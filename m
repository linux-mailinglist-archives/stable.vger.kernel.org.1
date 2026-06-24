Return-Path: <stable+bounces-268170-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id v1qYATfjO2pvewgAu9opvQ
	(envelope-from <stable+bounces-268170-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:01:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A16BEE7E
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 16:01:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=rowland.harvard.edu header.s=google header.b=KstfDJkD;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268170-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268170-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=rowland.harvard.edu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9D983015853
	for <lists+stable@lfdr.de>; Wed, 24 Jun 2026 14:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B565F3B19C2;
	Wed, 24 Jun 2026 14:01:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380A526F29B
	for <stable@vger.kernel.org>; Wed, 24 Jun 2026 14:01:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782309673; cv=none; b=IU9xPoT/5hdwHZbg1fi91czMvYlw4ZL6bcou6cjtDuGYD01MEwtAIJLe3rUVURyVZjV975GFrgUyOn6kYBJuQd4px7t5pDNQb28vZzwhApY+0S9DBmMB0GWis0SDm97r/y+ycmjnWYIP0pi7exlwMa1jm6Hj0qaa/6Olibed0+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782309673; c=relaxed/simple;
	bh=sqz/nCl4XMoZ5TKKVVNz5tAI/LScRoJeM9WbyPmJx3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBWX/PWsN5XK3JqiTh5ZIbWeBRhjES7ciRiD82fHCWV7QbD9+nGT8XFFErGJ2qlWxcor8fc3o1L3HliZoZU7dTj82QLnfvh+Uq2aFl2q8mJ23h8ZBXMyK7ECS+t+tXGcKGTh3B6V0Zz3eAP9+WLpSkNHYItEuVgf6yJDMSPSd2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=KstfDJkD; arc=none smtp.client-ip=209.85.222.174
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-915b5ce94c7so93377985a.2
        for <stable@vger.kernel.org>; Wed, 24 Jun 2026 07:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1782309671; x=1782914471; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wsEoW4DBoKT0fUYLZPdL7MZJTkz7+GAlNaoQ4msQnkg=;
        b=KstfDJkDlEZuT1HYy2wLN0zzVO7os9Mav9CMPrsd7Kv98rDcLUS7Wg5ukVEMLr3LVG
         wrMAP69DjNNNzDVB2ZNOfiTOc1hFWk6LOgZdLKLlC+joHQiuqFZ40e7hNzcPh9oWhGY/
         2G/O2HjDTmBS9oRGG1S37xQaTYUM3wBJHlcPNdyjlvsE1IDgBr7ovk0ZlAyLMvD5K4F2
         s+LsOd3mFqtYmxhVb2PFHtvW7RF7jgiJBAVwWIQuzP65aYXobwjDznATwWFVkYABsJXZ
         LVH9wW2TsSZf+p2SWTS7/3e2nLXqldUfpW6QUJzVbbrD9x+kGVzbxfNNIV+4CBNNqAON
         puzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782309671; x=1782914471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsEoW4DBoKT0fUYLZPdL7MZJTkz7+GAlNaoQ4msQnkg=;
        b=LSvXT0WjVyPXV9BSFSqMVxYUmENC2NPjvxg0fuwzZa9baKoOF5spSNp9cXwd0VzhNs
         jWSl6Nr2lOhXBQl4sRUSgz5Z1qGRfnhp2N1AD7nzfBtgjatUfRXa84hsaIs97ZFZ+SmM
         TyoaQhI2jAbzR8CsEY79rTQX9QSdv27/Jg+KDHltBPFTXjmHO9o+xX5bsrxtNcYcyNpP
         9tVGrZfu7TMVBV+zRpsSd74P4bmL4YNHwFcNJ2kiUvIn60ckXJGbFvk6n6BE8m1y2ROV
         uHGvsrB6gIqZZpmA3tM8lPa8nSzsEQHn2rHcQwSF9MEw36SKFZOmqG03S7Rp8JTu+tfy
         auxA==
X-Forwarded-Encrypted: i=1; AFNElJ/ukKjiLEHtGXwO6lV6mWH4k3YCMtXlcsI/UApfVImCCGi9OogQNIwYGleWBpLkFTF/OTAuxC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6xnmQsd/TJjnV1pK8jRdIu1/X4cjj0b3I8WdeJAzlD27GfZlx
	BulJXlvg1/0Wk9J2LDo5/29cyVsUZUmfZqaOMfG13gPBeLCkr9nLUvsMSh1kBs4l2Q==
X-Gm-Gg: AfdE7clg+aNnUC7oLXt0I25BOktweYD64ZmnpzpBm320lD8yyPep+OVJNI6/qfl+qjT
	n/WhmQrRcQBJ3B7y0oQa+4LXLGNDRvB/+v6g33x4IV/0tk/Maz6NTRH/LAHLc6jFzQQzIw/A+XT
	68uu+++nklBNEmJSgdk2KDouojdTsvRnhMpO3/qx1Z3xOM0a58g6ZzEtr7ENKVvaCRJsjekURIZ
	aOiOuIl8IwetVkPTO1K2zcbvcc2KX9Ml7pXoAt1wlQZfvJdEZmIlp4qSiqsXXaho5NuOxpUXFtg
	A1g7cuQFjsgoUJH98qQgHea2dOn2F+QcPnLRWtwhXQLGRdxuz0cyem24zxjdiCglvyiuyMDNQ68
	Nq7OmaHnOHJiHwFj9I51ZHTDOjjpeC7z6DG5n0CXgrA4XOq/uV6yVx3apCC9C+wmjPgygRRtnpl
	v8qhPnK3J2BiEV1H/wR+CZKJubAmLZQRQ9
X-Received: by 2002:a05:620a:1a09:b0:915:cb5c:7f70 with SMTP id af79cd13be357-927800a2787mr561454085a.29.1782309641938;
        Wed, 24 Jun 2026 07:00:41 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d01:d210:d62f:1911:f952:16ba])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92600c7bf55sm552191785a.46.2026.06.24.07.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 07:00:41 -0700 (PDT)
Date: Wed, 24 Jun 2026 10:00:38 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Nikhil Solanke <nikhilsolanke5@gmail.com>
Cc: linux-usb@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org, michal.pecio@gmail.com,
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
Message-ID: <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[rowland.harvard.edu,none];
	R_DKIM_ALLOW(-0.20)[rowland.harvard.edu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,gmail.com,lwn.net];
	TAGGED_FROM(0.00)[bounces-268170-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:nikhilsolanke5@gmail.com,m:linux-usb@vger.kernel.org,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:michal.pecio@gmail.com,m:stable@vger.kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:michalpecio@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[rowland.harvard.edu:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stern@rowland.harvard.edu,stable@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rowland.harvard.edu:dkim,rowland.harvard.edu:mid,rowland.harvard.edu:from_mime,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 331A16BEE7E

On Wed, Jun 24, 2026 at 01:36:28PM +0530, Nikhil Solanke wrote:
> > Actually, the best approach here would be to put this single change into
> > a separate patch that comes before the current one.  That removes issues
> > of making more than one functional change in one patch and improves
> > bisectability.
> 
> Before? Shouldn't it be after my changes? That would make it easier to
> justify the changes. And just to be sure, you did mention it does
> align with what the intention of USB_QUIRK_DELAY_INIT, but it does
> change its behavior when the quirk is not set. Atleast from what I
> understood from the documentation and an LLM's summary, the device
> needs time to prepare the full configuration set. So, does delaying
> before the first header read really work? I can't test this since I
> don't have a device that requires the quirk to be set.
> 
> I personally think adding a condition to check if the quirk is set and
> then delaying before sending the first request would be appropriate.
> What are your opinions on this.

Well, put it this way: If you change the existing behavior, that change 
belongs in a separate patch.  If you want to redo this patch so that it 
doesn't change anything when the quirk flag isn't set, that's fine.

> Also is it fine if the string lines exceed 100 columns?

In lines containing long strings, it's okay for the string to extend 
well beyond 80 columns.  But then you should break the line at some 
point closely following the end of the string.  I'm sure you can find 
examples of this if you look through some of the other source files.

> Also, is there a need to check for krealloc()'s return value? Since we
> are only shrinking the buffer, there won't be any moves or completely
> new blocks (at least as per my understanding). Do I still need to
> check its return value for completeness' sake?

It's a little tricky to track this down, but if you look in 
include/linux/slab.h you'll see that krealloc() is defined as 
krealloc_node(), which is defined as krealloc_node_align(), which is 
defined as krealloc_node_align_noprof(), which is declared with 
__must_check.  So yes, you need to check the return value from 
krealloc().

Of course, you could simply try not checking the return value and seeing 
if that provokes a warning or error from the compiler.

Alan Stern

