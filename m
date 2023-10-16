Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB7BE7CA157
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:12:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjJPIMi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231135AbjJPIMh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:12:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1773A1
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:12:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C533C433C7;
        Mon, 16 Oct 2023 08:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697443955;
        bh=HGSJ7HB1phT/srq701sfvc5Tftcmis/KPSpG+qmKeuo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eMjOAG2EnFsIi50HKYH3emQ6UlJHtSgUYcu3inIeVqz/L37CRVSFTTie61i/eFGD1
         ZmsSQNGFJzGcX7T92Ez1kJ+9hhl/Xyk/b0yTJLYO+0CI0z9DglKsb05lYCgjyn38cA
         Xb/GMHMtzP4UqhVpp86U4BQVCpFSjq2wrthX0u2o=
Date:   Mon, 16 Oct 2023 10:12:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     rene@exactcode.de, stable@kernel.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/cpu: Fix AMD erratum #1485 on
 Zen4-based CPUs" failed to apply to 4.14-stable tree
Message-ID: <2023101619-magnetic-king-3962@gregkh>
References: <2023101528-jawed-shelving-071a@gregkh>
 <20231016075537.GBZSzseVhKAg9674XP@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231016075537.GBZSzseVhKAg9674XP@fat_crate.local>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Oct 16, 2023 at 09:55:37AM +0200, Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> Date: Sat, 7 Oct 2023 12:57:02 +0200
> Subject: [PATCH] x86/cpu: Fix AMD erratum #1485 on Zen4-based CPUs
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> Upstream commit f454b18e07f518bcd0c05af17a2239138bff52de.
> 
> Fix erratum #1485 on Zen4 parts where running with STIBP disabled can
> cause an #UD exception. The performance impact of the fix is negligible.
> 
> Reported-by: René Rebe <rene@exactcode.de>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Tested-by: René Rebe <rene@exactcode.de>
> Cc: <stable@kernel.org>
> Link: https://lore.kernel.org/r/D99589F4-BC5D-430B-87B2-72C20370CF57@exactcode.com
> ---
>  arch/x86/include/asm/msr-index.h | 4 ++++
>  arch/x86/kernel/cpu/amd.c        | 9 +++++++++
>  2 files changed, 13 insertions(+)

Now queued up, thanks.

greg k-h
