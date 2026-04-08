Return-Path: <stable+bounces-233873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFAoHMFF1ml+DAgAu9opvQ
	(envelope-from <stable+bounces-233873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:10:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ACE3BBCBF
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 14:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B8E0300863A
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 12:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9953BE17C;
	Wed,  8 Apr 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jm87BSeP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIsLadj0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Jm87BSeP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LIsLadj0"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B6F3A7588
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775650233; cv=none; b=uriSCbHHyhkPmM+otNvHwFNl4tLQKyxKaUwLAz/e7H9Um01XCAti19o6fvAJDe7+FLrnFkd0TWxMACFtym7rPnKMUtNne/xJNVcXUru8Nggs2DmfbZt/fbAx+nWymCEb3LtJT9Q+X7CF9oXuO8f6cx2c9X2d/0Pmia3wYj//jas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775650233; c=relaxed/simple;
	bh=FbvyjDOONu4Y6gB5HRN9Dr/B47aAoJsoy9pG1kRjusw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtEGtYzJyIUUN1oopEV2Lv4G5PBoOCHitsEqdEWZ+kLwzyGTl3vqn6/HmW1VG/pP60beDT3aVHjRd8JbGYGeoPkFU8ImL0AjdBX3DUa3ua/BqSj6nd3CJv2/yy08D1U0N3/5i+0RPWIIsudnmi99Oxm4TUTIKJa9rXIhzojSiXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jm87BSeP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIsLadj0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Jm87BSeP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LIsLadj0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8688C5BD6B;
	Wed,  8 Apr 2026 12:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775650229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDeys2nWetKCR+bZ6jYvtytH0CNJe6n73oyJ7kGB6GY=;
	b=Jm87BSePOCXNhUNk4HF5ohwz7GHkzY/ln9gnKNHXLa7vJChPx6iJJ8JSmeoRBoxbE7d1sg
	rO/NCDKgdRtj+ZqmMBjhfF+VgGXoqqLzIXjercdCFjhFOH2c/yDjFrs2Pga7C0YbH+O3+w
	od2toYhzKj5vbpmKygmV6qtJi92iW60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775650229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDeys2nWetKCR+bZ6jYvtytH0CNJe6n73oyJ7kGB6GY=;
	b=LIsLadj0md2WS3UB6Q5FJiEYxZTTASy993whfGfF+f5+ZHaNHM+9u7cFgOvW6SxBlRYOO8
	iHgnBA2yi8rcxECA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Jm87BSeP;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LIsLadj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1775650229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDeys2nWetKCR+bZ6jYvtytH0CNJe6n73oyJ7kGB6GY=;
	b=Jm87BSePOCXNhUNk4HF5ohwz7GHkzY/ln9gnKNHXLa7vJChPx6iJJ8JSmeoRBoxbE7d1sg
	rO/NCDKgdRtj+ZqmMBjhfF+VgGXoqqLzIXjercdCFjhFOH2c/yDjFrs2Pga7C0YbH+O3+w
	od2toYhzKj5vbpmKygmV6qtJi92iW60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1775650229;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FDeys2nWetKCR+bZ6jYvtytH0CNJe6n73oyJ7kGB6GY=;
	b=LIsLadj0md2WS3UB6Q5FJiEYxZTTASy993whfGfF+f5+ZHaNHM+9u7cFgOvW6SxBlRYOO8
	iHgnBA2yi8rcxECA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F2514A0B3;
	Wed,  8 Apr 2026 12:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id v+wxDrVF1ml7VQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 08 Apr 2026 12:10:29 +0000
Date: Wed, 08 Apr 2026 14:10:28 +0200
Message-ID: <87fr55lkjv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	tiwai@suse.de,
	linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org,
	liam.r.girdwood@intel.com
Subject: Re: [PATCH for 7.0 1/2] ALSA: hda/intel: enforce stricter period-size alignment for Intel NVL
In-Reply-To: <20260408084514.24325-2-peter.ujfalusi@linux.intel.com>
References: <20260408084514.24325-1-peter.ujfalusi@linux.intel.com>
	<20260408084514.24325-2-peter.ujfalusi@linux.intel.com>
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
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,suse.de,vger.kernel.org,linux.intel.com,linux.dev,intel.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	TAGGED_FROM(0.00)[bounces-233873-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,intel.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62ACE3BBCBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 08 Apr 2026 10:45:13 +0200,
Peter Ujfalusi wrote:
> 
> From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> 
> Intel ACE4 based products set more strict constraints on HDA BDLE start
> address and length alignment. Modify capability flags to drop
> AZX_DCAPS_NO_ALIGN_BUFSIZE for Intel Nova Lake platforms.
> 
> Fixes: 7f428282fde3 ("ALSA: hda: controllers: intel: add support for Nova Lake")
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>

Applied this one now (with Cc to stable).


thanks,

Takashi

