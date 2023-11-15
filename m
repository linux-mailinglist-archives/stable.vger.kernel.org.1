Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3BC67ECC00
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233822AbjKOT0U (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbjKOT0G (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:26:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C3BD4F
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:26:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A4EC433CA;
        Wed, 15 Nov 2023 19:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076362;
        bh=tXP0W9eD7m5tKXxKj3Naij0KtqVXpgsh2t2l1JnqIWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UlXNKUtw/6HhFmhYTkXhdzLQ6b/CyrTJ3GwqUWgvkwn17aTp9gvnc7v7DX4Q8wdoY
         QhsIbKYmCCCDhTa3egSZG8930Gxo9ZyCkay+nMLJdsH54UoQEciwrk04i8qrLGKr3V
         l8WEOkEJscGN4zmyAQjmuiCsBBbTcDfMmLbJninE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 243/550] accel/habanalabs/gaudi2: Fix incorrect string length computation in gaudi2_psoc_razwi_get_engines()
Date:   Wed, 15 Nov 2023 14:13:47 -0500
Message-ID: <20231115191617.575718683@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 90f3de616259cbb5666f00f8daf5420cd7d71d18 ]

snprintf() returns the "number of characters which *would* be generated for
the given input", not the size *really* generated.

In order to avoid too large values for 'str_size' (and potential negative
values for "PSOC_RAZWI_ENG_STR_SIZE - str_size") use scnprintf()
instead of snprintf().

Fixes: c0e6df916050 ("accel/habanalabs: fix address decode RAZWI handling")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/habanalabs/gaudi2/gaudi2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/accel/habanalabs/gaudi2/gaudi2.c b/drivers/accel/habanalabs/gaudi2/gaudi2.c
index 20c4583f12b0d..31c74ca70a2e5 100644
--- a/drivers/accel/habanalabs/gaudi2/gaudi2.c
+++ b/drivers/accel/habanalabs/gaudi2/gaudi2.c
@@ -8149,11 +8149,11 @@ static int gaudi2_psoc_razwi_get_engines(struct gaudi2_razwi_info *razwi_info, u
 		eng_id[num_of_eng] = razwi_info[i].eng_id;
 		base[num_of_eng] = razwi_info[i].rtr_ctrl;
 		if (!num_of_eng)
-			str_size += snprintf(eng_name + str_size,
+			str_size += scnprintf(eng_name + str_size,
 						PSOC_RAZWI_ENG_STR_SIZE - str_size, "%s",
 						razwi_info[i].eng_name);
 		else
-			str_size += snprintf(eng_name + str_size,
+			str_size += scnprintf(eng_name + str_size,
 						PSOC_RAZWI_ENG_STR_SIZE - str_size, " or %s",
 						razwi_info[i].eng_name);
 		num_of_eng++;
-- 
2.42.0



