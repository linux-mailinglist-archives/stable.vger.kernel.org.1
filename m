Return-Path: <stable+bounces-242996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMASAFWD+Gn0wAIAu9opvQ
	(envelope-from <stable+bounces-242996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:30:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3D54BC631
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9EEE03017249
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 11:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62CF23AD516;
	Mon,  4 May 2026 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kio4VKhi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pKDC1PSd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Gh0F0dCM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Fp0DFkOU"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F493ACA5A
	for <stable@vger.kernel.org>; Mon,  4 May 2026 11:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894222; cv=none; b=uALl9KQ7jJ0h08DgchniRJ7znW6Tac69vtGnGeoDcbN20XpIL1XByWRD21+wAjnV5zjfv9NarsKkr5irG8fKYa/Ut+4ctfJeorspP+09XdVGxaMEz+6JQY5isKqmnMQx8fagpgpSmFBA8aE2EmEfBmNxTAENVISv+KOD3rDdVC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894222; c=relaxed/simple;
	bh=6JSv02po0RWTzO/bgtInmv9gCi0M4h3Bmh8I9Dx/p8U=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bh3dYd/2E7pJr5LwjX+qnKZyX9oY8YGg5EjvDxpLRfM+XJ09kg8D/+sMJRTGYFvYFFr+IC/uzgedq1SDKDceV0ggIiS73AoRYY39e8P1qf0DiGcigULxqkdDjhaVxl7+XMjgDo8vfLBYUUPm/+5esAFZ8VZ1TVWTPHj7HKCkaoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kio4VKhi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pKDC1PSd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Gh0F0dCM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Fp0DFkOU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E3AD15C599;
	Mon,  4 May 2026 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777894218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X77MCTfP6oUt3rkFQ0tNawnARqoNxlYJz/UmLl3BZN8=;
	b=Kio4VKhi/OOgu2q9+wuAGCBvZCsrG3NcVmL8QHFyrCpKwiYqFwU6TPiZ5gzWJf566EOhts
	frAqoV/0qsRXK5iamsR4x3ZmeQCBHX+IO3k8U4t+FwaJZr6psIWNf8OEMvA5PVwPLnWhjU
	NHH1wmRZCPQC5JxnJUI2P2DmmENCmYM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777894218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X77MCTfP6oUt3rkFQ0tNawnARqoNxlYJz/UmLl3BZN8=;
	b=pKDC1PSd9QNuk34awuh/+4NHOVCT22+54cAkUDOJKgoTNAi0AmG4uxYo1pHvfCsJM+aAK8
	/aDApjRZ0xGTD1Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777894217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X77MCTfP6oUt3rkFQ0tNawnARqoNxlYJz/UmLl3BZN8=;
	b=Gh0F0dCMOLc31M30fxQDtpjak/+U/9AXQQbmWIpcv30Cnhy1wER9IOQ50nwvhQL7Qd7bMr
	UQbx2kDf2O6A9IwQmYwrtW0SY1frbnOoR06PH3ofzQE2+vV19B2BBtyOu3bPvBgKmGmCLM
	RzAeyPkMzX7U/5f+QvhXD6h/ahq4EVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777894217;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X77MCTfP6oUt3rkFQ0tNawnARqoNxlYJz/UmLl3BZN8=;
	b=Fp0DFkOUJXw515HKZrizgqWXM2pp5ZkcCiNtXr+u+Md4PAa4QVxFVN1a07qs4nJPvVssZu
	MzwOsMNYyaNYq2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0C4A593A3;
	Mon,  4 May 2026 11:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jvMFJkmD+GmXHgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 04 May 2026 11:30:17 +0000
Date: Mon, 04 May 2026 13:30:17 +0200
Message-ID: <87se87xvhy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Clemens Ladisch <clemens@ladisch.de>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: firewire-tascam: Do not drop unread control events
In-Reply-To: <20260503-alsa-firewire-tascam-read-queue-v2-1-126c6efd7642@gmail.com>
References: <20260503-alsa-firewire-tascam-read-queue-v2-1-126c6efd7642@gmail.com>
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
X-Rspamd-Queue-Id: 4C3D54BC631
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-242996-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:dkim,suse.de:mid]

On Mon, 04 May 2026 02:55:52 +0200,
Cássio Gabriel wrote:
> 
> tscm_hwdep_read_queue() copies as many queued control events as fit in
> the userspace buffer. When the buffer is smaller than the current
> contiguous queue segment, length is rounded down to the number of bytes
> that can be copied.
> 
> However, after copying that shortened length, the code advances pull_pos
> to the original tail_pos, marking the whole contiguous segment as
> consumed. Any events between the copied portion and tail_pos are lost.
> 
> Limit tail_pos to the position after the entries actually copied before
> updating pull_pos. When the whole segment fits, this is equivalent to the
> old tail_pos update; when the buffer is smaller, the remaining events
> stay queued for the next read.
> 
> Fixes: a8c0d13267a4 ("ALSA: firewire-tascam: notify events of change of state for userspace applications")
> Cc: stable@vger.kernel.org
> Suggested-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied now.  Thanks.


Takashi

