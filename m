Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17D079BBF2
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241977AbjIKU5b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239198AbjIKOOO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:14:14 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A99CDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:14:08 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c93638322so964178666b.1
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1694441647; x=1695046447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtfPL2emZ+ThTIXQ737wda+eYe7YeOc3mG8avwXPF00=;
        b=B3YW8qN1OM0NMMwQU1VBMALrVMB5bqAUZj86NyqQT5MeyCQ24oiEalA/DhP8hqwvqN
         S+35ruYX8xQleHQlUlyvpHWqxI47DGGI/9xeyQyViLKHirXKGU7Hj+SVIfZLIvTnZyfE
         TNi0Q4vxXYRbWoyzw+l/MOT/nfy8YCgI4QEock0MhAd9/rbmx9064FB/O+Bd+Q/VKpi1
         be5LnJpdAGWqbo89QYPCgGVvICeJqAVf3bSa7pmWnaS24UXCh+3VPtfdtklZc+kmpHWG
         2Bxsh+gOYNE7kMUAzmcyK4F2Ov5B4PBn/Zf6g8sgpFDnI0zLdNBo7MQvH17LkYTHvFlG
         /P8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694441647; x=1695046447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NtfPL2emZ+ThTIXQ737wda+eYe7YeOc3mG8avwXPF00=;
        b=Xs4J9BNXi+qaRi9Fe+oWsiyY89P+91T+6F3gydyrA6IoMBHWxEdZcG1XhS1oOp7HpN
         8+2SG9/T+/JKIiFAy1cEetrykaaot9FEmn0Z6k4dX+wJjDAhVENrcdwpYyAqcsbK9OKX
         V4/d0bfwEcowR1IAn1/OaqQWrPzE9anmb2ukQSlnDkD5zxY3kfzxxscflDge24WMaezS
         VO8PeEO+qC9MO7UxTcrsiMZV3huNiMyspyKf9DvAL4vrMR6z9OhxVgzMW/js7yj+YnAJ
         JlvvGmPoifyPw7HTrgDnHLEmUy77Mru51egMg9ydUxIKohqEC04YWVedqWDTlpI1tZk+
         FXgA==
X-Gm-Message-State: AOJu0YzPHZxrSQtJ1C0Y8DY8Dyz9k3dAOYNOGOtOK27m/hYATUnkz+/d
        VdUMPyrQwUr63utgPNjKALN2T2+fjWq5pN18O5LtAA==
X-Google-Smtp-Source: AGHT+IE05e6MiDP//Kv1NcMJh6gG19EBAAYmMoj9z4lXWNtchtfjTgjw1+YWgi0eny9agYeRN38esqdVXPtIT8/btx0=
X-Received: by 2002:a17:907:9724:b0:9a5:962c:cb6c with SMTP id
 jg36-20020a170907972400b009a5962ccb6cmr18545113ejc.31.1694441646773; Mon, 11
 Sep 2023 07:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230911134650.921299741@linuxfoundation.org> <20230911134653.617660874@linuxfoundation.org>
In-Reply-To: <20230911134653.617660874@linuxfoundation.org>
From:   Lorenz Bauer <lorenz.bauer@isovalent.com>
Date:   Mon, 11 Sep 2023 15:13:56 +0100
Message-ID: <CAN+4W8jR5vXtgzanqDc2UHYZRC-m87cMFwCAztArENtgqfA9Rw@mail.gmail.com>
Subject: Re: [PATCH 6.5 090/739] net: export inet_lookup_reuseport and inet6_lookup_reuseport
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Lorenz Bauer <lmb@isovalent.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg,

I sent the below email to Sasha and stable@ this morning, but I forgot
to CC you and can't find a copy of it on lore. So here goes a copy:

On Mon, Sep 11, 2023 at 2:55=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 6.5-stable review patch.  If anyone has any objections, please let me kno=
w.

This commit is part of the following series
https://lore.kernel.org/all/20230720-so-reuseport-v6-0-7021b683cdae@isovale=
nt.com/
As far as I can tell this was pulled in due to the Fixes tag on patch
7. I think that tag was misguided, in that the original code
explicitly rejected SO_REUSEPORT sockets so there isn't a bug to fix
here. The SO_REUSEPORT code is quite fiddly, so I'm uneasy about
backporting the change. Could you drop patches 3-8 from 5.15, 6.1, 6.4
and 6.5 please? Patch 1-2 are good to backport.

This also means that "net: remove duplicate INDIRECT_CALLABLE_DECLARE
of udp[6]_ehashfn" is not required anymore.

Sorry for the mess,
Lorenz
