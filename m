Return-Path: <stable+bounces-227206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ULr4C81su2kMkAIAu9opvQ
	(envelope-from <stable+bounces-227206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 04:26:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CA3EB2C5731
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 04:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88D133026322
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 03:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C831B377039;
	Thu, 19 Mar 2026 03:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejJRH+TR"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDFF36895C
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 03:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773890709; cv=pass; b=aWx42HqYUoGJLYqwOxpPanFS28HpJ0dcEV93N0LowcXdaUXczv5sSbuXG54zxO5Zc3IEClYZGkZM69HvremwP0t4lj942huoaOUe42RcZdCUaxUHpUVEtBwqIJHH2TxD5+vCqE2lrbgDRNZnMtfZuxa6WFLAg94Uy195YWPvq3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773890709; c=relaxed/simple;
	bh=EoxVk8snN2R0HXndJhx0GkkyTWreh6ieEsqLrF2AZDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q6G/P2lRKNfDzBj5i0fb75cpi/yyvsped6thLcBeeM19PxZfejbpkp+nUIlsEF4crMtqA1+z3UCkRBmBiZlgXHZWcQZmGpYSmdKes6Ra2XVW3wQ3vFCNuJJWeAtSTHZmE+SgLINM3XHiYOqZRkGm7f+yyCQv1dttKK+ygeyqv6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejJRH+TR; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-79a5a37113aso6294307b3.2
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 20:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773890707; cv=none;
        d=google.com; s=arc-20240605;
        b=RHuPdJI9YiM/r0bdRROoHHvusSMWgdRKnkQC3jWdtCB7kC0euxUkDc1gqhxay1nw5P
         gSN6P9gBUp+ZCBu3zYvbVzdJHTYT1SeW7w9CCjvnXNCZjyHoV/lrXW/xhUaJBYa2ehyu
         BSLNeFx+olyC6OAnPNq2V/rRmHsooxuDwjDan8Jqs5DJXUXYAYwC36Gl7pBkTAzZodAM
         jhTl9abdGQ50C+vxUKl9VszH76vdd1JE1ROOz3+B15YQmOWAFVkt3Uc1FrLSMUTJU74i
         FAZjkCPNSikXQ7Tk7CWlWyckE3b6OKIEqsVEqqF4e1GL7zcdB9h/FKIU9DKhSgu0rAVJ
         UmWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=;
        fh=qcB2sUVV3EiZTPsztVhPvR4DyZxuYj82oQGY8/d8MCE=;
        b=jP/m3mb0LDLhPmwfFunyIOdaJmKXdowXKujOneoxPQ5A0qDFk3UF8H7ZTXSSaufjQM
         xuti8exA855vidXmTBux4ps4pKvgb2PhNt9yQu06kMV6e/xXvBIz/QpI5BkF6IKf5YIc
         sd6fRWEh0rfTOuxZjuBpg/8h4gaWq7qAYuqEsjMDOM92cJHPdxOlqMXj9lf44Pca2NE4
         EekkxAUg5EWjf6nZ8qA1I54JxcyN1HwPf1e1MjeAr2ZO6tt23S3W8ATB0rgmyAOM0V3x
         VPBC6vVML40PvMf9oEo6XBZknNbd+m459OvyiAZMyVjJKv/yowCTpsnAdCNRQA6CG79w
         lP4A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773890707; x=1774495507; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=;
        b=ejJRH+TRvQ5gwRBM8zckcHgjeGHwZXvzsxthSSxibkh2grxLSad/jhLf5HDGA+HvI4
         NnfUf/r7uiFG8esTkTWYZiZpRPVzWh2UZsFeREG+61yyRdr2D+w1cZ4X3aiNB80PnLCj
         nrlqmAS/WqDVHwwgp49PaKNV4fy0FRIM9mBhX/ZcU1FQMtsQhWNPV1vfTW6Exm3HQMVf
         0NIzSRZEGJ5mmEIaYOC4H9ZfsbOh+BtsxvLVV9UBb70uif5PVtZz/CeNuTJm3N6S44qa
         hFvZ4TviHSWomUPg99f77wKx+I+6tkq9uPk3CwnvM9VDdPqy3jRbtMaAU0FvHH6MdrO8
         FoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773890707; x=1774495507;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUbY5prU9XTeY769c6qtwA4RxNc+IoHQBZAlAlVIU5k=;
        b=Ea0B7DFO4c1E6VJT2xEvJZLfvcWXc7IgRirCxAc+IgI0mAmUG8l8O0kL7124mGVcdJ
         H6LpjnKoiHkLR3VGisf7IS33UAesR3zsHcSkChVYuCizjzndxJFLm9Erog3cCzwA0jUs
         Ffr0f/0i1UYv/XHIJ6ka9e+Nke+mjDqL1lobX9FXtxVNgbtqaHhDRtwgPjdHGWzTJaPj
         9JXu0tgPQ4sk9h8q6f/yO/vZACI5DLlNk5ao4dh6guBFvETeyrlCyY1SYQNoVhv0+GTs
         qhdPJAYDfuerY3wpQz1kqNeBoMJRvxbI6HWZigrQtOsAJ3Lya+qJ/CtQMJBdioLissLi
         VscA==
X-Forwarded-Encrypted: i=1; AJvYcCUjX5E4+Kowcz+DjGuX7hJCLjCx1fDQWD459Jmh4LTF7/Iy4xPlTF7zQIofvSvjpPJthjjTUgw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/yCqfCyKbB3qj3o7kTZ5FlEpwroaSQMAK+aL5vUsj/6VvhsZ
	h4aWAaRCT8S0LptJlzMG9uDPkgn61rMhiqZRZ8voo9QOVDIJQORKkY5Vwy5VoUkk272/vDrFWas
	KeTFJ0gDXPDKbkQll2d7XwhoH+74dWWuf+O6Oi2QcF8XI
X-Gm-Gg: ATEYQzz8pDIV4ASAi8nKluJ4+Y9JMFi9lXjGBE06kH9H/7QzoUDBsz/sKfGVnLfZ7q7
	QD2UmaoZVltHjcJ2CJk6NTiJvN0i4kfRf/eYznqlo4HLueeMIdd08KLXjxxOFNcCqBjGeO1SEWi
	HR42XFDnZzoUeqCkqD1nOwuX+cLZjwV+3a+MIWbowc99xSJMlHKFqIZ1fC/659plUCTMC5lY2Rg
	V5QQMYEAKSXZpQppKQeRfJ63yG9ddZ6kYegT/XKxVAFEExwLicV0NtLlCHGImDzWHLcP5G5jvHR
	9opphzI=
X-Received: by 2002:a05:690c:ec9:b0:79a:6e1a:3f2f with SMTP id
 00721157ae682-79a71834809mr67186207b3.13.1773890707339; Wed, 18 Mar 2026
 20:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319022335.3213311-1-zzzccc427@gmail.com> <20260319025710.GA357817@sol>
In-Reply-To: <20260319025710.GA357817@sol>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 19 Mar 2026 11:24:56 +0800
X-Gm-Features: AaiRm52go2qevgYqXTn06GleSzroBKX_LMCPd09ZGdoi0s8xlATO5QEwKpO4fM8
Message-ID: <CAFRLqsUSiS=azce_Q8AB1J=eZGsknorSaVJW7qtSTd2czY22ZA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: annotate data races around fi->i_flags
To: Eric Biggers <ebiggers@kernel.org>
Cc: jaegeuk@kernel.org, chao@kernel.org, baijiaju1990@gmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227206-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.sourceforge.net];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.955];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zzzccc427@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: CA3EB2C5731
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Eric,

> Is that really the correct Fixes commit?  I don't see what it has to do
> with this issue.

You're right, commit 360985573b55 only remapped the flag values and is
not related to the race.

The race is between the lockless read of fi->i_flags in
f2fs_update_inode() (from the writeback path) and the writes from the
ioctl paths.

The read side goes back to:

19f99cee206c ("f2fs: add core inode operations")

which added:

ri->i_flags = cpu_to_le32(F2FS_I(inode)->i_flags);

I'll fix the Fixes tag in v2. Please let me know if my understanding is
correct.

Thanks,
Cen

