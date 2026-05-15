Return-Path: <stable+bounces-247600-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HfcCzTgBmp4ogIAu9opvQ
	(envelope-from <stable+bounces-247600-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:58:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CF554BD75
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 10:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60FC0317C490
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572BF426D1E;
	Fri, 15 May 2026 08:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WUFAPmf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241D426D15
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834465; cv=none; b=Wuk3/FrwxtxulAHQI+CQ6jgEiMGEF7OLtMztv9rK7LyunhLFYe9POZOIFT51vd/r6zWopl5Byfpk73NXiK2L4mgrUdKPvFXzN3shBGPOnIl66OKD37WaQfS7PYLYKHQX84tS5mAcBBZUk/vUiKbh6zoHDHADLsnSfH3AoUr/Bwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834465; c=relaxed/simple;
	bh=2EAfyyV+iWauH/3RALVrAdJLT2QJGuGFwv45XPCbK4g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mHyZaCdkN+852/c0+b9AVS++8seQSSSaEqM/eVeWIVsAfhoXwjePRWGDiJ9tTLSGyXCckrKjBHKvGsHHCou08AV7aPmqPPICzZk2GAJE4WQR0SaqRWd+hGk6WBvStrmhNusxOhRXwKVvXJMfsxUiTo1i0Oe2ptyKOZ2Nw8sfPY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WUFAPmf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D8CC2BCB0;
	Fri, 15 May 2026 08:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834465;
	bh=2EAfyyV+iWauH/3RALVrAdJLT2QJGuGFwv45XPCbK4g=;
	h=Subject:To:Cc:From:Date:From;
	b=2WUFAPmfpgpq7pte+5FWpNG8fWmnUcVjVrU/JDriqtii7ZvaDngqQAAWibWzcwoR8
	 1JZYQemlc7BwyXHNAxhf3QW2gxtuPx15Hm1Whocxte/IH2Y+rNxm3mTP0UxoKUkGWz
	 jweSelIZiTvr81iDf0yLTxpLSp82k7vjZdqqZWiU=
Subject: FAILED: patch "[PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending" failed to apply to 5.10-stable tree
To: zhengxingda@iscas.ac.cn,dianders@chromium.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:40:53 +0200
Message-ID: <2026051553-strode-excusably-c982@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93CF554BD75
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247600-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 570cf799e87ae805eacfab3b4ba66676b5fccdb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051553-strode-excusably-c982@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 570cf799e87ae805eacfab3b4ba66676b5fccdb6 Mon Sep 17 00:00:00 2001
From: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Date: Sun, 3 May 2026 17:17:08 +0800
Subject: [PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending
 disable cmds

When preparing the panel, it seems that it always expects commands to be
transferred in LP mode. However, the disable function removes the
MIPI_DSI_MODE_LPM flag, and no other function re-adds it.

As the unprepare function contains no DSI commands, re-adding the flag
just after disabling the panel should be safe. Add the code re-adding
the flag after the two commands for disabling the panel are sent.

This fixes error messages shown in kernel log when unblanking on
mt8183-kukui-kodama-sku32 device.

Cc: stable@vger.kernel.org
Fixes: a869b9db7adf ("drm/panel: support for boe tv101wum-nl6 wuxga dsi video mode panel")
Signed-off-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patch.msgid.link/20260503091708.1079962-1-zhengxingda@iscas.ac.cn

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index d5fe105bdbdd..658ce64c71eb 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1324,6 +1324,8 @@ static int boe_panel_disable(struct drm_panel *panel)
 	mipi_dsi_dcs_set_display_off_multi(&ctx);
 	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
 
+	boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
+
 	mipi_dsi_msleep(&ctx, 150);
 
 	return ctx.accum_err;


