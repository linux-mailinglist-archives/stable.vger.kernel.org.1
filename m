Return-Path: <stable+bounces-28719-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4227887F24
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 22:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63BB11C210D0
	for <lists+stable@lfdr.de>; Sun, 24 Mar 2024 21:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F70F19BA2;
	Sun, 24 Mar 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dVR409k0"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAA81C692
	for <stable@vger.kernel.org>; Sun, 24 Mar 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711315409; cv=none; b=dtVCpJ7D+qZDShyh5nyOGM5kA+Y8F4OjRfmZnEB0ce6k5WpXL+aCbnqudM7Ru75lYuvYTwvJYfgMeFI4/yZ9WHNkAVhN7ajcyaqjyumEndb7Va4Wdz6aPHD6YS9t1Nlc1wS9kFwRq7Q3Sm/Mz8YhnJmVALHaocsubbrH8tHRRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711315409; c=relaxed/simple;
	bh=eaL2HV0nr3pKOpuc80VoTpEGfmXNl75QksyHppznkO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Esn0q2mIWlzsy83Ai+DQ5DhfsYbR3Pox04p5WWXxXSFSzQ4GmOIzcLzZvixtqAyKbSoFfcjKouSKRHjNVZV7hBrUynsKbnXZ+cwRl+o57KBk6jB7vC0QJZ6T4yXKvFHRGOpbdfAqpZ9b5CApgR7Zb9YmpuWSHbAWNd8uLyWB23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dVR409k0; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78a13117a3dso336722385a.1
        for <stable@vger.kernel.org>; Sun, 24 Mar 2024 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711315406; x=1711920206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dQrY/qKbnJvySLkmsmeaAAsV45kQ02rxRFBiSeGoCJk=;
        b=dVR409k0IB8Eh2aAJiIvrL2oZ5U4fB1ug0yfHiRgSBwUsHFXqubJxVr5DfSkA+Fxqi
         bib93t8qBAHyOUVlEcZDoPIUpkzraSFMhRA68vR97Dl0GzKzkyBrhBUBVQkTD/FKXD+H
         0PTCyOpiMPFSQUkMAIJLnKSCX4rG8alj4wdFWxCdA3pSEamD4vjOF7fF92dac6alJ7qR
         S1PRorWINeLv9xURmIYs/qZyRCORn4mM3Wa0Bbf8ITbfaiFKYZ1JxU16WFetz8N7OQfk
         yl1/Y7jiCvSx22hGmrKiz/tJA2lxjaBgATvgQqy50nr5bJS6nMzvEpHDpCnEpcWt57li
         9//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711315406; x=1711920206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dQrY/qKbnJvySLkmsmeaAAsV45kQ02rxRFBiSeGoCJk=;
        b=QUHW9edYOUhmw31sFPM+K0DnbHYlI1qcbwFxxfMCIsardt0q6epBmM/AL8ya+CdUKU
         cFI8uuOAWR0Ml3yAf1LMgC8cSsQc8JTO+9ZN7k6UU0Ewv81z9IACoQSo/Bc5UbZdyVGH
         gKeyRh0fRdCSqLOQLT8amaajyPRo3KFkuUea7bQFU6yU4XvdGDIo8jUXjm2P28FB0QmE
         AXGhEN4COHR3+OwzcQwqaeHaYtww0yNZmynQMpdTNn3ErWxmtIheKI/pwWMmin35fkSp
         oMo2f806PLkYtaa8EV9VOyS6By+VC5PqiuQrwv/4uWI1KSIKOn2N41FxZuKYnTLJQYDW
         pLEw==
X-Gm-Message-State: AOJu0YxVwY6NFu2/cVc5/BwfLvigvNIMCMGN8J6CDd4+M3C/F0XHj+1/
	V8oJvPz73LUEDe98lBgpwPEgxw3gy1CJDvhJJeK78VHJ34RT9vpa
X-Google-Smtp-Source: AGHT+IEc10TOvq9RO7i3JeXuKpfhu+/asb72LZr+SvnMR7gsW2pXZNpPbNizJ9Ny6wM5ip/jy7sLLw==
X-Received: by 2002:a05:620a:22ad:b0:789:faed:fcb4 with SMTP id p13-20020a05620a22ad00b00789faedfcb4mr7882999qkh.21.1711315406331;
        Sun, 24 Mar 2024 14:23:26 -0700 (PDT)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id ay11-20020a05620a178b00b00789f7ba3745sm1613499qkb.25.2024.03.24.14.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 14:23:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 97158BE2EE8; Sun, 24 Mar 2024 22:23:23 +0100 (CET)
Date: Sun, 24 Mar 2024 22:23:23 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: "# 3.4.x" <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: stable backport request
Message-ID: <ZgCZy2WPbbteAbLc@eldamar.lan>
References: <CAMj1kXGE5OuqY8=F+_YV0p0mY2wjkdkh3L9-i-3z6tfZdmYMaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGE5OuqY8=F+_YV0p0mY2wjkdkh3L9-i-3z6tfZdmYMaw@mail.gmail.com>

Hi,

On Tue, Mar 19, 2024 at 08:21:49AM +0100, Ard Biesheuvel wrote:
> Please backport
> 
> b3810c5a2cc4a6665f7a65bed5393c75ce3f3aa2
> x86/efistub: Clear decompressor BSS in native EFI entrypoint
> 
> to stable kernels v6.1 and newer.

So on top of that as well df7ecce842b846a04d087ba85fdb79a90e26a1b0
which fixes the above commit.

Regards,
Salvatore

