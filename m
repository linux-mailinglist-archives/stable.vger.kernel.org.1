Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC0272BEEB
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjFLK1W (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbjFLK1F (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:27:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E9CA859
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10E6D61DB9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE619C433EF;
        Mon, 12 Jun 2023 10:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686564318;
        bh=OqMXXwWNtpffFLFXHeHpJm5PAX8GNhSvQ2tEOUdWHrg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qD0aN8qLtot2IOaMQzE+X/3YeRr53014/l0v5C/Z95657WFhOUAww/fGMrpnjWkZo
         CDBLRA2VLVp8lVuIw7E3ihbVrsbwOGS1gTimuaBllHPtf6qB42YYCrDIJ/rKEeCXDG
         mL9OWfoJFZlbA1T+L+pDLEZwrMQ2D6xYX27kaU5w=
Date:   Mon, 12 Jun 2023 12:05:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jaime Liao <jaimeliao.tw@gmail.com>
Cc:     sashal@kernel.org, miquel.raynal@bootlin.com, richard@nod.at,
        stable@vger.kernel.org, alvinzhou@mxic.com.tw,
        juliensu@mxic.com.tw, liangyanyu13@gmail.com
Subject: Re: [PATCH] mtd: spinand: macronix: Add support for serial NAND flash
Message-ID: <2023061207-deftly-shoplift-8bb2@gregkh>
References: <20230608054350.21191-1-jaimeliao.tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230608054350.21191-1-jaimeliao.tw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Thu, Jun 08, 2023 at 01:43:50PM +0800, Jaime Liao wrote:
> From: JaimeLiao <jaimeliao.tw@gmail.com>
> 
> MX35LFxGE4AD have been merge into Linux kernel mainline
> 
> Commit ID : 5ece78de88739b4c68263e9f2582380c1fd8314f
> 
> For SPI-NAND flash support on Linux kernel LTS v5.4.y
> 
> Add SPI-NAND flash MX35LF2GE4AD and MX35LF4GE4AD in id tables.
> 
> Those two flase have been validate on Xilinx zynq-picozed board and
> 
> Linux kernel LTS v5.4.242.
> 
> Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>
> ---
>  drivers/mtd/nand/spi/macronix.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Now queued up, thanks.

greg k-h
