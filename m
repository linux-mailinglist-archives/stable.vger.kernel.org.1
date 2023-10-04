Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F55C7B88B1
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjJDSS2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233410AbjJDSS1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:18:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48730A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:18:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49955C433C7;
        Wed,  4 Oct 2023 18:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443503;
        bh=NVxQyQ6voKiDlChAdKIzYNRzmn78HB3Ot2/9aeHPiFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m7ZY+qD4571gMMv5m5X9dKhfUYhw5RM/JLRSilTBcqLarJ7cC0NqKaSbY1kAEURNm
         IoAaU0VDvN08/c7pLpykoMenkaBwjXJ9PZmfmhfjOyaJTVmXzZ2UdXHLjU6lpM0rGi
         qHnAmkd+4hf/rY7Tm/jkmT4oYPZRJ/YQnkirMDJs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Borkmann <daniel@iogearbox.net>,
        Stanislav Fomichev <sdf@google.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 179/259] bpf: Clarify error expectations from bpf_clone_redirect
Date:   Wed,  4 Oct 2023 19:55:52 +0200
Message-ID: <20231004175225.506825606@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stanislav Fomichev <sdf@google.com>

[ Upstream commit 7cb779a6867fea00b4209bcf6de2f178a743247d ]

Commit 151e887d8ff9 ("veth: Fixing transmit return status for dropped
packets") exposed the fact that bpf_clone_redirect is capable of
returning raw NET_XMIT_XXX return codes.

This is in the conflict with its UAPI doc which says the following:
"0 on success, or a negative error in case of failure."

Update the UAPI to reflect the fact that bpf_clone_redirect can
return positive error numbers, but don't explicitly define
their meaning.

Reported-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230911194731.286342-1-sdf@google.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/bpf.h       | 4 +++-
 tools/include/uapi/linux/bpf.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 51b9aa640ad2a..53bc487947197 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1837,7 +1837,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Description
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 51b9aa640ad2a..53bc487947197 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1837,7 +1837,9 @@ union bpf_attr {
  * 		performed again, if the helper is used in combination with
  * 		direct packet access.
  * 	Return
- * 		0 on success, or a negative error in case of failure.
+ * 		0 on success, or a negative error in case of failure. Positive
+ * 		error indicates a potential drop or congestion in the target
+ * 		device. The particular positive error codes are not defined.
  *
  * u64 bpf_get_current_pid_tgid(void)
  * 	Description
-- 
2.40.1



