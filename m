Return-Path: <stable+bounces-244955-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKSNIq01/2kZ3gAAu9opvQ
	(envelope-from <stable+bounces-244955-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 15:25:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD23A4FFD8F
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 15:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE234300CC05
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 13:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1331F350A10;
	Sat,  9 May 2026 13:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b="e/Q2yBci"
X-Original-To: stable@vger.kernel.org
Received: from wp23.hostingpalvelu.fi (wp23.hostingpalvelu.fi [31.217.193.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0E433AD85;
	Sat,  9 May 2026 13:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=31.217.193.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778333094; cv=none; b=UUJy3ueSoVZ+HJcM0N2lqiMy+Up3ewDWESUayA0zNrGc5vzAMBTV3GTWmKSkN9OfBL/yH+wIKbNKxdY1pmOjda1zxA7n93GdGWlZGWuNK8A2V1RErTjO6N27J37vQc1zkQTIhUJofh5KRZyJmQTlHxAiYX0ci+jy0FsUAyjSyyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778333094; c=relaxed/simple;
	bh=BYERFdzVwseNfC2vrObzQ3PhWml7Dy27ykbtisPee/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ajku8KRkcVWiEkoY20H/tKoxSCr8HI+39vXtvfH2rQ2JNbdOKAkLRZFGqBq6Q3r7Wh1KjLYvd3dOG43/7XlHTytT8syk50LHoIIGZ0DGbf0VXLzBBP0rHwvITLeiS1OHX4nLnTHFlZbxEF4T+23azCMUQj5+p/tvsE4visT2c9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com; spf=pass smtp.mailfrom=bitmer.com; dkim=pass (2048-bit key) header.d=bitmer.com header.i=@bitmer.com header.b=e/Q2yBci; arc=none smtp.client-ip=31.217.193.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bitmer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitmer.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bitmer.com;
	s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pvf/MS/zmru/6FmL1UWsPRZanqYhC55RQ91wErIwJiM=; b=e/Q2yBci0VQjx4P4lAFOVxeDKP
	9fA6rGGNpLd+Z8e9kc5BGpXuBbAMzdp5ezUxc3pCAXg7BrgMjgmT8rMJWQtWi71rPd6OzxrgmGIF4
	Kngiez+2YDurLH2yXVCcrJY0NrhrIiFX33sPY4kC9UpbG7YfviBNAXilzMaSSnvv5AZADXjSMqla5
	5Isxem7ooJ4Fl5rEQ5mWbmTJFU1Yta0pio26QVhwdWh6ByiJz0MuBHCFJUpiBtEpaq/EhZFz6nJeU
	Nbjuz9CfIT3s5NvNjAGxvAm9KFB6dZUv5/DWaUsrdm7SUwBoVo4ChpCxU4bzhVSI1FB3B41wNHk9n
	hSsMIW8w==;
Received: from 81-197-209-194.elisa-laajakaista.fi ([81.197.209.194]:50140 helo=[192.168.0.12])
	by wp23.hostingpalvelu.fi with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.99.2)
	(envelope-from <jarkko.nikula@bitmer.com>)
	id 1wLhfl-00000003c5b-09Al;
	Sat, 09 May 2026 16:24:45 +0300
Message-ID: <45dabfd5-5976-4815-a41e-c7b218c8cfd5@bitmer.com>
Date: Sat, 9 May 2026 16:24:43 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: soc: ti: omap3pandora: fix stale ARM machine ID
 check to use DT
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org,
 Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Grazvydas Ignotas <notasas@gmail.com>,
 "H. Nikolaus Schaller" <hns@goldelico.com>, Tony Lindgren <tony@atomide.com>
References: <20260509020809.33060-1-enelsonmoore@gmail.com>
Content-Language: en-US
From: Jarkko Nikula <jarkko.nikula@bitmer.com>
In-Reply-To: <20260509020809.33060-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - wp23.hostingpalvelu.fi
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - bitmer.com
X-Get-Message-Sender-Via: wp23.hostingpalvelu.fi: authenticated_id: jarkko.nikula@bitmer.com
X-Authenticated-Sender: wp23.hostingpalvelu.fi: jarkko.nikula@bitmer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Queue-Id: CD23A4FFD8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[bitmer.com : SPF not aligned (relaxed),quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[bitmer.com:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	HAS_X_AS(0.00)[jarkko.nikula@bitmer.com];
	FROM_HAS_DN(0.00)[];
	HAS_X_GMSV(0.00)[jarkko.nikula@bitmer.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.infradead.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244955-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[bitmer.com:-];
	FREEMAIL_CC(0.00)[armlinux.org.uk,vger.kernel.org,gmail.com,kernel.org,perex.cz,suse.com,goldelico.com,atomide.com];
	NEURAL_HAM(-0.00)[-0.989];
	FROM_NEQ_ENVFROM(0.00)[jarkko.nikula@bitmer.com,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	HAS_X_SOURCE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_X_ANTIABUSE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bitmer.com:mid]
X-Rspamd-Action: no action

Hi

On 09/05/2026 5:08 am, Ethan Nelson-Moore wrote:
> The omap3pandora driver contains a check for the ARM machine ID via the
> machine_is_omap3_pandora() macro. This check is incorrect because the
> machine concerned now supports only FDT booting, which does not use
> machine IDs, and therefore it will always fail. The legacy board file
> for this machine was removed in commit 7fcf7e061edd ("ARM: OMAP2+:
> Remove legacy booting support for Pandora"). To resolve this issue, use
> of_machine_is_compatible() instead.
>
> Fixes: b715da74deaf ("ARM: dts: omap3-pandora: add OMAP3530 600 MHz version")
> Fixes: 9ccd0106c9db ("ARM: dts: omap3-pandora: add DM3730 1 GHz version")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  sound/soc/ti/omap3pandora.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

I guess this is the same than rx51 case that machine_is_omap3_pandora()
still returns true. Dunno is there an updated bootloader for it that
doesn't pass anymore the ID but I think only that case would warrant the
Fixes tags?

