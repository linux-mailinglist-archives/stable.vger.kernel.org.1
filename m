Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C2076F095
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjHCR1E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 13:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234713AbjHCR1C (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 13:27:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183CB2D65
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 10:27:01 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-584375eacacso13157077b3.0
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 10:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083620; x=1691688420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EHpUmzrQnDN6BdHRPVO0KcfDXP0OZ5FbBAepEsSX9Ig=;
        b=qxsXQyRbVAeRELuUUtKrCwywC6QQTi8GHNRwTQUgqwaMaE06n28e21MqPJCBZOSeOT
         Qdy3T1xm+nWsar3PElAyHH4XRbnbh/juQv6pT24VIx/hmG68SRWkDtgsWgv0Vbw+Xq4b
         +9kLmoit9sN1/gZfKklOc8XhcuoYMFvLaSeXIo/wdsXcRNSNRVLSqWMC8fCCM8aUcWcB
         aDSUJ5MX9993h31MPorj7ATaoVZTKC0TIpSNDyVZs/SHr6qPtsnYQt8mS3zlcdzRn4PP
         n6WROk+TAqngChxc1yRkKMEU0NvNbIWVZIRUByrfXNiHMt2U5V4plrf6i9OLozdZrkBK
         n96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083620; x=1691688420;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHpUmzrQnDN6BdHRPVO0KcfDXP0OZ5FbBAepEsSX9Ig=;
        b=OaG7hKgO8nxxpQzd+nJJF8Dc4uNreKQRqmSDcMzolEA3L72tbOCGJWIrRrIOzk7PNb
         LWrlhJoxhdEZNiLucyIWzjnwzhm2ESsEUWkETOMlaja2UusMC0VaHdKNC9Y3mfLSkqFE
         uzOh83fR2je6SYOVjPEYTF3Sc5zvH/ZGAfEyROE/BuKCniNTJJee86enbK180M+8V30f
         CqyJ2g8hZlSJFC1Cwqlo9/QbVLwKWGhixysneoJXIXoc/GBgnFbsqiEpIWhB4Wir7uiZ
         tQ8t2rNkd8OT90mGCzgYwQha2YNiSx8IU0uO8SecCPLOtCw/CPevi3JiE+LUVGCDAPBv
         dFCQ==
X-Gm-Message-State: ABy/qLZte9FshPmZne3Zgr3v9bJjesZtml4KifGb4I9D5ach8bUY4VjV
        qb0t4SvBEpTtFrHmmG773nXPBZlDFjE=
X-Google-Smtp-Source: APBJJlFJcCahjdAYX9Zx+DEl8b9H6rEwuNU2P9eGDfvhDJtLw9lJ/qnx3rNt/z46v/MM98tnx4xoFSOUp3s=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3dec:ef9e:7bf4:7a6])
 (user=surenb job=sendgmr) by 2002:a81:c509:0:b0:573:87b9:7ee9 with SMTP id
 k9-20020a81c509000000b0057387b97ee9mr191557ywi.4.1691083620320; Thu, 03 Aug
 2023 10:27:00 -0700 (PDT)
Date:   Thu,  3 Aug 2023 10:26:47 -0700
In-Reply-To: <20230803172652.2849981-1-surenb@google.com>
Mime-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803172652.2849981-3-surenb@google.com>
Subject: [PATCH v3 2/6] mm: for !CONFIG_PER_VMA_LOCK equate write lock
 assertion for vma and mmap
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

When CONFIG_PER_VMA_LOCK=n, vma_assert_write_locked() should be equivalent
to mmap_assert_write_locked().

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 include/linux/mm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 406ab9ea818f..262b5f44101d 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -750,7 +750,8 @@ static inline void vma_end_read(struct vm_area_struct *vma) {}
 static inline void vma_start_write(struct vm_area_struct *vma) {}
 static inline bool vma_try_start_write(struct vm_area_struct *vma)
 		{ return true; }
-static inline void vma_assert_write_locked(struct vm_area_struct *vma) {}
+static inline void vma_assert_write_locked(struct vm_area_struct *vma)
+		{ mmap_assert_write_locked(vma->vm_mm); }
 static inline void vma_mark_detached(struct vm_area_struct *vma,
 				     bool detached) {}
 
-- 
2.41.0.585.gd2178a4bd4-goog

