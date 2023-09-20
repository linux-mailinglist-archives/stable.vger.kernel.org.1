Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B94A47A7D3E
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235195AbjITMHw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235212AbjITMHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:07:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F756D8
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:07:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEE2C433C7;
        Wed, 20 Sep 2023 12:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695211663;
        bh=50i59VdnkDX4Aa7QX8dOrEVSu+9hZBH25fAOwi1JlrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X8aS2vMGTZGixfFb8Repw13na6JzW17+UdappOFgnmmXrKyrnqQzOFOhGliptctvm
         1Qwolg4U/cWaux+nSwvdn6EPlhGjEgU+t0OrelNLHIvi1r9zJ0lIMtIW4q+QmDFxlW
         +OAlrDhX5uO0SZ06dZfnE5ra9FXY9hLhTIq5Yydw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nigel Croxon <ncroxon@redhat.com>,
        Song Liu <song@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 177/186] md/raid1: fix error: ISO C90 forbids mixed declarations
Date:   Wed, 20 Sep 2023 13:31:20 +0200
Message-ID: <20230920112843.274460526@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nigel Croxon <ncroxon@redhat.com>

[ Upstream commit df203da47f4428bc286fc99318936416253a321c ]

There is a compile error when this commit is added:
md: raid1: fix potential OOB in raid1_remove_disk()

drivers/md/raid1.c: In function 'raid1_remove_disk':
drivers/md/raid1.c:1844:9: error: ISO C90 forbids mixed declarations
and code [-Werror=declaration-after-statement]
1844 |         struct raid1_info *p = conf->mirrors + number;
     |         ^~~~~~

That's because the new code was inserted before the struct.
The change is move the struct command above this commit.

Fixes: 8b0472b50bcf ("md: raid1: fix potential OOB in raid1_remove_disk()")
Signed-off-by: Nigel Croxon <ncroxon@redhat.com>
Signed-off-by: Song Liu <song@kernel.org>
Link: https://lore.kernel.org/r/46d929d0-2aab-4cf2-b2bf-338963e8ba5a@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/raid1.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
index 3e54b6639e213..7e37e4b2ec6ae 100644
--- a/drivers/md/raid1.c
+++ b/drivers/md/raid1.c
@@ -1775,12 +1775,11 @@ static int raid1_remove_disk(struct mddev *mddev, struct md_rdev *rdev)
 	struct r1conf *conf = mddev->private;
 	int err = 0;
 	int number = rdev->raid_disk;
+	struct raid1_info *p = conf->mirrors + number;
 
 	if (unlikely(number >= conf->raid_disks))
 		goto abort;
 
-	struct raid1_info *p = conf->mirrors + number;
-
 	if (rdev != p->rdev)
 		p = conf->mirrors + conf->raid_disks + number;
 
-- 
2.40.1



