Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF72577D17D
	for <lists+stable@lfdr.de>; Tue, 15 Aug 2023 20:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234958AbjHOSHK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 15 Aug 2023 14:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237657AbjHOSHF (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 Aug 2023 14:07:05 -0400
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DDC41987
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 11:07:04 -0700 (PDT)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-68732996d32so10157838b3a.3
        for <stable@vger.kernel.org>; Tue, 15 Aug 2023 11:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692122824; x=1692727624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzlqVQrvz1LgR4zEI0c7q19btoRHqsnter3MWimoxGE=;
        b=hiG8r7vPGqJNmNnWdDT9KHbb9KQdwVUQGMlS3dO6/2ADa5Eit6K3IeYEKLkEJWL6ni
         HVNl4DsZikpjBn6rR5Dxj2/INtElRybVMIKBl+XVSjgUQNHgvsVQY1vC8pFNyC4ae2vF
         XtmiWUDthUcSeyungNkTDq8xXJJdwPms+Yjchjy6bHcshtQMWmrYzrwRMTcgjyK2CPcx
         e86QXndoI6yBstB60XMtDBnimtFEg+M6YBo3mK8VU+w1WpAWXXCR8/IPDiFIC/f2jtgu
         vPT5cmzE+bi2AXREOAN2gSs4zIDgJSoEf0NFqI1gXKLVTSCmmsRomzGJyIHJmml1GDz0
         Pa1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692122824; x=1692727624;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzlqVQrvz1LgR4zEI0c7q19btoRHqsnter3MWimoxGE=;
        b=Ma6ZKQrIczmpjI7NGoEOlh2k5ecLfPcPSTerAMWfgZZG+l5uPFDNrxMpPwmnwGPl+o
         Wdx5dvaPgNvoCHBLPyx4/Ak19FXDw9E85JCVn6A8s0v4FgJrVqXMPRlHwjET6up8YTAX
         BIS3jNHz0GRO4ey1JnM3l+mmf1N1z78hwBv7xEdHzGNz04z+m7gSmQwESOKWLoOYpSx+
         xPhHEf4I4JSvqEaUyDvV6TV79UFQqY+Cz3x6SUUFIXDqCE8rtj84KwJd0vdfcJ8inJ1n
         iG5Q2oqqsV3EQ1iLlftZopQy3/k+U23ZcqNbFCL0sVN8zFmdS8/Nz3nhI8cZ9gx/mWP0
         C4IQ==
X-Gm-Message-State: AOJu0Yy1jSDIghQI8+ZW1PaeL+3IuCvZAG8P9sLmv6BZ/GdUW1lMJYgM
        6CfU0oyqMYwnGQycBQpBdnb6arT+DFgcZSVAnzwra2toTn7Bjyygee0PrSvEDnUZPEPBQ5ixm4K
        pUFuvYUQ7Y/NqaH0dTbDuKc2gAlMVtJWs/tG5WsmlwayCNEJOmVlsJ/GV+XeU68slvPU=
X-Google-Smtp-Source: AGHT+IFCfr4RjMfwdl7ViWc4OoIvxbxXoIYX5CJHfWNKEzrjjI1q0NtHNi/76Hj6tC9JGv96jWvg6pPtgelaHg==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a05:6a00:3a27:b0:687:94c2:106 with SMTP
 id fj39-20020a056a003a2700b0068794c20106mr6734231pfb.5.1692122823696; Tue, 15
 Aug 2023 11:07:03 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:05:21 +0000
In-Reply-To: <2023081201-exhale-bonelike-1800@gregkh>
Mime-Version: 1.0
References: <2023081201-exhale-bonelike-1800@gregkh>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230815180521.1049900-1-cmllamas@google.com>
Subject: [PATCH 4.14.y] binder: fix memory leak in binder_init()
From:   Carlos Llamas <cmllamas@google.com>
To:     stable@vger.kernel.org
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Carlos Llamas <cmllamas@google.com>,
        stable <stable@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Qi Zheng <zhengqi.arch@bytedance.com>

commit adb9743d6a08778b78d62d16b4230346d3508986 upstream.

In binder_init(), the destruction of binder_alloc_shrinker_init() is not
performed in the wrong path, which will cause memory leaks. So this commit
introduces binder_alloc_shrinker_exit() and calls it in the wrong path to
fix that.

Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
Acked-by: Carlos Llamas <cmllamas@google.com>
Fixes: f2517eb76f1f ("android: binder: Add global lru shrinker to binder")
Cc: stable <stable@kernel.org>
Link: https://lore.kernel.org/r/20230625154937.64316-1-qi.zheng@linux.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[cmllamas: resolved trivial merge conflicts]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder.c       | 1 +
 drivers/android/binder_alloc.c | 6 ++++++
 drivers/android/binder_alloc.h | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index c07a304af8a3..95c9f81a514a 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5658,6 +5658,7 @@ static int __init binder_init(void)
 
 err_alloc_device_names_failed:
 	debugfs_remove_recursive(binder_debugfs_dir_entry_root);
+	binder_alloc_shrinker_exit();
 
 	return ret;
 }
diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 1687368ea71f..f7f0b71c9f68 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -1033,3 +1033,9 @@ void binder_alloc_shrinker_init(void)
 	list_lru_init(&binder_alloc_lru);
 	register_shrinker(&binder_shrinker);
 }
+
+void binder_alloc_shrinker_exit(void)
+{
+	unregister_shrinker(&binder_shrinker);
+	list_lru_destroy(&binder_alloc_lru);
+}
diff --git a/drivers/android/binder_alloc.h b/drivers/android/binder_alloc.h
index a3ad7683b6f2..7efcb46c0083 100644
--- a/drivers/android/binder_alloc.h
+++ b/drivers/android/binder_alloc.h
@@ -128,6 +128,7 @@ extern struct binder_buffer *binder_alloc_new_buf(struct binder_alloc *alloc,
 						  int is_async);
 extern void binder_alloc_init(struct binder_alloc *alloc);
 void binder_alloc_shrinker_init(void);
+extern void binder_alloc_shrinker_exit(void);
 extern void binder_alloc_vma_close(struct binder_alloc *alloc);
 extern struct binder_buffer *
 binder_alloc_prepare_to_free(struct binder_alloc *alloc,
-- 
2.41.0.694.ge786442a9b-goog

