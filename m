Return-Path: <stable+bounces-254598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yER/FOL9FmoJ0QcAu9opvQ
	(envelope-from <stable+bounces-254598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:21:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EED225E5C8E
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08A23008D2A
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 14:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0531A045;
	Wed, 27 May 2026 14:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln1fQQSF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DADF25782A
	for <stable@vger.kernel.org>; Wed, 27 May 2026 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779891367; cv=none; b=C6mmz7ce/zL7k9lb+4V3arcAJxw9eYDQ94IdSG2jBiNBXd3ZxGTyMYfnc2vkZbKpbBQCL0WkbZJ7PLvx9+EouVUYyuhATY8Lj6W2rHsnilxS2ZXz3dt04TO4cPsDdL8zCKfM3Cx6eZQOVFqNoUf1ZgzOF/dz8MBTU8oMq2DIFxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779891367; c=relaxed/simple;
	bh=rwIJZwdE0h/vGwpewVyInBfM50pssfa9h16XffX+lY0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=Lyb2wQZIX6h/mHTcNi7Au6CCLQSOpiOTmPVxWO/XSxIswvxN7tx+aSw7oNl6fjjJUjXMdonRB15u3AztZQho8lTMYFBEuMxCplz/xAWLVmYYRfk0jtUQjuCGTax4iZ4XFZcNK1M4/L+hKInKWIGMzuVlEjwQjTiI/5EzsflcXcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln1fQQSF; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2bea7176c72so50170375ad.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 07:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779891366; x=1780496166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GzVcryfU9QxZddocswZazrJnx5GUut5UQLQcVR/qt2o=;
        b=ln1fQQSFl0ff4QyEjpwc2jwX4jb5xohSdkYyhO7cskouo+sV6UtJ4uNasSNa+o9Uvi
         7/nGDdns10Pr00EBix2uEQMzAaGrickjx/OAiIgSIoQdaarZ1DvBBqihQcx0YSCR1SIa
         tXDwQFxsq6Gz/jWOluXHX+QRkpJz74rJP90S5AAPx0pGHb8LcRdGkDP3xoazP/YXmdGE
         +af1f4gGpfJEjLW9bmjG/+7MdQd+bHzhr2F5awNFQEML4IC3VuxqSIOUAqCjTbuwZIll
         XIPiW1n7SkUpLb84DHoSR6V9PiZ4u3/9PNvFGDnuiPaQZIkictcCqhRaip0zwLCifiIF
         fAPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779891366; x=1780496166;
        h=content-transfer-encoding:content-disposition:mime-version
         :mail-followup-to:references:in-reply-to:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzVcryfU9QxZddocswZazrJnx5GUut5UQLQcVR/qt2o=;
        b=IOV52DncnVi6rtvP/DH9SwHTFgkX3JjOCe+UWVNL6yctE7mxn5gJgrHK6mpfYDJy3X
         8Y1N6oOQEb91dHGRmgndPVlgEHdo1RxPvdcW691QPmMbheNq7xs9a2pfp5jSTBsH/geA
         P+nMhCuRkor5kEWnDasZ5tH+niYqHFyNvQRzJbWVjTIEHrzQ1m1AJF2JaZo1i7EJ6Bbg
         mYO8qFVp0jl4ctH/IF1Us3SgvFIuN6rO47BuQg0sCuW4fa8JQ1379TWaYwp9B/SM36M4
         51M5GA+7z7lCPRnTGoDTWEb/D33J+FsZHKyRcp2PG9Y1WEf5XFEGoKjh4wor8dVZ9er5
         9LsA==
X-Forwarded-Encrypted: i=1; AFNElJ9T2VI8VMhZhQdHiek6RqfVCFr0vtc/q4ny5HQ1J03BDU+p59ppy6x8xePPgeezgZflVcIcRbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjxJBjpbIJb8OMXEVTLLUVmmDD0QeL+0ynuDXiAZFrv6Js704C
	jUHQuUs0dcE/bgsQnLqrF5qVFtv+mTPJM02pVlFGuAq/MHXGO6UFv+mMyHegmzKP
X-Gm-Gg: Acq92OFUyS/LjcPcQH02Swwhre9qU8yo43x8nWaOQB87PB16NGsoj+4hNxfkDpjdAZD
	iHDp5r1r9v62D54Cklidpqmm6CFuyWb4Id/2FlOe/Fu4+7ZEFfAQDj7bajZPl4Yk5DGH0w/cesS
	Mo0xswhFoMvBwDBjj2/MWk77MRCBN227vC8O2fic7Ms5XzLNZiY6cqJp7OPRWL4AlXJD4quxzi7
	DHCHmQlYK95uzUjL0hRxNw+aEl82Oeay8Dix8Urxfn0P1QH2nkj2qA4ttK4UoTKP1lSVXoOMHJH
	5hpdR+MZeU0BbXmgV1m3J/1ggFN59EOyTu9lxb36Skp7h1HGBy6xAfcTbGtXJeXfVA6TwvGx8Ah
	G8vqX+tt5aODq1UF6u5a60rhY6vcuO80XxjqmHN8C7nnnbFXGjlBduDyJR1g78CEkzmEEoXogLq
	hFxnr98jIy5DxkzEvcRTSJ1cUBYxi7sGhRtunsQyg0o2Nspp8=
X-Received: by 2002:a17:902:d4d1:b0:2bd:a5f:1d04 with SMTP id d9443c01a7336-2beb05bf787mr246093385ad.9.1779891365968;
        Wed, 27 May 2026 07:16:05 -0700 (PDT)
Received: from localhost.localdomain ([116.80.91.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b3085sm154156885ad.53.2026.05.27.07.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 07:16:05 -0700 (PDT)
From: Cunlong Li <shenxiaogll@gmail.com>
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] zram: fix UAF in zram_bvec_write_partial() and drop dead bio plumbing
Date: Wed, 27 May 2026 22:15:59 +0800
Message-Id: <ahb8nzeug80MJ8Pw@debian>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <ahabSU6QcGJ4T4ZP@google.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com> <ahabSU6QcGJ4T4ZP@google.com>
Mail-Followup-To: Cunlong Li <shenxiaogll@gmail.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim <minchan@kernel.org>, Jens Axboe <axboe@kernel.dk>, Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254598-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shenxiaogll@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chromium.org:email]
X-Rspamd-Queue-Id: EED225E5C8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 04:21:53PM +0900, Sergey Senozhatsky wrote:
> On (26/05/27 12:49), Cunlong Li wrote:
> > Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
> > happens on PAGE_SIZE > 4K configurations when a partial write hits a
> > ZRAM_WB slot.
> > 
> > Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
> > from zram_bvec_write_partial() and zram_bvec_write(), no functional
> > change.
> 
> Did you test it?

Compile-tested only so far; I haven't had a chance to run a
PAGE_SIZE > 4K reproducer yet.

Thanks for the review.

> 
> Looks reasonable (unless I'm missing something):
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

