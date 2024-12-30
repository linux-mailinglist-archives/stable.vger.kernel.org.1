Return-Path: <stable+bounces-106328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4909FE7E1
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 16:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3057A14F4
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2667415748F;
	Mon, 30 Dec 2024 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KnWJ+Qfk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D797615E8B;
	Mon, 30 Dec 2024 15:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735573596; cv=none; b=CPT3RvxEjcvUmFGTRU2XBtHDFZsVzT2VUO0eNC64ypmUQfm77iPZfkCxr2k6K74ICPO0kRK4Tpr9JRqVlaDJ21yoX2i8aiIRn1Ix+zfmB3ehHgjDsVUe2e/taDyH5b2kh5ehEOVQTyrJLQajakCeuprI7KVh8tKcbzwh8hqvImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735573596; c=relaxed/simple;
	bh=pYIGb1VUcUpAuv0b1QHEDhhdJvV0m+iDGluIZ+cGfV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DqUsqYUPLC0NWCIWfsLeV2rAMtWFgUGKuRmDkM2Z3FYP5umJv2o9vZCK4lrWqGTbWro87ezjUhsMPbGxgsyPcnd8mrX1S6epThTBfKX+fGusLB4nIWvFRcY3ZExNlsvpU1kE6hxUCMKHEHLnJH1JD6nvvVw0wXVTeZw+LhMCnp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KnWJ+Qfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED54C4CED0;
	Mon, 30 Dec 2024 15:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1735573596;
	bh=pYIGb1VUcUpAuv0b1QHEDhhdJvV0m+iDGluIZ+cGfV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KnWJ+QfkKp6LeyjNVep13O6gjun38RoK7EnZFV+tfCvZiJqm6TlhTxExVdJhRkXNg
	 KRfbAyHQZfH94PWYyTdQqJwcIFRR+eH8t5NENgHFkmFLzS+6q0ct/wBww2G5wbnUj+
	 d+oPr8+FajSL/XskPGP8pXoHHOHPmp2l9aDbXWuk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	WangYuli <wangyuli@uniontech.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 40/60] MIPS: Probe toolchain support of -msym32
Date: Mon, 30 Dec 2024 16:42:50 +0100
Message-ID: <20241230154208.802482602@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230154207.276570972@linuxfoundation.org>
References: <20241230154207.276570972@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiaxun Yang <jiaxun.yang@flygoat.com>

[ Upstream commit 18ca63a2e23c5e170d2d7552b64b1f5ad019cd9b ]

msym32 is not supported by LLVM toolchain.
Workaround by probe toolchain support of msym32 for KBUILD_SYM32
feature.

Link: https://github.com/ClangBuiltLinux/linux/issues/1544
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index dd6486097e1d..6468f1eb39f3 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -304,7 +304,7 @@ drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 ifdef CONFIG_64BIT
   ifndef KBUILD_SYM32
     ifeq ($(shell expr $(load-y) \< 0xffffffff80000000), 0)
-      KBUILD_SYM32 = y
+      KBUILD_SYM32 = $(call cc-option-yn, -msym32)
     endif
   endif
 
-- 
2.39.5




