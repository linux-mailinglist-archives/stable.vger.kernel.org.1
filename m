Return-Path: <stable+bounces-230659-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOUlHp6IxmlELgUAu9opvQ
	(envelope-from <stable+bounces-230659-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:39:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0DA5345696
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 14:39:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2AC6A30ED907
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 13:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CEA228CA9;
	Fri, 27 Mar 2026 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nhags/kb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nu6/6gev";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Nhags/kb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nu6/6gev"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD0922097
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 13:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774618539; cv=none; b=FMvXJno9N9rggHiace1wgAyVsQhdOGHxNrObZ8EwummGCaZCVce+y0+1GzGnGhilzcq+JcgvDQ5SQmwYHgufULCDmdEku2musTijyWX51AH6a9j3Qfxmqw1iTN8VoozqnZSuIYll0hw7uuywf+o/2EMg2eU6Pl2lQ2EeCMHHWis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774618539; c=relaxed/simple;
	bh=qZxDXzjA72JiH0zktFLKWyYTENc0Uknnxypgxn0sgrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOP18q2VgYnSI3/+JVTF61EtPHB1/PS3ynL5lZJx56/j3mRDDSuCVcBk+WfXozepuEjhaK2pZ0/3sogsKYIUENN70R2p2vPdaEsMF7JwFw7RN7H6MdTKBXW1PGNtDoyL7qpBm2hwA452jkQ2nq1l67hmbiuqy3Hoif+XLOj5d5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nhags/kb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nu6/6gev; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Nhags/kb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nu6/6gev; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 644A04D341;
	Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evTXBuoInYQBhs0rqrTB5K5chYYO4ou4lsjIR1w6tM8=;
	b=Nhags/kbmnJBnhKRdiOkJYizGM9L1JIMOiEA0tIzLJNcn4bLdvQTDDdSakgw5jX12gIezm
	lDt2dyIiVgvnif4H4Syt7dWdvmbDW0VedXutD/TsOYG3LaLV7nbbq1xh4H5zGFcnpbGa32
	ppuXmircL97n5EVbH4THecQ65KoGbm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774618536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evTXBuoInYQBhs0rqrTB5K5chYYO4ou4lsjIR1w6tM8=;
	b=nu6/6gevjUPoyIqKUqLoOmYmANaH13m7Qm3kArG89laZDV6VnNePtQr3wThKg09a6KVrDd
	2WT1lQFtHPMZUkBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774618536; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evTXBuoInYQBhs0rqrTB5K5chYYO4ou4lsjIR1w6tM8=;
	b=Nhags/kbmnJBnhKRdiOkJYizGM9L1JIMOiEA0tIzLJNcn4bLdvQTDDdSakgw5jX12gIezm
	lDt2dyIiVgvnif4H4Syt7dWdvmbDW0VedXutD/TsOYG3LaLV7nbbq1xh4H5zGFcnpbGa32
	ppuXmircL97n5EVbH4THecQ65KoGbm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774618536;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=evTXBuoInYQBhs0rqrTB5K5chYYO4ou4lsjIR1w6tM8=;
	b=nu6/6gevjUPoyIqKUqLoOmYmANaH13m7Qm3kArG89laZDV6VnNePtQr3wThKg09a6KVrDd
	2WT1lQFtHPMZUkBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1FE744A0B1;
	Fri, 27 Mar 2026 13:35:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6I+VBqiHxmleGgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Mar 2026 13:35:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com,
	airlied@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	stable@vger.kernel.org
Subject: [PATCH v2 01/15] drm/ast: dp501: Fix initialization of SCU2C
Date: Fri, 27 Mar 2026 14:32:53 +0100
Message-ID: <20260327133532.79696-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327133532.79696-1-tzimmermann@suse.de>
References: <20260327133532.79696-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230659-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[6];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: D0DA5345696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Ast's DP501 initialization reads the register SCU2C at offset 0x1202c
and tries to set it to source data from VGA. But writes the update to
offset 0x0, with unknown results. Write the result to SCU instead.

The bug only happens in ast_init_analog(). There's similar code in
ast_init_dvo(), which works correctly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 83c6620bae3f ("drm/ast: initial DP501 support (v0.2)")
Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.16+
---
 drivers/gpu/drm/ast/ast_dp501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_dp501.c b/drivers/gpu/drm/ast/ast_dp501.c
index 9e19d8c17730..677c52c0d99a 100644
--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -436,7 +436,7 @@ static void ast_init_analog(struct ast_device *ast)
 	/* Finally, clear bits [17:16] of SCU2c */
 	data = ast_read32(ast, 0x1202c);
 	data &= 0xfffcffff;
-	ast_write32(ast, 0, data);
+	ast_write32(ast, 0x1202c, data);
 
 	/* Disable DVO */
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x00);
-- 
2.53.0


