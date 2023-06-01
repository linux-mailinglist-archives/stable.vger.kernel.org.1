Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67947196BC
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 11:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232734AbjFAJVg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 05:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFAJVf (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 05:21:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2425897
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 02:21:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A913664265
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 09:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B7F3C433EF;
        Thu,  1 Jun 2023 09:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685611293;
        bh=iUWErps2MPb+it/j4Y4jrMFG3TUdYQN58eEQkiN43Kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kbFyDxv9Slrxc8eH02xmazWp/UL1KfJuzmkC5/7B3mbWKLysqFBg46JzTH/YrVdXV
         J4m27TvlogW9xRCPBq9XBHwSGIJpBpPDSbUKT9kw0tZXD2BXneQPHFfcLh8damQUY4
         7cMPJzLeu0cKr7UAQTy+MJThM8b8N1yfz6m5KCVw=
Date:   Thu, 1 Jun 2023 10:21:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Carlos Llamas <cmllamas@google.com>
Cc:     stable@vger.kernel.org, Zi Fan Tan <zifantan@google.com>,
        Todd Kjos <tkjos@google.com>
Subject: Re: [PATCH 5.15.y 1/5] binder: fix UAF caused by faulty buffer
 cleanup
Message-ID: <2023060114-ridden-velvet-5548@gregkh>
References: <20230530194338.1683009-1-cmllamas@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530194338.1683009-1-cmllamas@google.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 30, 2023 at 07:43:34PM +0000, Carlos Llamas wrote:
> commit bdc1c5fac982845a58d28690cdb56db8c88a530d upstream.

All now queued up, thanks.

greg k-h
