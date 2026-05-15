Return-Path: <stable+bounces-247408-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFmMIafCBmpdngIAu9opvQ
	(envelope-from <stable+bounces-247408-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:52:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A3954A262
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 08:52:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1ACBA3027C6D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 06:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E73C13FD;
	Fri, 15 May 2026 06:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NIwxRL+u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cyqRQcKz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NIwxRL+u";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cyqRQcKz"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8BE363C4A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 06:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778827940; cv=none; b=mFXsklhHhTfw33ORY2wir71bChNrR5FpRgI3GuxUK8syBid3WhSL8zJC2mj9QWR9bCYeyC6XsOQLQrsGkjmffqZMwVpScIKFcr8ftYnCiwq8SuljF25jWbVsCTareD7BOyv7pGyNIQlGoCO+R3T6es+uHAuxUxbApO4TXwmo8fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778827940; c=relaxed/simple;
	bh=tWuUm2mwbcJ4rbivt2NwYTSnQNVNKTVRWkuENrADWPo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=frgXA71lG+O1OBNYLEeK9FxUbADRAYH7H5bTHxd64qJ/zbSrrcAZHoY4/ofymO62zfKaLYMzq/kziWnYaNG3n8mhFOWAg3XsHhJpcqU1D4napj3EJGc/m1LZBdSzBeHZd+ebtZamhufM3OyPWSmpZUVuUJDuhtZqNyfiyhV2VPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NIwxRL+u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cyqRQcKz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NIwxRL+u; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cyqRQcKz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 84F9367684;
	Fri, 15 May 2026 06:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778827936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+AdS6SSgbLPMNBbL/0rBzhTfkZXvAnba8Rxn6lqoo=;
	b=NIwxRL+ubn76TL3bFNV4QSSMEcpxaOT2EoHZipa9X+y6YO+jU5HTo5uiJYNESgWEYV4UuZ
	W3dEgU0YdlZnqXkVrcCJbOtlwNuHkO0dUlFtLos3dNjNPBbZsrdqJqYpcnErYII3tpdkjh
	qCvPsgRrJxOaTz2w2mlGwKM3o+O98Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778827936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+AdS6SSgbLPMNBbL/0rBzhTfkZXvAnba8Rxn6lqoo=;
	b=cyqRQcKzV2SotHYrdy0wGop/HryCA5Pr+SeatEaliYB1QjdjkqPIYeHN65SZfxdKxmWxFd
	MOFbTa6ek8jcmrAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NIwxRL+u;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=cyqRQcKz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778827936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+AdS6SSgbLPMNBbL/0rBzhTfkZXvAnba8Rxn6lqoo=;
	b=NIwxRL+ubn76TL3bFNV4QSSMEcpxaOT2EoHZipa9X+y6YO+jU5HTo5uiJYNESgWEYV4UuZ
	W3dEgU0YdlZnqXkVrcCJbOtlwNuHkO0dUlFtLos3dNjNPBbZsrdqJqYpcnErYII3tpdkjh
	qCvPsgRrJxOaTz2w2mlGwKM3o+O98Js=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778827936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eW+AdS6SSgbLPMNBbL/0rBzhTfkZXvAnba8Rxn6lqoo=;
	b=cyqRQcKzV2SotHYrdy0wGop/HryCA5Pr+SeatEaliYB1QjdjkqPIYeHN65SZfxdKxmWxFd
	MOFbTa6ek8jcmrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3BDB2593A9;
	Fri, 15 May 2026 06:52:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NuM3DaDCBmqzTwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 15 May 2026 06:52:16 +0000
Date: Fri, 15 May 2026 08:52:15 +0200
Message-ID: <87ecjdupuo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Wesley Cheng <quic_wcheng@quicinc.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH RESEND] ALSA: usb-audio: qcom: Check offload mapping failures
In-Reply-To: <20260511-alsa-usb-qcom-offload-map-errors-v1-1-6502695e58bc@gmail.com>
References: <20260511-alsa-usb-qcom-offload-map-errors-v1-1-6502695e58bc@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 28A3954A262
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-247408-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Action: no action

On Mon, 11 May 2026 06:36:37 +0200,
Cássio Gabriel wrote:
> 
> uaudio_transfer_buffer_setup() calls dma_get_sgtable() and then passes
> the sg_table to uaudio_iommu_map_xfer_buf() without checking whether sg
> table construction succeeded. If dma_get_sgtable() fails, the sg_table
> contents are not valid.
> 
> uaudio_iommu_map_pa() also ignores iommu_map() failures for the event and
> transfer rings and still returns the allocated IOVA to the QMI response.
> That can expose an unmapped IOVA to the audio DSP. For transfer rings,
> the failed mapping also leaves the IOVA allocator state marked in use.
> 
> Check both operations. Free the coherent transfer buffer when sg table
> construction fails, free the sg table when transfer-buffer IOMMU mapping
> fails, and release the transfer-ring IOVA if iommu_map() fails. Also
> return the existing event-ring IOVA when the event ring is already mapped,
> matching the pre-split helper behavior.
> 
> Fixes: 326bbc348298 ("ALSA: usb-audio: qcom: Introduce QC USB SND offloading support")
> Fixes: 44499ecb4f28 ("ALSA: usb: qcom: Fix false-positive address space check")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied now.  Thanks.


Takashi

