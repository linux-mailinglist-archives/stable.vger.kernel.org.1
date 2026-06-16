Return-Path: <stable+bounces-264197-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vuTKD5NyMWpfjgUAu9opvQ
	(envelope-from <stable+bounces-264197-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F627691935
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:58:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=0KfyHKfG;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-264197-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-264197-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 359973041155
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 15:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9559A44D035;
	Tue, 16 Jun 2026 15:44:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DF6361651;
	Tue, 16 Jun 2026 15:44:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781624642; cv=none; b=bOoS5zY+aFLUFBiAyPyZnlFDzHU8mDuQK91nSSW0v8KqVdzUfJDcTQQzyqTRmEL4uynRTV4EIv8YaJOKztn9IhNxtJGrz7BoVQKl/KYnJ8/eeyNrMkaVx1lAwOBYiqvkTxFzwQ3DofnC6BBsUTJGsMD5tr3OGfSIX51nur2EVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781624642; c=relaxed/simple;
	bh=BwwuXAwDRgqSTyEauyRJs+10iLbDsG+7O6S1ho1GNHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cV4n5Y2T9D+s3k1uT718YuzgY60UFRnaxQIkpK7ZRI6q/ljxk4lv4KQbG2qM8FLJAiuenofZvX/Iq8amPfEgc355lPUYbLYe2mV9owtS+MHHXjAP8pymvwc09GGuUA0zV7F8Tppvetx/TbRqtTTtRCBjA8wdGf1rcyB7FILEbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0KfyHKfG; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD41F000E9;
	Tue, 16 Jun 2026 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781624641;
	bh=iSo5kW0mxBbheIqI4QHY5TACJa4bXaYMRNUNxkbu9gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=0KfyHKfGNsH5BlUMSBYe0qCGg/40mJNOVfePJqRofAvC8AfwZTe0cLdcxKL8Lh0vF
	 UIHU71jLuJTDdVAqjYStu8O0Uzmrc4xDeOdyDUkQzgOp2LNec5QWa8FWTpbHwmGfiK
	 dPBB/HfuVTLMgkRHoFlan5+UwFdXOKKC1lCLvIBQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>
Subject: [PATCH 7.0 340/378] drm/v3d: Wait for pending L2T flush before cleaning caches
Date: Tue, 16 Jun 2026 20:29:31 +0530
Message-ID: <20260616145128.085893582@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145109.744539446@linuxfoundation.org>
References: <20260616145109.744539446@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:mcanal@igalia.com,m:itoral@igalia.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-264197-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,igalia.com:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F627691935

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maíra Canal <mcanal@igalia.com>

commit abf888b03a9805a3bc37948a0df443553b1c0910 upstream.

v3d_clean_caches() starts the cache-clean sequence by writing
V3D_L2TCACTL_TMUWCF to V3D_CTL_L2TCACTL and then polling for that bit to
clear. It does not, however, check for an L2T flush (L2TFLS) that may
still be in flight from a previous operation.

On pre-V3D 7.1 hardware, kicking off the TMU write-combiner flush while an
L2T flush is still pending can clobber bits in L2TCACTL and cause cache
inconsistencies.

Poll for L2TFLS to clear before writing L2TCACTL on V3D < 7.1, ensuring
any pending flush has completed before a new clean is issued.

Cc: stable@vger.kernel.org
Fixes: d223f98f0209 ("drm/v3d: Add support for compute shader dispatch.")
Link: https://patch.msgid.link/20260530-v3d-fix-rpi4-freezes-v1-1-c2c8307da6ce@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/v3d/v3d_gem.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/gpu/drm/v3d/v3d_gem.c
+++ b/drivers/gpu/drm/v3d/v3d_gem.c
@@ -213,6 +213,14 @@ v3d_clean_caches(struct v3d_dev *v3d)
 
 	trace_v3d_cache_clean_begin(dev);
 
+	/* GFXH-1897: Ensure pending flushes complete before writing L2TCACTL */
+	if (v3d->ver < V3D_GEN_71) {
+		if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
+			       V3D_L2TCACTL_L2TFLS), 100)) {
+			drm_err(dev, "Timeout waiting for L2T clean\n");
+		}
+	}
+
 	V3D_CORE_WRITE(core, V3D_CTL_L2TCACTL, V3D_L2TCACTL_TMUWCF);
 	if (wait_for(!(V3D_CORE_READ(core, V3D_CTL_L2TCACTL) &
 		       V3D_L2TCACTL_TMUWCF), 100)) {



