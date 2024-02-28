Return-Path: <stable+bounces-25358-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B0086AF35
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 066E81C24270
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD754145341;
	Wed, 28 Feb 2024 12:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RTBCD2TG";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="RTBCD2TG"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B4413B29F
	for <stable@vger.kernel.org>; Wed, 28 Feb 2024 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709123470; cv=none; b=UiaJhR5RAgnfstGAj2RPvlyp86PFlp5GJaI4yWOqNvH4DDeltSluNFoJ9FhOj+qZYBHTCSkUs1LUv39EcjbGhH5MhIkZI8Q0q91GKOxQKtKfTNFVxUbvWxI76A5Y4dB4xZYWb+TfciRpLkBGRIO7byvRwU1BpwS85fpuw+GYfvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709123470; c=relaxed/simple;
	bh=B6B5qbwsu02wLwk7JqcnhaNSetR2oVpqkqUFAl1Y6ys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A97Ro4CU6gFUXUIYgarKnYuOQCpHhs5gLLBNQjZ/pyytdt1WiMZ77EU+hf2xuSTeb49YRsjUEzUCXmsS3CsXJ+4eOBF53yF/8s5z5oa5YD811cXfUZMpSsQRhXSqBIO1kMY5wJu2TrT05prSrHAKYAhv9DFZWich+Qh6C0D9lyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RTBCD2TG; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=RTBCD2TG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9F3B521EF4;
	Wed, 28 Feb 2024 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709123466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvGUREEPpmxQWTsLz8XuGTyDXHJu/eo1aXg75bkSMmE=;
	b=RTBCD2TGarpeTNhEx/iGBvxWWnWkNz/t/uY1ZNeM7gUU4fYcEioF/aOajzGJAVwJaycWlK
	tcoEA7D7buv9e6I8GUGwBmdRyShhauxAQkOcfy8bYw4L959qJmDalNV7fHDzjswUShnHCU
	vCfM5D6I2uLg+Yq+U2WokkbDzdwV3P0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709123466; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvGUREEPpmxQWTsLz8XuGTyDXHJu/eo1aXg75bkSMmE=;
	b=RTBCD2TGarpeTNhEx/iGBvxWWnWkNz/t/uY1ZNeM7gUU4fYcEioF/aOajzGJAVwJaycWlK
	tcoEA7D7buv9e6I8GUGwBmdRyShhauxAQkOcfy8bYw4L959qJmDalNV7fHDzjswUShnHCU
	vCfM5D6I2uLg+Yq+U2WokkbDzdwV3P0=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7F1C013A58;
	Wed, 28 Feb 2024 12:31:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZfZbHIon32VYVwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 28 Feb 2024 12:31:06 +0000
Date: Wed, 28 Feb 2024 13:31:05 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, guro@fb.com, hannes@cmpxchg.org,
	hughd@google.com, shakeelb@google.com,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] memcg: fix use-after-free in
 uncharge_batch" failed to apply to 5.4-stable tree
Message-ID: <Zd8niX5-e2cAth2X@tiehlicka>
References: <2024022759-crave-busily-bef7@gregkh>
 <Zd3jqLMSktEpZPM4@tiehlicka>
 <2024022704-overjoyed-display-b5cb@gregkh>
 <Zd4EnXYVbZilQR_M@tiehlicka>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd4EnXYVbZilQR_M@tiehlicka>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=RTBCD2TG
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.68 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.67)[92.91%]
X-Spam-Score: -2.68
X-Rspamd-Queue-Id: 9F3B521EF4
X-Spam-Flag: NO

On Tue 27-02-24 16:49:50, Michal Hocko wrote:
> On Tue 27-02-24 14:32:20, Greg KH wrote:
> > On Tue, Feb 27, 2024 at 02:29:12PM +0100, Michal Hocko wrote:
> > > Why is this applied to 5.4?
> > > $ git describe-ver 1a3e1f40962c
> > > v5.9-rc1~97^2~97
> > > 
> > > I do not see 1a3e1f40962c in 5.4 stable tree. What am I missing?
> > 
> > It is queued up for this next round of releases in the 5.4.y and 4.19.y
> > trees.
> 
> OK, now I remember the partial backport of 1a3e1f40962c
> (http://lkml.kernel.org/r/20240222030237.82486-1-gongruiqi1@huawei.com)
> but I need to have a look whether the follow up patch is really needed.

AFAICS f1796544a0ca ("memcg: fix use-after-free in uncharge_batch") is
only needed if the full 1a3e1f40962c is backported. The one staged for
5.4 shouldn't need a follow up as it only touches the pcp cache. I would
feel safer if other maintainers double check my thinking though.

Thanks
-- 
Michal Hocko
SUSE Labs

