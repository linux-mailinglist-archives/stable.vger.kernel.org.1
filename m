Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96ABB78EB1A
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 12:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjHaKwb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 06:52:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243350AbjHaKwa (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 06:52:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D75E4A
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 03:52:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4EF256274F
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 10:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ECA9C433C8;
        Thu, 31 Aug 2023 10:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693479126;
        bh=8ubKIbhzJ2rliJUfUMd3c/irypN/ytdCYNpjqGAqQd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LTWBG4AOZgc/84TfLFGDlT8dsCnMlqdklfTOZ/Exv6JIPaNkO0vvoEyYEdkintV3K
         o1/68TqVkqix9mgTnuPvObfq+ipjTAS9RhcZM6s1KGqgI+imcgGppgXkqEWqJTdokt
         5xTn+Luoj37fId0Cx74PDZGFYcez3mx3dZR0lFEk=
Date:   Thu, 31 Aug 2023 12:52:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: 6.1.50 misbackport ?
Message-ID: <2023083149-utilize-voucher-5a05@gregkh>
References: <28b5d0accce90bedf2f75d65290c5a1302225f0f.camel@infinera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28b5d0accce90bedf2f75d65290c5a1302225f0f.camel@infinera.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 02:34:36PM +0000, Joakim Tjernlund wrote:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=linux-6.1.y&id=f016326d31d010433b2a1a08a4856c214ae829eb
> 
> has:
> -		tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
> +		ret = tb_switch_tmu_rate_write(sw, TB_SWITCH_TMU_RATE_OFF);
> +			return ret;
> feels like an if stmt is missing here ?

Yes, it is.

Can you send a fix for this please?

thanks,

greg k-h
