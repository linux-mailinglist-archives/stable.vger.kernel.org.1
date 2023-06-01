Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CD8719779
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjFAJqN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233013AbjFAJqF (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC35194
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:46:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D7D064295
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:46:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EEDCC433EF;
        Thu,  1 Jun 2023 09:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685612760;
        bh=GqUnU61goddZLVXOeLWO6BCrExYfV+LIxnXn5jOQ7eI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZO5e3/+LJaXbQAofrf4WGHlezj3gcsgbGYKPUgWYei2nh9AV7vq8M1cvVWjfgzkiu
         1pIBlORCIOOy2iViiaeTfgFYltT1Gx9Kt1hQcF+UTDB2fMQFaawCkTNDzg4NoWg5UX
         P1y1jallUYe6zLWGbQUMl/+NU82lFai0eIpSqhf8=
Date:   Thu, 1 Jun 2023 10:45:58 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Christian Loehle <CLoehle@hyperstone.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: block: ensure error propagation for non-blk
Message-ID: <2023060116-trial-excusably-0006@gregkh>
References: <30da2b2257ee48d3808d6ae5f1972b9e@hyperstone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30da2b2257ee48d3808d6ae5f1972b9e@hyperstone.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 07:58:01AM +0000, Christian Loehle wrote:
> commit 003fb0a51162d940f25fc35e70b0996a12c9e08a upstream.

<snip>

You sent this, and the other commit, in html format, which made it
impossible to apply (and the mailing lists rejected your change as
well.)

Please fix up your email client and resend in non-html format and I will
be glad to queue this up.

thanks,

greg k-h
