Return-Path: <stable+bounces-50481-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC059068FD
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 11:36:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FDFB28774E
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2AC14039A;
	Thu, 13 Jun 2024 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hi1xPVIQ"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40241140374
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 09:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718271361; cv=none; b=QTLxgAkboYhDo5Fx5ANesAjO/cwGMhcgQYK6D1lVojLLk1eE7C8S8n2827su2wHMpCdfHWqMmnQXvMKoCJ9dyECZdLh1sg2IC6bm6pHOQ35VIZifgSzgP89Yrwz+9n97Uvqn32RHVCbQEGsKIz5XQr8CenNVmJhb0TQNwF0B33A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718271361; c=relaxed/simple;
	bh=cu/dQGPr41MhghabD46aO3bX0XTBfgtje55I8QhFGqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mRcis7iL82MfkSApJBvIKRsNX5Eml+kqRCmq/G92jaymhOe12WUx+Ymf3v4IAMejOc6aMZ/7HYof0txraDePvgVysSGoq6p3B+SZ6S1aQAGhnlUpL22cDwRo9b0AdZ/2SNPvDmehkP3UTBleX29pOUNaTvWqVeFC2H8hvR4EwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hi1xPVIQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718271359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+f9IRQAtoYreDkliCxhCyloA90D4/y0bQohgPwtZn1U=;
	b=Hi1xPVIQBfQkDP53uD0M+auZud3r1UltqE0qnsAHCf3PRdfekzvhYm9ZS38uFoDSxiKp9Y
	G3o2krpGh7hTsNW0Ico8KiiIqKO657l0m9KOdtBWvyKhJEedNOfXtJHW5s/WQwHyGzH+lr
	K7DIrbdItP5xb7xoBEJruvUB+gQdc4g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-217-Dz9YbvArPUWTZdvyFsxItQ-1; Thu, 13 Jun 2024 05:35:57 -0400
X-MC-Unique: Dz9YbvArPUWTZdvyFsxItQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f18355552so422427f8f.3
        for <stable@vger.kernel.org>; Thu, 13 Jun 2024 02:35:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718271356; x=1718876156;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+f9IRQAtoYreDkliCxhCyloA90D4/y0bQohgPwtZn1U=;
        b=IGeU7/JPwTgF1IWsTlVzYBkSs6aXsu/sBTDSZWmKrLIuKmYkYOsJL3Fy6+8PCtBkXD
         xSDBW735jjiph8HqS3BI6bPDY8IuyAy9j1lnCKWMuPFxYtQrhmQ+Tcjg37hGTh6hHWp0
         LDqFvcgM0rNi4lWPhvokCQDTLkNPCx3mzU5vNOZKv2GWOrcG+MGnIYnuQn5gOk+DQGjC
         7keN+ccN3vQ0RR+hxvdP9ENzI9SerN4LV5NX59G4NJuqaQfCZsy7qEywAnYA1TE37ON9
         ujY7fHLz/l1vINrc5Qsqn11JvoNW55ZAx5DYVuFJEzJr6eFwcaEtH5pD+mCIsahCkH8i
         7tRA==
X-Forwarded-Encrypted: i=1; AJvYcCVwdlwMohU7jL/C7IrR5CVIMRm5egMmHG6zPqD1a0Hfz4hEK828dFUAoydFIQN89vu/NIZJTX/NJBfU8oYh9C9ZyAwZ95hz
X-Gm-Message-State: AOJu0YzZw/6r+dMoHTf3hIGHXWEyuGDkqXQsi+NT5ibh0RAF5I3FEteY
	ErGWPdWdYaaw4/epbDHbHBtEdpZ3yYARr+S+d9iDOmgK1u7tXZ7khfKIe301QdwKDR6HYQNoqd8
	TcPn8eLtOwqYqMwYhSLhY9U3miz2zvk+SIzBsWc7VuZxo7JNeTV5UbZUbDRQkXw==
X-Received: by 2002:a5d:538d:0:b0:35f:488:6d3d with SMTP id ffacd0b85a97d-35fe89249f3mr2830856f8f.58.1718271355777;
        Thu, 13 Jun 2024 02:35:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRnQzDeC6g5C2hUDcuOh2NdJWNisz5Zy3hTXEWOVLoVlyeXt4Lup8LxzxKnEmUNmLb1HoUyQ==
X-Received: by 2002:a5d:538d:0:b0:35f:488:6d3d with SMTP id ffacd0b85a97d-35fe89249f3mr2830840f8f.58.1718271355247;
        Thu, 13 Jun 2024 02:35:55 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36075093615sm1159581f8f.6.2024.06.13.02.35.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 02:35:54 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
 sam@ravnborg.org, hpa@zytor.com
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH] fbdev: vesafb: Detect VGA compatibility from screen
 info's VESA attributes
In-Reply-To: <20240613090240.7107-1-tzimmermann@suse.de>
References: <20240613090240.7107-1-tzimmermann@suse.de>
Date: Thu, 13 Jun 2024 11:35:53 +0200
Message-ID: <87zfrpqj5y.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Test the vesa_attributes field in struct screen_info for compatibility
> with VGA hardware. Vesafb currently tests bit 1 in screen_info's
> capabilities field, It sets the framebuffer address size and is
> unrelated to VGA.
>
> Section 4.4 of the Vesa VBE 2.0 specifications defines that bit 5 in
> the mode's attributes field signals VGA compatibility. The mode is
> compatible with VGA hardware if the bit is clear. In that case, the
> driver can access VGA state of the VBE's underlying hardware. The
> vesafb driver uses this feature to program the color LUT in palette
> modes. Without, colors might be incorrect.
>
> The problem got introduced in commit 89ec4c238e7a ("[PATCH] vesafb: Fix
> incorrect logo colors in x86_64"). It incorrectly stores the mode
> attributes in the screen_info's capabilities field and updates vesafb
> accordingly. Later, commit 5e8ddcbe8692 ("Video mode probing support for
> the new x86 setup code") fixed the screen_info, but did not update vesafb.
> Color output still tends to work, because bit 1 in capabilities is
> usually 0.
>

How did you find this ?

> Besides fixing the bug in vesafb, this commit introduces a helper that
> reads the correct bit from screen_info.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 5e8ddcbe8692 ("Video mode probing support for the new x86 setup code")
> Cc: <stable@vger.kernel.org> # v2.6.23+
> ---

The patch looks correct to me after your explanation in the commit message
and looking at the mentioned commits.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


