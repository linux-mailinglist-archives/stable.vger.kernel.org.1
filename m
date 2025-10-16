Return-Path: <stable+bounces-185939-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD164BE2542
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37D17425539
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 09:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD2E26F46F;
	Thu, 16 Oct 2025 09:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lAP/uSlH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0F73254BC
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760606245; cv=none; b=H5WRbfI9rXi1NdrvlW1W6PKvtTU/mPfhDhgSDiWNOPzTUXtYwHPvvegOqxX/AHT8IWw9Lpf/BtaiQHlT+olrZ/Pco+/4/G3KU07OZvOPZgXvRT/BoZBMfQ61PPlf6IPfb6qXcCci2SeqwRQMLH2t8NF/2JCBAq66KqnfsEe2ZJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760606245; c=relaxed/simple;
	bh=eqLUPEo9Gd0DbwcwfRLPBforA+nxsuQCkKFW6i15MhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXgC69VjxS2kP5qxFvYE6e6uoMID4fMUZVpGHvPnSV9Wz3IvbbVjgxKu8TmMaBIAcWgqusiDAzekHdur+SSP+/fEnsJ6G+j3O7OSolvGwBEW9VlSYu3UTs8EPJT/b+o3oVs0+QUBwA9qPfshT5hPG411vD13nfLOfMpKSx8uulo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lAP/uSlH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-279e2554c8fso5327805ad.2
        for <stable@vger.kernel.org>; Thu, 16 Oct 2025 02:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1760606241; x=1761211041; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YewhkkrAxR5skN2UV7So4kHeHU1bICBISRlzVyf8pn0=;
        b=lAP/uSlHX4iU34w6VvxdSORazTN2gqKD5ziUIb+pcD0SHPHrPIB2N3RAsu96TOIFQJ
         JMMNxK+ragTE9U6B3o4CbsjNqmvpdd2Jh5s+5f9MH+j6dEnN3Keb/23KGAwVHjFnB/zy
         QD0eaKCanmyruGDpmOrfl7CeSPK3WsZ9O2+3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760606241; x=1761211041;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YewhkkrAxR5skN2UV7So4kHeHU1bICBISRlzVyf8pn0=;
        b=AwUZDarTzYGZiCuVHBXMoLFjTUK9KzhoycTNL4vUGUwt6mIAASM7R/GxhxGem+7HSg
         plUbacro6FiZLUwCFwyNON8v/xyL+K8X7GsMoZx7ob50uUcOm/KkDO1j3J4T0OMJcjq5
         0Hm9VLgK1Y12uSeMwmpJDoaNVZ87vMlICWffmVBqBtfBaVkfQ6V2s3k5O0hgdFVI2Uyc
         ElvD6KreLIK91au8giCv4NZus17X15u5Z7/81IzQ621H0eQG0GaeNH6/hg4MTb4MW+hD
         xd5Tm+Gp3SmUveU6glzeWMDI7pSZ6ZprIjIrt0cmGr4b4y5TUbITKiPGEzYi86ZMz51o
         STvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQJZxsZkVRhbf0qfDC2d6NbTxDff3wk8vWSFDh+M4mWqLxmVN28AZV+MtfDPgfHQlgUzCZtCs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6kjHq7knVyBJf1ZWwcR2XZnwOfGjVUz6qNAng0lWVCNP8b7tQ
	jKmcpMUsGERHjxYdX8ExzUWw+IqKVsYah+AYXcadIrKl1PEzKNxaSDb57gBKncjzUA==
X-Gm-Gg: ASbGncuWrNvH78jmwHqjkvUK0qU8ezDp8DU9PNBpWSRfqlWGQppLGzusNZy35qch0xB
	LnyezeUhVLXGKrwA9fEeDFss4z8GLMQ6dqv/LwER43Y8BcFll6/g0C2+VnbhhPdN1GruYTwHfqI
	fxDJBsjTZASs74A05iS4cOyctOSThg76VzRtwR4WuAcvdPFnmhL0iiSf0W3yx3dEsON4ANomnwj
	UToolH33O4VqjrBqIPZvi+f4g6WPfroMTAWqGWnSXBPt+/gy6EX8xMS1Bb5OkmS8vK/gK4lpcIf
	dqWwqJvC7zi4prGm3VB3gDv0MboATMLB5CvfQWLTTWrvVuQvMsNh9x4sONI41yEkb+9lOferisB
	he8eE4cm1PfQl3U7U0vaEYwfC4PWUT5QzudxuExx8D7Pgoct7uzLXO9pQPYO4PGvkqsNfSilLDW
	aRtAyoKtynl1aWfw==
X-Google-Smtp-Source: AGHT+IFoMJAa9tR1kziKAzA6Wcvm3FfHVTemEffdiwWmdyUMKYfNnFDLp/93IJJ4us2oCj2e9wtLYw==
X-Received: by 2002:a17:903:41c9:b0:23f:fa79:15d0 with SMTP id d9443c01a7336-290272e1026mr461762145ad.46.1760606241351;
        Thu, 16 Oct 2025 02:17:21 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:98b0:109e:180c:f908])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099afe03bsm22931265ad.107.2025.10.16.02.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 02:17:20 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:17:17 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, stable@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Christian Loehle <christian.loehle@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.1.y] cpuidle: governors: menu: Avoid using invalid
 recent intervals data
Message-ID: <e6jvienmvfdr6pti3phhbpuot7p7tbg5oysctpcwpwy7s3twqa@m3nuc6zqmkc7>
References: <20251014130300.2365621-1-senozhatsky@chromium.org>
 <2025101614-shown-handbag-58e3@gregkh>
 <p7j4aihzybksyabenydz634x4whuyjxsmvkhwiqxaor5uhpjz7@3l7kud4aobjf>
 <2025101606-galley-panda-297b@gregkh>
 <s7rjg3bxmjqxmqxppivrunk2awl2zwgxz7zb3godj3s2tvktg6@twicqbqsnuqk>
 <2025101611-shrubs-gigolo-3c4e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025101611-shrubs-gigolo-3c4e@gregkh>

On (25/10/16 11:12), Greg KH wrote:
> On Thu, Oct 16, 2025 at 06:08:39PM +0900, Sergey Senozhatsky wrote:
> > On (25/10/16 11:05), Greg KH wrote:
> > > I've queued up a backport I did with a cc: to you on it already, that
> > > should be identical to yours, right?
> > 
> > Looks right.  Thanks.
> > 
> > // I wonder why doesn't git cherry-pick -x add SoB automatically.
> > 
> 
> You need "-s" to add your signed-off-by, "-x" just adds the text at the
> bottom about the original commit id.

Oh, today I learned.  Thank you for educating me, next time I'll
make sure to use "-s".  And sorry for the missing signed-off-by
in the backport.

