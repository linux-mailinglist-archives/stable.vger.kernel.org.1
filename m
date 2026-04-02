Return-Path: <stable+bounces-233093-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JpZKCS0zmlVpgYAu9opvQ
	(envelope-from <stable+bounces-233093-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:23:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EB47738D09A
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 20:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5B1230B6E50
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB5B3033C6;
	Thu,  2 Apr 2026 18:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="mP230O7G"
X-Original-To: stable@vger.kernel.org
Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89E4317148
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 18:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775153726; cv=none; b=CKk3+R6cAFg51fGpn+FxpNBpKx9m0DmNcWlbx83vq+siRAZPx24OWkMVhFAQGykyHdwXzBy3PowKOw7RbudBQpAgZ7+RLtlLFzd5RJMHRFreaExFsE7Oxt/Qvbl7UtgYmSuuBEpGFwjEZzeENr8LFju538IJ0yQ10nreCSFCsVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775153726; c=relaxed/simple;
	bh=uiqCnhe7JFhzANWyg1lhqpRP1xpTm0+lrlk872mdWpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hfGed93MY0TkmabXFpyey8ORc9UBKFjvgVTQxI4z8HGRrFy2mUt9vImNaDNZiYIC9DRvbjHUDkTlnU0Nl418Ike5i6Pa5NpeNJQIgxDZDRIEeM4CoP0ns2wO/jcYiFmulftMBq8KHR9lxSSmV+NDLtiFwwUX94VBYt8Gu8mhZew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=mP230O7G; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Received: from [192.168.178.25] (i5C75F65A.versanet.de [92.117.246.90])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPSA id ED1D82FC0215;
	Thu,  2 Apr 2026 20:15:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1775153716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HClUk7kEUh+F8u20b5Cp4UK+o9jbxVwWDZQO8RU9YBU=;
	b=mP230O7G4e91fJS9MNlzbRZCD4FJob8KilRl1td9aN/qu5/6Yfsowy2L3+AWE6mROYPJiv
	oZ5ZSVCT0ChSoe9badkv7x3+lqmFi/alNw9TwlwulJ/fKwWoJzPN+wKqfXgHWPmuFmh4iv
	eYGOXVrgmWhx/GsK9V+o9sLzHj2tfBM=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
Message-ID: <34721017-9541-42c2-baee-d7d0aed6ac60@tuxedocomputers.com>
Date: Thu, 2 Apr 2026 20:15:15 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda/hdmi: Add quirk for TUXEDO IBS14G6
To: stable@vger.kernel.org
Cc: Aaron Erhardt <aer@tuxedocomputers.com>
References: <20260303185944.48669-1-wse@tuxedocomputers.com>
Content-Language: en-US
From: Werner Sembach <wse@tuxedocomputers.com>
In-Reply-To: <20260303185944.48669-1-wse@tuxedocomputers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[tuxedocomputers.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[tuxedocomputers.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233093-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tuxedocomputers.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wse@tuxedocomputers.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB47738D09A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

Am 03.03.26 um 19:56 schrieb Werner Sembach:
> From: Aaron Erhardt <aer@tuxedocomputers.com>
>
> [ Upstream commit d649c58bcad8fb9b749e3837136a201632fa109d ]
>
> Depending on the timing during boot, the BIOS might report wrong pin
> capabilities, which can lead to HDMI audio being disabled. Therefore,
> force HDMI audio connection on TUXEDO InfinityBook S 14 Gen6.
>
> Signed-off-by: Aaron Erhardt <aer@tuxedocomputers.com>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Link: https://patch.msgid.link/20260218213234.429686-1-wse@tuxedocomputers.com
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
> Change from upstream commit: The file was renamed sometime after v6.12.
> There is already a pending patch for 6.18.y and 6.19.y. This is for all
> stable released including 6.12.y and before with the old filename.

Just a gentle bump, hope it can land soon. Still applies cleanly to 6.12.y.

Best regards,

Werner

>
>   sound/pci/hda/patch_hdmi.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
> index 70a90117361c5..a5ebd2a9a1116 100644
> --- a/sound/pci/hda/patch_hdmi.c
> +++ b/sound/pci/hda/patch_hdmi.c
> @@ -1999,6 +1999,7 @@ static const struct snd_pci_quirk force_connect_list[] = {
>   	SND_PCI_QUIRK(0x1043, 0x86ae, "ASUS", 1),  /* Z170 PRO */
>   	SND_PCI_QUIRK(0x1043, 0x86c7, "ASUS", 1),  /* Z170M PLUS */
>   	SND_PCI_QUIRK(0x1462, 0xec94, "MS-7C94", 1),
> +	SND_PCI_QUIRK(0x1558, 0x14a1, "TUXEDO InfinityBook S 14 Gen6", 1),
>   	SND_PCI_QUIRK(0x8086, 0x2060, "Intel NUC5CPYB", 1),
>   	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", 1),
>   	{}

