Return-Path: <stable+bounces-252650-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EuUHdX8DWok5QUAu9opvQ
	(envelope-from <stable+bounces-252650-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1791E59625C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9017B3078731
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3969C3A6B99;
	Wed, 20 May 2026 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GPbq05XA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5388348C55;
	Wed, 20 May 2026 18:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301232; cv=none; b=prWNM4TOgEiPNSjWmasdkGoD5IUy0yBthZn4tUbInVhksAK5Cf6f11TZUa5ZTvtAsJbrW12MfSMHfwPG+EEYPZwL4hdYjNXH8+dhNKfCgqxuQ5IWiCkPNk2vI0ThUFhafthRAGEWOtpAmULI/X1E96idfHdbRTYBYTuZ+BPEwDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301232; c=relaxed/simple;
	bh=A3y0GAUu60Vzu97NP+cCxbH+dljV/M+DdEBgEwGiYKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mIJJMfpXBFjaV2t6h6MGz6d3VEHk5ko7uaPefHzbaJBDCB/49bZhfZtkLVU9NVaVZyOKJRZpgzhWro3MRh+UekNQXtQy0wEJ+Z+osbrRIWB5jrCInn84zng2gsJlxxFsnRE8qrZ5zyUsUt6cvm6/j5O58yt35pT5kLTXfgVMeqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GPbq05XA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FE61F000E9;
	Wed, 20 May 2026 18:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301230;
	bh=zCmJHLpFIgwhqJQFCZBjkSc103EWXeUeLN+JPFRyV18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GPbq05XAFT/h2QHLZhEiIDCLGAylwDc0ECOiiNGvGJxjwX/e0Q1THx6XUiWXXQjAs
	 EW2AOPHN73lrKOnvX6ccob2ZDc0TlKigvmf2zPyT7Z1Q0JIAbc7rJagLrSOjfiHsr5
	 JQMQm1GeQkHjep83jFGUKGuBcRiAe6KSyUDGnUsQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 474/666] slip: reject VJ receive packets on instances with no rstate array
Date: Wed, 20 May 2026 18:21:25 +0200
Message-ID: <20260520162121.543075607@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,asu.edu,gmail.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-252650-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,asu.edu:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1791E59625C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Weiming Shi <bestswngs@gmail.com>

[ Upstream commit e76607442d5b73e1ba6768f501ef815bb58c2c0e ]

slhc_init() accepts rslots == 0 as a valid configuration, with the
documented meaning of 'no receive compression'. In that case the
allocation loop in slhc_init() is skipped, so comp->rstate stays
NULL and comp->rslot_limit stays 0 (from the kzalloc of struct
slcompress).

The receive helpers do not defend against that configuration.
slhc_uncompress() dereferences comp->rstate[x] when the VJ header
carries an explicit connection ID, and slhc_remember() later assigns
cs = &comp->rstate[...] after only comparing the packet's slot number
to comp->rslot_limit. Because rslot_limit is 0, slot 0 passes the
range check, and the code dereferences a NULL rstate.

The configuration is reachable in-tree through PPP. PPPIOCSMAXCID
stores its argument in a signed int, and (val >> 16) uses arithmetic
shift. Passing 0xffff0000 therefore sign-extends to -1, so val2 + 1
is 0 and ppp_generic.c ends up calling slhc_init(0, 1). Because
/dev/ppp open is gated by ns_capable(CAP_NET_ADMIN), the whole path
is reachable from an unprivileged user namespace. Once the malformed
VJ state is installed, any inbound VJ-compressed or VJ-uncompressed
frame that selects slot 0 crashes the kernel in softirq context:

 Oops: general protection fault, probably for non-canonical
       address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
 RIP: 0010:slhc_uncompress (drivers/net/slip/slhc.c:519)
 Call Trace:
  <TASK>
  ppp_receive_nonmp_frame (drivers/net/ppp/ppp_generic.c:2466)
  ppp_input (drivers/net/ppp/ppp_generic.c:2359)
  ppp_async_process (drivers/net/ppp/ppp_async.c:492)
  tasklet_action_common (kernel/softirq.c:926)
  handle_softirqs (kernel/softirq.c:623)
  run_ksoftirqd (kernel/softirq.c:1055)
  smpboot_thread_fn (kernel/smpboot.c:160)
  kthread (kernel/kthread.c:436)
  ret_from_fork (arch/x86/kernel/process.c:164)
  </TASK>

Reject the receive side on such instances instead of touching rstate.
slhc_uncompress() falls through to its existing 'bad' label, which
bumps sls_i_error and enters the toss state. slhc_remember() mirrors
that with an explicit sls_i_error increment followed by slhc_toss();
the sls_i_runt counter is not used here because a missing rstate is
an internal configuration state, not a runt packet.

The transmit path is unaffected: the only in-tree caller that picks
rslots from userspace (ppp_generic.c) still supplies tslots >= 1, and
slip.c always calls slhc_init(16, 16), so comp->tstate remains valid
and slhc_compress() continues to work.

Fixes: 4ab42d78e37a ("ppp, slip: Validate VJ compression slot parameters completely")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260415204130.258866-2-bestswngs@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/slip/slhc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/slip/slhc.c b/drivers/net/slip/slhc.c
index ee9fd3a94b96f..fcb3eebe7311c 100644
--- a/drivers/net/slip/slhc.c
+++ b/drivers/net/slip/slhc.c
@@ -506,6 +506,8 @@ slhc_uncompress(struct slcompress *comp, unsigned char *icp, int isize)
 		comp->sls_i_error++;
 		return 0;
 	}
+	if (!comp->rstate)
+		goto bad;
 	changes = *cp++;
 	if(changes & NEW_C){
 		/* Make sure the state index is in range, then grab the state.
@@ -649,6 +651,10 @@ slhc_remember(struct slcompress *comp, unsigned char *icp, int isize)
 	struct cstate *cs;
 	unsigned int ihl;
 
+	if (!comp->rstate) {
+		comp->sls_i_error++;
+		return slhc_toss(comp);
+	}
 	/* The packet is shorter than a legal IP header.
 	 * Also make sure isize is positive.
 	 */
-- 
2.53.0




