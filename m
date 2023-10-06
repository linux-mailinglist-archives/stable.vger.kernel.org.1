Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732A97BB7D1
	for <lists+stable@lfdr.de>; Fri,  6 Oct 2023 14:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjJFMiK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 6 Oct 2023 08:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjJFMiJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 6 Oct 2023 08:38:09 -0400
X-Greylist: delayed 14444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Oct 2023 05:38:07 PDT
Received: from mail.flyingcircus.io (mail.flyingcircus.io [212.122.41.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2893C6;
        Fri,  6 Oct 2023 05:38:07 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flyingcircus.io;
        s=mail; t=1696595884;
        bh=QROki/xLmnzh8Ufw7wb6+X7Eml957imSqlgKLlkSy5s=;
        h=Subject:From:In-Reply-To:Date:Cc:References:To;
        b=FO27+VlxnQ3cXrTELOkkm8HUlgD1XHloGN6D9tHnuiZAZ14IoN7cVZEBaiHrqMaDI
         iK1NFrEvV6wdFPLG2J7I8qdMT3cPgW+gqnF/etTXonALd9oVdUarNd0cD4Ios/lOHv
         HNqXnriIu3z1BRIa88uYaCanBBy1f9+T3B1fuEIw=
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
From:   Christian Theune <ct@flyingcircus.io>
In-Reply-To: <982dc76d-0832-4c8a-a486-5e6a2f5fb49a@gmail.com>
Date:   Fri, 6 Oct 2023 14:37:43 +0200
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        stable@vger.kernel.org, netdev@vger.kernel.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <0AAB089F-A296-472B-8E6F-0D60B9ACCB95@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
 <207a8e5d-5f2a-4b33-9fc1-86811ad9f48a@leemhuis.info>
 <879EA0B7-F334-4A17-92D5-166F627BEE6F@flyingcircus.io>
 <740b0d7e-c789-47b5-b419-377014a99f22@leemhuis.info>
 <BBEA77E4-D376-45CE-9A93-415F2E0703D7@flyingcircus.io>
 <982dc76d-0832-4c8a-a486-5e6a2f5fb49a@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

> On 6. Oct 2023, at 14:07, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>=20
> On 06/10/2023 17:51, Christian Theune wrote:
>> Hi,
>>=20
>> sorry, no I didn=E2=80=99t. I don=E2=80=99t have a testbed available =
right now to try this out quickly.
>>=20
>=20
> Please don't top-post; reply inline with appropriate context instead.

Sorry, I will avoid that in the future - I was a bit in a hurry and thus =
negligent, but you=E2=80=99re right of course.

> You need to have testing system, unfortunately. It should mimic your
> production setup as much as possible. Your organization may have one
> already, but if not, you have to arrange for it.

I=E2=80=99m able to do that, I just didn=E2=80=99t have one at hand at =
this very moment and no time to prepare one within a few minutes. I=E2=80=99=
ll try to reproduce with a 6.6rc in the next days.

Christian

--=20
Christian Theune =C2=B7 ct@flyingcircus.io =C2=B7 +49 345 219401 0
Flying Circus Internet Operations GmbH =C2=B7 https://flyingcircus.io
Leipziger Str. 70/71 =C2=B7 06108 Halle (Saale) =C2=B7 Deutschland
HR Stendal HRB 21169 =C2=B7 Gesch=C3=A4ftsf=C3=BChrer: Christian Theune, =
Christian Zagrodnick

