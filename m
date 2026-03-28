Return-Path: <stable+bounces-230760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PZyEd5Rx2nCVQUAu9opvQ
	(envelope-from <stable+bounces-230760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 04:58:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 373CC34D34E
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 04:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0ADB13024ED5
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 03:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0191831715C;
	Sat, 28 Mar 2026 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M/4rJ1OW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89613175A94
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 03:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774670296; cv=none; b=TxBbRssbkUTeCfe3xSuT4EasyhxcYMe9Go2VxTx62ayGBEe+bAvMfQwBe7hpYpF0pMnxOEwfWRUWX7bITRrrWW2XEIeoD8fSl5aCx8Zv6Sm374/4JVDTjgLP1T8tCkLKioA0pFURPhVHFSJnoBxBHlXTKaf8Crz92BMLwne+dnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774670296; c=relaxed/simple;
	bh=mSy4RoaBT39xTSvc+8yUlqjxtU8HoyAOY5FwrcPr75Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mr30hl+yJAWlw6cwTAMLuz8lDQWS/cFiP88691yHIG+bh1/Zr79VZRogvavXBE56oAK8hk11fCDi+T3pbQjpgAfWCXMXOicxChT34llqFqyE9x0P4sBnI9sHQYVNYZn2c0SgddP51iqabDDHaJh0tA/n0nuirs3js+kgdsmkIEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M/4rJ1OW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cfc1aced74so474152985a.2
        for <stable@vger.kernel.org>; Fri, 27 Mar 2026 20:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774670294; x=1775275094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DBblOHPwIcVybXPXeTa1HXY+6r7rBi60EfIfdS+sSzY=;
        b=M/4rJ1OWtFZPA0PHYOeZiFQEguoQP8Koy1ONfG2NZoucbMz/f1gKdoHHd61CnCWPr8
         bKjlFJKRDeLPtcrO1PKGZfalNBvIbFeJS1/i1ukZ561+PJkAC5g2cAJdC0HmM65ii9/m
         SaJqPRItB+4pEluHjfJQVyNUBElEuWolCVUk3YHTS/EGQtaem+wKYOVGEmenfWyZWaTW
         gPvgEQIACmVhCydY09KqqngptN06JVqi08bBvw+abSbgsZjBA6MUG60gxjvA4d4S05z6
         a6ocedyz4SA8DVmHy7MZV0y9mtHls2sTxBz+RthOoQSZ6Y+mCzC0vGcRueS9ScjUPnHj
         9mhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774670294; x=1775275094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBblOHPwIcVybXPXeTa1HXY+6r7rBi60EfIfdS+sSzY=;
        b=oQuO8AQZ5vIhNCgG+2Ph/VNKSBdkYxa+0mqI3u+b/NDqN2LRdW2wNVm1VbyNMBtTpX
         8UzRW6v17F0PiXeQ2VBYqV1hDTULL3C06oWYkKfdMB4TDDfclG46Y4IXUA0y1Y6trgWZ
         2014lKpxa3hrNV/BnC3nrEcgA7pQY+hqI5BDH/J7ZeB38SsWNkIH7tZFv9SnPc3ZFzUH
         /JjPEkKdrLlH9liDvL3YEM1SZkODLdxEx6qbpky5s3F/nz/miMNc/jqmz+QRdpxIDGf6
         stF2aUdWcl3h9NNEcyJGylKgUr2q5cQXEnJII5xGuTRA4zuqzmtCpjT0que610X3rImQ
         yOlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCjRko0UHNaFO3e5412LagoOMbps+btIISkgnvC0KRIQKZC+MasSSTdBih6rgf8CBGsoHjUuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsefDVX5ex9wvTIbik5ElCk359NYGdu1r22s6pzZAhP5DIFHmP
	55wRDzNjoiaffp3wnWgrT3/xCVayHe08ogAfL5Cw7TuSoPOUdoLMIn7V
X-Gm-Gg: ATEYQzyyjNayJIj1VO3Wi8Q0EUUIzE4sgEFVi2qbxbWbIuffV022U+xdDzxs5VtCHSb
	uxTXTShUp1nnuyBApozHoS1oY74Fol166we0O8ID3g4sDW7T07iB2SadA1PrJo6CQp9JAF0LXK6
	sMyh5vU/anKO3yp0VNNAfyrmwC1uiSxdkxdJaIk0+Bdf6EEIOzrC7q8luM1+saQlz7tGOmgHgkA
	GTN9l5gy3ct25FZkoZ09Kj9AXctlDkJyp0X/Nc5Qtuzf3t4p9JMIRdbiee26jg+6N/WREtpND4L
	+lejIiUEQVd3kdj/eaIBBGxYhoD8EkeMlne7wkJQj+zx5Yi9dy9syiiKWUPbNMdPIw5y1YnvvFJ
	9LI4O9RJQcF6htC+7QYCidnzLZ4ykpK2AoXZh8zpUfT9PtnmwrLG0lXxjPfNZK9aLpLOZCt50mv
	5KOgxJD7o4NKWLMVErL2nJ22uLDyYY/9SWFWABXLa3UvnrXw8aEJqr2fgXhbWbvwcyri6EBP7na
	24MqHRUT6dyQTbpls/OaQ==
X-Received: by 2002:a05:620a:4625:b0:8cf:bbf0:ff52 with SMTP id af79cd13be357-8d01c7d86eemr698785385a.63.1774670294490;
        Fri, 27 Mar 2026 20:58:14 -0700 (PDT)
Received: from mango-teamkim.. ([129.170.197.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d028044bdcsm84452585a.28.2026.03.27.20.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 20:58:14 -0700 (PDT)
From: Nathan Rebello <nathan.c.rebello@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	stable@vger.kernel.org,
	kyungtae.kim@dartmouth.edu,
	Nathan Rebello <nathan.c.rebello@gmail.com>
Subject: [PATCH] Bluetooth: ISO: fix NULL deref in iso_recv() ISO_END handling
Date: Fri, 27 Mar 2026 23:58:13 -0400
Message-ID: <20260328035813.296410-1-nathan.c.rebello@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-230760-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org,dartmouth.edu];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathancrebello@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 373CC34D34E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The ISO_CONT case in iso_recv() properly checks for unexpected
continuation frames (!conn->rx_len) and oversized fragments
(skb->len > conn->rx_len) before accessing conn->rx_skb. The
ISO_END case lacks both checks.

When an ISO_END packet arrives without a preceding ISO_START:
  - conn->rx_skb is NULL (never allocated)
  - skb_put(conn->rx_skb, ...) dereferences NULL -> kernel crash

When an ISO_END fragment is larger than the remaining expected
length:
  - skb_put() extends past conn->rx_skb->end
  - triggers skb_over_panic -> kernel BUG

KASAN confirmed the NULL-deref on kernel 7.0.0-rc5 via VHCI:

  general protection fault, probably for non-canonical address 0xdffffc0000000018
  KASAN: null-ptr-deref in range [0x00000000000000c0-0x00000000000000c7]
  CPU: 0 UID: 0 PID: 72 Comm: kworker/u9:0 Not tainted 7.0.0-rc5
  Workqueue: hci0 hci_rx_work
  RIP: 0010:skb_put+0x27/0x1a0
  Call Trace:
   <TASK>
   iso_recv+0x5e0/0xee0
   hci_rx_work+0x226/0x730
   process_one_work+0x633/0x1060
   worker_thread+0x45b/0xd10
   kthread+0x2c6/0x3b0
   ret_from_fork+0x38d/0x5c0
   </TASK>
  Kernel panic - not syncing: Fatal exception

Fix by adding the same validation that ISO_CONT already has:
reject unexpected end frames and oversized fragments.

Fixes: ccf74f2390d6 ("Bluetooth: Add ISO Socket")
Cc: stable@vger.kernel.org
Signed-off-by: Nathan Rebello <nathan.c.rebello@gmail.com>
---
 net/bluetooth/iso.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index be145e273..97b5fc9da 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -2587,6 +2587,20 @@ int iso_recv(struct hci_dev *hdev, u16 handle, struct sk_buff *skb, u16 flags)
 		break;
 
 	case ISO_END:
+		if (!conn->rx_len) {
+			BT_ERR("Unexpected end frame (len %d)", skb->len);
+			goto drop;
+		}
+
+		if (skb->len > conn->rx_len) {
+			BT_ERR("End fragment is too long (len %d, expected %d)",
+			       skb->len, conn->rx_len);
+			kfree_skb(conn->rx_skb);
+			conn->rx_skb = NULL;
+			conn->rx_len = 0;
+			goto drop;
+		}
+
 		skb_copy_from_linear_data(skb, skb_put(conn->rx_skb, skb->len),
 					  skb->len);
 		conn->rx_len -= skb->len;
-- 
2.43.0


