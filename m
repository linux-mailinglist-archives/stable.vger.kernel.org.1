Return-Path: <stable+bounces-107950-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A031DA051CB
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 04:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99CA2166D49
	for <lists+stable@lfdr.de>; Wed,  8 Jan 2025 03:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08931225D7;
	Wed,  8 Jan 2025 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bddwJI7x"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CE2E40E
	for <stable@vger.kernel.org>; Wed,  8 Jan 2025 03:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736308661; cv=none; b=kFI8uifk4migB3FhDgSHYlT2WC0M0jEice3EWF+jrzwCV2/Gb5mfJGG/erqWIx5FwQ2p+DEhM3KDleFMniBin9AGOOK340wJe49y5bVLqATW3rBwEg21Zj8L+qOsm8FOkmYQHqY69TrHY7tbOQZgwhuJ0+DbyT1ex6HLwCAKfFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736308661; c=relaxed/simple;
	bh=HFAP6Z27ggflbOwbqei/tPnM7E/jc5voO6Q/60x7cCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbGMc2tm0Lz/tNmD8vLOmjO7EX51fR4F5A88Xs/twSMyUBCuXiRPThOiE/Z466U/NUDLyuRKX1FLY2uOyr4N/73HBNLizE9m3AeBdfOltpFTF7WXJWlF+utS9QUYOOTq5CGeC+HtlRIHTIMxoSumudz0Y+ULqMIB5hx6q72JB3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bddwJI7x; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso19392300a91.1
        for <stable@vger.kernel.org>; Tue, 07 Jan 2025 19:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1736308660; x=1736913460; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IponVW/M+FnCmeuwMnKczDOxfpK2ZzCUGsvfkspw3lo=;
        b=bddwJI7xAVbm893wWSzIqyfG0uiXBbc4PsEWW5NruETf5cePpdnAjftEbLpZAZfJCc
         ZStSj4s+p38gAXMWdheZltGKhnUYYMJpTXMbMcE+4rc+t7q3eglDHTX5A5ZQOPG9ns8g
         kfQZpGoeVTjpbZq4PshtsT6k/MjQm07V+2UyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736308660; x=1736913460;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IponVW/M+FnCmeuwMnKczDOxfpK2ZzCUGsvfkspw3lo=;
        b=emy+zOuTDU6RJOs7HntjdAsG84x5ZkJXm6R9adcQq5FPgFfvJB6AQsJ7Yu7vTVTqDV
         Ky6Etl6/brGn7x/qmyvX/4tS4mm6naDWBmIfIqFT7u1uOI5cY43OS64ktnswioDQsRlL
         wAmliSDEFjz2pKLIMi+iXfUEw6jgGiSNuIR8GuyhVX4RmsVOz3sj4T4Xp4mzexmbSZam
         UdlH88I8Rz3RyPTaWMJ9f3KRc/HM3w7JYmUG/Ld0tYj6IfwbmtPiP4+/Iov1ZYtXbXcI
         L/J/YQ/deZ+4HvCz+u+DWHY+XdEqlh6PXtpCiQEumeqXzalicuJdK7Edohs4IO65eMkI
         h4oQ==
X-Gm-Message-State: AOJu0YwMf6CnBgmQI3tLthXaUqj1GYBDdgvtMVD9Rm2rfsRSYqitq0xg
	+oJAKyTeShybbaV76pVD88h5R+TdQV8+E5U2xDOACt6JHl2nBUMFu8DRtM3ctw==
X-Gm-Gg: ASbGncu5sUirue1gI4kH3PEMgaUhvxEFfSFFvH0iaGp2yyxUO41MXNaYfHVSdj+PlnW
	AH7W7rQRCy9q5pmCtq6EPnbcd32Ryzpq818UfyYBgi2TtGhN7U4LXBHOmT13XWPyv5usoZZsAHB
	S2x0a9WAqbQpG9son9xVxfdxIUyrsmAgx1VKrUMwvTn4ouD0a1oiOPK2uuwuqWhBIX99kcwJwcs
	gOGUqdpt/no8hgNOleYbzD2FzwXmrQZEM13WMZFcZBNtC0T9D2dlAlrBwVG
X-Google-Smtp-Source: AGHT+IF1jV4TMg8uxC/I2vIoxriNkws4tuVNpHjLTgWdv9bAUYjLRlHBJroU8Xxrj96i568sNEJiSA==
X-Received: by 2002:a17:90b:56cb:b0:2ee:c04a:4281 with SMTP id 98e67ed59e1d1-2f548f102demr1967055a91.6.1736308659843;
        Tue, 07 Jan 2025 19:57:39 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:57ef:1197:3074:36c2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f54a265fffsm402107a91.2.2025.01.07.19.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 19:57:39 -0800 (PST)
Date: Wed, 8 Jan 2025 12:57:34 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Kairui Song <kasong@tencent.com>, Desheng Wu <deshengwu@tencent.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.1 58/83] zram: fix uninitialized ZRAM not releasing
 backing device
Message-ID: <fg53jy5btcr7cgfltwknct766wdurl34nkblh3wylhiawz2vje@zh6p4yc4wdjt>
References: <20241223155353.641267612@linuxfoundation.org>
 <20241223155355.874444273@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223155355.874444273@linuxfoundation.org>

On (24/12/23 16:59), Greg Kroah-Hartman wrote:
> 6.1-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Kairui Song <kasong@tencent.com>
> 
> commit 74363ec674cb172d8856de25776c8f3103f05e2f upstream.
> 
> Setting backing device is done before ZRAM initialization.  If we set the
> backing device, then remove the ZRAM module without initializing the
> device, the backing device reference will be leaked and the device will be
> hold forever.
> 
> Fix this by always reset the ZRAM fully on rmmod or reset store.
> 
> Link: https://lkml.kernel.org/r/20241209165717.94215-3-ryncsn@gmail.com
> Fixes: 013bf95a83ec ("zram: add interface to specif backing device")
> Signed-off-by: Kairui Song <kasong@tencent.com>
> Reported-by: Desheng Wu <deshengwu@tencent.com>
> Suggested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Can we please drop this patch?

