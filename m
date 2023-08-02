Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD8A76C580
	for <lists+stable@lfdr.de>; Wed,  2 Aug 2023 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjHBGqn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 2 Aug 2023 02:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231849AbjHBGqk (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 2 Aug 2023 02:46:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5709273C
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 23:46:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F701617A5
        for <stable@vger.kernel.org>; Wed,  2 Aug 2023 06:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4A3C433C9;
        Wed,  2 Aug 2023 06:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690958794;
        bh=A1+PFjhOPH5Yb8jZHB2wYEMuO8AT2eLLkDrDsOPjyXg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S7QwMLDGc+QI0uigNs38q5g4jMT0N72JCaoFUHFyBFm1O2AKxgiqJ4hZpreBiGwvW
         wSKf7Ce6QK+s2OWT+pz+SVVb8GL11cZGiSfbX7Eihan25XxqcvA/Dv9gTwOIJwkwAA
         0v+e0cTNcfjQlTmZzk+HBSJyDubo/0K4pfr8z3+I=
Date:   Wed, 2 Aug 2023 08:46:31 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jan Kara <jack@suse.cz>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Zhang Yi <yi.zhang@huawei.com>, Theodore Tso <tytso@mit.edu>,
        Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 047/155] jbd2: remove journal_clean_one_cp_list()
Message-ID: <2023080255-absence-sliced-7fc9@gregkh>
References: <20230801091910.165050260@linuxfoundation.org>
 <20230801091911.867814225@linuxfoundation.org>
 <20230801130944.7e3hhyosweufeuaf@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230801130944.7e3hhyosweufeuaf@quack3>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 01, 2023 at 03:09:44PM +0200, Jan Kara wrote:
> On Tue 01-08-23 11:19:19, Greg Kroah-Hartman wrote:
> > From: Zhang Yi <yi.zhang@huawei.com>
> > 
> > [ Upstream commit b98dba273a0e47dbfade89c9af73c5b012a4eabb ]
> > 
> > journal_clean_one_cp_list() and journal_shrink_one_cp_list() are almost
> > the same, so merge them into journal_shrink_one_cp_list(), remove the
> > nr_to_scan parameter, always scan and try to free the whole checkpoint
> > list.
> > 
> > Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> > Reviewed-by: Jan Kara <jack@suse.cz>
> > Link: https://lore.kernel.org/r/20230606135928.434610-4-yi.zhang@huaweicloud.com
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > Stable-dep-of: 46f881b5b175 ("jbd2: fix a race when checking checkpoint buffer busy")
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> This and the following patch (46f881b5b175) have some issues [1] and cause a
> performance regression for some workloads and possible metadata corruption
> after a crash. So please drop these two patches from the stable trees for
> now. We can include them again later once the code has stabilized...
> Thanks!

Thanks, turns out there were 3 patches here (2 prep patches, one fix)
that needed to be dropped from all queues.  Let us know when the fix is
in Linus's tree so we can add them back in.

thanks,

greg k-h
