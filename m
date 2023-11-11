Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FFB7E87CD
	for <lists+stable@lfdr.de>; Sat, 11 Nov 2023 02:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjKKBnH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 10 Nov 2023 20:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjKKBnG (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 10 Nov 2023 20:43:06 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE3448C
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 17:43:03 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-421ae866bc2so123861cf.0
        for <stable@vger.kernel.org>; Fri, 10 Nov 2023 17:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699666982; x=1700271782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFubWzEQonzq+lv002YAaxFb128xpJzjCEGjF24rMEM=;
        b=NTAk4i+HQRpvUo3tDOoyTs2GWVW6hXD4IH7UYYXN62R3txHesP6ivSewkvk+YpZYeQ
         jTd1M2REx9fk7EVona0tqJ9BTjKykgD/+R0osRnVhFiN2VmZgBAIVw3dMlfNaBeEf2Z7
         Kyk/FNRPtzlj1tfIlaeagFvBDtVa15se8eL6IoM26Dv6mFqo+M5abZMN7nzlbPLWXlzg
         fU4YhOYUROPDHh2+3HXi/lSPb04kX/XJJUNbzZw0Pam654Ff+TA1O5sI/IP4gcKdE7KL
         21uCucvBBnJzxPZV+WR2Ct49MwR9Fh9NiuzXcLg1q2LfMuCJEPdMAfUKDu7Lkbf0g3BZ
         BSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699666982; x=1700271782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFubWzEQonzq+lv002YAaxFb128xpJzjCEGjF24rMEM=;
        b=wGUpPOYT6zAzMhuict4XvGJoE4p5jHk3b6U9lBeiOJ1LcseKGshgX3pbEs8DR90NjR
         bSqavWS8tfqE9tkAhtYXnCjD+9o5mIzsbzMaGt+j0DW6lRVTG9UsWxVD1e7SsNXXvoJc
         TcqXBgZb7dxxawJYBev+ic8OPhgNHr6z/S2tXCKGD1JFnwGPtByyLLDDrcsz4QO+D/9Y
         E6HUmbA+1jVEotcbX87sbsW1MWTqbNAQeeZmYSkJMnQt5cMndIJS8mYK0qe7rqwx5M1j
         nOahKmT00b4Bm2cDabbFqAYKy3e871X5YEp55V4TPesKYEQ0YlWZatrubjhqMbnivUcz
         tXRA==
X-Gm-Message-State: AOJu0YzLm6T++tWeQ5Oaum8+HwfjxOpGi5V3zR3rv1z/F5uWq9vKsOlJ
        6rrzFFdOGBvwWotq69wqthhO4gQLSRhfLA8NaFU34Q==
X-Google-Smtp-Source: AGHT+IGQR9HMCrPQXlBQ/2GprZyNn9b5D7vkdrp50OmQHiBBwnQPMkuoZANQcfMonS6xRt1c5BvBjWKGdGqKHyxVaps=
X-Received: by 2002:a05:622a:4008:b0:421:56ae:e761 with SMTP id
 cf8-20020a05622a400800b0042156aee761mr82044qtb.6.1699666982448; Fri, 10 Nov
 2023 17:43:02 -0800 (PST)
MIME-Version: 1.0
References: <20231110080241.702999-1-herve.codina@bootlin.com>
In-Reply-To: <20231110080241.702999-1-herve.codina@bootlin.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 10 Nov 2023 17:42:26 -0800
Message-ID: <CAGETcx-Mp0uKBF_BWFFBUm=eVOp8xhxF3+znFB8vTaFwpJWTnw@mail.gmail.com>
Subject: Re: [PATCH 1/1] driver core: Remove warning on driver unbinding
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 10, 2023 at 12:02=E2=80=AFAM Herve Codina <herve.codina@bootlin=
.com> wrote:
>
> During driver unbinding, __device_links_no_driver() can raise the
> following warning:
>    --- 8< ---
>    WARNING: CPU: 0 PID: 166 at drivers/base/core.c:1426 __device_links_no=
_driver+0xac/0xb4
>    ...
>    Call trace:
>    __device_links_no_driver+0xac/0xb4
>    device_links_driver_cleanup+0xa8/0xf0
>    device_release_driver_internal+0x204/0x240
>    device_release_driver+0x18/0x24
>    bus_remove_device+0xcc/0x10c
>    device_del+0x158/0x414
>    platform_device_del.part.0+0x1c/0x88
>    platform_device_unregister+0x24/0x40
>    of_platform_device_destroy+0xfc/0x10c
>    device_for_each_child_reverse+0x64/0xb4
>    devm_of_platform_populate_release+0x4c/0x84
>    release_nodes+0x5c/0x90
>    devres_release_all+0x8c/0xdc
>    device_unbind_cleanup+0x18/0x68
>    device_release_driver_internal+0x20c/0x240
>    device_links_unbind_consumers+0xe0/0x108
>    device_release_driver_internal+0xf0/0x240
>    driver_detach+0x50/0x9c
>    bus_remove_driver+0x6c/0xbc
>    driver_unregister+0x30/0x60
>    ...
>    --- 8< ---
>
> This warning is raised because, during device removal, we unlink a
> consumer while its supplier links.status is DL_DEV_UNBINDING.
> Even if the link is not a SYNC_STATE_ONLY, the warning should not
> appear in that case.
>
> Filter out this warning in case of the supplier driver is unbinding.
>
> Fixes: 8c3e315d4296 ("driver core: Update device link status correctly fo=
r SYNC_STATE_ONLY links")

Wrong Fixes tag. I just added the SYNC_STATE_ONLY exception. The issue
has been there since before.

> Cc: stable@vger.kernel.org
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/base/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 17f2568e0a79..f4b09691998e 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1423,7 +1423,8 @@ static void __device_links_no_driver(struct device =
*dev)
>                 if (link->supplier->links.status =3D=3D DL_DEV_DRIVER_BOU=
ND) {
>                         WRITE_ONCE(link->status, DL_STATE_AVAILABLE);
>                 } else {
> -                       WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY))=
;
> +                       WARN_ON(!(link->flags & DL_FLAG_SYNC_STATE_ONLY) =
&&
> +                               link->supplier->links.status !=3D DL_DEV_=
UNBINDING);

Don't delete the warning please. Make it better so it doesn't warn
when it shouldn't.

This combined with the other patches you sent make me think this is
more of an issue in the device removal ordering than an actual issue
with the warning. I'm not fully convinced the warning is incorrect
yet.

-Saravana

>                         WRITE_ONCE(link->status, DL_STATE_DORMANT);
>                 }
>         }
> --
> 2.41.0
>
