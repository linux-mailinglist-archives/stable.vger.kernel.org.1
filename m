Return-Path: <stable+bounces-106663-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39EB9FFEB1
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 19:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 927013A24E7
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920DA1B4128;
	Thu,  2 Jan 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WAQrR3KO"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EDF1A2632
	for <stable@vger.kernel.org>; Thu,  2 Jan 2025 18:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735843416; cv=none; b=jKds90d+dyANpDGs+5ZHVFlF6uKm/l1YnK5Ukjp4qBYOd/s+56jDM43Nwt9DfZT0eQcZUGTE8//9sPMidOOoTjNJKIaVb2Brz4qmcmn56x1IZCMzGKojKr9F/u4gT+St3yLk//1QNxyNGo0Np7m11iTxyleF+KNX4H/bOerPM4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735843416; c=relaxed/simple;
	bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sAry/OObeM8Pw9SpmOrpCOAXK3Dn1x1xT6BHYvxGhjxJD5qT6Mpibz8FXrJ/emE5XCnlBqdw7Rqia684BnqwlgFgiF4nxvowQ/s18DtO+TxqAIGuE2bcjzQZojp6mJujHe4jxG+ngo5WkAC9aUzMOe5tiGtqqClIV0VKJ9lGbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WAQrR3KO; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6d89a727a19so110962436d6.0
        for <stable@vger.kernel.org>; Thu, 02 Jan 2025 10:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735843414; x=1736448214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
        b=WAQrR3KO97OulvUQmH4kG1LwL4a4h86Y5h3arlUunzG1p6JYqIO2wd8FJhAg6lGOCh
         lNTzaHdZG/CCrOrVk1YPjKPoNo+u19MAQu6IrLD6fr9/YlsGlTuoWe2hius4X2+ErPnE
         twujS4rR3nCAkTlWBkWzDH2RbHCOVCoR1g3kaPGI86tQdzAVMdHAOfs9DjMns4ZOoIWh
         OYSgRe5vBeHvv80UpqOuiXXlmgk0pTEo5ykIahRgYWb/cik86qje7U305Us/O0gf8jwQ
         Kb/TeepYC1Ck5P0k+8xWwVnq+pc4Ri6GsoF7a27snj6xHURMl1S/0NqM6+47IqCE4+/c
         QpEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735843414; x=1736448214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eiml2yjpmOszRDlSCn6XV9ArVvimnR2tz8b95UUvfR8=;
        b=DUEZPyMEjQiYm2HxLXkcFmUR363IN8fYTlfVjOVTK9faXgug3k15s3pARKWSeOnM4V
         fx2poSicrB4RbMCxIflmsC4ld9p+6L9DjR7IcEPkL/ZLjZ15cIMDN4lmSLEZnqpRVnOt
         eLNdzBKgKO0+Rb4j6AzG04m9QHGn08oquutrl6lDuGzftrUiztftnbxLPHzsPNGePgFA
         cU5SRyEaF14BlnTJGvL7vNxltx12Ks/vJGUkewVushj7WTdvyrAfeFSBIvE+PdOcIHI6
         Oe42kX3Bi84EWQQB6IcUBJS5/bDRlwQXE/JLtr4K/q1MKvTIDeAHqx9X03fthd/hEtUU
         L78g==
X-Forwarded-Encrypted: i=1; AJvYcCVHyVYwfvXeY8nxpt3mchwf+867uJLdG6L/7DgJl/qtcWzZBvJJNFFUVxflm/y6QnXpJH/CLac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVo1klV1LQvOkby2CEB+E1+AfmB1GfXELIdclY5rC9rncPpZEH
	qo7+QwLCBGEFp3dfzAAtjBah92aexmO3yp2x9AkvsuGYtqjNt+r6fxRxgl5nb8DTntZWYygm/mp
	P0XIPCkzRsSppiss+rHyrWOz4Wjrc8lUobnZE
X-Gm-Gg: ASbGncsGNWh3+I+p5EFHHgKkul17miDpXPISbge/Je9y2jToo30gsa0Lujr/BZneH+c
	bQjGxtPoQqUj77jgf5xxgBkD6poWPU4B37hCm
X-Google-Smtp-Source: AGHT+IF2tZXZGzK4SR62kPfJyDlYZjAffFvMlSMw7+NG+gQt+geLbrrGjOcGHqDzqV0Ly6l7e8fT7ZNqEBaPAWkEaVw=
X-Received: by 2002:a05:6214:5bc7:b0:6d8:8a0b:db25 with SMTP id
 6a1803df08f44-6dd23618b5bmr751231406d6.21.1735843413422; Thu, 02 Jan 2025
 10:43:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241218133415.3759501-1-pkaligineedi@google.com>
 <20241218133415.3759501-3-pkaligineedi@google.com> <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
In-Reply-To: <3ad7bdd2-80d2-4d73-b86f-4c0aeeee5bf1@intel.com>
From: Joshua Washington <joshwash@google.com>
Date: Thu, 2 Jan 2025 10:43:21 -0800
X-Gm-Features: AbW1kvYJhRQu9jWJ1-H0lGB_jEU0IWP-wY0jRAO_aZNMsIq7HMjjdk9-3POyjeg
Message-ID: <CALuQH+W3TK4Kvgbf1d+eFjR8W45_84M7T=aD0BeAdbGQdm5koQ@mail.gmail.com>
Subject: Re: [PATCH net 2/5] gve: guard XDP xmit NDO on existence of xdp queues
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Praveen Kaligineedi <pkaligineedi@google.com>, netdev@vger.kernel.org, 
	Jeroen de Borst <jeroendb@google.com>, Shailend Chand <shailend@google.com>, 
	Willem de Bruijn <willemb@google.com>, andrew+netdev@lunn.ch, davem@davemloft.net, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, horms@kernel.org, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Ziwei Xiao <ziweixiao@google.com>, 
	open list <linux-kernel@vger.kernel.org>, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Wouldn't synchronize_rcu() be enough, have you checked?

I based usage of synchronize_net() instead of synchronize_rcu() based on other
drivers deciding to use it due to synchronize_rcu_expedited() when holding
rtnl_lock() being more performant.

ICE: https://lore.kernel.org/all/20240529112337.3639084-4-maciej.fijalkowski@intel.com/
Mellanox: https://lore.kernel.org/netdev/20210212025641.323844-8-saeed@kernel.org/

> You need to use xdp_features_{set,clear}_redirect_target() when you
install/remove XDP prog to notify the kernel that ndo_start_xmit is now
available / not available anymore.

Thank you for the suggestion. Given that the fix has gone in, I was planning
to make this change as part of a future net-next release with other XDP changes.
Would it make sense to make those changes there, given that the patches as
they went up, while not completely correct, should at least cover the
vulnerability?

Thanks,
Josh

