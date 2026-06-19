Return-Path: <stable+bounces-267427-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0fwoAJpxNWocwgYAu9opvQ
	(envelope-from <stable+bounces-267427-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 18:43:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 463A56A71A5
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 18:43:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=grrlz.net header.s=stigmate header.b="kXR/6eg/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267427-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-267427-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=grrlz.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1FA9E302172B
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8063BF684;
	Fri, 19 Jun 2026 16:38:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from confino.investici.org (confino.investici.org [93.190.126.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6FA3B42C2;
	Fri, 19 Jun 2026 16:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781887080; cv=none; b=uK1nosoJxHAsyVS1iWrEObkoZ4Q+bI5u0Roycct+NrOJZ2xFaUSzONs0rjV3ZGD8mzt5+ctIDE05Ko31biNiC6yOY3MTQsza71BizPdyNDoswGOUPDCyCiKJBuWhLdjlXA4Non0w/6t3H6GNBv2Aze5iZ7JAK8dCqpcNJqx8rZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781887080; c=relaxed/simple;
	bh=ZskmbQGX+wTrTq4oL6kwkAKc9As0FGX9OjT1UNB/0MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dU5SRLuBJQvTmfLSop845wzroNX/yPLyqjJUV42Qq7Ymnxybnc2NMtOHQTlwYvDl5iDeO0ryyFlNy75APAZ8VpoRBNneZtbY6vFlwURBh4+VVcqYsVN8axuqK3Kh96kwNEVTvkpIablgrPuVzCP/bqSMKigbM5g75zCsoR77Ajo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=grrlz.net; spf=pass smtp.mailfrom=grrlz.net; dkim=pass (1024-bit key) header.d=grrlz.net header.i=@grrlz.net header.b=kXR/6eg/; arc=none smtp.client-ip=93.190.126.19
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=grrlz.net;
	s=stigmate; t=1781887075;
	bh=4eKcsr+UzJ7qj5Jrxlc7lgXi8XIpKkEBQv5p5NC2Gjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kXR/6eg/ArhsZTTjfyILfGroWjV+fetVxYz3k2a57vAJ5gtbF1M0oXhxCQWggkw1t
	 XcSp2ukDMLk//ODE3n0MCAqen6CFAhMKaVuDhygV/L5iqxTElMd8CMYYxSNkotJupX
	 4KtqaD8kIAngNsxWYSEmCOHfQP6zn79/juaJUrx4=
Received: from mx1.investici.org (unknown [127.0.0.1])
	by confino.investici.org (Postfix) with ESMTP id 4ghjv76zLTz115H;
	Fri, 19 Jun 2026 16:37:55 +0000 (UTC)
Received: by mx1.investici.org (Postfix) id 4ghjv73k17z114y;
	Fri, 19 Jun 2026 16:37:55 +0000 (UTC)
From: Bradley Morgan <include@grrlz.net>
To: Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	Bradley Morgan <include@grrlz.net>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] cpu: hotplug: bound hotplug states sysfs output
Date: Fri, 19 Jun 2026 16:37:18 +0000
Message-ID: <20260619163719.12103-2-include@grrlz.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619163719.12103-1-include@grrlz.net>
References: <20260619163719.12103-1-include@grrlz.net>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-267427-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:peterz@infradead.org,m:linux-kernel@vger.kernel.org,m:include@grrlz.net,m:stable@vger.kernel.org,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[include@grrlz.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[grrlz.net:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,grrlz.net:dkim,grrlz.net:email,grrlz.net:mid,grrlz.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 463A56A71A5

states_show() adds CPU hotplug state names into a single sysfs buffer
using sprintf(). With enough registered states, this can write past the
end of the PAGE_SIZE buffer.

Use sysfs_emit_at() so output is bounded.

Fixes: 98f8cdce1db5 ("cpu/hotplug: Add sysfs state interface")
Cc: stable@vger.kernel.org
Signed-off-by: Bradley Morgan <include@grrlz.net>
---
 kernel/cpu.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0f32086f9ed4..dec58e19329b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2857,7 +2857,7 @@ static const struct attribute_group cpuhp_cpu_attr_group = {
 static ssize_t states_show(struct device *dev,
 				 struct device_attribute *attr, char *buf)
 {
-	ssize_t cur, res = 0;
+	ssize_t res = 0;
 	int i;
 
 	mutex_lock(&cpuhp_state_mutex);
@@ -2865,9 +2865,8 @@ static ssize_t states_show(struct device *dev,
 		struct cpuhp_step *sp = cpuhp_get_step(i);
 
 		if (sp->name) {
-			cur = sprintf(buf, "%3d: %s\n", i, sp->name);
-			buf += cur;
-			res += cur;
+			res += sysfs_emit_at(buf, res, "%3d: %s\n",
+					     i, sp->name);
 		}
 	}
 	mutex_unlock(&cpuhp_state_mutex);
-- 
2.53.0


