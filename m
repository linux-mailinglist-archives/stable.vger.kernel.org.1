Return-Path: <stable+bounces-185742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A8ABDC158
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 03:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D42C4008D4
	for <lists+stable@lfdr.de>; Wed, 15 Oct 2025 01:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C23825A2A4;
	Wed, 15 Oct 2025 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hwKjdpaH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18351F4191
	for <stable@vger.kernel.org>; Wed, 15 Oct 2025 01:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493415; cv=none; b=p2oFMbN7ejbEU0/KEf20DoKIlI7Dh+V2mdTNiebax7QZZ2cYDaqv2JsiRXLFb+rh05AFlBl090zT9o16IaM/tf9HxcbWAd0BmB16JBzG+jvUYh1L7+CuLBUhB3rImGkScwQjL7KHHceAPV7cWvhC/Mwo+SHTSm42X5eNKNlp0KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493415; c=relaxed/simple;
	bh=FThhOQrJbCtjj1TTK9njlcMwLVBiVt0cR2pa63pzOII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=El+n/oLX8v4JeO6gXCI1pBm7CuIUxMVgiyP5VHskmQSbAB1D6NmWACiWZP/N1i6AiHPFlM2E8Onsb7KUuOH3aChERm2XT7Ie/u4LpvDM2wI5t9M8fJVkwdFY3RLp/8FHN2gVozo+nw11iAoUBGOknYAjoT/B2phNE9U/RA9wjus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=hwKjdpaH; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-781001e3846so5802535b3a.2
        for <stable@vger.kernel.org>; Tue, 14 Oct 2025 18:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760493413; x=1761098213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=822jt5nEXo/RsUhaWbDrvompK6uhrTRlKH06xCVQnfc=;
        b=hwKjdpaHSXxKvsPPMwfl+aZeGlRt5f6brIREm0hv2AYjlDTn00wv0cMXOV1kp/FxSx
         F5u8W2NH0bDk4wYF5inc5AWiiXUSdfhI5zTPScSMlQYFpCOYJ0tcQ8wP+8x5IWB4518r
         HBbNPthfPnLh0UljjBNVyz9HBInyqNJtip0F8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493413; x=1761098213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=822jt5nEXo/RsUhaWbDrvompK6uhrTRlKH06xCVQnfc=;
        b=Ny7W79YhZuV7xkmtLKLAQ8LzmDtjdgi/0D7osDSPSjTGTA/h8LDjjnEMTAk8TT24So
         vs/QlfPzCKsi130CfkcRNPmFzvo+41DAOAmcEmeME2MAi0eoESLpSUjmhkWGgpzMCE7U
         ufMbb7SabVrPQfi0lqTA1mIdFq+SbDdryIjm6PEzpHznQFrrgzjgspMhQ3XvcAuBXbNy
         qboIhkU9IYopWWBG7Vmx6j7A0le+swsxM6BEKbhLzwqbfoPwl4n+AuEJJyCaRb9800F8
         +zLwhSCAzYLilE+SX6jIoD+wctiPIsdPd6in4knkEAMtgZh8v3oFisfobJ8tweeeK/ZO
         kvIw==
X-Forwarded-Encrypted: i=1; AJvYcCWAskqPBjaluQ4YfmKxCSQbgpIpLuQ3FQAzeCyCixGo5oc51f6/o+BtkFbTj1Xh7KjH/9MOxOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZf4xmm/h54lVGWNR07e5A44cI7NNbzDWEidwZNLHMVY+SV4Tg
	U1P3x90/7+Zzz8kDA4fUYgrf3UkCCf1bkD/073a4UwGxDnpxgSCIzNDlrWpDwmU7gQ==
X-Gm-Gg: ASbGncuB4ZxeXbQR8+oR2+5BK9prAf8nCT8a2h6sVrbfkD3GDNBwhalbktsDQubZmsL
	dGAPIJe9ARFQeAo783wWXRGFVeUFSuFT4P5GvPdqwSJ9G/SA5EvylDka7vHy5l3xrYGaLy7Jd6c
	42QxpRVZltheMNnRgn/CmSJPLAF+BDwUDdssAUP9TFtpwlgIPrQewGuiPoeNtPFaH8qJTqsB1ow
	3/FHTmwndl+XyxYxB74B36nFU8Kc92SNhsxbxNYKYxfQzmFwEBLlmCwxndN/ajAbbv8MhISmA46
	GBca5OrFFSQu+WdirSqGA2LABVh0UbDLdqtDuZU3N8ALc1Iq6vjL9BAQHu48dGa+seHpHdQpdlK
	hOYgwcf79BuiPUyY6mt4zBadZMCykJ5v5e8lQBl2iwJ/t6xMGd2GzfA==
X-Google-Smtp-Source: AGHT+IFSmlSytCc9zkvG/SRHsjlMMQoRxAEYdYK4gnYvww//dSwAhUqG1pTtzJHUpugUyz5xS6ETKg==
X-Received: by 2002:a05:6a21:33a4:b0:2cb:5f15:ebf8 with SMTP id adf61e73a8af0-32da81724d5mr33293736637.27.1760493413122;
        Tue, 14 Oct 2025 18:56:53 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:f7c9:39b0:1a9:7d97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b678df48a83sm13978466a12.31.2025.10.14.18.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:56:52 -0700 (PDT)
Date: Wed, 15 Oct 2025 10:56:47 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Christian Loehle <christian.loehle@arm.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>, 
	Sasha Levin <sashal@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Tomasz Figa <tfiga@chromium.org>, 
	stable@vger.kernel.org
Subject: Re: stable: commit "cpuidle: menu: Avoid discarding useful
 information" causes regressions
Message-ID: <wd3rjb7lfwmi2cnx3up3wkfiv4tamoz66vgtv756rfaqmwaiwf@7wapktjpctsj>
References: <36iykr223vmcfsoysexug6s274nq2oimcu55ybn6ww4il3g3cv@cohflgdbpnq7>
 <08529809-5ca1-4495-8160-15d8e85ad640@arm.com>
 <2zreguw4djctgcmvgticnm4dctcuja7yfnp3r6bxaqon3i2pxf@thee3p3qduoq>
 <CAJZ5v0h-=MU2uwC0+TZy0WpyyMpFibW58=t68+NPqE0W9WxWtQ@mail.gmail.com>
 <ns2dglxkdqiidj445xal2w4onk56njkzllgoads377oaix7wuh@afvq7yinhpl7>
 <a9857ceb-bf3e-4229-9c2f-ecab6eb2e1b0@arm.com>
 <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iF0NE07KcK4J2_Pko-1p2wuQXjLSD7iOTBr4QcDCX4vA@mail.gmail.com>

On (25/10/14 16:02), Rafael J. Wysocki wrote:
> > >> Would it be possible to check if the mainline has this issue?  That
> > >> is, compare the benchmark results on unmodified 6.17 (say) and on 6.17
> > >> with commit 85975daeaa4 reverted?
> > >
> > > I don't think mainline kernel can run on those devices (due to
> > > a bunch of downstream patches).  Best bet is 6.12, I guess.
> >
> > Depending on what Rafael is expecting here you might just get
> > away with copying menu.c from mainline, the interactions to other
> > subsystems are limited fortunately.
> 
> Yeah, that'd be sufficiently close.

Test results for menu.c from linux-next are within regressed range: 78.5

