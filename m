Return-Path: <stable+bounces-196961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EE2C8844C
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 07:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7A9E234E3AD
	for <lists+stable@lfdr.de>; Wed, 26 Nov 2025 06:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B883161A8;
	Wed, 26 Nov 2025 06:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OcuGuJyr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Laspvpj3"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3931E8337
	for <stable@vger.kernel.org>; Wed, 26 Nov 2025 06:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138478; cv=none; b=a2ELfxzCGmg3X/Ij+n4+qYm/XIHZ1MwKLKUgMF8krqyZnNlVIWImaXXRQi59hocNymdlhVK0k3BKS2xyAvuSMiP/+0HyhDgkTiHcMEhUGFF6LJYosXELybB4tAQXIQ0zvGhWe4maeY6QGPReTOcT1hD1fP7bqUqikVzSfoG5hss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138478; c=relaxed/simple;
	bh=6GBox+U71wd52Kw2/PdLyqreoI+ktndyD42jWbX4uFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4c772oSPG3a8H4tMbXkwD+qN9+Dfjty4OJZD6oP2BeABVxKehZLNDkxaze48JFEnjWfw+XzflROZBxyF1PtIADIK1sbYn9iEEwXgNZral6z3YksNOo2yoMOGV30kBIoIq9SleNYeDjQ1Ufy6gjZL0hc2xs5EERpRYsPFMg0gvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OcuGuJyr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Laspvpj3; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138474;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
	b=OcuGuJyr91W1OUNQQkOx7IE8HIxXDAfld9TaMtqqp0Q1zE1ZVtppn3GPSezPPv407B3Sru
	J7h3q7nQ2/1q+IncrqhVkivL91qOT3NcddnFZxOZueJutCUY9xhuskUBDfYMl7ocqh4+T7
	tWFjUvqcISzLLirqEoa6sHaW7N4A320=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-T8fnPbFyNr2zyCUY83BVVQ-1; Wed, 26 Nov 2025 01:27:53 -0500
X-MC-Unique: T8fnPbFyNr2zyCUY83BVVQ-1
X-Mimecast-MFC-AGG-ID: T8fnPbFyNr2zyCUY83BVVQ_1764138472
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-477563a0c75so33530255e9.1
        for <stable@vger.kernel.org>; Tue, 25 Nov 2025 22:27:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764138472; x=1764743272; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
        b=Laspvpj3X2vQMlf7eONaP0uEp8iI8cEklRxi9rYME1Ke09iAyhQFbFP85DLnUbkjTb
         hYevtAYaQVPBAc271d9zgt64yK6LwKG9I42NrD/sQ3KRFJyiYRiYoifiS05RzMUizjiY
         NeIEdBz96Eksy+9fO+yvK8HhzaRpbyZ0/DGz9oPG7YPXvljKkCZeyQYDb+5yG/7tbhQu
         fPkjBLqEteKvW5UP5eSiAR2q6j66mMTzGPA3uva6MZVtNm7U8/ALB7Zb8nNuPG6x5HXP
         XMs8cql4IO3EUQYQEu57ZdGY5YiA4qv/gxM4QyGBOktjbrid4DAcHn2rd+KL3Y8djLVE
         tYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138472; x=1764743272;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARxIA8tdQWb99qoXW28PLnSr1NCprmRt1PGWJHnjSzg=;
        b=hvQoxhCY6zrI9bvXLKcShPQAx6f91wf7uBPLB9PnGECVeLc1VUoDlURpTFSWOjnaY+
         nYfDTaamh3ODWTGWObGadR/ilNkzt/aVnWHPVF/X93kvY5L8tE2M7mHN28N6uNvcG+/a
         9ry1HxRPpGnz/Xoy6B3F0NC1Vxa4Pc0VDyA5qI6RTEcauw/yIBoN2UXg499sqB64uR9G
         todTNnLwBBhfz8wyE0fu6G2Ai4MiNRCm2vuGmfcRCgAjEtJDlCkKFLK8JarIohnezsuh
         8ikPZscTV0D8UQ/o47lir5tsq63UAFZplkZ2N0ZUB7umJE4rVcHQlrClAIGEElcn0WJx
         RU9g==
X-Forwarded-Encrypted: i=1; AJvYcCXhP/guJ5IQu5E5AmAltBEbHhY4NFLAEFXKFUaUWH88/5qMDpkcgM0/T///744w9IqYvSSDpvQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvgSBLQFDpkMxgSjX+vm5Ksu9LnvYR+UMERndyikKRo7SCPJOd
	n7evuDTfJXd1JGgLArqWPhA5xsuzE64ulUiGB6MR9J2LyKzk4zDUGi84Lp3HNWWMUfrkgVOyvbD
	ltKDoIGYCjZIAc4Bu9PXGXNptkCrusUoWr00kzBWS53n0yLGetpxuKKJ+1g==
X-Gm-Gg: ASbGncstokHm3Pj0xX9uKY4GxpM1Xs8+vt0B3gCQoGwQr9x2bzji/ds9CFUdJiYUj3A
	Y0XtMgHKqtzQYhZL6twDkQLS5/3PEwORdR6OoUsIm9uJ0Q2IwTqpPZ6qcuQJ0QadHs2xKeH5ci+
	LWVSHreeskFoltuFI/9ar/UHbdMVHwwwDye1i1djdR3AswTjQpUuHI/bo2GP0MoEsQntp8IvF2o
	hJEOnpE9P5qeAI6+MpsY+BNTCe83XyDKxkI0GI6JETDZ3ot/E7lz9Rvzpx7CaQiMMJCCmjdSX8t
	B88D4eLQgrHQjY1c5m6yMNg+/4YhHPQthbr8AVoy0ERDtsOP0muKhpu/SXm7qum8TnLgw3OyX2o
	ohtJxLMmd4IbCqcN6+u01b9CsouIz7A==
X-Received: by 2002:a05:600c:4443:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47904b103e2mr53915405e9.18.1764138471839;
        Tue, 25 Nov 2025 22:27:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF0f1u0T3jzKYGdUCWINkcBdum6zqYD5lZ2uzy8Z3cJxh7vJamCVyKXR4UerdY4GLIpXEKe5g==
X-Received: by 2002:a05:600c:4443:b0:46e:53cb:9e7f with SMTP id 5b1f17b1804b1-47904b103e2mr53915225e9.18.1764138471351;
        Tue, 25 Nov 2025 22:27:51 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4790adc601dsm26881835e9.1.2025.11.25.22.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 22:27:50 -0800 (PST)
Date: Wed, 26 Nov 2025 01:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, eperezma@redhat.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net V2] vhost: rewind next_avail_head while discarding
 descriptors
Message-ID: <20251126012023-mutt-send-email-mst@kernel.org>
References: <20251120022950.10117-1-jasowang@redhat.com>
 <20251125194202.49e0eec7@kernel.org>
 <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEuCgSVpshsdfeTwvRnMiY8WMEt8pT=gJ2A_=oiV188X0Q@mail.gmail.com>

On Wed, Nov 26, 2025 at 02:18:25PM +0800, Jason Wang wrote:
> On Wed, Nov 26, 2025 at 11:42 AM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 20 Nov 2025 10:29:50 +0800 Jason Wang wrote:
> > > Subject: [PATCH net V2] vhost: rewind next_avail_head while discarding descriptors
> >
> > >  drivers/vhost/net.c   | 53 ++++++++++++++++++------------
> > >  drivers/vhost/vhost.c | 76 +++++++++++++++++++++++++++++++++++--------
> > >  drivers/vhost/vhost.h | 10 +++++-
> >
> > Hm, is this targeting net because Michael is not planning any more PRs
> > for the 6.18 season?
> 
> Basically because it touches vhost-net. I need inputs for which tree
> we should go for this and future modifications that touch both vhost
> core and vhost-net.
> 
> Thanks
> 
> >


Well this change is mostly net, vhost changes are just moving code
around.  net tree gets more testing and more eyes looking at it, so it's
good for such cases.

-- 
MST


