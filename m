Return-Path: <stable+bounces-64808-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB469437A8
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 23:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A444C2848C0
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 21:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AF11607B0;
	Wed, 31 Jul 2024 21:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW8tycoB"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9231BC40
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 21:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722460715; cv=none; b=oexcoiGDPaYPlo6XPsJ+E9LcO/3UkSEdASIDxfAIIcqSVCWCf5KHgzSeQR0eYra/sU19FDXD8qO9gqXdR1ODMd2HnLBc72xJjhplC607YvtV5xiXYUVIpYx5jH8fV1gs5qYcBZBlvWiPbW5mzaf6kPnhLZI/aw7D3T8iyqHAcKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722460715; c=relaxed/simple;
	bh=NqiclvbCP2OQ7Ina8jDYF9/McnZrsd+Z4GR+MnQQhls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGlN5lyOrDV50HEr/pLF99SIBdKn1mQCsZDXcF8X5dNJydFb7oDIU8VCiOfuMpaM/vEqTCxB3jOpt4BuJXnDpacSfyAQgJVe/l/JrzY9p58r0Vcr5ho0bj42z4PMxNW41auMgCRlma7yhFvqRmXUEdmkOZVmcTBdzOVkOTg5Kw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gW8tycoB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722460712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bKdInG1OtpKpxRilEfiRw+XNZcY8cbOzLiAZonQhq90=;
	b=gW8tycoBJO1ORvyVeCX7SwITAU3n1uxR5hkxPeIcR/u7UubyGI4xztkgQ3SPD3N8qSxPu8
	rZoTRwLYanOD2wwcnu/+q0EMdB044J9l+kUkuuPURU758HtzVh85VvA/OY+rEApxVZNpat
	5TxvNVGsudeU1dqXT6RX6ivdRXH3h+Q=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-A0Mj2rUBMJKUkN4wNQjOmw-1; Wed, 31 Jul 2024 17:18:30 -0400
X-MC-Unique: A0Mj2rUBMJKUkN4wNQjOmw-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52f0108a53dso8259900e87.0
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 14:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722460709; x=1723065509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKdInG1OtpKpxRilEfiRw+XNZcY8cbOzLiAZonQhq90=;
        b=EN8wQOa5ywwEWDbVmarECltgGNrWbcO1ef3LaiuSONpx/hb0C+6AVgOsardjkmzv5N
         93IgBiJOUaFy+CH9cc4rAxznr9GNPzUxfp/wQmSiVzv7ivrB+cR/IdOROIDsoK4yLj1Y
         h/uygi0YWLmtcISozc1UxTURNozia7fLh7yVYxZ/G2XTCazEwATDDg1ctmNHAjY0Rj/P
         FMctH4JWMMAizoanQnGdexpfi7fy/Nct5mfrjEk+q/bw2Q343mfWyyBg4KQO9Ic4v6vx
         RnMIaR/Ig5Zj5/ZcS8zuOB38fgEDmdqPfNulOsSwGLvH8BBEA+7PeP0Wm+qcO1Cy3i3B
         8BOg==
X-Forwarded-Encrypted: i=1; AJvYcCUDgPZ+A45qHXMO1M4Dr/TG+MgZNa12zWi6//fJvjbgc3hZT7e1c1C1z+/zS45iN4zAj6wg/+e+Y62BLhlgVm/YtTDBnTCl
X-Gm-Message-State: AOJu0YzBupFKpJ8bD3cP/T/rZw6FroHUAD5nkwNFiGjYhlkZvutFw2T8
	eWCvBNLzeJRHAs2WUZYOa2B5kW0f7pW1pViKVu97tXJ/4reVE+UHKTYIzaLl018+S2o32j2DZqH
	1uOqyafpmUYQgX1FnH6L0kFhOzh/kcmme8gCYuBIEJUkkYupydNPpZQ==
X-Received: by 2002:a05:6512:b05:b0:52e:9fd3:f0ca with SMTP id 2adb3069b0e04-530b61c8b29mr166281e87.33.1722460709331;
        Wed, 31 Jul 2024 14:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFAl7TOmiwrb7SR7IgnOM2SF/1zCAF5fHO3YQpg6C1uxKqXSkE3RpxPj0fCYXGG+w88vd9rOw==
X-Received: by 2002:a05:6512:b05:b0:52e:9fd3:f0ca with SMTP id 2adb3069b0e04-530b61c8b29mr166260e87.33.1722460708510;
        Wed, 31 Jul 2024 14:18:28 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac63b59c95sm9280320a12.50.2024.07.31.14.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:18:27 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:18:22 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Pirko <jiri@nvidia.com>, stable@vger.kernel.org,
	patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.10 259/809] virtio_net: add support for Byte Queue
 Limits
Message-ID: <20240731171750-mutt-send-email-mst@kernel.org>
References: <20240730151724.637682316@linuxfoundation.org>
 <20240730151734.824711848@linuxfoundation.org>
 <20240730153217-mutt-send-email-mst@kernel.org>
 <2024073119-gentleman-busybody-8091@gregkh>
 <Zqph1kRQx0FU4L3I@nanopsycho.orion>
 <2024073128-emergency-backspin-11ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024073128-emergency-backspin-11ff@gregkh>

On Wed, Jul 31, 2024 at 06:12:35PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Jul 31, 2024 at 06:09:58PM +0200, Jiri Pirko wrote:
> > Wed, Jul 31, 2024 at 07:46:26AM CEST, gregkh@linuxfoundation.org wrote:
> > >On Tue, Jul 30, 2024 at 03:33:18PM -0400, Michael S. Tsirkin wrote:
> > >> On Tue, Jul 30, 2024 at 05:42:15PM +0200, Greg Kroah-Hartman wrote:
> > >> > 6.10-stable review patch.  If anyone has any objections, please let me know.
> > >> 
> > >> Wow.
> > >> 
> > >> It's clearly a feature, not a bugfix. And a risky one, at that.
> > >> 
> > >> Applies to any stable tree.
> > >
> > >Now dropped, thanks.
> > 
> > I wonder, how this got into the stable queue?
> 
> Stable-dep-of: f8321fa75102 ("virtio_net: Fix napi_skb_cache_put warning")

Well, hmm. Something to fix in the auto-backport machinery then.

-- 
MST


