Return-Path: <stable+bounces-167076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B80B21862
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 00:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7CAB7B1CA6
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 22:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A109222425B;
	Mon, 11 Aug 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Co6Gtmvv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF19222591
	for <stable@vger.kernel.org>; Mon, 11 Aug 2025 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951430; cv=none; b=sdXTebBW7va731jtnnsl1q33ek//HkW8x4MvTE67XaH+rLnGy3mDtbTx9Lb4XD8DhX1csIc6DMq3K3zMBSnZYZMAEvaUOpI9IcMlZeriC74wz6Nwo50CdjJ091lnCoNMBj/NIPyjH1Yp0Y2hTkCyy/ljBTIjte6t5/EpEMwq8qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951430; c=relaxed/simple;
	bh=jZnQk/+DI/W/cu7TAJrRr7X1GxzdQamI06MP1GAqt2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GtmexCfYffWuasq+xx2KR8YDewqBTQJ6nAiI8OUn3zAWha5QdYy0QfthkFfDBoBgzmQjjZzAmTbdVFaJ1DjMOCgJYgvUgkKgmjlAxKPj9Hpdh9VCMq8pQQErmcg+i+vDhcniWWBSpdHpMq29bXZkLS+ei3Mt/X+RVkTiBfc6Izg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Co6Gtmvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE073C4CEED;
	Mon, 11 Aug 2025 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754951430;
	bh=jZnQk/+DI/W/cu7TAJrRr7X1GxzdQamI06MP1GAqt2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Co6Gtmvvtf1y5tuKj+HaQfxBj+kpO1dRNDo+8VWvwNA2IvdX1im1z9twEXq8C1KnU
	 4WFBQkM5eMBZ6VBnkAAuwWpj+HETia28yGlr+kQQF/hAF4k1S/3g3GJLmMLSxCd3SX
	 YwMxcNjYgBLGccKRtdDwnQLwKGdQc3AUV8CwkI6qm2gz4/Gm3ZLdk+sAKjrBxTMKM4
	 YeX6PTCqngpQKUAbbRxVKGu1IDM8Aap+PtyMTO+JGnhkl3C7BDUEpj8VrJBRmPByMI
	 JjokswNmkyAGnvISEihFSx/SryzvaispFudU0D8/NqaIadRTvO4ah4S2YIMZ8uCxNd
	 q1CwQdEG13V3Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10] scsi: pm80xx: Fix memory leak during rmmod
Date: Mon, 11 Aug 2025 18:30:27 -0400
Message-Id: <1754925250-783d021d@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250811052035.145021-1-shivani.agarwal@broadcom.com>
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

The upstream commit SHA1 provided is correct: 51e6ed83bb4ade7c360551fa4ae55c4eacea354b

WARNING: Author mismatch between patch and upstream commit:
Backport author: Shivani Agarwal <shivani.agarwal@broadcom.com>
Commit author: Ajish Koshy <Ajish.Koshy@microchip.com>

Status in newer kernel trees:
6.15.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (exact SHA1)
6.1.y | Present (exact SHA1)
5.15.y | Present (different SHA1: 269a4311b15f)

Note: The patch differs from the upstream commit:
---
1:  51e6ed83bb4a ! 1:  1652f92390bb scsi: pm80xx: Fix memory leak during rmmod
    @@ Metadata
      ## Commit message ##
         scsi: pm80xx: Fix memory leak during rmmod
     
    +    [ Upstream commit 51e6ed83bb4ade7c360551fa4ae55c4eacea354b ]
    +
         Driver failed to release all memory allocated. This would lead to memory
         leak during driver removal.
     
    @@ Commit message
         Signed-off-by: Ajish Koshy <Ajish.Koshy@microchip.com>
         Signed-off-by: Viswas G <Viswas.G@microchip.com>
         Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    [Shivani: Modified to apply on 5.10.y]
    +    Signed-off-by: Shivani Agarwal <shivani.agarwal@broadcom.com>
     
      ## drivers/scsi/pm8001/pm8001_init.c ##
     @@ drivers/scsi/pm8001/pm8001_init.c: pm8001_init_ccb_tag(struct pm8001_hba_info *pm8001_ha, struct Scsi_Host *shost,
    @@ drivers/scsi/pm8001/pm8001_init.c: pm8001_init_ccb_tag(struct pm8001_hba_info *p
      
      	/* Memory region for ccb_info*/
     +	pm8001_ha->ccb_count = ccb_count;
    - 	pm8001_ha->ccb_info =
    + 	pm8001_ha->ccb_info = (struct pm8001_ccb_info *)
      		kcalloc(ccb_count, sizeof(struct pm8001_ccb_info), GFP_KERNEL);
      	if (!pm8001_ha->ccb_info) {
     @@ drivers/scsi/pm8001/pm8001_init.c: static void pm8001_pci_remove(struct pci_dev *pdev)

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

