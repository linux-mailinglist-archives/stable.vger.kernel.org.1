Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1778B72AC6F
	for <lists+stable@lfdr.de>; Sat, 10 Jun 2023 17:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjFJPAY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 10 Jun 2023 11:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjFJPAX (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Jun 2023 11:00:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD53AA5
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 08:00:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4407A61169
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 15:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26257C433EF;
        Sat, 10 Jun 2023 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686409220;
        bh=xqovdrUr3AnVr+uxYMCWB3Gw4xgw1Ev86OVzhABQ0qI=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=clfY7snMK2PwuygO+woNDY+edXqg7cGATdpWZjdDUwj0p12uhUSCYuY4902aGAM2O
         kQ+xPN3P2lLkpy+BpDP8+VYi3hH6nldplLshG4MINMFiRCA3dRc2/UuxLdA4bR2ufI
         2uPeSM9oPL84DiroIEkoklkgWlEWBVSI69ss29bo6ipdBWgHfMbPOk4ajJ7C2nISdq
         70Jy3tpDDc4waeDKtxrz3evew4znCR88VS3UxdavElfdy9FIPNdUUXah8cJu2uXkxu
         Ucw3YQNmTLEsBGCmGcVQyDdZLWx/0ldilOMW67yiCnvEHjRRx3cuKlpTM0ipBrJUTE
         pNlbEiRf26E7w==
Date:   Sat, 10 Jun 2023 08:00:16 -0700
From:   Kees Cook <kees@kernel.org>
To:     Frank Reppin <frank@undermydesk.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        keescook@chromium.org, stable@vger.kernel.org
CC:     Holger Kiehl <Holger.Kiehl@dwd.de>, debian-kernel@lists.debian.org
Subject: =?US-ASCII?Q?Re=3A_request_commit_for_6=2E1_too_//_scsi=3A_mega?= =?US-ASCII?Q?raid=5Fsas=3A_Add_flexible_array_member_for_SGLs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <18d71d6f-3bb1-ff5c-d053-787492322bf6@undermydesk.org>
References: <18d71d6f-3bb1-ff5c-d053-787492322bf6@undermydesk.org>
Message-ID: <FEF61131-A089-4A5A-AE38-71DFB6B8E8B9@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On June 9, 2023 3:42:12 PM PDT, Frank Reppin <frank@undermydesk=2Eorg> wrot=
e:
>Dear all,
>
>I've already followed the reply instructions on LKML - but it somewhat
>messed up my message there (so probably nobody knows what I'm talking abo=
ut) - however =2E=2E=2E
>
>Earlier this year you've committed
>
>scsi: megaraid_sas: Add flexible array member for SGLs
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/mkp/scsi=2Egit/commit=
/?id=3Da9a3629592ab
>
>=2E=2E=2E but it only made it into 6=2E3 at this time=2E
>
>I hereby kindly request to see this commit in LTS 6=2E1 too=2E

Sure! These requests are handled through the stable mailing list (now adde=
d to To:)=2E

Greg, please backport a9a3629592ab to 6=2E1 (and 6=2E2)=2E

Thanks!

-Kees

>
>Why?
>Debian Bookworm is soon to be released (RC4 at this moment) and is not ye=
t aware of this issue=2E=2E=2E
>
>We're currently testing some new DELL servers and want to roll 'em out
>once Bookworm is released=2E
>Previous tests using Debian Bullseye (Kernel 5=2E10 based) where fine=2E=
=2E=2E
>but all of a sudden - with Debian Bookworm (Kernel 6=2E1 based) this weir=
d
>call trace shows up in our logs - and this is hard to explain to QA ppl=
=2E
>
>Apart from this call trace showing up - I don't see any weird things=2E
>The /dev/disk/by-uuid/ thingie I wrote about in
>
>https://lkml=2Eorg/lkml/2023/6/9/1384
>
>is nonsense ofcourse - because upon further thinking about what I wrote
>it came apparent that the command I'm using does change/nullify the UUID
>I am talking about=2E
>
>Thankyou!
>Frank Reppin
>
>


--=20
Kees Cook
