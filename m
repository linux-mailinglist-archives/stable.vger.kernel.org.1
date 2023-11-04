Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D898E7E1111
	for <lists+stable@lfdr.de>; Sat,  4 Nov 2023 22:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjKDVCe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 4 Nov 2023 17:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbjKDVCE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 4 Nov 2023 17:02:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F010EC4
        for <stable@vger.kernel.org>; Sat,  4 Nov 2023 14:02:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61866C433C7;
        Sat,  4 Nov 2023 21:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699131721;
        bh=x8XuhbC75O/yvjXyGVSZCOYtUyzjcnsgzJpfWu3lmEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NkyJSCHoJiX81ILJEKUI2kyZBO3dk/yj33dCYgrwOA4xvRhvvT14olsOL5btyX/DB
         7Z8u0Wfeb6g2Zn1zY+WBXxokB4+iaSnnt8pNNeCXHR6rjMmiXa67LEToWdP8IuRCA5
         Yxo4lUxTln3RW/wHl/Gm3F8A+hy+xwBWxHvENyhBEQHKWMH/R4Ja2EEiHtvD+K1HG+
         doXTTrg6aqjBai6mXU2F5+H1kuowpp/Wab7rOgHScRa7nZ7TiKOLm8+EuGCZmbThJC
         rl9NfEVF/Ts1pHAGhHOnfRBYHs6Jkkx54OwHxDYiC36Ie6A7B2zbL/1DZRhxUJ8gHa
         bo9/6oIEcL/EA==
Date:   Sat, 4 Nov 2023 17:02:00 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>, Gary Guo <gary@garyguo.net>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: Re: backport 0b4e3b6f6b79 and 35cad617df2e
Message-ID: <ZUaxSDabYeRN7TPv@sashalap>
References: <1760daa6-7245-4d01-bb89-388c472ec5ed@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1760daa6-7245-4d01-bb89-388c472ec5ed@proton.me>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Nov 03, 2023 at 09:57:46PM +0000, Benno Lossin wrote:
>Hi,
>
>I noticed that without commit 0b4e3b6f6b79 ("rust: types: make `Opaque`
>be `!Unpin`") the `Opaque` type has an unsound API:
>The `Opaque` type is designed to wrap C types, hence it is often used to
>convert raw pointers to references in Rust. Normally `&mut` references
>are unique, but for `&mut Opaque<T>` this is should not be the case,
>since C also has pointers to the object. The way to disable the
>uniqueness guarantee for `&mut` in Rust is to make the type `!Unpin`.
>This is accomplished by the given commit above. At the time of creating
>that patch however, we did not consider this unsoundness issue.
>
>For this reason I propose to backport the commit 0b4e3b6f6b79.
>The only affected version is 6.5. No earlier version is affected, since
>the `Opaque` type does not exist in 6.1. Newer versions are also
>unaffected, since the patch is present in 6.6.
>
>Additionally I also propose to backport commit 35cad617df2e ("rust: make
>`UnsafeCell` the outer type in `Opaque`") to 6.5, as this is a
>prerequisite of 0b4e3b6f6b79.

Queued up, thanks!

-- 
Thanks,
Sasha
