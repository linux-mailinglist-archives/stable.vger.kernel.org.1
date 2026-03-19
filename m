Return-Path: <stable+bounces-227189-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC2iFUNGu2n9iAIAu9opvQ
	(envelope-from <stable+bounces-227189-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:41:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C2D2C4242
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 01:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9AD9C302C312
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 00:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F8021B192;
	Thu, 19 Mar 2026 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UzhqPD0t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A511A2B9B7
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 00:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773880893; cv=none; b=F1P6r4wQHatST8bRrMLtWR33urzoL5ejoGUnOGfcXqYVm3hDyOdE0M5LEyfBpRuO4cvcg6VAtpcrUVM3/QJryfx5O0r3r7Ywg1Qh7PwPjTje7zaj/JAp8m1aCILBCtSg6Ztu2hDh2Oyqgebf8vVpA1672EmFHOEz+R4JXnigx68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773880893; c=relaxed/simple;
	bh=6fN6HSlQPLgxtLiGWYYOHD8nz9aPxmsGUHRnr4KGzRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GE3aY9tWlyG4K0+PlGSLc864J/6xyPyWaQIM+bNIvTGuu2C0Wq60ZElFSTfQVri5sMQ6aPdhOc1PfyWLgX39MVBGTdFaVIp0aAHUnud6zBS1aDvVxbq/1Pjk0G02ZQSRS0YPS2x3RC1u7X7r9Xp3B5cSC67MYiZ3rchOE2gDzCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UzhqPD0t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB69FC19421;
	Thu, 19 Mar 2026 00:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773880893;
	bh=6fN6HSlQPLgxtLiGWYYOHD8nz9aPxmsGUHRnr4KGzRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UzhqPD0tomoveoCbkp4SIO/owlhrfueGDTuf+vCNkOPiusKHE7Gqv/RpPjqeeMcdx
	 syZZs6zbkwIsZlbWPuFafdO1RrjcowiX7aWm9hR9yIOg/zxr3eIfuaJswVSwyXV0JY
	 ut/o5nNGtjbCAc4t9wslezhvADoaJ83kzzMWid2nl+hG7ftQCZ+cu3+przXKyBQlQI
	 iRB7VqDCsHeJy22ptAwKgHUfIj3QC2TZqf9WSD82vWB8q8N76D+WH9hR1bsxxSN8va
	 f+W7i0LWKWzDjvvTI7K3lpH9EAiFQWil360Arp0kf34N0x3PT/pJSb14MNajNn3jYt
	 xY1ZSA6xfaElA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19.y] netconsole: fix sysdata_release_enabled_show checking wrong flag
Date: Wed, 18 Mar 2026 20:41:31 -0400
Message-ID: <20260319004131.1853033-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026031740-salon-routine-26fd@gregkh>
References: <2026031740-salon-routine-26fd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227189-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: B6C2D2C4242
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5af6e8b54927f7a8d3c7fd02b1bdc09e93d5c079 ]

sysdata_release_enabled_show() checks SYSDATA_TASKNAME instead of
SYSDATA_RELEASE, causing the configfs release_enabled attribute to
reflect the taskname feature state rather than the release feature
state. This is a copy-paste error from the adjacent
sysdata_taskname_enabled_show() function.

The corresponding _store function already uses the correct
SYSDATA_RELEASE flag.

Fixes: 343f90227070 ("netconsole: implement configfs for release_enabled")
Signed-off-by: Breno Leitao <leitao@debian.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260302-sysdata_release_fix-v1-1-e5090f677c7c@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/netconsole.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index f418efb38508c..eb282b295da8b 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -508,7 +508,7 @@ static ssize_t sysdata_release_enabled_show(struct config_item *item,
 	bool release_enabled;
 
 	mutex_lock(&dynamic_netconsole_mutex);
-	release_enabled = !!(nt->sysdata_fields & SYSDATA_TASKNAME);
+	release_enabled = !!(nt->sysdata_fields & SYSDATA_RELEASE);
 	mutex_unlock(&dynamic_netconsole_mutex);
 
 	return sysfs_emit(buf, "%d\n", release_enabled);
-- 
2.51.0


