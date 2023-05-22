Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD5E70C4B5
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 19:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjEVRzr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 13:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjEVRzr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 13:55:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FCEFF;
        Mon, 22 May 2023 10:55:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F60162160;
        Mon, 22 May 2023 17:55:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62908C433EF;
        Mon, 22 May 2023 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684778145;
        bh=a8FRsjoTGvN91icSayR4DQgfYSvqNCPh1+GQef0dDnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GtcimX2iBq9w9+EP2tsbif5ow8z9ZQseNmkMWyaPNYFQNPQz4YrzYvaxr/Mo9ealW
         Det9Lb9FY8YZHgvhOYs9Z9ewHE1NiLu3EOKCzVAKcPGejPnhVx928rGQY+R47nNB2s
         Uoeq3ES4Ym8Bu4XnS12UsTx9NTQmUs3DSrFG7ABiew3k7NlBg2dr/bbOoPL+WUYy0M
         wJxG6HuLLmFcnGKhmxY0Ku94515BeFRlvBFqyFrXcHfh9JjNokFtkiwrLavyWsLyqL
         2RXyJC8rjhSxZJaSj0Mnvl5jWAJzBydsbv/YmtzfcDqVODQ7xoI0je8QchBvNPnGOP
         0th+bVx8VOktQ==
Date:   Mon, 22 May 2023 13:55:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, gregkh@linuxfoundation.org,
        stable@vger.kernel.org
Subject: Re: [PATCH -stable,4.14 0/8] more stable fixes for 4.14
Message-ID: <ZGusoFuQqgzDWXAx@sashalap>
References: <20230516151606.4892-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230516151606.4892-1-pablo@netfilter.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 16, 2023 at 05:15:58PM +0200, Pablo Neira Ayuso wrote:
>Hi Greg, Sasha,
>
>This is second round of -stable backport fixes for 4.14. This batch
>includes dependency patches which are not currently in the 4.14 branch.
>
>The following list shows the backported patches, I am using original
>commit IDs for reference:
>
>1) 08a01c11a5bb ("netfilter: nftables: statify nft_parse_register()")
>
>2) 6e1acfa387b9 ("netfilter: nf_tables: validate registers coming from userspace.")
>
>3) 20a1452c3542 ("netfilter: nf_tables: add nft_setelem_parse_key()")
>
>4) fdb9c405e35b ("netfilter: nf_tables: allow up to 64 bytes in the set element data area")
>
>5) 7e6bc1f6cabc ("netfilter: nf_tables: stricter validation of element data")
>
>6) 215a31f19ded ("netfilter: nft_dynset: do not reject set updates with NFT_SET_EVAL")
>
>7) 36d5b2913219 ("netfilter: nf_tables: do not allow RULE_ID to refer to another chain")
>
>8) 470ee20e069a ("netfilter: nf_tables: do not allow SET_ID to refer to another table")

I've applied the 5.4 and 4.19 series, but it looks like patch #1 here
fails to apply. Could you please re-send the 4.14 series?

-- 
Thanks,
Sasha
