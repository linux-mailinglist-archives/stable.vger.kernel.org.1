Return-Path: <stable+bounces-267756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JP4ZNQRZOWrIqwcAu9opvQ
	(envelope-from <stable+bounces-267756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:47:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D076B0DB1
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 17:47:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b=qU7OXhdU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267756-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267756-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1AD53026A83
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41DE83C09E0;
	Mon, 22 Jun 2026 15:42:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEC2313545;
	Mon, 22 Jun 2026 15:42:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782142953; cv=none; b=kPEJDYMS/ebAlD5DghPGuEElrl5LNETrap7sRiBdx1C4cWjym0xZkRqS9Pdegiy+vD5ALAJWG52DUu+8u8sSUDrL2/0pUxGZTDMqnnIlAVDD6uwMwwr1LeVU0FFoUBgkKt45rZir5M42LbpamQ6W++TiO1eAzzlpTvMN1Eh2h1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782142953; c=relaxed/simple;
	bh=w0CF9D7qA0+TFxzuaf5uEQDES1j7coKNW/VOdu7PohA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iG0bfkZJ3R5MDW9SFxoH4hilCIeFL4X7FUly9/VYa1eFiso4tWBfqa1P9Xxe3oTzeF3bHWjmdU9yoHCHqhtLM2KsEVanbCrEWr2Qjm/QF2tTZmuJdduVVBW1OOwZHVHD7nAvDw4rFyFJEuwfIFyAcJTxHHFcX/uqGnxsnVG+7rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=qU7OXhdU; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1782142949;
	bh=8HvyzZuawri13YB92T7bVnVD98DHY25m1Z90Cfn8Rdk=;
	h=From:To:Cc:Subject:Date:From;
	b=qU7OXhdUfBzV1ZdAqfTngw/0Tt1PJ98cDMYL326oOpbGQ3+D9EKirxvRLaRdF3G/3
	 X78z75f/wognEhYEARNF72oK/8QQXh8ACuWz6VIs/9/toMgh7aQIWWO4GGyzjd/X6S
	 1KAOPtevmTVRz0xexT+VPKHp1f4EqgB5RolNo2KU=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4gkXWn4tnxz10x5;
	Mon, 22 Jun 2026 15:42:29 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4gkXWn0tthz10x8;
	Mon, 22 Jun 2026 15:42:29 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Kees Cook <kees@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matteo Croce <mcroce@microsoft.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>
Subject: [PATCH] reboot: keep parsed reboot CPU in range
Date: Mon, 22 Jun 2026 15:42:16 +0000
Message-ID: <20260622154216.10064-1-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[grrlz.net,reject];
	R_DKIM_ALLOW(-0.20)[grrlz.net:s=stigmate];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267756-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:akpm@linux-foundation.org,m:mcroce@microsoft.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:include@grrlz.net,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28D076B0DB1

reboot=s... parses the CPU number with simple_strtoul(), but stores
it in an int before checking it against num_possible_cpus(). Very
large values can wrap negative and bypass the range check, leaving
reboot_cpu invalid for migrate_to_reboot_cpu().

Keep the parsed value unsigned until after the range check.

Fixes: f9a90501faac ("reboot: refactor and comment the cpu selection code")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/reboot.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..a1ad6047b14a 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -1134,12 +1134,11 @@ static int __init reboot_setup(char *str)
 			str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
 
 			if (isdigit(str[0])) {
-				int cpu = simple_strtoul(str, NULL, 0);
+				unsigned long cpu = simple_strtoul(str, NULL, 0);
 
 				if (cpu >= num_possible_cpus()) {
-					pr_err("Ignoring the CPU number in reboot= option. "
-					"CPU %d exceeds possible cpu number %d\n",
-					cpu, num_possible_cpus());
+					pr_err("Ignoring the CPU number in reboot= option. CPU %lu exceeds possible cpu number %u\n",
+					       cpu, num_possible_cpus());
 					break;
 				}
 				reboot_cpu = cpu;
-- 
2.53.0


