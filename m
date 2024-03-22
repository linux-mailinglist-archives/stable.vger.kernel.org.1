Return-Path: <stable+bounces-28608-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 312DD886A9C
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 11:43:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3EE31F22281
	for <lists+stable@lfdr.de>; Fri, 22 Mar 2024 10:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE353D3BF;
	Fri, 22 Mar 2024 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GXt0pcKa"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22DC3B2A4
	for <stable@vger.kernel.org>; Fri, 22 Mar 2024 10:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711104223; cv=none; b=hwk22jlu3r+3xqx6on1eJNQQRickr4QrqM7yOGAmAPbGRBV38MUa2rqOan2QwIRj1H4betr0bIa4v/b11tQHAYoLpQdK3AvGwVyaVV+C2L8ISKvUbzx3JGLG77FF0HEYVqeweO2ZUwJ0YCE7SEy9RvVyJB6R5Yypx/zjw6UMBWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711104223; c=relaxed/simple;
	bh=S8Z7aChjuflwNhwZ9CR9vs1643uDXcQF3L3Qw+I+IUk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=D6/FXwwe+OdPqYsyP6mKzZaJRNbj5FzaWAe0VOBEcScnsoaTNKEc2XXG6Hun96VUA+GUwqAQRfCxtmiHOVUt9Z2/PwSqWu2YuWJPfpjaxDnt80+CnzM0Jbzg5XQLRekRcbaLyfq2bAgQtKPPqoxnkDxi9rFIDHvTsZFM9tgCy3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GXt0pcKa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711104220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4hqr5sqga/uu4OSt9i/tA6ZdLVrKguR4cLu3EI2g3Y=;
	b=GXt0pcKaEhclhYYXwroSn1rin/GVpQilNW97ug782OqZoyhZPjhwY34SSIQJIi4Hl5GhsY
	w8FPf232QAxy0j166Y4EZJ3GkoSInYZ71wxzFtv+5UENbCvoeJR0epgELmJHP3Y/HEauky
	pDetvwD96J062+R8JpRfesX5DFtJULE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-rUokSxPMN9SQqTlojz6lCw-1; Fri, 22 Mar 2024 06:43:37 -0400
X-MC-Unique: rUokSxPMN9SQqTlojz6lCw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3418f237c0bso893638f8f.3
        for <stable@vger.kernel.org>; Fri, 22 Mar 2024 03:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711104216; x=1711709016;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e4hqr5sqga/uu4OSt9i/tA6ZdLVrKguR4cLu3EI2g3Y=;
        b=xTOQu/RZlrsru4099/sgk0WYL/imBq1NODxRWjtQxeKC8KHNxVf6Ro3mJFWjz9RFn7
         l4l13PedBy/07kYfwSbKqEgwpRNG9XHZ9QGlnWcXeJHGVfOklLs2YYWZrNNFjkUoVSqy
         VapN0SQFuoDR4Q2cnsZ+tZb67PlQdi1HrClrl9ATZXsgsX70Wnt4dhv3cFk1pGf1/ynZ
         1I0MTeepu6m8IiA35KZQJFuPRX0tTA088HNNtaNa4i2L9TUcVcVmnnf9llSj0YexWu6g
         dl/si3fqLZmNz6BgeTAG57lixNIOA6C0rWvWIxtk9noCF4IcvkzkQLvxiHWOpyKi2AOt
         qCRQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCqmTP2T0xepLqjIRVcuEDvTuQiZD5L8zmo+sehtVMutvCLR9Ml7nIOlC9QH6VI5hrchbXYQOBYbcbkqi2mIzm4fyFd/0I
X-Gm-Message-State: AOJu0YxWOElVtx+m1WAdO//oMNfvwFZiKgtsKrVxILCoxQh0lzAaAhsR
	X8g2s76vRnorXdfPPaiOvm8rZcuq9wJHo4k46q41jQRPISzaDwey+8iQdz8MHd9VCT8yoqAWvpK
	o5j/E1QtrHqw7yiMnIk5Vt7Zwe8YuPTx2Hn0GNMY7Vple250Kxoc9kw==
X-Received: by 2002:a5d:4145:0:b0:33e:9451:c299 with SMTP id c5-20020a5d4145000000b0033e9451c299mr1237992wrq.26.1711104216104;
        Fri, 22 Mar 2024 03:43:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFsAkU+2jK4kRfvDnw8i0oVWh6n19VVa3BIi69kxPxPYLEkn3rIbnPUV1SFTkGh0njd+owt8g==
X-Received: by 2002:a5d:4145:0:b0:33e:9451:c299 with SMTP id c5-20020a5d4145000000b0033e9451c299mr1237971wrq.26.1711104215672;
        Fri, 22 Mar 2024 03:43:35 -0700 (PDT)
Received: from localhost ([90.167.87.57])
        by smtp.gmail.com with ESMTPSA id n10-20020adfe34a000000b0033de10c9efcsm1771312wrj.114.2024.03.22.03.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 03:43:35 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, nbowler@draconx.ca, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Arnd
 Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert+renesas@glider.be>,
 stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: Select I/O-memory framebuffer ops for SBus
In-Reply-To: <20240322083005.24269-1-tzimmermann@suse.de>
References: <20240322083005.24269-1-tzimmermann@suse.de>
Date: Fri, 22 Mar 2024 11:43:31 +0100
Message-ID: <877chu1r8s.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Framebuffer I/O on the Sparc Sbus requires read/write helpers for
> I/O memory. Select FB_IOMEM_FOPS accordingly.
>
> Reported-by: Nick Bowler <nbowler@draconx.ca>
> Closes: https://lore.kernel.org/lkml/5bc21364-41da-a339-676e-5bb0f4faebfb@draconx.ca/
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 8813e86f6d82 ("fbdev: Remove default file-I/O implementations")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.8+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


