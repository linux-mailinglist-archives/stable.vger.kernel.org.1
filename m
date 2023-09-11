Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6C579AD80
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355364AbjIKV55 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbjIKOXO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:23:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450D7DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:23:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C04EC433C7;
        Mon, 11 Sep 2023 14:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442189;
        bh=fQvMRimz4XO5aLrtd3aM1OOsSou3OSPLGafczgZSATs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iLXwlzEgGhV2iaaCw7XNRbKUueLtAIan5SClTASeAcVDXR4WUKZL0pU/OaBpZ0ZAc
         Wjj6FLGBS4JBg/aiR8nFErbPY15VRj4WHG8rRAnsF4wklIQEv1MAHN1At8caIpTVco
         ij1ZWjUqefiTfq6APK0nkxJJOCW3q8lDnd1mQWyc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Ding Xiang <dingxiang@cmss.chinamobile.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
Subject: [PATCH 6.5 678/739] selftests/landlock: Fix a resource leak
Date:   Mon, 11 Sep 2023 15:47:57 +0200
Message-ID: <20230911134710.037246531@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ding Xiang <dingxiang@cmss.chinamobile.com>

commit 2a2015495142ee0a35711b5dcf7b215c31489f27 upstream.

The opened file should be closed before return, otherwise resource leak
will occur.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20230830101148.3738-1-dingxiang@cmss.chinamobile.com
Fixes: 3de64b656b3c ("selftests/landlock: Add supports_filesystem() helper")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/landlock/fs_test.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -113,7 +113,7 @@ static bool supports_filesystem(const ch
 {
 	char str[32];
 	int len;
-	bool res;
+	bool res = true;
 	FILE *const inf = fopen("/proc/filesystems", "r");
 
 	/*
@@ -125,14 +125,16 @@ static bool supports_filesystem(const ch
 
 	/* filesystem can be null for bind mounts. */
 	if (!filesystem)
-		return true;
+		goto out;
 
 	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
 	if (len >= sizeof(str))
 		/* Ignores too-long filesystem names. */
-		return true;
+		goto out;
 
 	res = fgrep(inf, str);
+
+out:
 	fclose(inf);
 	return res;
 }


