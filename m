Return-Path: <stable+bounces-245051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wJOuIOS6AGoAMAEAu9opvQ
	(envelope-from <stable+bounces-245051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:05:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FCC50546B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 19:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA99D300A51D
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23CFC3B2FD6;
	Sun, 10 May 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3Rzr/ZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m6NStZxX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="t3Rzr/ZA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m6NStZxX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB02243387
	for <stable@vger.kernel.org>; Sun, 10 May 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778432719; cv=none; b=aPFybrfFUWp+3Mj+rjjMXtzNHx4lqtaRiuAUQlVcQez1PoU/YoxsAy/cvgXp31lraAqiaZ8skRuhdVqSwfcIfo2NMB/KFxHIc3msgZ9uVVC6h1t1QsQB1JRRAomqYiI9Oz53Z5WotfsrRw7AVrLFmyEO1u2dAE4JalYIxdGcQCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778432719; c=relaxed/simple;
	bh=+/M+i4GQUf/WuzxfoQND6YeQVJa2UOXpbHB67Xmjp3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TaJSOQEnuaJjIQ7U0WT4AID++rrKQrLvK9dlqRnzdKNOo/tdy1fKAP4hmTl7VizqlW5S4xRofZ8WyuoBghfeF9sgN7803HDP2JJTGKxybjLrIUPJMlSbJqOJPZiN6TSjcpIGBlH6m9lRfsQj3VBO8Ns99ML1fJS6A/xO4TvOYcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3Rzr/ZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m6NStZxX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=t3Rzr/ZA; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m6NStZxX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 38E136B102;
	Sun, 10 May 2026 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778432716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=t3Rzr/ZAothvvYEaw2BmuQuaVdqh0q521a08fn7rvln3a904fgSFNzcIR1Day3hDAnNKdC
	wZYtKCzWz+jwlf6RE7GXCPFKcjt7YXCJO/OXCvyWeYFXqBdOhcc2WLCojamO6YVStvvIIY
	ohEvDnp68CKG2dGAyYwWA1/a//8yflw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778432716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=m6NStZxX+I6i4FJph6UpOHgK8nPOwaBQNE3e2LL5IdyPdBPt6ub2eLMW6FZGmtd9/912iI
	VGrN2S5/PeKipiBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="t3Rzr/ZA";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=m6NStZxX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1778432716; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=t3Rzr/ZAothvvYEaw2BmuQuaVdqh0q521a08fn7rvln3a904fgSFNzcIR1Day3hDAnNKdC
	wZYtKCzWz+jwlf6RE7GXCPFKcjt7YXCJO/OXCvyWeYFXqBdOhcc2WLCojamO6YVStvvIIY
	ohEvDnp68CKG2dGAyYwWA1/a//8yflw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1778432716;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kdzP/Xxvb7jr89HHk+vrFGBQW+EaZi2atMtnwucH4/M=;
	b=m6NStZxX+I6i4FJph6UpOHgK8nPOwaBQNE3e2LL5IdyPdBPt6ub2eLMW6FZGmtd9/912iI
	VGrN2S5/PeKipiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9AE593A3;
	Sun, 10 May 2026 17:05:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gg/dFsu6AGq6fQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Sun, 10 May 2026 17:05:15 +0000
Message-ID: <ae8593df-e86e-4f06-ba0b-71b75cd5d589@suse.de>
Date: Sun, 10 May 2026 19:05:03 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
To: Jakub Kicinski <kuba@kernel.org>, Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org, stable@vger.kernel.org
References: <af2kdW2F1gJ9U-Gg@v4bel> <20260510084520.476745b5@kernel.org>
 <agC256wVYa4Gnvy1@v4bel> <20260510100310.230b15ed@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260510100310.230b15ed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 19FCC50546B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245051-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fmancera@suse.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 5/10/26 7:03 PM, Jakub Kicinski wrote:
> On Mon, 11 May 2026 01:48:39 +0900 Hyunwoo Kim wrote:
>> On Sun, May 10, 2026 at 08:45:20AM -0700, Jakub Kicinski wrote:
>>> On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
>>>>   			    sp->hdr.securityIndex != 0 &&
>>>> -			    skb_cloned(skb)) {
>>>> +			    (skb_cloned(skb) ||
>>>> +			     skb_has_frag_list(skb) ||
>>>> +			     skb_has_shared_frag(skb))) {
>>>
>>> We seem to be getting a lot of fixes for this issue, and this one is
>>> incorrect :| Writing to _any_ frags is incorrect. You have to copy
>>> if skb is not linear. skb_ensure_writable()
>>
>> I was testing a patch based on skb_ensure_writable() but it seems v3
>> has just been merged to mainline...
>>
>> What would be the best way to proceed?
> 
> Depends on the tree. Where was it merged?
> 

It is already on linus' tree.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aa54b1d27fe0c2b78e664a34fd0fdf7cd1960d71

