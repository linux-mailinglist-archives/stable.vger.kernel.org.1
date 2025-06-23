Return-Path: <stable+bounces-157283-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 356EDAE533D
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:51:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C13044A7759
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE31218AC1;
	Mon, 23 Jun 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2VOI0oQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA22136348;
	Mon, 23 Jun 2025 21:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750715489; cv=none; b=ttB78CUKQyEIYsPdpDERMXX/hkRV/UuVHfNxDdCPeXVmBImy6DTG2kvv/VcUaaxxtTwoU+3OWfzwkECQkExMIj06Z88P6GZilwLM9ANAzg34QqLvr7oP+9psySaNSgQPNQBHzkoRIT99FQC8wfh2bcW91mM8tN93SfwQc/Uh25g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750715489; c=relaxed/simple;
	bh=1kHpPe2h4SXUppzQ7zsBjTgp8cWUA39qJSTbb95RRZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EpUNOwH/q8YGEWm6sxUMsnf2Q1BG6sxnH3wg8PeP0B3wJPuzZiIq92xyite+F6mjj/tDzSI/jdhFNTwgIeb04jZJ0HEVZn0hkd+PZTWcMe7ycApt+c4FRC23a0f+4mo9BiEVaFcWH2G+79dFkBE/FHN0m2EQsM0I5UMKMMjeOTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2VOI0oQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02AF5C4CEED;
	Mon, 23 Jun 2025 21:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750715489;
	bh=1kHpPe2h4SXUppzQ7zsBjTgp8cWUA39qJSTbb95RRZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2VOI0oQ2WlzhSGWZePv58aA9Ypnazv1ewYGpXAuh4kIoBk01Lou2MoxB4/WJ/Xba2
	 AeA0fmp6hTwi/UKXGmEGs6R5UxPbux4J5aMOnIBQsAbOXiqohp1sdEUk8zHa4BrSRr
	 gnbZH1ypNTzMKlUkg04jgv2Bwftul5yRn0TqDbFY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.6 223/290] udmabuf: use sgtable-based scatterlist wrappers
Date: Mon, 23 Jun 2025 15:08:04 +0200
Message-ID: <20250623130633.633165417@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.910356556@linuxfoundation.org>
References: <20250623130626.910356556@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marek Szyprowski <m.szyprowski@samsung.com>

commit afe382843717d44b24ef5014d57dcbaab75a4052 upstream.

Use common wrappers operating directly on the struct sg_table objects to
fix incorrect use of scatterlists sync calls. dma_sync_sg_for_*()
functions have to be called with the number of elements originally passed
to dma_map_sg_*() function, not the one returned in sgtable's nents.

Fixes: 1ffe09590121 ("udmabuf: fix dma-buf cpu access")
CC: stable@vger.kernel.org
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20250507160913.2084079-3-m.szyprowski@samsung.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/dma-buf/udmabuf.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -161,8 +161,7 @@ static int begin_cpu_udmabuf(struct dma_
 			ubuf->sg = NULL;
 		}
 	} else {
-		dma_sync_sg_for_cpu(dev, ubuf->sg->sgl, ubuf->sg->nents,
-				    direction);
+		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
 	}
 
 	return ret;
@@ -177,7 +176,7 @@ static int end_cpu_udmabuf(struct dma_bu
 	if (!ubuf->sg)
 		return -EINVAL;
 
-	dma_sync_sg_for_device(dev, ubuf->sg->sgl, ubuf->sg->nents, direction);
+	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
 	return 0;
 }
 



