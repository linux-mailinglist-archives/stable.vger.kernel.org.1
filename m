Return-Path: <stable+bounces-188917-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC414BFAB34
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 09:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13C0C19C7D40
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 07:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD082FD673;
	Wed, 22 Oct 2025 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hauEEkBz"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE0F2FD68B
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 07:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761119594; cv=none; b=GW5Gb8h5j3EL72+dtBQAW2Z1e6VJ08ABN7VuqoveRwoqdyQbC6PLF4F14sny3uBmAmVUF9vQBpE/0IhQsFIKCvu50nb1EFcffcAXv1M44ZN62TjDOJrUjmdcWKjDyY10bnXoLqdKfVPa/xcgMUqjc6LMC1JNi4KQhGRdGRXByQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761119594; c=relaxed/simple;
	bh=NVEVc5HmVV5+klwi8ZNSMdxU2jEjKAdogelzBxuyRrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m29KjyBepG4PP9wPCfpQUl5M3ieuYugUCHNNMXzWv+FrDI79+LXKxN5zXC4En+n9ghMSrqUOCnqHzbOxlecvVaBy9szzxi19dGAAFjDzC4Du7ErNrejb2FPGE8zZxHt370ux3bhYsM9llVZBxu/LrTz9/Y7w2bmo/0zVHFo87WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hauEEkBz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b3e8f400f79so112829766b.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 00:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1761119589; x=1761724389; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:user-agent:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Np0FoOcxlyI7hVIm/wC5O0j9mybbBaqeBJm2gWQTDc=;
        b=hauEEkBzxnTa3wpwsCdPwAVzzsUAZXPzdCIdcFIa/fzAQvhBLxHE2vWt5u1U5U+G1q
         m/+9PlQtx0rL17YbxvO99eKKwnWbe4MkAGcXPrObSsacJBDxcM2/wqaH5AgqSFDe309P
         rEPomByJg1vG9O+aEzJ8TuiRUfYpl04NIuKDOUW1meKxC6ksQNFok01shDkOT2jb72dv
         kp5lYpJpasSN8n2mKS6x93YmK3fwwzCFM4+q81yRsOYEsPdX5YVlStt1TtxZDaWsJ/Y0
         R5t6b0ru9ATIP95jWQ79QGwr1CGK4j4oBXegpjI9iHReysmme2DSHcanj64Q2xmLdeBX
         cynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761119589; x=1761724389;
        h=content-transfer-encoding:mime-version:list-unsubscribe
         :list-subscribe:list-id:precedence:user-agent:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Np0FoOcxlyI7hVIm/wC5O0j9mybbBaqeBJm2gWQTDc=;
        b=Vq39aj8TQULP9mPMVbHcCBsP6p6quR878YG3r/BXLFxBbTZmKvI7eAO934HNpBmUTc
         jhvc2JuNcGBYpme8180zNUOd5174+KgHxCjGoA73ORxCPLAav3MvA0QN/pcaqHH+Iz1t
         6L7eq/IdGK5toc4NArNyuh0fi37g21/ehuSwm8kLhzEqV69krvTm44yDuzDf+GMyhSW3
         jHCJthJlG3RALahh9/APmPDNuJ13FZv/YI10OngE8dR9FdZouHdq6nvEJhQI6pRyWWWe
         W3wAycPupdUX5Hde2bdqW3u+aORwv19/t52naOg6AVFMMV9zGEa7UTdZ7fTD1swoigCJ
         8uZA==
X-Forwarded-Encrypted: i=1; AJvYcCVcjH4/6zKZ622+zuW7gfHFzvtlaSoZcAhRWX7izbnQ3TtJnv1XQPobmK5e7JdEG2aACkvLfwo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEmavJLC86cFJUDFZDSEoMl/ppTqxPP/pk5WGEKfrblBqGC2/H
	mcpu04P5eSuYteayQzVNg5Q0p6MNjy3iku6A06VtlG9Sj1nMLcQmKhHE7hqe95hWZP4=
X-Gm-Gg: ASbGncu0k9l3BAKq2bmY97uYZSPef/Wr94+3eFTzRYoogDLQBLzf7Zc3vV2t0/7JckM
	SXkqP2onj3iWQ3gn+lEmB7FSDbTkOrIq9ez3JcXwaOhLz1FrCpkYrH0FhLnB9jwJ7iZZUtLtlcF
	IhaUXe4mrmYysXgK55mvgUwBowwTeYAWqGJgOsMdMcxID9mUS4JBTuWq7nTR2QdZjz5PXPTrbBX
	TQa+qtv9fi8De3Gc0tI1oH8ByogQTd/HEoTWNf7ongCwtp8F7denxQ2WkmVnn4BoFi/nvRumZVS
	oka2AuhpHRD8TNryb3Y8sdjOtz6ojCtmP5GObiMMZ6pbsjOlRDDhtSmldORZlyeJEDZYoIYUEXs
	eHPsfrFvWzXO8t44AVk6NFtpBAHxghOikaOKdzRP5oGsbAtwRYb4MTf8ujbfzqOyf50fJ+1vVQ1
	B1Mn/yS0gWaqbTjbKzt7+dqwhBEq7ljrXcmOw=
X-Google-Smtp-Source: AGHT+IFWiu60bAMGJoOFtuBtm/G16Iaqoy90K2ZjhLUjbbNGur2Q4tyDRQlfvomdLboRV0XvpFF8Rg==
X-Received: by 2002:a17:907:6ea3:b0:b65:c8b8:144f with SMTP id a640c23a62f3a-b6c793063bbmr421456866b.6.1761119588933;
        Wed, 22 Oct 2025 00:53:08 -0700 (PDT)
Received: from lb02065.fkb.profitbricks.net ([2001:9e8:146b:cf00:d95c:fb2c:e457:3090])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65eb9523a7sm1291852666b.71.2025.10.22.00.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 00:53:08 -0700 (PDT)
From: Jack Wang <jinpu.wang@ionos.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: axboe@kernel.dk,
	hare@suse.de,
	john.g.garry@oracle.com,
	patches@lists.linux.dev,
	sashal@kernel.org,
	yukuai3@huawei.com
Subject: [PATCH 6.12 111/136] md/raid0: Handle bio_split() errors
Date: Wed, 22 Oct 2025 09:53:07 +0200
Message-ID: <20251021195038.635577649@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251021195035.953989698@linuxfoundation.org>
References: <20251021195035.953989698@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Garry <john.g.garry@oracle.com>

[ Upstream commit 74538fdac3e85aae55eb4ed786478ed2384cb85d ]

Add proper bio_split() error handling. For any error, set bi_status, end
the bio, and return.

Reviewed-by: Yu Kuai <yukuai3@huawei.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>
Link: https://lore.kernel.org/r/20241111112150.3756529-5-john.g.garry@oracle.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: 22f166218f73 ("md: fix mssing blktrace bio split events")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
--- a/drivers/md/raid0.c
+++ b/drivers/md/raid0.c
@@ -464,6 +464,12 @@ static void raid0_handle_discard(struct
 		struct bio *split = bio_split(bio,
 			zone->zone_end - bio->bi_iter.bi_sector, GFP_NOIO,
 			&mddev->bio_set);
+
+		if (IS_ERR(split)) {
+			bio->bi_status = errno_to_blk_status(PTR_ERR(split));
+			bio_endio(bio);
+			return;
+		}

The version of bio_split return NULL or valid pointer, so we need adapt the
check to if (IS_ERR_OR_NULL(split)) for all the 3 commits about Handle
bio_split() errors for md/raidx.

