Return-Path: <stable+bounces-254497-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL8QC6abFmonnwcAu9opvQ
	(envelope-from <stable+bounces-254497-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D44415E060D
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 09:22:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E53F3027D89
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 07:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC083C3798;
	Wed, 27 May 2026 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kiGDWlL0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9944A2BE621
	for <stable@vger.kernel.org>; Wed, 27 May 2026 07:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779866519; cv=none; b=VRuEi2pqc7m8R3g556B++M7faA4oKUj/99ieaBQ7+vk/gg62twnR6CHzQdMB7ZzEZhDbsABEf+WJPMIMCJGcjqfHaf9K8Rik0tbcCnmR39139Ov/tiQfIAf6Z0eeyldK68sX5wMFxCIORQ7D4WnMxG7Gi2RW0u2cTJL8NNBJe0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779866519; c=relaxed/simple;
	bh=a8s7JtOphjdlMjvBprTXjUUvcfayNfid6SMNJ6WsphY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVW6cQbrxNKlWY63uAvJfdoJ/Af6NFm+P/pJswQuArfg7i14N9wxWgcYqCwGGjgr7iJ6M3OVjk+BSIJE4kKE0ifFW9LBKGFyiftkY39YMd6qiDYSiCmqcuNSQSvDiZG2fZ9bRk/sMXYWbp223x1KiWVAbz5W07+x0hEo127i65I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kiGDWlL0; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c855599a77aso116770a12.0
        for <stable@vger.kernel.org>; Wed, 27 May 2026 00:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1779866517; x=1780471317; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SbeQ0cOV/xX8qRCoZ0tY0TlvEmEpG2Jpa9wLZjTTDgQ=;
        b=kiGDWlL0Mw806Fe952FxMerCCBA69LXrFLx5lZqxVieDf7NuLGuSZ3EOzf74UHPFas
         NbObQ/BhaPN+PEi6JykiCRWLa08Ahve75Nwx8bHc6Hc1J9mhOn6NBAWLzMB/uUyGK2aM
         Si+hMj9tvtNkbVxiNpXFGgIlEnb5v5VUzHXv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779866517; x=1780471317;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SbeQ0cOV/xX8qRCoZ0tY0TlvEmEpG2Jpa9wLZjTTDgQ=;
        b=dnAOzcI7fj+hH7tTTxjnnZR4bRPk5efvONwe5kMoNqLZOiGe9r/u/GrRNjs1VXrpbN
         e6WhltWWGY3e3tTvdDlrOPSEvMjCOMD4vg5PdxygNKathB+JvnD7aEP5AaHLCXb7ou5J
         dVSzRJUrpuYUhoV/hu9k0slIpSJoy2uB+ywh1YJ4faMB/hKTXFzD641xSeVfkQH4HEL7
         /Gh41Z6Viu5m1Rz8rnrlcXGqXvvjwnAUJnO+4RVKh4KdltUKg7mLIeKWk7+yExMvIcqd
         M45X4EzAtXy98ftB/JJxDq79Bhgut2lf3H8Ynqsc9GwsFdvLJMs+7yTb6g3IS1PZY9DY
         il9g==
X-Forwarded-Encrypted: i=1; AFNElJ+i2/sQVea1LKZQA+cLfpuy4u1/oIW5qw/rMuLVfipnS2RwVuKfhcQxRoX+h3v7PCsIE5n7wks=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCBXwoCetOKrKvnhoVWkhtOUco0CoflHFMPUf2A85C7Jhfk85r
	iQSld+UHXCvPMzVFFEpZ+kGSo5190CTh+IwsKbFe7+pQBP3+t9PFIWSXq4p7aGRqBA==
X-Gm-Gg: Acq92OHpAgrbO1sRSPYpH8yj5VTMTKYHI5NsMyqg4etLAp9E7Z9T2mKq2+b3Zo5mg0o
	inbCzrZ24IqatGbtCYlGPkF00RnlGnvXTOtxN7qDZEuGu2kYTPQ089LJtj53GBwvYDPCIyDgJFm
	yrhjtRdfOtBDKrBWvIoIyuOcj5uR2kYhH4Mc2naDiPLz012Er81gWgqhKPYPQRibzjoYDSc+GAp
	9FHkmm6pwjMJx77K2NLXQFHs6ue8hrVAgxSwjt9SlLT24UPVX4+0h5EeOtoLNCc+ko5ES7OpML3
	YJYphes3a9ZRZAgy237giPIfVgMYDPyFylwwg5brBgUsJ05emNnp+9iukEwlpMkTR8/qnwwnPyk
	fBkzAlWIkRD8aMJYlvV4/jWgIUrR9W/k9nfUz9X8mksucYnGlSBGNT3jwv6j28PGrd6xaDDh51o
	J89cHWSsLrGSEnn/6THW0cmHzHfnwdiGws4QmSE8ccqmBlXba4ATDfGpuvY1+hE34=
X-Received: by 2002:a05:6a00:a383:b0:82f:21ee:270e with SMTP id d2e1a72fcca58-8415f6d0bb4mr21703648b3a.42.1779866517012;
        Wed, 27 May 2026 00:21:57 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:140f:40ed:a6bd:f680])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70bf92asm1369996b3a.31.2026.05.27.00.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 00:21:56 -0700 (PDT)
Date: Wed, 27 May 2026 16:21:53 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Cunlong Li <shenxiaogll@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Jens Axboe <axboe@kernel.dk>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 0/2] zram: fix UAF in zram_bvec_write_partial() and
 drop dead bio plumbing
Message-ID: <ahabSU6QcGJ4T4ZP@google.com>
References: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260527-zram-v2-0-2fb84b054b5c@gmail.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[chromium.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254497-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,chromium.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D44415E060D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On (26/05/27 12:49), Cunlong Li wrote:
> Patch 1 fixes a use-after-free in zram_bvec_write_partial() that
> happens on PAGE_SIZE > 4K configurations when a partial write hits a
> ZRAM_WB slot.
> 
> Patch 2 is a follow-up cleanup that drops the now-unused bio parameter
> from zram_bvec_write_partial() and zram_bvec_write(), no functional
> change.

Did you test it?

Looks reasonable (unless I'm missing something):
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

