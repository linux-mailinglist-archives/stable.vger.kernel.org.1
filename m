Return-Path: <stable+bounces-121643-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8750EA58A45
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 03:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4248A3A8A87
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 02:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7E718E764;
	Mon, 10 Mar 2025 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtvnxQXL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2144156861
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 02:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741572863; cv=none; b=Hkjl1Q5UfuhkOzBWzv1s/0L53fQT79uKFr5rJAtQDudYIw10c5rAqYfJ+/VvY2EDV2sp5XibOlV816z7EYvbTOwwEf7pjuOxL/X1+LhyQG+yNeOkpJDa0t5JYAMnUZXaeMjghnAbsfcgCBqB59QLzt8R3JKwSUAcmERXxyEn37Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741572863; c=relaxed/simple;
	bh=ohOjAEbW/MTdc3fV/X+ZVVpRqv+Fv5kQBp5ReesGv60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ghgl7i/j3GhA4BiMc+HDu9P15BeYSSsXom008kVd0SZPsiodvla99M0baLEWvVlvUlbJQ5E3SU/PcMmWpvUO7ENfvBKC3mvmVDopt6r4CGNBYiUbHAwjYnqDy0Z71d6vy29kbpJ/twZslRifjVzhekgCSwxGK+YSyf7j6iu70KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtvnxQXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B31F3C4CEE3;
	Mon, 10 Mar 2025 02:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741572863;
	bh=ohOjAEbW/MTdc3fV/X+ZVVpRqv+Fv5kQBp5ReesGv60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LtvnxQXLoqrGvOG+2kjQbjYXrCkKWyw7Hz2D/pogkVwAsnjhjv+FeTGC5xAjw+Euh
	 S2dr3997FuLAt10EHRx82165VnjYCD1FrkDrNQXvBO0IbA5OiWuAwl+hHrMeJCnLQF
	 0BoA8ibcdaCiYSr5ohCecHNNUMK7lh93AjKGke4raUia3i/trgOufEczL8nI1OFFln
	 VhaR3Mt9K6MotrUpNHujMM/cDfuMPNKe9mF1Jt94elfUhdcwlw2ydRsdniCF7wraAx
	 /RLcZG5sS/ph6pVRfk2ceh1ykOW2DQDXRjRqqav4q4UQJVLQR1o508hhTyKkjO12ER
	 aUcOYCWeq6pQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiangyu Chen <xiangyu.chen@eng.windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10] crypto: hisilicon/qm - inject error before stopping queue
Date: Sun,  9 Mar 2025 22:14:21 -0400
Message-Id: <20250309163914-b1ce5f47b5a3c7c5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250307084249.710957-1-xiangyu.chen@eng.windriver.com>
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

The upstream commit SHA1 provided is correct: b04f06fc0243600665b3b50253869533b7938468

WARNING: Author mismatch between patch and upstream commit:
Backport author: Xiangyu Chen<xiangyu.chen@eng.windriver.com>
Commit author: Weili Qian<qianweili@huawei.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: aa3e0db35a60)
6.1.y | Present (different SHA1: 98d3be34c915)
5.15.y | Present (different SHA1: 801d64177faa)
5.4.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b04f06fc02436 ! 1:  d6e21dbc7d6aa crypto: hisilicon/qm - inject error before stopping queue
    @@ Metadata
      ## Commit message ##
         crypto: hisilicon/qm - inject error before stopping queue
     
    +    commit b04f06fc0243600665b3b50253869533b7938468 upstream.
    +
         The master ooo cannot be completely closed when the
         accelerator core reports memory error. Therefore, the driver
         needs to inject the qm error to close the master ooo. Currently,
    @@ Commit message
         Fixes: 6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
         Signed-off-by: Weili Qian <qianweili@huawei.com>
         Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    +    Signed-off-by: Xiangyu Chen <xiangyu.chen@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/crypto/hisilicon/qm.c ##
     @@ drivers/crypto/hisilicon/qm.c: static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
    @@ drivers/crypto/hisilicon/qm.c: static int qm_set_vf_mse(struct hisi_qm *qm, bool
     +{
     +	u32 nfe_enb = 0;
     +
    -+	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
    -+	if (qm->ver >= QM_HW_V3)
    -+		return;
    -+
     +	if (!qm->err_status.is_dev_ecc_mbit &&
     +	    qm->err_status.is_qm_ecc_mbit &&
     +	    qm->err_ini->close_axi_master_ooo) {
    ++
     +		qm->err_ini->close_axi_master_ooo(qm);
    ++
     +	} else if (qm->err_status.is_dev_ecc_mbit &&
     +		   !qm->err_status.is_qm_ecc_mbit &&
     +		   !qm->err_ini->close_axi_master_ooo) {
    ++
     +		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
     +		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
     +		       qm->io_base + QM_RAS_NFE_ENABLE);
    @@ drivers/crypto/hisilicon/qm.c: static int qm_set_vf_mse(struct hisi_qm *qm, bool
     +	}
     +}
     +
    - static int qm_vf_reset_prepare(struct hisi_qm *qm,
    - 			       enum qm_stop_reason stop_reason)
    + static int qm_set_msi(struct hisi_qm *qm, bool set)
      {
    + 	struct pci_dev *pdev = qm->pdev;
     @@ drivers/crypto/hisilicon/qm.c: static int qm_controller_reset_prepare(struct hisi_qm *qm)
      		return ret;
      	}
      
     +	qm_dev_ecc_mbit_handle(qm);
     +
    - 	/* PF obtains the information of VF by querying the register. */
    - 	qm_cmd_uninit(qm);
    - 
    -@@ drivers/crypto/hisilicon/qm.c: static int qm_master_ooo_check(struct hisi_qm *qm)
    - 	return ret;
    + 	if (qm->vfs_num) {
    + 		ret = qm_vf_reset_prepare(qm, QM_SOFT_RESET);
    + 		if (ret) {
    +@@ drivers/crypto/hisilicon/qm.c: static int qm_controller_reset_prepare(struct hisi_qm *qm)
    + 	return 0;
      }
      
     -static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
     -{
     -	u32 nfe_enb = 0;
     -
    --	/* Kunpeng930 hardware automatically close master ooo when NFE occurs */
    --	if (qm->ver >= QM_HW_V3)
    --		return;
    --
     -	if (!qm->err_status.is_dev_ecc_mbit &&
     -	    qm->err_status.is_qm_ecc_mbit &&
     -	    qm->err_ini->close_axi_master_ooo) {
    +-
     -		qm->err_ini->close_axi_master_ooo(qm);
    +-
     -	} else if (qm->err_status.is_dev_ecc_mbit &&
     -		   !qm->err_status.is_qm_ecc_mbit &&
     -		   !qm->err_ini->close_axi_master_ooo) {
    +-
     -		nfe_enb = readl(qm->io_base + QM_RAS_NFE_ENABLE);
     -		writel(nfe_enb & QM_RAS_NFE_MBIT_DISABLE,
     -		       qm->io_base + QM_RAS_NFE_ENABLE);
    @@ drivers/crypto/hisilicon/qm.c: static int qm_master_ooo_check(struct hisi_qm *qm
     -	}
     -}
     -
    - static int qm_soft_reset_prepare(struct hisi_qm *qm)
    + static int qm_soft_reset(struct hisi_qm *qm)
      {
      	struct pci_dev *pdev = qm->pdev;
    -@@ drivers/crypto/hisilicon/qm.c: static int qm_soft_reset_prepare(struct hisi_qm *qm)
    +@@ drivers/crypto/hisilicon/qm.c: static int qm_soft_reset(struct hisi_qm *qm)
      		return ret;
      	}
      
     -	qm_dev_ecc_mbit_handle(qm);
    - 	ret = qm_master_ooo_check(qm);
    - 	if (ret)
    - 		return ret;
    +-
    + 	/* OOO register set and check */
    + 	writel(ACC_MASTER_GLOBAL_CTRL_SHUTDOWN,
    + 	       qm->io_base + ACC_MASTER_GLOBAL_CTRL);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

