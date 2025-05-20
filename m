Return-Path: <stable+bounces-145077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1445DABD994
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 15:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 495A818805A1
	for <lists+stable@lfdr.de>; Tue, 20 May 2025 13:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256D522DA16;
	Tue, 20 May 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu2sOCok"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5821C4609
	for <stable@vger.kernel.org>; Tue, 20 May 2025 13:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747748200; cv=none; b=Y4mg2AZLG1gPdoW1JbXOz94YvPrjSwJUX57XyeV1TWmJpN52SO0KhhnM6GxvcGtjJL77xJy9rOSFFKh7RNcSsDnsyvdqnNqtCghMOxXIzJ6rh2k2A4yR14GRdd2IMtNfihHJAB0niDJBQcS47ztKl2d6BqUBE6mo1AuyVhPIO3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747748200; c=relaxed/simple;
	bh=bvAxrAgXBSB1fXDQCiITStcoJmCe7OoVzw06nbytJtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jM+M53x9yCOWM7xJEXSYdd8R8jAF2q7NHoUg3/yrkU1Q5wIqb6KFdnqKIwiNn+VqK7O7yQwuyUBSIWBRoYQJ3DuFtfOPnOoHJwEGKbdWNRCGZokzLcy6CKVcZP8yp4TXGAyx6ZKDiny0PeeO+3+fGwRXYho1JnnC+ggaZfehf2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu2sOCok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFCD7C4CEE9;
	Tue, 20 May 2025 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747748200;
	bh=bvAxrAgXBSB1fXDQCiITStcoJmCe7OoVzw06nbytJtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tu2sOCokMWObqnE4OsXpelve6pjpuYdzM27EvDJz1dOLFrESXP0H1q2SajULI4Mhd
	 m8i7RuaJSzfxERAmlPFkdoSjl7MDLl30akYF9oYgfhwlnsJTXhRFr/aGn4e+r5fBDk
	 P+LjtEI3KNrjA/zICvHeH9Ix6CxZnHuWLwd91VrmhOZ3d89l9gutTO3ItQgy3cciWF
	 V8ZMebsmYCtwPpx11qCAT1tU7PipjZMnzxUs7gj0tjLibR27iO66baODw+MuyluHTC
	 0o/4LPsSDcq2p3wkGglZFhR/RjR9ZS9MkkL18ncfhp2yVrE4GvrMey8YTrZipy2bWa
	 iZuw/2hIcUDcw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] Bluetooth: btnxpuart: Fix kernel panic during FW release
Date: Tue, 20 May 2025 09:36:38 -0400
Message-Id: <20250520043140-eda1377e7249949c@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250520073106.2054836-1-bin.lan.cn@windriver.com>
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
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1f77c05408c96 ! 1:  f6951acf722c3 Bluetooth: btnxpuart: Fix kernel panic during FW release
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
| stable/linux-6.6.y        |  Success    |  Success   |

