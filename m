Return-Path: <stable+bounces-166991-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E69BBB1FED1
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 07:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A69163BB86B
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 05:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52217270EC3;
	Mon, 11 Aug 2025 05:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HagoNJBb"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f97.google.com (mail-oo1-f97.google.com [209.85.161.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C361426B098
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891495; cv=none; b=a+K1zbxgmMQwv2vFdDPWCZWnYCGK4CM+/9rae+7QbcDquazwyIoojC/G9BzoaZ7kRqMjaPVdqEE9lI0STUcu8H3kmf3tQrgXRQDrRYL8D6AG5WDss/yMUSHJsEtqebBK106wjKxeL6t1kacH2IY5AMVicTlpsnP6HQp7doAPHmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891495; c=relaxed/simple;
	bh=0yp2V2VVk7SzKuFUi/ZVfl/o+NZ050J3YB1CuCwPaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EUU/FnABQAHlW61cZ26swXT7QMSvq/lJ1dpKZQCWdOwZEb71TP3pG1K4j3zxDBqfKNpWDn02ICTEDtmJPyjpMb3JydL0NvViWkhumd3FCpCheq/goOgFR7VA8zErqGyUel3A6pfdZQpE7h21U+UDV4v4o2eyqFbUowoG5moO0p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HagoNJBb; arc=none smtp.client-ip=209.85.161.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f97.google.com with SMTP id 006d021491bc7-619b3117266so1559275eaf.3
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891493; x=1755496293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=RN0azueOQjpuyv6YG3U9L+FZ6e9A/7LBcmescx0qaDu1Csn1jg1MG8hDnV1m6Oshvk
         AHT2EIX2V9TLkf6RJZu4ZFdr5mU06nsZrMMmAyJxkcxtb2Yv7W0Na+kKk3bjBK01GiA8
         0MtuWsNBeonI3MlH8hMwR4HD4aNe4LhgDDaD8xqIWLnk9vRciMQJa+xia7LsJ03XU0fT
         HrwqwJ9lmAebvy+jqh9KfiG6bTEQUrFJcKuS6v9SbVn1qUFlHhn/ThCN4LWuPO15GHWB
         dWw5dlwo7UfoQWO8dT51e4nu7KhlDiAzNCcNq5ugnNJrEhej4pZmNZn67/9jjjG5q5Ye
         iZjw==
X-Gm-Message-State: AOJu0YxFJjPXrpIk7Zf6XeHtoIc8FXP4f30TNwKu89TrSi85xCfLL4gZ
	+OvHA1M6iSd2HmpOTxH8inIWarcJowd2ZCJMPcF/wiLzcWisgHKI1MMhGC5SNREX3uRuPiam7EV
	idOtnPUWz8DfL9uxqT4kIdXE9oF9aCUSq3O3XA0tpni1wRuEAxQB1CYNcxkOBzkQAlZgj9tJccD
	zSZPm1TDgtNLXinlsxu7LmlQBQCOSYIQmb2z7sgbLlqM3RKDpc2ZXwKpsG65tkiTMTFzaBqd3vI
	B4E0aFhtQf5zGunvQ==
X-Gm-Gg: ASbGncsxf7mrlCj7tYM5p1ZxUZRqL4GQVfVH1mmw2atS7fEy5IgyM+quEH0847244sQ
	Rzx42591rqqvhrCEheJvM6kejo+6QwtctFfEunBwjX+fR+GMxPqz3Vk7t8otmNGdIa/4NDWtzbF
	sMGEncusG9mQdE4n6C5jGPu6Edw8aIEHLqxn5ohgCMSqmUiiIRnmZzQjoaCkg4kLJqvCOAmastE
	u/P7Dcgnt7lzylhrxnKm66uUJFqJMozn1I/Fm4C3AQGpCZRfmavYaN2XcJ5/Bb1bBmvFQqnGlHc
	dg/870n1mtwgCbEOWi0GhWB2OTmDG1w7BeAZS0l0hvCfczzO8wRDYnCvbxAwYjHpU7PFI4LIcin
	fK9bX2VxwRwHVVeO0dKbW58ALEkdINGxdOJJplMG+EZJ6+LyvN2vJqgGdE8+S0FLM7yz5FKDf1N
	nfoE+DDg==
X-Google-Smtp-Source: AGHT+IHApZnA8u/3XNHjruEl44BN19PRXIJFxDpkcfYbGxpIphEM1fxSL/IjSvaV7EoYSuiOz8qkG0KF9ezS
X-Received: by 2002:a05:6820:811:b0:619:866f:76b1 with SMTP id 006d021491bc7-61b7c41e3a3mr6640461eaf.4.1754891492803;
        Sun, 10 Aug 2025 22:51:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-122.dlp.protect.broadcom.com. [144.49.247.122])
        by smtp-relay.gmail.com with ESMTPS id 006d021491bc7-61b7d522bb4sm179360eaf.2.2025.08.10.22.51.31
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:51:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-70732006280so80728616d6.3
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754891491; x=1755496291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=HagoNJBbvs8WLIpLTExqvMa5PlAM3qXlrJWy6cq0p7jdveH0Jmk+/H+B7XHZ+y7nx8
         /Fp0ti8epILIQgjZGX4WGgJ+pwRksrsuUpJbCJmNc0LYsRPP6jGhpgGwoTOJzzoH5aOY
         IGKoE/Cs/J7G5FGHJKsXelDTXPeVcP9hWWlXc=
X-Received: by 2002:a05:6214:c83:b0:707:bba:40d4 with SMTP id 6a1803df08f44-7099a1b9ccfmr151427656d6.11.1754891490886;
        Sun, 10 Aug 2025 22:51:30 -0700 (PDT)
X-Received: by 2002:a05:6214:c83:b0:707:bba:40d4 with SMTP id 6a1803df08f44-7099a1b9ccfmr151427376d6.11.1754891490332;
        Sun, 10 Aug 2025 22:51:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077c9d6d6csm150672406d6.4.2025.08.10.22.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:51:29 -0700 (PDT)
From: Shivani Agarwal <shivani.agarwal@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: bcm-kernel-feedback-list@broadcom.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	tapas.kundu@broadcom.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Shivani Agarwal <shivani.agarwal@broadcom.com>
Subject: [PATCH v5.10] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Sun, 10 Aug 2025 22:38:08 -0700
Message-Id: <20250811053808.145482-1-shivani.agarwal@broadcom.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit 0b0226be3a52dadd965644bc52a807961c2c26df upstream.

Memory allocated by 'vmbus_alloc_ring()' at the beginning of the probe
function is never freed in the error handling path.

Add the missing 'vmbus_free_ring()' call.

Note that it is already freed in the .remove function.

Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until first use")
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Link: https://lore.kernel.org/r/0d86027b8eeed8e6360bc3d52bcdb328ff9bdca1.1620544055.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Shivani: Modified to apply on 5.10.y]
Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
---
 drivers/uio/uio_hv_generic.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 6625d340f..865a5b289 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -306,7 +306,7 @@ hv_uio_probe(struct hv_device *dev,
 	pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
 	if (pdata->recv_buf == NULL) {
 		ret = -ENOMEM;
-		goto fail_close;
+		goto fail_free_ring;
 	}

 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
@@ -366,6 +366,8 @@ hv_uio_probe(struct hv_device *dev,

 fail_close:
 	hv_uio_cleanup(dev, pdata);
+fail_free_ring:
+	vmbus_free_ring(dev->channel);

 	return ret;
 }

