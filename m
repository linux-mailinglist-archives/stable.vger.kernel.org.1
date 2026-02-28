Return-Path: <stable+bounces-220717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKw3NbFUo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:48:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1761C88BC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C51D33108367
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20383F9AA4;
	Sat, 28 Feb 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqFh97B8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7000F3FD15A;
	Sat, 28 Feb 2026 17:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300597; cv=none; b=DbvhhwIrQ3Sm2hCP31Tna8ucySrR5gJDosqYPk8foVUGMBQn/OAVDk7nOUNH1EGodLuZOsAIqkQflULe70LVsUdpMiiHzX7yillrNbcAC2yiJcjcrRka9h0xKWogofKA4WwXii2qHAlx15/y8IkZexsxhiOdQgQtLMSdulOR5Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300597; c=relaxed/simple;
	bh=/K1y+ZFChZi8Am+ZS0Tvw7xs44reTOVZ/28KbEPHIH0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9TsGoEFmyyvt664n193XZ6ND85qAl1o47AFothn9Fni4wk+LGvgiwRwFEiF9KfPKr1CA1+IOZogXEEw/+p9SikpGVPpmQAuZHVtQnD+JpzgnM8d9yQE4FXFhMuCtlDLV+tJ9mcXFEowpjPvC0ZczmfOts99bu3h8zJf5EyCFfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqFh97B8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90BCBC2BC9E;
	Sat, 28 Feb 2026 17:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300597;
	bh=/K1y+ZFChZi8Am+ZS0Tvw7xs44reTOVZ/28KbEPHIH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NqFh97B8DU8Dk17w1qmivDs8stsoHGvPeyVcWJ/evivHTx0UX2R9d0giG/N1WQx8r
	 wz0e5PRaeVF4F4gBUDrg2Axs1XKQ/WqjFGtqVI4+umPhT9CVWyMj7sBB2H7XHrra29
	 pXZbfS6Ilk+ZLX03mNtlW3Nkw4Cnf8JJ3YauwnAFdXCm36+5/5tIuXzKtPSmd9x9Ys
	 R49G6vXgFibYyvJYICWFCBrdUZwgZ9XT7LIJzGCVrfC5RcjD0hnzFKzOlNum7u53p/
	 +gw4dwBnF128GYPBTVdMlr4a1VTOJscQ4Z4lKl3tzsbbOOeJ5nOWHwLuZYpgVr//vc
	 8Miwjei6lbZgw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 638/844] media: iris: Add buffer to list only after successful allocation
Date: Sat, 28 Feb 2026 12:29:11 -0500
Message-ID: <20260228173244.1509663-639-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220717-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3B1761C88BC
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
index b89b1ee06cce1..f1f003a787bf2 100644
--- a/drivers/media/platform/qcom/iris/iris_buffer.c
+++ b/drivers/media/platform/qcom/iris/iris_buffer.c
@@ -351,12 +351,15 @@ static int iris_create_internal_buffer(struct iris_inst *inst,
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


