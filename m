Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD326733F5B
	for <lists+stable@lfdr.de>; Sat, 17 Jun 2023 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346230AbjFQICC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 17 Jun 2023 04:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjFQICB (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 17 Jun 2023 04:02:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFA31A4
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 01:02:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0529F6097A
        for <stable@vger.kernel.org>; Sat, 17 Jun 2023 08:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 166E3C433C8;
        Sat, 17 Jun 2023 08:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686988919;
        bh=s4DKql04/1jD0bX4llMxvqyxhv3PWftRb7w2EVWkn14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qcs6U8udqqFvO4VrDGmaGU6OaQv83HHPy0FUOlmwCQIbponUhFR825MiOIRclXoqE
         p4aAuykxEOoSA8xmvZiufVEuVIFTZCzA/kobfN2UdomGi2qxCQ9CYHkDaH1MoI1GkW
         tFH+HmZnp9Hzu5GsMoz+UGgpk4R3WWVjufWNFMG8=
Date:   Sat, 17 Jun 2023 10:01:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     stable <stable@vger.kernel.org>
Subject: Re: io_uring fix for 5.10 and 5.15 stable
Message-ID: <2023061749-glare-arguable-9852@gregkh>
References: <0a921aec-9e55-e83c-1a9e-4f25e19d4195@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a921aec-9e55-e83c-1a9e-4f25e19d4195@kernel.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Fri, Jun 16, 2023 at 09:15:25PM -0600, Jens Axboe wrote:
> Hi,
> 
> Here's a fix that should go into 5.10-stable and 5.15-stable.
> Greg, can you get this applied? Thanks!

Now queued up, thanks.

greg k-h
