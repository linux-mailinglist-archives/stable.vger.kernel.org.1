Return-Path: <stable+bounces-127338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC014A77DBE
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 16:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B315F16CC96
	for <lists+stable@lfdr.de>; Tue,  1 Apr 2025 14:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDB6204C2F;
	Tue,  1 Apr 2025 14:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="mGTjgFrW"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD4204C02
	for <stable@vger.kernel.org>; Tue,  1 Apr 2025 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743517791; cv=none; b=EcFkp1dgULBuxqtgJX2aE0OA5e/831cNhzgCzdWE0WdDU1qavn6a9ICqmdGIAdhzSpOpr57fgT/ggLpjzyViNMBpttYDUBprUqbmgmTi1senc/GTjUUU9X2LX6DI0XYNCS3F7xy34cVkcNsU1GlkAUCskyQhnYLGbyJqAJVEhzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743517791; c=relaxed/simple;
	bh=4+DXyGZpy3baMIIEpJypfdpYsotPYKsxA3mI/UuDijo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U64679HS++K1BPgMk2yht0qiJyTeeFB3+zMYgfGfwj7AU2NXurg8yktFSpPoPbDftibpo1czVqKqaToA1tzjnXYaXNA5NMwnhVqBz6QjJLUddNOVEKZBIoWoUoPU9zQHbRHsZ83mq1pWkTpDbXNZLFfCv+iYtcxVcDUP747v+6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=mGTjgFrW; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf680d351so37755585e9.0
        for <stable@vger.kernel.org>; Tue, 01 Apr 2025 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1743517788; x=1744122588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4+DXyGZpy3baMIIEpJypfdpYsotPYKsxA3mI/UuDijo=;
        b=mGTjgFrWukuCgEL1V89KWiCBAZVaAwkfyWfauRCvEJmnXY5lHfl+spBQxEiMyKK6fe
         dkfqaWxw3weMe4lRZ0SyTzMNg2+nY4+ZD1YhiMH3lMXF9lFZ+WjvgJAWQbZKLK0wKZv1
         EfzkhPpIHr93ggh6ADw0H6f0usvjyhd6tNThiu8VdrJWJVYOzrwCRYW0PmYONL/okXlV
         otpSUU1h3Vz9Uffo0qLBoD85WV9FiQO8sAfyjCLv/X9mybzyJQShC0jtjElLthqPtO3r
         L6bMncHQR5tCaQ5daeBc6i2fsB9T5lRyjfGfxnhRr9gu2yEjTe3TaqXzUrDWXvYcVhuo
         sijQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743517788; x=1744122588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4+DXyGZpy3baMIIEpJypfdpYsotPYKsxA3mI/UuDijo=;
        b=MmFkmuLJ4YCutU9zqyVkCMpxWsDFhok0YK0hWSVZqrEPWoxe1qma8uI8w3NTevbUS0
         qeAgGzPtGpD+1kpvtt8njWCFO7l+GIIyzSESP7aeVB04hu7yPuPmhtLk9P+X0UJj/jMo
         JGt+Mb/lsY8vQw/FGRW3LPKid3iCIt12FoSxS35UOli5/TE3xx7TRV7pzEQYMZj0kVrd
         x9lYfyvIUDRN7NYIyKBXQGixrxVB6RJGWj4SClIE1858oDmg6HKoxHOEQYOKuH7Tr8pq
         DfhpszCSShzH9O5d8w0SXVMRz7XfrRCu30O5enfRWFJwQiOPdzHlhcMG9WMNKwZ/JxoR
         WowA==
X-Forwarded-Encrypted: i=1; AJvYcCXqWxMN217TV2kqHc65L435KtJ6RwNGXaAel6i7AT4AillPDveLR8R5yDnS3Ln8I7fF8EaD3x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8MDt91J4wiqsD5l1EdM7luTvL/CboZA6Y/k2QPtD9Q9OOMKo/
	/3rJ1otjegJ60KNnACKZekNhrKilJhUtb/rWbrL8GSh8TdOc03ZC5BcbKm7XFck=
X-Gm-Gg: ASbGncu1ZQ9gv2tO02APQX41Yc1DUl0jL5UpvkytAk/W01B48kytLdWfhwUc9J7w09W
	msRCRMyrfgJq6CwA/wuKE4eAI0aJinjRc3+nZDDmeT/8xkCHLKgU5SRNthBD+m89hTlE3+bDNXw
	O7d1RSxO65UX5+pgW1//6KgIfJhOd2JYjYMka0d5zxBm24Bnp+HIpYwVGCqPZF/snqAu4hjQzfw
	q9omjFo3n5aBlNjfSM7NgG6fm9yP+0ePmltL9BbIuAtA+QKOXW2lmunTUGtXXo+gO4k8jN5HIGU
	KqqU2iyF0IThCKMAMZmIAFjLvquKc2kyYFbJn0uwAeS3Df9HGlw7WND8lMA/jCto3kwV2L2CTA0
	P4RBAmj2PL/4tQCvZgPzuzd67V2Q=
X-Google-Smtp-Source: AGHT+IHNx4vQ9HZX3k4j4jTP+pXfpW+zl8Y4RdgON0AYVMnFWqF1w5VQnDHa4fobYb4eHhHiNIy/Pg==
X-Received: by 2002:a05:6000:18a2:b0:38d:ba8e:7327 with SMTP id ffacd0b85a97d-39c27ee84f2mr205051f8f.8.1743517788210;
        Tue, 01 Apr 2025 07:29:48 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66a9d2sm14254936f8f.43.2025.04.01.07.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Apr 2025 07:29:47 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:29:45 +0100
From: Daniel Thompson <daniel@riscstar.com>
To: Haoyu Li <lihaoyu499@gmail.com>
Cc: danielt@kernel.org, chenyuan0y@gmail.com, deller@gmx.de,
	dri-devel@lists.freedesktop.org, jani.nikula@linux.intel.com,
	jingoohan1@gmail.com, lee@kernel.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	stable@vger.kernel.org, zichenxie0106@gmail.com
Subject: Re: [PATCH] drivers: video: backlight: Fix NULL Pointer Dereference
 in backlight_device_register()
Message-ID: <Z-v4WansLWJtv9CV@aspen.lan>
References: <Z65fFRKgqk-33HXI@aspen.lan>
 <20250219122950.7416-1-lihaoyu499@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250219122950.7416-1-lihaoyu499@gmail.com>

Hi Haoyu

On Wed, Feb 19, 2025 at 08:29:50PM +0800, Haoyu Li wrote:
> As per Jani and Daniel's feedback, I have updated the patch so that
> the `wled->name` null check now occurs in the `wled_configure`
> function, right after the `devm_kasprintf` callsite. This should
> resolve the issue.

I'm afraid this patch got swamped in my mailbox and I missed it.

Worse, we've just been discussing and reviewing a patch for the same
issue from another developer:
https://lore.kernel.org/all/20250401091647.22784-1-bsdhenrymartin@gmail.com/

So, I just wanted to acknowlege the mistake. Sorry.


Daniel.

