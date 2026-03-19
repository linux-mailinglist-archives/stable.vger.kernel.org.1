Return-Path: <stable+bounces-227400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDgTGQqNvGnz0QIAu9opvQ
	(envelope-from <stable+bounces-227400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:55:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D3C2D4538
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 00:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 758CC301CC7A
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 23:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C994405AA3;
	Thu, 19 Mar 2026 23:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BCoeykvI"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D853FFAB9
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 23:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964535; cv=pass; b=AeiV7gTFuHzEEBrZdfEhbTJy0jY+4Y6PSvSXQf72A6FYsG5Upru9EGDh9J8sQ8MHKnC0Dr9WmvLGIJYDGo8X9cekdBRToxkESUZ9RkU/3+r7bp7TA5mHGCmfQqNVEEc5gx6JOdacCAjz8EYvn42zo3xG10jq808PTU5W9LSSyco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964535; c=relaxed/simple;
	bh=YqQWHG7sQVFE30nL5cwSU7IIyU4kUNqSrNwlZahbGjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r3pqTayxUd6eC3TzXN9BPV8pzqqDP7fl4mMWFvMnckUHq6mnsdNesXWU7DluwANTT7H3VqeHo7jd66n8P/FEiQMMNf88GDUh/X8fpZ7PvLBYqHiij4xInuQi1TzqQatm3S9OEA1OO/tr7Ec4waWKgCkGNnBMIkIk6dHxpBKnfvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BCoeykvI; arc=pass smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso12808425e9.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 16:55:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773964532; cv=none;
        d=google.com; s=arc-20240605;
        b=SFmIKtcn2gQSmtVHDNSKvDv1jtITzJ82lVFnrAqMiqhhZBHAj1EWZCH/ALn52xcrpb
         Xgx0+Ew+25993CI+ixiFZ43xmRn7aQCub+JaG0YAxqarc2vDp7C1EtByYOt36NbxZL1B
         wKte/ln1ainX+BX/W7qJQLfoKXTylwtSPhfXGVq33Cf1jn+YZPgXrQpPGc2q51fsZ5Ld
         VFDJJnQecxwzn1/qMZoO6ferNj3LR0I4TYgtEsiLiwPB61ZHErrbWX64g492EKZlFVTc
         HtqFjPdmCyKMX9X+AXBLH3LbhLQd/3SSVaBK2t0XW5YL/z6htH+qV1PjtWuJI2d3IbYM
         Zpbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        fh=T8+Dh75nJnu5HAXpp12s6+D8KCxcDr58SD5rST8A+zU=;
        b=BSe1qEHfhYhRzaDWPMRZrSucF5o7/dlPMK8ZAdLPK5xlHQOtNCwjgPXoX0tqK+xXI5
         hh4CNsTpUT2tdrJbVasPV32Wv8Gb5pBOAHlitG8yb0LADS15zILgrJ/8KC3ScxpuOuCc
         b/ORR8LZsAHwkOvN6l/xeYY5v+bV+G8VA2jgWws7mm1EsrXnXENpanfr1jIPZOuleyp/
         a/wTbt3g8zo4VUl3Hki1bYReRGuU1VyN5NAz0xJzlXXUPwiEdCmx8C+GuBgDpjDs21DZ
         FXe4GK0zYq8z6rULW8BnvATIhrv9Fa0latgadFeilICoUVXZOWpPBz2jsNJ517siM7j1
         SfMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773964532; x=1774569332; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        b=BCoeykvI88QnQL/8jSCcXfFTOwf2O/IBfmBjqBllJqKJdTX+YDgnHKjnoUEE1j3G7l
         tT8wt3kFWyGjs0GyS/wVMu4O6WIl8UF37kZNLRoPJBE4sAHM3lziHAt2w0I54Eon5jKj
         xl3HiD+HXmubN6/8F6XE5kZ2DTpK7UJrEkgR1f0Y0ckGSTvOX3maIkry6QZG10f4g1Hz
         8f6pvoRnIfViKcne0eBgrswOmCIVjgzVpCIJMQoslyUUvy/qidFk6E816I3vI42LOspv
         J46EGjZKYP/2c9t8/LSVeMzTJypoJ5li56QI0jJMqrQUI3znlB0Ri55bgnXiDF/IL4FG
         Bu3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773964532; x=1774569332;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/mhKg6xVvWfMaz63hQEXWdsh4Rp4Y+bSTphJUnzWMR0=;
        b=F4+l/zBLy10RaDuERxwn00AoFMckx2hLZ1Jq5covq7FEOzXVVI/LcUF5sQwD4U71cD
         tly5f6XRa9pcH3s+Q+aTLzMwleRU1E6jSxLlk/ecNT0lrDHQ3FUlJ//J9wdCQhm9qxcv
         Sud0twq4rOlFjgkw+5cS6ILo32mq/a0hCocVLaPykHuN0cRhgvNd8ZAdXDlrK/AOJKvV
         Nep4K5yzAyhyTe02FMx9HnSqH+QEIH0qAY0wr5QfWD3p4fivBw3A+HzNz2fFc7GMossI
         h06NEsko5/wqWYnuaEwNrV44QPMquAp8/d+3rfQ3QBC99Z/C4dsudXXiU6PbJGRMLLV2
         kGkg==
X-Forwarded-Encrypted: i=1; AJvYcCUUcXZRkpQ99W3qFTho3inB/iT8LNq0uDVyXgYpY/UMxpcIQgh8NHRl5i0FnX41O8Zxb0Y3uag=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIknijNFwHR/RIwFsDX7xPKjc9cLhVNkaoK2MWTBbFmlYOQfka
	5D1Rw7ur0eL78mi8B71+y1161thL+CN9t4HPDpdiie02gX61LPhrd1P83gUmA/oi4Ompu0JdBWw
	bOg7SLCNDXGWnTU9S/ggwH/bRG0KqyrBQnqLDH3s=
X-Gm-Gg: ATEYQzx1VhIVYKl2iaU2ViM1oDIDggjR40aUc7MV8xbN5H7B7tffSmjcquP5/VBIZM4
	cNnFPZ1c3Davs2WUvI5En+dLkaA129plVZaChN5tuGmdHF/hyqKDPYp54WyBOY8+dr6gSAHAqXV
	P2tVHjp1+8EsPtKmLk8WQi7pCAmYpPO322OoEo2il0lR6awOQtIqEDpo1zQaL+ObfVkIo7jWwA9
	kll73Yy394a9crcS9aMsDAfhpkckkeZUM4oIqWbQQtKvx9YwBjV/iyuyGXOILTJcI+nGR3083Sr
	XptVOQ==
X-Received: by 2002:a05:600c:3495:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-486fedf6b7amr17160365e9.8.1773964531889; Thu, 19 Mar 2026
 16:55:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319194540.3463371-1-joannelkoong@gmail.com>
 <20260319194540.3463371-2-joannelkoong@gmail.com> <1f1dafa7-54c7-4eae-a19e-5ec1be391079@kernel.org>
In-Reply-To: <1f1dafa7-54c7-4eae-a19e-5ec1be391079@kernel.org>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Thu, 19 Mar 2026 16:55:20 -0700
X-Gm-Features: AaiRm52BrVoXuXp1mgrMWHCIO62znYxeTnQ2oKGY6jvIBiTwB0i4w5xIYrFYXBI
Message-ID: <CAJnrk1atiw4v5OHsvE6uov3aWpQPerRW_eo6Rxg3Z6hPO2uC2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] writeback: don't block sync(2) for filesystems
 with no data integrity guarantees
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: brauner@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz, 
	miklos@szeredi.hu, therealgraysky@proton.me, linux-pm@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-227400-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.959];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1D3C2D4538
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:26=E2=80=AFPM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> On 3/19/26 20:45, Joanne Koong wrote:
> > Add a SB_I_NO_DATA_INTEGRITY superblock flag for filesystems that canno=
t
> > guarantee data persistence on sync (eg fuse). For superblocks with this
> > flag set, sync(2) kicks off writeback of dirty inodes but does not wait
> > for the flusher threads to complete the writeback.
> >
> > This replaces the per-inode AS_NO_DATA_INTEGRITY mapping flag added in
> > commit f9a49aa302a0 ("fs/writeback: skip AS_NO_DATA_INTEGRITY mappings
> > in wait_sb_inodes()"). The flag belongs at the superblock level because
> > data integrity is a filesystem-wide property, not a per-inode one.
> > Having this flag at the superblock level allows us to skip the logic in
> > sync_inodes_sb() entirely, rather than iterating every dirty inode in
> > wait_sb_inodes() only to skip each inode individually.
>
> Makes sense to me.
>
> [...]
>
> >       if (sb->s_user_ns !=3D &init_user_ns)
> >               sb->s_iflags |=3D SB_I_UNTRUSTED_MOUNTER;
> >       sb->s_flags &=3D ~(SB_NOSEC | SB_I_VERSION);
> > diff --git a/fs/sync.c b/fs/sync.c
> > index 942a60cfedfb..aedbf723830a 100644
> > --- a/fs/sync.c
> > +++ b/fs/sync.c
> > @@ -73,7 +73,12 @@ EXPORT_SYMBOL(sync_filesystem);
> >
> >  static void sync_inodes_one_sb(struct super_block *sb, void *arg)
> >  {
> > -     if (!sb_rdonly(sb))
> > +     if (sb_rdonly(sb))
> > +             return;
> > +
>
> Should we move some of the comment you deleting over here?

That's a good idea - I'll bring back the comment block that was
previously in wait_sb_inodes() and move it here

>
> > +     if (sb->s_iflags & SB_I_NO_DATA_INTEGRITY)
> > +             wakeup_flusher_threads_bdi(sb->s_bdi, WB_REASON_SYNC);
> > +     else
> >               sync_inodes_sb(sb);
> >  }
> I was wondering whether that handling should be moved to
> sync_inodes_sb(), so it would catch any (existing+future) callers.
>
> Alternatively, we could catch abuse by adding a warning to sync_inodes_sb=
.

Thinking about this some more, I think you're right.

At the vfs layer, the only other relevant callers are
generic_shutdown_super() when handling an unmount and syncfs for
syncing a specific fd. For these, I was thinking it'd be more useful
to return after writeback has actually completed, since the caller has
to directly invoke the operation on a specific fd/mount. But that's
wrong, we shouldn't be picking and choosing which syncs are ok vs not
ok to wait for. And I'm realizing now there's also the
hibernate/suspend call paths that call filesystems_freeze_callback()
which can also call into sync_filesystem() -> sync_inodes_sb()...

I'll make this change for v3.

Thanks,
Joanne

>
> --
> Cheers,
>
> David

