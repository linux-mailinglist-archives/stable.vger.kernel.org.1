Return-Path: <stable+bounces-233087-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OIpCDwGszml+pQYAu9opvQ
	(envelope-from <stable+bounces-233087-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:48:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4602038CBFF
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 19:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F0DA301B665
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 17:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32CC3EFD1A;
	Thu,  2 Apr 2026 17:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZeGTnTG"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E1635AC2C
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 17:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775152016; cv=pass; b=mJA/bHJcxPTfHrHDg2Nm9Ng/6TsG0qvTnagYXpi4za1HOfeVDIfIPcrYn8A0R2qGTFZv6xXtNRalXFGAhcgL9r7RxRe3ogHMFiMOiZdlFPOT7ZLK3b2V9wAixcQOXYUy9mgRozDH2Um+fDVEC0DnToXuTetoZQBUAvX0FBtqSWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775152016; c=relaxed/simple;
	bh=vLWME0cnYtbrYL3id4SXNOx/aCqzr9gZTol9fgRzy2o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uTaAtYEvZo9S7N57H/NyFREucIqp+XU8gigcM1RQ6PEhOLOm5/Q4hGiO2JWuwZBvfsv8VNGNpKJk8megCwjxvgD+Sgj1VVs8MLduMIBOzOZdYrGpXthbxqKfCenNT/t37KHzhiXkJIZoBMASndpWv73qtT9Yu5bG9Pn/SBAqivY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TZeGTnTG; arc=pass smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-40ef10ec84cso918189fac.2
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 10:46:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775152014; cv=none;
        d=google.com; s=arc-20240605;
        b=PeQCfY4/dDLbpYip60DWqeh7valWHvT2hE3y9lwLiAOIbYKTJKlYua/+CcpLqxab0k
         WWqMuEyW2+RwEpSLhdZBi5B/bNwV2xAxfIiRfgmosA26i73KP2IQE8dSPtznYGxa0FXt
         fPuOEFJzB8Am48DHq7IsywmHs2Szql73ItYxQXtUODeaXflLm6uTUGlKfk+iv50+00Fr
         /pLxOErhmu2u+YiwhZFJsvoQugS+8+U/rJ8AzTyO+Nu8hv0HiUx2vUQmYsCBckI1YGOC
         VjmCMRVRGPKuZhdKnFecNIzNa//r9ezFstVf3Xpem5iZafkdiNCRK+lOT5A7qjqtbi1z
         CkAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QCWYfKeXB20MomO0D+y1pxAHdIkqRWaleYo5B5V4Oiw=;
        fh=7NCBQToVwBNZGGJsOaKA2v75TcmKLaNF+F1pAdTz/5s=;
        b=iJ4Rx2o6qn7eOw+huUv9Z7+FUFplD4pz0cSRg9dkKnZd5qvRcUF3dC71WcYvUwsmf8
         4mJVaUtxJDlv17ZwY/catAlfF29BjSGWfefERqDxQOATfwy9STlMaGgR3RciHbW+mel/
         7NjeTKGZqRDu2BQcr0p+VMGYiVyL3USa0HnJvcQ3YtvI4gAG5sBhG0IChXdYFOUFXuKV
         Ek1FCCiRUnIBzJ2i8e+9V6pqJnvoS1R/1VWORag8Hz4bSVCbhAbky7E8WdP+dbxoEj2t
         WEfOLriRb4t02PqsxBzvYVT6s+uzZYjHK6l1cIV7ZadMJNzW+kfjV1cbFfv0tjDetoQi
         bIjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775152014; x=1775756814; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QCWYfKeXB20MomO0D+y1pxAHdIkqRWaleYo5B5V4Oiw=;
        b=TZeGTnTGHk4xuUQPHv7tnbxFy//tATeVrD4AzJZp7eP566Yjjz7KEQJUeFwIVwJlgo
         +POZAlc8iaAUbQXwSttD1HqzLRT5Qpj8HJgCURwhne9bdQxRe9qjAGrAe84r5FoHxgsc
         VZb3IpjCBtha9DOSgwwYSecdh+C6hvyoV8WTsE6eR14Ui44ev5cl7aKn9UzhuOvkrbkY
         dbAi6Hp46+rKogdkLdkLv5uZu1lI4A1X230iatMowm1IqHgwZr15WR9kTc3qyJGLbwey
         xMrNT4VTJcDmL73Y+Th/fwHcNSgPac26jXlb2NWXD7x9Cy3Ow76PMyKcFss62b43ylon
         1Qpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775152014; x=1775756814;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QCWYfKeXB20MomO0D+y1pxAHdIkqRWaleYo5B5V4Oiw=;
        b=AunQj9LOizkSk+C7JmX/xaMTi9+EypJY1dCbN8YBPkczL78f33b0sDoZfC7mbpg4It
         5vPNj4IBJHZjENRzb5n5vbQWM0heu/Pkcmnu9efAu6cLUdss6lvKbvVJ0SRjEChduOLt
         mIFX75yrGFE9a/CE3S676VCx5SBlYDqtYj/DYqlnOxK1fLSnLIF6B6VdbUIOC0yQMG15
         zQUY2MyDqgspmswPuCApfzFPIon9PVCuAEFsQeiAGCkn2nq6Njuwvm5/IEr/ZvcC7Nmy
         luPpmpo2bGUgkgkdYwsl0/FcWCmSyCKZCBOJtQimELZfpUNu2A43yWUk2mZ5yc/AMWsR
         oAug==
X-Forwarded-Encrypted: i=1; AJvYcCWaP5L7JfzbWzyy93/IaRPDQwMyMKcHTVmPaWJ6zcvxh9m110FaoLrlHII7i2OgJx/l6N0s8dw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlIMqQ7SorKbALaTdTHdBmKf4+/PqNBvJg3KtSojn2MKxtJHpp
	czxZn4m1FDwB4+4gpe8rXL4kaWi5NRHuT/kACp91063+RSAUAl72IujMkO7j+iRqcnqmJYzJzdq
	Z80qsXdbQo+hpAP2VJpF13qkvRQxfnik=
X-Gm-Gg: ATEYQzzwEaVy8oK1hB1wOLEDY/jTF9/uayMLxfA2Ndng0C9GBIyypMQVSkOGjZt40h/
	abxJEKdaUE45uHmwEATu7p1UPbek6IEG/lPufJmOgBPczNSneLIpczJLG2Owx0PY/e9yJPo7pFk
	YYbWwDJitG+MiGzdM8MbvYTO2C0pCo+4tlBE4q19uNBCVbk5lE8eLOOD2UZiKEhFNEQAVbTjX9Q
	SLdgEPocmF2ef48blUlvPZH/SsFqsWEUu5XIk6ruydIlviY8Kqbh0UCBiLr4waBmWq9fm8p+E2J
	EhLN/SM=
X-Received: by 2002:a05:6870:2323:b0:41b:edc8:7bb1 with SMTP id
 586e51a60fabf-422cffec1camr5232458fac.43.1775152013888; Thu, 02 Apr 2026
 10:46:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402111332.55957-1-tpluszz77@gmail.com> <686134c9-c2e3-444f-b83a-dd229c7b0102@lucifer.local>
 <389887c2-ddae-4456-b9d2-417aaaa2b340@kernel.org> <5a45a004-9ad1-4503-82b2-cf46b4ed4f9c@lucifer.local>
 <ea00acf0-e743-453c-aaa3-b688cf87f3e6@kernel.org>
In-Reply-To: <ea00acf0-e743-453c-aaa3-b688cf87f3e6@kernel.org>
From: Andrei Vagin <avagin@gmail.com>
Date: Thu, 2 Apr 2026 10:46:41 -0700
X-Gm-Features: AQROBzB4xb9cbiOvevc-qc69sOwxlYEMm5dKPC9iiIiSbkUs8mf5C0Pke5hEWyo
Message-ID: <CANaxB-x+UCqd7YMY=xxV1JJq4FtgBifJJVMrzBmqzp+VVsUgsA@mail.gmail.com>
Subject: Re: [PATCH] prctl: require checkpoint_restore_ns_capable for PR_SET_MM_MAP
To: "David Hildenbrand (Arm)" <david@kernel.org>, Cyrill Gorcunov <gorcunov@openvz.org>
Cc: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>, Qi Tang <tpluszz77@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Oleg Nesterov <oleg@redhat.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, criu@lists.linux.dev, 
	Aleksandr Mikhalitsyn <alexander@mihalicyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233087-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linux-foundation.org,redhat.com,vger.kernel.org,lists.linux.dev,mihalicyn.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,iu.edu:url]
X-Rspamd-Queue-Id: 4602038CBFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 2, 2026 at 7:29=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 4/2/26 16:21, Lorenzo Stoakes (Oracle) wrote:
> > On Thu, Apr 02, 2026 at 03:55:27PM +0200, David Hildenbrand (Arm) wrote=
:
> >> On 4/2/26 15:06, Lorenzo Stoakes (Oracle) wrote:
> >>>
> >>> We've had a gaping security hole since 2014 and nobody noticed? I fin=
d it
> >>> hard to believe.
> >>>
> >>>
> >>> Hmm there is already:
> >>>
> >>>     if (prctl_map.exe_fd !=3D (u32)-1) {
> >>>             /*
> >>>              * Check if the current user is checkpoint/restore capabl=
e.
> >>>              * At the time of this writing, it checks for CAP_SYS_ADM=
IN
> >>>              * or CAP_CHECKPOINT_RESTORE.
> >>>              * Note that a user with access to ptrace can masquerade =
an
> >>>              * arbitrary program as any executable, even setuid ones.
> >>>              * This may have implications in the tomoyo subsystem.
> >>>              */
> >>>             if (!checkpoint_restore_ns_capable(current_user_ns()))
> >>>                     return -EPERM;
> >>>
> >>> And you're proposing _adding_ this check on top of that? Seems super
> >>> redundant.
> >>
> >> Yes, should be moved.
> >
> > Well, I don't think this patch should be applied at all...
> >
>
> I mean a v2 would have to do that. Whether we would merge that is
> another discussion :)
>
> >>
> >>>
> >>> but also, this seems super-specific buuut... Then again #ifdef
> >>> CONFIG_CHECKPOINT_RESTORE around this. Ugh.
> >>>
> >>> I _hate_ this inteface. HATE HATE HATE it.
> >>>
> >>> Anyway, does updating _your own_ auxv really require elevated permiss=
ions
> >>> like this?
> >>>
> >>> I don't think so? Couldn't you go and manipulate that anyway without
> >>> elevated anything?
> >>
> >> Hard to believe ...
> >>
> >> I was wondering whether this could break some users. At least CRIU doc
> >> states:
> >>
> >>     This option tells *criu* to accept the limitations when running
> >>     as non-root. Running as non-root requires *criu* at least to have
> >>     *CAP_SYS_ADMIN* or *CAP_CHECKPOINT_RESTORE*. For details about
> >>     running *criu* as non-root please consult the *NON-ROOT* section.
> >
> > Hmm. I wonder if we don't have more users than that though? Hard to rul=
e out
> > some weird program somewhere using it for some strange reason.
>
> See my LXC example. My gut feeling is that there are more users.
>
> Which then raises the question why this is still protected by that
> kconfig option.
>
> Something is off here, maybe :)
>
> >
> > Commit ebd6de681238 ("prctl: Allow local CAP_CHECKPOINT_RESTORE to chan=
ge
> > /proc/self/exe") explicitly _only_ restricted the exe link.
> >
> > So maybe these comment is in reference to _other_ operations other than=
 non-exe
> > changing PR_SET_MM_MAP, PR_SET_MM_MAP_SIZE?
> >
> >>
> >> I mean, the check makes sense given that prctl_set_mm() rejects all
> >> these operations without CAP_SYS_RESOURCE.
> >
> > Hmm but the CAP_SYS_RESOURCE check is only applicable to commands other=
 than
> > PR_SET_MM_MAP or PR_SET_MM_MAP_SIZE?
> >
> > #ifdef CONFIG_CHECKPOINT_RESTORE
> >       if (opt =3D=3D PR_SET_MM_MAP || opt =3D=3D PR_SET_MM_MAP_SIZE)
> >               return prctl_set_mm_map(opt, (const void __user *)addr, a=
rg4);
> > #endif
> >
> >       if (!capable(CAP_SYS_RESOURCE))
> >               return -EPERM;
> >
> >       ... rest ...
>
> My point is that you can perform all these modifications without
> CAP_SYS_RESOURCE through prctl_set_mm_map().
>
> Like PR_SET_MM_AUXV.
>
> It's all very inconsistent, that's what I am saying.
>
> >
> >>
> >>
> >> CAP_CHECKPOINT_RESTORE was not introduced before
> >>
> >> commit 124ea650d3072b005457faed69909221c2905a1f
> >> Author: Adrian Reber <areber@redhat.com>
> >> Date:   Sun Jul 19 12:04:11 2020 +0200
> >>
> >>     capabilities: Introduce CAP_CHECKPOINT_RESTORE
> >>
> >> So at the time PR_SET_MM_MAP was added there simply was no such capabi=
lity.
> >>
> >> Likely, now that we have it, we should indeed use it.
> >
> > But we did start using it in the exec_fd !=3D -1 case?
>
> The existing ns check was replaced at some point, yes.
>
> >
> > Hmm actually sorry it does more than just manipulating auxv, you can ch=
ange a
> > bunch of mm->... stuff.
> >
> > But if it's your process does it really matter? You can manipulate memo=
ry all
> > over the place in your process...
>
> Well, I am wondering why e.g., PR_SET_MM_AUXV etc requires CAP_SYS_RESOUR=
CE.
>
> PR_SET_MM_EXE_FILE I understand. The other not.
>
> Extremely inconsistent.

It was a long time ago, and I was not directly involved in introducing
PR_SET_MM_MAP. As far as I remember, the PR_SET_MM_{START,END}_ATTR
commands were introduced first, and they were guarded by the global
CAP_SYS_RESOURCE capability. I believe these prctl calls were part of
the first series of patches for user-process Checkpoint/Restore (C/R)
merged into the Linux kernel.

A few years later, as real users started adopting CRIU, there was a demand
to support user namespaces. There was a discussion about relaxing the
global CAP_SYS_RESOURCE check. Eric expressed
concern that this interface didn=E2=80=99t guarantee the consistency of the=
se
parameters. That was the moment PR_SET_MM_MAP was introduced. I dug into
the history and found the relevant discussion:
https://lkml.iu.edu/hypermail/linux/kernel/1407.1/01621.html
https://lkml.iu.edu/hypermail/linux/kernel/1407.1/00899.html.

```
Subject: prctl: PR_SET_MM -- Introduce PR_SET_MM_MAP operation

During development of c/r we've noticed that in case if we need to
support user namespaces we face a problem with capabilities in
prctl(PR_SET_MM, ...) call, in particular once new user namespace
is created capable(CAP_SYS_RESOURCE) no longer passes.

A approach is to eliminate CAP_SYS_RESOURCE check but pass all
new values in one bundle, which would allow the kernel to make
more intensive test for sanity of values and same time allow us to
support checkpoint/restore of user namespaces.
```

The initial implementation of PR_SET_MM_MAP didn't have the capability
check. It was introduced in 4d28df6152aa ("prctl: Allow local
CAP_SYS_ADMIN changing exe_file").

Thanks,
Andrei

