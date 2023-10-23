Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B8B7D34A7
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbjJWLl4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234264AbjJWLl4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:41:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3141D7E
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:41:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C30C433CB;
        Mon, 23 Oct 2023 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698061295;
        bh=yYZU+tWEY9rqDCssCwRdqYy7yQMgIIEfZNxF61AYD7g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jr5WGgDRWjLcd8TVQESEJbcaLI3GDHSFTfj+cP+7nSLaazrODcH3cJeYVQM+vhk+M
         wnpmMZKkZYBqL4a+yt5ptV4EGOpHvfG/s6juqDt3nmg5RRefP2XblSx90R+SQe86c9
         /HU0yF3jrGOwElJC5NtWYRj81UG2hL8zL4ZmdPJo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Avri Altman <avri.altman@wdc.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.15 110/137] mmc: core: Capture correct oemid-bits for eMMC cards
Date:   Mon, 23 Oct 2023 12:57:47 +0200
Message-ID: <20231023104824.514306328@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104820.849461819@linuxfoundation.org>
References: <20231023104820.849461819@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Avri Altman <avri.altman@wdc.com>

commit 84ee19bffc9306128cd0f1c650e89767079efeff upstream.

The OEMID is an 8-bit binary number rather than 16-bit as the current code
parses for. The OEMID occupies bits [111:104] in the CID register, see the
eMMC spec JESD84-B51 paragraph 7.2.3. It seems that the 16-bit comes from
the legacy MMC specs (v3.31 and before).

Let's fix the parsing by simply move to use 8-bit instead of 16-bit. This
means we ignore the impact on some of those old MMC cards that may be out
there, but on the other hand this shouldn't be a problem as the OEMID seems
not be an important feature for these cards.

Signed-off-by: Avri Altman <avri.altman@wdc.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230927071500.1791882-1-avri.altman@wdc.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -96,7 +96,7 @@ static int mmc_decode_cid(struct mmc_car
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);


