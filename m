Return-Path: <stable+bounces-238474-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LWDNEcN4mkg1AAAu9opvQ
	(envelope-from <stable+bounces-238474-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:36:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1BB41A2C9
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 12:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DD803001BE6
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 10:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AFC636D9FE;
	Fri, 17 Apr 2026 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FT0cwr5W"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC07370D56
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 10:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421763; cv=none; b=Cp8RHNjCfCA/NozAGrK1bt2W2VxVrfUml5o3b4bOQNZ9HoZlgOnptjM+1lKCPKq5FlxnQVXxSTuckbfzir2Vl3bTf6oz7FqdDwXyS11ZbcBG+w3UvobKXlx9gr3Ou+gJ2Cejwq19+M2oAIjAEYMRkuTZWzNjyg9TAMH6u3HhMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421763; c=relaxed/simple;
	bh=yy99X5ZV6EUa6VM0MQM1D/ya75MnDqHlC2agDPMvgQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FKCLKxfkUaEl94uibjX33V00A1Gd1G1eme6KMobjdCJ+gZNoneylyBYJkhiNUvkt3xEUwOkFj2rGR13ICiLiW3waewxODTNYswPt38rd8PI15zApv5Llai97DM3s1vxvEfPy64qAqFvHc9jIa9MmN797fP41oxynGB/TJeoBp/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FT0cwr5W; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso6397745e9.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 03:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421760; x=1777026560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fE+qnOdm3zs6vETg/xjRcNv6wjpPT+qb+RS/sbJQMYo=;
        b=FT0cwr5W+nVQVd7Mqs9ZMC1zMV35dp30Y/faZNSdwHYBrS2Kr09Xk9vGS2Zlg6npVb
         XFzGegkJ6IikFwPJ31IzZfghEuJS/+6oj1PtzubWJynJHLdh5O8dAF92lgvcotCYwwYT
         tqelDA3+aFIrTVp/yb0jzkWagc3AIwbkf89Q+Dlh/KaRdxEn6cTYH8HbAjST4Ph/jDqd
         ggecJ9AG3wtInJTt1jXIAZrr5S7kk9jAQfGZ4x0bWq8a6dXbB1TQcmraPbiI7WBuw6va
         fsxzLfq51j+UPOoDWsArGn/C6ytisqISUngvSz6QFHEWOoyARolJrvXpE70t9G8fJE7R
         e3fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421760; x=1777026560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fE+qnOdm3zs6vETg/xjRcNv6wjpPT+qb+RS/sbJQMYo=;
        b=UD7fpYVmRo29yCry4wh4y2m4lNYkM4bPJVk+Du/aKK770QCR9V2ulCJIqjhkY7GwwB
         ZV7oj2/Vxbkel0rnxGh+PUsnudqidn+MsigjYkvcNfBY2cISxhc9A4BSHrcB7krccqe0
         xXP9T74AsHDxZuXrYU3dz6Ra9eHv7aINgYNXiDaiwAY7+0xvwc4kHRA8o17jKBHzOKKg
         xuoNwiRetjCi7MQWZw8nXo1VOB/w2umptUBQmYIG7jteRIWdiHah6EcCzHQNeQmCVMge
         TNKT96Uvus5RsMcHJHpTghKGdRJW9sYmEU0/VRkuZGLa1CtkkjSEB4rqza64K5oiVvRQ
         VUdg==
X-Forwarded-Encrypted: i=1; AFNElJ+9eoc0G3pS0HzHvE8jn1oSIYXBn6EZNr9oMT6Kc/iSeEFAH03dM6ikCDf9IBQ+mUzezjyYEVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YylRyYXa0A+UTAEpRQ8cSW4/aaE/Gf4lo0PGfRlfaE44OoxfERA
	e9Dlh2GboJJ+jcE0UmT8i6CviHxUxjdCvQapvFeUvSKPX1z0qhEu18s=
X-Gm-Gg: AeBDieuGmRgOZ5gczg8p+2KN6iDDC88iE4irVX1d5YZelEUj3bReOfoSL4V39nEAtBj
	5aLCiJzJ7Xfe9WMwH5uQQfpmFw2GYWBFJNkZB2XnsqtKCpBigWuPbooHibee4vONGvQtRRCeIyC
	pFjOoBMDYwE633uJxa+3gXxna5EUILs4ekvgV4C62hIlHFxw3qcLUGjCzPQL/IPCeORUkrkMJVU
	WKO3TAkjKN0jBlP9L+7zCythnSYp9/2b0xS9STaxG7HHv+D9SCg1fhX1mIdT1tRLV6aq/p+Oc7d
	lK2hWeYNufB0+s5uxwDp1Iu3hOBiLhl1C85Van1lr/znZfkx/ozOHp4vVZnLJoFh/aecRoOvqnH
	6v3kDHJuYOeYyBXECwf36XAFUmFTInP3JZdoREjnuACOmjtXSh3aXUwoFkN/TfTrNsErmeYE4Xh
	ajQeM=
X-Received: by 2002:a05:600c:c4a1:b0:488:c014:34da with SMTP id 5b1f17b1804b1-488fb77ed1bmr27199815e9.26.1776421760356;
        Fri, 17 Apr 2026 03:29:20 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7c0eacsm13854955e9.35.2026.04.17.03.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:29:19 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	marcel@holtmann.org,
	sean.wang@mediatek.com,
	mark-yw.chen@mediatek.com,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v3] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Fri, 17 Apr 2026 10:29:19 +0000
Message-ID: <20260417102919.2549352-1-tristmd@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238474-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,mediatek.com,lists.infradead.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4B1BB41A2C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tristan Madani <tristan@talencesecurity.com>

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Add length validation before each struct access to prevent OOB reads
from malformed WMT event responses.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 drivers/bluetooth/btmtk.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca274..b1a96ebae 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,6 +695,12 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb == NULL)
 		goto err_free_wc;
 
+	/* Validate SKB length before accessing WMT event structs */
+	if (data->evt_skb->len < sizeof(*wmt_evt)) {
+		err = -EINVAL;
+		goto err_free_skb;
+	}
+
 	/* Parse and handle the return WMT event */
 	wmt_evt = (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
 	if (wmt_evt->whdr.op != hdr->op) {
@@ -712,6 +718,10 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 			status = BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
+		if (data->evt_skb->len < sizeof(*wmt_evt_funcc)) {
+			err = -EINVAL;
+			goto err_free_skb;
+		}
 		wmt_evt_funcc = (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) == 0x404)
 			status = BTMTK_WMT_ON_DONE;
-- 
2.47.3


