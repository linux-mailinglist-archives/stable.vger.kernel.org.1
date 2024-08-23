Return-Path: <stable+bounces-69923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B628295C2CE
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 03:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E78931C2214B
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94E171A7;
	Fri, 23 Aug 2024 01:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKwML1ib"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1B411717;
	Fri, 23 Aug 2024 01:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724376653; cv=none; b=I0lO96kIgC3grff7D5DgGpJTS2i+In/bw0LCaLHPhs2X6ST9fw6SLq1RoBcUW62RMGSxr6c7Zc1YnkyZ4Fzpgrh7fYkSxpXNh6PY7oB2y55+VGKaxR4wamjATaguHGyYAKk2vHWo6xH8qiTJexyabKu2bACtQSxa4oMMyP4Y3Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724376653; c=relaxed/simple;
	bh=HofqKVSX8hweqL6tlQcJRK+U2s4peJlN5tm1BKQFY+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MlO/veaxgiCap/AsfOEzadUOyhbWk25xj997N2BgEb7sF71U4V3yvvrNgOQ0pYSexttoDep1Q5/rdiD/sHeMsIMjhvfK8gEh34Z9q2jJnkCH9aXEHXyoKIP1XayRhIZv5wTrFfYmD5mpkr9/zeLi2zfe3FfxYV6EgRxKk4RtR4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKwML1ib; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso1030888a12.1;
        Thu, 22 Aug 2024 18:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724376651; x=1724981451; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ihi7wzSMhY5GnCD6Z9YDyGcT9vUYowgSoRe9ny56RKs=;
        b=fKwML1ibAozG5fqvYfRvfb5HYsf30tv2YXqbODaNom4oFq3eQFluTIwwIoUKkJ8fJ3
         9XExf5NgTb0mH9j/wn42YrTpxbhhlW2XUFVhdeEtCXij43OrYkcdRMliHYyOjwZRlkHk
         vc/FE/DN9hiZIN4WMDOOznc6Q/WqdLifonrEG26EIascOr6q0X9UlRrVsyNOwfzhfRti
         ozvx+0U1RNoyWCkd8dftVdQd/OfVndeUO28LMnneAKtEsb1Hzwawwug2AZ/KNopdgg50
         30IiIlTvwUtMzjXIIFDlcVaKwTKmIKQhP0UKA9svOLvQht5tV/u2F27K6l/BkzC/ulN0
         CNCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724376651; x=1724981451;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ihi7wzSMhY5GnCD6Z9YDyGcT9vUYowgSoRe9ny56RKs=;
        b=BbATG4u7CzbdVuQPtL2q6AB5iOzz919sQ+FJjrAqqdGjw6SwvyMyYj0pwkn2nYmlmY
         iFzT6m3sp3IQbGbQrpSes3BvLcQWh3BMsWS4ieeMhfftrF+dRHLNjb/YmGNaAcJqJKv1
         aCexcMLBrCwxRMcVeL717jnZ1nyNu2zp3trx4qOSKvA1cvxN9XWucJ+HZ49F2/HB+TLd
         /6Aw/TmZm2h3jqPlBs+zMa2bIAs4ZJw6oS8yo+INoKRQA0wE+tmd61myeBsemGWvKTbT
         gg2IIfk1VV5qiSu1a8x0ZmIDdbSFPMqezgMgrxrWgiertMWdtHVNy8EqtpYycp5dl4If
         rcfA==
X-Forwarded-Encrypted: i=1; AJvYcCX44B1R8UF5PufbLZzZb547poyfg4A1656KqZWzz0J7893BqEoMwNY63pb72rbwMVhj4mtlRMqt9+sD4cA=@vger.kernel.org, AJvYcCXRn55rWCvRXuUNnvvqJuS0S6ZnNZnWYkK2cWG6nbk8gM53aqaZhIdOqF8IiiHrqPIzJGUPDyI+@vger.kernel.org
X-Gm-Message-State: AOJu0YyDElydkVHjDlnOHYh3KgILKM80vlk5SZ6j9mYsejnlaZSPuleX
	XyH4b8ChWp7iqPfnbHpHJj+6oXLkS643QF4pUhB0v06uOG/EBe8s
X-Google-Smtp-Source: AGHT+IEUjYPI40y3iHamCoD/f4OnT066ID5vY9jdGC3TDvPbeMcs+wyBdQkE5gL/FDck0Afo4eiFJQ==
X-Received: by 2002:a05:6a20:2d27:b0:1c6:a83c:d5db with SMTP id adf61e73a8af0-1cc89dd1450mr1019077637.31.1724376650893;
        Thu, 22 Aug 2024 18:30:50 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ccdb:6951:7a5:be1b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7143430f6e7sm1979338b3a.160.2024.08.22.18.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 18:30:50 -0700 (PDT)
Date: Thu, 22 Aug 2024 18:30:47 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zijun Hu <zijun_hu@icloud.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] driver core: Fix an uninitialized variable is used by
 __device_attach()
Message-ID: <ZsfmR69nVPZj_8oE@google.com>
References: <20240823-fix_have_async-v1-1-43a354b6614b@quicinc.com>
 <ZsfRqT9d6Qp_Pva5@google.com>
 <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04c58410-13c8-4e50-a009-5715af0cded3@icloud.com>

On Fri, Aug 23, 2024 at 08:46:12AM +0800, Zijun Hu wrote:
> On 2024/8/23 08:02, Dmitry Torokhov wrote:
> > Hi,
> > 
> > On Fri, Aug 23, 2024 at 07:46:09AM +0800, Zijun Hu wrote:
> >> From: Zijun Hu <quic_zijuhu@quicinc.com>
> >>
> >> An uninitialized variable @data.have_async may be used as analyzed
> >> by the following inline comments:
> >>
> >> static int __device_attach(struct device *dev, bool allow_async)
> >> {
> >> 	// if @allow_async is true.
> >>
> >> 	...
> >> 	struct device_attach_data data = {
> >> 		.dev = dev,
> >> 		.check_async = allow_async,
> >> 		.want_async = false,
> >> 	};
> >> 	// @data.have_async is not initialized.
> > 
> > No, in the presence of a structure initializer fields not explicitly
> > initialized will be set to 0 by the compiler.
> > 
> really?
> do all C compilers have such behavior ?

Yes, all conforming to the C standard.

Thanks.

-- 
Dmitry

