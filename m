Return-Path: <stable+bounces-94095-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CCA9D33F0
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 08:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB46282DE8
	for <lists+stable@lfdr.de>; Wed, 20 Nov 2024 07:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8328B18B46A;
	Wed, 20 Nov 2024 07:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ATb3DBs/"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298F181B8D
	for <stable@vger.kernel.org>; Wed, 20 Nov 2024 07:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732086089; cv=none; b=SIwusNxCun/8EQ7hvSH/w7ZSrv9INUt6dBKdnG+1Ly2X8TsMzQH0mGHErIg7wNYhE/JdaXz+YYclTiJIjcc+gWsoP2R1iuca4Jup7AJf/jWu3E7ZIemECG3c7tvAglvuG8C5ik7qlKUIsgwiaolQiYWtbaRXueO4zvvSIZei0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732086089; c=relaxed/simple;
	bh=YfY9O7wSH3eO92M+fpGPgneosedEVw+4tWw9KEXSXxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ5Kw75414vUI5H2X7ly4SS2FtcAPpjJmsEdX65XM6Fc1yaIjX0ZMcH/iCVCkntC8tOpJYWfNQbtlzR0pS4FZQx+XJvTMWo+AaX8KhgoI0XTZpd/ryNwCXp65FWoARwn9xC/hg7TUsVgt9yeAe3zmmgrf29qi5cQZUFJsVS51O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ATb3DBs/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6b4ca29bso761739866b.3
        for <stable@vger.kernel.org>; Tue, 19 Nov 2024 23:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732086086; x=1732690886; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuhGZa1wphlMJu5BT/9fX23QNVaQXhewHRgLxFfqZUY=;
        b=ATb3DBs/Hu8GkvOO22S2bOSvc6wiG62VSZwZorKsazgBvfp5jhdajM4eMcTEkVEMKY
         9avSU1zXJDvl7vVPEF8xoMasxf7EH6RIauLbmL4SmTy7oh5POkNKC2uN162gtZByzrUd
         0oodT5TUPjIUz9MPvelqtlDyK6kbFXdaQqpgf4MhPkuyp72xejPXe63UEBxBYZBfCgUP
         2rnwnyXosQZKTJ9vCZ/zg1DmIlCbsIw9dAcZbaAN8wC8FJ57+reE/VP6k0TwBLmoxA3h
         XahDRzad5zylP/9bZ7GRZJUFt9Qvpt9+6ihmSV8N9VjkSM/a+wkMRFsAHixPFbPXuDrW
         yf8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732086086; x=1732690886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuhGZa1wphlMJu5BT/9fX23QNVaQXhewHRgLxFfqZUY=;
        b=EXkkcc7cARdeYtlbx7+ta4PYTaDzaMhXBl4Eu/TrCPr5/TIaAiqZujRMJtUJoJqtm7
         mMUGy3y1RLfi37zQfftRQkODychcc+SdNfkCuZboJffblFXwuCkOGbYvqchDrvl5ZMqH
         QCMvXGFa/jGUWl+0os3b8GtPSSmpXqxsB4+yZAqdM7BXJ7HNBXC5Ol7Y1k76C2yfXZfv
         SCPM2VRucz9xC8SEzEpRuJToSWO3mIkRhvRs6mZVkZU6M9v04z4IBji/w2xsHMUFE3NW
         QRJkwO5Di/PVcd1OQFDNYXBby4I3MV7TIZMAmK++wLvo8TQf6ts8ibZxzTGUWgVhWDXT
         fiGA==
X-Forwarded-Encrypted: i=1; AJvYcCXcHBM/i4yuUwT+zNxUzf2wnHGfXH/RTFeZLTHiysOnUz/F8oxKYGCXg6lxTMeRSSYDoOmNifQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztlXm0mdXMyZfY0aRqt1SqI1nNTi9S1yAJKMTHpeXHIQQBybpA
	PO7TP9MpPaSPz+EAr22xMuRlf7KDR5s66RU6/T3gr4NMNPP3NvP8uU4d+BWC
X-Google-Smtp-Source: AGHT+IGQ/p9RGsj/UtKWUzs6dPt72UBwcdLUCoTcS5a12Ok5zybtRplyc9AOLKJDgxlyx+B/wkPMzA==
X-Received: by 2002:a17:907:84c:b0:aa4:9b6a:bd77 with SMTP id a640c23a62f3a-aa4dd551bbcmr156944366b.17.1732086085636;
        Tue, 19 Nov 2024 23:01:25 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20e044b59sm726873866b.143.2024.11.19.23.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 23:01:24 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 007E4BE2EE7; Wed, 20 Nov 2024 08:01:23 +0100 (CET)
Date: Wed, 20 Nov 2024 08:01:23 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Dominique Martinet <asmadeus@codewreck.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, y0un9n132@gmail.com,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiri Kosina <jkosina@suse.com>, Sasha Levin <sashal@kernel.org>,
	regressions@lists.linux.dev
Subject: Re: [PATCH 6.1 175/321] x86: Increase brk randomness entropy for
 64-bit systems
Message-ID: <Zz2JQzi-5pTP_WPx@eldamar.lan>
References: <20240827143838.192435816@linuxfoundation.org>
 <20240827143844.891898677@linuxfoundation.org>
 <Zz0_-iJH1WaR3BUZ@codewreck.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zz0_-iJH1WaR3BUZ@codewreck.org>

Hi,

On Wed, Nov 20, 2024 at 10:48:42AM +0900, Dominique Martinet wrote:
> Hi all,
> 
> this patch introduces a regression in some versions of qemu-aarch64 (at
> least as built by debian):
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1087822
> 
> It doesn't look like it still is a problem with newer versions of qemu
> so I'm not sure if this should be reverted on master, but it took me a bit
> of time to track this down to this commit as my reproducer isn't great,
> so it might make sense to revert this commit on stable branches?
> 
> (I don't remember the policies on "don't break userspace", but qemu-user
> is a bit of a special case here so I'll leave that up to Greg)
> 
> 
> I've confirmed that this bug occurs on top of the latest v6.1.118 and
> goes away reverting this.
> (I've also checked the problem also occurs on master and reverting the
> patch also works around the issue there at this point)

Interestigly there is another report in Debian which identifies the
backport of upstream commit 44c76825d6eefee9eb7ce06c38e1a6632ac7eb7d
to cause issues in the 6.1.y series:

https://bugs.debian.org/1085762
https://lore.kernel.org/regressions/18f34d636390454180240e6a61af9217@kumkeo.de/T/#u

Regards,
Salvatore

