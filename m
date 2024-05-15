Return-Path: <stable+bounces-45188-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF798C6A70
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 18:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1521C2082B
	for <lists+stable@lfdr.de>; Wed, 15 May 2024 16:21:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5C8156674;
	Wed, 15 May 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JidyIdhd"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE4156255
	for <stable@vger.kernel.org>; Wed, 15 May 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715790072; cv=none; b=JYZtvNB6bmOcbxd3eOZ0rTwQRVJq5m3TmIduwhgP4pycCbx5Z1u/g884abGjGZBE21wcW7+YABKUskJ9mpYHJJmtozzjxFUmRMfwadmXCzCxXcY0DyF8X3ZsoaXwWDIGDGAXubBKfeLHPqpzLRALikP7ZPb4MuoPXXrZWyP+Cg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715790072; c=relaxed/simple;
	bh=VTAKupd41+vwdD2+AAdWUtgNtPv+N5S8/ZucUcvM7XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN6ZOL/iTm4f+vjZtwjL3HDQhS/FOuBiJhzBLzorHs3nVluj9YnN1nFQzHGVQMMQyd2hrMwH5Un00eHarKqKd39Hgpyv+yjGVm+bRbbw1d/jw13zohwXR2lAyIvolAt80oUXUxw1Bcl4pfC6f3FHrVypkZbnxnhrRwTFO0RvUeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JidyIdhd; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52388d9ca98so2496140e87.0
        for <stable@vger.kernel.org>; Wed, 15 May 2024 09:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1715790067; x=1716394867; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VZ4/RopXS5f2WiCBIMNF7eOCyIDKJ+KDv3FhPq2DLoA=;
        b=JidyIdhdEFP5K0YaHSuNKEATbC4BSETr3jqA8wg/DA4xqvfLY0Cem0mc6ljal9sWTX
         BU46JRAKWnTw6CsgKfTT8erG+/gBEn9yNECFpAVQRjS7XAum+qq6jkQyCjpGfJZcsXoo
         nRLQt3OTueR/f+rwBEyT1JNEtOeLzhGRhPm1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715790067; x=1716394867;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZ4/RopXS5f2WiCBIMNF7eOCyIDKJ+KDv3FhPq2DLoA=;
        b=wgt2vJALsp7U69y4t3uqQDH53XimbohvBzgDYi3J6crSVLnj2uxoV7btJQ62RmPiRC
         LlFjwkLYZKlsr59GZIbDiseLCj9gwShaalsYtxpQMyxCa8sBX7Tx8SIDpcI+PWLdjKdW
         UUtg5Iuume83xX/YGJaGNQulsqJ+NjapzDIrKcbzKH0IeF/IImZJ4WaVSPQbN02AuzD1
         +iCOOscQtfkADFEnnaTzFpq2w03r62vkqOP3X3Zba39ccl7xr62a7kqE1xKbA89E2Iqu
         HKTGrRLQMvXqWTE/aKpmWWEnsk2cn/3yCEfNA2Br7Pn53ebmMHFe3yIo1ncFHptN60eH
         U4bA==
X-Forwarded-Encrypted: i=1; AJvYcCWZqXZS8LKoNKBuNHoHTfSxHMYI/t1RPkY3ggUDJIeYLFR3QE7P+vX9Hdz4cwK44fxFLuZH0IFIlQpufo/rCzPxQYzS22M2
X-Gm-Message-State: AOJu0Yx2J9Eui9KicPcjc7fS8T7PeqAaYEmWd7PyRYeL17q423k1BlyO
	jopbanHPzvedkW1MgjFZaIJ+RsDFgqaPRtIlHXuuLAZPt7yuYRBvNowrkZKSkBeCc9INZj+o1WD
	3uMbx2g==
X-Google-Smtp-Source: AGHT+IFIeBtjM3c8pABwLyViOCNFgJk9kM84NmLPM586UYLmXkPtCclpRxIXqra56kafZblYgSEsjw==
X-Received: by 2002:ac2:4c85:0:b0:51f:5d1a:b320 with SMTP id 2adb3069b0e04-5221047585dmr12373542e87.68.1715790066995;
        Wed, 15 May 2024 09:21:06 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5239335e60bsm325665e87.84.2024.05.15.09.21.05
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 09:21:06 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-52388d9ca98so2496058e87.0
        for <stable@vger.kernel.org>; Wed, 15 May 2024 09:21:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5akbq4btUDae9Zv4V2nJUnVbJPNHbTX4kSvkfuDtrYZ7+ApIlFK5Nzd9jUJmY6e/BidJU8+klcGT+t/HXclDPtG3+0/wN
X-Received: by 2002:ac2:5f59:0:b0:521:92f6:3d34 with SMTP id
 2adb3069b0e04-5220fd7c838mr12720657e87.22.1715790065107; Wed, 15 May 2024
 09:21:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240515082456.986812732@linuxfoundation.org> <39483cfc-4345-4fbd-87c2-9d618c6fdbc6@sirena.org.uk>
In-Reply-To: <39483cfc-4345-4fbd-87c2-9d618c6fdbc6@sirena.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 15 May 2024 09:20:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
Message-ID: <CAHk-=wjntFiQ=mM-zDHTMnrqki3MN3+6aSXhjnJozBaKqLLUDQ@mail.gmail.com>
Subject: Re: [PATCH 6.1 000/243] 6.1.91-rc2 review
To: Mark Brown <broonie@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <opendmb@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 15 May 2024 at 09:17, Mark Brown <broonie@kernel.org> wrote:
>
>     A bisect claims that "net: bcmgenet:
> synchronize EXT_RGMII_OOB_CTRL access" is the first commit that breaks,
> I'm not seeing issues with other stables.

That's d85cf67a3396 ("net: bcmgenet: synchronize EXT_RGMII_OOB_CTRL
access") upstream. Is upstream ok?

                 Linus

