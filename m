Return-Path: <stable+bounces-89609-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 491DB9BB0A2
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 11:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E66B280E3A
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 10:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911C61AF4EE;
	Mon,  4 Nov 2024 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ic+9WT1M"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7118C020
	for <stable@vger.kernel.org>; Mon,  4 Nov 2024 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730714983; cv=none; b=bOF29Qqw4RLkKO02JPVTCkHRACrFqgFBeAX6ylUZarHJ7W6psxnghrgWjzfY5nbqnjcHLaBdQXOmKo58PNGrGkAZs8FRRlskRqfbp64WTvtIL8hnBdnOWjB/yhTKL2nmvz/N4YDOfg0w/iRbojLJVi/rU+jXFtD20cDSO6GHN6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730714983; c=relaxed/simple;
	bh=/mA7xwO17nfudrwhrGynT4Jz/VBstxG5McmGQTgujIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1AWCNDikLkqv2KYybfiy4efIMMNrFd/W2DnadjIT/cFWA1FDWzcMaRCym+rE11X7eeqZ7AxQ5vEjuXQMhH55TW8Mpp4Ev0XFBhY7g+n4R2ukfIGjOC7Gv+PrKspdFjE1GvxnI9BW/apUd/z3vL/Q64T7EGYjuYjov16nJkHG6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ic+9WT1M; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-20cf3e36a76so41764135ad.0
        for <stable@vger.kernel.org>; Mon, 04 Nov 2024 02:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1730714981; x=1731319781; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2NTPtVJiGE7BPjeCGKQ0KHoPZRyzN7fNEfwB/yEgVkc=;
        b=Ic+9WT1MdDZRXSb9qbdg8+dFPGxifYAIIgYH/FGAWZ21kRmTRI/M87PRIzAPP9rI5o
         KHLpYiI0fl5lsp4s8ZOfd+y74H58dhQqlsCOlpSXo7SfWTohWfY8qvjwjTxq+J9AYqfC
         oPwEtXelD8UKNJzv+MLctaZKBfIMF0TNrxsIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730714981; x=1731319781;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NTPtVJiGE7BPjeCGKQ0KHoPZRyzN7fNEfwB/yEgVkc=;
        b=JXPEyUh3CT4ekeZVu3u5Hlkx8dAfBAkDRcGdINHJM8wX33IW4PHCVKpwJZAAG5BiTt
         fCM6qGLx2NI4KVmbna0sAcMUbtbYF8UZ1gXuVVjma6ph0uMMJPUOGbPoX/bN1AYUFITc
         q83w77YOtw0Mltql3af4Hr3fLatWaTqRwV/gJc0MwLRiBFwVlOPBU/7EWy88dQ6kQoK/
         rr4IApQrKe1EjT4fEFKCjtpXGmvJ4H7KQkDbC27dFbMsGlrexgKi23jEAgwrzGRYZEHR
         2FxhsEp2ym1CbjQi6bQHf/g5Cre1s11SFCfVheS+F/+lZfmVoHOeCVm6Ew+OK7s74NEX
         m6iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVj7HZjlI/XozPFOcda2m2Gq7buqhPFTKyCxRlQIjpAZkJzqnbmERrwS1RH+1fDF7r5ADqqkXw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhMzKzhNO0ztFtuwR/E1z5DFAw2+EO1ftTKOwPZeuF6LvaooDx
	oXI3DipgUyP+odbLA3v+zOVi/94pdbdb3OmKjSDpl4m8e8L/yZxD1k39ZK3fLQ==
X-Google-Smtp-Source: AGHT+IHYH3t7ESW1pbuyQj7zVT94C1I2YPmvGXz2YuPhNZlY1eftMl0pWbwj7PJh4W7mfbZkG/rDiA==
X-Received: by 2002:a17:902:c40c:b0:20c:7d4c:64db with SMTP id d9443c01a7336-21103c7bfafmr208351825ad.49.1730714981357;
        Mon, 04 Nov 2024 02:09:41 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:313d:96c4:721d:a03b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056ed969sm57814635ad.1.2024.11.04.02.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 02:09:40 -0800 (PST)
Date: Mon, 4 Nov 2024 19:09:36 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Fix crash during unbind if gpio unit is
 in use
Message-ID: <20241104100936.GZ1279924@google.com>
References: <20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031-uvc-crashrmmod-v1-1-059fe593b1e6@chromium.org>

On (24/10/31 13:59), Ricardo Ribalda wrote:
> We used the wrong device for the device managed functions. We used the
> usb device, when we should be using the interface device.
> 
> If we unbind the driver from the usb interface, the cleanup functions
> are never called. In our case, the IRQ is never disabled.
> 
> If an IRQ is triggered, it will try to access memory sections that are
> already free, causing an OOPS.
> 
> Luckily this bug has small impact, as it is only affected by devices
> with gpio units and the user has to unbind the device, a disconnect will
> not trigger this error.
> 
> Cc: stable@vger.kernel.org
> Fixes: 2886477ff987 ("media: uvcvideo: Implement UVC_EXT_GPIO_UNIT")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

FWIW,
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

