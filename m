Return-Path: <stable+bounces-260179-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DcdtFbF2IGo53wAAu9opvQ
	(envelope-from <stable+bounces-260179-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 20:47:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C467A63A9FC
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 20:47:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=aZCElZPs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260179-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260179-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0048A303D0B1
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 18:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE34D477995;
	Wed,  3 Jun 2026 18:46:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225B437F01B
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 18:46:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780512409; cv=pass; b=XKncVfHQJnZWJAWeoAQl4MMvdCmxEHmCD9s42haF4BpLQezw890qzlk30WOUHca2uy17/HAzxzuJIH/ZNKwxBwjJFC72vsnxBe5NZDyFjs51p0jpA8d8PIIkLQS/QZ0f7Y7AvWu/OWzE1N7V5vTeznORdrKXyrFFk1uX5AOjfH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780512409; c=relaxed/simple;
	bh=T/ZPxZzlX3sZq/L9I8ve0ZkLUAVqVu/gDVfbfSQGf/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HvMwVoNkcwNEmhrUI1VkIln0kpFivCiXwbfqHx2LdPZT2bjAzwPBymRV5lJP4InH7vGBLkndUSWLMh31n4IWECukMOJ5FJIuvIGgyrusM7v6Pyopw7/Z+WJiTBGC6d3ksXzrRLFuzODKNhhArhoZ4eTiHuTA/4zijqeRjYCL3ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aZCElZPs; arc=pass smtp.client-ip=209.85.208.44
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-68cb445dd5cso1470a12.1
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 11:46:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780512406; cv=none;
        d=google.com; s=arc-20240605;
        b=ADp9Lwc1M5pMfbb3x9DMsbIi3ORza6MilZgFxIzAW3oMd9m8HtzkRJaT1OwJ+i5m/Z
         iTqt6YWXIpVHIHyFG8+wQiwbEZGg6ujxFY/DpKHA0xb4daphKlhQNf9EI3xRgFiukRd2
         c1yx/xB/Xkij9+FIBfQNDWT7PO5GNS6PldLlMuNZj44xM4++JSPcDdm6aZiQKHTx7Af+
         /GuOm+piLUCc3bQ3kHi6xnzEnphaqw8AVydlZ1WYEHh+HMkrmFYK23v93DE37eDQ3qdE
         LneQAOBah9zbrmyZyICV9u1wKtDgvVEwkrds7eExcx+ZwUP28yU4AKQpdUmbhmtebHy8
         aR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        fh=zolxWiB9YJh+jOkzthvbK2o4b8QDggdMLCU2UQg7k28=;
        b=j/NCmCBGlWhri1JfLrebadtcOwl4NN0vzd8zCSXl9ty6zGEku3NBtB0g81yEkemPpw
         S/oUZ/B7YQCOGNh1FpptgXIN8ihw36jzJsznnHRJIkQB0vkY9fk5J1Xa29Iq4kEIhi7R
         czgMMr/hrB6jPeBXdL2Cv99qmeOqe9gmgc9dTY0Y10WAgbVsMWDYGuOQDAD11fsOvV1Z
         GpWgxMpzIxOqg7JV4QFNro11GWRpxszjKuI+kb/l6eNW1xP434ay4eSyfaJX5Eaq5Tx1
         EVOMO99Ao3wHbXpKZ0PaAuiNBmxAh5n+VWJSD4AEoRU93tuN2F1KRaBZSaCm5YRxsBS7
         cIVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780512406; x=1781117206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        b=aZCElZPsvTw9rQ9KX8qZWHsmfHgEw2D9EYNkNuLr1RCFEdJApTu1qBtkp2oAX292We
         n/1ggVIEmBLBEY9DgV/CuTQehV+6I85q700o03Vnu4dp9tiu4MkZQ8KzzpYSaBKWos4W
         feg+kPJj5Nd0syIkAYS9TdEMYz/TreTj18DZQorFFh+zoNoyhjuM26nqDPpSjFWGNG8O
         Dn/SM2nwJvNaW9iOxfTFDyFjJ57/HRqq39WvDd8BP7QYDwXE2pf4/Pk9EHKf+JF7r0E0
         Z01Exib40QPwO6uHSCsYui3PT/3feezZOCqRopAqtac6H3gfMpnwb+TF/AzRhfb2xqvQ
         6d3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780512406; x=1781117206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N0I/V/n5gAej83npBKjlcD3mf3nZ4PsFC7cqd9huV/c=;
        b=U9tBBQGZMvUTBFAZRenVoTrlrUvExJR25n120zSl6TYJ37RGBZMFS+jQXtVTIJrl1P
         vPCr1Yonw2ePPbjnj4vpludiTKV9FkVFyTW/cZ4pL6uPtXO+yAGzG/4M2/s4EXjGggpe
         MJpuNT9tfQMZ3t2BFUmmbKEIZe7cWK/kCxS1hndaLEuJdTEd0gg0aqjQCbsAMzA7ibIb
         M/Qi5JKew4gVnTiz5M3aeFGamlDNupDb9UHDmXiWXRlpRa5ao22cPtZepa1/MY9NJ40F
         dbclkJYctb/ojyYVleR9lddiXR4QLO3GBEFoDp51xqup+iqDqIeWvf7qWccApFBqnvFl
         Qwhg==
X-Forwarded-Encrypted: i=1; AFNElJ8mySqCwtxMdDyBQIVoYcI5LqOp3l19LZtzx8PbkvIg7ASYzpnO/eFZgQp/bl+ZxrN/WhqTVf8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQTs/w5BepKDA4xKSA2txYjrca5zOM+PPytVg+Ve3UxF0MChoS
	qgXif84CaKuvZDZrdgkaxsbfrRhumdAuHAFG0NOep88GyYj6PyxsJCiWMmOR09Ypl2EfWmKue+Y
	VtMsE2n68oBPDLVUuz6QLLOCWLMDBfcfKkWy5xD3D
X-Gm-Gg: Acq92OGS4IjFpZUcBNaOpfB3cScX2wVynX44cdKjus2Ohkec9FI7nFn9Utlggoxtjch
	torTpuP1PR7z/FS4gtzhbRbOgaOvC3xNfdTOnz5lU1TccUbtF6UJHS5DTKEu/26IiIkan4DeUDn
	FN0So1UKJK+7KbKRStd5iRTI50TU79lqJd3MhLnvaSCXufyN3duTXGSBMsRyXhmNGpH3TcYSWiv
	Jl6gvBygdCpD0jJOdagAAun7vK3Yj5JzHwpmAmwphHm6/Ip3JFW4zTHwaTT4p5zRc2MnPAMwN0z
	//ZHNtaJ0Lc7e0fs0DZTrcWw0aB7isbsglgxax8Mj3BmwT2sk3Gaxbfd0zM=
X-Received: by 2002:a05:6402:10cd:b0:68a:7046:e64 with SMTP id
 4fb4d7f45d1cf-68f12aaf42cmr15325a12.3.1780512406065; Wed, 03 Jun 2026
 11:46:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
In-Reply-To: <20260603182454.GX2636677@ZenIV>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 20:46:07 +0200
X-Gm-Features: AVHnY4IOIf990_8GL-GvEPTAuAhu-9aAisHbx6iJzPDbVrDL-pH0XXeLuXuhWf0
Message-ID: <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
Subject: Re: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260179-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:chuck.lever@oracle.com,m:jlayton@kernel.org,m:amir73il@gmail.com,m:linux-fsdevel@vger.kernel.org,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[jannh@google.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,oracle.com,gmail.com,vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jannh@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.org.uk:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C467A63A9FC

On Wed, Jun 3, 2026 at 8:24=E2=80=AFPM Al Viro <viro@zeniv.linux.org.uk> wr=
ote:
> On Wed, Jun 03, 2026 at 07:15:23PM +0100, Al Viro wrote:
> > On Wed, Jun 03, 2026 at 07:38:06PM +0200, Jann Horn wrote:
> >
> > > Fix it by taking rcu_read_lock() around the mount::mnt_ns access, lik=
e
> > > in __prepend_path().
> >
> > > +   /*
> > > +    * Containing namespace.
> > > +    * Normally protected by namespace_sem, but there are also lockle=
ss
> > > +    * readers (which must use RCU to guard against the namespace bei=
ng
> > > +    * freed).
> > > +    */
> > > +   struct mnt_namespace *mnt_ns;
> >
> > Umm...  It's somewhat subtle - at the very least you need to explain wh=
y
> > there will be an RCU delay between umount_tree() clearing that and
> > having the sucker freed.
>
> Something along the lines of "removals from namespace are serialized on
> namespace_sem and guaranteed to happen no later than the active
> refcount on namespace reaches zero; freeing of namespace happens only
> after the passive refcount hitting zero and there's an RCU delay between
> dropping the last active ref and dropping the passive one that had been
> implicitly held by the fact of having actives", perhaps?  Only in
> more readable form than that, please...

Hm, like this?

Containing namespace (active).
Normally protected by namespace_sem.
Can also be accessed locklessly under RCU. RCU readers can't rely on
the namespace still being active, but implicitly hold a passive
reference (because an RCU delay happens between a namespace no longer
being active and the corresponding passive refcount drop).

