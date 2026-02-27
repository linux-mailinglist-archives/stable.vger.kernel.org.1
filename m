Return-Path: <stable+bounces-219982-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF0dEKXCoWkVwQQAu9opvQ
	(envelope-from <stable+bounces-219982-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:13:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE41BAA01
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 17:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CE46E30470D8
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 16:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AFE44B672;
	Fri, 27 Feb 2026 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="LfmMR7yW"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5CB3ED133
	for <stable@vger.kernel.org>; Fri, 27 Feb 2026 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772208356; cv=pass; b=VkpocK8teLtv8Nul+ooJ6bsn8LGP9l8FrtOteI41UYSvjdtbKVUFEpwEPVHFa9nXmUbdXvLP+L9RCc7V3/pz6HLfaJgG477wQgj/bCUpfdtYd+/cZRpST3IYjw5NPkIYB3sbWwnM+ykF2Cg48nouUvEpQzedbwJhJX9YQBdx1IU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772208356; c=relaxed/simple;
	bh=XWRFmApZo3EeyDOBlJmpjRgegzMqTxAsMi4wp2Eo1BI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UvFF6/v4uNiUhGLa2CuJ9BRFaCA7qfxE9+s6c+vII+n5RsX1/8ccsWdv96bZswDC4vrWOK1rXVNDBVOFz4mZ6JsEqQ/jVIK2Vt3EVabE/YjrjsybUsSnKsX+A8BF2YR7HBO6ei9pw6L9JqKQsRP5kg3y3vpJ/AUYZoRhFARZH9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=LfmMR7yW; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5069b3e0c66so45181681cf.1
        for <stable@vger.kernel.org>; Fri, 27 Feb 2026 08:05:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772208354; cv=none;
        d=google.com; s=arc-20240605;
        b=Zxuuw83U1t8d/1B3hDLaMVnqUpFvCeDFwkE/Q+s9/Gx6Q4e2LXSIVfWw51mcoRgAeZ
         5KE3QV1KG0R/h321aEc9jPHPh8fPS+Bi2fpB17PkbAXMW15GKE00S/PPmcynVnk8RpSR
         u1kKgS7QTEUaca749jl8Iy890gdxZlOztgoiYeOlYYjiNeI+a0ZRy0gTZjLSwMk+Gq56
         bIZghZEIqYG8JAppPZVXRtn4CoZCPO1i5VOSYmyiJUmWEGBLEJMcxQbG+dC15JpEmMbZ
         Hmpo6sckr2Fn+XtiuOR2KGFBr8Ns8DhrNkXDNbZ3JUgb8Hx+lYrMEfGmNmDQ4eAym/WS
         P6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        fh=7cxB6c0DLeZzP23+4VKFyzh0xK/0bdVywzMmZUoQ7Q4=;
        b=CeaddOXb264KgSlNpD838UmPtq0lRoXTnp44qXoJJ21xjAJHCy72+fhzEw1tSpoWeO
         SmcadKSpl2myhCUmNM/jSjcebZYVPQ26voHC9thPxE29xhMbJGjxu/GPkwM/mMRNt+Er
         +TXj5tfGqCusebRKysudJPFZ/dLbEQxS0Inu1MsED0oj3mlHX9ooD1hfRS3k8dY9Xq7F
         iXUFA42DbStHvbw6/OzKOeUUOosswrfjQDFs7aak111hJHmFuu/NiGFWXggIQ01AFb+l
         RJJjuVX3+IVxVgCIOwt4gFUdSqikm5hjlGeQcqe4K2wrquK2aQNNPFKjT3iVNfC2gb9b
         YAKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772208354; x=1772813154; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=LfmMR7yWSQDmoRuq8VMySSMb8MeEheV9tG0G8OqPmk/6sqF0avT6fPmX07OP7d6QPp
         R8LeZJN6zJ+aybdL6KzvIV4eRn/fXKAorfRYAC9Hg46GD7soHmbbqrWu9iCrPrF64Jjf
         /83il98BCG8P0YvthzYNAGxMDWz2f7wI/2dgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772208354; x=1772813154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=856KIRdxloXmGE2r36jtZze8d7am6/2KS375WxUkhdA=;
        b=GyQLuMRbM6bWQGkHOrFCg6EPVdFIedOZYt2qXgCAcJWrLDqb+FlC5t1YUxm3FBWJ3F
         njc+XDF2y9EYoW2cGrvZl3NtjS70L7gF66RyPy33jG3Nj0qsAGRfFhsOdRRtQgusplgN
         aYhK5vRe7m8pEMmsM7M2VKw0ubUJ2d6exl/WXtwx9AIVMvWgt+LP15neT9ZCPyDRZJvU
         8UYEGfI/KDX5gWmAluHIV2ClK77UWwMiOt7Jnd1DHRxTu/sPl2Hk2OYufSvOrT6haSTr
         pFY2+s8bis+k9TCz3wqvF0eych+j7h7hHx2b9HloOAKOWtDfFDj4Ixom2CQUdp7Znbg8
         xVsg==
X-Gm-Message-State: AOJu0Yz21hDZLO2ZOQgWFHI96QRkeiQd1Whl5G5dx3bRsldabakFQUhZ
	VcRm6RhscnS7Ph+awulgES4QktbShya7eAy8BesoG5gS9o1jAmExWs4ICkgNwt/UCsZRpobbwbt
	0AFQd7K0usiokRa9FIE5s5nypS4ibh72u8M+db93AuA==
X-Gm-Gg: ATEYQzw3EQJYvgpLAIJBOGm015gYCxk2V4cucdYgNdI0mcbuR2xm4HzdAP8vD/0Nufo
	tfYssO/UNjtEuptQtXNrdt+zjw4e0kKozTp1GAXkU5KirOnEA6cfri0WMg+ccFpnymVHwG4aOnM
	2xmneO7ltiBPBE/OSimYUrt3da8exzaVHWX9U5ZmArQmqwDdetegixNUhuO2XA3pEiLMIVxA3ix
	ekVLbgHMZKPL/D5IxLTR7d6cirCc/3edRv7w9zH52JBVvk6WXGPPiSyBZ8EyfJdNUfcQivf5hSK
	MwaPKg==
X-Received: by 2002:a05:622a:15c6:b0:506:a574:a98 with SMTP id
 d75a77b69052e-5075240cb43mr43969551cf.25.1772208352680; Fri, 27 Feb 2026
 08:05:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <177188733084.3935219.10400570136529869673.stgit@frogsfrogsfrogs> <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
In-Reply-To: <177188733154.3935219.17731267668265272256.stgit@frogsfrogsfrogs>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 27 Feb 2026 17:05:41 +0100
X-Gm-Features: AaiRm522nNR8quw6-QPApM41f6VxVhfe4lhaNvG1qaOhqP6WFi_K60TlVjnXPqk
Message-ID: <CAJfpegubENC3LxtG8MbO4OxUgD_Pd1GR9pw6Xcob_JiG+2cOFg@mail.gmail.com>
Subject: Re: [PATCH 2/5] fuse: quiet down complaints in fuse_conn_limit_write
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: stable@vger.kernel.org, joannelkoong@gmail.com, bpf@vger.kernel.org, 
	bernd@bsbernd.com, neal@gompa.dev, linux-fsdevel@vger.kernel.org, 
	linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,bsbernd.com,gompa.dev];
	TAGGED_FROM(0.00)[bounces-219982-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,szeredi.hu:dkim,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 90AE41BAA01
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 at 00:06, Darrick J. Wong <djwong@kernel.org> wrote:
>
> From: Darrick J. Wong <djwong@kernel.org>
>
> gcc 15 complains about an uninitialized variable val that is passed by
> reference into fuse_conn_limit_write:
>
>  control.c: In function =E2=80=98fuse_conn_congestion_threshold_write=E2=
=80=99:
>  include/asm-generic/rwonce.h:55:37: warning: =E2=80=98val=E2=80=99 may b=
e used uninitialized [-Wmaybe-uninitialized]
>     55 |         *(volatile typeof(x) *)&(x) =3D (val);                  =
          \
>        |         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>  include/asm-generic/rwonce.h:61:9: note: in expansion of macro =E2=80=98=
__WRITE_ONCE=E2=80=99
>     61 |         __WRITE_ONCE(x, val);                                   =
        \
>        |         ^~~~~~~~~~~~
>  control.c:178:9: note: in expansion of macro =E2=80=98WRITE_ONCE=E2=80=
=99
>    178 |         WRITE_ONCE(fc->congestion_threshold, val);
>        |         ^~~~~~~~~~
>  control.c:166:18: note: =E2=80=98val=E2=80=99 was declared here
>    166 |         unsigned val;
>        |                  ^~~
>
> Unfortunately there's enough macro spew involved in kstrtoul_from_user
> that I think gcc gives up on its analysis and sprays the above warning.
> AFAICT it's not actually a bug, but we could just zero-initialize the
> variable to enable using -Wmaybe-uninitialized to find real problems.
>
> Previously we would use some weird uninitialized_var annotation to quiet
> down the warnings, so clearly this code has been like this for quite
> some time.
>
> Cc: <stable@vger.kernel.org> # v5.9
> Fixes: 3f649ab728cda8 ("treewide: Remove uninitialized_var() usage")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Applied, thanks.

Miklos

