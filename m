Return-Path: <stable+bounces-258355-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGolDrMoG2ra/ggAu9opvQ
	(envelope-from <stable+bounces-258355-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A11526113F7
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 76C9930C012B
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A722FDC5E;
	Sat, 30 May 2026 18:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXuSV/70"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97623342CB3;
	Sat, 30 May 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780164074; cv=none; b=mlRP9Y2Tw+zWdgsqUhBq4CQeQcj5T5Bso/eh5CVffERp9eWqyo5F5yJoLHHyDIIcHuh0FQKsKyCBFfYJ6B9+gQFv6MB18zyQ/KqwXKFQ93pHTWrvZe8iGQFEb1zUdViP287apfEfWTo7+je00gl1R5YyOa8/yuO82uCjuMfmW78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780164074; c=relaxed/simple;
	bh=QDRQ0Vv1ts6I3PKSBf3tAk3BzFEL0SLjwCB6sdc5KHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sdxGPcfU7O+eP7v/VtTc2PIWRFYNvrXheZrLR2JbHXvSf0smDhrr8WExbyfT5ktKciafm5mHSdll5SdgmkU2XIPqqRqyfZcfoflHarmGxMI9VjA3jmC0Gz+zBS+o9wq4WvdDRcLyCf1hnfP7MoJEzO2G/Ysw5bA4eymRyK5RDts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXuSV/70; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2051F00893;
	Sat, 30 May 2026 18:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780164073;
	bh=ZHBjd7iW1DNGmsgUqYMutQKUZ2KD+0yYKCE5bPb+jbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KXuSV/70clpdmushSzh/CXZtNk6koysyCp7NUVpD+BNNCQynFFsw0xwAgT+UnKUfn
	 QYtdv7G5VRj9lSyofhEz7I0aylHtO2jAbGzKC+1TGhR9ODX0nUQBW8bR23UKjmEU2e
	 2f0obxJOHmsVBmv+eCMZPxLRJG6M0hhyG73EAleI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 429/776] net, bpf: fix null-ptr-deref in xdp_master_redirect() for down master
Date: Sat, 30 May 2026 18:02:23 +0200
Message-ID: <20260530160251.530984019@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160240.228940103@linuxfoundation.org>
References: <20260530160240.228940103@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-258355-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,80e046b8da2820b6ba73];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,appspotmail.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,iogearbox.net:email]
X-Rspamd-Queue-Id: A11526113F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiayuan Chen <jiayuan.chen@linux.dev>

[ Upstream commit 1921f91298d1388a0bb9db8f83800c998b649cb3 ]

syzkaller reported a kernel panic in bond_rr_gen_slave_id() reached via
xdp_master_redirect(). Full decoded trace:

  https://syzkaller.appspot.com/bug?extid=80e046b8da2820b6ba73

bond_rr_gen_slave_id() dereferences bond->rr_tx_counter, a per-CPU
counter that bonding only allocates in bond_open() when the mode is
round-robin. If the bond device was never brought up, rr_tx_counter
stays NULL.

The XDP redirect path can still reach that code on a bond that was
never opened: bpf_master_redirect_enabled_key is a global static key,
so as soon as any bond device has native XDP attached, the
XDP_TX -> xdp_master_redirect() interception is enabled for every
slave system-wide. The path xdp_master_redirect() ->
bond_xdp_get_xmit_slave() -> bond_xdp_xmit_roundrobin_slave_get() ->
bond_rr_gen_slave_id() then runs against a bond that has no
rr_tx_counter and crashes.

Fix this in the generic xdp_master_redirect() by refusing to call into
the master's ->ndo_xdp_get_xmit_slave() when the master device is not
up. IFF_UP is only set after ->ndo_open() has successfully returned,
so this reliably excludes masters whose XDP state has not been fully
initialized. Drop the frame with XDP_ABORTED so the exception is
visible via trace_xdp_exception() rather than silently falling through.
This is not specific to bonding: any current or future master that
defers XDP state allocation to ->ndo_open() is protected.

Fixes: 879af96ffd72 ("net, core: Add support for XDP redirection to slave device")
Reported-by: syzbot+80e046b8da2820b6ba73@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/698f84c6.a70a0220.2c38d7.00cc.GAE@google.com/T/
Suggested-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Link: https://patch.msgid.link/20260411005524.201200-2-jiayuan.chen@linux.dev
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/filter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 87aaab182e60d..87447a7843b5a 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -4031,6 +4031,8 @@ u32 xdp_master_redirect(struct xdp_buff *xdp)
 	struct bpf_redirect_info *ri = this_cpu_ptr(&bpf_redirect_info);
 
 	master = netdev_master_upper_dev_get_rcu(xdp->rxq->dev);
+	if (unlikely(!(master->flags & IFF_UP)))
+		return XDP_ABORTED;
 	slave = master->netdev_ops->ndo_xdp_get_xmit_slave(master, xdp);
 	if (slave && slave != xdp->rxq->dev) {
 		/* The target device is different from the receiving device, so
-- 
2.53.0




