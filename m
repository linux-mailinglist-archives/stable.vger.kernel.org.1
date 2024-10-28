Return-Path: <stable+bounces-89100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F99B374E
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FFB7282FBF
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 17:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C941DF272;
	Mon, 28 Oct 2024 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPgLNOyB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A538C1DCB30;
	Mon, 28 Oct 2024 17:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730135154; cv=none; b=e3elS/4fPRh5ErXiqfc5JoWHXaPgnXkHhW4uC7oMnf36ske/AHsBTdS+NbG6bh2h+6Uybn0KNayPQvmXvqM+KcF3JYbJZTS9fTCzd+p7qqtbYotLR7zvGeOe6s2oNKAP7Mh7XoFNL+B2R3jhZJohqcVirqAw9P0NELyCHX3EiOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730135154; c=relaxed/simple;
	bh=g0vUX0QJEXTiwH4iay17IWpe6yFetg3wdKQpdeXvrW8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aGN5EPJTeVFr2UZKkaxAT4zaTLZiL+ZOIIRGYaUs6ftunnxnAfbCcm7mTDGzBDVgYWUc/Qn9luBNBT1S2X+ehORIR9oOF+PmQcpT7tr3yh5G6Z8nCeQzb+iQYnXGv25d9RrYhu6GF8MaVxFC7ctUQx7uLBv6oyR/KmBhMCKBk58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPgLNOyB; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-37d47b38336so3271419f8f.3;
        Mon, 28 Oct 2024 10:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730135151; x=1730739951; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e/2O1z708SYqPEIp80B98dBw9e50ciXre81ne18sB0g=;
        b=kPgLNOyBxKp8JfBNBGPQdRhQhJDohw2GaODvyjC1U5lcxj7IoCTyV6WNTaAFrpPav6
         sVd3lRMk5Ii85/FzShnPSBLeRXwGJW3fhKA6+RzKf+hu03cJO/S6LaCizHi9Yaa35vP0
         xdySrm3+KsBBDmibbna/Aw2Yfa/UQkZR4NNHWKDO6aMu0WAQCy2routDHogP+W++ibQB
         1yhSVsrNGN+0CyT1sF2TNNxonx+HewlopEOtcc3O3xrta45Wgom/3OJF32rHn20ZRDD8
         yDJ6UKW4iMs02IHeQJM2oIiZ3W+sRzIE4wLqUxNC4Apkd+MI0OP87mNpFs08m2sOdQhH
         wALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730135151; x=1730739951;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e/2O1z708SYqPEIp80B98dBw9e50ciXre81ne18sB0g=;
        b=dDL33cVCPoscVzqKXtz7z1eNI+AO4fW04s0CxPIk5VeblLagi3VvjB7zdedL5w/KYJ
         9wXuo6NZOwtSsttPAxPRXV9qsQewahhqylHmnKX7VSfuuS+n7493jrcv454pUff3v7pK
         dClKetqA4+iohZAeUxkJU9LyhqmPdYEer4mYBSbuGYRjPe8Mxv47U6n17OOPok2Yftlm
         qPQvAP0k8N5tMTySvJhvO7RXHxPs10u2O2WAeaJDLVP7b6yBjGoKLnhdxPnd0t4tsiKW
         DDBjKyvh3shHecvPNXEtpAChOZ496XXDjCpL5M4YCTDhqSvEzI1p02T/SiSq4i5O2P6O
         tSYA==
X-Forwarded-Encrypted: i=1; AJvYcCVWXIICY0OG/jaTdWKNc/DZOKaHkoXX4enMrpNTlabaB/ZT8lmVgSUl6RUGvtZBX0l7+4yd+fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXvMxr7IsK0cBSi2x0PsQINYwPK8KAlkfxvDpne0Mm7DKpHenS
	GC3FSw5r5wKJCJEZYl88cQHBkc3BiX7B1siVf4vgMMJKuRz3CBHmc+/clQ==
X-Google-Smtp-Source: AGHT+IF2hPgak3K9piqNnHXHCFdV74LdDXHY4auy1drZsVwmwbUgY9kTo1OFunnD400KgkN9FoXl1A==
X-Received: by 2002:a5d:6192:0:b0:37d:4956:b0b4 with SMTP id ffacd0b85a97d-3806122fc7emr7285952f8f.59.1730135150768;
        Mon, 28 Oct 2024 10:05:50 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-b273-88b2-f83b-5936.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:b273:88b2:f83b:5936])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b3be78sm10097655f8f.31.2024.10.28.10.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:05:50 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Mon, 28 Oct 2024 18:05:41 +0100
Subject: [PATCH 1/2] virt: fsl: fix missing of_node_put() on early exit
 from for_each_compatible_node()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-fsl_hypervisor-of_node_put-v1-1-dd0621341fb7@gmail.com>
References: <20241028-fsl_hypervisor-of_node_put-v1-0-dd0621341fb7@gmail.com>
In-Reply-To: <20241028-fsl_hypervisor-of_node_put-v1-0-dd0621341fb7@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, Timur Tabi <timur@freescale.com>, 
 Kumar Gala <galak@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730135148; l=1004;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=g0vUX0QJEXTiwH4iay17IWpe6yFetg3wdKQpdeXvrW8=;
 b=9tvQbnMucwyiReUbapTwMoxy633yJUDMChbcMUo9ThaTTFcQBgZrlCtDrSTB7tiukDmIoJ4fn
 l8NypN5FGMuDhUbX8dhSCVNjESA61CmLijHwhhHXOrFHUEW+Q6Lvvbz
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Early exits from for_each_compatible_node() require explicit calls to
of_node_put() to release the node and avoid leaking the resource. Add
the missing call to of_node_put(np) before the 'goto' instruction that
jumps out of the loop.

Cc: stable@vger.kernel.org
Fixes: 6db7199407ca ("drivers/virt: introduce Freescale hypervisor management driver")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/virt/fsl_hypervisor.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/virt/fsl_hypervisor.c b/drivers/virt/fsl_hypervisor.c
index e92e2ceb12a4..7c7ec13761ba 100644
--- a/drivers/virt/fsl_hypervisor.c
+++ b/drivers/virt/fsl_hypervisor.c
@@ -846,8 +846,10 @@ static int __init fsl_hypervisor_init(void)
 		}
 
 		dbisr = kzalloc(sizeof(*dbisr), GFP_KERNEL);
-		if (!dbisr)
+		if (!dbisr) {
+			of_node_put(np);
 			goto out_of_memory;
+		}
 
 		dbisr->irq = irq;
 		dbisr->doorbell = be32_to_cpup(handle);

-- 
2.43.0


