Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1373E790B44
	for <lists+stable@lfdr.de>; Sun,  3 Sep 2023 10:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbjICIp5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 3 Sep 2023 04:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbjICIp5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 3 Sep 2023 04:45:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFC7115
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 01:45:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 041F2B80967
        for <stable@vger.kernel.org>; Sun,  3 Sep 2023 08:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48152C433C8;
        Sun,  3 Sep 2023 08:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693730750;
        bh=ajWzTj3wdr/N3WVLIZb+S8hfwLtZO3YAqbL0N9typUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=foZaf46t6nE4KIGZtA43aT/fbQGsfhf17a9s7lXzpZ21dIBRsM130VAhY8JsiqGBc
         2/mmHdp5IZPCOzDXOb66yFRIjT8uIufuDAcWPmSpOLHXVVWaVISEhavlRLZotAc2Ev
         LjIxTkTYGBV5+osk1okHj+MzbbyYksXCzrivQJyk=
Date:   Sun, 3 Sep 2023 10:45:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kyle Zeng <zengyhkyle@gmail.com>
Cc:     stable@vger.kernel.org, sishuai@purdue.edu, hch@lst.de
Subject: Re: [PATCH] configfs: fix a race in configfs_lookup()
Message-ID: <2023090335-budget-snide-af81@gregkh>
References: <ZPOZFHHA0abVmGx+@westworld>
 <2023090247-sneezing-latch-af81@gregkh>
 <ZPOvQjsauIgSik3k@westworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPOvQjsauIgSik3k@westworld>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Sep 02, 2023 at 02:55:14PM -0700, Kyle Zeng wrote:
> > You lost all the original signed-off-by lines of the original, AND you
> > lost the authorship of the original commit.  And you didn't cc: anyone
> > involved in the original patch, to get their review, or objection to it
> > being backported.
> Sorry for the rookie mistakes. I drafted another version and it is
> attached to the email. Can you please check whether it is OK?

Good enough, thanks!  Now queued up.

greg k-h
