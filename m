Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196E77AC21B
	for <lists+stable@lfdr.de>; Sat, 23 Sep 2023 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjIWMvd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 23 Sep 2023 08:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjIWMvc (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 23 Sep 2023 08:51:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CECE19A;
        Sat, 23 Sep 2023 05:51:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E958C433C7;
        Sat, 23 Sep 2023 12:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695473486;
        bh=DwdwV618sEoTwFsaoaxPjvWP/0MFYl+KkTbQtvP+BF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NgqcHDnYWov9IU1xrHrJWV9kGr2fveB0BTxHcPyaEx9AEjo0y0HRSg+Bb2JIl+INq
         R2IDSN/FsBcDvn3tfoqjNW3l+yePnEqOkbYL134lhQBbHRRd0cewbph+w2Pb96PEr0
         TeKmr0Mzsaklfj2JkGR6Tw4V47mSp4XOqRvb/iXi0cT8XoGay66oQCxLQLu22pCu85
         y1he6qruF9WxQj5ZjKcwPdB8crUhulPwtk2zpLK8MTjgFHKzHRR0gZa26gPtCzPq1F
         thaVStsBwZEAc2ck5UkgBCGUpfTwHQx4bDT1IqO4pHrB8JA3lEZ7K+4C9LZa9RwPae
         IeuU5D/dJAuSQ==
Date:   Sat, 23 Sep 2023 08:51:25 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH -stable,6.5 0/5] Netfilter stable fixes for 6.5
Message-ID: <ZQ7fTaNCZSFfNaUE@sashalap>
References: <20230922160256.150178-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230922160256.150178-1-pablo@netfilter.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Sep 22, 2023 at 06:02:51PM +0200, Pablo Neira Ayuso wrote:
>Hi Greg, Sasha,
>
>The following list shows patches that you can cherry-pick to -stable 6.5.
>I am using original commit IDs for reference:
>
>1) 7ab9d0827af8 ("netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention")
>
>2) 4e5f5b47d8de ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")
>
>3) 1d16d80d4230 ("netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails")
>
>4) 7606622f20da ("netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration")
>
>5) 44a76f08f7ca ("netfilter: nf_tables: fix memleak when more than 255 elements expired")
>
>Please, apply.

Queued up this and the rest of the patches you send for 5.10+, thanks!

-- 
Thanks,
Sasha
