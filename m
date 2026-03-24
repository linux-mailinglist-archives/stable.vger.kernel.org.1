Return-Path: <stable+bounces-230048-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +AMJChj+wWnqYgQAu9opvQ
	(envelope-from <stable+bounces-230048-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 03:59:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D700301656
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 03:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 178C63030127
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 02:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2EF388E61;
	Tue, 24 Mar 2026 02:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lTeLrk/J"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6939388E4D
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 02:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320982; cv=pass; b=aMvtVrolbtfCocm5sxt38BV96i8wA/pcUN7pniszsoHjrkesgQpBTNbIuwpEQXI3y21KpyEvy2alsMri94HwzVYog9BoGurH0OgdlrMnLU93HqQQ9k5/mXmW4Nzw7u1R+2nQIbUIHoFZR1x1+W3yN5L96KaeMzyM278utpycfCU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320982; c=relaxed/simple;
	bh=o/skd7D95WNSbrYtC4xn5gfzVqcvn+A4lGocklhRyt4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U7Vskb0VEEs5QIalPD4+aLw1YtgOpXfWXuwF00Lqsv/2i3j43igLCChIQ7TfqJYzZHksgjF7Jit0ofxuOV5BIf19EgHdPC0cvqBkyk+hRuS1iXWdD+0PSKmNrRe7OW2iX3/JEeGKXNH8PCC6yy/j1CIGhh/Jmt6heeuGWwZUMFk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lTeLrk/J; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b8f97c626aaso772395066b.2
        for <stable@vger.kernel.org>; Mon, 23 Mar 2026 19:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774320979; cv=none;
        d=google.com; s=arc-20240605;
        b=QbQDpydPduj0Gqh8TJVcHUofxAGON0ys4PIIM8AFTZUby5kSC0iMMjkjHnNm6Cf5KK
         rME4VcyVTKurXqIh0hMWN2J13Qb7OByBuPvIwU0rOo0DM0DFQZPrWneUWdtyLKtYLsiK
         WzXZX/rEMvGDMfZ/L0cag8Ciw3I8+Ve+ehzxEuZPuSN22/j6G27ggF08aZLp7baGbx6G
         7U3b0IFiqvGWuBX0uQ7+bh2Gk5hHYngQN0sM93p3MMcuOEVqWK1mza3frPrVbLeq2DuN
         0PXdqnmKmDxencYlBhMkHDtpC7QMwXkBSf+Ht+z53ueB5EYySmFSt9bX330/tFa3VieF
         5bZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m1Fy558thMEchxvffNmHIHu+yPWwhkymd/ZNOHH1urs=;
        fh=j2ltgUaWbyWmpqu/YwH5tRH4kP0FO3Sq6BapDvAnIa4=;
        b=P1tbJiYYIOZ+3TqGf2ePwVpJ9tNaEIUIwpJqfaBFGewOAFARUavc4tfWp773Zm2mrg
         DHA2ejGZG6+yXOfspP809C7JQaE4Bmx4SjjjQR7CHRDBygxfvLWbMQlg2MXzdK3Iqglv
         g//nnX56j4vwJ/pCFdpQsrb6RjKVoT4NSElbIwLle8Wzb+9kyLFt9trJAYZFvhV6cB0O
         muffD1PTFpKf7/dZQ5KlVMxIKyL+npA6EfAuywkKZha66TkwAZ0imKkgiFb0LWtFFDXJ
         ZQC0o5W7qQdm6yAgErk/qbpPsTGszFlIjvzy5/idAT+oP/oxpe722pVH0MJJRd0P0FUv
         mGJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774320979; x=1774925779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1Fy558thMEchxvffNmHIHu+yPWwhkymd/ZNOHH1urs=;
        b=lTeLrk/JTbzuZo2PCc58APDztdI4i8KsUz9ivIihFuU7W9OClOiGZ2JdITxbki5PIU
         Rl74zF4H40GzTX1U2dX+8s8fwq5A1wBBxnwOOb6hKwhtytHgJMUV3SQ5kNPVgdwK5vSN
         XThzSOe0qQBSHGMyhHTEmwcuuzxQdZ7bmMP3ic77/X4PAOBupR2P7p9LS4tvOS1qJwsc
         n3gQS5k2o0i+vSwn+bauoQjuRSss5XHJH3rPblMN5tKTl5O7Yv/QBs/geuBC+jKf/4gY
         OunB/etT//9XEZcSKEb7t8xU1Pv9q7Qu725iq6Zz6WUbpUNmq9Gq3zldghlLb6Utwrgm
         VbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774320979; x=1774925779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m1Fy558thMEchxvffNmHIHu+yPWwhkymd/ZNOHH1urs=;
        b=R9ir0UWdEkr5hLoQp8j2XZX5uv3wL6f5a+nYYAQ9RinoRsB3T0vBFBgZm8bFYCUL53
         X9s+85/gtnHLeX/o01mKUSfdw895+1bpbaJ7eI1S6ynItr6WDNjZ5vkC22MaR+xBBuYq
         OJWou4DnE7MT44J38ByFCAlWAJLWg46Nvd4qEQR6xCnCAOL4JuZaT1CQRFKrEHS1Wqq0
         bME00kEmuqJwonbQCd1sOOQJ6KPEBuoxU3oZ3az6DkoGNPSGJMB5YfXBHP6h2msWyhsx
         OtqwdU32bNPGAAHAXk5et7KQO0cIJYfRE+UUE8VJh8TbxofaP7P1UBj9pw/Iy2GySgbE
         TWvA==
X-Forwarded-Encrypted: i=1; AJvYcCUpqA5TpDEb0dvnLgXnynxY1iFaDqv1MeuJ4mX7EEBn7+FjMXsIe0ee/c0309Yw459yufsrUsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJbMiH7mP5Mz3PFCZDkOskeqgQBJwmcjYQndJ2kQTANGKtzWtp
	e2kUR0Muss8NPz05g5VEKxJl6SGbQtd37BxbAr73Q0/NuIsc9mRXl30sxnAAhKcOSxCOjM/GZsR
	5zFB2/qoLlCkf+AP3IN4fXOgD04tX7Ngg9BJX3aFpT7VN
X-Gm-Gg: ATEYQzxQVu+Fe2WH+wEAmhDLSk6PjB8hTwDIANHqYBAt1pEe2mPHhpwVDGXtVuDeCdS
	AQIJ8HqsSXPI1/9Yro3UMZZFlWdVtOE2ZzYj2BRS9WPvwhkEVMsclafqtJuySh07eTehao+oAgI
	aOObxyfRQSVbYgU3c41b254EWNYTna43KtjTIvgvkA5Jk8+vKgKim+FKb/vl03Onkb8O5bbUvuR
	Dizqbxx8D3zNR6Sz7wlTAHRm8KVwbQYAgUwSw6+jhzcQM2hVg73FSRBZqj+SyLOTW0TeVgSd4bO
	VyFyIykzqHxpf6xgdHDN0zReLV2/1kWnOdzBXQL3RIny7kBu5zojPA30EIgcOO1EYQ==
X-Received: by 2002:a17:907:158a:b0:b98:2c44:6631 with SMTP id
 a640c23a62f3a-b982f21dc70mr733527866b.14.1774320978733; Mon, 23 Mar 2026
 19:56:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260314123741.1439792-1-gality369@gmail.com> <20260314123741.1439792-2-gality369@gmail.com>
 <20260323174027.GN5735@twin.jikos.cz>
In-Reply-To: <20260323174027.GN5735@twin.jikos.cz>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Tue, 24 Mar 2026 10:56:07 +0800
X-Gm-Features: AQROBzDejusHmhqodxDfy9ApYb3p-75c3_u4nNYjkSfzM53rurgHUy-jBUQ4MT0
Message-ID: <CAOmEq9UCwf_NzNh3tbuYqWYWxdkM8-V4w38YeVWwaK=RmR9usw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] btrfs: balance: fix null-ptr-deref in chunk_usage_filter
To: dsterba@suse.cz
Cc: dsterba@suse.com, clm@fb.com, idryomov@gmail.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,fb.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-230048-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.cz:email]
X-Rspamd-Queue-Id: 7D700301656
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 24, 2026 at 1:40=E2=80=AFAM David Sterba <dsterba@suse.cz> wrot=
e:
> So, for example you let a filesystem create some structures, let it
> continue, damage/destroy the structures and then let it access again?
>
> If this is supposed to emulate a corruption, either on media or in the
> IO path then OK.

Yes, this is one of the fuzzing strategies we use, where metadata is
intentionally corrupted at runtime to emulate possible media corruption
or I/O errors.

> > diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> > index 2bec544d8ba3..7c21ac249383 100644
> > --- a/fs/btrfs/volumes.c
> > +++ b/fs/btrfs/volumes.c
> > @@ -3863,14 +3863,20 @@ static bool chunk_usage_range_filter(struct btr=
fs_fs_info *fs_info, u64 chunk_of
> >       return ret;
> >  }
> >
> > -static bool chunk_usage_filter(struct btrfs_fs_info *fs_info, u64 chun=
k_offset,
> > -                            struct btrfs_balance_args *bargs)
> > +static int chunk_usage_filter(struct btrfs_fs_info *fs_info, u64 chunk=
_offset,
> > +                           struct btrfs_balance_args *bargs)
> >  {
> >       struct btrfs_block_group *cache;
> >       u64 chunk_used, user_thresh;
> >       bool ret =3D true;
>
> As this is bool it does not match the changed return type anymore
>
> >
> >       cache =3D btrfs_lookup_block_group(fs_info, chunk_offset);
> > +     if (!cache) {
> > +             btrfs_err(fs_info,
> > +                       "balance: chunk at bytenr %llu has no correspon=
ding block group",
> > +                       chunk_offset);
> > +             return -EUCLEAN;
> > +     }
> >       chunk_used =3D cache->used;
> >
> >       if (bargs->usage_min =3D=3D 0)
> > @@ -3986,8 +3992,8 @@ static bool chunk_soft_convert_filter(u64 chunk_t=
ype, struct btrfs_balance_args
> >       return false;
> >  }
> >
> > -static bool should_balance_chunk(struct extent_buffer *leaf, struct bt=
rfs_chunk *chunk,
> > -                              u64 chunk_offset)
> > +static int should_balance_chunk(struct extent_buffer *leaf, struct btr=
fs_chunk *chunk,
> > +                             u64 chunk_offset)
> >  {
> >       struct btrfs_fs_info *fs_info =3D leaf->fs_info;
> >       struct btrfs_balance_control *bctl =3D fs_info->balance_ctl;
> > @@ -4014,9 +4020,13 @@ static bool should_balance_chunk(struct extent_b=
uffer *leaf, struct btrfs_chunk
> >       }
> >
> >       /* usage filter */
> > -     if ((bargs->flags & BTRFS_BALANCE_ARGS_USAGE) &&
> > -         chunk_usage_filter(fs_info, chunk_offset, bargs)) {
> > -             return false;
> > +     if (bargs->flags & BTRFS_BALANCE_ARGS_USAGE) {
> > +             int filter_ret =3D chunk_usage_filter(fs_info, chunk_offs=
et, bargs);
>
> Same problem here. Also please use ret2 for nested return values.

Thanks for the note, I=E2=80=99ll fix the return type issue and send a v3.

Thanks,
ZhengYuan Huang

