Return-Path: <stable+bounces-210803-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CrHMPkqcWniewAAu9opvQ
	(envelope-from <stable+bounces-210803-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:37:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F5E5C509
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id ED01884E533
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 17:55:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B31D346ACC;
	Wed, 21 Jan 2026 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WO/y8HoN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31DB333C50B
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 17:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769017909; cv=none; b=cncyv1q3QY2CTcEoQRgzG6HVatbAgFIL2j0NRQXH3pVndWiFrBuIpKu8xC53UexbWxundb8LSglDOa43X17MCLqOnzQ5nSRX6iGqmV3LqR+wo0GW6FFsLw2uiuYIs2yIL8zygC5KlmDitJ/LpPZGaN/kzeThnllRobViyNEN5NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769017909; c=relaxed/simple;
	bh=1qYGgZ9c1b8r3u+ifdHQSBBS7lpLzGEKtldRnalLi6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dRUNFVpHzWNninMncNIRfQHPBvNSFRDnrDG1LbRBWGWZV80XLAGwEfchATRTDqyK6B9RdyNlR96KIa55yO+SZ0MP7ycpmlCzAdpuq1O8suqnJ/C2Y8WCV9tjI9b/loapPT4MB/cHPPGGEpXvhuQOMQra210UpNwtj0UboGBzcbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WO/y8HoN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-81f3b4ae67bso111101b3a.1
        for <stable@vger.kernel.org>; Wed, 21 Jan 2026 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769017906; x=1769622706; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xSB1wkD3tnNMvDpX/kYDMDj0XcHDa2KakGtOpJoZJvw=;
        b=WO/y8HoN8++LvTXEnlN+3f5gDWDSUm8n+DL3HU2hv1uCQUVaUdkpBB4z1GNQlcQl89
         xX12P/wt4OkuQrJcLbmZZr5Krf3FNaFOeWBVe8WzXf+88X0Z9D/Qn8Wi/FsUSl+z3t7y
         UDaLZ7U5BZDTEg6zkRlas4v1eWL+rBltX/WyU5FLSK18ZAhaYG+IKyL7o3N9Eg6PzR9I
         17Rdkl0uBp20uoqz4j07jCD47tgZU8AwJ1AE2EZOKC8gKSX+P3Vj0Tk7BB70mDF1Tz/o
         GhWiLfWWwxXI625dlz727yNxEacK+wlu1lQH3NcUfqF6zIlyxgXkUI1e1rbA0MeaQpcw
         0QFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769017906; x=1769622706;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSB1wkD3tnNMvDpX/kYDMDj0XcHDa2KakGtOpJoZJvw=;
        b=kwNPrEMKhAsb1uaNE/+OBUfkZXfX0zJ7PQOXvvkn6z1SA9C+S13jbUjLkux5Wce+hJ
         h1qKJ2ORClY6hE4P1DG+tf+OzVJOm9ctMmUP05Dd1nyTtHZ05QohCBdcBCWOfV1DjN7d
         1rRw39rYpjecicfuRqNbAdmrDF9Wob2Q78oVczUbRmcs/vHWeajaG1+O29zUIv9Rp9RQ
         0A2/XKAyBVAjZNGKVOnJk/EpPTt0ti+l0v9qI+0HcvHraTwiF0ff0FO2FpcLUP3NeEpz
         Oq8FibN9hg/E2pOJhEyV9qNqxy22RbhOWArcGJMzzIFkQAf+oC7s8NSoPSNTFvLP0phO
         WT4g==
X-Forwarded-Encrypted: i=1; AJvYcCWu+Gr0fnEdFIuEob0uctMDEWenXilaJDq4+WVSt48nlKcxap4q6ZO9gB8l+hQL+ZmXGs98JOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMblJtGZHwElxzqaa2SbrXOot+DwgGeV30ivqeI9mDvyhhvAkw
	1I4WbnASbhJe6jMUk5AwGVsOyv9peLzVNQuNxI7MpzZaqjqhLtpQJdks
X-Gm-Gg: AZuq6aIOfmn7yT17NvRY/+jXRKkW8Aq0DdG9KaULhgMSppDInAs/358TfRwwMvGqXQY
	X957Px9L2MEd8+sbQmNGNSkJ93nAwvLZvJypnkQXtwF7MJyd0lPhF12Kuq5mA7ogCJvxd5Xrx++
	wkZB8agEp0HckKhOzNrbY+mk+y/k7QmDihm1bT8fz55SQYze7SsQCfZc+Ke7jfhXibEatHNsZh5
	VPA+KD58PxAzbRSd5qm1KS0m3w0pvxj9/N1OPGrHHpiE/rKt4WowemaUIMijFV3F3S9ElTdOb9J
	8uRwXZW3XnnLUqGY6dahUz+VB3qA1agjjhuQ5RYYMJSz5lGllFqgSLEfSkuxjok8nCyS40KyQnU
	JS4UVGD/hdzGtvZUP/6a2jsgxhwRZbj1lNPxiqYVO35cy0BGW8nbvEc6bmJVW2NI2QZW+40u8em
	7a2kE6dZ2vcEc=
X-Received: by 2002:a05:6a00:8d2:b0:81e:408e:47c9 with SMTP id d2e1a72fcca58-81f9f69002amr15459101b3a.11.1769017906237;
        Wed, 21 Jan 2026 09:51:46 -0800 (PST)
Received: from inspiron ([111.125.231.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-81fddd12fcasm7382081b3a.0.2026.01.21.09.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 09:51:45 -0800 (PST)
Date: Wed, 21 Jan 2026 23:21:36 +0530
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
Message-ID: <20260121175136.2ku57xskhwwg7syz@inspiron>
References: <20260108191523.303114-1-activprithvi@gmail.com>
 <2f88aa9b-b1c2-4b02-81e8-1c43b982db1b@acm.org>
 <20260119185049.mvcjjntdkmtdk4je@inspiron>
 <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac604919-1620-4fea-9401-869fd15f3533@acm.org>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210803-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: A8F5E5C509
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 05:48:16AM -0800, Bart Van Assche wrote:
> On 1/19/26 10:50 AM, Prithvi wrote:
> >   Possible unsafe locking scenario:
> > 
> >         CPU0
> >         ----
> >    lock(&p->frag_sem);
> >    lock(&p->frag_sem);
> The least intrusive way to suppress this type of lockdep complaints is
> by using lockdep_register_key() and lockdep_unregister_key().
> 
> Thanks,
> 
> Bart.

Hello Bart,

I tried using lockdep_register_key() and lockdep_unregister_key() for the
frag_sem lock, however it stil gives the possible recursive locking
warning. Here is the patch and the bug report from its test:

https://lore.kernel.org/all/6767d8ea.050a0220.226966.0021.GAE@google.com/T/#m3203ceddf3423b7116ba9225d182771608f93a6f

Would using down_read_nested() and subclasses be a better option here?

I also checked out some documentation regarding it and learnt that to use
the _nested() form, the hierarchy among the locks should be mapped
accurately; however, IIUC, there isn't any hierarchy between the locks in
this case, is this right?

Apologies if I am missing something obvious here, and thanks for your 
time and guidance.

Best Regards,
Prithvi

