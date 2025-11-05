Return-Path: <stable+bounces-192501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE06CC35908
	for <lists+stable@lfdr.de>; Wed, 05 Nov 2025 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5DD324E6A58
	for <lists+stable@lfdr.de>; Wed,  5 Nov 2025 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD62EC083;
	Wed,  5 Nov 2025 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gqtNW8eb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AF2309F1B
	for <stable@vger.kernel.org>; Wed,  5 Nov 2025 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762344606; cv=none; b=B/Kj5TUGKIMrn6IbrZbKvyLJTKfL/T2QGvRAhgSlWTudnd+XKN3hI18N0dq45AX96MI+VVxOSvfHW2jL9j7YoGbSoVfXELIl7PR9XwxRb7kEpcbIBiYrH64hBlUDCt6qICu20148JVFyNXNnNzG17GrrxUWtfe1H3+7bmmQ47Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762344606; c=relaxed/simple;
	bh=bnpQGzI4B5hGrp0wTon9oxArxPpXYiU4pYwtlgfUFDI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=k4NS0F5ShVZGh4XZfOHhxiTEmgRJ6+I75JauyAnkTg7MuZXrGlD/S3JLpMiDUF0LNUt/6jRZirf/Mx/lpYdfQtMRBOHHLfRzS7uEmJjl8lj0cCGkCGT0KKTazBD+S2StISr45p5WFTB33avZu0SeN/5CSdaHm8zyJ+vcQRsXEro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gqtNW8eb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47118259fd8so48609025e9.3
        for <stable@vger.kernel.org>; Wed, 05 Nov 2025 04:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762344603; x=1762949403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U3J/NIy5xeeSdfSZQ6BlX/MI3fqUlXs6wtPy1sv0wyk=;
        b=gqtNW8ebBMLON3eE/c3FMlZ84D/x8oUwqgtbYUesTmMBcuKhNXei8NISqsFLKymlvH
         1IAPN9ewiff+PbO2s4xVBBWleS/qgOOkbbkmIpZdNXtQwVschchYi7YZ6E25AaFf8l1V
         RTu+57Ugo3qAs7w8hDJrMcPC8zmfDVgMyFitaPoCtpMe7xMXge+4z9cglMXoj3ZI+M5U
         0+kREgac7OgN4YFz2GfqglAF8NIj7VVtCPt07fiQm7b5g4uYgL94g+OO/JRengeQZjbO
         RDOCpJ99jWFAFOduSCF0na1x/sWkf59eq9Ym6a++n8ptWWPHFPGvFFGGMCAYhhwkTNta
         3Hjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762344603; x=1762949403;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U3J/NIy5xeeSdfSZQ6BlX/MI3fqUlXs6wtPy1sv0wyk=;
        b=GoSZZqgFc7nzpqmJWwPBXl2GwedKJs+Z7TavAMfOL3GoWaSYUtAb/uFMPXOQIVQgGB
         8Ma5kVRUs5xWMLe3nZJX8vtC74b9FEY/+xzhea1C9C/hG5JVUfZ4fYIcdyiDRcpJIxqg
         n9PUvsNKj4AAf1Na7XRdz2ek5jvy1V3V3lgNsNdrQBnRSMwmLeXr3rzRacs5T5AXE7X9
         YfRKMzTcQqIwlw8LYciJfodCqSFWGvgcs8FF/MEuiXVw1F+jzhSpotTXZKYLcOMNZ1rJ
         SR0rDHr9O6aTKfKRTP2cLNZk0Ffkx2N3X3yJP7gt8Ws7rFUqpC9lx7VwhGkQ3QOiD9if
         ZYQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHy9EK7SrguDmxJGgt1AUQ3Y4+k+pw9GUpHSPHmY0UUQOLa3h9lyZU4QukyFkuD64x97I5y+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwiKGWCp4aZQiJKNttWK3aQMCpBekSnvnYP08E4OF0YtZp1x3E
	rAWY6SyH/SZNZXX9zx5FcJeQtIsx5PwXmLWvQBT1JUKf22z+lnd8rIZzgCgg0Q==
X-Gm-Gg: ASbGncvuorDi3BP/KV867/IDGHkuD36DRsYv5S5qCQxuE/ytvU5bKafibQ0vyfxXPrt
	3VEHW8gIHUP8E8eL5RXClLD/e8T+GmUoSL1yVAxBGBaQglec0zacoz6AGoOSm/GVH78XBz56qN5
	wVdH980WSdu7xPd5IFAQ2LtciR/bVm3XpFAKEg8m6oQhERjcg57e0HfRMjkFP12Ejmg/Tpxh/dV
	O0NuzAkuABKTKS/bBDkWG00Cxtzu+tzhigACFy1zODuPqSEBY6qE8a9S+gSeKDk2I2NgXjmp/sO
	jvfannpiZ/SIopIuIaub8+iwaGtb609j3MNlu3NuqD5dz15en55ytPbRtdI7h90qnvllKp0b4Pu
	vHzysbCLTeUjdQmzQr9xyZnJBrFSIL08GSyBufxUltz7Isb/+G4Jab0NrOa07CwsH3VqLZ0TbMM
	GRYt0Hl04aUk9ih0hvaVoVfmgQkYXfK51H1d5y9tLDl34bcWyywR8m2nv8/RIrzmfO4JGU
X-Google-Smtp-Source: AGHT+IEVMkfsi/TMQ5+j0mTFe69wny26XbcL9qotwvAht7k4HyToyOV6jdByqLiw8PySJXwST5xGCA==
X-Received: by 2002:a05:600c:1e1d:b0:477:a9e:859a with SMTP id 5b1f17b1804b1-4775cdf54e7mr25560405e9.22.1762344603073;
        Wed, 05 Nov 2025 04:10:03 -0800 (PST)
Received: from GALAXY.zrh.enclustra.com (xcpe-178-82-9-56.dyn.res.sunrise.net. [178.82.9.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f5f8csm9919165f8f.23.2025.11.05.04.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 04:10:02 -0800 (PST)
From: Ivan Vera <ivanverasantos@gmail.com>
X-Google-Original-From: Ivan Vera <ivan.vera@enclustra.com>
To: git@amd.com
Cc: Ivan Vera <ivan.vera@enclustra.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvmem: zynqmp_nvmem: fix DMA buffer size
Date: Wed,  5 Nov 2025 13:09:58 +0100
Message-Id: <20251105120958.16266-1-ivan.vera@enclustra.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The efuse data buffer was allocated/freed with sizeof(bytes) instead of
the requested length, resulting in an undersized DMA buffer and possible
memory corruption. Allocate and free using the actual 'bytes' length.

Fixes: 737c0c8d07b5 ("nvmem: zynqmp_nvmem: Add support to access efuse")
Cc: stable@vger.kernel.org

Signed-off-by: Ivan Vera <ivan.vera@enclustra.com>
---
 drivers/nvmem/zynqmp_nvmem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/zynqmp_nvmem.c b/drivers/nvmem/zynqmp_nvmem.c
index 7da717d6c7fa..d909c8da747e 100644
--- a/drivers/nvmem/zynqmp_nvmem.c
+++ b/drivers/nvmem/zynqmp_nvmem.c
@@ -100,7 +100,7 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	if (!efuse)
 		return -ENOMEM;
 
-	data = dma_alloc_coherent(dev, sizeof(bytes),
+	data = dma_alloc_coherent(dev, bytes,
 				  &dma_buf, GFP_KERNEL);
 	if (!data) {
 		ret = -ENOMEM;
@@ -134,7 +134,7 @@ static int zynqmp_efuse_access(void *context, unsigned int offset,
 	if (flag == EFUSE_READ)
 		memcpy(val, data, bytes);
 efuse_access_err:
-	dma_free_coherent(dev, sizeof(bytes),
+	dma_free_coherent(dev, bytes,
 			  data, dma_buf);
 efuse_data_fail:
 	dma_free_coherent(dev, sizeof(struct xilinx_efuse),
-- 
2.25.1


