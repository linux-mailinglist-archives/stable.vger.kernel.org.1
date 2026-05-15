Return-Path: <stable+bounces-247629-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iG2cIofpBmpKowIAu9opvQ
	(envelope-from <stable+bounces-247629-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:38:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAB54C8DA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 11:38:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 98AF930F1F20
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FC143D516;
	Fri, 15 May 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FECjXTAB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LM3vZH3u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tF5tMWAh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/UL8X7Vg"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DD643E489
	for <stable@vger.kernel.org>; Fri, 15 May 2026 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778836921; cv=none; b=eIRl+p2QNdN5DF5aaVm3Fg+BRQ0OvX26f0AsLRMRasx+FP66YUIPSSxC0VlShrKt5lHatHphQIq/K+76OFXm6K2kh3UhebVRFJmJh6j5uaWEojgW3xkuTsDyZd1C5yTVfFsoJyOD8cHw35vGTiy8Zrojs0oztE0CLxXjOReUZjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778836921; c=relaxed/simple;
	bh=BzIZ2Js6Ee3WqJhSyTJNHhDtTiyLZnraCSY+K9Ta9X0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=syyWNMnPYp8cCS9ryPINR1SJzu3URBlkYfgEszoCkZALqQwagUMhOmQlnjH1HZKvI3dbBbJJnyZjoeMghNnsG2bQnVTNlpDsa7JYqg3Nbbjv97Nt2m27nTxAsu9brj2hLgc9TlXSlutLWkEGHJPOVs9KMp0Sz72kEoOxfhbYz0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FECjXTAB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LM3vZH3u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tF5tMWAh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=/UL8X7Vg; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B379A5CFC9;
	Fri, 15 May 2026 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778836918; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=FECjXTABr4ThkQ+cxBcfFo3FJIW8Vr8VEVyKAsBU8IiRWuzy+YsDbSBGkkg2Ln4MSNYzoc
	NYlhN0EV/Csbse+Q05sQmoafkYnh/sA831R5x9XTxKnxbLPuXE9hiUysyKV+Np9OiYvreI
	mBTkKjhAS54Bk/soTA++G3SFL8u8JfM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778836918;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=LM3vZH3u9yuLa7+udBWkkEm5Bz1JxIbH0NCLySJ9yp5/j0AqF+nV+CESsywn+7HEheOomB
	rxcKPcNiJPA30jDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=tF5tMWAh;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/UL8X7Vg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778836917; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=tF5tMWAhHY0+eirCEkDkyM1L5NQMmB0zVumlVNFt/KLBy9e6ctigH3XdtH+x8ybNQf1z8l
	OfbzRmpjmKge+5/g1x66ETUAp8NxzBgA7TWDOMfntB70V+jx3d5nRsH9fonH1OaHFRahjX
	ZCkoNE03rlAR0j2Hpp3suWplixc7rBc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778836917;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qgsCfFEjyOA/Igt3r/ROXBd/VbetbI06f99NuQF6Hwk=;
	b=/UL8X7VgEB9fszJkueKxUSpN8+Z8kQ8q6Xa7FnEDYL1g4Tzx+Y6kM15/jHIn9clITnyffB
	MInAcVhg10sOzSAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692B6593A9;
	Fri, 15 May 2026 09:21:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id p2BhGLXlBmowaQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 09:21:57 +0000
Date: Fri, 15 May 2026 11:21:56 +0200
Message-ID: <87h5o9t4cr.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>,
	virtualization@lists.linux.dev,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: virtio: Validate control metadata from the device
In-Reply-To: <20260507-alsa-virtio-validate-kctl-info-v1-1-7404fb12ec37@gmail.com>
References: <20260507-alsa-virtio-validate-kctl-info-v1-1-7404fb12ec37@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 0CFAB54C8DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247629-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, 07 May 2026 16:28:30 +0200,
Cássio Gabriel wrote:
> 
> virtio-snd control handling trusts the device-provided control type and
> value count returned by the device.
> 
> That metadata is then used directly to index g_v2a_type_map[] in
> virtsnd_kctl_info(), and to size loops and memcpy() operations in
> virtsnd_kctl_get() and virtsnd_kctl_put() against fixed-size
> virtio_snd_ctl_value and snd_ctl_elem_value arrays.
> 
> A buggy or malicious device can therefore trigger out-of-bounds access by
> advertising an invalid control type or an oversized value count.
> 
> Validate control type and count once in virtsnd_kctl_parse_cfg(), before
> querying enumerated items or exposing the control to ALSA.
> 
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied to for-next branch now.  Thanks.


Takashi

