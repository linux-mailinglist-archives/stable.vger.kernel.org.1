Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F2278EB23
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 12:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244867AbjHaKyk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 06:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345876AbjHaKy1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 06:54:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6343CE48;
        Thu, 31 Aug 2023 03:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15C68B81FF4;
        Thu, 31 Aug 2023 10:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC34C433C7;
        Thu, 31 Aug 2023 10:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1693479261;
        bh=uZNAfnVHICuCi5/0/OxlLVh8T/eGCQKs+HT9Bz2ea6E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QxNoVYwl9WPr76BV2UUrX1ODQgN0sRbALiLEIsEMSbk6N83CKxIx23W+eZzr2BoXH
         kIFBFvrjMjBXir2/2xP504Pg4BhvmVBGjLNCcql7E/Ih42A9Cul6iTprcDRzXb9Fgh
         8jspXZ0vsgAEG+i6onCSicSNDWOgZXCLJ+Wn0vGo=
Date:   Thu, 31 Aug 2023 12:54:15 +0200
From:   Greg KH <gregkh@linux-foundation.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     stable@vger.kernel.org, paulmck@kernel.org, rcu@vger.kernel.org
Subject: Re: Please apply the following rcu-tasks fixes to 5.10 and 5.15
 stable kernels
Message-ID: <2023083108-envelope-cavity-06ca@gregkh>
References: <20230830193303.GA623680@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830193303.GA623680@google.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Aug 30, 2023 at 07:33:03PM +0000, Joel Fernandes wrote:
> Hi Greg, Stable team,
> 
> Please apply the following rcu-tasks fixes to 5.10 and 5.15 stable kernel.
> They cleanly apply and are required to fix a warning [1] that shows up
> during rcutorture testing and are all bug fixes merged into Linus tree.
> 
> I have verified them on the latest 5.10 and 5.15 stable kernels.
> 
> commit 46aa886c483f57ef13cd5ea0a85e70b93eb1d381
> rcu-tasks: Fix IPI failure handling in trc_wait_for_one_reader
> 
> commit cbe0d8d91415c9692fe88191940d98952b6855d9
> rcu-tasks: Wait for trc_read_check_handler() IPIs
> 
> commit 18f08e758f34e6dfe0668bee51bd2af7adacf381
> rcu-tasks: Add trc_inspect_reader() checks for exiting critical section

All now queued up, thanks.

greg k-h
