Return-Path: <stable+bounces-220923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJQvMhZHo2lM/AQAu9opvQ
	(envelope-from <stable+bounces-220923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:50:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 741DE1C76AC
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61016343020B
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE48D42F547;
	Sat, 28 Feb 2026 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQgw0Yyf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB624A13B0;
	Sat, 28 Feb 2026 17:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300811; cv=none; b=YOhpOq67JbxjCBN11ugnTtgU13u16TJ1v6Ia0aRo7KBI6c8aT2bFWyQoeFyHLqrfacD3KD0MTfzwQuZ6Dvljbqt4jgc1MA6/Gf+ZWK7kj7Z93Baj1/3WGMr+H9U2UzpbnOD/0WRvXgRuwVwPsYdJi3jOq4tLopbbVLGnvf6FoCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300811; c=relaxed/simple;
	bh=SPe0+iqz6muqsA+aUVSzBHkbxKZYx7UYCVsomXMyUXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fm6nwXRqLeOBKCJRqSW30AFAfoa1O/rsJ7UqN9bbgGj1SMqzwOlcm8QDaDy2qxr9el/1CdoKOxgS4/++IPDYij9QUr3h0cVPfiVxq+pEFnUCnVPEH2E1DiBVCAj6qsKGWbE7Uej5q1u/w2qECzuBxL4zt4jIPl6NpbjclkZR8ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQgw0Yyf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15022C2BCB2;
	Sat, 28 Feb 2026 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300811;
	bh=SPe0+iqz6muqsA+aUVSzBHkbxKZYx7UYCVsomXMyUXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cQgw0YyfzHDfQCMP4mZjfFCGnfRJIhF8ogevrijt/ATYEEoUpWC5iQotKKJ1YBHEq
	 SPrAQHH6ItkLzMqx8840SJjdG0+VDXhWlvluwlYcKnb7QERMo595sGMxkzjLgx7A5c
	 uYeVhzjbD2jloDIImOG12j5YkB8jGbBgElfS0eYPc9FzoWt9wbmYOJ9emfRdRnJnYk
	 bBR7L0T8T7mo43tLRrJjM2W+sBSd1MIu/Lenfkn3+LjykoUD1Vw/SHBq9kWR1P1AFI
	 Xo6BxcFptPeRexpIR+q764yixd4dZjq8zsE0upSSHDmm/jIi5jhWTlWKTMYqSZmrZX
	 E4aybeGELTBbQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 844/844] Linux 6.19.6-rc1
Date: Sat, 28 Feb 2026 12:32:37 -0500
Message-ID: <20260228173244.1509663-845-sashal@kernel.org>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220923-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 741DE1C76AC
X-Rspamd-Action: no action

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index f486050e0bee4..4a101ca9a0456 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 19
-SUBLEVEL = 5
-EXTRAVERSION =
+SUBLEVEL = 6
+EXTRAVERSION = -rc1
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.51.0


