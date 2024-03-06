Return-Path: <stable+bounces-26893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3932C872BF7
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 02:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D91C21740
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 01:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62A0E4C91;
	Wed,  6 Mar 2024 01:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="CUyDawRL"
X-Original-To: stable@vger.kernel.org
Received: from eastern.birch.relay.mailchannels.net (eastern.birch.relay.mailchannels.net [23.83.209.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31990647
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 01:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709687326; cv=pass; b=AyBfhjqF8UdhJylhCO1JvLU1aQ76nVpn/MZQ2yDLFD882Qq5flo/RXGam5orxdNScgtH9dWZ9WXGiWK9T3n5+RS026pDeqIpZWRS7QxztU0IuvG9uWmSZ2ASeb4SYEeyh6i+3JZY1TJ6a0xdfBxpqcL+7Y2aV+jGli5Dtcd5d7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709687326; c=relaxed/simple;
	bh=HJle/GNNs09UVXorHkOiCGDS4/HVoyXE/hJOlYVCxmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cB1cucOBj8Y+Ui+h3kPI/EmcwHHb6MSqKFEq6wIHEhWCUnp7CfKG9k1RQs62uBnVVgroGM7e3zw95e7iElfqmChzvOFZHT28HifnBYEIKBGX3+UHPJ6tB+bzMPFymyBOK6X1MUIu5Vr5xLzYVFaR0hVcZASbnupiu22TwY+gHaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=CUyDawRL; arc=pass smtp.client-ip=23.83.209.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2F06C54157A
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 00:49:51 +0000 (UTC)
Received: from pdx1-sub0-mail-a210.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A1A0C541493
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 00:49:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709686190; a=rsa-sha256;
	cv=none;
	b=NDpVPv2tDMUkMrtEGxT8sb5rbRrUFkYPAPYCHH8AW52QqquAd8WEg4xGBSMnlt9pPdu1K2
	xR+LhTvp046FuviSfd8Yl+tUEajF09mHF5HgZlkDfhel1t1IH1o9zxSC3Pd7P+rtwFD+DZ
	OrFAR4tef1o86zjEpElBMyHmaFV0JGInIO6jIb48UVnlTaOMDFPjry0ZfYFOpiDU6Xng6/
	wBpkw5ePlMyXUUv2D5GwR96AfvThTDR0G+w09sHJH6kM9vixCMMp/Jx/d9r2VAWLnnEMxh
	vYcPr02rmtKJdK+Mc25p7VbcoSwXbNCr9idv7j3scgtyNFoHVU2WKwenqce3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709686190;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=EpX9FMnkSA9qP79yTLo4VHBROcf/tv5MB/+02P/ztu0=;
	b=GABCYUs2paSyUMOAhZrQvQe5rYiZif2piOWzFgMj8W4LcwZqnT4udDAVLeauIX1owbHmSp
	tA3LxGyIjebg/FVzsXFkgY8naa4k9d2bqugO/CzcIoVUJ8kb1rS8WRh51+iFcNFN+IfJNZ
	8XR31WzwLXiW3YMAr6+4IdAzX9iRKfM4hdaID0f9hcUOhDRafyO7Sezim1hBPzMSUZ82sN
	AssvuPAV7Bu31lwbx7MGkh8K1qGM/uGmV2a3qYaQS+SKpMe2mZp59y21S/N8c/rtQ7W0rJ
	eSjujA2VNHThj3/2ssvwihkbX7n1G2zC6s7g2CqVPqC0GorG5tHuPyu8TvgRIQ==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-lj49k;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Bored-Desert: 203cf16f5fac05ea_1709686191042_2217646402
X-MC-Loop-Signature: 1709686191042:2592001313
X-MC-Ingress-Time: 1709686191041
Received: from pdx1-sub0-mail-a210.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.101.14.227 (trex/6.9.2);
	Wed, 06 Mar 2024 00:49:51 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a210.dreamhost.com (Postfix) with ESMTPSA id 4TqDNZ33qBzJZ
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 16:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1709686190;
	bh=EpX9FMnkSA9qP79yTLo4VHBROcf/tv5MB/+02P/ztu0=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=CUyDawRLchInh2Z4hVUfwX06jZhk+jl4CWZEYX87v5l4IlFUDUXgV5ObfUSA5ZvSL
	 SmMSwIRoTYQvSGisDjchljM8w5MDE34aqyW6TQ28Ou9XBS92IqK2UArFUTCTul0QsD
	 jiJABEP1yLON7RNurEWcfp9kHBjnT92PpTNV3Tt4TvztGQjpIQfio0of3daCyFm3hU
	 jrU3yb68B4VH+KrW51f91btUGMR3Bsw6x25BqBruM6RundTWbmhhw2aLvyRD5izZTI
	 lxDzkuGk/0XAMCpSGZzcerRGWDqrYr189HgAiLJEuU1YixqVr5TqZzAvJve0uotf4Q
	 abEVsgrCUc2gg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e0082
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Tue, 05 Mar 2024 16:49:42 -0800
Date: Tue, 5 Mar 2024 16:49:42 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: stable@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org
Subject: [PATCH 5.15.y v2 1/2] KVM: arm64: Work out supported block level at
 compile time
Message-ID: <21a92d6c66b6100d45a9cf8a0e48f613576157fa.1709685364.git.kjlx@templeofstupid.com>
References: <cover.1709665227.git.kjlx@templeofstupid.com>
 <cover.1709685364.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709685364.git.kjlx@templeofstupid.com>

From: Oliver Upton <oliver.upton@linux.dev>

commit 3b5c082bbfa20d9a57924edd655bbe63fe98ab06 upstream.

Work out the minimum page table level where KVM supports block mappings
at compile time. While at it, rewrite the comment around supported block
mappings to directly describe what KVM supports instead of phrasing in
terms of what it does not.

Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20221007234151.461779-2-oliver.upton@linux.dev
Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 arch/arm64/include/asm/kvm_pgtable.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_pgtable.h b/arch/arm64/include/asm/kvm_pgtable.h
index 027783829584..87e782eec925 100644
--- a/arch/arm64/include/asm/kvm_pgtable.h
+++ b/arch/arm64/include/asm/kvm_pgtable.h
@@ -13,6 +13,18 @@
 
 #define KVM_PGTABLE_MAX_LEVELS		4U
 
+/*
+ * The largest supported block sizes for KVM (no 52-bit PA support):
+ *  - 4K (level 1):	1GB
+ *  - 16K (level 2):	32MB
+ *  - 64K (level 2):	512MB
+ */
+#ifdef CONFIG_ARM64_4K_PAGES
+#define KVM_PGTABLE_MIN_BLOCK_LEVEL	1U
+#else
+#define KVM_PGTABLE_MIN_BLOCK_LEVEL	2U
+#endif
+
 static inline u64 kvm_get_parange(u64 mmfr0)
 {
 	u64 parange = cpuid_feature_extract_unsigned_field(mmfr0,
@@ -58,11 +70,7 @@ static inline u64 kvm_granule_size(u32 level)
 
 static inline bool kvm_level_supports_block_mapping(u32 level)
 {
-	/*
-	 * Reject invalid block mappings and don't bother with 4TB mappings for
-	 * 52-bit PAs.
-	 */
-	return !(level == 0 || (PAGE_SIZE != SZ_4K && level == 1));
+	return level >= KVM_PGTABLE_MIN_BLOCK_LEVEL;
 }
 
 /**
-- 
2.25.1


