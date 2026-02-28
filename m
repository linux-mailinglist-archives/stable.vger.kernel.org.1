Return-Path: <stable+bounces-220891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOSOLCtIo2l//AQAu9opvQ
	(envelope-from <stable+bounces-220891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD491C78BD
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 20:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3399D30D34F3
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A332C424E4B;
	Sat, 28 Feb 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df1LMhA9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662B4424E41;
	Sat, 28 Feb 2026 17:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300781; cv=none; b=bMW+ViT/DkuP/LXs6Czqe7bvCM7jojecc0Cd/kSdaTZuNFDzIHqQ2xc0sB0I3glgYil9fD9Z33f57oqkb9gM++JPHDSf9L2Dyj01gcSRCJsHjzVHXQ1odVqdGw3YpyphrmNhajWB85w8kgyxxI8Wg60zYKh5bOeFuk1kOyON6qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300781; c=relaxed/simple;
	bh=RzykjqbxI860RyMl76kUWU06jUsyYYPYyBd7OBFoEjU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OiP318rqkhv+Ai+l/oIPJkvszFpgcfVUadR/QJL/r4tjQgBzAFK8OxdSaDJirx31TbBKvgRXTBj9fqRNKMoTf8V9Y7bw3UELdLuK+UOjP8F4bXrqSG76U46r59W5Jb0dGHQXgnQLwEY5ZjwD9+1ddkDK4NdYCV1BRj1jqASFRHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df1LMhA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECE1C19423;
	Sat, 28 Feb 2026 17:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300781;
	bh=RzykjqbxI860RyMl76kUWU06jUsyYYPYyBd7OBFoEjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=df1LMhA9lge7qC64QJ3mJSuEQfHOQ9jITxBdNMxYV+2cheM+Tm7Mvp3cufdj4h1vE
	 QEEXadFFfwvIC+Zc5IHHo8Le9mD2zmHfWZHpA/DthT8H5rK6Hv0DUpEfpOF6IVpIoF
	 n7qcoSGxQWrMN6THxuS76L6y8yuaFiiBw8B9e2SXH8mSIIk1wg/93PLD+IyvQiF4ya
	 xTa999JIqtuKaeru9cZZ/3jUD/SUHXjPal1wW79PRI2r2lq7T97UDa7IoHoOUfiJpT
	 1wQVCJBQG1A7bdUP3yULB5VgFICKEjdzTq5kbQnWCB0zi8kXyW4NNHggcP1+fZ9Qa0
	 q3sY7ZT3FMwGw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 812/844] fbcon: Remove struct fbcon_display.inverse
Date: Sat, 28 Feb 2026 12:32:05 -0500
Message-ID: <20260228173244.1509663-813-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmx.de,kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220891-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,gmx.de:email,suse.de:email]
X-Rspamd-Queue-Id: 4CD491C78BD
X-Rspamd-Action: no action

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 30baedeeeab524172abc0b58cb101e8df86b5be8 ]

The field inverse in struct fbcon_display is unused. Remove it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 44ea4ae4bba0d..9cabafd2d91ca 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -30,7 +30,6 @@ struct fbcon_display {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
 #endif
-    u_short inverse;                /* != 0 text black on white as default */
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;
-- 
2.51.0


