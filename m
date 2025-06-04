Return-Path: <stable+bounces-151332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB5B9ACDC55
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8532217187B
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 11:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D6028E57C;
	Wed,  4 Jun 2025 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhQtsuSX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5437828EA42
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749035708; cv=none; b=vEhINBeD4NiBS65h+U7MFMuTqe+lWTZy66bDHtRzaU/ygw+i3+sV8eEVwc49gshsM5sKx2IRJRYqThxJ5y+EI/UXUpm5tBaZ+2foFX7CqkWybkwr/HRiUI13he1/Xii/LsvT/tanXH2n5bpk7nFpH1GYbl+Pb+6djtulXwU0WYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749035708; c=relaxed/simple;
	bh=DDIrx6qniSjWoPqZ1+FQ6cvCHnIr1IHnMhtHEPpu3Uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SbtnerMbZpoKfKAiQCfhjOyFuBrwJdBN9cwmRUyDkEup6cMTy7An1fa9jDK4rd1igzsgyBbmgrb0GA7BQ8OQxFviB/sKyv1LDLmVFRlC+ypcbiq2Ow95v+CEAKADjT2/1O0YC7IQrI3zCkaG0jBfiZV4mhT6aLtQWkwLBLUQMwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhQtsuSX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749035705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H5bmvoV528ZDMkA8vQ3GG9k3siMYViBoGzRoypMVKOg=;
	b=DhQtsuSXVgzmSCn0wnyUdW+YVlr9NUQyYvR5IRxjHF9idM8PTO2hvSqlgxuDjuDpEj8d2X
	5D7R5lMhfyonIVigVscUQbBVXUxGTSTlrE7WDAy2n8qO5xaarBmrRZthsveEvD+rkLrxTJ
	i2e5IsCNIyZX8dc4r+4gb56u1ESbQ3o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-_HyiYfveNcCp61u3DvqRWw-1; Wed, 04 Jun 2025 07:15:04 -0400
X-MC-Unique: _HyiYfveNcCp61u3DvqRWw-1
X-Mimecast-MFC-AGG-ID: _HyiYfveNcCp61u3DvqRWw_1749035703
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-450cb8f8b1bso17674455e9.3
        for <stable@vger.kernel.org>; Wed, 04 Jun 2025 04:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749035703; x=1749640503;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H5bmvoV528ZDMkA8vQ3GG9k3siMYViBoGzRoypMVKOg=;
        b=liKCA7SYFv0sVu6n8xMoJDR8xOLtyQ4GWCLTV1J5jfbnqCWVcxZpKc8u39BnJqfyvL
         AVdhSU7WxkC+WzKJaoI1bHFImWzACeyb27AjdDCGXHVNuTGVbusqxMIJP/z6D55/Dw52
         G9XuUv5YPdUXdM0db5E9dHq24/xhMqLibfUp4zGU6duw9akOeexzt/nDoCEKUSOIVbzJ
         PJm4HZhGjjhDcLntw8ZVjbwlNQi3VwYp4AfzRrjFAyfR0mDT7wj5x8RD1AOfCFvwUFOO
         sMHMr20Pw12yxdbEaQrpBkixFgG+PYQuULiOLNh1h8BqISAFJmrGY2ZpuDITL55GIjOy
         RwVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3fGFSYswa8hNsroHlhVpWin5G5o/QP9GFNDkAmFevM2+/vkKua0pfR3e3Hr06uMXWB/fjwm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMiiTD0/6PuBSMbLR3iyIrCx7dtdV85ynMukhe0cLhJrxS6/wm
	MkNYPdHVei/++P8dvf/O23sXxhaB2g6jYBhOk4nGoKTp34lhR9wbZChYtkhbAF41GBO5h0IyOgy
	nURllrYIM6fipIABxNmrTw6ZrtQ21t7ClkTlAA+wP8LDHGcoQidDdBrwhmw==
X-Gm-Gg: ASbGncsmTYu1Hx/7DfaWhWN5BzblFIzLaOjOB7wMSbGlWfkQBubrUKZfwkooIZo8mH+
	rsMA+UPEwbtNYfIzwC511GmhgoSkjtm0tyy8YBDjx+yUDrz/UhCmjI/KpGRpxTubPjHuldgLn23
	HfzB0asnT3EJBZ8r6tlPCB7DpNHwDhpngOkT6VXiqsmgY/qgCqlcNax5Q4oekzzR5WXW6KOG2Lo
	3S7NYzGU8iaQPbMhTTKIYl2BJsZzS+Hq+f3EXCes3dfchHqqcXnH6uL/j1CialPIPizqS7ECPQ5
	d2ZCKiohWPutRPPUrCXFaRM+KicS6gtoXanCbGgZOSiFnDhAp58NyILRInn8Slk49Z7M5Q==
X-Received: by 2002:a05:600c:3542:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-451f0b3938cmr24124115e9.30.1749035702775;
        Wed, 04 Jun 2025 04:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEkyu2yxy9u1E10EDNHkq0GJQg9fveXJ4AfXqJRU2A9xpka6O8heUM24yU/Pjyhp3aJF3xAA==
X-Received: by 2002:a05:600c:3542:b0:439:86fb:7340 with SMTP id 5b1f17b1804b1-451f0b3938cmr24123775e9.30.1749035702404;
        Wed, 04 Jun 2025 04:15:02 -0700 (PDT)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a522ab67dbsm916950f8f.62.2025.06.04.04.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 04:15:01 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Thomas
 Zimmermann <tzimmermann@suse.de>, Alex Deucher
 <alexander.deucher@amd.com>, Tzung-Bi Shih <tzungbi@kernel.org>, Helge
 Deller <deller@gmx.de>, Uwe =?utf-8?Q?Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>,
 Zsolt Kajtar <soci@c64.rulez.org>, stable@vger.kernel.org
Subject: Re: [PATCH] sysfb: Fix screen_info type check for VGA
In-Reply-To: <20250603154838.401882-1-tzimmermann@suse.de>
References: <20250603154838.401882-1-tzimmermann@suse.de>
Date: Wed, 04 Jun 2025 13:15:00 +0200
Message-ID: <87ecvzahcb.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the helper screen_info_video_type() to get the framebuffer
> type from struct screen_info. Handle supported values in sorted
> switch statement.
>
> Reading orig_video_isVGA is unreliable. On most systems it is a
> VIDEO_TYPE_ constant. On some systems with VGA it is simply set
> to 1 to signal the presence of a VGA output. See vga_probe() for
> an example. Retrieving the screen_info type with the helper
> screen_info_video_type() detects these cases and returns the
> appropriate VIDEO_TYPE_ constant. For VGA, sysfb creates a device
> named "vga-framebuffer".
>
> The sysfb code has been taken from vga16fb, where it likely didn't
> work correctly either. With this bugfix applied, vga16fb loads for
> compatible vga-framebuffer devices.
>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


