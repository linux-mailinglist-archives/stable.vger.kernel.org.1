Return-Path: <stable+bounces-132356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5584BA872B6
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 18:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FAF1892EC5
	for <lists+stable@lfdr.de>; Sun, 13 Apr 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE6F1DF969;
	Sun, 13 Apr 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOuBfJIQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C7F01DD9AB
	for <stable@vger.kernel.org>; Sun, 13 Apr 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744562860; cv=none; b=jRzGNEt3pLKj4P3GP1s6yy4KIYgrzpxCBiO1g/ChvlDS8xR1DVz6MvWAytZ1CTmozWgm1CQExYAhw9AelSJbqGg5W89+keMkAxCG5NfoauCQDE+yB4GwcXQ+JuC2iBsCOZ9+8iUtv+3DFXQ+EbawLkv02pDHQndaP6juC4lXawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744562860; c=relaxed/simple;
	bh=JQJZHVRsSWcNKRCch8ArPf5D7eVEdIqOdgAsKGnnHO4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pz5japmPiMhzRyMjL1hCoYM/0wcumTGEkZOTw9BZVzXGtS5f43/tn+teJB25L8Gim7fbjKdas1gdY+jqfQW+QZ9e6NMdyUHxv5pdu+KZhhuYvsjqnOT8UsY1yxeiCn+UEtf0pTd/pXL5grc7UvKyb6gaii4/AkMWaQRxeCFJUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOuBfJIQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BDAEC4CEDD;
	Sun, 13 Apr 2025 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744562860;
	bh=JQJZHVRsSWcNKRCch8ArPf5D7eVEdIqOdgAsKGnnHO4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOuBfJIQT2P90WYtYxq7wIYf+Ayi9sHlGr/JPqy9B02xuAnhey8eq63/3WPxZxGLD
	 nHpR5WU1ho9VLdngyl/05kYH9W/6aNO5xIWGrDTcg36gbr+80vUflLWn42yzzLxaUm
	 rD4IiQALl4WhBTA2bDcpCauV1QAO1wGLMXoqtotDFFYZodDK1oC6zqhpA3j31B/7P0
	 X9PDrYCF5WwWmGn9T6kw0AqtDc//IJeTbJpCAPKI6XdMy2DydB0WUvgbL74rAxNdQx
	 sVwLjeT5BrQgyG77r65tGTySu5fvIMyt3zsBOCV/RPu10Qbnk3tpIzdOanCcMaGFjA
	 bQtHDvPr3Xd5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Feng Liu <Feng.Liu3@windriver.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] nvme-rdma: unquiesce admin_q before destroy it
Date: Sun, 13 Apr 2025 12:47:38 -0400
Message-Id: <20250412094432-8b369cf58422246a@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250411030455.1085781-1-Feng.Liu3@windriver.com>
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

The upstream commit SHA1 provided is correct: 5858b687559809f05393af745cbadf06dee61295

WARNING: Author mismatch between patch and upstream commit:
Backport author: Feng Liu<Feng.Liu3@windriver.com>
Commit author: Chunguang.xu<chunguang.xu@shopee.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)
6.13.y | Present (exact SHA1)
6.12.y | Present (different SHA1: 05b436f3cf65)

Note: The patch differs from the upstream commit:
---
1:  5858b68755980 ! 1:  4d596a05770c2 nvme-rdma: unquiesce admin_q before destroy it
    @@ Metadata
      ## Commit message ##
         nvme-rdma: unquiesce admin_q before destroy it
     
    +    [ Upstream commit 5858b687559809f05393af745cbadf06dee61295 ]
    +
         Kernel will hang on destroy admin_q while we create ctrl failed, such
         as following calltrace:
     
    @@ Commit message
         Reviewed-by: Christoph Hellwig <hch@lst.de>
         Reviewed-by: Hannes Reinecke <hare@suse.de>
         Signed-off-by: Keith Busch <kbusch@kernel.org>
    +    [Minor context change fixed]
    +    Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
    +    Signed-off-by: He Zhe <Zhe.He@windriver.com>
     
      ## drivers/nvme/host/rdma.c ##
     @@ drivers/nvme/host/rdma.c: static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
    + 		nvme_rdma_free_io_queues(ctrl);
      	}
      destroy_admin:
    - 	nvme_stop_keep_alive(&ctrl->ctrl);
     -	nvme_quiesce_admin_queue(&ctrl->ctrl);
     -	blk_sync_queue(ctrl->ctrl.admin_q);
     -	nvme_rdma_stop_queue(&ctrl->queues[0]);
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

