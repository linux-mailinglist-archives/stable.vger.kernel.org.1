Return-Path: <stable+bounces-237782-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIOdHcMW3mlBmwkAu9opvQ
	(envelope-from <stable+bounces-237782-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:28:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4403F8ACB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 12:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0DB92301C8AD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 10:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5E83D3D1D;
	Tue, 14 Apr 2026 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JdIl6pFb"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4FE3D3D0C
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 10:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162469; cv=none; b=bBjTpzCiJdy7gCDHeaOcNssrh8CqL2B3Hmnzu11jv4hdIfJepCHWZGkLbMCuXkJ6FNeWhG0X9J5lb7QQO9WKOTkpXpd4JY6yWpYdU+MXOgTU2ig38+GKtegoxYtzr+dauyGdxXBjilS36mpKAwrC2ZsUIh1WReV3olrVpMjbZDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162469; c=relaxed/simple;
	bh=ZWVL2LtB+sJiNUdV7z82423QqS4Q0S1LVEpSn3KXChA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=q8GuBAEHEEKVXqykyCEgBi7oh+Zo5YCe7zhH4hTFnPCClcJFoxr7gQfR3+xStoViSr3i1iBQYAHaLGWgu5sjPXDyTWnCyHZNG2AHa/4ovSBu0H3nTc6B/TLbAWiEbB8WAQ9qPLaIVcd8THTyGTQLWlXJSi3nP7v5U5qRlKSPfC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JdIl6pFb; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D2C801A3296;
	Tue, 14 Apr 2026 10:27:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9A2245FFBB;
	Tue, 14 Apr 2026 10:27:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 351B410450970;
	Tue, 14 Apr 2026 12:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776162458; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=h8ey9CmN38Fhwlg8yQDoqTDnddfyH7yrk+3c7ZyI9Ls=;
	b=JdIl6pFb9bdbuXpenlZl46AJrCBnaogmstXLpxMVMJNeW/ib0YQorQO4t42dhhwhfc/qNI
	900ZBrGyy1QLL7SrPWsWXNmZnqMjZm/V58EGxI23pHxtxSXgLGOZCJTkGVDPbaf5M84PPi
	Z9w/i7dN6FJypePxDlqQ/74HBlFXWO+NwYV9L/cCE9X8US0/i05r4zTCEUleWHsbSGs3Me
	ZnhuwKewgVdYRzt8iN+o+3abC/Q0RO1kby8wbfmdcJMzgE4rMxuR9Y8FssoQuWpA4baDJb
	rx9YXkZl690Y/o9ov7Tk3rUpWH5Hps25hoI5Y3ZML395ChLdxZ8q8W2UnWpHuQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Simona Vetter <simona.vetter@ffwll.ch>, 
 Alexey Brodkin <abrodkin@synopsys.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Ian Ray <ian.ray@gehealthcare.com>, stable@vger.kernel.org
In-Reply-To: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
References: <20260402-drm-arcgpu-fix-device-node-leak-v2-1-d773cf754ae5@bootlin.com>
Subject: Re: [PATCH v2] drm/arcpgu: fix device node leak
Message-Id: <177616245447.642738.16922563942350413002.b4-ty@b4>
Date: Tue, 14 Apr 2026 12:27:34 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ffwll.ch,synopsys.com,linux.intel.com,kernel.org,suse.de,gmail.com,bootlin.com];
	TAGGED_FROM(0.00)[bounces-237782-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email]
X-Rspamd-Queue-Id: EF4403F8ACB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 02 Apr 2026 18:42:20 +0200, Luca Ceresoli wrote:
> This function gets a device_node reference via
> of_graph_get_remote_port_parent() and stores it in encoder_node, but never
> puts that reference. Add it.
> 
> There used to be a of_node_put(encoder_node) but it has been removed by
> mistake during a rework in commit 3ea66a794fdc ("drm/arc: Inline
> arcpgu_drm_hdmi_init").
> 
> [...]

Applied, thanks!

[1/1] drm/arcpgu: fix device node leak
      commit: ad3ac32a3893a2bbcad545efc005a8e4e7ecf10c

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


