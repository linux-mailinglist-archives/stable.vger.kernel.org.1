Return-Path: <stable+bounces-267056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t4beCAGwM2pGFAYAu9opvQ
	(envelope-from <stable+bounces-267056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:44:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B20BD69E8C8
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 10:44:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=suse.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267056-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-267056-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80E643029713
	for <lists+stable@lfdr.de>; Thu, 18 Jun 2026 08:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DF03B3C1B;
	Thu, 18 Jun 2026 08:43:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4453B38AA
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 08:43:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772221; cv=none; b=L940b22gIC8nsci6uM0k+SA7jDnCKP52adnpHQCU8qOTnlwDjBjnWdw+KXMDziwH2Dsy+2VPYOulz9A7y2BhGgwAhrgc+MdImk4K+hn0UQqUwVkjVGQMwlSxPenIuOHcFNGUDViMMXCqg52tUawHnhAqF3zxmxuP/WXYcghh2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772221; c=relaxed/simple;
	bh=XU5HMB7igl97Og5kJ75ZgLq/RBPY6Y0kM+1wcDngq0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgBhC36bOQSmBGWCohMvyT7LpfCflLuyLJheGGovN0hUE6hUVvl+lp/5Ywb7gyCxwnhBLELyGd7jI12yApUROmzTXQIGDGWTBpbU+wj/HgfooS+mCVRl2CwuACjbmFmI0cbFb/N9UD2jBe+sbtss+Fv1LrBcZj2abcrXmogLHa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id D12F16D221;
	Thu, 18 Jun 2026 08:43:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AB63779A8;
	Thu, 18 Jun 2026 08:43:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SN2lILWvM2pAPwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 08:43:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] drm/sysfb: Avoid truncating maximum stride
Date: Thu, 18 Jun 2026 10:42:00 +0200
Message-ID: <20260618084327.46567-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260618084327.46567-1-tzimmermann@suse.de>
References: <20260618084327.46567-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[suse.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:javierm@redhat.com,m:maarten.lankhorst@linux.intel.com,m:mripard@kernel.org,m:airlied@gmail.com,m:simona@ffwll.ch,m:dri-devel@lists.freedesktop.org,m:sashiko-reviews@lists.linux.dev,m:tzimmermann@suse.de,m:sashiko-bot@kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-267056-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
	FORGED_SENDER(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[tzimmermann@suse.de,stable@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp,suse.de:email,suse.de:mid,suse.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B20BD69E8C8

Passing a maximum as 64-bit type to drm_sysfb_get_validated_int0()
can truncate the value to 32 bits. Use drm_sysfb_get_validated_size0(),
which uses 64-bit arithmetics. Then test the returned stride against
the limits of int to avoid truncations in the returned value. A valid
stride is in the range of [1, INT_MAX] inclusive.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/dri-devel/20260617114016.5A5991F000E9@smtp.kernel.org/
Fixes: 32ae90c66fb6 ("drm/sysfb: Add efidrm for EFI displays")
Fixes: a84eb6abe2b6 ("drm/sysfb: Add vesadrm for VESA displays")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
---
I've added Reported-by and Closes tags because this is a pre-existing issue.
---
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
index 042d1b796696..1c479ce0e503 100644
--- a/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c
@@ -57,11 +57,17 @@ int drm_sysfb_get_stride_si(struct drm_device *dev, const struct screen_info *si
 			    unsigned int width, unsigned int height, u64 size)
 {
 	u64 lfb_linelength = si->lfb_linelength;
+	s64 stride;
 
 	if (!lfb_linelength)
 		lfb_linelength = drm_format_info_min_pitch(format, 0, width);
 
-	return drm_sysfb_get_validated_int0(dev, "stride", lfb_linelength, div64_u64(size, height));
+	stride = drm_sysfb_get_validated_size0(dev, "stride", lfb_linelength,
+					       div64_u64(size, height));
+	if (stride < INT_MIN || stride > INT_MAX)
+		return -EINVAL;
+
+	return (int)stride; /* stride or negative errno code */
 }
 EXPORT_SYMBOL(drm_sysfb_get_stride_si);
 
-- 
2.54.0


