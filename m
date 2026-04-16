Return-Path: <stable+bounces-238270-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFiTHgaa4GlMkAAAu9opvQ
	(envelope-from <stable+bounces-238270-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:12:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 770B740B5F0
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAC4230E53FB
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 08:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4974F33123B;
	Thu, 16 Apr 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="bv9p4fn+"
X-Original-To: stable@vger.kernel.org
Received: from n169-114.mail.139.com (n169-114.mail.139.com [120.232.169.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8F37C0FE
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 08:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327104; cv=none; b=bfFZgwCjz9C6RENfW+l2JrQVn/zGaqTu+rGu8UMXhuiUHS+Pce5pg/EO9YP7ZkgWZ5shpce4sl8lV3V81NXLiZ5/NTVTmQr6bPKx/zzFqVK6o4SzGNjQfEr+wouReYZ0s15P1ImU+VkRBDBkFCJBVLK4ug91jmRdYKhAdeYTsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327104; c=relaxed/simple;
	bh=WZmhw5N8YSGXHyPY3Dm8NsnFYZ8dOkTtiojdyrxWtJg=;
	h=From:To:Subject:Date:Message-Id; b=CZO/Ui/7Joy4GCwxPlFk0qymirumK93AA8hwNHlqTA0PvQeXPsJrGoIGW+rXRERi4OkAEhpqWK+3lESHZk5wF2zbp5azUhyimgnD1Mmn4h+EJRbFk3/Y5KMqI14t5+6ujDp8UJJJniufzFqWgRtwhw/ZJzT+Rf8iyto0JJiIj6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=bv9p4fn+; arc=none smtp.client-ip=120.232.169.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bv9p4fn+1wZHOAkIfbMJzerqDlqq7Wb+gizY9rc8agOr2p5+7d4YKnmrwPvPVvwNOlogiGOhNQ4at
	 aOXc0ubeswBnvGK0RK2iuZ01d+KHlWCrrFK2HxAaGE1ssQwaF6HWS0NjgaDdMBxEi8NRysSCBg+ZiM
	 jpoaGR28UL/+Sgyg=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[183.241.248.246])
	by rmsmtp-lg-appmail-44-12058 (RichMail) with SMTP id 2f1a69e099acddf-14161;
	Thu, 16 Apr 2026 16:11:26 +0800 (CST)
X-RM-TRANSID:2f1a69e099acddf-14161
From: Rajani Kantha <681739313@139.com>
To: kuba@kernel.org,
	joe@dama.to,
	stable@vger.kernel.org
Subject: [PATCH 6.6.y] nfc: nci: complete pending data exchange on device close
Date: Thu, 16 Apr 2026 16:11:19 +0800
Message-Id: <20260416081119.2197-1-681739313@139.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [1.04 / 15.00];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238270-lists,stable=lfdr.de];
	ASN_FAIL(0.00)[1.2.3.5.c.f.2.1.0.0.0.0.0.0.0.0.c.6.3.0.1.0.0.e.4.0.c.3.0.0.6.2.asn6.rspamd.com:server fail];
	DMARC_NA(0.00)[139.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[681739313@139.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	NEURAL_SPAM(0.00)[0.412];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,139.com:mid,139.com:email,dama.to:email]
X-Rspamd-Queue-Id: 770B740B5F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 66083581945bd5b8e99fe49b5aeb83d03f62d053 ]

In nci_close_device(), complete any pending data exchange before
closing. The data exchange callback (e.g.
rawsock_data_exchange_complete) holds a socket reference.

NIPA occasionally hits this leak:

unreferenced object 0xff1100000f435000 (size 2048):
  comm "nci_dev", pid 3954, jiffies 4295441245
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    27 00 01 40 00 00 00 00 00 00 00 00 00 00 00 00  '..@............
  backtrace (crc ec2b3c5):
    __kmalloc_noprof+0x4db/0x730
    sk_prot_alloc.isra.0+0xe4/0x1d0
    sk_alloc+0x36/0x760
    rawsock_create+0xd1/0x540
    nfc_sock_create+0x11f/0x280
    __sock_create+0x22d/0x630
    __sys_socket+0x115/0x1d0
    __x64_sys_socket+0x72/0xd0
    do_syscall_64+0x117/0xfc0
    entry_SYSCALL_64_after_hwframe+0x4b/0x53

Fixes: 38f04c6b1b68 ("NFC: protect nci_data_exchange transactions")
Reviewed-by: Joe Damato <joe@dama.to>
Link: https://patch.msgid.link/20260303162346.2071888-4-kuba@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Rajani Kantha <681739313@139.com>
---
 net/nfc/nci/core.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/nfc/nci/core.c b/net/nfc/nci/core.c
index e2ffdb06bf9a..fb81d9909500 100644
--- a/net/nfc/nci/core.c
+++ b/net/nfc/nci/core.c
@@ -567,6 +567,10 @@ static int nci_close_device(struct nci_dev *ndev)
 		flush_workqueue(ndev->cmd_wq);
 		del_timer_sync(&ndev->cmd_timer);
 		del_timer_sync(&ndev->data_timer);
+		if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+			nci_data_exchange_complete(ndev, NULL,
+						   ndev->cur_conn_id,
+						   -ENODEV);
 		mutex_unlock(&ndev->req_lock);
 		return 0;
 	}
@@ -597,6 +601,11 @@ static int nci_close_device(struct nci_dev *ndev)
 	flush_workqueue(ndev->cmd_wq);
 
 	del_timer_sync(&ndev->cmd_timer);
+	del_timer_sync(&ndev->data_timer);
+
+	if (test_bit(NCI_DATA_EXCHANGE, &ndev->flags))
+		nci_data_exchange_complete(ndev, NULL, ndev->cur_conn_id,
+					   -ENODEV);
 
 	/* Clear flags except NCI_UNREG */
 	ndev->flags &= BIT(NCI_UNREG);
-- 
2.17.1



