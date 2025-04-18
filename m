Return-Path: <stable+bounces-134606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B68A93A08
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90CA016A752
	for <lists+stable@lfdr.de>; Fri, 18 Apr 2025 15:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F40F213E89;
	Fri, 18 Apr 2025 15:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0D9uFky"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B01DE88C
	for <stable@vger.kernel.org>; Fri, 18 Apr 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744990968; cv=none; b=BepTqDB0Z6Mia51QvHnVelx9u+06+iHnCewDDv13uxUj19/2/m/c2XT8Yodr4U1AaEI9eK4m2f3j4O7Yq+12SDGyYcXsOwyGy8yp6zDilyD2h08GGvFGI6JAKIKWQY37hjhUNBguKSEGgdlb9OU4xIA3RO82NQLMMc4sSNj7mSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744990968; c=relaxed/simple;
	bh=FpceXmI0JUswJVRF+Km6qZ3cqqEn4rL9HiN0Noz/Qkw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rImmGyC/NgkqHP8BW+5Ec6IbtePPUctAKmSQa2b5VAXADDR/6mHM7XQiVKBOooWznhdQum24L2O+PFgZ5PDhJeIHqX5dbXB1wWqaOoMUU82NH5gEZIJQUdTDpqWtTdA+wgvXhnNHDfo998eCohV/hfEqfU4RTgmnf5K0K8Fv0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0D9uFky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCFFC4CEE2;
	Fri, 18 Apr 2025 15:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744990967;
	bh=FpceXmI0JUswJVRF+Km6qZ3cqqEn4rL9HiN0Noz/Qkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0D9uFky1npaX1DH6fjWEVPUubmgAd1LfafbVI9zk356zJ3D0/2zDa6s15yYulR7t
	 LEigM5ex5kQdBd1BRLQeCmdqgt7N9T/QbrP1l6ogvgiun4nf9CQqTPl6BymRRxIpHf
	 tnMBJftXzJb+UYEi2u54DWw928QcMgCcUBdPIpM3HeSVTcGNKmjpmSij+SUb/RAbDL
	 YihCFUd6FRGm5Eh2Aw3NkKJ5yEpSzG4FWeOeAE3NGwvPzH/H+rfjsbUjwXiAXgS7nT
	 4uY5feTZon6el3hQEVgSCt58x98WrRDHHZJfrAgU4Hyj26Jm4OIKK1zpYo8q8wI4ZQ
	 dJW/bDHBpCcig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	yi.l.liu@intel.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] iommufd: Fail replace if device has not been attached
Date: Fri, 18 Apr 2025 11:42:46 -0400
Message-Id: <20250418083103-cbb127cf0ae9bcbf@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250417133638.115407-1-yi.l.liu@intel.com>
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
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  55c85fa7579dc ! 1:  8310b5beec2ea iommufd: Fail replace if device has not been attached
    @@ Commit message
         Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
     
      ## drivers/iommu/iommufd/device.c ##
    -@@ drivers/iommu/iommufd/device.c: iommufd_device_attach_reserved_iova(struct iommufd_device *idev,
    - 
    - /* The device attach/detach/replace helpers for attach_handle */
    +@@ drivers/iommu/iommufd/device.c: iommufd_device_do_attach(struct iommufd_device *idev,
    + 	return NULL;
    + }
      
     +/* Check if idev is attached to igroup->hwpt */
     +static bool iommufd_device_is_attached(struct iommufd_device *idev)
    @@ drivers/iommu/iommufd/device.c: iommufd_device_attach_reserved_iova(struct iommu
     +	return false;
     +}
     +
    - static int iommufd_hwpt_attach_device(struct iommufd_hw_pagetable *hwpt,
    - 				      struct iommufd_device *idev)
    - {
    + static struct iommufd_hw_pagetable *
    + iommufd_device_do_replace(struct iommufd_device *idev,
    + 			  struct iommufd_hw_pagetable *hwpt)
     @@ drivers/iommu/iommufd/device.c: iommufd_device_do_replace(struct iommufd_device *idev,
      		goto err_unlock;
      	}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

