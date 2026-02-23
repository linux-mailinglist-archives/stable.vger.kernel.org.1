Return-Path: <stable+bounces-217710-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJbLKCIWnGkq/gMAu9opvQ
	(envelope-from <stable+bounces-217710-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:56:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E4717356F
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 09:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B4AD301D31F
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFFF34D922;
	Mon, 23 Feb 2026 08:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FmE/Shlq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="psTJZNCV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FmE/Shlq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="psTJZNCV"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0E834D4D2
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771836903; cv=none; b=m2WBPyvXQPJQbpccswg/69uK0OhNBweKSAnxIcJGoGKxMpXMES16F19Hlloo9a5/XJn/v2VOVYthCJ3UeqKHr0sGq+oaMiICIJSCZ1sW+Z+ViuF4UVORQVA2jbB4v0QyyecPEWp5PP9jJRZKp0hT3o42hIvx39LMkFB/eEpUsAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771836903; c=relaxed/simple;
	bh=6qVDbE0ZzA7jNuLVHNQbKmIFvoUxMftry0ikgI+bNxE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SXzUxFkImyHjJ1wqSNN6v+BWDwKGHLnNA0ZeKzur3m77WOZ/AK9GCqTKwHDI5bjviiUmtiiDDhuD4YPFxOQlKPT/naDTOIdZNMMLYOs+pxiHHUTJTQ6zIPbj3pe0Xu8vQUf0uxlocKYi2mJYzc3KsHkV9XLyocgxZ33J3UEEGLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FmE/Shlq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=psTJZNCV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FmE/Shlq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=psTJZNCV; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 949F65BD01;
	Mon, 23 Feb 2026 08:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771836900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFPkYVz+vAvYIiRPyxZ8jqaXNZZ4lvSTPvOFGTqMuJE=;
	b=FmE/ShlquF6FW7AQhIMiqcrS3+NjHISTwBxemOf8+o9gAAhjtnlUfQEYLBEFVePVyFyaC8
	R9MzLdL/BQLFGAmMiQ342JtGPp2wMnXC5WlAmopbYqMC2er+bdToL+V7YiK8cXWQtypZem
	wddUjKJzqJBS9V97dmKBoikygYVQlqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771836900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFPkYVz+vAvYIiRPyxZ8jqaXNZZ4lvSTPvOFGTqMuJE=;
	b=psTJZNCV49gSDytULg5eXx+U2N83w1DtYt0dEgPdyDr80GFoklGGepxUyLiQN1TRrh+vLV
	Z284+JGtt5wf0ZAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="FmE/Shlq";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=psTJZNCV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771836900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFPkYVz+vAvYIiRPyxZ8jqaXNZZ4lvSTPvOFGTqMuJE=;
	b=FmE/ShlquF6FW7AQhIMiqcrS3+NjHISTwBxemOf8+o9gAAhjtnlUfQEYLBEFVePVyFyaC8
	R9MzLdL/BQLFGAmMiQ342JtGPp2wMnXC5WlAmopbYqMC2er+bdToL+V7YiK8cXWQtypZem
	wddUjKJzqJBS9V97dmKBoikygYVQlqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771836900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jFPkYVz+vAvYIiRPyxZ8jqaXNZZ4lvSTPvOFGTqMuJE=;
	b=psTJZNCV49gSDytULg5eXx+U2N83w1DtYt0dEgPdyDr80GFoklGGepxUyLiQN1TRrh+vLV
	Z284+JGtt5wf0ZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FE2D3EA68;
	Mon, 23 Feb 2026 08:55:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8dHxFeQVnGmlfgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 23 Feb 2026 08:55:00 +0000
Date: Mon, 23 Feb 2026 09:54:59 +0100
Message-ID: <87342rn8kc.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Juhyung Park <qkrwngud825@gmail.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH 1/2] ALSA: hda/realtek: fix model name typo for Samsung Galaxy Book Flex (NT950QCG-X716)
In-Reply-To: <20260222122609.281191-1-qkrwngud825@gmail.com>
References: <20260222122609.281191-1-qkrwngud825@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217710-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tiwai@suse.de,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:mid,suse.de:dkim]
X-Rspamd-Queue-Id: 03E4717356F
X-Rspamd-Action: no action

On Sun, 22 Feb 2026 13:26:08 +0100,
Juhyung Park wrote:
> 
> There's no product named "Samsung Galaxy Flex Book".
> Use the correct "Samsung Galaxy Book Flex" name.
> 
> Link: https://www.samsung.com/sec/support/model/NT950QCG-X716
> Link: https://www.samsung.com/us/computing/galaxy-books/galaxy-book-flex/galaxy-book-flex-15-6-qled-512gb-storage-s-pen-included-np950qcg-k01us
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Juhyung Park <qkrwngud825@gmail.com>

Applied both patches now.  Thanks.


Takashi

