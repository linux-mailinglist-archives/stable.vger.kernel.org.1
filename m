Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E172B7417D9
	for <lists+stable@lfdr.de>; Wed, 28 Jun 2023 20:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjF1SQa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 28 Jun 2023 14:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbjF1SQ3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Jun 2023 14:16:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB60C19B9
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 11:16:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53A3561414
        for <stable@vger.kernel.org>; Wed, 28 Jun 2023 18:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5589FC433C0;
        Wed, 28 Jun 2023 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687976187;
        bh=pJUjNmizPlYRdDtgUt1CKwizLnAxB/dR98cGZBnO0dg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MmdyxLRi3DKjoVOLLZYzcxoo9g2JXACjNzvWEi+3a1z+8KOgSoBZUlJIdZrjaNAfa
         NHjILaT4svCrdfdO5/P+axJ3WWPv2OCmcnzWMO6LlON41hT8D9b/znT9WI5uDRnLnR
         AwoKsT9W/kSc7H6oMvfI91WXIaS0LQuSPkzSAnIY=
Date:   Wed, 28 Jun 2023 20:16:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Limonciello, Mario" <Mario.Limonciello@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Regression in 6.1.35 / 6.3.9
Message-ID: <2023062808-mangy-vineyard-4f66@gregkh>
References: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN0PR12MB6101C52C4B7FB00702A996EBE224A@MN0PR12MB6101.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Jun 28, 2023 at 05:56:01PM +0000, Limonciello, Mario wrote:
> [Public]
> 
> Hi,
>  A regression was reported in 6.4-rc6 that monitor resolutions are no longer present for anything but native resolution on eDP panels.  This specific change backported into stable at 6.1.35 and 6.3.9:
> e749dd10e5f29 ("drm/amd/display: edp do not add non-edid timings")
> 
> After discussing it with the original author, they submitted a revert commit for review:
> https://patchwork.freedesktop.org/patch/544273/
> 
> I suggested the revert also CC stable, and I expect this will go up in 6.5-rc1, but given the timing of the merge window and the original issue hit the stable trees, can we revert it sooner in the stable
> trees to avoid exposing the regression to more people?

As the submitted patch had the wrong git id, it might be good to be able
to take a real one?  I can take it once it shows up in linux-next if
it's really going to be going into 6.5, but I need a stable git id for
it.

thanks,

greg k-h
