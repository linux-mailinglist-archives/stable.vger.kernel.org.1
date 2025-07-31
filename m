Return-Path: <stable+bounces-165692-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541E5B17795
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 23:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 390AB6200A7
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 21:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5C0260587;
	Thu, 31 Jul 2025 21:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koiWbp3A"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171AC25F79A;
	Thu, 31 Jul 2025 21:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753995750; cv=none; b=jGWP/+pb+8G1sWfYvTJeKgGvPom3Bwy+paqbqQo8R+iMbq9L2sr6KTi7yS+EpazDEcfMcIr0IL4Kt3YLONkYKNBkszqJe//pZtdiLWSeInsjSYLffSn3fv36ScSPJ2mgmCK4McLzL+X01ANZNjl7LA9P8qaI47tPAi5ew6RaHXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753995750; c=relaxed/simple;
	bh=XFxsUeF+zq/mBVLsJMPjwE7rt9e6GZnVzTsOlyRyTQA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=Qm/EslfG65mtgsOJlsZLXraGr38i7HUVgwNKcut1OTryPOEydQApjuTURwHS147sB1cYjt4w3PNoWW34AVrviE+DChERiexp/W79PvVbsC4YC/Aj6WxK7jTstGxyph1Ewn/ufoLa8cVhWhmtxeiDVH3n2eTKjUuwAu0EZpb0DS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koiWbp3A; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e8fdbd45e10so629329276.1;
        Thu, 31 Jul 2025 14:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753995748; x=1754600548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVFyIWtKdA2NqJ76tkI6J64oKLKpACgR6gAjU1ZAd0w=;
        b=koiWbp3AVXEvoSlsQB9QOFJHLbFM1k1Xupco8AshgHKWVyWgu5aQG5TrfZEctohTkA
         sWJZTvIHIjcIrRYxAQqCwmCoHbHun+HdfUoFdtxwLJh1AI74t4KzmxdwOuExWCMUpdnR
         cFuaxulrr1ihcOPH9wRA4OToxLVDxVjJANRzo05PjQYAXE1C9h+r8gsuiPuOApLqeJQa
         YsASE7p9UGHpwLXYs4+oj470jm7+tWjdFL6//Bau0Af2mCdGpN6Wt546RdM+j7pxGEWf
         1SQ3mvk8JsNCbXHsDnJ3VoKay0xQHFGr2v4uHXYyVgArEo8oitxJwiJaL/FhlaZDwexT
         Kf1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753995748; x=1754600548;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lVFyIWtKdA2NqJ76tkI6J64oKLKpACgR6gAjU1ZAd0w=;
        b=MYduPyHCT4sQ3vsECVc2WV1F0CuuJmvWlRDpOgB1vUEaxPECTnXrZUABqgRP+bsxuo
         Ewr1ck2oO1KZ/UQsl4how/S/joUOCqyujqsa556ZIsxpG1M7D9WH6xdcpEl01paIZkkd
         k/IhrPlg69Q/29Tth07BO7ChWtPcjJ2Iz/spVo06nArB8HHs8LQfAQkPi9iRhPfo0cGt
         TLEVlbjaXVlKJUfo85I1xvIeW3EHAT5QSoZQJztjzGOIZhFw0CO7DvXzoqZV0P77OksD
         A+VxzWE/okgMNrDxO7bGkuF1wNGA0QveUOYCDVvSO0gimSqewghN9rYpGQnp4LNtiv/Z
         WXWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUENxNIb8xGTaAiK+jcrDjQfaDaAsoWZKzN2PU0fzcnPQVIt18/O7lhIqKzTb3+luhp1sXo1Mw=@vger.kernel.org, AJvYcCV3Q48f8I2xmfLEJSxdbNJPyceLRoGu8UNnJv38KyvgZVkW3vGetsiXi1XXVNIpjfu/qHuulizU@vger.kernel.org
X-Gm-Message-State: AOJu0YyTsMv8OhwZZcJonQ6BUbVL2ba5RJlDxsdfWxMt6JIggHH+D4HS
	uhxFX0cM24CvVv/uVR6jhO9ekaJdUOAL9NYOJvobH0p//kYigXndGCpx
X-Gm-Gg: ASbGncuNfRWGt0qIKPWy6bQWanX/ndJogOSYAAyfdQZ0mNedXNVO2Ccjxonwc/AX8Bd
	C35kOBjgDGVAk4YN0a3uiqmz7lSz/r/Zr5v9nq6qjC/IiHYZGd4TMZ757o6Px9CfIMlj0B/qILB
	HIEC6lAeZEDFqdRTuWFEhugOmvMrZHtakmDJ40/HZ19tu50eYMwex+M26sVFResbgxiHC36D52R
	KRyERVbNTr5ozn6czL1ekYbvHnErcrmf5HDFNxVnHDNHEfcyGiQjQz2Ol9mqGVzskMlq54EchCE
	SoWNfjBK6vQBMDWc+U5k9WYI3U9FboaAAvtn1spWCPvQUmyS6/aWmHPybbL0f58ttzv1oPKZ9mL
	JdjwxMxXKYDF6gv2mA5octu158FFGURNeTLkfe8XP4CGqFYv1TAQWdFTf0fEECePG2esFXQ==
X-Google-Smtp-Source: AGHT+IG/HhrjEg72oQ+ecwdbKzVh8c2dmRnWi8zHYxBuJVMMJwqcvylkoLHxr6hanJE6obV3fWqR0Q==
X-Received: by 2002:a05:690c:650e:b0:712:c14a:a388 with SMTP id 00721157ae682-71a46521a94mr114446507b3.7.1753995747918;
        Thu, 31 Jul 2025 14:02:27 -0700 (PDT)
Received: from localhost (23.67.48.34.bc.googleusercontent.com. [34.48.67.23])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-71b5a3a9a9dsm5976367b3.10.2025.07.31.14.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 14:02:27 -0700 (PDT)
Date: Thu, 31 Jul 2025 17:02:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 Willem de Bruijn <willemb@google.com>, 
 stable@vger.kernel.org, 
 Quang Le <quanglex97@gmail.com>
Message-ID: <688bd9e3db0_28448c2941d@willemb.c.googlers.com.notmuch>
In-Reply-To: <20250731175132.2592130-1-willemdebruijn.kernel@gmail.com>
References: <20250731175132.2592130-1-willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] net/packet: fix a race in packet_set_ring() and
 packet_notifier()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> When packet_set_ring() releases po->bind_lock, another thread can
> run packet_notifier() and process an NETDEV_UP event.
> 
> This race and the fix are both similar to that of commit 15fe076edea7
> ("net/packet: fix a race in packet_bind() and packet_notifier()").
> 
> There too the packet_notifier NETDEV_UP event managed to run while a
> po->bind_lock critical section had to be temporarily released. And
> the fix was similarly to temporarily set po->num to zero to keep
> the socket unhooked until the lock is retaken.
> 
> The po->bind_lock in packet_set_ring and packet_notifier precede the
> introduction of git history.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Quang Le <quanglex97@gmail.com>
> Signed-off-by: Willem de Bruijn <willemb@google.com>

The From: author attribution is incorrect.

I will resubmit (after the customary 24 hrs).

