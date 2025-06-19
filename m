Return-Path: <stable+bounces-154776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CEBAE015C
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 11:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614155A48F2
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 09:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F11921C9EB;
	Thu, 19 Jun 2025 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dC51qBRV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C329B21CC47
	for <stable@vger.kernel.org>; Thu, 19 Jun 2025 09:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323866; cv=none; b=iRptNrZKxaU8gUCm/merOkUH5gRxw/UU1/65ooG+syiiFJWXP14EA3JfHIGvzu/DgKnTYWB7b4Zuu2N5znTWSJJxJ1RuumcgwOHfASkFC0pKCl+6sG5N62oKo9evuse0SWJjCr90b0fKvDwq3y5ggRDNIxnF0WLOJasC5ZkWuNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323866; c=relaxed/simple;
	bh=WFuJilUtTcC8E8LHtxgigUCt7UwgXCHctMu/IJPZoxg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2LqHm9r6781jBRgNQbmnz+CuGaNUybezmXAsF8r+EYf6YpVwd4+ql4EkB65Kk0j7NQBJKSm5dZvil1RK1DMu/uNHHXBj5PfNPaEUwyeD+Se10kHAZmFirohsE75y2VN/xlIDZSfNg8CepJHWWy4Eip01MGAbuud8gUwAO0QR4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dC51qBRV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F13C4CEEF;
	Thu, 19 Jun 2025 09:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323866;
	bh=WFuJilUtTcC8E8LHtxgigUCt7UwgXCHctMu/IJPZoxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dC51qBRVQ94hYcQrkhsHQO04VH6dciC/eXVgvswQMGaExuUr0AlA09nePLi+fvJ52
	 0ak+MGYD2bFK27ie1CTsfiIoXKDU3WI258KAmWOreIrwIC0nig7zZ4rlKfsDdle9f/
	 UWekcIATb4sYlzN64YjwQzXnJzs/iZ2azW3Gc3pcSWEegG0HdrgneX/OwUhwpoOij8
	 FPpPWgjVx7jUgyaOCApcqCX0iXt+6M85Yvqa+lFBCJCRJrjzJI6qh9LgT/0Lj9bN2l
	 MZyCIlcNeHn91Sz+E6K9AwFDMfqTUZyQ+ovgqbF8a4vqrjk7H3uunZpG5yZ2hX4b4P
	 xY9lo9O2xL+7A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] scsi: pm80xx: Set phy->enable_completion only when we wait for it
Date: Thu, 19 Jun 2025 05:04:24 -0400
Message-Id: <20250618194344-57003f97e74862a6@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250618065133.3756860-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: e4f949ef1516c0d74745ee54a0f4882c1f6c7aea

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Igor Pylypiv<ipylypiv@google.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 7b1d779647af)

Note: The patch differs from the upstream commit:
---
1:  e4f949ef1516c ! 1:  b784aa07fb1ca scsi: pm80xx: Set phy->enable_completion only when we wait for it
    @@ Metadata
      ## Commit message ##
         scsi: pm80xx: Set phy->enable_completion only when we wait for it
     
    +    [ Upstream commit e4f949ef1516c0d74745ee54a0f4882c1f6c7aea ]
    +
         pm8001_phy_control() populates the enable_completion pointer with a stack
         address, sends a PHY_LINK_RESET / PHY_HARD_RESET, waits 300 ms, and
         returns. The problem arises when a phy control response comes late.  After
    @@ Commit message
         Link: https://lore.kernel.org/r/20240627155924.2361370-2-tadamsjr@google.com
         Acked-by: Jack Wang <jinpu.wang@ionos.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/scsi/pm8001/pm8001_sas.c ##
     @@ drivers/scsi/pm8001/pm8001_sas.c: int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
    @@ drivers/scsi/pm8001/pm8001_sas.c: int pm8001_phy_control(struct asd_sas_phy *sas
      	pm8001_ha = sas_phy->ha->lldd_ha;
      	phy = &pm8001_ha->phy[phy_id];
     -	pm8001_ha->phy[phy_id].enable_completion = &completion;
    - 
    - 	if (PM8001_CHIP_DISP->fatal_errors(pm8001_ha)) {
    - 		/*
    ++
    + 	switch (func) {
    + 	case PHY_FUNC_SET_LINK_RATE:
    + 		rates = funcdata;
     @@ drivers/scsi/pm8001/pm8001_sas.c: int pm8001_phy_control(struct asd_sas_phy *sas_phy, enum phy_func func,
      				rates->maximum_linkrate;
      		}
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

