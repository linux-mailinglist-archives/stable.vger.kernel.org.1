Return-Path: <stable+bounces-225380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEEBOxZxtGm2oAAAu9opvQ
	(envelope-from <stable+bounces-225380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:18:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 674CA289A83
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 21:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34EF3303F448
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 20:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C013612F6;
	Fri, 13 Mar 2026 20:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BuQCbkPX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E01363C52
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 20:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773433037; cv=none; b=sdzf3Xdy5zlUGTbET65kFJrXER9iAHDqMbtvK3BevSfeJfv1iUz5dlw6ROnp0T1aELado8rcsOooOvjSoeUXrb2F8OtjD8LXQ81M8Y85iP33lHbKDBs8/DspJwWhK5qEg+XSMonT9qfOqm2uA5rKNhi0ajZAw/dn7RUFgUQnPa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773433037; c=relaxed/simple;
	bh=vbARsqc+d3uVyBmdOg0cXIP4bmMldMpQ98Q8O6fpLMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jha6KC2dzhjBb1LybgUBFG6JZzaDm7GEHm7uJo85KI9DwK+bbkfHbkphcB78uIm2vYnc5KHYf2JofR/C/YZDezKxo11miyJLDxgkv03qaeI621fR0W6O0upPr93CSRFX0jYE0lJfmdU6Vz9RTVD8BBzoxs0t9q4nzOXokla1V4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BuQCbkPX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4852c9b4158so22066155e9.0
        for <stable@vger.kernel.org>; Fri, 13 Mar 2026 13:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773433033; x=1774037833; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q9gHGobWfNUu+5lsnewMjx+gKUC6WWoehDbrgRIwq2c=;
        b=BuQCbkPXqi9AzsFTO9JdLA3zr6GF2X8rFkV07zXk9hQhqzQhd/2GSue+1MWWH4pTTx
         MKYTqZs3ZONYNX5B5nSWsgORb8vtYZv76P/FbXzNbDpnol9Qg3U4GmpV6iwtP9Tb4KnS
         C3eFPUBBasSru0/G/SnFv84MVW3K1H1atI0JX5nhJHv/F1FcFw5bL1OTBWifWrPS6Ert
         Y5E9KNKLr+cBBgdTbIl/gjkL1VqEAaXi6M1ztzkAk3dkB0HXcSwekuy5so9LwZ29LY4M
         RWfDWOw8lQKAo57axq5Uk9fXvUBQ5hdUXgY1PsX9L7l8fDdbT+UZZi05WwtZfZZ4hFyG
         NHPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773433033; x=1774037833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9gHGobWfNUu+5lsnewMjx+gKUC6WWoehDbrgRIwq2c=;
        b=F/MML0/82T5phXnr2ymq330jcAeHCo2Qcnd8PissDKvgcZE2FqKBs88KR6uponCWET
         BSZ9wT4QT8SSHuJzZzRYdi9jdF888w7/LhStFpIUqXGMfDS+LZ0xhTVEhvHNnFPT3W/R
         /l2S3q9Vqsw3LduBlndXYBKBPPbYkHH/zb5bnYKZc2kGe55aHQelyBGvLwXiuIqfX+Fm
         Cvn22yOP2EgcpJO4Ls9Uj1NsCxNY7FClzMf+xyzsVYzxg5a56GWBca4XdBr+pTNob/+G
         4JK2IkobLY2uWZFb/WxcGDXF5MUfh+rimRQx/50D1dI/giuWUoIMdJb8zy/+II3pLqwh
         zV8w==
X-Forwarded-Encrypted: i=1; AJvYcCWjvliJ3ecn0HbZ1a/f9tWdGBZrgYw7NWNEEIDFmNrQw7tKy/p8ZStHnRRMh3A1MxHHtcr+rJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkV/SLtqy4XNXGsHWlNQq+QE1QBHV12JaSNUGZcVpIbFUOVAfT
	iyuOwuffKpPU15G67vCJoBTe6uIkJp9A/mTfjSuuDPJ8uqN3ToOwAzXWENdz2evVI/Q=
X-Gm-Gg: ATEYQzwC7SFV5nMNuDmx0GbcQayyUbkoT6fDwA6ylYZrLj0HGzQgrA6HGFqMiUkk7Tm
	3kHUipA1wxQr7om5zYX2Q2danr8joXbKBA6hKKZ+FfAAdtDKxlZmKzhuHXACssyJR6Qb62YZw1/
	7hKk5JIUrczri8kz+eir04eMNBa/fFzLKrRINOFbtAotzsYn3vn3jr+6UAE9/OJWKjMDBgq1ZHt
	/rttOLWPcimeMm5x1Oq7nrG3eqbfACdPAS7nx+Fs8OkdLK/2KKuXzWE+AWz7OGwwnunWdGwuq8Z
	Q4nU5ncVGOnQ+cPVjRRzk5LrPVzNHf4Xy2ZZKbTktC4pp4B0GO2UOsrpRRdGZqgUtapUyT2BYIb
	Wj1TeXxg9soR3SDzSkHyQoKo23oYri+QM8JGfPD0HtUFGLcsF6Mf7JM+H8EV3om9m9AQHN2szBO
	aLs+vOHFj+mtnobxXnuldEJBCU1w57mWgcuYnT/QxsD6olZLLcILzJSrxSWOQJcH/jMg==
X-Received: by 2002:a05:600c:354b:b0:483:2c98:4368 with SMTP id 5b1f17b1804b1-48556703401mr76665615e9.18.1773433032551;
        Fri, 13 Mar 2026 13:17:12 -0700 (PDT)
Received: from precision.tail0b5424.ts.net ([2804:7f0:6402:b103:6a0a:3e1c:778a:5cc7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a1117sm4787248eec.3.2026.03.13.13.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:17:11 -0700 (PDT)
Date: Fri, 13 Mar 2026 17:17:06 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.com, 
	bharathsm@microsoft.com, dhowells@redhat.com, Shyam Prasad N <sprasad@microsoft.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH] cifs: open files should not hold ref on superblock
Message-ID: <54dzktjc3vwt55dfj6wi4346la2my4fsg7wfyrtwm2apzvppip@xbi6evlur3kz>
References: <20260304124629.1616108-1-sprasad@microsoft.com>
 <u4s57pxvrttksfxe5evylucarfoyiv3ut32d45nvfafsgmxtog@72x2iew66wrt>
 <CANT5p=rdme19zW8Dk7WuEXw68Jzdt2QsdfK-gRManJJgGWQByw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANT5p=rdme19zW8Dk7WuEXw68Jzdt2QsdfK-gRManJJgGWQByw@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225380-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.com,microsoft.com,redhat.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,suse.com:dkim,suse.com:email]
X-Rspamd-Queue-Id: 674CA289A83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 10:57:42AM +0530, Shyam Prasad N wrote:
> On Fri, Mar 13, 2026 at 1:28 AM Henrique Carvalho
> <henrique.carvalho@suse.com> wrote:
> >
> > On Wed, Mar 04, 2026 at 06:15:53PM +0530, nspmangalore@gmail.com wrote:
> > > From: Shyam Prasad N <sprasad@microsoft.com>
> > >
> > > Today whenever we deal with a file, in addition to holding
> > > a reference on the dentry, we also get a reference on the
> > > superblock. This happens in two cases:
> > > 1. when a new cinode is allocated
> > > 2. when an oplock break is being processed
> > >
> > > The reasoning for holding the superblock ref was to make sure
> > > that when umount happens, if there are users of inodes and
> > > dentries, it does not try to clean them up and wait for the
> > > last ref to superblock to be dropped by last of such users.
> > >
> > > But the side effect of doing that is that umount silently drops
> > > a ref on the superblock and we could have deferred closes and
> > > lease breaks still holding these refs.
> > >
> > > Ideally, we should ensure that all of these users of inodes and
> > > dentries are cleaned up at the time of umount, which is what this
> > > code is doing.
> > >
> > > This code change allows these code paths to use a ref on the
> > > dentry (and hence the inode). That way, umount is
> > > ensured to clean up SMB client resources when it's the last
> > > ref on the superblock (For ex: when same objects are shared).
> > >
> > > The code change also moves the call to close all the files in
> > > deferred close list to the umount code path. It also waits for
> > > oplock_break workers to be flushed before calling
> > > kill_anon_super (which eventually frees up those objects).
> > >
> > > Fixes: 24261fc23db9 ("cifs: delay super block destruction until all cifsFileInfo objects are gone")
> > > Fixes: 705c79101ccf ("smb: client: fix use-after-free in cifs_oplock_break")
> > > Cc: <stable@vger.kernel.org>
> > > Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> > > ---
> >
> > Hi Shyam,
> >
> > So the side effect of the previous code is that the umount hangs until
> > all the files are closed?
> 
> Hi Henrique
> Umount works. All it does is decrement refcount on sb.
> When the last file is closed (or when the last cifs_oplock_break
> processing completes) that's when cifs_kill_sb would get called.
> Before that if there's another mount of the same share, it will reuse
> the same session, tcon and open handles. As a result, an attempt to
> delete files on the mount point may fail (which is one of first things
> done by many xfstests).
>

Thank you for the explanation.

I will wait for your v2.

