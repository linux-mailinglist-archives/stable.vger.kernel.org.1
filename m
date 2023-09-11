Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD56879C0CF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353524AbjIKVri (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240050AbjIKOfB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:35:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4796F2
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:34:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A6CC433C7;
        Mon, 11 Sep 2023 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442897;
        bh=yNO1s/m6GoOGn7CueTssnayVx5bg3QY6hUC/ce0PnRE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lODSXDRHbD5ZuReUezvEph9PO7vC7H4ShNjZ0JRidWMgU5OvSJuVm4DTkPIifnc/f
         TQ7nxLBg8BpiVe2lpDeepM60gs476cnEXj+VlczXKOmXugtsL9b+JmRINHuBWeios3
         FnK3rWmF5ZpdjLk7OU9n44P7hMDwji29rn/xQfLc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kui-Feng Lee <thinker.li@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 187/737] bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
Date:   Mon, 11 Sep 2023 15:40:46 +0200
Message-ID: <20230911134655.799687171@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kui-Feng Lee <thinker.li@gmail.com>

[ Upstream commit 5426700e6841bf72e652e34b5cec68eadf442435 ]

Verify if the pointer obtained from bpf_xdp_pointer() is either an error or
NULL before returning it.

The function bpf_dynptr_slice() mistakenly returned an ERR_PTR. Instead of
solely checking for NULL, it should also verify if the pointer returned by
bpf_xdp_pointer() is an error or NULL.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/bpf/d1360219-85c3-4a03-9449-253ea905f9d1@moroto.mountain/
Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
Acked-by: Yonghong Song <yonghong.song@linux.dev>
Link: https://lore.kernel.org/r/20230803231206.1060485-1-thinker.li@gmail.com
Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index f12565ba136b0..8c5daa841704b 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2218,7 +2218,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
-		if (xdp_ptr)
+		if (!IS_ERR_OR_NULL(xdp_ptr))
 			return xdp_ptr;
 
 		bpf_xdp_copy_buf(ptr->data, ptr->offset + offset, buffer, len, false);
-- 
2.40.1



