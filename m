Return-Path: <stable+bounces-263777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wWN6Da9lMWrjiQUAu9opvQ
	(envelope-from <stable+bounces-263777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:03:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BE71690BB9
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:03:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=R6WPTh9N;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263777-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263777-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 926AE30309DC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9632D425CFF;
	Tue, 16 Jun 2026 15:00:57 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711823AA1BA;
	Tue, 16 Jun 2026 15:00:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622057; cv=none; b=BOqZscN6DbNxy/FzlhiXal7hg43LC1Rdhj3BdBRxVDyEMY1/Le42eihJlYa1Z3xmca1GUN7dJdrW2HaMsfBhEztBdyyHyV9/ZsLjq+zKMBoJGKb2o03ZF5eU5tDS4GJvtKfE9AyWEMWe9Mnx03e+t2KDlLXsPdGCdQCI4UID/eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622057; c=relaxed/simple;
	bh=xiAfXOz+fDPXctjBtvVx9pRyeU+zAs83KWgMZykGwaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GlwLC44/8x7ZxcWUhSqkOE2WEzjdetSroStnd3eFoQCxKk9vncIgpWXoZOTC49cMvIkOdzEl6Db4MM8ZxO6UN0UNLdNSCOfGp0g2wbtgCzVSfA1L75OLrcVlU9LxLoRFr+bEQxNhxrhwAzrdG5/borAfn7+AyTsVkSZycanrEho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R6WPTh9N; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5659A1F000E9;
	Tue, 16 Jun 2026 15:00:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622056;
	bh=DEV7KiNJUl0u7Fp12kmLOK2iUEMlr1fe7sCzILQB62U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R6WPTh9NZdJDErxKWs9re6d51jh97fRccyyoT8XIuLGAugEDzpZdT2rae7daPY5p9
	 QA6+AktiGMa2W2ZyBVI4l1tXGPnPoLLk47UH42yUGp6bFbCS2rbXrp/gXIjme3y1xv
	 wTLHwNEPFqbtxEFQCHVRcOAL0gtfLhJlDI51Uxw8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 7.1 8/8] arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU
Date: Tue, 16 Jun 2026 20:28:53 +0530
Message-ID: <20260616145523.583441428@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145523.335696673@linuxfoundation.org>
References: <20260616145523.335696673@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263777-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:will@kernel.org,m:mark.rutland@arm.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9BE71690BB9

7.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Will Deacon <will@kernel.org>

commit 1940e70a8144bf75e6df26bf6f600862ea7f7ea1 upstream.

Commit fb091ff39479 ("arm64: Subscribe Microsoft Azure Cobalt 100 to ARM
Neoverse N2 errata") states that Microsoft Azure Cobalt 100 CPU "is a
Microsoft implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and
therefore suffers from all the same errata.".

So enable the workaround for the latest broadcast TLB invalidation bug
on these parts.

Signed-off-by: Will Deacon <will@kernel.org>
[Mark: backport to v7.1.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/arch/arm64/silicon-errata.rst |    2 ++
 arch/arm64/Kconfig                          |    1 +
 arch/arm64/kernel/cpu_errata.c              |    1 +
 3 files changed, 4 insertions(+)

--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -367,3 +367,5 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | Microsoft      | Azure Cobalt 100| #3324339        | ARM64_ERRATUM_3194386       |
 +----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #4193789        | ARM64_ERRATUM_4118414       |
++----------------+-----------------+-----------------+-----------------------------+
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1182,6 +1182,7 @@ config ARM64_ERRATUM_4118414
 	  * ARM Neoverse-V2 erratum 4193787
 	  * ARM Neoverse-V3 erratum 4193784
 	  * ARM Neoverse-V3AE erratum 4193784
+	  * Microsoft Azure Cobalt 100 4193789
 	  * NVIDIA Olympus erratum T410-OLY-1029
 
 	  On affected cores, some memory accesses might not be completed by
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -365,6 +365,7 @@ static const struct arm64_cpu_capabiliti
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_V3AE),
 			MIDR_ALL_VERSIONS(MIDR_NVIDIA_OLYMPUS),
+			MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 			{}
 		})),
 	},



