Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C8B79B61B
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233046AbjIKUw5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbjIKNrm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:47:42 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C63F5
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:47:37 -0700 (PDT)
Received: from theinternet.molgen.mpg.de (theinternet.molgen.mpg.de [141.14.31.7])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: buczek)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 53CAD61E5FE01;
        Mon, 11 Sep 2023 15:47:02 +0200 (CEST)
Subject: Re: [PATCH 5.15 052/107] Remove DECnet support from kernel
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        David Ahern <dsahern@kernel.org>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        "David S. Miller" <davem@davemloft.net>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20230619102141.541044823@linuxfoundation.org>
 <20230619102143.987013167@linuxfoundation.org>
From:   Donald Buczek <buczek@molgen.mpg.de>
Message-ID: <6084b5fc-577c-468a-a28e-e0ccc530ed9e@molgen.mpg.de>
Date:   Mon, 11 Sep 2023 15:47:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20230619102143.987013167@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On 6/19/23 12:30 PM, Greg Kroah-Hartman wrote:
> From: Stephen Hemminger <stephen@networkplumber.org>
> 
> commit 1202cdd665315c525b5237e96e0bedc76d7e754f upstream.
> 
> DECnet is an obsolete network protocol that receives more attention
> from kernel janitors than users. It belongs in computer protocol
> history museum not in Linux kernel.
[...]

May I ask, how and why this patch made it into the stable kernels?

Did this patch "fix a real bug that bothers people?", is Documentation/process/stable-kernel-rules.rs obsolete or something else? I apologize, if I overlooked something obvious.

Background:

No, we don't use DECNET since 25 years or so. But still any change of kconfig patterns bothers us. 

We automatically build each released kernel and our config evolves automatically following a `cp config-mpi .config && make olddefconfig && make savedefconfig && cp defconfig config-mpi && git commit -m"Update for new kernel version" config-mpi` pattern.

Historically, the changes of savedefconfig in a stable series were zero most of the time. Only when we start a new series with a -rc1 kernel, we had to fix things because, for example, we lost one config because of reorganization of dependencies or a module went from tristate to binary as CONFIG_UNIX did or an option was  renamed as CONFIG_AUTOFS4_FS was. But we only needed to care for that seldomly and in expected moments, when we actually want to move our fleet to a new series and manually compare and test the config.

These changes complicate continuous upgrades and add distractions during reviews and investigations of unintended config changes. And of course, they increase the risk that you lose a feature you depend on during a upgrade from one release of a stable series to another. That's fine, if the changes are really justified by real world problems and maybe these are. But I failed to find the explicit reasoning here.

Another example of such a change in stable for 5.15 might be the addition of CONFIG_MICROCODE_LATE_LOADING with default=y [1] which removed the feature by default, which had to be detected and undone.

I just wanted to note, that backporting "Cleanup"-Patches to stable has cost for the users, too, even if it was true, that nobody needs the removed feature and that there are no unforeseen side effects or other bugs in the patches. It produces manual workload. So I hope, the "only real bug fixes"-policy is not generally obsoleted?

Best

  Donald

[1]: https://lore.kernel.org/stable/20230307165910.899232186@linuxfoundation.org/
-- 
Donald Buczek
buczek@molgen.mpg.de
Tel: +49 30 8413 1433
