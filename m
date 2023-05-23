Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F4470E333
	for <lists+stable@lfdr.de>; Tue, 23 May 2023 19:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237955AbjEWRGT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 23 May 2023 13:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbjEWRGR (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 23 May 2023 13:06:17 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36451BF
        for <stable@vger.kernel.org>; Tue, 23 May 2023 10:06:15 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64d293746e0so6479443b3a.2
        for <stable@vger.kernel.org>; Tue, 23 May 2023 10:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684861574; x=1687453574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5D4jJBdsw8v5z1Hj7e4NkWHnBQGpeGcsx2kEbP6mIWQ=;
        b=ln4dCoJzG69l0bBJ66KX8uAKPONQc33WsyrsJD2qkfoU+XgCrb4Ky7e2c7ejfR3RfW
         OF/9Ad54Mh6U0/dlwSmvD15AmN5ad11ggoJYfdYnbUxhiAh6J+yB8V92GYw9uJsD9CJT
         GZ8P1zrI7yzwZfchnshDFmU/ZUIQplyuqIV/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684861574; x=1687453574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5D4jJBdsw8v5z1Hj7e4NkWHnBQGpeGcsx2kEbP6mIWQ=;
        b=OEQYCtF/Np52kaLOju8gXBlkpiamOy4cVAKqvTIDhtcC0KDVMC6QEuT2Z5Ul2X8a81
         1HSnyr0bC2XmDkmwcUz2vfIkG+v2Rg4pHm66ejPFsPPAdpaeLmostC2K9dOxA40UWVRj
         z25qWwOXoi2Uzf0k8owgDo+Q+RUH/28+E0breEBJps3ZJSc0rAjsdX6McAug/JBPAFYj
         +6Ahg8tG6boTKHh9FJ/4HtLDpaP7owh/6qDC8eS/k5rydV5QlgX4qryPdvmJVhFvBblE
         idjMIOnNtXY1+uvm4SNVDqBE56IaEgzBlf3ZqNw4V9qrvYLzQL6Pk6Yq09V/fHJJwQ5f
         hqfg==
X-Gm-Message-State: AC+VfDxtFQgxju3lndKn21ZcLumg1IPS/K606gdeqIKXLkvy5a5Fy5Cz
        QO0L9XFrvrnMx+8uP547X0kXBw==
X-Google-Smtp-Source: ACHHUZ6Iu7uTc8qj06melcElk4wG/mkYt9xsoFCNr5WU4few+n4Wb1U5B20HKwwiuBR+NHUrnMzvlg==
X-Received: by 2002:a05:6a00:14c4:b0:647:e45f:1a49 with SMTP id w4-20020a056a0014c400b00647e45f1a49mr19188735pfu.4.1684861574564;
        Tue, 23 May 2023 10:06:14 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id i9-20020aa79089000000b0064559b58eb8sm6035544pfa.154.2023.05.23.10.06.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 10:06:14 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     raven@themaw.net, arnd@kernel.org
Cc:     Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] autofs: use flexible array in ioctl structure
Date:   Tue, 23 May 2023 10:06:10 -0700
Message-Id: <168486156843.2168554.9330529184813281577.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230523081944.581710-1-arnd@kernel.org>
References: <20230523081944.581710-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, 23 May 2023 10:19:35 +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Commit df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3") introduced a warning
> for the autofs_dev_ioctl structure:
> 
> In function 'check_name',
>     inlined from 'validate_dev_ioctl' at fs/autofs/dev-ioctl.c:131:9,
>     inlined from '_autofs_dev_ioctl' at fs/autofs/dev-ioctl.c:624:8:
> fs/autofs/dev-ioctl.c:33:14: error: 'strchr' reading 1 or more bytes from a region of size 0 [-Werror=stringop-overread]
>    33 |         if (!strchr(name, '/'))
>       |              ^~~~~~~~~~~~~~~~~
> In file included from include/linux/auto_dev-ioctl.h:10,
>                  from fs/autofs/autofs_i.h:10,
>                  from fs/autofs/dev-ioctl.c:14:
> include/uapi/linux/auto_dev-ioctl.h: In function '_autofs_dev_ioctl':
> include/uapi/linux/auto_dev-ioctl.h:112:14: note: source object 'path' of size 0
>   112 |         char path[0];
>       |              ^~~~
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] autofs: use flexible array in ioctl structure
      https://git.kernel.org/kees/c/e6d6886d469f

-- 
Kees Cook

