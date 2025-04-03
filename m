Return-Path: <stable+bounces-127503-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2C5A7A169
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 12:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85EBE170391
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 10:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FDDE248891;
	Thu,  3 Apr 2025 10:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ucnJKdiM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CjPRKR3v";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ucnJKdiM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CjPRKR3v"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820281F4C84
	for <stable@vger.kernel.org>; Thu,  3 Apr 2025 10:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743677578; cv=none; b=DB+Z0qwhBabaaL3pcuALRa7D+7xPC0KuW1DmTEGrHHM0yYkm6k2N6N3W8+xtyrB3b9+cMs4/CliKuzfLFljPzWYZU+SOdC2Q92ZV1kT+aMAh4HhPGynTsyE29jgTkrMm0CLi7I5qYl35FPjgKyMzZydtR+6BO+psmJZz/Z1Z+tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743677578; c=relaxed/simple;
	bh=SWg2hKOjyoZYJKlnzcYdNywCSuGj3SLTw51+7g4s9T4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GUe+BGECq12fJ1RjQRlJryv2v73NPJ/lp1YVUCTH5uEBIKeCfTiu85UD8PmegnNQFZcLa6D+FXV4PiPB/fG5AWlyXXBgNxhy6JWO4SQPpqCEiaqI1bIN2FDz4JHhpw9qbXcOh0R4TtNcyrMas72/XL2rV9aur+2gkW7pP76h9jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ucnJKdiM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CjPRKR3v; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ucnJKdiM; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CjPRKR3v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7C8D9211B3;
	Thu,  3 Apr 2025 10:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743677574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJRwADuh9Gf8w3cJ3qkn0sEpYgoWwqfQMCfDUgsVJYo=;
	b=ucnJKdiMegpOJAdc2tH5ka7+226kXUodBZMjJOuH8o7n/l4F3VZl53M+C1+Jg0RD+JAcXA
	wWyEeEhrGSqmqmvZG4QGaAY/k1ax7ymRyFZrJeuduL/9BITbQp9PAHxk2ZnWjWHlotXj5D
	Vnxn0hnMxKJxTCgtybHZlzSZ9Juw+yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743677574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJRwADuh9Gf8w3cJ3qkn0sEpYgoWwqfQMCfDUgsVJYo=;
	b=CjPRKR3vdRJbDa0YIb0G/MQr/L2JCsmTMz2xbLc2iXEdn6EM9PYT/smyZRDaO+9bLxmDLX
	j0Drw6N2bPE2+dBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ucnJKdiM;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CjPRKR3v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1743677574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJRwADuh9Gf8w3cJ3qkn0sEpYgoWwqfQMCfDUgsVJYo=;
	b=ucnJKdiMegpOJAdc2tH5ka7+226kXUodBZMjJOuH8o7n/l4F3VZl53M+C1+Jg0RD+JAcXA
	wWyEeEhrGSqmqmvZG4QGaAY/k1ax7ymRyFZrJeuduL/9BITbQp9PAHxk2ZnWjWHlotXj5D
	Vnxn0hnMxKJxTCgtybHZlzSZ9Juw+yk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1743677574;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RJRwADuh9Gf8w3cJ3qkn0sEpYgoWwqfQMCfDUgsVJYo=;
	b=CjPRKR3vdRJbDa0YIb0G/MQr/L2JCsmTMz2xbLc2iXEdn6EM9PYT/smyZRDaO+9bLxmDLX
	j0Drw6N2bPE2+dBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 048BC1392A;
	Thu,  3 Apr 2025 10:52:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XE+5OoVo7mfnDQAAD6G6ig
	(envelope-from <jdelvare@suse.de>); Thu, 03 Apr 2025 10:52:53 +0000
Date: Thu, 3 Apr 2025 12:52:52 +0200
From: Jean Delvare <jdelvare@suse.de>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Tudor Ambarus <tudor.ambarus@linaro.org>, Pratyush Yadav
 <pratyush@kernel.org>, Michael Walle <michael@walle.cc>,
 <linux-mtd@lists.infradead.org>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>, Steam Lin
 <stlin2@winbond.com>, kernel test robot <lkp@intel.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH] mtd: spinand: Fix build with gcc < 7.5
Message-ID: <20250403125252.03432904@endymion>
In-Reply-To: <20250401133637.219618-1-miquel.raynal@bootlin.com>
References: <20250401133637.219618-1-miquel.raynal@bootlin.com>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7C8D9211B3
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,bootlin.com:email,intel.com:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Tue,  1 Apr 2025 15:36:37 +0200, Miquel Raynal wrote:
> __VA_OPT__ is a macro that is useful when some arguments can be present
> or not to entirely skip some part of a definition. Unfortunately, it
> is a too recent addition that some of the still supported old GCC
> versions do not know about, and is anyway not part of C11 that is the
> version used in the kernel.
> 
> Find a trick to remove this macro, typically '__VA_ARGS__ + 0' is a
> workaround used in netlink.h which works very well here, as we either
> expect:
> - 0
> - A positive value
> - No value, which means the field should be 0.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503181330.YcDXGy7F-lkp@intel.com/
> Fixes: 7ce0d16d5802 ("mtd: spinand: Add an optional frequency to read from cache macros")
> Cc: stable@vger.kernel.org
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

Tested-by: Jean Delvare <jdelvare@suse.de>

Thanks Miquel!

-- 
Jean Delvare
SUSE L3 Support

