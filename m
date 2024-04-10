Return-Path: <stable+bounces-37999-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3789FD1A
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B10221C20B52
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AE626AE8;
	Wed, 10 Apr 2024 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nFkyi0Xn"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FCD17A937
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712767081; cv=none; b=DgbuQ5Yio3LlNOxddUtpExBuIXKvuOoBi7gVsgZu6j4TiAv2pP2H7JxQRGPo8dblyQb1O9kB1a1tiXRsRgbPTJ8zi/gXfrWM7C10CEvBr66k3X6OR2lGu0SeOcKq3hk7x7nAJtO5XmI07ajBlOwkU4/D05kAKJSOYdDWYlvdyMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712767081; c=relaxed/simple;
	bh=AMgEGgEF5G11tgF61befRzoOglNuHlyFi5hOiDd6CP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VF3kN5RcIrdIWYstSOfCqK3WNfixLWOabTfqxlwAjsQ+kdGtSEBcezmShl7FSntlZYUA9RUKyJeYutuU2ZgONqbyPkL8p+ayBFF5adFeTSp2k583JsLONX96Ca4LGGSru5iBODIpUfhO5KUDkHy+JzuEUnu6flR91OSLxMbagtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nFkyi0Xn; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1e424bd30fbso24827785ad.0
        for <stable@vger.kernel.org>; Wed, 10 Apr 2024 09:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712767079; x=1713371879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yjP//Mip90DcNq6QUVZoNBunB0elsCFZjlaQ4MXCgWM=;
        b=nFkyi0Xn8/OzkUAZ+2/Ui58M1HJWqyUmgnUHMoU4oO/fprB27ptMt31THYMyHCzoBc
         QVJy1BkPe3dajgNK5PjsTssvAtSbgNh5harwwOBUzcIhhSj18O/4zwJsJ6RLeSF6GXup
         pvgmz48HOFhOlEIzajHPwjCJu0xw+day70h0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712767079; x=1713371879;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjP//Mip90DcNq6QUVZoNBunB0elsCFZjlaQ4MXCgWM=;
        b=JhT2fUY9Ic9K0Wd51vMLRnDVfiqa7pjAYpm6l5MjRDwszs+xIZte06ua1Epk7R3BrD
         +puyxOBR/qr7+FKf5JEVAHb3VbdiraBgdp8Q7D+TTtJuyicBWxZPCBEv4JSpjU4Fp/pq
         O6KM3+5lRcb3H6PrgEwC1CsgwtvzBVM3InrTOItnSfR0h3lI6D9KF/rWdXdmA5l/8O94
         aCpe8uDoweYQ6/n0WqzHT35xBlZmQEMjaO/vQxyPsRmrrN/HvgCbphtf6hdp5wDIfW3J
         5n4Ao2pWEouZic2re6rv+3EvIrJDn4nwdTaV4F081Z2g+GL1vSjdE9PuMTX9eYmQSdSS
         syKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV9Ket0bOwT4E+arDwztxYHw0E39mM3W9EiuXUM+GAfb0KMt/mkM2sXRCe0dWjdZ6bhkPFdREmOc+Vtk2kLigiqqLh3ubry
X-Gm-Message-State: AOJu0Yyl4P/xBXLgFhmRxpzAVSO0iy3sUM/yVJD1NQahpX5WE2U7hcbf
	YoT6Ux7eOg/94IL9NkcBABpL4VHjNeHenoyir4M7FRLW5G8Ix8INP4TxI7vqfA==
X-Google-Smtp-Source: AGHT+IGkSiqBENZyju8TbqoPI/qjO3Z9rGbf5Qvvr78dXidWDY70vwNaq6ppkND4mRSc9wHSfUaMow==
X-Received: by 2002:a17:902:eccf:b0:1e3:1542:91e2 with SMTP id a15-20020a170902eccf00b001e3154291e2mr4176100plh.46.1712767079276;
        Wed, 10 Apr 2024 09:37:59 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902e2d100b001dddcfca329sm10961121plc.148.2024.04.10.09.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 09:37:58 -0700 (PDT)
Date: Wed, 10 Apr 2024 09:37:58 -0700
From: Kees Cook <keescook@chromium.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Pascal Ernster <git@hardfalcon.net>, Borislav Petkov <bp@alien8.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH 6.8 271/273] x86/sme: Move early SME kernel encryption
 handling into .head.text
Message-ID: <202404100937.12A8146@keescook>
References: <20240408125317.917032769@linuxfoundation.org>
 <76489f58-6b60-4afd-9585-9f56960f7759@hardfalcon.net>
 <20240410053433.GAZhYk6Q8Ybk_DyGbi@fat_crate.local>
 <25704cce-2d6e-4904-a42d-47c96056459d@hardfalcon.net>
 <CAMj1kXH+xOB3cLHL5XHAxMHeN8oOXYaqdExx2+Tij6vwZwhkiQ@mail.gmail.com>
 <CAMj1kXFQfgAOSdPd1aYW8TDi8mkExK9G4buviysu85YsQaQPdw@mail.gmail.com>
 <3ef518a6-6c9b-42f0-a3e0-22a306185a9a@hardfalcon.net>
 <CAMj1kXE-Yt+zVgZ5Y=jEssrna+pUYAOOEr5cXLiXMkmRqEKwhQ@mail.gmail.com>
 <fb25f7fa-f5f8-4ae6-aaa1-e1fdfd2f47a7@hardfalcon.net>
 <CAMj1kXFMwxFJJvYaTfUYb88a3iL4VFLWoBVdKj1eUH7q5_fOVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFMwxFJJvYaTfUYb88a3iL4VFLWoBVdKj1eUH7q5_fOVw@mail.gmail.com>

On Wed, Apr 10, 2024 at 06:01:03PM +0200, Ard Biesheuvel wrote:
> Please try this patch
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=e7d24c0aa8e678f41457d1304e2091cac6fd1a2e
> 
> My bad, and apologies for the mixup - I lost track of things and did
> not realize this fix was not in Linus's tree yet when I asked Greg to
> pick up the EFI changes.
> 
> @Kees: can we get this sent to Linus asap please?

Done! :)

https://lore.kernel.org/lkml/202404100935.3D7CAE6@keescook/

-- 
Kees Cook

