Return-Path: <stable+bounces-249601-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aObYD2JvDGpKhgUAu9opvQ
	(envelope-from <stable+bounces-249601-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:10:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF045804AD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 16:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 63E6530602AB
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 14:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DE63ED3D8;
	Tue, 19 May 2026 14:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="QY+14O3W"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EECA3403FF
	for <stable@vger.kernel.org>; Tue, 19 May 2026 14:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199679; cv=pass; b=q6ES2rNDMgS1PhtgSNmZSKyIH+6DyndC80pklU3Q6pcNl/RuKnRdqVTr/uwi/ewdcZog2pHC/9SxhBZFNYZ4JjpweBVCbFpZYusQojovYNN0gKXDnM3B9IXpk6mOcpc94229jNda3UDQBk23ZlEIDRKBS+SmvdsdDLW/GTmegQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199679; c=relaxed/simple;
	bh=VUN0slV2E/uvTpww7QVUeFC3SqCXZBlBGuW9mvpkZ/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B4CbqEdM9NyjDwYcyd9M3aIDiYxIJ4kCZcB6F8snG/Eim+LLO4qdoMWNCXxBw6OX1iQODK/weANefgIQ/malEqVN610Dj48VnvqgSB+GWeAa4HSeWH1G/C7h+ZkZXgaIXmXhCwOY2FuE/qPkB+ibFjSVXTDuY+YIspZ/YgMt2OM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=QY+14O3W; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5165195c8b0so43562461cf.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 07:07:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779199677; cv=none;
        d=google.com; s=arc-20240605;
        b=FKT8cMvKO63sQvgWnIYflMi0fmhN4IcUAnU99ttSD4xUJYM9bh3BN3nEJXpO5rFfT5
         Ys1jEZ0MMHYGH7KS4qIReliQZNtPQUl3jky9l2QJwVqD6jPWM99fRZ8HY66tQ1lridNc
         3ceczgEqQG+EaXXzWin2Hrvpzdg37t3i/hYC9KECWNGTvM6Ws4RYLJFVYO54RZ+vP/Lu
         aFAynqTK/mgWtVNRQLFILsR1zvOUxDFoZeuFQXLApa8daUuBeyxuv9QOJ9+Of6EW4LgS
         PSNQCEAKBqStEueGulkYmvc6YFR0EZZfPeuLLpG22Adjxpd1NcU8LImWJaCDJj/ohfqD
         rlnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jlvaaSf6hX71qoVaaZAiNP7dD67S54v9Ar0OEm1wY9U=;
        fh=kyxivFnzvuvu3BVdGAnRs953L2YejVkO/9LddWQrVi4=;
        b=jZ5U0gu9S4YvcX6Jk3PRzZQawXdurrxpyj3Cu8DTfJ6OzvGWmSvN+mt5XmZwpKunzB
         YsevuW8pM6ZjPqobeucG2kuAmGAJXPcELDnaaESqpHru6rVBLYmAjH68iqf7dzdTu/bf
         o7hR0q9MSPy8pmBgiP7QCOlDUmGMt/Iu1usSxtALPy0WwDryCS5I9JCV90nn41gTffca
         yXFM6EvgOen/1cyfI+dwrzj37UWO56rZXzDaeGCorfH/jhDtLhzhXvMZ9yH8pM7SkU9Z
         2dct3lIxa4EknDDJcg+KNljmLUcAVhP7q9sSw82daxXvu9PijsFZUdZBILNDSGTgb+Md
         SeCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779199677; x=1779804477; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlvaaSf6hX71qoVaaZAiNP7dD67S54v9Ar0OEm1wY9U=;
        b=QY+14O3WqHLYpxnM5NCUpxlMLDMB79h6LYUiv5D40RcaagKKbyn2PBsp7PeYJTGOzX
         akdKHGF7zhjwMG6jptIxgmrQ6SqgYCYwaeAD2wRJvetJ7rquaY7Oz9XpfX9OHYLJNvp7
         j5sFIV6D7ZUwm1u1FhQmxAIPdFeP7qMWZb0is=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199677; x=1779804477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlvaaSf6hX71qoVaaZAiNP7dD67S54v9Ar0OEm1wY9U=;
        b=p+qCv27MwHJ+qvtDdbm+tvPuy0DcXpnKNleCwVKXIk5TI1OL7fPpwUV+u7oyG7KbGv
         70FI07I6/ppBY6AREM7WAptBruHdYF+GV4r2LSUxWrnObbIYQLrfsDkCcPtraJXaz5Rx
         ZKaoBkj2jBhq8cOTg9fidqvNQ0hP3E4TE6HWKpDRcR5phKOAROfwPkAXnY4UR0lrEuj8
         /TJkqjiDE1gOgde057dW5pAATLM0bagkNe4tcAHTrwag35FgHDpbTd0Ld2EWa5CgixEs
         HR5E83oKtR1zGCA+XIoq8fgDziyIgb3X6QfQ1305GltkT7wBnYMSR/ioacIlEM1s8bwQ
         J8yA==
X-Forwarded-Encrypted: i=1; AFNElJ8gb39yxVQK24rQ5sHSA8Kg85bVi/dohamj5ZJo5IFNnq5FyhY3rNUclceXQVW90GlTLttw7AY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwVDfW/hzKxRpG2tHsaN8PzA0n/fLvQoWCs/OOA8qV3hS4lw2U
	gAfgeUDnK1xDsf1l8gEoWq+zBvcs1TubZlY49giUMDrzjoSDtO2yN1Z3lWPp0tlJ9fdvNDP7w3u
	fXGZDWvI5MWj2YX/qkmkXERUC18tSadUtn7tDrX3c/PjJxUD7dYMkO/g=
X-Gm-Gg: Acq92OGbYsebobQNYov13RrG84HTdC9F0UU1We0N01C63J9nYplt2A2nlwFz57IHhuU
	vwO9hpg9Z8FdNhPTkqZTX16IK5S4txzNS2xHOXRwKtAsFyNm/2kIHobAhD6zIb2XzPEtBffRxxO
	rvKWm5Fwuwib+2CUZmOwl8tKXZEIB/7SHgRFb9czSg+vSzGFuPP1zeqoBrV2ubU5Uw/NkmMBGuY
	m5xeWcOPrb/+3Yyw8hnZXtEfTlMdb0zNXBzZZlYDgzs+NO1gO1Rlt5arxS/gEX+y80dikLcjjlS
	WsG3qSD+SMPp/nw1Tq7CB8X80aZ6tWBQO/Z56kw=
X-Received: by 2002:a05:622a:250e:b0:50d:b0f9:1a66 with SMTP id
 d75a77b69052e-5165a20c07emr258446821cf.42.1779199677085; Tue, 19 May 2026
 07:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
In-Reply-To: <20260519-fuse-dir-pagecache-v1-1-1f060c65930d@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 16:07:45 +0200
X-Gm-Features: AVHnY4Ju8gNxI22X-oXQbbZ3c7C6b3wtqxFhm0MkkpAJGdYIHwyAWsx7v_165KU
Message-ID: <CAJfpegv63pO9k1mvYct_U+aSuiHHVBxCdNgsaj3FhK8ZX_m0Mg@mail.gmail.com>
Subject: Re: [PATCH] fuse: reject fuse_notify() pagecache ops on directories
To: Jann Horn <jannh@google.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-249601-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,szeredi.hu:dkim];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: ADF045804AD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 16:00, Jann Horn <jannh@google.com> wrote:
>
> The operations FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE allow the
> FUSE daemon to actively write/read pagecache contents.
>
> For directories with FOPEN_CACHE_DIR, the pagecache is used as
> kernel-internal cache storage, and userspace is not supposed to have
> direct access to this cache - in particular, fuse_parse_cache() will hit
> WARN_ON() if the cache contains bogus data.
>
> Reject FUSE_NOTIFY_STORE and FUSE_NOTIFY_RETRIEVE on directories with
> -EINVAL.

Good catch.

Shouldn't this reject !S_ISREG()?  Symlinks also use the page cache
and could break if overwritten by arbitrary data.

Thanks,
Miklos

