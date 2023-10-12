Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8A07C6EB6
	for <lists+stable@lfdr.de>; Thu, 12 Oct 2023 15:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378475AbjJLNDe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 12 Oct 2023 09:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378572AbjJLNDd (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 12 Oct 2023 09:03:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF40091
        for <stable@vger.kernel.org>; Thu, 12 Oct 2023 06:03:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38E20C433C7;
        Thu, 12 Oct 2023 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697115810;
        bh=6yX/WOUyZelBUeisXtsJ2BdBXO3dsFQ0rXRjzeTE03c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dW7Z3uoqNdV0mEIbSdN8XVEdm2EkqT5XVh99FOu3pPWTP6kkWOJwyQ8hK9bwfE3L4
         LdUUs+3UCMrutsPHEs5N++59z2KJ38Uj6dct1jCot/IWeZ0oJq5C+8x6cAqwtGG0O4
         SJC0VciY0AhZRvGwtqDZliQhjUuqKR6MOH0z9RC0=
Date:   Thu, 12 Oct 2023 15:03:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Zbigniew Lukwinski <zbigniew.lukwinski@linux.intel.com>
Cc:     zbigelpl@gmail.com, Jan Kara <jack@suse.cz>,
        Eric Whitney <enwlinux@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/1] quota: Fix slow quotaoff
Message-ID: <2023101218-cussed-aside-c623@gregkh>
References: <20231012122533.1281864-1-zbigniew.lukwinski@linux.intel.com>
 <20231012122533.1281864-2-zbigniew.lukwinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012122533.1281864-2-zbigniew.lukwinski@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Oct 12, 2023 at 02:25:33PM +0200, Zbigniew Lukwinski wrote:
> From: Jan Kara <jack@suse.cz>
> 
> Eric has reported that commit dabc8b207566 ("quota: fix dqput() to
> follow the guarantees dquot_srcu should provide") heavily increases
> runtime of generic/270 xfstest for ext4 in nojournal mode. The reason
> for this is that ext4 in nojournal mode leaves dquots dirty until the last
> dqput() and thus the cleanup done in quota_release_workfn() has to write
> them all. Due to the way quota_release_workfn() is written this results
> in synchronize_srcu() call for each dirty dquot which makes the dquot
> cleanup when turning quotas off extremely slow.
> 
> To be able to avoid synchronize_srcu() for each dirty dquot we need to
> rework how we track dquots to be cleaned up. Instead of keeping the last
> dquot reference while it is on releasing_dquots list, we drop it right
> away and mark the dquot with new DQ_RELEASING_B bit instead. This way we
> can we can remove dquot from releasing_dquots list when new reference to
> it is acquired and thus there's no need to call synchronize_srcu() each
> time we drop dq_list_lock.
> 
> References: https://lore.kernel.org/all/ZRytn6CxFK2oECUt@debian-BULLSEYE-live-builder-AMD64
> Reported-by: Eric Whitney <enwlinux@gmail.com>
> Fixes: dabc8b207566 ("quota: fix dqput() to follow the guarantees dquot_srcu should provide")
> CC: stable@vger.kernel.org
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/quota/dquot.c         | 66 ++++++++++++++++++++++++----------------
>  include/linux/quota.h    |  4 ++-
>  include/linux/quotaops.h |  2 +-
>  3 files changed, 43 insertions(+), 29 deletions(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
