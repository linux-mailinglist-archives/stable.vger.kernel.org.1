Return-Path: <stable+bounces-112035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3E4A25E67
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 16:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0BD3AB92B
	for <lists+stable@lfdr.de>; Mon,  3 Feb 2025 15:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE3D209678;
	Mon,  3 Feb 2025 15:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="Wr+bly4O"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED89E205AA3
	for <stable@vger.kernel.org>; Mon,  3 Feb 2025 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738595548; cv=none; b=HfWtejZ3BM+n0PUL21e4mr43VeUDIOQDMLtE6bxEA5yi6T/q/Od8Go7Pv53ceKmKAt4JL6wgueJf5K06twtq26Sv2h8Vpkp3bYaunmokGeUQszEaJgi/5a/xWukyNfWJrlrIq1zgqRp42btJ0QbGEejquprOb50PD978x5Ycoqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738595548; c=relaxed/simple;
	bh=De3tZJ+i6RyFMLShSETS1a0kwp/lElizeBd6vf1Kk1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=efwwVNYpNPyGB/dMYSOKTConDzQ7+o7XbL6LR6ZI7ec3wk4Z8cIuh/Ky7FdCpbCD6/DaellJeYLWF/Kj+Mbjza+0N4TQL2T+frWpEHWdGByAmC93Ugfx83srh1o1OBDdn2pyU1fbF8EkEBtYYwyXZMZHpGBPw9T0r7dSd3hKXbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=Wr+bly4O; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4678cd314b6so42347071cf.3
        for <stable@vger.kernel.org>; Mon, 03 Feb 2025 07:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1738595546; x=1739200346; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0uRjRCoiTmQxPaUbLc8rVKhXS5CF+EA4SHG9IAe/UnA=;
        b=Wr+bly4OQKwdMoHg9Y0qe9L40TIko1GsFSUrkq2tX3li1sVXyzTNUvoF2QRYp1oqYU
         N4yt/UwTmaiSY+6i5iE6ScjQG/r3rkvhRHLnQ8d2yH3sewm8gMtsP86dRLbjnHus+H0/
         qDOq57vh3wFkq2TC0S+Zb6ySrOGUpP1lpNIqFv1bIkBpZeyqvFVfVjnAq/OXtj/8Khjy
         9txacgMhzIoRZDgSoWu/jDv3TI0k8aCJUd8ZdJnXkKk4mYYyx6iW51LBSYYcNYtFrg7F
         GkOOdzxsDnhXenaIrRA3Vt2o/sPyXzNqoq0rvRLtVdCB1TZLv7J1ysGZarggReTvDp6H
         TGbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738595546; x=1739200346;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0uRjRCoiTmQxPaUbLc8rVKhXS5CF+EA4SHG9IAe/UnA=;
        b=XJyvOU21DFWzmvSTEgRV8alMUotdN6DP57vHb/mfF1JC2FW90P6DdHp8fhHyZwVRrE
         8meWn9MGXKL29n/GZ3C1T7rd62nmTrrzeezS0A9ixvQ/nQycx9Ch4KBDgtNnJlltaIgK
         iQtRQuIPVXOq/p78w84rEP0DdF5+8ATcaOnJ4y0FBhZR5YkBiCV0UYwxhKl1B+20o5OU
         7TTGjXYIJLWlc7F4JrngWGmyIROvzceUE8JIfV5AaLDHdooUK0caeApDDZ8GZEEKfsDI
         evd8Vicghqod6aF18tX6cNN0buUQ6dAWfBY1aAMoFNOhRbIK6q9G3XrAWnWbbchCsYtR
         309g==
X-Forwarded-Encrypted: i=1; AJvYcCXzkFzc0BMqap2lWoubUZKVz60/WBFZP5xTVn9cUrvt8/COGdsNYHDpeqOyS7yr0YryzaUZSSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfbWjzP65jwj8z+wg8ZHBfIsgdyvcnGAGNprX1ACljOmi9eQk1
	Rg68q7wwy0+/8ixC66VTgSgzAXtOVxTeqzj/7lnmRzLFPqLSTWd1UUZ89KydLT3AUWqbBG1xYEo
	=
X-Gm-Gg: ASbGnctgH6DowIPEmfXMwjZDoLbU1tU7xAwPkv4LjQMIR+1Z8SXRJSQ4Cv6rQgmmzcp
	/mAFHtZwhdQw8qtSy5Mc/ZyeY+FMZjNZb5biMsEinshj2tdVN34JgBXsv0+5+MfGMoNfo0FS78N
	cObpYP7+s3PYDtIaGNZwFvAyimexUjYokb5IAvThhLg40vnmDa+IBSzsPDTTporeTrD2t5IY02W
	rD83Lzl088X7yv6OPyyZlUCe1KROGUeplFhTzuLXXHuiVuhIR4+ct+lTi2zplwupGOq+ox7CXmo
	Wa0zn04txBFo3yVzFyf9WZjsTlNSmSqntQ==
X-Google-Smtp-Source: AGHT+IHyUL2x0qBbG+DgG0G3rjDNRAFJ94tx2vEQWzKX0Qbs1ZMr7OqI1ExwtF+LFOaQezc0ZvX8xA==
X-Received: by 2002:a05:622a:13d4:b0:467:57c8:ca31 with SMTP id d75a77b69052e-46fd0ba39dfmr318463241cf.46.1738595545561;
        Mon, 03 Feb 2025 07:12:25 -0800 (PST)
Received: from rowland.harvard.edu ([140.247.181.15])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46ff30fc6fesm33943751cf.27.2025.02.03.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 07:12:25 -0800 (PST)
Date: Mon, 3 Feb 2025 10:12:23 -0500
From: Alan Stern <stern@rowland.harvard.edu>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] USB: core: Enable root_hub's remote wakeup for wakeup
 sources
Message-ID: <61fecc0b-d5ac-4fcb-aca7-aa84d8219493@rowland.harvard.edu>
References: <20250131100630.342995-1-chenhuacai@loongson.cn>
 <2f583e59-5322-4cac-aaaf-02163084c32c@rowland.harvard.edu>
 <CAAhV-H7Dt1bEo8qcwfVfcjTOgXSKW71D19k3+418J6CtV3pVsQ@mail.gmail.com>
 <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fbe4a6c4-f8ba-4b5b-b20f-9a2598934c42@rowland.harvard.edu>

On Sat, Feb 01, 2025 at 11:55:03AM -0500, Alan Stern wrote:
> On Sat, Feb 01, 2025 at 02:42:43PM +0800, Huacai Chen wrote:
> > Hi, Alan,
> > 
> > On Fri, Jan 31, 2025 at 11:17 PM Alan Stern <stern@rowland.harvard.edu> wrote:
> > >
> > > On Fri, Jan 31, 2025 at 06:06:30PM +0800, Huacai Chen wrote:
> > > > Now we only enable the remote wakeup function for the USB wakeup source
> > > > itself at usb_port_suspend(). But on pre-XHCI controllers this is not
> > > > enough to enable the S3 wakeup function for USB keyboards,
> > >
> > > Why do you say this?  It was enough on my system with an EHCI/UHCI
> > > controller when I wrote that code.  What hardware do you have that isn't
> > > working?
> > >
> > > >  so we also
> > > > enable the root_hub's remote wakeup (and disable it on error). Frankly
> > > > this is unnecessary for XHCI, but enable it unconditionally make code
> > > > simple and seems harmless.
> > >
> > > This does not make sense.  For hubs (including root hubs), enabling
> > > remote wakeup means that the hub will generate a wakeup request when
> > > there is a connect, disconnect, or over-current change.  That's not what
> > > you want to do, is it?  And it has nothing to do with how the hub
> > > handles wakeup requests received from downstream devices.
> > >
> > > You need to explain what's going on here in much more detail.  What
> > > exactly is going wrong, and why?  What is the hardware actually doing,
> > > as compared to what we expect it to do?
> > OK, let me tell a long story:
> > 
> > At first, someone reported that on Loongson platform we cannot wake up
> > S3 with a USB keyboard, but no problem on x86. At that time we thought
> > this was a platform-specific problem.
> > 
> > After that we have done many experiments, then we found that if the
> > keyboard is connected to a XHCI controller, it can wake up, but cannot
> > wake up if it is connected to a non-XHCI controller, no matter on x86
> > or on Loongson. We are not familiar with USB protocol, this is just
> > observed from experiments.
> > 
> > You are probably right that enabling remote wakeup on a hub means it
> > can generate wakeup requests rather than forward downstream devices'
> > requests. But from experiments we found that if we enable the "wakeup"
> > knob of the root_hub via sysfs, then a keyboard becomes able to wake
> > up S3 (for non-XHCI controllers). So we guess that the enablement also
> > enables forwarding. So maybe this is an implementation-specific
> > problem (but most implementations have problems)?
> > 
> > This patch itself just emulates the enablement of root_hub's remote
> > wakeup automatically (then we needn't operate on sysfs).
> 
> I'll run some experiments on my system.  Maybe you're right about the 
> problem, but your proposed solution looks wrong.

I just tried running the experiment on my system.  I enabled wakeup for 
the mouse device, made sure it was disabled for the intermediate hub and 
the root hub, and made sure it was enabled for the host controller.  
(Those last three are the default settings.)  Then I put the system in 
S3 suspend by writing "mem" to /sys/power/state, and when the system was 
asleep I pressed one of the mouse buttons -- and the system woke up.  
This was done under a 6.12.10 kernel, with an EHCI host controller, not 
xHCI.

So it seems like something is wrong with your system in particular, not 
the core USB code in general.  What type of host controller is your 
mouse attached to?  Have you tested whether the mouse is able to wake up 
from runtime suspend, as opposed to S3 suspend?

Alan Stern

