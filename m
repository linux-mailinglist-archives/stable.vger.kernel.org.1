Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659E57DD0C3
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 16:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345103AbjJaPm2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 11:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345107AbjJaPm1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 11:42:27 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19A8E4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 08:42:24 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 5976A32009DC;
        Tue, 31 Oct 2023 11:42:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 31 Oct 2023 11:42:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1698766942; x=1698853342; bh=mb0gYnV0H7yJxOK1w9f/YAAaMqkDuUMTlzo
        Ud82abGI=; b=BeyyQ7BaR/RTfnF3twpmruJUylTd2KwhIKx23X70HU3YCqspbzF
        X6EO2K57TKbc7Mn25vORN7XhERC2lI7nOmpJKMeEwz5n0wjbPBMLg3s4PnwuS4oE
        GNX43jlbcIMsVCwylSZtStBr05IYD1KDNN/cBYAszZF+iu3wYfKg/MS56zhIo3Wr
        Euf10bzZMJDP0WiPo3/pj8+EfLhb5WZV+5xwHz990+Fa3hqO/KHp/v+K1vPRIB3d
        PUIdXssOculZP1Xy52e6gRm775dRaeVuY0ID9JkfePdqqEp4Cd7W80TXWX3J4/45
        sY2g6fjxWQ0dgzqObJfz1KNUT7Ip0KBM/9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1698766942; x=1698853342; bh=mb0gYnV0H7yJx
        OK1w9f/YAAaMqkDuUMTlzoUd82abGI=; b=nYOyPpfjVRmq9pCxHWrqyTLGx9rpA
        GnCHemUTpulOxIjaEqeBtLvLo2+PPa50Bc+14ETaISQyFnIvTHmtVb3J7Ac2kfnq
        +y4WewQfvMPiob7Bg1j1UTc6fO/DyO1wdA8NFZ10J8omUVproUWww+gHZDgSjEFI
        YnqRJ8NF8uIWG+r15Lmq4wBaTnIIn9QLpJbfJIG+J6s3QNPoSnbkR0SKWVXze0xG
        57itohLuUUuo6/nadLbx5t8gn57YUf+ODQbzpCoKCgPiT8lzMcUNHAAS3hYISYxU
        VrZC3ut/SmXRrwB+ZRTDBqtpVeULJ+nk2KrVjIOLi3Ts4gXuoSSpj/7YQ==
X-ME-Sender: <xms:XiBBZdMJNFaSuy5Lwwo1xH09ezt6TWxLho3FYHFjTMLV8l6ddoZ24g>
    <xme:XiBBZf_cdcVd2m25pH1A9aMneVUeX-Z-fy2Gte_aU_1oRAuoPQXeMUtXHF_z5iG8M
    fa-1QuXLVzA9A>
X-ME-Received: <xmr:XiBBZcSKMMylrp4MuGKAp7KoycjircffxkYn7OZlYnhBD5pjItLIEnS-BQKp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtvddgjeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtjeenucfhrhhomhepofgrrhgv
    khcuofgrrhgtiiihkhhofihskhhiqdfikphrvggtkhhiuceomhgrrhhmrghrvghksehinh
    hvihhsihgslhgvthhhihhnghhslhgrsgdrtghomheqnecuggftrfgrthhtvghrnhepgfdu
    leetfeevhfefheeiteeliefhjefhleduveetteekveettddvgeeuteefjedunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgrrhhmrghrvghk
    sehinhhvihhsihgslhgvthhhihhnghhslhgrsgdrtghomh
X-ME-Proxy: <xmx:XiBBZZuZ6raSlIE2RbAev_Rd7bZerJYavYYIZwVC1fS6DP1uGgs25w>
    <xmx:XiBBZVdtDOki9nEDoNl9sbkJsth3Ee99o383WXOFNwlVoSfx4AbvKw>
    <xmx:XiBBZV1UoSO1HCwau2Bcj1beU1Li5PbYqwAYMsUT2KYpOFZn20RjvQ>
    <xmx:XiBBZR5XFR6o0Cj40Z1Fpn0igWzSrYolxPyDCbjSo2ik6Wio1Q1Fxw>
Feedback-ID: i1568416f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Oct 2023 11:42:19 -0400 (EDT)
Date:   Tue, 31 Oct 2023 16:42:15 +0100
From:   Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
        regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5
Message-ID: <ZUEgWA5P8MFbyeBN@mail-itl>
References: <3514c87f-c87f-f91f-ca90-1616428f6317@redhat.com>
 <1a47fa28-3968-51df-5b0b-a19c675cc289@suse.cz>
 <20231030122513.6gds75hxd65gu747@quack3>
 <ZT+wDLwCBRB1O+vB@mail-itl>
 <a2a8dbf6-d22e-65d0-6fab-b9cdf9ec3320@redhat.com>
 <20231030155603.k3kejytq2e4vnp7z@quack3>
 <ZT/e/EaBIkJEgevQ@mail-itl>
 <98aefaa9-1ac-a0e4-fb9a-89ded456750@redhat.com>
 <ZUB5HFeK3eHeI8UH@mail-itl>
 <20231031140136.25bio5wajc5pmdtl@quack3>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="T+T3sop+0bQ1u8dt"
Content-Disposition: inline
In-Reply-To: <20231031140136.25bio5wajc5pmdtl@quack3>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--T+T3sop+0bQ1u8dt
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Date: Tue, 31 Oct 2023 16:42:15 +0100
From: Marek =?utf-8?Q?Marczykowski-G=C3=B3recki?= <marmarek@invisiblethingslab.com>
To: Jan Kara <jack@suse.cz>
Cc: Mikulas Patocka <mpatocka@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org,
	regressions@lists.linux.dev, Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
	linux-mm@kvack.org
Subject: Re: Intermittent storage (dm-crypt?) freeze - regression 6.4->6.5

On Tue, Oct 31, 2023 at 03:01:36PM +0100, Jan Kara wrote:
> On Tue 31-10-23 04:48:44, Marek Marczykowski-G=C3=B3recki wrote:
> > Then tried:
> >  - PAGE_ALLOC_COSTLY_ORDER=3D4, order=3D4 - cannot reproduce,
> >  - PAGE_ALLOC_COSTLY_ORDER=3D4, order=3D5 - cannot reproduce,
> >  - PAGE_ALLOC_COSTLY_ORDER=3D4, order=3D6 - freeze rather quickly
> >=20
> > I've retried the PAGE_ALLOC_COSTLY_ORDER=3D4,order=3D5 case several tim=
es
> > and I can't reproduce the issue there. I'm confused...
>=20
> And this kind of confirms that allocations > PAGE_ALLOC_COSTLY_ORDER
> causing hangs is most likely just a coincidence. Rather something either =
in
> the block layer or in the storage driver has problems with handling bios
> with sufficiently high order pages attached. This is going to be a bit
> painful to debug I'm afraid. How long does it take for you trigger the
> hang? I'm asking to get rough estimate how heavy tracing we can afford so
> that we don't overwhelm the system...

Sometimes it freezes just after logging in, but in worst case it takes
me about 10min of more or less `tar xz` + `dd`.

--=20
Best Regards,
Marek Marczykowski-G=C3=B3recki
Invisible Things Lab

--T+T3sop+0bQ1u8dt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhrpukzGPukRmQqkK24/THMrX1ywFAmVBIFgACgkQ24/THMrX
1yxXiwf/STqQWBIoStONLIYTVENKHHERIECrbOJ3yP9Go8RfO3rJ23Ex6CAj0jvm
eoItbb+4wfzvg6Cko+yvRa1jlK1Bau9YT17OhaJydq3WIbfUbxlMq8Rj8q43jKak
PMzvgY2aHJ+P33UbnAweZTH9zVE2hOBi1WDs4tLpHXSqaiRxtRTLxkhEOR3+ESDz
HJNb3lNtD6/8H6fIDdElrizvvpDmbbLoA2ulPJGzBHTz9gt55taD22b9GChRE9Bv
pYSyINW8cN1jQzYG/eLtcJGrBpeI0F8LrlCfBnK3A9/QiV8NLBJmT2h+WEjv7Azp
bUEnlyfGpodVuj6V5NGcWtAAkl6R2Q==
=krBC
-----END PGP SIGNATURE-----

--T+T3sop+0bQ1u8dt--
