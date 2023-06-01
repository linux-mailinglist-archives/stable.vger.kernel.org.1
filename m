Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF1C71905A
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 04:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjFACHu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 31 May 2023 22:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjFACHt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 31 May 2023 22:07:49 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C46133
        for <stable@vger.kernel.org>; Wed, 31 May 2023 19:07:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 733B05C01CA;
        Wed, 31 May 2023 22:07:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 31 May 2023 22:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1685585263; x=
        1685671663; bh=bg7JvsvfSAtwjJ2bCs1qjuCrVNfS6ZSDnqTL+rRGNZE=; b=F
        39gU2iKfk+9sniCcAPnRqOvbmByW3yXaMPzdZ4GywQZSxa9PwKEqy9XxLVBTDaO9
        z6iErB6+PSP78dUktjNFGVgrZVuonAl97YIJTsxAWF+GiZpkrmUdqF8KD8HzSF+N
        XIoc31/nZXoilapt8J7naBM4T8IszQorf4XARbVsVLbQD8B8yekYBhhXVOIreSIC
        7mOekVTsCxlSwEzGke0g339d5hzoHz/adnHR8P/GM+elfEiKKUnxvxrK1c9Nw8mE
        l7DZBalVIPLdTAU9/59y2G0rjd9E3YNrfFYA8oSor71OwIG41fOxAv1KtGTnhMll
        FX6h4S9Ej5EzsYMiCpltg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1685585263; x=1685671663; bh=bg7JvsvfSAtwjJ2bCs1qjuCrVNfS6ZSDnqT
        L+rRGNZE=; b=xWFBp+eUsr13M/ijXcv8gDXVTUcKXYhiBIV18WDbzTaW5g/PnNl
        Uvhxvjzwd+XoyK+5/K0dFO2W6ksvBoEqRp12/mwhIkYD6fd7awBfHv3rQlgT3J18
        RNCORskzCkMh6J+NqTdYXwEiFzoCckWHegFHQzHIF80pH8nTJECuc57pBey8Buea
        gPpbyXRaUzY5hjuVBD4up821svajN26ogMTY9l9wwNFl6vDaXFuc76xu5gWM/hTU
        MbUiRrnOE7ejJ5+U9YPjHfAhDe1oGKWzbOleCKypPqd+GhOZke8lA423XgCgrgJW
        399GiCkl/wf7rj4dcrKVwFO0ch4TIJnAyOw==
X-ME-Sender: <xms:b_13ZOxpOz4hTC_83x18CXRZ2ewauyRjwtqC2ZES2sU3p58oNLQF1Q>
    <xme:b_13ZKQ9_HW-IybuWcAWnis7sCeT9MtGbm15mZmAovzZ1UrVUv-rQ19TBgfBqH2I1
    l_xQQIgVDmF65E>
X-ME-Received: <xmr:b_13ZAXvV97FW0RjkKfEaRRtcxKbr4FlpxbwTl9B6KIRIfOc3Z765jSHI6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeltddgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkgggtugesghdtreertddtvdenucfhrhhomhepffgvmhhiucfo
    rghrihgvucfqsggvnhhouhhruceouggvmhhisehinhhvihhsihgslhgvthhhihhnghhslh
    grsgdrtghomheqnecuggftrfgrthhtvghrnhepieeivdefvedvtdfguddvkeeikeeigeeh
    leektefffeejkeefvdfggfdtjeevleejnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuggvmhhisehinhhvihhsihgslhgvthhhihhnghhslhgr
    sgdrtghomh
X-ME-Proxy: <xmx:b_13ZEivrp8Zpf-dwnISZif7xQ3XsQYJFs-zE_8ch6YDGCbygSNhRA>
    <xmx:b_13ZAAWfzGymVd_m9pzi6iyOrxbmwsivJ13hNz8cBR2fyt2xbJJHQ>
    <xmx:b_13ZFL6xgmH8-iOkIHyXKjWzTluhIGvp7wOLrq5q4WfEPP0ixViYA>
    <xmx:b_13ZP8ARRQd_CzCZlX4Hj1bzOKpK-CYfg79J5zPvAzIvXmMhQBEBg>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 22:07:43 -0400 (EDT)
Date:   Wed, 31 May 2023 22:07:37 -0400
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     stable@vger.kernel.org
Cc:     Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: Please cherry-pick 9b7c68b3911aef84afa4cbfc31bce20f10570d51
 ("netfilter: ctnetlink: Support offloaded conntrack entry deletion")
Message-ID: <ZHf9bdGWnOG4+EM+@itl-email>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="EZMipC3VuI6ixQsr"
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--EZMipC3VuI6ixQsr
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Wed, 31 May 2023 22:07:37 -0400
From: Demi Marie Obenour <demi@invisiblethingslab.com>
To: stable@vger.kernel.org
Cc: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
Subject: Please cherry-pick 9b7c68b3911aef84afa4cbfc31bce20f10570d51
 ("netfilter: ctnetlink: Support offloaded conntrack entry deletion")

Please cherry-pick 9b7c68b3911aef84afa4cbfc31bce20f10570d51
("netfilter: ctnetlink: Support offloaded conntrack entry deletion") to
all supported stable trees except for 4.14.  The lack of it makes the
flowtables feature much more difficult (if not impossible) to use in
environments where connection tracking entries must be removed to
terminate flows.  The diffstat is -8,+0 and the commit only removes
code that was not necessary to begin with.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab

--EZMipC3VuI6ixQsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdodNnxM2uiJZBxxxsoi1X/+cIsEFAmR3/WwACgkQsoi1X/+c
IsFb6g//SbWpHxzoweFPkdmH/WUWXPGwV0+XTjNURSkCAz1fztthdx16b/9Wy04e
uywfPAEtX/2E4BBwKppDUaua1Z/ammI/oeOVLDO0uxVlEoz/pKfA34NMeZX2xVtN
MmAW22ORvyfZBhQ9dOzMpXB2PT1ufpu3A9ULxV/SnUnobd6UYmE4zu6Yp5N7S4qd
9xqAl67JEkGEMTkU8iaXaPLgKNOQwI+/Xn9nNDBptPd/wJTXzFmPlIcS4FQxQaA2
uxEPtdm+QQXCxpktssW6jYZSj4lU9WdBkbEh0ItS7gLj8Wt4qAmDgczitk23BRDo
fa/lntkWZ8wJtpFiqL1Gf57D0rJIxQ4Kb+0qD+jMvyKXtyZHpFbP8C5i3jMd8flP
Ns1LTADFsuKluqxmJcqZXbTS7sG1v5rUoyrm5elwY+oC47SLBGeVyuW1IZLP4a8U
tFGbRW4xuMGRC/sMqDSBLCZQkbsZO6HYQTePhQg2JFYrzYrG1Ze6BxmMg3ywkF43
wJxAHq46xbxqt4rK4qRSps1ttVjanE/f0N+9zVNSyilOH2d/fdFNxfeUFud/bDPq
w4v60a2nJo/Y5l2xDXpXifazPBnP0pV10LLqrFSz1iafzt3/WKDr4Kg09qhCDtKW
0xWrmOwIC7mYdxeVWTIMkBs00qMnPencGBs7nKOpVjChDkbEzhw=
=Pr4v
-----END PGP SIGNATURE-----

--EZMipC3VuI6ixQsr--
