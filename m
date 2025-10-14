Return-Path: <stable+bounces-185588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AA5BD7F8C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 09:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C34FB4E2C55
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 07:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADBF2D94AF;
	Tue, 14 Oct 2025 07:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MQLDKaai"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C4D2D3EE4
	for <stable@vger.kernel.org>; Tue, 14 Oct 2025 07:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427551; cv=none; b=hnv7VhdsyjTza3E9b6V+28bH/vPq/BlGOXyKYIQWHoUyjrbYOF7yGt76LA70pyJHwY12FuABqbCoj6+THrLnLeR6vBUfRKJPXxWm3uDZ61JevPm2kntQ2n+DTQVnmtbVztdfrLToTWtbmf1uY7ENkm1KSodHcUL/MsILSz+xjh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427551; c=relaxed/simple;
	bh=Ws25b5KIlwTyCP8dDyVIBLRtzRsitC0cQKdPkKx5rKI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pswAMmV/jScvmGSYLXjT3fZowTIEDt9wSiRjU+wpGduNfg50PRd5Gr0bW0GvJOKEqftSExm03OGd8T4KU5luBU3Rg5GhOPJdWlNdzddSw5+fT9wkPYjRpSRZU7Rps9/oj3HReAZRmBfIuPuSSxSzpSF8qPKPv3yl0y2nXwlPlgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MQLDKaai; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760427549;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=I+mNHQsLdfiv7vvTT3E1UI4YOke0x16loHcS0d4AOZ4=;
	b=MQLDKaai5WqoMeKkVhL5qiNYP7gjBPWmj1uk8J0VWoMR1Tgo01ja4mstwwH5QZNOo7dJmz
	v6Mfp7r7day3XuNRRhUVxjsE+IQGkuBFGTxrjovQRpfeZ2fGNAO3AARdUaksgJIyPu9614
	OXF0KZqH1EmjUAk8Z6jx5ZGmNDx4Huc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-jfMzzfFHOtegstpEx1O4xA-1; Tue, 14 Oct 2025 03:32:50 -0400
X-MC-Unique: jfMzzfFHOtegstpEx1O4xA-1
X-Mimecast-MFC-AGG-ID: jfMzzfFHOtegstpEx1O4xA_1760427169
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee888281c3so6226896f8f.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 00:32:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760427169; x=1761031969;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I+mNHQsLdfiv7vvTT3E1UI4YOke0x16loHcS0d4AOZ4=;
        b=Mr/N7e5od6FnPnbLpf0JyWMF/soOTbrznoY2dKI9q5msHr4v/TvNC0Nu/UoiZtQly3
         oQLBPvDil2UPskGRCPzRerxbz9fFjvX/UHuVKncIOGoVjsGzjDvtH430PR2shGktBNO+
         wAcrmp+9KZDlYlJ3+3REBf1Dzq9+JX1NUY8rGq3cghd7RPLYdw+hyJI/EBmJPKAXITkt
         wylCkMQ3BSE3/ad2rT5zEN7vsMR+A2+m1XxIul3k1AqUo6P/fbHcLC7qeS8lBfBb0ZlY
         akoUN7nQ8tuMWB8l7QfEOAfP+LeBuUXWcXglfS09R/03VlgNrXAzGabyBqo26wCMTzU1
         RS8g==
X-Gm-Message-State: AOJu0Yyav1UK4sprfNvfGGLpyafETJSJD0Beb5QJDolFdLeFEMOG/3ju
	GlQd/xLqyVATE5N01fOVwj4gajlvxnSML8PaaC3dY7JjehZbGp5i2S0VVQaGOiFPOHWiPd4L8aH
	zrur/zBynVnd4BAZ/6T/MkwNmFyVPiXxbLggbaiPiYUJYuZdlCk2SjV0LbQ==
X-Gm-Gg: ASbGncuCwxFcWL+yVRFpddA+Le1gMbCgFF2LC/DfmezofrcIdlUCoXtJjiqGd1HPKqq
	MkZoqOE2nS4KO53zfVVO+PcmWqlsBVQKSMAUKviKbW2LH9RxnuDIwXzI6rS7QwI97vdxc1rcuP/
	SmjvlnRcDiRX9beRrC98E4TtnHTlaNG6MaNZ+Ufwo7YzJUgBQM1RP/9ExUTg/0715DYoPJgmwZY
	b3AiJXiDX3K3s2/OYle7EkrYCjcHR8hs6tPdnsKdgawbl6Ul7ASJggs9J/6kmXbz0IIA/NTg40v
	4e7wiZ1RJIQtTjZWZjByg77MmQP9h9dAcYHl8WYSerw/+d4vQRflpZe7cyoK8Ivt1BqNSPfQnyC
	WdqpgAkE8wHhRihTephA2MdA=
X-Received: by 2002:a05:6000:4023:b0:3ec:e277:288c with SMTP id ffacd0b85a97d-4266e7d90e2mr15348992f8f.31.1760427169483;
        Tue, 14 Oct 2025 00:32:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpkrFos/JoFF/exw8H13iEBsM6KPGAsZOyXjflOcvr7yhgSOkA9HU+kH6Zn/mcbepjNdm+gQ==
X-Received: by 2002:a05:6000:4023:b0:3ec:e277:288c with SMTP id ffacd0b85a97d-4266e7d90e2mr15348979f8f.31.1760427169091;
        Tue, 14 Oct 2025 00:32:49 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5833dcsm22073162f8f.19.2025.10.14.00.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 00:32:48 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Jocelyn Falempe <jfalempe@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jocelyn Falempe <jfalempe@redhat.com>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 2/6] drm/panic: Fix overlap between qr code and logo
In-Reply-To: <20251009122955.562888-3-jfalempe@redhat.com>
References: <20251009122955.562888-1-jfalempe@redhat.com>
 <20251009122955.562888-3-jfalempe@redhat.com>
Date: Tue, 14 Oct 2025 09:32:47 +0200
Message-ID: <87frbmq6ow.fsf@ocarina.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jocelyn Falempe <jfalempe@redhat.com> writes:

> The borders of the qr code was not taken into account to check if it
> overlap with the logo, leading to the logo being partially covered.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


