Return-Path: <stable+bounces-211020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAmNCZQwcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-211020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:01:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C25705CBD9
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 21:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C2C815ED423
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10073A1E73;
	Wed, 21 Jan 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nEmQ57OX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DE53A6414;
	Wed, 21 Jan 2026 18:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020169; cv=none; b=TU45fFBW9Mx8A/RJdKFrgf7VVwJuOtUBLzambLMN0sorsXgOIzXzoFr7NTUls7DyJ/3thLZzEb+uHKeXm1u1QSIwbDPQNABaOFN2+jXmnBJpNOarIjOoAbPWf0HHF18j07Dg0qZOeSoFtIiSOnsRVSIKXXvjPeUxXq2u4DGERi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020169; c=relaxed/simple;
	bh=N4zwqpZe/1YSMqs1x83Mm7eSYNBQPHO+pniiZKYIuho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1hvtS4rvDnv4d6aGoljAK/PCri/J/RV2miGFJiWwYqkNu9sCvrLRa4Y/C2/dl8YIcs6UbrGcgst64ILa5idp6qWh2rTT6KkJ1C09uvfhwQ3qHIYux3y/PzuJuzsWKv9KNlnz+2DK1GIYnP+X/JJ+oyfG31a4riZr/gHmlwkfbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nEmQ57OX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A96D6C4CEF1;
	Wed, 21 Jan 2026 18:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020169;
	bh=N4zwqpZe/1YSMqs1x83Mm7eSYNBQPHO+pniiZKYIuho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEmQ57OXWX5w6UZElZmYecXz8wl2IX9NqxWYvZMB+kw0oS/P8YA7PpFXwaOszh4Q6
	 LO6DjwjDPG9R42dNN7FIlF54s4Nt0iBvyrsrqKvq3YQ0mI1I4dfvXFWCCkfUIj8L3X
	 Fcw0br6cXW7xGGcQKEo5psyq9iC1KxPmlywF6S5Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tingmao Wang <m@maowtm.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 080/198] landlock: Fix wrong type usage
Date: Wed, 21 Jan 2026 19:15:08 +0100
Message-ID: <20260121181421.439449178@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181418.537774329@linuxfoundation.org>
References: <20260121181418.537774329@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211020-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,digikod.net:email,maowtm.org:email]
X-Rspamd-Queue-Id: C25705CBD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tingmao Wang <m@maowtm.org>

[ Upstream commit 29fbfa46e4287c596bdc77e2c599e3a1bbf8bb67 ]

I think, based on my best understanding, that this type is likely a typo
(even though in the end both are u16)

Signed-off-by: Tingmao Wang <m@maowtm.org>
Fixes: 2fc80c69df82 ("landlock: Log file-related denials")
Reviewed-by: Günther Noack <gnoack@google.com>
Link: https://lore.kernel.org/r/7339ad7b47f998affd84ca629a334a71f913616d.1765040503.git.m@maowtm.org
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/landlock/audit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/landlock/audit.c b/security/landlock/audit.c
index c52d079cdb77b..e899995f1fd59 100644
--- a/security/landlock/audit.c
+++ b/security/landlock/audit.c
@@ -191,7 +191,7 @@ static size_t get_denied_layer(const struct landlock_ruleset *const domain,
 	long youngest_layer = -1;
 
 	for_each_set_bit(access_bit, &access_req, layer_masks_size) {
-		const access_mask_t mask = (*layer_masks)[access_bit];
+		const layer_mask_t mask = (*layer_masks)[access_bit];
 		long layer;
 
 		if (!mask)
-- 
2.51.0




