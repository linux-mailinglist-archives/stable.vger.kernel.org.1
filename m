Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A18170C91C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbjEVTpU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:45:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjEVTpB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:45:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AB37119
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1B7EA62A3C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:44:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DBFC433EF;
        Mon, 22 May 2023 19:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784695;
        bh=A5cVwsx73lMpP6hlI3ekkuyMJI7zZZWgRvnobB8yFis=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hcq+CJGNdZe+zHDmrtn4t1IcrzR/Kn+wqa2J/gtCRjKWuKLgqh1X0t/ojf0k6WTPu
         rYb0mEM70NOenxwGkxZZ2gwJu209KJc9zh7N7pe2qFRLiQ/OZFhl3XLahpHoZ2EnzT
         9Btje6p6iiOTqu+pqqs1mpEX5OekVmEI9jsKmGyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Zeng <zenghao@kylinos.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 171/364] recordmcount: Fix memory leaks in the uwrite function
Date:   Mon, 22 May 2023 20:07:56 +0100
Message-Id: <20230522190417.001480567@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hao Zeng <zenghao@kylinos.cn>

[ Upstream commit fa359d068574d29e7d2f0fdd0ebe4c6a12b5cfb9 ]

Common realloc mistake: 'file_append' nulled but not freed upon failure

Link: https://lkml.kernel.org/r/20230426010527.703093-1-zenghao@kylinos.cn

Signed-off-by: Hao Zeng <zenghao@kylinos.cn>
Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/recordmcount.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scripts/recordmcount.c b/scripts/recordmcount.c
index e30216525325b..40ae6b2c7a6da 100644
--- a/scripts/recordmcount.c
+++ b/scripts/recordmcount.c
@@ -110,6 +110,7 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 {
 	size_t cnt = count;
 	off_t idx = 0;
+	void *p = NULL;
 
 	file_updated = 1;
 
@@ -117,7 +118,10 @@ static ssize_t uwrite(void const *const buf, size_t const count)
 		off_t aoffset = (file_ptr + count) - file_end;
 
 		if (aoffset > file_append_size) {
-			file_append = realloc(file_append, aoffset);
+			p = realloc(file_append, aoffset);
+			if (!p)
+				free(file_append);
+			file_append = p;
 			file_append_size = aoffset;
 		}
 		if (!file_append) {
-- 
2.39.2



