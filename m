Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15973746AB4
	for <lists+stable@lfdr.de>; Tue,  4 Jul 2023 09:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjGDHdM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 4 Jul 2023 03:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGDHdL (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 4 Jul 2023 03:33:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF0611C
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 00:33:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4119E61178
        for <stable@vger.kernel.org>; Tue,  4 Jul 2023 07:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA80C433C8;
        Tue,  4 Jul 2023 07:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688455989;
        bh=N+rvBaFsWTshp7hN1HgJPj1nLFmW0eYWWCXf6ztARi0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xKVhVxndOYf0qixBvT9GPmxTAT+EBY6FY4IGzNkrpM0rpaH0mwH9oiZMZPyoLSo7t
         +KbAkcMG1yTnJmSSYO+ji7q37DgFYSBPkLm1AxZ735Alm9sGQgOvdmsI44tT3iwHq/
         8oBNpZ2PSLTDuDED25aZvqdLXPL5Kq+UlafKyv0k=
Date:   Tue, 4 Jul 2023 08:33:07 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.15.y] nubus: Partially revert proc_create_single_data()
 conversion
Message-ID: <2023070456-crucial-ruined-9ce1@gregkh>
References: <2023070359-scowling-tiny-bfd6@gregkh>
 <12e2e18317f0348a3c1f7099c088bb08.fthain@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12e2e18317f0348a3c1f7099c088bb08.fthain@linux-m68k.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Jul 04, 2023 at 11:14:26AM +1000, Finn Thain wrote:
> The conversion to proc_create_single_data() introduced a regression
> whereby reading a file in /proc/bus/nubus results in a seg fault:

Thanks for the backport, now queued up.

greg k-h
