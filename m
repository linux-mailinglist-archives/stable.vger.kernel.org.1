Return-Path: <stable+bounces-139356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C412AA632A
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 20:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A147046824E
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 18:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68585222568;
	Thu,  1 May 2025 18:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IHYkG737"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282882206AC
	for <stable@vger.kernel.org>; Thu,  1 May 2025 18:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746125509; cv=none; b=EhgVcTiLvscHF0vmfl/e8pPiorBPceUKD7gx+QZYpmnpwD3Qlqo3CLwBNbB0959dcSZNz+U6X6wPL0fzxmrBNBxZMF+Dgx5khkNpuXlmJ9/zhrjkTy0i9NYloaZBsuBMl6kGhy1b1DkSPp8qJtsAyJkIOzfaaYX4ZHWD9G9NvPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746125509; c=relaxed/simple;
	bh=XmAe+olgrEDXHN516TDDgAfmezo0o4YxCSb0zVpm5f4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uddi6O3AXAMzFwxrrD0yF9/Nj/hLbs2+cK8Hne4rgKGBNLAIpud4y5PCdKlo6gpcsOL/Pw5RYvspw2rcwyMjGZiIw0qInWRwVzJpdR+MTDWL/Ko0H0OYIRSl/X8qO7B9Qj46AzfVRpnmqOz+6yMQ/XCSq9y+vm6KgSOdPjlUSNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IHYkG737; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1649DC4CEE3;
	Thu,  1 May 2025 18:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746125508;
	bh=XmAe+olgrEDXHN516TDDgAfmezo0o4YxCSb0zVpm5f4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IHYkG737VtCSN/LeEXaZReT6BP3DHXNheUwPE56lVAsQS0i7XlEyyxixAZdn7kHNB
	 VOtOIqqnOP+sxxgxKJagG7/rbnAD4sLZM28tVdCfpXWh+wk7VcMPSLrhEFFkJwqgqK
	 eYBXFCTQ/5/7g5R+Nx7c1+RMJ0/+rlQPyMF2VLM7kj/MxpngrP+EC8lABa5Fdg9kmQ
	 aGXDEm25aM8R1+qATy/4hVSLmpDNw3uDELUjke+tBjHyOc0mDswDo6AV6GS078Nizb
	 iAidYRnrRt5eQLMeEGJxxMlI2cjOAqh3BwXo+DSP9bu6eRqDJIr3+SQVfv3K/hRG/q
	 PGSzG+3wIVqBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexander Tsoy <alexander@tsoy.me>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/6] Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
Date: Thu,  1 May 2025 14:51:44 -0400
Message-Id: <20250501120454-63ba0e5ae15b72a5@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250430230616.4023290-2-alexander@tsoy.me>
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

The upstream commit SHA1 provided is correct: add1b1656f909c41aa0186fe75e7a42e2c0d2188

WARNING: Author mismatch between patch and upstream commit:
Backport author: Alexander Tsoy<alexander@tsoy.me>
Commit author: Aaron Ma<aaron.ma@canonical.com>

Status in newer kernel trees:
6.14.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  add1b1656f909 ! 1:  31661b9c361a5 Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
    @@ Metadata
      ## Commit message ##
         Bluetooth: btusb: add Foxconn 0xe0fc for Qualcomm WCN785x
     
    +    [ Upstream commit add1b1656f909c41aa0186fe75e7a42e2c0d2188 ]
    +
         Firmwares are already in upstream.
     
         kernel boot log as following:
    @@ Commit message
     
         Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Alexander Tsoy <alexander@tsoy.me>
     
      ## drivers/bluetooth/btusb.c ##
     @@ drivers/bluetooth/btusb.c: static const struct usb_device_id quirks_table[] = {
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

