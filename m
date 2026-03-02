Return-Path: <stable+bounces-222549-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2LOvCudUpWnR9AUAu9opvQ
	(envelope-from <stable+bounces-222549-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:14:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD81D55D1
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 10:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57E3130416DB
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF9238D01F;
	Mon,  2 Mar 2026 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="kq6yykSq"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69638D009;
	Mon,  2 Mar 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772442649; cv=none; b=sOJGPFxzG6ZFy5mNOohPBzXWmizqof4ekx596vccJdZOzqjTNU0i9HOCXYUUjqEEUVUGNJj7keeuURhrgu803q6jPFTF+0z6BxTrskqfXFBUYlddQzPHyHqIsKw2R5RnOei1/adO74MuGqtphH5QMeGfp9GdK2AFeHg1a33guvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772442649; c=relaxed/simple;
	bh=EbiUbBamIZ6iQCnBuNSz7FJjjmgw1YlSiC2B9C7jRP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4o4ZljERrGKtlw+kzQrUGjSfCKKifP0cSID63+975nP/UIvPqz3HoMg+OQsMyMW+SmKq2Ww3lKZPiR2XAkboAehYTCtkoGD0A566hR4D1welXDxUIMMD/o02vbKAhFDdYP9mciA63C+uUavszCapvSeTj2P9yPTMWdYtOXOjoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=kq6yykSq; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id 31F2B600298F;
	Mon,  2 Mar 2026 09:10:46 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 9zY3EXe9AjZ4; Mon,  2 Mar 2026 09:10:43 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [IPv6:2001:690:2100:1::b3dd:b9ac])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id 40B36600298D;
	Mon,  2 Mar 2026 09:10:42 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1772442643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALlF6/vIv/5xuYr1Gfj3RVY3fMyDzf4HKQYtSC25+Y4=;
	b=kq6yykSqCccGOyxQkZiYYRl4InB8BhUZ8Xs18tk1CsbLkx6x53sO9TssNNE4IQhab0mX6+
	mb3f/niCWn5KWXeAD5nzC5awUAM303Ro18H9t/o5YH1z0MZuCK+pPUcOAct8XEZBfweJ6/
	JaPuliwJ/uWR9AkGnIhkO7AEN5brKWsABtzVwup+36oZZO+MKN9STQ6AJeRxjf2235/aaf
	Tvs7tkK8V+ZBYxYPq4cpM8wrosSRCEkYKrXw7A2U4RMH61DqyiywtVGIWr7xu6PDJDTPwS
	rMiYO2GxfTgSTrUCfVfRW0WGtlsN4J0d2zzg9YBFMz81nTzxt0XULAhWB7ZrSw==
Received: from [IPV6:2001:8a0:fbec:a900:2c09:2fb0:9be7:36e0] (unknown [IPv6:2001:8a0:fbec:a900:2c09:2fb0:9be7:36e0])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id D502136013D;
	Mon,  2 Mar 2026 09:10:40 +0000 (WET)
Message-ID: <1663dc81-0685-4de9-8cf7-6065a644e7af@tecnico.ulisboa.pt>
Date: Mon, 2 Mar 2026 09:10:29 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/6] Fixes to Tegra USB role switching and phy handling
To: Mathias Nyman <mathias.nyman@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, JC Kuo <jckuo@nvidia.com>,
 Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org
References: <20260127-diogo-tegra_phy-v2-0-787b9eed3ed5@tecnico.ulisboa.pt>
Content-Language: en-US
From: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
In-Reply-To: <20260127-diogo-tegra_phy-v2-0-787b9eed3ed5@tecnico.ulisboa.pt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222549-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linuxfoundation.org,gmail.com,nvidia.com,kernel.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tecnico.ulisboa.pt:mid,tecnico.ulisboa.pt:dkim,ulisboa.pt:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[diogo.ivo@tecnico.ulisboa.pt,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tecnico.ulisboa.pt:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7ABD81D55D1
X-Rspamd-Action: no action

Hello,

Gentle ping on this series.

Best regards,
Diogo

On 1/27/26 15:11, Diogo Ivo wrote:
> Hello,
> 
> This patch series contains fixes/improvements for USB role switching on the
> Tegra210 and Tegra186 SoCs.
> 
> The first patch addresses a wrong check on the logic that disables the
> VBUS regulator.
> 
> The second patch removes a redundant mutex lock when setting the PHY
> mode.
> 
> The third patch guarantees proper ordering of events when switching PHY
> roles.
> 
> The remaining patches are included to standardize the PHY .set_mode()
> callback between Tegra186 and Tegra210.
> 
> With this patch series this feature can only be controlled from userspace,
> by writing the desired role to sysfs as
> 
> echo "role" > /sys/class/usb_role/usb2-0-role-switch/role
> 
> with role being one of {device, host, none}.
> 
> Further patches will enable automatic role switching via the 'cros_ec_typec'
> driver which is currently broken on Smaug.
> 
> Signed-off-by: Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>
> ---
> Changes in v2:
> - Remove DT patches already taken to be upstreamed
> - Add standardization between Tegra210 and Tegra186
> - Address review comments from v1, detailed descriptions in each patch
> - Link to v1: https://lore.kernel.org/r/20251204-diogo-tegra_phy-v1-0-51a2016d0be8@tecnico.ulisboa.pt
> 
> ---
> Diogo Ivo (6):
>        phy: tegra: xusb: Fix USB2 port regulator disable logic
>        usb: xhci: tegra: Remove redundant mutex when setting phy mode
>        phy: tegra: xusb: Fix ordering issue when switching roles on USB2 ports
>        phy: tegra: xusb: Add ID override support to padctl
>        phy: tegra: xusb: Move .set_mode() to a shared location
>        phy: tegra: xusb: Move T186 .set_mode() to common implementation
> 
>   drivers/phy/tegra/xusb-tegra186.c   | 73 +++++----------------------------
>   drivers/phy/tegra/xusb-tegra210.c   | 42 +------------------
>   drivers/phy/tegra/xusb.c            | 80 +++++++++++++++++++++++++++++++++++++
>   drivers/phy/tegra/xusb.h            |  4 ++
>   drivers/usb/gadget/udc/tegra-xudc.c |  4 ++
>   drivers/usb/host/xhci-tegra.c       | 14 ++++---
>   include/linux/phy/tegra/xusb.h      |  3 ++
>   7 files changed, 111 insertions(+), 109 deletions(-)
> ---
> base-commit: b02a5530af8abe0d3cd4852ba48990716e962934
> change-id: 20251201-diogo-tegra_phy-86c89cab7377
> 
> Best regards,

