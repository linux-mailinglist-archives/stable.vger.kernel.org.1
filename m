Return-Path: <stable+bounces-220493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MpPCEQ3o2lx+gQAu9opvQ
	(envelope-from <stable+bounces-220493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:43:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB52C1C62F7
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 533E83180CC6
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66713C7576;
	Sat, 28 Feb 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3UQYNoD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895DB3C7579;
	Sat, 28 Feb 2026 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300378; cv=none; b=iF0cBu0/A5TUyH63fuYmTM+mbu0FDj6cUIf5qadZrMkQPn8erbzCetM4KSkh05o6MepFaWpeUwCJg2LZx8mEvImdT8FDxTvJxjmkviNwaCeerWdBlEwDzygQTdxek8brPZgogdaKYit4FeqwOo29r3XrmYqUsNwRcIQ+/kOOUWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300378; c=relaxed/simple;
	bh=SmIZ7eLhuIMXWv0+9VOXp6q9bv9TM4DpcEnGvHeowfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S91rzEQsIZkD+TyWtPkmrzx7XcRKimNQvGSQqq5sI+tVrkTAc2hADdU2L8MROM0YsNpJjPhwrJSqA5Wb5biAF2vThYwQYqHukSfoetOWha5Gy/PigErLsEsuK4taypuJkyjKvI+Z8EnKk8smYu60DBRMP0BUmocgdtEG7Uuv8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3UQYNoD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD4A7C19423;
	Sat, 28 Feb 2026 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300378;
	bh=SmIZ7eLhuIMXWv0+9VOXp6q9bv9TM4DpcEnGvHeowfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p3UQYNoDTtPjHQxgVc92AVBKk2IjoEVp+XQBLkVhYNaTXKaySjEYihqoAl7U5emLP
	 q/mItUgNU60XegredbhoLszFSlEYAOLOaTKfcpp09alJDm3LK7DC/2r6VO0eeXwzlm
	 GyaUj+MFRGyoupAOzEDcFDmUctIPBp8YtwZ3J/W90FZkqaK9Ih1glw7RBXSAybSs42
	 F1qoRHrzuQ5AG1O8lmLDBEn2oKJDEwt0pZZ150GoIxIo3T4YD91OiisGjKPARX7cn0
	 toMY57uODU3/eJT16//HaQMS3vG4j/MAd/ywNqoAOHSfeBmt9NBMl2WORttuXk4GST
	 WHq3ZQcpRoN3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phil Sutter <phil@nwl.cc>,
	Alyssa Ross <hi@alyssa.is>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 414/844] include: uapi: netfilter_bridge.h: Cover for musl libc
Date: Sat, 28 Feb 2026 12:25:27 -0500
Message-ID: <20260228173244.1509663-415-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220493-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CB52C1C62F7
X-Rspamd-Action: no action

From: Phil Sutter <phil@nwl.cc>

[ Upstream commit 4edd4ba71ce0df015303dba75ea9d20d1a217546 ]

Musl defines its own struct ethhdr and thus defines __UAPI_DEF_ETHHDR to
zero. To avoid struct redefinition errors, user space is therefore
supposed to include netinet/if_ether.h before (or instead of)
linux/if_ether.h. To relieve them from this burden, include the libc
header here if not building for kernel space.

Reported-by: Alyssa Ross <hi@alyssa.is>
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter_bridge.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/uapi/linux/netfilter_bridge.h b/include/uapi/linux/netfilter_bridge.h
index 1610fdbab98df..ad520d3e9df8f 100644
--- a/include/uapi/linux/netfilter_bridge.h
+++ b/include/uapi/linux/netfilter_bridge.h
@@ -5,6 +5,10 @@
 /* bridge-specific defines for netfilter. 
  */
 
+#ifndef __KERNEL__
+#include <netinet/if_ether.h>	/* for __UAPI_DEF_ETHHDR if defined */
+#endif
+
 #include <linux/in.h>
 #include <linux/netfilter.h>
 #include <linux/if_ether.h>
-- 
2.51.0


