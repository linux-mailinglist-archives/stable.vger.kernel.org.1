Return-Path: <stable+bounces-238085-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCk8Jpde32n+SAAAu9opvQ
	(envelope-from <stable+bounces-238085-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:47:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2F4402CE1
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 11:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1C2983039CC2
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2F733EB06;
	Wed, 15 Apr 2026 09:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crVQINYW"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8053368A8
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246402; cv=none; b=XKFrB80I0lvqNAeFsTj5o0wenLBXMuCfeb0oT/VNH81zbwREmY9sfeWcWWRJtxRl+eEFAgc+lAw2eGntbGTfKJRSBl7QeKoP7IHe6MyOksJSGmmvGVptGaveHwp/jwlOLY4o6Y2afERHT9x04rvamE9Cz1TVeQkG3ZLoO0JHaaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246402; c=relaxed/simple;
	bh=LKL/MhWeV1FzrCZwdQLSjCSaRmITso0Q7UDbgZ9YwdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzKTSRYFkRn/aXjYqpiuG4s/xBWR2SRq/6plxgrreNaqnAYs3n230txRt9dRrcPkp4dx+s9O2MQ2HkNldqk3dWeYlQ0FqsX/ciUKtX2rTQGYsvdacugbnxEZe/nJwVmTnMJaGljx7dMOrsTGfqoJp+NoxmV30Y+7df7GWVFP/rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crVQINYW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6715006f4f7so5191955a12.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 02:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776246396; x=1776851196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kMZ3rmolb4xRGVlwbHJI7Qiu+rWBXpl768B1YvbmjeE=;
        b=crVQINYWcwpdMq4F9aveMGeWCJG6prb0NS9C9dtnElyjyftQQGiVrQ1DX5FO7JgZDV
         itJzomyknSjcop6me/VyWbWD6JvrKZiARLZ2sgdIYpmZJfwU4ycItRgSQEhBcdsSBUQ0
         9wQB3n90vx2TseezfhD2ay84XS9q5AfeINPt111TRivk3B6HbNvrOWWbvotywtNko+9M
         6fRpkAah5CZyJwpTaxkkk/ZDq7Pl11hBWApL+91DkZ7Mml1AgqyLvBKispekBRxkPW7v
         s2gy4zth0snjC0Cf1oUVhE/DzFezrucRGcA4VSrEMfbAkkGKUlPmYG7iWO2acb+ICBgt
         S6jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776246396; x=1776851196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kMZ3rmolb4xRGVlwbHJI7Qiu+rWBXpl768B1YvbmjeE=;
        b=V37G/z2M+ixDcdLp7yFs7n2s6NPe4oCvKY30C3p4G2ImeLw2axCYWBYrN9MBX1/26V
         WaMFEc+Tmr+ebFVzNxn6gbW42AfrKVfe4AQaZt/xyoLd1f/61/FdgSwUMNP4IjSDsyMD
         k8Sz/EnjaGGdx9NLl4VSk6+BzYFP2KYPmtCQIwlsSTI7NJz1Iw2qZnRcyqwz8oNp503/
         yTWLu4Br09URH/V6mhtswZbYuBs2SKphUspt84TaFtOH5uf6myeYiUA6Os3XM1Fn1foB
         YlT7IL7Oi5HMslL05zK+YR05xP2xqy1ulxjI3pWK1a7aijmsukPGDf/7XBW7yNyHGAq4
         9f8w==
X-Forwarded-Encrypted: i=1; AFNElJ8oM2WbRdadit1r8K1cweLuPlV6BeaoRRMVtAEf6Tultj1co+Z5xw3OqTv9iUa45Au+aqqdynY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaOPk+oC8ky4d5Q7cox1PrGeNvzdOnFMRQrp7HfvS090ytlfVR
	Zp8pFNKUTY1HweWMQdR0+F7htsO620KP8jPEMiF7R0P/+fpGOSVlCZgj
X-Gm-Gg: AeBDies+blA7n4QqHupc7sJGbgIbRAVsCuuhenma+v/jzQI4c2A2PL0yUfO0KdZDduI
	7n74KjLtnw3ih8j8XRtuAxapPRHKu4aAMSd/LdImOoOFskeytOXtRb+BrXxyKvDrrIQrJ8Ebsqj
	8wbNdTXkaj+cBHDjb16fGtdf6olF0Bkm/EgbAhs1quE7/Opz8JS0SHPm2xAQ6dW0ICfovpfu2iZ
	l0yag1bFaCBUS2idHiCE71vUAeDwaiZZMFvdhhRq57faESN3KEoHh5W8mO0kwdNzVIsk8tt88aY
	aHi0aXd0DSNor3SaYLtyGbOBHDI8/nAjPRYFaS/4L/OP9oMhbQ00RKkLc2VCLINqiFIi1n2KS7K
	m1DnDgn1LT1nPYLgtp6EaIY0B//CDmmOEJQIiISxVLmGilKbUEhPAA5KPIoUAbHsO/iWa65warZ
	1YiRUrlAZV7ajXiSjCEsL+lXNKeNuXrPoxGHl7bQjeruoug8gTX6ESgtLT+u8Nlf8dvfpCemC3M
	8xY22pb1kbe+AZykwBTPH6oVhBPAuOQXFYnRGe4jWz/+Coy04VLUzDTJa54INkmvxYzvuK61QSc
	MAX/QQ2XOxmYVPFw
X-Received: by 2002:a17:906:f582:b0:b9d:6109:f1fb with SMTP id a640c23a62f3a-b9d72440757mr1236270966b.11.1776246395751;
        Wed, 15 Apr 2026 02:46:35 -0700 (PDT)
Received: from ahossu.residents.sin.openfiber.nl ([88.202.160.248])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1778c4e57sm39310166b.47.2026.04.15.02.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 02:46:35 -0700 (PDT)
From: Alexandru Hossu <hossu.alexandru@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	error27@gmail.com,
	stable@vger.kernel.org,
	luka.gejak@linux.dev,
	hansg@kernel.org,
	Alexandru Hossu <hossu.alexandru@gmail.com>
Subject: [PATCH v6 2/2] staging: rtl8723bs: fix missing frame length checks in OnAuthClient
Date: Wed, 15 Apr 2026 11:45:05 +0200
Message-ID: <20260415094505.1115208-2-hossu.alexandru@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
References: <20260415094505.1115208-1-hossu.alexandru@gmail.com>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238085-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,gmail.com,linux.dev,kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hossualexandru@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7C2F4402CE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

OnAuthClient() accesses pframe without first verifying that pkt_len is
large enough to contain a valid 802.11 management frame header:

- get_da(pframe) reads bytes 4-9, requiring pkt_len >= 10
- GetPrivacy(pframe) reads the FC field at bytes 0-1

Additionally, when pkt_len < WLAN_HDR_A3_LEN + _AUTH_IE_OFFSET_ the
unsigned subtraction passed to rtw_get_ie() wraps around, causing it
to scan well past the end of the buffer.

Add an early check against WLAN_HDR_A3_LEN before any pframe access,
and a second check against WLAN_HDR_A3_LEN + offset + 6 after computing
offset to guard the seq/status reads and the rtw_get_ie() call.

Suggested-by: Dan Carpenter <error27@gmail.com>
Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
Cc: stable@vger.kernel.org
Cc: hansg@kernel.org
Reviewed-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Luka Gejak <luka.gejak@linux.dev>
Signed-off-by: Alexandru Hossu <hossu.alexandru@gmail.com>
---
Changes in v6:
- Add hansg@kernel.org to Cc (original driver author; accidentally
  omitted from the v5 series)

Changes in v5:
- Resend as 2/2 in two-patch series at maintainer request
- Add Reviewed-by from Dan Carpenter and Luka Gejak

Changes in v4:
- Replace incorrect Reported-by with Suggested-by: Dan spotted the
  missing length check during code review of the heap overflow fix;
  he did not file a separate bug report
- Add missing version changelog; correct subject line version number
  (previous submission was mislabeled as v2 despite being v3)

Changes in v3:
- Add first check against WLAN_HDR_A3_LEN before any pframe access
  to also guard get_da() and prevent unsigned subtraction wrap
- Rename subject to "fix missing frame length checks"

Changes in v2:
- Add single length check after computing offset to guard the
  seq/status field reads

 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 90f27665667a..884cd39ec756 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -860,6 +860,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 	u8 *pframe = precv_frame->u.hdr.rx_data;
 	uint pkt_len = precv_frame->u.hdr.len;
 
+	if (pkt_len < WLAN_HDR_A3_LEN)
+		goto authclnt_fail;
+
 	/* check A1 matches or not */
 	if (memcmp(myid(&(padapter->eeprompriv)), get_da(pframe), ETH_ALEN))
 		return _SUCCESS;
@@ -869,6 +872,9 @@ unsigned int OnAuthClient(struct adapter *padapter, union recv_frame *precv_fram
 
 	offset = (GetPrivacy(pframe)) ? 4 : 0;
 
+	if (pkt_len < WLAN_HDR_A3_LEN + offset + 6)
+		goto authclnt_fail;
+
 	seq	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 2));
 	status	= le16_to_cpu(*(__le16 *)((SIZE_PTR)pframe + WLAN_HDR_A3_LEN + offset + 4));
 
-- 
2.53.0


