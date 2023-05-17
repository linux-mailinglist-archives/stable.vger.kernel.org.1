Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB647068BB
	for <lists+stable@lfdr.de>; Wed, 17 May 2023 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjEQM4i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 17 May 2023 08:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjEQM4f (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 17 May 2023 08:56:35 -0400
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [95.217.213.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7747A35A4
        for <stable@vger.kernel.org>; Wed, 17 May 2023 05:56:33 -0700 (PDT)
Received: from [213.219.167.32] (helo=deadeye)
        by maynard with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1pzGhj-0006ek-3f; Wed, 17 May 2023 14:56:31 +0200
Received: from ben by deadeye with local (Exim 4.96)
        (envelope-from <ben@decadent.org.uk>)
        id 1pzGhi-00Ars2-2v;
        Wed, 17 May 2023 14:56:30 +0200
Message-ID: <80d3ba7a1b8b7d65713f66ca3562a5ec4971c5ee.camel@decadent.org.uk>
Subject: Re: [PATCH 5.10 076/529] crypto: ccp: Use the stack for small SEV
 command buffers
From:   Ben Hutchings <ben@decadent.org.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sasha Levin <sashal@kernel.org>,
        Julien Cristau <jcristau@debian.org>
Date:   Wed, 17 May 2023 14:56:21 +0200
In-Reply-To: <20230310133808.495306749@linuxfoundation.org>
References: <20230310133804.978589368@linuxfoundation.org>
         <20230310133808.495306749@linuxfoundation.org>
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-zgyW4vL2SFqadL66P0cX"
User-Agent: Evolution 3.46.4-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 213.219.167.32
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--=-zgyW4vL2SFqadL66P0cX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2023-03-10 at 14:33 +0100, Greg Kroah-Hartman wrote:
> From: Sean Christopherson <seanjc@google.com>
>=20
> [ Upstream commit e4a9af799e5539b0feb99571f0aaed5a3c81dc5a ]
>=20
> For commands with small input/output buffers, use the local stack to
> "allocate" the structures used to communicate with the PSP.   Now that
> __sev_do_cmd_locked() gracefully handles vmalloc'd buffers, there's no
> reason to avoid using the stack, e.g. CONFIG_VMAP_STACK=3Dy will just wor=
k.
[...]

Julien Cristau reported a regression in ccp - the
WARN_ON_ONCE(!virt_addr_valid(data)) is now being triggered.  I believe
this was introduced by the above commit, which depends on:

commit 8347b99473a313be6549a5b940bc3c56a71be81c
Author: Sean Christopherson <seanjc@google.com>
Date:   Tue Apr 6 15:49:48 2021 -0700
=20
    crypto: ccp: Play nice with vmalloc'd memory for SEV command structs

Ben.

--=20
Ben Hutchings
The two most common things in the universe are hydrogen and stupidity.

--=-zgyW4vL2SFqadL66P0cX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmRkzvUACgkQ57/I7JWG
EQkkMg//RUl7/6vp8OIA+Wt8Ty2kxl4iA7gXe1a+FN3lFH2dKSzfHJN38yIRWYO4
kCjk8askHFe86TJNGNTez2NQJxbzTUEOLxiOD4BBUhGuP1W3ZcszIP3/oMushw+9
9kFCx8+5WA5Nhf7QVg3K229sE8hoBCI/rc89evfw4K/xSpgwXr29IUfLCvTI8N1h
LZe5uuZ8th4y8nziupev/QWsiJ1nVgOHSquWDRUT9GVBcNv4XinELRjd4d1ez/ln
jCWcXv9QXZTMu1NqYiGer2lhXcvJ1cDCd/sQgidYqZPMHOVNndO5rlxML4RRbJvs
3yN72WtRd0D3r0RBbQOI/aZR7Z/UxoxJ1Omted78gGB5xdyYgJitg6VwNFg9TGc/
YGtHARF5SGdLRaahIcaMlRnZPmQrqur87Gv0ZRFfaP4Y/VOwknxARatnJZMYUoXI
eZfHYKCX2I/+obRRdWLbaEQhmjcYxrsvpIUoMoQ3xIiaQfO84haJrQC82ZfKm618
dfPXp4m0i4UuWVuczB+WgX9Axgx2aAuV8FEXsITQs0lylpyNw9WvR4Wunv/V8NJQ
3f806X2e/aHLtDdplWqytVAe+I226UmelrGWGC/cPjsgBs7pL57HcqWaWvpliuO5
d2hx7kzmSFCK1f1jWQ/mk09srmb232s0mwFlByThaAsTdK2f3Xg=
=qllS
-----END PGP SIGNATURE-----

--=-zgyW4vL2SFqadL66P0cX--
