Return-Path: <stable+bounces-254397-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOl+MojRFWogcgcAu9opvQ
	(envelope-from <stable+bounces-254397-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:59:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7EB5DA442
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 18:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 846B53111485
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5930B3C9889;
	Tue, 26 May 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="GzzSUQDE"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C505F3C8700
	for <stable@vger.kernel.org>; Tue, 26 May 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813449; cv=none; b=uSEMHHwHtwtiu4j4vTkfND4wM8akFpKycGGJOlwExHHLvNiohzHi//8YR15oE92+BtnLcGw/pR63ipODI7olBTTALRbk1s+grheuXjQnAzcXyV6+rBPC/Zl0Z6spC9ohFpUEA+hQ202YHZis06Zk8NJwxOu0nLho8K5ZbbpnBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813449; c=relaxed/simple;
	bh=wPbiL3tdI/BIIx2e1JWAGJkK2ZZp7TiXD7EE9S7Nf4g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oQKEWp52zLlBIMJpBvJ2Mi2+7uNVHwFj95ydP2wqq7KRLsTZtD6fcNLUXxgD4np68WWz+iKRiCU5EkqsPUspgOUPPMhwvlzVZBUXIw2jrKWjxymXD2JTrtZ+HhQd8HtK25pKpkZIL9tj+Y1sTicvME29pe7BymVLjjHmo2AkAWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=GzzSUQDE; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-43b6f19b7d4so2917216fac.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 09:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813447; x=1780418247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azootos90mDhLNr0xGgJIJN+KeILdcujsZY+11LjFE4=;
        b=GzzSUQDEwhM1O31ViCKM6Ww+oTALx2LQLj84W8oSLVpHCNL3moCoC93Af1ZFATwLmA
         1V5f1vGX+WHziRTSwZh8YtuNpGxknLPNJ4YUvx7ko6REjLVp4ZK7Jeft5KfSnFnYtOaa
         CcyTREFjf9u8t8ILNwzSeyU66Z3ZsRuR1Y62at8arCRV/ChAtg5h4GlB9xrsPMAgRhml
         TsJSrpo4axeKiQldnVgRSCh0KRN4idDmzQ9PlSeodNSrRpORN6XHNES7CdCpl7jKiE/Z
         fczlQtLVLmNlZW0Rbdl5G/U9VzHx2c5ZrV9DPIV5bVDa60jRNO8m9w/3a6Q0/urQbS42
         bh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813447; x=1780418247;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azootos90mDhLNr0xGgJIJN+KeILdcujsZY+11LjFE4=;
        b=qM90PQQXtnabk4l8EuCrXXeEXtkZUa52tkETlOFBPxUg/urqxTcD3G2shEvXUzxV93
         7lM2ORqsuaZfKTu5fWq/mM3OwlidLJwdhIfHCcr0KPNyAWVgr3WDJrRz7UnMX7MhDB7e
         +nvCMWVtIl6zl+3sHIT4SeQ/tZSBt/8wcpEAEA6dJ5m8GO9ALCfW80Dlzk+Qx3GzLuyA
         QiU6WBwL3KMA49CnYArabYftPb6kL165QHrE3IxnKf67nHPa6nj/0QnQQr2CjTDJdgdw
         IfEfAVOOEPG2ZxC5b2VHCOpEjjkz/5czb98/QG+KI7llEnb/PlT1R5ZRz/tUB24QKZwO
         XUaw==
X-Forwarded-Encrypted: i=1; AFNElJ92Sx4ksegNAHYdRmUiVAOKkYkE3pZBVh7eD70m8SNjYwSQ+EdbO/BKgMjRDDw425voXpgS3I4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS6rq8/EbxpenNFXp0mQdWAeTl9xm8HQEcPbyfOC/h/Fnm0M/Q
	xxYwdxNnfhCWIbtPLshBvxyLTXUQiE+O8bW1Pqr6SwQCJy1hlJ6lwWKKuP0f5fip7cU=
X-Gm-Gg: Acq92OGdSrTFeEDREQR6jhGqjZZvkZK2JtT9fj4OurvGdYUQaCkZIXRKz0yBq58JC8w
	a42dmLoJpsASXxEYnahW7/OTkq7HrtqCbYGEcfCVc0+IAkLKtRfxLGd0pKd0VxXf8BOkQxYjcor
	nHNFdhre9a5/wUEOg8Gad7JNMV3IUIAuBqFI1YOqIm0UcC8YiI+1WQbHIrow9vXVa+cZlLUigEz
	MNCWB29M3HU77HEAjx3F2+byFG2Ru/CYGXfyPmytQIekdtMhiAvzdXPfgRnz3nrk4eHQgTQfVT/
	OSF1YJJUQk1TlxFwRXrMUhnDfTPwPrFTlckakikpbkSqNUyWAsWJG0Mh0BAOeJHZAO6pVudBUvE
	o0/fKozDhCgxr0jMcqpPAXCCRp//lfX48V1pJotLBqyI1HiYRjKUMrvfzsSL8eozlQnqWwZhzfE
	RkQhwivsKWSLvBSqTkmQ2Z0dLlgcAxexk+uPqdpb/cuKCq6S0SvFdNZsgDYeQT4iY3hpK7jyxIz
	iM=
X-Received: by 2002:a05:6871:60ca:b0:42c:f89:755f with SMTP id 586e51a60fabf-43b5aa7e063mr11931015fac.9.1779813446741;
        Tue, 26 May 2026 09:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:25 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Arefev <arefev@swemel.ru>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 lvc-project@linuxtesting.org, stable@vger.kernel.org
In-Reply-To: <20260521072857.5078-1-arefev@swemel.ru>
References: <20260521072857.5078-1-arefev@swemel.ru>
Subject: Re: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in
 userspace
Message-Id: <177981344495.464267.5969625320718476596.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:24 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel-dk.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[kernel.dk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-254397-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[axboe@kernel.dk,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel-dk.20251104.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kernel-dk.20251104.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 5D7EB5DA442
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Thu, 21 May 2026 10:28:56 +0300, Denis Arefev wrote:
> The bdev pseudo-filesystem is an internal kernel filesystem with which
> userspace should not interfere. Unregister it so that userspace cannot
> even attempt to mount it.
> 
> This fixes a bug [1] that occurs when attempting to access files,
> because the system call move_mount() uses pointers declared in the
> inode_operations structure, which for the bdev pseudo-filesystem
> are always equal to 0. `inode->i_op = &empty_iops;`
> 
> [...]

Applied, thanks!

[1/1] block: Avoid mounting the bdev pseudo-filesystem in userspace
      commit: b518ae170f6c411cac2d5f320278c27d902bc628

Best regards,
-- 
Jens Axboe




