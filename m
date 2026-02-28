Return-Path: <stable+bounces-220887-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEk/EMpFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220887-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2BC1C752A
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:45:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AF52B308E65D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE7C423598;
	Sat, 28 Feb 2026 17:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pr2yvlxd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01063423590;
	Sat, 28 Feb 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300778; cv=none; b=dNqpceYDv6MSOd/2MVPMlKH9ExuIzux7SxJy+D/16LUy0cXoxZaLQbunmL1J/ITnZjFhE6wGVvKtDZZMnCZ/8OZMp3g4ac88M/Uv3d5VjO6e7mlYrBKSAVY/gsG5l05XFJUC8hAjEgm5c1+ASl6BJfqAqOrq4OhLU9tVzbSFmAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300778; c=relaxed/simple;
	bh=SgPq7xrhOcLQj6wkSLJcjM+Gd+ZOYudKrRPy5x5YVY8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RJVb2N2S2R/9yicnfNIYptP4+1BHKaWYcDmFwDzRVtE6G8pEeO1h7R/yu1rHPaweEdYxTmxyCbKlUUK+eeCN5/na01ii1iZKHQ3qlVcR/2rbyzzojBEh3rSHxitlg42oHbAgBVrCR9s92sbvUJ7ObByX0/hKEROrYgjrugj3eqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pr2yvlxd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12885C116D0;
	Sat, 28 Feb 2026 17:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300777;
	bh=SgPq7xrhOcLQj6wkSLJcjM+Gd+ZOYudKrRPy5x5YVY8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pr2yvlxdk3unBMCkigwgRRNYPxICUnerVjFJCB/7+hXWJB9M1nLUIEeJ4M9kucCWf
	 KGmrTSy7aIf0iUTOHJ39ruCXsbeAtp7QCjGHqHmT2csTkHcxYlDtTqGe9gUtSORxFQ
	 B/9C399MUdM4nbzUKI1r9KvhPZrR4QfvrRC1W5D+8gVHl6y4SDp55sSKK6sZJxuoi1
	 hc+ZMrkcXECoyaj/mxwBIewklkfnxouB1EHOCROAY2UsCE/ylURPqGNIcHFZLy7fwr
	 u7KRVlCU63oEJPHKMQp1yE5bImOrn7obSLv4GqAZV2KKSXES5hRk/eoQ3eCLROMvMq
	 SMzMj3TLKoeGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrey Vatoropin <a.vatoropin@crpt.ru>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 808/844] fbcon: check return value of con2fb_acquire_newinfo()
Date: Sat, 28 Feb 2026 12:32:01 -0500
Message-ID: <20260228173244.1509663-809-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[crpt.ru,gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220887-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email,crpt.ru:email,linuxtesting.org:url]
X-Rspamd-Queue-Id: CE2BC1C752A
X-Rspamd-Action: no action

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

[ Upstream commit 011a0502801c8536f64141a2b61362c14f456544 ]

If fbcon_open() fails when called from con2fb_acquire_newinfo() then
info->fbcon_par pointer remains NULL which is later dereferenced.

Add check for return value of the function con2fb_acquire_newinfo() to
avoid it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d1baa4ffa677 ("fbcon: set_con2fb_map fixes")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 7be9e865325d9..a07737dcb45ad 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1068,7 +1068,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		return;
 
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num);
+		if (con2fb_acquire_newinfo(vc, info, vc->vc_num))
+			return;
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-- 
2.51.0


