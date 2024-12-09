Return-Path: <stable+bounces-100256-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639A49EA0AF
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 21:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45CD9164CA0
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A82199EB2;
	Mon,  9 Dec 2024 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpATFCMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F6A1E515
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777755; cv=none; b=SbKZO5k4NqxmIUTLZWF0k5br3t/QcQRe6aFPn1WcpZ5QJXFcyGvZ3LTywpYjPB+/wV4TL1PjrTonXIQsvKfqTiTW9fUb/qecKfwZ2CSVLZmqV+gJHcxPoXnenkShUu1/rbwrXx2HSVjPIFINF0Q9/a+IdM0td8W5mUZlDLi3P6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777755; c=relaxed/simple;
	bh=Zgx3D37Zw1JWNuPE2e5fMfUSgIFBWRD/BpC05rCgaro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgPJnyIqTC3mjzsFEh+D7piOpGyCXFON2aE6ziv3kH6hZg/I/JV87TeO6XSIOHnc88qrW5Z0z90mBf7MqVwOMX1ZsqbiW7gRuZnNvbQTCaS2XnNg9Pci1BvTGXcAwGg4XMqdBdaTYNGBLkjHW2rivVSQalFGvQjfSjCwR6Y05y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpATFCMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A382C4CED1;
	Mon,  9 Dec 2024 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733777754;
	bh=Zgx3D37Zw1JWNuPE2e5fMfUSgIFBWRD/BpC05rCgaro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PpATFCMreP+gsCPMXD44pVfW/SpTzKLHPtAHEldt5k6gy3VS+y6ix2Pp4BiMCVQX8
	 HJ9QbIDddPrqSLdJyFuubS+KkXT/G8K1xVTASAJ68ebc3cfVQ+oMaCafUMfmPVaiz/
	 KuNUsDXAPnjMagvZXy0rXdUrjAIEcLN569BuQlxMWe0oChzdG8ABkaz7ntgF05QGm9
	 9r/01mZXpYEB6Brbg0TZWZwCRiz8KwVWv1CH3kGXuosq98wRYGY890iak5rEApmhMh
	 j3s/22xccX9Z2lkxQXja/Se4lvhN7oDMEOq9GSwG95JR6JlUiDcgyPwQVRpu5JTVCb
	 K4zHuBZ7IGOBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y] media: ipu6: use the IPU6 DMA mapping APIs to do mapping
Date: Mon,  9 Dec 2024 15:55:53 -0500
Message-ID: <20241209140015-9d5855e4e01a460e@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241209175416.59433-1-stanislaw.gruszka@linux.intel.com>
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

The upstream commit SHA1 provided is correct: 1d4a000289979cc7f2887c8407b1bfe2a0918354

WARNING: Author mismatch between patch and upstream commit:
Backport author: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Commit author: Bingbu Cao <bingbu.cao@intel.com>


Status in newer kernel trees:
6.12.y | Not found

Note: The patch differs from the upstream commit:
---
1:  1d4a000289979 ! 1:  b5698951cc16d media: ipu6: use the IPU6 DMA mapping APIs to do mapping
    @@ Metadata
      ## Commit message ##
         media: ipu6: use the IPU6 DMA mapping APIs to do mapping
     
    +    commit 1d4a000289979cc7f2887c8407b1bfe2a0918354 upstream.
    +
         dma_ops is removed from the IPU6 auxiliary device, ISYS driver
         should use the IPU6 DMA mapping APIs directly instead of depending
         on the device callbacks.
    @@ Commit message
         [Sakari Ailus: Rebased on recent videobuf2 wait changes.]
         Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
         Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
    +    Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
     
      ## drivers/media/pci/intel/ipu6/Kconfig ##
     @@ drivers/media/pci/intel/ipu6/Kconfig: config VIDEO_INTEL_IPU6
    @@ drivers/media/pci/intel/ipu6/ipu6-isys-queue.c: void ipu6_isys_queue_buf_ready(s
      static const struct vb2_ops ipu6_isys_queue_ops = {
     -	.queue_setup = queue_setup,
     +	.queue_setup = ipu6_isys_queue_setup,
    -+	.wait_prepare = vb2_ops_wait_prepare,
    -+	.wait_finish = vb2_ops_wait_finish,
    + 	.wait_prepare = vb2_ops_wait_prepare,
    + 	.wait_finish = vb2_ops_wait_finish,
     +	.buf_init = ipu6_isys_buf_init,
      	.buf_prepare = ipu6_isys_buf_prepare,
     +	.buf_cleanup = ipu6_isys_buf_cleanup,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.12.y       |  Success    |  Success   |

