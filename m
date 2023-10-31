Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEEA07DCFB4
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 15:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344573AbjJaOuh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 10:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344577AbjJaOuh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 10:50:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F65109
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 07:50:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF5F8C433C7;
        Tue, 31 Oct 2023 14:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698763834;
        bh=7BZu4XNo0ECBlP05W/D35LRcrFa2JHEe2x2hiIxRjE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sLVYEnWDJPbw3BjQHAw6YHBVWrVz4EnjDd1YdxJ3F61csE+idJBZZREhP3Gtgr3pB
         2KdNuXH1Ky6s/2/ZZwgLyt0y1MJIl6yng7cJwScWRSLe2nbg6sXLchstUpka9X9aVc
         Bmn/1p/Z+LQCzoZqGAJjnV/ms9AZzmBFKUJ+2MQY=
Date:   Tue, 31 Oct 2023 15:50:31 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc:     akpm@linux-foundation.org, lstoakes@gmail.com,
        stable@vger.kernel.org, yikebaer61@gmail.com,
        Michal Hocko <mhocko@suse.com>
Subject: Re: FAILED: patch "[PATCH] mm/mempolicy: fix
 set_mempolicy_home_node() previous VMA" failed to apply to 6.1-stable tree
Message-ID: <2023103117-wikipedia-tycoon-4b15@gregkh>
References: <2023102704-surrogate-dole-2888@gregkh>
 <20231031135111.y3awm4b3jvbybpca@revolver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031135111.y3awm4b3jvbybpca@revolver>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Oct 31, 2023 at 09:51:11AM -0400, Liam R. Howlett wrote:
> 
> Added Michal to the Cc as I'm referencing his patch below.
> 
> * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [231027 08:14]:
> > 
> > The patch below does not apply to the 6.1-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x 51f625377561e5b167da2db5aafb7ee268f691c5
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023102704-surrogate-dole-2888@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > 
> > Possible dependencies:
> 
> Can we add this patch to the dependency list?  It will allow my patch to
> be applied cleanly, and looks like it is close to a valid backport
> itself.
> 
> e976936cfc66 ("mm/mempolicy: do not duplicate policy if it is not
> applicable for set_mempolicy_home_node")

This commit does not apply to 6.1.y at all :(

sorry,

greg k-h
