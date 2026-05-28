Return-Path: <stable+bounces-255025-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEuMH/dUGGoQjQgAu9opvQ
	(envelope-from <stable+bounces-255025-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:45:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 043AD5F3E36
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30A9C3091EC4
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB4D3E8688;
	Thu, 28 May 2026 14:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FzELpMqT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FE43D3CF9
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978884; cv=none; b=ld8TTC/sWZaUSieIwgm1PXPvgeBr1aiDn7jIkck3glGnT08+vAqONtcTbqhY0WnC6yId6ABn/wBL/eZLoSHtc9GLp2clnZ3OFFtosQTD0MgaRBSd7O8jM0DYkIc81IhZpOPGQEa3XJYu6u55P521Pd5ahc36nINngtKnES6iomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978884; c=relaxed/simple;
	bh=0eE+3wJXB35CTaM3CGN3mJgxdh3wj7AQldYtzQyzVHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6XXHJxz26ENxKQEeipNU5ry6ksTdTQlPHKnRkBlaPkQnkpPcA1SWcim4LTAZiIMOZ38XTKYef3fZReZNFFKYfls2cTURJYsH3hcFPVpQkSVZs+IS4yLnZumtkbo174M8Nvt6w7Z8HRP5MsWd1ST7X764no9358JYWmH/PvTGQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FzELpMqT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4904c1ce4c1so67562425e9.3
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779978881; x=1780583681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxZz5a1qRqyA1KpHQgzxfGddHd7PspIS3/Rb7TY1aPc=;
        b=FzELpMqT8UUxc5OlWmucV7tNS2sD4GtZqzXJPvMfdhhQxxpH+WuWEGDANdVPPYF4gE
         2ZuwUAVs6iDgcbSLDCMjZItq+eujDnoTLA/5Lu2JEuTkOR7E5T4OACUCHX6WPFdjCB/O
         k9swhnjpTwcfALS0ACkofwQfnFB9agaNwDUMRv0ibhUEKhlDRjI5kOYiKbwTC0Z860QD
         eQXXe/TwKVDBYNhqMlHlmk/ZM37DshIiP9ZEPtx6biKjPY7+SBrW4z8hawrTqhvrP7D7
         3hZ4UgpklOF2b1kd1cyrM61HnqgdsKPiQa+VLqydUI75WU5e81sZMYw4MjmdtW+VBTey
         MtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978881; x=1780583681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KxZz5a1qRqyA1KpHQgzxfGddHd7PspIS3/Rb7TY1aPc=;
        b=Igj8Zg+MBBCXkXmQN6mPKMfOVsQEHZ81HAU+z8plZ3btrM6JZh0uNt3S8HYF5leS99
         isduxLkw9N5U9YLMtwy9eRxC8Qp93STcqLJ7ZbQ3omXIm4Mv/mRGnXiAjIvkRWkz18O7
         5qIHeHyb8tzGavqyDyWcW+706Upb81GtAG7RUuVzT9jXpkGlGdH9V+ldJ/t4YIAcqTwB
         pz4z7l5YS2JUgaIXnoPiKDDAjLoX4WGFJWgefWlGTvXmS6rabQBsR/lJLW557cIRUbQ2
         dFXkHhVFEXr+4MyGzJweQbx1MZhTnsm5BFMClX9nJaPuwBFWOHQ3jNvpdU4rsI9X2qzn
         47lQ==
X-Forwarded-Encrypted: i=1; AFNElJ9msyqfkLS25VlJCaCT/PQeZEw8Yk7GgTGNios8l46VuciNAI1HIBPxF0gPvRnUilbXVyDCtUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgL9Q+Mo5W3XkYDyAeSJtiBTlDbwiV5ZHUX0LZWV1LB0FTdMNs
	gSs8GICigPDi6ZBncNrN72tIEglEX/j7eEAXibR4xKIrhYBWLMZjcnAt8Db5SV/T1tgkD+DIM3U
	Cahj4OkMHXMEvS2BqU/dqrlRSgkkE6EJzgiNDEqgeq6hDaMjl4NE=
X-Gm-Gg: Acq92OFxubiVxfIEKIr/ghGaBh157WugJlWCVxGOFIVvOZPcUGWG0USginrMP5lBihe
	ur2JifhrNdU97bfN7dYcobin5XB9y1NR5kSXs9RtJRfycsvrgBPfJ4hZwlAPR0vXba7cbFiHqnE
	pV1dDV1EZ32DWFZp357Un+iLEutaqBd3AtZcJkHHzc8771jwZQWpZ9Ukz2A6rk3/TdIFOYgugb/
	67sKxav2sj7bG0iwERvk4YcgA1DCJFyMDpBXC2UB/sQoau/r64LoFz6ottP0Dyqp5XHt42ygghA
	mIBMg1GL/GWYzNX22ZNqiG8DWhRdh2xMVewzg5iu67T/Pbz2XhYTtgXJ4IZon5gy6+FDiY/mUvm
	ArOKCkm6LgBs6ES+REUH0Cx3W6jXEseu80K0+KQ4YTR5oRFUdwZ3fw6UtskNtNVY5ZjJlhs7yvN
	XREHcikVh9fiOqP4BRoN3Z86kXQcwX4upspDQQtnzvZ8G2sTYNJcpDVH0B/A==
X-Received: by 2002:a05:600c:3f0f:b0:490:8470:31f7 with SMTP id 5b1f17b1804b1-49084703202mr95055575e9.20.1779978881288;
        Thu, 28 May 2026 07:34:41 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4cf9:4344:20b8:5b16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490923613d0sm71986355e9.3.2026.05.28.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:34:40 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>,
	netdev@vger.kernel.org,
	Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] ovpn: hold peer before scheduling keepalive work
Date: Thu, 28 May 2026 16:34:38 +0200
Message-ID: <177997886516.4173782.12454597506201953464.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <177954800752.73238.12097994883239164708@gmail.com>
References: <177954800752.73238.12097994883239164708@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[queasysnail.net,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255025-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 043AD5F3E36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 23 May 2026 20:38:27 +0545, Shuvam Pandey wrote:
> ovpn_peer_keepalive_send() passes its peer reference to
> ovpn_xmit_special(), which ultimately drops it. The keepalive scheduler
> currently queues the work first and takes the reference only after
> schedule_work() reports that the work was queued.
> 
> Once schedule_work() queues the item, another CPU may run the worker
> before the caller gets to ovpn_peer_hold(). In that case the worker can
> consume a reference that was not acquired for it, corrupting the peer
> lifetime accounting.
> 
> [...]

Applied, thanks!

[1/1] ovpn: hold peer before scheduling keepalive work
      commit: c0951d651254b7d7f9a15d3ef149e8d2c9ff6ab6

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>

