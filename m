Return-Path: <stable+bounces-244176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H82OUkF+mkEIgMAu9opvQ
	(envelope-from <stable+bounces-244176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:57:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 605C04CFCF8
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 16:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2398E302BBC6
	for <lists+stable@lfdr.de>; Tue,  5 May 2026 14:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA50647ECE8;
	Tue,  5 May 2026 14:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iZUdRDG0"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAB330216D
	for <stable@vger.kernel.org>; Tue,  5 May 2026 14:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993030; cv=none; b=eItghOFzi2xFXhB2HL+yp02wO64+GU1x4Ajf3Lr3QRbQtLnT341cx5OV47y7WUEEohQk76abaA6T6CFqprwReSQf8DwzXH1wVmI8vUc4THlsC8D70lsBNWB5wTx9OYyvfSLd5poKARaeeTdSlL/4ta50vUOkMooa/t2ce14frc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993030; c=relaxed/simple;
	bh=R5PKQRDFxFRfs/opeVZTDRMnekNqOfgWTVe0W2o815w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SuCytKWywmzYP097Dx+QwLE0epQ2t6M3NqrGGmM9Qh48gy78r6H72y2llQETQd4sJueHbrr+j35TbLN3oHM9p9w5JdGnNTPaTevz0VMZHI6aMzTXV7KkiLZQj6m+GE4/EWuFwWOCmOPgY5+sOdgK4VoAdNL6WW6nfcE2sx9Vz6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iZUdRDG0; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1C3771A3515;
	Tue,  5 May 2026 14:57:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E34336053C;
	Tue,  5 May 2026 14:57:06 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 172B511AD0286;
	Tue,  5 May 2026 16:57:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777993026; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=3ykqrj8TMl/CACkCKsorqSvBm2kVfs95MQdBQxVzySg=;
	b=iZUdRDG0VkCisPZi3M/wzFLahpfFDlDBIQR6KmTPBz8U9mYcpOpfp7k1EFVh4nA4ICl3Uv
	UXZeoU7CNw+ZPbDQ3Q8KP16FGpSsW/cUy2KshCbJGQD3wBxTFJE3dMBdQI+WmawhIIyuWU
	jN/Gl4gTDT1uXsf7j+7CyWDNmIPLN0RM6rDkkMYGO2aA+kEEM2MDZblCQvDcUcP2Gm9qiH
	5NR2bMB1H7/uQHQjBIqDW+YMHfBvGdo9UyzRFWzrPw+gsAjvdGxxXVZBqPodp/PSVbd2Af
	0t00igisIjIb/II2YaC7NaM/xKpCr2Jc8XgnnGBXv3G8jHNR3w12Y1M4FmxJGg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Alain Volmat <alain.volmat@foss.st.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Osama Abdelkader <osama.abdelkader@gmail.com>
Cc: stable@vger.kernel.org
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Subject: Re: (subset) [PATCH v3 1/3] drm/sti: remove bridge when sti_hda
 component_add fails
Message-Id: <177799302281.1269303.8720982379934816219.b4-ty@b4>
Date: Tue, 05 May 2026 16:57:02 +0200
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
X-Rspamd-Queue-Id: 605C04CFCF8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244176-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[foss.st.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.ceresoli@bootlin.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email]


On Thu, 23 Apr 2026 22:06:19 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().

Applied, thanks!

[2/3] drm/exynos: remove bridge when component_add fails
      commit: 26f6654a9a60eb4d241f42a0ec85412e8821480b

Best regards,
-- 
Luca Ceresoli <luca.ceresoli@bootlin.com>


