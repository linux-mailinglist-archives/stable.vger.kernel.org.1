Return-Path: <stable+bounces-215857-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ISJOsqXjGnhrQAAu9opvQ
	(envelope-from <stable+bounces-215857-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:52:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6076B12556F
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CA5C23004DA4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F0727602C;
	Wed, 11 Feb 2026 14:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCpt7LPp"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEBD1158535
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770821572; cv=pass; b=X8K8dYPNJhlyLkvZac4dmMKWHKbDPvdVja2lKgUeS1Tdp9AGAwPf22PS669XOdbapcvmzG6NsnxKjBFW+ZsuZyXHx1VYNa0pyTnGkoSLPleSO1DWwgbDq/m8x65/nIR4PbaWAV/8AqK+Rc3L4aK9xiWPlxoUYg5wnwHbl6tT9ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770821572; c=relaxed/simple;
	bh=QUjQkJUWi024k1J7TmBam8PKt8oHP4ipS1phvf+eqjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nE8FBHYepSJhJGIebUDsRCEeiIqOkX51b6jcl6/GspT8C9OwAHqzTP/e6d3TwIq5jvi+RQ4Frajvy/ioqokDD4O5zIY77UxqP6QCHm8W7qpEm5+ZaQSj5/7vdRHIHhAv7rWC17YH5BWoOUKoscxeRdHk/mcEHVmfOuoxXIqoAtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCpt7LPp; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1249b9f5703so7216304c88.0
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 06:52:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770821570; cv=none;
        d=google.com; s=arc-20240605;
        b=LS0rlGEi6jSrbZHe3B1hbU7o90jYyYTC68bacJCyiVEDOzdw+oWxRNmeBZpAb58RiQ
         sw2SnMy37nqgdis4RTb/PH+mSxwlKIvfIdtZqgJ5rU47dTxnuSUv9zYT7IbNIsiBhbRe
         8ZLq2lM3bbXB0+82KA26Y5t4v42kwEraPP+OqA9+u2yHGU3pF63T34WGfEXvYu1lpGXa
         JtQupU19E8eL31eb3YEM8w+ZpYMKA+NJUWn59ne6etgfw4zJFgbDhBWq5XsrdPgVkpiO
         kFdN6RXvjp2zp/j1wbpb528gFlXGL5kxv9u6E/Xnfw3J5BViyre9HSV2QArvJejdtp50
         wPJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dS9JYFVceYu7Eyr24Du7RLvPPjHmThdSPq2If02YLxI=;
        fh=KbTxDwgg4hyUGfP18FoVEZxlahJ3g5J7V30IumT8jSI=;
        b=jQtJK3QXnTcKb9FidMeTITaw3MqW8Olv3AFNf1NFpzwFdESAEdkreoxuPwFu0Ytlse
         jUvCLKlXW5XUo2uXqK00DFhTpoP/FPBIOpXtW+QrdbMiE48u3Ek9dVGQPJte9AhheGsw
         xqcXXthfq9AkToWVqIAs1ODod8czN+JElypwYRGOsgBv6BnLbKHxIRH81VQ8GPOh5I3p
         kLJTqFMPHlEKUqskf1jEzRpeKT2YntXAy/MX6+eyXI+giUg8xp43TLK7++ESLRoQcPkv
         rflu67CxjDPsUVqnfDUtE8vWDFbTxogRdlCJ9HfYFSLIi/MjCiMTA1Jb/vSuhNfUgEWi
         PwBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770821570; x=1771426370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dS9JYFVceYu7Eyr24Du7RLvPPjHmThdSPq2If02YLxI=;
        b=cCpt7LPpQ+Nry0x8cUHUSkOlOwVpfPEWWjg+zAawf+lfhzzfVkmDMZ7VHdMMwgIRYw
         x3lnxXa07Yzy90/ZKa0HOOYa2usN/N4AoGcvUok6rprlAzGdU2Vn/UJ5lQOryFnaM+Gy
         xqmQJL0jKHtXZrdKECGcIBw/xW/OfRLTbbPx7/L0T2XrbqYJ0/A3rnHdVdhV06LNLHii
         L83u/RN8oTAH+Kv0IfN1er33Q/0Hqk5t4o/YU5kpcAkgu7pKBBQCh8cxthIsoEmGJLXk
         j3qUw32r40gc4DvEsxvaVzF7QLV2SrCV8OnILKklPWvEwwhXNeQiPEz2ECLXNxQMAu+h
         mmLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770821570; x=1771426370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dS9JYFVceYu7Eyr24Du7RLvPPjHmThdSPq2If02YLxI=;
        b=u9Q6wIXem5qSYL3jF/E5Bbqxb9LsZ+lWzprPISLgWsoMjrbZrnp9hdxSh5aRHyc3XZ
         TJfPhKEPsx607iaTF2RjjkYQbAZwbmIgZNIaePgG0HM9SQ/t5Zxpozr0CWIqPZrcpwFH
         8TZvbgVx5vQTkD+XE34rhgV1XNCKCMsccJxfYdSGrzvjwgVM/9Rb+1mZQfpZY0qJvAvC
         fch7KtheP+emDATK+vy0AzoeGbk03n7xM01VQ2tlJDn7DFIMVtAQ2HAW6kKpMtodkboe
         xYwjvVsRXTr1IHc9shCs3Wlaay1q4fN9GmwDnIVianxCzMhdI4K44QgSnGGqvY8Y3qrh
         cF+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWBinDsM15+RyVlG8XVR8S1Y4l8jAv8MBwkru9XGr4A3808MFxNku7EgBeX99UOTkNUQMj6IWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZfLGzMfaWEb6PQqAigCUMof7cLrmBmbYo4wPXaNEH3UMZBURe
	xxRyMfkuUfr/RWMey47MkyJQHtCtjokFkbgWgVgw9bbb1/wYFpNTTDKILesns+kobLxDEewgsYO
	zbG9UcUARI2U+jJQ59s0HxVDWzaZXLow=
X-Gm-Gg: AZuq6aIGfKZXWFyF/V8T7O5WilKOh0tsOjfBU2g8aNfbhXUmgGmaN/LAIGg4BJp2M9L
	8Jy94PJxAT+KxkyWk3hfdirYPHuT0S4ZujMBpSFyVXambksjMgzRorn2mkqi4aKDPmIuOOaTier
	Im/F40uzYXZPOjjAHm+Oa8gkjPhgNVtC/CMtUQ+OPYIntxm60esCmhbkclieGNk4gycl9M2L9AR
	d11m7G3lWcTq8RK9FldGSNlzF1y4q5Ji8RAIMFB0YWNi7nMDB9SK0AnPi87KRGYEhZgS6eyv9CN
	E+FvUCs=
X-Received: by 2002:a05:7022:2524:b0:11b:9386:8267 with SMTP id
 a92af1059eb24-127299a1ac7mr910474c88.44.1770821569744; Wed, 11 Feb 2026
 06:52:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126022715.404984-1-CFSworks@gmail.com> <20260126022715.404984-2-CFSworks@gmail.com>
 <CAOi1vP_2asCJyLOZH0GP=u8gRLU6jqnS-hC-R7ayjPOkk0zc0g@mail.gmail.com>
In-Reply-To: <CAOi1vP_2asCJyLOZH0GP=u8gRLU6jqnS-hC-R7ayjPOkk0zc0g@mail.gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 15:52:36 +0100
X-Gm-Features: AZwV_QiotgS2yAouwVnoHKIigFAQ_INSP408FySRNaJw97uNnRox7TAAplSuGWE
Message-ID: <CAOi1vP-_Kr5MM=0pM0+1aRQAAzoVsrQazp9uCsjpF9OVfW9S1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Christian Brauner <brauner@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215857-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6076B12556F
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 3:10=E2=80=AFPM Ilya Dryomov <idryomov@gmail.com> w=
rote:
>
> On Mon, Jan 26, 2026 at 3:27=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> =
wrote:
> >
> > If `locked_pages` is zero, the page array must not be allocated:
> > ceph_process_folio_batch() uses `locked_pages` to decide when to
> > allocate `pages`, and redundant allocations trigger
> > ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> > writeback stall) or even a kernel panic. Consequently, the main loop in
> > ceph_writepages_start() assumes that the lifetime of `pages` is confine=
d
> > to a single iteration.
> >
> > The ceph_submit_write() function claims ownership of the page array on
> > success (it is later freed when the write concludes). But failures only
> > redirty/unlock the pages and fail to free the array, making the failure
> > case in ceph_submit_write() fatal.
> >
> > Free the page array (and reset locked_pages) in ceph_submit_write()'s
> > error-handling 'if' block so that the caller's invariant (that the arra=
y
> > does not remain in ceph_wbc) is maintained unconditionally, making
> > failures in ceph_submit_write() recoverable as originally intended.
> >
> > Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> > ---
> >  fs/ceph/addr.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > index 63b75d214210..c3e0b5b429ea 100644
> > --- a/fs/ceph/addr.c
> > +++ b/fs/ceph/addr.c
> > @@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mapp=
ing,
> >                         unlock_page(page);
> >                 }
> >
> > +               if (ceph_wbc->from_pool) {
> > +                       mempool_free(ceph_wbc->pages, ceph_wb_pagevec_p=
ool);
> > +                       ceph_wbc->from_pool =3D false;
> > +               } else
> > +                       kfree(ceph_wbc->pages);
> > +               ceph_wbc->pages =3D NULL;
> > +               ceph_wbc->locked_pages =3D 0;
>
> Hi Sam,
>
> While I don't see anything wrong with the patch per se, I can't help
> but question the existence of this entire branch along with the meaning
> of the error.
>
> ceph_writepages_start() is the only caller of ceph_submit_write() and
> it already calls ceph_inc_osd_stopping_blocker() at the top where the
> error can be handled naturally -- nothing needs to be unlocked or freed
> at that point.  Since mdsc->stopping_blockers is just a counter, all
> calls made by ceph_submit_write() invocations in a loop would be
> "contained" within that ceph_writepages_start() call.  The only benefit
> achieved is potentially faster response to the MDS client moving to
> CEPH_MDSC_STOPPING_FLUSHING state, but it's rather dubious because
> sneaking in/having to wait for some more OSD requests isn't really the
> end of the world.
>
> Rather than patching the error path, I wonder if instead of calling
> ceph_inc_osd_stopping_blocker() the counter could just be incremented
> unconditionally, with the check for CEPH_MDSC_STOPPING_FLUSHING bypassed
> there?  This could be wrapped into a new helper that could also assert
> that the counter is already elevated before the increment.

Something along the lines of

void __ceph_inc_osd_stopping_blocker(struct ceph_mds_client *mdsc)
{
        BUG_ON(!atomic_inc_not_zero(&mdsc->stopping_blockers));
}

and switching to __ceph_inc_osd_stopping_blocker() in place of
ceph_inc_osd_stopping_blocker() in ceph_submit_write().

Thanks,

                Ilya

