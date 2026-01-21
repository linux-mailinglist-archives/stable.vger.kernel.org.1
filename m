Return-Path: <stable+bounces-210806-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KEzWMvEscWmcfAAAu9opvQ
	(envelope-from <stable+bounces-210806-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:45:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD725C75E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45429806D34
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C983570CA;
	Wed, 21 Jan 2026 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9WJEoN5"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EEE349B19
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 18:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769018907; cv=none; b=CW0G10qX7SxAHl305ljNi1iPeBDn6C1jAf2jr/4pMtDy8RqCesVhGbAxi6r4WXxzo1V/si5gKXXd97hnVeeW9bKdrrn8eyxOHBMkJj0YO9O4kEL4SEGkkNd0Wfr4YBFoaMeA8t4B7WRq9mF2thV41lgPdYR3oh9do+jTur9uSvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769018907; c=relaxed/simple;
	bh=vVxmaTN6DfAQMnybaHcGPQ0UAXYghYLqHrfg83IBi0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpb5xVvoo0J3nAuj041attbNOEGDuuYKXU1MApB3ovGTBcuaEKrJnPzKnqieV30tRRv4LuLK+l+2EeUozWbFlEfJUOxP0T5fanGmcKE4MrxeADfH0T7P2amuEkOjJVtUEEorJbb2uDoDl5w0RPtV4lnnuQ0rIFcXxoxoL4iYVnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9WJEoN5; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a12ebe4b74so1161985ad.0
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 10:08:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769018905; x=1769623705; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=72auvTTn3y/RhhBaaOjOnqHUYFhZMWqSD++rNQfrdXE=;
        b=K9WJEoN5XiF/8kURq1xAFdXXaYeHiUMKlFRahBUe6BqLlf7iR6B/RJcSwlBvlEcwzp
         xlBnFcr5xeSJgaWFzxcR2BC/65DHVIAl3WAIAM9k6mE3u2BIkvUDBnTksJFRC6SLRdgV
         bjZXrQ/JgOk9pR0aJW39Mm3z2Nl3XhiAHi8LVkxeYP+zDIBStH/T36zWiCBRJGxY2SqV
         kWG5Ctyi4M+sCn7c3sd12GtgCvB1dfk04epE/QOYXIk6/mxa9UBjbtEallporwuQeugf
         6kcbxoaLN3E+EXVHjHaLgJko14vIEw1pDOVC0CBqjxTdrAsoJbFVjmtRuy4slh6BG0eH
         +6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769018905; x=1769623705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=72auvTTn3y/RhhBaaOjOnqHUYFhZMWqSD++rNQfrdXE=;
        b=AeIJEudg3Z/Y6lqocWMtxkBzgRCpoFmKi5ux6oZaS1+k32pbGml+uHAZEbAuMPW579
         A/2JO1z/nnogEIlU3/mrdREJP54E1mUWLIP9A5jc0gdFxoyPj7n6cCn8q1xOWJMf4ZdJ
         CsceGndlcm41EUAPSPXA6IIsi6PA4nMh3M3CDp3tAjohSb4Fxw4sLqh6P15w8PuChksz
         q6UhRQzh+hFoRtNEIJ+2/uVLMlvtH9FHj5lrp8l3e1/Zdp00JPB6KiVKQtFA7hCxhrDq
         792BW+LYXWSCcEl+28Nh56NS1WMkclbbzhtVNOLArlT972I5JrxKCwPKYnQT2iitrNAK
         ilqg==
X-Forwarded-Encrypted: i=1; AJvYcCVUx0sbfEJZAOE93rb3o841WW32+7HJdkhPIjXCbdk9p4QBxSz0JQaaJpchsMbRJuIUTcfVz1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHh+W8bkOFPlgIU9jNbQGND9N33//UbxDuY+VneQPCkR6Za9Mh
	4dlaOF0wxpOKjoVPRfdzyhzjv6BBM9CASto4KpMIJ3Bhv7jNBx+6k7CL
X-Gm-Gg: AZuq6aK7lI8YWCOIFdgRIS72raqTu0Pg1WYibegtfjB7L4+JVhwcUNRb1F/AGKPUczI
	4Pojz3PvsrD0lRTGxVbO6J8T82DOtfvVCUJdbJFiw7iIsrc47q80oPkfmQ+rmj9QTIkKa42+Rrw
	CludmP11hU8R0picTwDKQHcIw/zlkWPFFm3gwmIK7eyr26KnUL1rTZbRvDTYrJIDPNFetcx+3Op
	JGPUGnrNGrcf63HJV8Sa2cs0jNKYGBxXtHYMQXrBsvfd1S1yp/QXs12xZBWY1BpsrApshNYpEX1
	JP0WND8eiBJiorRlJqT6ur1kDzCl6O+1iy4N1bmqdhVWVhI7wCSZu1bau3k9oqqgbmoP8STAaja
	8wdOJrT2MLMGEvULZT6cmppIIs2prkFzDgRq5ddLcflc9KjpJhc+OaFN0qrfFShg5c+rNWJ36Gs
	5FUbJ8hsBXIuw=
X-Received: by 2002:a17:903:22ce:b0:2a3:e7fe:646e with SMTP id d9443c01a7336-2a768a7e6e7mr60039705ad.5.1769018905199;
        Wed, 21 Jan 2026 10:08:25 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a719406505sm157012105ad.84.2026.01.21.10.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 10:08:24 -0800 (PST)
Date: Wed, 21 Jan 2026 23:38:15 +0530
From: Prithvi <activprithvi@gmail.com>
To: Bart Van Assche <bvanassche@acm.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
	hch@lst.de, jlbec@evilplan.org, linux-fsdevel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, khalid@kernel.org,
	syzbot+f6e8174215573a84b797@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Fix recursive locking in
 __configfs_open_file()
Message-ID: <20260121180815.usbtlsqxqdgriqqs@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
 <20260119185049.mvcjjntdkmtdk4je@inspiron>
 <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
 <20260121175136.2ku57xskhwwg7syz@inspiron>
 <6927d0f7-5bf5-4035-b1c2-50f3edae4b7f@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6927d0f7-5bf5-4035-b1c2-50f3edae4b7f@acm.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210806-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[oracle.com,vger.kernel.org,lst.de,evilplan.org,lists.linux.dev,linuxfoundation.org,gmail.com,kernel.org,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[activprithvi@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f6e8174215573a84b797];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: BBD725C75E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 09:59:49AM -0800, Bart Van Assche wrote:
> On 1/21/26 9:51 AM, Prithvi wrote:
> > I tried using lockdep_register_key() and lockdep_unregister_key() for the
> > frag_sem lock, however it stil gives the possible recursive locking
> > warning. Here is the patch and the bug report from its test:
> > 
> > https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m3203ceddf3423b7116ba9225d182771608f93a6f
> > 
> > Would using down_read_nested() and subclasses be a better option here?
> > 
> > I also checked out some documentation regarding it and learnt that to use
> > the _nested() form, the hierarchy among the locks should be mapped
> > accurately; however, IIUC, there isn't any hierarchy between the locks in
> > this case, is this right?
> > 
> > Apologies if I am missing something obvious here, and thanks for your
> > time and guidance.
> 
> This is unexpected. Please ask help from someone who is familiar with VFS
> internals. I'm not familiar with these internals.
> 
> Thanks,
> 
> Bart.

Sure, no problem...thank you very much for your time and guidance :)

Best regards,
Prithvi

