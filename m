Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59ABF700E7A
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 20:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237397AbjELSQy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 12 May 2023 14:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237760AbjELSQx (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 12 May 2023 14:16:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F752105
        for <stable@vger.kernel.org>; Fri, 12 May 2023 11:16:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8508365753
        for <stable@vger.kernel.org>; Fri, 12 May 2023 18:16:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4B4C433D2;
        Fri, 12 May 2023 18:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683915397;
        bh=SzlLfbXUn/0leWhmgkeyYab7ooRIhA9sYh7ZAaWcNmc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yjzf1Qsi/LaW1+KfF9KgaBv60ipYQ6KwWDR2NjBuaflcssMDmwIhfHA1jmN0WTeN2
         hD9b6d1WmkiJov+1PiUlKGYiqDeAXx6XVQcwx1PimBKy8qLQv0RhJAAo9lzAupPufo
         xfJwaw3pg/oPxd/aodSx9cXKfnla0aF9C/dpVTuUkXOBb8xjLhe8AaYwlCNC6IqnyI
         iAhnV72h2wZuCK09RFiDb04seWsi73k+N+hhaVWCImD2ONpq4dYt1fKe8R2oNj7LRE
         u8yoleARiW43BPFK1z/qPOxQinuRPL3D4bWaHnI5zHnfsKIjCV+4oT8TrmlPCs5y0f
         3v9qyEErtIKiw==
Date:   Fri, 12 May 2023 14:16:37 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     stable@vger.kernel.org, conor@kernel.org, palmer@dabbelt.com,
        linux@roeck-us.net
Subject: Re: [PATCH 6.1 v2 0/2] RISC-V: fix lock splat in
 riscv_cpufeature_patch_func()
Message-ID: <ZF6CYtsUgA9SFc0p@sashalap>
References: <20230512-unbroken-preppy-8d726731e8e7@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230512-unbroken-preppy-8d726731e8e7@wendy>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, May 12, 2023 at 08:58:17AM +0100, Conor Dooley wrote:
>Replacing <20230509-suspend-labrador-3eb6f0a8ac77@spud>, here's a more
>complete backport of the patches for the lockdep splats during text
>patching on RISC-V.
>I've preserved the original broken patch & the subsequent fix to it.

Queued up, thanks!

-- 
Thanks,
Sasha
