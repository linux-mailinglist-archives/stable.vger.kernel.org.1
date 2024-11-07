Return-Path: <stable+bounces-91847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 455CB9C0966
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 15:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2A2B1F245B9
	for <lists+stable@lfdr.de>; Thu,  7 Nov 2024 14:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CCD210186;
	Thu,  7 Nov 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=meirisoda.online header.i=@meirisoda.online header.b="iSptoqF+"
X-Original-To: stable@vger.kernel.org
Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A427420ADDC
	for <stable@vger.kernel.org>; Thu,  7 Nov 2024 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730991362; cv=none; b=joohQYsa1l//gmaIKqSGHqOSNDgM4+XbiCoohEiydO6nsZK1DL93bKCfAB+k4758V24fouQpagCa7kM53akVwwYK7GR45m9umvSNGubTN5o/WGRXK+m8B16sEUZyrt4Xq38EEZiG1BW391CdUbF3qoFNlq1tBLM6IwGeD82RmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730991362; c=relaxed/simple;
	bh=HQT6sSXxZ4+IzIT0kZfCvJG79/FhOL/fF37+8Asgz2g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AJa1yNKPXKeB6L/k5x6ZCo1Fp2v5fnTof8gfMxvR91nt2KSzv49a3OtCRHQF9aQGAO0su8MX1vjT4uQGZbHhppg4yZ6K8BYkvsiJidKpdHdIMHKY9oEj9xrYMldOaS1hJKn4VXrftpCFu4hgoiuOSnYwGqDnoNjQ+R37Pgc5++A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=meirisoda.online; spf=none smtp.mailfrom=meirisoda.online; dkim=pass (2048-bit key) header.d=meirisoda.online header.i=@meirisoda.online header.b=iSptoqF+; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=meirisoda.online
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=meirisoda.online
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meirisoda.online;
	s=protonmail2; t=1730991358; x=1731250558;
	bh=+Y7pVHk71hhLP46ETcmPhfbaVehxJr7d90LURWm4ZmE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iSptoqF+AGC67qae1HOgmVUvdvr6U/fcopGmorHOAy9nUvAyK2J5vsnS4m+fXOafv
	 dTRJTHRwHHLmPBAvTCo+J3l/9D95GQVEUoB83ewfEMu+fG3DEpFOTlI/yR4CU+Hdj/
	 c+1K9MFnBOWXCxoRi91eWcz/QEwWrR2HEGWszFtx8Z9gSyP1vWPvU47jFEB7Y5+mU+
	 j+3CoSjzifP0gUVSHT2UcKArLOoryQV0RiZcDsSTAeH8/KFCUhgqxJ7lz2ilFzzZAW
	 VFO5uJ2lpWSXTLB6hRZ2qDKV3ULhD7YN4jmVS+JK9c5CAkiXaSR5HnjQY8ET0NCkES
	 uDWbQ8UPjiq/Q==
Date: Thu, 07 Nov 2024 14:55:57 +0000
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
From: me@meirisoda.online
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: Kernel 6.11 breaks power-profiles-daemon on NixOS unstable
Message-ID: <Xw3BDSu6nGp8D43shw707_3JcIzRhictWhTjZpThlOWIyF69jtxhq11eV2ExaObroqAhGypRaS86DmN2f2e2IgmGSC4U1AFRW95qOLometo=@meirisoda.online>
In-Reply-To: <tRrhWMFNiTeCGps2p7WCa6mrpbeCMCgYfeXGsJNOjttrbCyth-0_5EsgpkAZ9zqeMBR4kS6axOZrZxJwnA3LhYtGMgmRnmL2-xrpI0oVkxk=@meirisoda.online>
References: <tRrhWMFNiTeCGps2p7WCa6mrpbeCMCgYfeXGsJNOjttrbCyth-0_5EsgpkAZ9zqeMBR4kS6axOZrZxJwnA3LhYtGMgmRnmL2-xrpI0oVkxk=@meirisoda.online>
Feedback-ID: 108323841:user:proton
X-Pm-Message-ID: a062c34edfdad8f4ce98d74a180b88d46dd18944
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Upgrading to kernel version 6.11 breaks the ability to switch between power=
 modes on KDE Plasma 6.2.2 and NixOS 24.11 (unstable). I am using a ROG Zep=
hyrus 14 GA401 with a 4060.

I thought it may be Nvidia acting up so I've tried:

    Re-enabling power-profiles-daemon in my NixOS configuration (did not fi=
x the issues)
    Disabling supergfxctl on NixOS configuration (did not fix the issue)
    Switching between nvidia latest and beta (did not fix the issue)

Switching back to kernel version 6.10 fixes the issue. Since 6.10 is consid=
ered EOL upstream, I had to manually switch back to a specific commit hash =
to get 6.10 to work.

Hoping this gets fixed on 6.11.

Thank you,
soda

Sent with Proton Mail secure email.


