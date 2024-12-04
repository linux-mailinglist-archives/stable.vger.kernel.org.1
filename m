Return-Path: <stable+bounces-98583-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C0E9E48B3
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 00:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DAD18804EB
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 23:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED30D1F03FF;
	Wed,  4 Dec 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQaFQyoD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA661B0F0E
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 23:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733354595; cv=none; b=uiPe8cz6YF9HFmw6i+XJ1ByCAjGLqrRagUDUKkjLiPhJ3AiwBaMwX0PTG8fq507qLkrIKtQHnA5bz+5dUnD9SdVXrY2BAINz/He6iDt32HLsBa9s/KFHHDh8qs03nUXY9XLh+hb9bTiZvzcRmntxshs87/uzhdnNjG7csrvJHYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733354595; c=relaxed/simple;
	bh=8dEjY1qgiy2UFhPcAnVhH4nf+KaQdwbl1QzY5LClPhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LARcSdX/VyL2I21VvApiiNuLwK/9MDT3dIw1DI5JzzEIEk7jkv//29TWEW0gdjLQnyzD5Jas2gPUJBnMSXV3aN/pG8UR3nErLA5dPaKfAgvw3k5ADEKKsrY2GALgdJuBJl9BoI1U7esPKxVQdg3f66ZCsiZomeVzvU8lYveCmpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQaFQyoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C384DC4CECD;
	Wed,  4 Dec 2024 23:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733354595;
	bh=8dEjY1qgiy2UFhPcAnVhH4nf+KaQdwbl1QzY5LClPhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tQaFQyoDnLn/h9S/DNX6k2RKHNALMi2fjjHeQh3pLVWEXpgLIVNdPYvbwUL8p6hqr
	 Ndk5Qilotmeuca3I12wUe4nGKn5BfGsKjudzSgr7MfyqEuVehf/EWM8c8ak2nnTTSP
	 z9cY8W3ZFRGYT2C3JTfGvhq3IVFGEr+O1lpeGMJss+CKXdM6hBtB1K/GXC8K8mNYaW
	 nSH6ScOQFAmyymNyS8lC4phit23YY84d70ifnNvSkapEXThsLQvtkM5tSrEf8o8TSS
	 do6bowCO3qjKuDB8uEDJma2q61WAGzJX/MBuuclT5BPOtpqOP0kfE8yZl6XaZ0IOeo
	 p/LLUB8WBGxlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jing Zhang <jingzhangos@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y 2/3] KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
Date: Wed,  4 Dec 2024 17:11:55 -0500
Message-ID: <20241204164213-af665442ee9e2d42@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204202318.2716633-2-jingzhangos@google.com>
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

The upstream commit SHA1 provided is correct: e9649129d33dca561305fc590a7c4ba8c3e5675a

WARNING: Author mismatch between patch and upstream commit:
Backport author: Jing Zhang <jingzhangos@google.com>
Commit author: Kunkun Jiang <jiangkunkun@huawei.com>


Status in newer kernel trees:
6.12.y | Present (different SHA1: 3b47865d395e)
6.11.y | Present (different SHA1: 78e981b6b725)
6.6.y | Present (different SHA1: 026af3ce08de)
6.1.y | Not found
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  e9649129d33dc ! 1:  ead439996b603 KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
    @@ Metadata
      ## Commit message ##
         KVM: arm64: vgic-its: Clear DTE when MAPD unmaps a device
     
    +    commit e9649129d33dca561305fc590a7c4ba8c3e5675a upstream.
    +
         vgic_its_save_device_tables will traverse its->device_list to
         save DTE for each device. vgic_its_restore_device_tables will
         traverse each entry of device table and check if it is valid.
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.10.y       |  Success    |  Success   |

