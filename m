Return-Path: <stable+bounces-172489-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F077AB32234
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CB01A04043
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D112BE62E;
	Fri, 22 Aug 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdvOwSoV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062D35975
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755886698; cv=none; b=Sz2tiZ79RTsvjdb8Is4gojiGN+W9nhNxofB9YD2Isz439qE1nO12tWL8pc04DXYDUGK9nuCVq/vzrRCF19PilI8R3VUsWf6J6RpVvxxMEyAFkVPbreBx0X9agciJmpU2poG/TZzh2IK1ar5ADbUYX7bgPRBjM/tP7NBblzbQHyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755886698; c=relaxed/simple;
	bh=pmMOLRm9PZWKWQaIpoJlCEMLBxMFN1yf8r7ci6M4i5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iCsQ0c6MkgSHHRyLi3o4fcFEUe/E7CTjST7N1K+10hQNxXJ+CNLSiKQC3bf/VzTLM/Qu7m0yuGr6FTdlDAu7aeHsxXfbbnujko5ezWokepRjzFne/fh+fKEFOCYp2qEYO25skKe+YNwrLBBQ0wivt7fceP5tycMXnXUblPeefm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdvOwSoV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 961F4C4CEED;
	Fri, 22 Aug 2025 18:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755886698;
	bh=pmMOLRm9PZWKWQaIpoJlCEMLBxMFN1yf8r7ci6M4i5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fdvOwSoVOlnH8CI6PJr/cppTdv61aVyhNFbyT19A1wtKLA/PM5Y5as1bTkB+4RM85
	 waLwNdmQ5SgorCOS7p94zoDq1GhswSGlGlHx9OB5il0cOOfcuL+S090hEN//RlIhue
	 u092n6visHmI1uxRKC8E3eKlg5aG12SLSmTLUxa+/ON8V18HgVMgwDc2IJr+Iiqze8
	 NRCxgdnJIvxo42WtnCFUee5pmdptZd29qKswAWKCs7lAZKSWIH51U+gkxn4P+NlMu+
	 Ch2er/DlNaZETAo+5CWwdKHdhsXbGzmTQMotPjJ6ogEVMb3dCvpj2/GxeyB60Xfdpb
	 HZyNspMCTppjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] soc: qcom: mdt_loader: Ensure we don't read past the ELF header
Date: Fri, 22 Aug 2025 14:18:15 -0400
Message-ID: <20250822181815.1360340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082136-curve-morality-6c4a@gregkh>
References: <2025082136-curve-morality-6c4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 9f9967fed9d066ed3dae9372b45ffa4f6fccfeef ]

When the MDT loader is used in remoteproc, the ELF header is sanitized
beforehand, but that's not necessary the case for other clients.

Validate the size of the firmware buffer to ensure that we don't read
past the end as we iterate over the header. e_phentsize and e_shentsize
are validated as well, to ensure that the assumptions about step size in
the traversal are valid.

Fixes: 2aad40d911ee ("remoteproc: Move qcom_mdt_loader into drivers/soc/qcom")
Cc: stable@vger.kernel.org
Reported-by: Doug Anderson <dianders@chromium.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Link: https://lore.kernel.org/r/20250610-mdt-loader-validation-and-fixes-v2-1-f7073e9ab899@oss.qualcomm.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/mdt_loader.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 6034cd8992b0..c2bbde533e66 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -12,11 +12,43 @@
 #include <linux/firmware.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/qcom_scm.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
 
+static bool mdt_header_valid(const struct firmware *fw)
+{
+	const struct elf32_hdr *ehdr;
+	size_t phend;
+	size_t shend;
+
+	if (fw->size < sizeof(*ehdr))
+		return false;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+
+	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG))
+		return false;
+
+	if (ehdr->e_phentsize != sizeof(struct elf32_phdr))
+		return false;
+
+	phend = size_add(size_mul(sizeof(struct elf32_phdr), ehdr->e_phnum), ehdr->e_phoff);
+	if (phend > fw->size)
+		return false;
+
+	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+		return false;
+
+	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+	if (shend > fw->size)
+		return false;
+
+	return true;
+}
+
 static bool mdt_phdr_valid(const struct elf32_phdr *phdr)
 {
 	if (phdr->p_type != PT_LOAD)
@@ -46,6 +78,9 @@ ssize_t qcom_mdt_get_size(const struct firmware *fw)
 	phys_addr_t max_addr = 0;
 	int i;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -92,6 +127,9 @@ void *qcom_mdt_read_metadata(const struct firmware *fw, size_t *data_len)
 	size_t ehdr_size;
 	void *data;
 
+	if (!mdt_header_valid(fw))
+		return ERR_PTR(-EINVAL);
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -151,6 +189,9 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	if (!mdt_header_valid(fw))
+		return -EINVAL;
+
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
-- 
2.50.1


