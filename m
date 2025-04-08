Return-Path: <stable+bounces-129567-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB3FA8008A
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9278443C96
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A1D267F65;
	Tue,  8 Apr 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yI4a1KlG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A330826561C;
	Tue,  8 Apr 2025 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111379; cv=none; b=IZpvosgoCuWFKliktRh1KplugIoXa4o4oj20BPNMtchaPClE70Zmx6npmfVTHn7EF4Wdr7Jg4oMUp2pLoXUaSv+fmCVBBFafDzqBolauP9PXpup67fv1oygCvd2RA5A/wvFm2cNUb181mmhD6/S2IRynP28DH8wVRh7IPgYlqqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111379; c=relaxed/simple;
	bh=KSzs7I4XvPNtnXyT6PLxA0ibUmTCACsLi3991nJye5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TltCd+cKRP1iUg6W1njSe9cMpPzhjm4Gxe4s2j4mXEX1MFakJwrCwfsIAT2/WXaru9QuVRBfrLBHKqdt6XW6gMQivgcIpVGd2Qd47GqWXlCpz7EkCr8dljJN7EKlKSsOuY4akMS6zzQEbeWaw70UGgO9RrvFcbtHv8SJtNHh2yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yI4a1KlG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34714C4CEE5;
	Tue,  8 Apr 2025 11:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111379;
	bh=KSzs7I4XvPNtnXyT6PLxA0ibUmTCACsLi3991nJye5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yI4a1KlG9nvYNR5NM3Vujs5Vx9zexdFrgceRDdMxr5xXK+v0smDD+kPtMw+u5SOth
	 t/3Z51kEJn6lVPsd9fLaC/Jgdp/xQvPDoRNCp7iXUsuLBifCtrmE0FDkxT4faWWkwf
	 Lxmrf5YDxtJAHtPEyHBRz6jjAe1KjdldqwK/NJf4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jinghao Jia <jinghao7@illinois.edu>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ruowen Qin <ruqin@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 410/731] samples/bpf: Fix broken vmlinux path for VMLINUX_BTF
Date: Tue,  8 Apr 2025 12:45:07 +0200
Message-ID: <20250408104923.810340069@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
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

From: Jinghao Jia <jinghao7@illinois.edu>

[ Upstream commit 94f53edc64e19640b5245721cd6d0c4a84f52587 ]

Commit 13b25489b6f8 ("kbuild: change working directory to external
module directory with M=") changed kbuild working directory of bpf
sample programs to samples/bpf, which broke the vmlinux path for
VMLINUX_BTF, as the Makefiles assume the current work directory to be
the kernel output directory and use a relative path (i.e., ./vmlinux):

  Makefile:316: *** Cannot find a vmlinux for VMLINUX_BTF at any of "  /path/to/linux/samples/bpf/vmlinux", build the kernel or set VMLINUX_BTF like "VMLINUX_BTF=/sys/kernel/btf/vmlinux" or VMLINUX_H variable.  Stop.

Correctly refer to the kernel output directory using $(objtree).

Fixes: 13b25489b6f8 ("kbuild: change working directory to external module directory with M=")
Signed-off-by: Jinghao Jia <jinghao7@illinois.edu>
Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Tested-by: Ruowen Qin <ruqin@redhat.com>
Link: https://lore.kernel.org/bpf/20250203085506.220297-3-jinghao7@illinois.edu
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index dd9944a97b7e6..5b632635e00dd 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -307,7 +307,7 @@ $(obj)/$(TRACE_HELPERS): TPROGS_CFLAGS := $(TPROGS_CFLAGS) -D__must_check=
 
 VMLINUX_BTF_PATHS ?= $(abspath $(if $(O),$(O)/vmlinux))				\
 		     $(abspath $(if $(KBUILD_OUTPUT),$(KBUILD_OUTPUT)/vmlinux))	\
-		     $(abspath ./vmlinux)
+		     $(abspath $(objtree)/vmlinux)
 VMLINUX_BTF ?= $(abspath $(firstword $(wildcard $(VMLINUX_BTF_PATHS))))
 
 $(obj)/vmlinux.h: $(VMLINUX_BTF) $(BPFTOOL)
-- 
2.39.5




