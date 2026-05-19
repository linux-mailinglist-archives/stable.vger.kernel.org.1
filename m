Return-Path: <stable+bounces-249521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOapGTc3DGoKaAUAu9opvQ
	(envelope-from <stable+bounces-249521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:11:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0864357BF01
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 12:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 93C343051ECD
	for <lists+stable@lfdr.de>; Tue, 19 May 2026 10:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81F5481226;
	Tue, 19 May 2026 10:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="cxuyoSUn"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C842480DEF
	for <stable@vger.kernel.org>; Tue, 19 May 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185072; cv=pass; b=RAcZw0LtmYEiD6j9Flerajghein6QNHFMG7FY2I6G5iGx4rcYsr3RMHmiUcIw+WtJYU/d3BVQpoHt2c7d7zOYeAfEbDCckYfUnKv0O/cjFqcPRzJgPQyW+E8ktGIdXJ6sqmrNd2TGMDwTvGqsB9oiRBwJUusNnz7bgnj/eFK6/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185072; c=relaxed/simple;
	bh=Dhc6kVUygSwb3/WTWYpM6RSnRMfkL+MN9Utka5VIF60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K3eEsHWNr/MYeafot4dTaIPWcSv52dMwx/NvkwB3pHNec2Te0ChFDxMsYbpjGYaDO8BYzPI1hLUe0kpv6PeZD+9tKOHLyN/cYgplpM3b1G91nceUcNTa37eOYfHRa/qcoKXrYHN1natxEzipSQdUf1H9mYBa8064J5HzwDETBCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=cxuyoSUn; arc=pass smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-9116861f004so821463185a.3
        for <stable@vger.kernel.org>; Tue, 19 May 2026 03:04:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779185070; cv=none;
        d=google.com; s=arc-20240605;
        b=FnwuTe0k4M+xkdrQCk1i4nMFxNRFEBMWfpy1NazqpmkVYGLa84oCYtfZYvNZwJkSC6
         LaGtRKKUEzPcDKt9RmwfAOD75YJ34S2bepsMeqHJDW+ZXbKgh+yVfIHKXJcefQ42be5y
         QgSOtZkdw/GsL0XRTuy6LjGdStyx4qqR/b45O19ZoPCg+RolopeSPezSlCovwouFPJI6
         F2QFdtoBJjBKUgQfII0jvJaOmWpLo0ZAgSmEeDMxSjEKzCrt0SGVOVTs+dnh1p4COaEV
         OX9me3WgjdTLLuJh3XCppCIhO3+KV6Qt2DL8caY9fg+y30wzFRqyp6LLVqNkK6UQVOvQ
         JXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ctTJbFngTGuiEcSoy3QpBTsjTTAFbNNyypIjJbvOChE=;
        fh=RvNb1DYn1q9kFT+w0pGRhc9uOBGvhoa1QmyDDmHoniM=;
        b=UrdoJg1mZ3yUFLozLAco1GTXp5Lct83lKBFB80+r03+BCZwzSGM8XgqXxsMib+GiTy
         EdH9tgGfdY2i9P45mssgRlVbINL7D1Ui9f1eZ5Uc/DqwzJhitd7jh35ZiZ6/O5PEh5xD
         elpSanuQouZtCBqKB7zZTbdYEYnyZKgu2TGmbfzJC+/n/OiRuEZH45XA5/bfct0r3Elu
         SaD/BZccXyPBfIPGiY4oqBMhKJYazBkg9PC+PUU1NMDSb0gaRHVlGeJOICqTAyQ4QNys
         xXX+EnnWJ1SDuOByDA84ySuvrwlDidSoYQZl+voE4G7LJLb8YJ6Jm5llZGjT1kfKe5m2
         FlOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1779185070; x=1779789870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ctTJbFngTGuiEcSoy3QpBTsjTTAFbNNyypIjJbvOChE=;
        b=cxuyoSUn5VY0tansFe0w8a/pw3NirbNH35hG1sWOggCl4mNzAfr6JhA0HmnUUnZhx6
         tSm8tjb0Iu0nuzXmIekFprk1nhhY+ryaa2uG2luWrasuuLiLu74tbWKAPtgdC9Gf1f6y
         HEirliOlgEEt9giqoGcF9hewlZVyqPZwaXxAw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779185070; x=1779789870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ctTJbFngTGuiEcSoy3QpBTsjTTAFbNNyypIjJbvOChE=;
        b=HpLNFj2UwGNE6eLiqSgOqlZx7zagHJayQYI+U97J0iQF6HL7GUskpMpkITvIuGkWES
         Yf/SWrlaTPHUbbRSyiRg6J7KtPvPrqGlo0GqOnNS3tJ66zLxYaT6Xx3M9QV6vAWoJINp
         b63ANIZNVGz4lquyS4EvomU2tCiKSyntQPREVSejHjeX8RWyI1HDrlEuvDjWoYNKzOao
         zGG5QIRFyFzAilwO667MQpc6sZQE0P0eFzYgwEH1y2dngqSKvU6jhoRzPCYGt7coDv77
         +M8RDnwii8+VxknwVCv5egzuI7UTlsirfW+5mV6tXgx26gEZJHd19uWBKTlQGl8DCRSO
         qIrQ==
X-Forwarded-Encrypted: i=1; AFNElJ/wNWBgDZ7+Y+V+n/H2o/ndjX2iu2Crny1wFjsTJH3Da42xvukqADlC2nnjCbTB20U8VmBtyrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGCMwZl2xbREPJOHYddoOK1AkQOo3j/ZpIS8/QBLZNd5mynNIk
	FfZigxw3FmER3+4Phh13r1UOvZn2nFlrxtGYWlBZzW/MwzTdimYDYCni85xfzro9nE2TlUKSjkl
	83FPVlcX5+He9qoHe25cL7m3wK+3hz+O85mPyOGYt7+CeWI2NBe6eERM=
X-Gm-Gg: Acq92OENiE9i1lhgLB8pHyt4Dh8WOBMHOAX3M1w/UX7PWSFqWRGjaOJHXRHxv2z//w4
	SQANF5o0fL5c2k0VLw4AAe7u3Vf9z3K+SAe06BtbmEVWut2CoU/wPf91BXPT4kg4gwt3CyjPROP
	youjPiXNuvaHpuGidopRX5FkIiCmT7QOvaOXXLezo7okRLmqT+crlA38FHEqEO42j0taosLHTno
	/A9Mth879eAQEnKGROfSlEIHqluZwNZ8t9Y8GpzH0GXu1na9k6sAqoG57QwhuhV/VwPbLO6w3wE
	ruKWSGRY22Zc4cAaHl2ufHFAdF/HhqAKCZKIv5W5MfsU0s0f1w==
X-Received: by 2002:a05:622a:1313:b0:50d:9b2e:7ee3 with SMTP id
 d75a77b69052e-5165a0ccdd9mr263610661cf.38.1779185070146; Tue, 19 May 2026
 03:04:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519004746.3203156-1-mochs@nvidia.com>
In-Reply-To: <20260519004746.3203156-1-mochs@nvidia.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 19 May 2026 12:04:19 +0200
X-Gm-Features: AVHnY4I6Nw30PU4eMzbpo1rRva11FapaZNtSMDO0MpY3BrJ8caDZotUSuHZn_vA
Message-ID: <CAJfpegsTsKqq+QQKyBexQFP1=EGd8YiMT=rbaCOPeTBvLsY_JQ@mail.gmail.com>
Subject: Re: [PATCH v3] fuse: back uncached readdir buffers with pages
To: "Matthew R. Ochs" <mochs@nvidia.com>
Cc: Bernd Schubert <bschubert@ddn.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249521-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,nvidia.com:email];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+]
X-Rspamd-Queue-Id: 0864357BF01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 02:47, Matthew R. Ochs <mochs@nvidia.com> wrote:

> This was observed with a 64K-page guest on a 4K-page host, using an
> overlayfs mount whose lower directory is on virtiofs. Reading a merged
> directory through overlayfs failed with:
>
>   ls: reading directory '<path>': Cannot allocate memory

IDGI, the patch makes FUSE_READDIR supply an array of folios.
Virtiofs shouldn't need to allocate a large argbuf after that.

What am I missing?

Thanks,
Miklos

