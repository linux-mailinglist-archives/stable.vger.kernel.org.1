Return-Path: <stable+bounces-230282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AAU7ONaiw2lssQQAu9opvQ
	(envelope-from <stable+bounces-230282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:54:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0A2321B20
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B80373024504
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 08:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3100B39A049;
	Wed, 25 Mar 2026 08:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="buPyr8S1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BB830C366
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 08:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774428884; cv=none; b=qIDCU98zDQstldnrYng2lWl8WeYnjQRT37jsLoj4ZzAqJ8Wttrw/mQTxIHvK1p0fxjiVluWZ7MAkSoTMNhNGszEEW/GTo2QTBFZ10Q6x4185Om3mwqGy8Vf2hRTyUwoDVVcUYJJ/b0auJK5b5V/Evq5OLy3Tl9P3KgYw+AQ3YVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774428884; c=relaxed/simple;
	bh=181LJJSr+VqdA9G5EcHAo2ZcMUdhse3ksWkeV4TVQGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZWrYFdeANIH4TClGCdp8Som0ct6wagTIsi6+6WgSYpzASJ8BmmdoZowAdqLGQKHtIwkR3RUzy6uAcLIi7TsfsDY83FhIz9VlmaQDEkZ4Yb+w+bDiU6xPQLd+6v6Eu3HvE7OMNcIPLj7Ncb8Vd1edRVzIpppJ026ya4HNlB6fDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=buPyr8S1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C70C4CEF7;
	Wed, 25 Mar 2026 08:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774428883;
	bh=181LJJSr+VqdA9G5EcHAo2ZcMUdhse3ksWkeV4TVQGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=buPyr8S19yhDSlTcmQdmSdNCEJlGi+bJ3hbaJsOEoMVVZ3YWq1QYi00ADizZ5B6T0
	 7qwv5Icr73ku8IVLkZ/XtfuNr3oMEwqM33gtC7i8VScSxUToZ6LPbj+4b4LeBRZDPG
	 qLVRmEp92/SfJIeXvFp9JZGyUfMfZsmrPfkM6UNk=
Date: Wed, 25 Mar 2026 09:54:20 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Dima Art <artdima93@gmail.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for HP Victus 15-fa2xxx
Message-ID: <2026032514-exes-repave-9420@gregkh>
References: <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACHgFRk+WSTAhhm4BbWwfqUMVCTJL4uTLK9+=8D6odKMq8BxAQ@mail.gmail.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230282-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C0A2321B20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 10:25:03PM +0000, Dima Art wrote:
> The HP Victus 15-fa2xxx (subsystem ID 103c:8dcd) uses two TAS2781
> amplifiers connected via I2C bus at addresses 0x36 and 0x37.
> Without this quirk, the amplifiers remain uninitialized causing
> mono audio output with no bass.
> 
> Tested on HP Victus 15-fa2xxx (HP-VictusbyHPGamingLaptop15_fa2xxx--8DCD)
> with kernel 6.19.0-9-generic on Ubuntu 26.04.
> 
> Signed-off-by: ardima93@gmail.com
> ---
>  sound/pci/hda/patch_realtek.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
> --- a/sound/pci/hda/patch_realtek.c
> +++ b/sound/pci/hda/patch_realtek.c
> @@ alc269_fixup_tbl[] @@
> +    SND_PCI_QUIRK(0x103c, 0x8dcd, "HP Victus 15-fa2xxx",
> ALC245_FIXUP_TAS2781_I2C),
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

