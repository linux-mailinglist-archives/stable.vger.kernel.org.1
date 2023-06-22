Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4937773AD52
	for <lists+stable@lfdr.de>; Fri, 23 Jun 2023 01:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbjFVXqw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 22 Jun 2023 19:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjFVXqv (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Jun 2023 19:46:51 -0400
Received: from smtp116.iad3a.emailsrvr.com (smtp116.iad3a.emailsrvr.com [173.203.187.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D2E2
        for <stable@vger.kernel.org>; Thu, 22 Jun 2023 16:46:50 -0700 (PDT)
X-Auth-ID: kenneth@whitecape.org
Received: by smtp39.relay.iad3a.emailsrvr.com (Authenticated sender: kenneth-AT-whitecape.org) with ESMTPSA id 2E14E3FA4;
        Thu, 22 Jun 2023 19:38:01 -0400 (EDT)
From:   Kenneth Graunke <kenneth@whitecape.org>
To:     intel-gfx@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Cc:     dri-devel@lists.freedesktop.org,
        Matt Roper <matthew.d.roper@intel.com>, stable@vger.kernel.org,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: Re: [PATCH 1/3] drm/i915/gt: Move wal_get_fw_for_rmw()
Date:   Thu, 22 Jun 2023 16:37:59 -0700
Message-ID: <24458277.F5hiQvuxAt@mizzik>
In-Reply-To: <20230622182731.3765039-1-lucas.demarchi@intel.com>
References: <20230622182731.3765039-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3654635.B3pjK0ouWD";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Classification-ID: a2f77604-44eb-471c-83ac-7c871bfb7d70-1-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

--nextPart3654635.B3pjK0ouWD
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Kenneth Graunke <kenneth@whitecape.org>
Subject: Re: [PATCH 1/3] drm/i915/gt: Move wal_get_fw_for_rmw()
Date: Thu, 22 Jun 2023 16:37:59 -0700
Message-ID: <24458277.F5hiQvuxAt@mizzik>
In-Reply-To: <20230622182731.3765039-1-lucas.demarchi@intel.com>
References: <20230622182731.3765039-1-lucas.demarchi@intel.com>
MIME-Version: 1.0

On Thursday, June 22, 2023 11:27:29 AM PDT Lucas De Marchi wrote:
> Move helper function to get all the forcewakes required by the wa list
> to the top, so it can be re-used by other functions.
> 
> Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
> ---
>  drivers/gpu/drm/i915/gt/intel_workarounds.c | 32 ++++++++++-----------
>  1 file changed, 16 insertions(+), 16 deletions(-)

Patches 1 and 3 are:

Reviewed-by: Kenneth Graunke <kenneth@whitecape.org>

--nextPart3654635.B3pjK0ouWD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE6OtbNAgc4e6ibv4ZW1vaBx1JzDgFAmSU21cACgkQW1vaBx1J
zDjnFA//U/nDOsrzgqZo+472pK9esanusHc+zttV6T+Hiu2ArNKir9nikv5vlAq/
PdK5ttI+n+rpT749bXaTEu00LIRkQvCd7hypf3ZPkdYuKpQNbbi8Ul+mWz9pWXrF
DBQkRfB4t2Y0+BBuvMcFzJGPT5+a1wa/L+kNacBMSnZueD5AzwRr99cNofd7ZJAX
OhMCIidq8f4m25GFRSO7U+/APAbZC2qzt+GMutwT4rbpW7fogMs48SmX5xy0xOUb
DVq807pf4l4JKFdFJBeDPsskof232pGzvogLQ4ejMRsRmdgMbV7J3hWTk2GUlSL0
SIgmc0SH42zDKx5T7uPnE5YrDCe8ot2BaDKYJEtuIn9OW7sKy9emZpNuXu5SqW5+
bxvaWr4ft4JLUxxuefA5/z2AwtnwrZUzKVGM+Jsu8I9Hj4NBVhFqqsqK9mfQVt1U
CHTyk3EQex4RgYx5p38cmA0ZdiIjfZx7GEg0HQ1jhe3eASvNxTPeJjEo6KnIwvKn
ecSOhHFhJoya85EoplM+5DVzoFz5LHXzToBUCrfNctHbVamCFKTuiiye3C0G8yAf
bYc55CcCaoPq0rOK4CRd2//KFO1+CDX9YdMO7IdObjwkAwqdbIoqOcKU/j2pjZ3f
gMO0PYrF7yP1yttFngKyy4UezfF/36aYHoR+FVMsbnOBWNO4LFY=
=kvk+
-----END PGP SIGNATURE-----

--nextPart3654635.B3pjK0ouWD--



