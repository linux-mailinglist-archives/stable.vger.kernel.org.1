Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC56712804
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 16:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243316AbjEZOHe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 10:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbjEZOHe (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 10:07:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202C8F2
        for <stable@vger.kernel.org>; Fri, 26 May 2023 07:07:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A697B64F46
        for <stable@vger.kernel.org>; Fri, 26 May 2023 14:07:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88476C433D2;
        Fri, 26 May 2023 14:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685110051;
        bh=30inlXr12nQlU2Uk98e81NpgPeXaI24Lbw9Dl3O98pM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NtENbzx0p5ytO1vUv7Tl3lkkwGCGvplJsPDh3a4+JvZJlfi/HZ+hdpCpsfPbBxvYQ
         a1thx+w24J+F384FrNcGUObM/ejpFAIvNF5VtuMAUSj9tpA0Jb1XfuVplLApvJz40z
         vpxo2iGfbSTHFwedXSZHbJqeCDsbsR5aehWca5/I=
Date:   Fri, 26 May 2023 15:07:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Gong, Richard" <richard.gong@amd.com>
Cc:     stable@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: Fix suspend/resume failure with AMD Navi3x dGPU
Message-ID: <2023052621-washstand-exponent-e962@gregkh>
References: <bff70d90-c530-b632-f64a-f400dd60c52a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff70d90-c530-b632-f64a-f400dd60c52a@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 25, 2023 at 11:23:44AM -0500, Gong, Richard wrote:
> 
> Hi,
> 
> The following commits are required for stable 6.1.y kernel to fix
> suspend/resume failure with AMD Navi3x dGPU.
> 
> 	1e7bbdba68ba "drm/amd/amdgpu: update mes11 api def"
> 	a6b3b618c0f7 "drm/amdgpu/mes11: enable reg active poll"

Now queued up, thanks.

greg k-h
