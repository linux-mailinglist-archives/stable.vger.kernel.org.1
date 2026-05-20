Return-Path: <stable+bounces-252966-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIUeFv7/DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252966-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:39:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B7A596F18
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE996307C415
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4259734EEF7;
	Wed, 20 May 2026 18:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="az54V+x1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00136370AEE;
	Wed, 20 May 2026 18:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779302055; cv=none; b=Apn9mGptU0Q/r5y+Sh6dfjdhcfUqe1PrxNt5BWSBtDTGy407HhkbO/zggsPpkZVQsek6Ke1eQ1+kgFVkV/sjtP7a2poz8gIawWXslaGe14uEHWGCke5wouUH21YcxYc9zkhbTagb3ekOKX853HVeaNWiRSRc+Gxa/ieAKPcJQJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779302055; c=relaxed/simple;
	bh=0eqiMnkI3tkSFrP0xANNbPlOjfcHJpTqlbxtE2bGW6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WOWQLD9I5PyzTu8ZVm0CtBBJK4vREE9FFJoeAI7s6zWzkKypkc6I3gKAs/5rrtgT8TUl7Cby4Z1riPJ3SmSFCbuM1Z6rMKsoKFFldfYBVyvclBYnq/hlXJZKPbTCDTBSCQUh0tJSTqTi8wOzN+qyLdVO6R2bDsfExfxk/0uS4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=az54V+x1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D6D1F000E9;
	Wed, 20 May 2026 18:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779302053;
	bh=qQ+80lnGJQMnXys+0mHwTgQ2C9ehN5hIB5Vq2DMw36E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=az54V+x1DryWWHj3tk2ul7dwYN36GDdV2omQCTalce5YsRZqs0zCyjsvNWhjmEKpD
	 XUTpyWyF8MJbGhSiByriZIeOGQd0HRL2oL2wdvXxzzAj2ORWehJavzyQWGEf0iO9yO
	 qjvxJEttprQKQvvw73WtIlFn/c6+SeAOqGTzJ6ok=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Douglas Anderson <dianders@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 119/508] drm/panel: sharp-ls043t1le01: make use of prepare_prev_first
Date: Wed, 20 May 2026 18:19:02 +0200
Message-ID: <20260520162101.206195854@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162058.573354582@linuxfoundation.org>
References: <20260520162058.573354582@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252966-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linaro.org:email,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,chromium.org:email]
X-Rspamd-Queue-Id: E5B7A596F18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

[ Upstream commit c222177d7c7e1b2e0433d9e47ec2da7015345d50 ]

The DSI link must be powered up to let panel driver to talk to the panel
during prepare() callback execution. Set the prepare_prev_first flag to
guarantee this.

Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260323-panel-fix-v1-1-9f12b09161e8@oss.qualcomm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
index 855e64444daa6..58f201720e699 100644
--- a/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
+++ b/drivers/gpu/drm/panel/panel-sharp-ls043t1le01.c
@@ -224,6 +224,7 @@ static int sharp_nt_panel_add(struct sharp_nt_panel *sharp_nt)
 
 	drm_panel_init(&sharp_nt->base, &sharp_nt->dsi->dev,
 		       &sharp_nt_panel_funcs, DRM_MODE_CONNECTOR_DSI);
+	sharp_nt->base.prepare_prev_first = true;
 
 	ret = drm_panel_of_backlight(&sharp_nt->base);
 	if (ret)
-- 
2.53.0




