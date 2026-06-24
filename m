Return-Path: <stable+bounces-268133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KUSrDjirO2pObAgAu9opvQ
	(envelope-from <stable+bounces-268133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:02:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D286BD299
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 12:02:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=uniontech.com header.s=onoh2408 header.b=ejqkpcJl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268133-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268133-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=uniontech.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3359B30C7630
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 10:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FD8D3B71D5;
	Wed, 24 Jun 2026 10:01:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F7D3B71BE
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 10:01:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782295266; cv=none; b=hm4Tqrklgv8+2ZYPTGskuRjG/yHuSQAv30McKC+n7+Yq0Ri0zLIlZIFFJ6KPIOvfRZdFdSft+5eIwzN25Kzb7isiVrzKi9zVZPW4cGYzdWiLP//7dOlzonXPStVb3tbgHeyMXf67QKLwlHfBMrBxdlqCZFgh9WnehvrJELQqVwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782295266; c=relaxed/simple;
	bh=oIEYfyBI/HY6darqsVGBC82MMHrJVuN7qqQh5Yujuq0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Eoq9/hkddha4/DY3s+gQQq0EwPd2mwRjuY+lCSNJAV70g4fIgxJOiRBdP0SGrhq7qj3A/DYjJ9l9H4yAzy0hRGG9S4BofTa58x43H10gcZoYcFHnuQvNEWTaBr5Ha08sBZ4cm53KRRbeutsNPfJeK4epJuk0Lm/4MUdTVlcWxd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=ejqkpcJl; arc=none smtp.client-ip=54.206.34.216
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1782295192;
	bh=VkOUhbDww57iO0p2rxbAqZ3RyZ9Ngi7YuBKPJC2iPVk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=ejqkpcJl8PlOpgMSoluWekrdqnK0f6hpC47+WDMzyZJ+stBi3ZItDY9zqTxcqvRV5
	 6A/4QpHcU1ZhifpVl74/gecnb4gdXNQ5by7B3zxxvqV7HGBjmz6ZLtQl5L1kkWknJl
	 y1Ki2f7XfPDMSLkTPQ0r1M5SjX0ibAo2P26eUSHk=
X-QQ-mid: esmtpsz21t1782295172t6a960cbd
X-QQ-Originating-IP: 5QqDY9Mz6lwiVbw5RvPqbi8h8LaIAWJ/rqaZHU13jvM=
Received: from localhost.localdomain ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 24 Jun 2026 17:59:30 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 14368970454076104944
EX-QQ-RecipientCnt: 9
From: Wentao Guan <guanwentao@uniontech.com>
To: gregkh@linuxfoundation.org
Cc: 00107082@163.com,
	guanwentao@uniontech.com,
	iklatzco@gmail.com,
	patches@lists.linux.dev,
	peterz@infradead.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	yeoreum.yun@arm.com
Subject: [PATCH] perf: Fix dangling cgroup pointer in cpuctx backport
Date: Wed, 24 Jun 2026 17:59:21 +0800
Message-Id: <20260624095920.2558406-1-guanwentao@uniontech.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <2026062455-obtrusive-sandbox-d6d1@gregkh>
References: <2026062455-obtrusive-sandbox-d6d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz3a-0
X-QQ-XMAILINFO: NRN3UPsLzYKVIW2xGgI+zTzrMhHEZ34YQiVhoPad/kZ0sEXCPJylnjIZ
	A/hVA9DahAmetClMLK1cZTfNBjOJqj7RBxUqZwdctuKehGu7TK70YQ9Sf/OwsXVEagdZpsI
	jaaQxFlCtvdNhaSl7k3u8Vel6y0cuX5DVXA5Ql01AV0aCeyFmm/hsVA0vWAI3DRlJmHYap7
	rNz02g07LFXDKKVKMzor83aMwIJJqxgIe3buA5DO0OPPEhwKacUoHXYcHH/N0mmCDp9PIUx
	H1+diaRUCId/7HjOJPxz/FFOiacs9VcwwlfnBJemLJY03FEkEFbTccEwvyBE76LO/cdRICs
	hHTQ8lm+OM8eybRTn//4XzuenXM4pOsbi9VYccvAtZiSTbMv76yUIn1AFdxPddXMEtzm3L4
	oOAmw1KjjcgBl/SV79XRfRyJzQWyhssHVsH6DHVSjSgP/laaNrzSXiGSENxq9CSAmoZTR2c
	S8PL6WlZt66h0hv8g27Wq2kete9HuqEt6X6YxBMIwBa0kq+fzBI5HIrRMn93E29B/Y891EC
	D+Te6zUNLX0tPdPrHc4c/UFr51h9u7/DFIyWb5GX0YZQA5EDzfZZKJZIysj2XfVP3tYLlf2
	9hd9swjuI0Pd/8Hn5hTT8yIypgj8Hitne8VaVxgUhDdZWZRVg4UVtE3FYXXOXRqIYd22gfg
	0R8qMcCXZbWckcd0OChTlwOZmtmS+9dzBlkVd/bpXrs1WGkPzssWe/aREbCxyOoq1r6FIXy
	32KLfIKkyipvpiJb/gy6hYnFF+CIGcnYL9SsmkLFMYBYjUfYqDVSZmKO9Dlskbvj/a+LGyM
	WLmjJorHOm1GONfR5Someh20e0SxgGc7Paqf6g8uo0vB2QJjkNgQcQuB5fj1FScGYlPKgf7
	eZPErAMON6unXBsIQVPzAvsoamoEE917Mo2+XwmgcM8Sx9QAIuIwxzczl2G0SxJKB4fhB3y
	3hOYDOlVFSMcDEDNI9ntl/EV5tGalZdetIyRDC0V1qqgtvqiBWnJet44lbgiUfoBBwa7+T2
	1t91t19rMs54b5a0cz7imFqAnwA6+itUnkIEpLc6QC5kKGXGyP17WFgxskaHGKPnrjZv52y
	Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[uniontech.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[uniontech.com:s=onoh2408];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[163.com,uniontech.com,gmail.com,lists.linux.dev,infradead.org,kernel.org,vger.kernel.org,arm.com];
	TAGGED_FROM(0.00)[bounces-268133-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:00107082@163.com,m:guanwentao@uniontech.com,m:iklatzco@gmail.com,m:patches@lists.linux.dev,m:peterz@infradead.org,m:sashal@kernel.org,m:stable@vger.kernel.org,m:yeoreum.yun@arm.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[uniontech.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[guanwentao@uniontech.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,uniontech.com:dkim,uniontech.com:email,uniontech.com:mid,uniontech.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43D286BD299

recently backport of ("perf: Fix dangling cgroup pointer in cpuctx")
use a middle version, so aligned with the upstream commit:
3b7a34aebbdf2a4b7295205bf0c654294283ec82

Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
---
 kernel/events/core.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a4187dea6402a..73a86db06cc9b 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2384,10 +2384,9 @@ __perf_remove_from_context(struct perf_event *event,
 	 */
 	if (flags & DETACH_EXIT)
 		state = PERF_EVENT_STATE_EXIT;
-	if (flags & DETACH_DEAD) {
-		event->pending_disable = 1;
+	if (flags & DETACH_DEAD)
 		state = PERF_EVENT_STATE_DEAD;
-	}
+
 	event_sched_out(event, ctx);
 
 	if (event->state > PERF_EVENT_STATE_OFF)
-- 
2.30.2


