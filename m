Return-Path: <stable+bounces-255749-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNM2ILKnGGpolwgAu9opvQ
	(envelope-from <stable+bounces-255749-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9475F92B2
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0563F320BFE9
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2222F39B4;
	Thu, 28 May 2026 20:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vr/6x76D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A355622652D;
	Thu, 28 May 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999776; cv=none; b=UdWxDB/VB6Ce8cUYqzIGwqJGIC93N+wkk4jAxuVGbzeVZtOXyfIIQRXS9Fw0XCoriR7obhWfN6y6OP7OjdnBvQmG5DJRG6p8YAADeuqMfLQwdk+oYvFe/5IHn8NXeM9NqKZ2xNSkxRPGv2TKBfdoxEJxwVvm2Ywl5RFXPVZETHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999776; c=relaxed/simple;
	bh=z/Fs+dVQGNWcK2ZMhEWfMbs/GJDCsdBVhFfr0LwhCLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mdv2SzTpKbo5JqqWYkX1dZ5R1yxwmaSMoGlvRn1Bq5lAg07AF1yJwsTfG8KlXiRHaal7jrIclb1KUn8dYaJBCBjcSO4SKQyNDkZYYhlOrvtccLUyzhSVabECk55P5BsAq3rBzTXAXRqcHmREPmkGdGIMuPf5VGgycGU+MF/QfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vr/6x76D; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7F01F000E9;
	Thu, 28 May 2026 20:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999775;
	bh=cA/sdSBHZexvd/iHhL50vvYq75pMwK2MOnPRcOeYzlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vr/6x76DqdHMrxIw3o19GJaUgIFRPWZrFkBd4hcSyt4TY+PmUD/NzMNuMQnBZqpRd
	 qz4Sc9BF9y4heTeYfjXXZM+UrFZfiyHG1jYo4xJcSLmJTzIeojA2rk4DoQDykhry8t
	 xJdIPsm8ZFk65J7R0fTkQxmPHYLsKbmeGL7T1NrQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Gow <david@davidgow.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 186/377] kunit: config: KUNIT_DEBUGFS should depend on DEBUG_FS
Date: Thu, 28 May 2026 21:47:04 +0200
Message-ID: <20260528194643.806484010@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255749-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,davidgow.net:email]
X-Rspamd-Queue-Id: 1D9475F92B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Gow <david@davidgow.net>

[ Upstream commit 8f80b5b227ef9ea422080487715c841856339aed ]

CONFIG_KUNIT_DEBUGFS is totally useless without debugfs, so it should
depend on CONFIG_DEBUG_FS.

Link: https://lore.kernel.org/r/20260425034155.53913-2-david@davidgow.net
Fixes: e2219db280e3 ("kunit: add debugfs /sys/kernel/debug/kunit/<suite>/results display")
Signed-off-by: David Gow <david@davidgow.net>
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 lib/kunit/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/kunit/Kconfig b/lib/kunit/Kconfig
index 2b9fd107a69fe..889380c2702c3 100644
--- a/lib/kunit/Kconfig
+++ b/lib/kunit/Kconfig
@@ -17,6 +17,7 @@ if KUNIT
 
 config KUNIT_DEBUGFS
 	bool "KUnit - Enable /sys/kernel/debug/kunit debugfs representation"
+	depends on DEBUG_FS
 	default y
 	help
 	  Enable debugfs representation for kunit.  Currently this consists
-- 
2.53.0




