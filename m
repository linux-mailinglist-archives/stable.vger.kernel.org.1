Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C857701F5
	for <lists+stable@lfdr.de>; Fri,  4 Aug 2023 15:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjHDNiq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 4 Aug 2023 09:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjHDNio (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 4 Aug 2023 09:38:44 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B55719A4
        for <stable@vger.kernel.org>; Fri,  4 Aug 2023 06:38:22 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5C0801C0003;
        Fri,  4 Aug 2023 13:38:11 +0000 (UTC)
From:   Diederik de Haas <didi.debian@cknow.org>
To:     Karol Herbst <kherbst@redhat.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Olaf Skibbe <news@kravcenko.com>
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        1042753@bugs.debian.org, Ben Skeggs <bskeggs@redhat.com>,
        Lyude Paul <lyude@redhat.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bug#1042753: nouveau bug in linux/6.1.38-2
Date:   Fri, 04 Aug 2023 15:38:03 +0200
Message-ID: <1861943.tdWV9SEqCh@bagend>
Organization: Connecting Knowledge
In-Reply-To: <b12e2b00-de18-df9c-eb4a-c6704aad2c97@kravcenko.com>
References: <20be6650-5db3-b72a-a7a8-5e817113cff5@kravcenko.com>
 <169080024768.2498.7944943374763908742.reportbug@oma-1>
 <b12e2b00-de18-df9c-eb4a-c6704aad2c97@kravcenko.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2154434.irdbgypaU6";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-GND-Sasl: didi.debian@cknow.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--nextPart2154434.irdbgypaU6
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
Subject: Re: Bug#1042753: nouveau bug in linux/6.1.38-2
Date: Fri, 04 Aug 2023 15:38:03 +0200
Message-ID: <1861943.tdWV9SEqCh@bagend>
Organization: Connecting Knowledge
In-Reply-To: <b12e2b00-de18-df9c-eb4a-c6704aad2c97@kravcenko.com>
MIME-Version: 1.0

On Friday, 4 August 2023 15:11:46 CEST Olaf Skibbe wrote:
> (On the occasion a maybe silly question: am I right assuming that the
> kernel has to be build on the machine we want to reproduce the bug on?
> Otherwise it could use much faster hardware (running also bookworm).)

If that is also an amd64 machine running Debian kernel 6.1.38-2, it should be 
fine to build the kernel on the faster machine.
--nextPart2154434.irdbgypaU6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZMz/OwAKCRDXblvOeH7b
bt4nAQDPFpmbSLHFD7getdYcWSuA7EjAC7ABRIrg2d1k235hpAEA9blNXwSDoplZ
dNmsvFiDM+/jBGYJnl/qIlH6lCd3Hw8=
=Re8d
-----END PGP SIGNATURE-----

--nextPart2154434.irdbgypaU6--



