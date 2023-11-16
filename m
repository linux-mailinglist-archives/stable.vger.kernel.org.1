Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D9197ED834
	for <lists+stable@lfdr.de>; Thu, 16 Nov 2023 00:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjKOXa4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 18:30:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjKOXaw (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 18:30:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E497198;
        Wed, 15 Nov 2023 15:30:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6400C433CB;
        Wed, 15 Nov 2023 23:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1700091048;
        bh=rr3CR0U/b/jAQxw4XuBWJ+U7nO79yMIcVVO7bvi3L1o=;
        h=Date:To:From:Subject:From;
        b=daVki2TcNz7ef6UBNPweU+6DTOYagp4iSTgXY+mVwVfM9aOQU+thkgv+KM3KjoMlS
         iqqRIZohDQFbrAYrpERjBqiyW7lD3N62ov9QxC7pFxIyalbiSCwVp+BuM2ZUf7TpLi
         llKunp5i+V0h7NF38n0zlaOGUQBHiyj2JLWOmc8A=
Date:   Wed, 15 Nov 2023 15:30:48 -0800
To:     mm-commits@vger.kernel.org, stable@vger.kernel.org, sj@kernel.org,
        akpm@linux-foundation.org
From:   Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-sysfs-check-error-from-damon_sysfs_update_target.patch removed from -mm tree
Message-Id: <20231115233048.B6400C433CB@smtp.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The quilt patch titled
     Subject: mm/damon/sysfs: check error from damon_sysfs_update_target()
has been removed from the -mm tree.  Its filename was
     mm-damon-sysfs-check-error-from-damon_sysfs_update_target.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: SeongJae Park <sj@kernel.org>
Subject: mm/damon/sysfs: check error from damon_sysfs_update_target()
Date: Mon, 6 Nov 2023 23:34:06 +0000

Patch series "mm/damon/sysfs: fix unhandled return values".

Some of DAMON sysfs interface code is not handling return values from some
functions.  As a result, confusing user input handling or NULL-dereference
is possible.  Check those properly.


This patch (of 3):

damon_sysfs_update_target() returns error code for failures, but its
caller, damon_sysfs_set_targets() is ignoring that.  The update function
seems making no critical change in case of such failures, but the behavior
will look like DAMON sysfs is silently ignoring or only partially
accepting the user input.  Fix it.

Link: https://lkml.kernel.org/r/20231106233408.51159-1-sj@kernel.org
Link: https://lkml.kernel.org/r/20231106233408.51159-2-sj@kernel.org
Fixes: 19467a950b49 ("mm/damon/sysfs: remove requested targets when online-commit inputs")
Signed-off-by: SeongJae Park <sj@kernel.org>
Cc: <stable@vger.kernel.org>	[5.19+]
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/damon/sysfs.c~mm-damon-sysfs-check-error-from-damon_sysfs_update_target
+++ a/mm/damon/sysfs.c
@@ -1203,8 +1203,10 @@ static int damon_sysfs_set_targets(struc
 
 	damon_for_each_target_safe(t, next, ctx) {
 		if (i < sysfs_targets->nr) {
-			damon_sysfs_update_target(t, ctx,
+			err = damon_sysfs_update_target(t, ctx,
 					sysfs_targets->targets_arr[i]);
+			if (err)
+				return err;
 		} else {
 			if (damon_target_has_pid(ctx))
 				put_pid(t->pid);
_

Patches currently in -mm which might be from sj@kernel.org are


