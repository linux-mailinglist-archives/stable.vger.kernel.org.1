Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D30E27E1FF7
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 12:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjKFL1M (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 06:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjKFL1M (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 06:27:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B4134
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 03:27:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F833C433C8;
        Mon,  6 Nov 2023 11:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699270028;
        bh=2K0zpBtorpzUYZr2Ldol0EdX9c9wipc76amzfAf80d4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIMEQcL/SMMGHJlhqhsVcMPNnLU/3hE8ihZFX6ENBuQ+R/U9wq7rRf1m5Y4TROhiZ
         31LEjp3B79eGgBkoZXwsu9/X9A9c9CscEEAPFlc12As8bI6M8MPpiT+vhzuTzvmRaH
         Raqa1UzABFeF7BJq7gwZllnRvcq8yWdjDZRPPeXk=
Date:   Mon, 6 Nov 2023 12:27:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragos-Marian Panait <dragos.panait@windriver.com>
Cc:     stable@vger.kernel.org
Subject: Re: [PATCH 5.4 0/2] nvmet-tcp: backport fix for CVE-2023-5178
Message-ID: <2023110657-greedless-huddle-aca9@gregkh>
References: <2023102012-pleat-snippet-29cf@gregkh>
 <20231101122422.1005567-1-dragos.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101122422.1005567-1-dragos.panait@windriver.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 01, 2023 at 02:24:20PM +0200, Dragos-Marian Panait wrote:
> The following commit is needed to fix CVE-2023-5178:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d920abd1e7c4884f9ecd0749d1921b7ab19ddfbd
> 
> Support patch:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0236d3437909ff888e5c79228e2d5a851651c4c6

Now queued up, thanks.

greg k-h
