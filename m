Return-Path: <stable+bounces-267589-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 64E4Na53OGokcgcAu9opvQ
	(envelope-from <stable+bounces-267589-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 01:45:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B1F6ABD0B
	for <lists+stable@lfdr.de>; Mon, 22 Jun 2026 01:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ekjecCfn;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267589-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267589-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A870F301FF8E
	for <lists+stable@lfdr.de>; Sun, 21 Jun 2026 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80B22BEFFD;
	Sun, 21 Jun 2026 23:45:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A88175A66
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 23:45:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782085541; cv=none; b=lsp4JHGI8CUcL2d9r+VgQApCYBNyw5KgsFQw4jhUFLf4ZD84vaErdR/cYYJ8Qq8BQ5Yt2wgjCdFIqcxcD6Vx1OQwLsWcBjZysP4aODZM3hVejY2E30XUtx9B6GpQz6obUoz6FIBp+8UsFlDat25c4n0ouWLTk/h6m9bpc1kC5Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782085541; c=relaxed/simple;
	bh=ZZfaNqTNNx9mhw99oZCuVOFnAcpnJCCrILs9MOE6uoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=siZQkZAXbdFkZ7j5LgKATCZY9FtG/3jjfVsxgIG6KLhxieI4RCEC0VX9uAuQQ0hE2xu1ielsEhdC1IynE/Q6mzP/ThLIrCjls/+4f5KdoGHJ5wteSHLT9owHHqZhTZHV/alKnAhoy5Vabwn3LYDSxOaGh67P4i68rJONeC6vp1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekjecCfn; arc=none smtp.client-ip=209.85.128.46
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49241a577d8so16371935e9.3
        for <stable@vger.kernel.org>; Sun, 21 Jun 2026 16:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782085539; x=1782690339; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZfaNqTNNx9mhw99oZCuVOFnAcpnJCCrILs9MOE6uoM=;
        b=ekjecCfnj+sl84SLjBsxA8bC4z9HY1vDU2G1UyXehvvTOUZ71lTgmXAwzkTkKMUlBT
         B2UxjUB/EBLZII65Xz2jDb7FvY0/QuQhYr8cQae/RaZWWnRFIi47t+UYbrqs9QBou3fe
         DEDb/hDtNv3HHSJg9uEgzyZ4Xl6+AzUeQYcY2fxfju8Ap8I/9OnYPgkgV8QmzBBEll8L
         aYRR1UGifvRyaBXsT/aQSFv1C7T50RrzyZqjhQJ3exdWtaIoy1PnDxY0zEZElpNBcKHG
         NGlgLhDho4QrYWri0Rh4KlbjuReHc6SMUiJMrB7SYRgiEKutCvVr6Nq8dAYo55ssEInd
         F1pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782085539; x=1782690339;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZZfaNqTNNx9mhw99oZCuVOFnAcpnJCCrILs9MOE6uoM=;
        b=j29u4vJ3WNnDWxN+NPjEPjUGaANi5sPytAsmRkxU0xT5IyZ8xPxkdd3fvAHzy9j4gb
         DUuqJusSJTREeZtmXGJ/LJHIM8bj0f8BhSgRdxh77FUwSkFFgtQMBTqQDzUeALfWL7BW
         CkXtD5VyyIK3A+7Nyw7CFRL79kzx0FkiaD4ypacFmHkRjbIP5PUm+yK8gFlrCYk3d0gN
         KgdNkXEW8d+X5zHBnOccSRwnegm3bHxA/1THTuZizLIbZEIEb8+hMxGPhNhxQT3zIJOL
         U5u7vw05JNrQOisBc/EDVzWSL2EJ/OlzPjHxnjP3hzxB2bPZK4IXbXlOOtotHCwclWGb
         tpZw==
X-Forwarded-Encrypted: i=1; AFNElJ8hULAKGTTDQk70LQCSxtOValnVQt22PJ3OfdMvB53Pslv3RXB3N/5MseqnQk7Q7ea4jwJ2wwQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbm9m1dX21yLFe7fEpsZUExnpZCU/XlsxPC2GSqAwc4OJqqCZw
	kT4iKvwYlaY9shWKU7U3L3hHL5uv2JJrjfgK/3z40j/FPza3r6sAi0T4S+9X
X-Gm-Gg: AfdE7ckB/Zvgl/xPaK3RgiXmVcMdxYJ9mpBy46fZoM29DHiXaKevd3/dhMe4bCmHo4M
	a/6X5deKc5egRqXXemmXMNVfNFMLQu77hm4+neSGP+5iTWexGyx+OreB1I0c1LXu8sDEYYrP0Md
	o4m2ajmPuC2T/sU4q+ZTzKVLgcCskZrp9vGzl0i6qpRssSEXNBAB7FGMz+757x6WlW2OrCHCfxy
	NNf3DJXznkQlkgWPtW1kdylkMgHRdZrfKJtywDH/EMqTedy0AvNyaBA/F18SggIxuY1N1DRqSU7
	yuncKUvfY9jUAewpWwVOBLNdettRridpEgn+YXNe5TsICvjEmRr1j5XrM6AmnL7aPugpxT/CSEj
	FpCmTqFkw3a5MDvDEq6wyut1CzggpAqB0FmarI0lDH6Gic7g1kBTUyaY=
X-Received: by 2002:a05:600c:3e06:b0:492:4fc6:75e with SMTP id 5b1f17b1804b1-4924fc613bamr87802335e9.0.1782085538626;
        Sun, 21 Jun 2026 16:45:38 -0700 (PDT)
Received: from debian ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492492338e5sm183359795e9.3.2026.06.21.16.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 16:45:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <dave@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Tristan Madani <tristan@talencesecurity.com>
Subject:
 Re: [PATCH] profiling: prevent stale prof_cpu_mask access on init failure
Date: Sun, 21 Jun 2026 23:45:37 -0000
Message-ID: <178208553739.3350560.11630245626644331749@gmail.com>
In-Reply-To: <be257038-78f3-4a6c-8a57-237f5e2676bc@I-love.SAKURA.ne.jp>
References: <20260621192324.2062795-1-tristmd@gmail.com>
 <be257038-78f3-4a6c-8a57-237f5e2676bc@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267589-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:penguin-kernel@I-love.SAKURA.ne.jp,m:akpm@linux-foundation.org,m:mingo@elte.hu,m:dave@linux.vnet.ibm.com,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:tristan@talencesecurity.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tristmd@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22B1F6ABD0B

On 2026/06/22 07:49, Tetsuo Handa wrote:
> NAK. This is a use-after-free read bug.
>
> Correct fix is to remove a commit which adds "free_cpumask_var(prof_cpu_mas=
k);".

You're right, the flag check races with the free. v2 will just
remove the free_cpumask_var() call instead.

> Which tree are you talking about?

This is for stable (6.1.y, 6.6.y, 6.8.y) where prof_cpu_mask
still exists.

Thanks,
Tristan

