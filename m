Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12E127267F7
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 20:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjFGSIV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjFGSIU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 14:08:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A89101
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 11:08:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 55A0F639B5
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 18:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6946CC433EF;
        Wed,  7 Jun 2023 18:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686161298;
        bh=O5lF+6uo4owu1+HVpsSaVrQDJcYLJ0P0aOLV/cAir4c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GFXUXJ+4wJi2SVzU/t35erMBUm5LUtqWNg0q7wMnJufmDadTAIF0s4A6ooex9HE65
         xiYV8Sp/XKEhODSeCwcZgj+WMYPHIeFWZf3JIcCt5uW1foCjcAbJmmRvfJ+7GueDFj
         /692onQilWdbevbNniRo2FPMsUIGnLD+LcA9P7GY=
Date:   Wed, 7 Jun 2023 20:08:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, anson.tsao@amd.com
Subject: Re: [PATCH 6.1] drm/amd/display: Have Payload Properly Created After
 Resume
Message-ID: <2023060722-jujitsu-importer-14db@gregkh>
References: <20230602035952.22551-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602035952.22551-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 01, 2023 at 10:59:52PM -0500, Mario Limonciello wrote:
> From: Fangzhi Zuo <jerry.zuo@amd.com>
> 
> At drm suspend sequence, MST dc_sink is removed. When commit cached
> MST stream back in drm resume sequence, the MST stream payload is not
> properly created and added into the payload table. After resume, topology
> change is reprobed by removing existing streams first. That leads to
> no payload is found in the existing payload table as below error
> "[drm] ERROR No payload for [MST PORT:] found in mst state"
> 
> 1. In encoder .atomic_check routine, remove check existance of dc_sink
> 2. Bypass MST by checking existence of MST root port. dc_link_type cannot
> differentiate MST port before topology is rediscovered.
> 
> Reviewed-by: Wayne Lin <wayne.lin@amd.com>
> Acked-by: Tom Chung <chiahsuan.chung@amd.com>
> Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
> Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org
> (cherry picked from commit 52b112049e1da404828102ccb5b39e92d40f06d4)

This isn't a commit in Linus's tree, where did it come from?

Do you mean 482e6ad9adde69d9da08864b4ccf4dfd53edb2f0?

I'm guessing so, so I'll use that when I commit this, thanks.

greg k-h
