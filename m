Return-Path: <stable+bounces-242942-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IxXORde+GlJtgIAu9opvQ
	(envelope-from <stable+bounces-242942-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:51:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 881C54BA909
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 10:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C2A0F300B9FF
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 08:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA334C989;
	Mon,  4 May 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I3lJa48i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930C1342144
	for <stable@vger.kernel.org>; Mon,  4 May 2026 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777884630; cv=none; b=estZO04sJCGu9njLTVfyYA6PZGs/7jn4D2K3KvM8fAwD3SKxz19ne8rNCVwGvp7aEZGl0QGleljypQUBWqYdCeWAbdFiJOXG3XXlVIypx3HfefTgjdGQ9EDoqRVfwbumQGVO+XOm8wpcqR0P0U4H4gOS56GMwZmNG8REdnmkJOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777884630; c=relaxed/simple;
	bh=jQAQ7mZCmvBCmrCuWBLpKmYPOmd3vVD1XoKZ1rdocI0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W1FzVZYOjC6ozCxcsbk8kahhAGWUXz7dze7XbDMd1vSO9is0wfyW1IwW++gc6BRtu4iy/w4cXgTF1MUhMSvcytmTpiFS7DHShEAo0nJmrc/zH4giMEQz9B1UzzRXc9JVxukoM/zXaBuA8kqQkBIQUdoK8houqsM3RrKpq6xpJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I3lJa48i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29759C2BCF5;
	Mon,  4 May 2026 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777884630;
	bh=jQAQ7mZCmvBCmrCuWBLpKmYPOmd3vVD1XoKZ1rdocI0=;
	h=Subject:To:Cc:From:Date:From;
	b=I3lJa48ihwTycHprKdiiwTFgpnTpnRk9/mCnh+8XmV3lZ5dPXMMz9A+BRLfFZeJ6D
	 FOTQLx228yw7Wmste35EIIl30FH7qU6palHHF6+JcAatmKgja5aDKFsjHPJnPw9KBo
	 kwHF84AUl6/m+LyFckwBOyePiPN8DfVmqhmz9w0Y=
Subject: FAILED: patch "[PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()" failed to apply to 6.12-stable tree
To: devnexen@gmail.com,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 04 May 2026 10:50:28 +0200
Message-ID: <2026050428-flaky-polish-d0e3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 881C54BA909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242942-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,msgid.link:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gregkh:email]


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 5638504a2aa9e1b9d72af9060df1a160cce2d379
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026050428-flaky-polish-d0e3@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5638504a2aa9e1b9d72af9060df1a160cce2d379 Mon Sep 17 00:00:00 2001
From: David Carlier <devnexen@gmail.com>
Date: Fri, 17 Apr 2026 06:54:08 +0100
Subject: [PATCH] gtp: disable BH before calling udp_tunnel_xmit_skb()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

gtp_genl_send_echo_req() runs as a generic netlink doit handler in
process context with BH not disabled. It calls udp_tunnel_xmit_skb(),
which eventually invokes iptunnel_xmit() — that uses __this_cpu_inc/dec
on softnet_data.xmit.recursion to track the tunnel xmit recursion level.

Without local_bh_disable(), the task may migrate between
dev_xmit_recursion_inc() and dev_xmit_recursion_dec(), breaking the
per-CPU counter pairing. The result is stale or negative recursion
levels that can later produce false-positive
SKB_DROP_REASON_RECURSION_LIMIT drops on either CPU.

The other udp_tunnel_xmit_skb() call sites in gtp.c are unaffected:
the data path runs under ndo_start_xmit and the echo response handlers
run from the UDP encap rx softirq, both with BH already disabled.

Fix it by disabling BH around the udp_tunnel_xmit_skb() call, mirroring
commit 2cd7e6971fc2 ("sctp: disable BH before calling
udp_tunnel_xmit_skb()").

Fixes: 6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit functions")
Cc: stable@vger.kernel.org
Signed-off-by: David Carlier <devnexen@gmail.com>
Link: https://patch.msgid.link/20260417055408.4667-1-devnexen@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 70b9e58b9b78..5150f2e4f66b 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -2400,6 +2400,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 		return -ENODEV;
 	}
 
+	local_bh_disable();
 	udp_tunnel_xmit_skb(rt, sk, skb_to_send,
 			    fl4.saddr, fl4.daddr,
 			    inet_dscp_to_dsfield(fl4.flowi4_dscp),
@@ -2409,6 +2410,7 @@ static int gtp_genl_send_echo_req(struct sk_buff *skb, struct genl_info *info)
 			    !net_eq(sock_net(sk),
 				    dev_net(gtp->dev)),
 			    false, 0);
+	local_bh_enable();
 	return 0;
 }
 


