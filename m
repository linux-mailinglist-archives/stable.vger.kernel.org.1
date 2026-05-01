Return-Path: <stable+bounces-242233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEBxM58X9Glx+QEAu9opvQ
	(envelope-from <stable+bounces-242233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 05:01:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6414A9DDE
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 05:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7002F3019906
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 03:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8CDB2EBBB7;
	Fri,  1 May 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PriSyPY4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2FF19F11B
	for <stable@vger.kernel.org>; Fri,  1 May 2026 03:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777604504; cv=none; b=bWWZdxzoLGi++3yyREVF8EoRuasLnphqeieBBCyApXBwgVSDES18K2kDhcb3+gnpWvEfcSPNujjYPsxzCMAlc4oHyzYkOVmlrPRxTevhBfGIBt0JOGD7QXAJ26wypTuRTei9Kun1REqBRpqFZi3S3d2lP7GdEyY/jcmU6KFcons=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777604504; c=relaxed/simple;
	bh=2zdWrY87j65xBnMHItwSK4ZtkUkSeYSCDdievMvYSgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDA5z9XMYZpjiqYoRvkAQ7IMZtWvcq+VTcT3VoXsXdc/Ke7TpWX9ThZfUCWLvS/5kg5YBsg3soDg8xXoa+rp77duQaW5XsgN8gMVUJp0WomL5DG4en83zePdwmwQSOuavdLV+62Vp2hty16QtKZBg1Rv4rPZ8lWKhSfpHTrmhrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PriSyPY4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D69C2BCB8
	for <stable@vger.kernel.org>; Fri,  1 May 2026 03:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777604504;
	bh=2zdWrY87j65xBnMHItwSK4ZtkUkSeYSCDdievMvYSgY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PriSyPY4X/eBn26UcTwITTvyTHH1QbQ9BM0CLAF3bLggaGp8y3hAtJVYLmuGPR2SI
	 50T+CRqvvFwOF6r9W0FXLP8U1RUtEkBJ5I0Fs0v7nT+pX1ZqKZuNVF+Bj33ARYFptY
	 7dwib5o5KJ9Jj/Y3wHl57VNXvg0eqzU4vGY6j8FAkmzcpoQEp3pC36cGFnh6yTO64c
	 /LvyEVZpH+iMJIpgTAzDe1P5KcxiZq1eqyidyPiMuZr+dxAUl3wpGcBDyf4qoT0b5R
	 yaO0F1ROO2vEavQeirReZdM1jPrli5venvQVY480sRzqxbUvKXAz9AYtrXunwgTXt+
	 zfeoEI3qsXWiQ==
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7982c3b7da9so15226227b3.1
        for <stable@vger.kernel.org>; Thu, 30 Apr 2026 20:01:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9MvAcLu1FbF/+tXn2TrhT312i7oD6pLuG/w4p262nLwAvorLTesFCIzC88QUeMQ/QrzZSRQMw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+z0qz95iNDtS9Zxj5Mdn+Nui8y6Sa1PUKOeISwc+6QcYSXcrJ
	Ibj6mnsiRWMAhrbKOCXf+UCqE1JPAtQA37IfJpu57wFPlR/jeQVj2d1ebZXM1y4zlcmySjdxbXJ
	HvgR9+KUKaYFwYYB2nRkx0T4mi8KW8yl1dis5DWKoHQ==
X-Received: by 2002:a05:690e:1381:b0:658:d26:d8cf with SMTP id
 956f58d0204a3-65c18c85c83mr4753063d50.23.1777604503446; Thu, 30 Apr 2026
 20:01:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430232851.236666-1-wnliu@google.com> <20260501000059.262516-1-wnliu@google.com>
In-Reply-To: <20260501000059.262516-1-wnliu@google.com>
From: Chris Li <chrisl@kernel.org>
Date: Thu, 30 Apr 2026 20:01:32 -0700
X-Gmail-Original-Message-ID: <CACePvbWJTk-dTuOP6owxiUkh6HfRp7AWGW9KMJVFtdABmw==4w@mail.gmail.com>
X-Gm-Features: AVHnY4KS8noUTYIFJB1xZmFbA88r3mKCmhaLIyZbJuxdfsmwjkBoTi4_Qy9-6do
Message-ID: <CACePvbWJTk-dTuOP6owxiUkh6HfRp7AWGW9KMJVFtdABmw==4w@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix precedence order in set_dte_passthrough()
To: Weinan Liu <wnliu@google.com>
Cc: iommu@lists.linux.dev, jgg@nvidia.com, joro@8bytes.org, 
	patches@lists.linux.dev, robin.murphy@arm.com, santosh.shukla@amd.com, 
	stable@vger.kernel.org, suravee.suthikulpanit@amd.com, vasant.hegde@amd.com, 
	will@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 3D6414A9DDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242233-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chrisl@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, Apr 30, 2026 at 5:01=E2=80=AFPM Weinan Liu <wnliu@google.com> wrote=
:
>
> Bitwise OR | operator has a higher precedence than the ternary ?:
> operatior. It will be incorrectly evaluated as:
>
> new->data[1] |=3D (FIELD_PREP(...) | dev_data->ats_enabled) ? DTE_FLAG_IO=
TLB : 0;
>
> Wrap the conditional operation in parentheses to enforce the
> correct evaluation order.
>
> Fixes: 93eee2a49c1b ("iommu/amd: Refactor logic to program the host page =
table in DTE")
> Cc: stable@vger.kernel.org # v7.0.*
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Weinan Liu <wnliu@google.com>

Acked-by: Chris Li <chrisl@kernel.org>

Chris

