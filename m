Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 543BD7AB40F
	for <lists+stable@lfdr.de>; Fri, 22 Sep 2023 16:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjIVOv0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 22 Sep 2023 10:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231157AbjIVOvZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 22 Sep 2023 10:51:25 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3899C6
        for <stable@vger.kernel.org>; Fri, 22 Sep 2023 07:51:18 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D4AD84000C;
        Fri, 22 Sep 2023 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695394275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6wQX2ktdkqFIuYrPhSh4pRo+ygkcZ8kR2Ky+CjNE0P0=;
        b=Wr85+tU+J3U/0x0nUCpDXOCwzzBOmg3xw+HhtOh9/ntsNmDwpNjDBJiBHtjnp2ohPH5p+n
        cezjFJ9DhguYo6iMeHOufrPueJm1s9MqdW3x4T9fZ5JjBrAwH/TX0uUG18Le1C2FiDwt0s
        plmXrrXSFHRgmxuhJU4Lzxl/RkCM0UOEAhT76ROxxgAXXT4Jul5sbcmLudgbIIDgB8HRCY
        1wZdMaUYDru3jbzgpT6LokedvTwbEqZ1lukZqmw5+i8GUcJqQMo2C9lbPnwriW8HaFRPhH
        HiBbX6pSGFedGRKnYBacnz8/P9c676e3789WETtj8GptG91cBlKCrCvhIx5U6A==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michal Simek <michal.simek@amd.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/3] mtd: rawnand: pl353: Ensure program page operations are successful
Date:   Fri, 22 Sep 2023 16:51:13 +0200
Message-Id: <20230922145113.578275-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230717194221.229778-3-miquel.raynal@bootlin.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'9777cc13fd2c3212618904636354be60835e10bb'
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Mon, 2023-07-17 at 19:42:21 UTC, Miquel Raynal wrote:
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
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: stable@vger.kernel.org
> Fixes: 08d8c62164a3 ("mtd: rawnand: pl353: Add support for the ARM PL353 SMC NAND controller")
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes.

Miquel
