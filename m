Return-Path: <stable+bounces-248439-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEEOKalOB2rBxgIAu9opvQ
	(envelope-from <stable+bounces-248439-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:49:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B3D553FB3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77F30330B551
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762B2798F3;
	Fri, 15 May 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y64t86wg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D4B3C4B72;
	Fri, 15 May 2026 16:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861735; cv=none; b=uTlBeyeHUskP409BmawOeMaHVYNWvV/rW8hD+Sw+VgUYf4qnm0CIoyiQfUqczESbPM5BWBI4Hi7jCefJEB7mZLSQ313FQJZ7DT1XSaRu9IFt5Ava7VIdYaGGn9ybvyy59PWFv0Ilt7GwFPIZH/RdrJwNUHmsDBUFp9LsJjXb4y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861735; c=relaxed/simple;
	bh=yVEkMIKjDKVJxU6XRLYMAUxlcB0kUyELftCRD4YAHxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ObtWCSn2kp9ntSp8HE++sdbqA2HNnZ5lL3LLLj6q3fedmAIHYho9gIgi/+nPsM9CmcKWhMxbBxJTyE/MhQaVN4lwBLj+C9WVErZzBxqrKkPDXAXYleB1w3cnygdrlwt4iIq6Xhj3Wwou3NsNnSazMuO9E1kNCMsW1dco+Bmhca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y64t86wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68B1C2BCB0;
	Fri, 15 May 2026 16:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861735;
	bh=yVEkMIKjDKVJxU6XRLYMAUxlcB0kUyELftCRD4YAHxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y64t86wgP0d/7FHlefMkA/8YvibuKc55Vvr3yHs60NGAn1WYAuJVabejBAtWq9rHG
	 Vo2X6gvnjPMoyNh6ZXwM8e/scc+FCPkeOaCiH2vrSMXMZJ6/txK43QDL1NzDh9RUyr
	 S6Y5zSDhi2nwTte19PNvXvub4PZieOMxtkLalYcs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 443/474] fbcon: Avoid OOB font access if console rotation fails
Date: Fri, 15 May 2026 17:49:12 +0200
Message-ID: <20260515154724.672461274@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 24B3D553FB3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-248439-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,suse.de,gmx.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,gmx.de:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit e4ef723d8975a2694cc90733a6b888a5e2841842 ]

Clear the font buffer if the reallocation during console rotation fails
in fbcon_rotate_font(). The putcs implementations for the rotated buffer
will return early in this case. See [1] for an example.

Currently, fbcon_rotate_font() keeps the old buffer, which is too small
for the rotated font. Printing to the rotated console with a high-enough
character code will overflow the font buffer.

v2:
- fix typos in commit message

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org # v2.6.15+
Link: https://elixir.bootlin.com/linux/v6.19/source/drivers/video/fbdev/core/fbcon_ccw.c#L144 # [1]
Signed-off-by: Helge Deller <deller@gmx.de>
[ renamed `par` to `ops` to match the 6.12 local pointer name ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/fbcon_rotate.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -46,6 +46,10 @@ static int fbcon_rotate_font(struct fb_i
 		info->fbops->fb_sync(info);
 
 	if (ops->fd_size < d_cellsize * len) {
+		kfree(ops->fontbuffer);
+		ops->fontbuffer = NULL;
+		ops->fd_size = 0;
+
 		dst = kmalloc_array(len, d_cellsize, GFP_KERNEL);
 
 		if (dst == NULL) {
@@ -54,7 +58,6 @@ static int fbcon_rotate_font(struct fb_i
 		}
 
 		ops->fd_size = d_cellsize * len;
-		kfree(ops->fontbuffer);
 		ops->fontbuffer = dst;
 	}
 



