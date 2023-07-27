Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B3F764254
	for <lists+stable@lfdr.de>; Thu, 27 Jul 2023 01:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjGZXGc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 26 Jul 2023 19:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjGZXGb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 26 Jul 2023 19:06:31 -0400
Received: from abi149hd125.arn1.oracleemaildelivery.com (abi149hd125.arn1.oracleemaildelivery.com [129.149.84.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956661737
        for <stable@vger.kernel.org>; Wed, 26 Jul 2023 16:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=adeXy24LwyLPD7w2tMgIdpcV0wWeY6swswqHtjOUS1E=;
 b=QFBjjb+nrYTVxk07MnTP8AI9i6bAkdHx4YupESzDL6HfH3AGXHp+/gg2W1FVXl2v8FAwwpJkCdvJ
   UqKJYJng8jCsZkOMkNuAmSA28eqzzOiCMkgGB7g1/Sby7XpMUNGhyWMGA3gvyjP3K3VeHf/fr3DU
   q0aRsxBS0i1/VUX55LC8UVb5CWIN2lEymChi0KkGcRCjI8AO1tUJgcj1jJ+tvmaGOQoRdzq984wg
   s7etIboh49c1AJglAvsX25smStTnHnKqnqEAFfwbXyinoo0j6wOjDwpxw3tciC06wNi7E1r2Hpm1
   OkiN3/RSag0nnQcdM3t+4JmksI99Zj9cnn10jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=adeXy24LwyLPD7w2tMgIdpcV0wWeY6swswqHtjOUS1E=;
 b=Yahznc3qgH06ZEqH69Ka73YVus52i6LkjQNaGiAVz7shcyqTXVO4p++c5/3Cx5527Bxmb8Ot+vpT
   Bbctjxy4lxT9gMv8Zb7mYCjKSyWhsF0XmeaUpvJu9mVs86J4TVA8SRn42ljzA+j3rlNQ2Li+qvPi
   TuVSSh1Nm0Bh29XRc/JYqjqzwDDzrvJ5T2NOD9yCaeJHJace+Kc7/m5daK6Hj//AnPRQBEboh1R+
   sBxA3xmBYfT6f3fRyasVzneh7yjFupeEZL4blaDp69GnnxPvoD/O39jnzSqNsqdsAIHy2Zv/81V7
   Haoa3lKeF92dFNEAbRT/krprdtPsavx8VV9BLA==
Received: by omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYF00GX8EUS06A0@omta-ad1-fd1-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for stable@vger.kernel.org; Wed, 26 Jul 2023 23:06:28 +0000 (GMT)
Message-id: <5fbe6ee8-f907-ffec-7c6d-400aa74eaf20@augustwikerfors.se>
Date:   Thu, 27 Jul 2023 01:06:25 +0200
MIME-version: 1.0
From:   August Wikerfors <git@augustwikerfors.se>
Subject: Re: [PATCH 6.4 102/227] ACPI: resource: Remove "Zen" specific match
 and quirks
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        evilsnoo@proton.me, ruinairas1992@gmail.com, nmschulte@gmail.com,
        Mario Limonciello <mario.limonciello@amd.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sasha Levin <sashal@kernel.org>
References: <20230725104514.821564989@linuxfoundation.org>
 <20230725104518.968673115@linuxfoundation.org>
Content-language: en-US
In-reply-to: <20230725104518.968673115@linuxfoundation.org>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAHVxkMB8SvPYfOC9e8d1PrwcKCnkwiggtN+41vRCQYWzqY8j5IHfVKfMunb/qoh
 TQL5PuhsxN3XpcD4ScJvfJHk1VBxEuKwp/4w86Noyl/hyembW/uSUS3u6v6Dvqt3
 jf/WtZiPlFzIPaxonZnj9Ho0gxSxwvf3dzeYE/alF7NO3bJIqgWKUOyGJaI9mG9+
 TY93hiR1Daf1hw+ikOhaaM3xgxscNOuMbAYz1aQRy2VPA8tVOKMTk6I8rybXX88Y
 OMU3PEWb6CrzNaiPvf3d995eH6zMop+9kq6FMvrtrNV1aeiFZEhexQ7ouldPWNVd
 94izcgWDbCP5WOEfUD8wHGibjWSEPUqQK1eQa0Hszj2ZLsFjlkFMjKu/qr07GlQB
 MobU9nK1l4rUcEMiVnGQ995TKV35fu9Ef22LY4JhUBb5xhVVGFKNhxXDjf7RMnOs vy0=
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi,

On 2023-07-25 12:44, Greg Kroah-Hartman wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> [ Upstream commit a9c4a912b7dc7ff922d4b9261160c001558f9755 ]
> 
> commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on
> AMD Zen platforms") attempted to overhaul the override logic so it
> didn't apply on X86 AMD Zen systems.  This was intentional so that
> systems would prefer DSDT values instead of default MADT value for
> IRQ 1 on Ryzen 6000 systems which typically uses ActiveLow for IRQ1.
> 
> This turned out to be a bad assumption because several vendors
> add Interrupt Source Override but don't fix the DSDT. A pile of
> quirks was collecting that proved this wasn't sustaintable.
> 
> Furthermore some vendors have used ActiveHigh for IRQ1.
> To solve this problem revert the following commits:
> * commit 17bb7046e7ce ("ACPI: resource: Do IRQ override on all TongFang
> GMxRGxx")
> * commit f3cb9b740869 ("ACPI: resource: do IRQ override on Lenovo 14ALC7")
> * commit bfcdf58380b1 ("ACPI: resource: do IRQ override on LENOVO IdeaPad")
> * commit 7592b79ba4a9 ("ACPI: resource: do IRQ override on XMG Core 15")
> * commit 9946e39fe8d0 ("ACPI: resource: skip IRQ override on AMD Zen
> platforms")

Unfortunately this breaks the keyboard on Lenovo Yoga 7 14ARB7:
https://lore.kernel.org/all/596b9c4a-fb83-a8ab-3a44-6052d83fa546@augustwikerfors.se/
https://github.com/tomsom/yoga-linux/issues/47

Regards,
August Wikerfors
