Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA073713B26
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 19:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjE1Rfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 13:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjE1Rfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 13:35:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F7CBE
        for <stable@vger.kernel.org>; Sun, 28 May 2023 10:35:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C42C561384
        for <stable@vger.kernel.org>; Sun, 28 May 2023 17:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA068C433D2;
        Sun, 28 May 2023 17:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685295329;
        bh=YPrjMgTd0UJs8mXQk7CD4ANdMAgl9Ghx/lgIlx93Lno=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CHNoDMRTocUskQNl6Rde69HYEiOBgjuPGqZ9PnICwirYkjs+UCLrORiqtSA+rkQjF
         7hD4R7bqPAUfGCNEJaGUBhHL4nj6ax5tx5R44quP5O8h8rXj6vFdQCdtoGUiNWofQ4
         mi3KwQ6NY7bLwA7Xmj4vAT/zksZfWIjlC1cfJEZo=
Date:   Sun, 28 May 2023 18:35:26 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Liu Ying <victor.liu@nxp.com>, Marek Vasut <marex@denx.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, kernel@pengutronix.de
Subject: Re: [PATCH 6.3 169/694] arm64: dts: imx8mp: Drop simple-bus from
 fsl,imx8mp-media-blk-ctrl
Message-ID: <2023052819-unnerve-raving-0f24@gregkh>
References: <20230508094432.603705160@linuxfoundation.org>
 <20230508094437.900924742@linuxfoundation.org>
 <20230523-justly-situated-317e792f4c1b-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523-justly-situated-317e792f4c1b-mkl@pengutronix.de>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Tue, May 23, 2023 at 05:47:41PM +0200, Marc Kleine-Budde wrote:
> Hello Greg,
> 
> can you please revert this patch, without the corresponding driver patch
> [1] it breaks probing of the device, as no one populates the sub-nodes.
> 
> [1] 9cb6d1b39a8f ("soc: imx: imx8m-blk-ctrl: Scan subnodes and bind drivers to them")

Sorry for the delay, now reverted.

greg k-h
