Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57F5B79B750
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbjIKWrX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbjIKN5k (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:57:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81AE5CD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C306BC433C9;
        Mon, 11 Sep 2023 13:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440656;
        bh=zNs9SatSEwXaFDGbxX/ytRZawcLCZfOEXWuSSSIdgKQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mE46kBK48QYkow812/Uyf5JrG4atKISzecb6mzKvKQuVHx3NcHcAJulayKRhfOkvP
         BKs8Lni7ql1orQdZ3rntu0vMA0eok8iiQzKgZokos1AbGWLKrzWieCUSCXcNLmh1vP
         HQr9/ZOnSMmOzeHZBGpi8fZ1RraMWsHUbTxsE/oE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kui-Feng Lee <thinker.li@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 111/739] bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.
Date:   Mon, 11 Sep 2023 15:38:30 +0200
Message-ID: <20230911134654.200582684@linuxfoundation.org>
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
index 9e80efa59a5d6..8812397a5cd96 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -2243,7 +2243,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
 	case BPF_DYNPTR_TYPE_XDP:
 	{
 		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
-		if (xdp_ptr)
+		if (!IS_ERR_OR_NULL(xdp_ptr))
 			return xdp_ptr;
 
 		if (!buffer__opt)
-- 
2.40.1



