Return-Path: <stable+bounces-220589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELEwCUs+o2nv+gQAu9opvQ
	(envelope-from <stable+bounces-220589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 858871C6B28
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0DE173281065
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B733E04AF;
	Sat, 28 Feb 2026 17:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFUIlxjX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48E3E04A4;
	Sat, 28 Feb 2026 17:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300472; cv=none; b=UEIML/JFAYQ2oieBIlV8uLPd/yNSSl3K3Ut6ai6SAS7At0/+F0izjo52IwObzXsApjGzRBWmpBhH6n0UoCFH8sRLX+pcTJrHMy1kIPZUTxdpDv1bZ/H63n7Ee2Sy1GUejCcvi2pfJtq0tYdhzbA4hIVeoKm0U+6Lpza+uIByNjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300472; c=relaxed/simple;
	bh=7mEMJvo5X8owgK7L/9oWkHE42x320z0Z8ypcbUH9IrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajIx64PaIj4yNZiU57RXPrZDnhmpLQqGSSANdHeYuZ6lFv38ioS/5/rKdQGXnettsBNmtjYIkvwbqiEICO956GPIwYabZdc9XuBpGTMa9tcP3h7KQ2MNP9uheFaWMOQkJcbLsMTF0CAm0Xc7Gh8yZw3gVSBxtaO83ce/C3j+fao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFUIlxjX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14666C19424;
	Sat, 28 Feb 2026 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300471;
	bh=7mEMJvo5X8owgK7L/9oWkHE42x320z0Z8ypcbUH9IrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fFUIlxjXeeuL2WqN9SJpu6S7/E2uujNmjlHnWs0sBo3RJaUMsLEbNcsFk14hjBACr
	 uW1irAmhIdm9d2J2hTI3g6Ygqb8WjO+0v29sUMMpNwLufu5WAh2VUm78D7+63X056P
	 NdDIRPuii2C6tPFnx/iadA39y9vik8bYLOEgBT0Pg4O/ZNtbErRKkESeApDuptS1rK
	 5QzNuTuVG03eINhZZLIcTvk0X9mZ7488wfxcyOlKX7gm0lJpWspIXX24pgJKFY3kf+
	 LLs5AkgCjDBkmclKTwLAobY1ninQjs4XNuXn+c7JVv0VzXa8VIAHclLmGldewTXSsU
	 UGF2zoOnVXTyA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>,
	Miaoqian Lin <linmq006@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 510/844] memory: mtk-smi: fix device leak on larb probe
Date: Sat, 28 Feb 2026 12:27:03 -0500
Message-ID: <20260228173244.1509663-511-sashal@kernel.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mediatek.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220589-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,mediatek.com:email]
X-Rspamd-Queue-Id: 858871C6B28
X-Rspamd-Action: no action

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 9dae65913b32d05dbc8ff4b8a6bf04a0e49a8eb6 ]

Make sure to drop the reference taken when looking up the SMI device
during larb probe on late probe failure (e.g. probe deferral) and on
driver unbind.

Fixes: cc8bbe1a8312 ("memory: mediatek: Add SMI driver")
Fixes: 038ae37c510f ("memory: mtk-smi: add missing put_device() call in mtk_smi_device_link_common")
Cc: stable@vger.kernel.org	# 4.6: 038ae37c510f
Cc: stable@vger.kernel.org	# 4.6
Cc: Yong Wu <yong.wu@mediatek.com>
Cc: Miaoqian Lin <linmq006@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20251121164624.13685-3-johan@kernel.org
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/memory/mtk-smi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/memory/mtk-smi.c b/drivers/memory/mtk-smi.c
index dd6150d200e89..3609bfd3c64be 100644
--- a/drivers/memory/mtk-smi.c
+++ b/drivers/memory/mtk-smi.c
@@ -685,6 +685,7 @@ static void mtk_smi_larb_remove(struct platform_device *pdev)
 	device_link_remove(&pdev->dev, larb->smi_common_dev);
 	pm_runtime_disable(&pdev->dev);
 	component_del(&pdev->dev, &mtk_smi_larb_component_ops);
+	put_device(larb->smi_common_dev);
 }
 
 static int __maybe_unused mtk_smi_larb_resume(struct device *dev)
-- 
2.51.0


