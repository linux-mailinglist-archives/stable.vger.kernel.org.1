Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC34F754E0E
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 11:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGPJZK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 05:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPJZJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 05:25:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9710CE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 02:25:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A4C660959
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 09:25:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB7FC433C7;
        Sun, 16 Jul 2023 09:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689499508;
        bh=axK01VUMA1Zr+GTd7KdxpJeItz986IhfP3eN/UaH2tA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dPUc+hWR/JlwLqaN+rSatqeouNEXOBVtyw2fEHgWvRaXkYwEexXFE3fVp3VN8jj2r
         6j7FFA+3FOB+uL6BaJDscMebeV88p+CSHKNaWlO0VYxdQV50h76Z1ls3g8ghgGhVGY
         8lOPVy/ON6e5ctb8edUod7R+DXE4AA266yl/rSUQ=
Date:   Sun, 16 Jul 2023 11:24:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Yugui <wangyugui@e16-tech.com>
Cc:     stable@vger.kernel.org
Subject: Re: one 'BUG_ON(ret < 0);' is still left in
 queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch
Message-ID: <2023071634-cogwheel-handgun-7cdb@gregkh>
References: <20230715070222.55BF.409509F4@e16-tech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230715070222.55BF.409509F4@e16-tech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 15, 2023 at 07:02:27AM +0800, Wang Yugui wrote:
> Hi,
> 
> one 'BUG_ON(ret < 0);' is still left in queue-6.1/btrfs-do-not-bug_on-on-tree-mod-log-failure-at-balan.patch 
> 
> so we need to rebase this patch.

Great, can you send a new version for 5.15.y and 6.1.y?

thanks,

greg k-h
