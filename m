Return-Path: <stable+bounces-212495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJ1aJw05eml+4gEAu9opvQ
	(envelope-from <stable+bounces-212495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:27:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B53A5A86
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A156D3031932
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 15:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E5D30274D;
	Wed, 28 Jan 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pS2PCDbJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F6C2F6183;
	Wed, 28 Jan 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615708; cv=none; b=qQ6z8eJZYw/KDbid54oRnMJUsk3vBntQ+4+ucK0e1/bOtzKQDIgpdH8Gx/xW7bWBtquWL/Vb/UFk4DG5889AHrUI0+sqzF8ylbiipzi2pqVB2YcPYJhpAtIz3jeSOFKPemZsXDTyFWSy6p38zvGS7YVtJ+DORKJMkjAt26ukfg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615708; c=relaxed/simple;
	bh=6v6FCpZsmfjzGMIaqJQti9/l6UuFmWl8rn5gSNsHikQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X8CHQAr2lszyQuedabmMHuh4/jJOSe0jIZAK/WXjmEKkGEHOz1ejOi9WmRsh9rI4XkJZX89w8e429DOYnixuiGTPZWT8szZtsqjPAnmENTKwo44E10Ai/0u2n2ool2jf394T61VKlXhGMtUf8ciw4r7GHecm+nGpgnupuuRnvaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pS2PCDbJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2631C4CEF1;
	Wed, 28 Jan 2026 15:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769615708;
	bh=6v6FCpZsmfjzGMIaqJQti9/l6UuFmWl8rn5gSNsHikQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pS2PCDbJBw3Zjc+XTwPwvAwKuIxHfhtYYzSumJzkB17A4TbzaOaDiT5tzBeExijQX
	 KUAkUsbNDFGWa0ZCcC1ZLA9cDuPYNjNtWTeiawbs3OdUGc4ncPlwClN/+7DzItoO5K
	 Htabawkrr5Pn3OGYkBFWenfKp+Cbgwb2WCkdsH0o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksandr Shamray <oleksandrs@nvidia.com>,
	Vadim Pasternak <vadimp@nvidia.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 090/227] platform/mellanox: Fix SN5640/SN5610 LED platform data
Date: Wed, 28 Jan 2026 16:22:15 +0100
Message-ID: <20260128145347.574185257@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212495-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: C0B53A5A86
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksandr Shamray <oleksandrs@nvidia.com>

[ Upstream commit 3113bcf4ccf06c938f0bc0c34cf6efe03278badc ]

In SN5640/SN5610 platforms should be used XDR style LED data with
predefined slot index per led_fan.

Fixes: 317bbe169c46 ("platform: mellanox: mlx-platform: Add support for new Nvidia system")

Signed-off-by: Oleksandr Shamray <oleksandrs@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Link: https://patch.msgid.link/20260107142548.916556-1-oleksandrs@nvidia.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/mellanox/mlx-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/mellanox/mlx-platform.c b/drivers/platform/mellanox/mlx-platform.c
index d0df18be93c76..efd0c074ad937 100644
--- a/drivers/platform/mellanox/mlx-platform.c
+++ b/drivers/platform/mellanox/mlx-platform.c
@@ -7381,7 +7381,7 @@ static int __init mlxplat_dmi_ng400_hi171_matched(const struct dmi_system_id *dm
 	mlxplat_hotplug = &mlxplat_mlxcpld_ng800_hi171_data;
 	mlxplat_hotplug->deferred_nr =
 		mlxplat_msn21xx_channels[MLXPLAT_CPLD_GRP_CHNL_NUM - 1];
-	mlxplat_led = &mlxplat_default_ng_led_data;
+	mlxplat_led = &mlxplat_xdr_led_data;
 	mlxplat_regs_io = &mlxplat_default_ng_regs_io_data;
 	mlxplat_fan = &mlxplat_xdr_fan_data;
 
-- 
2.51.0




