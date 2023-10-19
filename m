Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B990C7CFF92
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 18:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjJSQ3E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 12:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbjJSQ3C (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 12:29:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20A63126
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 09:29:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771A0C433CB;
        Thu, 19 Oct 2023 16:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697732940;
        bh=Ye8d1uuZaaK10OD5z7psESvy3uRnG/HNWE2waR2oJW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SyHilvGlYklTP6mvOjLmQd5fTzxp0Ev47QNZ10DvdN3886I4AjdUfGeV0g/zWiQIy
         ijODs9hpy1IPkyisRGwbu/HT8lfbtrz3b9fLfA4PU46m1p2cX6GUm2ZS34mEqr8FVH
         ZkYBBX6dDtZqUEkmqgnzSotT0ZtSXREUYPeDDmLCxaHjSzYQxCcME0oMey2AhP76gF
         kcrMo3vo4zJyspPatwj1V4OnRYq8DO/lHU+JZZYFLoQkXbC6S7xoJty61JMxm5/0pI
         zCl+wa2TLsmzN4z3cFeKJXjpsI3Fu2+iGFS6brWtQNOEs57Ws59gdJjBk0Ykh+k3lw
         G/YRMVgfmCPXg==
Date:   Thu, 19 Oct 2023 09:28:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 082/191] ethtool: Fix mod state of verbose no_mask
 bitset
Message-ID: <20231019092859.051ca34b@kernel.org>
In-Reply-To: <20231016084017.315801421@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
        <20231016084017.315801421@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 16 Oct 2023 10:41:07 +0200 Greg Kroah-Hartman wrote:
> A bitset without mask in a _SET request means we want exactly the bits in
> the bitset to be set. This works correctly for compact format but when
> verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> bits present in the request bitset but does not clear the rest. The commit
> 6699170376ab fixes this issue by clearing the whole target bitmap before we
> start iterating. The solution proposed brought an issue with the behavior
> of the mod variable. As the bitset is always cleared the old val will
> always differ to the new val.
> 
> Fix it by adding a new temporary variable which save the state of the old
> bitmap.

This one got reverted / needs more work. 
Please drop across the branches.
