Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9F46FAADE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbjEHLHl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjEHLG6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:06:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E2E2FA02
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:06:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D73AC62A84
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:06:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB7BC433EF;
        Mon,  8 May 2023 11:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543968;
        bh=8kqUxfzK8HhvW34/JzCdOrdS4s39HiYu249/IWnhSbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uz91HMk2Oizxd0AM/Ozj0YbBcLbSGAvBwR9bmwruh/ePu1SmnnHxErmg0308DgsVB
         I2uXQTLqnNLgIFot03rpNh5vqiAgHig8mhIAfPpRJIKbWAocJgC9tXyxX7+sseQhIO
         NMpXSbDurX9gubp1swgMTxY+uAmk/plWPytWXdBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 260/694] regulator: core: Consistently set mutex_owner when using ww_mutex_lock_slow()
Date:   Mon,  8 May 2023 11:41:35 +0200
Message-Id: <20230508094440.725333546@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit b83a1772be854f87602de14726737d3e5b06e1f4 ]

When a codepath locks a rdev using ww_mutex_lock_slow() directly then
that codepath is responsible for incrementing the "ref_cnt" and also
setting the "mutex_owner" to "current".

The regulator core consistently got that right for "ref_cnt" but
didn't always get it right for "mutex_owner". Let's fix this.

It's unlikely that this truly matters because the "mutex_owner" is
only needed if we're going to do subsequent locking of the same
rdev. However, even though it's not truly needed it seems less
surprising if we consistently set "mutex_owner" properly.

Fixes: f8702f9e4aa7 ("regulator: core: Use ww_mutex for regulators locking")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20230329143317.RFC.v2.1.I4e9d433ea26360c06dd1381d091c82bb1a4ce843@changeid
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/regulator/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/core.c b/drivers/regulator/core.c
index 1490eb40c973a..9a13240f3084f 100644
--- a/drivers/regulator/core.c
+++ b/drivers/regulator/core.c
@@ -334,6 +334,7 @@ static void regulator_lock_dependent(struct regulator_dev *rdev,
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_lock_recursive(rdev,
@@ -6048,6 +6049,7 @@ static void regulator_summary_lock(struct ww_acquire_ctx *ww_ctx)
 			ww_mutex_lock_slow(&new_contended_rdev->mutex, ww_ctx);
 			old_contended_rdev = new_contended_rdev;
 			old_contended_rdev->ref_cnt++;
+			old_contended_rdev->mutex_owner = current;
 		}
 
 		err = regulator_summary_lock_all(ww_ctx,
-- 
2.39.2



