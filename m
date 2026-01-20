Return-Path: <stable+bounces-210513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBa5M2pbcGm8XgAAu9opvQ
	(envelope-from <stable+bounces-210513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:51:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 522C35139B
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 05:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DE7088BE3D
	for <lists+stable@lfdr.de>; Tue, 20 Jan 2026 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD49426EA2;
	Tue, 20 Jan 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hMOcoQhd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D513A9000
	for <stable@vger.kernel.org>; Tue, 20 Jan 2026 13:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914272; cv=none; b=kH07bDTJnrxcpSLdZk07Tp17g/n03FbnzZycOQFwZ+uIie40pLiFpT7Ov9hBnNreO2PBCj2YQFB//NHFVt/NTeGvKjShnkmdRXb+S/cnaa4FGYeMZQ6ER2eRxox4gUqcgy8I0sCp81rjIVDE3fF2WlUsb2BSaN3vASfVRo00iQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914272; c=relaxed/simple;
	bh=KhwFD9j7sgoZyCHBfY5NLO0sA3pYv4SpxQ+CONi0kLs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Tc/alxu8iOzqmlHxDV4okU+X2CJOLSOjQ3oP4Cz+njlWLTlNw1I+OKr9DwmK97IDAnuFAxVZUZA5PZBvgD84zPxvmf/yxt4lwWZb/0MItNwDiUasc17nTH2vxpWhX/xZfexkb8wL95YOPVqX4SZslXtA/NTnWRBd4idQ+2S0Zuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hMOcoQhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47AB3C19422;
	Tue, 20 Jan 2026 13:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768914271;
	bh=KhwFD9j7sgoZyCHBfY5NLO0sA3pYv4SpxQ+CONi0kLs=;
	h=Subject:To:Cc:From:Date:From;
	b=hMOcoQhd/N/QV2zkLb2/QH5XBph5e+DIKkxbvdF6Q12YF8IgxDq+L1HKQCLn0dCON
	 +Q8EHG6VG5a46qEc5CiA2JIirKpqM6v71LJV6RyiuVFQun4Aw2+0sIIXMMyCKB8qqJ
	 6/I6JupKpqpMbZLlojKq3zNNjojA60kwgxNajJv4=
Subject: FAILED: patch "[PATCH] ASoC: codecs: wsa881x: fix unnecessary initialisation" failed to apply to 6.6-stable tree
To: johan@kernel.org,broonie@kernel.org,krzysztof.kozlowski@oss.qualcomm.com,srini@kernel.org,srinivas.kandagatla@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 20 Jan 2026 14:04:28 +0100
Message-ID: <2026012028-unclamped-unfrozen-60bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.54 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210513-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_DN_NONE(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linuxfoundation.org:dkim,msgid.link:url,qualcomm.com:email]
X-Rspamd-Queue-Id: 522C35139B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 29d71b8a5a40708b3eed9ba4953bfc2312c9c776
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012028-unclamped-unfrozen-60bd@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 29d71b8a5a40708b3eed9ba4953bfc2312c9c776 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 2 Jan 2026 12:14:11 +0100
Subject: [PATCH] ASoC: codecs: wsa881x: fix unnecessary initialisation

The soundwire update_status() callback may be called multiple times with
the same ATTACHED status but initialisation should only be done when
transitioning from UNATTACHED to ATTACHED.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Cc: stable@vger.kernel.org	# 5.6
Cc: Srinivas Kandagatla <srini@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Link: https://patch.msgid.link/20260102111413.9605-3-johan@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index d7aca6567c2d..2fc234adca5f 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -678,6 +678,7 @@ struct wsa881x_priv {
 	 */
 	unsigned int sd_n_val;
 	int active_ports;
+	bool hw_init;
 	bool port_prepared[WSA881X_MAX_SWR_PORTS];
 	bool port_enable[WSA881X_MAX_SWR_PORTS];
 };
@@ -687,6 +688,9 @@ static void wsa881x_init(struct wsa881x_priv *wsa881x)
 	struct regmap *rm = wsa881x->regmap;
 	unsigned int val = 0;
 
+	if (wsa881x->hw_init)
+		return;
+
 	regmap_register_patch(wsa881x->regmap, wsa881x_rev_2_0,
 			      ARRAY_SIZE(wsa881x_rev_2_0));
 
@@ -724,6 +728,8 @@ static void wsa881x_init(struct wsa881x_priv *wsa881x)
 	regmap_update_bits(rm, WSA881X_OTP_REG_28, 0x3F, 0x3A);
 	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG1, 0xFF, 0xB2);
 	regmap_update_bits(rm, WSA881X_BONGO_RESRV_REG2, 0xFF, 0x05);
+
+	wsa881x->hw_init = true;
 }
 
 static int wsa881x_component_probe(struct snd_soc_component *comp)
@@ -1067,6 +1073,9 @@ static int wsa881x_update_status(struct sdw_slave *slave,
 {
 	struct wsa881x_priv *wsa881x = dev_get_drvdata(&slave->dev);
 
+	if (status == SDW_SLAVE_UNATTACHED)
+		wsa881x->hw_init = false;
+
 	if (status == SDW_SLAVE_ATTACHED && slave->dev_num > 0)
 		wsa881x_init(wsa881x);
 


