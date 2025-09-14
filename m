Return-Path: <stable+bounces-179566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 897C8B56833
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 14:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A5B63A3F91
	for <lists+stable@lfdr.de>; Sun, 14 Sep 2025 12:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EC02571DE;
	Sun, 14 Sep 2025 12:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VsWhIibm"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413882550CA
	for <stable@vger.kernel.org>; Sun, 14 Sep 2025 12:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757851212; cv=none; b=tHGXPMNmbxCmnnEGbFOv9pwt4PpDhP5IzM9HTyLKnrOrOgWm7WnGjYznGFnRQJsG4qbuNXTWIApZIlO6amE1P1NKTQydGByDbXJ6T4zrBHNAGT9spEkGuLx7PvkZLoWapMMAyajnT0nKjlvz+76zJQq7+Lh34lP1eyQw4Vs02KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757851212; c=relaxed/simple;
	bh=H83KzL8/CfZhNhi4O5n9Ik6CFSV8CrYLcK1ANXxGpTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMzqbCdx5wifDhEr6JpcAV1de8gfxc/S/XFwYCC1uEwbfF+U9FqCXbVzncYCJI97/lVpEq9S6SVTkSwcrWxDG8NC9IfySo8VSG0zAOlm0PcWFOta6m22LyqLJaXS3qn7FCy/Elhqm+lq175pgzPuVi34anbbqWysyg4qL6m9XmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VsWhIibm; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-62ec5f750f7so5388045a12.3
        for <stable@vger.kernel.org>; Sun, 14 Sep 2025 05:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757851208; x=1758456008; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sFTAcA6XM8wkhD1HzW4kDc6Y/3kd/E27zk6PuMogAcw=;
        b=VsWhIibmk5hLiAlouffYSz2ycBV8ZUuspiwtHjrdmsv3zJHpCQmlelsj1y9tLvhSEt
         vHHkf+VbduRbJRGGsKZzh5NzIgUO5JUfaFFyjP5GLDSgO9O4E19uGs4mIs1L96ObjViv
         /r/h5EW/mcPFOR4aosDgG/Lhy0tHF4fc9bWD5uIOAPYp8q9KY6p62/ANZKtqSs3rMiPn
         sZflP7tGMkKBPlLjOeBFjd/toGZiXDs2CJbU/F8z1bGXVoPvtfwfcKgeCdibXmEL2QTg
         79loUasIUN0wbyrBYz8n6E+vD02ZQ+HkMrv9kaGkj86kVK2q6bqE/+wCRXuP9Azey4yW
         Lcpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757851208; x=1758456008;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sFTAcA6XM8wkhD1HzW4kDc6Y/3kd/E27zk6PuMogAcw=;
        b=ScVzokgoq2lvRJ6BvrjFPvQomXBsDZUapwZUwxKxci7TsyhVoj7GgUp8e1QWrLoT8f
         k+CERz8KHlJID8JAKKx/zbACtc3kwoEWSDBDWcdv6CDPTZhKwBDsbxU9Th69CZwypUdC
         7c38f/ADJBuGnMq0gYtM+bDAvYT+f66BiT/BZFqgA5ZxLLZFGN8p9/7giCzNKA8nTkrf
         hcgm/ODNWZpEJcWEzNuQkkomaoozL6ygrsH9hjo/rYekotdHPZY1S9/XfFcCcuwJ/F0l
         jpC42iopKtREOkbBWynMUfy3DZy3dBn1vbmNgOLL8NDurkVpBgnHFh9iDNm/npxBCuzv
         FNrw==
X-Gm-Message-State: AOJu0Yw1L/7uAoE8rXQXLLdIxXxvkI9cgttoddXn6B0ziwM90yEfn8q3
	yB01BH9VYdb0eRQcOFvpSmY9Ykp9X5uaevbs/y6QNgyRsQHag504BnbW
X-Gm-Gg: ASbGnctzAUxATxkkKe2W3RzNP2uivp/jckY5/0n1uKOfONpyd6njQKr53CfmNgSGvcD
	yLPCjhLwkH6EoDmEPjlz/q2PsgumHxvrxQ9tovgBzmm+i5B7H9VoBnMKhNvj2ivEDUEpcNWQYW2
	9V2oQJAT/EwlcYfzA2SOXmKIwpN1oVp5Hy6JDgUDF3sLHUDo9SPG4WOkZfKKpFGwwRr+5EEoq/P
	IsP9q/2Ss5PsQ3eruPjxlildQeZrVAEr4+90YcmOkDzo3nVx8d6WKexyZusPI9v2BDftCppQFuq
	k+UcgwMw8X91EDoi0Q1frf80e/MeDIrRBGT2UALtPKzzl9dgju+DMz1OorItTBvQnqi4JGJUHJg
	XKMpwJebZfwzBajT4GmnQlg2S9ie2H2EhJseluFfOYjI1SaCPnE5Smx2n
X-Google-Smtp-Source: AGHT+IHrhatpADYdxw5A1Cb3MSU9waSkeNIvXJj+dZ+fBnicwXRH+2zGZRn+rKJ+xNpYEQKKmll32A==
X-Received: by 2002:a17:907:f818:b0:afe:d055:7531 with SMTP id a640c23a62f3a-b07c3841de1mr924389166b.48.1757851208312;
        Sun, 14 Sep 2025 05:00:08 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07e1aed5ffsm334685966b.81.2025.09.14.05.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 05:00:06 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 78397BE2DE0; Sun, 14 Sep 2025 14:00:04 +0200 (CEST)
Date: Sun, 14 Sep 2025 14:00:04 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Marcel Jira <marcel.jira@gmail.com>,
	Niklas Cathor <niklas.cathor@gmx.de>, 1114806@bugs.debian.org
Subject: Re: Please backport commit 440cec4ca1c2 ("drm/amdgpu: Wait for
 bootloader after PSPv11 reset") to v6.16.y
Message-ID: <aMauROClYgtk9wrq@eldamar.lan>
References: <aMakc-rP93XNJaA6@eldamar.lan>
 <2025091431-manpower-osmosis-b679@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025091431-manpower-osmosis-b679@gregkh>

Hi Greg,

[note fixing up my typo for the Debian bug, sorry about that]

On Sun, Sep 14, 2025 at 01:43:38PM +0200, Greg Kroah-Hartman wrote:
> On Sun, Sep 14, 2025 at 01:18:11PM +0200, Salvatore Bonaccorso wrote:
> > Hi
> > 
> > In Debian we got the report in https://bugs.debian.org/1114806 that
> > suspend to RAM fails (amdgpu driver hang) and Niklas Cathor was both
> > able to bisect the issue down to 8345a71fc54b ("drm/amdgpu: Add more
> > checks to PSP mailbox") (which was backported to 6.12.2 as well).
> > 
> > There is an upstream report as well at
> > https://gitlab.freedesktop.org/drm/amd/-/issues/4531 matching the
> > issue and fixed by 440cec4ca1c2 ("drm/amdgpu: Wait for bootloader
> > after PSPv11 reset").
> > 
> > Unfortunately the commit does not apply cleanly to 6.16.y as well as
> > there were the changes around 9888f73679b7 ("drm/amdgpu: Add a
> > noverbose flag to psp_wait_for").
> > 
> > Attached patch backports the commit due to this context changes,
> > assuming it is not desirable to pick as well 9888f73679b7.
> > 
> > Does that looks good? If yes, can you please consider picking it up or
> > the next 6.16.y stable series as well?
> 
> I have a revert of the offending commit in the 6.16.y queue right now,
> as this was pointed out as causing a problem:
> 	https://lore.kernel.org/all/20250904220457.473940-1-alexander.deucher@amd.com/
> so that should resolve this issue, right?

Ah good, yes that should be equally fine (I missed the pending
revert). Thanks a lot!

Regards,
Salvatore

