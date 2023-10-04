Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313C07B7CC4
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 12:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbjJDKAj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232876AbjJDKAi (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 06:00:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2B2AC
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 03:00:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47EA8C433C7;
        Wed,  4 Oct 2023 10:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696413633;
        bh=9KRP5Pp1aXqiXJyZ1V/b/zjefT/h9ygp2FIDMpB6IFg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gHpP5G5tESppxmvtYk4or0Cwps5/H7SluFyVK98nOQ5/51Wx+BjVqkYqFzWMeFVN7
         GwcNXJ3cnH0I8ZA+DbqXxXSjTOWWsHyRulmJz9zSylQMj9q96CiA6YSKg8rVMambPL
         KqtFkVoeEx+640naSFQbdymUQrmR/mPkkVToPTaCVa5+yqimTdfoy62gdpyKKaQbZS
         +ZoBtrFr08+o5cw4ShJPeUB6AMW/gOBnS5vyIHcqrpaH9hA+qaZAAgdpzboIr8nNLP
         VKBVgRwxIG2pV5dJcKKfe/gAOFKfpcWHBjNlc9ZVQo88l7dxTw8wnXwQnu74inIa7Z
         A7xgMgp6kY45A==
Date:   Wed, 4 Oct 2023 06:00:31 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Munehisa Kamata <kamatam@amazon.com>
Cc:     casey@schaufler-ca.com, roberto.sassu@huawei.com,
        stable@vger.kernel.org, vishal.goel@samsung.com
Subject: Re: [PATCH for 4.19.y 0/3] Backport Smack fixes for 4.19.y
Message-ID: <ZR03v3PJbcEWPaZ2@sashalap>
References: <ZRv6gaFF0hPrhj+D@sashalap>
 <20231003190217.35669-1-kamatam@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20231003190217.35669-1-kamatam@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 03, 2023 at 12:02:17PM -0700, Munehisa Kamata wrote:
>Hi Sasha,
>
>On Tue, 2023-10-03 11:26:57 +0000, Sasha Levin wrote:
>>
>> On Thu, Sep 28, 2023 at 06:51:35PM -0700, Munehisa Kamata wrote:
>> >This series backports the following fixes for Smack problems with overlayfs
>> >to 4.19.y.
>> >
>> >2c085f3a8f23 smack: Record transmuting in smk_transmuted
>> >3a3d8fce31a4 smack: Retrieve transmuting information in smack_inode_getsecurity()
>> >387ef964460f Smack:- Use overlay inode label in smack_inode_copy_up()
>> >
>> >This slightly modifies the original commits, because the commits rely on
>> >some helper functions introduced after v4.19 by different commits that
>> >touch more code than just Smack, require even more prerequisite commits and
>> >also need some adjustments for 4.19.y.  Instead, this series makes minor
>> >modifications for only the overlayfs-related fixes to not use the helper
>> >functions rather than backporting everything.
>>
>> What about newer trees? We can't take fixes for 4.19 if the fixes don't
>> exist in 5.4+.
>
>Sorry if it was not clear enough in the first post[1]. For 5.4+, please just
>cherry-pick the 3 commits. Those should apply cleanly.
>
>[1] https://lore.kernel.org/stable/20230929015033.835263-1-kamatam@amazon.com/

Ah I didn't see this one, perfect, now queued up.

-- 
Thanks,
Sasha
