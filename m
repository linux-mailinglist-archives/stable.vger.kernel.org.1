Return-Path: <stable+bounces-100677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425B79ED1FF
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 17:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53214166377
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 16:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8171DDA3C;
	Wed, 11 Dec 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzRMkrt4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0831DD9A6
	for <stable@vger.kernel.org>; Wed, 11 Dec 2024 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934807; cv=none; b=o5QobTBcNrAnuwRmVBLTqpOdaxiIhEdUt1EVQVYk4UPWjABGQ+A+WEMp1JASQc19UmIC7krczZVXGpzhKF7Slbo7ko7waBS7uELAf27eoxWzKXanXKYNVcpLVTn92Rd2TGhsYtp/La7jS0tuVByrsQTSoduHBMK1sfElawnwphs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934807; c=relaxed/simple;
	bh=917YYe7Hgjk3TiVS6pcEKRYj+Cf/b3ihWfLATLbCIbs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKhj8zuHnuw/Js9JwBQ7wpHtxxIPksW+I/AeDhBGnUJ2ScNynjRPgmj0l/2YgGp2ZkFAzLWz3oTFKQ/kLSSWlmR2pG/BfntdY0oazZ5puegux0f7EIFQVloSFbqMKQ3v2RgVhESHoyrEnuENqNdQw+v5IlJHnOJ3d7IqgP8V7FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzRMkrt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C228C4CED2;
	Wed, 11 Dec 2024 16:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733934807;
	bh=917YYe7Hgjk3TiVS6pcEKRYj+Cf/b3ihWfLATLbCIbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YzRMkrt4npwJYImL1x115GqfqWUACd2ER8AQU3NK2oFZrAxpUry9ZFJQa2CT/7Vax
	 fmTHo2NgXNCqqq56RzeWbFF3b0pMneoM2Hdka7LEMw0naatiKHwt8teA1S2YNkGXZc
	 yCqgC6ymPzPvDIUxYqsYH+zNR7rrqXeWogCC3Tdq05ggut9gYCvNt7Vj4HkVnAdQWQ
	 paZoJcouKP5zGb/OQboG7y8m7kpY2x3lh5lJXY0aJOredzWIKRC0sDOGqlsvqcsvkD
	 tq7vvRQo0AajWAWv0qO193CjQ26mL9YVEvPFqa9lKdUtdtQIdWBZ+QtgtjxTx7tMMg
	 Y+AwNOCP/oCLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: libo.chen.cn@eng.windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] crypto: hisilicon/qm - inject error before stopping queue
Date: Wed, 11 Dec 2024 11:33:25 -0500
Message-ID: <20241211083647-b5c9f6aacf3e0045@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241211081815.209162-1-libo.chen.cn@eng.windriver.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: b04f06fc0243600665b3b50253869533b7938468

WARNING: Author mismatch between patch and upstream commit:
Backport author: libo.chen.cn@eng.windriver.com
Commit author: Weili Qian <qianweili@huawei.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: aa3e0db35a60)
6.1.y | Present (different SHA1: 98d3be34c915)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b04f06fc02436 ! 1:  1ad66e6380c8c crypto: hisilicon/qm - inject error before stopping queue
    @@ Metadata
      ## Commit message ##
         crypto: hisilicon/qm - inject error before stopping queue
     
    +    [ Upstream commit b04f06fc0243600665b3b50253869533b7938468 ]
    +
         The master ooo cannot be completely closed when the
         accelerator core reports memory error. Therefore, the driver
         needs to inject the qm error to close the master ooo. Currently,
    @@ Commit message
         Fixes: 6c6dd5802c2d ("crypto: hisilicon/qm - add controller reset interface")
         Signed-off-by: Weili Qian <qianweili@huawei.com>
         Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
    +    Signed-off-by: Libo Chen <libo.chen.cn@windriver.com>
     
      ## drivers/crypto/hisilicon/qm.c ##
     @@ drivers/crypto/hisilicon/qm.c: static int qm_set_vf_mse(struct hisi_qm *qm, bool set)
    @@ drivers/crypto/hisilicon/qm.c: static int qm_controller_reset_prepare(struct his
      	/* PF obtains the information of VF by querying the register. */
      	qm_cmd_uninit(qm);
      
    -@@ drivers/crypto/hisilicon/qm.c: static int qm_master_ooo_check(struct hisi_qm *qm)
    - 	return ret;
    +@@ drivers/crypto/hisilicon/qm.c: static int qm_controller_reset_prepare(struct hisi_qm *qm)
    + 	return 0;
      }
      
     -static void qm_dev_ecc_mbit_handle(struct hisi_qm *qm)
    @@ drivers/crypto/hisilicon/qm.c: static int qm_master_ooo_check(struct hisi_qm *qm
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
| stable/linux-5.15.y       |  Success    |  Success   |

