Return-Path: <stable+bounces-55849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769A79184CD
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A68621C21CBC
	for <lists+stable@lfdr.de>; Wed, 26 Jun 2024 14:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA491822F1;
	Wed, 26 Jun 2024 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GElyynqP"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A708415D5AB
	for <stable@vger.kernel.org>; Wed, 26 Jun 2024 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719413283; cv=none; b=qCN5tHS+2GD+11GZySaz+bxeB+lXkFN592fxAJ9D2DfRwpenwzNsytbJcZNiAydvaXmNNDjh6XhdxoVP6lIrFzcjdmSBzH+m1tnqxA9IXDlne6P7lJ2pAdpAEC0ScCAV0+C+4aaNvBFydEDn6/hnJ3Zd4yEqsDItSe2gPfZhW2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719413283; c=relaxed/simple;
	bh=5Ryv2L7wzmaide0wCWArvGAK4sd3G0Db4JFqzlRX0Es=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MEMOEI7cdXw2F5DKWlK31mt9h/p9XkmPhg9XVE/+rLaPijpuYd4fX82itRpbWTumjvgY8EX0F3vMNdxOA51KmlDtOhvgkpjGNFgrpB7nZYQ3YRNop6NmjQF2nJ4eFxE8/W2nhKTQwOGdfRA6odbbHgKB2QK5Xpl0ID5+Q/WfgVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GElyynqP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719413280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eYt5kb05tGM80IO8nBGJUTnLOSBS+UoyBRCwpxbLfyI=;
	b=GElyynqPhMHiFrMDlANcsPVOqDlWdtCV9P6hsk7Sy9BGrVHd8dUISKYqkIKXcxw3uDlXZy
	iGYdq4uUoC2x+KmjJP1jSOMrjZ5FO8s7k0W7Z5lSPJlLy4mSDa9c6sm54PUBLQmGe+51E9
	AWRLXb6214DYmU1ZXhHdKYLxkSjlVRk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-s9fl_LUuNEKXiaSa94GitQ-1; Wed, 26 Jun 2024 10:47:58 -0400
X-MC-Unique: s9fl_LUuNEKXiaSa94GitQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42183fdb37cso46848435e9.3
        for <stable@vger.kernel.org>; Wed, 26 Jun 2024 07:47:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719413277; x=1720018077;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eYt5kb05tGM80IO8nBGJUTnLOSBS+UoyBRCwpxbLfyI=;
        b=UfB7hUbjzqv9mv7aZbTJEASwI/Za2M1erKr2x2im2x7ZMPmhs6OKhhyTre847H3K1G
         I/YqrFvBASn/Tu5N1cpVpYD16sQvZ0z4B2nRnfrmtE8eAueiTTlMf67Ieq9/hsQwLfIS
         4Dw6KAL5tSFV76DDy+Y9n2bT433Ndgoi4aKdtkqfVUOwc6fv3JcbyAG7j+YPURwyHxbC
         Cpw95IU+UqCHR7cYWSPZzHatFY6UGNMmASIRhkXnfcOuZzONC5N5fkuftRlDzLbm8jPL
         4ESnVLWV+4uOZOT2s/cbGZONUCzGl30m4qvUgWcuEMGZsfOYi+Pet2UpACMwYMLidhXP
         FmLw==
X-Forwarded-Encrypted: i=1; AJvYcCX4oyATRlCxNKAhCPACa6+ADBlr3znOXBkufCQQx8Z0jMFVKYx1qzt3fnmqnXdq9jGn2lxpRRL32znUt+n7aqejwpePyXF+
X-Gm-Message-State: AOJu0Yz9ItAqX1cLgFnqKWAatNPN+PbxYhLJN/ybcn3+pSeQK19577Zm
	UBpbvt4jlvXe2SE09QbCgMO5Bj9JirBV0upP8DAf+x9JbiLJZRGKdEe4CKx+q+tsopiC+pxqrpV
	pBxg8sO4IG7jwEiwMiVSi6AEcFdlMW+XbQT9hH5UK8mplxLFyWq6qOA==
X-Received: by 2002:a05:6000:2c5:b0:366:e89c:342b with SMTP id ffacd0b85a97d-366e89c34bcmr10728907f8f.52.1719413277555;
        Wed, 26 Jun 2024 07:47:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkoG2YOIq/yG0kgniqXpeQXkzwdHGL/u9q030ztQSVeGx9YNZ4Mf5z8xcvsmSAKD0jVbAf7g==
X-Received: by 2002:a05:6000:2c5:b0:366:e89c:342b with SMTP id ffacd0b85a97d-366e89c34bcmr10728886f8f.52.1719413277083;
        Wed, 26 Jun 2024 07:47:57 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36638e90ccbsm16017265f8f.59.2024.06.26.07.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:47:56 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, maraeo@gmail.com
Cc: dri-devel@lists.freedesktop.org, Thomas Zimmermann
 <tzimmermann@suse.de>, Helge Deller <deller@gmx.de>, Jani Nikula
 <jani.nikula@intel.com>, Dan Carpenter <dan.carpenter@linaro.org>, Arnd
 Bergmann <arnd@arndb.de>, Sui Jingfeng <suijingfeng@loongson.cn>,
 stable@vger.kernel.org
Subject: Re: [PATCH] firmware: sysfb: Fix reference count of sysfb parent
 device
In-Reply-To: <20240625081818.15696-1-tzimmermann@suse.de>
References: <20240625081818.15696-1-tzimmermann@suse.de>
Date: Wed, 26 Jun 2024 16:47:55 +0200
Message-ID: <871q4jkbfo.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Retrieving the system framebuffer's parent device in sysfb_init()
> increments the parent device's reference count. Hence release the
> reference before leaving the init function.
>
> Adding the sysfb platform device acquires and additional reference
> for the parent. This keeps the parent device around while the system
> framebuffer is in use.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 9eac534db001 ("firmware/sysfb: Set firmware-framebuffer parent device")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Jani Nikula <jani.nikula@intel.com>
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Sui Jingfeng <suijingfeng@loongson.cn>
> Cc: <stable@vger.kernel.org> # v6.9+
> ---

Looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


