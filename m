Return-Path: <stable+bounces-254636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAVoIFAgF2rw5AcAu9opvQ
	(envelope-from <stable+bounces-254636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:48:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C132A5E7FB4
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 18:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 880983016938
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 16:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9AB42B744;
	Wed, 27 May 2026 16:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="g5amPypQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lxakIiok"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE130FC33;
	Wed, 27 May 2026 16:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900116; cv=none; b=TvaffhIfoWQF4DuiG0sNwsi/1P3EUXCNsUQ7n95VSnduPOVgPM8hES3mwG5VEFxYMbqMhtsBPehkGmFyfC8UIiS0V0YozC5I4idI5jDXkKOMukRiAcnN+HStJxScNfP2TAovVU5qvt3dF08vX+lp+UsVtJvVpBBp0EPMi36diTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900116; c=relaxed/simple;
	bh=chzHeLo+gapj7NI+eQv1Hz2dnAEuy4y8zseubhTZe9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DQjUQJkJ79TJtnJDc75QqTE/r2yux0YyKceNUYnTAxo5tN/yJ8+4XzRaOgYBzLOYZgiR4Fh2aTRVLSLH5tjnx14YqPOJAZ8awzJALFpTQt4KoR6sAPZNXm+aK19jBj5MZVz4RLDURFYQN55UgEv7oBymKC/qRhwCJlX77ksXTfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=g5amPypQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lxakIiok; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D3B2EC00D4;
	Wed, 27 May 2026 12:41:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 27 May 2026 12:41:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1779900112; x=
	1779986512; bh=In8/yiboQOKoeVh59fI2cTFMxbsmF+Qw0VkIY70T5es=; b=g
	5amPypQbvr/P+rlPqMMznwbzW5ROV0bIpD4ZX0lZJF4D+fBikmWVfI9eryxNdvbP
	ZJjLtN4RF6xISDjH1pku/b6t9ljGXycHW/amYCV2dEt7HzcC4e+pY/nQrHnhkrA2
	9tsFv6dClFbYQgissIbVSEQj+STkYVu5Kwt0scyQ+40XOyS6i3r+whDO2YfpIgDx
	KtlzJb67b0KfBvvlP77WkSiNW4pvLVTX0+MkNPgWrj2DuDhl021V36iG/MPJuVTO
	STbBLjQJu+jHOqlp3/tF40iqqW+R+uz2uYcyVOQiLoXnO88LkEze3XyT6VHJrA/P
	oK/zjZMK+E7/HIWXSK6qA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779900112; x=1779986512; bh=In8/yiboQOKoeVh59fI2cTFMxbsmF+Qw0Vk
	IY70T5es=; b=lxakIiokGo3GdfaS0lpqPd87x2qfaDoP3Y45yua6xa8XTcOx9CV
	ZTo8n5u5bMKZyAvp5fkBXcjLSaOKTDwyLKcoID3GuHUROd9aEDTBr20Lz/tZF0rK
	QDJSMadSY1rnbwnlBdiM6msqJ/1h6773YHxvJXWveWi5jAR+Iyeeeb85ePOJrExP
	AvhRCey3zpBoyhtQUQVDslrQZxTOkZUUavGlzEaGI94s7zS4eOJdnsZ4xNfWI+OM
	nD3EF78l2BdNNjrwFTwqr8EY43EDCCv2vYhZ9jdtfEkWqlVS1e29ZUuP1I8UEQBZ
	2QzK9rITy3ks524IiR3U+bEKMLJrUO1eJdQ==
X-ME-Sender: <xms:zx4XakkaHAq6hq6E6cpE3tWzSkJgH070DBIjz5VacsamWbM7C6Xtzg>
    <xme:zx4Xap0-4-8OoX8hCQ4sRshA7y3dBIHu9E72YgNQTfzLK131ejzfRnIiSeyrgzuZ9
    UKKHHSxRLpPruNC_6Qy9um5EBjvZtG5V_S1ALGJOna7hoovoDAPZTY>
X-ME-Received: <xmr:zx4Xatcff8ANAVpvdaR7tsPrH9kccYikFeXZq1CK0g1iexg2hyQTf0aaC4IH2kAw1yKTlh1jd29t7E4oLBdTTcI>
X-ME-Proxy-Cause: dmFkZTEEu74uO7jyOz6TIt+PFXasCeJVqCMIzBTBZepOCIj+GDqeqWhU1gCPPIUY2iSHEr
    Rv6GaCcwcIZmEgOmwgzap01mOILLj36HortkGSHGG9ohHwLyyDcKrSceGC3+3Y62hiAg4B
    z1uUkkAixZTJcFz4d07GNULmgs9qH7E5y3Ws8giCNYHtUdvXeTHJmjvlxXQ7htv/A0Pxae
    sOiZJz14WozAGZWJtLGb8mUBeQjkGpV8V3tLUwznzaYnB2DhggfMMFtK8zOjvimNQmDVF1
    LmZ9Re6hRTHA90MKu2ML3XPj9aLvFmubOG8M0BUwo13YefzuKa4JVvw66BlqkEo/GUJ0Rx
    SW3xt7eQ5BM0Gmdn/56whb8eo5TN9HNOMl0mVZMlKftXlr4vX4xblVJ1bQf4M4CcfF8CD6
    VmDx3kgKH9+65k6KNATWL2jF6dVPKz2YAoKkCJ9o/yp0T13Vnj/ex102T6nCZPwpzmD6Fg
    t2nmWZlrdLzoiKIRrC6fkMAl6KF0wEYbcKfkDiDzJmhUwWnRS7hiAPzkwysB2Zp0Sp3tqQ
    9GYrM0t8Ze1F8FqMX4RVNIu0RmA8CGgXVkRdcWa/0oUSENqiOGLUnAPvo84D/p7n6KdEQE
    XE5STwRVVdu7frqH78Y/tku/qyY/gvc2iIua4M5nsmS0MfXJ0Ltwi5NmXixw
X-ME-Proxy: <xmx:zx4XajbJYbvr5xVhrZ3lrjy6Dn7TINDMMx7yIxsv0rJ-B_YTQrqa5g>
    <xmx:zx4XaiHyq3519bzDxghDjY5-C_XuvRDl1BxKjv5DmNzOm91CL2-vWA>
    <xmx:zx4XahlEpKGo8HxzGh_O0aij34iIgvWMEO8PmxmhsGu0t0HtQ5bH3Q>
    <xmx:zx4Xale4edTPrbMTaRJa1pi-olZY2H8_t2x2KcRTqnad8b8wHVyIlg>
    <xmx:0B4Xalbev1pEMAVTYHAONuZAeTlhAJEofVmwhuqBSQN7MU-7k4Jk8HZJ>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 May 2026 12:41:51 -0400 (EDT)
Date: Wed, 27 May 2026 18:41:50 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Shuvam Pandey <shuvampandey1@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ovpn: hold peer before scheduling keepalive work
Message-ID: <ahceztFVA2y7eFaj@krikkit>
References: <177954800752.73238.12097994883239164708@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <177954800752.73238.12097994883239164708@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[queasysnail.net:s=fm1,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254636-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[queasysnail.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[queasysnail.net:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sd@queasysnail.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[queasysnail.net:email,queasysnail.net:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: C132A5E7FB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

2026-05-23, 20:38:27 +0545, Shuvam Pandey wrote:
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
> Take the peer reference before queueing the work and drop it again when
> the work was already pending.
> 
> Fixes: 3ecfd9349f40 ("ovpn: implement keepalive mechanism")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shuvam Pandey <shuvampandey1@gmail.com>
> ---
>  drivers/net/ovpn/peer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina

