Return-Path: <stable+bounces-27108-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09520875624
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 19:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B71E1287B25
	for <lists+stable@lfdr.de>; Thu,  7 Mar 2024 18:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7BF12DDA2;
	Thu,  7 Mar 2024 18:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sh0d++Lw"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0809012FF95
	for <stable@vger.kernel.org>; Thu,  7 Mar 2024 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709836404; cv=none; b=FSHkPzwFLYKMxO4WZ0hiqblQxigDbhY59vPXEiVdE8PLDBJW6gKOc8A0l45WyPsgpa+NKJWwyr867lDnDlFYNBDI3Nu2KoSXwik171w9j3R5TBnD579E9kZGfBTWsXKxssMrkDLScC+PSuhax6jTNa3LjJdqxODxobgdPF5zbKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709836404; c=relaxed/simple;
	bh=KLLXUGdLronzj3ejPe8s3lsBNaclrlbLXPaIQweRWfc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r0GcMSxmgnlUyXKlYDPeS4wnG0zShGcUutliPJ8QzP/Yk1Ui+KAOuyM6gCwGITK/VKboRFXhn+nHqaFFRR/v+wyakFdaYnDqVhsqrBKdw2hSixHMlcPRd0XJq246cw9N9cXYFWbQLauxtUuTRAXK6BhfdvaP+z17xN5PmEvkoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sh0d++Lw; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rnv.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1dd5b840a1fso4821785ad.0
        for <stable@vger.kernel.org>; Thu, 07 Mar 2024 10:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709836402; x=1710441202; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KLLXUGdLronzj3ejPe8s3lsBNaclrlbLXPaIQweRWfc=;
        b=sh0d++LwfEAnId/KJFWYx0SYLIkGQDWVqPRtSPKtNl6+zrYO31yi+iO3veE4pULxLE
         VmdC8ea/vcQd4j413tqgjC3GODt8jHDqZXUBIZZSs2FZjS67qkI4aUPwUa9fRN6R8v1s
         5cfojxC/mIPdsH3w6sAJeY3WxHTxElCLewfei7zIghSAxNeyzgBEHRs70KuaIknDby7Y
         Tm/drFks7pDkFxG+3YtV3hBo0GwtRis3qJ/0IQfTOL8Of292bRrvYrYGWO2q4UZAkmjr
         K43k6kmTVPzJhKrTbVDaL6gP1E6rWLIrU2Jg8x9qay1c0mX7JbzV8qY6TbRygQBrfUL6
         UG8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709836402; x=1710441202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KLLXUGdLronzj3ejPe8s3lsBNaclrlbLXPaIQweRWfc=;
        b=HnixBmJOytehW+aHXCBy0K5ipm/kG/cO0S5iDeHWyk2rXr1dRpbi3w5NW9F1twfOSc
         qjMbp8O74VKorzhChaqsm1lbb/fgAnv6eATaIOBzjKaY4y8V99uRCiKhP597QBckErdg
         Tvg3iSAXWiAVjgIiAW3aDMM+cz4k2ojlzRSAokstEVb7Da+uONVEdO1Lc1/EaRCk3xCk
         ONVVHFgMij8/4Bw+79fcHQbnjNC6V06wg/J6oUrBIkUxh2osKooSIgEnM+65zoFgjv5C
         2YSZNpLGcddsxP3ryqQd846g1Po/iDIFnck3RfZuOahzOR3f5XDch7QEBFvDP3KbQDkx
         hOrw==
X-Forwarded-Encrypted: i=1; AJvYcCUaEVZVhOiRR071gXppLmBg1k8ioPn2DuLR75DWg2NJTx5lC53k/nVsEv9pJv7q4OLNXsr2R4vcYPi2rjnVIK3ir2scYC8d
X-Gm-Message-State: AOJu0Yx6CjYUpOFZzKeFzE5sK1myRdZ33FOkYQ9xMP4I+nwk4JOL/h79
	xAJ9eBeNY2cyv9YsO4CFldGLCTFQNj7BgeFzgeaOglzXTkp2MHI7VxGtmU/64H0J0w==
X-Google-Smtp-Source: AGHT+IHi0zsopCbMj/Va6mRCdbqMpzYhdNm/8OUau5xudJeT0+fgAQxWhf40kFU/pU9yCLhbT6ZeUEk=
X-Received: from cos-rnv.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:81d])
 (user=rnv job=sendgmr) by 2002:a17:903:2847:b0:1dd:17ee:c423 with SMTP id
 kq7-20020a170903284700b001dd17eec423mr4597plb.4.1709836401065; Thu, 07 Mar
 2024 10:33:21 -0800 (PST)
Date: Thu,  7 Mar 2024 18:33:19 +0000
In-Reply-To: <2024030457-aware-trusting-9e48@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024030457-aware-trusting-9e48@gregkh>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240307183319.3146300-1-rnv@google.com>
Subject: Re: [PATCH 6.1 214/219] mm, kmsan: fix infinite recursion due to RCU
 critical section
From: Arnav Kansal <rnv@google.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	dvyukov@google.com, elver@google.com, glider@google.com, hpa@zytor.com, 
	mingo@redhat.com, patches@lists.linux.dev, quic_charante@quicinc.com, 
	rnv@google.com, stable@vger.kernel.org, 
	syzbot+93a9e8a3dea8d6085e12@syzkaller.appspotmail.com, tglx@linutronix.de, 
	ovt@google.com
Content-Type: text/plain; charset="UTF-8"

It does not apply cleanly there. It seems to me that the commit (commit
id: 5ec8e8ea8b77 "mm/sparsemem: fix race in accessing
memory_section->usage") is not a bug for 5.15 or 5.10 due to the absence
of relevant KMSAN bits in those branches.

