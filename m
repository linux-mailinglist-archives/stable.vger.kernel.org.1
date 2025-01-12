Return-Path: <stable+bounces-108340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82C1A0AB0C
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 17:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA9D1886B60
	for <lists+stable@lfdr.de>; Sun, 12 Jan 2025 16:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB621BD9D2;
	Sun, 12 Jan 2025 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eUuMqpF8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8152D157469
	for <stable@vger.kernel.org>; Sun, 12 Jan 2025 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736700644; cv=none; b=puiC+eOQQ1J5bj0wS8anAnSK7BgVmE6ResH2WYTCPSVNhNSswbpuKcq0evvxNYVJ/+nsyMgW57BwEoItuiRwKEFxK37obR/gV7E54N5jL862eVsCm8T2KrcfGRh9DPcm8P9bpV/NaM+A2iMzQX5uKkC+ckSzldeCUwtobbhX8iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736700644; c=relaxed/simple;
	bh=STvtkXTGScRKDfoJ1sZKhWwhO4x4Ppifa2A0qPDM6V0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qmOOeSwGfzDTp8dMKRlx+HoZnZpD7PK5yzMVLO//5XGUSeMNwEfx7ew7/3LYYdSes29Cn2uiFecgLZRp6gAPQOOjdB2eZfIw5E1fHqkCMKCDvC0EIlV4NOvIsulhMG7HPQ1D0cyUCE2zReZjzYi4Ln7BLQwRgEwtP2TdIqYrIQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eUuMqpF8; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so703274366b.0
        for <stable@vger.kernel.org>; Sun, 12 Jan 2025 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736700641; x=1737305441; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EH85sSFD0I8RKRLO5GXpyJOdD/Hu7Ugk+HsNoMJDA/c=;
        b=eUuMqpF8ZtjTDMekCMv8BI+QsybH/MQYhBRGsAn9fuWnYN90F2pq0TMhtf1Os0PF8C
         gqr6EpDqRT3ZxQxYIqQtS/xpnbz05KI6TWx0lau00ZkoFBdF5XLFzrIrMUmyyJW+VFhw
         uIM0ZNoqi+Ngms3LYYG6HjKc/By2TZoedgIiOyBnanqkrQWgFwE8/+CXCxumGhXwAPeh
         qOAQHb6EZ6Z7z5Z4XvL5aF81Zo72Hj1ASZtH+v8RlyG3RW3XBSPcBkDp9Sor94D1I8fh
         SSWeR+7WHlorv3oDH0CW0NLYz3pAvN4R+N1U2EQ4AjR5mNDe9HHng0eyQeNCHzlMf5N2
         e3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736700641; x=1737305441;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EH85sSFD0I8RKRLO5GXpyJOdD/Hu7Ugk+HsNoMJDA/c=;
        b=a5u584SmMokpfn+hn12qhmqsrwql3Mv9Kp3ehesad2Deoec5UcYPXsVgrhqrT+pNZq
         ZkKkwJ4cQ2rUo+Ht7uR03ozVdyGe/bbP0/qBxhklIYd8TkjbAw2CC9esP4XgUpmMSuIg
         xRwPMkc0oFIyUhQPnBLzBr/J3soa+ydmxb0e1uIgZTboun4g5vCGE0F0wM0uCZgEQIQN
         8QLt12hQHmnxiBWBu7IwnJQKSj614x4Mt6oWWF2vFcMSv7a/SKWKcUksEfB5UfYMQrgd
         3ZENr2P1D/1By/Ie+9H4aUVGlCY5kk8jGhMcjNDxKeTLfi8GuA6z1FaTF4+w0kfN5fJp
         vb0g==
X-Forwarded-Encrypted: i=1; AJvYcCVCQslbae4qrXCz8NPqrtorjxsDdW+pxblO17ZtgLUbRz2tosyHIaG0LEZtN98TJ3WgoyLmj9E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu26/MNQg3+4dtZ1nIQU/nrO+VMWPSeKnf6dV9ijupLiC2t+tU
	ZikmgrXq213PBC9B9UpO0j8ju8K5P2BlUqKQqWOK0ErRD4jvfOzi
X-Gm-Gg: ASbGncuhWYbygXRi9A6S524MYA+5BQtEC8XYLPYa5rlBgc35amu6zIx2cWLdxqwXOGb
	nykTD7OvALkFTblo0JmIzUbrwdsH/MAPVVZPw2Qz+hKwj0mwpbjDiaok0/ZujsfPRkkDsvYpw8m
	VrbFGMLwO0Twiy0SvZdDnuVRAiKljt1n0LorxqzzZMmh4pFpt1ofa4wNb3jF7SY/FzJdZGaxyGz
	uIRz7uM/euzd1/M60ODoYlB1y+revaKFgjl/v2fu/rS3fSKyayBDmuAYqld69hWLefm1VgkBV6e
	+BUKYqH89Zqi89Yb
X-Google-Smtp-Source: AGHT+IHuk6/ppT4TFtPfQBDCYDnfaFnjLJAXVAtkKCh3Doo+KQYjYQ582bYrlgJ5+zQgd6D+Yj0acQ==
X-Received: by 2002:a17:907:96a7:b0:aa6:2c18:aaa2 with SMTP id a640c23a62f3a-ab2ab73e7dbmr1538812666b.27.1736700640508;
        Sun, 12 Jan 2025 08:50:40 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c9562551sm389940466b.123.2025.01.12.08.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jan 2025 08:50:39 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2A531BE2EE7; Sun, 12 Jan 2025 17:50:39 +0100 (CET)
Date: Sun, 12 Jan 2025 17:50:39 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"sashal@kernel.org" <sashal@kernel.org>
Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
Message-ID: <Z4Py3_xhFkoJ9ivC@eldamar.lan>
References: <20241227073700.3102801-1-alexander.deucher@amd.com>
 <2024122742-chili-unvarying-2e32@gregkh>
 <BL1PR12MB5144159BC2B99D673908BB88F7142@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2025010334-deniable-hurled-4f0c@gregkh>
 <BL1PR12MB51449ADCFBF2314431F8BCFDF7132@BL1PR12MB5144.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL1PR12MB51449ADCFBF2314431F8BCFDF7132@BL1PR12MB5144.namprd12.prod.outlook.com>

Hi,

On Thu, Jan 09, 2025 at 06:21:19PM +0000, Deucher, Alexander wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Friday, January 3, 2025 9:41 AM
> > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > Cc: stable@vger.kernel.org; sashal@kernel.org
> > Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
> >
> > On Thu, Jan 02, 2025 at 06:08:38PM +0000, Deucher, Alexander wrote:
> > > [Public]
> > >
> > > > -----Original Message-----
> > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > Sent: Friday, December 27, 2024 2:50 AM
> > > > To: Deucher, Alexander <Alexander.Deucher@amd.com>
> > > > Cc: stable@vger.kernel.org; sashal@kernel.org
> > > > Subject: Re: [PATCH] drm/amdgpu: fix backport of commit 73dae652dcac
> > > >
> > > > On Fri, Dec 27, 2024 at 02:37:00AM -0500, Alex Deucher wrote:
> > > > > Commit 73dae652dcac ("drm/amdgpu: rework resume handling for
> > > > > display
> > > > > (v2)") missed a small code change when it was backported resulting
> > > > > in an automatic backlight control breakage.  Fix the backport.
> > > > >
> > > > > Note that this patch is not in Linus' tree as it is not required
> > > > > there; the bug was introduced in the backport.
> > > > >
> > > > > Fixes: 99a02eab8251 ("drm/amdgpu: rework resume handling for
> > > > > display
> > > > > (v2)")
> > > > > Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3853
> > > > > Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> > > > > Cc: stable@vger.kernel.org # 6.11.x
> > > >
> > > > So the 6.12.y backport is ok?  What exact trees is this fix for?
> > >
> > > Everything older than 6.13 needs this fix.  The code changed between 6.12 and
> > 6.13 which required a backport of the patch for 6.12 and older kernels.  All kernels
> > older than 6.13 need this fix.  The original backported patch targeted 6.11 and newer
> > stable kernels.  6.11 is EOL so probably just 6.12 unless someone pulled the patch
> > back to some older kernel as well.
> >
> > The commit has been backported to the following kernels:
> >       5.15.174 6.1.120 6.6.66 6.12.5
> > so can you also send proper fixes for 5.15.y, 6.1.y and 6.6.y as well?
> 
> Ok.  The patch is only needed for 6.11 and newer which is why I
> specified 6.11 on the original and the fixup.  Kernels older than
> 6.11 didn't support DCN 4.0.1 so it's not applicable.  Can we revert
> the original patch (73dae652dcac ("drm/amdgpu: rework resume
> handling for display")) from 5.15, 6.1, and 6.6?

That 73dae652dcac ("drm/amdgpu: rework resume handling for display")
as applied as well to the 6.1.y series and needs to be reverted again,
can this be the reason for the regression report in Debian as
https://bugs.debian.org/1092869 ? (caused after updating 6.1.119 to
6.1.123).

(I have asked the reporter for more information, once I have this
information I can provide a proper report back).

Regards,
Salvatore

