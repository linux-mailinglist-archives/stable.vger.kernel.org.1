Return-Path: <stable+bounces-192272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19905C2DC48
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 19:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B591898664
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 18:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4832E31D736;
	Mon,  3 Nov 2025 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="blTULnaF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537928DB52
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762196234; cv=none; b=S8uVUAaEGfEf0KyOt/Sg8JxpX4TNvYRKg5w3/YbZ2LYishfcPgDJIQhboVNbBgpOUjx/gsy0Doc/O65R07of4ZrODIdBtURkH02Y5HCyCcALloEr/Rs4ZDt33jI7vUXCZ4YwCFZPEYumBKX9IB85EL8bJTkxSB2ivQWXV5Ztihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762196234; c=relaxed/simple;
	bh=Z/xD2z+2YSUXqgcAz/IHOKt8zMT+ItoaZxlJAM3lWW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5v596uod7UKAvofgZ3Om5tJhbbeQuZYbS5n+SyO9F35Z7ClhRrQncwjoKuVlRnKD02cgFbY84Z65uivFzy1q/GnT4s7rcbnRC+4HQBnFU5C24FwmA6tuLH7NzvDLSiY3ISdKMqw37bEtJRDe9UjgHUfisTWueiPrnjmnEnx+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=blTULnaF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso64151525e9.1
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 10:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762196230; x=1762801030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8+eN+6lfnONIl6DhyaJPvMKjY4jky2Hy+ffm+J1z/H4=;
        b=blTULnaFqvUBBSBcMhJJ8lScuXmmnF6U7ItPR07z8gg3E+MPRp6c20ky1qqTu/Q7oR
         iKx6CtTNaJ+b6CQOgNFntTqG7TlxdTWRG7/UDwIDrSYwfkdWAJjfkYjPA9ZnQ78rB7O+
         TxJ8OwtRXqNcSLrpekVGAYxbWitbvBOkdIuZEp5BJWn4P6q3UQ4ksO6tK0L9vZPH0wm9
         l+swc8XTZwsEr2OMGT/FKQWTXB1lTdxPrGacXjL057zcZaaBy1LLo9pk7jBrSII39fG/
         VrXUZso8bB+b6inAkiXEuFPjNRKbAmsZKDqDbomBLrLKeYod8zOVV4ZquqTt0HPGOc2R
         cCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762196230; x=1762801030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+eN+6lfnONIl6DhyaJPvMKjY4jky2Hy+ffm+J1z/H4=;
        b=ecrQeEogMgT7VH5+Wp/wOoqELpdI3DyPMzWtka/f08NXan+eGZ/azIsV3kY0lSGGAB
         KDbYPqd99GD6BNfjStGZpZlv6emxCuSCkpFc3S3E+HXbboGytijbtQEHZRskh8thXv4w
         IFTJMQdVlJpXmeAlf0k9VCd7Ldnhe0PNX30WeBvH7sOlbcBfIXl2TGPv0wkXRvy0nmh6
         Rp+AiSA9YfydG8eBShhrfTFs31v7xNR5ExRKO63USDEtTBGYDms+vif9ayls0fzy7URN
         5Ql0FhGWI5PqRPHBKK+9GNyIZTtY5rUQBF4DJjUhBWZdPGQykYznmCBEqmvpFAVlLHK6
         oYCw==
X-Forwarded-Encrypted: i=1; AJvYcCVHqUhbF6VwxvacOb6y33nG96dtOHGiadbXQgUHlmKSeZbdp8AWmXzxFS9XIf2NmWsv+rh02Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPlsQIc8IsyIGiUPe5tdchlGdj8jaQxMwAODopDvDecv0rHKcq
	bKZVWNDbDN6RItR9sJ9Q0Ro4uftoYvRSW8KFRa6k6KsZS9Z79NiR3I0b
X-Gm-Gg: ASbGncvsh/Rq11tPPsA/WnYa6mnv0HTi6cMcrb4hilwu4kZCSkmzH+/+hCpXCDP5oqQ
	fZ3t+BCNjQ34LRkh906Tin0JpoSDKUBgKkQ0ro1BrSF2/nJOEodzAKHRE3+i3h1rZujgqkHdDSO
	G+w/zYIdTgidu1MSTN9sIxFUgPnheRG6/hZEsslUMKlFIwrJsbWewCoI1vLtErKfZeyd+1rgPdP
	k5YKUSdelm6aELVrsGbNlIMp4ZnXUvzHI/Nn3b6TbdT4rXm5BhoMHDc//ZkT4HWfzH6lNcUZS2l
	ljmmAorKfORvnZ46ghqw2k/X3Zu12XVE1X+70zN8A6KOApkVWxMMGYZtMEZD/T3R4iEz+2MP0Cr
	pOqc/DJuhxLAzkNEyHGbBdpxyNiWkXxy1f46OeKzTv1zGijPDb3wAvhi32/bpLkj/71EHCbYPHz
	p5sg==
X-Google-Smtp-Source: AGHT+IEK2+4nBd40SRJ0qYnaqIkscu36w0iUBumg+gWmVgTn8vW7aAbSUdB2E3eeUqZt28T5ziAh9A==
X-Received: by 2002:a05:600c:a08:b0:46e:35a0:3587 with SMTP id 5b1f17b1804b1-477308c9355mr115909985e9.27.1762196230208;
        Mon, 03 Nov 2025 10:57:10 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:f99c:d6cf:27e6:2b03])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4773d81cb03sm162334735e9.13.2025.11.03.10.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 10:57:07 -0800 (PST)
Date: Mon, 3 Nov 2025 19:56:55 +0100
From: =?iso-8859-1?Q?Rapha=EBl?= Gallais-Pou <rgallaispou@gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	David Airlie <airlied@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH] drm: sti: fix device leaks at component probe
Message-ID: <aQj69wzTceDklx2Y@thinkstation>
References: <20250922122012.27407-1-johan@kernel.org>
 <d1c2e56b-2ef9-4ab1-a4f8-3834d1857386@web.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1c2e56b-2ef9-4ab1-a4f8-3834d1857386@web.de>

Le Mon, Sep 22, 2025 at 06:16:47PM +0200, Markus Elfring a écrit :
> > Make sure to drop the references taken to the vtg devices by
> 
>                                                 VTG device?

Video Timing Generator.  This IP creates a vsync pulse and synchonize
the components together.

> 
> 
> > of_find_device_by_node() when looking up their driver data during
> > component probe.
> …
> 
> How do you think about to increase the application of scope-based resource management?
> https://elixir.bootlin.com/linux/v6.17-rc7/source/include/linux/device.h#L1180

Oh... I wasn't aware of this.  FWIU it is a way to directly free an
allocated memory whenever a variable goes out of scope using the cleanup
attribute.

IMO this is also a clever solution to prevent the memory leak, and it
would be a shorter patch.  So basically, instead of calling put_device()
as Johan did, you would suggest something like this ?

diff --git i/drivers/gpu/drm/sti/sti_vtg.c w/drivers/gpu/drm/sti/sti_vtg.c
index ee81691b3203..5193196d9291 100644
--- i/drivers/gpu/drm/sti/sti_vtg.c
+++ w/drivers/gpu/drm/sti/sti_vtg.c
@@ -142,7 +142,7 @@ struct sti_vtg {

 struct sti_vtg *of_vtg_find(struct device_node *np)
 {
-       struct platform_device *pdev;
+       struct platform_device *pdev __free(put_device) = NULL;

Best regards,
Raphaël


> 
> Can a summary phrase like “Prevent device leak in of_vtg_find()” be nicer?
> 
> Regards,
> Markus

