Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC2E1726B89
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjFGU0X (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbjFGU0Q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:26:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D2D19BB
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F24F864444
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:25:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1253EC433EF;
        Wed,  7 Jun 2023 20:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169535;
        bh=HoD8pfnSJ9bfKM/4PbrabivCPKLDimTR4j8uvKoaaYg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=glLOybQESyiCjgo9FKoLyUNcnD000SA8ffIACSKEx6eIZIRsU6UGB2B9n/Agzxa7o
         ybvcLu9WOsp/mgJ944Ce7qvHltc0/Db3aiBTkhFIsyMQ+RqEVT276xEWPVJLkFbfzM
         1nbxL1kC28jyrqsEFvTJJ580QszqA23mIrQNTxIo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Zeng <zenghao@kylinos.cn>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 117/286] cpupower:Fix resource leaks in sysfs_get_enabled()
Date:   Wed,  7 Jun 2023 22:13:36 +0200
Message-ID: <20230607200926.906855767@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit e652be0f59d4ba4d5c636b1f7f4dcb73aae049fa ]

The sysfs_get_enabled() opened file processor not closed,
may cause a file handle leak.
Putting error handling and resource cleanup code together
makes the code easy to maintain and read.
Removed the unnecessary else if branch from the original
function, as it should return an error in cases other than '0'.

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/power/cpupower/lib/powercap.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/tools/power/cpupower/lib/powercap.c b/tools/power/cpupower/lib/powercap.c
index 0ce29ee4c2e46..a7a59c6bacda8 100644
--- a/tools/power/cpupower/lib/powercap.c
+++ b/tools/power/cpupower/lib/powercap.c
@@ -40,25 +40,34 @@ static int sysfs_get_enabled(char *path, int *mode)
 {
 	int fd;
 	char yes_no;
+	int ret = 0;
 
 	*mode = 0;
 
 	fd = open(path, O_RDONLY);
-	if (fd == -1)
-		return -1;
+	if (fd == -1) {
+		ret = -1;
+		goto out;
+	}
 
 	if (read(fd, &yes_no, 1) != 1) {
-		close(fd);
-		return -1;
+		ret = -1;
+		goto out_close;
 	}
 
 	if (yes_no == '1') {
 		*mode = 1;
-		return 0;
+		goto out_close;
 	} else if (yes_no == '0') {
-		return 0;
+		goto out_close;
+	} else {
+		ret = -1;
+		goto out_close;
 	}
-	return -1;
+out_close:
+	close(fd);
+out:
+	return ret;
 }
 
 int powercap_get_enabled(int *mode)
-- 
2.39.2



