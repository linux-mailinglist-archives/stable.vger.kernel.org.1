Return-Path: <stable+bounces-127423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D851A7924A
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 17:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3FFE1895572
	for <lists+stable@lfdr.de>; Wed,  2 Apr 2025 15:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9115146585;
	Wed,  2 Apr 2025 15:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LM/x5bQk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E687338DE9
	for <stable@vger.kernel.org>; Wed,  2 Apr 2025 15:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743608412; cv=none; b=ZlbQMVjPVT9ZXWBHlcLGJTM+i8QKtYjEcCJ6eOs5Mopi08gAdfvIMbbSUmVVmBjm1wZYI3Dj6jznQBE629sRCD+GQiK9ljzjZRDk0Y0Hnp8n/DM3LqZewZFmTDaO9IXA840vlnH3mK/JFlewZOR4kw9mto/DZUs7pPfLxfOM0rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743608412; c=relaxed/simple;
	bh=Pbq1dx/OnJbPO7NellCFhQ39y6lY/rmd0Eej3PvX2s4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uTXlYMwy9sQhGkm9XWXPuJgktGpk/Pw1cFJ+LY4rBi6gtqwGS+5yIS6p/IQuA0+JrJRMiXxVttCUSqvpXadG+AtfQaQM15crPdkzhF/Xr48SFbM6F3ofy1Zgc3JtpG7s9yT8UzAfuGisM64VQ1Fc9B3xEIEV4RjhkVip5HWtKQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LM/x5bQk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743608409;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6nUx7Vl7EvSuoWp742ECf14m48HpSY6aOAHXmisq0nE=;
	b=LM/x5bQksdnhYE1azI1l4ots8vIs3rJK/pROXDeWjbYhkLOWb7qi+S2GysxC3EXQzZmkWb
	qOdC4Ktk2xI55ThCu3C18QSrBcrWTfwS9RyYnCxfrKxe2FthDUaYaGYpi8KKgWZvMdpFOB
	zILgsNnYsrWZoSqezTWIX/bt/wx5QOg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-3pyEB5htMdCj7WEkvybLrw-1; Wed, 02 Apr 2025 11:40:08 -0400
X-MC-Unique: 3pyEB5htMdCj7WEkvybLrw-1
X-Mimecast-MFC-AGG-ID: 3pyEB5htMdCj7WEkvybLrw_1743608407
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43cf172ffe1so60655845e9.3
        for <stable@vger.kernel.org>; Wed, 02 Apr 2025 08:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743608407; x=1744213207;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nUx7Vl7EvSuoWp742ECf14m48HpSY6aOAHXmisq0nE=;
        b=t5KtKZDGn44rkLXLXGIdJOXRTwCUGXq1kYMW1qkJWPQoLnJk/F4ZPQ63r5nOgBu42W
         0OoUfyuVO7Ap2WxbZ5IwlZY/OAu9mJpiabw+LwoTBiPzypv+LMso14r7cGq90WOh0/7/
         NIUpZQ3LVzwkPbIXUJcIsOZTatbTYEIhPe7J+jNm6WcZ7m+b4jZRWMJhdP2KjHfx94xK
         sek1vijtAgG6lTa0I+/RwEQ7WUTX4gPyOdgAgb8UUvOF4Iv03jdjRJs9fZ3onkM2iIGK
         JYNG+2+BCwPMQ09Ir64i4o4R7N0Mf1zxR7TMlKT8k740DcYX8xUFBvkoRz+QMnNi3hpF
         ft5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSTtwQk9ef2q/55FaG4MpZG5oPCk8EIqFzgyMt+kbtc/scOFY3utIIvVXRk8r/2GwgqKTqWg8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysWNSWEJZTpXN7VKGfyDgEjhz0s4/r1L9uHsJLukaxFya4Vvmf
	lJ7xT0Z7QGT8ZUCDYHBsxNHto2PF4T5/qUGEFAds/M9sFeG5s5PoKKAB9dTeoMwV0GXBtkVClHJ
	18m1RszqS82DjZX/+Jc1gQ/BCU80j802ixuiP9DcRhfCFhvc1cCEcRg==
X-Gm-Gg: ASbGncs8Vk6/eNSRUtlHttt8B5/nss+EiqltN56HCCpkok9IXyH8COG8pLLu1DgqTBx
	ukO3Fqbq0gG0k+QekKfYeT4JdPYoEhfLFLinuArjoMUCYhLqOayCadRWKivFbd69W4GkLpxmhjp
	cDc4n/IoDqeO9FgQoud+vP3cEaByyTI4lOj3yhcQA+l1kxuVoC4/nhTwRgayvs1VD33PKT8QsOB
	hAL5nnnE5decvWlWPTlzoSQ3W0nebgL0VjRxXsHPXghm0UKsSoZMGY8DVCUiILCGvuqHZ3GqY2l
	rxvG44aXuA==
X-Received: by 2002:a05:600c:190b:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43db61e0327mr166905455e9.4.1743608407272;
        Wed, 02 Apr 2025 08:40:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnFH42jKvsNA+QiJsZ/dd/OiaMejjhtC78pMe0Jb00FkOJVLLyR+cxJWkaCicl8B+/i2omrA==
X-Received: by 2002:a05:600c:190b:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43db61e0327mr166905175e9.4.1743608406852;
        Wed, 02 Apr 2025 08:40:06 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43eb5fcd489sm24265995e9.11.2025.04.02.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 08:40:06 -0700 (PDT)
Date: Wed, 2 Apr 2025 11:40:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, stable@vger.kernel.org,
	Maximilian Immanuel Brandtner <maxbr@linux.ibm.com>
Subject: Re: [PATCH 1/1] virtio_console: fix missing byte order handling for
 cols and rows
Message-ID: <20250402113755-mutt-send-email-mst@kernel.org>
References: <20250322002954.3129282-1-pasic@linux.ibm.com>
 <20250402172659.59df72d2.pasic@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402172659.59df72d2.pasic@linux.ibm.com>

On Wed, Apr 02, 2025 at 05:26:59PM +0200, Halil Pasic wrote:
> On Sat, 22 Mar 2025 01:29:54 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > As per virtio spec the fields cols and rows are specified as little
> > endian. 
> [..]
> 
> @Amit: Any feedback?
> 
> > 
> > Fixes: 8345adbf96fc1 ("virtio: console: Accept console size along with resize control message")
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Cc: stable@vger.kernel.org # v2.6.35+
> > ---
> > 
> > @Michael: I think it would be nice to add a clarification on the byte
> > order to be used for cols and rows when the legacy interface is used to
> > the spec, regardless of what we decide the right byte order is. If
> > it is native endian that shall be stated much like it is stated for
> > virtio_console_control. If it is little endian, I would like to add
> > a sentence that states that unlike for the fields of virtio_console_control
> > the byte order of the fields of struct virtio_console_resize is little
> > endian also when the legacy interface is used.
> 
> @MST: any opinion on that?
> 
> [..]


native endian for legacy. Yes extending the spec to say this is right.

-- 
MST


