Return-Path: <stable+bounces-27117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C4A875840
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 21:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7263128231B
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 20:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F6E1386CA;
	Thu,  7 Mar 2024 20:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I8hIznqe"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9505F1386CB
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 20:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709843120; cv=none; b=AZhisylaB5axe8qOosad5Q9ceBCSSOJBiC8gAB0z9TasK5MFJFYJ04VigPMQNR4lIeCRXJzYbzfA+Yt/5uqxBJqTG4uIoNaFCpWmtClbDiM2chhhCk7mu5AVPTXps0gZSwIiBT77yqtjd46mIRjqYjdlIPLIYnpiwCMtobZj6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709843120; c=relaxed/simple;
	bh=wcksxAH5d0LJpyAK9834DF91YZ/vlDby1Av24OrRNTo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hwU50kmh0DZEeJ434irEBaCRN2a52kfWxNhtIZYsHnfvw4FrROci0DtWIRa9NIvMbh4Fq/H5lDWU146Ob6SUprC1Z4tFsxJF5AtJdrkzych76pRpl5Ve8GX9g9N/BgcbB2nYvcejSl5yohNyk0/9TW+kfGzlxXtq9e5qLXApZBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I8hIznqe; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-29905ac5c21so118619a91.0
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 12:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709843118; x=1710447918; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wcksxAH5d0LJpyAK9834DF91YZ/vlDby1Av24OrRNTo=;
        b=I8hIznqe8bNwUc83m62NzKtqkmnGCZdDM/BJgbJwDAYH3C9tEUiQ4ifF7cbgi7klav
         BovN5hZb7+xhNdEKx1vfiKowafs3HC76/I/x5ZaUtBmpCEL1mGtpPLfMfJKqzNGU+b8Z
         OmjQNBpUHy5f9cZRbvGILEXmeY/yGSxuszqE7pAiloD+U8XekSG+PUKC07CSqLUEUtXa
         zAdq794fIBp82vSLTtruVfwXlhWJA7a3MscznB1/Wis9aDsaUcdwKUVCAW3zPm9vN8zo
         7wNLp+D+T/IjidscDkOk8aiIn7cKdIBt6Ymuv/+CqcZa87mJpcJ9X0nxcQO9eSJh4B7o
         vKKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709843118; x=1710447918;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wcksxAH5d0LJpyAK9834DF91YZ/vlDby1Av24OrRNTo=;
        b=fjdfiu3FSK0U0ijQ9yW2aM9EeavIBXLoFDVKm+3HJ4h3Ucie1yhm649H1vDEd0NUUI
         qxvyPko3WgqJPOpNBp0yTJk8ESLN1h57g96pboAReXoVHwzd77+ruAUW17yiiF5O/FOt
         2TYS+855aDaxMkM1uDySB0vWY4a/upIHImZ+3xJuX8POBJd4jj5KkePmYBKrV9FA3E0f
         1TC0n37OA5aVmL5SSVVUGKV8hyUl4N0DL2vGs3H+uCYvS5S21U4qX4opG6nRqm3yUjei
         IqZMFarjIrhClkrrfjJhH5At5KfcG6vE3A1oDyW07+lMDSMxaMDfa26NC8cLyEiOEjch
         8YWw==
X-Forwarded-Encrypted: i=1; AJvYcCV8i2jdfBXOMY8FeiCaIZ5AO1F006E2w5jVvHc0x7E0j1JMIqT2JC8dbrBB6lfuOASex0uEcB+tvviWuLsvVjwfltCXOuAQ
X-Gm-Message-State: AOJu0YxMBhRoUFT1kPYrOl0GBmuYBvkgkPgPSRD6MhLP67fImsOYgWZU
	ZFgom9GFSvRIZ9U51183rK4LvqMhNWbzN6iuk45BKZtAcNZd5aotRSzqKrsIFC+klA==
X-Google-Smtp-Source: AGHT+IG5rhxQfiUQ3FbNS7mxcQgFCmb8lQ87KoIdi96NuNNVpEPDAise+9SzpwE/tXgKxUgupveBRao=
X-Received: from cos-rnv.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:81d])
 (user=rnv job=sendgmr) by 2002:a17:90b:4d8d:b0:29a:c853:6a20 with SMTP id
 oj13-20020a17090b4d8d00b0029ac8536a20mr51731pjb.0.1709843117685; Thu, 07 Mar
 2024 12:25:17 -0800 (PST)
Date: Thu,  7 Mar 2024 20:25:15 +0000
In-Reply-To: <2024030739-untidy-progress-3db2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024030739-untidy-progress-3db2@gregkh>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307202516.3162736-1-rnv@google.com>
Subject: Re: [PATCH 6.1 214/219] mm, kmsan: fix infinite recursion due to RCU
 critical section
From: Arnav Kansal <rnv@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, elver@google.com, glider@google.com, hpa@zytor.com, 
	mingo@redhat.com, ovt@google.com, patches@lists.linux.dev, 
	quic_charante@quicinc.com, rnv@google.com, stable@vger.kernel.org, 
	syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

I was initially interested in backporting the commit dc904345e3 ("mm,
kmsan: fix infinite recursion due to RCU critical section") to 5.10 and
5.15. However, this commit does not apply cleanly to those versions.
Additionally, it seems this commit was intended to fix a bug introduced
by commit 5ec8e8ea8b77 ("mm/sparsemem: fix race in accessing
memory_section->usage") in 6.1, but that buggy commit may not be
problematic in 5.10 or 5.15.

Thanks,
Arnav


