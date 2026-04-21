Return-Path: <stable+bounces-240131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDvGLThc52l87AEAu9opvQ
	(envelope-from <stable+bounces-240131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:15:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EC439FC1
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 193D63029760
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 11:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11EA23BE17A;
	Tue, 21 Apr 2026 11:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aVOPb/1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAD93AD52D
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 11:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776770098; cv=none; b=h15Q2d/dfdFidMdK6rL0dw9VtSL/CkYktfYHTl6seoXtEeRtQZBOqergv3X3f6cScEBxeist2VTfwOxgLIg63CiyUmbTQlvyTTspTFfghcu+ULbVw5U1k+CGx76LcZ0TK7eQr/8/0Q/kLq3jj+Qsu4vdK1TLi8lqWsCg8mdFMDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776770098; c=relaxed/simple;
	bh=MH029eDJfEvKtox6zoGFIugdoIrSt90GG37NR0eJiAI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKkHVJLMchE1P0uMqt9LuFYWDyAAnrG22f7C7Dj5/xatELwhbkCDlYnZIl3nisKx/rF3ejKO8qfS+S9luq7LtkIWtGynpw28GucOyW8hfEPtV0Pa2Uc9rWCwVEipJndq4QlVoXg8Hi8KLXLkF6rgxtpIAxhzAwdBCK0Dx6PheTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aVOPb/1D; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cf8d550bdso3676670f8f.0
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 04:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770096; x=1777374896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kjPHv1Hru04ZXzIaQ9HvSw3rx3tnPbEFHQIlqAw5RuA=;
        b=aVOPb/1DYinFAxge6hyLa+szvLEjQjJFYpIHKc63H5XqmdzkQ7lbn2y0atN1kAlmv6
         9FGRArzEASWeRCiMbw5In4OEMMS8OOaf5ysAF8UiSosKO/Vd3w1+DfkmGBIwk2lpNKS6
         Lcap4FudwTxV6vx6o/EzZ0QW5ZofPmL+XKXX9hkTIqK0SDgGKB3LsbM0T9/CsqibpCzc
         sD3qTs4dGSAdiRjpMUE2aomLLM7A6dYTkzUcO3xB8/jDJGqzAfOxxsgQny0A31YvlFiM
         Lim8hJ5S0Lk1DoQE4EV4nkzOaKQgrz0Ute1B9CwvJJpEtNeQHD1jBJj9GwYWHPNMVeoQ
         S23Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770096; x=1777374896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kjPHv1Hru04ZXzIaQ9HvSw3rx3tnPbEFHQIlqAw5RuA=;
        b=mP3EYC8HQPbFApjh1tiSR2iOQIhtHNGAXCopAenKH0dxJrAKCrCUD5fq9RQg9lQjUQ
         XPMYJcRCQETz4BO5RK8zRORXSWwkgVP6e9gLBB224PPZHvdeYR8n3cfsboeXabqMsuuN
         /bCAoxPGRi8gIxvdb2sGVGvujjd5skn6z8X70OfAxpHfq1SUQFjdDnry//ONnEyVBnfT
         hd7fHDn7O0o0yPnjWUA+pot2pKPEzNOq1u2uuyDpg2AN+PuqvKVwVHxyi1ai77gMn6gn
         Cb6vWVJS1z0B9ClHM7JcUCwLJGpRgPKRPAb09bvXfjwXSYVDU7WXuPpGUSm0icIX4QUd
         J4sA==
X-Forwarded-Encrypted: i=1; AFNElJ+Nr8BYZbah69fZX3G1gczLIMMKLjkNJ+XvO9T+wiJUYIBrwp0W6RlwbxTbuG9Kokk6CHwLAOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbuz0PFm3BF2WPie92DKMZ0DHgBWhdNb7Hd0pbLYo2qKoZ7Rze
	iKRPdNnB4tjUR346hoy9nL57LyNo1hea16MgB3genQAQtZEs4FJLNjc=
X-Gm-Gg: AeBDiesudM5SQ9AtQLIwdpNZq672h2lakki+l6qgE6LFcuEzgAtPLe1LehxWN9NTWxr
	uippB7lT79cWtU6tz31OyaLa4RNTQI96rlwT9u/vVA/6spEj4TxtMbKCQ6/qVRgez7AB8t1xYw+
	k8l0zB8nkC89K0qDSv6bTyUzdLPVeyf7Pp+pYml6Ew2iZ56K67cbF398m8i/GLiEIe8OQdcCPyJ
	CKA91O+BX+lFQWUGp1nd1y3aHsnGLp6ArtSKxLSCMmIBtiXEUoNiiz95pvj+aIW7hNbHJe5Ba1J
	tBweDUDQj7jXW6C3FM4AVab2WqGQ8SFrEUhgh8PxnaXfvYA3UAlL8MaCo71XaxNNBr/iGQ4kjdN
	z73VesBOpSiMgfV3h1+ibRn2kM//TInfH/5ONlMmZylNWkOnPFoZcClh0U0fmK3+zkBI6aN0ovU
	WI2e4=
X-Received: by 2002:a05:6000:1889:b0:43d:7b7b:ab76 with SMTP id ffacd0b85a97d-43fe3dc54ddmr27175189f8f.10.1776770095504;
        Tue, 21 Apr 2026 04:14:55 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4c221cdsm36910279f8f.0.2026.04.21.04.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:14:54 -0700 (PDT)
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
Date: Tue, 21 Apr 2026 11:14:54 +0000
Message-ID: <20260421111454.3403059-1-tristmd@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	URIBL_MULTI_FAIL(0.00)[sea.lore.kernel.org:server fail,talencesecurity.com:server fail];
	TAGGED_FROM(0.00)[bounces-240131-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F17EC439FC1
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
 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca2748086..f70c1b0f89903 100644
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
 	if (wmt_evt->whdr.op != hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -712,6 +717,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
+
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
-- 
2.47.3


