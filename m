Return-Path: <stable+bounces-112266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DBD0A281D1
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 03:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAA0B3A37D8
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 02:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E6B211A10;
	Wed,  5 Feb 2025 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzHApj+L"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89957200A3;
	Wed,  5 Feb 2025 02:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738722709; cv=none; b=NRdZekCctJvRbcGph+QQx4Jx/cZw+B+THJiSdVfrRWJTp2crW+YBmrGCri99Awm7OHkE2m0hjt6Ef8L/27cinvi0OEdJoEico46TbK7n39svy7MCUTyrUeK4YaNaDroHcZkSyhDBJQdECeCDSKks/TrXqDR2RJtB8q4G0syM4wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738722709; c=relaxed/simple;
	bh=6FhjmrY29YgOj5ORMTKfXimWuMq2SCPv6geZKtdHuB4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Up2lfxpIWtYfHd/XIgITPL4Z4seLbj/vp/NW/VDYyBnsSvoA+wFNxeLb7UuFfYafL7/RQj0MoZeCvtegO7w1W32Jfg3QPGph0etUAnbCHdGc8QtuCGC5F6Z5u2+iEng3h6k4HpCs+aAaPCEY6lU8BBzEzNBGOXvTj7U/5sd/aNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzHApj+L; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6d8f75b31bfso51399826d6.3;
        Tue, 04 Feb 2025 18:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738722706; x=1739327506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q0nndVOelB0GZZn73pGujC/UiwJRPbAJWARFJMrXRho=;
        b=PzHApj+Likha2yaGhOS5ZJMCTCLZKPG68I9opq2Sc4YU2Jc7ejA+RUnoGmsNhDkx3m
         7e4qpEyxQCt5BNeu/Kc2WFW5qQUtEdx1ZcFhPg0hkRniaKyYTYEyvxQrhHPvzCZT1lSW
         rqj80UUbq0MmGidPVDWxIrZKmCnSQrOB8xWYfTJZ12uVwDoe/yLXj/b5nLsqPoCCLHK0
         mXUzTgZ+5b34omNpzqNyx67n9+YjtAcZLQqw2LvgVFTilA6jt42kPiaApGZUUvd/eiAc
         uR+XBOZrLHoNjTW+CS9lUVNF+30/+Li6r5xRCML0CiVJo3RgxbuSUybAdDSnpJFg8fLd
         1VrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738722706; x=1739327506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q0nndVOelB0GZZn73pGujC/UiwJRPbAJWARFJMrXRho=;
        b=ikQgs+84R0FJF5kk8SapupKsvh8YhRwEd2uXYvJiC5yf5nqsGfyY0iwsp3uqpP2Jl4
         grXEb2gAvD16aFFm/W55d5VVsFrHtOMnDO1zjR2W0xxRiF78Qlr/iYEWQ96v6b/fTyMF
         hAQ11iYpUbQxl0A4Y45x1Q808mKMxFkVvuAb2gcKohk3AQNjMHt4AxeqUGUV03NhFd82
         qncyOgO51a2FIcJtUxFQP/uZOhOTcaqYvJezKa/Wrv8isy5dL+l6SWa4cnZOLphvBYMC
         cVXH/DfYMFuZoq2ik5+XMotdGLwyFG0js9+LslyXRMHolbCBckJajNAsjdL7E/fl2sjO
         DT5g==
X-Forwarded-Encrypted: i=1; AJvYcCVhitf9AooKoBOTCue9lBK8dYft9Lg186kkqt1/ZD1H9bR8GQkh9kwOkE42MMDmYRBGKjbPu+3t@vger.kernel.org, AJvYcCX5IlDTmRgDBdomtjs/FonY2T3q9I/FliZ0xsYf03/nEdqPgH+oEFOANSVILLogNL7lhVCBo5N7hkdupJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPOM1YCbR13qN/Q0gc5IX85PYxJbg+g+WDDdQ37QKjDTWt/vpo
	bVwOWND5Clmuw484Vz+D0uTbNbA47fagm13IFkqGm6mud5ksPLOX
X-Gm-Gg: ASbGncsGNLHhyEQjx65MiV22UkWwKNwLAAk3n3CcygiQn0QCPrt7O33cQctaWnjrNVn
	+RCIkM9VJGAe8R0uCWhoaPHNNLO0c9ERzi6ukRtIRu6VyAqcmiBMVC4xBUF3KGQj63FagK2kMhq
	KmtgAPlrvJOO6PAP+ERH09brI2AEIg3fxb4QKYUCDU4sTGYpoMG3pzdD4SpEF0lK01gOclmhOQi
	dwewQbJApGjvOh5iOiAfq4cR2U8zy5xrQZbFXAaUDrb/RumMhBK0ffE5h1cYoXGeib/xyCrItnr
	8FeRb7bIRTSB+wkVDP6VvKo20VJGqfd57+Mq5w==
X-Google-Smtp-Source: AGHT+IFS+kn2ZGB2pFJiLdc5JmZU8Ll8iIHRaRz39Sw1icfJkjZHfXf8rJhLmct3iVykW6xS2xt6kA==
X-Received: by 2002:ad4:5f45:0:b0:6e2:4911:cd8a with SMTP id 6a1803df08f44-6e42fbef337mr17367796d6.26.1738722706299;
        Tue, 04 Feb 2025 18:31:46 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e25492254esm68579306d6.90.2025.02.04.18.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 18:31:46 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: christophe.jaillet@wanadoo.fr
Cc: gmpy.liaowx@gmail.com,
	jiashengjiangcool@gmail.com,
	jirislaby@kernel.org,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	stable@vger.kernel.org,
	vigneshr@ti.com
Subject: [PATCH v3 2/2] mtd: Add check for devm_kcalloc()
Date: Wed,  5 Feb 2025 02:31:41 +0000
Message-Id: <20250205023141.26195-2-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205023141.26195-1-jiashengjiangcool@gmail.com>
References: <f9a35a4f-b774-4480-910a-cdcf926df41b@wanadoo.fr>
 <20250205023141.26195-1-jiashengjiangcool@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a check for devm_kcalloc() to ensure successful allocation.

Fixes: 78c08247b9d3 ("mtd: Support kmsg dumper based on pstore/blk")
Cc: <stable@vger.kernel.org> # v5.10+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v2 -> v3:

1. No change.

v1 -> v2:

1. No change.
---
 drivers/mtd/mtdpstore.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mtd/mtdpstore.c b/drivers/mtd/mtdpstore.c
index 2d004d41cf75..9cf3872e37ae 100644
--- a/drivers/mtd/mtdpstore.c
+++ b/drivers/mtd/mtdpstore.c
@@ -423,6 +423,9 @@ static void mtdpstore_notify_add(struct mtd_info *mtd)
 	longcnt = BITS_TO_LONGS(div_u64(mtd->size, mtd->erasesize));
 	cxt->badmap = devm_kcalloc(&mtd->dev, longcnt, sizeof(long), GFP_KERNEL);
 
+	if (!cxt->rmmap || !cxt->usedmap || !cxt->badmap)
+		return;
+
 	/* just support dmesg right now */
 	cxt->dev.flags = PSTORE_FLAGS_DMESG;
 	cxt->dev.zone.read = mtdpstore_read;
-- 
2.25.1


