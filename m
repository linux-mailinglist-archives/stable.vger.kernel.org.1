Return-Path: <stable+bounces-240123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPQaBzJU52nz6gEAu9opvQ
	(envelope-from <stable+bounces-240123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:40:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DC5439A57
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF405300B981
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A493B8BC7;
	Tue, 21 Apr 2026 10:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sGfutDN4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6CC3BC66A
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776767997; cv=none; b=SCl6D7rlMj+cuOV3t+08n+xzWIM2sEFuSttPgrMLAfxFyNuMNonz2fK0C/3nvd/KjtDngyRPncP22TFTcFwTyJg/Vuz1P2IF8pNvjnF1uzGCMrfttURmE/Ub4J6dmu2eb+D2Gk+4HXyWjknY9JOUtg2Mi5K6ersR2Wao0CEXMqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776767997; c=relaxed/simple;
	bh=ymo8Yrctecma/M2W6veSSsi6Ymbtcjf0rAGf06SezC8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=knaLAvYxy/s1qqOR6RcPrlyGMvacekzM8+l90pOq2poP3vLDaVHsJ4f/6mMa4NLhGfSMCs1U1jhY3AjWzUM2TwXopz9FcYE7I97PnNd+Wqx6djYofMgwJfsQMJDWwjEAQt6RLeM4JcMOvejXgvRj24A6lwhLvzgG70wePWoReG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sGfutDN4; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d64313c39so3192456f8f.3
        for <stable@vger.kernel.org>; Tue, 21 Apr 2026 03:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776767993; x=1777372793; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=13ZWL/eHlUY5OOB6+y7Y+vPu0LaU5nOnT6pQcRP3ud4=;
        b=sGfutDN4hNp9DzEJJLgd5ZJX+j52qkS13eYp4/lY75URx4EHIv/KCqCJrcRLifzm/0
         GIzOQr7LAojZCz2X47W9yBGTZ9vKUqyrOPMusDIAt8I6Cqm50RsVT6yWuKE0qWOlGsyb
         EJi2fpDE5kExBGKYQxaA4wRJTQMfeiSVORoFa3jHZ1tn/PMYPENbkMGQ92hbsE1IHVCx
         jp1iU1WfzV50DSeLy5f1T7wI2FJDm820Gy5f9FpSZjYBGQe0AOOENlIQqDPQU45g7Dz4
         pAJZDHHD+bFUhFh4RcTFhqieEQLYGl9yMG2UatsnZWxOV6qpaQvcixvaTwJ5Fw1n8T2l
         iEow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776767993; x=1777372793;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=13ZWL/eHlUY5OOB6+y7Y+vPu0LaU5nOnT6pQcRP3ud4=;
        b=Y0MaYjEts4oVs9HX+pGJhQTR+bStuL/pkVghd6/FHAFis5Wq8qD6IN4IyC0m56aYyK
         EvEQNc+V+HYkGmyNVLEE/42Q3DBE0Zh4yeSm22X/tHz9mqqaOR9y85FGWrq0Z4dgm3AM
         mM7DgVQu/DYb0Ctkgh9M/Mtq0kT9L0YOIdFCCjojbihVgu8+KFrGuG/b/ZbTPxEk+Yyi
         0Qj9BLvQz/Te9W3u5IKid9wZBRBRWWwFeJ9Iad0PL00ryfiO5HFKKksg4yZulD+cAV2h
         vNb2hBi2LmVcQd2MLbsAFpqcX5vJ9BYBPB5LEWtKycajYf8RCAchHzGnAQ1dQ2760eA5
         EwwA==
X-Forwarded-Encrypted: i=1; AFNElJ/kn2+4/n8gCGWvqivx5aQmawTxoVHWcAKPqa3rvyRGeU683veQaqwJL7bvm1FxJ0+2+yNkcAk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy29ARTSnyCoTREqQTpUNJ0Tupi1espjr8oEsCtm2gYsJkZwzA3
	LzhFfuBLcq445enAs+TpPdo1P1ahdTaC5T0hMfYUSErpXxKZK+ENEXs=
X-Gm-Gg: AeBDieunK/ekkccPFbxDMtHA61/RlyExfO+Lwa8Tl4ZArDzd+m8cNdGXTFSK4OB8FSS
	zk3YA1AAVUUbrpoYc8tNxVTZLPZQmqx5y0xOBMKNtTGcgY38rDpFKm9XH3HjoUxKqwqBnv9M4Q1
	M1wBfSIkHz5eEPTdBrlamY5r4Td+Ab9tQ1V7zZKN3f2MR+2HENkiTCnOl7DeIkSHmbJpkuA2c60
	7ODMyku5uDop8ryaJ+gT1+1RsvbvOW7w/agyUyYdjOxqeiZaTZ8Wv77g9yFUAdFN9P0s/37YBgg
	c3Qgqwpn69gfGHEavj6OhptW/5YG1s42S0pL7HGRZBEQ1jrqz+ONpqg4jFK9zavXi/nYyJMa3Xo
	YQiTbmh5CFm/CLKw0w65RUG0aiw67Stsp4E4/DaYpZrQ+ZjsRGIAS7VQ5Hjkt60fGxl15p5iLOO
	3pXvKgH6ApRjQ=
X-Received: by 2002:a05:6000:2c0b:b0:439:beb9:5a96 with SMTP id ffacd0b85a97d-43fe3dfbff5mr27427886f8f.31.1776767992844;
        Tue, 21 Apr 2026 03:39:52 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm38619383f8f.17.2026.04.21.03.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:39:52 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Sean Wang <sean.wang@mediatek.com>,
 Mark Chen <mark-yw.chen@mediatek.com>, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org, linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before
 struct access
Date: Tue, 21 Apr 2026 10:39:51 -0000
Message-ID: <177676799168.2227510.2141901333230538239@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240123-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 82DC5439A57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 20 Apr 2026, Luiz Augusto von Dentz wrote:
> Can't we just use skb_pull_data instead?

Good call -- much cleaner. v4 below uses skb_pull_data for the initial
struct access and a follow-up pull for the FUNC_CTRL status field.

skb_pull_data(evt_skb, sizeof(*wmt_evt)) validates + returns a pointer
to the 7-byte wmt_evt before advancing. For the FUNC_CTRL case, we
pull the extra sizeof(__be16) to validate the status field is present,
and read it via the original wmt_evt pointer cast to wmt_evt_funcc
(which embeds wmt_evt as its first member).

---

From: Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH v4] Bluetooth: btmtk: validate WMT event SKB length before st=
ruct access

btmtk_usb_hci_wmt_sync() casts the WMT event response SKB data to
struct btmtk_hci_wmt_evt (7 bytes) and struct btmtk_hci_wmt_evt_funcc
(9 bytes) without first checking that the SKB contains enough data.
A short firmware response causes out-of-bounds reads from SKB tailroom.

Use skb_pull_data() to validate and advance past the base WMT event
header. For the FUNC_CTRL case, pull the additional status field bytes
before accessing them.

Fixes: d019930b0049 ("Bluetooth: btmtk: move btusb_mtk_hci_wmt_sync to btmtk.=
c")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
Changes in v4:
  - Use skb_pull_data() instead of manual length checks, per
    Luiz Augusto von Dentz.

 drivers/bluetooth/btmtk.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index 6fb6ca274..XXXXXXX 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -695,8 +695,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 	if (data->evt_skb =3D=3D NULL)
 		goto err_free_wc;

-	/* Parse and handle the return WMT event */
-	wmt_evt =3D (struct btmtk_hci_wmt_evt *)data->evt_skb->data;
+	wmt_evt =3D skb_pull_data(data->evt_skb, sizeof(*wmt_evt));
+	if (!wmt_evt) {
+		bt_dev_err(hdev, "WMT event too short (%u bytes)",
+			   data->evt_skb->len);
+		err =3D -EINVAL;
+		goto err_free_skb;
+	}
+
 	if (wmt_evt->whdr.op !=3D hdr->op) {
 		bt_dev_err(hdev, "Wrong op received %d expected %d",
 			   wmt_evt->whdr.op, hdr->op);
@@ -712,7 +717,13 @@ static int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
 		status =3D BTMTK_WMT_PATCH_DONE;
 		break;
 	case BTMTK_WMT_FUNC_CTRL:
-		wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
+		if (!skb_pull_data(data->evt_skb,
+				   sizeof(wmt_evt_funcc->status))) {
+			err =3D -EINVAL;
+			goto err_free_skb;
+		}
+
+		wmt_evt_funcc =3D (struct btmtk_hci_wmt_evt_funcc *)wmt_evt;
 		if (be16_to_cpu(wmt_evt_funcc->status) =3D=3D 0x404)
 			status =3D BTMTK_WMT_ON_DONE;
 		else if (be16_to_cpu(wmt_evt_funcc->status) =3D=3D 0x420)
--
2.47.3

