Return-Path: <stable+bounces-226361-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDiXKNeJuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226361-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:05:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F15802AEE80
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1DAA5307090D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1D3F54B4;
	Tue, 17 Mar 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SvL8Q2vr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772BC3EDADB;
	Tue, 17 Mar 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766360; cv=none; b=FmNZX8dAzwyTJ6hE87/1PJN0AkYg7KxcSRGeqcEk9KjNPn5M4MfHIdHsp9KG0KNHMdenTC1hhcoyMEwIfjBRzGXmwL41w22jc25x6wgmhuxITVfHOtjmp7pW76j8oWaIxceobllRXht8duYLECvTQ0JdE6qojP9qte4aNu+lJI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766360; c=relaxed/simple;
	bh=iu1/M1rOdOgLChHMnS51hoKQoMVWGmCd4oZoR8qkTig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XujMqcZ9jW1aRO7QJzXYkVBJjK9mh0lNl7Eq+LFPT+dghEAD2DlLk5pTkrqRB5vRB2uuNbxj1Zix6buIYxoVSIwYIO3dUdVxgihHTDhh8wAF0bz72tkNVow0DX4ZWRsXgNzCNSIuBm5jo7y39QnUQu2Vkqzfe8GBisQzYe/ni70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SvL8Q2vr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADA1C4CEF7;
	Tue, 17 Mar 2026 16:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766360;
	bh=iu1/M1rOdOgLChHMnS51hoKQoMVWGmCd4oZoR8qkTig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SvL8Q2vrx3A1f8nWqsHeUWE5/+lstU5IJW2GlLYMjIG8XT+qHWV9YXhf4CJZssBfH
	 zqN27ZaYbXV1gi5morjbAJSoFpba+FxinpDhfnxR6T4LZdSLB1Yx0/iluTmwLQRhsk
	 WCC8xtOeINeSQxsdfpWrDs8M2fPdMSSr6m3OcIEw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Animesh Manna <animesh.manna@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.19 227/378] drm/i915/alpm: ALPM disable fixes
Date: Tue, 17 Mar 2026 17:33:04 +0100
Message-ID: <20260317163015.360641006@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226361-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,gitlab.freedesktop.org:url,intel.com:email]
X-Rspamd-Queue-Id: F15802AEE80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jouni Högander <jouni.hogander@intel.com>

commit eb4a7139e97374f42b7242cc754e77f1623fbcd5 upstream.

PORT_ALPM_CTL is supposed to be written only before link training. Remove
writing it from ALPM disable.

Also clearing ALPM_CTL_ALPM_AUX_LESS_ENABLE and is not about disabling ALPM
but switching to AUX-Wake ALPM. Stop touching this bit on ALPM disable.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/7153
Fixes: 1ccbf135862b ("drm/i915/psr: Enable ALPM on source side for eDP Panel replay")
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: <stable@vger.kernel.org> # v6.10+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
Reviewed-by: Michał Grzelak <michal.grzelak@intel.com>
Link: https://patch.msgid.link/20260212062731.397801-1-jouni.hogander@intel.com
(cherry picked from commit 008304c9ae75c772d3460040de56e12112cdf5e6)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/display/intel_alpm.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- a/drivers/gpu/drm/i915/display/intel_alpm.c
+++ b/drivers/gpu/drm/i915/display/intel_alpm.c
@@ -558,12 +558,7 @@ void intel_alpm_disable(struct intel_dp
 	mutex_lock(&intel_dp->alpm.lock);
 
 	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
-		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE |
-		     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
-
-	intel_de_rmw(display,
-		     PORT_ALPM_CTL(cpu_transcoder),
-		     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE, 0);
 
 	drm_dbg_kms(display->drm, "Disabling ALPM\n");
 	mutex_unlock(&intel_dp->alpm.lock);



