Return-Path: <stable+bounces-144752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD82ABB826
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 669047A27B1
	for <lists+stable@lfdr.de>; Mon, 19 May 2025 09:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957C226C3BF;
	Mon, 19 May 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SWkHHEUR"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555126C3B1
	for <stable@vger.kernel.org>; Mon, 19 May 2025 09:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747645485; cv=none; b=b9I1FdjLdXBRvt8KzbDePTFFnME+YRXpU/4mMHrPJ9hY/UQQyK3u+AglfDhrZw4b+Mz0g5jUjWAjgabLBtGdnQZ1IfisLOcdw7jvieayIl8gQMohN1OwfZtpHL0QFADZmg4/zepsqR8MIfwOFa5405PAIze45vzzp06Gka7H83Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747645485; c=relaxed/simple;
	bh=s3ZF/R71XbQ2Wv8UWMHptS1RGAgFwyxTx7aSnB/lvm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UjMKm1XvVxwxE0q3e5ugosZ/LHWwthBeInH3oyLFv/LpNAr3C8jI4wK5b6CwH+bbhA/fnIg0nrmtn/MPfdBMiYyd3Lhm/7uAmKQ9PZsBEtWgt84+qkfvEUK0i0Dhx0Z6/TEO6zVFEGd1nouMtRFa07O6+bvXjnp3ipQ6Kx9P67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SWkHHEUR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747645482;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b+x4vTIQvSf2FWpLg3QbvkOR5KW8aweHD+AVnGY/4x4=;
	b=SWkHHEUReS3/wzqhhdzM/qZ8ikzkMJxlChELE0Ha9VnjVY2/sW7G54SgFhn5SYnIe7cA35
	mwxBOKlhHA4aatUCqzSHXbasPTTz/KjbLkilBpHqux4XS5cQCC1aooEV6etW9THK1D8DcC
	vjjEFd2z7xYXI9VmERZc0wxwYqSxxxk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-n8lWJeCSMc2eMSl6cNpsdA-1; Mon, 19 May 2025 05:04:40 -0400
X-MC-Unique: n8lWJeCSMc2eMSl6cNpsdA-1
X-Mimecast-MFC-AGG-ID: n8lWJeCSMc2eMSl6cNpsdA_1747645479
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so29332795e9.2
        for <stable@vger.kernel.org>; Mon, 19 May 2025 02:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747645479; x=1748250279;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b+x4vTIQvSf2FWpLg3QbvkOR5KW8aweHD+AVnGY/4x4=;
        b=aMDqTJvEh/jL10SGEGevd5kuYXq+nw6C4qY+58cr88ppP6kQsPoRa4aH7RT4niIngs
         7wLe9n1oIEq62JiQNKhbXcwV2Nkuc8WFMWYM59jf50KqUADHZVDQOF7k0ISGSniry6yQ
         V+wrgw7clpI0zMAT3Q5IotqrVXoY+MXLveFMNaMGyMOAAGba6jDADaxLfNTLTg2LTyE2
         KOQmvwxd5r4sDjTNFTldqvKCOszr9lR25rXyBwl/Er5/yqEJmDM4yLnpOBe2UNpS61hR
         24yCHG6AhlOFOCdJsCzpa+KkT4imxL28RqzyX5JWTSNlwCKu+UdTAZJguNVkiKNNCjVz
         CjRA==
X-Forwarded-Encrypted: i=1; AJvYcCUs9qtJTsHXIRl0Re1nfyUbAD5DTJZYfsktBnujURi+gQ8RxcCtxenKvI9VUCU5Ktjq2WQgWrs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbD+VW+/Osr+PwHZZBrxSK5dsdQCowdgCRj120zyFr8IR/5gw5
	WQ/2DwqBJTGp32b19jnonztZjNH0neRngPyDbYeT0vR7ImbQndXXLqPhpT7CXaaSUJ7LnM8Sqah
	efQPA7XqoRwc/W3X9RP1qShHjvIqWPfqES3kt0f1HJL83cNs+MhZkNuKTbQ==
X-Gm-Gg: ASbGncvnsC8UoUf/dIJQo2TB9jxeFGjoGjZ7GRl/ga0WYecKiLjbPEmjcXMWPnI1jaQ
	PSYW7VNv8dBG1uFLuSO/ZoerLFRnLQJVkAbEvxrTXvc3LjIfKeXZLwWCWlAPAAMWLkx6nS9T4EK
	kjOQ7D+2rVp0UwGVzwC7hSvsIEhXB2EH8mZO+yx6d/elx1P13eVocUpuyLDoNXmF/v1GR7TeYtF
	RkB4A0zgJNHj4syBFIUH83X4zAP47moJ2Gb2ObrgkGUgOPe5lLyDxHlZSgeiKue1ZYjDwSgVOit
	yJab7mPwy19Z7VvsPG4mwUxtkSwdb8cB1kN8G9mLDg==
X-Received: by 2002:a05:600c:524d:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-442fd6649bdmr105814975e9.24.1747645478942;
        Mon, 19 May 2025 02:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBHT37+a7uQLiNF7xXa9+Pq3Q8b9W3F1Dvt9NV0dg1vkagGrtK9lGqM9kuxuBv+sLOTByRBg==
X-Received: by 2002:a05:600c:524d:b0:442:e109:3027 with SMTP id 5b1f17b1804b1-442fd6649bdmr105814645e9.24.1747645478524;
        Mon, 19 May 2025 02:04:38 -0700 (PDT)
Received: from localhost ([195.166.127.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442f3369293sm207128905e9.6.2025.05.19.02.04.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 02:04:37 -0700 (PDT)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Thomas Zimmermann <tzimmermann@suse.de>, gregkh@linuxfoundation.org,
 hdegoede@redhat.com, arvidjaar@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH] dummycon: Trigger redraw when switching consoles with
 deferred takeover
In-Reply-To: <20250519071026.11133-1-tzimmermann@suse.de>
References: <20250519071026.11133-1-tzimmermann@suse.de>
Date: Mon, 19 May 2025 11:04:35 +0200
Message-ID: <874ixhotss.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Signal vt subsystem to redraw console when switching to dummycon
> with deferred takeover enabled. Makes the console switch to fbcon
> and displays the available output.
>
> With deferred takeover enabled, dummycon acts as the placeholder
> until the first output to the console happens. At that point, fbcon
> takes over. If the output happens while dummycon is not active, it
> cannot inform fbcon. This is the case if the vt subsystem runs in
> graphics mode.
>
> A typical graphical boot starts plymouth, a display manager and a
> compositor; all while leaving out dummycon. Switching to a text-mode
> console leaves the console with dummycon even if a getty terminal
> has been started.
>
> Returning true from dummycon's con_switch helper signals the vt
> subsystem to redraw the screen. If there's output available dummycon's
> con_putc{s} helpers trigger deferred takeover of fbcon, which sets a
> display mode and displays the output. If no output is available,
> dummycon remains active.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reported-by: Andrei Borzenkov <arvidjaar@gmail.com>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1242191
> Tested-by: Andrei Borzenkov <arvidjaar@gmail.com>
> Fixes: 83d83bebf401 ("console/fbcon: Add support for deferred console takeover")
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v4.19+
> ---
>  drivers/video/console/dummycon.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
> index 139049368fdc..afb8e4d2fc34 100644
> --- a/drivers/video/console/dummycon.c
> +++ b/drivers/video/console/dummycon.c
> @@ -85,6 +85,12 @@ static bool dummycon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
>  	/* Redraw, so that we get putc(s) for output done while blanked */
>  	return true;
>  }
> +
> +static bool dummycon_switch(struct vc_data *vc)
> +{
> +	/* Redraw, so that we get putc(s) for output done while switched away */

Maybe this comment could be a little bit more verbose about why this is needed
for the framebuffer console deferred takeover case? It doesn't have to be as
elaborated as how you have it in the commit message, but more information would
be nice IMO.

> +	return true;
> +}

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


