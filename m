Return-Path: <stable+bounces-35692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F60896CA2
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 12:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3661F2CAC4
	for <lists+stable@lfdr.de>; Wed,  3 Apr 2024 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3349A142E97;
	Wed,  3 Apr 2024 10:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gavkjaQ9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nG2z3kQq"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630561411DB
	for <stable@vger.kernel.org>; Wed,  3 Apr 2024 10:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140412; cv=none; b=hMbJIYR8huhqPia6V3uVnMe9UZNL9cocflqKJbk7XjNkPemAm3Mxpkyv49WvUFkzu/+A5o130Qjj/qHBNbetgzSp+xrQLxmnfT/Gztzjg4TM7yDhZZi1edr7Dn+IbumB+sOi6tLKXtBP4BCor4Vdrrnxrjn9ZAkd/NbmGyWHJFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140412; c=relaxed/simple;
	bh=LfkF9sMI6owipGj3Gkug54qtev/0UKR+eAOeSSIOte0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FmcMcDRUuaAjUkFFRnfQrlBqLLLgIQ/L5M0s9JVvfxf7lV1gvO6k6G6gkG524ko/7o0GTJOZFK+zxG62G3UJhfilMbqZr73ykdHtT7rMb72nvX585spZ/CvYWWWlw5zA7ZS5MHCeVbDh3qCjjPM70u0YDDVysmtJ+a/hB93WKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gavkjaQ9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nG2z3kQq; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 97B463521A;
	Wed,  3 Apr 2024 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712140408; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNe/AlEHHelvE+7Q5c0DHO3Yr/CYON4DkO0/HOYjOxo=;
	b=gavkjaQ9D7AsdThXKS5O8YCf4bF4TpiBF9mfwUfatYBMdu9J/runojfaIID4TqSk+J4NWP
	Ij2tGN3oJhGmY3RjSHUrXLkwkSKYJJDT6aEUdc+hQpNuVS7Z1LKWgY2RY4zA3zkgmsy0B6
	XuhKDRvDMvTHUaTIQuJV3fjW6anKpZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712140408;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kNe/AlEHHelvE+7Q5c0DHO3Yr/CYON4DkO0/HOYjOxo=;
	b=nG2z3kQqtv6iyoUyyl3psap0onhxscj6lCvqMZSSE5hcJ9cbxItBVe2vrj/ZYXwQBBGZ+9
	4hKHTRC5oVuyMSBg==
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6263713A8B;
	Wed,  3 Apr 2024 10:33:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id gCjNFngwDWaNEAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 03 Apr 2024 10:33:28 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com,
	jfalempe@redhat.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] drm/ast: Set DDC timeout in milliseconds
Date: Wed,  3 Apr 2024 12:31:28 +0200
Message-ID: <20240403103325.30457-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403103325.30457-1-tzimmermann@suse.de>
References: <20240403103325.30457-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -0.50
X-Spamd-Result: default: False [-0.50 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.20)[71.46%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Compute the i2c timeout in jiffies from a value in milliseconds. The
original values of 2 jiffies equals 2 milliseconds if HZ has been
configured to a value of 1000. This corresponds to 2.2 milliseconds
used by most other DRM drivers. Update ast accordingly.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 312fec1405dd ("drm: Initial KMS driver for AST (ASpeed Technologies) 2000 series (v2)")
Cc: Dave Airlie <airlied@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v3.5+
---
 drivers/gpu/drm/ast/ast_ddc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ast/ast_ddc.c b/drivers/gpu/drm/ast/ast_ddc.c
index b7718084422f3..3e156a6b6831d 100644
--- a/drivers/gpu/drm/ast/ast_ddc.c
+++ b/drivers/gpu/drm/ast/ast_ddc.c
@@ -153,7 +153,7 @@ struct ast_ddc *ast_ddc_create(struct ast_device *ast)
 
 	bit = &ddc->bit;
 	bit->udelay = 20;
-	bit->timeout = 2;
+	bit->timeout = usecs_to_jiffies(2200);
 	bit->data = ddc;
 	bit->setsda = ast_ddc_algo_bit_data_setsda;
 	bit->setscl = ast_ddc_algo_bit_data_setscl;
-- 
2.44.0


