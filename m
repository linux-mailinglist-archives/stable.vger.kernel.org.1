Return-Path: <stable+bounces-119606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8144A453B8
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 04:09:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD0B316CB6B
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 03:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2679225405;
	Wed, 26 Feb 2025 03:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gj8Gh0iL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060DC18A6A6;
	Wed, 26 Feb 2025 03:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539378; cv=none; b=oXfS+CoJrlaVHwd2KqCrY/kEQq6IV/P5DRua5sSwZ1vjZQmdkI7nHbsF5jex6zVSZvCh1imqyGRxEhdxr4DlOcI2MKTaWkgBZ9/bgxAFY6D3pBkfnyxtmu6+Fm8c6hYwtK1pEdkjX3W7yGyKuv2oz0ksjfzoH/oyY8wT6VvUgSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539378; c=relaxed/simple;
	bh=3cFHXH3/oJVY2LF35AS3JhelpUSBST3QH3X63TIStX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EMZtdaVm5E8gLFWNYnPgqT+SQjnMb+8I4mFh1KmEAa1PYVHYLM5NIDZWZnddmLjZW1+k4w80VRVLG1q60D6Uk6EeeczSMUU5J+z/CLhDfTLtvMGm/J3VY3DW6CUJjE8icAv2wpkk3F5v7nYFhl6s4wQxlXm1SAayqDLKRy6fitU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gj8Gh0iL; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6fcd8090fe7so33501867b3.2;
        Tue, 25 Feb 2025 19:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740539376; x=1741144176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IyZj4C9K1d8odw/tqUKy0+IlH8OYCthaQSH+++9eU+4=;
        b=gj8Gh0iLfyF4BAxHZZTkmF1keGrYIa8Ddug6NhPlJV3uiFOsIgPR2t4J8tYek2YQIA
         cYptWRniZNqp+xW+6QCcysDO1H2EbqQzGE5cQM3Wij6JOgqYk/SAPU99vlWmUESs+ShH
         oAJ+XroHxF0siOI1yL/C0XdgpWNSLVQ9Xcc17JXTLHQD4ZCP3ROrceRJ40mgOfZs/lcE
         cSexnxU4qpfzySf20Un03LpWpu61Cgugq5HQJgs3ZS3gebmsSkPOn6qrJUgq4KIBFrUW
         Lba9lgVMWVg0FbVnzPCTe4am14D2eh2DdLH70X4TuvhhneMCCyv05eEutFEvkXcbi/Db
         q2yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740539376; x=1741144176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IyZj4C9K1d8odw/tqUKy0+IlH8OYCthaQSH+++9eU+4=;
        b=tXjkuVmttnDfOx0hrymnMPFtGKuEY2UzGssEYxM58IfevNFObffxtoTNwjc4iAPRXb
         nP+MN8Z58m6oRXvu0X8eVStTyomYO1OvY4bDryeInyVkFbaeKEJhloiAuK3m4dTVrBx6
         8zHLagVdq/ep1UFyOW/qpqXxfxoijEk5jN/F1iyAx2y+tLDUJDdkp/bOmZU7s1R26gcO
         ++/jVWrr6//3eDuCB6aG6W9lyg0mCz7c5TGQpFMdJveX0LZxitIQpxNEZ2yydA7dSqRC
         uQgxEfOiVptZeMCZkAsWhzLpABSGaD0z1RAmxsFnqwd5IgyVY22on/s56CPa/roYPhMn
         aGkA==
X-Forwarded-Encrypted: i=1; AJvYcCU+gxCKxFoiibZRXOvBbfPn7kQb8oEXMr4MclZjs4JmfH6BWX+MXbjqiQoJBDFh1RarbpAZ0O+Q4AOM6D4=@vger.kernel.org, AJvYcCUJ7z5bqSeE/770e20/0V/aJJDLyzWYAaym1asQOlOL9xrnks+xLyMou+zitzrc0Cuj2OLV/QHz@vger.kernel.org, AJvYcCX94dlEXA7g0avlkgrruNhoKasx1mrDwtlqAw8B9Oze+8HVQ/b/g1E6CJyUOQBuq2lGfprZNM7f@vger.kernel.org
X-Gm-Message-State: AOJu0YzY2fUvhL+r7GnsEfgJbuuzqN25LmfBw1QAUxGFbzzD3GHNW0Lg
	S3oYazT1kmPZqL2oL5/bc3+OBG7VhWrqpfNlDV8n/fmrHYpI8mK3UnTXPQ==
X-Gm-Gg: ASbGncvfgoCiGVZ1H3jxKaHSRVzEVvCnxNWZmNsm4OzTa605kFhiiZx511EuE1SwtI3
	RtpU8chUr3GqeRwej4LlRrzFD9zSlZNwR6a70iJ409kMp/kO63PFe7Tep5lHD76Z1G+hF26Uskm
	Bmrk2YWG1TH024nfAo6zcKs+4ap/wmyIUXvvCyU+CFw9wfqkUItlx2djUpHfoyOpRJi8zYFgkC6
	STisfx4Zv5jd2YfxhT4PonOO8bdlkLzZNzV+txPaYvvyyxK52ldn9nukDayLexYpH14hMrXDBjc
	mWpMaVt1MQMLh40qpK2GHvSfiDRLiHVtI9pMgp04qoLm49Sk
X-Google-Smtp-Source: AGHT+IFFKcNLWVfI7M4avlepQKeUTdEOtQy14361siRLOko8JW4UoQuFMSAmlw/9Dggv5KZGXJ9H2w==
X-Received: by 2002:a05:690c:3803:b0:6ef:48ac:9d21 with SMTP id 00721157ae682-6fd10ae9ec2mr48590927b3.24.1740539374446;
        Tue, 25 Feb 2025 19:09:34 -0800 (PST)
Received: from newman.cs.purdue.edu ([128.10.127.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd2cf2f01csm449317b3.103.2025.02.25.19.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 19:09:34 -0800 (PST)
From: Jiasheng Jiang <jiashengjiangcool@gmail.com>
To: jiri@resnulli.us
Cc: arkadiusz.kubalewski@intel.com,
	davem@davemloft.net,
	jan.glaza@intel.com,
	jiashengjiangcool@gmail.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	vadim.fedorenko@linux.dev
Subject: [PATCH v2] dpll: Add an assertion to check freq_supported_num
Date: Wed, 26 Feb 2025 03:09:30 +0000
Message-Id: <20250226030930.20574-1-jiashengjiangcool@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <txrxpe7tmpsyiu4cwjd2gbs3udogmzdo5ertjwmhbeynu23iep@dcryfdoi7o5x>
References: <txrxpe7tmpsyiu4cwjd2gbs3udogmzdo5ertjwmhbeynu23iep@dcryfdoi7o5x>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since the driver is broken in the case that src->freq_supported is not
NULL but src->freq_supported_num is 0, add an assertion for it.

Fixes: 830ead5fb0c5 ("dpll: fix pin dump crash for rebound module")
Cc: <stable@vger.kernel.org> # v6.8+
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
---
Changelog:

v1 -> v2:

1. Replace the check with an assertion.
---
 drivers/dpll/dpll_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 32019dc33cca..3296776c1ebb 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -443,8 +443,9 @@ static void dpll_pin_prop_free(struct dpll_pin_properties *prop)
 static int dpll_pin_prop_dup(const struct dpll_pin_properties *src,
 			     struct dpll_pin_properties *dst)
 {
+	BUG_ON(src->freq_supported && !src->freq_supported_num);
 	memcpy(dst, src, sizeof(*dst));
-	if (src->freq_supported && src->freq_supported_num) {
+	if (src->freq_supported) {
 		size_t freq_size = src->freq_supported_num *
 				   sizeof(*src->freq_supported);
 		dst->freq_supported = kmemdup(src->freq_supported,
-- 
2.25.1


