Return-Path: <stable+bounces-260850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k+SXAYSSI2qLvgEAu9opvQ
	(envelope-from <stable+bounces-260850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 05:22:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2DD64C463
	for <lists+stable@lfdr.de>; Sat, 06 Jun 2026 05:22:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=h51HdRM0;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260850-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260850-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69D87302496F
	for <lists+stable@lfdr.de>; Sat,  6 Jun 2026 03:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745AE25B2FA;
	Sat,  6 Jun 2026 03:22:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63A23815B
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 03:22:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780716158; cv=none; b=jeyyDJN6h6Nq31OJeTcy7h9CeM8M+xqpUTAFnoXzX8NcuJ73IdZsqnuM5LpH3QdpUb4zUBBk798XQ4Qtp5jDlRwsXYwXKmw2v2++E1VK8dngp3De3Z0H8iSVP3utNrhwhkQ5rIAJgvRkkR8Rci0CbFFyjSRphTs/+3dY/WJdvoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780716158; c=relaxed/simple;
	bh=jbPgsrbK1K1b0DlYJTMCLHsCDahXSKwxCMeJ1Uav9D4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=rz8+wGFuPW88eKDbOhY429w4IZggnl5JeyfzqzhKH91Q/G9EhhFszdZtAUQx72xg35VfqzAzj0iuAd/pe+0I4pUkIkG7/Z4Iyiom6/DJJAeMReIdW5J680nB0splJfUVXbpdGMOPiNiLDWEhQ+Bo1vdQg+LaXGbCEgIOZNztKnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h51HdRM0; arc=none smtp.client-ip=209.85.216.47
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b903567fdso2565656a91.1
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 20:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780716156; x=1781320956; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jbPgsrbK1K1b0DlYJTMCLHsCDahXSKwxCMeJ1Uav9D4=;
        b=h51HdRM0t8zZBUN8sbbzxmIlBcc8YB9Ncwx5sDOW5rDhis7HgA1jfqIOVLxWLnhf16
         OVzZ/cNHuxmu2nP/k7+rcCGKmsSY63o2DvlYZnc5sUgHwH13/nAF6Lrq15lD3Kp1Hk6Z
         uqThe4ZdHPXuaepunMcm76yV7CSndkWvPmpnQ8ooglwaQtuSM0AupRmh8MBEb3f292fz
         J9zJ6q1HoQxL017uAavGOXtIjTJ7RQ3dVSt2lI3pTW26sXXXmCKuTS8+F2AYlJz0S2fs
         ZDzDVGWfPPaysUR8qIsx5DWpymiwydokNPWSJ+iAbeI0cFQ6uU0mQ5k9AN1vkSecDNCA
         ApXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780716156; x=1781320956;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jbPgsrbK1K1b0DlYJTMCLHsCDahXSKwxCMeJ1Uav9D4=;
        b=U69S2awquuAmYfmU8KfiBaoJgzYkKD6XWZm3VpjvsQ+OLp3B2aUcR69rGr4iQjZUmb
         TCwWya0qSAsEQrXjPoxS0lrqMooKUrHAeDilYWfPtnow1bCHiaCAIDGeJVRMzYq90SYA
         0yHO+StIfsH9LRaXCx/vTfnli/eJNxxJRkBquvQJZKS0UKQeNvw3IMNJ8arMfLNZ2tAM
         bL8jBYThMsvpTl+F9egT8sUHy6HXoVjiqwDtvzA/YIGKsb7TNER3sgCNI0HQE5rNmrDt
         uo0mgD2dJGsGsO8uRyG/HT2QEwdTLZs4Ll5rhTlOKjHEqzL/yvoWHtzjQ7I5b6Im/44q
         umgQ==
X-Forwarded-Encrypted: i=1; AFNElJ9REfoQuGRLe+Rn6SalrrkPClHp2eaFHjcE5BAwNkHWuHIIgs5fWzLomaBsDgNmLV53ChfoXw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP6GOn+jl8uVU41RL/TIItv+OpHT2XA7qclz062iUcb5UJfeac
	Um05ojaKNwFzbyP4b2y6oEqsZ+e5ZW4aOqgQfYDHVC6l1e+cE1cH4zzP
X-Gm-Gg: Acq92OG3YNaxzW1Ry6Sos1miqIx6Hp/t0jm19JJ/aI5bmenwn82EWyxXEYbjvlXS1Af
	eEFdE0V44Ku5cz2yqRw5hAuatlP9gqLNMyH1Hg7wW64GRHP1DkuRXX/YUCQxFMSImOrHKi6Fznx
	s5zLy92slXQ//+AOXysx2QBddaJGrsmyMta1xJ7pdw7x0jk1DR45d4z8cOzkKBaabvsV+T0RkyZ
	lRb/QnAfNqcnVJrFge2xPrlsQUDxFu6smlToiKVY9B7b5CsOsO2ruoVJSpDu0OLhy040XIY8+By
	hbzRuMGdjrll6kT526dWhD3vpro1YKl6ixn19znCHGaH4/cpoJmoWXzrLQDBCZ6krsatSbpyqfX
	f+rCik95pTjwPxk8ydHov3XB2Db1OnpPoQ4DTAGKBv0Ja5zqZJJPAlFcmehg/6PptfjYOHO8j8y
	JYFWc2tRHG/3PAeZAORRbh0JOJft7utU6x
X-Received: by 2002:a17:90b:35c1:b0:36b:9daf:1504 with SMTP id 98e67ed59e1d1-370f0772850mr6916406a91.14.1780716156242;
        Fri, 05 Jun 2026 20:22:36 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371341170c7sm2319688a91.1.2026.06.05.20.22.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 20:22:35 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org
Cc: Gautam Menghani <gautam@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, harshpb@linux.ibm.com, stable@vger.kernel.org, Sean Christopherson <seanjc@google.com>
Subject: Re: [PATCH v4] powerpc/pseries/Kconfig: Enable CONFIG_VPA_PMU to be used with KVM
In-Reply-To: <20260602121706.8423-1-gautam@linux.ibm.com>
Date: Sat, 06 Jun 2026 08:37:49 +0530
Message-ID: <o6ho8iyi.ritesh.list@gmail.com>
References: <20260602121706.8423-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260850-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gautam@linux.ibm.com,m:maddy@linux.ibm.com,m:mpe@ellerman.id.au,m:npiggin@gmail.com,m:chleroy@kernel.org,m:linuxppc-dev@lists.ozlabs.org,m:linux-kernel@vger.kernel.org,m:harshpb@linux.ibm.com,m:stable@vger.kernel.org,m:seanjc@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,ellerman.id.au,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B2DD64C463

Gautam Menghani <gautam@linux.ibm.com> writes:

> Currently, CONFIG_VPA_PMU is not enabled by default, and consequently
> cannot be used for KVM guests at all, unless explicitly enabled on
> host kernel.
>
> Mark CONFIG_VPA_PMU as "default m" to ensure it is available when KVM is
> being used.
>
> Fixes: 176cda0619b6c ("powerpc/perf: Add perf interface to expose vpa counters")

Not really a fix per-se. So we need not add this fixes tag.

> Cc: stable@vger.kernel.org # v6.13+

I think the stable tag like above is sufficient for stable tree
maintainers to pick this up.

-ritesh

