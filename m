Return-Path: <stable+bounces-224176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIRQCmr9r2mmdwIAu9opvQ
	(envelope-from <stable+bounces-224176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F90F24A415
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 900583035F6B
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AD3876A7;
	Tue, 10 Mar 2026 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AGclSuCB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8918B38758D;
	Tue, 10 Mar 2026 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773141306; cv=none; b=nsgOOpes5U7UUWx/SlUcLORRsGkxatJfed2FYw8YWiyEmP3z1DFqHDgqha6hksOUiVrUEj2zq1Foz2uJ0gClip4EAwYjUIJxvVPV2aZddfmAox9XWUe3O7vCQn65mnaUTd+GyULykFEmbjOcljOry6EQwDua4hmEl4JGxznRf2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773141306; c=relaxed/simple;
	bh=aHdPSN20W67Q+3u478jZGIKVX9CZJfZX+cE1kVXfDvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NqJKT/0u701OfElRBzVHaNrerFsm0blCGnSe6LB13UIKmKp4KZBS2O/EDWVkx/z8ZhW04JD1/Wjo9+E30r01tJCZu2x7fIY0rHRQ+syFVyEdvv5cn5NQ21xpwZtQZFeiYCZljx1Ask+J6K5/E95wc/C6l3mX+hDBCk5wmIJYC/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AGclSuCB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04BB0C2BC9E;
	Tue, 10 Mar 2026 11:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773141306;
	bh=aHdPSN20W67Q+3u478jZGIKVX9CZJfZX+cE1kVXfDvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AGclSuCBuPvp1lUX3c4NJm6FXM4SLZfFDrC24oHLy8XuU+5DOw2CewubRqmx7daYI
	 MhL5/1h+51ctL8v9u9+1ervkiQIOiyky0f4Mtph8LGmeKMIaKq5VguUZs3+ece3bIf
	 3WfeUhKL+WuJWSdQZghRdPJfJrmfPkNatxGuOhi6n0djzIMM3BazYXIz/P8CDUdARX
	 0MOVXSplCiI6hR1weFXaI6RNLcf4Ia0oqym71iowzprNrBhBz1uB3PB+mGiB0jdOD1
	 WICj+ZPdZV2EMknWwNyF1TvEHkXpebo1vWaENw5eIIpM+jZGjX3zwygv+LQLgFtlK/
	 wDn4I9yBIIAqA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 311/311] Linux 6.19.7-rc1
Date: Tue, 10 Mar 2026 07:05:58 -0400
Message-ID: <2867504d9c53260444ef95c17adeebb724395237.1773140656.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
References: <cover.1773140654.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0F90F24A415
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224176-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index faab511ef38c0..10167f6e68a0f 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 19
-SUBLEVEL = 6
-EXTRAVERSION =
+SUBLEVEL = 7
+EXTRAVERSION = -rc1
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.51.0


