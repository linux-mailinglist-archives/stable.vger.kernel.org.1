Return-Path: <stable+bounces-222582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BmOHbGJpWmWDQYAu9opvQ
	(envelope-from <stable+bounces-222582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 13:59:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 186171D951B
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 13:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 40F2E3010636
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 12:59:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79153C1988;
	Mon,  2 Mar 2026 12:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="mwAvOCHI"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF73BFE37
	for <stable@vger.kernel.org>; Mon,  2 Mar 2026 12:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772456365; cv=pass; b=jLco3xVcZxwjjzK4lhn5GOPpwKLxvQ4z7K1u+JgXQGcaV3UcvNB2NpxDStUCr1Hqu5npuOPWs/bv3xfuxp+pmFogDRiyuXeLVCkKO/CxuZhpfi0qbsLPKsk3KjNLOsUNtkMWfFovttwodgp0gk0G7DY0ZA3jyJGyOSnFbkKRlWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772456365; c=relaxed/simple;
	bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTAkLD7pep4CzMXjBhtZMI5dghEQ5vC+8BZEtyHkH7oK3rmz1MT9I84MsGpImuDdWacLktxUwVPEyV1cWd/t/l5QoX7ywJRiTmfqjlBj9as+AdqKyPes7Ze/YM50x2o/JVDc5KmCxMrgxjvs6avcAX89I2ZQxJegBiokXqbpqRs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=mwAvOCHI; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732e6a123so5464112c88.1
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 04:59:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772456362; cv=none;
        d=google.com; s=arc-20240605;
        b=WonxboV0JLd1rlFP1JE03Ck9pcrdoc16ou0yAZZ0/zq838Z7XpVaMw1nZwk6RhLQ34
         AN6xRhOkFdK8Q28aEa6YPOQVQsO3GDy2mviOZg2fH8NQeTzeljD6KvfKVqMMyuUCdoBh
         v0so7wqIIPbOWZ+3i8Ld4R7ow3kclYhWRVp1KCsKScVaUm/F8Ru3rwEiKo2/3CxHT5Kx
         BpbtH7ezg6YH/wXzc+MHLfstud2cJFaeCRasZyaQAurZpq0vo516sy+KwQFPokz6wQ4R
         vi0rC+iI0y4og9svjt4dIJIDvQJ08pYgmbzfGODub60QHdF4HHDDJVg6UGHYa8iLF3eh
         WqEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
        fh=IDQAUHFxwl9VhNAuQL+oR5FAJ07NPnjkPhy9Nq0wK9U=;
        b=JgTF0DIgces0uy3DuQv7CuqPgPzF067s3U2craaXaN7oMgRpiLNdstSrMRgV1T4pfO
         ihP4jBiZr+aSO2yKTmbSftbCUz4bXbQ4IkRaW1OqqNBMi4xdx3hYX/GqQCRrpl8VDplK
         eVCXB6bZq2zw6hoW/dEnoWaa+G7nXAWp8ksewnmL8o+4B+yewPgXBxVeWXmGyQmQSaLk
         /6TviYOlHBxXqcTWZku58HRZ3Q7o78D5ITJ+ixnoCFdq0b2pQiANx+AAoFq4f7rTYIzD
         +SavVnxf32Ng1z+GsatuNu2+7Xphr+7luPJdtk6EA1Bs3eF5zi9jmInLGpXyONcN9hmu
         qxpQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1772456362; x=1773061162; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
        b=mwAvOCHI+omgVo/SP5Sn7vzOktyS9SOo/ZsTcQeMYwLpuODbE/kofGJLj6tUcKv1Y6
         Omaym1AeKbv7oOw5jQsoM5vSC76fbYbd7tjxa0cfkX/9n0ko9Fwvs6LHQPN9zVo7yID5
         Jw2F/nfvgL1auhuor2BcjYAjHQyWfwem5DUw8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772456362; x=1773061162;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBb8h3H4mC7JvfxAGxqNwalFIOgvy4nMMnYn8mNtouU=;
        b=j+P16O073NENvoOxxXNgn1KBCJudvXg2862a8jAeQ6F8SDHGTzwiRleN/5ETe6R+eC
         MmbREWaUCmdBCAUOVySba6lZCdEH4CZBhgHPYwot5uX4LLvzpSQAa5hQo3jcn1G3bdi0
         s/3X0lm/seb5EMdcLrPEZoaZDKoQE5pilv9DQh+Ro7rhKAgI6pU/iJV9SWAb8eyO8PmW
         7uzPCZKB4zAeKMMlU4lZdyveZJy7vrC6UT76/n+uLTIjp0o7Ls20fl3iqZOLjo8jACTZ
         nfWuy7XYMbo82NkNGLlLE9O/JCRTmKHu4YeQ7ujwQI0Og430pSnkmVQxoX3w8fg642ot
         BPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKQ39oerOoiJsobvzppEKaEk/EvaQn09RYng+9C9jl0okirjoEEaj2jtqrqPotMVesvDxm4zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2easceyKYyOecSbBO3z0iaXLnEnkLuKLhpM7j9qkOjmZgy6g
	m6n7wmuPvYpJ7Bv34ejYO8pIe0etaRenUm5CE/JNVjmg6VYfIiFxQvycpzF47H6veQuM6cNwLQ+
	qsIrho6zSiqO6LG9hJWEFCL2hAKMy/lYK3orZwjgbrJYiTkL5swGY
X-Gm-Gg: ATEYQzzX/pz9yPUVY3BLuZcrQHqBO2leH+lwZquCQwbk9ACIuWF+TMYj65i8JJiGeN5
	dKbiytygjatTwq/631f1ISBor7euG6ueDo77SXUq03bpTl13B8xi2crucDhSxhG/RT4B/PFmOxR
	Y4VGl1yjA3Y45qNS5UW3qdLpeR/8zUooKvYwSTPh6ccqJQIfvExm+xO6Y15ORQ8qOKNd8/n02bQ
	zfnJXo9/zCLH6PhdgjDQ/w0dg+WFz09dfXh1QcrWq8rcSFRGKuwGoTzjp2jFOkhuIyqZ/8wg5NA
	WDSPAkSXVIufPYOmzeiL
X-Received: by 2002:ac8:5801:0:b0:502:9b85:a609 with SMTP id
 d75a77b69052e-507528d6a97mr146117621cf.30.1772455923205; Mon, 02 Mar 2026
 04:52:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260111-fuse_try_move_folio-check-large-folio-v1-1-04921ecf466f@ddn.com>
In-Reply-To: <20260111-fuse_try_move_folio-check-large-folio-v1-1-04921ecf466f@ddn.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 2 Mar 2026 13:51:52 +0100
X-Gm-Features: AaiRm53cf4qEObJN3O6WPl1Q0g2YyJCuNaf5Tt_XEdcgghEoaed5e10RMcoumaE
Message-ID: <CAJfpegutV_jsLAMo8Jnr=GYsYg0b_A9Z1MkgeMZYua0r-XnY-A@mail.gmail.com>
Subject: Re: [PATCH] fuse: Check for large folio with SPLICE_F_MOVE
To: Bernd Schubert <bschubert@ddn.com>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Horst Birthelmer <hbirthelmer@ddn.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[szeredi.hu,quarantine];
	R_DKIM_ALLOW(-0.20)[szeredi.hu:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-222582-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[szeredi.hu:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miklos@szeredi.hu,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ddn.com:email,szeredi.hu:dkim]
X-Rspamd-Queue-Id: 186171D951B
X-Rspamd-Action: no action

On Sun, 11 Jan 2026 at 12:48, Bernd Schubert <bschubert@ddn.com> wrote:
>
> xfstest generic/074 and generic/075 complain result in kernel
> warning messages / page dumps.
> This is easily reproducible (on 6.19) with
> CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS=y
> CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS=y
>
> This just adds a test for large folios fuse_try_move_folio
> with the same page copy fallback, but to avoid the warnings
> from fuse_check_folio().
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Bernd Schubert <bschubert@ddn.com>
> Signed-off-by: Horst Birthelmer <hbirthelmer@ddn.com>

Applied, thanks.

Miklos

