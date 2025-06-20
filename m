Return-Path: <stable+bounces-154853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 154B9AE1119
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 04:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A171F19E264A
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 02:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632A4139CFA;
	Fri, 20 Jun 2025 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvpPLJQ/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B19137C37
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 02:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750386306; cv=none; b=C+XkrcebG3b1x3COcgVtQNI4mWUsykiY454YvREbEy0b+NYd5TOI4YMRqwEiQ+2C1WZICwF8HtsL4sOH55dhuG/Ta9NH8XKS8OsgLs8u3UH9lt3uWjdtNkjbsgC1FdmsDSDyhvn+HXQ4ZXnhfaU33ugbU27jalAxZ5MZIxUynTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750386306; c=relaxed/simple;
	bh=26FlcVuxa7arLufshhqzuNRfbZLQbX66FCIRn96iiXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZYkHXZ2C2pAcwY8MImRTxJsmw4+8Wk4cVXwPudzeFzzQSng7kOnfWk9qT7ITnNKlE3quaN8LzzTfTC294viF8leDYmX0RhA8CqO7c/58Dr9lnZkbjCZjKqrpoDoq9kS01Xb6B3lxVgUJE+iws6K4spiylUVvWjk+/ml8+tXVTtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvpPLJQ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AA0C4CEEA;
	Fri, 20 Jun 2025 02:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750386306;
	bh=26FlcVuxa7arLufshhqzuNRfbZLQbX66FCIRn96iiXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TvpPLJQ/46d+XAeaE9rhpOWfYcWPI+uiBIM5/St7kJcQKwHCXfJIr9qNJUHYP3Qqt
	 ELob2yRKgvZKdXjkt39d5b0ywC2TSgiiSvYUiA3Q9JXYdWWNg4tWxqOkEAH9ny6NY8
	 2TLr2AwXdt5oJ/mDhmfOSi3lFim0/BxlSi2WiHReN05dX+fFe4DXMSGg9Yn3ohROte
	 gEZRn0qH8W49Yacky4oAC1ucR5oyVGlclevEifw6Fe3u4nFfi3CAkiK4Su7Na5l2Dm
	 Vn8S/JPty49ZkpMfS4sGKqov1Wqzek8Dt4IvAFoE4tzd6b+sPEUcNbhmvanSM275Nq
	 xOTaQDo8IKuGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linuxhid@cosmicgizmosystems.com
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
Date: Thu, 19 Jun 2025 22:25:04 -0400
Message-Id: <20250619054352-97adbb1753c91951@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250619005310.11573-1-linuxhid@cosmicgizmosystems.com>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: fe7f7ac8e0c708446ff017453add769ffc15deed

Status in newer kernel trees:
6.15.y | Present (different SHA1: 6dffa4488614)
6.12.y | Present (different SHA1: 549d235f4f07)
6.6.y | Present (different SHA1: cd2287ce05d8)
6.1.y | Present (different SHA1: 345ab0a1113c)
5.15.y | Not found
5.10.y | Not found

Note: The patch differs from the upstream commit:
---
1:  fe7f7ac8e0c70 ! 1:  c6a5ee4d9ec3b HID: usbhid: Eliminate recurrent out-of-bounds bug in usbhid_parse()
    @@ Commit message
         Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
         Reviewed-by: Michael Kelley <mhklinux@outlook.com>
         Signed-off-by: Jiri Kosina <jkosina@suse.com>
    +    (cherry picked from commit fe7f7ac8e0c708446ff017453add769ffc15deed)
    +    Signed-off-by: Terry Junge <linuxhid@cosmicgizmosystems.com>
     
      ## drivers/hid/hid-hyperv.c ##
     @@ drivers/hid/hid-hyperv.c: static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
    + 	if (!input_device->hid_desc)
      		goto cleanup;
      
    - 	input_device->report_desc_size = le16_to_cpu(
    --					desc->desc[0].wDescriptorLength);
    +-	input_device->report_desc_size = desc->desc[0].wDescriptorLength;
    ++	input_device->report_desc_size = le16_to_cpu(
     +					desc->rpt_desc.wDescriptorLength);
      	if (input_device->report_desc_size == 0) {
      		input_device->dev_info_status = -EINVAL;
    @@ drivers/hid/hid-hyperv.c: static void mousevsc_on_receive_device_info(struct mou
      
      	memcpy(input_device->report_desc,
      	       ((unsigned char *)desc) + desc->bLength,
    --	       le16_to_cpu(desc->desc[0].wDescriptorLength));
    +-	       desc->desc[0].wDescriptorLength);
     +	       le16_to_cpu(desc->rpt_desc.wDescriptorLength));
      
      	/* Send the ack */
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

