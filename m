Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942E579BFA4
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354238AbjIKVxG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjIKOXD (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:23:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B48DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:22:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34BC8C433C7;
        Mon, 11 Sep 2023 14:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442178;
        bh=PxVLIXqJ+f0BQpkhfyPKwTEFM3b91lCU3+Ob2wiFEnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hd5q+Vd51F/zZagJuzvMXH1sLYs8IZCZZH6/bCJ6sO88liplgzUpB0M0d3+mfxp/T
         lqQH3LWqhCRGlL5uXVoKdVEaclJK9GmAko/V9oUMU86WVhJu2eqbWXYMwYgsGW4Uyo
         bHn8cbCBJYBEC+lBdVfqBkPjwkZSxRKN9ECeYPu0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Vijay Balakrishna <vijayb@linux.microsoft.com>,
        Kees Cook <keescook@chromium.org>,
        "Tyler Hicks (Microsoft)" <code@tyhicks.com>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 6.5 646/739] printk: ringbuffer: Fix truncating buffer size min_t cast
Date:   Mon, 11 Sep 2023 15:47:25 +0200
Message-ID: <20230911134709.152020452@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Kees Cook <keescook@chromium.org>

commit 53e9e33ede37a247d926db5e4a9e56b55204e66c upstream.

If an output buffer size exceeded U16_MAX, the min_t(u16, ...) cast in
copy_data() was causing writes to truncate. This manifested as output
bytes being skipped, seen as %NUL bytes in pstore dumps when the available
record size was larger than 65536. Fix the cast to no longer truncate
the calculation.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: John Ogness <john.ogness@linutronix.de>
Reported-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Link: https://lore.kernel.org/lkml/d8bb1ec7-a4c5-43a2-9de0-9643a70b899f@linux.microsoft.com/
Fixes: b6cf8b3f3312 ("printk: add lockless ringbuffer")
Cc: stable@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Tested-by: Vijay Balakrishna <vijayb@linux.microsoft.com>
Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com> # Steam Deck
Reviewed-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
Tested-by: Tyler Hicks (Microsoft) <code@tyhicks.com>
Reviewed-by: John Ogness <john.ogness@linutronix.de>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Signed-off-by: Petr Mladek <pmladek@suse.com>
Link: https://lore.kernel.org/r/20230811054528.never.165-kees@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/printk/printk_ringbuffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1735,7 +1735,7 @@ static bool copy_data(struct prb_data_ri
 	if (!buf || !buf_size)
 		return true;
 
-	data_size = min_t(u16, buf_size, len);
+	data_size = min_t(unsigned int, buf_size, len);
 
 	memcpy(&buf[0], data, data_size); /* LMM(copy_data:A) */
 	return true;


