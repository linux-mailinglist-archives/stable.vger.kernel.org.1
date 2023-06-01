Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C45F3719FEB
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 16:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232295AbjFAO1y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 10:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbjFAO1x (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 10:27:53 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C943123
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 07:27:49 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5689335d2b6so8294817b3.3
        for <stable@vger.kernel.org>; Thu, 01 Jun 2023 07:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685629668; x=1688221668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICHI64+8dOrhd6y0piTql/tzROSogAi/ONuL/Zv7624=;
        b=Io8/Ei8M8AWi39vZsJRs2SxnUXgYnGpE0MdIrn5tF2PO5HT7AdECiszwRtM7p7TaH1
         R5MiAKHyrma1vY5G2OMbvg8yn+PEB4rSrjBO+pRy/93nGRDSUUL4kMK0aVt8Wc0TEf0w
         V45lSkeVyzX/rx7HZ4RyeACES5xYcHjeLN+lGGJn35DXgNIfHHn59bP3FE0tzizBE5Dx
         WDuIpu2pZ4tNTuROPDs5tKhYROVYGefzumWGwqasDwE2bD5wxwGpXx8BIWWTaPo6DjCp
         KOMpE5ZNgYzD/vJu3d/ju0Gty+bB6PrbUw3mxMA1kcat7z4cORpMcVMpg7OwSQYPPRrS
         RufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685629668; x=1688221668;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ICHI64+8dOrhd6y0piTql/tzROSogAi/ONuL/Zv7624=;
        b=QZabcUQEH5ftmFkKoZ0Bo9SjUhFCxDh7eZiaAMEOI/GGa/xW5yVLzy0hvHQTizoAez
         dUYHYVyjtJGppweGRoDwB+2ul7JSWjgJRP9sOLSnotXcftSLiUJ5Q0pa9wQdCi9yyMoK
         val1yimb0JyLqdUZVNkkvwwsgIPysYJ35p6d6R9MJ7Me9qiY+pdzm8K9+HwSBa6dx0Iu
         0ehu8PXs2n1NOlVIzVFr19k2Nj1cClblNdcAM13VC5r43TcyCw1N5BlkVTBbh+ki9jYr
         7NYYNHxZLn9cgDnddFtWNesWVQQzLyGp4cmn2GHch+OiMgropWkIQR0RXUA4bESl64L6
         F8Vg==
X-Gm-Message-State: AC+VfDwVClu9UI3WKiws5HHhBUtgdhuOdES5couCr5n2zmA8nG+108UK
        +TjYIt1pYEoZhyF1BxFVGNscAdaR1GRCSMFUM6l5QeN3NjmI/pAIbw==
X-Google-Smtp-Source: ACHHUZ4KDjqE/yYyur3zuhUhsgcAs+fe6kC1U5juQjrtyc2wkIuFG8pD3a8UlNiQsast4f0p+wL/wE36Uk5km75xlmA=
X-Received: by 2002:a81:4605:0:b0:569:12a5:f30a with SMTP id
 t5-20020a814605000000b0056912a5f30amr3372103ywa.9.1685629668444; Thu, 01 Jun
 2023 07:27:48 -0700 (PDT)
MIME-Version: 1.0
References: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
In-Reply-To: <8892cb92-0f30-db36-e9db-4bec5e7eb46e@amazon.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 1 Jun 2023 10:27:37 -0400
Message-ID: <CAHC9VhTmKbQFx-7UtZgg8D+-vtFOar0dMqULYccWQ2x7zJqT-Q@mail.gmail.com>
Subject: Re: Possible build time regression affecting stable kernels
To:     Luiz Capitulino <luizcap@amazon.com>
Cc:     sashal@kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, May 31, 2023 at 10:13=E2=80=AFPM Luiz Capitulino <luizcap@amazon.co=
m> wrote:
>
> Hi Paul,
>
> A number of stable kernels recently backported this upstream commit:
>
> """
> commit 4ce1f694eb5d8ca607fed8542d32a33b4f1217a5
> Author: Paul Moore <paul@paul-moore.com>
> Date:   Wed Apr 12 13:29:11 2023 -0400
>
>      selinux: ensure av_permissions.h is built when needed
> """
>
> We're seeing a build issue with this commit where the "crash" tool will f=
ail
> to start, it complains that the vmlinux image and /proc/version don't mat=
ch.
>
> A minimum reproducer would be having "make" version before 4.3 and buildi=
ng
> the kernel with:
>
> $ make bzImages
> $ make modules

...

> This only happens with commit 4ce1f694eb5 applied and older "make", in my=
 case I
> have "make" version 3.82.
>
> If I revert 4ce1f694eb5 or use "make" version 4.3 I get identical strings=
 (except
> for the "Linux version" part):

Thanks Luiz, this is a fun one :/

Based on a quick search, it looks like the grouped target may be the
cause, especially for older (pre-4.3) versions of make.  Looking
through the rest of the kernel I don't see any other grouped targets,
and in fact the top level Makefile even mentions holding off on using
grouped targets until make v4.3 is common/required.

I don't have an older userspace immediately available, would you mind
trying the fix/patch below to see if it resolves the problem on your
system?  It's a cut-n-paste so the patch may not apply directly, but
it basically just removes the '&' from the make rule, turning it into
an old-fashioned non-grouped target.

diff --git a/security/selinux/Makefile b/security/selinux/Makefile
index 0aecf9334ec3..df35d4ec46f0 100644
--- a/security/selinux/Makefile
+++ b/security/selinux/Makefile
@@ -26,5 +26,5 @@ quiet_cmd_flask =3D GEN     $(obj)/flask.h $(obj)/av_perm=
issions
.h
      cmd_flask =3D $< $(obj)/flask.h $(obj)/av_permissions.h

targets +=3D flask.h av_permissions.h
-$(obj)/flask.h $(obj)/av_permissions.h &: scripts/selinux/genheaders/genhe=
aders
FORCE
+$(obj)/flask.h $(obj)/av_permissions.h: scripts/selinux/genheaders/genhead=
ers F
ORCE
       $(call if_changed,flask)

--=20
paul-moore.com
