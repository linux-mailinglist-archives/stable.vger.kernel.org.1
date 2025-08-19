Return-Path: <stable+bounces-171783-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70424B2C345
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1CD27B5DAD
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB7433CEBF;
	Tue, 19 Aug 2025 12:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GcP3hN0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CARIwZRt";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0GcP3hN0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CARIwZRt"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD133CEBD
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605844; cv=none; b=bwTWsEJg5QZeMXypVu7y7RMl9hwu8gX7TzjopUhJpkSaoo9uWLTPrwKQv5R/vRpv8R9OfXXLXf1ktlDmrJtePVmyHP6oK9N3tKEveYDcA/+Kt/p51PA5fmJXSwNkfEtq+r/yEEWSw3IB8wOnm4cFe+zXEyJOYivlWkgpqiNKoa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605844; c=relaxed/simple;
	bh=aLkH05P3vAW1vdgoW32EvwBJGtyRYtVfM+OV8jRD/is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6UuOeUqdndssYkJT/lK4powofHj1bA/MmyLPMrHw/ixpSpIFWFp4Y60LXWok3OJFT+Xuvn5C9iDNphxy8T0fwthtUM77A1YG867fVmeWaAw8nIMQwqgCmVuyP68ITeBw248YuzBVYRp4Rn2HJqY5yQ8I8yDIh0q3CF7Bz1IOmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GcP3hN0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CARIwZRt; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0GcP3hN0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CARIwZRt; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3DF741F786;
	Tue, 19 Aug 2025 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755605840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJcJK5eJNAr608bIa1BI6Q8++rFnIc/EAHj+iHv+YxA=;
	b=0GcP3hN0kgyivlhiYNfGn3NeH9dT0kzdjEzDO4Q559OVpZsXw8I9D/XZClHitz1JZ/98Qg
	2lROdwRTzuCzw7HTDyOHQisleGS9SdUQUWmC43fr9KxurP+p7Ib8mD0Q3drcgRTtHhbM4q
	HjNQgioxFtf1jAWgEbFdrNBXeeXI67o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755605840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJcJK5eJNAr608bIa1BI6Q8++rFnIc/EAHj+iHv+YxA=;
	b=CARIwZRtus4A9cC19aSiJGLMcbiBWNJIDstAiWUPhydNfhzj+RM+6v1ggYLOh4uSKFHzWs
	hg/ZTToZ5+cl/PAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=0GcP3hN0;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CARIwZRt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1755605840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJcJK5eJNAr608bIa1BI6Q8++rFnIc/EAHj+iHv+YxA=;
	b=0GcP3hN0kgyivlhiYNfGn3NeH9dT0kzdjEzDO4Q559OVpZsXw8I9D/XZClHitz1JZ/98Qg
	2lROdwRTzuCzw7HTDyOHQisleGS9SdUQUWmC43fr9KxurP+p7Ib8mD0Q3drcgRTtHhbM4q
	HjNQgioxFtf1jAWgEbFdrNBXeeXI67o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1755605840;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lJcJK5eJNAr608bIa1BI6Q8++rFnIc/EAHj+iHv+YxA=;
	b=CARIwZRtus4A9cC19aSiJGLMcbiBWNJIDstAiWUPhydNfhzj+RM+6v1ggYLOh4uSKFHzWs
	hg/ZTToZ5+cl/PAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2563D139B3;
	Tue, 19 Aug 2025 12:17:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JHnwCFBrpGgLeQAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Tue, 19 Aug 2025 12:17:20 +0000
Date: Tue, 19 Aug 2025 14:17:14 +0200
From: David Sterba <dsterba@suse.cz>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 6.12.y 7/7] btrfs: send: make fs_path_len() inline and
 constify its argument
Message-ID: <20250819121714.GQ22430@suse.cz>
Reply-To: dsterba@suse.cz
References: <2025081827-washed-yelp-3c3e@gregkh>
 <20250819021601.274993-1-sashal@kernel.org>
 <20250819021601.274993-7-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250819021601.274993-7-sashal@kernel.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-4.21 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:replyto,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 3DF741F786
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.21

On Mon, Aug 18, 2025 at 10:16:01PM -0400, Sasha Levin wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> [ Upstream commit 920e8ee2bfcaf886fd8c0ad9df097a7dddfeb2d8 ]
> 
> The helper function fs_path_len() is trivial and doesn't need to change
> its path argument, so make it inline and constify the argument.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> Reviewed-by: David Sterba <dsterba@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This is neither a fix nor a dependency of other patches, please drop it.

