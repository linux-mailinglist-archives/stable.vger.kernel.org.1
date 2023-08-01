Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42DE276AD45
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbjHAJ1o (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbjHAJ1U (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:27:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04E21BCC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BDC361509
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26690C433C7;
        Tue,  1 Aug 2023 09:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881970;
        bh=5nIX0H463/gjYphDy/rMq91ASKNmd04JuT6uRFdUX40=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ej+A0JKIT1x5HgJ8tQ1/O4Urs9wksI2EPCoFvd92P6VVQUXnixQFMSYfgwi8uzip+
         xLG4q3a8ZmZjqIIfrCWbZNIsYXNmZgzTFBNYWJKpTyVNqN2yndsImfowUWKXmG7ibR
         /bJ0z/k4Pur6AE8Naw7SjMBc+TiRpUtlRafHRQiA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 095/155] dm raid: protect md_stop() with reconfig_mutex
Date:   Tue,  1 Aug 2023 11:20:07 +0200
Message-ID: <20230801091913.592150675@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091910.165050260@linuxfoundation.org>
References: <20230801091910.165050260@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit 7d5fff8982a2199d49ec067818af7d84d4f95ca0 ]

__md_stop_writes() and __md_stop() will modify many fields that are
protected by 'reconfig_mutex', and all the callers will grab
'reconfig_mutex' except for md_stop().

Also, update md_stop() to make certain 'reconfig_mutex' is held using
lockdep_assert_held().

Fixes: 9d09e663d550 ("dm: raid456 basic support")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 4 +++-
 drivers/md/md.c      | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 6d4e287350a33..8d489933d5792 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3305,8 +3305,8 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	return 0;
 
 bad_unlock:
-	mddev_unlock(&rs->md);
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 bad:
 	raid_set_free(rs);
 
@@ -3317,7 +3317,9 @@ static void raid_dtr(struct dm_target *ti)
 {
 	struct raid_set *rs = ti->private;
 
+	mddev_lock_nointr(&rs->md);
 	md_stop(&rs->md);
+	mddev_unlock(&rs->md);
 	raid_set_free(rs);
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 5a21aeedc1ba7..89a270d293698 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -6281,6 +6281,8 @@ static void __md_stop(struct mddev *mddev)
 
 void md_stop(struct mddev *mddev)
 {
+	lockdep_assert_held(&mddev->reconfig_mutex);
+
 	/* stop the array and free an attached data structures.
 	 * This is called from dm-raid
 	 */
-- 
2.40.1



