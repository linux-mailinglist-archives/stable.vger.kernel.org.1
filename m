Return-Path: <stable+bounces-151309-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD2ACDA56
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 10:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5E603A4B29
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 08:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6C028A408;
	Wed,  4 Jun 2025 08:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Or78OMGs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0481DED6D
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 08:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749027264; cv=none; b=AhZrn3q5yje8TGUErrMnAF5VGmz/NiS7e/7zW3BLxbQcC8QiF+9a/RTG/QLRA+IzOY8DJj5OM1Ml0cP25+mUQATNB5yC3TnTbicHsKDJYT4MV4MiiboA/9Hb/C75oTFFP68anrUc8IKaHLrg71kuONw2wnWm4P5nQlw49nkFIt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749027264; c=relaxed/simple;
	bh=g0ppivEkoM1bf4Myn91O2YnyqHNJElL0LhGMOzqDmBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WWRrGpPxjFy7gGKCBBIXgJHd/UtHLKsKqewilQT/NDtENmBz4oLdIHof6is6lzSfHMX4cmGU5OJQ6KBoDWQ0IMAYn0iMUCi6tUKAJmithM1ts60kjdYXgLoVKdyDVcNeYRH2mbZ4i4JUfF0M/nDVBJSGQvtziljj0WNj+suBWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Or78OMGs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749027261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AvsoGpn4vrP9au9LXRzA3/0BBfANYNVTOadYG+jd6TY=;
	b=Or78OMGsoG1g9Lfdn8fp50sf1Teu1M0vbg2F2hFTogBzrYl9kAC0tbu02hyPy7JvFUhe39
	C4jnmNRNd70+Z+1QJS7oiUxdX15OmCF+lj6Bssm0t65X6GZspCzgkCsbc5uEyo1F5T8ExN
	a2sF/mFtapjNKszY32ccX8x8TbPTWv0=
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com
 [209.85.219.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644--zENBJVxM8C03xyJdZj4xQ-1; Wed, 04 Jun 2025 04:54:19 -0400
X-MC-Unique: -zENBJVxM8C03xyJdZj4xQ-1
X-Mimecast-MFC-AGG-ID: -zENBJVxM8C03xyJdZj4xQ_1749027259
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-e7b4e43d31aso4294632276.1
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 01:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749027259; x=1749632059;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AvsoGpn4vrP9au9LXRzA3/0BBfANYNVTOadYG+jd6TY=;
        b=nTGgT5tPlHg05MvnT+bH+eVla2ZxAl9MvRxwvMYm3Ih5aJoJiT48brsnwo5UviURlf
         pew5k21QuHWXcFIuLIyLAb2kbYkejWnAfGJOlqksky5LTzzz/llCn/hT2n9wWUReAlkp
         9ckuyI8bXBfJWkQPAxoYzDArEPTsoXQ/b27vZhWtq9tUtkTP4L4V8nJj3C9sXXK4Py2f
         f1Do7YT0+XkADxi1COY54rTztb5DTgxTLkCLPDKZlQdjV9qsVU0Su819Ak+iesGIUCrk
         PAJI71Hzj1axaW2wYhRhmutOYrIvdRTcsZrM7QoUzy2AiNu/BJvDIV6MJ/ITzG7lsF8w
         66UA==
X-Gm-Message-State: AOJu0YwLNooOPDvsXqPLPtyNi8GvE9mRvF8KUlPr4NF0Axll+0AE0u6D
	v5HP1rsyzkFZh/kO4v4JzVKQtPgKpj+eMErzzfdLlF5Qw4BZoVtQ3WpPvtAEarGQtfhHmliNYug
	RAm2P8NfMsXPnUJSDyyDtbRSuaFO1S7W2FKefAP4F15XCYhOcJJEzOMZlqRDEEZ2AYoDFW7+2Fs
	AkhmjHFMQp0G0qqs4Ww2Z1MDE/NRzrS3aP
X-Gm-Gg: ASbGncvtMbk2hxQQAMvFbLlVnZD2q1Uj46dd780ycqdfCi3bY5CPTrN3OUAUKjJDRvt
	HJZfePSOKdxwaMwPOgyABbhpYeAke9qCG0SKwl8Xmuy4eJnZ7ukH7foP5CRzKXBioCx9PSTTzC3
	5MGwA=
X-Received: by 2002:a05:6902:2d06:b0:e7d:d002:da94 with SMTP id 3f1490d57ef6-e8179c0191dmr2531828276.20.1749027258985;
        Wed, 04 Jun 2025 01:54:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2C121V7OjYlteSOkifolsWZy/x2Ol1f4a1SiVTnu+7fvufC/08o+ydl4x6iDTlhXDzxen3FpEn318g2cKE4M=
X-Received: by 2002:a05:6902:2d06:b0:e7d:d002:da94 with SMTP id
 3f1490d57ef6-e8179c0191dmr2531819276.20.1749027258689; Wed, 04 Jun 2025
 01:54:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602134340.906731340@linuxfoundation.org> <20250602134341.897528821@linuxfoundation.org>
 <CAGxU2F7fRUn1H_-CF5SJJ1DZDEt3xfm+er0kqa_XS9nn6uJi0g@mail.gmail.com> <2025060443-morse-reentry-9573@gregkh>
In-Reply-To: <2025060443-morse-reentry-9573@gregkh>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 4 Jun 2025 10:54:07 +0200
X-Gm-Features: AX0GCFuyEeJEQ6h8-T5G-nE_57PXCHmHGBprnsW2EwdMbKXOArs7EAI3zPnaWyU
Message-ID: <CAGxU2F60xQoWT3JBHQfGAgjPSJAMwVpynbiLXnbZw72Q2QqJ2Q@mail.gmail.com>
Subject: Re: [PATCH 6.6 024/444] vhost_task: fix vhost_task_create() documentation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	"Michael S. Tsirkin" <mst@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 4 Jun 2025 at 10:40, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jun 03, 2025 at 02:18:12PM +0200, Stefano Garzarella wrote:
> > On Mon, 2 Jun 2025 at 16:04, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > 6.6-stable review patch.  If anyone has any objections, please let me know.
> >
> > It seems that commit cb380909ae3b ("vhost: return task creation error
> > instead of NULL") is not backported to 6.6, so we can skip this patch.
> > BTW it's just a fix in a comment, so if it's too late, it should not
> > be a big issue.
> >
> > Just for my understanding, next time should I add a Fixes tag in this
> > case, also if the patch doesn't touch code?
>
> Yes, as you did say that in the changelog, which is what triggered this
> backport, but our tools that automatically check for Fixes: tags missed
> it :(

Sorry about that, I'll keep that in mind for next times.

>
> I'll go drop this now, thanks!

Great, thanks!
Stefano


