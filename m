Return-Path: <stable+bounces-272222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id i/G1HnPCS2pAZwEAu9opvQ
	(envelope-from <stable+bounces-272222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:57:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B82A9712478
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:57:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LPouN4bF;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272222-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272222-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E25327907B
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 13:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0D40A933;
	Mon,  6 Jul 2026 13:17:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1253EA96A
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:17:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783343831; cv=none; b=C6lxhC4MHpYcdHvSm6/Hi6yGyfoHUw6TZw8jQVZ2H6KoY9UlLOpIwBQGXB+0LqVOQ3Oevn5G4cyiDgAyMR5JIJ0F0V/9jwRem7xyG7C4NFKReLQeuDsOD0Lg9NtrFx3R6MPrN55UGjEMBlIHObWqKuDwdMuYqTwAThbIUR0zzJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783343831; c=relaxed/simple;
	bh=Hf7StOzUoX0WAVrJUJ1j4R8NAq2Qy5/YR1Hm/Gj3UuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZetkOvwrWplrAQkUDKSGqbryi8L5WMhbHCSIVzUALyIxN+6mUFW2LbIdsE0CYaljJhuvG/SjBUgHbv8/K8bAqseMzZqX2o+Dy29R3Y3b+YU96xsmMjoRaze98JfUJQeXarbMDobPn7IYem0nac5VfCFBdu43QyS9vYimwE/4/Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LPouN4bF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855951F00A3A;
	Mon,  6 Jul 2026 13:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783343829;
	bh=+iFKq1xy8JuoZydFrdyIVYdfXqJdo9zhBarfodWb1BQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LPouN4bFJnZFN9RTv5p3ULBjbQ9HVP9CSuRLHTlfnZ/c4BLy7c1gupFDCOmC/aXJO
	 nl+YmHwU2MJEGg5I8k8w3mNdLFnv7OzK6H+BCqTey1y5ehorIKT1l8lF16KHCxHE6n
	 mnuc/5kb0lPggPASGsk6zkBooABMEsLtQzzXV4QcmSe0jblvPDD5K+9x93TnbdZKFi
	 Y4L7Bgp6jfixc+mIbAzIEJTH7jWr/Xlsg4YjHf3kk0homFvckUFyhrwloGTud2Qids
	 hyYY9l7snHVTKA4Th0Nl9dD2Z8798MwrDp9skzApk7FB4IFk9+TCiw466sqb2/N9c9
	 /Gaylrp5YrEgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] apparmor: advertise the tcp fast open fix is applied
Date: Mon,  6 Jul 2026 09:17:08 -0400
Message-ID: <20260706131708.2289810-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070217-slapping-magnitude-794a@gregkh>
References: <2026070217-slapping-magnitude-794a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272222-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:john.johansen@canonical.com,m:sashal@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,canonical.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B82A9712478

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit 2f6701a5ce6257ae7a64ddc6d89d0a08d2a034f8 ]

The fix for tcp-fast-open ensures that the connect permission is being
mediated correctly but it didn't add an artifact to the feature set to
advertise the fix is available. Add an artifact so that the test suite
can identify if the fix has not been properly applied or a new
unexpected regression has occurred.

Fixes: 4d587cd8a7215 ("apparmor: mediate the implicit connect of TCP fast open sendmsg")
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/net.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/security/apparmor/net.c b/security/apparmor/net.c
index f6f749191f6017..b6df6ff6bd9c1a 100644
--- a/security/apparmor/net.c
+++ b/security/apparmor/net.c
@@ -21,6 +21,7 @@
 
 struct aa_sfs_entry aa_sfs_entry_network[] = {
 	AA_SFS_FILE_STRING("af_mask",	AA_SFS_AF_MASK),
+	AA_SFS_FILE_BOOLEAN("tcp-fast-open",		1),
 	{ }
 };
 
-- 
2.53.0


