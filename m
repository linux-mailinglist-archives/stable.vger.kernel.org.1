Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C75A722473
	for <lists+stable@lfdr.de>; Mon,  5 Jun 2023 13:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbjFELUK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 5 Jun 2023 07:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFELUJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 5 Jun 2023 07:20:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0B70115
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 04:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5098961A88
        for <stable@vger.kernel.org>; Mon,  5 Jun 2023 11:20:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 382B3C43445;
        Mon,  5 Jun 2023 11:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685964000;
        bh=ouWot4juw3FjcWEk0jkyT5HIIWblCyGOFwTp/Dou44M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qZbohzNwmjtgMJ1+9WmFaP+R+yEXzUIatgdj/V4ffqAJgSw4qrsaqqR78igltNmTd
         QzadT8ss3w/ihQJwIPrcDV7oD8KD/7QShFU5cVlAzG6gQsyCJsifMTluWSfj5Bi+zI
         XBDU9qpk5s5e9O1Nf2eel2YKcxwGTHWyVmeBVaWU=
Date:   Mon, 5 Jun 2023 13:19:57 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     kuba@kernel.org, simon.horman@corigine.com, stable@vger.kernel.org,
        Lee Jones <joneslee@google.com>
Subject: Re: FAILED: patch "[PATCH] net: cdc_ncm: Deal with too low values of
 dwNtbOutMaxSize" failed to apply to 4.14-stable tree
Message-ID: <2023060524-pluck-undermost-a9e1@gregkh>
References: <2023052625-mutual-punch-5c0b@gregkh>
 <4f0cac8d-ef9b-5c97-3076-8a6a78e11137@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f0cac8d-ef9b-5c97-3076-8a6a78e11137@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 05, 2023 at 12:07:20PM +0100, Tudor Ambarus wrote:
> Hi!
> 
> In order to apply this without conflicts to 4.14-stable, one needs to
> apply a dependency, thus the sequence is:
> 
> 7e01c7f7046e ("net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize")
> 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
> 
> Let me know if you want me to send the patches explicitly.

Please do, as 7e01c7f7046e does not apply at all either.

thanks,

greg k-h
