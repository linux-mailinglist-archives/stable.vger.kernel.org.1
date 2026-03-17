Return-Path: <stable+bounces-226717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFwTGHuNuWnkJwIAu9opvQ
	(envelope-from <stable+bounces-226717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C26352AF5C1
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3EE23076483
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2132548B;
	Tue, 17 Mar 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AK9uhr6g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276B191F94;
	Tue, 17 Mar 2026 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767935; cv=none; b=ENW9yqEOfsKU63SQiwOK4YAMJSlHfZvu4Dil4ZV/13zwk+HeUq6e5CFe14FpMsvPYFZZCEY8h+CIWPhl16QtIFebb1Ke7k/6fDmm9gCAe/lzAxUXwh8msdhveHfChbcrqTk4MJuiKOw1uguvLhQnBIxAV2kJyEaJwwkLpIwe43s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767935; c=relaxed/simple;
	bh=6NiVTJ2l03YA3IvUPda/7j8uEyQn7ccOJVLHcPg12p4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B494qbhbp4x+Q1zqsQLQ6vnyWoIjVgRBF495evKX+YXyRUL5otz6RAahMZNyVPpnfKkYh1YhgQxChV5Br7rO1oLmTtTrVYNaMhHfju9haiRdGbqBh/avki45/H2woPdPpE+NFXAk/GKFp/1RmsEa76RsiMfvDSq3o1W9hDbVmiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AK9uhr6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54300C4CEF7;
	Tue, 17 Mar 2026 17:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767934;
	bh=6NiVTJ2l03YA3IvUPda/7j8uEyQn7ccOJVLHcPg12p4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AK9uhr6gDrlxnhHZ9/III0/Le8GaGdbmDtULTXNGCAiBoqFsDVhD1Fb4idWnjxDnD
	 3MZHe8fJm/QEYQdx/duajsvBQ97eYZqEsl4iPzPmLzZBYG18Z6MV4LU/g9mCphpHHY
	 7VMRBDdV/ScyBkE3s/6Hxrfbuef+nRtJFMhZUw20=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Animesh Manna <animesh.manna@intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.18 193/333] drm/i915/alpm: ALPM disable fixes
Date: Tue, 17 Mar 2026 17:33:42 +0100
Message-ID: <20260317163006.513741346@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-226717-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: C26352AF5C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -577,12 +577,7 @@ void intel_alpm_disable(struct intel_dp
 	mutex_lock(&intel_dp->alpm_parameters.lock);
 
 	intel_de_rmw(display, ALPM_CTL(display, cpu_transcoder),
-		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE |
-		     ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
-
-	intel_de_rmw(display,
-		     PORT_ALPM_CTL(cpu_transcoder),
-		     PORT_ALPM_CTL_ALPM_AUX_LESS_ENABLE, 0);
+		     ALPM_CTL_ALPM_ENABLE | ALPM_CTL_LOBF_ENABLE, 0);
 
 	drm_dbg_kms(display->drm, "Disabling ALPM\n");
 	mutex_unlock(&intel_dp->alpm_parameters.lock);



