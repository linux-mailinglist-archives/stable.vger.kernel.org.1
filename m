Return-Path: <stable+bounces-37921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4B7A89E9CD
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 07:35:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 116A31C2122B
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 05:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788ED168CC;
	Wed, 10 Apr 2024 05:34:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692EF171BA
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712727296; cv=none; b=b8CKu0sT2Xi9dHUXromw+MkK0r6VACzp6c9jBfMQrb6RF+3/kjPpqjNyNgya97i6wd0RFyghM+szaycAiap875NJxAdgsFe1sZwHSZi6YkkN/SoMYvjHU9tEYbpHVwGNvhR2jJK3wa06wcQyZORhicSkep8E1Mv/ewquiEywyrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712727296; c=relaxed/simple;
	bh=2mycxeuRqD70O4mpnm9YevrRn8hndWw3CGePrM9dahA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1K97vAN7RYWEBOXHcZOe1fzHzs0lFBEibdfkG4n24Qrmg/vH0kMOOntE/N+h7+gMMRGUZ6gtPTtstsz+U0Vn0fhuM5lt0wG6+5xxR6U6tIKgW+souiH8e8aRFgxi17l+LjwbAaeldKplzmi/M0HfjTplHcDkGeaaH1g1AMoMt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BF5E940E02A5;
	Wed, 10 Apr 2024 05:34:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id PLADih6RBPZn; Wed, 10 Apr 2024 05:34:46 +0000 (UTC)
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FFED40E01C5;
	Wed, 10 Apr 2024 05:34:39 +0000 (UTC)
Date: Wed, 10 Apr 2024 07:34:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Pascal Ernster <git@hardfalcon.net>, Ard Biesheuvel <ardb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 6.8 271/273] x86/sme: Move early SME kernel encryption
 handling into .head.text
Message-ID: <20240410053433.GAZhYk6Q8Ybk_DyGbi@fat_crate.local>
References: <20240408125309.280181634@linuxfoundation.org>
 <20240408125317.917032769@linuxfoundation.org>
 <76489f58-6b60-4afd-9585-9f56960f7759@hardfalcon.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <76489f58-6b60-4afd-9585-9f56960f7759@hardfalcon.net>

On Tue, Apr 09, 2024 at 06:38:53PM +0200, Pascal Ernster wrote:
> Just to make sure this doesn't get lost: This patch causes the kernel to not
> boot on several x86_64 VMs of mine (I haven't tested it on a bare metal
> machine). For details and a kernel config to reproduce the issue, see https://lore.kernel.org/stable/fd186a2b-0c62-4942-bed3-a27d72930310@hardfalcon.net/

I see your .config there. How are you booting the VMs? qemu cmdline?

Ard, anything missing in the backport?

I'm busy and won't be able to look in the next couple of days...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

