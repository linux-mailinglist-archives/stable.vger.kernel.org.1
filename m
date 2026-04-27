Return-Path: <stable+bounces-241380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I4aHnWS72nRCwEAu9opvQ
	(envelope-from <stable+bounces-241380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E944769FF
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:44:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99A50304E320
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626FA34D384;
	Mon, 27 Apr 2026 16:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HH2JMXVs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260D72C11E7
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777307909; cv=none; b=f8eEC7/dnvEruNdcxaLjjOESHYqilJPNrhgwJaGlkwwBdoelJELlU3rswSbO/Q7yugkrat8jzHWQ++IJsWvQMniFzWN2LDGwMHB1wZQQClNxOul+EFXY1fw988NEqo2f8624fi9jg5kFHaTaLNrl+My5s5R3iln2w3NOGVVJCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777307909; c=relaxed/simple;
	bh=v2pftadC45mke46uK8V6j94um90D9j/mjYM4k9SSAx8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CRjEynMFrIESz7Tdzj0cxkKVFgQ+NLz5UsM/dVLmZT/etMY/kaGJ9Hsvqsf21efp1hGnmSeA68nvSqrKcraAFjWpDCEHuH1/BtGs2ETt+ct0G3+1m6RtQ+MWDBrPNcLSEosjBsb0xfx4DZhkPvXao7qozRAOdOTJmuHWMLdf4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HH2JMXVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8EEC19425;
	Mon, 27 Apr 2026 16:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777307908;
	bh=v2pftadC45mke46uK8V6j94um90D9j/mjYM4k9SSAx8=;
	h=Subject:To:Cc:From:Date:From;
	b=HH2JMXVsgMDI/LxM+DGlHOAQKmD4vQ1xMDgl2EYpBv+nMpGnWP7NgMn0ozfPbEHfY
	 H4mzlM2HvHTyk+5pPwva049C6zc5BMdhSUDSZngydlrzl9lwLeH8kNMctRmCyOXCAM
	 HGRBy7aBcnDyEtF7VA2xn9JGqHINcEbi/0jSc0J4=
Subject: FAILED: patch "[PATCH] leds: qcom-lpg: Check for array overflow when selecting the" failed to apply to 5.15-stable tree
To: gregkh@linuxfoundation.org,lee@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 27 Apr 2026 10:37:43 -0600
Message-ID: <2026042743-vacancy-unread-9565@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D0E944769FF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241380-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,gregkh:email]


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x d45963a93c1495e9f1338fde91d0ebba8fd22474
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026042743-vacancy-unread-9565@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d45963a93c1495e9f1338fde91d0ebba8fd22474 Mon Sep 17 00:00:00 2001
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Thu, 19 Feb 2026 15:34:35 +0100
Subject: [PATCH] leds: qcom-lpg: Check for array overflow when selecting the
 high resolution

When selecting the high resolution values from the array, FIELD_GET() is
used to pull from a 3 bit register, yet the array being indexed has only
5 values in it.  Odds are the hardware is sane, but just to be safe,
properly check before just overflowing and reading random data and then
setting up chip values based on that.

Cc: stable <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/2026021934-nearby-playroom-036b@gregkh
Signed-off-by: Lee Jones <lee@kernel.org>

diff --git a/drivers/leds/rgb/leds-qcom-lpg.c b/drivers/leds/rgb/leds-qcom-lpg.c
index 016bf468e094..f6061c47f863 100644
--- a/drivers/leds/rgb/leds-qcom-lpg.c
+++ b/drivers/leds/rgb/leds-qcom-lpg.c
@@ -1273,7 +1273,12 @@ static int lpg_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 		return ret;
 
 	if (chan->subtype == LPG_SUBTYPE_HI_RES_PWM) {
-		refclk = lpg_clk_rates_hi_res[FIELD_GET(PWM_CLK_SELECT_HI_RES_MASK, val)];
+		unsigned int clk_idx = FIELD_GET(PWM_CLK_SELECT_HI_RES_MASK, val);
+
+		if (clk_idx >= ARRAY_SIZE(lpg_clk_rates_hi_res))
+			return -EINVAL;
+
+		refclk = lpg_clk_rates_hi_res[clk_idx];
 		resolution = lpg_pwm_resolution_hi_res[FIELD_GET(PWM_SIZE_HI_RES_MASK, val)];
 	} else {
 		refclk = lpg_clk_rates[FIELD_GET(PWM_CLK_SELECT_MASK, val)];


