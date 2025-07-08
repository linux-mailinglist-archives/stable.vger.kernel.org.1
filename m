Return-Path: <stable+bounces-160844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C40AFD23D
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 18:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 635E8188DF11
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 16:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E112E54BC;
	Tue,  8 Jul 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ur7V8+2c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9292B1DF74F;
	Tue,  8 Jul 2025 16:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751992854; cv=none; b=Cu951GdX1DG08mT0gpteaQMj/6SQe3hgDD+Sx7c4g2o1ebGhEoZuN3FiBYYtv5JJDmVDoVnWyK7NpfDu8PoJbuiKkHKlvPszotFoZk5B6EqzMJsskjMH4GYBzGftYFlZxeCHt8yeIjHbZBi87/xMKtzBAdYdmVV/aviEZA0N058=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751992854; c=relaxed/simple;
	bh=i0cLEQIagQ4iXksm+gcxXEVTLeHmq21OX3duRAfdSSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbgWJ34H88rxsq2MqPDknyuLvN/pIcWLEKHNFKygYNV2ejdzK2W/NKNKBI2yCxb61/hEPlLI1TFdomWtiWplm3/Af7S5+wfxM6ewu03Ym1Ld2T+729wfAjmcx68LCcFssZr1O4RTsezfUCF1Zr7YANF1BS6mL5xpWzhcEZro0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ur7V8+2c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B07C4CEED;
	Tue,  8 Jul 2025 16:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751992854;
	bh=i0cLEQIagQ4iXksm+gcxXEVTLeHmq21OX3duRAfdSSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ur7V8+2cACFLuEbJcirEh7afugDfhqXgiAFgeSvEj23whSpCvVuu0vS76CMJ7UN8n
	 j1dCUhja1jRnq4kqTxq7bnayiMNoXxAr21pN3xiVVBHoIQ3bZC2gogGKd8K97ifrd2
	 MB7rK9m7B204aPmngYx+18z28PdnmYvyltXuOEj0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christian Marangi <ansuelsmth@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 096/232] spinlock: extend guard with spinlock_bh variants
Date: Tue,  8 Jul 2025 18:21:32 +0200
Message-ID: <20250708162243.960732417@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250708162241.426806072@linuxfoundation.org>
References: <20250708162241.426806072@linuxfoundation.org>
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

From: Christian Marangi <ansuelsmth@gmail.com>

[ Upstream commit d6104733178293b40044525b06d6a26356934da3 ]

Extend guard APIs with missing raw/spinlock_bh variants.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: c7e68043620e ("crypto: zynqmp-sha - Add locking")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/spinlock.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 63dd8cf3c3c2b..d3561c4a080e2 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -548,6 +548,12 @@ DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
+		    raw_spin_lock_bh(_T->lock),
+		    raw_spin_unlock_bh(_T->lock))
+
+DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->lock))
+
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
@@ -569,6 +575,13 @@ DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
 			 spin_trylock_irq(_T->lock))
 
+DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
+		    spin_lock_bh(_T->lock),
+		    spin_unlock_bh(_T->lock))
+
+DEFINE_LOCK_GUARD_1_COND(spinlock_bh, _try,
+			 spin_trylock_bh(_T->lock))
+
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
-- 
2.39.5




