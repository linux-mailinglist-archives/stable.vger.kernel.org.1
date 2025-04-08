Return-Path: <stable+bounces-130749-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D47A8060C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1113E188937C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA726A1D7;
	Tue,  8 Apr 2025 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gHfS7Jxk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B830E269B0D;
	Tue,  8 Apr 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744114546; cv=none; b=IdRSU8GecITFV3EmRRd/Pqk+oVQdb4EXvnUUf1v08sOfJg7Oetx2jNSXKbQERkXe6tLyoI7Vhj1ErmlypR3XMM4J963GUQfioFieJiXJStxaI0E8zWdYJIt2N+3iA1710ZZFIaO8lxhCUqVzMLrYYW6k+sXstrlGDhgCMuMeDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744114546; c=relaxed/simple;
	bh=uie/bxxIrLA3MOl82sXGZibmJs2GwP2NFLFq0Gj6BSI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQya10FN/nVbsxOCx5XLJNIpnXfb5hvxwVz7vkzp+VoLAUDaFX+80s8LTRmJuoWyqNXCOERhA0jEdqey3CH64s1+68KgeZEuRSn5yPcEt64U05Pi+7M1Pu+SHgVYRYbiMK7VwPFaWJp+vKPibCoR91T/hzWEYUHs7OQQjU+n3yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gHfS7Jxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BD1C4CEE5;
	Tue,  8 Apr 2025 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744114546;
	bh=uie/bxxIrLA3MOl82sXGZibmJs2GwP2NFLFq0Gj6BSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gHfS7JxkaQ0Wm9uxrTPRTNVAcsi+Wqtcp33BW0Tw1hhi5jrYIBLUVsMixcQ26qlql
	 B+CBDBP3c26wDlB+EpE8tXg/T4+z1ovwFxMOpHnum701+Pf2QZQFbuBLOiQCpiAzsH
	 GYXBE+gNDdgPYOH/FwFRXtd7JBhZC+at0NUHkIUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Ambardar <tony.ambardar@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 147/499] selftests/bpf: Fix runqslower cross-endian build
Date: Tue,  8 Apr 2025 12:45:59 +0200
Message-ID: <20250408104854.854779724@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104851.256868745@linuxfoundation.org>
References: <20250408104851.256868745@linuxfoundation.org>
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

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tony Ambardar <tony.ambardar@gmail.com>

[ Upstream commit cb3ade567816a03d1ac1c33bf86073574efcfcaf ]

The runqslower binary from a cross-endian build currently fails to run
because the included skeleton has host endianness. Fix this by passing the
target BPF endianness to the runqslower sub-make.

Fixes: 5a63c33d6f00 ("selftests/bpf: Support cross-endian building")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20250125071423.2603588-1-itugrok@yahoo.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/bpf/runqslower/Makefile        | 3 ++-
 tools/testing/selftests/bpf/Makefile | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/runqslower/Makefile b/tools/bpf/runqslower/Makefile
index c4f1f1735af65..5613b5736d938 100644
--- a/tools/bpf/runqslower/Makefile
+++ b/tools/bpf/runqslower/Makefile
@@ -6,6 +6,7 @@ OUTPUT ?= $(abspath .output)/
 BPFTOOL_OUTPUT := $(OUTPUT)bpftool/
 DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)bootstrap/bpftool
 BPFTOOL ?= $(DEFAULT_BPFTOOL)
+BPF_TARGET_ENDIAN ?= --target=bpf
 LIBBPF_SRC := $(abspath ../../lib/bpf)
 BPFOBJ_OUTPUT := $(OUTPUT)libbpf/
 BPFOBJ := $(BPFOBJ_OUTPUT)libbpf.a
@@ -63,7 +64,7 @@ $(OUTPUT)/%.skel.h: $(OUTPUT)/%.bpf.o | $(BPFTOOL)
 	$(QUIET_GEN)$(BPFTOOL) gen skeleton $< > $@
 
 $(OUTPUT)/%.bpf.o: %.bpf.c $(BPFOBJ) | $(OUTPUT)
-	$(QUIET_GEN)$(CLANG) -g -O2 --target=bpf $(INCLUDES)		      \
+	$(QUIET_GEN)$(CLANG) -g -O2 $(BPF_TARGET_ENDIAN) $(INCLUDES)	      \
 		 -c $(filter %.c,$^) -o $@ &&				      \
 	$(LLVM_STRIP) -g $@
 
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 8d206266d98c8..1d1aed1b0872f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -354,6 +354,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
 		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
+		    BPF_TARGET_ENDIAN=$(BPF_TARGET_ENDIAN)		       \
 		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS) $(EXTRA_CFLAGS)' \
 		    EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' &&	       \
 		    cp $(RUNQSLOWER_OUTPUT)runqslower $@
-- 
2.39.5




