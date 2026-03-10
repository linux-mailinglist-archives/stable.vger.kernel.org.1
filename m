Return-Path: <stable+bounces-223873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNFyFIb8r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-223873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:12:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4650D24A10B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:12:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 393A73052CEA
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5F38423F;
	Tue, 10 Mar 2026 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efoCPGna"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0DE3806C1;
	Tue, 10 Mar 2026 11:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140776; cv=none; b=JA9wLSpATaoZhiA7RbtEKDTluMwu0ME0s02boQumnWHHbx96nFY+o9k6bErJtfyvr2IbBMubkAf4NSJUr8WDv5iAMdOy/f4sx/JQR2Rf4MnX5aK4R6ZPs5m6PhicvC2rPDIJfWSUJxTM5VlPmzL/Hnd06+CK0tZ/s/qyWZNY26I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140776; c=relaxed/simple;
	bh=5QurvBrlKao6PNW3VYI23cPsVbqWtnCOZOWq4i9pH7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHRiKAvKSn2uM90qGZ5/d61+peBEZYZPW4CxrPVMUxJV26+6iLm2jTTQX8jozRciL735YV23pcv4kH1Vx0I7SdXEgv9wHSLLbSuI8thsOXXHxtYecek8W1KfYlOWNQh9kgWLnqONdMuORSIp8tvQAAdf9znN8jEIcapIOtJ9MyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efoCPGna; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30689C2BC9E;
	Tue, 10 Mar 2026 11:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773140775;
	bh=5QurvBrlKao6PNW3VYI23cPsVbqWtnCOZOWq4i9pH7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=efoCPGna4NS4vre8BH7tdLhwuQpBEZnc9tUSPfIGxbhyjD+3WIeJ7ldsBm5tOQAWA
	 74b6vItosmZHnRhVt3kNxFC5Hhx1XyUfqC/rwAneNjFl0Hh0e/P05mf8/iTYU5Lf9d
	 1/GXCct2QUbvEXvh9g7YCfmDMunZ1Ve/3aLDfrI3Vn0Jrpu0ubknrwxIdVBh07aazk
	 X58imr0zbW8Re9BPbZYIOqmHIVHUnLbjcydja43gi6V9tUfrzQbbUNbMA/eXDOaBjv
	 4X9bva0EsM5HCkRV8YKM37KuKbvaYASoV/uBeWBFWG0nWbk/L/lHpvZ72TsA0eLvvN
	 lA0XJIiAUzLMg==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Ethan Tidmore <ethantidmore06@gmail.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 009/311] drm/tiny: sharp-memory: fix pointer error dereference
Date: Tue, 10 Mar 2026 07:00:56 -0400
Message-ID: <e90413efd93d95e9f7d301bad12ad093b18fe8e2.1773140655.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4650D24A10B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-223873-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Ethan Tidmore <ethantidmore06@gmail.com>

[ Upstream commit 46120745bb4e7e1f09959624716b4c5d6e2c2e9e ]

The function devm_drm_dev_alloc() returns a pointer error upon failure
not NULL. Change null check to pointer error check.

Detected by Smatch:
drivers/gpu/drm/tiny/sharp-memory.c:549 sharp_memory_probe() error:
'smd' dereferencing possible ERR_PTR()

Fixes: b8f9f21716fec ("drm/tiny: Add driver for Sharp Memory LCD")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patch.msgid.link/20260216040438.43702-1-ethantidmore06@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tiny/sharp-memory.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 64272cd0f6e22..cbf69460ebf32 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -541,8 +541,8 @@ static int sharp_memory_probe(struct spi_device *spi)
 
 	smd = devm_drm_dev_alloc(dev, &sharp_memory_drm_driver,
 				 struct sharp_memory_device, drm);
-	if (!smd)
-		return -ENOMEM;
+	if (IS_ERR(smd))
+		return PTR_ERR(smd);
 
 	spi_set_drvdata(spi, smd);
 
-- 
2.51.0


