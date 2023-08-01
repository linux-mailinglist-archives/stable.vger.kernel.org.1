Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4310E76AAAC
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:16:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232176AbjHAIQI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232183AbjHAIQD (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:16:03 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62614A0
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:15:59 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5F57924000B;
        Tue,  1 Aug 2023 08:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690877757;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K7/azCga1PLRKDPtjeIdqDTJmyCn1Sacaoj52+y2ms0=;
        b=d4gZo3df/8Hri7VbWCJ1UwH64pMZthK9EM2t13g381aGW7al3tN1m7VJjUV1IgJZb2kB3I
        3uXyxUhJuXuTVYmsoXGVUMeZ+cvxoGuctjPjj5s1koFztKExbjpfQphrPnaTWk5GrtlGbX
        fuPPRB9U/65DvrxI3lDgZWFPkIEzCv01Fo/Wt/X27F0ZdXMFhxsgnp8k++B3X+VDqhG3wz
        6jhj7lTdDwhhu7uFVM1fu7LTuBdz7S+KV5i+kH36+jrHtDFcBeBcR8+JwRTOL7bFqCFlI/
        Sil28i8tFefwehE4rfs/Z1GF9tvZHeeeu65riWV0w6U9oL1PpuokCrTWSgiHDw==
Date:   Tue, 1 Aug 2023 10:15:56 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ASoC: cs42l51: fix driver to properly autoload
 with automatic module loading
Message-ID: <20230801101556.21eed088@windsurf>
In-Reply-To: <2023080157-twitch-embargo-953b@gregkh>
References: <2023072301-online-accent-4365@gregkh>
        <20230727123339.675734-1-thomas.petazzoni@bootlin.com>
        <2023080157-twitch-embargo-953b@gregkh>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: thomas.petazzoni@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hello Greg,

On Tue, 1 Aug 2023 10:03:26 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Thu, Jul 27, 2023 at 02:33:39PM +0200, Thomas Petazzoni wrote:
> > In commit 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table
> > pointer"), 9 years ago, some random guy fixed the cs42l51 after it was
> > split into a core part and an I2C part to properly match based on a
> > Device Tree compatible string.
> > 
> > However, the fix in this commit is wrong: the MODULE_DEVICE_TABLE(of,
> > ....) is in the core part of the driver, not the I2C part. Therefore,
> > automatic module loading based on module.alias, based on matching with
> > the DT compatible string, loads the core part of the driver, but not
> > the I2C part. And threfore, the i2c_driver is not registered, and the
> > codec is not known to the system, nor matched with a DT node with the
> > corresponding compatible string.
> > 
> > In order to fix that, we move the MODULE_DEVICE_TABLE(of, ...) into
> > the I2C part of the driver. The cs42l51_of_match[] array is also moved
> > as well, as it is not possible to have this definition in one file,
> > and the MODULE_DEVICE_TABLE(of, ...) invocation in another file, due
> > to how MODULE_DEVICE_TABLE works.
> > 
> > Thanks to this commit, the I2C part of the driver now properly
> > autoloads, and thanks to its dependency on the core part, the core
> > part gets autoloaded as well, resulting in a functional sound card
> > without having to manually load kernel modules.
> > 
> > Fixes: 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table pointer")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > ---
> >  sound/soc/codecs/cs42l51-i2c.c | 6 ++++++
> >  sound/soc/codecs/cs42l51.c     | 7 -------
> >  sound/soc/codecs/cs42l51.h     | 1 -
> >  3 files changed, 6 insertions(+), 8 deletions(-)  
> 
> What is the git commit id of this change in Linus's tree?

Ah, I see I didn't do "git cherry-pick -x
e51df4f81b02bcdd828a04de7c1eb6a92988b61e", so the commit log doesn't
have the reference to the original commit, sorry about this.

The original commit in Linus tree is:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e51df4f81b02bcdd828a04de7c1eb6a92988b61e

Thanks!

Thomas
-- 
Thomas Petazzoni, co-owner and CEO, Bootlin
Embedded Linux and Kernel engineering and training
https://bootlin.com
