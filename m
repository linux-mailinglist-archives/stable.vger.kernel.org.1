Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AF87051C7
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 17:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjEPPPC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 11:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjEPPO7 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 11:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7C65FC2
        for <stable@vger.kernel.org>; Tue, 16 May 2023 08:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B0AEE636C2
        for <stable@vger.kernel.org>; Tue, 16 May 2023 15:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AE0C4339B;
        Tue, 16 May 2023 15:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250098;
        bh=Eay3umSnMvALBzJ/s6TIw3Bf6vlQLVKyVV2/SaF252s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k6LCXJqCKSfKIl13WyDKIIRC0oEYF2c2AlaIJO3f/JSuEuYW4su9uywFMsYjDEezb
         S0HZJRw0y5hZ2J7sZ/Cx8hKhYp3TiN3/5RAi+j7agpVPqyZx0vSZ4fQNas1EkSbq+f
         5FmDgFYE13f9hD6PJbGkGzGPk/cTUxwonk0Mwj7U79klIp4X20l3UB0FzEq5qdLFQN
         fPbevICN8kE9c+7IfmFq4YgciN2LlPNcVid9Qvr9/kEFNOHX6e4MrCV4UwDJmMZ+re
         8Rgk3oFQkrtjAMTKp9o/0itJAv3fbsDcxRtaDOjiC/C2/IPbLunFmm6ffV4PP8reIK
         WaJib5EcukNdw==
From:   Will Deacon <will@kernel.org>
To:     Peter Collingbourne <pcc@google.com>, catalin.marinas@arm.com
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        vincenzo.frascino@arm.com, stable@vger.kernel.org
Subject: Re: [PATCH] arm64: mte: Do not set PG_mte_tagged if tags were not initialized
Date:   Tue, 16 May 2023 16:14:43 +0100
Message-Id: <168424555655.607776.5607047868333556534.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230420214327.2357985-1-pcc@google.com>
References: <20230420214327.2357985-1-pcc@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, 20 Apr 2023 14:43:27 -0700, Peter Collingbourne wrote:
> The mte_sync_page_tags() function sets PG_mte_tagged if it initializes
> page tags. Then we return to mte_sync_tags(), which sets PG_mte_tagged
> again. At best, this is redundant. However, it is possible for
> mte_sync_page_tags() to return without having initialized tags for the
> page, i.e. in the case where check_swap is true (non-compound page),
> is_swap_pte(old_pte) is false and pte_is_tagged is false. So at worst,
> we set PG_mte_tagged on a page with uninitialized tags. This can happen
> if, for example, page migration causes a PTE for an untagged page to
> be replaced. If the userspace program subsequently uses mprotect() to
> enable PROT_MTE for that page, the uninitialized tags will be exposed
> to userspace.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mte: Do not set PG_mte_tagged if tags were not initialized
      https://git.kernel.org/arm64/c/c4c597f1b367

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
