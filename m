Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E524472AF8B
	for <lists+stable@lfdr.de>; Sun, 11 Jun 2023 00:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjFJWhV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 10 Jun 2023 18:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjFJWhU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Jun 2023 18:37:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE6DE5
        for <stable@vger.kernel.org>; Sat, 10 Jun 2023 15:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=Content-Disposition:Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:
        MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Content-Disposition:In-Reply-To:References;
        bh=2/W27NYKUp/nhuEs+s9Q8lou4ZPYcS3Trh2TsZTJCjg=; b=4ApXLaN4yHitSt9MVIIToh5uEE
        31d1oKyiCAbXu+Y4GwKHFdURfi4nM4CeTOLv0Ce/y679BMk8xYw3K4V+EM7OLBne+uS+HKqKbvT/H
        oLD5TmOCJTpROXlqHIrB7uISu+crAr5y9Y+zu6N5FUa2bLM9Y1TCu6/OSMTv0YdJGOwY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q87Cp-00FTOW-9u
        for stable@vger.kernel.org; Sun, 11 Jun 2023 00:37:11 +0200
Date:   Sun, 11 Jun 2023 00:37:11 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     stable@vger.kernel.org
Subject: Missing backport for 04361b8bb818 ("net: sfp: fix state loss when
 updating state_hw_mask")
Message-ID: <99df4175-f41a-47d1-9d55-99e1976e8127@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi Greg, Sasha

Commit 04361b8bb818 ("net: sfp: fix state loss when updating state_hw_mask")

ends with:

    Fixes: 8475c4b70b04 ("net: sfp: re-implement soft state polling setup")

git tag --contains 8475c4b70b04

shows that the problem was introduced in v6.1-rc1. However, the fix
has not been backported yet to v6.1.X

Is the Fixes: tag not sufficient to trigger the machinery to get it
back ported?

Please could you back port it. It cleanly cherry-picks to v6.1.33

Thanks
	Andrew
