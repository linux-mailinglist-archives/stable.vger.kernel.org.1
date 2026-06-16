Return-Path: <stable+bounces-263898-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yYuvCepqMWpdiwUAu9opvQ
	(envelope-from <stable+bounces-263898-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:25:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B0712691030
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:25:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=2tmrcfMJ;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263898-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-263898-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D23F230B499B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB6743E4A8;
	Tue, 16 Jun 2026 15:17:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A924243E49F;
	Tue, 16 Jun 2026 15:17:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623055; cv=none; b=nq9qjdv6s/Vt4dtEHUo9c9nRC6d3BQZzg4Uc3RD5EFCryB6XnQiDkNUBG4QvMdqC7GYg7PnYpP6S6iVQTd5pWAYDyeMYkr4HYYa7ql06njeXct0f0cDHlp4x4gt35PVA8qyatX1DJvZzHceSIwDAA6CJs86FY6f9JGopXLDo1gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623055; c=relaxed/simple;
	bh=hegltPWP1Vm3eaO0dlUnmbHkqFNcb9GgZ1mkNFiHwxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUzXrtAtiqDAeamfEi+stgy5Q7S53T4CWJJuURJDSgfYs4XijoFixSgbeyxyYp9DMD/ioq9tlfiVjkwBhiv6tUEx+L+qmdlfOiW1hnuR9TwSWIh4DN6aOIga5mIwGQb5zLye9G5AGjxKn65t8TfyLn6GDmwY2xv7eZ+17QHAq1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2tmrcfMJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544151F000E9;
	Tue, 16 Jun 2026 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623054;
	bh=79MvhfUvtOrDi4Qv4SF0Ahc7DFwYbLRXpoRC/7dFWks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=2tmrcfMJqyzSwuoRweexO3eSfZQCFgh5y/SUMe66mtNt+rIEEV5HAnX27FanAYBZH
	 6Y4RhzRriEOuvyBtqEw28T6u5WMkwWvo9j7ot2yymC+q8xDLfWQr+c9fE+5c0n/cH7
	 FXUJVEca61W5lqrippC61icKN0iAMJXQmtMZ3Hsk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dexuan Cui <decui@microsoft.com>,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 080/378] hyperv: Clean up and fix the guest ID comment in hvgdk.h
Date: Tue, 16 Jun 2026 20:25:11 +0530
Message-ID: <20260616145114.409807726@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263898-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:decui@microsoft.com,m:hamzamahfooz@linux.microsoft.com,m:wei.liu@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B0712691030

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 83eb00f31eb1b10735d48e469df72cc2b0e06f6d ]

Change the "64 bit" to "64-bit", and the "Os" to "OS".

Remove the obsolete paragraph since the guideline has been
published in the Hypervisor Top Level Functional Specification
for many years.

The "OS Type" is 0x1 for Linux, not 0x100.

No functional change.

Fixes: 83ba0c4f3f31 ("Drivers: hv: Cleanup the guest ID computation")
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/hyperv/hvgdk.h | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/include/hyperv/hvgdk.h b/include/hyperv/hvgdk.h
index 384c3f3ff4a525..f538144280ca55 100644
--- a/include/hyperv/hvgdk.h
+++ b/include/hyperv/hvgdk.h
@@ -10,18 +10,12 @@
 
 /*
  * The guest OS needs to register the guest ID with the hypervisor.
- * The guest ID is a 64 bit entity and the structure of this ID is
+ * The guest ID is a 64-bit entity and the structure of this ID is
  * specified in the Hyper-V TLFS specification.
  *
- * While the current guideline does not specify how Linux guest ID(s)
- * need to be generated, our plan is to publish the guidelines for
- * Linux and other guest operating systems that currently are hosted
- * on Hyper-V. The implementation here conforms to this yet
- * unpublished guidelines.
- *
  * Bit(s)
  * 63 - Indicates if the OS is Open Source or not; 1 is Open Source
- * 62:56 - Os Type; Linux is 0x100
+ * 62:56 - OS Type; Linux is 0x1
  * 55:48 - Distro specific identification
  * 47:16 - Linux kernel version number
  * 15:0  - Distro specific identification
-- 
2.53.0




