Return-Path: <stable+bounces-134604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF41BA93A07
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373231B61D7F
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A706021422F;
	Fri, 18 Apr 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgHG9w7F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68789213E6A
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990963; cv=none; b=sx8m3XqaywMppyYIn0toYsnwa0Da5aRQj/ijl9PaWBd+p0mzl8OZkWoBtjm34Mpx4Nr/3bRLj+UWQV4yh7TQPEjMfZY3NfIfFkLtn2FnLLh/Ysp36JrXoCiX/ylbvEJh6HloTkNwkVwGvcZjjtZ6rA+O/PZYOy/53Dy261RaqB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990963; c=relaxed/simple;
	bh=5PwageeQWgPeg/apVSHHYFj+zBnAUZz52a5YGKU5Npw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SgC7nB9qio2y990w08xiW7RiyeSAXvZyN7LemOlM+GIOKY+DWDZH+k0gSoyUwCK3ExJPf5DzoSZ4lU6YRzOVb2rGUIb2D+YzcDz/NFSfchZE2t+TqaaCncUdakS2pMZLBvXIXt1r6hvmkN09OkQr5KdauerWKVK0Zl2zpXoTHOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgHG9w7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2FBC4CEEA;
	Fri, 18 Apr 2025 15:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990963;
	bh=5PwageeQWgPeg/apVSHHYFj+zBnAUZz52a5YGKU5Npw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hgHG9w7FD3ovV1HCArEgFd6+zjkdD6ASj83whXrp8P3stnhTWYWTuaFZGWpH8ZI2l
	 84X0Mf38XWmu4zyckFGRxCHj2WI7vtVso57WzF+NPUodH2SjPIus1J6x+J/qR++BU5
	 p2Snk7bnaeP0DKIc2FbpwuRbxv0w9pBeS/d+YphkktXyUCezM/j1NE8eZ0vMmBddA/
	 Jng916B0tTqjUAUjm5P4h42+6RLRIf4rK8biHl2Mva1T8gScc+u/6mVCjayIdc4VwP
	 1csSgn6J6ixArbZ3t51sfJAtYy6g/A1vXLJVJt/u7OypGgCqIUcInFN3d9EjBwAvGQ
	 LdlO0MOhst1qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.l.liu@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] iommufd: Fail replace if device has not been attached
Date: Fri, 18 Apr 2025 11:42:41 -0400
Message-Id: <20250418085713-b332a9a897f871ef@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417134743.205380-1-yi.l.liu@intel.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 55c85fa7579dc2e3f5399ef5bad67a44257c1a48

Status in newer kernel trees:
6.14.y | Not found
6.13.y | Not found

Note: The patch differs from the upstream commit:
---
1:  55c85fa7579dc ! 1:  5c6d205c63555 iommufd: Fail replace if device has not been attached
    @@ Commit message
         Reviewed-by: Kevin Tian <kevin.tian@intel.com>
         Signed-off-by: Yi Liu <yi.l.liu@intel.com>
         Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
    +    (cherry picked from commit 55c85fa7579dc2e3f5399ef5bad67a44257c1a48)
    +    Signed-off-by: Yi Liu <yi.l.liu@intel.com>
     
      ## drivers/iommu/iommufd/device.c ##
     @@ drivers/iommu/iommufd/device.c: iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
    + 	return 0;
    + }
      
    - /* The device attach/detach/replace helpers for attach_handle */
    - 
    ++/* The device attach/detach/replace helpers for attach_handle */
    ++
     +/* Check if idev is attached to igroup->hwpt */
     +static bool iommufd_device_is_attached(struct iommufd_device *idev)
     +{
    @@ drivers/iommu/iommufd/device.c: iommufd_device_attach_reserved_iova(struct iommu
     +	return false;
     +}
     +
    - static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
    - 				      struct iommufd_device *idev)
    + int iommufd_hw_pagetable_attach(struct iommufd_hw_pagetable *hwpt,
    + 				struct iommufd_device *idev)
      {
     @@ drivers/iommu/iommufd/device.c: iommufd_device_do_replace(struct iommufd_device *idev,
      		goto err_unlock;
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

