Return-Path: <stable+bounces-72767-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D65C296958B
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1442D1C23292
	for <lists+stable@lfdr.de>; Tue,  3 Sep 2024 07:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803B61D6DC2;
	Tue,  3 Sep 2024 07:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzbTX+ki";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="a90nMhHL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="SE0xcmyo";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/HtWBsRp"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8771D6C7A
	for <stable@vger.kernel.org>; Tue,  3 Sep 2024 07:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725348685; cv=none; b=BWMZ5a5l0PlW+VoJLMuj/K7NaMfFXNWd5Sw+akM82wkMyvT2vjUv3EQ1f6h/Jx5+vRhML3HbgSLmFi0HOgHQySmSrXQ22iRZMbfHFPL9uuFSxsOYjGPGfUpykL0+C5RKaQOnYrak86LjQUet/tlwNyId2VDOehkgPPeh+rOmewU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725348685; c=relaxed/simple;
	bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lnm3eKy5Q5mKpIu/csqUjVhpeLdUcQBQ3VFR2XX4w8c6oWzkId+oIpad+bOHJBAWLFPI1C8gOmiV1fgVfgEJj4sxxZXI3l2OwzSjUd2KTWLAg+fno7uStFujPh16xzu3B/KktRTBJ+G0vRuRur4ZhJmhr5JLyVJTD40nf95S/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzbTX+ki; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=a90nMhHL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=SE0xcmyo; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/HtWBsRp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B9AC71FCF3;
	Tue,  3 Sep 2024 07:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725348681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
	b=OzbTX+kiYnX1kJMkKsazkuoPXxoWZpnLQbDm29vi639bmdMFLhfQTo0G+4Q5t7b40E3Ib2
	L3cNWrYJsCf0ZHfe0QY8jzS9/a96/bDic8nHNuzI/OLZs8+n0cxWJvF3HuInMJmQSBKiaP
	SQC4c1cZYnXkcGtdvNH0vp2m8IqhJ6c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725348681;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
	b=a90nMhHLvoi+r09tX+x6N35gtkchjQ+VRm5ue/kaEJlHzdZJWaEgWxS4Zkx4edeRbT+npn
	OmsHtQL+lVVcyuDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=SE0xcmyo;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/HtWBsRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1725348680;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
	b=SE0xcmyofO2HBQXKkxV01N+wnsM99hl9PZxYGfqS8P5E/qxpDmDEycI9i8TCZZcqN4jdPF
	7zO9eVys/BDN4d//ZQbZlDpRkhLg2fG39YIEf2Xkm1jDJR6MRF0Y/JQz0Hsgf7/JNVv/B5
	bZ0mnbnDuO9ylq+wgyzfYLzNAYPsx8Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1725348680;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NdGl09ae5aOwGpA1yeG0QYr2/4XDZNyMPzN3I4cDk+o=;
	b=/HtWBsRp9YsYyRiaMF0Afeo+loFRfaACnkefZlq9OAYCsboQkrKU6cKpwMIabk5VqHLDyU
	6TLMJEWksILt+DDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7C90813A52;
	Tue,  3 Sep 2024 07:31:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8AyXHEi71mb2TwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 03 Sep 2024 07:31:20 +0000
Date: Tue, 3 Sep 2024 09:31:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: cel@kernel.org
Cc: ltp@lists.linux.it, Amir Goldstein <amir73il@gmail.com>,
	stable@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH RFC] syscalls/fanotify09: Note backport of commit
 e730558adffb
Message-ID: <20240903073115.GA726144@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240831160900.173809-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240831160900.173809-1-cel@kernel.org>
X-Rspamd-Queue-Id: B9AC71FCF3
X-Spam-Score: -3.71
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,vger.kernel.org,oracle.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Chuck,

thanks for your patch, merged!

Kind regards,
Petr

