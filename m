Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D6C7A5C4D
	for <lists+stable@lfdr.de>; Tue, 19 Sep 2023 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjISISf (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 19 Sep 2023 04:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbjISISe (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 19 Sep 2023 04:18:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 807F6119
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 01:18:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3215f19a13aso1300816f8f.3
        for <stable@vger.kernel.org>; Tue, 19 Sep 2023 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111507; x=1695716307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFKz0KWwiS0pVzc4P5uzGjv0X8MPFPaaJ3s5AKyJ+TY=;
        b=CChUMqViAk9ijFZ+Sl2Vatz6hWua9FTgOycsJhTcyibs1c8Xzz9MAN/OELcBC+GXoF
         guqchm8GrRqi8LUrDqAJkih6qWGxjk+wl0rkZ1r1AIvl3OiAoKnadWPznvyU8Mr4L71Z
         3Q/JkMEQ+aDUQOEQ3R+yGShFrD3lVB/jselhDoUXT3KuxTT9ky4MaUsPwoVmbinoP1du
         WO0ubhXrw6JXwsp56VPF+KwnAksjEfj12It4P1ZtASfVd2Xh4NZT5DV3hdwcyAtatEVT
         1xbCrKZNHQMsS5NHfv8hb/izwN6gCl500JK1pqe66ywE0Ym/2dopUaA644KCZEKDlK/d
         jH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111507; x=1695716307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFKz0KWwiS0pVzc4P5uzGjv0X8MPFPaaJ3s5AKyJ+TY=;
        b=tYnTMiC7eSLIkvfeRhvz+IgbupJrtD7EVtU/498ijaxXSVJVbDIIlqI737g1EbyCw3
         DCtb7lHo1pHXezddKxAgV2AGKuCZRyr4EjUQTpo1Pfa2Z+O+yyRePmd+XN/jV4y091V/
         y7W01Rzw6yc1TVL8adotRZ/P6IGwQf4m7KJv+Sn7hjBWYMO9pr25emHEY1dCTp2CrWTJ
         6xV68XJ61GHatNBBsglhGaI4C7HS6ypmrSKNPmmw3QdRr7K9y1nfXtK40/mC4FkFnloz
         XRXhMcBY8LBO9Y0Km5BK4EF6IH3T0GlFp/NCVHUI58juW/1wHMirkWIkZX018GderaD3
         73Ag==
X-Gm-Message-State: AOJu0YzbVrReVp6sT/m5p25L7pZCbUsw6Pvt6BM5FEHu1MVcgBvFF9DM
        2oN3CudB7RbRw8U9rPrK/TBgMw==
X-Google-Smtp-Source: AGHT+IFIA72JLXYLX9P45Y7TvbzUP8wCfKgwoFLVj3U0ZuxAO8wVqrE454TPVH/lN3031fnF4Cnvpw==
X-Received: by 2002:a5d:404c:0:b0:319:7abf:d8e2 with SMTP id w12-20020a5d404c000000b003197abfd8e2mr10936570wrp.24.1695111506898;
        Tue, 19 Sep 2023 01:18:26 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b003142e438e8csm14687115wrv.26.2023.09.19.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:18:26 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ext4/acl: apply umask if ACL support is disabled
Date:   Tue, 19 Sep 2023 10:18:23 +0200
Message-Id: <20230919081824.1096619-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

The function ext4_init_acl() calls posix_acl_create() which is
responsible for applying the umask.  But without
CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
and nobody applies the umask.

This fixes a bug which causes the umask to be ignored with O_TMPFILE
on ext4:

 https://github.com/MusicPlayerDaemon/MPD/issues/558
 https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
 https://bugzilla.kernel.org/show_bug.cgi?id=203625

Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ext4/acl.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 0c5a79c3b5d4..ef4c19e5f570 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	   ext4 ACL support is disabled at compile time, we need to do
+	   it here, because posix_acl_create() will never be called */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
2.39.2

