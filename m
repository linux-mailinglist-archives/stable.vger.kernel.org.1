Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6151675CA16
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 16:34:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjGUOeP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjGUOeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 10:34:14 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A4E4269F
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:34:12 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fb5bcb9a28so3320548e87.3
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689950051; x=1690554851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qfahRnOSaxHuC4uuvPzhv2/ZD/mZunNuT4Wpt04q0ng=;
        b=D1Sb0BY7G+QlXTWN+dHrYmhw908FHAHphJFVcF7uqJ7TPhIx5YoLTZq3mY8XYKtxA5
         dT3hdjqiKANt9FW7SoL/reI2e9DeBIlEpJH0Ma4j875eDEQcEb7+aYMjizQnfZJ/Pttm
         36ydR4JQEDAqfDma+13groZ0i3Ol31a9pNajWszIxENWw34d92jPzTF2G6fzAkBqivOe
         CwIsvy/51jLgzC/j7y69CXtGAYxL9l4nRlb3C7dSwI/ChDqkMf3RQVJObz48HnF5UizZ
         2RSL48jOQ5V0hRWvx1KXwnm0kklgewfPfVcfyLHUBB1S2cPuLcKaDOdHQQ27aiLuGmcJ
         pXPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689950051; x=1690554851;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfahRnOSaxHuC4uuvPzhv2/ZD/mZunNuT4Wpt04q0ng=;
        b=l1pKHvHXUzHuKvksWnHtTSsDoW3J5xKyT4LRbWEMiEeXQ2jxI6gTyfOOIN++0aigai
         HlPKJ3JjnSXTmm3x4Fx5Mt7N+o6qfWPnkT/BaiilOkR026w4gTMzkUfm4dJBcGX4sszA
         7I3b05jnrM7neS4wh+wD/JjDhxZv2hyCASWsVhJYOODfRBGjuIzQuMedf2mnGRnDxDi7
         Ix1gY4AWPXwlZLXN4eQPdgOqfpI+DOBZS9JEVr/VWkizKa21zSWDXLlG6NCL3zH2B67G
         fiTIwRyqzT8b5tJUNlE4cS4A+QKkeG6Gpuk8mE71VZ0foHa3xc2lItoUD7nwNTKGr2KD
         sj8w==
X-Gm-Message-State: ABy/qLZIuE65udULqZRxIn9uaBhFKVUA03n9WM5Q9BvvZ66+DwyNMGz4
        ttm62+dqD4Fodkmv2qrJq8A=
X-Google-Smtp-Source: APBJJlG7LP9ACc/SAWHBmoWPVcMSrhISL3pncD4/jZaapF9bM8liKL9VWhGeeBVJNVLXb3tW/fya4A==
X-Received: by 2002:a05:6512:3e11:b0:4fb:8939:d95c with SMTP id i17-20020a0565123e1100b004fb8939d95cmr1796603lfv.30.1689950050438;
        Fri, 21 Jul 2023 07:34:10 -0700 (PDT)
Received: from [192.168.1.95] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z1-20020a056512376100b004eb12329053sm757763lft.256.2023.07.21.07.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 07:34:09 -0700 (PDT)
Message-ID: <f551563c93f3a1c80d0182ac9b2e9873db9eaad4.camel@gmail.com>
Subject: Re: [5.10, 5.15] New bpf kselftest failure
From:   Eduard Zingerman <eddyz87@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Luiz Capitulino <luizcap@amazon.com>
Cc:     "sashal@kernel.org" <sashal@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>, ast@kernel.org,
        gilad.reti@gmail.com, Mykola Lysenko <mykolal@fb.com>,
        andrii <andrii@kernel.org>
Date:   Fri, 21 Jul 2023 17:34:08 +0300
In-Reply-To: <2023072139-shriek-ranging-bd9e@gregkh>
References: <935c4751-d368-df29-33a6-9f4fcae720fa@amazon.com>
         <76dfe02eea69141b662a3a399126dba9e00e5abe.camel@gmail.com>
         <9c7fc5ab-1c06-8452-2747-aa89e7a1dfb6@amazon.com>
         <c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com>
         <bc521a2f24c416a658ab50685fbf647d4e069c8c.camel@gmail.com>
         <2023071846-manlike-drool-d4e2@gregkh>
         <595804fa4937179d83e2317e406f7175ca8c3ec9.camel@gmail.com>
         <96204082-4cb8-038c-ac83-6b1a9f367f3b@amazon.com>
         <2023072139-shriek-ranging-bd9e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, 2023-07-21 at 07:30 +0200, Greg KH wrote:
[...]
>=20
> backporting the mentioned patches is best, can someone send them to us
> in email so that we can apply them?

I'm investigating 5.15 test failures at the moment.
Will send patches for linux-6.1.y by the end of the day.

Thanks,
Eduard
