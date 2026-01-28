Return-Path: <stable+bounces-212645-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKmsFQJHemkp5AEAu9opvQ
	(envelope-from <stable+bounces-212645-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:27:30 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBE1A6E23
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 18:27:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 283C430F6E94
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E7833EAE7;
	Wed, 28 Jan 2026 17:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QCIYXqIX"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5F3330B01
	for <stable@vger.kernel.org>; Wed, 28 Jan 2026 17:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769620680; cv=none; b=S7r4PFBMTqstQqyuT/f6RSc1x8Uom1EtdwoseZCQkU/4w90PACsAORG5ZGtL9pqWGy5LK/rpDpycj5cMkz4FcDFI2SmsOUvxNaVMZiJmWCmWUGaAlb8MEGH40f9wtkk+x28X4o6BtJXSeDoxdri7S9xv+ypzJDnXEUPRtexORiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769620680; c=relaxed/simple;
	bh=BGqnVmp1eJvMacXoI673ldZKkJTfLCVUC3t8ZxfuCwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skY05bdls1rQ3O70zqjgXaEONtPkadtin1RDVzEzzxpmITjz2gIxQ3ZX+8f67MMjOvT/zVNToRQfblWmIUQQNqzvY39gSpmleMwFBkAsHNlN8duEeGf0WmAJvR6/dv3DcB2YYRoMy6pJYWPPB2mFgWiQikn8eWcLG2mbkhWXCwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QCIYXqIX; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-435903c4040so90612f8f.3
        for <stable@vger.kernel.org>; Wed, 28 Jan 2026 09:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769620677; x=1770225477; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6AJCBY/tn9iOXEaPRhRwwP52ntozIkhH10hpJi9Uxfw=;
        b=QCIYXqIX4S1leR4PqjDNaKfuzvj8PYyES41JLnLA4lgg/zA+XQ5FiEagKlSznLW15B
         4H1ymrd6jf8WGQxX0JYtJHEr5oHTtcyUVDcs9X45aLledpLSfNbWUzWI4v9ZPKaMHiIy
         aiTsi929c9RFpk5B49MB8MoTJvUOT8hpBMMHXXJx7iA634yJny8Jy0ET3sIu4VPkDhZ+
         o0LFAMpPh+XRs81FfCuDsKVonGrHoYNgOpK20PlKO3XZ6GEG1kk44zdNdNxB5pgnv+WT
         PgtGCTehQUDJ1fiqIOoQOAoVAUsBfK0rMZKVMYgCt69Vs6yQVwftVI+KqKGLKQAaVMyv
         GTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769620677; x=1770225477;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6AJCBY/tn9iOXEaPRhRwwP52ntozIkhH10hpJi9Uxfw=;
        b=glksflmTdNmcrjAbTqoC64WiVshterB6TuAawqNfLg35qc0fLVrCeruvpSWPjWT/16
         /dU0V82uwjFc7Hb02gbMfZaFh3sOE7RwYTLRH5Lb75ypF3y26TZUkbjb/ofVpt1tOj3P
         SyNXdSrE/o5tdXQaycGCZyw18cuXqhALllHaS5DFegfllqjQSmNNVR9jOHSqUPoe+i7h
         i5c5Z9ZGvQ8BCoNBWouEJSJtMxdAllvANs0oof+wuW9jDJZWwrysY6+/EjSVZtd3mLKe
         lS/cWgs0eTYdjEg3prB0+/NwQjACyhTRRtRFLILkRixKMhBmv4rWk9jCCZlLq80Jv5/8
         z6ow==
X-Forwarded-Encrypted: i=1; AJvYcCWl/55B1dQQyuTudAt1Q1hRK3dMdXYxt0zX/ymQSWrfgbTvKw74FSMNTNUUbUcc/O9jFmBD5Yc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHaUYX/ZWFpM39xj9tifeWMXQpRK3pwGQmVZm5FN/umnRe4oL7
	WVtLFiSlwM54p6IAHQvFBoKfEXT8zRB0vRHaBIkWX7/f/mPY363vw/FWVR35n2ymfkE=
X-Gm-Gg: AZuq6aKiPnk5FmBNIhmaj28WEZ15UeESdyCyP/5wA8PguMKYrRNgYLNkvdjjXhxIR+2
	VgWjntTV47yHlz4tFitt469R9x0DTToBVpvXko16K6vOi8I9aCBgKeQJT66uatqywGEprlcn3wf
	tj+bF1JgyN+6kOFrHsqOvucloGoylmfwr4UHPMTMsYzXYSd1W+zacUeY3IGNhCr00iPxqReaD2S
	z2kTZCp/L2E3NaYkLgTLKOib2NG9ZjXT1Dy174Cq/vOR8j8K00uQrJxkD7eyfrVlN6vOUskXFFD
	+1E2W8ej8pi9OJjwU7vriL6ZS7OxYCCBw99Gh9tpAEOaQsnOUxAdXu1lQHyxInSsM9/TAKyoD3e
	BvBbqC5d/FPL6i71TnJhGkcDvDJIT7S0RiIgjUx1ajAry34SoQgRe6fpRic71ze0bhDHIKoRhwU
	qYMb9PDJ76gzq2gsomswU=
X-Received: by 2002:a05:6000:178e:b0:430:fd60:940f with SMTP id ffacd0b85a97d-435dd04c33amr8035567f8f.14.1769620677507;
        Wed, 28 Jan 2026 09:17:57 -0800 (PST)
Received: from precision ([2804:7f0:6401:4338:fe12:6a4e:72af:4ca4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a16cf8f2sm3841611eec.7.2026.01.28.09.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 09:17:57 -0800 (PST)
Date: Wed, 28 Jan 2026 14:17:51 -0300
From: Henrique Carvalho <henrique.carvalho@suse.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: sfrench@samba.org, pc@manguebit.org, ronniesahlberg@gmail.com, 
	sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com, ematsumiya@suse.de, 
	linux-cifs@vger.kernel.org, stable@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH v2] smb: client: split cached_fid bitfields to avoid
 shared-byte RMW races
Message-ID: <pkihyoewqokamtfcawpoe7mpqqu4rf7zwtfnymd5dxxb75cg64@efxg7to7rzqk>
References: <20260127160128.243441-1-henrique.carvalho@suse.com>
 <CANT5p=q8trAvAMwVOczAuet2qFV_m0w9a9PJdJEtPhAsf5DGsQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANT5p=q8trAvAMwVOczAuet2qFV_m0w9a9PJdJEtPhAsf5DGsQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212645-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[samba.org,manguebit.org,gmail.com,microsoft.com,talpey.com,suse.de,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[henrique.carvalho@suse.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ABBE1A6E23
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 05:03:03PM +0530, Shyam Prasad N wrote:
> On Tue, Jan 27, 2026 at 9:39 PM Henrique Carvalho
> <henrique.carvalho@suse.com> wrote:
> >
> > is_open, has_lease and on_list are stored in the same bitfield byte in
> > struct cached_fid but are updated in different code paths that may run
> > concurrently. Bitfield assignments generate byte read–modify–write
> > operations (e.g. `orb $mask, addr` on x86_64), so updating one flag can
> > restore stale values of the others.
> >
> > A possible interleaving is:
> >     CPU1: load old byte (has_lease=1, on_list=1)
> >     CPU2: clear both flags (store 0)
> >     CPU1: RMW store (old | IS_OPEN) -> reintroduces cleared bits
> >
> > To avoid this class of races, convert these flags to separate bool
> > fields.
> >
> > Cc: stable@vger.kernel.org
> > Fixes: ebe98f1447bbc ("cifs: enable caching of directories for which a lease is held")
> > Signed-off-by: Henrique Carvalho <henrique.carvalho@suse.com>
> > Signed-off-by: Steve French <stfrench@microsoft.com>
> > ---
> > v1 -> v2: Add Fixes: and Cc: stable tags
> >
> >  fs/smb/client/cached_dir.h | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/fs/smb/client/cached_dir.h b/fs/smb/client/cached_dir.h
> > index 1e383db7c3374..5091bf45345e8 100644
> > --- a/fs/smb/client/cached_dir.h
> > +++ b/fs/smb/client/cached_dir.h
> > @@ -36,10 +36,10 @@ struct cached_fid {
> >         struct list_head entry;
> >         struct cached_fids *cfids;
> >         const char *path;
> > -       bool has_lease:1;
> > -       bool is_open:1;
> > -       bool on_list:1;
> > -       bool file_all_info_is_valid:1;
> > +       bool has_lease;
> > +       bool is_open;
> > +       bool on_list;
> > +       bool file_all_info_is_valid;
> >         unsigned long time; /* jiffies of when lease was taken */
> >         unsigned long last_access_time; /* jiffies of when last accessed */
> >         struct kref refcount;
> > --
> > 2.52.0
> >
> >
> 
> Does making them as separate bool fields ensure that compiler does not
> optimize them into bitfields anyway?

Fair question, I hadn't thought about it.

However, according to C11 standard, that is not allowed:

        2 Except for bit-fields, objects are composed of contiguous sequences of
        one or more bytes, the number, order, and encoding of which are either
        explicitly specified or implementation-defined. (6.2.6.1)

        15 Within a structure object, the non-bit-field members and the
        units in which bit-fields reside have addresses that increase in
        the order in which they are declared. [...]

> Ideally, we want to protect these fields with a mutex / spinlock,
> which doesn't leave us suspect to such issues.

So having them as separate bool fields should be enough.

-- 
Henrique
SUSE Labs

