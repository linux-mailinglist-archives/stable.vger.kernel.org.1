Return-Path: <stable+bounces-60399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B955E933958
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 10:45:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C979B20F32
	for <lists+stable@lfdr.de>; Wed, 17 Jul 2024 08:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EC3B791;
	Wed, 17 Jul 2024 08:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="GXv5qRKd"
X-Original-To: stable@vger.kernel.org
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429EC2032D
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205938; cv=none; b=c6B6NH43YFOMTspO6XNXQ7GBPq8D/EZ0EVR8fqsa3y4gVSov87HGy+sjDmaA4BA4Z+5L6fsZ7jfKIOQgN9Jo6iIPgK242f38ERCf/Bz/AEkBSBblDLWfaZ7NVdBPZXeUYFvBrj4YfOA/7jxnXIIveEG4sXuX5Ji5ZVLA4c5dBcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205938; c=relaxed/simple;
	bh=W9VmWVK58badX7GSE7EEIgtqAFJOLmPN0d6q5z7UVwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oq7tvlC9NN5R5veViZAcI9rPq9z8SVk1P9SiXSORoQKjHCf/PvbgnmcAE7pR4yKEuCnn6LXeigu0uexGJnScnPdHcB/VGkkf5LJ3ZfmRhQOrSS7ByxK9R1rOdf8U3Q/U3kNKSqHOFWdqaMBvOMTH+AIo/M8zLkGtn/VewZdsEWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=GXv5qRKd; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=GXv5qRKd;
	dkim-atps=neutral
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 2414A356
	for <stable@vger.kernel.org>; Wed, 17 Jul 2024 17:45:36 +0900 (JST)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1fb4e7cc5d5so36849645ad.0
        for <stable@vger.kernel.org>; Wed, 17 Jul 2024 01:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1721205935; x=1721810735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=J/GZGtsnnR5oOKYcIqwuG9u16iCTD0VQnjtKSN0BGpU=;
        b=GXv5qRKd+I6XcCaD3Fq4Q47d41yI98afHwciZZluGFO/i5kluYVsUZ2wVGnO9pTyk9
         kznL14k41ITrij64FtjDMTNkNvsmbMl8X38t9rLzLqM0WbZ31pIUAw+WkibU99sI6kTj
         0g+wxDdwDsNWIVGXp2U3KME7ZLEPrfFGTe3UUTFls5SusAlC9S2koGzMN5ng0/Smcp8i
         u+RE7WsU4mx/wL2MPT9TKMvO4SQnjFx/K3mRSczkqhxse2zrtKLVDJvWGV4lTkdyq4as
         K9sMob+kFlVu9638ZNLtuVGfG6VhhBeHmaKmL5H2sIvVdbcuvLvGlfstRjSCine3TOT1
         q9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721205935; x=1721810735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J/GZGtsnnR5oOKYcIqwuG9u16iCTD0VQnjtKSN0BGpU=;
        b=TQXJoD1UkgZennZd3dG5dDJ1dXkNFmuJPbIfWZvHzBmgXUUtjEKI8atuYQRVIs4v7Y
         dV3e8uQdjW72umk3RgHgxCnFMDIud6RTieIqLlNcxCT6SERY/3VH5/0DjkXUisTIvX9T
         wdCI9p8TU+uZhv0K9iZLES6piar5peZlvFzi35gYRYDfgywEvszmvV/aF4ssT8lrRROy
         zhtKlKRY9d/1qubhrTRO1fcyGH6gzDLMJt5LiZkC9XwPSw3tNdPe9VAChV3NiNVi2vHR
         QVBPdtmdoSP8EHa+584DblzPuQdoxGCCvXRd2LPulquFZdsEZm0R5cwnCS//MWEK9o/N
         Ve4Q==
X-Gm-Message-State: AOJu0YyVh1mAgQgheiw0bGZHvIDoGbWYaj7t41exO1noLXkjqN9fwuot
	YlKRZX8hwF6MJ+Alhv8DNrCUZtI1jC90dGQKbpGYjGPNF636lfdFTwg1At3+2sdn8QRTwemmrza
	aV0Qhy8KIEdGGC/lcj23y5AaSbf+j3JPpshkNjRhXwef6dfQVzreHFRroPh3khXs=
X-Received: by 2002:a05:6a20:4309:b0:1c3:b210:404c with SMTP id adf61e73a8af0-1c3fdae4aa1mr1551369637.0.1721205935206;
        Wed, 17 Jul 2024 01:45:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVgqLsrih9a0qyE0YJvgurVJ20EEhE1k4zvqfyoL04aAzCLiDSSQc8endkRl0qSpP0XLBvEQ==
X-Received: by 2002:a05:6a20:4309:b0:1c3:b210:404c with SMTP id adf61e73a8af0-1c3fdae4aa1mr1551359637.0.1721205934852;
        Wed, 17 Jul 2024 01:45:34 -0700 (PDT)
Received: from pc-0182.atmarktech (35.112.198.104.bc.googleusercontent.com. [104.198.112.35])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc4764b998sm9185225ad.267.2024.07.17.01.45.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Jul 2024 01:45:34 -0700 (PDT)
Received: from martinet by pc-0182.atmarktech with local (Exim 4.96)
	(envelope-from <martinet@pc-zest>)
	id 1sU0I1-005iUG-11;
	Wed, 17 Jul 2024 17:45:33 +0900
Date: Wed, 17 Jul 2024 17:45:23 +0900
From: Dominique Martinet <dominique.martinet@atmark-techno.com>
To: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Bing-Jhong Billy Jheng <billy@starlabs.sg>,
	Muhammad Ramdhan <ramdhan@starlabs.sg>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH 5.10] bpf: Fix overrunning reservations in ringbuf
Message-ID: <ZpeEo2nt-9vOPzg7@atmark-techno.com>
References: <20240717065946.1336705-1-dominique.martinet@atmark-techno.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240717065946.1336705-1-dominique.martinet@atmark-techno.com>

Dominique Martinet wrote on Wed, Jul 17, 2024 at 03:59:46PM +0900:
> The only conflict with the patch was in the comment at top of the patch
> (the commit that had changed this comment, 583c1f420173 ("bpf: Define
> new BPF_MAP_TYPE_USER_RINGBUF map type"), has nothing to do with this
> fix), so I went ahead with it.
> 
> I'm not familiar with the ringbuf code but it doesn't look too wrong to
> me at first glance; and with this all stable branches are covered.

I need a bit more sleep; that obviously missed 5.15 which didn't get
the fix backported either due to the same conflict; this commit applies
to both branches.

I've also checked something like bpftrace which uses the ring buffer for
message passing doesn't blow up when spamming a bit on 5.10, just in
case.
-- 
Dominique

