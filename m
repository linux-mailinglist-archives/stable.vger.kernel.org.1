Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC12A70CA88
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 22:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjEVUN4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 16:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjEVUNq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 16:13:46 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C4CCA
        for <stable@vger.kernel.org>; Mon, 22 May 2023 13:13:44 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 6845F5C0178;
        Mon, 22 May 2023 16:13:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 22 May 2023 16:13:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1684786423; x=1684872823; bh=DP
        P132aPxNM0A6MmttmKLNiatsnl/V6ZqeKAqLjm0d0=; b=yUfycxNChc1fjyK/bT
        K9GKq0PMJhJBPvBbJvjFDiLRIi25+34IvSIUYvjZzB7hP5MPq97JJznEduCWQhxa
        gbr+wSOBYdBvKXrLlZwC9UFQz23gkK9d18OT5vHTb+UP+p9RhO/VFIYCTIXOvR88
        KNi02mN1C2K7+O8WOpwt/a9Irf4jehZDk2dl9ycF3HnIXqInQv7M6AvkeixStT2z
        pk9DpQYhUyZXCT9hW+sVm5IzVGec1URRcsteF6RPG78T5j+stafFPPW1pWyIegWx
        melyxtQMScyfgRTBRIpTLiVqyOCFkKTioBn7P1oLVjAZsOwxbKcPMU+PMWPL+F2h
        4Yfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1684786423; x=1684872823; bh=DPP132aPxNM0A
        6MmttmKLNiatsnl/V6ZqeKAqLjm0d0=; b=syEuL3JlxiyfjQ911jPVfziOnkAok
        sqJe2DHRybaSbFOiWd+rx7TDFCkzQyayr7pn49DzGbQf7zunedUdsthyik+2iBwU
        jYp0O8tqh3XQeIoHKuY79hQsCXisBXLzuQTMUOL0wj+WYf14Qzqt41b2FpWnSTFJ
        nzEmqQjjFB7unKp8SlktWMB8xKA6sYIq030y04NVZQQdCmn+l2zr21WDBvTDmRhm
        0uKFAMg0fnlh/NCMQqvD92JwmNVXJ8NNLzybf3PLt2RQQ5fviB4hyh+2z9KYWamb
        20JNytAkcGvcDpSEb+aEiZu16AZDwXuMwaQ9Znts3Xte0TEtkFQIcAZ6g==
X-ME-Sender: <xms:9sxrZErE6pot3sofSjtTeu3jrU3mYmpMvFmbWC9NPcYr4ZZjh5sb4g>
    <xme:9sxrZKorfkoPazFwQ509OmE2yKb_SZVQpq2u2ZxXvPbl67OfSdSV5lVBFDfwwgav8
    pDMY_lSFUyFGSb-tw>
X-ME-Received: <xmr:9sxrZJOrC7f5pBA0X6UOSpbQMJP8mJsxgRM_dqqjyhVjN318mGgD9pYdH07vIUtoFpCSppuFigJ7RGkJq48wufiea6Qfw3knyQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddgudeffecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufgjfhffkfggtgesghdtreertddttdenucfhrhhomheptehlhihs
    shgrucftohhsshcuoehhihesrghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepie
    duffeuieelgfetgfdttddtkeekheekgfehkedufeevteegfeeiffetvdetueevnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisegrlhihsh
    hsrgdrihhs
X-ME-Proxy: <xmx:9sxrZL6LhVZn3fBGv6o321uyfqEBQK2mmO85TCsX6w9Rv__hq453Gg>
    <xmx:9sxrZD741KUVTbTuzZ55EJPjFZX2ttTBzxs58jGDial8u92GB8nnKg>
    <xmx:9sxrZLgCxBA4enhR5AnmBjombhxm0IZxHs6rqBPXwRkrr9_dvbfuqg>
    <xmx:98xrZGb00WF_8wh1rBG_dLOxheFeCqhoaS6uL5fXFqq7PhZJU7jcgg>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 16:13:42 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id C07804F6D; Mon, 22 May 2023 20:13:40 +0000 (UTC)
From:   Alyssa Ross <hi@alyssa.is>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Peng Zhang <zhangpeng.00@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Robert Hensing <robert@hercules-ci.com>
Subject: Re: Backport request: [PATCH] maple_tree: make maple state reusable
 after mas_empty_area()
In-Reply-To: <2023052230-unleaded-attention-bfff@gregkh>
References: <20230522192934.kz5gp7rp2jeycaqj@x220>
 <2023052230-unleaded-attention-bfff@gregkh>
Date:   Mon, 22 May 2023 20:12:38 +0000
Message-ID: <87wn10ruq1.fsf@alyssa.is>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Greg KH <gregkh@linuxfoundation.org> writes:

> On Mon, May 22, 2023 at 07:29:34PM +0000, Alyssa Ross wrote:
>> Hi, please backport commit 0257d9908d38c0b1669af4bb1bc4dbca1f273fe6 to
>> 6.1.y onwards.  This patch fixes a regression which broke some programs,
>> like GHC (the Haskell compiler).  We've been shipping this patch in
>> NixOS unstable for the last couple of weeks, to positive results.
>>=20
>> (The patch had "Cc: <stable@vger.kernel.org>" but from what I can tell
>> has not been selected for backporting.  Apologies if I've just missed
>> it.)
>
> You just missed it, it's queued up for the next stable releases.

Ah, I think I must have asked between the emails being sent out and them
showing up on lore, since they were only sent just 20 mins before I
asked.  Sorry for the noise.  I'll know to check the queue directly next
time.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmRrzLYACgkQ+dvtSFmy
ccByOw/+PGGNvOb87gvIYohAk9Koyng5y6gdMQgaTx51SgVWngCN1dLX/iXMwkk3
PUV350+nOHqQG8uVSK4aVyQS4ztDhjzKSJ2q4BpT4erVWh6Hwi4DNyDhp+dV8KSg
TtIZUieoidDtpdyuy5oR29h7bCKhpFEzHtVqas7OWKCqwMLONUxHVP/1SRkssoE9
ES7BuvY/4KoL0PJmsy+gu7XQZ4/pmI60y7hm0kyRkSjBTwaYpvzm5MtX8QVjRBvg
O24cIFyFacaEkpmTIDTvCMOAiBsd/gn9crLwnmiY99vuwELpEL5n6PPJUfLU4LFV
AWij79dK9kKS2cCrxP8gLGsGWDfLHcyrdWcVLNBIPImEvh56+6AUl2O/6Sj1fyRY
WoWDugb5hZKAxlB9DOIaUixN6ong0+dGDALtGD5kHJwxRqIRPXItTZjbaTG7dbw8
N23g62IFdNwHJ2A5G4efi9KCUqW2sFwsUL52cA4H5vVEa+MBuYnayouX7nYRG8kb
R+MXcFb31KXfmUNkHvyBDfg+uAkRE/zvS6skB7aN1Lgk9pE2p8ilOUUmrHiTIgZO
/kLSt/YmqtUPZ1rZC9He097uy9tLp1S3QUShfX/ATRIqN4p/OL8PQTX3Z0Oo/sBx
n/W0dyDmD3TSV/QR1kb/AdlgeJ2Dm5+SG4+evPfJxcgJat026H4=
=8oIb
-----END PGP SIGNATURE-----
--=-=-=--
