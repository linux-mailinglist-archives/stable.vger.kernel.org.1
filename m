Return-Path: <stable+bounces-136791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED805A9E457
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 21:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 750F93B1452
	for <lists+stable@lfdr.de>; Sun, 27 Apr 2025 19:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D861F1EB194;
	Sun, 27 Apr 2025 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jsi+w+bS"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9431F941;
	Sun, 27 Apr 2025 19:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745781108; cv=none; b=gZ3JAJFv2Cn2RJS/f6gcaoxtX7pCIrTtEdebnY6AeDf2csqDOmS5t/8ZtU1ECjNRfYqPvm0FLF9vJvZYIbVHc/QMkCs3JdNU743MUW4o12YnQTNhk34lfzMjLOzARVo+KXO63YBHvvGbRZjdOutFFQb71+CWm86KaN8KZ3Jhwq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745781108; c=relaxed/simple;
	bh=ha+CD/QWZdr/qEctAEVQgT/2LNKeTiY01reuxChdQPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fsO8thC9+MHKr9uaxGJWubpbda/z3QyCTBi+c0X2p/KQDRl1I3ZG5L5ONASm3IouZj4Jkyi0w49cYSqUoSp1OTRlEPwAbQw4SvEEaisSWORm1YYCvYlTmRKtBDRAfUz1LIxGJubag6oq8kKxFrh1ZBz9Hv7veMiO4nSoQ78jKnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jsi+w+bS; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22c33e4fdb8so42283995ad.2;
        Sun, 27 Apr 2025 12:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745781106; x=1746385906; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Xq9WjFUkY/jJtaOUyR07QLAr3NdXDaHUkVXWwbHPAjg=;
        b=jsi+w+bSJy9E/QU6tFtTNHz2ahPlNUV3SRIUFthQMdCa1T08oLDgLlFEmVFx96dSnc
         yjFNnyRBmP9F8ib5EAHPRmzGkhBqsYmTBqpgzSqE8m3P9g0/BCZRiKQckHd+HXUgPidf
         sNEPOCFRfnSF9+Bn27zUL0gcfv6CJ29pIvVugZXurFOKnPkExO+XsJ4lJZGvoH6klheM
         ykmRy8RLTSL0BO7I3iFn8zdgIbyx9n4GnEdCaCraCWBtjJZp3EtLY5zQvLZd5MNrUH5o
         48Spkld5h8vfuuD5uH61nkequIWQ1GTuAG6XCZrKJ24t9J0iPx8yH7G5wA6pvWBId8zl
         3PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745781106; x=1746385906;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xq9WjFUkY/jJtaOUyR07QLAr3NdXDaHUkVXWwbHPAjg=;
        b=MbbOk1zVi79RppC313dbVjovmwAs8qlCYXEPJgu5X6HMNLzqQofAbpF35xGv2OdzUY
         cj8y0n8RaYWMUnKdR9i1k1COSmKjqISRs3sRc1Mq5fboLDebVMQogs7oCVkPvvCuP9mu
         2o2n/tTGjEPy36fAr8pBuqqcVOLBDrkmgqqflpKU7xy1Bhiz47bvWEyUATN1njl9VzkU
         JZZb7ITyYgF+mkD7MOmB6btgI+vMX2lfpxSj7cCCe++/aqMKmc7E+Iz/uzIZzBuvyxTR
         cOGtJ0GsPQfGnzzb1GyAR8yFJInZDLSefodWvZDNCrtEEjObW/sRw/QC70DsTftSi8A/
         Nc+g==
X-Forwarded-Encrypted: i=1; AJvYcCWIMuljywc4CX6ngtDshd4sJqlXno75pBZsPoE/YkZjeiXQTXFwf27AuEODwOlBsT9T56e2sEOOU2/FRiY=@vger.kernel.org, AJvYcCXIGOwRGdydxoXIbyvFltMollfdGXvWO5G38RMEvJFzqfXPzgdSK1UQa6HtT3s9QX4wtUFDQae0@vger.kernel.org, AJvYcCXThHd4rcb3r/yySlxqEUDaZ4c3YJWXyVbBSOnj/fFbWDirPvHpvXgmj9JK4uBLA+ZRyjm9+68q@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs2jXI8UWIUS/+uhhcNEzliNi9FNxFoW5JUp8G+gBiFRecHMAw
	wyzZ+udoAc7o5ZY0jkqJ+6BbDG42ptDpPuxPDPXampR2tMGP4NwB
X-Gm-Gg: ASbGncuo+VBQvc3FWLDcpPeRh3m/NPILbT5al+3VoVTVvjBcGGL5Wbr71dIl1DGJ396
	020UEemtAcRhQAIrxkdFAIOPJ8QnpBP38TqVK5AmDCAJBuEdXYYWyESfUbt0jOCwFv8FT+zGrqX
	ANJDZkEkPAWC3l/REJpRbK+45RCg9/XVa0YwZunf9ZEokIfSzcZ9cbY7BGQQYAdNWZd5IazC7Mp
	ehUTjwduTiqpfSpsA5j/4umO9Yqz8cMsrYKhc/gHmmYlKMXBILxARKCVEbe5aXBlRgWX8XWGCnT
	R5MPWb8eyTcZTDCPDUqihdiLA6M+OJf88TRMBKtSNIlde2Y=
X-Google-Smtp-Source: AGHT+IHWw4FLxxfNF5W3Sze3kOT43PHacUq2v0g0M9nT54cm3v8n2ibQ9X8LDKKBv52lTDeX2ALI4w==
X-Received: by 2002:a17:903:184:b0:223:3630:cd32 with SMTP id d9443c01a7336-22dbf73e790mr143727105ad.53.1745781106559;
        Sun, 27 Apr 2025 12:11:46 -0700 (PDT)
Received: from localhost ([2601:647:6881:9060:19f0:8ab0:4510:f0a3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76c96sm67142215ad.38.2025.04.27.12.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 12:11:46 -0700 (PDT)
Date: Sun, 27 Apr 2025 12:11:45 -0700
From: Cong Wang <xiyou.wangcong@gmail.com>
To: "Alan J. Wylie" <alan@wylie.me.uk>
Cc: Holger =?iso-8859-1?Q?Hoffst=E4tte?= <holger@applied-asynchrony.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>, regressions@lists.linux.dev,
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Octavian Purdila <tavip@google.com>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	stable@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [REGRESSION] 6.14.3 panic - kernel NULL pointer dereference in
 htb_dequeue
Message-ID: <aA6BcLENWhE4pQCa@pop-os.localdomain>
References: <89301960-1758-5b2e-6d91-81ef06843e14@applied-asynchrony.com>
 <20250421210927.50d6a355@frodo.int.wylie.me.uk>
 <20250422175145.1cb0bd98@frodo.int.wylie.me.uk>
 <4e2a6522-d455-f0ce-c77d-b430c3047d7c@applied-asynchrony.com>
 <aAf/K7F9TmCJIT+N@pop-os.localdomain>
 <20250422214716.5e181523@frodo.int.wylie.me.uk>
 <aAgO59L0ccXl6kUs@pop-os.localdomain>
 <20250423105131.7ab46a47@frodo.int.wylie.me.uk>
 <aAlAakEUu4XSEdXF@pop-os.localdomain>
 <20250424135331.02511131@frodo.int.wylie.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250424135331.02511131@frodo.int.wylie.me.uk>

Hi Alan,

On Thu, Apr 24, 2025 at 01:53:31PM +0100, Alan J. Wylie wrote:
> > On Tue, Apr 22, 2025 at 07:20:24PM +0200, Holger Hoffstätte wrote:
> 
> > Meanwhile, if you could provide a reliable (and ideally minimum)
> > reproducer, it would help me a lot to debug.
> 
> I've found a reproducer. Below is a stripped down version of the shell script
> that I posted in my initial report.
> 
> Running this in a 1 second loop is enough to cause the panic very quickly.
> 
> It seems a bit of network traffic is needed, too.
> 

I just tried your reproducer in my VM since I don't have pppoe setup,
after running ping flood (ping -f) bidirectionally for ~10 minutes, I
still didn't get any warning or crash.

I also tried to reduce the bandwidth limit you set in your script to get
traffic throttled, still no crash/warning.

Note, I just used the latest -net, without applying any extra patch.

Thanks!

