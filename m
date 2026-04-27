Return-Path: <stable+bounces-241425-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFs5Mwau72lyDwEAu9opvQ
	(envelope-from <stable+bounces-241425-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:42:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 459F3478C5E
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 20:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3D3563017FB8
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 18:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313003B9D90;
	Mon, 27 Apr 2026 18:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y4mYFcBM"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD26364EA5
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 18:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315332; cv=none; b=WfGLmghISMLhR0oM+W6ShK2gORb6zPY53YrYFFtNAVqUMqdH3lnnsfr2GnIztlp5f3RqtqHa9oLCfD9YZGgEBswb8jW0+3if8dhMki/vZH5OAZhJRLN/KTpBPaPt2hDJj4eOwSzSua4eYBxTcnUS1jnId3gLp1nyPQ4PKO2bndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315332; c=relaxed/simple;
	bh=+glJ/XUzPVv0XRekOZGXxeVpc8X178pA2InS5Zp6MFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L21xllLnGqqwfcNA1GxkycDRRXpn3RitbzgBZXA8/K5d0qLB71tM3s/9qXAKHgnTgK0tNiX6TWRTscQiZ1tTM0ZvSCNCQDwwvmKZSOkKAU2bUSL4B2ExlfALRQ5UzoeS8FgHAbYrzV8OPUdUlTiopUvgJHx4mM5N7iz+Swl0bUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y4mYFcBM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f9f49e4beso5632464b3a.0
        for <stable@vger.kernel.org>; Mon, 27 Apr 2026 11:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777315330; x=1777920130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+glJ/XUzPVv0XRekOZGXxeVpc8X178pA2InS5Zp6MFE=;
        b=Y4mYFcBM1vEPXn0bAyMlFiN/Eu8aYTK1gBfgqKO0fQG8WJOb6Hw1JUOH9118L5dmPK
         IfflZ/blk3dfb+l8ulonWugWdG4NvqWxfbbDmUxGziA4Q3S76IEnTKI3aERHR/+vaOHy
         aievnGEyN9W9gpTYvEbia1Qh7g2yhrsRTm0hEPEdDyGVX/mGajqUYgh87nIg+P9yOrZ2
         3+7IZKy1fL4ZToz5L0TNhwH3plvS/XBqUsUKUQhBubP2roVCzxcRDnqLrhTaksQksYKh
         o88vy7Vey5UaL5lBLJQ1JtY2ftHOm4oF0gpkWwCWTui5jriAa4D2Vb1CVl/6NuMkwS7Z
         14Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777315330; x=1777920130;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+glJ/XUzPVv0XRekOZGXxeVpc8X178pA2InS5Zp6MFE=;
        b=gd01/9nPfgEBkOfBmc7jU6g/xANhDA7gaxsuX/xzCBsDQ+RId9nAzFWPKI8HQnFhAX
         wSTX/03lzNLP+qUUhSLbsYIyj6RxLslERgxxDXPH5K+osrPofqcxpHvuxjMADrdS6qJy
         /69LJBiGk8b2qN2AzSqFvCzUNIIQGHIXFMRmbj+KS5ZZPd6BiAy4JHm5QWVXyPN4qmbQ
         3e+yOfG6yZB1n7x8e00cY/P/ty06rC/SSeBMcemRZN8dlbS7Vf9zUjAOf75Y4IKwxlLV
         W1TeBj1ZcMOEW+NtWoY83xJ72H6BOppl78qq2Mbh/+TY5R34dVeJcEwUvwjMbI+TUYoA
         ceRw==
X-Forwarded-Encrypted: i=1; AFNElJ82k5nW/juf8zAPzIeax/Cv4BWSRQb8eVS/iu4HRT79vH4ynuSLR7URWiPVRlid6GmiC47dXRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw45s2DuHdbQS34aXq/79RRqh8eGX/fO7EgRHWpGzBLlmYVasts
	a6tXeYac/UJ8u74WQKyNiSRpWYzvKH+UMynexmPEZxZNonN8QR0+RNtNJoavrvEuWYQvcFP0lVs
	yiUq1Zyz4sg==
X-Received: from pfbmy20.prod.google.com ([2002:a05:6a00:6d54:b0:82f:f2d:5b4d])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4504:b0:82f:3828:a019
 with SMTP id d2e1a72fcca58-834dc3179b3mr141350b3a.46.1777315329976; Mon, 27
 Apr 2026 11:42:09 -0700 (PDT)
Date: Mon, 27 Apr 2026 18:42:06 +0000
In-Reply-To: <CAPpSM+SbRsFUd9jcP81K1VmhANhT7uzPqOPmy8i0gZ28ctjQKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAPpSM+SbRsFUd9jcP81K1VmhANhT7uzPqOPmy8i0gZ28ctjQKw@mail.gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260427184208.161981-1-kpberry@google.com>
Subject: Re: [PATCH 6.12.y] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: xmei5@asu.edu
Cc: bestswngs@gmail.com, chenglongtang@google.com, joneslee@google.com, 
	kpberry@google.com, pabeni@redhat.com, rnj@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 459F3478C5E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,google.com,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241425-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kpberry@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hi Xiang,

> I was wondering if it might be sufficient to apply my original
> patch instead. I=E2=80=99ve also checked against 6.12.81 and didn=E2=80=
=99t encounter
> any conflicts.

We tried applying your original patch first, but, while it does apply
cleanly, it doesn't compile because the version of bond_xmit_broadcast
in the 6.12 kernel doesn't have the slaves_count variable introduced
in ce7a381697cb.

> Could you please clarify the need for the parameter bool all_slaves?

We had included the all_slaves parameter to try to reduce the chance of
conflicts with any other potential backports from later kernel versions,
but I agree that omitting it is probably better.

I've sent an amended version of the patch which just adds slaves_count,
uses an explicit loop, and applies your original change. Tested the
patch by compiling it.


Thanks,

Kevin

