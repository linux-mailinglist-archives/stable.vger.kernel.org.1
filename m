Return-Path: <stable+bounces-111271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CD6A22BD1
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 11:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA2D41643CD
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 10:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409881BCA0F;
	Thu, 30 Jan 2025 10:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="knM7JQPI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649051BEF97
	for <stable@vger.kernel.org>; Thu, 30 Jan 2025 10:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233511; cv=none; b=fme2gCcwzj+IgYvLdEIH9d1qK5rE5mCIsabLAPmQgVo2BXWSqIxq/Vxj4uvxW/keQdC8zNgWxdPWEjb5wV6KcP6253osT18Vdp7uWJt5AFtkAHvt+9TbG1COsYCCLgQ1XRfbZoftbiOQNx5m6C2ywx8yoX5krTBf5v8SmPCR93I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233511; c=relaxed/simple;
	bh=tGrCZ4ndsDoz5NlT/10Tgmu9uj0zdaCYVUdOZfiUBEE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eXniKq/PTkro5tqnc4MKShI+waAPcD4cvaOV5PWd+5fvvBRac/LAecbdl4iL+vK9NAv1jW62e1R8F9B7c92X/MBQLt8MS6SEijyKvO8gR++u9ersu/fkhofCuDYjDqftM6V09gEFC32pkSMjdI/m7nC172axEAUMjzhGEPVVR40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=knM7JQPI; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ciprietti.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-ab6e2b653a0so60829666b.3
        for <stable@vger.kernel.org>; Thu, 30 Jan 2025 02:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738233507; x=1738838307; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xxVf9tkLPmTrxs9X10h/QRVbx8eycxkvI5Qr31UJqfg=;
        b=knM7JQPIIhLIFUYl1mHNk2vQ0hgPfwzu/jWcrt+5FqZM5bmQ4wDRakASvRpnsxeWFP
         mjVTitGttiAfp+9I9keXWspXoMfnHbgE31Rm13fcF2xLxSpbGA6aKcBJxyRU6JYKSdcp
         ogkZFpiSaj4zqlQ6mYkURtw6hjdjHgeCO0foemdCgp/XCbkdI92U+AUFIlHYWN9y8IsZ
         zWw1yoVy2t/4HHliwmRNHYmS42dEfx26pss5U6s8Lz4i5tbhXwRr1UWF3qyDxfJ+4ndk
         SsmSML4u684LBrq6SYYFmcyDRM88MX3lhL8Mi4rOVGMQwkedQADVUAjub7EA/C6+6zSQ
         A2fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738233507; x=1738838307;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxVf9tkLPmTrxs9X10h/QRVbx8eycxkvI5Qr31UJqfg=;
        b=T3Z5uK/teGPo64Ld4CvyhqQt8V0BTE9Sfk+qjZzg0mshgupl8iy3XLGri1vLp2ZAuS
         74h9KqP5sEkfgUL7KyI7gIX3gMmZZ2N+oXbkkhL4ldg+UFnWWqfaEfX6QHSyk4vTSHqO
         VzMORjQGKp9mBRP/1uMC41M2P1nuTGhjMNsrE8RAmoUzLffmYWFla1/5PzLDsinsPBLz
         L0pq4hSFzaLRoxJW6aO09pxRG46mIXNcOCU1vc8nWkDFw60/cmw4X/+gBKt0gEreV6mQ
         ANVfG9ILhkxn+jhNuTgMwPg5I6MkAsJL62LsNsnA6FSapsUZwV17xVIwVZG3KtE0UxD+
         9h3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVsu/NxPG/299afeNhUt6PfIliG8Z7DDIdyFSqebIhx+XOgPFZlGzVD4floUY/hO1RLqV8sLtU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmS6aWvhQRhzYB6e9FYPD1uxE2Sbuhdy9Gd/zmy2vKQhDiMn8
	9euLfNECJJ01+1st17oJnG6bdC3mf6gct4uvfb3TSJwgQz0kkhLS6lTU+etzNaoA+WKOi4enzy7
	icB/Yru1pksqWOQ==
X-Google-Smtp-Source: AGHT+IGc7/emACZyVpUR6cdJ2jr4gQDwP/J0Y2a09pTQLgBcA0sDodoiESTHS7czF4qmDSYw9+OeIVdPcL2cfV4=
X-Received: from edbes17.prod.google.com ([2002:a05:6402:3811:b0:5d7:d679:3926])
 (user=ciprietti job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:6d0a:b0:aa6:7165:5044 with SMTP id a640c23a62f3a-ab6cfdbdd59mr609194666b.44.1738233507704;
 Thu, 30 Jan 2025 02:38:27 -0800 (PST)
Date: Thu, 30 Jan 2025 10:38:12 +0000
In-Reply-To: <2025013020-carefully-jailbird-640d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2025013020-carefully-jailbird-640d@gregkh>
X-Mailer: git-send-email 2.48.1.262.g85cc9f2d1e-goog
Message-ID: <20250130103812.3955746-1-ciprietti@google.com>
Subject: Re: [PATCH 1/1] blk-cgroup: Fix UAF in blkcg_unpin_online()
From: Andrea Ciprietti <ciprietti@google.com>
To: gregkh@linuxfoundation.org
Cc: ciprietti@google.com, stable@vger.kernel.org, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Greg,

My apologies, I didn't notice that the patch was already queued for 5.10.y. 
As for 5.15.y, it should be already merged as commit 8a07350fe070 in the 
stable repo: 
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=8a07350fe070. 
Same goes for the other LTS trees up to 6.13.y.

If that sounds right to you, I believe there is nothing left to do here.

Thanks,
Andrea

