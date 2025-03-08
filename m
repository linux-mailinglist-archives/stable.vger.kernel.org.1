Return-Path: <stable+bounces-121539-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45A6A5795F
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 10:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E75AD17161B
	for <lists+stable@lfdr.de>; Sat,  8 Mar 2025 09:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AB31A9B53;
	Sat,  8 Mar 2025 09:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f2CebwcH"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61327190470;
	Sat,  8 Mar 2025 09:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741424809; cv=none; b=TOozC6ajYa/jSI3en93ZQajCGEKeOLoteB1VtNdMWDic790vYehirfwbaiZIclDznoyCeebq97H/T6NHsOO1QRWlHzvQFriToIg7MRADD4yXezRgw0R1nkoeXK1jemHlPG1+UIIT3kzmFV4R5QlS1h1DuKi55vE+e/WkTI9V6xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741424809; c=relaxed/simple;
	bh=nfhjE40xxkcPs3x/zKH+iuKpPgn5nQqIk3wcE5A/8bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKeQXQTBabj/PvJc6zFN9GfBKMj0V7Xj75FZx2dkTueQB906KRupJq3vVjeNI7Ew9+aQz1CKQcfgRu0SuMumIicoDFjSkC38Are9Bn+N8S1GZUh27RlJNuWlgeT+xW59/PSTG5BQlfQoueOXpWxVqJGjnvHfNRpEhhQ3KqFiW5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f2CebwcH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac2400d1c01so447174866b.1;
        Sat, 08 Mar 2025 01:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741424806; x=1742029606; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nfhjE40xxkcPs3x/zKH+iuKpPgn5nQqIk3wcE5A/8bI=;
        b=f2CebwcHOHAlkK6Y7H/C98MMH3U6h7nkFYVS7IeOi1j3quoHc/Ua3MxgHcVn8Dd8YY
         R445xjW7PTfjHrGD2YgFEO7lJYuDmxbJw4rKaMABb43/ltdXxG5e7CcdqO1tNHRdrPhe
         8FZLxiLg4zfSMMR+5dn0EOw1wmGiHozsL+pvK9v5JUcAA/VwTkGVaPDSv3ds1+22xPmP
         e2sqerHtDm+sXJKhGPhWJbZye1XiVPw1e30bEUHMjtreg1XrwMscBwGTiRZN1FtxQfMI
         6QKoZKVDI7l9R9DC5Y045VcHGtA9o6JaAQsu7sbspcruQZOjTgjwZvUhVWEH8zxmfsmW
         EbEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741424806; x=1742029606;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nfhjE40xxkcPs3x/zKH+iuKpPgn5nQqIk3wcE5A/8bI=;
        b=GNoBKywarKTvhTg2ilYd/j21DvUugwAyu1Psd6jOCYfHiEMO/dJnvJ3G1sMgJ21dhW
         eCyYP5SZqR7u0zpchtQQcejFZRF1ZmsQ9MeU0YawodkH8Z3t5zkbi8vbPVfG1kK6+3Ue
         2dZ4tEqvMLis7lC2gFzRCnsWhYO/LLWVJdhKZDOb2jZd7cWe6p7ebahsPk5quY3nSHk3
         A8NjABVoN1RdlSHryX2Q39k/E+l2HG7EMJm/2xc4G/rEtt9O3To1qO9U8NJ0hRC1ShPW
         Oz2lLXo9hFG88UKprtk3pIpN/sJKpyOxmn6IE8WUNTKPJUu0EdQjlvW2p6wiqSR48KVO
         teyA==
X-Forwarded-Encrypted: i=1; AJvYcCWbzIMxOl5PFWFoDcF9ITaxn+8RvgJxLBxYuQaZpuRp+c+855skei+HnP3SCIwj7HaDe76esC0/wzyEi9w=@vger.kernel.org, AJvYcCX+OXEipzcwpXipLabcnPEZagJa8XUkFAd23390XNMQA5fX6xSH2+m7o7RYHxanGbKd1tciwxVg@vger.kernel.org
X-Gm-Message-State: AOJu0YwH2ctSJ6+ueWHnWW+Ke112QchhxwOWYT5d10VhvhtPqBKoYEIj
	PlR/n/xjfUdQ3AbryMGIuyKeRW3zGB++KLw/WpblQDUY4UMMhMW3a56w2t02yMNzhiFGoS7z6wK
	XLT4TVdVny9tA1JL4EGVXzQx8kkw=
X-Gm-Gg: ASbGncviu5gLhc21uVd6LfgTHvg3uChWCYiqJ7RcUeDPXjnKhDDOtp2Owj3KKQPxZM1
	MM+OV65QRoL+C9m4LsfLe9tJZ2AJKp+B+Ct5SyoCeOUORESH40E/b0XzR7nvoGYHg2rGWq77q1A
	+fw97OjDGwiD7w7bedYO3RkOdD
X-Google-Smtp-Source: AGHT+IHkeM05YvQ3aCsNf4yKtzCuNpIM0jL/QQ2Us5+xQQOxNr0NPQZlyzAQUOEgBpZrXn/lKU5lNudpr9HcScj5mIU=
X-Received: by 2002:a17:907:9703:b0:ac0:4364:4083 with SMTP id
 a640c23a62f3a-ac26c55ad33mr318540966b.0.1741424805405; Sat, 08 Mar 2025
 01:06:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMpRfLORiuJOgUmpmjgCC1LZC1Kp0KFzPGXd9KQZELtr35P+eQ@mail.gmail.com>
 <2025030559-radiated-reviver-eebb@gregkh> <CAMpRfLMQ=rWBpYCaco5X4Sh1ecHuiqa91TwsBo6m2MA_UMKM+g@mail.gmail.com>
 <CAMpRfLMakzeazr91DBVyZQnin7y6L9RB+sPFb59U1QZvY3+KBQ@mail.gmail.com>
 <2025030718-dwindle-degrading-94d3@gregkh> <CAMpRfLPLJA4TaJQCeYfn5XRFnVdqJ36yv-1LL7o=kjYOAj9u1Q@mail.gmail.com>
In-Reply-To: <CAMpRfLPLJA4TaJQCeYfn5XRFnVdqJ36yv-1LL7o=kjYOAj9u1Q@mail.gmail.com>
From: =?UTF-8?Q?Se=C3=AFfane_Idouchach?= <seifane53@gmail.com>
Date: Sat, 8 Mar 2025 17:06:29 +0800
X-Gm-Features: AQ5f1Jp1hvuPcDaUxTR56G33cLSG2ApeIhs0Aj6N0KUu2izrRwnaakZ21ArTRiA
Message-ID: <CAMpRfLOmXBFatrp-tuYF=XeruyDLUE=Dk=yxx7N_nHP7NsQ5jA@mail.gmail.com>
Subject: Re: [REGRESSION] Long boot times due to USB enumeration
To: Greg KH <gregkh@linuxfoundation.org>
Cc: dirk.behme@de.bosch.com, rafael@kernel.org, dakr@kernel.org, 
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Some development here,

I noticed today that while applying Dan's patch and reverting the
"bad" commit resolves the issue, it only does so on a reboot. The boot
is still slow on a cold boot.
As you said this might very well be a mix of different issues. It is
my own fault for not reporting this regression earlier thinking it
would be fixed.

As a sanity check I retested old LTS releases. I find that v6.1 does
not have the issue on cold boot while v6.6 does. The USB error
messages are there regardless, they just don't impede on the boot
process time.
I am almost 90% positive that those error messages have always been
present on this system, for what it's worth.
I have gone through the troubleshooting step of unplugging all USB
devices and headers and the errors are still present.

If I find the time I might run another bisect between v6.1 and v6.6
doing cold boots instead of reboots and report back. I am just afraid
I will just get back to the initial commit reported since this is what
I first did.

Thank you.

