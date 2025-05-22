Return-Path: <stable+bounces-146078-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACD1AC0AC8
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 13:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6731741D9
	for <lists+stable@lfdr.de>; Thu, 22 May 2025 11:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0105823D291;
	Thu, 22 May 2025 11:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P2TFZOnl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7a29t8u";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="P2TFZOnl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w7a29t8u"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369FC230BC2
	for <stable@vger.kernel.org>; Thu, 22 May 2025 11:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747914571; cv=none; b=dm5C5HID9Xu7t2bmko0VG27SIh9DQgNvz33VQTfDBGqgJSlf6FZw1Yxp6ZbOGq4i6So1R/dTHpONKUi+TcFxRrkLckaj0AGa7SE+6MXh89upkHNh7umHb4UdcCphtN2YOT61ibixXxDI3YQPnx8Vlvetyd982r+osaYqGRq3yFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747914571; c=relaxed/simple;
	bh=TuBx5StHK8VP1xW3hG0mkITonEVjlS9yKCzdQ9VZWGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5DjDoZMv3MDd6Aac7ckWwwEOYvXxSvcWPhtx/sd+7MRd9gY8Xk9FeU2IvjaY4LEygJn4d/myv9t8IV7YZwwZefU3gh9P9SA+WJ3BZAfXuYC0W1kYsrjRgdtr3RtlsJVG+Pct/e5EJLzlYTBuvu3XAKgrIU9ziA3XzBFeUko2VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P2TFZOnl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7a29t8u; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=P2TFZOnl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=w7a29t8u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3F03B21A1C;
	Thu, 22 May 2025 11:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747914568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQRUtWyOBWmX6kLMyTdH5usDFLYr4fmjaiIBz46kNI8=;
	b=P2TFZOnl4F5ci4DzulKguOM5w1aVEkvgjuxVMzS4WT1rvpAK/PoJ44urk1jsHWxEncr4qL
	1Qz/WgoC8nc4uSQGVTtRfhgmffmbaHY8/MXjtbWXaWaUNE90R/Pgs69OkzQSP+D/dQDf6K
	Lh/p3Q97xyWKy2LssxEQwUEa9zrLdBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747914568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQRUtWyOBWmX6kLMyTdH5usDFLYr4fmjaiIBz46kNI8=;
	b=w7a29t8uekXu6usd189cm7ZRbvY+/sniNqB717Fc59cj5YGvVjosTB3V/hkUBL9XuyeEnH
	fQ2ux3/0sMPqIXCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747914568; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQRUtWyOBWmX6kLMyTdH5usDFLYr4fmjaiIBz46kNI8=;
	b=P2TFZOnl4F5ci4DzulKguOM5w1aVEkvgjuxVMzS4WT1rvpAK/PoJ44urk1jsHWxEncr4qL
	1Qz/WgoC8nc4uSQGVTtRfhgmffmbaHY8/MXjtbWXaWaUNE90R/Pgs69OkzQSP+D/dQDf6K
	Lh/p3Q97xyWKy2LssxEQwUEa9zrLdBQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747914568;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GQRUtWyOBWmX6kLMyTdH5usDFLYr4fmjaiIBz46kNI8=;
	b=w7a29t8uekXu6usd189cm7ZRbvY+/sniNqB717Fc59cj5YGvVjosTB3V/hkUBL9XuyeEnH
	fQ2ux3/0sMPqIXCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E663137B8;
	Thu, 22 May 2025 11:49:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n1mzAkgPL2g5YwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 22 May 2025 11:49:28 +0000
Date: Thu, 22 May 2025 13:49:26 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Ge Yang <yangge1116@126.com>
Cc: Muchun Song <muchun.song@linux.dev>, akpm@linux-foundation.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, 21cnbao@gmail.com, david@redhat.com,
	baolin.wang@linux.alibaba.com, liuzixing@hygon.cn
Subject: Re: [PATCH] mm/hugetlb: fix kernel NULL pointer dereference when
 replacing free hugetlb folios
Message-ID: <aC8PRkyd3y74Ph5R@localhost.localdomain>
References: <1747884137-26685-1-git-send-email-yangge1116@126.com>
 <644FF836-9DC7-42B4-BACE-C433E637B885@linux.dev>
 <aC63fmFKK84K7YiZ@localhost.localdomain>
 <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff6bd560-d249-418f-81f4-7cbe055a25ec@126.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_TO(0.00)[126.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[126.com,gmail.com];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,kvack.org,vger.kernel.org,gmail.com,redhat.com,linux.alibaba.com,hygon.cn];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Thu, May 22, 2025 at 07:34:56PM +0800, Ge Yang wrote:
> It seems that we cannot simply remove the folio_test_hugetlb() check. The
> reasons are as follows:

Yeah, my thought was whether we could move the folio_hstate within
alloc_and_dissolve_hugetlb_folio(), since the latter really needs to take the
lock.
But isolate_or_dissolve_huge_page() also needs the 'hstate' not only to
pass it onto alloc_and_dissolve_hugetlb_folio() but to check whether
hstate is gigantic.

Umh, kinda hate sparkling the locks all around.


-- 
Oscar Salvador
SUSE Labs

