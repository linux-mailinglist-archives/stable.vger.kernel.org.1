Return-Path: <stable+bounces-240382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFm9G8se6Wl+UgIAu9opvQ
	(envelope-from <stable+bounces-240382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:17:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F8EF44A137
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6A2B3031ECB
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A9363090;
	Wed, 22 Apr 2026 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="REnHlWwN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hj/9OoPc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="REnHlWwN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="hj/9OoPc"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7DF36166A
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776885270; cv=none; b=rH1FDapyGB2bLTv9AhEN6BG95XFhY/oH5NQuLHIznuC9S/EzwlQFLZpoKNYSEQYMPrEzm+6jPfPm0TE5KsgI5rrFia+5TRa1uWwQpyX9rk1K3oMsqMf75k239Z3P0K3/+2gQ8bdszfIt85smNhSoHczQGEo6+2a9Xs0hO8zTQw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776885270; c=relaxed/simple;
	bh=v3k6BW0VjtHYSkTtjZWNvzXiA+F5vkZY+kYFdoYFF6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZUKBNrVr93NDGC4qnXm/zFolAA53MMtNUG40mCE1XERrBKShdXctVCLtzQOc6Vpkr4+3WEOJSyg+OorUJp33Cm08lYf0PCfCpjY88CKIDChELlkJyi27B2i6ZjCmeUgoW8X3o8fgKN87hvSzZ+0LKuuwrhkk+MZFWiWAubT+Gc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=REnHlWwN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hj/9OoPc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=REnHlWwN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=hj/9OoPc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 48EE46A827;
	Wed, 22 Apr 2026 19:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776885255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVuxbSAzewsAYv8/qYWz0g/O7K1OXFm7e8ZlxXnfSt0=;
	b=REnHlWwNhU+aY9Fe7p+ZajDg+lfd0uFecBx1jOdTU0hn6kEFp6Z9Bf2E5Pz2d7C2hhEZNz
	YqUtg3r4rlpSQ3+bsxiBcsZX05/iEKYemleZbTCA+L1bpRRhq4f5JYClOVT0IjKgfmEHBI
	VkfwFdSsYyGaNmnpKWbhd284Rj8bnRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776885255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVuxbSAzewsAYv8/qYWz0g/O7K1OXFm7e8ZlxXnfSt0=;
	b=hj/9OoPci7zg8PPoyMK0MyMxe3VC2eAGp6yMRvAy6bpbYPxDfjounNHVHFtjkvEqgKhrP0
	/9O821rA4F0IZDDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1776885255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVuxbSAzewsAYv8/qYWz0g/O7K1OXFm7e8ZlxXnfSt0=;
	b=REnHlWwNhU+aY9Fe7p+ZajDg+lfd0uFecBx1jOdTU0hn6kEFp6Z9Bf2E5Pz2d7C2hhEZNz
	YqUtg3r4rlpSQ3+bsxiBcsZX05/iEKYemleZbTCA+L1bpRRhq4f5JYClOVT0IjKgfmEHBI
	VkfwFdSsYyGaNmnpKWbhd284Rj8bnRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1776885255;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kVuxbSAzewsAYv8/qYWz0g/O7K1OXFm7e8ZlxXnfSt0=;
	b=hj/9OoPci7zg8PPoyMK0MyMxe3VC2eAGp6yMRvAy6bpbYPxDfjounNHVHFtjkvEqgKhrP0
	/9O821rA4F0IZDDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1EAD4593AF;
	Wed, 22 Apr 2026 19:14:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id TleCBgce6WnqegAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Wed, 22 Apr 2026 19:14:15 +0000
Date: Wed, 22 Apr 2026 21:14:13 +0200
From: David Sterba <dsterba@suse.cz>
To: Aleksandar Gerasimovski <Aleksandar.Gerasimovski@belden.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	Rene Straub <Rene.Straub@belden.com>,
	Filipe Manana <fdmanana@suse.com>, Qu Wenruo <wqu@suse.com>,
	David Sterba <dsterba@suse.com>, "clm@fb.com" <clm@fb.com>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 7.0-5.10] btrfs: be less aggressive with metadata
 overcommit when we can do full flushing
Message-ID: <20260422191413.GG12792@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <20260420132314.1023554-1-sashal@kernel.org>
 <20260420132314.1023554-174-sashal@kernel.org>
 <SA1PR18MB56923AA957ABED674340E52C992D2@SA1PR18MB5692.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR18MB56923AA957ABED674340E52C992D2@SA1PR18MB5692.namprd18.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Score: -4.00
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TAGGED_FROM(0.00)[bounces-240382-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[dsterba@suse.cz];
	RCVD_COUNT_FIVE(0.00)[6];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsterba@suse.cz,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6F8EF44A137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 12:24:52PM +0000, Aleksandar Gerasimovski wrote:
> Hi everyone,
> 
> Can you add Rene's tag to the reporter as well, he was the one seeing
> and triggering the that internally and I continued with following that
> with the mailing list:

Technically the Reported-by tag can be added but that would be only for
the stable patches and I don't think this has even been done. Credits
are collected before the patch is merged, after that it's immutable
(574d93fc62e2).

