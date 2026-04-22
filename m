Return-Path: <stable+bounces-240352-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yLmBBuPu6GkdRwIAu9opvQ
	(envelope-from <stable+bounces-240352-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:53:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id EAD90448262
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 17:53:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E2B8C30058F4
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 15:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2BF1E5724;
	Wed, 22 Apr 2026 15:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yND6BcCQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uXo6oknD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yND6BcCQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uXo6oknD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF69A337110
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 15:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776873181; cv=none; b=Fn2sUPkNSDDLZN8Jb9KJ06hMRQiZKUODaTmD1bGQNJm7KWkfEeSEiRQ/CY0MC6xJcA/YZW2yTtU7kAQvj9Uf3MGPwtdjJ+f9eAb5Afkx31f2cD8oo7XgNUbkjwYNy3yQboOnecZZUDNeikUM+U6hA2fm7Qgzm6TCpG7LTljIupA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776873181; c=relaxed/simple;
	bh=qUhbgS0hylqW8b9ndidsx+aApWml+a4+UZIsPPxuf5s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1vLGbjsFSwI3hjGf+ICRSM74QzspbKDrDITmykWYJYrz4fNpfiKFrRBH08A1bEjP1XB18K6RqaZRxTS7GLHrcgLkpxsTrj57MBMUmFkJDo2YU81bLv0fStTY5iqEPFAO6mupBrtAS5gPeERNoskHgu1Mz2pIo4gk5Og9TYLqOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yND6BcCQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uXo6oknD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yND6BcCQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uXo6oknD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 380376A826;
	Wed, 22 Apr 2026 15:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776873178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy++AjzVN8gmcvIEvuLQq7s4MEomCM+GzEPHMiJvKp0=;
	b=yND6BcCQyX7B0L+Bp0U5945LQQ4f3OXaV+ajQjQO3SCC0abE7045odtzC2cNI++kwOMcxW
	U5FqfijSy3w3JGGRpG4FGZUob/01fSmTnOXWhfKo0F10lhphBQ4nljThr8SS0wRT4JQfTo
	HZOQ4oSg4qcpBO/loeXSxkTzfmSn3eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776873178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy++AjzVN8gmcvIEvuLQq7s4MEomCM+GzEPHMiJvKp0=;
	b=uXo6oknDZ8Xi6HcJU18Ax8Euf9ZvF2Ui6wcxE9dIwBRD9uyG552EscjDLYg0D9s75t5xCP
	mVoTmBHrnT2MPRBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1776873178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy++AjzVN8gmcvIEvuLQq7s4MEomCM+GzEPHMiJvKp0=;
	b=yND6BcCQyX7B0L+Bp0U5945LQQ4f3OXaV+ajQjQO3SCC0abE7045odtzC2cNI++kwOMcxW
	U5FqfijSy3w3JGGRpG4FGZUob/01fSmTnOXWhfKo0F10lhphBQ4nljThr8SS0wRT4JQfTo
	HZOQ4oSg4qcpBO/loeXSxkTzfmSn3eY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1776873178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy++AjzVN8gmcvIEvuLQq7s4MEomCM+GzEPHMiJvKp0=;
	b=uXo6oknDZ8Xi6HcJU18Ax8Euf9ZvF2Ui6wcxE9dIwBRD9uyG552EscjDLYg0D9s75t5xCP
	mVoTmBHrnT2MPRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07374593AF;
	Wed, 22 Apr 2026 15:52:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0MuFANru6GnqOAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 22 Apr 2026 15:52:58 +0000
Date: Wed, 22 Apr 2026 17:52:57 +0200
Message-ID: <87h5p33sbq.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix Audio Advantage Micro II SPDIF switch
In-Reply-To: <20260421-microii-spdif-switch-fix-v1-1-5c50dc28b88f@gmail.com>
References: <20260421-microii-spdif-switch-fix-v1-1-5c50dc28b88f@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240352-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EAD90448262
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 22 Apr 2026 03:07:41 +0200,
Cássio Gabriel wrote:
> 
> snd_microii_spdif_switch_put() returns 0 when the requested
> vendor register value differs from the cached one.
> 
> This comparison was inverted by the resume-support conversion,
> so real SPDIF switch toggles are ignored while no-op writes still
> issue SET_CUR and report success.
> 
> Return early only when the requested value matches the cached one.
> 
> Fixes: 288673beae6c ("ALSA: usb-audio: Add resume support for MicroII SPDIF ctls")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Thanks, applied now.


Takashi

