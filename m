Return-Path: <stable+bounces-268807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rdZHH4lYPmr5EAkAu9opvQ
	(envelope-from <stable+bounces-268807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:46:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5E06CC295
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 12:46:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=g6xfnBz1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268807-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268807-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89FD4300D853
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 10:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A603E00B6;
	Fri, 26 Jun 2026 10:46:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46DC29B766
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 10:46:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782470779; cv=none; b=tKOR0Sco+894i0MmQCDqzEMgpXb8nMX49TyShxfa6/D83yMQv2UYYTjpxAAmcleWBVq4fSGKMfAlrBXrXkuyaaH6eRLBIO2CWR4RgjKiw0nji3dkrSdYvWepALZvSplfEGwGWLONL5hMk/cdnE5Cwemn+ln4ohdEAjFSWoxv+UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782470779; c=relaxed/simple;
	bh=vKEWT6O9bP3DpdrhVvIho3UWnDQ9SYmZ2ge7bd0ghi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cww+Xi/6Ics6fkFnw3Ft1Fc05sRgTWIz8gp1DGQjCzUkzDwOrnaiBJWBafzPQD6VuBvGdmXQ5Lu6WVbHNETgqypJFpXDajjLKTqQYBsneoLxpASH/wlL3XvWnwh50e+D5v07IqMJGEMZSsfJpNHrEidHsZ+xsNXajg6P8Pez6X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g6xfnBz1; arc=none smtp.client-ip=74.125.82.173
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-30bf132969bso1275873eec.0
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 03:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782470777; x=1783075577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qP0J1iWyaoP+HLz+xwVairx0bDAZ93dXt6GX/Ei5LK4=;
        b=g6xfnBz1cpWSfhdC9mzpPEjHqjf50psXJGZn8at5/PVxiZkzCw9NE7a3DZzE77FiIP
         K5K14S8hMnoggHgDAkz/WGIal73rLWcTwJftSEz8Um1SqkNIf/+w9C0b/GpVtnfZl/12
         uUtPVT1B/DRlw/O+d8e9fA/pTuuQuMmCnppD2uVffxCxRLJw6E6BwoTrtCliHnQxOl7x
         TFhFsqT5Fnhc8jlsg1C4KQfFLZrTbuy9Xk1n6iFdFGVPD6/4RN864qhig9GGTg6EAeI2
         gk1yr7Mo5MP3fR90Py/4+YRFpdfQSU9+yLur75CbXVMrHvg/sugBJkhT//8b9vlm6Oqb
         R+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782470777; x=1783075577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qP0J1iWyaoP+HLz+xwVairx0bDAZ93dXt6GX/Ei5LK4=;
        b=ICqQjN0nluQ6x/Y//t05jHS0khFHz3F3ECSQ8W7BXE37P1YgimKZR0T4TwXNd4oRPw
         VXhQRVbvUizFpWJzBQ9id0A3B0p/sGCzFX7xnYBKEBChq2upJS0bnycC9xjm7PIz6WRD
         0PAlrlT2FHpO0xGF3jauGXfCPcW/+zKlbmtJrD7kU7HyMJrJaJQRYJhUYArC6A3x1v1d
         IiUKLteOuUcmnYRt9e0bctdjK27uEj2F/vNSlHauJMfua1ZzUuMhDQgbajhGMZ9vpH7g
         ViEwde2KdPd9pD5ftHGTtUJat1gP5j2XOVXpbXiRYJzfdj7DA3DC3X9NUBAPH/HjIx/h
         6VmA==
X-Gm-Message-State: AOJu0Yx5tBV2k1hi4r9Q0nC7DTCAy3pSWXZIkR2rrTgHipcirpnIgHLH
	ZJKwIKMhnsMNAJmW/Mtpioatc+6W/+GFFVtMvZZ50WMe9ujWruKGbfPaPgMPSIJcFHtDug==
X-Gm-Gg: AfdE7ckNMky7Hk6wb+Q0wMTv43GcrHxjABn74429NzyOTDoWdgTSVLql+vavJRN6uwF
	kQfZyzJ6HoGTqRRigrw5ou9kZfqoJeWEpJoT7Eh4p2T+SwmRt5QVNRhiUSdwWo/nVRNbrCzPNtv
	koFE3je3tgCbFtuTbMHnnWHyAIOdIxyJcuEQbE+pJTrsJY1api1Hes3uuKFLXzWcn6I1bvyQsYv
	jZMXAYAlLSokiQLfunRN9tt8kksd9TbOTKzFMNCENYMKezdf2J3l+Ec3oo23bBZcV4LZbJi4eUQ
	lkLQx7H9IidejkzYmuG2S7H/OM+kgbKruFK9IymPmtAt1LfT0BEKGAxrNxwehhTh/0wZOf/NulP
	CfCEvF+CjL4oGkpfR1qUn4mhj0u87xci1T7CdFeKUisLntctPl9mztaaltJuCZIRFmdkf1dZx1t
	kOMDE62W5VJCSHR3SBW5T5FASkgFosNp+5Y09yPmjvQrV9jhRYcRcN2qIqHA==
X-Received: by 2002:a05:7301:644c:b0:2ea:e93a:ff9b with SMTP id 5a478bee46e88-30c84bcdacfmr6099364eec.13.1782470776870;
        Fri, 26 Jun 2026 03:46:16 -0700 (PDT)
Received: from naduvan.timesys.com ([122.178.167.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7cab28fasm17823093eec.30.2026.06.26.03.46.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 03:46:16 -0700 (PDT)
From: Siva Balasubramanian <sivakumar.bs@gmail.com>
To: stable@vger.kernel.org
Cc: tristan@talencesecurity.com,
	pav@iki.fi,
	luiz.von.dentz@intel.com,
	linux-bluetooth@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Siva Balasubramanian <sivakumar.bs@gmail.com>
Subject: [PATCH 1/2] Bluetooth: btmtk: validate WMT event SKB length before struct access
Date: Fri, 26 Jun 2026 16:16:03 +0530
Message-Id: <20260626104604.3465124-2-sivakumar.bs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
References: <20260626104604.3465124-1-sivakumar.bs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[talencesecurity.com,iki.fi,intel.com,vger.kernel.org,linuxfoundation.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-268807-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:tristan@talencesecurity.com,m:pav@iki.fi,m:luiz.von.dentz@intel.com,m:linux-bluetooth@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sivakumar.bs@gmail.com,m:sivakumarbs@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[sivakumarbs@gmail.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sivakumarbs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C5E06CC295

From: Tristan Madani <tristan@talencesecurity.com>

commit 634a4408c0615c523cf7531790f4f14a422b9206 upstream.

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
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 634a4408c0615c523cf7531790f4f14a422b9206)
Signed-off-by: Siva Balasubramanian <sivakumar.bs@gmail.com>
---
 drivers/bluetooth/btmtk.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
index ad8753dda826..5c6f4d4b2e7f 100644
--- a/drivers/bluetooth/btmtk.c
+++ b/drivers/bluetooth/btmtk.c
@@ -655,8 +655,13 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
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
@@ -672,6 +677,12 @@ int btmtk_usb_hci_wmt_sync(struct hci_dev *hdev,
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
2.34.1


