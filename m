Return-Path: <stable+bounces-228383-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLmXI9dNwWmhSAQAu9opvQ
	(envelope-from <stable+bounces-228383-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1442F4881
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:27:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D20A316CB15
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773503B27C8;
	Mon, 23 Mar 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qiTuZBQW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2573AD537;
	Mon, 23 Mar 2026 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274966; cv=none; b=jCiXOPIpD1J4cIYQjS2d6fZd5KRpBtzQuUJFMkLaI3FDZpPRWjXVZrkyJyNmMNUgnBUgICnuNG/tzySBPT/U2nEpDwRFW7uc7kpuL+lAkqLZ2IkqVQtvNDygibRsXaHXgRMPDYYDSCjv1Wq+lx7N5AUb3DfH2omFCKkZzjJ59xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274966; c=relaxed/simple;
	bh=JFnrhPyw7VNZgiOXWtbH2+MKwfM07owT+bQWyISsQ4M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai/erI2F+D+SPr1ahSEJqtVHKI7QYgzh0fnvgp+sop8HtTgm5Ciuj/yxiSM7QF8rycSI0l0QDMBxmEGxn9RwnK7ig0njSf1vIaB8t9kAGujW3fDMWvORyVomAhwzZe4m6NNqIyZS9Qew4vW6eF4TxQIDaO4glOjxUPuBq8KHPR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qiTuZBQW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BBFC4CEF7;
	Mon, 23 Mar 2026 14:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274966;
	bh=JFnrhPyw7VNZgiOXWtbH2+MKwfM07owT+bQWyISsQ4M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiTuZBQWXVJC2YoX9oLEyv5RtKQVLr7ld+dwstkRB1ffVbwH6jzMliQi5XJ5v+5wG
	 GZ0vEKtp1ScrcIJfo/AYRMnkYfDuZxy3dMIlqvPxVlCLqTdEOKOUQ+HctVMJSvWCrU
	 635pJGgo2ELz2/cGvTkpSYn9+dyDqBHGMxP7eD2Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 133/212] mpls: add missing unregister_netdevice_notifier to mpls_init
Date: Mon, 23 Mar 2026 14:45:54 +0100
Message-ID: <20260323134507.976389860@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-228383-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: BB1442F4881
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 99600f79b28c83c68bae199a3d8e95049a758308 ]

If mpls_init() fails after registering mpls_dev_notifier, it never
gets removed. Add the missing unregister_netdevice_notifier() call to
the error handling path.

Fixes: 5be2062e3080 ("mpls: Handle error of rtnl_register_module().")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://patch.msgid.link/7c55363c4f743d19e2306204a134407c90a69bbb.1773228081.git.sd@queasysnail.net
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mpls/af_mpls.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 25c88cba5c48b..1c70cb26e7ba1 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -2777,6 +2777,7 @@ static int __init mpls_init(void)
 	rtnl_af_unregister(&mpls_af_ops);
 out_unregister_dev_type:
 	dev_remove_pack(&mpls_packet_type);
+	unregister_netdevice_notifier(&mpls_dev_notifier);
 out_unregister_pernet:
 	unregister_pernet_subsys(&mpls_net_ops);
 	goto out;
-- 
2.51.0




