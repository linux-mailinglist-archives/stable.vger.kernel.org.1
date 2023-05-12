Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1226FFDCA
	for <lists+stable@lfdr.de>; Fri, 12 May 2023 02:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239628AbjELAPo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 11 May 2023 20:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjELAPl (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 11 May 2023 20:15:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F9A7DBF
        for <stable@vger.kernel.org>; Thu, 11 May 2023 17:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78493652C8
        for <stable@vger.kernel.org>; Fri, 12 May 2023 00:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54A9C433D2;
        Fri, 12 May 2023 00:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683850528;
        bh=sZk70NcrbVRpueC9ZJm09fpyJteFJmLq1NDkL3if4lo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nox69fr5IEURUliYt+0G5sYCX+PkJn+5hn0KcfKLqSh/v5I/r/3Iji2+tcydQYQmA
         oV6piv3y0c3BLwvmcLR1NHGULJ+Hg3t0+4bGgEEXPgog2fWNoBqcGEIKaex4iH6IwI
         6VwALA/EUzuGOVU2gAUuKsuUxnwoDqU8JAzn2AIZeUJVsaFUZdSQUw7a2P9fNlqNAn
         eKqZtVAOcu5bwupTrPAb1875vyLIF99f1OVwsm8NiYZhwBBc/Bc4esG9q5CUxcWTyt
         ZBPQLRJxWuK1W4olkyi/xiClW8OfL7sZJ4y4CXwR8Z9njfG04wEt4KIQwZi4ClUgdQ
         SNchB6sYUb6Cg==
Date:   Thu, 11 May 2023 20:15:28 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org, tsung-hua.lin@amd.com,
        richard.gong@amd.com, Jerry Zuo <Jerry.Zuo@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH 6.1.y / PATCH 6.2.y 1/1] drm/amd/display: Ext displays
 with dock can't recognized after resume
Message-ID: <ZF2FIOG51Z/WKi0m@sashalap>
References: <20230509160120.1033-1-mario.limonciello@amd.com>
 <20230509160120.1033-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230509160120.1033-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 09, 2023 at 11:01:20AM -0500, Mario Limonciello wrote:
>From: Ryan Lin <tsung-hua.lin@amd.com>
>
>[Why]
>Needs to set the default value of the LTTPR timeout after resume.
>
>[How]
>Set the default (3.2ms) timeout at resuming if the sink supports
>LTTPR
>
>Reviewed-by: Jerry Zuo <Jerry.Zuo@amd.com>
>Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
>Signed-off-by: Ryan Lin <tsung-hua.lin@amd.com>
>Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
>Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
>(cherry picked from commit 01a18aa309aec12461fb5e6aecb76f8b33810658)
>Hand modified for missing changes in older kernels including rename
>of dc_link_aux_try_to_configure_timeout()
>Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>(cherry picked from commit 5895ee73fc6b3d507b8ce42763df086acf43d26b)

Queued up, thanks!

-- 
Thanks,
Sasha
