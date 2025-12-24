Return-Path: <stable+bounces-203388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B01CDD192
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 22:56:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E891302EA37
	for <lists+stable@lfdr.de>; Wed, 24 Dec 2025 21:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D6592DAFC2;
	Wed, 24 Dec 2025 21:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0um9IRZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19B72FF16C
	for <stable@vger.kernel.org>; Wed, 24 Dec 2025 21:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766613344; cv=none; b=rNP6fafSvtIC09IwJLo6HuRD1MABomYzc0RcXKu6ls7l+xETJnaX9PbxF2kAW4tz2jUaTWjqSy0mbnz7nmy3yyP9y7I5GZXRZUF/kgSbunDl+F8oy8xVc/i/dUMgiqHTXQZ2gWQSQ9NpFKSsID9Bdy9r6mCyHCRco2yd8mazvak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766613344; c=relaxed/simple;
	bh=gcrpt2TLWQnMLjJ+UBFP6GF2RAVhjuIhN9D62wOQtHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oIppQ0BLvsE71qxEeIelbSzOOXFwR9odAOCm/4R2T+Qg7oQfHy0KEZ9Fpc9yHk2trCIuIrSQPTbXUXlyqmrgkjOJLVKI3GbPSqnP+tetvv+e/YI+S3Lajo+qtQGao2uXhOftJCxPDNxtDku1fLqIm7plbqLz27qBoRwgQ7vQbQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0um9IRZ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-78fb9a67b06so46572977b3.1
        for <stable@vger.kernel.org>; Wed, 24 Dec 2025 13:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766613342; x=1767218142; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcrpt2TLWQnMLjJ+UBFP6GF2RAVhjuIhN9D62wOQtHI=;
        b=K0um9IRZ7g9CB7AyzJG/Tr8qh+qy0kYbU6jQx7OGEIsM68mcb9VEZJqKwJbeAQzM1B
         Cg7zfUG0u6uGQumroWaRRTMOJUrXm85rc5nfE+cArIcGnEdNJe3rktM+aMfMMYCPjGuQ
         Hysaz+094K3SWSDSNj5UggRtg6zYzX03v+86RHTo0XAe/EHDZ364IAOoGJx1TjtQnIwc
         /UORfRC9ILBcNmQytILFFFPGoqNQi2HIK64Ezt3i/hBdUS2M8My8ixrl0ONhPY5aJqRW
         CT97kIBIRYLhJQq4aHs2yAUFrvR2xxgXaKU0oxaVCpTFr8W3rg8BaBi9PyRLmsEtFY5C
         CODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766613342; x=1767218142;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gcrpt2TLWQnMLjJ+UBFP6GF2RAVhjuIhN9D62wOQtHI=;
        b=wOUXZa4BqHdqwixwrfus2h9CooyI4YlDprTbp/l1gHWHB7eF9vWISywuBylDoS5A7J
         uXj1RO+ccKxeqzqDoluDhgNUYwB+Bdj2ShcEWvxaj6mCNHz4NaYU4cWzWhsbuq3PKdGJ
         uc2jKKvLzpFHlaRE1thqQPJLLRSjiV/3XC+RMSixUY/8mz1ll57QDIUqvyh5BNo/0DsU
         KGfvR99g8VQnQJH3vkbieLuzzlZ75XvXl/rvYEXG25Z/XdB9Ke6bGa00yRtHfBNK3suB
         RJt6mDrCVCEzSohmE8O538Ij8PID2nzSfnMltnHW9vdz8drvTfH/3gcxhQwM7lH8VTpn
         oGVA==
X-Gm-Message-State: AOJu0Yzfq4TvjET18JNvFcmjDo7lZDZOwWclIFbkNoiffiZdy4vWYx3u
	pCAdwUDoUFh+NtD4bE/KenvyrymlhYVKGTBdAOvPD2dND/GfCncs9tHa1kSnl8dW2gJMaSCakaw
	5GmfpjYad2C1v6KCn2WxmAApixpeeuoNHeqY=
X-Gm-Gg: AY/fxX6cB2HrA2O0c+h50kZWyqB6egsApcBVAqp2J4j7IXmX2fzUYa1y4yg433AsSem
	oRmXoDP+O8L2m2IbLfl/9nEVWA6sx91tAt6V1bDUv7eDyhIGoxLi9K11K09Jw8HAcdxPIOIzuFq
	gcbIqPaHVaYe1ycxFq08dfiszfeWdJ3lTOCB0nf5bt4B3EcZ3ye3viUOq/1hfkE4lUjENXHszLv
	g3zj4LTLlbbmMkoU3DQrdeX5UuCxr/1/blpEoUt9M42OJ5zXOurHRY0L548PmpB6uxucxk=
X-Google-Smtp-Source: AGHT+IEpWUFhJTbJvbRiEFFQSl1w/rtpjdLBKcR+9LgVGr5bKBdM0vW5xNZMJqvwzUD4Wo/ND39HRrcaoFSW60rKAys=
X-Received: by 2002:a05:690c:6187:b0:788:19b3:3fcb with SMTP id
 00721157ae682-78fb3f251cemr173706687b3.25.1766613341690; Wed, 24 Dec 2025
 13:55:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH1aAjJkf0iDxNPwPqXBUN2Bj7+KaRXCFxUOYx9yrrt2DCeE_g@mail.gmail.com>
 <2025122303-widget-treachery-89d6@gregkh> <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
In-Reply-To: <ME6PR01MB1055749AAAC6F2982C0718687AAB5A@ME6PR01MB10557.ausprd01.prod.outlook.com>
From: JP Dehollain <jpdehollain@gmail.com>
Date: Thu, 25 Dec 2025 08:55:30 +1100
X-Gm-Features: AQt7F2qqiR2-Fij-2-72-5E_Ew2qlokVeK6smQ8pAbRpQN9Pjxp6ccDoSnpcn2o
Message-ID: <CAH1aAjJjxq-A2Oc_-7sQm6MzUDmBPcw5yycD1=8ey1gEr7YaxQ@mail.gmail.com>
Subject: Fwd: Request to add mainline merged patch to stable kernels
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg, thanks for looking into this..
The full commit hash is 807221d3c5ff6e3c91ff57bc82a0b7a541462e20

Note: apologies if you received this multiple times, the previous one
got bounced due to html

Cheers,
JP
________________________________
From: Greg KH <gregkh@linuxfoundation.org>
Sent: Tuesday, December 23, 2025 6:39:22 PM
To: JP Dehollain <jpdehollain@gmail.com>
Cc: stable@vger.kernel.org <stable@vger.kernel.org>
Subject: Re: Request to add mainline merged patch to stable kernels

On Tue, Dec 23, 2025 at 04:05:24PM +1100, JP Dehollain wrote:
> Hello,
> I recently used the patch misc: rtsx_pci: Add separate CD/WP pin
> polarity reversal support with commit ID 807221d, to fix a bug causing
> the cardreader driver to always load sd cards in read-only mode.
> On the suggestion of the driver maintainer, I am requesting that this
> patch be applied to all stable kernel versions, as it is currently
> only applied to >=6.18.
> Thanks,
> JP
>

What is the git id of the commit you are looking to have backported?

thanks,

greg k-h

