Return-Path: <stable+bounces-172478-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C368EB3216A
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84A67AA8142
	for <lists+stable@lfdr.de>; Fri, 22 Aug 2025 17:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3871096F;
	Fri, 22 Aug 2025 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJuERWNn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A727AC37
	for <stable@vger.kernel.org>; Fri, 22 Aug 2025 17:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755883208; cv=none; b=dvSpbbw7l1rXQeIUjyn5DCr9HfRgRh4dIjEtgJx0LCEOn98Pmh9azjIcn0uBgooS6rdhRYHbxvUVZWoB6RJQxut66Wg+cB+3W1xgID9TesVHAEg0rUpqx5kh4/ID5BVpNGEEX7ESpolfIJJUQSJmSM2CXIip8gEVvM4sYkqilHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755883208; c=relaxed/simple;
	bh=m3cZeFchT4K29btKZKWLEp5r0ySxW9xn1PDWCnLAeQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Is+kVpe0yv1G/isPUiDDH6fr3h71OLWgOeQOxVyGUghxPlrA3EBrfExOlg+AQWcbHlDtunzlYIfAXX769Ly1pihY04jpJP3x0d/4chs0Pqbal0rFLvXFXusk/Y4Bn+d1ZTbxazpW33SJRWItdnqlfGhW9TiQrzT/YFzbhO5/zg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJuERWNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F7C1C4CEED;
	Fri, 22 Aug 2025 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755883208;
	bh=m3cZeFchT4K29btKZKWLEp5r0ySxW9xn1PDWCnLAeQU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJuERWNnuKLv7yzOim137kptA1tcPiGGw3k+Yr+f2BvVLUOFneNAqLDEMjap8p98c
	 vwdGmdaXuvBt4M3RZBU441+CFZ234vc8SwWiA9aanTQKwt+l31zoBqg6okNOywO1bK
	 fupJ7u1bUJ108k6grvHOg1f3PISYYrURRxuukts9TiGDgo34qUI5LUAIVUhMYlF2HO
	 Md3ARp1MjcOxmXgVVUF9S7D2cC+fh4s4IwdJ1uQN7bk6o3i9O9vg4zTjmiNbVxjpAM
	 hUYnf1c0wGakqoaOg7UMtF0dFmFI77c9sHKHIFkfXLdbgjfl3Y8K/BLpYCpltGET5h
	 spr5jULqX2wRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>,
	Melody Olvera <quic_molvera@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] soc: qcom: mdt_loader: Enhance split binary detection
Date: Fri, 22 Aug 2025 13:20:04 -0400
Message-ID: <20250822172005.1328408-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025082135-dividable-grandma-3c11@gregkh>
References: <2025082135-dividable-grandma-3c11@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>

[ Upstream commit 210d12c8197a551caa2979be421aa42381156aec ]

It may be that the offset of the first program header lies inside the mdt's
filesize, in this case the loader would incorrectly assume that the bins
were not split and in this scenario the firmware authentication fails.
This change updates the logic used by the mdt loader to understand whether
the firmware images are split or not. It figures this out by checking if
each programs header's segment lies within the file or not.

Co-developed-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
Signed-off-by: Gokul krishna Krishnakumar <quic_gokukris@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230509001821.24010-1-quic_gokukris@quicinc.com
Stable-dep-of: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/mdt_loader.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 10235b36d131..c075d38f38fe 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -264,6 +264,26 @@ int qcom_mdt_pas_init(struct device *dev, const struct firmware *fw,
 }
 EXPORT_SYMBOL_GPL(qcom_mdt_pas_init);
 
+static bool qcom_mdt_bins_are_split(const struct firmware *fw, const char *fw_name)
+{
+	const struct elf32_phdr *phdrs;
+	const struct elf32_hdr *ehdr;
+	uint64_t seg_start, seg_end;
+	int i;
+
+	ehdr = (struct elf32_hdr *)fw->data;
+	phdrs = (struct elf32_phdr *)(ehdr + 1);
+
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		seg_start = phdrs[i].p_offset;
+		seg_end = phdrs[i].p_offset + phdrs[i].p_filesz;
+		if (seg_start > fw->size || seg_end > fw->size)
+			return true;
+	}
+
+	return false;
+}
+
 static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 			   const char *fw_name, int pas_id, void *mem_region,
 			   phys_addr_t mem_phys, size_t mem_size,
@@ -276,6 +296,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	phys_addr_t min_addr = PHYS_ADDR_MAX;
 	ssize_t offset;
 	bool relocate = false;
+	bool is_split;
 	void *ptr;
 	int ret = 0;
 	int i;
@@ -283,6 +304,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 	if (!fw || !mem_region || !mem_phys || !mem_size)
 		return -EINVAL;
 
+	is_split = qcom_mdt_bins_are_split(fw, fw_name);
 	ehdr = (struct elf32_hdr *)fw->data;
 	phdrs = (struct elf32_phdr *)(ehdr + 1);
 
@@ -336,8 +358,7 @@ static int __qcom_mdt_load(struct device *dev, const struct firmware *fw,
 
 		ptr = mem_region + offset;
 
-		if (phdr->p_filesz && phdr->p_offset < fw->size &&
-		    phdr->p_offset + phdr->p_filesz <= fw->size) {
+		if (phdr->p_filesz && !is_split) {
 			/* Firmware is large enough to be non-split */
 			if (phdr->p_offset + phdr->p_filesz > fw->size) {
 				dev_err(dev, "file %s segment %d would be truncated\n",
-- 
2.50.1


