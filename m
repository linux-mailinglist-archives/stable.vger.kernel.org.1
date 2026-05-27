Return-Path: <stable+bounces-254626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PbQOakXF2px3wcAu9opvQ
	(envelope-from <stable+bounces-254626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:11:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF045E7823
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B633430BAD34
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A790A3EF646;
	Wed, 27 May 2026 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kdLsC7lG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3JsilUno";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kdLsC7lG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="3JsilUno"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEF3E3C7A
	for <stable@vger.kernel.org>; Wed, 27 May 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898050; cv=none; b=LC9zQ0L1nVbJbRnT9PNtAf0lDQWgLq87w7BJCbpooSXL3RqL1m5XxuI0SmXvEBa8aE5zY2e1z+ScD2PPlvSSFxYr1PNRfhcoy2LKx/VfUkWHG34WHjF3puFRMlx25QCmlWjBMFGQmndiWrNAvtec9rGpGIGJ6/YVduKg6Qk7v/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898050; c=relaxed/simple;
	bh=8UaDU8tyq6fJreIIDw7WaUsoLWd4eersEx+DqAjXry0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HEW36wnvlCzRORkUx5ycg8x49viBO36u9I0i68M/Y0Mwby/RAkFg3052CUY8SVzrgfKNV4HIYB/UbstO4vmX30sM8qKeJIgyMKkEYOJ4w/KBfaH7FAXRENyaJAeAhnBsqoaUVuyFIdHexn8KKIFDkjdjPDLMGPEi5Ub+g1lpy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kdLsC7lG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3JsilUno; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kdLsC7lG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=3JsilUno; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 63FCA6ABA1;
	Wed, 27 May 2026 16:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779898046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CstPdIeDAGKSLVe4RiHjZcwVi7sRkfjmCSJZnv3MS8=;
	b=kdLsC7lGaahiPCECVRXhd1Ddg5G24B/hhlXynF9KyBq6Xnlhougn9PqFmssm97fvfnJExH
	dZiwkICfPRl0eBEH9bom1S44IVZ0kDRW0haVnsQuUB/ZU0vAD/KLSkvqiHVcoNUG2Pok9G
	eYuNRtwG57MMNmCZsx8QLLjPWVsJK6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779898046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CstPdIeDAGKSLVe4RiHjZcwVi7sRkfjmCSJZnv3MS8=;
	b=3JsilUnoVF/G8ra+AArOMi+Ef5rip21MIhMZ0z8/FHof4efNIfwkmm3FD+rdMIN1bEMArr
	C/IuBFWIn7UCLcBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1779898046; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CstPdIeDAGKSLVe4RiHjZcwVi7sRkfjmCSJZnv3MS8=;
	b=kdLsC7lGaahiPCECVRXhd1Ddg5G24B/hhlXynF9KyBq6Xnlhougn9PqFmssm97fvfnJExH
	dZiwkICfPRl0eBEH9bom1S44IVZ0kDRW0haVnsQuUB/ZU0vAD/KLSkvqiHVcoNUG2Pok9G
	eYuNRtwG57MMNmCZsx8QLLjPWVsJK6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1779898046;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7CstPdIeDAGKSLVe4RiHjZcwVi7sRkfjmCSJZnv3MS8=;
	b=3JsilUnoVF/G8ra+AArOMi+Ef5rip21MIhMZ0z8/FHof4efNIfwkmm3FD+rdMIN1bEMArr
	C/IuBFWIn7UCLcBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1849A5A902;
	Wed, 27 May 2026 16:07:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rE3ABL4WF2r4SAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 27 May 2026 16:07:26 +0000
Date: Wed, 27 May 2026 18:07:25 +0200
Message-ID: <87o6i0vnsy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Huacai Chen <chenhuacai@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	stable@vger.kernel.org,
	Baoqi Zhang <zhangbaoqi@loongson.cn>,
	Haowei Zheng <zhenghaowei@loongson.cn>
Subject: Re: [PATCH V2] ALSA: hda/hdmi: Use 'AC_PINSENSE_ELDV' to detect pinsense for Loongson
In-Reply-To: <20260527140841.3407183-1-chenhuacai@loongson.cn>
References: <20260527140841.3407183-1-chenhuacai@loongson.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	URIBL_MULTI_FAIL(0.00)[loongson.cn:server fail,suse.de:server fail,tor.lore.kernel.org:server fail];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-254626-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 6CF045E7823
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 27 May 2026 16:08:41 +0200,
Huacai Chen wrote:
> 
> Due to a hardware defect, for Loongson PCI HDMI devices with a reversion
> ID of 2, the pin sense status must be determined via the ELD.
> 
> Add a codec flag, eld_jack_detect, to indicate this case, and do special
> handlings in read_pin_sense().
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Baoqi Zhang <zhangbaoqi@loongson.cn>
> Signed-off-by: Haowei Zheng <zhenghaowei@loongson.cn>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Applied to for-next branch now.  Thanks.


Takashi

