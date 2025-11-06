Return-Path: <stable+bounces-192592-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F33AC3A342
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 11:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27ABE5064AF
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 10:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A4730EF6D;
	Thu,  6 Nov 2025 10:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ad4S5uB5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xnZT1/3i";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ad4S5uB5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xnZT1/3i"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF0230C639
	for <stable@vger.kernel.org>; Thu,  6 Nov 2025 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762423440; cv=none; b=WnO2/Pl1EJTlzMyPeCPdcoFJCxgT3i25pRooaitB1LH31rXsbRUrX7UHAZGOZfo7/HQNMsX1LDcmed/QWo9y/m06I3x/pzSu+EwvrP02lAqTKNiZWnbaJVkndd+gnZXgLWJy3a2T2WYzhFiM2Zq093eF1gsIItun7TOMUiXtNuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762423440; c=relaxed/simple;
	bh=QjS5npl9Z5HIJm64TxJo0GwvoG5u76CjTCfFNvtGmZA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqxQFDedA2xVTB3CelgSlWN4JN0qekegbzVbaStokRZXM2vGzIxaFvAnANOyFymLUvS2N3NCT++D9N7Vw7qxhO3GDbihO4Xe6TjiX657m/+9uqOz97Dm0CdK5eNqGk2co6gxs9lX8fEb/FUOZ3vz5f0+67D8ggAYcFPLXuReRYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ad4S5uB5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xnZT1/3i; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ad4S5uB5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xnZT1/3i; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94964211CC;
	Thu,  6 Nov 2025 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdfsAf5/BWSCLBs5oZvNEz8zkFgIh+C6TXYYaVXdzf8=;
	b=Ad4S5uB5uCD0pQsd0/VTlnggK8h9mlAwk31qzkBLTcaGQqofkbTl54T3urNJhw8v04cl5Q
	vY+oKBnT6X3lbondNmjP3gzhA4LjgYUmDeJCj2Xxih6p8dgnipWOp9BnKZg7sr5zRxWZ3P
	FkOoZmIUQ51CRUN1jGfS5gqv+LrBIzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdfsAf5/BWSCLBs5oZvNEz8zkFgIh+C6TXYYaVXdzf8=;
	b=xnZT1/3i14SMILJInuQcsrei9ylNdmuL1CquzYTo2TIyNNMtT+Pvx6/u3a+WEYlTctgyHS
	JbFG2OXCLU85McBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762423436; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdfsAf5/BWSCLBs5oZvNEz8zkFgIh+C6TXYYaVXdzf8=;
	b=Ad4S5uB5uCD0pQsd0/VTlnggK8h9mlAwk31qzkBLTcaGQqofkbTl54T3urNJhw8v04cl5Q
	vY+oKBnT6X3lbondNmjP3gzhA4LjgYUmDeJCj2Xxih6p8dgnipWOp9BnKZg7sr5zRxWZ3P
	FkOoZmIUQ51CRUN1jGfS5gqv+LrBIzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762423436;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdfsAf5/BWSCLBs5oZvNEz8zkFgIh+C6TXYYaVXdzf8=;
	b=xnZT1/3i14SMILJInuQcsrei9ylNdmuL1CquzYTo2TIyNNMtT+Pvx6/u3a+WEYlTctgyHS
	JbFG2OXCLU85McBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A6DB13A31;
	Thu,  6 Nov 2025 10:03:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Bk7eFIxyDGm/OQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 06 Nov 2025 10:03:56 +0000
Date: Thu, 06 Nov 2025 11:03:55 +0100
Message-ID: <877bw3h3zo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>
Subject: Re: [PATCH v2] ALSA: wavefront: Fix integer overflow in sample size validation
In-Reply-To: <SYBPR01MB7881B47789D1B060CE8BF4C3AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881B47789D1B060CE8BF4C3AFC2A@SYBPR01MB7881.ausprd01.prod.outlook.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[outlook.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,outlook.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.30

On Thu, 06 Nov 2025 03:49:46 +0100,
Junrui Luo wrote:
> 
> The wavefront_send_sample() function has an integer overflow issue
> when validating sample size. The header->size field is u32 but gets
> cast to int for comparison with dev->freemem
> 
> Fix by using unsigned comparison to avoid integer overflow.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>

> ---
> Changes in v2:
> - Check for negative freemem before size comparison
> - Link to v1: https://lore.kernel.org/all/SYBPR01MB7881FA5CEECF0CCEABDD6CC4AFC4A@SYBPR01MB7881.ausprd01.prod.outlook.com/

Applied now.  Thanks.


Takashi

