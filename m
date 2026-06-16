Return-Path: <stable+bounces-263796-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2jGfF1pmMWoJigUAu9opvQ
	(envelope-from <stable+bounces-263796-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:06:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2F0690C21
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:06:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=pNnnteJp;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263796-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263796-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DAA0D3051A44
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DC436F42B;
	Tue, 16 Jun 2026 15:05:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4A43A9D94;
	Tue, 16 Jun 2026 15:05:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781622302; cv=none; b=SKgnSzDQmZchzoP93lJsUDNLmZ3K9vGzMM6CNPmR3NQ5SHqmZKhlG2cb8JreY/65bhZxqpB39Cxa9jwMqePhCLiOjg667u71Nqzd0jikPyqTR/1Q3HfR1yTQhLIW+DtuzSUv/8cEnAk5Qwf1o/P/iPNoLZ07qnUY+f711WFEzn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781622302; c=relaxed/simple;
	bh=Fum+62qEJk0Uja4sR7So94wyGrEk4j+Zlps66fsffgc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQ3QnGa/e4IaJ9fi24IJBQ0IISPlYmji6npVLecnw9aepNU/ZeOOZKUNh4COqFwdsFthZcnnytmBrFmYVK5lHVjkZrXJgUgc1aNt7h6AuJZOVnqrwlJe9W8AlFEvcUIOM2+7zb3avmJ5YreiwKdeMqnwD8/wOrM49Yk7HMKLVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNnnteJp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9897E1F000E9;
	Tue, 16 Jun 2026 15:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781622301;
	bh=Jmx4mJ6V9g+imjCH/f40yhzKJUIYXfT0oRb9A+HIm/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pNnnteJp0M5aEwlfhLsVSuTHvZbtfbgp3X8KmexUC55AfGt2cLPzVUoCy7rFbOQzJ
	 WDzIFo5j0Xm08eh5QnXlbKICh0IlhuvvHYorUMOVq4AfcVKMhmgUmo47lQw7mHyqs4
	 SVw6zFWabgfF4wuVNy0dhv2Rvd9yIATVZzQRp5ag=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xie Yuanbin <xieyuanbin1@huawei.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 003/325] ARM: allow __do_kernel_fault() to report execution of memory faults
Date: Tue, 16 Jun 2026 20:26:39 +0530
Message-ID: <20260616145057.989124303@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145057.827196531@linuxfoundation.org>
References: <20260616145057.827196531@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263796-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:xieyuanbin1@huawei.com,m:rmk+kernel@armlinux.org.uk,m:bigeasy@linutronix.de,m:sashal@kernel.org,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,armlinux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BA2F0690C21

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

commit 40b466db1dffb41f0529035c59c5739636d0e5b8 upstream.

Allow __do_kernel_fault() to detect the execution of memory, so we can
provide the same fault message as do_page_fault() would do. This is
required when we split the kernel address fault handling from the
main do_page_fault() code path.

Reviewed-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Tested-by: Xie Yuanbin <xieyuanbin1@huawei.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mm/fault.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index f87f353e5a8b0a..192c8ab196dbab 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -175,6 +175,8 @@ __do_kernel_fault(struct mm_struct *mm, unsigned long addr, unsigned int fsr,
 	 */
 	if (addr < PAGE_SIZE) {
 		msg = "NULL pointer dereference";
+	} else if (is_permission_fault(fsr) && fsr & FSR_LNX_PF) {
+		msg = "execution of memory";
 	} else {
 		if (is_translation_fault(fsr) &&
 		    kfence_handle_page_fault(addr, is_write_fault(fsr), regs))
-- 
2.53.0




