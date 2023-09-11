Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0EC79B3BC
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357947AbjIKWHB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbjIKPzH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:55:07 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D94D198
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:55:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A924FE0024;
        Mon, 11 Sep 2023 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1694447700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O3vuoRl+RdDbBEa7LX1PCZn8k8YNFYHdyS3xcvL6/hc=;
        b=pac5vbNCQYaTKPxE9CPbhvhia1Soiv3q78u6+yPaTYWchzPOpNVMgS7kQSop/KUCWeu+Iy
        fQ+i/OGcHjSv4LjAAQzTxyGzOgz/S+t7cBiTlv5lJHtpsetw9iuBveWDxcdrvofBauHNW4
        Xc5SrPa9+3igfFDJn5hfn2e7GkZqrUxWZUY5CMv+QtZieyyQMsXSMW4yUm5iEmxPupGgdE
        Fq5X/qSZsuonfFZk1n+WLy4wDft5npUZuhvBVGxKytlDjYTx5PnVCGxow8MvK8k7q4R0dP
        liWFISOQnNsobKBCDb9RBNPkQgfyT9DV1rWabCCdDexfOOazHdm0BO2IaOu/2g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org, Aviram Dali <aviramd@marvell.com>
Subject: Re: [PATCH 1/3] mtd: rawnand: marvell: Ensure program page operations are successful
Date:   Mon, 11 Sep 2023 17:53:53 +0200
Message-Id: <20230911155353.611221-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717194221.229778-1-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'3e01d5254698ea3d18e09d96b974c762328352cd'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 2023-07-17 at 19:42:19 UTC, Miquel Raynal wrote:
> The NAND core complies with the ONFI specification, which itself
> mentions that after any program or erase operation, a status check
> should be performed to see whether the operation was finished *and*
> successful.
> 
> The NAND core offers helpers to finish a page write (sending the
> "PAGE PROG" command, waiting for the NAND chip to be ready again, and
> checking the operation status). But in some cases, advanced controller
> drivers might want to optimize this and craft their own page write
> helper to leverage additional hardware capabilities, thus not always
> using the core facilities.
> 
> Some drivers, like this one, do not use the core helper to finish a page
> write because the final cycles are automatically managed by the
> hardware. In this case, the additional care must be taken to manually
> perform the final status check.
> 
> Let's read the NAND chip status at the end of the page write helper and
> return -EIO upon error.
> 
> Cc: stable@vger.kernel.org
> Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
> Reported-by: Aviram Dali <aviramd@marvell.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> Tested-by: Ravi Chandra Minnikanti <rminnikanti@marvell.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes.

Miquel
