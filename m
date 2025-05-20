Return-Path: <stable+bounces-145090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CB9ABD9BA
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18CEF1BA4DD2
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1F721C4609;
	Tue, 20 May 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPGw+YMm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634D51B0416
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748434; cv=none; b=d/vJEa0jeTBMaxZZjGLcrt6ZYFce45nzs7PVLNzHtBLq6fB5LXseFh9GNb8+eydm/c0sTzHzdbcjLQmX7rCqwPqqVyk+BG/dkYrL5f3PlO07fLu495eDLdc7tFNxs2MGc8wOIiTWOTULfSPvH1+oiV8u1uIJiNFhjVD4v1mZHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748434; c=relaxed/simple;
	bh=6jK0LhfE4Ep+Y8XnD9o6IfobhmgVJE5flUDR88YdV1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfMmU9k8wCH+nLN4c/ZVYvMtep8AbFoqKulkgqTZ+UUqPLWfYq97J++m+9z07qIZwEC4xSQ9tOrwmeJ64zknH+qv3atEEOhLAIoiyv1CI60NAs0oUWiaUmADSRqrxEWF0+x00zs5IQKSzx7vfnJIfe5D7ueGUomR9UILE13wZEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPGw+YMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB25CC4CEE9;
	Tue, 20 May 2025 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748434;
	bh=6jK0LhfE4Ep+Y8XnD9o6IfobhmgVJE5flUDR88YdV1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jPGw+YMmvRf4DrviHyuPQoAc7oZ6GPhGQJwwuK6xdISSKtTcVmjGXnmnCNPs3cOmh
	 TKkdCsKF4kpeTmtIQKA7nJUT2y+n4cggD9w6fwSIYTHj4lr9cElED5HROFTmzuJpIN
	 iB4TlKe+ze31kneO8+Q5O/Nt/SWFjx+e8p9FPN+w5RvnZnfn4ZcmCrnU1QOHbUd1jN
	 B16KaasJDZ3yU54ZoCDf1RkaQbGbB/FQE44KDrarqyhtXHsDPoX5lNp8xPwQnwPmW4
	 jVDsYp2WTu8amvwhLVGIurONflryUKsuJFgKEBceK2VLhV+uURVej42Un6bJnW5b9r
	 3k3PxaPWnRquA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Tue, 20 May 2025 09:40:32 -0400
Message-Id: <20250520054604-d34a7cfc0e143272@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520072958.2053271-1-bin.lan.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: 1f77c05408c96bc0b58ae476a9cadc9e5b9cfd0f

WARNING: Author mismatch between patch and upstream commit:
Backport author: bin.lan.cn@windriver.com
Commit author: Neeraj Sanjay Kale<neeraj.sanjaykale@nxp.com>

Status in newer kernel trees:
6.14.y | Present (different SHA1: 6749cf49eff7)

Note: The patch differs from the upstream commit:
---
1:  1f77c05408c96 ! 1:  d854ce2fc9d99 Bluetooth: btnxpuart: Fix kernel panic during FW release
    @@ Metadata
      ## Commit message ##
         Bluetooth: btnxpuart: Fix kernel panic during FW release
     
    +    [ Upstream commit 1f77c05408c96bc0b58ae476a9cadc9e5b9cfd0f ]
    +
         This fixes a kernel panic seen during release FW in a stress test
         scenario where WLAN and BT FW download occurs simultaneously, and due to
         a HW bug, chip sends out only 1 bootloader signatures.
    @@ Commit message
         Fixes: 689ca16e5232 ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
         Signed-off-by: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/bluetooth/btnxpuart.c ##
     @@ drivers/bluetooth/btnxpuart.c: static int nxp_download_firmware(struct hci_dev *hdev)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

