Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C11267939C9
	for <lists+stable@lfdr.de>; Wed,  6 Sep 2023 12:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjIFK0Y (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 6 Sep 2023 06:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238852AbjIFK0X (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 6 Sep 2023 06:26:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E703110C7
        for <stable@vger.kernel.org>; Wed,  6 Sep 2023 03:26:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec9300c51so2924092276.3
        for <stable@vger.kernel.org>; Wed, 06 Sep 2023 03:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693995979; x=1694600779; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bd8xPMJuwIaL4g5So5Hpw2FKK/Xq7RuyWEq/PvNzxXE=;
        b=bd3P5L2QfUWkrIhT2st/O48iS8Ew2tRAYPpzoyBE2S2T5Nex+LsZHGVxfdbPO9P8R5
         +25y3HAaekcS809uNaqHU2VXed4HB3GA0awjBb//vogVM7eZ+C5h2GFI3MU6bBcZ+x3q
         fyhsyvYTmdLK/QODO4R/C9onqZqddqdpeEcQ9jh9Q3A4JTAxwCJUYIocWDHz1d5Mxnmg
         +48aJ5b9JV5yr2xCrWcrTVIC4I3FMdihSEfcASYkYIa9LdcSG0J1cU1kiUsFH67zvGBL
         w4T1ysNJeR+saPZc5grIGMNYlrlL/tD2Oc20AiPP8JgIWR4Shr+cXgLjekNq6Tus/Z/9
         3MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995979; x=1694600779;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bd8xPMJuwIaL4g5So5Hpw2FKK/Xq7RuyWEq/PvNzxXE=;
        b=auE5DfDORT0mkgI5FfYDcvzm6jNMjjZN6rKMQRzos1OASHDEo/iezCcgDFVZRvFilz
         WyK0Q6zbvBS9YgDrALAyYadl7+AvoCyxh8+vWpn+uyjWCbSrncb4AXusDCSLvLz9S1p+
         AVTzMeGKIf0TtyhbXGDjdC+MFOtCqV39y14s/DFEWQWY9aLxqNqKx+K8icsgWUAPlmVe
         9V1i3Q0RbddAS7wA93CxKfLhKw+mPfAEyPXNPduw548A9X/9Cx+jHc/fQeFDlQj41P1+
         ZcQecluDFWFrqUpyXVxK/BUyC/vgK7twlI0MrSat88t36OvrfsMfHG6esxwbps82c2ju
         SB6g==
X-Gm-Message-State: AOJu0YxYV5ZtVyTeyXAR0BWpaqGV6dq5BXv0y4sOFiMRGQVjC82pbOw8
        5zIHxTy2lmbgRsPxVMjR02uX6oiL9Q==
X-Google-Smtp-Source: AGHT+IE/UnZx+PImE5pc+JUOpSk02v87E9WHzmFRHcOsG8fNZn7gy5TZNBqX0sBQuSywALVf2UHXb/I+GQ==
X-Received: from alpic.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:1bf2])
 (user=alpic job=sendgmr) by 2002:a25:ca87:0:b0:cb6:6c22:d0f8 with SMTP id
 a129-20020a25ca87000000b00cb66c22d0f8mr383370ybg.4.1693995979209; Wed, 06 Sep
 2023 03:26:19 -0700 (PDT)
Date:   Wed,  6 Sep 2023 12:25:57 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230906102557.3432236-1-alpic@google.com>
Subject: [PATCH] SELinux: Check correct permissions for FS_IOC32_*
From:   Alfred Piccioni <alpic@google.com>
To:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Eric Paris <eparis@parisplace.org>
Cc:     stable@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alfred Piccioni <alpic@google.com>
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

Some ioctl commands do not require ioctl permission, but are routed to
other permissions such as FILE_GETATTR or FILE_SETATTR. This routing is
done by comparing the ioctl cmd to a set of 64-bit flags (FS_IOC_*).

However, if a 32-bit process is running on a 64-bit kernel, it emmits
32-bit flags (FS_IOC32_*) for certain ioctl operations. These flags are
being checked erroneoulsy, which leads to these ioctl operations being
routed to the ioctl permission, rather than the correct file permissions.

Two possible solutions exist:

- Trim parameter "cmd" to a u16 so that only the last two bytes are
  checked in the case statement.

- Explicitily add the FS_IOC32_* codes to the case statement.

Solution 2 was chosen because it is a minimal explicit change. Solution
1 is a more elegant change, but is less explicit, as the switch
statement appears to only check the FS_IOC_* codes upon first reading.

Fixes: 0b24dcb7f2f7 ("Revert "selinux: simplify ioctl checking"")
Signed-off-by: Alfred Piccioni <alpic@google.com>
---
 security/selinux/hooks.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index d06e350fedee..bba83f437a1d 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3644,11 +3644,15 @@ static int selinux_file_ioctl(struct file *file, unsigned int cmd,
 	case FIGETBSZ:
 	case FS_IOC_GETFLAGS:
 	case FS_IOC_GETVERSION:
+	case FS_IOC32_GETFLAGS:
+	case FS_IOC32_GETVERSION:
 		error = file_has_perm(cred, file, FILE__GETATTR);
 		break;
 
 	case FS_IOC_SETFLAGS:
 	case FS_IOC_SETVERSION:
+	case FS_IOC32_SETFLAGS:
+	case FS_IOC32_SETVERSION:
 		error = file_has_perm(cred, file, FILE__SETATTR);
 		break;
 

base-commit: 50a510a78287c15cee644f345ef8bac8977986a7
-- 
2.42.0.283.g2d96d420d3-goog

