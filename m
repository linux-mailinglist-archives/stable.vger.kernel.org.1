Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921237BE12E
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377487AbjJINrr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376774AbjJINrp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:47:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250FDD3
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:47:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636D7C433C7;
        Mon,  9 Oct 2023 13:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859263;
        bh=sbwbeoHwQnDZHh9oMYq2xi+LZksT42TLSVxizUNakbU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqtWjDeptYhThhtfyn+hKBksNMC6p8Tvqz2bSbR4LRPX7hSeILYPx3V9irHnkpE1/
         FN2Y3stt+2xFNhK0BAMhtrqtm66rqOyQT1rONrKUOhQrAOlgtg4AvrvnhBG/zL4MDU
         IcHl17vqO2sfI4c6xFJftLxumTrSZFxpMqbAm+Gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 15/55] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date:   Mon,  9 Oct 2023 15:06:14 +0200
Message-ID: <20231009130108.296164989@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130107.717692466@linuxfoundation.org>
References: <20231009130107.717692466@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zheng Yejian <zhengyejian1@huawei.com>

[ Upstream commit f6bd2c92488c30ef53b5bd80c52f0a7eee9d545a ]

When user resize all trace ring buffer through file 'buffer_size_kb',
then in ring_buffer_resize(), kernel allocates buffer pages for each
cpu in a loop.

If the kernel preemption model is PREEMPT_NONE and there are many cpus
and there are many buffer pages to be allocated, it may not give up cpu
for a long time and finally cause a softlockup.

To avoid it, call cond_resched() after each cpu buffer allocation.

Link: https://lore.kernel.org/linux-trace-kernel/20230906081930.3939106-1-zhengyejian1@huawei.com

Cc: <mhiramat@kernel.org>
Signed-off-by: Zheng Yejian <zhengyejian1@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1949d7bbe145d..f0d4ff2db2ef0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1686,6 +1686,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
-- 
2.40.1



