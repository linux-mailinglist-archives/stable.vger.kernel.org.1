Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6B17D7CF1
	for <lists+stable@lfdr.de>; Thu, 26 Oct 2023 08:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjJZGkN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 26 Oct 2023 02:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjJZGkN (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 26 Oct 2023 02:40:13 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688FC9C;
        Wed, 25 Oct 2023 23:40:10 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 28AA2C020; Thu, 26 Oct 2023 08:40:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698302406; bh=un9bFkKkDnEO5ds9VDjL40Q+CLVHMEVuBkDazZsoQ34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k4jkhMGWgX814U3jnpwffJXj2X+v5p0YHOHAQxebGelITeuDqw5IqEGa8rUBR2Mpp
         0XkTne/HcYL9XNAS2hoYhC4otzVmyEu8v76R633vqfaFamqrhP7dUZ/7MB7Ve0WSz3
         9yY1ZgEb1KUoR9B5+fD3IUiqOqs6dHsnGthEaIlm2uzcbMMul6Ot+3oE44TL7L3h/8
         TubYmBI9hL0tl4OlQuobvruqEFg8rRX2oR5txGDnZ8WqnQqbt/bTX74WIJavIsX75R
         vVRF72J4mRD5D2rTbPi0Wf5CY2E0yW+8RdmNPM+R4TqAcMI1tmAgB/Y6uz/q5mXEus
         QVo89dZHm499A==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id E56AAC01C;
        Thu, 26 Oct 2023 08:40:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698302405; bh=un9bFkKkDnEO5ds9VDjL40Q+CLVHMEVuBkDazZsoQ34=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEurB/ZUuAxvpeq6jFETqHITBC+GX+LBkmynBB1kdBuRaA+LPKUmWXwmJyDFrK0WJ
         Gh83MQuOKSuow2SDeakgleSaODXphx3ngRZAvmdr8tLU3VDMKHw7/PBsux2A0gA1N0
         snLOxIGEPXGacgW8EePhKTY08LfkPwccTUN9u5fXpC+4Lfvd+uzF9NIV43xbDuabbj
         Ab4BrcEjyOw71IjbUjNdfTFMioE39yRUBSnGURYuYSCXejUW3l3EQIENat90EqQLdA
         5S0V38yFDBhqwPKAvBvlZlEq75DGLbGVrdphRJWWArAKBn5PcYAj5cIuaZIa7ccoUo
         YTi/0ncKhe7iQ==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id b554c8bf;
        Thu, 26 Oct 2023 06:40:00 +0000 (UTC)
Date:   Thu, 26 Oct 2023 15:39:45 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Avri Altman <avri.altman@wdc.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org,
        Alex Fetters <Alex.Fetters@garmin.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mmc: Capture correct oemid
Message-ID: <ZToJsSLHr8RnuTHz@codewreck.org>
References: <20230927071500.1791882-1-avri.altman@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230927071500.1791882-1-avri.altman@wdc.com>
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[note this has been applied to all -stable branches as well -- sorry for
noticing this after explicitly testing the 5.10.199-rc1...]

Avri Altman wrote on Wed, Sep 27, 2023 at 10:15:00AM +0300:
> It is important to fix it because we are using it as one of our quirk's
> token, as well as other tools, e.g. the LVFS
> (https://github.com/fwupd/fwupd/)

On the other hand there are many quirks in drivers/mmc/core/quirks.h
that relied on the value being a short -- I noticed because our MMC
started to show some hangs that were worked around in a quirk that is
apparently no longer applied.

Unfortunately almost none of these are using defines so it's stray 0x100
0x5048 0x200 .. in MMC_FIXUP (3rd arg is oemid), so it'll be difficult
to fix -- especially as embedded downstreams often add their own quirks
and you can't fix that for them.

I'd suggest something like this instead:
-------
diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 1e14cc69e0ab..892a5bba36ec 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -189,7 +189,7 @@ static inline void mmc_fixup_device(struct mmc_card *card,
 		if ((f->manfid == CID_MANFID_ANY ||
 		     f->manfid == card->cid.manfid) &&
 		    (f->oemid == CID_OEMID_ANY ||
-		     f->oemid == card->cid.oemid) &&
+		     (f->oemid & 0xff) == (card->cid.oemid & 0xff)) &&
 		    (f->name == CID_NAME_ANY ||
 		     !strncmp(f->name, card->cid.prod_name,
 			      sizeof(card->cid.prod_name))) &&
-------
(whether to mask cid.oemid or not is up for debate, but that leaves less
room for error)

I'm testing this right now for our board, will submit as a proper patch
later today if it works -- but feel free to comment first.
Missing quirks on certain sd/mmc can cause some trouble so might want to
revert this patch on stable kernels unless there's immediate agreement
on this patch

Thanks,
-- 
Dominique Martinet | Asmadeus
