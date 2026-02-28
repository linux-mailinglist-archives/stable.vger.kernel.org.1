Return-Path: <stable+bounces-220114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C+oH9Apo2kr+AQAu9opvQ
	(envelope-from <stable+bounces-220114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D45D71C5142
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:45:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AB9E300BC9E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FACB47ECF1;
	Sat, 28 Feb 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBUOH1uu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6EF47ECE8;
	Sat, 28 Feb 2026 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300025; cv=none; b=guQ+5xGvn8n8TvLfYbNO5RKyQzwxTRc4xc4GY7SGRv+1i8+7G5JKdJ8+QUa7fJEh/uMEDjDMhUYjWFrKeSe7vsvfl05VHB/iwYnsqTMJrEY7ezlRkAOUtPaqqnzWWU6EoaCqgjruO28SncNbu0sil3exTYs1WiGqOYHfBlIoUgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300025; c=relaxed/simple;
	bh=EY/BGeOOCFFP9d7pnNT8svYATTIHoqhTE4sX02nGVNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oyu4PnxBROBLP6MmGFFV9MBhJ2KkSllPEU7KY9QOqKjcVQhLasCnl1GUk9aJgBBsmy2JPQllUqHRfm78wroZ+IX8cRKHR2YQF2Mi9D4Blgq/Za3crTqGuw6UTT8QmiGI9GS6V6KHAm7TSRfNwI9yBCc/xNugeOoAkXZRALrRQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBUOH1uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CBDC116D0;
	Sat, 28 Feb 2026 17:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300025;
	bh=EY/BGeOOCFFP9d7pnNT8svYATTIHoqhTE4sX02nGVNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GBUOH1uuu+sPK48Wl9xyQZeNy2ZZNi0ImLz/6KZsavTrqMvDqpoBDjx8yzhLKVLl5
	 rhRea2BzEmFIwxA1zGeJ7ekntL7LVGueAuLvsIp+85g5TVMjbL6Vl9iumhKGMF9t9h
	 SkqVb/lJpTKqVibWfm2hjjpNdfuiKtO2zjjmtFGrsydpu8LAqdU9xN3pjHJ5zMuyKN
	 uvI/MYSehn65TiJvxbeQxbiIQxbBbPdPZeLmEny8kXsMB+r1pOdiUq8iddPAMOWCXn
	 8z0wcjN1gcuKYjhzE3QSgEtMhdfVgPP7sQN2t9EpCewB5kll9ttIhR0dzdiSvyZ60U
	 2QY08bPOIs8UA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jeffrey Bencteux <jeff@bencteux.fr>,
	Paul Moore <paul@paul-moore.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 036/844] audit: add fchmodat2() to change attributes class
Date: Sat, 28 Feb 2026 12:19:09 -0500
Message-ID: <20260228173244.1509663-37-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220114-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bencteux.fr:email,paul-moore.com:email]
X-Rspamd-Queue-Id: D45D71C5142
X-Rspamd-Action: no action

From: Jeffrey Bencteux <jeff@bencteux.fr>

[ Upstream commit 4f493a6079b588cf1f04ce5ed6cdad45ab0d53dc ]

fchmodat2(), introduced in version 6.6 is currently not in the change
attribute class of audit. Calling fchmodat2() to change a file
attribute in the same fashion than chmod() or fchmodat() will bypass
audit rules such as:

-w /tmp/test -p rwa -k test_rwa

The current patch adds fchmodat2() to the change attributes class.

Signed-off-by: Jeffrey Bencteux <jeff@bencteux.fr>
Signed-off-by: Paul Moore <paul@paul-moore.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/asm-generic/audit_change_attr.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/asm-generic/audit_change_attr.h b/include/asm-generic/audit_change_attr.h
index cc840537885fb..ddd90bbe40dfc 100644
--- a/include/asm-generic/audit_change_attr.h
+++ b/include/asm-generic/audit_change_attr.h
@@ -26,6 +26,9 @@ __NR_fremovexattr,
 __NR_fchownat,
 __NR_fchmodat,
 #endif
+#ifdef __NR_fchmodat2
+__NR_fchmodat2,
+#endif
 #ifdef __NR_chown32
 __NR_chown32,
 __NR_fchown32,
-- 
2.51.0


