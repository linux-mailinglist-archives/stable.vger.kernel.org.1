Return-Path: <stable+bounces-231213-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AfDENNzymlQ9AUAu9opvQ
	(envelope-from <stable+bounces-231213-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:00:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728735B883
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 15:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 74FD2304AAEF
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 12:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27E343C343F;
	Mon, 30 Mar 2026 12:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZkCBOjc"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7285530DECC
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774875186; cv=pass; b=KlsqXb+SleHBLt+9dLzpaaqn84IM85BhiOZ6RuW6d0SfcJpqOfXeGnCvpFtrNmZf8xRnpI8e0OfZxgkMvRJ1jLRloVCnpaba17B8amYMyi/moMuuNWKBllUsfVkwh5WySwS2RzgSdVB+1N5GTZByTF6AS50q5exWd4vLjRMJDz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774875186; c=relaxed/simple;
	bh=Xgpxd6LjVeMvdHSSdA9xJHFscqyTnj+wVUgxFWYPiWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QMSy+1fWcXxLnk+lKBm6Dwh6TxL17oHy2jAiOHklm43KenBMS3xLfbaG8l23BHYEUubouMW7eBG/dphHc0M8JqPzQX2iRoXnRCaxnkJDkbCDFeqnkNRO1NpsWbhpUDsqtYxK+X5PN8xuUGcdm+oMZOuEsLAMQJ+AbDed5QcrHAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZkCBOjc; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-66bf6aa4858so1118329a12.2
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 05:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774875184; cv=none;
        d=google.com; s=arc-20240605;
        b=Cn3WzEwL2Ut5jZ6VjDaXtuYN82oHCqROHTXG0u+gMBdbJPUQL9jn21b+XcN40Md4Wq
         SYId8Ro+yH+f2I9cNGvf3prqi6fTLzh7V0rxYQ8nGT0TpJEMjcsXDZC0MZ93oFG03m4u
         +NHB40fyNP3NkNjcG3o+XNmEbcCKh8tSXF7gMeSUqopFF3Xv4Bga9RSTt589nxP7l/aF
         U6tjEOm7SDBXVWyu+pZ9hBQimeXO9Tn0bR3Op60d0sQLPf/X42PZmtpkarLrpsOmpOR3
         kr7EWBajiaxCBIB1NFLb02hlD7USK59bhn5bkLy69QKKqeIhaIEEWr0nXiBZRoEqNPp6
         i/Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=62XzECu+t3sRPm0u5HYhE3GP4DOkf8lXqjYsf1ADUNc=;
        fh=R6zpyIv4Ww4Seq+pDxJCycSlBigFuJ1Mi6vPS0rrwbU=;
        b=YcUh36cVx61AKDwclJ8KdtzBP8zgMQR99T4uyc+NlJcQEiZbCF7AB2GJw5NErL9v8B
         KCdnKB08dmMwwaVjYt/ejLVz+VM46yzzVsiPBELl5kMKKR/MuQfRju2S6oCKwGJzdOv3
         oNlCjNASMpbn+pVlXBe9Janhu2/y71MAqdaX4JpLnIM7aQ9Lv/3IDlSNiIe5xp7C+LYt
         I6XPhrRvyVhESXhhoYSFEmWYR4m8VdTP31gareGkJv1ZUtFCemuxJllYYwfWs/aU/rb/
         pIpbn6vchsr6My2ANoe/K/hGsg8R3bJAWkAAQCJdUWNGsypPlNLsMJHt15iRK1jn0NfN
         hpNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774875184; x=1775479984; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=62XzECu+t3sRPm0u5HYhE3GP4DOkf8lXqjYsf1ADUNc=;
        b=VZkCBOjc8k1L3Wt68hILEYfJ0x3jjwYgFOtyxQnxVgAlOAK8oKS5TE8eCJ0qcus9DB
         UZtRIVRX6WhekTPt6tgm29mUDbnNI8NunydYcmp5TEjZbtm1JID5IeoSpOQHX+uUhbaJ
         PLx6pKntOKdNuIFcIQo9yh4iIFwz65Wb9X22FM38Rr6TRMBgMFc+J3J3gQNfHiZ2pZD8
         KdnZ75nY1PEFpeVAYFt8axGv0qMPqbg4iGG6UwlYqAqJC6nle1Xdw5YasAQF7B0RTn73
         QiyS4jykXQk5fQUCAOYy384tHgHdF4mEuVbsbDQXqHCKRC19ChNHvy0xaeT8TamtfM95
         c/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774875184; x=1775479984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=62XzECu+t3sRPm0u5HYhE3GP4DOkf8lXqjYsf1ADUNc=;
        b=MwvoldjhWuWQMR044OnYrnmNWsXlaH3ni4Snkig58MLloLrxZuKgjJsocDXG2n6LlD
         5sUtrLktQr/+5wbaz+/yOk307afPmuTxBTdxDjmWhWEzy04r/JueTG7Diz+ArnhLo4xh
         ixEy0JzVqZCrXKw0jnFTEdQ637sYNCVGyJchA5KMo5Xm9IdpPmWesrof+Zf/9VEY+oad
         erf4177g1JQjbOKo8PlrOwBG0zOrPolmfH1rNQgkPlfkQxJbvuyzWBrFK+1QI7GWhgyI
         wR6H5Tiv7oQ/GJQh5d4WLWWLOhJSlL4ZLViG8qaC05esGBEE7Qa0AX+1JeqnmADK3o+S
         7WLQ==
X-Gm-Message-State: AOJu0YyM3ZxY+glfZ8WTAJV3By8YK7I9w58zWPGm0UJge+hvjZtmcBUo
	vxeNb5vKqg1QKOI6hcNSvzBYx+TLw9StCqvMeESR8rq0+z6EP52hArmk9Udt9MK8974cNwmK5pU
	HYvx6apzk1o8NSFy3+MXu0iLyd74Ez3itKZaQ
X-Gm-Gg: ATEYQzxpL+5jzC2kH+kKg2VgG8cl3JwqWb7WjZb0NjLLJviMqiW2+3TOKv3zLdMgTlw
	1A2+aTd0OR6ctWfWwTlqASHMV1rrkkaZuxKuK6WFz/wPiVSl7AToD4m2WC7rS7NLO5sg4tdYQfE
	i9KJiJeAf7oiadKj5ggYbUJC4LOMaT0ovemBB+21QaWdx1nlOVKBJeOgFRGiNO3fXGKWW1GkWqN
	wJPSDp+9AIFdYIP81hEUQGfhQkQiv9mVS0aMnwcdDf2fVN0tu57fudYbozw+EJNYNULcghn5/xJ
	UwQrhAfnRRv73RyJcFlgOXDg4qGwbpgUMhtG427b62epVEAoeBSKXA9jquRV81iaa3UGfOWPfg=
	=
X-Received: by 2002:a05:6402:3496:b0:66c:1cef:71d7 with SMTP id
 4fb4d7f45d1cf-66c1cef73ddmr354694a12.27.1774875183431; Mon, 30 Mar 2026
 05:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALynFi5UR5NUQLn8-rx66AoD72Qn0Chji_m+hVFrXL4cReNJ1A@mail.gmail.com>
 <2026033051-primate-headache-5bf9@gregkh>
In-Reply-To: <2026033051-primate-headache-5bf9@gregkh>
From: Kai Zen <kai.aizen.dev@gmail.com>
Date: Mon, 30 Mar 2026 15:52:37 +0300
X-Gm-Features: AQROBzBuUczw9DpMXCU9c7UDLfSG4ubI2YeYRzemiS3WlPndSqLNB8HDAnAoMYU
Message-ID: <CALynFi4Vbem2rjQh9uon2Te78wULDRqV-ApQK-efC4dhOMJC1w@mail.gmail.com>
Subject: Re: Subject: [PATCH net] tipc: fix UAF race in tipc_mon_peer_up/down/remove_peer
 vs bearer teardown
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kai Aizen <kai@snailsploit.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231213-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kaiaizendev@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 8728735B883
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Thanks for the pointer. I see my mistake =E2=80=94 I submitted the patch
directly to stable, but per the stable-kernel-rules, the patch needs
to go through mainline first (Option 1).

I'll resubmit the patch to netdev@vger.kernel.org for mainline
inclusion. The patch already has the appropriate Cc:
stable@vger.kernel.org and Fixes: tags, so once it's accepted upstream
it should be automatically queued for stable backport.

Apologies for the incorrect submission process.

Best,
Kai

On Mon, Mar 30, 2026 at 8:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Sun, Mar 29, 2026 at 11:23:49PM +0300, Kai Zen wrote:
> > CVE-2025-40280 fixed tipc_mon_reinit_self() accessing monitors[] from a
> > workqueue without RTNL.  That patch closed the workqueue path by adding
> > rtnl_lock() around the call.
> >
> > However, three additional functions in the same subsystem access
> > tipc_net->monitors[] from softirq context with no RCU protection at all=
:
> >
> >   tipc_mon_peer_up()      - called from tipc_node_write_unlock()
> >   tipc_mon_peer_down()    - called from tipc_node_write_unlock()
> >   tipc_mon_remove_peer()  - called from tipc_node_link_down()
> >
> > These three are invoked from the packet receive path (tipc_rcv ->
> > tipc_node_write_unlock / tipc_node_link_down) and hold only the per-nod=
e
> > rwlock, not RTNL.
> >
> > Concurrently, bearer_disable() -- which always holds RTNL per its own
> > inline documentation -- calls tipc_mon_delete(), which:
> >
> >   1. acquires mon->lock
> >   2. sets tn->monitors[bearer_id] =3D NULL
> >   3. frees all peer entries
> >   4. releases mon->lock
> >   5. calls kfree(mon)                     <-- no synchronize_rcu()
> >
> > The race is structural: there is no shared lock between the data-path
> > reader (which reads monitors[id] then acquires mon->lock) and the
> > teardown path (which acquires mon->lock, NULLs the slot, then frees).
> > A softirq thread can read a non-NULL mon pointer, get preempted, and
> > resume after kfree(mon) has run on another CPU, then call
> > write_lock_bh(&mon->lock) on freed memory:
> >
> >   CPU 0 (softirq / tipc_rcv)            CPU 1 (RTNL / bearer_disable)
> >   tipc_mon_peer_up()
> >     mon =3D tipc_monitor(net, id)
> >     [mon is non-NULL]
> >                                          tipc_mon_delete()
> >                                            write_lock_bh(&mon->lock)
> >                                            tn->monitors[id] =3D NULL
> >                                            ...
> >                                            write_unlock_bh(&mon->lock)
> >                                            kfree(mon)
> >     write_lock_bh(&mon->lock)   <-- UAF
> >
> > The fix mirrors the existing bearer_list[] pattern in the same module:
> > convert monitors[] to __rcu, use rcu_assign_pointer() on creation,
> > RCU_INIT_POINTER() + synchronize_rcu() on deletion (before the kfree),
> > and the appropriate rcu_dereference_bh() vs rtnl_dereference() variant
> > at each read site depending on execution context.
> >
> > synchronize_rcu() in tipc_mon_delete() is placed after the
> > write_unlock_bh() and before timer_shutdown_sync() + kfree() to ensure
> > all softirq-context readers that already observed the old pointer have
> > completed before the memory is freed.
> >
> > Fixes: 35c55c9877f8 ("tipc: add neighbor monitoring framework")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Kai Aizen <kai.aizen.dev@gmail.com>
> > ---
> >  net/tipc/core.h    |  2 +-
> >  net/tipc/monitor.c | 51 ++++++++++++++++++++++++++++++++--------------
> >  2 files changed, 37 insertions(+), 16 deletions(-)
>
> <formletter>
>
> This is not the correct way to submit patches for inclusion in the
> stable kernel tree.  Please read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.ht=
ml
> for how to do this properly.
>
> </formletter>

