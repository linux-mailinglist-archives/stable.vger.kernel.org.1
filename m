Return-Path: <stable+bounces-187839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B0DCBED0AF
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 15:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5F1934E59F1
	for <lists+stable@lfdr.de>; Sat, 18 Oct 2025 13:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D182D8DDB;
	Sat, 18 Oct 2025 13:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/BlTbDN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84352D8DA8
	for <stable@vger.kernel.org>; Sat, 18 Oct 2025 13:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760795467; cv=none; b=L7yMZmF7cy5OfV305WlHRx8fqRwxe/RgtBiuAjBqFSf2PtYz+4MprvQxbpBD1hKmwrFGGodN0mBf4/1tfxajMyds3y1aHoophiHDw5/sPWubEFPAwosGhzZmfGcRHMzeORtf2uC0X2YahmDU7Nvs6scf5alhEdlRJhKECbfZr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760795467; c=relaxed/simple;
	bh=dlK4USONtEkItDKxy/gw9nJaFaNwhWOJEtFnldsEpB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKBbp7xbuBLZ58tySyDCxyG+WHa+/Lc5NLhxUvjsVBTahwFMFeElc5ELyUc0wTucg0MoNu2xcmR43HJl5197BWOWyTS2EIfi4nyUXUg1XVb0o+IFwDLxmGv5qkPKnzISWCxuaKurVtgPyW454x7CTT8kzQr6RQxCYjPTKZx/0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/BlTbDN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E62DC4CEF8;
	Sat, 18 Oct 2025 13:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760795465;
	bh=dlK4USONtEkItDKxy/gw9nJaFaNwhWOJEtFnldsEpB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f/BlTbDNbb1vUfAa87MnLn09wLKUcSKFFnDB+Iyv/BG+QaqHrlq4ZNm9L/76vzIoM
	 CI+xK3fxcmySFhZKPSFLKsXLCizxMvsbGIZDMBMS+wMWyhZr0eNqCNpZ7mvfl+HHVe
	 d/6smInKem0TQnz6lfKWKgpl6n9MxJyWETFp2Mra6cKEb4sEJInh/ZYTZhNn1ceyHI
	 28S/o9iT+rcw9IwkMY71qQ2xlm92/rFwk7cA4cac6tOySyJkLDX55eHTeGvrjyRw81
	 6jFdo7OjPJXBr6K9BLj4wjLJTKhbeo6WmNbSZi6oJDNbpwZgB0jzx6Lg/ZZdvAye+s
	 ku01H08ZU/DOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>,
	Ionut Nechita <ionut_n2001@yahoo.com>,
	Kenneth Crudup <kenny@panix.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/2] PM: hibernate: Add pm_hibernation_mode_is_suspend()
Date: Sat, 18 Oct 2025 09:51:01 -0400
Message-ID: <20251018135102.711457-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101656-trailside-reabsorb-e368@gregkh>
References: <2025101656-trailside-reabsorb-e368@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mario Limonciello (AMD)" <superm1@kernel.org>

[ Upstream commit 495c8d35035edb66e3284113bef01f3b1b843832 ]

Some drivers have different flows for hibernation and suspend. If
the driver opportunistically will skip thaw() then it needs a hint
to know what is happening after the hibernate.

Introduce a new symbol pm_hibernation_mode_is_suspend() that drivers
can call to determine if suspending the system for this purpose.

Tested-by: Ionut Nechita <ionut_n2001@yahoo.com>
Tested-by: Kenneth Crudup <kenny@panix.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Stable-dep-of: 0a6e9e098fcc ("drm/amd: Fix hybrid sleep")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/suspend.h  |  2 ++
 kernel/power/hibernate.c | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/suspend.h b/include/linux/suspend.h
index 317ae31e89b37..0664c685f0b24 100644
--- a/include/linux/suspend.h
+++ b/include/linux/suspend.h
@@ -276,6 +276,7 @@ extern void arch_suspend_enable_irqs(void);
 
 extern int pm_suspend(suspend_state_t state);
 extern bool sync_on_suspend_enabled;
+bool pm_hibernation_mode_is_suspend(void);
 #else /* !CONFIG_SUSPEND */
 #define suspend_valid_only_mem	NULL
 
@@ -288,6 +289,7 @@ static inline bool pm_suspend_via_firmware(void) { return false; }
 static inline bool pm_resume_via_firmware(void) { return false; }
 static inline bool pm_suspend_no_platform(void) { return false; }
 static inline bool pm_suspend_default_s2idle(void) { return false; }
+static inline bool pm_hibernation_mode_is_suspend(void) { return false; }
 
 static inline void suspend_set_ops(const struct platform_suspend_ops *ops) {}
 static inline int pm_suspend(suspend_state_t state) { return -ENOSYS; }
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 2f66ab4538231..bcbb99fbabf65 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -80,6 +80,17 @@ static const struct platform_hibernation_ops *hibernation_ops;
 
 static atomic_t hibernate_atomic = ATOMIC_INIT(1);
 
+#ifdef CONFIG_SUSPEND
+/**
+ * pm_hibernation_mode_is_suspend - Check if hibernation has been set to suspend
+ */
+bool pm_hibernation_mode_is_suspend(void)
+{
+	return hibernation_mode == HIBERNATION_SUSPEND;
+}
+EXPORT_SYMBOL_GPL(pm_hibernation_mode_is_suspend);
+#endif
+
 bool hibernate_acquire(void)
 {
 	return atomic_add_unless(&hibernate_atomic, -1, 0);
-- 
2.51.0


