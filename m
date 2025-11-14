Return-Path: <stable+bounces-194769-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 259A1C5BCDC
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 08:36:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6269A352F0E
	for <lists+stable@lfdr.de>; Fri, 14 Nov 2025 07:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47D7C2F5A30;
	Fri, 14 Nov 2025 07:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nkw+G5Xu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721FC27E074
	for <stable@vger.kernel.org>; Fri, 14 Nov 2025 07:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763105757; cv=none; b=Q/CVxiX8QBS/BjE7K11DuE55NrzTchTMvfGuwVHo+osRh34VJuG8GwMxST5KWJw3WZ4V7mjnYze0n/f12Rpuj4WD9adVRM286REbxDoV4lwFgvGmV0X+JGgrtRYSlpTzyoxSe4liZJYKUkGZ+vXaGljx0fDOrZ/yT9hKTEVhqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763105757; c=relaxed/simple;
	bh=HCFB0gf1PTZ8qxvL0c9ZgT0prON/gQ9PbNIYjC4hFrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e/NxF+LeDjWqzzyIQvyz4F7e74vfxnmNMvW8GWDXgpbJDB67QL0zGo1eXMA2yXcjrsEft+sW0K0/MSakDuz5gJm5+ksin8dapiSpCnf+mFrKQT1h3KsSYiJlthZPN8CNlLL1yAvnPOV7zSaPBS7GLb2JBmT5aHZc/4zhs6XG/P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nkw+G5Xu; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-640a0812658so2639754a12.0
        for <stable@vger.kernel.org>; Thu, 13 Nov 2025 23:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763105754; x=1763710554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFLTfYFZo+inPQxPyq4xaMb0Ju+C3NcGaHtCUNuaidI=;
        b=Nkw+G5XuPphbM8Z24zwvM6Jx0KTORY4EHAlx/cE6LCUfVWPLhpDr5VrO5bKeTbvHaI
         xLcOjfliPV60r0j2inpTVfyVPNRmFJeF4HGAazXdkZgZCDN0YsPkSteP21TatNwDEy/H
         am0/pz9AZrClLc1zXKUQ9cc3psQ8AThUsxNm1LIVGCu9yG8uNuO5B7hMgQw8uPahHFUf
         lvsqKI3RD90/wHhVmsNe5R3p3hsFwIq23cHyna8clpI3bHRnFIToT+WSFLMEHL/ikXFG
         9LZL3VJjm2ZfOq7kevlnzWDbYiAAlf1stT4cKwllJqyiQ/h6KUWA9+5Wsb9cxWR+YmNF
         +IzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763105754; x=1763710554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFLTfYFZo+inPQxPyq4xaMb0Ju+C3NcGaHtCUNuaidI=;
        b=epZnpgT8rM41MTCW9Z/rRUYzQrHb7nDFrBwV6wngpvrdPtQMd1ZR9aPciM8043fko6
         J1vnhATev7AEUqUKEeKpx6o3B1IF4un/XN/JZlpcieckwhpdkXZ6S+ltFxsibzoGIB1k
         plPOgX5aUdqOWYiBPk9gYZs94dxTL6h2Z9oftrCiQCAW9GAQuq/z9EEfNw72j6bxDJ9W
         BAHIafDG61JYI32eyJf4Qt2Nr2y4Yc1NoRa0w2T2RD0nVdq9nzn7w7JOdZRqpkIT8i5H
         ZogGI307H5JkjgQsvZxQs7zLIZaxF1pdfvjzWzfnQFKv6fhPe6hT1XrBR6mgftmK22zX
         hq7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXon5dD1bVjLBTafu+XGnAW0sotJ4seU3HlpUQgbGJ/l/V1Dp45G3YNfMV/himD51iQwX2i5Dw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7qJIDlHSqpfTcCVz1GAS5pxdH51qJf+j29FcNIBQVxLf5JAfR
	DHjkTfSfpSHNH1AryUb4CqytDQt0PSZQF1/nDhsVktkU4y/Ub0dtTHHJ
X-Gm-Gg: ASbGncvIKNGqnor1PU17w1J49/9OkdQWIAReJHzyTB8JUT+vxkdhiisbhsJO5ooYL+v
	K4gd3SYUVk77asSX0bWA+EjMUrHALFC6YRhGRljgDsNpAdEbDmtfYYrjeQq15+GDb+QcvnGbzqM
	x2a7GNrwu2LpadrI5qcOvKY8pEz3awMurNzZ3R2TQn5p2D7R1rnu7gzk9tGfhvM19NVcBA7VUdw
	iJUpnNurzTHO82UfzhGKTWUPlj5iD9ED7mm76rxaSVFM0/lHA5SCm6QMMv2b4S6eyKMLsga/q84
	u+JOY3uQGuhGJ/bAquo446gQIwYjwq2LDDM1pT89V5QnGVWLBZQZa7hBXkDrCBOlivS+i55fcOW
	/y4iRKwVfKRRDiogmufNp3Vyuzd+n+/tEBd8iwebziZitJXmBa9eKakIdGe/ZGfrFgKmhdB1h/L
	7ne/XJKt0JjKHrHh9YZCt8
X-Google-Smtp-Source: AGHT+IHP8f4IDOhs+3WdtpM7lYYKMk1Y/gzrU/hQkgwM7xC+v+Hy+cdkWU21+fN20Ut6b8xaehwCWg==
X-Received: by 2002:a17:907:d09:b0:b3f:cc6d:e0a8 with SMTP id a640c23a62f3a-b736786e693mr156169466b.17.1763105753546;
        Thu, 13 Nov 2025 23:35:53 -0800 (PST)
Received: from foxbook (bfd52.neoplus.adsl.tpnet.pl. [83.28.41.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b734fa81275sm330810266b.13.2025.11.13.23.35.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Nov 2025 23:35:53 -0800 (PST)
Date: Fri, 14 Nov 2025 08:35:48 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, Hans de Goede <hansg@kernel.org>, Ricardo
 Ribalda <ribalda@chromium.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] media: uvcvideo: Return queued buffers on
 start_streaming() failure
Message-ID: <20251114083548.54251544.michal.pecio@gmail.com>
In-Reply-To: <20251113214056.2464-1-laurent.pinchart@ideasonboard.com>
References: <20251113214056.2464-1-laurent.pinchart@ideasonboard.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Nov 2025 23:40:56 +0200, Laurent Pinchart wrote:
> From: Michal Pecio <michal.pecio@gmail.com>
> 
> Return buffers if streaming fails to start due to uvc_pm_get() error.
> 
> This bug may be responsible for a warning I got running
> 
>     while :; do yavta -c3 /dev/video0; done
> 
> on an xHCI controller which failed under this workload.
> I had no luck reproducing this warning again to confirm.
> 
> xhci_hcd 0000:09:00.0: HC died; cleaning up
> usb 13-2: USB disconnect, device number 2
> WARNING: CPU: 2 PID: 29386 at drivers/media/common/videobuf2/videobuf2-core.c:1803 vb2_start_streaming+0xac/0x120
> 
> Fixes: 7dd56c47784a ("media: uvcvideo: Remove stream->is_streaming field")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Link: https://patch.msgid.link/20251015133642.3dede646.michal.pecio@gmail.com
> Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> ---
> Changes since v1:
> 
> - Reorganize error path

Look alright, thanks for taking the patch.

