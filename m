Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7AC576AB58
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 10:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjHAIx0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 04:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbjHAIxY (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 04:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029BB1711
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 01:53:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9404E614B4
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 08:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FCC7C433C9;
        Tue,  1 Aug 2023 08:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690880003;
        bh=PmNeqTkeaJRMmr9b9RKk+gOPbmeldm77SbXCPnzjV4g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yjq52rgupM2xc+YX0lunjjgHl0SjEqye6YQdNvrZ8986Vb1rn72BUOO0mF8JQJxKq
         iTjV8YTnssL4yOVNxsvlxsfGL3RC2gAF9NkBIBA9nNg0K+dPTcJoEDPSLycq/tp5lD
         H9cbB+7oSDdOiC2wmv1xjWFIGb4P1ZeHTXXFP5zA=
Date:   Tue, 1 Aug 2023 10:53:20 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] ASoC: cs42l51: fix driver to properly autoload
 with automatic module loading
Message-ID: <2023080103-thursday-laxative-add3@gregkh>
References: <2023072301-online-accent-4365@gregkh>
 <20230727123339.675734-1-thomas.petazzoni@bootlin.com>
 <2023080157-twitch-embargo-953b@gregkh>
 <20230801101556.21eed088@windsurf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801101556.21eed088@windsurf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 10:15:56AM +0200, Thomas Petazzoni wrote:
> Hello Greg,
> 
> On Tue, 1 Aug 2023 10:03:26 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Thu, Jul 27, 2023 at 02:33:39PM +0200, Thomas Petazzoni wrote:
> > > In commit 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table
> > > pointer"), 9 years ago, some random guy fixed the cs42l51 after it was
> > > split into a core part and an I2C part to properly match based on a
> > > Device Tree compatible string.
> > > 
> > > However, the fix in this commit is wrong: the MODULE_DEVICE_TABLE(of,
> > > ....) is in the core part of the driver, not the I2C part. Therefore,
> > > automatic module loading based on module.alias, based on matching with
> > > the DT compatible string, loads the core part of the driver, but not
> > > the I2C part. And threfore, the i2c_driver is not registered, and the
> > > codec is not known to the system, nor matched with a DT node with the
> > > corresponding compatible string.
> > > 
> > > In order to fix that, we move the MODULE_DEVICE_TABLE(of, ...) into
> > > the I2C part of the driver. The cs42l51_of_match[] array is also moved
> > > as well, as it is not possible to have this definition in one file,
> > > and the MODULE_DEVICE_TABLE(of, ...) invocation in another file, due
> > > to how MODULE_DEVICE_TABLE works.
> > > 
> > > Thanks to this commit, the I2C part of the driver now properly
> > > autoloads, and thanks to its dependency on the core part, the core
> > > part gets autoloaded as well, resulting in a functional sound card
> > > without having to manually load kernel modules.
> > > 
> > > Fixes: 2cb1e0259f50 ("ASoC: cs42l51: re-hook of_match_table pointer")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> > > ---
> > >  sound/soc/codecs/cs42l51-i2c.c | 6 ++++++
> > >  sound/soc/codecs/cs42l51.c     | 7 -------
> > >  sound/soc/codecs/cs42l51.h     | 1 -
> > >  3 files changed, 6 insertions(+), 8 deletions(-)  
> > 
> > What is the git commit id of this change in Linus's tree?
> 
> Ah, I see I didn't do "git cherry-pick -x
> e51df4f81b02bcdd828a04de7c1eb6a92988b61e", so the commit log doesn't
> have the reference to the original commit, sorry about this.
> 
> The original commit in Linus tree is:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e51df4f81b02bcdd828a04de7c1eb6a92988b61e

Thanks, all now queued up.

greg k-h
