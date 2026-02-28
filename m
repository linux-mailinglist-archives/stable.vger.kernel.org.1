Return-Path: <stable+bounces-221181-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QI8DLf9Jo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-221181-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:03:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AFB1C7D47
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 21:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81FE93466342
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3367B373C07;
	Sat, 28 Feb 2026 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbYyD6eX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB121B9F5;
	Sat, 28 Feb 2026 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301539; cv=none; b=Fd/6fTuLg9Rb1/GPj/fgAEhZyXNnw8tXOMt7W8z+Ij+xlgYeKOhwIu6YrAmoUrKLgAmeW5hxp52GvmdYJEL7GbfNG14wnECgB4iDa1v3vtl1KuaOf4DDRnolYsJtH1HokwcH6Mbvg40e0eZqzYVRlTbZy9Wl3vxi9mOPu88x6kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301539; c=relaxed/simple;
	bh=52p4sL82RyST9hoyOzQaCwxu6La9p3mr5VhqShIvROQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DcXLnlyLQKVihUQweAyTH4+X9JLbzgGTcSGUpkPhNGlRznt8uGSeiFSVt8pHNWGHTm9E4BeYS3XZUPi8AJ8tKBgzkmeqda8dJ0oNYe0k0jcHpdGggD+bjHcPl+fm5oKaLkiFB03XjSDZ/R6mudjjIEgU4kXBP1+mbtawbJsRjhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbYyD6eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F394FC19424;
	Sat, 28 Feb 2026 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301538;
	bh=52p4sL82RyST9hoyOzQaCwxu6La9p3mr5VhqShIvROQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WbYyD6eXzgv/aHv0CikhsfUiSV2RoyqXpAItouhGM1Ph2TuSORR/+sUWJsBf7AQqw
	 RPw2hisAh6vjiWLo+8FwIA2nbwJbfW0c38CpaPalaS2sV+1fSjzAlVskzSyEYQkMl9
	 YhvkUkLjL4scHadnAziIjk8DbfOiGogSAQsIintzxFo1/dLpimw43QSsuuXte8Ltr+
	 lTj1//Oi+nj0fRMTAYLy8ncKdAkPl9CJhlz/vFHNKRWfFIQK5gk+Vnx6J4r+HEzh0G
	 wb5+0bPn2exWyqB4rAflTOkbHoYOXLWAsXnm8eIG9VD2/GgquAKRecDAnKEq/juWjZ
	 TVnKDWFR6Et9w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Andrey Vatoropin <a.vatoropin@crpt.ru>,
	stable@vger.kernel.org,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 720/752] fbcon: check return value of con2fb_acquire_newinfo()
Date: Sat, 28 Feb 2026 12:47:11 -0500
Message-ID: <20260228174750.1542406-720-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[crpt.ru,vger.kernel.org,gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221181-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxtesting.org:url,crpt.ru:email,gmx.de:email]
X-Rspamd-Queue-Id: 38AFB1C7D47
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
index e7e07eb2142eb..7453377f34336 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1047,7 +1047,8 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		return;
 
 	if (!info->fbcon_par)
-		con2fb_acquire_newinfo(vc, info, vc->vc_num);
+		if (con2fb_acquire_newinfo(vc, info, vc->vc_num))
+			return;
 
 	/* If we are not the first console on this
 	   fb, copy the font from that console */
-- 
2.51.0


