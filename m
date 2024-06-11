Return-Path: <stable+bounces-50183-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B23904795
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20FA7285AEA
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 23:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DF4156245;
	Tue, 11 Jun 2024 23:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bdJyANb6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B81E155CAC
	for <stable@vger.kernel.org>; Tue, 11 Jun 2024 23:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718147658; cv=none; b=rZ3qfybmKJ/SAb1DIIEjUuvmwtk6vbXSKneev0jabYvSxV3fJhSODKJaiu1vdQlxejzRYXmiNbjDZVnNYkxZNG5Dk9cP/U2IDLdXPcTgR5XeQ2MAIfuraQcSoL4+wTr5iLi5WOoaBWZotqUUN1Qo/3VDXBJHGA3Yf92yPhzNY6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718147658; c=relaxed/simple;
	bh=uQQqqX3m7pbIn89WtFxaUm8ZlR7ATsRfgOQIrXwe7KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8nmPClijn7QYhD3ZTiiZVPbFkCixzA+jblHzrUA+5Imebq2ZKphG7oEp34fPZXTsjQz8naETsAFxXL/xEdMYbezyvdK0veiqMbfsv2DUldpm6+gmv5CXpOcXeuBjXm99NpM/1trOaeiVQUBm3kR1rnj1iX1xKge9XtebF5covM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bdJyANb6; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1f717b3f2d8so2536605ad.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 16:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718147655; x=1718752455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G4NKRSzRUO9zxmE7CyGeus+0BBDnvcGxcOkVTXBxNh4=;
        b=bdJyANb6vHr0U24erJ5E33PvHrYqH/9Lkpadn97M0les/+2+AJV5rupy3ogUVUs6ot
         rzFgt/TkZa4FfiuNmymMEYh4Y4F/H07WBnnuSRKJVYdJtC1JGP8oUVZ2vogGgg4KceTt
         NOsbxOvnQCMhyzzoiDiLc1jqDGRPbemUzjUHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718147655; x=1718752455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G4NKRSzRUO9zxmE7CyGeus+0BBDnvcGxcOkVTXBxNh4=;
        b=DzC9fNNgoix39Rzp1dKG098PhL/JIluPOAKaSxR2UKm3bgADf5V77vBEOd1YTyf3Iq
         kgt4IsQ4HmcNP0nYSNLhmIIomKzcJpfzLoRdxNE0A5aJBWAvd2DMlcKmz8E9dm064M5Z
         yLL64c/FSsl42f5V2XFcFft1XBIgBAeKzK4coa1HSoEnDWrPdFN30Bczf1++k3tRtD/B
         IJP8D8uKfTq0DDXLdl0HHdnE2c2kJaJReV5HU+FnJ9m02Y29pCmxrBXDq0WbN3K3vDDz
         oZg4cdfA/TcyXkAuHqb8z1VdgwZwIdX7GO1AiPJ0oIIoGTItuubrThAu2ppUE9+s30CU
         MyZg==
X-Forwarded-Encrypted: i=1; AJvYcCVtZhKHtnzmj5AHLebsXy6N+gIJbNC1PlSSU/Wf7iHGcQ1sMhKJsEopo1gORuwOSQQzgC04R9/zOmwvhJF4LfuR/Il7IaqQ
X-Gm-Message-State: AOJu0YwLXWvdgCL+HrSm1ilCru2G0c54haeZhU0hII5Vl1nll6QTua56
	RnfEssbuzFf4aS/xVL0u5h0m9SX9AAXpn6FawcCn+tVBr5drP41ioLJpw6jcVw==
X-Google-Smtp-Source: AGHT+IGdNDtP3xIWxdgEuCn8jEyOCrtFBh2iITQjh4/VkBiUCRHSlUbcVmBovHOf4FNPsfqHXh+PRA==
X-Received: by 2002:a17:902:dace:b0:1f7:126:5bb7 with SMTP id d9443c01a7336-1f83b19c2d2mr5260145ad.21.1718147655552;
        Tue, 11 Jun 2024 16:14:15 -0700 (PDT)
Received: from localhost (213.126.145.34.bc.googleusercontent.com. [34.145.126.213])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1f6e1ba23c7sm85924185ad.29.2024.06.11.16.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 16:14:15 -0700 (PDT)
From: jeffxu@chromium.org
To: rdunlap@infradead.org
Cc: akpm@linux-foundation.org,
	cyphar@cyphar.com,
	david@readahead.eu,
	dmitry.torokhov@gmail.com,
	dverkamp@chromium.org,
	hughd@google.com,
	jeffxu@chromium.org,
	jeffxu@google.com,
	jorgelo@chromium.org,
	keescook@chromium.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	pobrn@protonmail.com,
	skhan@linuxfoundation.org,
	stable@vger.kernel.org
Subject: [PATCH v3 1/1] mm/memfd: add documentation for MFD_NOEXEC_SEAL MFD_EXEC
Date: Tue, 11 Jun 2024 23:14:08 +0000
Message-ID: <20240611231409.3899809-2-jeffxu@chromium.org>
X-Mailer: git-send-email 2.45.2.505.gda0bf45e8d-goog
In-Reply-To: <20240611231409.3899809-1-jeffxu@chromium.org>
References: <20240611231409.3899809-1-jeffxu@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Xu <jeffxu@chromium.org>

Add documentation for memfd_create flags: MFD_NOEXEC_SEAL
and MFD_EXEC

Cc: stable@vger.kernel.org
Signed-off-by: Jeff Xu <jeffxu@chromium.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

---
 Documentation/userspace-api/index.rst      |  1 +
 Documentation/userspace-api/mfd_noexec.rst | 86 ++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/userspace-api/mfd_noexec.rst

diff --git a/Documentation/userspace-api/index.rst b/Documentation/userspace-api/index.rst
index 5926115ec0ed..8a251d71fa6e 100644
--- a/Documentation/userspace-api/index.rst
+++ b/Documentation/userspace-api/index.rst
@@ -32,6 +32,7 @@ Security-related interfaces
    seccomp_filter
    landlock
    lsm
+   mfd_noexec
    spec_ctrl
    tee
 
diff --git a/Documentation/userspace-api/mfd_noexec.rst b/Documentation/userspace-api/mfd_noexec.rst
new file mode 100644
index 000000000000..7afcc480e38f
--- /dev/null
+++ b/Documentation/userspace-api/mfd_noexec.rst
@@ -0,0 +1,86 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================================
+Introduction of non-executable mfd
+==================================
+:Author:
+    Daniel Verkamp <dverkamp@chromium.org>
+    Jeff Xu <jeffxu@chromium.org>
+
+:Contributor:
+	Aleksa Sarai <cyphar@cyphar.com>
+
+Since Linux introduced the memfd feature, memfds have always had their
+execute bit set, and the memfd_create() syscall doesn't allow setting
+it differently.
+
+However, in a secure-by-default system, such as ChromeOS, (where all
+executables should come from the rootfs, which is protected by verified
+boot), this executable nature of memfd opens a door for NoExec bypass
+and enables “confused deputy attack”.  E.g, in VRP bug [1]: cros_vm
+process created a memfd to share the content with an external process,
+however the memfd is overwritten and used for executing arbitrary code
+and root escalation. [2] lists more VRP of this kind.
+
+On the other hand, executable memfd has its legit use: runc uses memfd’s
+seal and executable feature to copy the contents of the binary then
+execute them. For such a system, we need a solution to differentiate runc's
+use of executable memfds and an attacker's [3].
+
+To address those above:
+ - Let memfd_create() set X bit at creation time.
+ - Let memfd be sealed for modifying X bit when NX is set.
+ - Add a new pid namespace sysctl: vm.memfd_noexec to help applications in
+   migrating and enforcing non-executable MFD.
+
+User API
+========
+``int memfd_create(const char *name, unsigned int flags)``
+
+``MFD_NOEXEC_SEAL``
+	When MFD_NOEXEC_SEAL bit is set in the ``flags``, memfd is created
+	with NX. F_SEAL_EXEC is set and the memfd can't be modified to
+	add X later. MFD_ALLOW_SEALING is also implied.
+	This is the most common case for the application to use memfd.
+
+``MFD_EXEC``
+	When MFD_EXEC bit is set in the ``flags``, memfd is created with X.
+
+Note:
+	``MFD_NOEXEC_SEAL`` implies ``MFD_ALLOW_SEALING``. In case that
+	an app doesn't want sealing, it can add F_SEAL_SEAL after creation.
+
+
+Sysctl:
+========
+``pid namespaced sysctl vm.memfd_noexec``
+
+The new pid namespaced sysctl vm.memfd_noexec has 3 values:
+
+ - 0: MEMFD_NOEXEC_SCOPE_EXEC
+	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+	MFD_EXEC was set.
+
+ - 1: MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL
+	memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL acts like
+	MFD_NOEXEC_SEAL was set.
+
+ - 2: MEMFD_NOEXEC_SCOPE_NOEXEC_ENFORCED
+	memfd_create() without MFD_NOEXEC_SEAL will be rejected.
+
+The sysctl allows finer control of memfd_create for old software that
+doesn't set the executable bit; for example, a container with
+vm.memfd_noexec=1 means the old software will create non-executable memfd
+by default while new software can create executable memfd by setting
+MFD_EXEC.
+
+The value of vm.memfd_noexec is passed to child namespace at creation
+time. In addition, the setting is hierarchical, i.e. during memfd_create,
+we will search from current ns to root ns and use the most restrictive
+setting.
+
+[1] https://crbug.com/1305267
+
+[2] https://bugs.chromium.org/p/chromium/issues/list?q=type%3Dbug-security%20memfd%20escalation&can=1
+
+[3] https://lwn.net/Articles/781013/
-- 
2.45.2.505.gda0bf45e8d-goog


