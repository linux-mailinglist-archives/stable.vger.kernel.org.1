Return-Path: <stable+bounces-127689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 108CDA7A721
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B96791684A2
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB926250C05;
	Thu,  3 Apr 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PF3INage"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9955224CEE2
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694744; cv=none; b=d3tCZBVAzwW7DYjZZkc17U2zFjmrKwKrTy2qSt9lilGAx9RkKb0+q9FtEl7Z+qpXdCmorctkN500i4MPnsj/aU6seJ3lNaKXRKIpaTHf0G0467Erfr6pJZI5MYc4mif84cMUeQCRs4qtfiNnPsjVRo5kiOT10d1lkxVf4QL7Dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694744; c=relaxed/simple;
	bh=uvUikTVBUqHsgS4En0AdpQ9fmkAjT6L3e+DsjJUuEHM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzTNCpI7FHgbksCtt9YqN4Tv1Ao9MCHtZp6WT3tWU0gr21Rows0B4vV7d3aCyfHdNl2F++6r3FXVjLPAdWUVB1bIbghrYX/i6D9ccAIUIhyIH07O6Sv0j7Ju+1CNjH+GX5eQnpjGBk9k+nGSxbJ13UIHUCAzMJtY0Iid/suzK80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PF3INage; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1311EC4CEE7;
	Thu,  3 Apr 2025 15:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694744;
	bh=uvUikTVBUqHsgS4En0AdpQ9fmkAjT6L3e+DsjJUuEHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PF3INage3jm06+VseOgnkHvjrwwBAoSRwBorE5uQrit2B3hMTwAB5j3iBaJxQfnSu
	 h6kdYr35IsPBMblSceufdNuazFbayxx4NiPOiEmw9aDil2NM5RKBfaSw371Hy5wLA1
	 D7Xl9qpszv4vaOvOWrF3Q7pvvQrUfVxEM4/GNsag7i2/DnpNOELWhMMGOlNJuwQL5p
	 g+nkR1LQp7Xb9zOcoCWjYYpwSjimo6YPIggLQsjLkP4sgbAJk/yuNsOkXcln88ELJy
	 rt2BJWfcogfbiXNWkZWgP4pxdAyM9OFkAYlTaaCLmtvf28BvEQt4Nx01djx/WywSD/
	 kINnmM6FrgNwA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.6.y] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Thu,  3 Apr 2025 11:39:00 -0400
Message-Id: <20250403073954-d1ca208cf2f31d40@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403064935.51299-1-jianqi.ren.cn@windriver.com>
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

The upstream commit SHA1 provided is correct: a7bb96b18864225a694e3887ac2733159489e4b0

WARNING: Author mismatch between patch and upstream commit:
Backport author: <jianqi.ren.cn@windriver.com>
Commit author: Abhishek Tamboli<abhishektamboli9@gmail.com>

Status in newer kernel trees:
6.13.y | Present (exact SHA1)
6.12.y | Present (exact SHA1)

Note: The patch differs from the upstream commit:
---
1:  a7bb96b188642 ! 1:  bb53b578c3dc2 usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
    @@ Metadata
      ## Commit message ##
         usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
     
    +    [ Upstream commit a7bb96b18864225a694e3887ac2733159489e4b0 ]
    +
         Fix potential dereferencing of ERR_PTR() in find_format_by_pix()
         and uvc_v4l2_enum_format().
     
    @@ Commit message
         Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
         Link: https://lore.kernel.org/r/20240815102202.594812-1-abhishektamboli9@gmail.com
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    +    Signed-off-by: Jianqi Ren <jianqi.ren.cn@windriver.com>
    +    Signed-off-by: He Zhe <zhe.he@windriver.com>
     
      ## drivers/usb/gadget/function/uvc_v4l2.c ##
     @@ drivers/usb/gadget/function/uvc_v4l2.c: static struct uvcg_format *find_format_by_pix(struct uvc_device *uvc,
    @@ drivers/usb/gadget/function/uvc_v4l2.c: uvc_v4l2_try_format(struct file *file, v
      
      	if (fmt->type != video->queue.queue.type)
     @@ drivers/usb/gadget/function/uvc_v4l2.c: uvc_v4l2_try_format(struct file *file, void *fh, struct v4l2_format *fmt)
    - 		fmt->fmt.pix.height = uframe->frame.w_height;
    - 		fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
    - 		fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
    --		fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
    -+		fmtdesc = to_uvc_format(uformat);
    -+		if (IS_ERR(fmtdesc))
    -+			return PTR_ERR(fmtdesc);
    -+		fmt->fmt.pix.pixelformat = fmtdesc->fcc;
    - 	}
      	fmt->fmt.pix.field = V4L2_FIELD_NONE;
    + 	fmt->fmt.pix.bytesperline = uvc_v4l2_get_bytesperline(uformat, uframe);
    + 	fmt->fmt.pix.sizeimage = uvc_get_frame_size(uformat, uframe);
    +-	fmt->fmt.pix.pixelformat = to_uvc_format(uformat)->fcc;
    ++	fmtdesc = to_uvc_format(uformat);
    ++	if (IS_ERR(fmtdesc))
    ++		return PTR_ERR(fmtdesc);
    ++	fmt->fmt.pix.pixelformat = fmtdesc->fcc;
      	fmt->fmt.pix.colorspace = V4L2_COLORSPACE_SRGB;
    + 	fmt->fmt.pix.priv = 0;
    + 
     @@ drivers/usb/gadget/function/uvc_v4l2.c: uvc_v4l2_enum_format(struct file *file, void *fh, struct v4l2_fmtdesc *f)
      		return -EINVAL;
      
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.6.y        |  Success    |  Success   |

