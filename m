Return-Path: <stable+bounces-245321-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM5YLqlBAmp9pgEAu9opvQ
	(envelope-from <stable+bounces-245321-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:52:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3824E51606C
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F714304FB93
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 20:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1723B634E;
	Mon, 11 May 2026 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNL95gjv"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5C43B530A
	for <stable@vger.kernel.org>; Mon, 11 May 2026 20:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778532757; cv=pass; b=JVP2Vf2KOltvXFS1Lj+rachI4yCWH9zHqSM9K4QS7fBz+WCmlU5YmP+q2CIju61wA9BOpy+52s6H023bgNMAfhNtfWJZKAIh3DdrzT4Zr+q7xQxdpn2SlMFk4O8QSeE0CB7w0Iln6G0VwnKGVBZyRNbng0dGa3g3EXq3uQJ4xhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778532757; c=relaxed/simple;
	bh=DiHWs1sOoiu2X3GZePgpXCTnujQDkMBn+jXMmT4E3Xo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OQ6QiVef5DotLQXW3VoJEqi8jfA/jzEGQZpCisiWbNIzFhDIJOFXTAprowSSETjtcKVEdH535jcpSSkTCmmdc8UfkNJvMYT6XczQ/JtLCIU7bksaxCvqe4k/vEt4Oy4etNCNNRM+F2JYRUO5yGIM5pMMsBCOIxKmM0p0DAv7lwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KNL95gjv; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8379e010b01so1960108b3a.1
        for <stable@vger.kernel.org>; Mon, 11 May 2026 13:52:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778532754; cv=none;
        d=google.com; s=arc-20240605;
        b=i2HDwfwkvWSPNKFyvRGXhQjpTytqa4XXj0GSO+XH1W+1hS3FCKuyL709BNzx0lPLb8
         OqWbLGLxDwGXxvPRZNcIL6ivdjxICVjNxF4vqj64ZavSWkpwbw1g27cKzZz3HEoDIXMK
         1di2E4e2+/Mo3xZa96GwlAvp0tMMgRnbtL0wdxCI6X3s3m9uW4N9vQHAxjV2i3urYP6K
         xnaokyvO1lPTd1k9SfpzhaqeKBzU3drrwHrLhLM80KE6MFt6UNWq/Kn57Mf4s4i+8GC7
         +QKpcKI3gVcsY0jFFA8zd6zQ55+zXLB+cF+URMD7/OS2mP8DGygjxARbdsCIQ9QYuFQ/
         hsQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        fh=4vBEYjnUnLRa8RDgyhK4Rc4wmt8Z5mQC/3WqNvtEtSk=;
        b=g1MaR50Q5tBK9ZLNZ7U1vICO6Np2sL2OCrKuM/0ttRjr3pnAMZUnyAS6qxhLHYWJ2P
         GKmE+fVUKABzOsR8CUp2N8Pg+40RCrAphFEv8uza7m2JvFklcp8kXrER/v51B553ePRj
         DyLarJgEQUDcVkcK+AcUSmqwCCUq65MW2+somBGSOA4AieLldX9gHSBiUwTiYayCTrbm
         mF/fER8i86DMERE/bZk+p6xU9uThp2tbsJTWR+DBvtQnh1xEGEoieXJjly+DdlbQmWAc
         Tdzem6TV5qYUPUsL4YFUzyV6n55T5Dmd9yOfx7nSI9NgEvryR9G8w/s8d5e40AC2fdqd
         6mNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778532754; x=1779137554; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        b=KNL95gjvbWQXoawbUCz0Gg17P/zErBroamUNEtu6ucAMcF6gXWEzMI4S4HvYKbMD3C
         apml2UkN5+zj2Ld2qje12S7sXOjZ+h4j71Ou+M8aQ2Nyr7Kd0uU/zCt1ViL0jDNDYR3M
         QmNYjkvu0JUlHXvJ00w3/HjCMo2ou/Ia8+dNmAs82qVSyI1wXd3a/CRMryd1GtoXhpSE
         4hZabtcnSE3sG+G4lcuLorg3wrEb12Xk/l40QaTrI9/amqf9ilHLL6uu9hKPdFR9y9wf
         TqMG3uJUqo+GhNihyFhpWnfEFmXOcrKNNowkVdKOwRe6wpn+M0AfK2iy7dVWZqADjle1
         ExMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778532754; x=1779137554;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qb2D7VaeqYETPPxAqKFZu7rg55Sh46PbfZK/pmKKrP0=;
        b=l0Hxua0jyOYkyNepsDpihHQu5sTsZYSD0DqfMvIYlfukKNAiEqENtWeITz748WGgDf
         Do30edEEPUNbdDK1wkwxZn29pVWNnJOP0vyQvorwCRMleivCWI3K0O5v2kU1o8FJDTzL
         6HvFojk1xmG3mWGUmtYzTiGIytFP7F4bzzr5SZihfGChDSY3Jxrjo5fG1oyMmYkrDPLw
         93q7uZimorr1qpgie2bB5DOwtDAm/2iNk5JJZVVWFvzFNdQl9xwu4+G9nIXFpG6k60gX
         MXjjurSnwLwyyhESGj6Oraq9Yg/dlZpppmInwqnykG/UWc0333byBPed1PloiF3dYzK9
         gjgA==
X-Forwarded-Encrypted: i=1; AFNElJ+3hJHSv0+o91ix9U+rmQksIIhjs/G8yQK4B/EK7Ky/U5S/XsAdbv2bTATB3ScgkF1R3meleJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyal2MXKYnO1bCv2MycYHpSPV4O5nHt/PLSQYa0ZbSn5wmM2TC+
	OgGJqYz1ojmYAvkrrvjI0qbDYvfUgpgAKhutIAuqTyqYE4FrvEF3dgSkye29cOVyb4W+Uvgp0nP
	fJ/uYY9uFsQzkFBijtqzxcL6QrIIVq7U=
X-Gm-Gg: Acq92OECbteXi5yLY05MnW/hUq59D8XjftdQH71iY4aYZlKSjzm8r6sisj6WMUIiy6U
	aPVceJDKMFU3dvHroiD/P0KBxSLBoenS/w9h0rBfuLBfg50po2eo+rG5LOqghVppCq3vaOWuqjk
	6Qc7+ewOGUd8D6LS44HSU5Dtf/9XNRoDB6xdtA5a7wMsEjKV+kxc7yrlQv2NxTrUb4XwDrvb+ZL
	yMptOsnrkvjn8LRvC1Sd+WXj/1eHhsj+h6YrQphY9RaaMsO5ozgp/AF3WhznQkfgvZWFDyOet2Q
	q0w/CrFmVoV8LKg5Xvux+aObWrkc91tXBenTxKZU424wAGlxHDcxfPZxLi/Ci8W/3NlrybFcLii
	XLxSGuj55MP70jITkpiYceMkuP3tT3/fMuWaf2k9y
X-Received: by 2002:a05:6a00:1bc9:b0:82c:d7c4:4c5c with SMTP id
 d2e1a72fcca58-83a5bae02b6mr23896094b3a.20.1778532754053; Mon, 11 May 2026
 13:52:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508001455.3137-1-joycathacker@gmail.com> <CADvbK_fOduqbZSx7xefbDhDi+=eLmgN8k=Bm+J0tRDrFj6ZYmQ@mail.gmail.com>
 <20260508182044.55b567c1@kernel.org>
In-Reply-To: <20260508182044.55b567c1@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 11 May 2026 16:52:21 -0400
X-Gm-Features: AVHnY4K-4oufZ5Bh_ouYXMsrGsz6Jdk671TfT3bU5bBuK9XkaMlt9GEU6bPpSL8
Message-ID: <CADvbK_f0hTB5rsjNO7Mkg69KqTF2QmCKHNH__JCwS5LtfPgRLg@mail.gmail.com>
Subject: Re: [PATCH net] sctp: revalidate list cursor after
 sctp_sendmsg_to_asoc() in SCTP_SENDALL
To: Jakub Kicinski <kuba@kernel.org>
Cc: joycathacker@gmail.com, marcelo.leitner@gmail.com, davem@davemloft.net, 
	edumazet@google.com, pabeni@redhat.com, horms@kernel.org, 
	linux-sctp@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, security@kernel.org, 
	Ben Morris <bmorris@anthropic.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3824E51606C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245321-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org,anthropic.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,anthropic.com:email,mail.gmail.com:mid,sashiko.dev:url]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 9:20=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Fri, 8 May 2026 16:35:21 -0400 Xin Long wrote:
> > On Thu, May 7, 2026 at 8:15=E2=80=AFPM <joycathacker@gmail.com> wrote:
> > >
> > > From: Ben Morris <bmorris@anthropic.com>
> > >
> > > The SCTP_SENDALL path in sctp_sendmsg() iterates ep->asocs with
> > > list_for_each_entry_safe(), which caches the next entry in @tmp befor=
e
> > > the loop body runs.  The body calls sctp_sendmsg_to_asoc(), which may
> > > drop the socket lock inside sctp_wait_for_sndbuf().
> > >
> > > While the lock is dropped, another thread can SCTP_SOCKOPT_PEELOFF th=
e
> > > association cached in @tmp, migrating it to a new endpoint via
> > > sctp_sock_migrate() (list_del_init() + list_add_tail() to
> > > newep->asocs), and optionally close the new socket which frees the
> > > association via kfree_rcu().  The cached @tmp can also be freed by a
> > > network ABORT for that association, processed in softirq while the
> > > lock is dropped.
> > >
> > > sctp_wait_for_sndbuf() revalidates @asoc (the current entry) on re-lo=
ck
> > > via the "sk !=3D asoc->base.sk" and "asoc->base.dead" checks, but not=
hing
> > > revalidates @tmp.  After a successful return, the iterator advances t=
o
> > > the stale @tmp, yielding either a use-after-free (if the peeled socke=
t
> > > was closed) or a list-walk onto the new endpoint's list head (type
> > > confusion of &newep->asocs as a struct sctp_association *).
> > >
> > > Both are reachable from CapEff=3D0; the type-confusion path gives
> > > controlled indirect call via the outqueue.sched->init_sid pointer.
> > >
> > > Fix by re-deriving @tmp from @asoc after sctp_sendmsg_to_asoc()
> > > returns.  @asoc is known to still be on ep->asocs at that point: the
> > > only callers that list_del an association from ep->asocs are
> > > sctp_association_free() (which sets asoc->base.dead) and
> > > sctp_assoc_migrate() (which changes asoc->base.sk), and
> > > sctp_wait_for_sndbuf() checks both under the lock before any
> > > successful return; a tripped check propagates as err < 0 and the loop
> > > bails before the re-derive.
> > >
> > > The SCTP_ABORT path in sctp_sendmsg_check_sflags() returns 0 and the
> > > loop hits 'continue' before sctp_sendmsg_to_asoc() is ever called, so
> > > the @tmp cached by list_for_each_entry_safe() still covers the
> > > lock-held free that ba59fb027307 ("sctp: walk the list of asoc
> > > safely") was added for.
> > >
> > > Fixes: 4910280503f3 ("sctp: add support for snd flag SCTP_SENDALL pro=
cess in sendmsg")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: claude:mythos
> > > Signed-off-by: Ben Morris <bmorris@anthropic.com>
> >
> > Acked-by: Xin Long <lucien.xin@gmail.com>
>
> FWIW sashiko says there's more?
>
> https://sashiko.dev/#/patchset/20260508001455.3137-1-joycathacker%40gmail=
.com

I will try to verify this and submit a fix if it could be reproduced.

Thanks.

