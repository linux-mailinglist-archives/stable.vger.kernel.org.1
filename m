Return-Path: <stable+bounces-172492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4743B32267
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 20:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACFC1CE0003
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 18:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7224C299A84;
	Fri, 22 Aug 2025 18:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RT8cmG8h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BBC19D07A
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 18:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755888583; cv=none; b=hLqtocivDNvYDIyMGmTcgJQ2YTxL9pQ7s7dWFIFtygg0dKspzzzKsykWeCvZKYfVDbBcP8j/EcPxOSz0Zj6Jyb/zcP+hitVQd0nhWdppFvpnF19mdY1cnBXTZ5ccgBt6vy3reB5wGJDmS29Wi+ftI7FTbno5ohaQKdh+FKwo/TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755888583; c=relaxed/simple;
	bh=pmMOLRm9PZWKWQaIpoJlCEMLBxMFN1yf8r7ci6M4i5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h6MmBoJ1COJRBQObmblxqoA8QuGGEXiy7W9txmRwv/lpyaW7gmVN9BiWOHDBK/U7u1bnUkDzK1mG4yRIagEAi2D5UIHndLF407Y0F1xJrW891wU4FH4jl3NJzZ219j8t/J+rdiXXheYLxT6JTNzFXYNkR0WB7Ra+CELnwS9qGWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RT8cmG8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D67C4CEED;
	Fri, 22 Aug 2025 18:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755888582;
	bh=pmMOLRm9PZWKWQaIpoJlCEMLBxMFN1yf8r7ci6M4i5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RT8cmG8hvdbRUDaBZbXtqNuP5v60Mwb+hmM99heP9yaqjJGVlcyo3QLdWWC/QTBqf
	 TLuzhiwtS8SmXC2Ci8iAwrwQmZJFKKHiPchZslbScEPGlEA1sH4ogGo3uN3Dg4FN0c
	 yshSGQKDEhm2JNQQjPELXDD54ij5M7vrMZjphda1GMgN6yY+Cx87eah+tjSpGF+QaK
	 NpBuVUQNknd6XbA+M5hXyo5dofVRB5KQYmoD7UzXgip+O40bBWWFY+FmCoyTN9wxQu
	 lz0CYvys8C9tQ1698MXyb9DekcLGiqb7UcJ2PgdtDu3wKKJpJ4p++HQROtAlJsE4Ys
	 tmmlxK4LCb3cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Doug Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4.y] soc: qcom: mdt_loader: Ensure we don't read past the ELF header
Date: Fri, 22 Aug 2025 14:49:39 -0400
Message-ID: <20250822184939.1400692-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082137-glazing-stitch-f238@gregkh>
References: <2025082137-glazing-stitch-f238@gregkh>
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


