Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A95B57356C6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 14:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjFSMYl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 08:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjFSMYa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 08:24:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CDF31BEB
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 05:24:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1DDD260BCA
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 12:23:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 280C6C433CB;
        Mon, 19 Jun 2023 12:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687177430;
        bh=fIuFymwEElrTS5wdr/DgBjq0SOKuxWsWIgeUWUV6dlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cR/TtebWCoT595RrxxFC4Fblphu40kGf5pA7ME5EwJjTypRMcSOtGNcE0upjxStuQ
         1mCwKsoH68dHz0jKKOA6ghT1Xtc0GrpJz98jOs5QtZ4y+49CUmO8ig4no4UsE/V4eD
         asunO+lCkSuLMFh14VYGCU5uo1pQV7xkkFHmdNG0=
Date:   Mon, 19 Jun 2023 14:23:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Janne Huttunen (Nokia)" <janne.huttunen@nokia.com>
Cc:     "minyard@acm.org" <minyard@acm.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: IPMI related kernel panics since v4.19.286
Message-ID: <2023061927-fox-constrict-1918@gregkh>
References: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ae67dbec16b93f0e6356337e52bf21921b0897c.camel@nokia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 11:11:16AM +0000, Janne Huttunen (Nokia) wrote:
> 
> We recently updated an internal test server from kernel v4.19.273
> to v4.19.286 and since then it has already multiple times triggered
> a kernel panic due to a hard lockup. The lockups look e.g. like
> this:

Does this also happen on newer 5.4 and 6.4-rc7 releases?

thanks,

greg k-h
