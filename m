Return-Path: <stable+bounces-156156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 209D0AE4D43
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A30AE17CBC6
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B14E25F785;
	Mon, 23 Jun 2025 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X15DLdHq"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162921DDA31;
	Mon, 23 Jun 2025 19:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750705668; cv=none; b=O/dW3jaCOquGSfp/QaWwYSjOcB2OBxGnbQj0bo172dYe13gkdydD5dSJ7/xrsGe/A7C5VvbxTdaWSP2g3kOH6dD6b7OS0dgb0jBL7icaCeUsA4AgiDDA/fJJundcHAWXXI0s9ahd8RW7a4XIb7QcwOmbv5Cqe6bGK3y7bs0NCRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750705668; c=relaxed/simple;
	bh=Cqplu8f4hWitp/dfm+57z4bYpEzAG44i8JZxloWIXxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fG+zUiBkvhmSgF3iLS3W1Bv4AcvGLit2I8KGH4in1Z0PKAEmOcbhQmzIVDXIkvpJzszX1A6rshsAzkDaxRj6s5Wt3ARKERFaXEcYVP8AcOd1emO942RYtsnjkrxFeFdEDzX0zSBDkWQhXTGxP8aDCer6WTEi4s0i0KQrS4hu++o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X15DLdHq; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-453643020bdso27937915e9.1;
        Mon, 23 Jun 2025 12:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750705661; x=1751310461; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uC7LQWCoV/JaAVtmtniWmiLNc6kWkM08c4IXcOjZlWs=;
        b=X15DLdHq6k6+NJUfL6OeS7N3lDSfLQxx3V7dfO2UQ9xOSEPSI7RsxloT7hsKzz+ds4
         yGnNOXTI7Z50XZIrFA/ZPPAwrWn3iqklmEfGgEwPZi8481kJSpzK15wvPYdgKDxqXYIN
         epOHiFoA0/fkyAIXJk0CiPfFIJWlbzkzCMdgAS/lfHW80rG1LJH56D+MIzJ7UhP0J1nO
         ebuIp2D0KjZSmmVV9ye5fD3eZEzf1AdhFgperU72qUYOmMsbDQlcbFjJFpNS4AQ/BOIK
         sqAOrqRnuGJNi2YBkQ6ep3YgRjTMoAZ7LTyxuBBHXhKufv9h/2D1m5TLj70Lx7iq1sXW
         ieHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750705661; x=1751310461;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uC7LQWCoV/JaAVtmtniWmiLNc6kWkM08c4IXcOjZlWs=;
        b=m0GVRNcasz5IIoW6xuLNFGhvS/KRENRz0ibX81sEETTZ7Mvd80Vp7sPURgroA301qO
         5tWowhV2XC30FMLd+GLxUUMqMuE2EYyhY/+6Z+gIi0kevSsThI5xHR9/yqKE+G0S43jn
         3IJc4mI11uwW+QQvwC+cqK6TkP/dLmNfPISKUsvK9GyawmuydGJ9LrW28k0n2LD3nuIU
         cOKnUiaS8VfDM1AlGSoYukeSgmzV/PiTAvAY9X83adYGIl4DL7OMvOgjlg7OfRNo7VYM
         gEw12j1RJsJiapnr2LfOPkwSrmBsOp9KXABcEfetbE41+cilUsuQVORJsgc5Ig1vXRWH
         yjEw==
X-Forwarded-Encrypted: i=1; AJvYcCVfM9nR/bvlwJBOJ8LHE8D2t1fkKXvcYaZ8J1Y7BL3pwDtIZQ72JHkL0v+I1UuJLNXRK4GPZsovWxc=@vger.kernel.org, AJvYcCWow1hwg6mJMPjoyz4TPn990Dxi/uPgwNdG87ho6T1E2RxF2iZTgqPdaCEbMyNwiewduFa2IZb5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7hFjwq1BkM1R/SLUjEfp+FRXq2Ps/JnpYIZrT5GYtyjhus1r1
	WK+K8UWFTkeBmVsBhpoG3VVflEKpxzIUt6V83wyxgS0MZ4YugzimCsEo
X-Gm-Gg: ASbGncvSD00a3E26a0QNGa7QUavp7Jz1mmwS27dw/0waakr15qps9XWe0E2vtylnbCD
	ntw/5Ut4C9t6N89InhScI1/66Ypkqh6dFcpO/rZcMuurtd5HvXVqCl0u3r4/ExyzNOJoco3Yz+Y
	s2Ab2HLtBnsbuLXGFVkAd+OCerxoqFqmNIzjSgtYTdOGkyR/9SYeKcJO3ZKtEErVbUC0aipWlyX
	Y2oHDcHEuuVN40wWM8crxAaMxrfdpOyjY8HKrOWxMqG4EsxBmj1nQdsnvEwuRQusrNblErGbO4E
	lDSzYo6h9f0VWIBOWfxFfARjjsFdVJz3SWOJZ+ribkhkdOMamiAFr3TTqS5nUIJPgLoVNwqqF0r
	QE/j2uc+qSSckTd2/QuY=
X-Google-Smtp-Source: AGHT+IEVP5pvd/JbZjc3OIC2JD+r0G6o4NVC/z4QSgpCi5ldtfxVwt9glkS/VN4gp3sE+qwLzZ8ctQ==
X-Received: by 2002:a05:600c:358f:b0:442:d9f2:ded8 with SMTP id 5b1f17b1804b1-453659caba2mr138642735e9.15.1750705660967;
        Mon, 23 Jun 2025 12:07:40 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8e0asm152224315e9.23.2025.06.23.12.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:07:40 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 71C2FBE2DE0; Mon, 23 Jun 2025 21:07:39 +0200 (CEST)
Date: Mon, 23 Jun 2025 21:07:39 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Jeremy Lincicome <w0jrl1@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, regressions@lists.linux.dev,
	Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
	1108065@bugs.debian.org, stable@vger.kernel.org, net147@gmail.com
Subject: Re: [regression v6.12.30..v6.12.32] mmc1: mmc_select_hs400 failed,
 error -110 / boot regression on Lenovo IdeaPad 1 15ADA7
Message-ID: <aFml-1X0-vItR2Au@eldamar.lan>
References: <aFW0ia8Jj4PQtFkS@eldamar.lan>
 <aFXCv50hth-mafOR@eldamar.lan>
 <004c6e95-7c1b-4a7f-ab68-1774ce5a51d7@rock-chips.com>
 <aFmPQL3mzTag5OxY@eldamar.lan>
 <35be0df5-b769-43ce-a9c4-7df4d4683dab@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35be0df5-b769-43ce-a9c4-7df4d4683dab@gmail.com>

Hi,

On Mon, Jun 23, 2025 at 12:58:43PM -0600, Jeremy Lincicome wrote:
> On 6/23/25 11:30, Salvatore Bonaccorso wrote:
> > On Mon, Jun 23, 2025 at 05:13:38PM +0800, Shawn Lin wrote:
> > > + Jonathan Liu
> > > 
> > > 在 2025/06/21 星期六 4:21, Salvatore Bonaccorso 写道:
> > > > On Fri, Jun 20, 2025 at 09:20:41PM +0200, Salvatore Bonaccorso wrote:
> > > > > Hi
> > > > > 
> > > > > In Debian we got a regression report booting on a Lenovo IdeaPad 1
> > > > > 15ADA7 dropping finally into the initramfs shell after updating from
> > > > > 6.12.30 to 6.12.32 with messages before dropping into the intiramfs
> > > > > shell:
> > > > > 
> > > > > mmc1: mmc_select_hs400 failed, error -110
> > > > > mmc1: error -110 whilst initialising MMC card
> > > > > 
> > > > > The original report is at https://bugs.debian.org/1107979 and the
> > > > > reporter tested as well kernel up to 6.15.3 which still fails to boot.
> > > > > 
> > > > > Another similar report landed with after the same version update as
> > > > > https://bugs.debian.org/1107979 .
> > > > > 
> > > > > I only see three commits touching drivers/mmc between
> > > > > 6.12.30..6.12.32:
> > > > > 
> > > > > 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing parameters")
> > > > > 38828e0dc771 ("mmc: dw_mmc: add exynos7870 DW MMC support")
> > > > > 67bb2175095e ("mmc: host: Wait for Vdd to settle on card power off")
> > > > > 
> > > > > I have found a potential similar issue reported in ArchLinux at
> > > > > https://bbs.archlinux.org/viewtopic.php?id=306024
> > > > > 
> > > > > I have asked if we can get more information out of the boot, but maybe
> > > > > this regression report already rings  bell for you?
> > > Jonathan reported a similar failure regarding to hs400 on RK3399
> > > platform.
> > > https://lkml.org/lkml/2025/6/19/145
> > > 
> > > Maybe you could try to revert :
> > > 28306c58daf8 ("mmc: sdhci: Disable SD card clock before changing
> > > parameters")
> > Thanks.
> > 
> > Jeremy, could you test the (unofficial!) packages at
> > https://people.debian.org/~carnil/tmp/linux/1108065/ which consist of
> > 6.12.33-1 with the revert patch applied on top?
> > 
> > I have put a sha256sum file and signed it with my key in the Debian
> > keyring for verification.
> 
> Do I need all those packages?

Just the linux-image-6.12+unreleased-amd64-unsigned package to test
the patched kernel image and modules.

Regards,
Salvatore

