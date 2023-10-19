Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955027D0067
	for <lists+stable@lfdr.de>; Thu, 19 Oct 2023 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235472AbjJSRYA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 19 Oct 2023 13:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbjJSRYA (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 19 Oct 2023 13:24:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13630126
        for <stable@vger.kernel.org>; Thu, 19 Oct 2023 10:23:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4FBC433CB;
        Thu, 19 Oct 2023 17:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697736238;
        bh=Rxqh903u0A4sdT96drARWgDv8MSls0oBQDuqLALNZ3A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=faHvt+AOx5Vcf3zy/oEQdieoD7MTbCw2+UfqfIU69OD87n3OCC4HIEXB3zTl3aTrt
         cAw44dLU/XdsEQzCmYht/lvTIR4K831VA80lu8fCnTQG6ylQUa8kq3YSuifJxT2ltm
         SZ2h500AwmiwJE3i9iVD5xgaixTdo5UMgA7RAJHU=
Date:   Thu, 19 Oct 2023 19:23:55 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Kory Maincent <kory.maincent@bootlin.com>,
        Simon Horman <horms@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.5 082/191] ethtool: Fix mod state of verbose no_mask
 bitset
Message-ID: <2023101950-pogo-stoning-0d0d@gregkh>
References: <20231016084015.400031271@linuxfoundation.org>
 <20231016084017.315801421@linuxfoundation.org>
 <20231019092859.051ca34b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019092859.051ca34b@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 19, 2023 at 09:28:59AM -0700, Jakub Kicinski wrote:
> On Mon, 16 Oct 2023 10:41:07 +0200 Greg Kroah-Hartman wrote:
> > A bitset without mask in a _SET request means we want exactly the bits in
> > the bitset to be set. This works correctly for compact format but when
> > verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
> > bits present in the request bitset but does not clear the rest. The commit
> > 6699170376ab fixes this issue by clearing the whole target bitmap before we
> > start iterating. The solution proposed brought an issue with the behavior
> > of the mod variable. As the bitset is always cleared the old val will
> > always differ to the new val.
> > 
> > Fix it by adding a new temporary variable which save the state of the old
> > bitmap.
> 
> This one got reverted / needs more work. 
> Please drop across the branches.

Now dropped, thanks.

greg k-h
