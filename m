Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499C47BE1A3
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbjJINw1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377453AbjJINw0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:52:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF241B9
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:52:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5EBC433C8;
        Mon,  9 Oct 2023 13:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696859544;
        bh=xkBv8x1uVWv5XW3CGAbQT0MF/FyjjN+CBj/D54XZiFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b2rxO3OP57krjrFuarHc0UQnDnIjiJpA6m+ZenYCx6LkU5VHMY63VTW01nue/f33j
         qVmrXCoAPlLN6BdkJMVmG2wYQ6NdMAJlyD9rSMp8P8hIU+pRNkNPXY4wlOvSl8m6cC
         hmC3DbJdSgDmPfVGUZsJr8k9LeCOrhlhToWNl8bs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, mhiramat@kernel.org,
        Zheng Yejian <zhengyejian1@huawei.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/91] ring-buffer: Avoid softlockup in ring_buffer_resize()
Date:   Mon,  9 Oct 2023 15:06:09 +0200
Message-ID: <20231009130112.816856260@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130111.518916887@linuxfoundation.org>
References: <20231009130111.518916887@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
index c8a7de7a1d635..320aa60664dc9 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1753,6 +1753,8 @@ int ring_buffer_resize(struct ring_buffer *buffer, unsigned long size,
 				err = -ENOMEM;
 				goto out_err;
 			}
+
+			cond_resched();
 		}
 
 		get_online_cpus();
-- 
2.40.1



