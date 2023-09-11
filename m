Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D37D79AF69
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239574AbjIKUzG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 16:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbjIKOHu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:07:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D862AE40
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:07:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BCB1C433C8;
        Mon, 11 Sep 2023 14:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441265;
        bh=SGuD7jkWU9loaBn9EbIHOU3HJARe0U/NXxBk9SSgLZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTMS9bqyVt2Rc6JOQ9F3BqQyOixo0/n67YIDzNnF5xoLz4ju7J2cD3BdBo3A72hIZ
         5vrRh4Rw5hLFhGBqkCj0erHbSlX/TtzFaUS9hRlLkAOaPKk/1VKODQp/51iGYr6dgP
         Nc1EG3Jn6U5zzKV+DPomkYnehtjnK/ley1iwCZ7Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Igor Pylypiv <ipylypiv@google.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 353/739] block: uapi: Fix compilation errors using ioprio.h with C++
Date:   Mon, 11 Sep 2023 15:42:32 +0200
Message-ID: <20230911134700.983814474@linuxfoundation.org>
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

From: Damien Le Moal <dlemoal@kernel.org>

[ Upstream commit c7b4b23b36edf32239e7fc3b922797ff1d32b072 ]

The use of the "class" argument name in the ioprio_value() inline
function in include/uapi/linux/ioprio.h confuses C++ compilers
resulting in compilation errors such as:

/usr/include/linux/ioprio.h:110:43: error: expected primary-expression before ‘int’
  110 | static __always_inline __u16 ioprio_value(int class, int level, int hint)
      |                                           ^~~

for user C++ programs including linux/ioprio.h.

Avoid these errors by renaming the arguments of the ioprio_value()
function to prioclass, priolevel and priohint. For consistency, the
arguments of the IOPRIO_PRIO_VALUE() and IOPRIO_PRIO_VALUE_HINT() macros
are also renamed in the same manner.

Reported-by: Igor Pylypiv <ipylypiv@google.com>
Fixes: 01584c1e2337 ("scsi: block: Improve ioprio value validity checks")
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Igor Pylypiv <ipylypiv@google.com>
Link: https://lore.kernel.org/r/20230814215833.259286-1-dlemoal@kernel.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/ioprio.h | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
index 99440b2e8c352..bee2bdb0eedbc 100644
--- a/include/uapi/linux/ioprio.h
+++ b/include/uapi/linux/ioprio.h
@@ -107,20 +107,21 @@ enum {
 /*
  * Return an I/O priority value based on a class, a level and a hint.
  */
-static __always_inline __u16 ioprio_value(int class, int level, int hint)
+static __always_inline __u16 ioprio_value(int prioclass, int priolevel,
+					  int priohint)
 {
-	if (IOPRIO_BAD_VALUE(class, IOPRIO_NR_CLASSES) ||
-	    IOPRIO_BAD_VALUE(level, IOPRIO_NR_LEVELS) ||
-	    IOPRIO_BAD_VALUE(hint, IOPRIO_NR_HINTS))
+	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
+	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
+	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
 		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
 
-	return (class << IOPRIO_CLASS_SHIFT) |
-		(hint << IOPRIO_HINT_SHIFT) | level;
+	return (prioclass << IOPRIO_CLASS_SHIFT) |
+		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
 }
 
-#define IOPRIO_PRIO_VALUE(class, level)			\
-	ioprio_value(class, level, IOPRIO_HINT_NONE)
-#define IOPRIO_PRIO_VALUE_HINT(class, level, hint)	\
-	ioprio_value(class, level, hint)
+#define IOPRIO_PRIO_VALUE(prioclass, priolevel)			\
+	ioprio_value(prioclass, priolevel, IOPRIO_HINT_NONE)
+#define IOPRIO_PRIO_VALUE_HINT(prioclass, priolevel, priohint)	\
+	ioprio_value(prioclass, priolevel, priohint)
 
 #endif /* _UAPI_LINUX_IOPRIO_H */
-- 
2.40.1



