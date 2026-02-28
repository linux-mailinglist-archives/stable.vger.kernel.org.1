Return-Path: <stable+bounces-220141-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAjWDxIso2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220141-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1CE1C536F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:55:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F64F31374CE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A9148B372;
	Sat, 28 Feb 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQ7FX2te"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48D48AE15;
	Sat, 28 Feb 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300050; cv=none; b=Wl9dvHzLoUa28vbeE6cpoMpAglIRw4j2Se0UVqbiv1GOOM0Agx0Qlmky+7Gpc4ORc+CynjclxDAqyBuNrmMFQqtEBJGyp04sL9NEV6+u+FoRByGrjaAltrIHkmLDcqafi5a9//DxQTJemSC92YVKiM6g3uKzAYzWCBRoLulLv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300050; c=relaxed/simple;
	bh=LXfydIHbtyS7K6xEZPDR93d+R5QphdM5i5xDyAVm46E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhED6S7pDnmhTsBrSY2WLBVGsXfdi1tfFb5UTW9zYfTLdkPhM8Fg9we7UyuTd+vHwU623JpAfGi28YP9HCzvWTT9s5FheV7E6TUyJhawiwGOnd2vGUDsxX0lVZXQ1E1EWYaevnon35xSBCM1aFY4LWcUOb+bxVVkz/fRO+azRLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQ7FX2te; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7323CC116D0;
	Sat, 28 Feb 2026 17:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300050;
	bh=LXfydIHbtyS7K6xEZPDR93d+R5QphdM5i5xDyAVm46E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZQ7FX2teRFLyTfSD6AePp2UXw17Cj1FHbAlz3TmntVSsTq1eI957kJzbwXih6yRn8
	 T8Crvy7z/18LEI2Zkg/37W7rdyCAyyDB29fHrFWP3mw7bG00gKvkjPfk0Apk6g2qRn
	 bW2eh1WLxHjDgyVgaf1IUXrpotXUVuqxjPOS/Y0i7KgJYEokLF2GA0gzYU0o7afWoB
	 xi4pcKqjdXMiWLht02oZn1N+InPFxzjQfLnTBl1eLhs2UvXViWnlDyf1c5TrsdcI3j
	 L3Pn6j5JiMVhApOr6kPBR6WZPA9jEAgFRRORioEmPyJJJL9/V3j5Ya64kUHcJ9w/EU
	 /B4683EvEtuFQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Juergen Gross <jgross@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 063/844] x86/xen/pvh: Enable PAE mode for 32-bit guest only when CONFIG_X86_PAE is set
Date: Sat, 28 Feb 2026 12:19:36 -0500
Message-ID: <20260228173244.1509663-64-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220141-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:email,antgroup.com:email]
X-Rspamd-Queue-Id: AE1CE1C536F
X-Rspamd-Action: no action

From: Hou Wenlong <houwenlong.hwl@antgroup.com>

[ Upstream commit db9aded979b491a24871e1621cd4e8822dbca859 ]

The PVH entry is available for 32-bit KVM guests, and 32-bit KVM guests
do not depend on CONFIG_X86_PAE. However, mk_early_pgtbl_32() builds
different pagetables depending on whether CONFIG_X86_PAE is set.
Therefore, enabling PAE mode for 32-bit KVM guests without
CONFIG_X86_PAE being set would result in a boot failure during CR3
loading.

Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Message-ID: <d09ce9a134eb9cbc16928a5b316969f8ba606b81.1768017442.git.houwenlong.hwl@antgroup.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/platform/pvh/head.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/platform/pvh/head.S b/arch/x86/platform/pvh/head.S
index 344030c1a81d4..53ee2d53fcf8e 100644
--- a/arch/x86/platform/pvh/head.S
+++ b/arch/x86/platform/pvh/head.S
@@ -91,10 +91,12 @@ SYM_CODE_START(pvh_start_xen)
 
 	leal rva(early_stack_end)(%ebp), %esp
 
+#if defined(CONFIG_X86_64) || defined(CONFIG_X86_PAE)
 	/* Enable PAE mode. */
 	mov %cr4, %eax
 	orl $X86_CR4_PAE, %eax
 	mov %eax, %cr4
+#endif
 
 #ifdef CONFIG_X86_64
 	/* Enable Long mode. */
-- 
2.51.0


