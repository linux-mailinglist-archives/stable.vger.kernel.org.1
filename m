Return-Path: <stable+bounces-197752-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 733E9C96EE7
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93A7D3A7196
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8983074A0;
	Mon,  1 Dec 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xuh1f61f"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2A306B0C;
	Mon,  1 Dec 2025 11:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588430; cv=none; b=J8GoHmUfaGsyFDRnAASLtcr+Y9kMaRJIXBMe7vZQLH7EVFZZZ+Daq+Z2lKkRLaWyQ/oLt8Gxl82QFLLC4EDNN+sl1djr10ButwWQuRYdBCu2swMHEscKgOjJFdBGzHkZVtKMd9EKVNAeBNE5jMzdEPXd9nVm0/SbtVRGjyNT2I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588430; c=relaxed/simple;
	bh=gAWkInsM6T2gY88rD2z0B9hR4tuvpTx6stBt6T8Mhso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W2BP1uZ09SL3OIaaN6zuVvA1mKc61lVMSfODSgflmJYHRvgFqqjuh43p104prEMcVuo6saZKS8wKnlmAOv58HVGGBMnLQJRXJLYGE4lXcbrUhs0C/7Wv50ekp+LnlGRZaPl6Q1YWa/cjWalayngtYEpCtf6YJks2GrcXuH+6F2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xuh1f61f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12FCC4CEF1;
	Mon,  1 Dec 2025 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588430;
	bh=gAWkInsM6T2gY88rD2z0B9hR4tuvpTx6stBt6T8Mhso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=xuh1f61fuvBqfh/rgho7hjxiiTHiailW6kN4ZCN7won5nHD70be6LQEAHPPiJaejK
	 2ucIuYD/lwhpGQPV69RddUc7OeY06ZKbXayxDfQ1oWCcRXwlTvlMHYPgYdz+HDyC6X
	 SJT0NtnOrHMTzgzZLK/5notIEpQYrflf3qj2mwk0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Lucas Stach <l.stach@pengutronix.de>,
	Christian Gmeiner <cgmeiner@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 013/187] drm/etnaviv: fix flush sequence logic
Date: Mon,  1 Dec 2025 12:22:01 +0100
Message-ID: <20251201112241.729830639@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tomeu Vizoso <tomeu@tomeuvizoso.net>

[ Upstream commit a042beac6e6f8ac1e923784cfff98b47cbabb185 ]

The current logic uses the flush sequence from the current address
space. This is harmless when deducing the flush requirements for the
current submit, as either the incoming address space is the same one
as the currently active one or we switch context, in which case the
flush is unconditional.

However, this sequence is also stored as the current flush sequence
of the GPU. If we switch context the stored flush sequence will no
longer belong to the currently active address space. This incoherency
can then cause missed flushes, resulting in translation errors.

Fixes: 27b67278e007 ("drm/etnaviv: rework MMU handling")
Signed-off-by: Tomeu Vizoso <tomeu@tomeuvizoso.net>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Reviewed-by: Christian Gmeiner <cgmeiner@igalia.com>
Link: https://lore.kernel.org/r/20251021093723.3887980-1-l.stach@pengutronix.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_buffer.c
@@ -346,7 +346,7 @@ void etnaviv_buffer_queue(struct etnaviv
 	u32 link_target, link_dwords;
 	bool switch_context = gpu->exec_state != exec_state;
 	bool switch_mmu_context = gpu->mmu_context != mmu_context;
-	unsigned int new_flush_seq = READ_ONCE(gpu->mmu_context->flush_seq);
+	unsigned int new_flush_seq = READ_ONCE(mmu_context->flush_seq);
 	bool need_flush = switch_mmu_context || gpu->flush_seq != new_flush_seq;
 	bool has_blt = !!(gpu->identity.minor_features5 &
 			  chipMinorFeatures5_BLT_ENGINE);



