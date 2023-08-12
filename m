Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43A12779E8B
	for <lists+stable@lfdr.de>; Sat, 12 Aug 2023 11:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbjHLJ1b (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 12 Aug 2023 05:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjHLJ1a (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 12 Aug 2023 05:27:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68856DA
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 02:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0087561689
        for <stable@vger.kernel.org>; Sat, 12 Aug 2023 09:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B2EC433C7;
        Sat, 12 Aug 2023 09:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691832453;
        bh=kur3VkRhjTIJ0IuzV9rbGALDJicbLb99CUivpaZBbic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZx/gG+kLVANUTzD4AKLp86WkK4cMWF5IcAuhkncNYjTo+jylAg85yP3hTFsnBXbP
         pFCHM/BXipQ934eVwecP10F4X7aqn7kzDQRwOp3B2zadRGZOK8swaLxGk3Y3kKxwxk
         9v/ZHLDM7X00RmWP2Amg2tr/CKoxBowzKTuw8tP8=
Date:   Sat, 12 Aug 2023 11:27:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pu Lehui <pulehui@huaweicloud.com>
Cc:     stable@vger.kernel.org, Eduard Zingerman <eddyz87@gmail.com>,
        Luiz Capitulino <luizcap@amazon.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Pu Lehui <pulehui@huawei.com>
Subject: Re: [PATCH 5.15 0/6] Backporting for 5.15 test_verifier failed
Message-ID: <2023081213-scored-scared-e8b5@gregkh>
References: <20230804152459.2565673-1-pulehui@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804152459.2565673-1-pulehui@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Aug 04, 2023 at 11:24:53PM +0800, Pu Lehui wrote:
> Luiz Capitulino reported the test_verifier test failed:
> "precise: ST insn causing spi > allocated_stack".
> And it was introduced by the following upstream commit:
> ecdf985d7615 ("bpf: track immediate values written to stack by BPF_ST instruction")
> 
> Eduard's investigation [4] shows that test failure is not a bug, but a
> difference in BPF verifier behavior between upstream, where commits
> [1,2,3] by Andrii are present, and 5.15, where these commits are absent.
> 
> Backporting strategy is consistent with Eduard in kernel version 6.1 [5],
> but with some conflicts in patch #1, #4 and #6 due to the bpf of 5.15
> doesn't support more features.
> 
> Commits of Andrii:
> [1] be2ef8161572 ("bpf: allow precision tracking for programs with subprogs")
> [2] f63181b6ae79 ("bpf: stop setting precise in current state")
> [3] 7a830b53c17b ("bpf: aggressively forget precise markings during state checkpointing")
> 
> Links:
> [4] https://lore.kernel.org/stable/c9b10a8a551edafdfec855fbd35757c6238ad258.camel@gmail.com/
> [5] https://lore.kernel.org/all/20230724124223.1176479-2-eddyz87@gmail.com/
> 

This, and the 5.10.y series, now queued up, thanks.

greg k-h
