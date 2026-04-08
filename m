Return-Path: <stable+bounces-235151-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPK+KvCq1mmOHAgAu9opvQ
	(envelope-from <stable+bounces-235151-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF063C2DA4
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F70B308EB92
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B8B3176E4;
	Wed,  8 Apr 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XQVi+Bfg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895B52F39C2;
	Wed,  8 Apr 2026 18:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674700; cv=none; b=umkTdcc2zhJoxjrq3jElHpvGh2pPgK6soHHtW0zN5oochyTFXgjI7NAXogLmknu0eRRFpbXgYBqOqh+NjWYqvRRWgXtOpSwFhu7Jys4ad7Kj1L+ITfylniXfRCdpAEVZwwTNLED3xbQmlMX4KeBJ8urVYYjViwJNnYuiwRDE61Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674700; c=relaxed/simple;
	bh=NbKe9qMxcDLqWnsg97Aa0OkjRit3g/AcVgBNWn12pI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p74SuO7HezL67CaplIQZBSDM4zK2Ljf5DjifXaGB2GBuBcbA0rGE2fIIq616G3EI1+/GFHkDu1Fd15cnJR5SvC2nTmlvR1h7hkVUyhyWAXGBPLXBBSx6ZM7wT7cwTM5sMTvfEgZgCWJCFHq8Pe2wdd1IHQ0FrZr8M2xAU2cp6Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XQVi+Bfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F338C19421;
	Wed,  8 Apr 2026 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674700;
	bh=NbKe9qMxcDLqWnsg97Aa0OkjRit3g/AcVgBNWn12pI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XQVi+BfgcgjWkKCMpyiGxnLytdPorVREeu431jGORhNnZFLGKcieOtXcaZXdUXm40
	 6KmkWF6ygwpWGmnUMsPBa9JmnAabRMzFMVGP8h0a82p1SO/qfc6RNGEG30PDE7qZWR
	 9T96C3zkwq1XLOQDIklgAMCxzBrZBjymPVDvUU8A=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.19 199/311] drm/ast: dp501: Fix initialization of SCU2C
Date: Wed,  8 Apr 2026 20:03:19 +0200
Message-ID: <20260408175946.841873252@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175939.393281918@linuxfoundation.org>
References: <20260408175939.393281918@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235151-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,lists.freedesktop.org:email,suse.de:email,msgid.link:url]
X-Rspamd-Queue-Id: EAF063C2DA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit 2f42c1a6161646cbd29b443459fd635d29eda634 upstream.

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
Link: https://patch.msgid.link/20260327133532.79696-2-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/ast/ast_dp501.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/ast/ast_dp501.c
+++ b/drivers/gpu/drm/ast/ast_dp501.c
@@ -436,7 +436,7 @@ static void ast_init_analog(struct ast_d
 	/* Finally, clear bits [17:16] of SCU2c */
 	data = ast_read32(ast, 0x1202c);
 	data &= 0xfffcffff;
-	ast_write32(ast, 0, data);
+	ast_write32(ast, 0x1202c, data);
 
 	/* Disable DVO */
 	ast_set_index_reg_mask(ast, AST_IO_VGACRI, 0xa3, 0xcf, 0x00);



