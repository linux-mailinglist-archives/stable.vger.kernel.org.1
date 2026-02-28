Return-Path: <stable+bounces-220819-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHFBNKFFo2li+wQAu9opvQ
	(envelope-from <stable+bounces-220819-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:44:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F18D1C7501
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C060310BC03
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B9A413F55;
	Sat, 28 Feb 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqvKUXTH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7940413F49;
	Sat, 28 Feb 2026 17:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300704; cv=none; b=hOdjJmqZLdmSK86c14m2YYpzPAMsHGrDBYhm8Kl+P4ylQxnh7myxeNDqfhq+4FE5qHfbvAh96TnUWlMeMRTubCalNWZFChDakNl4ylvsBX69xBMmihkkwMWKaE3sP8xujniZiwX2SEoQDxkMNbg5FgO32dOTY9caFMjr7nu54eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300704; c=relaxed/simple;
	bh=ZwyYhaYhrSbFRdn+LnNbNaEEXW4wkcTasMoEGoCtb8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pskb7eOCJURS3mN+omN0nUpBg2qJxSIwJVVqR5eb00hHg6Uo2t//GxlM0GEmQwsIz8MRLdm7QOIdPobA3a7Sgb38+S64IntMbvHT8P13oIuBrtHm9F5fT46TDwd8DlvjBoT0AjauvQ62H7fcQ6Ef/6a0JPHpgQxCOaNtcCLPATc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OqvKUXTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14C3C19423;
	Sat, 28 Feb 2026 17:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300704;
	bh=ZwyYhaYhrSbFRdn+LnNbNaEEXW4wkcTasMoEGoCtb8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqvKUXTH75XocudkxBLnFyA9Q0bhfauTvHLAOqEfOQWFY04tT+Sj3mWVgD+vTssVJ
	 xxHB2kMapNhqeY0qRa2zbYm52PhP3GRcWfFCZQYManOKiSlBlsABZDXS5SiFcp5oh8
	 Mw82edQLr0N5nUoZQb6nmxNwIId1e+Zm0LRD7Mj46yNc6jCQxM8S15H77+Yu0f1xE0
	 hklruGan0l2JTs7QOpK01vE6s18k38Du7hHV9r+mmQu1W/UujyTOYSDu/zvnR0YNjT
	 JPeXRcsoOBJ/mSV++0mAMg/q5FIjXG4+AkQd1kJsVkSaQHBJBE9XUIWu1WxkD0LczJ
	 jrnJQ6TC4xvFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 740/844] PM: sleep: core: Avoid bit field races related to work_in_progress
Date: Sat, 28 Feb 2026 12:30:53 -0500
Message-ID: <20260228173244.1509663-741-sashal@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-220819-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,msgid.link:url,intel.com:email,unisoc.com:email]
X-Rspamd-Queue-Id: 6F18D1C7501
X-Rspamd-Action: no action

From: Xuewen Yan <xuewen.yan@unisoc.com>

[ Upstream commit 0491f3f9f664e7e0131eb4d2a8b19c49562e5c64 ]

In all of the system suspend transition phases, the async processing of
a device may be carried out in parallel with power.work_in_progress
updates for the device's parent or suppliers and if it touches bit
fields from the same group (for example, power.must_resume or
power.wakeup_path), bit field corruption is possible.

To avoid that, turn work_in_progress in struct dev_pm_info into a proper
bool field and relocate it to save space.

Fixes: aa7a9275ab81 ("PM: sleep: Suspend async parents after suspending children")
Fixes: 443046d1ad66 ("PM: sleep: Make suspend of devices more asynchronous")
Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Closes: https://lore.kernel.org/linux-pm/20260203063459.12808-1-xuewen.yan@unisoc.com/
Cc: All applicable <stable@vger.kernel.org>
[ rjw: Added subject and changelog ]
Link: https://patch.msgid.link/CAB8ipk_VX2VPm706Jwa1=8NSA7_btWL2ieXmBgHr2JcULEP76g@mail.gmail.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/pm.h b/include/linux/pm.h
index 98a899858ecee..afcaaa37a8126 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -681,10 +681,10 @@ struct dev_pm_info {
 	struct list_head	entry;
 	struct completion	completion;
 	struct wakeup_source	*wakeup;
+	bool			work_in_progress;	/* Owned by the PM core */
 	bool			wakeup_path:1;
 	bool			syscore:1;
 	bool			no_pm_callbacks:1;	/* Owned by the PM core */
-	bool			work_in_progress:1;	/* Owned by the PM core */
 	bool			smart_suspend:1;	/* Owned by the PM core */
 	bool			must_resume:1;		/* Owned by the PM core */
 	bool			may_skip_resume:1;	/* Set by subsystems */
-- 
2.51.0


