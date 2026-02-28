Return-Path: <stable+bounces-221039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLgqKyJIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-221039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F3D1C78A8
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E66953607F80
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D856C175A78;
	Sat, 28 Feb 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U05uOGwF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC9175A60;
	Sat, 28 Feb 2026 17:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301381; cv=none; b=WdUnU49TGclFPxvBhum+iov6wnaAilwL31r0YKiDDmsjc6NG8JLDy5y5TiRK9hPbQN9lIhxMf9Zw6ULNuX1OI7FqcPOaJ7PHmSVTJVVztGv3NQkWokD9T5UNKAGTtZy/c+h3X+Vv502tTA87JlyRVBCrq76JOf5GneSER/mXTec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301381; c=relaxed/simple;
	bh=DqQ5COpFoz06QmMiwWfHYxRSvwdv6KAznqtOtdj5Fkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LexEMeNqnAUrNVFaAAk6uEM0qYa4gswv9eRr+ehFFO2HHyEU2iVOsPp/SLWpwumO68B5HLMEtrD1IKXX7VBdfEa/wgLWJLgugogSLh+stWubUu2ZuGBRVgXoC1/Gvzgt1zVUJbTPJw6jkY5kBJ4O8SOQnurIpwJCOwqJRIyN39I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U05uOGwF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3193C19423;
	Sat, 28 Feb 2026 17:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301381;
	bh=DqQ5COpFoz06QmMiwWfHYxRSvwdv6KAznqtOtdj5Fkc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U05uOGwFoX+fgHH49vzKnQnIemeYd4893t0WXJ2aUPzPq/yvwkS/1l1Jnow1bHqBZ
	 4qbjYtyfYsa2Iitywzf71OzN9k2kKpK2SWGrqTPSBoX3tViiH1rA4pgeIB9Klsznro
	 zwSjh1qz3IDe2EGCvLO3MMqk/LFLS7+7XP9EQCUTKRwb0jynQG5SPUyE7dSoVVw4Ma
	 9F2zy3F84WyBFHvvq63NCX7S/EZnae74cRVePIBNSeJbu4E5C7NBNleanP0ITGr6H0
	 cusfQBUvX7gV4WzLm/+il74UpLRI4kTkCK9dSPrqW2Y4gACJM3ZZ+EUnfGaFd6KYQT
	 w34kmNPlFXFBA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 570/752] media: iris: Add buffer to list only after successful allocation
Date: Sat, 28 Feb 2026 12:44:41 -0500
Message-ID: <20260228174750.1542406-570-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228174750.1542406-1-sashal@kernel.org>
References: <20260228174750.1542406-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-221039-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 59F3D1C78A8
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 2d0bbd982dfdd67da488a772f7a8a1bdca7642bf ]

Move `list_add_tail()` to after `dma_alloc_attrs()` succeeds when creating
internal buffers. Previously, the buffer was enqueued in `buffers->list`
before the DMA allocation. If the allocation failed, the function returned
`-ENOMEM` while leaving a partially initialized buffer in the list, which
could lead to inconsistent state and potential leaks.

By adding the buffer to the list only after `dma_alloc_attrs()` succeeds,
we ensure the list contains only valid, fully initialized buffers.

Fixes: 73702f45db81 ("media: iris: allocate, initialize and queue internal buffers")
Reviewed-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_buffer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/qcom/iris/iris_buffer.c b/drivers/media/platform/qcom/iris/iris_buffer.c
index c0900038e7def..006ad855a8e51 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -340,12 +340,15 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
 	buffer->index = index;
 	buffer->buffer_size = buffers->size;
 	buffer->dma_attrs = DMA_ATTR_WRITE_COMBINE | DMA_ATTR_NO_KERNEL_MAPPING;
-	list_add_tail(&buffer->list, &buffers->list);
 
 	buffer->kvaddr = dma_alloc_attrs(core->dev, buffer->buffer_size,
 					 &buffer->device_addr, GFP_KERNEL, buffer->dma_attrs);
-	if (!buffer->kvaddr)
+	if (!buffer->kvaddr) {
+		kfree(buffer);
 		return -ENOMEM;
+	}
+
+	list_add_tail(&buffer->list, &buffers->list);
 
 	return 0;
 }
-- 
2.51.0


