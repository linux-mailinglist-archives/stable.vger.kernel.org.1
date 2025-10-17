Return-Path: <stable+bounces-187403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31015BEA332
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B811AE327C
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822C330B1F;
	Fri, 17 Oct 2025 15:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IO6TthJI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D2C330B3C;
	Fri, 17 Oct 2025 15:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715971; cv=none; b=Qaswhv4IG7+dQ5C3f8MbXF+xRfRU1qiO/jEmMW0nLkrebR9klvXBUn1PNYGeymEpySC8voFydp6kGLexlKG5S6Y4KbuB47bIohAAaYdImVD61Zj7H80UJyVcBH4O79E+GWBntOFg88hj227qIyzHmPnkSvELRhz/gDPwxQzRmtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715971; c=relaxed/simple;
	bh=7yUBZFzdl0E1dQmioxozpJtxQqJ3562WOq78yinS/eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WbiyAurh5ram2bTLnPVRWqN7UGzGJg0yea8V3gu9H1fGAYqAK5VnzSMiroIR1776WyqaWI0uyvbvm81hg/hNH9GomF30jBiDocXMXvNCIoszYen3wMYgZpTbCVXFnykJKLmaU/u5a+RNHP+VCLiUSKvc7yuN90A2sV7fc5ZRs9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IO6TthJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AFEC4CEFE;
	Fri, 17 Oct 2025 15:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715970;
	bh=7yUBZFzdl0E1dQmioxozpJtxQqJ3562WOq78yinS/eI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IO6TthJILbt4poJrkouUPhQ9fbvPT3WZlmdJ47Mm1wQ+A6CXVSWuSZMnlAEN6pOJC
	 ZNlQ8MNTfVisclOCx/x8PqehVzq8k9jHrwM7NJ6GxqF7QERCAILVwrCcoGmRWF8DiE
	 73H8kjZdZaBwwHFXvqo3ZyW4wqcsJ12ojA1WOMAU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 028/276] regmap: Remove superfluous check for !config in __regmap_init()
Date: Fri, 17 Oct 2025 16:52:01 +0200
Message-ID: <20251017145143.431205915@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145142.382145055@linuxfoundation.org>
References: <20251017145142.382145055@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 5c36b86d2bf68fbcad16169983ef7ee8c537db59 ]

The first thing __regmap_init() do is check if config is non-NULL,
so there is no need to check for this again later.

Fixes: d77e745613680c54 ("regmap: Add bulk read/write callbacks into regmap_config")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://patch.msgid.link/a154d9db0f290dda96b48bd817eb743773e846e1.1755090330.git.geert+renesas@glider.be
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index ebddc69bc969c..35cfbec6bf9ac 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -888,7 +888,7 @@ struct regmap *__regmap_init(struct device *dev,
 		map->read_flag_mask = bus->read_flag_mask;
 	}
 
-	if (config && config->read && config->write) {
+	if (config->read && config->write) {
 		map->reg_read  = _regmap_bus_read;
 
 		/* Bulk read/write */
-- 
2.51.0




