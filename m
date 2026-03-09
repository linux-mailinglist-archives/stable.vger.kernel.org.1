Return-Path: <stable+bounces-223634-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6FvLNqzDrmn2IgIAu9opvQ
	(envelope-from <stable+bounces-223634-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:57:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5A023947A
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 13:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 571DB303A3C1
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 12:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428863BED40;
	Mon,  9 Mar 2026 12:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="p8qmf8wM"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE4D3B8BCC
	for <stable@vger.kernel.org>; Mon,  9 Mar 2026 12:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773060922; cv=none; b=dHdQtTGwPdm0oRigF1P+YUDpp2zLU0uBCvzxYZwrEXcSz9JghImYl+OwWbtLsXlAWIAtokhUSmD8//pt+XYsnFvjCpP8WqD/2LwArak5YUbRUg1IkmnkNIlpmK02BlYA4LsVfaz5k/Dnuu88UWmZZn/KEMuSVfXGwKbFPfqj7eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773060922; c=relaxed/simple;
	bh=6F4tYFxIxl5jUs6uiWf8XdWz74jtj5fTeJj1oAJexMw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=dsY/cq2hhcWnjXLiiIB1JGyfB2nxVLTUyKx9nR6eQHgsYcl8uOpevDF01vpCDvsLL0YzIjF5Y6FCmMry6dOBckFM3NX/pf/BeFU14yZ1gogZpeECPI9RS2mXOK04m4GrYAKa/wlviT0ndGQ4X6iG1Rd6Fo3NhUo6mqwDanQD7IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=p8qmf8wM; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773060908;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+RwK8RR51qXeZ71e+SyZvIcyWk9REBek1JHzsr0gp2E=;
	b=p8qmf8wMnjquqbtDjCeFlkv0g/rwvbNPeTR18zkEYenETkIXumccUggucGa0zgF6GLFLib
	djNVfvGk4X/ruI12bGeiJmIWq/w/TeASL0uz2CUP4SvuXjw4HSrvbgcBOJSUbD//EuWvQm
	6+dP7/V+lRP4TfPb+t+51d5aiGXV3nY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81.1.4\))
Subject: Re: [PATCH] ALSA: aoa: Handle empty codec list in
 i2sbus_pcm_prepare()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <87zf4hmcw4.wl-tiwai@suse.de>
Date: Mon, 9 Mar 2026 13:55:02 +0100
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>,
 Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <CFB7A246-8C9D-4F49-8143-2883030C1135@linux.dev>
References: <20260309114159.765304-3-thorsten.blum@linux.dev>
 <87zf4hmcw4.wl-tiwai@suse.de>
To: Takashi Iwai <tiwai@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5B5A023947A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223634-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.904];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

On 9. Mar 2026, at 12:59, Takashi Iwai wrote:
> On Mon, 09 Mar 2026 12:41:59 +0100, Thorsten Blum wrote:
>> Replace two list_for_each_entry() loops with list_first_entry_or_null()
>> in i2sbus_pcm_prepare().
> 
> Hmm, I guess both can be simply list_first_entry(), as the codec list
> in this code path is guaranteed to be non-empty (it's called after
> i2sbus_pcm_open() which has the check of the valid codecs).

That guarantee only holds for open/prepare, not for i2sbus_resume() via
i2sbus_pcm_prepare_both(). It's probably uncommon in practice, but
i2sbus_pcm_prepare() should still handle it safely.

>> Handle an empty codec list explicitly by returning -ENODEV, which avoids
>> using uninitialized 'bi.sysclock_factor' in the 32-bit code path.
> 
> Which 32bit code path are you referring to...?

The SNDRV_PCM_FORMAT_S32_BE/SNDRV_PCM_FORMAT_U32_BE branch.

Thanks,
Thorsten


