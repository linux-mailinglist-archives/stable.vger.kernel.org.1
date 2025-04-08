Return-Path: <stable+bounces-128789-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E6A7F1BA
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 02:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3EB18975BB
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 00:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E7225F795;
	Tue,  8 Apr 2025 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EGLtxiUd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A41725F78C;
	Tue,  8 Apr 2025 00:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744073622; cv=none; b=cgEDcF/PSEAeb9qYG7hKq8g9Bl5ak3hawnto/hmrXIzYFTD1McBlwv6YGTNDsJ0D9FEExSiInDkgR+ROlaM0ITM1Wn0FMOofFlD1YZec8H0xFg31Stye2BNhfhXNZuEXfIeHI6KUtbR1v16kwiVGH5bkjC26/1FZJ8R0qtLkm/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744073622; c=relaxed/simple;
	bh=5shCUpL32JQ0J0p2ImZRworI9Ip01R6iAdj+DvbED4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD3foQNVB4J5nEZGb4o54ELyC/Z1EdfLD8s3pO9Sfh+yqnmX92da46nY6ns/k7ILmVGlBnJnmy0Gwm9XSXBmY5INvDgjtA8BCel6JjYsJJekhquh/0qGwOYQ2AsST6h7MK/tjVlbm3gQpDxsO8cVxpCDsNs5PzXecFcE/TTyGIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EGLtxiUd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4805FC4CEDD;
	Tue,  8 Apr 2025 00:53:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744073622;
	bh=5shCUpL32JQ0J0p2ImZRworI9Ip01R6iAdj+DvbED4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EGLtxiUd/YlW5xkeR05LQWJjNb1Ku2cqGFi6SDU/TVO53AkzVPiea3k9uHrJUBpRG
	 l5S2JeFuY2f6i/Jl2APttHtd7zGHcxY+WgFEsda6VR8T0UcBd362JZHC5+R/uXVNiK
	 nCU7jFpM83bB0v9w/gT+Gcnph7xi+jifqgWlqHaQKUuq9eaKHjxQrToturveveNKX/
	 tFiC5xuvGUDikb7a9kpQodMdkEL5fN4kgyruo/sBbENKSbpFDHKavLynnfzQjUJ1xy
	 HEhA8kNz4yxLBKs0p+15ry3KNIIxyYXzpzyAdkbhksQkjFarD2qrtoS5zWSUtWorN7
	 SuZa8SQB6AQKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xi Ruoyao <xry111@xry111.site>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-kbuild@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 2/3] kbuild: add dependency from vmlinux to sorttable
Date: Mon,  7 Apr 2025 20:53:34 -0400
Message-Id: <20250408005335.3334585-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250408005335.3334585-1-sashal@kernel.org>
References: <20250408005335.3334585-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.1
Content-Transfer-Encoding: 8bit

From: Xi Ruoyao <xry111@xry111.site>

[ Upstream commit 82c09de2d4c472ab1b973e6e033671020691e637 ]

Without this dependency it's really puzzling when we bisect for a "bad"
commit in a series of sorttable change: when "git bisect" switches to
another commit, "make" just does nothing to vmlinux.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 scripts/Makefile.vmlinux | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 873caaa553134..fb79fd6b24654 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -79,6 +79,10 @@ ifdef CONFIG_DEBUG_INFO_BTF
 vmlinux: $(RESOLVE_BTFIDS)
 endif
 
+ifdef CONFIG_BUILDTIME_TABLE_SORT
+vmlinux: scripts/sorttable
+endif
+
 # module.builtin.ranges
 # ---------------------------------------------------------------------------
 ifdef CONFIG_BUILTIN_MODULE_RANGES
-- 
2.39.5


