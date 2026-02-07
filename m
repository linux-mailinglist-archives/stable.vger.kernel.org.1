Return-Path: <stable+bounces-214788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IWxmDURUh2kRWwQAu9opvQ
	(envelope-from <stable+bounces-214788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:03:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9681064A2
	for <lists+stable@lfdr.de>; Sat, 07 Feb 2026 16:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 604173004625
	for <lists+stable@lfdr.de>; Sat,  7 Feb 2026 15:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4A6352925;
	Sat,  7 Feb 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PgNUYZjw"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F03189BB0
	for <stable@vger.kernel.org>; Sat,  7 Feb 2026 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476606; cv=pass; b=Gxy1O/d25zM6EKuexMW3I+LFDA1v6EeAjcNttvB1obOqjpODIPGO39CHTI9WjI6nQ0IATV9lg5VD1nvhckMilUS31qr0crKF9N9p2pmAT7lNEcvgqs/GQ4SpyNOOFv7BCDmhgvHlvO2wjhpnBl85/kEkH2qxC7sqnXNm3lq2fxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476606; c=relaxed/simple;
	bh=V6Ss5XpsjKoGOf9rRrMSZvZipghpLxZFw4pS4gJWW8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WikOVn3StEFh9MNMqRvkYqNrlmSa1hHqgj0iFnsnLF99Y72miCS4FGW+hCFML5WR7VONf1zCZkdsQCHs7MCxam6iQujfQOA0jblS9pUImfW9WnXTwEdgl8Rn6gE6MA+t0mEZoXSbQ5nxiu89hh6pCSGWAN+/2cM/G1imLXhwyvE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PgNUYZjw; arc=pass smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d148dd3421so603657a34.0
        for <stable@vger.kernel.org>; Sat, 07 Feb 2026 07:03:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770476604; cv=none;
        d=google.com; s=arc-20240605;
        b=MkQstIpuXLloxT9KRBsF9vUnYX3DDB2eA7m3bRk2v7lz9kVi64ZPdwzItgDCLG9fgS
         mkkqnFx/ZkI7s2/dGor8I8rC6sGRQkKWp8zXgb7gK+wJlKTgsNzYBlDv3RUnDXawI7p0
         5i1mgolz9D9HIFCWkl4/qf5tHTsBjHI8the/pCy20McVBSOwTBK1aN5H8WsKPxzXal1l
         8Fv5MSPkEyBdXrWjip+4zXrpGKx3VEqtzK/81DPqpvXVaBy6n8G8M4VQt2IDwfIUjRPQ
         XDCNJnvEhQlurQIyTkf3coCpOI3sND8DhGo6BL/973CYTG1NHsS70cTcbc5RWOX6qhOk
         BfgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V6Ss5XpsjKoGOf9rRrMSZvZipghpLxZFw4pS4gJWW8c=;
        fh=HazZrGa7a3hvrY4ihViZlm5wgBkuheHSaXnBC/FOsxQ=;
        b=WakOUSs6NYf4gkszJhV3T25Es9XwMPOFT6NKL5m+p49vOltpAXNaXGY05vbJDdQC9O
         Ir511iodUhnwPJl6iOnUd269n5wAsFFv54FIZKEU4lxOlWcQSpkvfGHTRIEagfYYVYJx
         D+awhY+JN415ooP+eq3zKufh1Ad0zugg++wGz3BXrDgKpFYTvhPZXtNB4zltq0ECNMD9
         s/DtDR4ar2996dV2u+8mWIjOqQPLgshOuXD9lDVsKpLNHzfY2EHUlAYft4AGi7yJ2Rxv
         kvw//8KKOOPcdOPT31/xvEIVQ+gqTvFeD00z2P3BekI8S9qyt6MdUvhC+XdtxNapmh3R
         oU7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770476604; x=1771081404; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6Ss5XpsjKoGOf9rRrMSZvZipghpLxZFw4pS4gJWW8c=;
        b=PgNUYZjwQxAIX+2lpoYdpYLzRdwNT3TxNzcqSHUJAMYHKGT+E8mkkoOLA9lktJlkOA
         mkPGxBRNjx1lyoOayoQyPLb4XNJg/csNIrbA9AMqxY4TZyqFhWUjfZ/k22o95LngZXIm
         JafB8o5ItsuygurgVW1t5b3nddOpZkfKs8yXxqzpqyMchIOvyBDxk7dKCVqu2UhNf5OU
         9Me8K3HF4VR5TGJKYXFHEdyhJ2ul3Q2arif6Y64DPs0MlMlJpGs/3eGiqPPAKPiI3V1z
         Hc27FhjOeKkruBZOqu5ro6+0IbgJj2/DuLbK3++BV07HTgHp2TQFywewjkrXJP/wgj9m
         avqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770476604; x=1771081404;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=V6Ss5XpsjKoGOf9rRrMSZvZipghpLxZFw4pS4gJWW8c=;
        b=koBj1YnO65vYPbMa3rj15+kAZrEd1ktvvvkrCxVfW8d0OHiGdguFB+YRhvMNuGj9qI
         M11rkBFB/MQ8rC2G453lIp1M/0N21zMar/rndlB+jCtaeGIQGNmfeOoNGgEurI0feiFx
         naumUrW2LuAV8j6VfJ/Obfga7QPO1miZZE3YEAHPnGq62/zswruSzKy7UqthxrZUNkVM
         ud0RoL9VbzsokARyj8rXm4l4G6NC7D9OQNyMW+tLFphPFgtZLAPxRQYqMrAzVVC2jdbp
         pNAB0lFmg3OakGLTJ7cCaxBKN3GQfSMDF7bBwec6pqK7saLqJcg/7381Vg0kpOQ0SLZZ
         n22Q==
X-Forwarded-Encrypted: i=1; AJvYcCWAO22fpRYOUREpjnHFpjayS3T+3SmSy2lIJRQ7EODD1EdfeWxwxVPN+2GwUEWLinnadHHftD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsBuEpxfsocaeZLL+Jr0db59BhpLeO6GIuIY5pdhhgliMQRzsX
	DvkvhplzULrQVDDBEjJH9mkIfm62C6/YEdF5LgiPMpe1XiRFostv06LmshSus9VJhqiPYk9Rtpa
	HzUVZ0j91FtSAxQZn9jx6zDjE497UPto=
X-Gm-Gg: AZuq6aIEJxrzgBMf6YJoL0bb7Si05LOCji7rd8V/YpUekb2KidpBWnUdKLlGHWMrMxV
	/GieqRbrdFKIJ++nCLX1R71/0b7TUDiUxIWNSpGgsXcrZ+evrRlXdUpFOQxW5E0LK3gm0EFyb3T
	+2PTjgforCxoW4I7ThzwdmPJCmRocgXA9gH2beZMs83F0gFgIjzkhjzdyJXBFnvZ2I3dtc15tvu
	uisEM8Gk8eAB8PRSe+dvRhiKwImDVxiNFAGTrfkiOcvmVWNrvNaQWHuGbyHemYD4NWlU9dGPw==
X-Received: by 2002:a05:6830:4885:b0:7d1:9195:a83e with SMTP id
 46e09a7af769-7d4644176c7mr3390186a34.12.1770476604387; Sat, 07 Feb 2026
 07:03:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCs03XcXt5GDae7d74ynC6P6G2gLw3ZrwAYvSQ3PwP0mGXA@mail.gmail.com>
 <20260206174017.128673-1-mikhail.v.gavrilov@gmail.com> <3BB6BA1D-3756-4FC6-B00D-79DF49D75C51@nvidia.com>
 <CABXGCsOMzrQTsByYraNby_MXnTuYBNt2vbWu65KCGX6bmi11iQ@mail.gmail.com>
 <F36AF979-5BE3-4399-9420-F41A475EA87D@nvidia.com> <B6CDB0B7-CB9A-492E-90DA-F8D7E3B037E1@nvidia.com>
 <7C7CDFE7-914C-46CE-A127-B7D34304C166@nvidia.com> <4C3D8E3E-D9D6-4475-A122-FA0D930D7DAD@nvidia.com>
 <CABXGCsP2z6sbf_FYZjdxyLhfJZEaxz0_WrEeteS50GLyU=KQGA@mail.gmail.com>
 <CABXGCsNM8Oex-V3vFSUy3ftMw1fAweHZHQYzRHWU9M6gm7r-rw@mail.gmail.com>
 <FF3C3042-8265-40E8-8786-333A6F627405@nvidia.com> <AB3C1175-FF03-484E-AEB6-07BC93E49683@nvidia.com>
 <CABXGCsNyt6DB=SX9JWD=-WK_BiHhbXaCPNV-GOM8GskKJVAn_A@mail.gmail.com> <247E7FE9-E089-43D1-882B-81C7134C2FFE@nvidia.com>
In-Reply-To: <247E7FE9-E089-43D1-882B-81C7134C2FFE@nvidia.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Sat, 7 Feb 2026 20:03:11 +0500
X-Gm-Features: AZwV_QibOWsx0hvxPwoz0xT04dTclVaZRJpGZO3WzheOmzFRcEus6GsPC6hRFhs
Message-ID: <CABXGCsMx5xxxaqsLMHrRE=K2-QQ8AsYWbpo=eCf+PKBEGXSZXw@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: clear page->private in split_page() for
 tail pages
To: Zi Yan <ziy@nvidia.com>
Cc: linux-mm@kvack.org, akpm@linux-foundation.org, chrisl@kernel.org, 
	kasong@tencent.com, hughd@google.com, stable@vger.kernel.org, 
	David Hildenbrand <david@kernel.org>, surenb@google.com, Matthew Wilcox <willy@infradead.org>, 
	mhocko@suse.com, hannes@cmpxchg.org, jackmanb@google.com, vbabka@suse.cz, 
	Kairui Song <ryncsn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214788-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,tencent.com,google.com,vger.kernel.org,infradead.org,suse.com,cmpxchg.org,suse.cz,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3E9681064A2
X-Rspamd-Action: no action

On Sat, Feb 7, 2026 at 7:32=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> Thanks. As a fix, I think we could combine the two patches above into one=
 and remove
> the VM_WARN_ON_ONCE() or just send the second one without VM_WARN_ON_ONCE=
().
> I can send a separate patch later to fix all users that do not reset ->pr=
ivate
> and include VM_WARN_ON_ONCE().
>
> WDYT?
>

Makes sense. Ship the quiet fix first for stable, then add
VM_WARN_ON_ONCE separately to hunt down violators in mainline.
I'd vote for option 2 (just free_pages_prepare without VM_WARN) - it's
simpler and covers all cases.
Will your patch include a revert of the split_page() fix that's
already in mm-unstable, or should that be handled separately?

--=20
Best Regards,
Mike Gavrilov.

