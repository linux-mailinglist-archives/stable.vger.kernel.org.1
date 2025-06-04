Return-Path: <stable+bounces-151330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B5ACDC1F
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 12:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B59A3A38BC
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 10:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD66B28CF6F;
	Wed,  4 Jun 2025 10:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PdL6S8A1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTpPWh2Q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PdL6S8A1";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hTpPWh2Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C58428D8C4
	for <stable@vger.kernel.org>; Wed,  4 Jun 2025 10:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749034104; cv=none; b=G63Ongc1Mc2iKXheRLNrJSPyvLyYZRSN6B0nnKWNgxoGVg9pGXTwDg2bFhRItObtv1AY+5yoIslpdJ918ojXfWIDb0xw6KxdXypJDiwfwL1svGprbuFt1j4Jc89dPm/L/LUJvgvqDgFSHLrNqAZbcRn+OyXJZOycn+GguioGEDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749034104; c=relaxed/simple;
	bh=eMc3z7LPDhbTS1cXhdXmgOby4F0SIeeE/EzWk2butk8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Cz6jfe/U/abIcaJ/ljgD4XDMFrm0/Ue0+kSH5b01VbjD4RltXvatLhn3FeXaKfxDI2jfRb0bm570/r28RDWxR+fT1q8fFxgItiQpsGsx6eYRoMlm5cbH1WJOiVM53+Arv8bejZlVsTcNvzgGzZNjH8aSbQ1XP3XIVWwxMlemPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PdL6S8A1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTpPWh2Q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PdL6S8A1; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hTpPWh2Q; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0433B5D230;
	Wed,  4 Jun 2025 10:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749033465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kxO8WDSe490cbHdHnEXd3fqWy18pk7jWUod9HuQdJns=;
	b=PdL6S8A1HR0YLCczXMQr2/ylJ52KHDwo1+2T+xu4jus22SIvnS+luFeImg/lixedpXH/+M
	QUJedn1xXjavUA4x/XwVr1dcz4c2U5I4p6nkFr6g4WikVzY+AtTAirlPHyb5KCqCoaK2iO
	4+HBvt6QtnXC2fm2d9Kc1o95NaKEo3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749033465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kxO8WDSe490cbHdHnEXd3fqWy18pk7jWUod9HuQdJns=;
	b=hTpPWh2Qw7dQiWZ/xlVXJ6x5fsYNr0SF3PZ2aJo8C1sw84qcxR+qwcrl9J5+Ykq85KYlU3
	SYNJMOZjZ4YPLFAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=PdL6S8A1;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hTpPWh2Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1749033465; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kxO8WDSe490cbHdHnEXd3fqWy18pk7jWUod9HuQdJns=;
	b=PdL6S8A1HR0YLCczXMQr2/ylJ52KHDwo1+2T+xu4jus22SIvnS+luFeImg/lixedpXH/+M
	QUJedn1xXjavUA4x/XwVr1dcz4c2U5I4p6nkFr6g4WikVzY+AtTAirlPHyb5KCqCoaK2iO
	4+HBvt6QtnXC2fm2d9Kc1o95NaKEo3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1749033465;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kxO8WDSe490cbHdHnEXd3fqWy18pk7jWUod9HuQdJns=;
	b=hTpPWh2Qw7dQiWZ/xlVXJ6x5fsYNr0SF3PZ2aJo8C1sw84qcxR+qwcrl9J5+Ykq85KYlU3
	SYNJMOZjZ4YPLFAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C558A13A63;
	Wed,  4 Jun 2025 10:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oDTfLvghQGg9KgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 04 Jun 2025 10:37:44 +0000
Message-ID: <6f2c8516-98e4-4a83-83fd-5e0891de535f@suse.de>
Date: Wed, 4 Jun 2025 12:37:44 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] video: screen_info: Relocate framebuffers behind PCI
 bridges
To: javierm@redhat.com, bhelgaas@google.com, iivanov@suse.de, tiwai@suse.de
Cc: dri-devel@lists.freedesktop.org, linux-pci@vger.kernel.org,
 stable@vger.kernel.org
References: <20250528080234.7380-1-tzimmermann@suse.de>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20250528080234.7380-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 0433B5D230
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

If there are no further comment, I'll merge this patch via drm-misc-fixes.

Am 28.05.25 um 10:02 schrieb Thomas Zimmermann:
> Apply PCI host-bridge window offsets to screen_info framebuffers. Fixes
> invalid access to I/O memory.
>
> Resources behind a PCI host bridge can be relocated by a certain offset
> in the kernel's CPU address range used for I/O. The framebuffer memory
> range stored in screen_info refers to the CPU addresses as seen during
> boot (where the offset is 0). During boot up, firmware may assign a
> different memory offset to the PCI host bridge and thereby relocating
> the framebuffer address of the PCI graphics device as seen by the kernel.
> The information in screen_info must be updated as well.
>
> The helper pcibios_bus_to_resource() performs the relocation of the
> screen_info's framebuffer resource (given in PCI bus addresses). The
> result matches the I/O-memory resource of the PCI graphics device (given
> in CPU addresses). As before, we store away the information necessary to
> later update the information in screen_info itself.
>
> Commit 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated
> EFI framebuffers") added the code for updating screen_info. It is based
> on similar functionality that pre-existed in efifb. Efifb uses a pointer
> to the PCI resource, while the newer code does a memcpy of the region.
> Hence efifb sees any updates to the PCI resource and avoids the issue.
>
> v3:
> - Only use struct pci_bus_region for PCI bus addresses (Bjorn)
> - Clarify address semantics in commit messages and comments (Bjorn)
> v2:
> - Fixed tags (Takashi, Ivan)
> - Updated information on efifb
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> Reported-by: "Ivan T. Ivanov" <iivanov@suse.de>
> Closes: https://bugzilla.suse.com/show_bug.cgi?id=1240696
> Tested-by: "Ivan T. Ivanov" <iivanov@suse.de>
> Fixes: 78aa89d1dfba ("firmware/sysfb: Update screen_info for relocated EFI framebuffers")
> Cc: dri-devel@lists.freedesktop.org
> Cc: <stable@vger.kernel.org> # v6.9+
> ---
>   drivers/video/screen_info_pci.c | 79 +++++++++++++++++++++------------
>   1 file changed, 50 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/video/screen_info_pci.c b/drivers/video/screen_info_pci.c
> index 6c5833517141..66bfc1d0a6dc 100644
> --- a/drivers/video/screen_info_pci.c
> +++ b/drivers/video/screen_info_pci.c
> @@ -7,8 +7,8 @@
>   
>   static struct pci_dev *screen_info_lfb_pdev;
>   static size_t screen_info_lfb_bar;
> -static resource_size_t screen_info_lfb_offset;
> -static struct resource screen_info_lfb_res = DEFINE_RES_MEM(0, 0);
> +static resource_size_t screen_info_lfb_res_start; // original start of resource
> +static resource_size_t screen_info_lfb_offset; // framebuffer offset within resource
>   
>   static bool __screen_info_relocation_is_valid(const struct screen_info *si, struct resource *pr)
>   {
> @@ -31,7 +31,7 @@ void screen_info_apply_fixups(void)
>   	if (screen_info_lfb_pdev) {
>   		struct resource *pr = &screen_info_lfb_pdev->resource[screen_info_lfb_bar];
>   
> -		if (pr->start != screen_info_lfb_res.start) {
> +		if (pr->start != screen_info_lfb_res_start) {
>   			if (__screen_info_relocation_is_valid(si, pr)) {
>   				/*
>   				 * Only update base if we have an actual
> @@ -47,46 +47,67 @@ void screen_info_apply_fixups(void)
>   	}
>   }
>   
> +static int __screen_info_lfb_pci_bus_region(const struct screen_info *si, unsigned int type,
> +					    struct pci_bus_region *r)
> +{
> +	u64 base, size;
> +
> +	base = __screen_info_lfb_base(si);
> +	if (!base)
> +		return -EINVAL;
> +
> +	size = __screen_info_lfb_size(si, type);
> +	if (!size)
> +		return -EINVAL;
> +
> +	r->start = base;
> +	r->end = base + size - 1;
> +
> +	return 0;
> +}
> +
>   static void screen_info_fixup_lfb(struct pci_dev *pdev)
>   {
>   	unsigned int type;
> -	struct resource res[SCREEN_INFO_MAX_RESOURCES];
> -	size_t i, numres;
> +	struct pci_bus_region bus_region;
>   	int ret;
> +	struct resource r = {
> +		.flags = IORESOURCE_MEM,
> +	};
> +	const struct resource *pr;
>   	const struct screen_info *si = &screen_info;
>   
>   	if (screen_info_lfb_pdev)
>   		return; // already found
>   
>   	type = screen_info_video_type(si);
> -	if (type != VIDEO_TYPE_EFI)
> -		return; // only applies to EFI
> +	if (!__screen_info_has_lfb(type))
> +		return; // only applies to EFI; maybe VESA
>   
> -	ret = screen_info_resources(si, res, ARRAY_SIZE(res));
> +	ret = __screen_info_lfb_pci_bus_region(si, type, &bus_region);
>   	if (ret < 0)
>   		return;
> -	numres = ret;
>   
> -	for (i = 0; i < numres; ++i) {
> -		struct resource *r = &res[i];
> -		const struct resource *pr;
> -
> -		if (!(r->flags & IORESOURCE_MEM))
> -			continue;
> -		pr = pci_find_resource(pdev, r);
> -		if (!pr)
> -			continue;
> -
> -		/*
> -		 * We've found a PCI device with the framebuffer
> -		 * resource. Store away the parameters to track
> -		 * relocation of the framebuffer aperture.
> -		 */
> -		screen_info_lfb_pdev = pdev;
> -		screen_info_lfb_bar = pr - pdev->resource;
> -		screen_info_lfb_offset = r->start - pr->start;
> -		memcpy(&screen_info_lfb_res, r, sizeof(screen_info_lfb_res));
> -	}
> +	/*
> +	 * Translate the PCI bus address to resource. Account
> +	 * for an offset if the framebuffer is behind a PCI host
> +	 * bridge.
> +	 */
> +	pcibios_bus_to_resource(pdev->bus, &r, &bus_region);
> +
> +	pr = pci_find_resource(pdev, &r);
> +	if (!pr)
> +		return;
> +
> +	/*
> +	 * We've found a PCI device with the framebuffer
> +	 * resource. Store away the parameters to track
> +	 * relocation of the framebuffer aperture.
> +	 */
> +	screen_info_lfb_pdev = pdev;
> +	screen_info_lfb_bar = pr - pdev->resource;
> +	screen_info_lfb_offset = r.start - pr->start;
> +	screen_info_lfb_res_start = bus_region.start;
>   }
>   DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_ANY_ID, PCI_ANY_ID, PCI_BASE_CLASS_DISPLAY, 16,
>   			       screen_info_fixup_lfb);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


