Return-Path: <stable+bounces-54798-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5550E911D01
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 09:40:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8167B1C220FB
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 07:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9812216B74F;
	Fri, 21 Jun 2024 07:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vis34gig";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rWLYepDS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vis34gig";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rWLYepDS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5507E16B722;
	Fri, 21 Jun 2024 07:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718955609; cv=none; b=hsNRbSbT/GGquD5fp2XsJ/mSKYSEwQasxmsHpFxzjIeeymA2UqxGg4A/3n92hQsUd+WJU2y7az5Y7LWped7ESHNM2D/Zh3qpCxNKAWuhznAVxFkFwlYV2HxLYSs1ZimGU6FZFIr4vaS7om/dZ3JFuM/etzhflr77Qmi1d9jrW7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718955609; c=relaxed/simple;
	bh=n8mjHVE4QI7Gt/+GbdHZbPHB1yW24UL/gEzfpVEpO1o=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9GlpoefsnKGZAqGPZeZjJ2PhqBlZHXVQk2q4mYbmkCjnBEbj7X4DLcCg8H955/avXX5WGxK3N73qo+ZvPQ8bvvIgB6nuYunuMYg8tZDoRJazlu3M7khqTGwy+mA41kPs6gTZaooo1iEMFW8FK/t8ZaWcRKprUD5Jcu/BBYoY8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vis34gig; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rWLYepDS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vis34gig; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rWLYepDS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9591F21AB6;
	Fri, 21 Jun 2024 07:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718955605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhxsmOBFtZ6Zm2jXACqTnbq4HaCbZfBCpgBPf2JObqA=;
	b=vis34gigNN9mH/lVAjb5hXFcb18zUIBSMf8W4fwC6CSzJoj/Jq6mGUz9GmttMWYUR7tJ+f
	uYLIWz1R7K17N71nMDqFmgu5Rmqwqs/xqvjQOSuWqH/JWLZHvQhIkNk3B0djGbD2Vk1dMV
	yiKR5Or4jsOCJzRB1rsP/jgEh8jD4yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718955605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhxsmOBFtZ6Zm2jXACqTnbq4HaCbZfBCpgBPf2JObqA=;
	b=rWLYepDSCUZuFvrGlYVf2hR5s/ULlbMYQt3omR78JaH1UNe0welOYf6gG2RQUMtp6minGS
	YrmiGwFuWAyGT6CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718955605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhxsmOBFtZ6Zm2jXACqTnbq4HaCbZfBCpgBPf2JObqA=;
	b=vis34gigNN9mH/lVAjb5hXFcb18zUIBSMf8W4fwC6CSzJoj/Jq6mGUz9GmttMWYUR7tJ+f
	uYLIWz1R7K17N71nMDqFmgu5Rmqwqs/xqvjQOSuWqH/JWLZHvQhIkNk3B0djGbD2Vk1dMV
	yiKR5Or4jsOCJzRB1rsP/jgEh8jD4yY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718955605;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yhxsmOBFtZ6Zm2jXACqTnbq4HaCbZfBCpgBPf2JObqA=;
	b=rWLYepDSCUZuFvrGlYVf2hR5s/ULlbMYQt3omR78JaH1UNe0welOYf6gG2RQUMtp6minGS
	YrmiGwFuWAyGT6CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CDF713AAA;
	Fri, 21 Jun 2024 07:40:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VfBKGVUudWaOGQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 21 Jun 2024 07:40:05 +0000
Date: Fri, 21 Jun 2024 09:40:31 +0200
Message-ID: <87msnezqts.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Pablo =?ISO-8859-1?Q?Ca=F1o?= <pablocpascual@gmail.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14AHP9
In-Reply-To: <20240620152533.76712-1-pablocpascual@gmail.com>
References: <20240620152533.76712-1-pablocpascual@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/27.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.29
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.29 / 50.00];
	BAYES_HAM(-3.00)[99.98%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, 20 Jun 2024 17:25:33 +0200,
Pablo Caño wrote:
> 
> Lenovo Yoga Pro 7 14AHP9 (PCI SSID 17aa:3891) seems requiring a similar workaround like Yoga 9 model and Yoga 7 Pro 14APH8 for the bass speaker.
> 
> Cc: <stable@vger.kernel.org>
> Link: https://lore.kernel.org/all/20231207182035.30248-1-tiwai@suse.de/
> Signed-off-by: Pablo Caño <pablocpascual@gmail.com>

Thanks, applied now.


Takashi

