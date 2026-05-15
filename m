Return-Path: <stable+bounces-247597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIT3FgvjBmoGowIAu9opvQ
	(envelope-from <stable+bounces-247597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:10:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A787554C172
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BC9B317A895
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA0840628C;
	Fri, 15 May 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MB5iu8Sd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C8E3F7AB1
	for <stable@vger.kernel.org>; Fri, 15 May 2026 08:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778834457; cv=none; b=K/+Nm7btGSq/nc0q72QRCQz2CH9BSvuWrKG9k+QeNWdWOcqi5PStCXY8UUNkqTCRfZ5b3jFn8TyF6J5yo7I/k/HiF4h6zO471bYuY7Xzze9k6gHJcqZnxphlJ5D/EGQ3QSs4gx7nQslYXGgAfEjCO2XH1gqvdQXFw1Wrurf5Eiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778834457; c=relaxed/simple;
	bh=RnaDTHxnabX37I/tr7MN3pfGUB4umghZxlszaO9V0dM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=A2oInIgHLcnD0EXAyTXTlR8tqiVieh5Swo/J1aac1/j+Yv+bFL5D27cWbpJ7OetMTFViHgs0dXnxkT6eNo6jrYaqZfWqAcrFt+XKRtebEG4GOsqPlY8bZ4LJuozqrRVc5QTveD4r80GNUSNma8qAJbQxeAHLzUuByqplfQHqLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MB5iu8Sd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AE5C2BCB8;
	Fri, 15 May 2026 08:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778834456;
	bh=RnaDTHxnabX37I/tr7MN3pfGUB4umghZxlszaO9V0dM=;
	h=Subject:To:Cc:From:Date:From;
	b=MB5iu8Sd1MGhYCkei8DpZ5ZmphxE/BqJQo/pIDa+lSO5g3Gm8lO2CMjwNLXziraz6
	 iFieqJa3zwyeb2HjY9y60NCDzzLvOzUDZrVY8ZMUG3WHjr27+sx2Ue4IVLSPWBR+WZ
	 CrZYFbcgak4M+h1QPnN//2AC0rwz1KzUx8nRA4NE=
Subject: FAILED: patch "[PATCH] drm/panel: boe-tv101wum-nl6: restore MODE_LPM after sending" failed to apply to 6.6-stable tree
To: zhengxingda@iscas.ac.cn,dianders@chromium.org,neil.armstrong@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 10:40:52 +0200
Message-ID: <2026051552-repost-region-e57a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A787554C172
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
	TAGGED_FROM(0.00)[bounces-247597-lists,stable=lfdr.de];
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 570cf799e87ae805eacfab3b4ba66676b5fccdb6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051552-repost-region-e57a@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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


