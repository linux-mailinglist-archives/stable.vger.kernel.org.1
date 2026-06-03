Return-Path: <stable+bounces-260184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id layxGcl9IGoQ4QAAu9opvQ
	(envelope-from <stable+bounces-260184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 21:17:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BC75C63AC97
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 21:17:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=jfCgoD20;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260184-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260184-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A344A3068FE1
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 19:15:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F6648A2A1;
	Wed,  3 Jun 2026 19:15:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C3481FBB
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 19:15:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780514107; cv=pass; b=mhbzIqo9I69E/MJHuG1obwHXLpFWhfS9F9XHRFixuvuP4GFwsxfK2Z/QIJsyHwLymtW9xEACZDKWrDIyriPp4If0QGMANtMEgdCU5N3GB720Phj7GvIokaP+riKldUx3o8mStJqBJ76mIiaLmSozVFOfNwp/WNzVI3iX2MR/Njs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780514107; c=relaxed/simple;
	bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSZ+8X9daf4BSwX9LoqbPLiyb1FGfWIJ5TCLha00Q0BPG0z+6bmomMYX6ef4E8fbaAREL+R4+/BZhjaDTDzOIT9P7GALY4jAfcsgxUgu3W+ISDVAr1tO0pkaoJKlq05447qYOfP/Gzp23DC8doB/mE/NCWEjuXilLP4mfmcgMIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jfCgoD20; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-68ced08613aso2183a12.0
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 12:15:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780514104; cv=none;
        d=google.com; s=arc-20240605;
        b=hXtnb2MRKoBvASOhSkuHnWgVcqzzNIdfsxtv7DgRK/U5Wy0N3P86SjfenHywxXXqzr
         weDsurN4pATMYKflt4xQuMiAg4AOE0cElyCg0ZKw8i0fXywOvIG4CcENKJtyAa3gh5E5
         bcWLN53gjJLll8pIbud4tK+YgiAu5XJLUJnVvPx7YOOS+jbnJRp4nZXL4OuKUPkSY8RL
         HHaJrbsiLqi2UB6Khc3eWO5fyQwHZWJ7TsCNaYOSHa5JN+1+CJsKODY0Uhz/eE1a7OiB
         w9vnKksuUOxv8+sG5WLXnzyuUp6q/WA+VxDUChY8Kc8athGJPcGkIXiCdlvrw35ywC8S
         JCRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        fh=/is+38VExpn2ped9rTqOaazuCZSUDxStOJM3tJHbevU=;
        b=hm2wWSVFwb//JQnzTwMx76cA3jeIFZ6HIWDH+CXrhG4NQCIcuoViN8yIGF65rcxjSX
         CKDs0WnN3md5mgRVVoa7e7Jn+Pu6pi0lc76J3R1kYNqBgFnPwY3W0frb0NrRzdoU6pwz
         eXDE5YC7d3XSer69uIyYHRg+1sIZNp6brDsN0oxqwO83oRiYzpalNQxxggJ7CNjPz1rO
         nk51vgYO+CMghLN70IGcFxVYeRFLiuC7X88Kj4ECay4VI2jqeBgNGIkooSa8o69QcTnQ
         tGWPwQbndlFLW3uNUq4I++weMbl7KHirUmF+8jozi9d5UAbsRbETbvVC4ewqr8WDDmP9
         FJog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780514104; x=1781118904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        b=jfCgoD20x0qu8FZprg93X9hh0T1PTypoAvgZBKJeink+mL18zBqEY2pmwVerCEJwsl
         GkyNgfsCPofojIJhn5Vd3Vk2Pk/J9HMcfJpABhiw6yoEAyK+q4dApFG4OIn0bqfECNyQ
         2oJZbCI9bmLnfOblCoqW15O4RUQ6Vhwd4Z/505wVP/FxtDmKGW+oXozWxRwWxYpMpb04
         5o03yP6rSexzL0vFgJZNBAY+fEm863IlApogxPgsRsNc5tZb8Uj1bsAUr12J+EZuNS+6
         ppnBooS/9tfJ3kDEPidU5nkDnrnLpKoSXs9FIcgPYlHQPwkg58N1spmmlbQS5DXFnpsU
         Pe/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780514104; x=1781118904;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60oYmwJGC5Tx6z0G3fsCQIEvwp54Q9uaEUQlNjxCn+s=;
        b=BG8vc6SZ2kC2C1bX6KwZvmFe+kIMF1q6MVlDJvrnwLo+5OGOldLxoE+9OjrE2SLS6a
         uq8oUDjRJ7MPZR8lhR06ovyyUVaxwOfLY5Bys+fbcW1qWW9IpjPGTF13l+S869H/Knmf
         xbqOYT2HxO00UGNPzq6I0+5AuOIK/oFy6BRDJZOftyKU8l1R4bTCGEZ0TdYi42Poe+6m
         JWpyHlj36OYxxDSQb0r3Vqz95QgOmBSX0dBzZq3NgYantNHgdpPZQM8H9mx5TWhDpAs0
         hd4c8iUo4sSv777XyGBCGb7DDfjmxQhNXkPFvlJbHgRqoUf8EY4STVPJvtHzIl5rOXkQ
         6ezQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ki78lGpXSjEEqGGsCRRegiEpXmJKqLwNhl49oI7v3IAzDn+M/XlX8mEhuUt7Y7kzSOX5wKEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQL3ni+udVFZD5TkkxJ0yUXSoIqlWOEeQnCllCW4B8OqjT4qNM
	pbJaNnnPQV8yiPPESrb7yE1J3ixaHWr2XpModPXrzvjCXDeDo2txJ2++L6l81pVia8OtSvtwY/Z
	jg2FcklTUMDFkRJmXY5XmwqHm3Hbb4YvTgtvbomZN
X-Gm-Gg: Acq92OGh93KcQFbfQ9Y9ibgIaSOejQuTvSG8eEHQeRt+2JnAAolcd2YjuQQJpVjOq57
	AjWCcBJ6YDW28pFcD2DkfdiLSD0Vhoy/8lEEkoJ5E3EpBsz2Mcy374Wq+iamn3bJugXEaUy8MVM
	e8ZKfOiBHSOfm28Y469cD36zoLWwIWi7IRCyFMX1Q3SOCNbhhA5w6v/E0EL0Sm7f0W3O2NS6JDm
	VbWIcplgwzqNGf/A8myo/56FVszhsLcp9N2O3GCvZP12JxHat07PX7exHye8nuA0a/CGwTru+rT
	rKc+mkdd4dFx7gjunG5vxC0qu1MuM3E7G6nrvxSfMq+qTxvn
X-Received: by 2002:a05:6402:a2c5:10b0:67b:7d05:60b8 with SMTP id
 4fb4d7f45d1cf-68f129a2317mr14728a12.10.1780514103934; Wed, 03 Jun 2026
 12:15:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603-vfs-fhandle-uaf-fix-v1-1-ff64ee367e4d@google.com>
 <20260603181523.GW2636677@ZenIV> <20260603182454.GX2636677@ZenIV>
 <CAG48ez0Jte3UE8wn9Ljs3o2uVDFB24Zbp9zBdaj+D5c4R0+TSQ@mail.gmail.com>
 <20260603185324.GA2636677@ZenIV> <20260603190225.GB2636677@ZenIV> <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
In-Reply-To: <CAG48ez34NaE5DCdC=VQWFRPds6JHwGq2YJDF5e6XUtGPNfQq+g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:14:25 +0200
X-Gm-Features: AVHnY4Jw9NWOm2jCBllhmHRKUG5CK3R17Tf93bIq0FGTh8la-bdsWtIarmCo4Tk
Message-ID: <CAG48ez2kK2dB4Tva0aNdWphV6BS021A4bf6a_cu_yOEJ8Uy=PQ@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260184-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BC75C63AC97

On Wed, Jun 3, 2026 at 9:08=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
> (And there's also that weird detail of how, for anonymous namespaces,
> the active refcount isn't used and AFAICS never actually drops to
> zero...)

(Er, nevermind, I missed that anonymous namespaces just have their
active refcount set to 0 from the start already.)

