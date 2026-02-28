Return-Path: <stable+bounces-220447-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKGHGZ07o2nO+gQAu9opvQ
	(envelope-from <stable+bounces-220447-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D3C1C6861
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BDC63275B4F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3CB3B5C15;
	Sat, 28 Feb 2026 17:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBKbDH3+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF763B7778;
	Sat, 28 Feb 2026 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300336; cv=none; b=BTfoVn/5i5dIOZVuYzKh3sENBTr4TIbBxVTniB72WIR/BdsYg0xnHxSWypoQzV75lIR4R+bDJKyJeekilHZd2dKnZelG5Ug7Y75zhy0gXfu3x2abM5kEORj6tpX7cohnPwRsWaUgYySmy87TFXVbZd6PbnNleJt5mpAAFlRdIEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300336; c=relaxed/simple;
	bh=DLs8O39Aquy21DE10NBbQgShhgreUQHnlNBuqWYnRLY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y1gqCbIRe8J21XbJTwE7XvBx/SWs263fAiHIAHA9IHoXlx421NCBEpByIthKQjM/S3WKzDDFTrK/gxzWcQ0+hlz0zHgUcgbio08HeusRR36LK6tOobMCJXaIREi6eYTztJ6tsKJKAMvgooZu1kUjG4kXOnPakSHW6cbb6Kziin0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBKbDH3+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33CDFC19423;
	Sat, 28 Feb 2026 17:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300335;
	bh=DLs8O39Aquy21DE10NBbQgShhgreUQHnlNBuqWYnRLY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rBKbDH3+K1fMN2jqauDYLuKo1OZTHsQvLfSgkD/dQJU9dHdKHSu/F1qNrneVFC8/o
	 zNRKrwSNizaYdF7qF4Ra4oRhO8q6V6IiIh+sodFPLudqklDtHIMUkidpjRboioA0HS
	 +K6xdo1Tdi58HWZrg1LqzhKi+8tsk4SsI73fR9dq1JBwWUsAH1N+hlK0Qv2GbokJUR
	 Av96zAUT5XilyaXgH8+RoJ0KC4lm5JJf13ANKlJOHNbydlZXrRROySKE8KdcnrMmNJ
	 OIZ77I9ekc4p55YzNxZkgGDLpiOga6af2EIJizGukrrnUWSS/Rmll/qJ6Vo/w/VkLY
	 zM1mLq7Gcvrcg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Liang Jie <liangjie@lixiang.com>,
	fanggeng <fanggeng@lixiang.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 368/844] staging: rtl8723bs: fix missing status update on sdio_alloc_irq() failure
Date: Sat, 28 Feb 2026 12:24:41 -0500
Message-ID: <20260228173244.1509663-369-sashal@kernel.org>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220447-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,lixiang.com:email]
X-Rspamd-Queue-Id: B7D3C1C6861
X-Rspamd-Action: no action

From: Liang Jie <liangjie@lixiang.com>

[ Upstream commit 618b4aec12faabc7579a6b0df046842d798a4c7c ]

The return value of sdio_alloc_irq() was not stored in status.
If sdio_alloc_irq() fails after rtw_drv_register_netdev() succeeds,
status remains _SUCCESS and the error path skips resource cleanup,
while rtw_drv_init() still returns success.

Store the return value of sdio_alloc_irq() in status and reuse the
existing error handling which relies on status.

Reviewed-by: fanggeng <fanggeng@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Link: https://patch.msgid.link/20251208092730.262499-1-buaajxlj@163.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 1d0239eef114b..dc787954126fd 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -377,7 +377,8 @@ static int rtw_drv_init(
 	if (status != _SUCCESS)
 		goto free_if1;
 
-	if (sdio_alloc_irq(dvobj) != _SUCCESS)
+	status = sdio_alloc_irq(dvobj);
+	if (status != _SUCCESS)
 		goto free_if1;
 
 	status = _SUCCESS;
-- 
2.51.0


