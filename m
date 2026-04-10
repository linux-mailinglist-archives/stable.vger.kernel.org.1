Return-Path: <stable+bounces-235651-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6KsHD1wz2WmjnQgAu9opvQ
	(envelope-from <stable+bounces-235651-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:29:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 376943DB0F3
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 19:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EED4300692F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 17:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC3D3E0C57;
	Fri, 10 Apr 2026 17:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/doCxf4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659943E120F
	for <stable@vger.kernel.org>; Fri, 10 Apr 2026 17:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775842102; cv=pass; b=Zo5DN2SFZGNnhfkyokWoRjLxjoQZsNpByZbSqVnxMz65E3BCGTWlGaMin83aiybAInxdpYjmY1Q+PXcd+b2l4gX41gunxrGtLLmMjrMD264IUSWxceBBgqWudAlLILb9NkMUQY+VVaIEgn0ddFL6eFm4DvUMzUBjaFSaFq1yfEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775842102; c=relaxed/simple;
	bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D35t4WKPG9A8QTvfImTULyqlqwyxCdnAYUU6V3cXZ6poKOq2nzOGnaNTkvZVG1ZxnBcTX/U0+8FjqoAfA4EmFLNV8rfR9yHJ+NhBgnV6DLQIa97D5hGsEprGXRPqNN57Ku9jcao627DXFIaedSP8wOStSpffGE8BhcDv+nYEDCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/doCxf4; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48897fd88ebso24477015e9.2
        for <stable@vger.kernel.org>; Fri, 10 Apr 2026 10:28:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775842100; cv=none;
        d=google.com; s=arc-20240605;
        b=D6oAkSLZTtHJ9cC7sXePe1svFM4p9kAfEGMgTDj2j1PGbwHP1HtCTPbg+OLVoCpiQF
         jFwhhzX50ebRzOsHPB7/Himz38klsGXA0xDun8nUoUXc48aJhwLhDtg7WktyLQYg1+rA
         krJXlKj2tUW82Qpv7t7/869Om5Tkg9/JI1NFTiF17bcvD5kAOcIen/3OVQ2QhMX7vUQN
         clYR0CHzQA1OiaKnZppT0l5Tz7tQyPO13D8YO6GCn8L0PnPKqm+AgRBj7e8O43dDJpAb
         8KbKLExQiCoTbkDD3FFYV+O9IMSoRLCGkaYWnsV3HFtAAcCe81k+2V7DqkLhhtdosM8Y
         f70A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
        fh=r6FuONt0ApCux5OQyyEJuJyVRYzESS83Rt+7IPdlXl0=;
        b=SmuCbDFIjElze2+eIycOt8nCZtE3gxv92I23f0oxWYnehGFyDBgEIo3I7wU966n4of
         xLiUm0ESRCpWwAGCVALtek4YqqiJWkUpKvcuasrVe3JUucgXxbdh3RCgpsaSC+PtPdX5
         kZ893RIHNEplK5HJ5EFSZoaO0WyMiYiqdj+Vb7b2gIEVPJfVPO62i4uftJdVX5E3clwW
         osJx5E+oS12TXo5eyotGK+GaHfamJgPsWNXJoChe5d2f7Dpwi9rRDEAI06pNAZKOFny4
         /1tev/XYp6wLgOv6tkFjCF/QzSEEj3bwgk3Pg6U3c3cbVHZG8QKLkXeSg3+Da7O97y34
         0O6g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775842100; x=1776446900; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
        b=G/doCxf4nvuExAnmxE5TaRgRRXk044LGACoz228o+fpBD1gBo0Js3MeYfpn9zFDsir
         gOalSgw7B08P8jNVcMSTyznIz6U8iQWj4gkE6MkEpaUDxDEn2dLE2wIPTP/GvVCz3aqt
         BKLSYNAcuBVxlAaazNwvewJoKlW+VwESoMDiKje2gNcU40Fyyk/mq/nqku++GF8M0L2G
         gbm8UNlt01y0M12REnHtAiDKt4xnM6Xs8NgmMi2EMZR0MAUd7TGmFEYi35wES7t3k1lR
         BhBpOEpSzKhqq008uwTKRX4Z3Zs0Gz+mwIRbANu1o7qfdExXZRMGmKGwUKzNdmv0voBl
         zM2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775842100; x=1776446900;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jdsyBt3/Kio3xWCllaU1Sz8HEB36v3G/OEQlvSGr848=;
        b=Y2hOPMuP9U7CIZyhAETZt/lOmX+6YUQLl8Q4lL6T0m7BvWHMigWLrn2skeShsYy53Q
         H9oUPeqnsKr1W58jmFSlxQG+MmoJnViLKIGu3B49q+TO/u7l9KKyOpOE3Z8N0aZ2l1c4
         gmwfB4HfJGHJKV6SqHcw0ZvHfggzhV7qkBa/Ud1zVVDIgBAiO5ugSYoYDr8pkd1FEh1H
         FY83fc21p7nRFdxQLaMj1LwIr2m1zyUDoayTsO0xgo0ttk3xhUHVboleoMFmiuG1rUJB
         lNeCGMOSnuCm81n5diUnR9NoAj5nrvdreHRymhIgajPVxRcjywQvel/KjKuhaU2IZlSl
         m00Q==
X-Forwarded-Encrypted: i=1; AJvYcCWiPMPn2E/I4l/gudpbrCOkGq0S9XegieRbw1t5ChImSNAAJLiMsKGQzdN2JhOA5FMrn8Yodec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrnIm3Nlr8lx616nLzhG0UdXVcbiSPou4t5chZNiNGr+zQWMlQ
	gEQw1AW4LqamCtYxHJT1QJVPmEc+WQ7PSfAxxeNF2cSesmIcQShtsY+RGRZJGblgNxXUtnVbyu1
	tS+siZzGnQoMQu2QF66oow9pNxOiMV4ugbcEtzI0=
X-Gm-Gg: AeBDieuW+oWgkdTeVVt4MmZ1N7tXFpTzUgIIHtuh4o8XhOt9RNVWn/MhfiLYZ7qqhHR
	98iUX92EEhjkpfFP44rr6TP7AJ+kx8ymQLLEBP/wooobWlGNeYruQGyubsjKmZNVuflQM8gbUJh
	GaTO4Br0xWtQthSY7yuU3Nxy1hEsceHcNPmcd4OZY8EXanPntEbVhshZwXzSDi7GA+lPBckH6st
	4LDrTyrfK6n2mvwZIISJFHhUKrEHH+OLwhsjim/2frhKdkGancERf85zb8qpRQTquYxNBccg3dC
	bNsqqQ==
X-Received: by 2002:a05:600c:628b:b0:487:1fbf:e0bb with SMTP id
 5b1f17b1804b1-488d680851fmr53226865e9.6.1775842099481; Fri, 10 Apr 2026
 10:28:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021-io-uring-fixes-cancel-mem-leak-v1-0-26b78b2c973c@ddn.com>
 <4b5a8040-b62c-4d75-a474-70d0b4759461@bsbernd.com> <CAJnrk1ZohxcDERszbii8ZM0g1ZzTwk6+wEqRWpCoSwBXzgavkg@mail.gmail.com>
 <adiiTGjP1tqZfIrI@fedora> <CAJnrk1Y37_=OtwZHK_-AEN9Fysoi8VapeiQmv-xxvWjZJZn8+Q@mail.gmail.com>
 <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com>
In-Reply-To: <a9b8887d-f80a-4a0b-a1a5-3dd52dd23497@bsbernd.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 10 Apr 2026 10:28:07 -0700
X-Gm-Features: AQROBzCBpnM0YmTlP8NptZ8FmIfA4r2lRbJ75c7O27XrO_0_1rvbDAboqFdeYds
Message-ID: <CAJnrk1aSE3ukj=6aoG-UhsFQN1Eo1_AEZk07X+M_z2GM-dq-AA@mail.gmail.com>
Subject: Re: [PATCH 0/2] fuse: Fix possible memleak at startup with immediate teardown
To: Bernd Schubert <bernd@bsbernd.com>
Cc: Horst Birthelmer <horst@birthelmer.de>, Bernd Schubert <bschubert@ddn.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org, 
	Jian Huang Li <ali@ddn.com>, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-235651-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joannelkoong@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,bsbernd.com:email,birthelmer.de:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 376943DB0F3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 10:18=E2=80=AFAM Bernd Schubert <bernd@bsbernd.com>=
 wrote:
>
>
>
> On 4/10/26 19:09, Joanne Koong wrote:
> > On Fri, Apr 10, 2026 at 12:21=E2=80=AFAM Horst Birthelmer <horst@birthe=
lmer.de> wrote:
> >>
> >> On Thu, Apr 09, 2026 at 04:09:53PM -0700, Joanne Koong wrote:
> >>> On Thu, Apr 9, 2026 at 4:02=E2=80=AFAM Bernd Schubert <bernd@bsbernd.=
com> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 10/21/25 23:33, Bernd Schubert wrote:
> >>>>> Do not merge yet, the current series has not been tested yet.
> >>>>
> >>>> I'm glad that that I was hesitating to apply it, the DDN branch had =
it
> >>>> for ages and this patch actually introduced a possible fc->num_waiti=
ng
> >>>> issue, because fc->uring->queue_refs might go down to 0 though
> >>>> fuse_uring_cancel() and then fuse_uring_abort() would never stop and
> >>>> flush the queues without another addition.
> >>>>
> >>>
> >>> Hi Bernd and Jian,
> >>>
> >>> For some reason the "[PATCH 2/2] fs/fuse: fix potential memory leak
> >>> from fuse_uring_cancel" email was never delivered to my inbox, so I a=
m
> >>> just going to write my reply to that patch here instead, hope that's
> >>> ok.
> >>>
> >>> Just to summarize, the race is that during unmount, fuse_abort() ->
> >>> fuse_uring_abort() -> ... -> fuse_uring_teardown_entries() -> ... ->
> >>> fuse_uring_entry_teardown() gets run but there may still be sqes that
> >>> are being registered, which results in new ents that are created (and
> >>> leaked) after the teardown logic has finished and the queues are
> >>> stopped/dead. The async teardown work (fuse_uring_async_stop_queues()=
)
> >>> never gets scheduled because at the time of teardown, queue->refs is =
0
> >>> as those sqes have not fully created the ents and grabbed refs yet.
> >>> fuse_uring_destruct() runs during unmount, but this doesn't clean up
> >>> the created ents because those registered ents got put on the
> >>> ent_in_userspace list which fuse_uring_destruct() doesn't go through
> >>> to free, resulting in those ents being leaked.
> >>>
> >>> The root cause of the race is that ents are being registered even whe=
n
> >>> the queue is already stopped/dead. I think if we at registration time
> >>> check the queue state before calling fuse_uring_prepare_cancel(), we
> >>> eliminate the race altogether. If we see that the abort path has
> >>> already triggered (eg queue->stopped =3D=3D true), we manually free t=
he
> >>> ent and return an error instead of adding it to a list, eg
> >>
> >> In my case (Bernd mentioned that I was investigating a hang during umo=
unt)
> >> there were a lot of requests created during teardown, so what happened
> >> was very similar, but for exact the opposite reason.
> >> In fuse_uring_abort() queue_refs was already 0 due to an optimization
> >> where the ring teardown ran before fuse_abort_conn().
> >
> > Hi Horst,
> >
> > Just to clarify, is this with running locally patched changes on your
> > ddn kernel? In the upstream code I'm seeing that teardown is only
> > called by the abort path, eg fuse_abort_conn() -> fuse_uring_abort()
> > -> fuse_uring_stop_queues() -> teardown logic, so I'm not seeing how
> > it's possible for teardown to run before fuse_abort_conn(). Is there
> > something I'm missing?
>
> See my mail please it explains the history and shows the patch I had
> posted to the list and which is not applied yet. The DDN branches have
> it applied.

Hi Bernd,

Can you link to which mail you are referring to? Which patch are you
talking about?

Thanks,
Joanne

>
> Thanks,
> Bernd

