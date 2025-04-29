Return-Path: <stable+bounces-137531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68840AA1375
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04C127A7A29
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B6D7211A0B;
	Tue, 29 Apr 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M8Qqnujb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 592282472AA;
	Tue, 29 Apr 2025 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946346; cv=none; b=qVc7qRPo4kCHRhxt/WCH0mvlcnUkDSvfdI7C+oPgdGlA8j8m49uQarAK5YfWMeDGxZht/KJ90c5jkhbCe7aK6mKvNvfB/bwah3PaG3PRPDghFq759Udvks6K5YZBRSVMxHc6PF2aDqZ7vXx7ssWF1jFPJbmah/ba2DT7LQmB+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946346; c=relaxed/simple;
	bh=bDuENEKkosBijoZW7brsGamHoq/FeDWrvQjIQWKsitE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C5gErPLmg3cY8ppS9dJPH8eihK9pMf1RLEGbOzcPWkn0ddVGfr4slcrTivp0enPFXuIa0UbxJgnu6xtojwmbPua1U9kSdoM04OyYOvbgwrwwUZtqxCVqiJaC/28ARYV2SDvkfXdYryfblbsyD9ck2LFo1v7UqQu669OqHPebf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M8Qqnujb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B8AC4CEE3;
	Tue, 29 Apr 2025 17:05:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946346;
	bh=bDuENEKkosBijoZW7brsGamHoq/FeDWrvQjIQWKsitE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M8Qqnujb82VU5+PAm/6l4lUb+QYxwXlZQuofkebcetr6iAZecCOyNn+Ia5jacp1j6
	 qh/8mmKZFBlEMTxw8LWChVSIznZMaoDBsU8s1KM4u1d+Jv/mTJuJIyw3uOi2nXJqp3
	 AFnnOvN+igLLJx6XY7YYiyxFhjYY8rVzlAuQG7OQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xi Ruoyao <xry111@xry111.site>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 236/311] kbuild: add dependency from vmlinux to sorttable
Date: Tue, 29 Apr 2025 18:41:13 +0200
Message-ID: <20250429161130.691661569@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161121.011111832@linuxfoundation.org>
References: <20250429161121.011111832@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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




