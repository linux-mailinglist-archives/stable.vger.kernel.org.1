Return-Path: <stable+bounces-102368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1749EF278
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E07A0189B3A5
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC98722EA00;
	Thu, 12 Dec 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i5DTvvvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6571222D77;
	Thu, 12 Dec 2024 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020972; cv=none; b=HmpodDRz3A67cOgkve06EGOfiB7mRAA6jNfaK2SGe/3nrFc++aZcDhYPLGMgUm3p+7CyjjyGL+ByMNFNyQ87zibBihdgI1BMv5nzeYv1/ALjuPZLFJ5SR4DZsVI+e7tZXaloJI/0W20SLiNqhpTDlMGZIf6Lo1xOC2nPkeFr7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020972; c=relaxed/simple;
	bh=FM1VCcwbJKU02cwM88cr3SBtcO94BGzDeD4h2ZTBvZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EkSCo6q30tw0JocaQwfUuYPQ/F4fCcpZ09E6IRWsa/+b5+uA3oexlUXHTmpitr1YSberf84hosXISwk5aOhP0KKMLmkETAzaBDL885UW76sKufZCjnqIHucupfRZgtWMYzJ8o/MYYL4JkZ8QABpes1wUaxCwrLKe5K9JhRBRa+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i5DTvvvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB944C4CED0;
	Thu, 12 Dec 2024 16:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020972;
	bh=FM1VCcwbJKU02cwM88cr3SBtcO94BGzDeD4h2ZTBvZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i5DTvvvZw8kYum9uM8UsCAfOaTvIx7QcEgYT5zhZye4hQJcSUlhnsVfitgA+LvYqw
	 4Z1JQ9Yx6ygu0fsmyo6bbjR7702l+1tnqQ7UTUjeRbtx67IDfhz/3vqo/v4Aa/cb2h
	 h1qAgpvwqnR41Apf+MwfMp6Q7O+wSbGKXyEzd5ro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.1 611/772] arm64: Ensure bits ASID[15:8] are masked out when the kernel uses 8-bit ASIDs
Date: Thu, 12 Dec 2024 15:59:16 +0100
Message-ID: <20241212144415.177210068@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Catalin Marinas <catalin.marinas@arm.com>

commit c0900d15d31c2597dd9f634c8be2b71762199890 upstream.

Linux currently sets the TCR_EL1.AS bit unconditionally during CPU
bring-up. On an 8-bit ASID CPU, this is RES0 and ignored, otherwise
16-bit ASIDs are enabled. However, if running in a VM and the hypervisor
reports 8-bit ASIDs (ID_AA64MMFR0_EL1.ASIDBits == 0) on a 16-bit ASIDs
CPU, Linux uses bits 8 to 63 as a generation number for tracking old
process ASIDs. The bottom 8 bits of this generation end up being written
to TTBR1_EL1 and also used for the ASID-based TLBI operations as the
upper 8 bits of the ASID. Following an ASID roll-over event we can have
threads of the same application with the same 8-bit ASID but different
generation numbers running on separate CPUs. Both TLB caching and the
TLBI operations will end up using different actual 16-bit ASIDs for the
same process.

A similar scenario can happen in a big.LITTLE configuration if the boot
CPU only uses 8-bit ASIDs while secondary CPUs have 16-bit ASIDs.

Ensure that the ASID generation is only tracked by bits 16 and up,
leaving bits 15:8 as 0 if the kernel uses 8-bit ASIDs. Note that
clearing TCR_EL1.AS is not sufficient since the architecture requires
that the top 8 bits of the ASID passed to TLBI instructions are 0 rather
than ignored in such configuration.

Cc: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: James Morse <james.morse@arm.com>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20241203151941.353796-1-catalin.marinas@arm.com
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/mm/context.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/arm64/mm/context.c
+++ b/arch/arm64/mm/context.c
@@ -32,9 +32,9 @@ static unsigned long nr_pinned_asids;
 static unsigned long *pinned_asid_map;
 
 #define ASID_MASK		(~GENMASK(asid_bits - 1, 0))
-#define ASID_FIRST_VERSION	(1UL << asid_bits)
+#define ASID_FIRST_VERSION	(1UL << 16)
 
-#define NUM_USER_ASIDS		ASID_FIRST_VERSION
+#define NUM_USER_ASIDS		(1UL << asid_bits)
 #define ctxid2asid(asid)	((asid) & ~ASID_MASK)
 #define asid2ctxid(asid, genid)	((asid) | (genid))
 



