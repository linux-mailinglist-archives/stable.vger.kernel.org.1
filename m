Return-Path: <stable+bounces-91425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B199BEDEC
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69EE4B24E13
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB541E22E6;
	Wed,  6 Nov 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pSFXHck2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE251E0480;
	Wed,  6 Nov 2024 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898698; cv=none; b=Vjo7mwM4Zz2Ya3KKT68Tw94WMAcj1jiUHsVJSJ4tb0wHb2ibjA1MtoZOBMKqSH4jCIJHmz1vqurG45CIGLS5YcU2WO+yb6ja7n66/XiiozwuGzfalgI0tThK9Bjyujxak50FxjGFwDJWdtVnu30BWu+b+BwWxvdgoSyajEw60yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898698; c=relaxed/simple;
	bh=QIaFUuLIct3gIw28oGaj04R0HxUfs81m55ERhTTMfwM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsN8DmKwXHNAW9SsgWNZZsclhTU/f4b8s6JLoeHuIus5M0nMhvwaGrk9u08+9KEB5Ksisqrw7H5A4fh4bfvAZ70wNJAN6JnCBHdxLUFxERMkpJKFjtR9G/jckqFmuVeu7EEOolnYkqM8+saixO3NhxB5kJt4p745ZKW50f/W254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pSFXHck2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26711C4CECD;
	Wed,  6 Nov 2024 13:11:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898698;
	bh=QIaFUuLIct3gIw28oGaj04R0HxUfs81m55ERhTTMfwM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pSFXHck2d1p0CTwCKMmsVzop35i9eo65lZmT49h5M5MBjQ7Z9z3mQ9B658YCdml2i
	 A3x5L74ZwG4HIDULQdXAw82N1+9LW7KTcY9vegou0j94ectDgOsV+cYqBCuikEGojs
	 PE7XhfnUDnncErQjDknTMg1Oh438oR30B+/HWxGw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neal Cardwell <ncardwell@google.com>,
	Yuchung Cheng <ycheng@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 325/462] tcp: fix tcp_enter_recovery() to zero retrans_stamp when its safe
Date: Wed,  6 Nov 2024 13:03:38 +0100
Message-ID: <20241106120339.556352347@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Neal Cardwell <ncardwell@google.com>

[ Upstream commit b41b4cbd9655bcebcce941bef3601db8110335be ]

Fix tcp_enter_recovery() so that if there are no retransmits out then
we zero retrans_stamp when entering fast recovery. This is necessary
to fix two buggy behaviors.

Currently a non-zero retrans_stamp value can persist across multiple
back-to-back loss recovery episodes. This is because we generally only
clears retrans_stamp if we are completely done with loss recoveries,
and get to tcp_try_to_open() and find !tcp_any_retrans_done(sk). This
behavior causes two bugs:

(1) When a loss recovery episode (CA_Loss or CA_Recovery) is followed
immediately by a new CA_Recovery, the retrans_stamp value can persist
and can be a time before this new CA_Recovery episode starts. That
means that timestamp-based undo will be using the wrong retrans_stamp
(a value that is too old) when comparing incoming TS ecr values to
retrans_stamp to see if the current fast recovery episode can be
undone.

(2) If there is a roughly minutes-long sequence of back-to-back fast
recovery episodes, one after another (e.g. in a shallow-buffered or
policed bottleneck), where each fast recovery successfully makes
forward progress and recovers one window of sequence space (but leaves
at least one retransmit in flight at the end of the recovery),
followed by several RTOs, then the ETIMEDOUT check may be using the
wrong retrans_stamp (a value set at the start of the first fast
recovery in the sequence). This can cause a very premature ETIMEDOUT,
killing the connection prematurely.

This commit changes the code to zero retrans_stamp when entering fast
recovery, when this is known to be safe (no retransmits are out in the
network). That ensures that when starting a fast recovery episode, and
it is safe to do so, retrans_stamp is set when we send the fast
retransmit packet. That addresses both bug (1) and bug (2) by ensuring
that (if no retransmits are out when we start a fast recovery) we use
the initial fast retransmit of this fast recovery as the time value
for undo and ETIMEDOUT calculations.

This makes intuitive sense, since the start of a new fast recovery
episode (in a scenario where no lost packets are out in the network)
means that the connection has made forward progress since the last RTO
or fast recovery, and we should thus "restart the clock" used for both
undo and ETIMEDOUT logic.

Note that if when we start fast recovery there *are* retransmits out
in the network, there can still be undesirable (1)/(2) issues. For
example, after this patch we can still have the (1) and (2) problems
in cases like this:

+ round 1: sender sends flight 1

+ round 2: sender receives SACKs and enters fast recovery 1,
  retransmits some packets in flight 1 and then sends some new data as
  flight 2

+ round 3: sender receives some SACKs for flight 2, notes losses, and
  retransmits some packets to fill the holes in flight 2

+ fast recovery has some lost retransmits in flight 1 and continues
  for one or more rounds sending retransmits for flight 1 and flight 2

+ fast recovery 1 completes when snd_una reaches high_seq at end of
  flight 1

+ there are still holes in the SACK scoreboard in flight 2, so we
  enter fast recovery 2, but some retransmits in the flight 2 sequence
  range are still in flight (retrans_out > 0), so we can't execute the
  new retrans_stamp=0 added here to clear retrans_stamp

It's not yet clear how to fix these remaining (1)/(2) issues in an
efficient way without breaking undo behavior, given that retrans_stamp
is currently used for undo and ETIMEDOUT. Perhaps the optimal (but
expensive) strategy would be to set retrans_stamp to the timestamp of
the earliest outstanding retransmit when entering fast recovery. But
at least this commit makes things better.

Note that this does not change the semantics of retrans_stamp; it
simply makes retrans_stamp accurate in some cases where it was not
before:

(1) Some loss recovery, followed by an immediate entry into a fast
recovery, where there are no retransmits out when entering the fast
recovery.

(2) When a TFO server has a SYNACK retransmit that sets retrans_stamp,
and then the ACK that completes the 3-way handshake has SACK blocks
that trigger a fast recovery. In this case when entering fast recovery
we want to zero out the retrans_stamp from the TFO SYNACK retransmit,
and set the retrans_stamp based on the timestamp of the fast recovery.

We introduce a tcp_retrans_stamp_cleanup() helper, because this
two-line sequence already appears in 3 places and is about to appear
in 2 more as a result of this bug fix patch series. Once this bug fix
patches series in the net branch makes it into the net-next branch
we'll update the 3 other call sites to use the new helper.

This is a long-standing issue. The Fixes tag below is chosen to be the
oldest commit at which the patch will apply cleanly, which is from
Linux v3.5 in 2012.

Fixes: 1fbc340514fc ("tcp: early retransmit: tcp_enter_recovery()")
Signed-off-by: Neal Cardwell <ncardwell@google.com>
Signed-off-by: Yuchung Cheng <ycheng@google.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/20241001200517.2756803-3-ncardwell.sw@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 75e954590bdd5..5923261312912 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -2343,6 +2343,16 @@ static bool tcp_any_retrans_done(const struct sock *sk)
 	return false;
 }
 
+/* If loss recovery is finished and there are no retransmits out in the
+ * network, then we clear retrans_stamp so that upon the next loss recovery
+ * retransmits_timed_out() and timestamp-undo are using the correct value.
+ */
+static void tcp_retrans_stamp_cleanup(struct sock *sk)
+{
+	if (!tcp_any_retrans_done(sk))
+		tcp_sk(sk)->retrans_stamp = 0;
+}
+
 static void DBGUNDO(struct sock *sk, const char *msg)
 {
 #if FASTRETRANS_DEBUG > 1
@@ -2685,6 +2695,9 @@ void tcp_enter_recovery(struct sock *sk, bool ece_ack)
 	struct tcp_sock *tp = tcp_sk(sk);
 	int mib_idx;
 
+	/* Start the clock with our fast retransmit, for undo and ETIMEDOUT. */
+	tcp_retrans_stamp_cleanup(sk);
+
 	if (tcp_is_reno(tp))
 		mib_idx = LINUX_MIB_TCPRENORECOVERY;
 	else
-- 
2.43.0




