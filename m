Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F0C7909B5
	for <lists+stable@lfdr.de>; Sat,  2 Sep 2023 23:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234974AbjIBVIz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 2 Sep 2023 17:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234956AbjIBVIz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 2 Sep 2023 17:08:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7F81708
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 14:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C612AB80906
        for <stable@vger.kernel.org>; Sat,  2 Sep 2023 21:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39650C433C7;
        Sat,  2 Sep 2023 21:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693688927;
        bh=Tn6ITRKPIpTdyBBpv3uqkvIBRkCWh2m0qspb6RQ1Sj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T1956iph61WQxX4QTt8O8GisvN6eNaCoqxIStiEyhb3WjyPF9xJcRAxLQTx34EuFQ
         wraSJd1i3B4iXpHk771Ejh8AYmZFcPB9FrvAfXWsBHt28RlIH5lcpzTSne0MsJ4dlW
         JuPDP2SXEq/Genczv6YvRav2X/lkxxsPgL2oqZ3s=
Date:   Sat, 2 Sep 2023 23:08:43 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <2023090247-sneezing-latch-af81@gregkh>
References: <ZPOZFHHA0abVmGx+@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPOZFHHA0abVmGx+@westworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 02, 2023 at 01:20:36PM -0700, Kyle Zeng wrote:
> commit c42dd069be8dfc9b2239a5c89e73bbd08ab35de0 upstream.
> Backporting the patch to stable-v5.10.y to avoid race condition between configfs_dir_lseek and
> configfs_lookup since they both operate ->s_childre and configfs_lookup
> forgets to obtain the lock.
> The patch deviates from the original patch because of code change.
> The idea is to hold the configfs_dirent_lock when traversing
> ->s_children, which follows the core idea of the original patch.
> 
> 
> Signed-off-by: Kyle Zeng <zengyhkyle@gmail.com>
> ---
>  fs/configfs/dir.c | 2 ++
>  1 file changed, 2 insertions(+)

You lost all the original signed-off-by lines of the original, AND you
lost the authorship of the original commit.  And you didn't cc: anyone
involved in the original patch, to get their review, or objection to it
being backported.

Take a look at many of the backports that happen on the stable list for
examples of how to do this properly.

Here are 2 examples from this weekend alone that are good examples of
how to do this properly:
	https://lore.kernel.org/r/20230902151000.3817-1-konishi.ryusuke@gmail.com
	https://lore.kernel.org/r/cover.1693593288.git.luizcap@amazon.com

Also, how did you test this change?  is this something that you have
actually hit in real life?

thanks,

greg k-h
