Return-Path: <stable+bounces-263911-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g/ZRDsVqMWpOiwUAu9opvQ
	(envelope-from <stable+bounces-263911-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D71691009
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=hkPnlmt+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263911-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263911-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61AF831F6B6D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD1843DA53;
	Tue, 16 Jun 2026 15:18:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3C143DA2C;
	Tue, 16 Jun 2026 15:18:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623127; cv=none; b=WrXgc3cLCxv6Id9C1XO9UHSoj0SWYRnucJfRJ2BMZHy8787vP3dRoJi2pe6X4J3A85ZlT1eXmpsRqc35ZPcQq/6zQ5aS8FYm9bvts5b53ZiKRCFdYzvft5sd6hf43T6zhIUpQYHqUYhrkbY+6BxV7sHg8gfZnFTr/RXwHYpW8wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623127; c=relaxed/simple;
	bh=Ry9OS9HnHFJyFJuJvYHATezQAU0uTi2BLV6qjUkec+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GFP52Xo9zQVXprkkeOLdhmsybY4f+PW3yL6F8GtFqJ/GYQg3C9RrvNAiCimNERj0l6SAQ9QOHzAG8NG/zsNd12Al/c41QzLv56mCSkNSxyfI4Z7x9BTF635xdIiGwv5sgZy6piICdtBcOCUKBtdZzGmE6BVXoEpCl8eV4mYi6N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hkPnlmt+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5B41F000E9;
	Tue, 16 Jun 2026 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623125;
	bh=k5o+NzBo3tilC4nT9IAlXvueWqRG9qSy316ayS9753g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hkPnlmt+O+soZWLGnwj3TJMBorHQE65TsWnjOtpDT3cLRvXAu1E3PSufEX4W2yx/a
	 JO9uObZNDqbMsAD3dDa+2nx9RXV4KMJGLqrL2S8PEv65Oj4SRefmqzZZiewbCR6geH
	 NI7H3W/0LRh6zc6TYBDQ1ABf4yFijg8+ojdOaDJ0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nam Cao <namcao@linutronix.de>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 092/378] tools/rv: Fix substring match when listing container monitors
Date: Tue, 16 Jun 2026 20:25:23 +0530
Message-ID: <20260616145115.120850680@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263911-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:namcao@linutronix.de,m:gmonaco@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 83D71691009

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit ba0247c5aa3fcb2890a92a97a88c70fe5ce704a6 ]

When listing monitors within a specific container (rv list <container>),
the tool incorrectly matched monitors if the requested container name
was only a prefix of the actual container (e.g., 'rv list sche' would
incorrectly list monitors from 'sched:').

Fix this by ensuring the container name is an exact match and is
immediately followed by the ':' separator.

Fixes: eba321a16fc6 ("tools/rv: Add support for nested monitors")
Reviewed-by: Nam Cao <namcao@linutronix.de>
Link: https://lore.kernel.org/r/20260514152055.229162-3-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rv/src/in_kernel.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 95eac9ab148468..e4f35940374f5a 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -193,8 +193,12 @@ static int ikm_fill_monitor_definition(char *name, struct monitor *ikm, char *co
 	nested_name = strstr(name, ":");
 	if (nested_name) {
 		/* it belongs in container if it starts with "container:" */
-		if (container && strstr(name, container) != name)
-			return 1;
+		if (container) {
+			int len = strlen(container);
+
+			if (strncmp(name, container, len) || name[len] != ':')
+				return 1;
+		}
 		*nested_name = '/';
 		++nested_name;
 		ikm->nested = 1;
-- 
2.53.0




