Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527877B7CDD
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 12:10:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232895AbjJDKKV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 06:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232887AbjJDKKV (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 06:10:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DBE83
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 03:10:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77B2C433C9;
        Wed,  4 Oct 2023 10:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696414218;
        bh=qNHqHFxeBBJ/V4RUDRctKQTu5PRHS1G0YgrL+OhJ1vM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r+C86ldsh713ltDDZ8Pc+vzk9DrA2Gh6dSpbUDEvOVfGQXCFzYCBrjTyIS3Cn5Cof
         BP2Jkz0n0Njg+EpM3nnNowIj90PyOrmyOMPfRXEt5nPnaorxsjTtD2QHfxnQNEm5Sz
         5UmNkCbeWFTCuWqAZW/7sg6z6/seTMWsQp2aS0V5w6Kydr7Fi9mzk1CpOhIybHoENi
         iMz5J5jpepRJsnKaGRYqpFRA1wQ5mj/vTVYaP3XO/x0MCKPfUhmW6bbw6+vgjz4doV
         cWq1WziRJkNPGOSPdGoMOjqm2D9hbZeDIpfJ64qwgK/TP8+NO08W+0fIa0nzpjO8m8
         b8Lps4IRnJSoA==
Date:   Wed, 4 Oct 2023 06:10:16 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Mathieu Othacehe <othacehe@gnu.org>
Cc:     stable@vger.kernel.org, jack@suse.cz,
        Marcus Hoffmann <marcus.hoffmann@othermo.de>, tytso@mit.edu,
        famzah@icdsoft.com, gregkh@linuxfoundation.org,
        anton.reding@landisgyr.com
Subject: Re: kernel BUG at fs/ext4/inode.c:1914 - page_buffers()
Message-ID: <ZR06COwVo7bEfP/5@sashalap>
References: <871qeau3sd.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <871qeau3sd.fsf@gnu.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Oct 04, 2023 at 11:37:22AM +0200, Mathieu Othacehe wrote:
>
>Hello,
>
>I have been experimenting this issue:
>https://www.spinics.net/lists/linux-ext4/msg86259.html, on a 5.15
>kernel.
>
>This issue caused by 5c48a7df9149 ("ext4: fix an use-after-free issue
>about data=journal writeback mode") is affecting ext4 users with
>data=journal on all stable kernels.
>
>Jan proposed a fix here
>https://www.spinics.net/lists/linux-ext4/msg87054.html which solves the
>situation for me.
>
>Now this fix is not upstream because the data journaling support has
>been rewritten. As suggested by Jan, that would mean that we could
>either backport the following patches from upstream:
>
>bd159398a2d2 ("jdb2: Don't refuse invalidation of already invalidated buffers")
>d84c9ebdac1e ("ext4: Mark pages with journalled data dirty")
>265e72efa99f ("ext4: Keep pages with journalled data dirty")
>5e1bdea6391d ("ext4: Clear dirty bit from pages without data to write")
>1f1a55f0bf06 ("ext4: Commit transaction before writing back pages in data=journal mode")
>e360c6ed7274 ("ext4: Drop special handling of journalled data from ext4_sync_file()")
>c000dfec7e88 ("ext4: Drop special handling of journalled data from extent shifting operations")
>783ae448b7a2 ("ext4: Fix special handling of journalled data from extent zeroing")
>56c2a0e3d90d ("ext4: Drop special handling of journalled data from ext4_evict_inode()")
>7c375870fdc5 ("ext4: Drop special handling of journalled data from ext4_quota_on()")
>951cafa6b80e ("ext4: Simplify handling of journalled data in ext4_bmap()")
>ab382539adcb ("ext4: Update comment in mpage_prepare_extent_to_map()")
>d0ab8368c175 ("Revert "ext4: Fix warnings when freezing filesystem with journaled data"")
>1077b2d53ef5 ("ext4: fix fsync for non-directories")
>
>Or apply the proposed, attached patch. Do you think that would be an
>option?

Backporting the series would be ideal. Is this only for the 5.15 kernel?

-- 
Thanks,
Sasha
