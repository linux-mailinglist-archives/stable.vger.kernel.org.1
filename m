Return-Path: <stable+bounces-200968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F12F3CBBB42
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 14:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 57B18300769F
	for <lists+stable@lfdr.de>; Sun, 14 Dec 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B82625A359;
	Sun, 14 Dec 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IeU8RZ4j"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E01917FB
	for <stable@vger.kernel.org>; Sun, 14 Dec 2025 13:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765720485; cv=none; b=Sm3AS1zope2kTmguScoTrx95O3OuXrlaL5TtX2DdtjUVzfi33j+7usIPt93Ut+ITKHlH9oKBY28XmzR/M/K8T1+lGksL0WxVGe3FQ1hzqRLqMEeZMZ1UlbjBs+My4ftninC6uOI93jEXdmOl4oj6nHkWGOjMSCWacghhdzZ3Xeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765720485; c=relaxed/simple;
	bh=PjGrwWZV81DPFzMQNA4x3xriIjb0S8YAsDZbn2pcA6U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R4HAQFQaD8LiZZr2UlkMwduWQ8oWtn8XeTpL8zPGpzoMp1Ceh20o0SPbx8xTnf3zBK831ZjUEN3hIJsOARL6u8iUHakaPHyvN5DuELL/iasTWxQHDSjH9pDZQazarx2YeoVz0KVqmazXVreGaQ3b4WZ7xcT45dABH2O2mFno0Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IeU8RZ4j; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47796a837c7so18788465e9.0
        for <stable@vger.kernel.org>; Sun, 14 Dec 2025 05:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765720482; x=1766325282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A27ILOHpvAtHnE+6lvnDEAst4fggOFaoxUBA4wWZFjE=;
        b=IeU8RZ4jvC+WmapLF9dlbFIqlZbg18sWO66y0ieYZj/Ak4RFOZjMZhWNhuRjUdEBE0
         SUBI6M+r1oB70c0wiptn2g9iiEW/9PZBIRigRaWesnU/cYAkj6nG4wnXj7H419j69u1+
         6FRtAeP+wJl8hOWkUVACQmSTdZDOSUdgkKUAZmkQBRFkzrZznwp5sIUTzchbqcn/mu5X
         AaeCFBMXGB081ZlOL9cvin/GH683T0R1WuGSTLvpysl4HzHj0566Do0aGkoz+r2xon1V
         Y1zvl+Z7vbjYpAYVvYYubyiX5SEoYYaP/B69bPN43l6bkZ4yuVAoiKR4GSjZbCGeXQgQ
         Bpcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765720482; x=1766325282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=A27ILOHpvAtHnE+6lvnDEAst4fggOFaoxUBA4wWZFjE=;
        b=r4k8AS5OyPRVWT5j7IRTueHPzy89ceaAV67TJyTdCEUbAUwZKqPV3E9sOpFUBxwQPk
         VOVKnzTtAp3pV2owaCcnHYUC9lJvuUApKo9zV0Rwt1CtHBrsuZHmLvT8vvgn9rkznQfS
         S1ux0NIq5yS76MYeHLDwot7VEzAQ/tAYrD7/xIpqUpzIqbxzVT+CrQ6KCRPVNC/Q90KF
         gNVCWtl6Z8HItfrqWCvsXac2apxkdW0w01rPrnTuU5BQ2IxyDsOAmqk8y/jL6+10+o09
         zPAU8toi2IH+POpSA2z/YUwF/pZt4ciBXc+GP9iT1NsEWLCETaUN0SJYrquFsxDdHbsk
         +NmA==
X-Forwarded-Encrypted: i=1; AJvYcCVcifP+5mEZtyIQXqlUUS0rvpNmCleENmsXqgD5TBcymShkdB7zT7F/6NrpL6SSwvFisLamlTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBb4Kt5m5Ym/iBeZpJTiky4KSAeFkhB7ngx1KiuiZAhzC53864
	DZIml0YO0R2wFJNSA+1Oj2XALvtSHKjKUK+OXLOJ0aTS1QNwtfsL6pN/
X-Gm-Gg: AY/fxX4xwLNI65Ma0J/4Y/5R/8wGmD6/OnsOwQWkICmDveoaDRbSsmrLrZtu6WGB3IG
	AZfIsKSYY978JD/bsD6nV8RxeSVkHrczsLhfBSmFqrw9BBYEmGc/M3UTsICCX/Kz/cheBcE+vTj
	MBFjGz6dsizQv150TjuvmELAfBO9fVYhAruDqE/r2DfeNig4oxSuCP0HTiOe5IluN+4xBAL2zXR
	FpB5+B/qjLDJar8vtPcUf/lfffEOANR7FzojoGbK29bhrU8snmQMAdQ1X4AzPlAH3CJ82+TqiWH
	RPlvL5PouJI8MisEvknojavHEQyiR+yoMhUH+FJSxluTKBZK3aF61WCJlYD3+3Qvx2dr4tMu474
	G3bInePpU/3p5CeDSTXVNew4PLs9CTJ2rTStMa/f30txPo01oQoe5RrvqDWTFLk2VRHWYt4RZWD
	ggdciFlhd2BE+0oY4acF99VnIij9I2rD2lhQCkTHTtRmcU+s8EJv4w
X-Google-Smtp-Source: AGHT+IHTxNR+ZUDxw8OLVbLKKhDwZuONnZ52bWZfD6ui4ltu6ALafY6AXlfWh7ujj0ZxW5VYZ5/Z9Q==
X-Received: by 2002:a05:600c:3ace:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-47a8f915c57mr66690115e9.32.1765720482446;
        Sun, 14 Dec 2025 05:54:42 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47a957de489sm114389375e9.5.2025.12.14.05.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 05:54:42 -0800 (PST)
Date: Sun, 14 Dec 2025 13:54:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ma Ke <make24@iscas.ac.cn>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 aloisio.almeida@openbossa.org, lauro.venancio@openbossa.org,
 sameo@linux.intel.com, linville@tuxdriver.com, johannes@sipsolutions.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 akpm@linux-foundation.org, stable@vger.kernel.org
Subject: Re: [PATCH] NFC: Fix error handling in nfc_genl_dump_targets
Message-ID: <20251214135440.51409316@pumpkin>
In-Reply-To: <20251214131726.5353-1-make24@iscas.ac.cn>
References: <20251214131726.5353-1-make24@iscas.ac.cn>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 14 Dec 2025 21:17:26 +0800
Ma Ke <make24@iscas.ac.cn> wrote:

> nfc_genl_dump_targets() increments the device reference count via
> nfc_get_device() but fails to decrement it properly. nfc_get_device()
> calls class_find_device() which internally calls get_device() to
> increment the reference count. No corresponding put_device() is made
> to decrement the reference count.
> 
> Add proper reference count decrementing using nfc_put_device() when
> the dump operation completes or encounters an error, ensuring balanced
> reference counting.
> 
> Found by code review.

Is that some half-hearted AI code review?

Isn't the 'put' done by nfc_genl_dump_targets_done() which it looks
like the outer code calls sometime later on.

	David

> 
> Cc: stable@vger.kernel.org
> Fixes: 4d12b8b129f1 ("NFC: add nfc generic netlink interface")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
>  net/nfc/netlink.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/nfc/netlink.c b/net/nfc/netlink.c
> index a18e2c503da6..9ae138ee91dd 100644
> --- a/net/nfc/netlink.c
> +++ b/net/nfc/netlink.c
> @@ -159,6 +159,11 @@ static int nfc_genl_dump_targets(struct sk_buff *skb,
>  
>  	cb->args[0] = i;
>  
> +	if (rc < 0 || i >= dev->n_targets) {
> +		nfc_put_device(dev);
> +		cb->args[1] = 0;
> +	}
> +
>  	return skb->len;
>  }
>  


