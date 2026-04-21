Return-Path: <stable+bounces-240127-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMaDJf5V52nz6gEAu9opvQ
	(envelope-from <stable+bounces-240127-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:48:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBF4439BB4
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47E153011C9E
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D435AC18;
	Tue, 21 Apr 2026 10:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jGuhvpOZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0083ACEE9
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768508; cv=none; b=QzT6T5FQC+8YWHuClsjld0Cu7kQVSIDFKPOHVQEHoG0X7/L2z04xyy/haZWGnzJ+qUUg5vrlhczNFTde9KdV4QPflr6iP48HIEs4jZMUla9TUejKZvegnP7ZkmdAs8Dy3a+tKOiuwjwZnZKLrRdxbFwyq3eV7RMCxEFbkSrTCPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768508; c=relaxed/simple;
	bh=FgFyEEu7SzAMRI//XWO7zdbV++r3zoDQ/MgG+dqm/7c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=poTG2eWHJXaAfjQwasw1x1H73ZNfbdxUYOEPdpHu2V+5MV/sbgCh8m93ACN2QuyAwIMmSthntJMGTDvDJAKB0UimD2nJLGQM7TNtulrcjUgvVcSKUOejJMa0W5nRJr1LaS9g97QjSMlsF9zmPB4UBZrUYLdUpGPArlltQ8HX/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jGuhvpOZ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so4587705e9.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 03:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768504; x=1777373304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f+ooAKgHIuKcQdMInfKY/BCUWonIks5RSqvPScUktgk=;
        b=jGuhvpOZ1+sHmiFZmO7UMXLvK1JqUfIrTPAIuSO4Jtb3DN1AFV1n6ge4Pyh1QZ6KlI
         OwuJD7v40siKsyMtDDkgCYJIa7QixBUx1Mf8VY8hG8ldN2ao9AbelSfEJa492ZptAYnQ
         zz37EFRrfgyTgLlJHGHVh9+6yzzYdtAROB38jLXie6ngehlXZ7OpFF88hWxGvZXT+uXg
         2SUu4yYlQflRZa3zlIHwfVC3irEZhkdAhMGESWh51ZPaLcAUkAgu/sJB/uqZLQm6YzQr
         e6ImOk42YOsywu88Vjk0fHLrN9xyoCxhNQ8kGj2HR7jmzvsu51US32sGAA5hoIhGUqdG
         D2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768504; x=1777373304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+ooAKgHIuKcQdMInfKY/BCUWonIks5RSqvPScUktgk=;
        b=QW6vw6Iq4Og7siR+G9gBtrInl+ytC6Nxoq/8RXWZ7VIbj9Qsx5pKK6Z3LKlSbMSUYs
         W7Pv9xwUB6Sjk1M+Kuig0C0J3FN66ml3SRXT45rKNmcNBhM0MdccJ63Q0JUJw1l0SndI
         ffOv4Boddd5vIEt2hd0wTRScDKIOrKci6I2uJOdoHCehAFvexCT9HtSoZtUbH33l3ino
         qoILt3Uvh7HxILsZNaNlAyo7/vJLMpLeIwmf5o7tZDdZB6HHmssLl1BvWc/03jE8ybVk
         ZN9TNz4CSccM6en8PHxImHN2L5pp9ptq3yXP69eE31svVPKQYX2Wzzau6hkfD9WfTttN
         03cQ==
X-Forwarded-Encrypted: i=1; AFNElJ/amyELYk4Wmd7xrBFYP3gSW0C2x61r9AlcP+a+gg6vilpgxUb7xeAtcuvu+PD9pLgly2MbgwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaM/NDKS7vaGhrx0iITIxtghFaAyUPZHY8vwZT10XivqRhI/B
	l9zTEFUKopKZ+eDObhatq845tpSB5wU7lDyXm5fmxDtzXEjU1UX6pJA=
X-Gm-Gg: AeBDievrlyn7y8Z82pfwVT+Ow8MnsLo7IPiC9fGVPZtaRlZTDLb7dJMSxMcEqgDlEMH
	Tpb02+CK2IaYIPKyI84cGEizHiJx+Ebvyf+M5/tZwIF5pOFKp5uCc6JywqSIo0n6YvbNf2yqDkp
	m7qOWklprKf8p7WD20uuJaYPmNjt/nyZil5mk5IdwkWluDQ4meJVgbZN7ZHXG3D+cvoJ3j/NV04
	2xd68j7JANQuKFMEBkE30zqe3A/6TwQTz0LB5ftGr61p0DGiD5culfB+ufUKGXCwn6hF96iSnHz
	Prr+g+L2Y6bzW/SuLMHnPDZpyvysxn7eFwLtXxI4TUN1+DeaKGXw152yFSRPlGzEi0BmP9tDQOL
	pP8Ptmrx0RWJVfvB5kekmCdo3xDPMM3Pq0r5gVUDaZ/M0KSbw6iVCC+aQy1gMUq6HPOP56uud6y
	jzJ0Q5IT8qrZAHyQ==
X-Received: by 2002:a05:600c:8207:b0:485:3193:6ddb with SMTP id 5b1f17b1804b1-488fb73cf74mr265162525e9.3.1776768504275;
        Tue, 21 Apr 2026 03:48:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc14a61asm332563105e9.15.2026.04.21.03.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:48:23 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Chen <mark-yw.chen@mediatek.com>,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Tue, 21 Apr 2026 10:48:22 +0000
Message-ID: <20260421104822.2498025-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240127-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 3EBF4439BB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v4:
  - Use skb_pull_data() instead of manual length checks, per
    Luiz Augusto von Dentz.

Changes in v3:
  - CI all pass (CheckPatch, BuildKernel, CheckSparse, etc.).

 drivers/bluetooth/btmtk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca274..b1a96ebae 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,8 +695,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
-	/* Parse and handle the return WMT event */
-	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt = skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err = -EINVAL;
+		goto err_free_skb;
+	}
+
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -712,7 +717,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 		status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
-		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
+		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
 		else if (be16_to_cpu(wmt_evt_funcc->status) == 0x420)
-- 
2.47.3

