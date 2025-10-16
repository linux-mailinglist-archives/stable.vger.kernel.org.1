Return-Path: <stable+bounces-186006-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 527EBBE3335
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 13:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF54F1A63B07
	for <lists+stable@lfdr.de>; Thu, 16 Oct 2025 11:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FEF31C591;
	Thu, 16 Oct 2025 11:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="icI7z3/6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAF32D320B
	for <stable@vger.kernel.org>; Thu, 16 Oct 2025 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615835; cv=none; b=CaWAhNa4x3oFRKgNrz4UMVCe8q9Pzh2JPP6T0OcMCOaqjczhvWP9pQTFIV6GtqOcMkO70d911GPFTsUnSU3HU+5S8PeLzIT/rq2rGgHEBwBbwgG2UJb4KN0qdGd0FpHW2wWtqIwcj/439D6eu2AibbLLeyXSHDI/ZMeiEsHw2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615835; c=relaxed/simple;
	bh=V8hv0wFeTGYdUzlT6wejav2H15scRUVSHCD0N95fkvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipdj6URtkel+MLZ8IlFPvAUJwwFD3Ym9Y3sKD3n/6bE68iRImutrbcnXFi1FF04xIcp7Kd9eVA+5OB1Nqn7Q6/qyWzGdeMpNvw4IUCBrxRxV2CVYa4Wq3ry+/uELHI/NsStNqyt9dPPPteSy07n32h4EPqX9ZEi/rx5pWAz/BEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=icI7z3/6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F066BC4CEF1;
	Thu, 16 Oct 2025 11:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760615834;
	bh=V8hv0wFeTGYdUzlT6wejav2H15scRUVSHCD0N95fkvE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=icI7z3/6QSu7hYvg7i0VnY1vkFL+7tcNqgJEpPoi4khaznSlgJT0zMCIKuCNzc41V
	 pPKzstj0iI4WnHOIL361yMqGvo6pV+BQ0G9w6u9hC+G9IrKiQw81ALHcgKD8hc4Sh6
	 x+NwglosrKGDvLwm1P4eB9d7u4l8upzH73oJzwAQdrNS7vX0kw8rnEe9dRIdjqQ0bD
	 iGOBnXHj5PrSyRSVZVqI5U7+bLjHB9bQz+cVM6bMlvUWi1vb23mhyH4buEXVgOK2AZ
	 qi97K9xVHhLI8bL2nkcwtTcv4pdYNNgcSTm89z7b9ze7uXPzhs0Byo4hGvx65eojwK
	 GNt5sHjDNeEhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] asm-generic/io.h: suppress endianness warnings for relaxed accessors
Date: Thu, 16 Oct 2025 07:57:08 -0400
Message-ID: <20251016115709.3259702-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251016115709.3259702-1-sashal@kernel.org>
References: <2025101544-snoring-unseemly-47ff@gregkh>
 <20251016115709.3259702-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit 05d3855b4d21ef3c2df26be1cbba9d2c68915fcb ]

Copy the forced type casts from the normal MMIO accessors to suppress
the sparse warnings that point out __raw_readl() returns a native endian
word (just like readl()).

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Stable-dep-of: 8327bd4fcb6c ("asm-generic/io.h: Skip trace helpers if rwmmio events are disabled")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/io.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index d78c3056c98f9..587e7e9b9a375 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -319,7 +319,7 @@ static inline u16 readw_relaxed(const volatile void __iomem *addr)
 	u16 val;
 
 	log_read_mmio(16, addr, _THIS_IP_, _RET_IP_);
-	val = __le16_to_cpu(__raw_readw(addr));
+	val = __le16_to_cpu((__le16 __force)__raw_readw(addr));
 	log_post_read_mmio(val, 16, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
@@ -332,7 +332,7 @@ static inline u32 readl_relaxed(const volatile void __iomem *addr)
 	u32 val;
 
 	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
-	val = __le32_to_cpu(__raw_readl(addr));
+	val = __le32_to_cpu((__le32 __force)__raw_readl(addr));
 	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
@@ -345,7 +345,7 @@ static inline u64 readq_relaxed(const volatile void __iomem *addr)
 	u64 val;
 
 	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
-	val = __le64_to_cpu(__raw_readq(addr));
+	val = __le64_to_cpu((__le64 __force)__raw_readq(addr));
 	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
 	return val;
 }
@@ -366,7 +366,7 @@ static inline void writeb_relaxed(u8 value, volatile void __iomem *addr)
 static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
-	__raw_writew(cpu_to_le16(value), addr);
+	__raw_writew((u16 __force)cpu_to_le16(value), addr);
 	log_post_write_mmio(value, 16, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
@@ -376,7 +376,7 @@ static inline void writew_relaxed(u16 value, volatile void __iomem *addr)
 static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
-	__raw_writel(__cpu_to_le32(value), addr);
+	__raw_writel((u32 __force)__cpu_to_le32(value), addr);
 	log_post_write_mmio(value, 32, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
@@ -386,7 +386,7 @@ static inline void writel_relaxed(u32 value, volatile void __iomem *addr)
 static inline void writeq_relaxed(u64 value, volatile void __iomem *addr)
 {
 	log_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
-	__raw_writeq(__cpu_to_le64(value), addr);
+	__raw_writeq((u64 __force)__cpu_to_le64(value), addr);
 	log_post_write_mmio(value, 64, addr, _THIS_IP_, _RET_IP_);
 }
 #endif
-- 
2.51.0


