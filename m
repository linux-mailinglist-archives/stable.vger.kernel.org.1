Return-Path: <stable+bounces-221101-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yFHTF3NIo2mm/AQAu9opvQ
	(envelope-from <stable+bounces-221101-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF901C795C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:56:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E9AF33851D5
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A9371447;
	Sat, 28 Feb 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFDZGi34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E5936D9FB;
	Sat, 28 Feb 2026 17:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772301450; cv=none; b=pI+4P6s3afoeDwDtEjN6H5M6YfeTllF08nmjbWIb3T03Gz9tlMYS41F45IuPc1ouX35ySZ3OZqrDhXvHDIuZFY0qI+KBilwfQ9dGdKFEcgJ/b1brWinm0sC1f2GfFxFj+G5OqwuzM8cqOfilukMANJDfjz/6ldoGauptj3/Yaqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772301450; c=relaxed/simple;
	bh=tCMzRHsWyYdx+p+srmphj93Pe8F2zhyw2KaMUk7nLZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fOqhU3sR7YDNSpAO6JDj+uxn+HcXQgBUTFEsPIqBmmWxtUhHP9teZU8RjvsAxKJLRdYhhl+I3lHEPgcFITmtornvQCbCiH2i+yrRREiO1gSJvin3/e53SE0nG7aQatmu8bMCE3qBk+vZZUCEuyVVD9jZo+TTCQjafDvXSQayMw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFDZGi34; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A377C116D0;
	Sat, 28 Feb 2026 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772301450;
	bh=tCMzRHsWyYdx+p+srmphj93Pe8F2zhyw2KaMUk7nLZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qFDZGi3417G6MTVuIA4DDAI69wAkJsRcIEEopgbacK9e0OOKBYNBrErhUZj+11S5l
	 sRLjHkKOkzTWqf26529VgmIeB6gxeNKZpoGEkZ6ktOcLUO5fKtHilz11vzU48AkyXQ
	 CXubuyk03yJSjWds86/mNAa2SYwoCWFLTIvlqj8BoDYMVIIyQcwr2ruDRLmJNr3Wfg
	 0gIVvtMG8/flXBC25/NXOQ2Va6Ob+69FbtYUoC6ekpVRFuNH+Go4XJNLOvMaJHYpNs
	 qbdwhWB6ON1pdP+UQMyM016ec04GKxYvnU/NtUu8JwuQkew5Ej+Cn1RMiT22Y1w3Er
	 sMd33R8DMhQfw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 636/752] powerpc/smp: Add check for kcalloc() failure in parse_thread_groups()
Date: Sat, 28 Feb 2026 12:45:47 -0500
Message-ID: <20260228174750.1542406-636-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,csgroup.eu,linux.ibm.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-221101-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9DF901C795C
X-Rspamd-Action: no action

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit 33c1c6d8a28a2761ac74b0380b2563cf546c2a3a ]

As kcalloc() may fail, check its return value to avoid a NULL pointer
dereference when passing it to of_property_read_u32_array().

Fixes: 790a1662d3a26 ("powerpc/smp: Parse ibm,thread-groups with multiple properties")
Cc: stable@vger.kernel.org
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20250923133235.1862108-1-lgs201920130244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 68edb66c2964b..0cd9c0c21af3e 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -822,6 +822,8 @@ static int parse_thread_groups(struct device_node *dn,
 
 	count = of_property_count_u32_elems(dn, "ibm,thread-groups");
 	thread_group_array = kcalloc(count, sizeof(u32), GFP_KERNEL);
+	if (!thread_group_array)
+		return -ENOMEM;
 	ret = of_property_read_u32_array(dn, "ibm,thread-groups",
 					 thread_group_array, count);
 	if (ret)
-- 
2.51.0


