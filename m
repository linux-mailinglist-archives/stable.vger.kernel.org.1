Return-Path: <stable+bounces-229849-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKLADCt+wWknTgQAu9opvQ
	(envelope-from <stable+bounces-229849-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:53:47 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 511C72FA937
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2641430D9E30
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFA13BE17D;
	Mon, 23 Mar 2026 16:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b="SwGLjMrK"
X-Original-To: stable@vger.kernel.org
Received: from smtp1.tecnico.ulisboa.pt (smtp1.tecnico.ulisboa.pt [193.136.128.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6273BB9F6;
	Mon, 23 Mar 2026 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.136.128.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283029; cv=none; b=Ei9sy74AW0xNAOzunvYVD7TDfe6hWaayzJPc1mPOzq9NTbZvhSJl+CW4JZ0ov6dbfrNV2Q7/jfDnB8r7Twz1Av8EKsVsQnP5N4cNuVD0I3Yh8BbznN+/GDSmYQkORXLYnrlNDV3KUEFpNWTuVvFLfeYDFZ47I7h/E6hOSn7UxaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283029; c=relaxed/simple;
	bh=AiYR3m9OPMS94EYaKPIpJW6EJB1OAUUOLjUwhjl9HPw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7glgbpiy/WVb4t6sGriqxfNK17JOjzLGGRUgd7QWzWulxjNGew6gUlPKEiKgFiO5/K9/3lvKaFDfzk3bAoxZLSdkd2A5jUnBHV6mWcB+LmBdqYlyIOYHUQKFRTXKUn8zfnVZInNAdxnNHbtA4b3srAS+Xwd28h3rIOYa6DlclI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt; spf=pass smtp.mailfrom=tecnico.ulisboa.pt; dkim=pass (2048-bit key) header.d=tecnico.ulisboa.pt header.i=@tecnico.ulisboa.pt header.b=SwGLjMrK; arc=none smtp.client-ip=193.136.128.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tecnico.ulisboa.pt
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tecnico.ulisboa.pt
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTP id C350E600882A;
	Mon, 23 Mar 2026 16:15:46 +0000 (WET)
X-Virus-Scanned: by amavis-2.13.0 (20230106) (Debian) at tecnico.ulisboa.pt
Received: from smtp1.tecnico.ulisboa.pt ([127.0.0.1])
 by localhost (smtp1.tecnico.ulisboa.pt [127.0.0.1]) (amavis, port 10025)
 with LMTP id 126tTdIN8NTm; Mon, 23 Mar 2026 16:15:44 +0000 (WET)
Received: from mail1.tecnico.ulisboa.pt (mail1.ist.utl.pt [193.136.128.10])
	by smtp1.tecnico.ulisboa.pt (Postfix) with ESMTPS id E2AB36008813;
	Mon, 23 Mar 2026 16:15:42 +0000 (WET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tecnico.ulisboa.pt;
	s=mail2; t=1774282543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oxX+OUc3xAG2hwZFdRqs0R//MKXMT1i1SmwKlI7QCUU=;
	b=SwGLjMrK9ln3TcNEAy+X0mypZiqlB9obo5qLLYD5EBTUgUj81QnjKt4tNkkCO/mjjfLHo2
	Y3PEOU09sIAODUjaPNDpqo8otBGKVMH1F3dMorf4JQkK59Kd9t8gDl0REdd3ML2ISfa8Nz
	xrmRUHJjFZk015wqZPQfQEY+5UCcGar+nTkVXv5d0H7/JE04N/KYuScurMaSJD+96Gidfo
	dZjlL3FAbJq76/l/qMwZIXalTwJLtpmVI+NFuV0B5AIO8SCGPyqLBrFoIElXWbMarS1Zka
	u4xxGAi8SdMWEwhWRMzTd2WgoTDOZ6Z04F/vuH6KRUMU+VLL9EJCGdzVPKcEYw==
Received: from [IPV6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde] (unknown [IPv6:2001:8a0:57db:f00:3ee2:38aa:e2c9:7dde])
	(Authenticated sender: ist187313)
	by mail1.tecnico.ulisboa.pt (Postfix) with ESMTPSA id 767D33601AC;
	Mon, 23 Mar 2026 16:15:41 +0000 (WET)
Message-ID: <54167943-deac-40ec-be86-7ddc6b015c2d@tecnico.ulisboa.pt>
Date: Mon, 23 Mar 2026 16:15:24 +0000
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tecnico.ulisboa.pt,quarantine];
	R_DKIM_ALLOW(-0.20)[tecnico.ulisboa.pt:s=mail2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229849-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[intel.com,linuxfoundation.org,gmail.com,nvidia.com,kernel.org,linaro.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tecnico.ulisboa.pt:dkim,tecnico.ulisboa.pt:mid];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 511C72FA937
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Ping on this series as it has been quite a while since this was sent out
originally.

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

