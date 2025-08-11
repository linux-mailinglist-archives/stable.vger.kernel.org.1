Return-Path: <stable+bounces-166990-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF032B1FEC7
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 07:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E116B172D14
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 05:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B0026E179;
	Mon, 11 Aug 2025 05:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Hu/xsv1l"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f98.google.com (mail-oo1-f98.google.com [209.85.161.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4B61F4628
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 05:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754891434; cv=none; b=WNE3soDkvh4Wt3nPStjSEpkMgXJtB+e2Ljn0eZJH4mOtmUE3mhzJLF6etD2Sz8QFZp5xPjqzEpljru0W8PcVTdvV4fCpji8iSxZ4hWyDWmII77cIvs/lX+FH6FHHCKQHw5/KKhSn0Ms+yx8Ix6tB0JS9At+MYeA8athfaM9hUmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754891434; c=relaxed/simple;
	bh=0yp2V2VVk7SzKuFUi/ZVfl/o+NZ050J3YB1CuCwPaGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WzRUj1ZI0cUVjObqYTsRV0oAu3w9T6j9mEu7WW+PQKCPrGB7VBMBQFjWmtiPmTziZeWbXmZTBRmGa/rjmaXuJi/DnCBrXNNU710vrKTnb+gzDPAxRGI4fix3Ea5q69HyRmQta26RZdCY54fZEFwTxmd3QFXFB0+8CWwXIspatlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Hu/xsv1l; arc=none smtp.client-ip=209.85.161.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f98.google.com with SMTP id 006d021491bc7-6199e7dea32so1905887eaf.2
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754891432; x=1755496232;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=fFwp2PGY+KEuuEGfvoG4GRSu0iQrk41VMK4e285QvJQXBvR4YriIR0Tye3fZWr1T7C
         R9W4ZPa5mHjlYV9386raj7fJLfxMcRSUDdCRU1ttQHrpVLUTE6D6wBHdM4Sn2sknsfKa
         MLm2PQ8MPpAk6Dy+VhswgUb6rp5h1Ok8iZRT5uKjea9dnUzqsYDMx3XN+fzSuuyqNaDD
         U6OnBoX42g/suSGgz30+8DrPV46ZVNbrr0MUV+WxmXd63dIw8mk6QHaPba0O+qZ1UTpN
         OfD8B+Q0zPint70GR0aR6frCUAdscI3iYdqJx8694x/djGa7sOLYJ4nJLsUjsBpUJrfs
         U8OQ==
X-Gm-Message-State: AOJu0YwH1UcALOaIe5C5YuIbYHrQXRVbLsAZW0o3iiifJ6gSVZMMDsK/
	XG4+Om/q+GFrgIHZg8BOlmmTJ3dJTrmXmuTItubnGWWtyX4W+wPsztdvQUtIrd2VjCuE7rYGQEx
	pFdyqiG/nYPuGQVIXXg5mlr2mX1s+RfhppQT3QWmd0oSYKIiXxASw5iUsh9l1NQy36LCI16nnpo
	QaWqpz51xqAJ94ftBTfb2GudGF6Zyz+0+uvBr6X2/vr+eAn/Q0s5tBauo8JGMUFJYlcOoiedqb5
	5yNu3uuDRJYxIT5lA==
X-Gm-Gg: ASbGncsn/54gGKsxmz70SmEzAUicMyHmIK5a+M/MzcBrwNNaHuYaVw+Qpnnd8TtYoYB
	mIcTAzAaq98Iw5e5Bz3LWtXatpxRBbyLS0X/jEXWuRQmU8SAt8nYGb5W6xUMYMcS4F9sezhaftv
	3OiJ5KjaP++RvroJ7ZqG+CSO7AndszwUB1eKMAPdoxv5S9C2HBmfKpMFKNkT7PVUGZtM0MuBJeS
	Wkr+zTgYgOYzBNkk5GiYC2/YJ5zPpEFL+S4tHvJsGF7abL4DI6A5b03smUvI7EEsKA/0VZJkXUq
	n9+ugRLK+TAo7AMo5VDTqaXMpxUgHYp4X6ZfIVA3fWUafm8qwl1NrW4GzJLgnHehrlq9IDlXPYB
	wVyWVGrUCxsCR87jvdAjDuRHyes4139otHukmAx5oRxD3vjeiiHgzD/Mhj3j7Wt9XK1g7JBOC0d
	fF
X-Google-Smtp-Source: AGHT+IE3K5aT4ddkEdpQ2fDRFqnrzA9SEPbzfdEe8pZpeFtU6Sv3uynKMF7oP6mkWIT0opioMMHGcwdkeJpJ
X-Received: by 2002:a05:6808:5091:b0:433:ffbd:a2dc with SMTP id 5614622812f47-43597b4f47amr6202196b6e.4.1754891432504;
        Sun, 10 Aug 2025 22:50:32 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-30c13bd9e61sm660266fac.6.2025.08.10.22.50.32
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Aug 2025 22:50:32 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e7ffe84278so851739285a.2
        for <stable@vger.kernel.org>; Sun, 10 Aug 2025 22:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1754891431; x=1755496231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FGXD3kaHwd6Vj5dcpPpaYy6WT0iTxp+nQotnuFSJvo=;
        b=Hu/xsv1lHeaKP0Y/TICX/h21gFB3AHPyTXa/2a552THojLnYaoyz5O+I5zAsAv2t2o
         zVi3EyAIpAUlbDL5vKFhi+TTJUMn69EfwKawAA1UCdSbK8BMrbF0ZN/YgTPQ6UW+DjOW
         6lB2nS1uOufa45S2URM/BECqZRg3ARWqIG9WQ=
X-Received: by 2002:a05:620a:5783:b0:7e8:1718:daf6 with SMTP id af79cd13be357-7e82c6840b7mr1332717585a.15.1754891430941;
        Sun, 10 Aug 2025 22:50:30 -0700 (PDT)
X-Received: by 2002:a05:620a:5783:b0:7e8:1718:daf6 with SMTP id af79cd13be357-7e82c6840b7mr1332714785a.15.1754891430374;
        Sun, 10 Aug 2025 22:50:30 -0700 (PDT)
Received: from shivania.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e8050b6101sm1021477285a.26.2025.08.10.22.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 22:50:29 -0700 (PDT)
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
Subject: [PATCH] uio_hv_generic: Fix another memory leak in error handling  paths
Date: Sun, 10 Aug 2025 22:37:08 -0700
Message-Id: <20250811053708.145381-1-shivani.agarwal@broadcom.com>
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

