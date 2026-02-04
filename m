Return-Path: <stable+bounces-213883-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLhzBXJpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-213883-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:44:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 558EEE949C
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3404530DDAD4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272B2421885;
	Wed,  4 Feb 2026 15:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zDMVMUu3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE70241C312;
	Wed,  4 Feb 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217831; cv=none; b=R8GvNIbPi8uq3qL+ll69Ah6o0t70XZYx6FDNBk73dDlUT5B52FPbpXD8biKpHhXOksRQ5t/vNHYTgTlCyVvjD07VqOtpdpOlHLEa6tNVypw+GU3ZhAAF5AFk4IJO0/Mkn94dPA9I9W00eRtPDvmkvOMbD7JRpZPN/zroVDkvGWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217831; c=relaxed/simple;
	bh=990A/WYwQhyIycivGYBT2saJbo870cqN0t+SiSqASAM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uumsG2p1r3dYfjDn94f+dEmr7VZClLw88fb8oUWV52iP9m9Ezg60Vctom1mASq0PdrWZSWgTFEnmAA4eKWH6P+2TCgZ1nClGXGvyAJuDGyVaeHrS+rikkS8EkTckN1pqjfhADnzgSIJfNH5CEoKwWIzNZbGtatyy+S9DfojTjHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zDMVMUu3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11969C116C6;
	Wed,  4 Feb 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217831;
	bh=990A/WYwQhyIycivGYBT2saJbo870cqN0t+SiSqASAM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zDMVMUu3oe2x8guXK0L39To8w25+aXaZ3lkixozqtw2Dt0r5476Zfg07ayKC/6uMN
	 imFtLTeP8Lm69tUCslVI/mjAGCPqzgpet2tOX6dLGpI0dmlpjJ/KE/1e7+db5XqTLS
	 Xnbf5pMpWomH9dIFwjnAS3BWJib2ZZ65jc1LlzK8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cheng-Yu Lee <cylee12@realtek.com>,
	Yu-Chun Lin <eleanor.lin@realtek.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 133/280] regmap: Fix race condition in hwspinlock irqsave routine
Date: Wed,  4 Feb 2026 15:38:27 +0100
Message-ID: <20260204143914.428093926@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213883-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 558EEE949C
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cheng-Yu Lee <cylee12@realtek.com>

[ Upstream commit 4b58aac989c1e3fafb1c68a733811859df388250 ]

Previously, the address of the shared member '&map->spinlock_flags' was
passed directly to 'hwspin_lock_timeout_irqsave'. This creates a race
condition where multiple contexts contending for the lock could overwrite
the shared flags variable, potentially corrupting the state for the
current lock owner.

Fix this by using a local stack variable 'flags' to store the IRQ state
temporarily.

Fixes: 8698b9364710 ("regmap: Add hardware spinlock support")
Signed-off-by: Cheng-Yu Lee <cylee12@realtek.com>
Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
Link: https://patch.msgid.link/20260109032633.8732-1-eleanor.lin@realtek.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/regmap/regmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index bdbde64e4b21d..bc89790ff0ded 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -462,9 +462,11 @@ static void regmap_lock_hwlock_irq(void *__map)
 static void regmap_lock_hwlock_irqsave(void *__map)
 {
 	struct regmap *map = __map;
+	unsigned long flags = 0;
 
 	hwspin_lock_timeout_irqsave(map->hwlock, UINT_MAX,
-				    &map->spinlock_flags);
+				    &flags);
+	map->spinlock_flags = flags;
 }
 
 static void regmap_unlock_hwlock(void *__map)
-- 
2.51.0




