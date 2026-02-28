Return-Path: <stable+bounces-220199-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BLFDK4wo2kE+QQAu9opvQ
	(envelope-from <stable+bounces-220199-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1311C5940
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33EA8316278E
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 17:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBEE4508F8;
	Sat, 28 Feb 2026 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0s13dw6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5F04CA296;
	Sat, 28 Feb 2026 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300105; cv=none; b=fYSiEn9lA9hlmraCeoji1uNEjHF+5QfiWLGGYkvKEw41lisQhqQkyT/NJDRiMF7WFwZBtRUVnMPBEcimjiCEYvs6RLplzlxrc1n6rlpbw1UDG+k4sTV4lp+nDvJVCqNIgyB8cW05OzwUR6Y/ZB+QPK69nkRVydvMaQIU8Ruz0Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300105; c=relaxed/simple;
	bh=GiSdY7QWPuOmRrO/Wej4YIsbBGCxiqtbm54OJsH3IzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOCY0bZ+aRsR5rtZXMDWhFNU91zhEDstTbAdevF4CixiVBDHp46jWdCG7H3nYTk+wXpdiDDN+RrVEff2VoJaw4yJPm05nc2lFn7nOs1rR/LScmvy0ajALMqXaMwsMd9WXSUsNN7C2Y0yNFvzZgWxwfgzpQFlbVhecG7k4+n4hgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0s13dw6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD23DC19423;
	Sat, 28 Feb 2026 17:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300105;
	bh=GiSdY7QWPuOmRrO/Wej4YIsbBGCxiqtbm54OJsH3IzQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s0s13dw6LihjVPsSX1fMw7E10Puax+PKU5yLHHPSUYVhCwWj385AabM80Z1XJlq86
	 8ONc/ejjZUKWufbWs8TGNsSr0wcyrfYz8IkG6uo8UnvpOQUG42gP2JaDtj5Q7ETqXe
	 GoW9p/dWW61K78mAscNYW0L6TJBUGLp3akE9y/4isiJEylYyu+SNKP5uD4xF01kVGt
	 OX9Z7Dgji2l2d3gaFnGilh791l1HBUYCWNqu5jUis9x4sWDA5qpCI/oOQDQIeGu+3r
	 PVqR2eFkFtiWWxVwGd4t8L+Uo8w6wu/gpORuAgsG2uvBYkmt55ZnuD9RlZhlEb+a5m
	 WixSDJf2BOHsg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 121/844] parisc: Prevent interrupts during reboot
Date: Sat, 28 Feb 2026 12:20:34 -0500
Message-ID: <20260228173244.1509663-122-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmx.de,kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220199-lists,stable=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: CC1311C5940
X-Rspamd-Action: no action

From: Helge Deller <deller@gmx.de>

[ Upstream commit 35ac5a728c878594f2ea6c43b57652a16be3c968 ]

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/parisc/kernel/process.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
index e64ab5d2a40d6..703644e5bfc4a 100644
--- a/arch/parisc/kernel/process.c
+++ b/arch/parisc/kernel/process.c
@@ -85,6 +85,9 @@ void machine_restart(char *cmd)
 #endif
 	/* set up a new led state on systems shipped with a LED State panel */
 	pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
+
+	/* prevent interrupts during reboot */
+	set_eiem(0);
 	
 	/* "Normal" system reset */
 	pdc_do_reset();
-- 
2.51.0


