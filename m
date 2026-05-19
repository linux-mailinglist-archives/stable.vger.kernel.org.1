Return-Path: <stable+bounces-249604-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL2wD9pyDGqihwUAu9opvQ
	(envelope-from <stable+bounces-249604-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:25:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 409D35807DD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C79833035974
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB46B4028D4;
	Tue, 19 May 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V+7INmm2"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FA061D5170
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199945; cv=pass; b=CCZqywuKHCOvRniMCMCTNXdj6G90uOy0zkAFgfTPTKD8bhuCN/vMWTyUO5e4X4H8/UUaocquL3YjvZDy49ZdwR2eUGWKuoN8TFsI4mVV0rWx3tz61ZhhOyDUHOyLgAAPolOjD1yWCWgU4fS3Nl7KfFaAhXcTEIWQuchlgh4hees=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199945; c=relaxed/simple;
	bh=whO7YAb0sWqd5LNBElkzPg3UvW0e8KJGAEQaNkj809A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BQLWs2aKO/fEiB4G3QdgP1sgXWZzPz6Mk9jPbmxnJmSZQ3Hprv7kUpabAFE6fbzobWuT4dvII6fz8flzvjZkXp+YwbKYLnzkbb0VHjZiqFqANPqW/kHruwjxqCURqidRF3fkZRtRX9dLOlvzhaKByJD1jHeFP2MNzVRx5sLoUZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V+7INmm2; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-67c1eea6b4dso273a12.1
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:12:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779199943; cv=none;
        d=google.com; s=arc-20240605;
        b=GZoHcgQR0CvepANgZjRxlHL1YMxScl80amoYXuWsRJ8VSRTJ6wLKskprWklPR1i4Zu
         eSY9kCGAfg5mtkm7U8Mh7SdPdgLKfyuFTd0sWiMDI0VisKCxHGs5SNWVTXaYwb9iFzTV
         9Sl3U7u3F0DiDKId9Y+ToWa+6khjjDd6o2Mey7zOQnFrg6MjgdoMO1VXQYnxU4gTrGxa
         BguPRsVgc60p63VijVa1yQYYtWHT7wwP9cJdmXzREgZU5OPXJyn6iEOQtEfsDgcb3uyw
         lRVia68JfA5pug8R5I+D3ANI5BwgtfqrKD2KxF8rQzxf7gRtboTANUGnmTpSSoQgBog/
         2tRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TFvbTxe5R6vdG6Zb7KmpleI10nj39uD6U/cRpjncsMA=;
        fh=g/VUTZqQ8ELPROTiz8s7p3sgUpXJwUDcokp8vxfO3/U=;
        b=OMGptSeADDrA8R+sKVFTWzCY3hUfAeuXiVe0YCMRQyIphORu3ZAx+f0GNMOfZ/A+Ck
         6x1G/bY/t+Kqni8D+gB72OiuT1FS2sqyQyn/CHLkdgNLc6yYEAfSarrAJYvSRVXZkVDq
         lHPuzRntNzTr3hUSySxjQsYaWiET3BCZhwIq1LM41Yji+0bQ+9BKGcdmGNlTosUNewD6
         62fz9Rl6svCb6diqeOyWsBfS7nOhLH5ChYufczyoMTgm87kPKU0D17OweIgRxZtLL8Rk
         Ho1xtvA+vlJyYKv44lH31Qz65ftVMo5kyKw55BS2b7N1R4rL1X4xgi0ozqMkausvdqvf
         GcPA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199943; x=1779804743; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFvbTxe5R6vdG6Zb7KmpleI10nj39uD6U/cRpjncsMA=;
        b=V+7INmm2JEClJfN2MwEtNRWWNbaJ4FlHRyBoUwL322w11KUeAcOwePUHT/98Qh6olF
         uFMYrdDvOe6EEkgTi01nA5O+vdlbjBhiuQFw9y1u7OHMr+atlr7bIdWukIhM0ZePv+D8
         +JmrlzDZhwcZcxlySO7724hdGvBr73vFNa2WEqO/RbyB+cGfiHGE498yn/3F2lxfHJjx
         VxFV93cMgG9vW+dHaF7LTFcDv/pzdEVOxk52nmgAtqyYJKlsIMOZLBuR90mNCJVSdojt
         yM9svAcTj1Q21SNy1q+v0QR1iHM+yOE4He+UY0RnejLcRuF9P+1dVn7ntMpIFWW/sfpx
         DVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199943; x=1779804743;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TFvbTxe5R6vdG6Zb7KmpleI10nj39uD6U/cRpjncsMA=;
        b=i6XWwmcTFLcnirmP9AQXI4jtPJM6uV3iCMtzZXjCOYJe10qZ0EIHQxsGsEEAdZdCRx
         0KnC1Ghvl0OzUXUcj890kBOE2f4KhKiB5PObm3DNs9KY5agzAeOm7TImNIVfLYRzwY01
         B/4qQv9dol0WXh2mF0NwhDs0tA39QvOu5OAmXIoCwFVIQyAUoLL6TLgSbrMqn+x3NdYV
         WZZnJRc8TFFJIjJaLjjNIVZy2I7zNPLEbho3HGiXuOxUAiPBAluFXw81qnChy14xKoaE
         K/ElicMyj4Y+kP3wrVg2KX1ASmbSHRxSTZCAWBNAEnbLKjDaNOjOI9e3/2cSnk0HiobV
         Gglg==
X-Forwarded-Encrypted: i=1; AFNElJ+7bFI+DT8EZzkmFpAns+0rKWP3CuGHXS2A/HHJlv+k2UhaMLaLNV1L+4W4ctjJrvpnOva7280=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTqeIWC+0xUxIPe89NvEyyVjhbu6Xwmbnej7ViMPt7Z33x/AuC
	4EHimu5dYeWpogdg9cM/gUnXwprbgUMi+1EzLn8MMFRsJrQKG8iBjogpaSncBW7/asOuj7GhfMD
	uiTwBYvpEnlX/VuvZm2T2ilNbGYFhIsqFvufRH2Bv
X-Gm-Gg: Acq92OHOY5hAD6dwf/9P0mz9rVzanrBIoWsIKDWv9Xt5szZbB97GwY4QwOHeazOprD1
	Hq6Q1Vv6zbnEKeB5UZLcYGXd6sH1vVaeenSNIqkS5U9A+nt5OWD9xs75IoqiquR9bgu7/zcQLtr
	wT9giVi/3yrnTnz3yW4cJ7Y9fvCtysg+07h8z3NslkCKCECH33czYvprtHEbNyDawvFB9hgcpoB
	wTOpSX7V/h/qSmHt101BhOZK2cxMPLLMn3SKg/qYcIH/X7GLFKm5u1xFf11l5ZU26iYgq8k7hJC
	bD7ovmpBFjEsNK9vslo953AvvYagimWGZW/PJvE0DmdCJOjN
X-Received: by 2002:aa7:db55:0:b0:67b:6dc6:3a5 with SMTP id
 4fb4d7f45d1cf-684986effeemr78445a12.9.1779199942226; Tue, 19 May 2026
 07:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com> <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com>
In-Reply-To: <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 19 May 2026 16:11:46 +0200
X-Gm-Features: AVHnY4IC0Nb8ZGebLrWGuDuCoZnifzO_29zTNKSpR2gX_4smRdDNEvnUWhpnr1M
Message-ID: <CAG48ez2gP5nfASBgZe_QiFcAQfnHd2D68gDiofOjxuGix2jajQ@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249604-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[szeredi.hu:email,mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+]
X-Rspamd-Queue-Id: 409D35807DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 4:07=E2=80=AFPM Miklos Szeredi <miklos@szeredi.hu> =
wrote:
> On Tue, 19 May 2026 at 16:00, Jann Horn <jannh@google.com> wrote:
> > The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> > FUSE daemon to actively write/read pagecache contents.
> >
> > For directories with FOPEN_CACHE_DIR, the pagecache is used as
> > kernel-internal cache storage, and userspace is not supposed to have
> > direct access to this cache - in particular, fuse_parse_cache() will hi=
t
> > WARN_ON() if the cache contains bogus data.
> >
> > Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on directories with
> > -EINVAL.
>
> Good catch.
>
> Shouldn't this reject !S_ISREG()?  Symlinks also use the page cache
> and could break if overwritten by arbitrary data.

Should it be `!(S_ISREG() || S_ISBLK())` ?
I think block devices are supposed to act roughly like regular files
in terms of pagecache, but IDK how that works in the context of FUSE.
Let me know which way you prefer and I'll send a v2.

