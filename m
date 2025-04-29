Return-Path: <stable+bounces-139001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8BAA3D8C
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 02:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F661B66D2B
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 00:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E7228D311;
	Tue, 29 Apr 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iMdxqZb1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E928D308;
	Tue, 29 Apr 2025 23:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970695; cv=none; b=IvzjHv6t5IK7v0KktZJcJtyN8MNnkb/rsbwdEK5MrKx+4k6W2klzJf7/ZBXrEoqEyvH41e+1AvOLua59XE4GcJDZpxbPdOWmWci5YMQSwqGG+I8GId8FiqFaOJ4oY8tPxuVJXYVNzPcGgy48h9TL3I2/NrXAxDyE8OaXBBv+sNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970695; c=relaxed/simple;
	bh=mn2OJK9nfrZBwazt/tK62atJTBt/LKwKlt0TM28XSqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QZB1udd9ENPGl66/UkgfX3xHZm/ZKUmHuztm/N9lylGcXc1lJ8ySJRhH6hWrPTIViwcF8jFSE6lSf9gzZ/w5upAIGIM4QHlof9I/hdiUh0mLHfKk+x7ZnAnjSetoUylCmvjlYuHVgpI0wmvJPk0xQ//3obxSxuyOyZB1NcUbSJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iMdxqZb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1592AC4CEE3;
	Tue, 29 Apr 2025 23:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970695;
	bh=mn2OJK9nfrZBwazt/tK62atJTBt/LKwKlt0TM28XSqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iMdxqZb136rXTD9Z62udH/BxqXfmu4YafXgi3FNo+QvhkPzB0PYlt0jrIHPyAMR67
	 r2Rhp9dO1FW4BoGX1mfVvvm4lOt0Jru9MA1csEX3PEaSQ8TFJGg4kXl2RSFZrJqFtk
	 LSCohcFe6eatn+1gYHk5gm+SQ065D9/lW7Q9M6aAvqlCso5p3H9/lGuLo0MN4RPvN7
	 a15+YWneelvcIFgXCTNHZLTIwOXDL/toW3Zh3xP8nl1maPTpSKdV1KZK4bYUJ6N+yD
	 5fobKJkF0WVMCcw44+L4izqRkd6FzL9x0Md8mwyM3MXF2BT5qMvltojE5VX2eJKQO5
	 1nW+PysoV6BjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	srini@kernel.org
Subject: [PATCH AUTOSEL 6.12 06/37] nvmem: core: verify cell's raw_len
Date: Tue, 29 Apr 2025 19:50:51 -0400
Message-Id: <20250429235122.537321-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
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
index 8af2a569c23aa..3671d156c7c33 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -592,6 +592,18 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
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


