Return-Path: <stable+bounces-263909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4ft3ML1qMWpKiwUAu9opvQ
	(envelope-from <stable+bounces-263909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B987690FF8
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:24:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="Dfq/8U/4";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263909-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263909-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BB5D30AAD86
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB8643DA53;
	Tue, 16 Jun 2026 15:18:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808AE43DA56;
	Tue, 16 Jun 2026 15:18:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781623115; cv=none; b=VMfDHaJpWQhN2q7YPLmXprxUwCwUs3cr0xzbuKFL+BA9GsU3U5guad4o4d3YfaPZ7JVmHEG1p0EOHkK4c4Uhzh9Soo7fCxltXrK+pT6krT8iCoX01n9WHdvXv9xR2zegWhOP5DUVJQXk8j1ONSQvSP9FYuIjjtB04HYDZ+Y8P/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781623115; c=relaxed/simple;
	bh=wbDWxTjOgaNm5M8u8MoZx4uYN0XnULNE5BI0hAX9C9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ld1+fK01Gp3dNFJb08l+sgc/1Jx4pe1cdFFbLDKZ0F3ayZ630hhOkZgZ3Cd4wGLT0TcHSdVzKcsDls1kyujO5Q8JaHSnVQ/qlJgUEdJao6NSBlbFhvwvrwkAukocQl36exye9MTr2jBronaRJC6409WDpc9G4sVGSnxaUFHqMR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Dfq/8U/4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EBED1F000E9;
	Tue, 16 Jun 2026 15:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781623114;
	bh=wL1ahz19fmHj7hppao81D7CbmQsF9vp4KvVUNSydXJU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dfq/8U/4noemXjWJRRTK4tAhIghgb8EfGoLrnx11B1psBp4a+lnJ6xvPeH794WdLH
	 FAtG2OrdW3mxe9mIQF5UO295/Hx5twNxuN39vZmqo4JauY+a7HXQxRK4HhSJsVIyJ1
	 T0UnshOQ4DozgWsA6zyzblE1I2dmNx6yjysyZFTo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	unknownbbqrx <dev@unknownbbqr.xyz>,
	Gabriele Monaco <gmonaco@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 090/378] tools/rv: Ensure monitor name and desc are NUL-terminated
Date: Tue, 16 Jun 2026 20:25:21 +0530
Message-ID: <20260616145115.003665186@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dev@unknownbbqr.xyz,m:gmonaco@redhat.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B987690FF8

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 08904765bb941f98306ae6841c33cfd299343faf ]

ikm_fill_monitor_definition() copies monitor name and description with
strncpy(), but does not guarantee NUL termination when source strings are
equal to or longer than the destination buffers.

Clamp copies to sizeof(dst) - 1 and explicitly append '\0' for both fields
to keep them safe for later string operations.

Suggested-by: unknownbbqrx <dev@unknownbbqr.xyz>
Fixes: 6d60f89691fc9 ("tools/rv: Add in-kernel monitor interface")
Link: https://lore.kernel.org/r/20260604120946.90302-2-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/rv/src/in_kernel.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/rv/src/in_kernel.c
index 4bb746ea6e1735..d324538249d3ab 100644
--- a/tools/verification/rv/src/in_kernel.c
+++ b/tools/verification/rv/src/in_kernel.c
@@ -215,10 +215,11 @@ static int ikm_fill_monitor_definition(char *name, struct monitor *ikm, char *co
 		return -1;
 	}
 
-	strncpy(ikm->name, nested_name, MAX_DA_NAME_LEN);
+	strncpy(ikm->name, nested_name, sizeof(ikm->name) - 1);
+	ikm->name[sizeof(ikm->name) - 1] = '\0';
 	ikm->enabled = enabled;
-	strncpy(ikm->desc, desc, MAX_DESCRIPTION);
-
+	strncpy(ikm->desc, desc, sizeof(ikm->desc) - 1);
+	ikm->desc[sizeof(ikm->desc) - 1] = '\0';
 	free(desc);
 
 	return 0;
-- 
2.53.0




