Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97E370C2FC
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 18:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjEVQHw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 12:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjEVQHv (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 12:07:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30CDDB;
        Mon, 22 May 2023 09:07:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6FDF961E0D;
        Mon, 22 May 2023 16:07:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9ABC433EF;
        Mon, 22 May 2023 16:07:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684771669;
        bh=C01DKtfrswh+VRdwlCfp5W7yRc3+tbweHpuSHM//zPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qPtbAdn2SoZeKKdkkK7407FYWBGLBVPTPE/UfHMpHsL7JL82r2BiQ1geTFQKqW/Cx
         LnHBKlxbv2gUYCeugpXIDE7kMu3ZGrUxg+MAGHv30OiWQhSknXFBTtf+k1kHVKFdyp
         Vc/laR0DNiblPMmxCZXYWCLzgEFzI/Eq499Z71KIA3CrVSXLWO94eiXNpBfl5jxQNi
         H/s6InqVD9Z26JmGQ9LhavZS3BTC3fdfK+uzfzbxpPjxqtSuG01N+FWipcf1VPhHg0
         /suwtaf+IDAv5lElGmAw1Y3zuMrdNPtRNGNluH+EXLglm3SE59j8s5MDlhXys1R26E
         YlE5xEkLBaaBA==
Date:   Mon, 22 May 2023 12:07:48 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Paul Moore <paul@paul-moore.com>
Cc:     stable@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>,
        linux-security-module@vger.kernel.org
Subject: Re: Stable backport of de3004c874e7 ("ocfs2: Switch to
 security_inode_init_security()")
Message-ID: <ZGuTVAj1AJOdTtLF@sashalap>
References: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhRPvkdk6t1zkx+Y-QVP_vJRSxp+wuOO0YjyppNDLTNg7g@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 19, 2023 at 05:51:59PM -0400, Paul Moore wrote:
>Hello,
>
>I would like to request the backport of the commit below to address a
>kernel panic in ocfs2 that was identified by Valentin Vidić in this
>thread:
>
>https://lore.kernel.org/linux-security-module/20230401214151.1243189-1-vvidic@valentin-vidic.from.hr
>
>While Valentin provides his own patch in the original message, the
>preferred patch is one that went up to Linus during the last merge
>window; Valentin has tested the patch and confirmed that it resolved
>the reported problem.

How far should this patch be backported?

-- 
Thanks,
Sasha
