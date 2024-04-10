Return-Path: <stable+bounces-38004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E7689FD8F
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 19:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3FCB2AA30
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E49771552F7;
	Wed, 10 Apr 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="yW79wGeG"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1022E17B515
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 16:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768338; cv=none; b=eXM2A2Wo973Nkam2wa0NgT+hgLAfFfZIB42JUhtfyYnDD8PQ6P2P5DVfUt9Zl4jF4U5GYkCLJgnhTeOt+ccOrlEWH1HTpJAIY9gPJbt2jQao43YwxMPdNUIRPE6gR9uE9sMASqWTZbnVLkzosJ/T4A53LIswskG6bxMc84wrbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768338; c=relaxed/simple;
	bh=iGbJGU5JOI0dJ8GhJN0d2FkkljFCJdBvkrXmicyrGys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjTnys+AIhAQwcQRTChL0YiPxXeRP99rJL/YjzivAA4ph3bDWUVbOSYuwAx4PjYXk2hbYn8cxImvPQBbG5M27hseZZ25yJpY3uDe07PulPRgJ4MnBKAEx+XN6oQJFi8+h/oDtfk/wpXIldvzJjk14G+pBxN1s75SyQV4Sm5sfeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=yW79wGeG; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1712768333;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zO8CCcU5uFWiaI5apM4bN4AQn1jmaKiKHGMr98/qkK4=;
	b=yW79wGeGBgk8tGNmxn7qmDlS5vPfPtHwPOZ3MCzRX9nNwERSeV3FRgzk0T1YufZTw+1ZWl
	C9ioz4zXRcLBOzCg==
Message-ID: <dc118105-b97c-4e51-9a42-a918fa875967@hardfalcon.net>
Date: Wed, 10 Apr 2024 18:58:51 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.8 271/273] x86/sme: Move early SME kernel encryption
 handling into .head.text
To: Ard Biesheuvel <ardb@kernel.org>, Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, Tom Lendacky <thomas.lendacky@amd.com>
References: <20240408125309.280181634@linuxfoundation.org>
 <20240408125317.917032769@linuxfoundation.org>
 <76489f58-6b60-4afd-9585-9f56960f7759@hardfalcon.net>
 <20240410053433.GAZhYk6Q8Ybk_DyGbi@fat_crate.local>
 <25704cce-2d6e-4904-a42d-47c96056459d@hardfalcon.net>
 <CAMj1kXH+xOB3cLHL5XHAxMHeN8oOXYaqdExx2+Tij6vwZwhkiQ@mail.gmail.com>
 <CAMj1kXFQfgAOSdPd1aYW8TDi8mkExK9G4buviysu85YsQaQPdw@mail.gmail.com>
 <3ef518a6-6c9b-42f0-a3e0-22a306185a9a@hardfalcon.net>
 <CAMj1kXE-Yt+zVgZ5Y=jEssrna+pUYAOOEr5cXLiXMkmRqEKwhQ@mail.gmail.com>
 <fb25f7fa-f5f8-4ae6-aaa1-e1fdfd2f47a7@hardfalcon.net>
 <CAMj1kXFMwxFJJvYaTfUYb88a3iL4VFLWoBVdKj1eUH7q5_fOVw@mail.gmail.com>
Content-Language: en-US
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <CAMj1kXFMwxFJJvYaTfUYb88a3iL4VFLWoBVdKj1eUH7q5_fOVw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-04-10 18:01] Ard Biesheuvel:
> Please try this patch
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e7d24c0aa8e678f41457d1304e2091cac6fd1a2e
> 
> My bad, and apologies for the mixup - I lost track of things and did
> not realize this fix was not in Linus's tree yet when I asked Greg to
> pick up the EFI changes.
> 
> @Kees: can we get this sent to Linus asap please?

Thanks, that patch does indeed solve the issue for me. :)


Regards
Pascal

