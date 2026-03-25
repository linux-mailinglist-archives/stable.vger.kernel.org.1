Return-Path: <stable+bounces-230259-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JyMMqg+w2nspQQAu9opvQ
	(envelope-from <stable+bounces-230259-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:47:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF6431E696
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 02:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 539553053E14
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 01:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 272CF2288CB;
	Wed, 25 Mar 2026 01:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="JPqrEXjZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954AE33E7
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 01:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774403193; cv=none; b=cSQ/IRXcHRB5Fqin04iC6oNCFxJltLlvyzmwSEkZNjCMnSShpURhDDCAeWh+nKoMYyflZrZIYGHS6GBoK960NcQkqPeOG/DeBLmCK7cjAaLV3aU5pGSx8dUlwmWxETuP8O6aoD3bN4ANaCyk9zMl1QSFX4tnx/uAM5m6Hp57OhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774403193; c=relaxed/simple;
	bh=J05DKlmK+44ZtncLnTpEsjlOqflBQqjoy8CruuSFAdw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mI3AnwvkkXItvqTPj/AN+f/PY5KIVIyc+bQu7/x369vrXHe3zriqCAPx2rSTDfK8bwSc+8snsUtxQV1rNr/3OJSFAXtX5huHqkhaKaGnMt+4HRTW9zhWdjOIDFt3zXZEX7cyDmseHSzeWCnnBtaG3+JWAkVOC2l8tn5oZAuESyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=JPqrEXjZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b0603ee486so13526445ad.0
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 18:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1774403191; x=1775007991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XAqwg4AZtsESsH97IIgmTxvMLL2sE46/gIAdnIuPc+o=;
        b=JPqrEXjZp25gpFGUSP9UPyNEimPuO5kDezLntBJaie7NmpgP5aOJfx7msCr7jMxfJC
         9yCDdvalRYJTzxgXk0xllsG5glyTCC2tTLJaT6e1I6VCvdgPLp/0WP+o3PIvq/00uCCJ
         r6VZpYboTCmYS8S7U8dCMTqew32nNi072OEk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774403191; x=1775007991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XAqwg4AZtsESsH97IIgmTxvMLL2sE46/gIAdnIuPc+o=;
        b=f0BjeXYGLii+3T0s0cf5XbBoOiAkDh/d1+Nr2VzIIpi8exdEd9nX7Di1sOuuYRGvqD
         GJrofnFETERXW0wEy/qbPpjbURs6qNazVKAnyomtk5crBGSgz+70y42iUeZav2h76Do9
         oYBjtulDzMlAy19ff5Mwoide6gVgSYrNNQ3qR/QK3r8q/l3jp5uqzRS5+z4Wzr31Mrzh
         suMWFBPlIYYGCewcBHz30U2q6u9rwtNfJ5s0IzSZDmPFarTb2HY73kuSb3SR1iWWM7Im
         1yuLvnqU4yzHV0kzgxdRu9aSB3Zf1UZ9/w0R3dVdF4V5JDkcNyoJKxst/hhWhvq+OAnJ
         J2LA==
X-Forwarded-Encrypted: i=1; AJvYcCWCbGtbSbRYirOG66dYnrU1UpjObGnXiCxwgQUzaNXArDUF5QIsEnYaBoSvB0eyi6SDXc3oKd4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFmArW1QSNro3kiJXobKyDJPl1iaxvbCKS4yK2gexcSfYxGphr
	b4b83CIDs4EwC0CBThCJYtHfglYvzj0srSTtfeFQR60AZZ4sEH2IHi8ecMbmAwDuUw==
X-Gm-Gg: ATEYQzw9YXbaJvxtoH7wBo9YJChCJ/VWGucx2PsBCKqoLXQyiq17fg28CQ+0UZhcjmP
	aUnEjNDHga2obdeWU2pBDyEc7KcUU5lXb0URDbxbxx1g77aJvId4MTUAUEKO0ceytPuZrWQ42lt
	F7eRvROn6XAyDFJej8gsZiygSn5gRkWgih+Jxkyo6Rq+GE6Pu8pBaikbS4VtZ8kazqc6MDYu71L
	7EjFmhxtmucLjZAYq30RPDiZKPoXma4O6jlansmBwRhlxBpB1PCM3l1r+kKWBoAtBlfyoGX5x2A
	GQMDeYaxSlaCP2LSn8dL2oUmWd4sOwIqaPMkaF7Ayr9c8HB2tl+sVS4UfkDNGWG3gxzFdNtt6/N
	1bgweOL2EV3PW3EYOhEhUG5CjeR6xhfcWM1NjepWm1djzHZM/RU+ivT33htTEZz5XSXXn45CDmJ
	4B6M/8YDID8IMjSt0JgdKchx9LeshCLnjoDMltMSFWxdGNmpXsoSAzwLKa8Zk+iICNWfeR26+g+
	A==
X-Received: by 2002:a17:902:ebc2:b0:2aa:d5e5:b136 with SMTP id d9443c01a7336-2b0b0af3befmr20192675ad.38.1774403190926;
        Tue, 24 Mar 2026 18:46:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:b91b:3806:4771:9ab8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083527f84sm153641805ad.18.2026.03.24.18.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 18:46:29 -0700 (PDT)
Date: Wed, 25 Mar 2026 10:46:26 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mm-commits@vger.kernel.org, stable@vger.kernel.org, 
	senozhatsky@chromium.org, minchan@kernel.org, mark-pk.tsai@mediatek.com, 
	syoshida@redhat.com
Subject: Re: + mm-zsmalloc-copy-kmsan-metadata-in-zs_page_migrate.patch added
 to mm-new branch
Message-ID: <acM-RcQ89TkxDhCo@google.com>
References: <20260321175018.5B0E7C19421@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321175018.5B0E7C19421@smtp.kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230259-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[senozhatsky@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email,mediatek.com:email,chromium.org:dkim,chromium.org:email]
X-Rspamd-Queue-Id: 4DF6431E696
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On (26/03/21 10:50), Andrew Morton wrote:
> This patch will shortly appear at
>      https://git.kernel.org/pub/scm/linux/kernel/git/akpm/25-new.git/tree/patches/mm-zsmalloc-copy-kmsan-metadata-in-zs_page_migrate.patch
> 
[..]
> ------------------------------------------------------
> From: Shigeru Yoshida <syoshida@redhat.com>
> Subject: mm/zsmalloc: copy KMSAN metadata in zs_page_migrate()
> Date: Sat, 21 Mar 2026 22:29:11 +0900
> 
> zs_page_migrate() uses copy_page() to copy the contents of a zspage page
> during migration.  However, copy_page() is not instrumented by KMSAN, so
> the shadow and origin metadata of the destination page are not updated.
> 
> As a result, subsequent accesses to the migrated page are reported as
> use-after-free by KMSAN, despite the data being correctly copied.
> 
> Add a kmsan_copy_page_meta() call after copy_page() to propagate the KMSAN
> metadata to the new page, matching what copy_highpage() does internally.
> 
> Link: https://lkml.kernel.org/r/20260321132912.93434-1-syoshida@redhat.com
> Fixes: afb2d666d025 ("zsmalloc: use copy_page for full page copy")
> Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
> Cc: Mark-PK Tsai <mark-pk.tsai@mediatek.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

