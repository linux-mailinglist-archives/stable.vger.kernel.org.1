Return-Path: <stable+bounces-256089-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KaELLipGGpolwgAu9opvQ
	(envelope-from <stable+bounces-256089-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB485F9899
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7299B30FD69C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07642EF652;
	Thu, 28 May 2026 20:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lp7Mik/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D523346BE;
	Thu, 28 May 2026 20:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780000724; cv=none; b=IfoZv+hitU83hPMbYUNEslUehJtK65rPkthJ7AmhkPHQynM3xxiGbDx7vjkybxCnkBOrMQkdqMxh5m29uOAiPdxt6VanNKeAK0vtJA+aRoaGsIt4iN5U9EcGy/A8PscwuaR3CkHQJ64Yj6U9+Nn5AxX1SLU5E4b1dd5NvPh7ESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780000724; c=relaxed/simple;
	bh=Nl3pfaTCMCeThiJAAteC1iaStZoN32EHliSnbAGXHjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ca06j0BtGj9aEWIT/dYwFK7q7HF8Z2e5p6vcynrrg0HJWjfdqTio86xNUiBOXw1z9NMWe2vax6RwnOaXJJRGE7IJ/1iNWpK4hHbjfuHgiQQCHWPJ7obTy0GQhkgBt1UBDmLTiYuMufVrrDNTPv9sEY9D1s6WCz/pUMlHLyKAWGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lp7Mik/9; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB851F000E9;
	Thu, 28 May 2026 20:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780000723;
	bh=VG0fuS77BbHVhpeY0L1V/JhoaHjSzchZdVF+dTMpN0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lp7Mik/9csnmn52x41ZKkeKGod+u6hZjeOxQa1ENVMxfQTPBPutNvGKKmavpIGSAh
	 iQgumGIdnZ58vdK/U+Lfr1o0UsmAdy/ibMF2mRt+qeLVFwVno3DQA1A3CxuJ1UkinN
	 BhaKg2ZZbDQ4FaqpV5Ag/TjCfLmdJY6sDM/FNHrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 146/272] firmware: arm_ffa: Check for NULL FF-A ID table while driver registration
Date: Thu, 28 May 2026 21:48:40 +0200
Message-ID: <20260528194633.459904641@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194629.379955525@linuxfoundation.org>
References: <20260528194629.379955525@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256089-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 4EB485F9899
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sudeep Holla <sudeep.holla@kernel.org>

[ Upstream commit 0a5e695095c557d2380131b613dea4e8d90371be ]

The bus match callback assumes that every FF-A driver provides an
id_table and dereferences it unconditionally. Enforce that contract at
registration time so a buggy client driver cannot crash the bus during
match.

Fixes: 92743071464f ("firmware: arm_ffa: Ensure drivers provide a probe function")
Link: https://patch.msgid.link/20260428-ffa_fixes-v2-1-8595ae450034@kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_ffa/bus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
index dea3eb741d95d..ef41815c0109e 100644
--- a/drivers/firmware/arm_ffa/bus.c
+++ b/drivers/firmware/arm_ffa/bus.c
@@ -26,6 +26,8 @@ static int ffa_device_match(struct device *dev, const struct device_driver *drv)
 
 	id_table = to_ffa_driver(drv)->id_table;
 	ffa_dev = to_ffa_dev(dev);
+	if (!id_table)
+		return 0;
 
 	while (!uuid_is_null(&id_table->uuid)) {
 		/*
@@ -123,7 +125,7 @@ int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
 {
 	int ret;
 
-	if (!driver->probe)
+	if (!driver->probe || !driver->id_table)
 		return -EINVAL;
 
 	driver->driver.bus = &ffa_bus_type;
-- 
2.53.0




