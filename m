Return-Path: <stable+bounces-80181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C316F98DC4E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:40:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54491B2616E
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F07F1D0DD9;
	Wed,  2 Oct 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPGBoB2i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9941D0F7F;
	Wed,  2 Oct 2024 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727879620; cv=none; b=h7v06YISjL6mxHKcD+hvON18xpNYFCsguAewcjTS1F1ppTrHsJ55KN2W4xU+M/buYXW4muOFAXNaUUmCTRqoJpQM1CJdVaZieNgmd41C1C3hV2e5gLctwHFuFuiTUav3NP/DbJ9yaT7LU200DSn5RAWgVWjUKWoUmUKqA51uufE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727879620; c=relaxed/simple;
	bh=1bcJRlpIHkDs8pBsJUo5c4z4daakA8HLhG6FDcdYT+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwWBemUK+kifyvkJBJMG+C/GgsopUIybuAefUdzagA+tAqMyyocsXgNIAwXpDFjhJxacYLyAB4nv3GWCVGwCPRJTjKN2bJPiycxJa0MP/jDUXVzNB4K/LQmgpfpvRVQP8A1GtlN7KRqJxp06iFrI5QvPHC+/J7VVkx0Py7zFfuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPGBoB2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 706F9C4CEC5;
	Wed,  2 Oct 2024 14:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727879619;
	bh=1bcJRlpIHkDs8pBsJUo5c4z4daakA8HLhG6FDcdYT+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPGBoB2i2BVnSDQtOECF22y6lNgms3+EFgexJZyE5uvQk1iZ8i+wWkXQjmddTiCjM
	 gRZp+jzsUUvKppMMMYj5qxPcG+8BBotwBjw6f2i2/07FrZFVAsC/VxQgD4Ezst0NhL
	 qiUWqRHbPQjRzENpZIE3lu/n/gfy7ubkzt1zrBV0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 181/538] selftests/bpf: Fix error linking uprobe_multi on mips
Date: Wed,  2 Oct 2024 14:57:00 +0200
Message-ID: <20241002125759.401627536@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Ambardar <tony.ambardar@gmail.com>

[ Upstream commit a5f40d596bff182b4b47547712f540885e8fb17b ]

Linking uprobe_multi.c on mips64el fails due to relocation overflows, when
the GOT entries required exceeds the default maximum. Add a specific CFLAGS
(-mxgot) for uprobe_multi.c on MIPS that allows using a larger GOT and
avoids errors such as:

  /tmp/ccBTNQzv.o: in function `bench':
  uprobe_multi.c:49:(.text+0x1d7720): relocation truncated to fit: R_MIPS_GOT_DISP against `uprobe_multi_func_08188'
  uprobe_multi.c:49:(.text+0x1d7730): relocation truncated to fit: R_MIPS_GOT_DISP against `uprobe_multi_func_08189'
  ...
  collect2: error: ld returned 1 exit status

Fixes: 519dfeaf5119 ("selftests/bpf: Add uprobe_multi test program")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/14eb7b70f8ccef9834874d75eb373cb9292129da.1721692479.git.tony.ambardar@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index caede9b574cb1..598cd118dfd65 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -702,6 +702,8 @@ $(OUTPUT)/veristat: $(OUTPUT)/veristat.o
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $(filter %.a %.o,$^) $(LDLIBS) -o $@
 
+# Linking uprobe_multi can fail due to relocation overflows on mips.
+$(OUTPUT)/uprobe_multi: CFLAGS += $(if $(filter mips, $(ARCH)),-mxgot)
 $(OUTPUT)/uprobe_multi: uprobe_multi.c
 	$(call msg,BINARY,,$@)
 	$(Q)$(CC) $(CFLAGS) $(LDFLAGS) $^ $(LDLIBS) -o $@
-- 
2.43.0




