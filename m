Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0199A7EDDE0
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 10:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344968AbjKPJpz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 16 Nov 2023 04:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344956AbjKPJpx (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 16 Nov 2023 04:45:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C7A196
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 01:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700127950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zSzsA5SxyFLcplHAlbNRiGj1W1HdcMtXrU3K2DbJDWo=;
        b=BS8cDv13tlnncvqz42L16ScaQGgJDbw+Zd7bntQm3tK4iJrLOspjNcK6+ItXvGWGiqyUsA
        q3JmQTnlswQT37uy0uQUny4M+4Zs+ZQfJNBCXbqZXtsU9VKGlSx9L/pnrmytci0J4DcXCY
        0DWpp2AuMrJlzU9s0wKQOndCH2eOddQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-DQ5asifhPcW3qDzDKRl8Rw-1; Thu, 16 Nov 2023 04:45:48 -0500
X-MC-Unique: DQ5asifhPcW3qDzDKRl8Rw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4084163ecd9so3515715e9.3
        for <stable@vger.kernel.org>; Thu, 16 Nov 2023 01:45:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700127947; x=1700732747;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zSzsA5SxyFLcplHAlbNRiGj1W1HdcMtXrU3K2DbJDWo=;
        b=aL5H04WelC5AOjCAK9TERgGb1c5ttlU0W0Rp2qLcl6JKuxle7e+zntXNLFp3H9/K0a
         2ZsEH39fKFpJIFXYx2aBPp1/ie57MvdLlsEpY5647RxY2GGov2IZTcjLn/0sgk4O93yO
         89oDXow/VzAQX57BEZ5xgL3TEWkngvOlet9wKelqIpC9JEcu+elrIAbee4NxyAefC7SH
         fg+DWJQUvLNZToJjbg8gZbJgtEfwvoqWkRgixCFFFI5AIo1Uc9LNfe1A/nQDpbS+sKUQ
         1x/Ld3WNpsPYyDVOKs4FDAbB2RvScKmWVI8D4w2aVFgbP8w9or9hDuM1GzjuiIUypyif
         oVXw==
X-Gm-Message-State: AOJu0YxIsvyc5AjUaIhEzSykdWERTKUnoPQaFqXgkvmzFC52XG0jTRrG
        jETkCnNMbB93doXjsL/8tugQ8VMN4LwHBePef1QBYgVxsSMqEEDyuXQMyPyZ8NiLZd/AVWXgGto
        2nNCKe3zUF8PQgicO
X-Received: by 2002:a05:600c:46cf:b0:3f5:fff8:d4f3 with SMTP id q15-20020a05600c46cf00b003f5fff8d4f3mr13564632wmo.7.1700127947455;
        Thu, 16 Nov 2023 01:45:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtLFlJthV6m1GTAAXrgTEAAU7vMTnuD+YdTz6edocexCaOzMz3U0re055aJeRbTrwW/zVrhw==
X-Received: by 2002:a05:600c:46cf:b0:3f5:fff8:d4f3 with SMTP id q15-20020a05600c46cf00b003f5fff8d4f3mr13564617wmo.7.1700127947117;
        Thu, 16 Nov 2023 01:45:47 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id je14-20020a05600c1f8e00b00405bbfd5d16sm2915620wmb.7.2023.11.16.01.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 01:45:46 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH 01/32] fbdev/acornfb: Fix name of fb_ops initializer macro
In-Reply-To: <20231115102954.7102-2-tzimmermann@suse.de>
References: <20231115102954.7102-1-tzimmermann@suse.de>
 <20231115102954.7102-2-tzimmermann@suse.de>
Date:   Thu, 16 Nov 2023 10:45:46 +0100
Message-ID: <87h6lm58vp.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix build by using the correct name for the initializer macro
> for struct fb_ops.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Fixes: 9037afde8b9d ("fbdev/acornfb: Use fbdev I/O helpers")
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Helge Deller <deller@gmx.de>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: <stable@vger.kernel.org> # v6.6+
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

