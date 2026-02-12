Return-Path: <stable+bounces-215919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEghH9SFjWmx3gAAu9opvQ
	(envelope-from <stable+bounces-215919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:48:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C76B12B025
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 08:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAE28305E9AA
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 07:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB2B28CF50;
	Thu, 12 Feb 2026 07:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tJrVLIXQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6CD29A2;
	Thu, 12 Feb 2026 07:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770882510; cv=none; b=qThos3py5z1hdk6p2a1Z0/T2J0nSxZwQ8rUiwdpsSWVU3vAjYlsUo55OJrJwWLNkFHANg8xcFnt0/aZ03LuXKfnreOIIwmCn5tm1GTbeOzBj99gDtThXO+DniJpMwlh6OFmkSqnqRI7VodiOTDNtE6fpf22w76Pu3qNGEkn5bjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770882510; c=relaxed/simple;
	bh=1v5bdO3G5lcngWEcs9w9BledEi1V0scMHcB9CFT+cQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9uy/Dmyn4qXS10iz5/zDi1L47tUdb8ugGr6W8VOgADsHDZ6SBeNBjCPUr92YEq8OyFSjV381dG6i+8jNAZON8LsF4RioFpEavnZCjLLW36Cb66mnJgp4vefGNTaAvuqtvSOpEF5BgRi/8frEEvoyYvNIPSLauS/ttb7LGAqqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tJrVLIXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBD9BC4CEF7;
	Thu, 12 Feb 2026 07:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770882509;
	bh=1v5bdO3G5lcngWEcs9w9BledEi1V0scMHcB9CFT+cQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tJrVLIXQKkEh2ijH8TE+h+4b1TUgrI+ZoAY41hYtVten+wHw74vCrJjRWaDGUrvov
	 lMSw25ToyvpI5e3Rev11JHdjAEku+VABe+ibKr7/7XgilKmJDsPgP1up5QwwKb/en9
	 tb1lqXbjwUgCzVm3EWeNAyEEr2uKFKgnyqrW/3fs=
Date: Thu, 12 Feb 2026 08:48:25 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Mariusz Skamra <mariusz.skamra@codecoup.pl>
Cc: linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Fix CIS host feature condition
Message-ID: <2026021216-lyrically-tactful-d3b3@gregkh>
References: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260212074111.316980-1-mariusz.skamra@codecoup.pl>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215919-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,codecoup.pl:email]
X-Rspamd-Queue-Id: 8C76B12B025
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 08:41:11AM +0100, Mariusz Skamra wrote:
> This fixes the condition for sending the LE Set Host Feature command.
> The command is sent to indicate host support for Connected Isochronous
> Streams in this case. It has been observed that the system could not
> initialize BIS-only capable controllers because the controllers do not
> support the command.
> 
> As per Core v6.2 | Vol 4, Part E, Table 3.1 the command shall be
> supported if CIS Central or CIS Peripheral is supported; otherwise,
> the command is optional.
> 
> Signed-off-by: Mariusz Skamra <mariusz.skamra@codecoup.pl>
> ---
>  net/bluetooth/hci_sync.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index f04a90bce4a9..0b0dc0965f5a 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4592,7 +4592,7 @@ static int hci_le_set_host_features_sync(struct hci_dev *hdev)
>  {
>  	int err;
>  
> -	if (iso_capable(hdev)) {
> +	if (cis_capable(hdev)) {
>  		/* Connected Isochronous Channels (Host Support) */
>  		err = hci_le_set_host_feature_sync(hdev, 32,
>  						   (iso_enabled(hdev) ? 0x01 :
> -- 
> 2.53.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

