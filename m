Return-Path: <stable+bounces-233119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PSkJ0nZzmmGqgYAu9opvQ
	(envelope-from <stable+bounces-233119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 23:02:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1EF138E33C
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 23:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E4E7A30429BD
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77DFC372ECC;
	Thu,  2 Apr 2026 21:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="QMPkaeDF"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142B336B06A
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 21:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163602; cv=none; b=Lu9wpdYi6sTuPO11yMzYCQeOg8+0S9dnm2Vhm0IW8KxseMN5y19Wzwn9xWtd9n1S8XyfmHCSCrAXlN/De21ZpVlseZ6prsCcu1DSCBjZLSwiqnfb0Gj2MXdXocJwJ7m9XoL9WCqLPLnkYdz4hR9t+HSaUF7T5Zqn31SHqNkA4ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163602; c=relaxed/simple;
	bh=u54I39wHWUHbDyBdb1+/nfBUiIfO1SJ+AZIT0MAjnsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nPX9BRET6mN7dVedN2NnJqBpbA9pALCnA++zu91gtlfwymuMO6S1weKnaC1/spRiEKaT+dQfEkUlJVQM+M4CPtD8bUhgH2MTpX/KYJ8NE5QeZqB9nvVyV5tRXYirpa4QoPVJL1fH7g6bl3pMHN0sJqrMWrnB6a0W4LnEyIrN7V8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=QMPkaeDF; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so622290b3a.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 14:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1775163600; x=1775768400; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bCpzZqe6/GN8u+eCCZI55uBzEHgmE5Itzy/ezeiV81U=;
        b=QMPkaeDFoQ+WWZN1aGpnLQJwMkacotRy78374fSVeRHQrjW3V5ll1MbpWxI/HZk4Sq
         YAsAiLe/A4LcyUIU3ZvTivOazOLmFeZs+YuZBwtn6xh3HbG6Nv70VCBf5+Bv/gPjY4Rh
         QnC8zoKcgE50G7mvxotJdmYnPhJYmQTetWoN9heJ5HDzZbq6VjqSy7Ip/Vx4a1ZggHP8
         RWWFs8G4btex6KLraQ1SUIgvqq8OolP4KKFNd14KlkKmMXPAaUWDln3ygL5VMlGvIbd7
         slPmM5rW7PYuxm451RKdYtg80BnKfU9tOQgk5MXLBbNWb8v8cu/c09rr/FlqEwk0G8Ah
         ps3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163600; x=1775768400;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bCpzZqe6/GN8u+eCCZI55uBzEHgmE5Itzy/ezeiV81U=;
        b=g8jrw/1SacD3cZ9kFb20kOg43U1z1K0ThGAEZpCmyr/tM9FD6q6TyycmLzqCAdNme6
         7vhZah1g+NZ3RkEeUDBH8WjGksKv0cnLjKlbjlmrOOO5wNvmYnhiScBxM/j6swdyXV/b
         deso4a5l/Bnj6CymNYI9G2NCC/LbFFDaYdQsgyRJBWEKhd1iq3VU30UqQBEYB8xhjOHt
         4nlS554jvqW0SNCmrgmByBfFFDjCyzDKsHDl7JsiECYgMzsWtgbNddJdH8AtHdZ7LQus
         UZPn/8D7uHrGEsJ/G7tAQKS0o+koJZNcCa9JAgSkwaQY5S9CtrVcWGZQRyqz2jv1ARlB
         ymuA==
X-Forwarded-Encrypted: i=1; AJvYcCXKUG2YJ0rYid5oYNStvYjpt2XNg+sd8YbvDeP9E/CVaiGGqUj3HGtZAoKeIX6ikra36lv82qs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2n772rh3+e+WXM7sIGAZ9dpAzTI0P3pK1Ig5mN07KNssqQXOW
	l73fk86dHg0WWqHAa589m8mjJZ43/5DgZBwGue7DXOOBQUkkQ/7kAibeHrE7JXa5gwQ=
X-Gm-Gg: ATEYQzzKdz9iI5I3Rd/RH35cyKbagw1vHYwX4LH0OBkMA9YWKBqNx3LVytSBPSWLwhD
	cGZ6tlWvpGex0wRzs86PtNmiHjnpasaMiBwyycQQHjw5eAJhYHKYA+XmL9zHDvZ0SyZq9blZiMv
	WqomMWLW73h2VYd1NdbCXw7oGx7ogj0WZExa4xRxpn3Lzddo8Bcrw2jtWnJ5bg7XRUIUjYiI1Ad
	V3XfOl3wwMHKCHU3WQKS+YX7Gr6cdMou3tFNr+6ic4Dawn45TWvyKINTeieuqPP4Bqfl1JkfhXE
	/IH1D+ESuR2J5PNdAo5q2MugN/LhH5vwCWqanDHsQ2PntPaZElWmSX5LsDbLm66+/X9BNmiLqLJ
	5tH7SMXf7U/1hqfAako36k7evKHdOmZFOiR3EnWaDXIAbNnvSdqvdVlYeAqYgIIeheO47123aHV
	CiuXM=
X-Received: by 2002:a05:6a00:3902:b0:82c:e816:412f with SMTP id d2e1a72fcca58-82d0da5502fmr501200b3a.18.1775163600420;
        Thu, 02 Apr 2026 14:00:00 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c6ba2fsm4034726b3a.45.2026.04.02.13.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 13:59:59 -0700 (PDT)
Date: Thu, 2 Apr 2026 13:59:59 -0700
From: Joe Damato <joe@dama.to>
To: David Carlier <devnexen@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: lan966x: fix page_pool error handling in
 lan966x_fdma_rx_alloc_page_pool()
Message-ID: <ac7Yz2X0t3ibnNha@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	David Carlier <devnexen@gmail.com>, horatiu.vultur@microchip.com,
	UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260402172823.83467-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402172823.83467-1-devnexen@gmail.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[dama-to.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233119-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DMARC_NA(0.00)[dama.to];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dama-to.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,dama.to:email,dama-to.20251104.gappssmtp.com:dkim,devvm20253.cco0.facebook.com:mid]
X-Rspamd-Queue-Id: C1EF138E33C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 02, 2026 at 06:28:23PM +0100, David Carlier wrote:
> page_pool_create() can return an ERR_PTR on failure. The return value
> is used unconditionally in the loop that follows, passing the error
> pointer through xdp_rxq_info_reg_mem_model() into page_pool_use_xdp_mem(),
> which dereferences it, causing a kernel oops.
> 
> Add an IS_ERR check after page_pool_create() to return early on failure.
> 
> Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>

