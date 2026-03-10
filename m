Return-Path: <stable+bounces-224493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LQZBjgDsGnOeQIAu9opvQ
	(envelope-from <stable+bounces-224493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 093AD24B483
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 12:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5E6930638C2
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 11:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F044E038;
	Tue, 10 Mar 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIPdWzXg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F9C41C307;
	Tue, 10 Mar 2026 11:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773142224; cv=none; b=JPlzF+Dx9X88Fi8qmNd6cH+VAVVouhZ9RUK/lYi0IodLVMop1huil8kK/QQPBQFCDDUKXv9q+j/rQ9PyTMcXhdfKv9Nlovm/xs2rv+MnFt7B4zfBgnJrFrRNecWtGXhiUHkx3jsVgJfezOas5nBd7dmUtYbYJ4ma9PKiHVT4hfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773142224; c=relaxed/simple;
	bh=kznOSeB2M2LYqECj+f8jbs/4Y98WrvJVnIRq3fEwcFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ChJvDjjxqZfMALH2KqDE+aiS7dXiZz15OFzbWLGaBdeCny+a3Ie7Xj/OtKWK/53RpSoyzTnjlNoVcNXmTOQqY9ecap3iwEfObPbzLlGOfUBFx3c4hplw3Y+TxQzUW1ZlCniWW6qcRNj4OUiB95P/qUH+0JmFfUZ8D/Qua02GFk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIPdWzXg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEFBBC19423;
	Tue, 10 Mar 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773142224;
	bh=kznOSeB2M2LYqECj+f8jbs/4Y98WrvJVnIRq3fEwcFM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIPdWzXgENTI+dY4WNTOlBXwuTh1ULp7dJkoSZIAbjjcMh6MJRC8pVvFQ4IoFLHAg
	 BzIFRwSF7XNUW1n8NTQcsTniyyhuHOgXtLtoDCV1G8QWGI/+4xAt5+cZxCVfGJRsc2
	 A/D4mdtBfRdFNc1G3TXZC0e4VQhynGPVm+Tpgn2CMBPkN/Xv0q9dSrg8OkCZp5m1hR
	 jHSplVBb+uHihafJyI2BqEmf5zLjVzDIsLbrQdjvs5zly599Vbf3bsBBJid/yFfTa7
	 mle3PiaXIGrol6MYfVQCm3Oe6rhofywLuhmzEpO+PIYHgLfkZT+gTbQ4fo4MFEEFpe
	 Ygj3H8lGSxdPA==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 314/314] Linux 6.18.17-rc1
Date: Tue, 10 Mar 2026 07:19:33 -0400
Message-ID: <c86e53b5f7797099e5c89a0c3f43de859d8ec1ec.1773141556.git.sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1773141554.git.sashal@kernel.org>
References: <cover.1773141554.git.sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 093AD24B483
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
	TAGGED_FROM(0.00)[bounces-224493-lists,stable=lfdr.de];
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
index 35c1fcb095717..45fde0552cd9d 100644
--- a/Makefile
+++ b/Makefile
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 18
-SUBLEVEL = 16
-EXTRAVERSION =
+SUBLEVEL = 17
+EXTRAVERSION = -rc1
 NAME = Baby Opossum Posse
 
 # *DOCUMENTATION*
-- 
2.51.0


