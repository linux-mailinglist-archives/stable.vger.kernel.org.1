Return-Path: <stable+bounces-241845-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNHSFsbD8WkbkQEAu9opvQ
	(envelope-from <stable+bounces-241845-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:39:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E81C49145A
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 10:39:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A036302AF18
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 08:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF26E3B0AF1;
	Wed, 29 Apr 2026 08:39:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C369B37A494;
	Wed, 29 Apr 2026 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777451958; cv=none; b=qxjO7wARp7CHVCXNhraea6AGA+z1QYMN6F5YJlNPwEJb2XTKGSfeDvdk+PPFMQYlp9KY344kCzlCqhhmIZUcx169wmtd9BHt20LLtpJGaWOIIlTYfx6clznkwzBca5zqYm8kBnzOGfSa4EKC+xpfYZYWnEHaGCHcst0isii2uQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777451958; c=relaxed/simple;
	bh=psz74xlyo+Q/D2GKhu7Hni7zJsLkYJergDSVpn6RWXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ax2a/XBQ6K8Kc/MqkPXm2QkrC7aqdaAVhGrctVMk73RUO4rLcEyo0D8gltoOG8CvreiW61IpGD3UgjQ3CqgsakaQYaQOQBTSm39i0S05BoKnpZ2rfFfgqx/eNRjBZi/Zjgj5XxesAbjnUlIS8TZFiCe4qQf8ga78dGlulfYXdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpgz13t1777451890te988ade6
X-QQ-Originating-IP: cuFgxeLDLHQr17MDl9BvVrK4VlEB+G9bs4t8/BsiYyM=
Received: from w-MS-7E16.trustnetic.com ( [36.24.191.108])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Apr 2026 16:38:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17928567013619831319
EX-QQ-RecipientCnt: 11
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	stable@vger.kernel.org
Subject: [PATCH net 2/2] net: libwx: use request_irq for VF misc interrupt
Date: Wed, 29 Apr 2026 16:37:43 +0800
Message-ID: <786DDC7D5CCA6D0A+20260429083743.88961-2-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260429083743.88961-1-jiawenwu@trustnetic.com>
References: <20260429083743.88961-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NSXtYWcyD5KOs8APlK1IfwaTYPxQAyl3qy1odxVGBrH8hcH47PUFnWZf
	eFGusaYvM1aJMS7c9ZWQUUhZ0Rl9IdBA1X6vj5bYb7iXtBBGWh5GHqZ8otYetl8R+F/pneJ
	LRuaN8el9FvACRCJG+dsOgXRMByOeYPigY2f32D8EARbqshKg9Ezpk3o4IOy4MSMkzeI6gR
	fdoMusgZPqOIOIgIJsOA223NsT0OWqdc7kF02Bn1kwcVCoOc+NPg+RdaDvARkDKk7zV+3gS
	Vm1gvks+eFGiXxmuViLC6C2vARCu9XjEwQsa2/HAgkvi+Nuq3YBW4TnKUhosKW/BJg0Gceq
	vbHoiyPpzbpGLqFBF/sx9QtpUbMNIlFvoIyQoXbNEwLzgL3mqZ3ziRrquQGJ7HmzNXolkfl
	tod0VDl0GG48qGcHdzYJJG54/Y5/kUC7BO2gPfRKIj93dWStcfUxWlINKIE+YI6zJKdeZZZ
	8t8KGEBImsIWyxGSkw5LafhF9/cr7TdN7Oou/NwSAIC7edVam3N5UkmV41CEHxPrfUKU0rZ
	eJUVlyK8y0i36giyDKPCFllrjnKofdP6G3EIjSSwO13kUTnqmwDU/0S7jBi/zkDpUE3DG0C
	kWyCsz4CcPdHWm52tubM1t1+mrxQaxyxVeXplCAblFCrYGVAhnp9uaYleTbyKv9/+ZDK5zy
	/2UQ5EfuVrbCaVuPDpxUX2oLa9ToXlXIsRrkYGQKxXEHaYznxEK9XWXE4kiSPDG5ZyP0de+
	ftSoQ/IekKu6w9LmjW3mjl9JMB0nlOwgu9jBMAbTd7qHyWCFHCoV7xmsDj/1WtCJWbobcMK
	mVQoA558xmQ4riX6kbUFHfdxYXt2z3ipLqL5Xd70zG5Fb9PHGlE1XrJBebagr4i765ppKyZ
	YLbvjZASdigli4VsfEJARpOPu1c1IcGMZvMiJwOP2rwOxjcSDtRn0A3xBipL1tapQxlczaD
	iVSBNMuEj27r4RM5SdDA6Ihp5yuZp/thWuaQZF05mjhjYG1Njx0r0ZHAmmpz56NHQpyCoFI
	Y+5su6SF0p+PYTLo+fIGm3z5LlwCuazOSAC/PmsY0NzSXKwc6sJboxxI8du8TQM1LUd3Iis
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0
X-Rspamd-Queue-Id: 0E81C49145A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241845-lists,stable=lfdr.de];
	DMARC_NA(0.00)[trustnetic.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiawenwu@trustnetic.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_SPAM(0.00)[0.611];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Currently, request_threaded_irq() is used with a primary handler but a
NULL threaded handler, while also setting the IRQF_ONESHOT flag. This
specific combination triggers a WARNING since the commit aef30c8d569c
("genirq: Warn about using IRQF_ONESHOT without a threaded handler").

WARNING: kernel/irq/manage.c:1502 at __setup_irq+0x4fa/0x760

Fix the issue by switching to request_irq(), which is the appropriate
interface or a non-threaded interrupt handler, and removing the
unnecessary IRQF_ONESHOT flag.

Fixes: eb4898fde1de ("net: libwx: add wangxun vf common api")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 29cdbed2e5ec..94ff8f5f0b4c 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -99,8 +99,8 @@ int wx_request_msix_irqs_vf(struct wx *wx)
 		}
 	}
 
-	err = request_threaded_irq(wx->msix_entry->vector, wx_msix_misc_vf,
-				   NULL, IRQF_ONESHOT, netdev->name, wx);
+	err = request_irq(wx->msix_entry->vector, wx_msix_misc_vf,
+			  0, netdev->name, wx);
 	if (err) {
 		wx_err(wx, "request_irq for msix_other failed: %d\n", err);
 		goto free_queue_irqs;
-- 
2.51.0


