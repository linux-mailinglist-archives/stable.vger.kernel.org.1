Return-Path: <stable+bounces-255883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0OGYLVmmGGpplwgAu9opvQ
	(envelope-from <stable+bounces-255883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:32:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA055F8E94
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B7102306FACD
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0ED21C3318;
	Thu, 28 May 2026 20:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZkCwixBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B483002A0;
	Thu, 28 May 2026 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000146; cv=none; b=V9BbyV8NUze7BaV4Y22Ss0GghcLvDDqTbM/tAO2Cg7NjWNXLw1B+2TEaAgLNUdEIH57wKzTR2d1XPyDlorPXsL6BH3VnvjNQI5p7TI1SWDLV24xk/lUZLgEUcZEY546wfHFs7Uh9jFnKgiMHgJTv0WzkPZ+vfcge0Wj28n7FlS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000146; c=relaxed/simple;
	bh=9LVK7pJ4F1wCJk+MLfHXSaW2yQ4L+vhByeQDIrlLL40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SspEG0F1I7EEgsB3s8oEs6WEjR0d5G+eO34i8txB2ZTBb4ew5Y4ahxdXdDt0kPTj3U7H96wf0EBK8MnM3UyQWYtFye2ZyevcvWwc6Ri98YE3jrnudBAPeLu928IZDR79L5yS21mWBf+6LdyLRdq6vaTW9FmNRCUAglW2/06jhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZkCwixBz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D1C1F000E9;
	Thu, 28 May 2026 20:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000145;
	bh=ZApD5t6sB+PafWl3e1uy4RSYUsiU3ReJxzU99LCbvnY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZkCwixBzTc2tKr2r14w29UX3VDrw5VH6BtagU6Iyi7gvplzspZabQvWxLOgsqQ0fu
	 KX/Rur/+Yxgd050VYroDBDohGmcd0613//pavLEkn6+Q7GlBty+x5ETP6lnD8TQKEY
	 +LZt36d0paRmOUnvZBw/s8QkDnwKXuvo4o/4E9iY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	CK Hu <ck.hu@mediatek.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 319/377] drm/mediatek: mtk_cec: Fix non-static global variable
Date: Thu, 28 May 2026 21:49:17 +0200
Message-ID: <20260528194647.633943888@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255883-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,collabora.com:email,mediatek.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: DAA055F8E94
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>

[ Upstream commit 571f00a5fb725984049bd532ee8193cc34ff2994 ]

The struct 'mtk_cec_driver' is not used outside of the
mtk_cec.c file, so make it static to silence sparse warning:
```
drivers/gpu/drm/mediatek/mtk_cec.c:243:24: sparse: warning: symbol
'mtk_cec_driver' was not declared. Should it be static?
```

Fixes: 1e914a89ab7e ("drm/mediatek: mtk_cec: Switch to register as module_platform_driver")
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Reviewed-by: CK Hu <ck.hu@mediatek.com>
Link: https://patchwork.kernel.org/project/dri-devel/patch/20260429-mediatek-drm-fix-sparse-warnings-v1-3-d95c4d118b83@collabora.com/
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_cec.c b/drivers/gpu/drm/mediatek/mtk_cec.c
index c7be530ca041f..b8ccd6e55bedb 100644
--- a/drivers/gpu/drm/mediatek/mtk_cec.c
+++ b/drivers/gpu/drm/mediatek/mtk_cec.c
@@ -240,7 +240,7 @@ static const struct of_device_id mtk_cec_of_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, mtk_cec_of_ids);
 
-struct platform_driver mtk_cec_driver = {
+static struct platform_driver mtk_cec_driver = {
 	.probe = mtk_cec_probe,
 	.remove = mtk_cec_remove,
 	.driver = {
-- 
2.53.0




