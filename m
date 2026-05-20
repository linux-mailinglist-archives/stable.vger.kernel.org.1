Return-Path: <stable+bounces-250489-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHUELbbvDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-250489-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:30:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D0660593D63
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4CA183224B22
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0540A3A4526;
	Wed, 20 May 2026 16:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rj0Mev1H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17036EAB8;
	Wed, 20 May 2026 16:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779295543; cv=none; b=OEiH9LTHwS8TkAqdHSraWKvBuINeMCdFJCEBNY3F9Wmcm3IKS17mgbGnR2Rqt0jaUJcUO6ZOMC6pOLZ+03ccjSd/PT4vlCZNEdCdpJhgQm7reQKXK3ohHSS+1x6dqpoWxQ9srrtiz0JfWay6S0sUm0jnOtrlj3++XKxH4Mlm8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779295543; c=relaxed/simple;
	bh=f5oDWkDl47cNYkSIJmtYDDvlaYbAGQfwdimhXIaXJaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g2bvmhsmROWEUDWUoHPjear9Dn0znZaRAtJwiI0aUrJ7EDpj1du3/HBRh9S/FxAmjNzXQID7bJ0EfKodgLt+LRYGalh8Fmz9nPsnLpahgviLVbtHbaIfZ+JTKNpbWn/oadg5y0COKUQxXBSACe/qYlnGZ5d8S8LH0Unpi4x3Bq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rj0Mev1H; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC8E1F000E9;
	Wed, 20 May 2026 16:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779295542;
	bh=v60S4fv0Zn0qotkaQBHIRUsa8iksAFNRt6k8CvrNv10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rj0Mev1HUQTXfCgEPPSgYyCAkaMHhLQzGHZ4Rfh3vnoS/1rDMwF16I0SshAFWXuCn
	 gchS9QRRCSkPT29fpXNzaCoa2oHFRAcJN6QXcXkpN26yE3/f0e2OEpfIev/2o6N2dg
	 RpLA/5r2Q8pNq2m3p+oDEpFSkkMpv8wpFbp6akq4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matt Evans <mattev@meta.com>,
	Ted Logan <tedlogan@fb.com>,
	David Matlack <dmatlack@google.com>,
	Alex Williamson <alex@shazbot.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 0458/1146] vfio: selftests: Build tests on aarch64
Date: Wed, 20 May 2026 18:11:48 +0200
Message-ID: <20260520162158.561956307@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162148.390695140@linuxfoundation.org>
References: <20260520162148.390695140@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250489-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[shazbot.org:email,meta.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,fb.com:email]
X-Rspamd-Queue-Id: D0660593D63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ted Logan <tedlogan@fb.com>

[ Upstream commit 1347a742a1e1b080e2e8d200312ae45b8d6ac859 ]

Fix vfio selftests on aarch64, allowing native builds on aarch64 hosts.

Reported-by: Matt Evans <mattev@meta.com>
Closes: https://lore.kernel.org/all/e51b4ff2-13c4-47d4-b781-3dcbd740d274@meta.com/
Fixes: a55d4bbbe644 ("vfio: selftests: only build tests on arm64 and x86_64")
Signed-off-by: Ted Logan <tedlogan@fb.com>
Reviewed-by: David Matlack <dmatlack@google.com>
Link: https://lore.kernel.org/r/20260319-vfio-selftests-aarch64-v2-1-bb2621c24dc4@fb.com
Signed-off-by: Alex Williamson <alex@shazbot.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/vfio/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vfio/Makefile b/tools/testing/selftests/vfio/Makefile
index 8e90e409e91d8..0684932d91bfc 100644
--- a/tools/testing/selftests/vfio/Makefile
+++ b/tools/testing/selftests/vfio/Makefile
@@ -1,6 +1,6 @@
 ARCH ?= $(shell uname -m)
 
-ifeq (,$(filter $(ARCH),arm64 x86_64))
+ifeq (,$(filter $(ARCH),aarch64 arm64 x86_64))
 # Do nothing on unsupported architectures
 include ../lib.mk
 else
-- 
2.53.0




