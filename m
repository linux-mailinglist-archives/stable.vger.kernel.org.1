Return-Path: <stable+bounces-118484-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FBBA3E16B
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 17:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F383B19C3CD0
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 16:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B0A211A04;
	Thu, 20 Feb 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="H/Y5QNnQ";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="UOOWd59+"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7174120F062
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.154.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070093; cv=none; b=CFCK+IYebheIUTHVU34fJi+ulm3gD0+LqU04eOYB1/XbqY4qvJXRJqbE2anpo9l1wrHBWJ/NjngxKi3yCaeZJdpcwjgq9jvJzb9Ki9oEWA5OXd8NJtoM/gWpypDs/jy2UhpMUZTj9GMUmnBEPCuk+rKjjMl/e4wmnVWnSvFlIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070093; c=relaxed/simple;
	bh=pbdR7nxvueo2TLaKE5sF10t2b+oN0pSH5FKcIBPg2yE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c8ago8pRuWnPu2QfKG/RJbEUEEDZqBxZOTU44+2X4vfNOOPet4r4C09z7u0tmjruHuJ+NLeHbXKDLi+gh3+ToUwIiVpQTMUhU1EMEOahmWmN0vIwvlkJ/EMDXoOUxf0b+qyLagEUvTCp0LHDhuj7UjjltQZ3IxLvtCCxXybE6ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=H/Y5QNnQ; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=UOOWd59+; arc=none smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=UtFu/7rrHv4X5KOTvsXatoIKvP38Td4ByIZSHbNhxXM=;
 b=H/Y5QNnQSdKVkGKUBSTSBmttqgIjVEe22rsEDSKU8dDUSQA2Ftiza2zkwLPXL9vktGDaC2LrNl0/ph5AA31veXHm+rggUejAGdgcaxpupxnQimmgcg7b3da/nbKqbPcum2N8H+90iLmZyIqdQOWwQ3cNzzjleRgSi6F/2jU9DD8YEiSnxVS+8teeOG9aAZPmDofL2hk2yjPMcPAbylFakkwLqX1pgqMFyKgzjGViZnQtTTxv9cnMqkswVBQBfxN9m7hofdqlu7veQeunjTBF86TdA2Y0RgRHylX1Ib6O6dLIwycum0Qgvhvva3ilj1DMp3u3zbmsWsTGCcVDNmznWA==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3FD6D3C0064
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 16:48:09 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-38f2726c0faso1480298f8f.0
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 08:48:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740070088; x=1740674888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UtFu/7rrHv4X5KOTvsXatoIKvP38Td4ByIZSHbNhxXM=;
        b=UOOWd59+P3yQtU+IYbKge1b0W5670XnbgMRo7+aS3eA8mwSS04yH+s6Dp2BTas/Pv9
         c7+SvQPz3n2KaGpJU8SVusdPt+P/nUT5CWucYrWwJ6DDHW1chWXolpOsS915CLHvVXCi
         oZorGvH7q/sWZvtoDGXuuFOFfSRfMoQZMuXm9AIYuCkTt8Gse7dPXnoKAzl78Z3e71SG
         bt4u2sztPbrbwQ6bR1/6igOTVCT1hTgBTkaneIiIIKNPaAJ+pZbwbZ7RMIBzia9LRX2O
         cGoyA5eD/6K5F/MQnW8O+bHWsNzJq2cwSe2p6FqMOfHKf3iuhhLWfcq0O5Hmmztw38lX
         sgsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740070088; x=1740674888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UtFu/7rrHv4X5KOTvsXatoIKvP38Td4ByIZSHbNhxXM=;
        b=Fl8RwFj48Eg2Rl1m2UrdKr+r2nu2tnv6n3eO3MOfBKG6DuP9Ny1QovITfgw/KpkePE
         n5lPqlsyh0g6Ks4ScYT0Wf1avuHtSWfH3/JSlsWsOI5FysNXA2kZa9olfscU4o39gCOC
         i/PUaWMQW3btLhIz6escCXalip3BiEPPzMAX6k76ezyWMErNVZULzjrAel96CX/7J0KP
         LX08SBKETRenyOND86KQKs67HG+cJ4HsXAZRv9pZlpWI5hOivzdFLZ2zhCPuG0GEzEWq
         u4VbtsIdjgbg5vW/ggelkqxRLNFYC6WP3gL0fb2MMJCci2lNUQnk32qH1bl4OJTGbsin
         dhEg==
X-Gm-Message-State: AOJu0YwA5f9rODqhS1Kl96nVixTKChAWkGmmOMFnBVieZ+bpvLM5QBwe
	JxJG7Xodh6dejUsQogaoB5QSeIcI74T76bEEPR8rz67yoWeuLkwMbYdr8hSYKFkrgmIELohbHc5
	u9AtOSuWbiE+F68GBPy+0CdXFwefRTez7AU1Pl1r8hiLTUKHIAsQKIZGnYo61SnepDKvf6YTYZ2
	fJfahskmJfBNGDacI3k70QrlMP8jJHpZPmPO9c2m9yV858CiGxnQ==
X-Gm-Gg: ASbGncvSFiIfsZLrmsWZwgCHBTgpslEuk6fMOdUYjvwQAfWafFm0T4phequ1WnY7DTN
	Kb2suCNQjwQS4BHcsfaeiK3bptMQ3BNdQt/VQr3pNchzLiZ31223KDRiw5+3wYQ==
X-Received: by 2002:adf:fa08:0:b0:38f:2a99:b377 with SMTP id ffacd0b85a97d-38f33f57459mr20939194f8f.53.1740070087963;
        Thu, 20 Feb 2025 08:48:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFFt+whvKVaXX4I4RkLMql6Zr2BmHhgEb6V9Rei8o5LVi/60bat3GQTyh1ZxROF61Yi6yE/rBBG1TCfUYx/5lc=
X-Received: by 2002:adf:fa08:0:b0:38f:2a99:b377 with SMTP id
 ffacd0b85a97d-38f33f57459mr20939161f8f.53.1740070087628; Thu, 20 Feb 2025
 08:48:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250219082550.014812078@linuxfoundation.org>
In-Reply-To: <20250219082550.014812078@linuxfoundation.org>
From: Slade Watkins <srw@sladewatkins.net>
Date: Thu, 20 Feb 2025 11:47:55 -0500
X-Gm-Features: AWEUYZm2jJ2bUAqU74OstkcJ9PoKvhhiK-1kP45Z94_5LauCnETdKls3QCUt_rY
Message-ID: <CA+pv=HM3XK=ceOVcTQJPQp2SH0KhU9pT0LwrWBwjobeq36B3NA@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/152] 6.6.79-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-MDID: 1740070090-ffBUylP7-uO5
X-MDID-O:
 us5;at1;1740070090;ffBUylP7-uO5;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;

On Wed, Feb 19, 2025 at 3:58=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.79 release.
> There are 152 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

