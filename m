Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3349578EAD5
	for <lists+stable@lfdr.de>; Thu, 31 Aug 2023 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345208AbjHaKrE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 31 Aug 2023 06:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345367AbjHaKq5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 31 Aug 2023 06:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA60E55
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 03:46:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96A186311E
        for <stable@vger.kernel.org>; Thu, 31 Aug 2023 10:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A74DC433C7;
        Thu, 31 Aug 2023 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693478758;
        bh=zh/nsJ12o9IcvBArjKHMjM1AKDGvk3WFprSIBBDOFT4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRF/p3KoOQTQqHKR1Lmi0wDi22gB/VVbK51q0ZpGJ/DH6W8dpktuG9Uv7X1RQ5lP7
         8lHRI3ukMVDsSqvOsRa2P/bH1gQuT63sM8hj/zFIDc1v1SOSIPj4GVVfwBlHD6KM5F
         iRqNgEoOlhyOhS5p8N/me1tyTJO/Y47aiGF/lwiA=
Date:   Thu, 31 Aug 2023 12:45:55 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     stable@vger.kernel.org
Subject: Re: [6.5] please apply f5f80e32de12
Message-ID: <2023083131-tweed-garter-be12@gregkh>
References: <20230829174957.0ae84f41@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230829174957.0ae84f41@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, Aug 29, 2023 at 05:49:57PM -0700, Jakub Kicinski wrote:
> Hi!
> 
> Is the queue for 6.5 open already? :)
> 
> Please apply commit f5f80e32de12 ("ipv6: remove hard coded limitation
> on ipv6_pinfo") to 6.5, it mistakenly went via -next. It's in Linus's 
> tree now.
> 
> Discussions:
> 
> https://lore.kernel.org/all/CABq1_viq9yMo9wZ2XkLg_45FaOcwL93qVhqFUZ9wTygKagnszg@mail.gmail.com/
> https://lore.kernel.org/netdev/CANn89iLTn6vv9=PvAUccpRNNw6CKcXktixusDpqxqvo+UeLviQ@mail.gmail.com/T/#mb8dca9fc9491cc78fca691e64e601301ec036ce7
> 
> Fixes: fe79bd65c819 ("net/tcp: refactor tcp_inet6_sk()")

Now queued up, thanks.

greg k-h
