Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E1777B484
	for <lists+stable@lfdr.de>; Mon, 14 Aug 2023 10:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjHNIpD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 14 Aug 2023 04:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233771AbjHNIob (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 14 Aug 2023 04:44:31 -0400
X-Greylist: delayed 476 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Aug 2023 01:44:12 PDT
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F281725
        for <stable@vger.kernel.org>; Mon, 14 Aug 2023 01:44:12 -0700 (PDT)
Date:   Mon, 14 Aug 2023 10:36:13 +0200
From:   Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Helge Deller <deller@gmx.de>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6.4 028/206] io_uring/parisc: Adjust pgoff in io_uring
 mmap() for parisc
Message-ID: <1692002074@msgid.manchmal.in-ulm.de>
References: <20230813211724.969019629@linuxfoundation.org>
 <20230813211725.807909427@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230813211725.807909427@linuxfoundation.org>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_05,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Greg Kroah-Hartman wrote...

> From: Helge Deller <deller@gmx.de>
> 
> commit 56675f8b9f9b15b024b8e3145fa289b004916ab7 upstream.
(...)
> This patch has no effect on other architectures (SHM_COLOUR is only
> defined on parisc), and the liburing testcase stil passes on parisc.

Confirmed: Both issues reported to linux-parisc earlier are fixed
now.

    Christoph (very busy fighting time thieves)
