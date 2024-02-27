Return-Path: <stable+bounces-25265-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B564D869B1C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 16:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47E51C247A1
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 15:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F111420B3;
	Tue, 27 Feb 2024 15:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Is87BeW9";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Is87BeW9"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9189146000
	for <stable@vger.kernel.org>; Tue, 27 Feb 2024 15:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048993; cv=none; b=fnJi3tDmqKXPzbcGH/6nvEFyWiFaKnpz7qNlwnZSINStdZZGU9iCfIngOJvab+EE7T2OBLuCcVcCx3evT0o5Tx1FnVO/HQvFCKGk4uUjOxw9qyXgFjOoHupR3HMpv5T9Sp6gKQPV0/5QzGHWB8DQ+L9ePYSkHpgMNUm/olu8WJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048993; c=relaxed/simple;
	bh=Po7J7zDN+TiIHmbbE3zOhmBlhZ0lS4ZZg6Lgnl6Pgjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2OsM1105FYbN82kX04iR+k+KKJs0CVkVhap+/Ok8WuD3kd+PAgWO1yIsnx43FuJqBm7LUDrJBwBbtyHM/KlOK0wFuZkKl7xj82btsdFvEShijtoAJn8wfnjUBoSSQOaQlly3N3P5PtwG02XGlIw69aXqeHL4bH3CXbZqjDrDcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Is87BeW9; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Is87BeW9; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 086E722265;
	Tue, 27 Feb 2024 15:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709048990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHOjCuXYX3NAFIxw/jtnvBmhzhA+CHEjuBWdtVOcTHM=;
	b=Is87BeW9xmxj3hfHmJ53ewrE5ARStfu54joxZCQo8FE6lsUvC9zD5EjeCBweyhfObkuxkP
	7Y8dXtj7SgUpkKFm3NWaoZvKye7yPBAeatkM+M6YVIO0iLqoaGCQlW+Ubar8cWz4+OIRj0
	cwTJVRUjW8kOw2NMD9zdHCZOgjqFjAM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1709048990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HHOjCuXYX3NAFIxw/jtnvBmhzhA+CHEjuBWdtVOcTHM=;
	b=Is87BeW9xmxj3hfHmJ53ewrE5ARStfu54joxZCQo8FE6lsUvC9zD5EjeCBweyhfObkuxkP
	7Y8dXtj7SgUpkKFm3NWaoZvKye7yPBAeatkM+M6YVIO0iLqoaGCQlW+Ubar8cWz4+OIRj0
	cwTJVRUjW8kOw2NMD9zdHCZOgjqFjAM=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 00C8C13A58;
	Tue, 27 Feb 2024 15:49:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IsIsAJ4E3mWHUgAAD6G6ig
	(envelope-from <mhocko@suse.com>); Tue, 27 Feb 2024 15:49:50 +0000
Date: Tue, 27 Feb 2024 16:49:49 +0100
From: Michal Hocko <mhocko@suse.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, guro@fb.com, hannes@cmpxchg.org,
	hughd@google.com, shakeelb@google.com,
	torvalds@linux-foundation.org, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] memcg: fix use-after-free in
 uncharge_batch" failed to apply to 5.4-stable tree
Message-ID: <Zd4EnXYVbZilQR_M@tiehlicka>
References: <2024022759-crave-busily-bef7@gregkh>
 <Zd3jqLMSktEpZPM4@tiehlicka>
 <2024022704-overjoyed-display-b5cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022704-overjoyed-display-b5cb@gregkh>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=Is87BeW9
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-6.79 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.com:dkim];
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
	 BAYES_HAM(-2.28)[96.60%]
X-Spam-Score: -6.79
X-Rspamd-Queue-Id: 086E722265
X-Spam-Flag: NO

On Tue 27-02-24 14:32:20, Greg KH wrote:
> On Tue, Feb 27, 2024 at 02:29:12PM +0100, Michal Hocko wrote:
> > Why is this applied to 5.4?
> > $ git describe-ver 1a3e1f40962c
> > v5.9-rc1~97^2~97
> > 
> > I do not see 1a3e1f40962c in 5.4 stable tree. What am I missing?
> 
> It is queued up for this next round of releases in the 5.4.y and 4.19.y
> trees.

OK, now I remember the partial backport of 1a3e1f40962c
(http://lkml.kernel.org/r/20240222030237.82486-1-gongruiqi1@huawei.com)
but I need to have a look whether the follow up patch is really needed.

-- 
Michal Hocko
SUSE Labs

