Return-Path: <stable+bounces-244337-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oP+6BFj2+mk1UwMAu9opvQ
	(envelope-from <stable+bounces-244337-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:05:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B732B4D7992
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 10:05:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31FD8300E5F6
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 08:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686873CF698;
	Wed,  6 May 2026 08:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UneSjBEe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AkQAKAIS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gI8q1zrS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zTiqIwJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83A9378D87
	for <stable@vger.kernel.org>; Wed,  6 May 2026 08:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778054736; cv=none; b=hAdR8TQBk03okBiiTUnOTZE8d97FHKJZs5eTzMlBteGvsVG1dMsyb8rN5394pUkyP8OnnDIfbH3b6q9fAtURF8IZ4hKeyeLz7vUFiPVLpaO6taoccKzJcuw+EOPwja9XVDgb/L0c3r0v2OWAnSZWuWx5jo0MdTsD3Sz+dqoSP7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778054736; c=relaxed/simple;
	bh=0ps8bJK6DcNXN0UOauIdpXg3SPcwwpcGNr3Dnt/+Txw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoolndH5F6v/hVFCbhcywoZcqnbDZ7HiuDfpImy8CfLuT9F5k0NXD6V8rY+mxPS05IHEdr/vMbktA2e/N5ils/6jnkeplUC+Cs4h7ZAgbXtl6DNb0tmnPjdzVDfiM3dTNXcubnIbD7qrQa7Uo5pN7e/7ghbx3MSxuKKH3EAwqMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UneSjBEe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AkQAKAIS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=gI8q1zrS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=zTiqIwJa; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E75AA5CE13;
	Wed,  6 May 2026 08:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778054733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAg/SWP8vgBEMcklkvAaUbpWAr2r4ID1DcmDiUQam6Q=;
	b=UneSjBEeqssb5G9KiZdL/0WbXYGPS4UZiMNBNLVEM29BJOT2AmupjC8cktgQ1HeSj50+Of
	BYt1jnc2lcKyusERiGqPktQQSrSe3xAG5MzUSA3kbfWsPYWv4HFVmM8a7o+ZXmHuEShRlV
	BA8J/kTGfOZi46v4Epw2HebNlssPwWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778054733;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAg/SWP8vgBEMcklkvAaUbpWAr2r4ID1DcmDiUQam6Q=;
	b=AkQAKAISuUeV6L5FdICJdt2Nd/u5jcCdo90huU+qnyYpq1qPDoeQeE0lFzvI3Bg8KTO7J0
	IOh2VNONW4UnM4CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778054730; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAg/SWP8vgBEMcklkvAaUbpWAr2r4ID1DcmDiUQam6Q=;
	b=gI8q1zrS0FOrv6OoworiuBinhk6LR9Z3zoB0232KguX+GVtuFA8/zj/X+BX6sA8Vwd7qUv
	KYs4S/GYNiFTSWXsCOIMZwQKnaD4ZKf80IQc85qnW7JkNQm/cFWQ2h0lpuI7E/S7K3FDyo
	mt7zPDVi3yVUTVFlH4e2AMwb7nwAQCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778054730;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAg/SWP8vgBEMcklkvAaUbpWAr2r4ID1DcmDiUQam6Q=;
	b=zTiqIwJa6uM1gfXDlLzG6ckGt6OEu+6tSpkgNGbZ7qkziT+pSLry8XHYG1TW3Kn3/kLAjs
	Uk/FE2L2BBXFstBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7A62E593A3;
	Wed,  6 May 2026 08:05:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RfZ6HEr2+mnEKgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 06 May 2026 08:05:30 +0000
Date: Wed, 06 May 2026 10:05:30 +0200
Message-ID: <874iklt12t.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Takashi Iwai <tiwai@suse.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 0/2] firmware_loader/ALSA: Fix TAS2781 async firmware teardown
In-Reply-To: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com>
References: <20260505-alsa-hda-tas2781-fw-callback-teardown-v4-0-e7c4bf930dc8@gmail.com>
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
X-Spam-Score: -3.30
X-Spam-Level: 
X-Rspamd-Queue-Id: B732B4D7992
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244337-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[suse.de:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[suse.de:query timed out,msgid.link:query timed out];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[suse.de:query timed out,msgid.link:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	RBL_SEM_FAIL(0.00)[172.105.105.114:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid,msgid.link:url]

On Tue, 05 May 2026 13:18:15 +0200,
Cássio Gabriel wrote:
> 
> TAS2781 HDA I2C and SPI queue RCA firmware loading with
> request_firmware_nowait() during component bind. The firmware loader
> keeps the callback module pinned and holds a device reference, but it
> does not provide a way for drivers to cancel or synchronize the queued
> callback before tearing down driver-private state.
> 
> Add a small firmware-loader helper to cancel or synchronize async firmware
> requests, then use it from TAS2781 HDA unbind before controls and DSP state
> are removed.
> 
> No hardware runtime test was available.
> 
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>
> ---
> Changes in v4:
> - Use spin_lock_irq() in the worker and cancel paths, which run from
>   sleepable contexts.
> - Fold kfree(fw_work) into firmware_work_free().
> - Keep irqsave in the request path so GFP_ATOMIC callers do not depend on
>   IRQ state assumptions.
> - Link to v3: https://patch.msgid.link/20260501-alsa-hda-tas2781-fw-callback-teardown-v3-0-8d9f873b97bd@gmail.com
> 
> Changes in v3:
> - Keep request_firmware_nowait() manually managed instead of making the
>   existing API implicitly devres-managed.
> - Track scheduled async firmware work in an internal list protected by a
>   spinlock so request_firmware_nowait_cancel() can find and synchronize a
>   pending request without weakening the GFP_ATOMIC caller contract.
> - Match pending requests by device, callback context and callback function
>   instead of matching by callback alone.
> - Avoid the devres_add() / schedule_work() ordering race pointed out in
>   review.
> - Leave devres-managed support for a separate devm_request_firmware_nowait()
>   API if needed.
> - Link to v2: https://patch.msgid.link/20260430-alsa-hda-tas2781-fw-callback-teardown-v2-0-2c7d89cb3175@gmail.com
> 
> Changes in v2:
> - Add request_firmware_nowait_cancel() in the firmware loader instead of
>   tracking the callback lifetime locally in the TAS2781 HDA driver.
> - Keep the TAS2781 change to a cancel/sync call in I2C and SPI unbind.
> - Drop the unrelated cached kcontrol pointer cleanup from the previous
>   local-driver version.
> - Link to v1: https://patch.msgid.link/20260430-alsa-hda-tas2781-fw-callback-teardown-v1-1-874367d6b41b@gmail.com
> 
> ---
> Cássio Gabriel (2):
>       firmware_loader: Add cancel helper for async requests
>       ALSA: hda/tas2781: Cancel async firmware request at unbind

I guess this could go via driver tree?  Or I can take both if I get an
ack, too.

In anyway, for the series:

Reviewed-by: Takashi Iwai <tiwai@suse.de>


thanks,

Takashi

