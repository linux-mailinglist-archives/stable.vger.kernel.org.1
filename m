Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B057C9A80
	for <lists+stable@lfdr.de>; Sun, 15 Oct 2023 19:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjJOR7m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 15 Oct 2023 13:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjJOR7m (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 15 Oct 2023 13:59:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A40AB
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 10:59:40 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-536ef8a7dcdso6004a12.0
        for <stable@vger.kernel.org>; Sun, 15 Oct 2023 10:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697392778; x=1697997578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoXsgJJ21m2pTS0JXP5H9mz5VnmfvA1QDP4HFkDfg8I=;
        b=tdl1yJ18y09pUoQCC9VLILF6P6jr2OYZN2t7XyTrAEzU9yBzK6u1psUALYdBMP41JG
         XOc8mPVS5h8sJGaVMUWMTdcZPen+uzh4Ff+UktjKZ8imHi+UEv1U6ULeo+YsVobXedjR
         S95tk6zYh2hcS/TGeUExPZfC0UDLDIC76vFe0L0TF+emEileZge3FXYqNGxpEJjSGyHB
         lZILKxTtLxVMNVKlzNfgbLs3OCUPr2R3h/SAPz7DKh7HwmxSK1acqRxuyWAWWgeluHhe
         MNdrKttfMWk6nh/IhMiB8HJF5iHslazpsTqiR/HbPaJ/v5WmO62g4TVLD8N+Vi5rbD5o
         BIsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697392778; x=1697997578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoXsgJJ21m2pTS0JXP5H9mz5VnmfvA1QDP4HFkDfg8I=;
        b=iJ/Z/SOI6Nx12kJH4DhxEYTQIEWOwLUfN0UaL+SVPqjaG0GG8V+LhiZoKVt1aNmgVx
         hMEqOJrhJNS15IT5XjRUSb463bHEGhrC1+Iyb7Dxm4VtcyxYo9SQuUqufb6T3tPxnaVH
         U1klyUujSrCTiVCWpQhNtgJkhAe5znh7hpOKX9RSoAk56OIXYmbD7hi1TaA+clDfoVv8
         7Akp6J74wCoGlirJZmRuDyHM9j1rCACD3L3FgzKSAREmcqH8POHiE+Tc4IjzyQE6XxmP
         hJWUDouhjbdrTgxY/HAqOxXqkjh8YvJ3ZuN1NdeC1qv3mhVtK+Pux0Wlj4TzKtB+4jmt
         7D3Q==
X-Gm-Message-State: AOJu0YwTF+Lnvt9XjInyitI9WNo13NRFMeI1B7VLHm4gbOnItHOyaI2b
        WqD0P2G+V4mjBrvRvl/okr5GNXGTG0eiroRCJGceVA==
X-Google-Smtp-Source: AGHT+IEc72G92Ay7Jor1qXeXCYca2EmQ32QifiPi3MFWNhCc9tFTuEoJ+puwmVtEMPlREyewYE4EheuxyGkazFqLLu8=
X-Received: by 2002:a50:a45d:0:b0:538:7038:6bdf with SMTP id
 v29-20020a50a45d000000b0053870386bdfmr101716edb.1.1697392778442; Sun, 15 Oct
 2023 10:59:38 -0700 (PDT)
MIME-Version: 1.0
References: <20231013214414.3482322-1-prohr@google.com> <2023101505-speed-procreate-347d@gregkh>
In-Reply-To: <2023101505-speed-procreate-347d@gregkh>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Sun, 15 Oct 2023 10:59:21 -0700
Message-ID: <CANP3RGfU9+GuMm+K8hohxxCndLNy925CTMHKXhiFkjwgojbzwA@mail.gmail.com>
Subject: Re: [PATCH 5.10 0/3] net: add sysctl accept_ra_min_lft
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Patrick Rohr <prohr@google.com>, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sun, Oct 15, 2023 at 10:46=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Fri, Oct 13, 2023 at 02:44:11PM -0700, Patrick Rohr wrote:
> > I am following up on https://lore.kernel.org/stable/20230925211034.9053=
20-1-prohr@google.com/ with
> > cherry-picks for 5.10.198. I have run our test suite with the changes a=
pplied and all relevant tests
> > passed.
>
> All now queued up, thanks.
>
> greg k-h

Great!  Thank you.
