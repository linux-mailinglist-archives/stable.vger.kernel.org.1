Return-Path: <stable+bounces-210889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDAWFroncWniewAAu9opvQ
	(envelope-from <stable+bounces-210889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:23:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E82DD5C168
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3299138C356
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0564392C44;
	Wed, 21 Jan 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OxJz00I5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B903A9DBC;
	Wed, 21 Jan 2026 18:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019727; cv=none; b=kWtj6cNDOQWkEF5iaRnt/4AJlkn3/9Rh306eUktKT9tS7kwq+DSBA7ihSnDWZCH2cgqWPTZKe6n83NF2u2Eu/S40rpeTJgFTekPUz0MVktWBgtBPUO94HIxKTlki+jybes/pyeLcMvVzUwY3DT5Hqb+uIkJxkgzd6LqJ6suuwF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019727; c=relaxed/simple;
	bh=gI9pNNhmZwnSdkg4yJVC3ckl87SM2IcJblwg/nhJI80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HGWN8d7SN9HVzlOwcoMePGmhBDdTf9IgU1bbMiaGqVJTn/2hASDWdilADw4xY1s+XYmiYaDagbPmV3A8Vhp56i5mMKLo/4/jZOi6Z8oE1y4K1hdgB9ShcYCclwl1FU8uCdyGnauI/zYrQ2iNK3gtkvkP5/sgOdQNo2hqtq0brkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OxJz00I5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99E6C4CEF1;
	Wed, 21 Jan 2026 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019727;
	bh=gI9pNNhmZwnSdkg4yJVC3ckl87SM2IcJblwg/nhJI80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxJz00I59O0SjZXbMQI9JhtI7ppzB2rboJ6/UNR0mi8btPe0a3KT+uDoK72pFbgs3
	 UGKDInCcItSRqrwtpB0yi19yfENHmXAaxPs1pcLnceCzbTq0j09wEROHIZ04C8i/Ca
	 ELM3NFvo7+Ox0jaLdbQwJDLy85nIhqDFSZL9R97c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Dragan Simic <dsimic@manjaro.org>,
	Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH 6.12 089/139] tcpm: allow looking for role_sw device in the main node
Date: Wed, 21 Jan 2026 19:15:37 +0100
Message-ID: <20260121181414.659310870@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210889-lists,stable=lfdr.de];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MID_RHS_MATCH_FROM(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,intel.com:email,manjaro.org:email]
X-Rspamd-Queue-Id: E82DD5C168
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaud Ferraris <arnaud.ferraris@collabora.com>

commit 1366cd228b0c67b60a2c0c26ef37fe9f7cfedb7f upstream.

If ports are defined in the tcpc main node, fwnode_usb_role_switch_get()
returns an error, meaning usb_role_switch_get() (which would succeed)
never gets a chance to run as port->role_sw isn't NULL, causing a
regression on devices where this is the case.

Fix this by turning the NULL check into IS_ERR_OR_NULL(), so
usb_role_switch_get() can actually run and the device get properly probed.

Fixes: 2d8713f807a4 ("tcpm: switch check for role_sw device with fw_node")
Cc: stable <stable@kernel.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Link: https://patch.msgid.link/20260105-fix-ppp-power-v2-1-6924f5a41224@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/tcpm/tcpm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -7697,7 +7697,7 @@ struct tcpm_port *tcpm_register_port(str
 	port->partner_desc.identity = &port->partner_ident;
 
 	port->role_sw = fwnode_usb_role_switch_get(tcpc->fwnode);
-	if (!port->role_sw)
+	if (IS_ERR_OR_NULL(port->role_sw))
 		port->role_sw = usb_role_switch_get(port->dev);
 	if (IS_ERR(port->role_sw)) {
 		err = PTR_ERR(port->role_sw);



