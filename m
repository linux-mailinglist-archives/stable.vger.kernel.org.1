Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9CF4755704
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjGPU4Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbjGPU4W (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:56:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2854EE58
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:56:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE14660EB0
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:56:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62C7C433C7;
        Sun, 16 Jul 2023 20:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540980;
        bh=MhWnvgjUa0GJERQ4HN7kdbji4IAM4pWddadrN0fUFlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PHap22rPmMFhwCrfTSqwdMzcvwh3GeSNgH9qMsnEbMGzjqiDqARUxr7vz2syGCjYE
         /zFcdT0D+Ar/v1WTcEKjskuPlvyjceulDhVu49U9S1wwOBN+6xzTAhT9rOEvpC5fmZ
         IOmnvD/KjCCwig1YFdCIrB2MzhsavSnARsxo+hp0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 519/591] dm ioctl: have constant on the right side of the test
Date:   Sun, 16 Jul 2023 21:50:58 +0200
Message-ID: <20230716194937.303692071@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 5cae0aa77397015f530aeb34f3ced32db6ac2875 ]

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Stable-dep-of: 249bed821b4d ("dm ioctl: Avoid double-fetch of version")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
index 2ced382cdd70b..6aeae095086d7 100644
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1819,8 +1819,8 @@ static int check_version(unsigned int cmd, struct dm_ioctl __user *user)
 	if (copy_from_user(version, user->version, sizeof(version)))
 		return -EFAULT;
 
-	if ((DM_VERSION_MAJOR != version[0]) ||
-	    (DM_VERSION_MINOR < version[1])) {
+	if ((version[0] != DM_VERSION_MAJOR) ||
+	    (version[1] > DM_VERSION_MINOR)) {
 		DMERR("ioctl interface mismatch: kernel(%u.%u.%u), user(%u.%u.%u), cmd(%d)",
 		      DM_VERSION_MAJOR, DM_VERSION_MINOR,
 		      DM_VERSION_PATCHLEVEL,
-- 
2.39.2



