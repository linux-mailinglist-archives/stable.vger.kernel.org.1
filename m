Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA92A76AD43
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjHAJ1i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232934AbjHAJ1E (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:27:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85251FE2
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:26:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B66261504
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:26:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88908C433C7;
        Tue,  1 Aug 2023 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690881964;
        bh=toYJ/CO/OMrBMvBx85taIAekcQ7y1dZXKrYDaxLLK8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FR4/bj26EY5wjFvUEPXJgo5LGmjjxdcAwbmQMiYj463XsZli1BpAKV5ioBCzXA1XN
         BU718KkbEECAzoKRTFV7tgjulkQl14L4qIoQJa7UQhtvoG35Y+EOVvtMsXE3umHKLg
         XugkpApIb6bHXD1j7nBoVu658xbwbsQCU4UgzAjQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yu Kuai <yukuai3@huawei.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 093/155] dm raid: fix missing reconfig_mutex unlock in raid_ctr() error paths
Date:   Tue,  1 Aug 2023 11:20:05 +0200
Message-ID: <20230801091913.501306931@linuxfoundation.org>
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

[ Upstream commit bae3028799dc4f1109acc4df37c8ff06f2d8f1a0 ]

In the error paths 'bad_stripe_cache' and 'bad_check_reshape',
'reconfig_mutex' is still held after raid_ctr() returns.

Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index eba277bb8a1f1..d3ac3b894bdf5 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3278,15 +3278,19 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	/* Try to adjust the raid4/5/6 stripe cache size to the stripe size */
 	if (rs_is_raid456(rs)) {
 		r = rs_set_raid456_stripe_cache(rs);
-		if (r)
+		if (r) {
+			mddev_unlock(&rs->md);
 			goto bad_stripe_cache;
+		}
 	}
 
 	/* Now do an early reshape check */
 	if (test_bit(RT_FLAG_RESHAPE_RS, &rs->runtime_flags)) {
 		r = rs_check_reshape(rs);
-		if (r)
+		if (r) {
+			mddev_unlock(&rs->md);
 			goto bad_check_reshape;
+		}
 
 		/* Restore new, ctr requested layout to perform check */
 		rs_config_restore(rs, &rs_layout);
@@ -3295,6 +3299,7 @@ static int raid_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 			r = rs->md.pers->check_reshape(&rs->md);
 			if (r) {
 				ti->error = "Reshape check failed";
+				mddev_unlock(&rs->md);
 				goto bad_check_reshape;
 			}
 		}
-- 
2.40.1



