Return-Path: <stable+bounces-255064-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIKJD/NwGGq4kAgAu9opvQ
	(envelope-from <stable+bounces-255064-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:44:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 950355F52D5
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 18:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6F21301A1D7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533313F413A;
	Thu, 28 May 2026 16:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmgI1+RQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9C348C7C
	for <stable@vger.kernel.org>; Thu, 28 May 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985962; cv=none; b=GBfSEt2Bb5+l+nTI5qD8FwL/XsOBlfDzXO98UkhV5E+0GhFWKSpteRuwokuazeCOft9VXnHznK1EalqnnJibcMdIkCiqJQc7FMydX32i7wAipT5uVstpxJZwsg2KVojPnu0iiYJvY3sYN8Z5qWBy0KKITeoNkwBUpd8+QMG5Tkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985962; c=relaxed/simple;
	bh=ufv1PObtyFAiJQzsskvo1bUR+MHLbc50/gzK5sojAAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7gD3UkV8cw+EymVulgkBW2F8170sW8ENoGecQoJPS989YgCKCUScDgY9BS2cnrCLLbrgZVWJvDARndlVSEhZbdeR1CpnGhhW4WMEhkXN9pOqYIFzQQjIwhK/jynEbEVWyKLJ7wQ4LqfVWxmsdAYsmKwsGvaUswsPK3b7m+SYNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmgI1+RQ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2b4650d5f5cso54988055ad.0
        for <stable@vger.kernel.org>; Thu, 28 May 2026 09:32:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779985960; x=1780590760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mh+PZK3q6XrLM8CGunVOtEsZQHIDpJMRVztO6r+erJQ=;
        b=fmgI1+RQEhi9wUMi6GpqlHiOrLgj5NJq2zLr5kKFSRwjK56k4WmPpFnbAEt09VhD6a
         zgNiG2SVl961/9Oduyxa5VPQV9RQYjfr5rSfIsmfgEXKbti7YNUwZKI0RP5cykhaGfYC
         /7WLn8f7dy3a0y+pBBVSjspvQmt8sIBYAFW/9EaoT1yOdyhRvoQ2HxRWZiOmzEz+Fo8T
         mxagicuYJyQ4847ahJfsq6LnzjxFFEcjo2PB/+qi9RISZy1hK1YofHO4DzyT9Z9kfYDp
         aKaFmcMQzX+DUzWktFdhivDNP6eAs0OfR/nq9Ea7X+Hw6NhY7uOG8eXa4DOr5V//wvTg
         8+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985960; x=1780590760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mh+PZK3q6XrLM8CGunVOtEsZQHIDpJMRVztO6r+erJQ=;
        b=HhGYJ/5Hid6C+EKCdyEt4iV+hI/BpwW41lbAQdXByIj2iwn/zm9pJyWKsgxqRcO7Vd
         4I1MTUBPile/C8QmXUHZmgF6s6DIQMS+ZcZyXZO+yI5B5Fe/7Q98KYUOVhRBrdzQI9B/
         1D7jzR2OBFmpzIHiSTqz3LlWpW531aPoty7McFS6G8XbXCyNXsfWFlda5qf6iPqTQzHG
         //XfWKNBVskofNxV5HFsisx2XC7RmfQMdSFMiylmdmkxvB33iVW9WpCp3SS9jYnRpn78
         psOZELIZco49oDGshyU6+kKHyh4m5uCP5XR2ZIQmdYPhfRRfBo3pthQ8zX4LabpRbMFy
         kP7Q==
X-Forwarded-Encrypted: i=1; AFNElJ9IeLHp2Map2U4OOxfN3KVHzshXjLQB0LpyFXgy8+1U86SrX2yT8NlI4qCcBnMr6BF7jIJ2JlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVk1FRqGn9+0fIM6eg4YUhtei0iGaP6NU0jpPDiNo143SKx4xp
	lcYq6FS5R/lWL8LJ8yCD/20f1xsDodBb4P5w9/rTN1I2bFtdYVz6r8RM
X-Gm-Gg: Acq92OE8k/brVaMqXStBfndzU6vqWdhvLEv91yXramGG+WN6Vu3U0Op35T3G1UxUHdj
	fCrzMGwRuVCnvNi7YtVcQ8icWKZ4PhjDWIfXiAHt/PWs593jq3NIVkHMEY4XOZXXKZ6XEIE+t1f
	LWzS8YKdZLIc4aNnKzQK40dK5FenSC8OSqKm7f27VQsQKMMjerEVFCmJHFn6fkDyHS5mFlN4BwC
	hLXglhoCsUKMBDgnwd/+etesxSzf3SNWx6VpTWTQxaLtpGtGc+TOkTG8oJURyY/xZb7gUR5olbn
	+tjRMtei8xHaUfD+96e9cRxJLLmHsnqxEFfpbf4lsYiN+IgPnUvakGdwwWhzfEdT8/T54wsTUxo
	hkghOiRgjDGOPp2DDG3R4hccByTbK6JIxaeM3HAipYJeN5sramjmQ+hMGoX76fuT0YePbYV2zlf
	5jv5EA2VQIWtaOn0YvfVUGbVKO81+fdmzFIszRssxHfKuizCfp0xyCHDA=
X-Received: by 2002:a17:902:f78f:b0:2be:e3bc:e8e4 with SMTP id d9443c01a7336-2bee3bcea3cmr158404015ad.18.1779985960405;
        Thu, 28 May 2026 09:32:40 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([192.129.190.145])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58b387dsm191320345ad.50.2026.05.28.09.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 09:32:39 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: jiayuan.chen@linux.dev
Cc: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	horms@kernel.org,
	lyutoon@gmail.com,
	stable@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: Re: [PATCH net] ipv4: validate ip_forward_options() option fields against skb tail
Date: Fri, 29 May 2026 00:32:26 +0800
Message-ID: <20260528163226.573363-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <b1447f76-0ca4-49b1-a1ba-2670dbbe5eea@linux.dev>
References: <b1447f76-0ca4-49b1-a1ba-2670dbbe5eea@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-255064-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 950355F52D5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/28/26 9:48 PM, Jiayuan Chen wrote:
> The bug is real, but I'm curious what kernel version and driver you're on.
> On my side the skb falls into SKB_SMALL_HEAD_CACHE_SIZE (704), so the
> linear area is pretty long, and optptr[2] maxes out at 255, which doesn't
> look like it can reach frag_list.
>
> May the driver use alloc_skb to allocate small liner buffer?

net.git at e1914add2799 (7.1-rc3), x86_64 + KASAN, plain QEMU, no special
driver. You're right that with a normal small nh_off the +250 write stays in
the linear area. We get the reach from a large nh_off instead.

The packet is forwarded over a VXLAN-over-IPv6 tunnel, so after decap the
inner IP packet still has the outer eth/IPv6/UDP/VXLAN/inner-eth in front of
it in the same head (nh_off ~112 here). Inner options are 12 NOPs + RR, so
opt->rr = 32, and nft rewrites the RR pointer byte to 0xff on the forward
hook:

  nft add rule ip filter forward @nh,272,8 set 0xff

so ip_forward_options() does

  write = head + nh_off + opt->rr + (0xff - 5)
        = head + 112 + 32 + 250 = head + 394

with end = 384 that lands at shinfo+10, inside frag_list. ip_rt_get_source()
writes the route source there, and kfree_skb_list_reason() walks the corrupted
frag_list when the skb is dropped.

VXLAN was just convenient. Other paths likely work too: any encap that pushes
the options deeper, or a smaller head like you suggested. Pre-6.3 without
skb_small_head_cache a plain forwarded packet already has end=192. I can send
the PoC off-list if you want to repro.

Thanks,
Qi

