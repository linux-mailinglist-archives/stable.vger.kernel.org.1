Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBCD6F240F
	for <lists+stable@lfdr.de>; Sat, 29 Apr 2023 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjD2J4j (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 29 Apr 2023 05:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjD2J4h (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 29 Apr 2023 05:56:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7B61998
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 02:56:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 152A460ADF
        for <stable@vger.kernel.org>; Sat, 29 Apr 2023 09:56:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2CC433D2;
        Sat, 29 Apr 2023 09:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682762195;
        bh=FLYcUPnflzwXEpC8eJVpjsF5FPlo9/Zof5v/HyqTeSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V5MJ0xfGEimD14Kr3oL7f3duw4O8YHaX3HsZR0xoWxMW25mSvLQbTCR7cNFBpqZFW
         thdevmhWAXqcmqmECnc8LgDvFYIjI4KCB8ZNhtR6n//K9dM5197LMjhkyY9IaQNPSw
         LnByJC4FeYhobU909NJYitob0x/b9jzX1aRel/vJnte3ERx640VjsyyoZLhVHjbKf1
         TisYbgnOPk/2+4/kCwVN2Upgr12jVdq0WmpYDO5AJ37KE6C0uE2yUjM3eAP7kyPaGh
         LjL1fOqJD41sM3RI1v7xy7gBbfYyCrUkTDKN1jHcnjvZPfbpQrW5pJNI6sTOzvLpV/
         tSALQb9ecr9IA==
Date:   Sat, 29 Apr 2023 10:56:32 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Alexandre Ghiti <alexghiti@rivosinc.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 6.2.11 v2 0/3] Fixes for dtb mapping
Message-ID: <20230429-designing-unpleased-63a3a3e59aa3@spud>
References: <20230428103745.16979-1-alexghiti@rivosinc.com>
 <2023042822-pushpin-coil-b0bc@gregkh>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Sn+Hq/CT7h2nUjo3"
Content-Disposition: inline
In-Reply-To: <2023042822-pushpin-coil-b0bc@gregkh>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--Sn+Hq/CT7h2nUjo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2023 at 01:15:35PM +0200, Greg KH wrote:
> On Fri, Apr 28, 2023 at 12:37:42PM +0200, Alexandre Ghiti wrote:
> > We used to map the dtb differently between early_pg_dir and
> > swapper_pg_dir which caused issues when we referenced addresses from
> > the early mapping with swapper_pg_dir (reserved_mem): move the dtb mapp=
ing
> > to the fixmap region in patch 1, which allows to simplify dtb handling =
in
> > patch 2.
> >=20
> > base-commit-tag: v6.2.11
>=20
> Thanks for redoing all of these, now queued up!

Aye, thanks for both that & for doing the fixmap stuff in the first
place Alex :)

Cheers,
Conor.

--Sn+Hq/CT7h2nUjo3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEzpzwAKCRB4tDGHoIJi
0n8xAP9PEL8/eV3sTiZKB5OiJBLQ7QKMeUJdr2k6lUViAGLt7QEAs0RnZ4j1HEho
ixtTNB0I0rbt2Kl9LypSP6Du6EjhngI=
=CA/G
-----END PGP SIGNATURE-----

--Sn+Hq/CT7h2nUjo3--
