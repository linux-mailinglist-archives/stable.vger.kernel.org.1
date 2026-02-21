Return-Path: <stable+bounces-217626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNwoNIxImWklSgMAu9opvQ
	(envelope-from <stable+bounces-217626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:54:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3013D16C3A4
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 06:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4303E302DF6B
	for <lists+stable@lfdr.de>; Sat, 21 Feb 2026 05:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BE6336EE9;
	Sat, 21 Feb 2026 05:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMb/Pou6"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08792336EC3
	for <stable@vger.kernel.org>; Sat, 21 Feb 2026 05:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771653256; cv=pass; b=dZn2pq7HB27eWg6t/qPGEcq0GxNoD1KkJBLZ8hZqIc++1JZ9fq1I6AizBFqV5u9mZDYOtk2zfv/yg14m6/qdLYHxUtnpDm3JCEcA+ho9b8CGAOc8vt7N8fXD8Qf17UBCQyGOeE53w42yBRTpqnvyRYpp/npQMZi+A26xlC4vKh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771653256; c=relaxed/simple;
	bh=YewRXrFUyaO5CstkA8Fo2NIN/yzDQQBaDZNBgTPd728=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdmWA9iCliLHgl8UFsvD80kNVJGzkPi3y1OcaJLGMh4DjHe2vJUo5O3486j6LUzGal3fvu5fmkWBj2K2QOlz5N71DR6pcn1pbRr9P8QvdnPKPKel3r3csEhABvi8Rn/iZTKzoXL1JE4B/hf0QR0jufQouyPj/tt42WLLtbRPz1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMb/Pou6; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b885e8c6727so499138166b.1
        for <stable@vger.kernel.org>; Fri, 20 Feb 2026 21:54:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771653253; cv=none;
        d=google.com; s=arc-20240605;
        b=QsBm9W6eQ8TZdNyKutbq28HtpqdqZ5c9AtdtkNSP1B0SZIpP1oExRHbmf4XwMIH90D
         u9Swzl4VhmGuXnWTBA5kkFtfCt0MESKjowKS+7eJE3uvxx+Gx/Qr3qhWAvwits+XnTac
         8KSxu2y6z37FZwVCGyDCGlOuQOpfVEVXta//vDqDZ6lD++QFMh7QYylUoa3FgfgUWp1g
         4KcU4QtgftsiueHwN77qdoxSlpdoW5ICVVBzBbva7i4EzTdlm3q/117ovIJOKQyghDQm
         TInVMx4VEoCzPMfp8ewY/KTH58Owdy39Lcbcf08Gj15XVcOIumbLkHwJZeVce3hnmr67
         jwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+tgY/mGK3l60LP3OprA602wtr51m0b3f7apbXmR/PtQ=;
        fh=iLryWfP5D+1yWWR82cy56fWpQuLvIOi2LdE+FlaUCEY=;
        b=TXO4d6J7EFVKIOEjJ4EsnRC+9m++Lz5lhFL37Gl70rlPPjHJ5tThJydK5XfZ6YWgs6
         wmVtZQbPT7L85VijkMWqPEUTOnm+w47BzgpMNg7h3Kz8N45zw/MN0jYojtba3pvSSh6W
         JrAMi38BXEzxC8wMwEDmMj34fohZCKKVnnpeUe9f4ByQt0y8IXhCl+xMOfv3TT2rlxgF
         zIjylQuYW1cuuExELI/TFU6UpBLYw+IbSYWcTHWlqp1i6qeG1Qlix+/DXxyNdtcRcCq1
         0QUDrHjUC0EVE/d9lbKtsDniOpc4+nq14uAtuawQJCbrxDRBlmBJW+1VHa9xNFSead99
         tZ8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771653253; x=1772258053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tgY/mGK3l60LP3OprA602wtr51m0b3f7apbXmR/PtQ=;
        b=nMb/Pou6swwkk/M08/XJNwEc0U1aUYUGE0DOYLrHdyY8pJ6EHIGMNnJbKa/KeUyJQT
         I31tPt5ocVqorTC1VNkKKrsu7IHaFQYN+ulGzi255SdyiHy97Hw4tSNNhbXQ2yaryu2V
         7up49sKi3RxzkfFnE/OwkeH7Ne6BRrhqjg2DPfGUcF010bD/sQyDrnIFZty/it5cn0cm
         gU38E2/VvHnzIyyT6q9rcMTEjIDAoIFDod0YKP/TDIzwPtzGYqoHogrew2zKP+m4egf/
         0fF1qAYlKfux0RE6SE/DE/CnTgNfvqoOvljgZk87o577qUum4x+g9X358tAgZ5Y0QcSf
         D9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771653253; x=1772258053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+tgY/mGK3l60LP3OprA602wtr51m0b3f7apbXmR/PtQ=;
        b=wXI5rjPstrWRtrQw4yrqOwK9iTzGlHKPOo2IqD0MnxfgqC3JdOXmuyqXJ+Y94RQBCM
         6wM27HMMNs3dOwnhMzv9TYnHK6HJqrLWzyoQyKmmE9lHxi+K1OoylS/BLn0aaZH0ikAz
         YX9GfQGPmCeQPlRPaARWAgwjLbdakUJDZVKnVxvEJRRZdIhD9A565GTLBdB42CkpzH4H
         vPE+Uh3zx7CrtqurIEu/abgJnkp2z2ZnBYTlgnIItMgYliqfMVhk5aLSksI/CEQ63XZW
         ZMHU6+4DLSbK+Pd1xURtl9ZZI+nji6aFj+uJd/gOjyfxIeMYlQ8rdMFB/gJrZnJqkK6h
         mLJg==
X-Gm-Message-State: AOJu0Yzq+xQpHeEjKEFRIlYTBH2uKeDFpqP4ZUS72xUULty9YK83TWo8
	bzpYbxo9rLOuTIdOsFt89JJIsJTNOhts8n5HmqtJbqqGM74hf1sp0XB6MUqtZxlV5WbaOVMpa0e
	QSU+Z4aqp3yU40RHgyyd5BUVJBvFchDo=
X-Gm-Gg: AZuq6aItU+vNUuVPHQZ5CgHknzfuhFf3RzHuBuz0kNn/c6YCRpFc7hFFlic1TWFKeyv
	xdG2oAQ5rnfsqQPLeXKhuGUkvJE7CtApidkzk163qKas7I7fv1ne19ixqRIQ2hEhLW5AhUwm8/z
	mndMBnUEJQ0TWcU1JTtKI1MPryWnxyERZGNYrncPDs1n387TUU/xYACoBgW2zFNEe7AjvQKKyd5
	rWST8njnd62xINJXCAVOJeiP4B09tEboH0FDSXIPmw0528ivqBpqGxQGUidwGZGvjIkh4qvvp6l
	jjcmw4aBc8kJy7Uvj33JTSJGLmqYvS30iw4VJacPq1UE9OP3uWUe1V5lRxv8vYgaMO3bCjsR11B
	0MOeNFQ==
X-Received: by 2002:a17:907:728e:b0:b8a:e013:9c5b with SMTP id
 a640c23a62f3a-b9080ec254fmr125502166b.4.1771653253038; Fri, 20 Feb 2026
 21:54:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260221034402.69537-1-rosenp@gmail.com> <20260221034402.69537-2-rosenp@gmail.com>
 <2026022132-gem-stylishly-2c49@gregkh>
In-Reply-To: <2026022132-gem-stylishly-2c49@gregkh>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 20 Feb 2026 21:54:02 -0800
X-Gm-Features: AaiRm51WLD1sxY9MNhXBFSAsYS9PctRSAkLeekgnCI2YpU7VawQg_l6hW2FQy2s
Message-ID: <CAKxU2N8g+BRzyZ=5dWjrL3Eb4zRz-_yfv29tfJL2uvJpZWZUcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Revert "drm/amd/pm: Disable MCLK switching on SI at
 high pixel clocks"
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Kenneth Feng <kenneth.feng@amd.com>, 
	Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	"open list:AMD POWERPLAY AND SWSMU" <amd-gfx@lists.freedesktop.org>, 
	"open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217626-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,amd.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 3013D16C3A4
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 9:40=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Feb 20, 2026 at 07:44:01PM -0800, Rosen Penev wrote:
> > This reverts commit d033e8cf4e8f6395102cdbc3cb00dc7cb9542f53.
>
> Why?  You need to explain why you do something, not just what you are
> doing.
Not sure how to specify that it's a requirement for the second patch
so that git revert works without problems.
>
> And this is a 6.12.59 commit, explain, in detail why you aren't wanting
> it reverted anywhere else INCLUDING upstream.
>
> thanks,
>
> greg k-h

