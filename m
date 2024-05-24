Return-Path: <stable+bounces-46021-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E24288CDFE0
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 05:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1196D1C221B7
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 03:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C0B138DD9;
	Fri, 24 May 2024 03:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EAnFq72n"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602BC383BF
	for <stable@vger.kernel.org>; Fri, 24 May 2024 03:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716521993; cv=none; b=T76yEIiAlF40gRf10HwZTy4T8seSHKKCXez27pfvhz5DaUcm2L8XSzKgsnh1wqmQ03dXXHPW2PbQt2NU9VSWyGSptCe4Xox+JM/lLrB53wrqFWs2UhPxO8Zl3JDGZ0PXqVXZWlXFSFSCQH5ACT6sXdz/vg8U49vmlClOAPZxxLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716521993; c=relaxed/simple;
	bh=23moA4iMJXSgtkxujKg/JAxWm3k0ziZQHmIoopuyc70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qmzfei1WF2hgYFphO968JrG0DShjR68sxozpFCFLo4wyBLEZN8uwbihOqGRvOl/ANoHTbQcFJeV7pRY6XPHRdqQxa0ohLM2XEN3YaQ5lUr3xmInOoJzVctkH0QfabcTmtbWjpa8Lrj8L0vFX6x3eyIuLGsqKWIWN4vrGJdugdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EAnFq72n; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6f10092c8c7so4323726a34.1
        for <stable@vger.kernel.org>; Thu, 23 May 2024 20:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716521990; x=1717126790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6jr022mlOQVdTQNdYCM0jmCCOa9PK9T8m0GA7PmwSw=;
        b=EAnFq72nP3DWnIENBt6bak1yK0hRnCHettp4QHJW+TniqVP1Ukusn/rGWO15BP6o8N
         TOUI3uMjvlZPtbD7OzxanVlYjZEK0W5yfgZkGmQ948JLY+b3nT19tnfQ7pNKh/C5vpbP
         gN5bljzjnZpklV4Yw0rmR1uTSkuavL9c8c9Ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716521990; x=1717126790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j6jr022mlOQVdTQNdYCM0jmCCOa9PK9T8m0GA7PmwSw=;
        b=Vl2GQ3TyCRbrQa5FKmJ5DPy89kEPa58oAOHr1TJ+QrYz0h368mRKnjzc+k9gAORKqs
         ePGm10hdnFDjjV7Qyyq5xVVkGSGILJGPBbMeIyn0hI8bI06miYvlPgOafmk7EJjnItAZ
         dCRSjuwPCn+qYMPwB20QRGS2bzqQjLW53pjQSxPPBqJ4yiSVW/+OBwndnXQfGGvfXN8s
         1hYVq+MJY5gJQkUztvPQ9X4Gi1nhAUdnF7wYsZhMQuUJaOjPj20+zho7yLiSyV0194Io
         nTfsoq2a3IMVBC/SD4FPB5p5uep2gFtSXlbNycpz/6NjtRfuBpC6nvOrl6LwAOgFSrOv
         II+w==
X-Forwarded-Encrypted: i=1; AJvYcCUvFO8HHU04Ycdj00Vm2vAaSYUApKQBkx22OAVj6XgMwhvTzvFHLfJEVDqU0pUyAS9NIpqO3ZJitqtq61nHF8RbEfnxZMpO
X-Gm-Message-State: AOJu0YydgXBmuDsnd0gUPXzBcE/J708Dg4MJ9bXmtDTY1Qqb36/yHglf
	B1ewXS2sKjDwxjktmOrDFENjDNpgfiKW0m6DqF/h7NkCVaEazc/sZ2smoPk+lQ==
X-Google-Smtp-Source: AGHT+IHZf+jr2XVCdIxoQjdDZnqMqm+D003gUslsBjdQqg0R++wGRM0qaMzD5yCdbM2LCfnRng/Tyg==
X-Received: by 2002:a05:6870:1492:b0:24c:6198:5ff8 with SMTP id 586e51a60fabf-24ca105306amr1500902fac.4.1716521990321;
        Thu, 23 May 2024 20:39:50 -0700 (PDT)
Received: from localhost (197.59.83.34.bc.googleusercontent.com. [34.83.59.197])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-6f8fcbeb674sm315258b3a.122.2024.05.23.20.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 May 2024 20:39:50 -0700 (PDT)
From: jeffxu@chromium.org
To: jeffxu@google.com
Cc: jeffxu@chromium.org,
	akpm@linux-foundation.org,
	cyphar@cyphar.com,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org,
	David Rheinsberg <david@readahead.eu>
Subject: [PATCH v2 1/2] memfd: fix MFD_NOEXEC_SEAL to be non-sealable by default
Date: Fri, 24 May 2024 03:39:30 +0000
Message-ID: <20240524033933.135049-2-jeffxu@google.com>
X-Mailer: git-send-email 2.45.1.288.g0e0cd299f1-goog
In-Reply-To: <20240524033933.135049-1-jeffxu@google.com>
References: <20240524033933.135049-1-jeffxu@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@google.com>

By default, memfd_create() creates a non-sealable MFD, unless the
MFD_ALLOW_SEALING flag is set.

When the MFD_NOEXEC_SEAL flag is initially introduced, the MFD created
with that flag is sealable, even though MFD_ALLOW_SEALING is not set.
This patch changes MFD_NOEXEC_SEAL to be non-sealable by default,
unless MFD_ALLOW_SEALING is explicitly set.

This is a non-backward compatible change. However, as MFD_NOEXEC_SEAL
is new, we expect not many applications will rely on the nature of
MFD_NOEXEC_SEAL being sealable. In most cases, the application already
sets MFD_ALLOW_SEALING if they need a sealable MFD.

Additionally, this enhances the useability of  pid namespace sysctl
vm.memfd_noexec. When vm.memfd_noexec equals 1 or 2, the kernel will
add MFD_NOEXEC_SEAL if mfd_create does not specify MFD_EXEC or
MFD_NOEXEC_SEAL, and the addition of MFD_NOEXEC_SEAL enables the MFD
to be sealable. This means, any application that does not desire this
behavior will be unable to utilize vm.memfd_noexec = 1 or 2 to
migrate/enforce non-executable MFD. This adjustment ensures that
applications can anticipate that the sealable characteristic will
remain unmodified by vm.memfd_noexec.

This patch was initially developed by Barnabás Pőcze, and Barnabás
used Debian Code Search and GitHub to try to find potential breakages
and could only find a single one. Dbus-broker's memfd_create() wrapper
is aware of this implicit `MFD_ALLOW_SEALING` behavior, and tries to
work around it [1]. This workaround will break. Luckily, this only
affects the test suite, it does not affect
the normal operations of dbus-broker. There is a PR with a fix[2]. In
addition, David Rheinsberg also raised similar fix in [3]

[1]: https://github.com/bus1/dbus-broker/blob/9eb0b7e5826fc76cad7b025bc46f267d4a8784cb/src/util/misc.c#L114
[2]: https://github.com/bus1/dbus-broker/pull/366
[3]: https://lore.kernel.org/lkml/20230714114753.170814-1-david@readahead.eu/

Cc: stable@vger.kernel.org
Fixes: 105ff5339f498a ("mm/memfd: add MFD_NOEXEC_SEAL and MFD_EXEC")
Signed-off-by: Barnabás Pőcze <pobrn@protonmail.com>
Signed-off-by: Jeff Xu <jeffxu@google.com>
Reviewed-by: David Rheinsberg <david@readahead.eu>
---
 mm/memfd.c                                 |  9 ++++----
 tools/testing/selftests/memfd/memfd_test.c | 26 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/mm/memfd.c b/mm/memfd.c
index 7d8d3ab3fa37..8b7f6afee21d 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -356,12 +356,11 @@ SYSCALL_DEFINE2(memfd_create,
 
 		inode->i_mode &= ~0111;
 		file_seals = memfd_file_seals_ptr(file);
-		if (file_seals) {
-			*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
 			*file_seals |= F_SEAL_EXEC;
-		}
-	} else if (flags & MFD_ALLOW_SEALING) {
-		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
+	}
+
+	if (flags & MFD_ALLOW_SEALING) {
 		file_seals = memfd_file_seals_ptr(file);
 		if (file_seals)
 			*file_seals &= ~F_SEAL_SEAL;
diff --git a/tools/testing/selftests/memfd/memfd_test.c b/tools/testing/selftests/memfd/memfd_test.c
index 95af2d78fd31..8579a93d006b 100644
--- a/tools/testing/selftests/memfd/memfd_test.c
+++ b/tools/testing/selftests/memfd/memfd_test.c
@@ -1151,7 +1151,7 @@ static void test_noexec_seal(void)
 			    mfd_def_size,
 			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
 	mfd_assert_mode(fd, 0666);
-	mfd_assert_has_seals(fd, F_SEAL_EXEC);
+	mfd_assert_has_seals(fd, F_SEAL_SEAL | F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
 }
@@ -1169,6 +1169,14 @@ static void test_sysctl_sysctl0(void)
 	mfd_assert_has_seals(fd, 0);
 	mfd_assert_chmod(fd, 0644);
 	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_0_dfl",
+			    mfd_def_size,
+			    MFD_CLOEXEC);
+	mfd_assert_mode(fd, 0777);
+	mfd_assert_has_seals(fd, F_SEAL_SEAL);
+	mfd_assert_chmod(fd, 0644);
+	close(fd);
 }
 
 static void test_sysctl_set_sysctl0(void)
@@ -1206,6 +1214,14 @@ static void test_sysctl_sysctl1(void)
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_1_noexec_nosealable",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
 }
 
 static void test_sysctl_set_sysctl1(void)
@@ -1238,6 +1254,14 @@ static void test_sysctl_sysctl2(void)
 	mfd_assert_has_seals(fd, F_SEAL_EXEC);
 	mfd_fail_chmod(fd, 0777);
 	close(fd);
+
+	fd = mfd_assert_new("kern_memfd_sysctl_2_noexec_notsealable",
+			    mfd_def_size,
+			    MFD_CLOEXEC | MFD_NOEXEC_SEAL);
+	mfd_assert_mode(fd, 0666);
+	mfd_assert_has_seals(fd, F_SEAL_EXEC | F_SEAL_SEAL);
+	mfd_fail_chmod(fd, 0777);
+	close(fd);
 }
 
 static void test_sysctl_set_sysctl2(void)
-- 
2.45.1.288.g0e0cd299f1-goog


