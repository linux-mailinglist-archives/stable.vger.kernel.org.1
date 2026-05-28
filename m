Return-Path: <stable+bounces-255823-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNKdJQCnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255823-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3FC5F9072
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65D49327137C
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CF8257854;
	Thu, 28 May 2026 20:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IpRQeLxU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20012DDC5;
	Thu, 28 May 2026 20:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999980; cv=none; b=M/lU8Llj7R7hSrBL6/iuZyvBV4xBK4vqTHfI9YKMFl/2EVrSOxHbAcqoAitWd+65OtW6vRuSydEyuRtprKmBCk1hgba7Ufq5i/Qmr40+N3PQJFbLNXVQLRWnkQCWfxoERxdNliyB4c2gmdGTfK9ZTRH6YObdbAorZaXv84mKNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999980; c=relaxed/simple;
	bh=IH018Zf9+t5uVXQhNgMPcQ7uhSa6VrMNWJ9pbDGe6QA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vGQxGQ/HIi6fFZrGzoplAWQrLG+4T47Wdv+ZR5QSlC6lNhNrtZ3lChYRg9d62OazH40hNJW0DY3LGhFMx1+IfEV1CsA03U7W/Nvn96c2WGMi2aNw8UMKKHQuKljXADfBGBR4iGYJJP0UA8JO5svldF1J2s24sftiLcyGurft47s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IpRQeLxU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C541F000E9;
	Thu, 28 May 2026 20:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999978;
	bh=NVuj5DvsOX+gHc29pbRqDjbdll80JbzKfg7248DblaI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpRQeLxUfFoJpwP4sVzgjMG5EcfhgB1LFvdi43D5PuhgWTAIjZYGAKUaCdOfbtv9Y
	 M6Z0oIvE09HKeJUiJAHK/3QnAYviim8cRDmte0fI71TbdOFra3a4z4LpU+ii0422j/
	 me++1J6aHDHURvNhpv1vpZLXK3LGRn4/vayj2nh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Julian Braha <julianbraha@gmail.com>,
	Gautam Menghani <gautam@linux.ibm.com>,
	Amit Machhiwal <amachhiw@linux.ibm.com>,
	Harsh Prateek Bora <harshpb@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 232/377] powerpc: fix dead default for GUEST_STATE_BUFFER_TEST
Date: Thu, 28 May 2026 21:47:50 +0200
Message-ID: <20260528194645.107074648@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,linux.ibm.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255823-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1D3FC5F9072
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julian Braha <julianbraha@gmail.com>

[ Upstream commit aef656a0e6c01796190bb5bd2bdba1c644ed7811 ]

The GUEST_STATE_BUFFER_TEST config option should default
to KUNIT_ALL_TESTS so that if all tests are enabled then
it is included, but currently the 'default KUNIT_ALL_TESTS'
statement is shadowed by 'def_tristate n',
meaning that this second default statement is currently dead code.

It looks to me like the commit
6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
intended to set the default to KUNIT_ALL_TESTS, but mistakenly
missed the def_tristate.

This dead code was found by kconfirm, a static analysis tool for Kconfig.

Fixes: 6ccbbc33f06a ("KVM: PPC: Add helper library for Guest State Buffers")
Signed-off-by: Julian Braha <julianbraha@gmail.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260405161545.161006-1-julianbraha@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/Kconfig.debug | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f15e5920080ba..e8718bc13eeb1 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -83,11 +83,10 @@ config MSI_BITMAP_SELFTEST
 	depends on DEBUG_KERNEL
 
 config GUEST_STATE_BUFFER_TEST
-	def_tristate n
+	def_tristate KUNIT_ALL_TESTS
 	prompt "Enable Guest State Buffer unit tests"
 	depends on KUNIT
 	depends on KVM_BOOK3S_HV_POSSIBLE
-	default KUNIT_ALL_TESTS
 	help
 	  The Guest State Buffer is a data format specified in the PAPR.
 	  It is by hcalls to communicate the state of L2 guests between
-- 
2.53.0




