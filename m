Return-Path: <stable+bounces-191398-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 90363C132EB
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 07:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3B7C1351145
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 06:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAF2BE622;
	Tue, 28 Oct 2025 06:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WAhKlf00"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D56248881
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 06:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761633379; cv=none; b=kisXL+BQbpvpriwglL7Hg1pIr1C4mfuOy5fPRZ9PkbNpz9j2ZQmrn5zNAxJqeecW8/aDIKn4vg+R5ZyHmLOZ/Fe1wOyDSWiYoryXG9H9PHf7Ev3j9b7Ciw2JKT26hLlRZgpiMF4zSVbTcpFAeXApYAllMp8bKQ4gqdSXbBWrx8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761633379; c=relaxed/simple;
	bh=fIpLWlJZgNMVBNwv1Qi28QT9txbaMkE9WZofpeGLL44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rERM2QCCXn4iBwIh9InmisZAFy+bPWY9ZODH5OAGExkgnlXLi4KDI/kQ5CvLMD/Lrs8PfBk0z0xmuX8qIeo195D32WdzYGMMzHPIujimySoi9+dQhiut5n2RuLBLwZe9Reox/SHodp1ZThfO8dJQjv/kAdmy/2hCJYL6G2RTGiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WAhKlf00; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-26a0a694ea8so39758175ad.3
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761633376; x=1762238176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eHCzvaSzIfjxLqqlWg+9YqHl2rYFybHFRYREuApfQng=;
        b=WAhKlf00a90QiFnzImHQoIkAhc/wIBuKyFnC+lMM7EJQCTvPL0dl0HgQFGOkKK7Fmd
         uZhtkcbluoVSwgY4e94hV6pHV1Aho+4N2UO7FISgTHfulzAAFodsDwrimwjOJf+IgHzH
         1Sd2r/GHtRzDd+d67OMlPwh6fhMdVsCOQB5OXz83jUrx/o8/1lF1vV8IO2ud7hwerZ/l
         ETybXYi9ptdRtqHkcCsQ8gyx+wDMVEj7nxSe/W8ruSSqAd7V+EyDqVv3jzf8oumfXThf
         vVE2vcvlALANA8gvgyuUlENZYUxCUWslRgIJTFFMtX18FEEQuaW0zbESvaUqysTy3+v3
         jQtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761633376; x=1762238176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eHCzvaSzIfjxLqqlWg+9YqHl2rYFybHFRYREuApfQng=;
        b=QE2IUYRnXd5F6gc8Uu1f/793xPdvHW/pbbC8ks8FCALxm2Z42MozY0dlZAsO6xVYKw
         lo0AS6/+6Lw4M+UKMskeGI3WPGnNCuuLdKeo3VM19Uiv4efioVGFn2CRFBGMiPp+8KYG
         YU4xiGIvMQ7S7HELYtz8KmTJT0s3MWJo3qISk33cGfDAfeNs1e+k1z5aQrE4414Zgd6e
         4FWyidSF1RFkfh5TgrRh08S4hDDBzc5R8Fmwt+L40oLI0UGbWSY1hnbWg0+EeL+jlc+B
         DphfYjFWY0HXfSBSsagVkmcPrPCURLO6qRXwqyXGE3EXxe7ZkgOOe2nV9jnZLBCf6ada
         D23Q==
X-Forwarded-Encrypted: i=1; AJvYcCV/WLPexpvHTRYVWaMMF/KQZ0obe2a2zcWCFzIKINNPz70rJOOqKnuZjxAnDpr/BWPsiiALdQw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoCorYjwyq7mlmZB2mRn14bcmeszaOYl7f7LW16cRqzV+G4qrm
	0tx1/ihXysx81Hdcz9kZeGMD78DJ7bchj+cKvllYjEZU63nsXRBBvVU8
X-Gm-Gg: ASbGncuh9h5PSB90d8HyevZ8unP5nauioQOrVIVd6wVo5JsLKgcfNYl5LdPqaHbrbqb
	lPsevygLnUhKBYN1dy2DJP55FbowmcQPRuGW8lcsExzdEhDi7QCjpJUq8BEwHSvL9lEx5FFCj7B
	vqBJx9AjbVXC2dx3AoV8REhKs5j/oMCqkVodUWKWsOHqY8uxzWGEloN1LpCTGHS05Hn8+aji/5B
	jcYBm0R/EC8gJT6nKWL10hfD+Ycut3ce66lrUxbS6+VxxOhoGO+Hi5iYo9UPDgSBuoRpLrW/2+5
	naN83FA+nPGZ6FHV8QTuNB4krdUYZKYBHGnJyR0q9a6mUa4uqRED8cww6KVTu6CICaWB1aWRGgG
	5zXXelrkjwdhBwB5nK1PHM30r48645gKn2xI5pdnE/Q2aqr+ei795RP0jfiSYU22Hbi501MQrdm
	ETJfQK42z22sW/DinBQqDFZQ==
X-Google-Smtp-Source: AGHT+IH2v3C/umCB14OlrxNqF3tzlUkDCN89YW3HVw9JkHJXqPm2mOQ48IiDSJJGHTDX9O7MPiIkwg==
X-Received: by 2002:a17:903:b50:b0:264:a34c:c6d with SMTP id d9443c01a7336-294cb3ecbc3mr28327115ad.37.1761633375933;
        Mon, 27 Oct 2025 23:36:15 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498cf4a53sm105914585ad.6.2025.10.27.23.36.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 23:36:15 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Thierry Reding <treding@nvidia.com>,
	Rob Herring <robh@kernel.org>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iommu/of: Fix device node reference leak in of_iommu_get_resv_regions
Date: Tue, 28 Oct 2025 14:36:01 +0800
Message-Id: <20251028063601.71934-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In of_iommu_get_resv_regions(), of_find_node_by_phandle() returns a device
node with its reference count incremented. The caller is responsible for
releasing this reference when the node is no longer needed.

Add a call to of_node_put() to release the reference after the usage.

Found via static analysis.

Fixes: a5bf3cfce8cb ("iommu: Implement of_iommu_get_resv_regions()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iommu/of_iommu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 6b989a62def2..02448da8ff90 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -256,6 +256,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				maps = of_translate_dma_region(np, maps, &iova, &length);
 				if (length == 0) {
 					dev_warn(dev, "Cannot reserve IOVA region of 0 size\n");
+					of_node_put(np);
 					continue;
 				}
 				type = iommu_resv_region_get_type(dev, &phys, iova, length);
@@ -265,6 +266,7 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 				if (region)
 					list_add_tail(&region->list, list);
 			}
+			of_node_put(np);
 		}
 	}
 #endif
-- 
2.39.5 (Apple Git-154)


