Return-Path: <stable+bounces-26843-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 322208727F2
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 20:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17381F24FE9
	for <lists+stable@lfdr.de>; Tue,  5 Mar 2024 19:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7E15C612;
	Tue,  5 Mar 2024 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="LQ1ldbdB"
X-Original-To: stable@vger.kernel.org
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02F65C5FD
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709668159; cv=pass; b=qr9UXAVftDaSA5xQi9i+OeIStqhD05Pk7kTuMGnRML9vsJKj69LVoiRUg/D64+BTGbzeaoC5w67JQtcmnqg9nHHgTSFzulQIyHVvV05xRBs72Tk/G58hGSMGJ5PhBbTjMuuCR9PxptA/0pUan9pAzi8Dc5r7/F2Bws31rwfIyk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709668159; c=relaxed/simple;
	bh=6vmeA6S/aWTdxIm3wzboVir81wQ0joTj+zd4cbwqkok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQIUmW/I8EMR4TJ6WnJoq5JC7N3Z930v/tbX67hzLP1h5GwmP3tAQylJP2N9FBy+mjMXF6zMLTuh/knaj8IQdmHGZGRhJMLKtfQna8GEJQON6M9CdziGnPk4KXLerqe2tkKN4vm8aSdFetLlclNvhTI6JNuTDrutSj18JPtdP6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=LQ1ldbdB; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 3C86F90281F
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:41:55 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id A6956901A0B
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 19:41:54 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1709667714; a=rsa-sha256;
	cv=none;
	b=6BTuIcuj2RYu+wYQet0UVrEAEZnZybCsiJ6hv326ntGMwP5A7Dddaj8URXy6QnMYg29odB
	5TFTUbC5jy5bWVjzgtG4wkGBKdKdSfiVEXxlYRPzS9fyBnE6x+AS2EXzUKVYRWY6rewEsL
	JD6QMGfJTr7P2RVOvngfnN0x1w1r3HQi+awrQKnKSuoKjL6+oYNTzxGJASaEcH5iuHnoBw
	ayoPL0rTVKq97+iOHsfMezCIE2SVTE25ZpanjoXL+xsJwlqbXD6/ox4zY0PqnKGxkb5iW1
	5mqzdqwoLNuWpzG3v2/oqHsgCV6Gl0F8OmqKLJT1hWNZNqeWdSlvXjMGDQGxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1709667714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=toLiXIytUz7sF69OdOxZkKEWMldkS6KytMaGIuNQxWY=;
	b=hMpe4kjA0GNt3F8VUW5l5XZH0WWiVlpWV+kYoDKJb//5SvwBA3ObKAv/dBWE21UzicCv2O
	3WtnzM+OT7hbNLavRi6OuBr1fsVtZvP+4aD4MfizyyaNlqYxl4w7Pkza9awGlUGR4GOU14
	iEz93oLaQ7ZhRibRVnOG8iEsSml5MYpDrLfqgcClN/rTdE+ctS98AJ/w8z3RVuxNeW+A2T
	VSeKiDtjGYFConTAutzKefRnynvHvXK91Ea7L4yLHD5qd4eJzkK1P+x457pgddh27uDWYG
	Kt9rq2+2cxvTrXrk3ODTy+3TCG53wVEkIKCeTK8HK902FoYDRiNEL1F549PnqQ==
ARC-Authentication-Results: i=1;
	rspamd-7f9dd9fb96-skq2d;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Lonely-Shelf: 17a5e24561c7abaa_1709667715023_1731104994
X-MC-Loop-Signature: 1709667715023:1713224982
X-MC-Ingress-Time: 1709667715023
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.117.236.39 (trex/6.9.2);
	Tue, 05 Mar 2024 19:41:55 +0000
Received: from kmjvbox.templeofstupid.com (c-73-222-159-162.hsd1.ca.comcast.net [73.222.159.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Tq5YG32Jgzqt
	for <stable@vger.kernel.org>; Tue,  5 Mar 2024 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1709667714;
	bh=toLiXIytUz7sF69OdOxZkKEWMldkS6KytMaGIuNQxWY=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=LQ1ldbdBzrfZOfybz1OG2hiUQ8hoVAY4JE7ExpjyYbpXBybIXaj2DBUuWHVD96wZa
	 Q8ZploU00Z3BKEinmW+SX49ukC1O31takTkVuy/WsmvpncyJ8mbUuaIGoMcRFWoovb
	 EHG6CHqbbLSLtFtV1k/eVZQPznmLjZfxa9wu8UGOTWCW5jSdHM+SL+13om4KXtVkGk
	 elAIHjG7M0HBxXOL/pnyu4qt55yjJJXRGf6ollckMi0p+n5QdP1TtXWNq6fC2nRjE5
	 XMxQVlYdrLWQ+JiXQ+u4v5po2l3vGpeGS9V+nWxOGTB3Vqq+EU4tYyqyw8Uv1bOxSe
	 JojEgxKsTrucg==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00eb
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Tue, 05 Mar 2024 11:41:45 -0800
Date: Tue, 5 Mar 2024 11:41:45 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: stable@vger.kernel.org
Cc: Oliver Upton <oliver.upton@linux.dev>, Marc Zyngier <maz@kernel.org>,
	James Morse <james.morse@arm.com>,
	Alexandru Elisei <alexandru.elisei@arm.com>,
	David Matlack <dmatlack@google.com>, kvm@vger.kernel.org
Subject: [PATCH 5.15.y 1/2] KVM: arm64: Work out supported block level at
 compile time
Message-ID: <21a92d6c66b6100d45a9cf8a0e48f613576157fa.1709665227.git.kjlx@templeofstupid.com>
References: <cover.1709665227.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709665227.git.kjlx@templeofstupid.com>

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


