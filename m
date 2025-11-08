Return-Path: <stable+bounces-192789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD78C4345F
	for <lists+stable@lfdr.de>; Sat, 08 Nov 2025 21:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1697F1889E2B
	for <lists+stable@lfdr.de>; Sat,  8 Nov 2025 20:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0579325DB1C;
	Sat,  8 Nov 2025 20:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="uXCbx/Ve"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216A0244660
	for <stable@vger.kernel.org>; Sat,  8 Nov 2025 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762632142; cv=none; b=UdEeltGOM/taqQNZZbhssAi0g+PD61gIm9CWBtsz91h0x4zSoSBJcwdEBn2IX/UAd8kNwtZRtN9P7uVjWyrGcoq2q9d+jxMp8TLnAxLzi40uQMj6fYU1Vah+OE7FeNTbUs2VFayawB6PiTBqE8yvLjNLjO4LQkzB/acvNtFlYhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762632142; c=relaxed/simple;
	bh=vEZrLeBeJ7h1ipH89PqPi/zSNBxuNbQgKGCtCvuVOvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWjwKYnM+7IqPizLZHzLvUrHBSj7u8Ba+mrCoXbom2mJyeZZD2L5MNmmgu72wQHhwMpJ1YoQpl7vqaQdQBcOX7d91qrf+2dXo7x8vtzcvV0R13LRAj11VdWdcybVn6Lt9xARJUpaygwZ2i5OOOZ5F22BUYpEbAOClYraXuGLSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=uXCbx/Ve; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-8b22624bcdaso248920385a.3
        for <stable@vger.kernel.org>; Sat, 08 Nov 2025 12:02:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1762632140; x=1763236940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=afLIDtjU2jTYgwYOZlnNOt8tUMpTLcQFNlRa10jsVq4=;
        b=uXCbx/Ve2EP0neuZFLhGWMy7dXysEzjXrFPt9Cfj2/6+/JfLqnyirWi5b5PuhpFSP8
         txe5vj8WXnF4+p8ytuMPVWFJ4EPZiVxjNZoW7FKnA7rs3L5fntgkK/JBAK+s9TMGREes
         zsmyoT+OJC99bEsm8ArDdqfWNOb8ZsDqphUMDJsSc/27OTJRmXAzKUuaIaR6LCg0hPpa
         ECFUwdASC9W9yFA1Q8bqaAv1KJMHSus6yMUC9axWzxNBcTJ0OukccjH+elO7M0I05Fh7
         GRUqJkwfl2a/xfbD6Bpbu9R5wOh27yVuxG25Eypz809YlhWNLCLX1by7+KLTS9XoiPSp
         b+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762632140; x=1763236940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=afLIDtjU2jTYgwYOZlnNOt8tUMpTLcQFNlRa10jsVq4=;
        b=rNiacH6j81SqHgnWLIHp5jA7XfsXoYUssCGL2NhxpI8n7BmkNEsnZlpnGPPWVtZoxw
         XH2GC++fIKeL8jjTSPq6xyk10CQ9UfGN0nyGtndVInqiVS4jeU7UiEBPty3F8nfuLbYE
         t7czN64LR1NXFs6JW8Yuo8Rrwrt53JqmZ9wPp1uOZo/lnTFdc0C8POXCL0Jc+R5UhW0A
         ZOhC3jp6xN8AxyJpwUsppcBLX5RlXQi4ut+1JjLNaabGSGoEodFVH6lR7bmCOgabT/tb
         tk74Tx6tJTAFB/sZCUAUq+mmNitAMByZ0v3VvoPbJv+OgUcFBx9Tmub/YsVWQmNSC0NB
         l7+g==
X-Forwarded-Encrypted: i=1; AJvYcCXaaC2XOiB8PhtMTanT9DfeCEsTb9b52cHiJuSgbdmKevVL2yjP5vjAZ8Z9iW9MFzLKzULg5iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp1XgYt9rFbjSd99QhrN8eFsvTuHeedy7nr6iTgCKKf5m3LInm
	5MoSkgEYZC0aIeZuRG8gRSToqZGupCDmQ7/gPmsPzit1IG2L2ojh+qyBlAuettSTl30=
X-Gm-Gg: ASbGncs6uc6pIEYVdMHRHOjOyxF5nAfmL1pJGjMaK+7kfGCNDlLxTsroQ0OdZrzUBfP
	d+FGbnNPqfllgA4gHFPmPUrFC16nDQ1RU7j/GWu5V2FLgYO9utCiCbhHHSHNOGWTB+s5u2F1Lht
	RQKMbCD7kPrRWAt9WbDG9ivKbGgH//P1n7PDBPWwSJ6Q57cNv+BVnvpiNVHQXtRkYrtU1ps3oGd
	uuFT+ojOhfbxxEwwcU0IvhA+vRgh6CGMotEJHlFIthXxCX7uGIJ2Nq7asECtu63nX3itPdTt0vA
	yMby6Wy9rmrOPMOfbGn8XCQANU0XLx4uzN0vIHQq5t3KQIHjwtkOb6upmCSXLZkCEOZkpDcKbQg
	AOa37+zQPynPWIU38t/KMHCLXIBRGn3qj74KQMbt0Wk0rtdTBHy7CW8d9Rk7H/xXUyMpaBtRgpV
	0/XMWikLc+EEw0zAr9DgjdGQitb3ro/w==
X-Google-Smtp-Source: AGHT+IEP6njqvP7OJ8++MLrTcCjSZ1Kt6Z5ev6k1eTY7/VIni/FZ+4NbLV9Nf5JbGDhmp9iwi4d50A==
X-Received: by 2002:a05:620a:701b:b0:8a2:319d:27c3 with SMTP id af79cd13be357-8b257f683a0mr386978485a.73.1762632140037;
        Sat, 08 Nov 2025 12:02:20 -0800 (PST)
Received: from localhost (ip-24-156-181-135.user.start.ca. [24.156.181.135])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-8b2355e9a35sm659818685a.20.2025.11.08.12.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 12:02:18 -0800 (PST)
Date: Sat, 8 Nov 2025 15:02:17 -0500
From: Nick Bowler <nbowler@draconx.ca>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: linux-kernel@vger.kernel.org, regressions@lists.linux.dev, 
	"linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: PROBLEM: boot hang on Indy R4400SC (regression)
Message-ID: <j5uutbx2oi2ccudo54o4hgxfmwfchwmd2ktig6xjgkqa7ho2pj@xb4luighppnc>
References: <g3scb7mfjbsohdszieqkappslj6m7qu3ou766nckt2remg3ide@izgvehzcdbsu>
 <e4ed75c7-b108-437f-b44b-69a9b340c085@app.fastmail.com>
 <ea6p4efuwbrlqjiwkgjcd7ofj7aahfnnvnkooo2il36ggzrlcj@n6mcofpb2jep>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea6p4efuwbrlqjiwkgjcd7ofj7aahfnnvnkooo2il36ggzrlcj@n6mcofpb2jep>

On Fri, Nov 07, 2025 at 03:12:31PM -0500, Nick Bowler wrote:
> On Fri, Nov 07, 2025 at 07:29:25PM +0000, Jiaxun Yang wrote:
> > Unfortunately my Indy won't go over ARCS prom so I'm not in a position
> > to debug this on my side. I have inspected the code again and I can't
> > see anything preventing it to work on R4000 family.
> 
> I'll try adding some extra prints to at least figure out where it is
> actually hanging.

I did not have much success with adding prints, but looking more closely
at the console output it seems that what is ultimately failing is the
SCSI bus enumeration which does not complete unless I revert commit
35ad7e181541.

So I presume that is why I also don't see the messages about mounting
the root filesystem (I suppose it is just waiting for a disk).

I see the drivers printing the usual info about each device, but not
everything.  Specifically, the lines that are missing are all of these
ones that would normally be printed:

    sda: sda1 sda2 sda9 sda11
   sd 0:0:1:0: [sda] Attached SCSI disk

    sdb: sdb1 sdb9 sdb11
   sd 0:0:2:0: [sdb] Attached SCSI disk

   sr 0:0:5:0: Attached scsi CD-ROM sr0

Other than that everything else seems alive.  Several other drivers
go through their initialization during the time the SCSI stuff is not
completing.  The 'random: crng init done' message is printed after a
while too.

I tried enabling CONFIG_SOFTLOCKUP_DETECTOR and CONFIG_WQ_WATCHDOG to
get some more information out but these options do not seem to do
anything in this scenario, nothing is printed even after ~10 minutes.

Thanks,
  Nick

