Return-Path: <stable+bounces-220719-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCSbA+5Ao2kR+wQAu9opvQ
	(envelope-from <stable+bounces-220719-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A34AE1C6F03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:24:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6614A3180A9D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49143FD8F2;
	Sat, 28 Feb 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzXJ8CHC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307D3FD8E7;
	Sat, 28 Feb 2026 17:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300599; cv=none; b=rZU9j0V8a6AL6YTXMxZWt69NFCtdX80z+ewDw0Y5Rnx7Wp7IY8ZXS8dydW4AaSJKlz/qYTW4T+adWMjgnuLMa6HliAg+l6O9ENjHJzlnPyspaI7ISQrVbxWc+aV9YuWeYsCuuE7eW22+40PLkQ/S/2C8wX2Dv7PrPLkbQH6x90Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300599; c=relaxed/simple;
	bh=GKzwqxHBGQfxQn1X+IxwJTAomcaHxn/exreFipPVGf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLZaFGKnLR6S1cXWaSQUoWus+MriTBzFawpfOO1lGdrOEUsXIcv25Nb+oBvSWth/ynpfApmpjnLWCQcVMhvGeJ55GTVba5zAWWyXbq2FYkY1aUePV/YCq0AZJNygoxQnAqmUjT3l3SGVrZpsHrvXj/f8UnaqGr1T87wd8cCoFQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzXJ8CHC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2CAC2BC87;
	Sat, 28 Feb 2026 17:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300599;
	bh=GKzwqxHBGQfxQn1X+IxwJTAomcaHxn/exreFipPVGf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzXJ8CHCL75EQgvm6Oe5HJjTYSuOLWn7T07xJpulktGbKD64ALk/xbnxmn8l7f3+L
	 +DBNQTNBrxL/+U4xKV8trKYYTwaBPjI0GwUeGq7Bz5h9ozM4u6id9bC8wKEY+Kg05G
	 6HiuLy/U3R40RKxC7oBXx5gyf02KIon+je5VIrbhQxK8Abu159aiklEFJ2P6+lDocz
	 uHE/DcB0GXdFolxq5sw0X/8bzMb4oRR/S5wJVIIjUIkJlL+XA35DICS+YbBEfBnXup
	 u1n50fzM83XNdLitnKQnsnMO9/e8m2YEmgbMbQzCwioSQ7Ek4w3Uk9A8veOGUtNI1O
	 PvmH8qVBMaZ5Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Bryan O'Donoghue <bod@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 640/844] media: iris: gen1: Destroy internal buffers after FW releases
Date: Sat, 28 Feb 2026 12:29:13 -0500
Message-ID: <20260228173244.1509663-641-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220719-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable,cisco];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,qualcomm.com:email,linaro.org:email]
X-Rspamd-Queue-Id: A34AE1C6F03
X-Rspamd-Action: no action

From: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>

[ Upstream commit 1dabf00ee206eceb0f08a1fe5d1ce635f9064338 ]

After the firmware releases internal buffers, the driver was not
destroying them. This left stale allocations that were no longer used,
especially across resolution changes where new buffers are allocated per
the updated requirements. As a result, memory was wasted until session
close.

Destroy internal buffers once the release response is received from the
firmware.

Fixes: 73702f45db81 ("media: iris: allocate, initialize and queue internal buffers")
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Reviewed-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
index 1c107daca9e89..11815f6f5bacd 100644
--- a/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
+++ b/drivers/media/platform/qcom/iris/iris_hfi_gen1_command.c
@@ -441,6 +441,8 @@ static int iris_hfi_gen1_session_unset_buffers(struct iris_inst *inst, struct ir
 		goto exit;
 
 	ret = iris_wait_for_session_response(inst, false);
+	if (!ret)
+		ret = iris_destroy_internal_buffer(inst, buf);
 
 exit:
 	kfree(pkt);
-- 
2.51.0


