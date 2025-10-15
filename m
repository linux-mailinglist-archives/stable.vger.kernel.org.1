Return-Path: <stable+bounces-185751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 500A3BDC8B3
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 06:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A5C94E44AB
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 04:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECD12EBB81;
	Wed, 15 Oct 2025 04:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nSQJ9w8Q"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2757422A4DA
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760503821; cv=none; b=PT3UFhSKr2v+/oSN7uA5jYidC1QLK3j6928k2SboZLLKun9NR+wClCv3C8vGrYvusvPZ5UQAMRnpEZTBr0eOPn+oZursejbYreVPIFfcqBl5YRusTR0WJqZbQRHVoA28jChAnI37lT4YoFpjWIHWjMeTyAd9rDNpyjHUGIyt6uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760503821; c=relaxed/simple;
	bh=mwJKG02gnDXAFkxBbLw8//vPU/ysGJRJT6ylFFPCGps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AIOtA4vHcdgKFvu4K79rPpUDRGCiQGZBgI0p9E7gS2ofT64bnkWL97fIHk7upd7EOESQjDm/Y6YyHZggDW42Scp+t+/25Ztrd3g/XQv2feqqtnDlSejfDb1uTbM//FM2ViAKvSH05ZFjKeYHlj7zaQcyuzmUoX1o3IOIRiltCh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nSQJ9w8Q; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-77f1f29a551so7765889b3a.3
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 21:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760503819; x=1761108619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mwJKG02gnDXAFkxBbLw8//vPU/ysGJRJT6ylFFPCGps=;
        b=nSQJ9w8QBZzStxm6t7hnIlXSmpJ8KE07VnWxQMtr06IzEjFeWctQYY1SdA+Z0Y9/0Z
         Z/HHTW0yeWEvkt8m6ZitWm0GvKUopg1uP2OT/sbHWwWWYp+PxhANFaIEm34slqQAMOBk
         KP3US+J/UnVzVehzxIufi5vcUKRkDvv3f/wg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760503819; x=1761108619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mwJKG02gnDXAFkxBbLw8//vPU/ysGJRJT6ylFFPCGps=;
        b=b/bSZFrYEnWdOSZSkNOB23C7l71AKcW7MCfk8OQ5NENBhAtQf+WrAhftdLK/muWNXx
         LEICa/d6fz6/5ckizHtKnMJcatcH6KnZOq9RKLLnofsjP3gWoNAPRyH/3L5BteNjJ4Zi
         z0A/495jdJdGK2DxTlvFTJIP3ADZnmapD73bZVaxNSn62o4wBfoncupMla4P+1mKLGZj
         QaHiEpKoGsG/38uoCJFUYHErivPlwXGo3NCGdMc9sU9ZwQaZAta3i/WvJxJQRKxtkZHb
         lUufVkdKwe1vGpVtmqCnJUE6QlvQ/rVCx3Z/q91AKZKRxnnBBVhfjJ+CoRpHDg0Rmxt3
         XPQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrZzqYsiw6bSUSNOHPykPcbCBywahdqCYAxGNC367JMQJlgtNi9XjOG/i3j3LJRDDIPbHgyoM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9aI/KPob394qvHA37PndegiJo9QgDvBEPA1OLFHqGQIsgPCBq
	1mVQ1vWzMVBufmG+SjxDJNhfmSAnR2QOEKRj+GA+TNM/ebIx+MKW6paR1jvlocgsaw==
X-Gm-Gg: ASbGncvGy6lLpDSHYpldnjtUSavNtL2RFObGFe37bv4hKflnIDgC4bvCr7YOmerux4a
	D9+GtPWxQoYhzpoxJFj2pgO3WEDGevxSLnOQZPqgiwFEBki2BQXK1yLsHWlS6DMzG+7vSEs/BJ6
	kqgF2At4h1Myhk394OGuqHTst3rbK5uK5XtNb+9TumeetWivVjbY6ZNiXctcSPfVVVDbtHk9y5F
	DDIpqoWSaUgzfA2ZtPZhZ1vvuwuMl4c+8eHJDDIvm6eJAM+zRY7PKASHc+PaFkC2pxPyn3a+Yg7
	10ffQFNQRtPrK2FNIeyi7ZD/TpzNXS37pHKlM0AawFpXJP7Kgw/DUH2a5etbGDZKIYAU7YipLTZ
	X9LAUOnz9f7HXVpVE8ebn7oreS34AnnLyFsPEYq3lYsg=
X-Google-Smtp-Source: AGHT+IEVS7JRB9ukejNdbzoqfnoXFIm0wC1ObrEzBW4mZcnfolJj11YQDrsEh5d4bGJEkvxUanOfog==
X-Received: by 2002:a05:6a20:3955:b0:2dd:5de9:537e with SMTP id adf61e73a8af0-32da84cea01mr37580445637.51.1760503819441;
        Tue, 14 Oct 2025 21:50:19 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df7e1d1sm13676992a12.40.2025.10.14.21.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 21:50:18 -0700 (PDT)
Date: Wed, 15 Oct 2025 13:50:12 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Doug Smythies <dsmythies@telus.net>
Cc: 'Sergey Senozhatsky' <senozhatsky@chromium.org>, 
	"'Rafael J. Wysocki'" <rafael@kernel.org>, 'Christian Loehle' <christian.loehle@arm.com>, 
	"'Rafael J. Wysocki'" <rafael.j.wysocki@intel.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>, 
	'Artem Bityutskiy' <artem.bityutskiy@linux.intel.com>, 'Sasha Levin' <sashal@kernel.org>, 
	'Daniel Lezcano' <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	'Tomasz Figa' <tfiga@chromium.org>, stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <sw4p2hk4ofyyz3ncnwi3qs36yc2leailqmal5kksozodkak2ju@wfpqlwep7aid>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <8da42386-282e-4f97-af93-4715ae206361@arm.com>
 <nd64xabhbb53bbqoxsjkfvkmlpn5tkdlu3nb5ofwdhyauko35b@qv6in7biupgi>
 <49cf14a1-b96f-4413-a17e-599bc1c104cd@arm.com>
 <CAJZ5v0hGu-JdwR57cwKfB+a98Pv7e3y36X6xCo=PyGdD2hwkhQ@mail.gmail.com>
 <7ctfmyzpcogc5qug6u3jm2o32vy2ldo3ml5gsoxdm3gyr6l3fc@jo7inkr3otua>
 <001601dc3d85$933dd540$b9b97fc0$@telus.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001601dc3d85$933dd540$b9b97fc0$@telus.net>

On (25/10/14 20:41), Doug Smythies wrote:
> What thermal limiting methods are being used? Is idle injection being used? Or CPU frequency limiting or both.

How do I find out?

