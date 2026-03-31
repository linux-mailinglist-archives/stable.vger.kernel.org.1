Return-Path: <stable+bounces-232073-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFY6HzD9y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232073-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C13536D8D2
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 18:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D226306E2F8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2767A413225;
	Tue, 31 Mar 2026 16:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JDJEjIie"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9CC346E7F;
	Tue, 31 Mar 2026 16:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975805; cv=none; b=gItCHgQgVd+uZlSVd+tx0l7M0yKrykdyNGJ4aQUh6zZ4Rx+brRlwErAL3ZlYJLwfZMOOW1Sn/liZSRdo/4hVYmLaOEWusc6UTSMdfxgB9DNeMf5i/fHAAI4E0Nxdnell1qnTk6v0g1oav3ZukrGUJZQXBISJCWDHcal+PbqQJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975805; c=relaxed/simple;
	bh=SYqOShVyo3m7OrLbTfeHjMUVY82BLIKigfcekDAqhoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nKF6YpuE86HwHVBziUtW8sjOXh2ol8uqrhGDAKc/s0SD/rx+Tsm3QnajhXTVij/91H6F8cUmGNfRNQAIYcZMR7QBSP5ain41mIT/n8q0M+yXG9LXR7U8opVB8q3nWDqI59rQox8eFPfJD/MdqVta3yddJhqLGANmYUaDuelXL8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JDJEjIie; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74606C19423;
	Tue, 31 Mar 2026 16:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975805;
	bh=SYqOShVyo3m7OrLbTfeHjMUVY82BLIKigfcekDAqhoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JDJEjIie0aSBT8KpYu5jIg/grqec2zrolDzo2bcPnLEhhA9phlU8fraVcqluV9E5A
	 OaVI0m7cUkEtqiqu2m7bzuKCsvtwsglUU+l9QGSeZT8V6KFF8I0yhhtZHw3fvVeNWJ
	 bWUh74AF85zUbwzk5u0RcBgRcRaOQ5xJwjCRpjIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Miguel Ojeda <ojeda@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 093/244] dma-mapping: add missing `inline` for `dma_free_attrs`
Date: Tue, 31 Mar 2026 18:20:43 +0200
Message-ID: <20260331161745.110957567@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-232073-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,samsung.com:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 2C13536D8D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miguel Ojeda <ojeda@kernel.org>

[ Upstream commit 2cdaff22ed26f1e619aa2b43f27bb84f2c6ef8f8 ]

Under an UML build for an upcoming series [1], I got `-Wstatic-in-inline`
for `dma_free_attrs`:

      BINDGEN rust/bindings/bindings_generated.rs - due to target missing
    In file included from rust/helpers/helpers.c:59:
    rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs' is used in an inline function with external linkage [-Wstatic-in-inline]
       17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle, attrs);
          |         ^
    rust/helpers/dma.c:12:1: note: use 'static' to give inline function 'rust_helper_dma_free_attrs' internal linkage
       12 | __rust_helper void rust_helper_dma_free_attrs(struct device *dev, size_t size,
          | ^
          | static

The issue is that `dma_free_attrs` was not marked `inline` when it was
introduced alongside the rest of the stubs.

Thus mark it.

Fixes: ed6ccf10f24b ("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA")
Closes: https://lore.kernel.org/rust-for-linux/20260322194616.89847-1-ojeda@kernel.org/ [1]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Link: https://lore.kernel.org/r/20260325015548.70912-1-ojeda@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/dma-mapping.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 22b9099927fad..ac7803e3fa613 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -195,8 +195,8 @@ static inline void *dma_alloc_attrs(struct device *dev, size_t size,
 {
 	return NULL;
 }
-static void dma_free_attrs(struct device *dev, size_t size, void *cpu_addr,
-		dma_addr_t dma_handle, unsigned long attrs)
+static inline void dma_free_attrs(struct device *dev, size_t size,
+		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
 {
 }
 static inline void *dmam_alloc_attrs(struct device *dev, size_t size,
-- 
2.51.0




