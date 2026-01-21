Return-Path: <stable+bounces-211100-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFi4EWMtcWmcfAAAu9opvQ
	(envelope-from <stable+bounces-211100-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:47:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40B5C7EC
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:47:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 85B0B6B0202
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3704B3D648E;
	Wed, 21 Jan 2026 18:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HZ7DccLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D13B9618;
	Wed, 21 Jan 2026 18:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769020439; cv=none; b=hxcohd6GFQUoEadaV96ug/nf73VbCbfwNTkMTQCNJyY95SX4q4o/iFi7ZciFqA9WQtQky1NKuYvhLKFEirgYETqbYR2wFVF5ADqTjozU5cm0W3Gb/wlrTNrtVBORBIT/iqPScmoRA7+JyNeCc+O8QDDH8vgrxjFiSemc5sxvPNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769020439; c=relaxed/simple;
	bh=lrNbrjL/97OPaADqHnBGgpTBk8iC/WA6/QFf66zPYnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RdubThl8wDwgc2yp0zWd8SCwSKoW6vbhmdz6R4JLMGx8n9JmtK+/CbQV384XY58TxMbmd3MyrWYavRceYG5Pim450SIHdLHM5Iat4JmHyjaq1vu9fXLKFqOM/HeLCsSm2JDkJxA3gAaJrsLVVcXE0hOMrR0CT/5Q2x3ZS3TX5Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HZ7DccLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98DE4C4CEF1;
	Wed, 21 Jan 2026 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769020439;
	bh=lrNbrjL/97OPaADqHnBGgpTBk8iC/WA6/QFf66zPYnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZ7DccLs89aSWRU4FbvMsuTgKVrvhlA1WbfUlHzWjnsHOkaLoZWiFITIp6JNMgZA2
	 MpoaOca0I3oudTiBf9lBY1I0UiYbgv5C24yx9cXHopjBEETpy1t0u5qYDsEuTHE/ot
	 jCS/suz8W2aTODfQ8gX7zFmAq4m4VsFYteDUavc0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6.18 158/198] drm/sysfb: Remove duplicate declarations
Date: Wed, 21 Jan 2026 19:16:26 +0100
Message-ID: <20260121181424.237429961@linuxfoundation.org>
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
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	TAGGED_FROM(0.00)[bounces-211100-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,suse.de:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,msgid.link:url,lists.freedesktop.org:email]
X-Rspamd-Queue-Id: AC40B5C7EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Zimmermann <tzimmermann@suse.de>

commit b91a565ed14fcf900b4d95e86882b4b763860986 upstream.

Commit 6046b49bafff ("drm/sysfb: Share helpers for integer validation")
and commit e8c086880b2b ("drm/sysfb: Share helpers for screen_info
validation") added duplicate function declarations. Remove the latter
ones.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: e8c086880b2b ("drm/sysfb: Share helpers for screen_info validation")
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Javier Martinez Canillas <javierm@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.16+
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
Link: https://patch.msgid.link/20260108145058.56943-7-tzimmermann@suse.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/sysfb/drm_sysfb_helper.h |    9 ---------
 1 file changed, 9 deletions(-)

--- a/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
+++ b/drivers/gpu/drm/sysfb/drm_sysfb_helper.h
@@ -48,15 +48,6 @@ const struct drm_format_info *drm_sysfb_
 #endif
 
 /*
- * Input parsing
- */
-
-int drm_sysfb_get_validated_int(struct drm_device *dev, const char *name,
-				u64 value, u32 max);
-int drm_sysfb_get_validated_int0(struct drm_device *dev, const char *name,
-				 u64 value, u32 max);
-
-/*
  * Display modes
  */
 



