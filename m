Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 603917051C6
	for <lists+stable@lfdr.de>; Tue, 16 May 2023 17:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbjEPPPA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 16 May 2023 11:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbjEPPO5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 16 May 2023 11:14:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDBF40EE
        for <stable@vger.kernel.org>; Tue, 16 May 2023 08:14:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC63C629B0
        for <stable@vger.kernel.org>; Tue, 16 May 2023 15:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8115AC433D2;
        Tue, 16 May 2023 15:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684250096;
        bh=EL4ApGvcPCZ6fgqR7ch+164xaL4VTcBFs3QhBehmu/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MxdXQfp5mTiL6L5n7OT2m3mMtLXeOKH9ehYfqia4XRug9XuQTQxJRL+f5DIs/AWNf
         u81v+o1+L5pgVHcEfKmAYa6plqTKe33RlaiWQVnJRAcR2mw/gNs8MLBV6GI0RGFDxw
         hQkR0XSl1wHvAKsGux3oEryrI6mVp/pim6mq662GVHz08/t3VuuIsyqNXebtcbVb52
         8GOBHG/ihKusym9TFRfXLKqSnqmpr2EctohhxcTLDOWJUIwfCrgPt107dafzVVeEmI
         Hnx4I2D88c7LY9REE7m9pJ8JQ4Ad6y6gAuCU1SZtMXwnviXvF8pl13hwXGXtAyzVwY
         O3jied1ykMs5w==
From:   Will Deacon <will@kernel.org>
To:     andreyknvl@gmail.com, catalin.marinas@arm.com,
        Peter Collingbourne <pcc@google.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        ryabinin.a.a@gmail.com, Chinwen Chang <chinwen.chang@mediatek.com>,
        kasan-dev@googlegroups.com, Qun-wei Lin <Qun-wei.Lin@mediatek.com>,
        eugenis@google.com, vincenzo.frascino@arm.com,
        Guangye Yang <guangye.yang@mediatek.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] arm64: Also reset KASAN tag if page is not PG_mte_tagged
Date:   Tue, 16 May 2023 16:14:42 +0100
Message-Id: <168424553500.607599.5644733830720198100.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230420210945.2313627-1-pcc@google.com>
References: <20230420210945.2313627-1-pcc@google.com>
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

On Thu, 20 Apr 2023 14:09:45 -0700, Peter Collingbourne wrote:
> Consider the following sequence of events:
> 
> 1) A page in a PROT_READ|PROT_WRITE VMA is faulted.
> 2) Page migration allocates a page with the KASAN allocator,
>    causing it to receive a non-match-all tag, and uses it
>    to replace the page faulted in 1.
> 3) The program uses mprotect() to enable PROT_MTE on the page faulted in 1.
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: Also reset KASAN tag if page is not PG_mte_tagged
      https://git.kernel.org/arm64/c/2efbafb91e12

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
