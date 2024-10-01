Return-Path: <stable+bounces-78560-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEF698C3DA
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 18:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7221C24171
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B031C6F70;
	Tue,  1 Oct 2024 16:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYccTxLZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EC51C5782
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 16:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727801286; cv=none; b=XCFCnBoUGe1LBxANZc9wHHNRueJBhprddAbOWCvJ6/xoJQETdFmbb531DfbCdOmSGlk3VONdX586tCBkx/TSuxmxnatrWnNAjiHht00zalXNJarOCCEyggi713cYJY0/WLame3o2AMVYcc1b8rZHMiAQkQdbUzwbkGxC8LeW4R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727801286; c=relaxed/simple;
	bh=Mpt8LQ7WFhlR4/npQJ+yd0kFXefhqZaPUR3eB0VzwM0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AmUe5N+Rgkxo+rGMtCFWpnFSPxveueZTQvqJCN1ROjiY8CEpX+a8KFZosokJPyXkwyahp1TgOf/9RT1jct3yRav7IZI4mqeXYt2cLGeWMLwdIwLOlpot84XYQX6QJiS5x1rPzW0MWTaoksr7kCt1pdDAz/IRu0uWH0NxYVdQuBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYccTxLZ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--nogikh.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5c884bf0025so3520229a12.2
        for <stable@vger.kernel.org>; Tue, 01 Oct 2024 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727801283; x=1728406083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gaaxnQ+4iOGrqcUqSLfiVLnhl5dSo8V8j76UXEHeXUk=;
        b=fYccTxLZ1m5jfOASbAbb6m/k48hQ9O+fyzvUaQHTENGHFEagihNYw3M0RIBXqnY+jN
         7PlXfPojNGQdsHXGVnPVlYjY9QgkkOYYNpHzz9mOx7JkoOJ24UuelsUgQvXhrQc9qI/P
         Vno8XGCya5XSthxQgiwPAFSRisxQ8eSaC36wxXSsBy/luPk78J/Rc/s01FJ4xNWeIpIF
         I5GsgGKRsY+XHUaiRXYKEuL8ugvfDYn3sT+rlOR9JqkWN4pMB/lXZvB8IT+O+W9J68s7
         Sy1TNPrLo9G5inoVgTlN6+NhZGYpvCoYmpHTJTYdpB1aJAyFx2LpDlW25wllVnrarnp7
         Dy0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727801283; x=1728406083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gaaxnQ+4iOGrqcUqSLfiVLnhl5dSo8V8j76UXEHeXUk=;
        b=bXsUUwTB9KBha1A4qGozpi3BLQbgPmN5+h6Hdi3CeRSOdxYrbHmx14Z3SsN+gq6MSo
         deNe8bcIIXcKYmkAxb3GKtqJ8IlcUcgMWxZ2tElI7Ng9CLj7qQ8FihCcDv07e8PYSbHL
         Nh0ptQ/5uAViYLdKNBIxwsH4QtO5X+G+F5lUXzMg+HGg6ukqPM3as1E/lfvJjaACtJ94
         jbAh7mEMzBzDh4xd/CM2nVoV7UoClWhRuURk6wPPgDEXbYV/90eTPljCOUoxQGjyvl2j
         afagDtNmtYVAVVzx87h/h52lP5D9jXPuMR22Qr/3E3xbTn/Y/3YWsmI1nBFCaDMmEA7+
         Wltg==
X-Forwarded-Encrypted: i=1; AJvYcCW/AwaEVqEu73NvVsJf/kRwW0UkpjlCT57aKYOD+CLBBKPJ5rrlCrTu570hE2n6+BZkeYGZ4oY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9cuXOGd8V+9ddZFKL+O4s3tLvhVwEgYKSByflieS8ULkeSudc
	mFe0v273ir0Da8x7QVoFGP2fee2EbrMjVF6g8LHfQaNcXTPA8rjmbyJefcGlE9PICdtUsBzlYFb
	EjA==
X-Google-Smtp-Source: AGHT+IErS88qWTF5Vw1ftgVHnBxnAFB1tfct3YAYaMs/p7uJQbbxMDu2TCxWB40z4lYyhvEVHGN+4H8Csr0=
X-Received: from nogikhp920.muc.corp.google.com ([2a00:79e0:9c:201:64ce:f85c:15cf:a9bd])
 (user=nogikh job=sendgmr) by 2002:a05:6402:5208:b0:5c5:c4ab:8cc8 with SMTP id
 4fb4d7f45d1cf-5c8b18cda79mr15a12.2.1727801282810; Tue, 01 Oct 2024 09:48:02
 -0700 (PDT)
Date: Tue,  1 Oct 2024 18:47:59 +0200
In-Reply-To: <Zvv7X7HgcQuFIVF1@shredder.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <Zvv7X7HgcQuFIVF1@shredder.lan>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001164759.469719-1-nogikh@google.com>
Subject: Re: Re: [PATCH stable 6.1] devlink: Fix RCU stall when unregistering
 a devlink instance
From: Aleksandr Nogikh <nogikh@google.com>
To: idosch@nvidia.com
Cc: davem@davemloft.net, edumazet@google.com, gregkh@linuxfoundation.org, 
	jiri@nvidia.com, kuba@kernel.org, pabeni@redhat.com, sashal@kernel.org, 
	stable@vger.kernel.org, vkarri@nvidia.com, dvyukov@google.com
Content-Type: text/plain; charset="UTF-8"

Hi Ido,

On Tue, 1 Oct 2024 16:38:39 +0300, Ido Schimmel wrote:
> 
> On Tue, Oct 01, 2024 at 02:11:27PM +0200, Greg KH wrote:
> > On Tue, Oct 01, 2024 at 02:20:35PM +0300, Ido Schimmel wrote:
> > > I read the stable rules and I am not providing an "upstream commit ID"
> > > since the code in upstream has been reworked, making this fix
> > > irrelevant. The only affected stable kernel is 6.1.y.
> > 
> > You need to document the heck out of why this is only relevant for this
> > one specific kernel branch IN the changelog text, so that we understand
> > what is going on, AND you need to get acks from the relevant maintainers
> > of this area of the kernel to accept something that is not in Linus's
> > tree.
> > 
> > But first of, why?  Why not just take the upstrema commits instead?
> 
> There were a lot of changes as part of the 6.3 cycle to completely
> rework the semantics of the devlink instance reference count. As part of
> these changes, commit d77278196441 ("devlink: bump the instance index
> directly when iterating") inadvertently fixed the bug mentioned in this
> patch. This commit cannot be applied to 6.1.y as-is because a prior
> commit (also in 6.3) moved the code to a different file (leftover.c ->
> core.c). There might be more dependencies that I'm currently unaware of.
> 
> The alternative, proposed in this patch, is to provide a minimal and
> contained fix for the bug introduced in upstream commit c2368b19807a
> ("net: devlink: introduce "unregistering" mark and use it during
> devlinks iteration") as part of the 6.0 cycle.
> 
> The above explains why the patch is only relevant to 6.1.y.

Thanks for bringing up this topic!

For what it's worth, syzbot would also greatly benefit from your fix:
https://github.com/google/syzkaller/issues/5328

I've built a kernel locally with your changes, run syzkaller against it,
and I can confirm that the kernel no longer crashes due to devlink.

-- 
Aleksandr

> 
> Jakub / Jiri, what is your preference here? This patch or cherry picking
> a lot of code from 6.3?


