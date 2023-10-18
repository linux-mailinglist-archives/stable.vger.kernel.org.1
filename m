Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437BD7CDAEA
	for <lists+stable@lfdr.de>; Wed, 18 Oct 2023 13:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbjJRLqU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 18 Oct 2023 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRLqT (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 18 Oct 2023 07:46:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22B2A122
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 04:46:17 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40838915cecso8335615e9.2
        for <stable@vger.kernel.org>; Wed, 18 Oct 2023 04:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697629575; x=1698234375; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hIZB4xEFiDqc2+Z84fN6WVGzHYrI2kiuxOOK9C2i8+I=;
        b=OsJYJIZ7N2aUiAtuMwVWHJsMh4uu2u34GY9Gwnv07oPTNrecxZCVY4KTbU+Ktw3CRj
         3q57SyO8rPydvlVLdR69AqlO7YXRTbZ5yl1DRlaoZcFvGkebTFMDuFaArTRoybOAuQOf
         TfLAwWd9OnfJ29M6SIx3NZ7RrM/hVgzPl27fzG4Ss1/vm7ijw+EJYfo3WZ9vE16ps0VS
         ePpZa9ey+KrMFYVm+OKB1AwqKQyaiKO+HMhruH0gmaQ2kbfkzy1mtz3MoFvgDxnyGYfD
         8+CQFdqF8GZ1L0bloWz7eMTYNU8PmtoaX2FNqAhmVpLVeJbBVB3vaYVQucP+Ltu+I9BN
         YMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697629575; x=1698234375;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hIZB4xEFiDqc2+Z84fN6WVGzHYrI2kiuxOOK9C2i8+I=;
        b=LvaYGlXxQrAMI6Ni76oUlH7P04h70F6/2jIZGMaj5UXj5kInbYzDZ/0W4k0h0h81bO
         7ErfzVbWS2FbXQ2T87lpFB9A1J2lMhLkenoGVXKP6OI+Lk4ALGlxxxv4yljWiOC9FdbL
         39g1L4j4I/U5v00n0xYs7WMmmJN2bz7HIGApo6h7MqCi/pfMDM3vDvA1HNIDVIlFBccB
         5bA1PW3L16AlS/o20x6a9OcuA7UwKUcME4UE0ucNG16/cInF7pNQhp0QsM0qt53bVGeB
         oZEZaENCc3AqIiXxFptMhl7dF1qExNrfVuOdr11F6zs1VTukY33MJPJvALADPULYRuYv
         vdBw==
X-Gm-Message-State: AOJu0YwSqeVsxM18Fi1AsXGlrmXn9c0RLlR007chaPX81mxWYJKrlZh0
        U+w/Uvk3sjosyGeOydotVt37jAYBk05rArfjT7zifWwU
X-Google-Smtp-Source: AGHT+IFST4zTv5e3F3vfbnDudoRjP5SBUIl6bdsoe+9WOadjGlN10iP2gifoV+us3GybdQCFKsaB5Q==
X-Received: by 2002:a05:600c:468e:b0:405:3d04:5f52 with SMTP id p14-20020a05600c468e00b004053d045f52mr3756113wmo.24.1697629575441;
        Wed, 18 Oct 2023 04:46:15 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id bs30-20020a056000071e00b0032d9a1f2ec3sm1991631wrb.27.2023.10.18.04.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 04:46:14 -0700 (PDT)
Message-ID: <4b0b46f29955956916765d8d615f96849c8ce3f7.camel@linaro.org>
Subject: Re: [PATCH v2] Revert "fuse: Apply flags2 only when userspace set
 the FUSE_INIT_EXT"
From:   =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To:     Bernd Schubert <bschubert@ddn.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 18 Oct 2023 12:46:13 +0100
In-Reply-To: <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
References: <20230904133321.104584-1-git@andred.net>
         <20231018111508.3913860-1-git@andred.net>
         <717fd97a-6d14-4dc9-808c-d752d718fb80@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, 2023-10-18 at 11:39 +0000, Bernd Schubert wrote:
> On 10/18/23 13:15, Andr=C3=A9 Draszik wrote:
> > From: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> >=20
> > This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.
> >=20
> > This patch breaks all existing userspace by requiring updates as
> > mentioned in the commit message, which is not allowed.
> >=20
> > Revert to restore compatibility with existing userspace
> > implementations.
>=20
> Which fuse file system does it exactly break? In fact there haven't
> been=20
> added too many flags after - what exactly is broken?

The original patch broke the existing kernel <-> user ABI by now
requiring user space applications to pass in an extra flag.
There are various side-effects of this, like unbootable systems, just
because the kernel was updated.
Breaking the ABI is the one thing that is not allowed. This is not
specific to any particular fuse file system.

Kind Regards,
Andre

