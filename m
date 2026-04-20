Return-Path: <stable+bounces-239572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHQUHgtg5mkxvgEAu9opvQ
	(envelope-from <stable+bounces-239572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDEAC430FC4
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 19:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 21968329BD2C
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D8B329C6D;
	Mon, 20 Apr 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i7u0Zk/+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0422259F;
	Mon, 20 Apr 2026 15:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700596; cv=none; b=rAdklCfvj0fWS+kBR6FJTg3/1HmlOKKFAKgONYRgPEYr3u50CRagB0OhEjY3qEbirk4jNuW11nJSbKnmqV15u1n95hZnTOMHTDEhWqDQh4DzcYjd7y7XeIBkaWAzBQWgeEFuAi/ysloa/hHuIkFWlbYfgHDf67eiTjTa9sIVa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700596; c=relaxed/simple;
	bh=JwTW8QWniyW4HKTH7yHB/1C2tC8NQr9PN19EZyKmnrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGkY1OKiFrEXl7C6BIGd97dyUvMsXwTfdbmG0PGWwLjc7wzUlcAHNSjBx/08d1AkMnOYTZnWH4dZ57+0v2VYfl6o/JYpvGHN17w/mmKuEXTOd7qfIMzDtGlTmMGWS1FmSVFb6LaXIsNhqvyf7YPlioQo7s95qz+24zwj+K3o/Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i7u0Zk/+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744B9C19425;
	Mon, 20 Apr 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700596;
	bh=JwTW8QWniyW4HKTH7yHB/1C2tC8NQr9PN19EZyKmnrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i7u0Zk/+mqnmCYPliFWjd3qn47VcFuuuqBtBmBibHhDfV9tBJQvwv1W6ocRr4tkTU
	 v31Y3gSrcrcOhroSFBiCWe3/Xk67x8C2TMwEBdJFXdc1Ube7Xqkq8mF5yMo/PRgj+M
	 nfRbhaKXCkvCLFn4R2j7+tzIPB/pm5E7oGtZQadY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Frank Zhang <rmxpzlb@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 014/198] ALSA:usb:qcom: add AUXILIARY_BUS to Kconfig dependencies
Date: Mon, 20 Apr 2026 17:39:53 +0200
Message-ID: <20260420153936.129574450@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153935.605963767@linuxfoundation.org>
References: <20260420153935.605963767@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-239572-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,suse.de,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: DDEAC430FC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Frank Zhang <rmxpzlb@gmail.com>

[ Upstream commit b8bee48e38f2ddbdba5e58bc54ef54bb7d8d341b ]

The build can fail with:

ERROR: modpost: "__auxiliary_driver_register"
[sound/usb/qcom/snd-usb-audio-qmi.ko] undefined!
ERROR: modpost: "auxiliary_driver_unregister"
[sound/usb/qcom/snd-usb-audio-qmi.ko] undefined!

Select AUXILIARY_BUS when SND_USB_AUDIO_QMI is enabled.

Signed-off-by: Frank Zhang <rmxpzlb@gmail.com>
Link: https://patch.msgid.link/20260317102527.556248-1-rmxpzlb@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/usb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
index 9b890abd96d34..b4588915efa11 100644
--- a/sound/usb/Kconfig
+++ b/sound/usb/Kconfig
@@ -192,6 +192,7 @@ config SND_USB_AUDIO_QMI
 	tristate "Qualcomm Audio Offload driver"
 	depends on QCOM_QMI_HELPERS && SND_USB_AUDIO && SND_SOC_USB
 	depends on USB_XHCI_HCD && USB_XHCI_SIDEBAND
+	select AUXILIARY_BUS
 	help
 	  Say Y here to enable the Qualcomm USB audio offloading feature.
 
-- 
2.53.0




