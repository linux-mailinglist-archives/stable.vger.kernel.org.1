Return-Path: <stable+bounces-132430-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63484A87E74
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3F391896FA0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 11:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E70128CF6D;
	Mon, 14 Apr 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBBSEdp7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2FDDF42
	for <stable@vger.kernel.org>; Mon, 14 Apr 2025 11:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744628947; cv=none; b=iGAk3T/FEtsucqldBdYps9ZsjWyoTWCwpNzJ/ULv5Jn3VsKI2AVaxBp6TXRAir1r+Z4ayUlXiTIQUFfVYl1kdYXSbN4ykwNfFc1kl6znnV/rr8WIN6DbqNR9wbT1Hu342UOo9UdfMYha8PL8xxwWuX9ZlA+yVWTOu3Zv++i1Kk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744628947; c=relaxed/simple;
	bh=Tk7HjUBbd5tOvhU6BuSiDfotyH77mOo7BgV/Feze0+g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MPG9yto9WH75oOCG7NbZkeVIl3lDlj3Qj82dTwnPq5GBJe9MyMRVGY7BwXg9SYH9CajjTa53uv9QqdEODUdc9KzWla5rsjvDFOkTL7l1os+rxS0+M/kLcAXvwEAvSlqkwxhgR3k3acRVviang32J3TmvK/GEOAZC8vOPLXm4mVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBBSEdp7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92608C4CEE2;
	Mon, 14 Apr 2025 11:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744628947;
	bh=Tk7HjUBbd5tOvhU6BuSiDfotyH77mOo7BgV/Feze0+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aBBSEdp7dttV0pM3IlYZEgJDnanWAAgjn8uP/6wPZBQvsqc8NYeugpACHW7CU195w
	 iMCZ2Nl39msgLzAH6+QniZ3Y3v5MStnpXuhlC4wIauCbmk6XAcPW6pYAEK1HBSxgqy
	 dOcx12ZpBhmbnsRdhYoc1lf5OeBDoAjxlNZ+bfzEMbEFKKRQ+kQ5Hp+65vBvyEUHyA
	 /ov0tOWyt9k9j4DuNPHc8f+HtQzgpZgxITQ8bQil5xvum4ElnGb1w+B0XvdZk4RGsu
	 RcIqq35Fe3UMHPR11WIH8rrqKW1aEDACElKlcQYXkLiQK3nUAx2ft8AHYd99kSp+YW
	 A1awgNTXnHNrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] vfio/pci: fix memory leak during D3hot to D0 transition
Date: Mon, 14 Apr 2025 07:09:05 -0400
Message-Id: <20250414064116-bd1d1492698e70e0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250414024356.1733216-1-Feng.Liu3@windriver.com>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: eadf88ecf6ac7d6a9f47a76c6055d9a1987a8991

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Abhishek Sahu<abhsahu@nvidia.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 4319f17fb826)

Note: The patch differs from the upstream commit:
---
1:  eadf88ecf6ac7 ! 1:  29252935ed497 vfio/pci: fix memory leak during D3hot to D0 transition
    @@ Metadata
      ## Commit message ##
         vfio/pci: fix memory leak during D3hot to D0 transition
     
    +    [ Upstream commit eadf88ecf6ac7d6a9f47a76c6055d9a1987a8991 ]
    +
         If 'vfio_pci_core_device::needs_pm_restore' is set (PCI device does
         not have No_Soft_Reset bit set in its PMCSR config register), then
         the current PCI state will be saved locally in
    @@ Commit message
         Signed-off-by: Abhishek Sahu <abhsahu@nvidia.com>
         Link: https://lore.kernel.org/r/20220217122107.22434-2-abhsahu@nvidia.com
         Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
    - ## drivers/vfio/pci/vfio_pci_core.c ##
    -@@ drivers/vfio/pci/vfio_pci_core.c: int vfio_pci_set_power_state(struct vfio_pci_core_device *vdev, pci_power_t stat
    + ## drivers/vfio/pci/vfio_pci.c ##
    +@@ drivers/vfio/pci/vfio_pci.c: int vfio_pci_set_power_state(struct vfio_pci_device *vdev, pci_power_t state)
      	if (!ret) {
      		/* D3 might be unsupported via quirk, skip unless in D3 */
      		if (needs_save && pdev->current_state >= PCI_D3hot) {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

