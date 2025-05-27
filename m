Return-Path: <stable+bounces-147031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A98AC55CB
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DBB1BA6CE7
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 17:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C4B27E1CA;
	Tue, 27 May 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mo3Ncmhc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5868C1E89C;
	Tue, 27 May 2025 17:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748366059; cv=none; b=PhVeA5bVe3abFHmlDuTA8FZLGD91iGUODaRUtTaWbdyXiy8G8CBtWIJKGD7XI4p1wkOrwzphEV/Y6hIF9VNwqmX3iUZN3z9EPD22bgd+Ho4DIAyr87fDZR9NKuWbaHmBpWrVEuIEJ8mODCuNricQiwXc+Yri6IRRp/m+bh4MNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748366059; c=relaxed/simple;
	bh=ly1WBIBl2IPn0JdGZUIJi18zZ07PRPY//FakTvPyUzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xj39ZE+RLJbu8y0tlG33wl/b/pD5bsp4Gd+jt7OEGprIQNalrpw/VLwTJUiaiRuM/LQZNhzEvQ9OWuAyRPyR3tL/3nUDwAJZFrngCnhfIZEcJb5lUtdKIds+vqqUfKAn7CRivIpelLsN3F7iHk8jsG7TzviOwelZT3ZZZyQ0SJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mo3Ncmhc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03E4C4CEE9;
	Tue, 27 May 2025 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748366059;
	bh=ly1WBIBl2IPn0JdGZUIJi18zZ07PRPY//FakTvPyUzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mo3NcmhcG7I0kdAGGwRBKZmGyD4tJNw/dIfG4gt4Yki0M+8yUgk6BMZEVppPXQe58
	 y98J7AHYNuzOqtc9C8m5JemFqDcuZ+IH/HORAOns509sdYwK+5NmUNALdbG3V2NWjw
	 hyAuefM2e/1Yhkpz2Sw8GVbUlOuEVHs89FuBIRO4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Raag Jadav <raag.jadav@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 547/626] devres: Introduce devm_kmemdup_array()
Date: Tue, 27 May 2025 18:27:20 +0200
Message-ID: <20250527162507.208575392@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527162445.028718347@linuxfoundation.org>
References: <20250527162445.028718347@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Raag Jadav <raag.jadav@intel.com>

[ Upstream commit a103b833ac3806b816bc993cba77d0b17cf801f1 ]

Introduce '_array' variant of devm_kmemdup() which is more robust and
consistent with alloc family of helpers.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Stable-dep-of: 7dd7f39fce00 ("ASoC: SOF: Intel: hda: Fix UAF when reloading module")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/device/devres.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/device/devres.h b/include/linux/device/devres.h
index 6b0b265058bcc..9b49f99158508 100644
--- a/include/linux/device/devres.h
+++ b/include/linux/device/devres.h
@@ -79,6 +79,11 @@ void devm_kfree(struct device *dev, const void *p);
 
 void * __realloc_size(3)
 devm_kmemdup(struct device *dev, const void *src, size_t len, gfp_t gfp);
+static inline void *devm_kmemdup_array(struct device *dev, const void *src,
+				       size_t n, size_t size, gfp_t flags)
+{
+	return devm_kmemdup(dev, src, size_mul(size, n), flags);
+}
 
 char * __malloc
 devm_kstrdup(struct device *dev, const char *s, gfp_t gfp);
-- 
2.39.5




