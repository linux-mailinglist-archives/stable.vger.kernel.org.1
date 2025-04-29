Return-Path: <stable+bounces-138962-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BD0AA3D0F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 01:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0929016BB1F
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2BB255F53;
	Tue, 29 Apr 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC4+Q4/3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E682550AD;
	Tue, 29 Apr 2025 23:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970619; cv=none; b=g7Cs4z+ibu47OxjyvL9wp5EatEoh2yw3V/h53Oi3/19Mpej/QW1eljjdgi20yeINlNTTG+OXay9HiMurVVUb9eYLIok7WWsmPFHYfunIx+CFsWGl5Q6mqFN9BIFJh7XWYmlUB8a/a+9yY3qOSI+gnHevzhgpU4Wf/vYi7dEqXZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970619; c=relaxed/simple;
	bh=eCV3lvXqkx8LFgE8OQ6xgie/yj0QNu/Pm9JrEcAqrUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q4xuu3+LMN3/RdthJUq7385OeMGh2ke4jOkY+Tdvh6Iu/nKzsM4z94VqDWFejWIVSN5C6J6n+t+y0OmlcLaOF/2jdP/HriTDpTnyIB5i1Yc4PEG2v6thVl7ERUlmWAdFwrN6ujuWnFL8HlWe1t02J+ty4G4LCKqGCeUcfjb+/Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC4+Q4/3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B40C4CEE3;
	Tue, 29 Apr 2025 23:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970619;
	bh=eCV3lvXqkx8LFgE8OQ6xgie/yj0QNu/Pm9JrEcAqrUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CC4+Q4/3YkzHr4/m7HbXIbl/sn8LuT4u8byH5Lq/oYD62vDSWOXZBaJs9h5lWrn/7
	 Ogj06MMIpjb7oVJmD6jivgzxc/6ZHTThAoUX7XygPG0MY36pHeRWq/o3VuUsNNdy6o
	 xNKPwtXCKReJVjI89mfsDCjUlSPTgl8Vz+/EUujZRocHCrIJWPqttzxj++iGlNy1Kv
	 qcD4mlOZbxnJEpZ4eeakuhGwqs2tJEDVTE/uIyJgl2WejoxqBLVprUB7q8EjicV/aI
	 fn5XUtgCFkLH0EzuEAT55yaxWdoOxIpTneZLy2zFURNHVVBhN6bOjl1GxWk8qOLy5S
	 5qJfZ950Qt98w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org
Subject: [PATCH AUTOSEL 6.14 06/39] nvmem: core: verify cell's raw_len
Date: Tue, 29 Apr 2025 19:49:33 -0400
Message-Id: <20250429235006.536648-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit 13bcd440f2ff38cd7e42a179c223d4b833158b33 ]

Check that the NVMEM cell's raw_len is a aligned to word_size. Otherwise
Otherwise drivers might face incomplete read while accessing the last
part of the NVMEM cell.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20250411112251.68002-10-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvmem/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 7872903c08a11..7b8c85f9e035c 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -605,6 +605,18 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 		return -EINVAL;
 	}
 
+	if (!IS_ALIGNED(cell->raw_len, nvmem->word_size)) {
+		dev_err(&nvmem->dev,
+			"cell %s raw len %zd unaligned to nvmem word size %d\n",
+			cell->name ?: "<unknown>", cell->raw_len,
+			nvmem->word_size);
+
+		if (info->raw_len)
+			return -EINVAL;
+
+		cell->raw_len = ALIGN(cell->raw_len, nvmem->word_size);
+	}
+
 	return 0;
 }
 
-- 
2.39.5


