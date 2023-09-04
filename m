Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0587917AA
	for <lists+stable@lfdr.de>; Mon,  4 Sep 2023 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjIDM6E (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 4 Sep 2023 08:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236868AbjIDM6D (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 4 Sep 2023 08:58:03 -0400
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFB0CD1
        for <stable@vger.kernel.org>; Mon,  4 Sep 2023 05:57:59 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2bcbfb3705dso21559221fa.1
        for <stable@vger.kernel.org>; Mon, 04 Sep 2023 05:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693832277; x=1694437077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kP6axYWQh7IIQgU34+jYVnXWJpapDY8Z6JPbK/ak5xE=;
        b=gDjq22vJpnlJR+oFDxD5aMJwXFmCSKlS362vy4gBAP+bEXJt8k/bflTpQQTyVfP8uu
         kHsy/qFWAJLJzCa/wOV/1F2xDzui68jyVpqScJ+GeW7UDVqznXxqg8ExkSklPH2Jw0dO
         IjNgC54vtSaVR6PUb9szsIxq/pHFMOm3ryMPwCER+iv2XCxWVgMasNf4li5qzoUDk28p
         Dmo+Gl+3HFlhYpO7DAgeQUOaCHCLBRhaXKJ/ua77nmMVeP7Ezf63+bDAAQAqzAC5jXMv
         Oi57JadQkQIrrkgnRBlEW9EEVyIkvFlvnOeKBpoz/1hOyXiNSmzNrspj983Yj1DuwCbL
         9/xA==
X-Gm-Message-State: AOJu0YxmXpoMUaX8oKrd4tGlHLHA58usXcESbmZYTTv4wIIs3TLX75xJ
        mX+QsXUhvA16BqKB0Tr0sPk=
X-Google-Smtp-Source: AGHT+IEwXj2VGEnU3VSX+SaG8doejrnx//uDuTUp5BXJsxaYxYBtJNccuwb4ML6aDkyVpeSQDTsgVA==
X-Received: by 2002:a05:651c:210:b0:2b9:5fd2:763a with SMTP id y16-20020a05651c021000b002b95fd2763amr6780335ljn.35.1693832277303;
        Mon, 04 Sep 2023 05:57:57 -0700 (PDT)
Received: from salami.fritz.box ([80.111.96.134])
        by smtp.gmail.com with ESMTPSA id y11-20020a1c4b0b000000b003fe2b081661sm17000960wma.30.2023.09.04.05.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 05:57:56 -0700 (PDT)
From:   =?UTF-8?q?Andr=C3=A9=20Draszik?= <git@andred.net>
To:     andre.draszik@gmail.com
Cc:     =?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
        stable@vger.kernel.org
Subject: [PATCH] Revert "fuse: Apply flags2 only when userspace set the FUSE_INIT_EXT"
Date:   Mon,  4 Sep 2023 13:57:47 +0100
Message-Id: <20230904125747.102023-2-git@andred.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230904125747.102023-1-git@andred.net>
References: <20230904125747.102023-1-git@andred.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: André Draszik <andre.draszik@linaro.org>

This reverts commit 3066ff93476c35679cb07a97cce37d9bb07632ff.

This patch breaks all existing userspace by requiring updates as
mentioned in the commit message, which is not allowed.

Revert to restore compatibility with existing userspace
implementations.

Cc: <stable@vger.kernel.org>
Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
 fs/fuse/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 549358ffea8b..0b966b0e0962 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1132,10 +1132,7 @@ static void process_init_reply(struct fuse_mount *fm, struct fuse_args *args,
 		process_init_limits(fc, arg);
 
 		if (arg->minor >= 6) {
-			u64 flags = arg->flags;
-
-			if (flags & FUSE_INIT_EXT)
-				flags |= (u64) arg->flags2 << 32;
+			u64 flags = arg->flags | (u64) arg->flags2 << 32;
 
 			ra_pages = arg->max_readahead / PAGE_SIZE;
 			if (flags & FUSE_ASYNC_READ)
-- 
2.40.1

