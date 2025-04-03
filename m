Return-Path: <stable+bounces-127693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643DDA7A70E
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EECEC7A616D
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 15:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB1250BF3;
	Thu,  3 Apr 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qioh+s3D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05680250BE5
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 15:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743694762; cv=none; b=Pq4TXlIAdYA72LnOfzDddfxcMFXNuwW56B8+9RyBpWVqS9vyitqZPYqXOQHk8OVJwWTSSL80jykS31kLpzpWccIW08xcaxIfOAIwCxE1wZLrptibHZRfqFHvKkKZnQ2it1w6iwBcQoLQD8Xm6wbcP4zerjYSR01M/VRRZubcBOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743694762; c=relaxed/simple;
	bh=UESmbIQ0NM4Y+ccdtrCtuuRrwCsn1v06Wd5l1GhP/Ec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mg//zamiO63wtiEBxKcqui5sorVoY8BFGCT39UzeO20Bg3OLzjCFqF3LdnmPDcDjIR+WFBvHlSFBTJuO268JmWo3foKJfeLGaA1+saemX1VjxQUgMMNhDSDd2Y0T6d4lNh/ai1cNslsnaQY0VG+YJi0ITj/a2cBb79kmxDMAXRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qioh+s3D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F830C4CEEB;
	Thu,  3 Apr 2025 15:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743694761;
	bh=UESmbIQ0NM4Y+ccdtrCtuuRrwCsn1v06Wd5l1GhP/Ec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qioh+s3D/Nft/AzaXrG67MINQb7PtBpAJnn9kkjDZs6b5YNwdbTLYzf8qBB52vBHw
	 FPqB4e1oqa4fzPLkwzH3e9pSQmqvxpFVOuNuQcX9MFrrO7Ou4WTjTBOZyRoSBRan5S
	 k4Y1MAbK7f6xZ59Tp6AMJToJBldYkfL3B/xcThFaCWklunNntUPevwKHyxCsZFnBQj
	 SGwWPFeaDVqjHxxmtasaBeaL/lKTGKtUqyQndMCJRz5R/3EHDyEmjIOSMrVTV/PNeI
	 y/tYhhpHTYFuF4AVsFw/YkyM5KedtcaMYuLbR03aMY1IYwrxAjX/TEPNRaxlAswvoi
	 B6AZMScY6/wMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jianqi.ren.cn@windriver.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
Date: Thu,  3 Apr 2025 11:39:18 -0400
Message-Id: <20250403073030-3275cb94fa4452dc@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250403064947.51317-1-jianqi.ren.cn@windriver.com>
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
6.6.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a7bb96b188642 ! 1:  d9d8a0b1ba842 usb: gadget: uvc: Fix ERR_PTR dereference in uvc_v4l2.c
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
      	list_for_each_entry(format, &uvc->header->formats, entry) {
    - 		const struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
    + 		struct uvc_format_desc *fmtdesc = to_uvc_format(format->fmt);
      
     +		if (IS_ERR(fmtdesc))
     +			continue;
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
    - 		return -EINVAL;
    + 		f->flags |= V4L2_FMT_FLAG_COMPRESSED;
      
      	fmtdesc = to_uvc_format(uformat);
     +	if (IS_ERR(fmtdesc))
    @@ drivers/usb/gadget/function/uvc_v4l2.c: uvc_v4l2_enum_format(struct file *file,
     +
      	f->pixelformat = fmtdesc->fcc;
      
    - 	return 0;
    + 	strscpy(f->description, fmtdesc->name, sizeof(f->description));
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.1.y        |  Success    |  Success   |

