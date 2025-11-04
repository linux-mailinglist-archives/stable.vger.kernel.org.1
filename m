Return-Path: <stable+bounces-192352-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA45C308D5
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 11:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 928604E7258
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 10:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78952D5954;
	Tue,  4 Nov 2025 10:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ilF0MDDj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DC0JfO9V";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oeiZPlC5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rhDBbVND"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FB2BE642
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762252835; cv=none; b=Qse5vDWydWI12msI5m6kc/2u2g/ihsmbyj+OEdjO2389hKTcR/n2DgCA9vTBWkhIbVMKRVlSuTBOyXmiBW9Kgw8JSzR6k/ErRNlwArH+V+On51w72gI1GNosWjrs01uc2p+89h/xdUIkM7nhBFkEH32t7ws83OATZz3YDdNRDHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762252835; c=relaxed/simple;
	bh=ScsvhX3dtt3SwLD1cu4spJwSs1sx3CRExS1mxaYaN3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uw2dsx9evwpxqlSJ8RH6Vr6tZH2x99yBombtcMCjbUnAf2gyHG+fYWI98/4S5mPx85Kp9Rl6k6lKG8w7uVcS3W0oJXG6PFQ9w4CNj2kUfjTw1Zth2Ml5mwBoL4ou1zmi0v6yu7Kda8fBiwDho1scn/TOazSlK+FU5KDXs4MgGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ilF0MDDj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DC0JfO9V; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oeiZPlC5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rhDBbVND; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BBA732116D;
	Tue,  4 Nov 2025 10:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762252832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wUrCtseumKk5fl2r2TTo6EYvzBfcEx8Q5G/gUQ/4PQ=;
	b=ilF0MDDj5rioIRFigF7RMtnAyL372JkQAJPNxFmPjD35rxLp9gAHk7w1VRjfzBMBrQZN+p
	oAzTOSq4IUhlEeoeXY0p+5ZSh0Sc6lrnBR4dQHGOkVpYMZzoS07d1WOUJpNSUZ/OuC109Y
	1KR+hAQe5EQexy6WSozkSANiDuvH/HE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762252832;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wUrCtseumKk5fl2r2TTo6EYvzBfcEx8Q5G/gUQ/4PQ=;
	b=DC0JfO9VBo+1USgHrOXy48pSvizxc+FGm/fblelFYV1H+GGOnStW7Mb0ygmRwYfbqLyAfj
	0ErhndUWXWsD/gBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oeiZPlC5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rhDBbVND
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1762252831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wUrCtseumKk5fl2r2TTo6EYvzBfcEx8Q5G/gUQ/4PQ=;
	b=oeiZPlC5hzZtUN9P8jYZb01R1knoxM4o/z02b4DRwvQlVq1WJ2qi6kKUWU2umqToP5iNtY
	XCbUcKbYG6KOHDiO/6dr7txDyQDvZvzh8g5txWcVuVP4ljQVSmtLvqvAYgWkzm0bqux8S9
	KesufEvB/+nTbFWmYLEtgZ3dhEYLfaA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1762252831;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wUrCtseumKk5fl2r2TTo6EYvzBfcEx8Q5G/gUQ/4PQ=;
	b=rhDBbVNDCVJyh48JW1zxTyCk29uyD4svS6OHwqVPk/zxFVy99S13vjsrEuqMEDVX9zW6+u
	uEpzwXxUfcQVpmDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C9CA139A9;
	Tue,  4 Nov 2025 10:40:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KaaqJR/YCWmiYgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 04 Nov 2025 10:40:31 +0000
Message-ID: <e5620018-e95b-4b4e-a829-f5b3115c59e0@suse.de>
Date: Tue, 4 Nov 2025 11:40:31 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND] [PATCH] nvme-tcp: fix usage of page_frag_cache
To: Dmitry Bogdanov <d.bogdanov@yadro.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Stuart Hayes <stuart.w.hayes@gmail.com>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@yadro.com, stable@vger.kernel.org
References: <20251027163627.12289-1-d.bogdanov@yadro.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20251027163627.12289-1-d.bogdanov@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: BBA732116D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[yadro.com,kernel.org,kernel.dk,lst.de,grimberg.me,gmail.com,lists.infradead.org,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -3.01

On 10/27/25 17:36, Dmitry Bogdanov wrote:
> nvme uses page_frag_cache to preallocate PDU for each preallocated request
> of block device. Block devices are created in parallel threads,
> consequently page_frag_cache is used in not thread-safe manner.
> That leads to incorrect refcounting of backstore pages and premature free.
> 
> That can be catched by !sendpage_ok inside network stack:
> 
> WARNING: CPU: 7 PID: 467 at ../net/core/skbuff.c:6931 skb_splice_from_iter+0xfa/0x310.
> 	tcp_sendmsg_locked+0x782/0xce0
> 	tcp_sendmsg+0x27/0x40
> 	sock_sendmsg+0x8b/0xa0
> 	nvme_tcp_try_send_cmd_pdu+0x149/0x2a0
> Then random panic may occur.
> 
> Fix that by serializing the usage of page_frag_cache.
> 
> Cc: stable@vger.kernel.org # 6.12
> Fixes: 4e893ca81170 ("nvme_core: scan namespaces asynchronously")
> Signed-off-by: Dmitry Bogdanov <d.bogdanov@yadro.com>
> ---
>   drivers/nvme/host/tcp.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
Reviewed-by: Hannes Reinecke <hare@suse.de>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

