Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8088E7556C4
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbjGPUxw (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjGPUxv (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91E2E41
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 556DD60DFD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68178C433C7;
        Sun, 16 Jul 2023 20:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540829;
        bh=71tj3icSu+aIy/1IuQ0gm8OMglN5UvEHtdqd/b0Fg1U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2uDGIBvDA3uNidt9xoqvHv4B2lWAR7yUbZxJW5Y8HkqRQAH8KDI/X6CiwRarI9wHl
         0R3+LTK6ptRYcJOH7eYmsh8/j57QAdKDEP+sdWIZRiZ3fL0ffOIpmgmGoXwfW3q0w5
         wsRCNBkyKlQ25eN8iXQSyjRU8POu2C88Z4HrOY2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 503/591] bpf, btf: Warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date:   Sun, 16 Jul 2023 21:50:42 +0200
Message-ID: <20230716194936.905452214@linuxfoundation.org>
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

From: SeongJae Park <sj@kernel.org>

[ Upstream commit 3de4d22cc9ac7c9f38e10edcf54f9a8891a9c2aa ]

__register_btf_kfunc_id_set() assumes .BTF to be part of the module's .ko
file if CONFIG_DEBUG_INFO_BTF is enabled. If that's not the case, the
function prints an error message and return an error. As a result, such
modules cannot be loaded.

However, the section could be stripped out during a build process. It would
be better to let the modules loaded, because their basic functionalities
have no problem [0], though the BTF functionalities will not be supported.
Make the function to lower the level of the message from error to warn, and
return no error.

  [0] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion

Fixes: c446fdacb10d ("bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF")
Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com
Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion
Link: https://lore.kernel.org/bpf/20230701171447.56464-1-sj@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/btf.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 8220caa488c54..fb78bb26786fc 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -7469,10 +7469,8 @@ int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
 			pr_err("missing vmlinux BTF, cannot register kfuncs\n");
 			return -ENOENT;
 		}
-		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)) {
-			pr_err("missing module BTF, cannot register kfuncs\n");
-			return -ENOENT;
-		}
+		if (kset->owner && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+			pr_warn("missing module BTF, cannot register kfuncs\n");
 		return 0;
 	}
 	if (IS_ERR(btf))
-- 
2.39.2



