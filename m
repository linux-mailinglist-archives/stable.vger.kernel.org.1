Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5F775D53
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjHILgO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbjHILgN (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CCB1FD7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:36:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FD5F6351D
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EAF2C433C8;
        Wed,  9 Aug 2023 11:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580971;
        bh=NcppRsAV0r2CxNwhBx1xRioA3ldRN6To9+yfWlxObek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iivz91Vr8U2gOGYYr6uOpADkgHCbp/B/o0xtDmQS4vVmEJyd9VGV0d/19uoQDEm4W
         edCB0v7UuFIWSDqbyzKjYjiLaXdRoKH0jfORzUhBCHP1lNySSCB6cOQurCdyVcd0vB
         Tgl6PQuvCqE9bXdPFqXct/0KN3fY+SXWj63oOiM4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 060/201] dm raid: clean up four equivalent goto tags in raid_ctr()
Date:   Wed,  9 Aug 2023 12:41:02 +0200
Message-ID: <20230809103645.850008655@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Yu Kuai <yukuai3@huawei.com>

[ Upstream commit e74c874eabe2e9173a8fbdad616cd89c70eb8ffd ]

There are four equivalent goto tags in raid_ctr(), clean them up to
use just one.

There is no functional change and this is preparation to fix
raid_ctr()'s unprotected md_stop().

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: 7d5fff8982a2 ("dm raid: protect md_stop() with 'reconfig_mutex'")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 27 +++++++++------------------
 1 file changed, 9 insertions(+), 18 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 1a25c8b01b6aa..f3a489b1b6e9a 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3258,8 +3258,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	r = md_start(&rs->md);
 	if (r) {
 		ti->error = "Failed to start raid array";
-		mddev_unlock(&rs->md);
-		goto bad_md_start;
+		goto bad_unlock;
 	}
 
 	/* If raid4/5/6 journal mode explicitly requested (only possible with journal dev) -> set it */
@@ -3267,8 +3266,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 		r = r5c_journal_mode_set(&rs->md, rs->journal_dev.mode);
 		if (r) {
 			ti->error = "Failed to set raid4/5/6 journal mode";
-			mddev_unlock(&rs->md);
-			goto bad_journal_mode_set;
+			goto bad_unlock;
 		}
 	}
 
@@ -3278,19 +3276,15 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	/* Try to adjust the raid4/5/6 stripe cache size to the stripe size */
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
-		if (r) {
-			mddev_unlock(&rs->md);
-			goto bad_stripe_cache;
-		}
+		if (r)
+			goto bad_unlock;
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
-		if (r) {
-			mddev_unlock(&rs->md);
-			goto bad_check_reshape;
-		}
+		if (r)
+			goto bad_unlock;
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3299,8 +3293,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
-				mddev_unlock(&rs->md);
-				goto bad_check_reshape;
+				goto bad_unlock;
 			}
 		}
 	}
@@ -3311,10 +3304,8 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	mddev_unlock(&rs->md);
 	return 0;
 
-bad_md_start:
-bad_journal_mode_set:
-bad_stripe_cache:
-bad_check_reshape:
+bad_unlock:
+	mddev_unlock(&rs->md);
 	md_stop(&rs->md);
 bad:
 	raid_set_free(rs);
-- 
2.40.1



