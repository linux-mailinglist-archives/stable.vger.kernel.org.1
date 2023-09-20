Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280997A7E2F
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbjITMQH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:16:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235541AbjITMQC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:16:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D8611A
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:15:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB43C433C8;
        Wed, 20 Sep 2023 12:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212152;
        bh=n9BLN8R29on/u4HAjawzxW1YN587MtMx0+uBclmoJrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l4GMMuaMzwbbxP2bgdTJ4gR0hRkKAM0s8ja6fnbHRfgyFDo8KxB3Ea//D+AzOHfRy
         /8ifCP5y2UgSYKwmp7jfxumkkFlKYHhoMHJ/FL8S95SeYnhFCoxANCMJRGyc9N9hPW
         hzJLLweGl571zHJ4VGPAcXSw7Oe10MmHjJNqIJrs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Dhruva Gole <d-gole@ti.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 4.19 171/273] PM / devfreq: Fix leak in devfreq_dev_release()
Date:   Wed, 20 Sep 2023 13:30:11 +0200
Message-ID: <20230920112851.802449130@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boris Brezillon <boris.brezillon@collabora.com>

commit 5693d077595de721f9ddbf9d37f40e5409707dfe upstream.

srcu_init_notifier_head() allocates resources that need to be released
with a srcu_cleanup_notifier_head() call.

Reported by kmemleak.

Fixes: 0fe3a66410a3 ("PM / devfreq: Add new DEVFREQ_TRANSITION_NOTIFIER notifier")
Cc: <stable@vger.kernel.org>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/devfreq/devfreq.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/devfreq/devfreq.c
+++ b/drivers/devfreq/devfreq.c
@@ -582,6 +582,7 @@ static void devfreq_dev_release(struct d
 		devfreq->profile->exit(devfreq->dev.parent);
 
 	mutex_destroy(&devfreq->lock);
+	srcu_cleanup_notifier_head(&devfreq->transition_notifier_list);
 	kfree(devfreq);
 }
 


