Return-Path: <stable+bounces-231020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLlyMOYmymnX5gUAu9opvQ
	(envelope-from <stable+bounces-231020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:31:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B16D356782
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 09:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1475A3004D28
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 07:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90283A0EA5;
	Mon, 30 Mar 2026 07:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngCkRXpY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F01C39EF20
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 07:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774855901; cv=none; b=QBAV9V/sWTzB65ixFxTIa+aTpPbLdHo2bITt/prWuwlUa1qRgbUTAH8S+ojBcKwl4xWpJLaysdiJNlZjX9Qn7ZossB4A0VsrqqyRG9hJQhgnz8QX39p75Hy1YJK7d0fYUTWN+5IwAu8Zz2iy0scdmKwu6cS0WRyZbzp6kDWK6i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774855901; c=relaxed/simple;
	bh=yBvn4M2fwZ/wUpBIpN5sR6P7GDJXzK0vo3gw3vBP+xw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXyCFCxNZipoVqcUgOmpVR1eSACup+imAXimRcm1y/rauXVD0NBCNSvDXJbhTWHlMQf23rqveGoJ2VeEa3WfkxX3m/kj2z+Ep9TzxvFQrxOgYVCNw0nmYEgOw27OWIcd6R2TN3IsNV8g5s+lIfG4jQBC/x16diH0LpH75guyqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngCkRXpY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-358ed696623so1853531a91.0
        for <stable@vger.kernel.org>; Mon, 30 Mar 2026 00:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774855900; x=1775460700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBvn4M2fwZ/wUpBIpN5sR6P7GDJXzK0vo3gw3vBP+xw=;
        b=ngCkRXpYcGe9lUFcYcYnWfXftXy6Oum8rGSq0ojpCFCxAOOZNVh1Hn9jxgQvRE6CPz
         fcac56qRrO0jDj3enNI+JigR71oNiSxArBKuT+uUrmzYhFHmwVAPz60HhipnY7R3msQB
         4H4md7wBff4/hyqICi2k/akS06KsoBzVWi6RmTEuVsVIyGt4uRWSC7fgcL6mfTjC54nH
         AzbsMWf1gRlI/ba/f2fSJoWuUsfmmSouFPw/4eH2rr4Utl+6PphT858jyuouS1iNEAqe
         KzcIqMMKyfT7RTxJWT7GMUmoo3l2zDPkOF2/OUm6sz/rWfYw7N/wNS5iluJiAKJVfjFO
         AT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774855900; x=1775460700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBvn4M2fwZ/wUpBIpN5sR6P7GDJXzK0vo3gw3vBP+xw=;
        b=am5a4NZY5GkK4IZ6ter7sBs/UVfzCMj7kuSD53f4SwrbW3RD2o3h/mpVRgiwgOytsK
         mVpp95PgA5FvdaHss39Yv++LnMyumj5K7KGLevNnuO9jPANoGVCHM3YbKpa7DQ+mA3Xo
         Xd8nVBEzh9AvTexSZ4XbFXm16QflPMAV2J12HMRvB3U/EdGK9u1kCMyakh1+LUU6uTkW
         hzLMOpwcoUb3PrW2LWh/k4k1+6FY8eEZySXsr9uGtq0M5KZoaHDzJTMPyHkDxq2lZVI+
         VOUUo6Kcg/N3t0QFXVfDs54N+26WJHtL1JJfZKEbeipXZCTgli2wh93q5OrNJIucuutg
         juTg==
X-Forwarded-Encrypted: i=1; AJvYcCXozgcSGVm/Y7gcB7CpZ7uotJYXjsDIYQorHk03N+N7Ta3LVuGD1awC2+IPm4q0OUDmJMT2DKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaWfsVcqATfhDkbvux/Qz1hOCb9805Y/xfIL8C5lOVtdVrqfKf
	MRWTyyQWtypR3LXl7o806NxSdktStzhyT4CxWz+zp2TZ4eIsGHbd4CSfLmYK48OY
X-Gm-Gg: ATEYQzwD8xwqBjtBVj2Lw36NO6GpCEzOja5sSVVFD/gOb0D4HbHvGnnS/CDi1lrP7jG
	GhgJXvfvpnRFdPcdy7j/HSfD2ykBwLqu0zxzOS90HBuMuPz4TcESoXzzEH4ZpGVV4oR+VYi2uwm
	GAiUGkQc4K6imkUUIhigzQzreb3Ac0I1hwxrmL+k3EocTSCn7RpJjBIhl/pGKgnJxlYeXNBgEsC
	nRTUHtXOfRcId0ZE4bIiCGMZaMhlF9J6BUT2ATqVkcEsMj2Q40Q4RSISEmixT2aeaq2wQj60+zO
	iy4bFlVlzdKtxvhckS87lzYGThur/oG/DQVksk4vAHMCuRlA80WAb6qYbmVyhJg963jAtHANG0W
	1cFiufq+0tVU+fKx8WAK0K0Z55FsfaaJ9lc9eauSgyYjWYZVDnjpDMn/bFN4M9LA8dSR/mymNt1
	u4KbjEqAEpfxny8/cydEhWHFVAb68+AjQ=
X-Received: by 2002:a17:902:ce81:b0:2ae:c5fc:b2ea with SMTP id d9443c01a7336-2b0cdcb73edmr129302335ad.30.1774855899658;
        Mon, 30 Mar 2026 00:31:39 -0700 (PDT)
Received: from d14217fb1c18 ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c3a4esm87361935ad.78.2026.03.30.00.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 00:31:39 -0700 (PDT)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: hd@os-cillation.de,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	sanjaikumar.vs@dicortech.com,
	sanjaikumarvs@gmail.com,
	stable@vger.kernel.org,
	tudor.ambarus@linaro.org,
	vigneshr@ti.com
Subject: Re: [PATCH v4 0/2] mtd: spi-nor: Fix SST AAI write mode
Date: Mon, 30 Mar 2026 07:31:29 +0000
Message-ID: <20260330073129.24-1-sanjaikumarvs@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260311103057.29-1-sanjaikumarvs@gmail.com>
References: <20260311103057.29-1-sanjaikumarvs@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231020-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[os-cillation.de,vger.kernel.org,lists.infradead.org,bootlin.com,nod.at,dicortech.com,gmail.com,linaro.org,ti.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B16D356782
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,=0D
=0D
I wanted to follow up on this patch series fixing SST AAI write mode=0D
issues. It has received Tested-by and Reviewed-by tags from Hendrik=0D
Donner.=0D
=0D
Could you please let me know if any further changes or actions are=0D
required for these patches to be considered for inclusion?=0D
=0D
Thanks,=0D
Sanjaikumar=0D

