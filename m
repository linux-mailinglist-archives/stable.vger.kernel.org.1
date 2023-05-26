Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5482712801
	for <lists+stable@lfdr.de>; Fri, 26 May 2023 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243827AbjEZOGd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 26 May 2023 10:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243811AbjEZOGc (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 26 May 2023 10:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D687DF
        for <stable@vger.kernel.org>; Fri, 26 May 2023 07:06:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D5D6165016
        for <stable@vger.kernel.org>; Fri, 26 May 2023 14:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B654FC433D2;
        Fri, 26 May 2023 14:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685109980;
        bh=52ysi6fApAzQz21KChSvc4bicQde8EXnvTb8aOzD3mM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ISo0q7cimnRuYVqkkD81LvoEdFLJc6xXm7MJxljsaNXgr5TYA39DeC6XTa43hpjgC
         3IaJXe6dIhja/pdN/7LWP0V9Tjij1yCM9NxpuAkrUXiWKLYRKanjfHkCaEy2txRW7C
         NDUgiDBOj7ZD2dKdc2nEOYvSvTWvs3zRjTzJJuwI=
Date:   Fri, 26 May 2023 15:06:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     stable@vger.kernel.org
Subject: Re: Watchdog timer fix
Message-ID: <2023052602-tanning-guy-7fd3@gregkh>
References: <67948087-ef70-adc9-0c3e-c1e6e4cb50bb@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67948087-ef70-adc9-0c3e-c1e6e4cb50bb@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, May 25, 2023 at 07:40:49PM -0500, Mario Limonciello wrote:
> Hi,
> 
> The following commit helps fix the watchdog timer on various AMD SoCs.
> 
> Please backport it to 5.4.y and later.
> 
> 4eda19cc8a29 ("watchdog: sp5100_tco: Immediately trigger upon starting.")

Now queued up, thanks.

greg k-h
