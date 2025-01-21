Return-Path: <stable+bounces-109896-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6D2BA1845A
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11103A11A8
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4C81F472D;
	Tue, 21 Jan 2025 18:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n1aScLqk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0278D1F5404;
	Tue, 21 Jan 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482757; cv=none; b=dVeEEQyPt7J73mLoEUeQgIGT2cVuJbfK3eueQIpMqUCpOGrUCZ6+Xzgyaqat7qtsxklFxhjwPRHrmGZoabrVdmX0fmvpPTVtMXxiR67b82AF1P672o3rvBpsqVZOJAY6JFbUaFG+8RopT58kfaat/GlGISPWo8Ezdby0nzy3OAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482757; c=relaxed/simple;
	bh=r14NQxiuUUhZ5ZfxnhogxfherFit/EpHm82UeZ7RaRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VvFNxD31xFC+9LBiBEBjiLnf2NshEc6MqqzeLpzjd+iNJiFFEziGInjnTUFRC53zaKjWjGcM/d69RhpcvARVI/p5T4H50tVsWObLRNkyM9Th/CuFGHt/Pg5U0zVaasmVN4mIFbYmn07DuGHcOMumUd2ElR/8EV6MzaIiwz+uw8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n1aScLqk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B619C4CEDF;
	Tue, 21 Jan 2025 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482756;
	bh=r14NQxiuUUhZ5ZfxnhogxfherFit/EpHm82UeZ7RaRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n1aScLqk9TL00ef+juLtCtzp4dgnhjt/D+3Oie9WtmabcIKjwcs2ziiMT+FK5JxNT
	 1jKCeropzmdxGQBNmBear/eWyJfLMwSgHnG2/c5jyR8YMavpwD7fMntzgpXIWN0SUP
	 8LQLsR9DoQuVlQ+YnX1V5DE6cFnBlV+rAh2eTKVQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Subject: [PATCH 6.1 32/64] mptcp: be sure to send ack when mptcp-level window re-opens
Date: Tue, 21 Jan 2025 18:52:31 +0100
Message-ID: <20250121174522.780248651@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174521.568417761@linuxfoundation.org>
References: <20250121174521.568417761@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

commit 2ca06a2f65310aeef30bb69b7405437a14766e4d upstream.

mptcp_cleanup_rbuf() is responsible to send acks when the user-space
reads enough data to update the receive windows significantly.

It tries hard to avoid acquiring the subflow sockets locks by checking
conditions similar to the ones implemented at the TCP level.

To avoid too much code duplication - the MPTCP protocol can't reuse the
TCP helpers as part of the relevant status is maintained into the msk
socket - and multiple costly window size computation, mptcp_cleanup_rbuf
uses a rough estimate for the most recently advertised window size:
the MPTCP receive free space, as recorded as at last-ack time.

Unfortunately the above does not allow mptcp_cleanup_rbuf() to detect
a zero to non-zero win change in some corner cases, skipping the
tcp_cleanup_rbuf call and leaving the peer stuck.

After commit ea66758c1795 ("tcp: allow MPTCP to update the announced
window"), MPTCP has actually cheap access to the announced window value.
Use it in mptcp_cleanup_rbuf() for a more accurate ack generation.

Fixes: e3859603ba13 ("mptcp: better msk receive window updates")
Cc: stable@vger.kernel.org
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/20250107131845.5e5de3c5@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20250113-net-mptcp-connect-st-flakes-v1-1-0d986ee7b1b6@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/options.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -605,7 +605,6 @@ static bool mptcp_established_options_ds
 	}
 	opts->ext_copy.use_ack = 1;
 	opts->suboptions = OPTION_MPTCP_DSS;
-	WRITE_ONCE(msk->old_wspace, __mptcp_space((struct sock *)msk));
 
 	/* Add kind/length/subtype/flag overhead if mapping is not populated */
 	if (dss_size == 0)
@@ -1265,7 +1264,7 @@ static void mptcp_set_rwin(struct tcp_so
 			}
 			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDCONFLICT);
 		}
-		return;
+		goto update_wspace;
 	}
 
 	if (rcv_wnd_new != rcv_wnd_old) {
@@ -1290,6 +1289,9 @@ raise_win:
 		th->window = htons(new_win);
 		MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_RCVWNDSHARED);
 	}
+
+update_wspace:
+	WRITE_ONCE(msk->old_wspace, tp->rcv_wnd);
 }
 
 __sum16 __mptcp_make_csum(u64 data_seq, u32 subflow_seq, u16 data_len, __wsum sum)



