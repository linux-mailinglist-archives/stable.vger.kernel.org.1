Return-Path: <stable+bounces-124614-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D4A644E4
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 09:14:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59C3A17028A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 08:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7262421B9E3;
	Mon, 17 Mar 2025 08:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V0ZEFRb9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nqxvI8JE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="V0ZEFRb9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nqxvI8JE"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B8BC21B9D5
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 08:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742199261; cv=none; b=ldXq9e3uJvcBizPLeZRmtXGU44zz0qXROZlASiEalavkLoRgzt+DOIjj3HIq0/kkBOE+SWknfOEJ3jd7Q3hFMMjsld5zI3xpnIGJgIyspjWjplTKpPoGw9+HHjBBHCE9qZlbzDaSWbT0XhKnxsf5o2NSXYIvdEPFNe+d5S2ySyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742199261; c=relaxed/simple;
	bh=TYc1oGCIqXLOAcShopqfbufU4H8MgOh0B+So20qNu0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD7ScseAa2b+W2tEGfCBIiNklD3XpEtaISOtGJzG1epBo0AFUazzMtxKrTl6DWzXT3ObUcfRjApiNKDXD+iIc3z/HX8IpwhNmHd1PInZc0wsMG/8TMXB3uaKbWyFl0Gu+L/U6Rb2qljV/U53Frz2P8gsk2fP6IKPyNdTy7otQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V0ZEFRb9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nqxvI8JE; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=V0ZEFRb9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nqxvI8JE; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8075821DBE;
	Mon, 17 Mar 2025 08:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742199256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCTGw/BFSjubs8TBP1yIA3Y0RHW0h2F1P3Zw3fQtEPY=;
	b=V0ZEFRb9JuaI9yL04aDcBcr7LutzggU4bXYJl3A/M5TwQhsMT3LiOByJ0Hhq/odoOzvTb7
	5QzNCs7KMtMMlEK96TfIWhNocVZWN/AOxK2UTYl8wuOj05VtJpmay6qBSbzwWD4RlCLBAM
	GtJUb9wxjz91lonyO8Ixt1i2Tzq9OtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742199256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCTGw/BFSjubs8TBP1yIA3Y0RHW0h2F1P3Zw3fQtEPY=;
	b=nqxvI8JEz8JnpFAExQ0FpXawpIoh96jCXZHOMcdum/pVwBBxh912Sgle++cixUauK+nA9Q
	oiPd7lqtmTReRrCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V0ZEFRb9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=nqxvI8JE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742199256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCTGw/BFSjubs8TBP1yIA3Y0RHW0h2F1P3Zw3fQtEPY=;
	b=V0ZEFRb9JuaI9yL04aDcBcr7LutzggU4bXYJl3A/M5TwQhsMT3LiOByJ0Hhq/odoOzvTb7
	5QzNCs7KMtMMlEK96TfIWhNocVZWN/AOxK2UTYl8wuOj05VtJpmay6qBSbzwWD4RlCLBAM
	GtJUb9wxjz91lonyO8Ixt1i2Tzq9OtM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742199256;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OCTGw/BFSjubs8TBP1yIA3Y0RHW0h2F1P3Zw3fQtEPY=;
	b=nqxvI8JEz8JnpFAExQ0FpXawpIoh96jCXZHOMcdum/pVwBBxh912Sgle++cixUauK+nA9Q
	oiPd7lqtmTReRrCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D92D132CF;
	Mon, 17 Mar 2025 08:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id msdvGtjZ12dedgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 17 Mar 2025 08:14:16 +0000
Date: Mon, 17 Mar 2025 09:14:15 +0100
From: Daniel Wagner <dwagner@suse.de>
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, wagi@kernel.org, 
	James Smart <james.smart@broadcom.com>, Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: Patch "nvme-fc: do not ignore connectivity loss during
 connecting" has been added to the 6.13-stable tree
Message-ID: <edd5aaf7-a6f0-4570-a640-6792ae0c57ed@flourine.local>
References: <20250315133440.904579-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250315133440.904579-1-sashal@kernel.org>
X-Rspamd-Queue-Id: 8075821DBE
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi Sasha,

On Sat, Mar 15, 2025 at 09:34:40AM -0400, Sasha Levin wrote:
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This fix is unfortunately buggy (schedule in atomic context). There is a
fixup patch which would be necessary alongside this patch:

f13409bb3f91 ("nvme-fc: rely on state transitions to handle connectivity
loss")

Thanks,
Daniel

> commit e0cdcd023334a757ae78a43d2fa8909dcc72ec56
> Author: Daniel Wagner <wagi@kernel.org>
> Date:   Thu Jan 9 14:30:49 2025 +0100
> 
>     nvme-fc: do not ignore connectivity loss during connecting

