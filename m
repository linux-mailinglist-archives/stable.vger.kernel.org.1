Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E603738EDB
	for <lists+stable@lfdr.de>; Wed, 21 Jun 2023 20:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFUSdM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 21 Jun 2023 14:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjFUSdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 21 Jun 2023 14:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9A0C6
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 11:33:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FC6761692
        for <stable@vger.kernel.org>; Wed, 21 Jun 2023 18:33:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FD79C433C0;
        Wed, 21 Jun 2023 18:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687372387;
        bh=l6ej5E0RDhospak8yXLc5npUkPJrufdAyWzcDKfr7iM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pemo81HyTUVmEcyR6xLTx/rTQX92v6J1lrQoADPDIKKFzejbCg7CcEpccOOsoZvQY
         yscYMaYzVn813MiDZ18p4oWTKYIAQpfJwD3+o3+9p69HnYwLZm9jdqMLzD84fDe2sb
         eK7HJLK0SShaEsvR3mO1UOpbYG5SAE1C5J126V0E=
Date:   Wed, 21 Jun 2023 20:33:05 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bernhard Seibold <mail@bernhard-seibold.de>
Cc:     stable@vger.kernel.org,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 4.14.y v2] serial: lantiq: add missing interrupt ack
Message-ID: <2023062152-rewrite-auction-0779@gregkh>
References: <2023061830-rubbed-stubble-2775@gregkh>
 <20230619211008.13464-1-mail@bernhard-seibold.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230619211008.13464-1-mail@bernhard-seibold.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, Jun 19, 2023 at 11:10:08PM +0200, Bernhard Seibold wrote:
> commit 306320034e8fbe7ee1cc4f5269c55658b4612048 upstream.
> 
> Currently, the error interrupt is never acknowledged, so once active it
> will stay active indefinitely, causing the handler to be called in an
> infinite loop.
> 
> Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Message-ID: <20230602133029.546-1-mail@bernhard-seibold.de>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/tty/serial/lantiq.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
> index 22df94f107e5..195b85176914 100644
> --- a/drivers/tty/serial/lantiq.c
> +++ b/drivers/tty/serial/lantiq.c
> @@ -1,3 +1,4 @@
> +
>  /*
>   *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
>   *

This first chunk was not needed :(

I'll go hand edit it...

greg k-h
