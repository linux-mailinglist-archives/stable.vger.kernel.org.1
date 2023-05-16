Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CC5704C7C
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 13:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjEPLkA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 07:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbjEPLjw (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 07:39:52 -0400
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 May 2023 04:39:51 PDT
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D12A2D4C
        for <stable@vger.kernel.org>; Tue, 16 May 2023 04:39:51 -0700 (PDT)
Date:   Tue, 16 May 2023 13:29:42 +0200
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        David Hildenbrand <david@redhat.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 6.3 224/246] parisc: Fix encoding of swp_entry due to
 added SWP_EXCLUSIVE flag
Message-ID: <1684236494@msgid.manchmal.in-ulm.de>
References: <20230515161722.610123835@linuxfoundation.org>
 <20230515161729.309596490@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="P15Zl2i1L+IUdXCm"
Content-Disposition: inline
In-Reply-To: <20230515161729.309596490@linuxfoundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--P15Zl2i1L+IUdXCm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Greg Kroah-Hartman wrote...

> commit 6f9e98849edaa8aefc4030ff3500e41556e83ff7 upstream.
>=20
> Fix the __swp_offset() and __swp_entry() macros due to commit 6d239fc78c0b
> ("parisc/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE") which introduced the
> SWP_EXCLUSIVE flag by reusing the _PAGE_ACCESSED flag.

Sucessfully re-tested for 6.3.3-rc1.

For the better-safe-than-sorry department,

    Christoph


--P15Zl2i1L+IUdXCm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEWXMI+726A12MfJXdxCxY61kUkv0FAmRjaSMACgkQxCxY61kU
kv213BAA0vcpmLNjIBEXOXZlhsDTRuEaofITrERmG5ypLQ2fClisx5uicJ1ePm/T
DO8L2sMNw7SCABNjme6VnCoaLFdmozxtpDxmgKAOI//75glNlrSuzRwp0z0RNWde
DWoGC/6MQkZOIlk704LGnTRPVK+UCxbV+R0zxZpWKiwyelBd3kmOBAkasyJFC2Dw
/cuQnD0LnCQKNDXY0oqHPCpOAWO36HNOzfwMhZToHWmE7iLpfQKjOhDvYJuV6lIr
5GRSKD5D2WKrAgIpFJY6byjI5xkNANK72lLHhoyMV6wX6dsd4vNAt9lUhHq0xftO
7XkIBy4Xrf8BLF50f8hWuqQ68Oz6VaSnfXmo09dDy9vjQ3jybMtjmLmEMz0R5N8G
TpaEVjPyEIFIauferuy5TnMrlcg6EupOyIKBPAhuK3X6GTw1/Y4M34oICnNfs2QQ
zZ5qTUhae2HEVDcDvGN4FESqywByhUI8y+9WPcvg6nuBccuwU154ClpNGuJ8D9Oj
DGj5V3G7DzWV3u/CU+zN6GGoINzVNc6PnGqKzJVyWXWpmtYxlSZRweOXPg5WeaRD
gFxA4KtqLiSgjaoJuVGbfqS7DXT8jKH2DbulkKttzhk+Hh92adbFMqyh6SFjCd/w
xSawA7nRMevkQ+1WJzZI6qoq5RlGhXl0AMrkyArm6jSoHsKse/Y=
=go7u
-----END PGP SIGNATURE-----

--P15Zl2i1L+IUdXCm--
