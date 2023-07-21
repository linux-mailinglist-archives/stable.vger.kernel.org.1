Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFBC75C7CD
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 15:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjGUN2Z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 09:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbjGUN2F (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 09:28:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B819330D0
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 06:27:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 41CEB61A39
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 13:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 518D7C433C7;
        Fri, 21 Jul 2023 13:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689946071;
        bh=bMprkDpE/C1FUUjuXPKgwCGyMikyrKZKvzNAqBwoHP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XXYrlImQdjSCNLpZlpUWpYGdVKTsGrl/IAICf6nXvP+fmUH9ao9UHFLEQnwdd6kyv
         u36lO7VT65xl9FAtjJ3/rcN1UulmI0VotBwD48ldewFQQnOwBeKXzz+5EfSdMvxqsF
         Wn79tDmiyN8kUDjTYLDpDMcskGk/GwljadGnq65Q=
Date:   Fri, 21 Jul 2023 15:27:48 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Li, Yunxiang (Teddy)" <Yunxiang.Li@amd.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: FAILED: patch "[PATCH] drm/ttm: fix bulk_move corruption when
 adding a entry" failed to apply to 6.4-stable tree
Message-ID: <2023072136-laurel-tightwad-9492@gregkh>
References: <2023072146-sports-deluge-22a1@gregkh>
 <BL0PR12MB2532C071AA71F63C61113B42ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR12MB2532C071AA71F63C61113B42ED3FA@BL0PR12MB2532.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jul 21, 2023 at 12:51:26PM +0000, Li, Yunxiang (Teddy) wrote:
> [Public]
> 
> Hi Greg,
> 
> I tried this out on my side, and it seems to apply cleanly, the same goes for the 6.1.y branch.
> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y git checkout FETCH_HEAD git cherry-pick -x 4481913607e58196c48a4fef5e6f45350684ec3c

The build breaks when you attempt to build it with it applied :(
