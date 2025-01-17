Return-Path: <stable+bounces-109387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CBCA1528F
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 16:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C12E16B5FB
	for <lists+stable@lfdr.de>; Fri, 17 Jan 2025 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670A198E92;
	Fri, 17 Jan 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="dURbqzav"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E168D198E76
	for <stable@vger.kernel.org>; Fri, 17 Jan 2025 15:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737126697; cv=none; b=TumoC0RP7WD0JjNWa8nt0Ba2LEIup6c58vZ/8peW/QuhYDYWysiLb4EEfgS8CZGoG2zLC5Ogu66KBaojOV7nBVM5L2pgJVxIVUl/5+s3lP7QPrKJX/eu4BY2zOVeR63zKaBAy37ChixzIEqliWwW+BgbtR9Fl1g6uVf0A04x+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737126697; c=relaxed/simple;
	bh=eG7Sh286dHUbRyO+bmAxpspSFiq/1ecajYvShoZ/aCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUwoeXxeXX++0/E5VYmYHJoFuLwD/dixDQK83uwhAJAyZrKcDDDlIAirbWr25R62oXYrISLiCktSL5L8mGYonfAcNnATBOV93Au6aJ+w046ceBOErL+l/f4l8PnZfxM116zE4PCEdjEEPa0bOi+a7waoDIEUcEm3DeFh35slGfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=dURbqzav; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so24282785e9.0
        for <stable@vger.kernel.org>; Fri, 17 Jan 2025 07:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1737126694; x=1737731494; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pekHVxf/ttoG9R46riopbQafADFU7Gi1rdzDwGi1/SA=;
        b=dURbqzavSgUIbNA/CdqhoUxSlIzUj8ctoKEPEUFrbkQX5tHyZCLDm1XBWqZXIbH2Bl
         3tLB3E5tp2c8Hcpxk46kbTlwbnP7atgCa1bE3JJuLrkwk6R1t0tBk6Q1+jVR7O4GyR9/
         9notahL0ITvXIAX5oLtUyc0rP9TXv798JM33k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737126694; x=1737731494;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pekHVxf/ttoG9R46riopbQafADFU7Gi1rdzDwGi1/SA=;
        b=JrOzVwhNtGa04n8MnYQe3TyhtbTfnfZWsxyyO3WXttAFIoGqyvR1nYRiaFlHqXVPZI
         /NF4TMMZXm9fdQjbFVCl/Yr6VgqI3sThV5ZlOT97Pm6Q9nW8vRJdVrT80NvgUeR5cTT9
         ciL8Pd79dfLwOImRxy6CDLIO7OQoqnTPIiXbN2oPoW8VqEHKVUdmmU8pDKjjJ6soXmDL
         ONnLhOX+AF70EYUDn0N9cPG+SoHPlXmTl4lD3pS1At+o9LgMGhJd4mD1resisx9Stw9Y
         KkRApdocwn7JcDVvO/QViMPo4OZXnuh9pIFzVAvVsTVw2M4zQoVV319VJeuec6FwOZ6P
         zEuw==
X-Gm-Message-State: AOJu0Yxwomie8MktEkajA5sABJAm8XYh2oVhuykV+WWm+adeYsJktoqU
	IkDHns8J4UGZw/5csyXMwPf4aK8eRu3nBt8d6IGe1PJo/fAYkJPTMunACDfsJNI=
X-Gm-Gg: ASbGncv17AhFgU4rjSd1mym3SOGzhi0YPjqztucvgEICLyxSZGTNUhnkS0BwAkMYHOv
	T2iLbqA38KjRWku7PLlHP+ixKwEBXeyLgJj1psH8CGDfLn3OI6REgfqebCTwA/gdEvKNYe7Mom3
	WGyF1T3+3r4b6jqkhdI2hJusbhDNuOANeKs6D+u/aYYWKQ+vhZxJbaNm5vHZxhjW7TNRK1+9VpG
	cWHDuWVoMGvzeFj+0HEhAhN20XyLWm92nxrmDGZflll8NpmjmxFCd6rQbUDDllmlCId
X-Google-Smtp-Source: AGHT+IF73lL6Kjo3I9LTRG8P/o5zjbTIw37pEm5uCicjXhtcR8WMg5rbZBAI4jBX4D1S13Mc3K1Kzw==
X-Received: by 2002:a05:600c:5486:b0:434:f586:753c with SMTP id 5b1f17b1804b1-438913ca694mr30636765e9.7.1737126694048;
        Fri, 17 Jan 2025 07:11:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:5485:d4b2:c087:b497])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43890367b48sm36478655e9.0.2025.01.17.07.11.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 07:11:33 -0800 (PST)
Date: Fri, 17 Jan 2025 16:11:31 +0100
From: Simona Vetter <simona.vetter@ffwll.ch>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"stable-commits@vger.kernel.org" <stable-commits@vger.kernel.org>,
	"oushixiong@kylinos.cn" <oushixiong@kylinos.cn>,
	"Koenig, Christian" <Christian.Koenig@amd.com>,
	"Pan, Xinhui" <Xinhui.Pan@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: Patch "drm/radeon: Delay Connector detecting when HPD singals is
 unstable" has been added to the 6.6-stable tree
Message-ID: <Z4pzIzRg2xpYv2mJ@phenom.ffwll.local>
References: <20250103004210.471570-1-sashal@kernel.org>
 <BL1PR12MB5144226AD0D6697DBF25ED56F7122@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB5144226AD0D6697DBF25ED56F7122@BL1PR12MB5144.namprd12.prod.outlook.com>
X-Operating-System: Linux phenom 6.12.3-amd64 

On Wed, Jan 08, 2025 at 12:02:03AM +0000, Deucher, Alexander wrote:
> [Public]
> 
> > -----Original Message-----
> > From: Sasha Levin <sashal@kernel.org>
> > Sent: Thursday, January 2, 2025 7:42 PM
> > To: stable-commits@vger.kernel.org; oushixiong@kylinos.cn
> > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > <Christian.Koenig@amd.com>; Pan, Xinhui <Xinhui.Pan@amd.com>; David Airlie
> > <airlied@gmail.com>; Simona Vetter <simona@ffwll.ch>
> > Subject: Patch "drm/radeon: Delay Connector detecting when HPD singals is
> > unstable" has been added to the 6.6-stable tree
> >
> > This is a note to let you know that I've just added the patch titled
> >
> >     drm/radeon: Delay Connector detecting when HPD singals is unstable
> >
> > to the 6.6-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> >
> > The filename of the patch is:
> >      drm-radeon-delay-connector-detecting-when-hpd-singal.patch
> > and it can be found in the queue-6.6 subdirectory.
> >
> > If you, or anyone else, feels it should not be added to the stable tree, please let
> > <stable@vger.kernel.org> know about it.
> >
> >
> >
> > commit 20430c3e75a06c4736598de02404f768653d953a
> > Author: Shixiong Ou <oushixiong@kylinos.cn>
> > Date:   Thu May 9 16:57:58 2024 +0800
> >
> >     drm/radeon: Delay Connector detecting when HPD singals is unstable
> >
> >     [ Upstream commit 949658cb9b69ab9d22a42a662b2fdc7085689ed8 ]
> >
> >     In some causes, HPD signals will jitter when plugging in
> >     or unplugging HDMI.
> >
> >     Rescheduling the hotplug work for a second when EDID may still be
> >     readable but HDP is disconnected, and fixes this issue.
> >
> >     Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
> >     Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> >     Stable-dep-of: 979bfe291b5b ("Revert "drm/radeon: Delay Connector detecting
> > when HPD singals is unstable"")
> 
> 
> Please drop both of these patches.  There is no need to pull back a
> patch just so that you can apply the revert.

Since we've just been discussing stable backports at length, how did this
one happen?

949658cb9b69ab9d22a42a662b2fdc7085689ed8 is in v6.11 and 979bfe291b5b in
v6.13-rc1, so there's definitely a need to backport the latter to v6.11.y
and v6.12.y. And maybe there was a cherry-pick of 949658cb9b69ab9d22a42a66
to older stable releases already, but that doesn't seem to be the case. So
what happened here?

Thanks, Sima

> 
> Thanks,
> 
> Alex
> 
> 
> >     Signed-off-by: Sasha Levin <sashal@kernel.org>
> >
> > diff --git a/drivers/gpu/drm/radeon/radeon_connectors.c
> > b/drivers/gpu/drm/radeon/radeon_connectors.c
> > index b84b58926106..cf0114ca59a4 100644
> > --- a/drivers/gpu/drm/radeon/radeon_connectors.c
> > +++ b/drivers/gpu/drm/radeon/radeon_connectors.c
> > @@ -1267,6 +1267,16 @@ radeon_dvi_detect(struct drm_connector *connector,
> > bool force)
> >                       goto exit;
> >               }
> >       }
> > +
> > +     if (dret && radeon_connector->hpd.hpd != RADEON_HPD_NONE &&
> > +         !radeon_hpd_sense(rdev, radeon_connector->hpd.hpd) &&
> > +         connector->connector_type == DRM_MODE_CONNECTOR_HDMIA) {
> > +             DRM_DEBUG_KMS("EDID is readable when HPD
> > disconnected\n");
> > +             schedule_delayed_work(&rdev->hotplug_work,
> > msecs_to_jiffies(1000));
> > +             ret = connector_status_disconnected;
> > +             goto exit;
> > +     }
> > +
> >       if (dret) {
> >               radeon_connector->detected_by_load = false;
> >               radeon_connector_free_edid(connector);

-- 
Simona Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

