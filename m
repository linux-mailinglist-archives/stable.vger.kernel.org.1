Return-Path: <stable+bounces-255023-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H4cLBtSGGqwiwgAu9opvQ
	(envelope-from <stable+bounces-255023-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:32:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CD95F3BAB
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 16:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16DE730612B0
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 14:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443A73BD224;
	Thu, 28 May 2026 14:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eWbst5Nn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3E726738B
	for <stable@vger.kernel.org>; Thu, 28 May 2026 14:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978710; cv=none; b=C9yxKKUw5MGGQTaiKOBxST+1Q6J3ZksXGawecwwxnkZLMeg9FDIoFKdUJtrQZvuSJ1Y+kX/AEQornv6lHm9wUtMxPIwkOkvoMdTwE/KtkOVD8iOTducxGDh90fAh6fLiBkj7As5QhBZ+oRVDBADZ8Yh+Ly/OBp113N+HURMofAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978710; c=relaxed/simple;
	bh=SXlX7u48JnMYKj0Nje6QkmsuNv0J7If4EK/lplL+lZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DsalK+BM9B+/gmV1xmnCzsbAT4a+XbKStibEH9D1xnAg/IUgSilwCKDPwT4F202yx/8DKf0spOta9/p1u0wSA7R5fPymo18w0zaanoDZdIBVplcVBAy/rmRi4ljuc1lLsWZ1jgHMk4EL2zIeMoE6Mz2OBzW43yLEHrFS2z89bQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eWbst5Nn; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so72794115e9.2
        for <stable@vger.kernel.org>; Thu, 28 May 2026 07:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1779978707; x=1780583507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bM+WzYj202rkhAKw8isFN4meBqK+WDYoMBYuhC1fFsk=;
        b=eWbst5Nnb2w9WuVCo8m3AAC9Bn5jGWnrLKg75i+1Xfq+EIV5SMpqw68QD4xIvTzrw3
         ev9rd8Sv/IF01cnXct6I8NytbTpi2sEkLcPaoCF7R8FFFc7Nd/Ral0XrkF64E4HevZ5a
         24IJOpiYJ2CQYIq/uTldsnyosyKDB5a1Ny9gKZ/F1X7gYm7nT9uPXXQpIhKPMp5KQ82N
         BrGTS+ZUtKHK6WWAfIMFRiGljl4dh3auW+7B4b5mK6xYx+OazHflR129QHLJp8KWPM9b
         nyziR+/HrbCQeLIPzB6eAHfIayBM5XYye5r2ysnVX+eC0uWZA1XHsUFy6eyxBDqGcyhc
         eMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779978707; x=1780583507;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bM+WzYj202rkhAKw8isFN4meBqK+WDYoMBYuhC1fFsk=;
        b=WSIXdZeWLvui3+U8xzOwrOU8O/tRuD/GqDqW4iNBzxQbiFcI+2dDXtFe2bSBy8I10D
         x+qQLLyItbFBJU+aOMHB3MUgkbNc6WTZqEZ+qzbI/37ZSsh4UbF6xwTnT1/5/jkebQgl
         j3tKMLZULTBo9O6asZytwO/+yfLZrif4X25BUvprgjoSBzXXa+wr2nESoKwNztmKk/8E
         TT3NWgISEtOzjiwfuD1wvWXENWX65l3wsuJHBkpHCe8ELqPj/hPR97m178F6glC/b9U5
         FzuEqO4iM93P1E1u2f7oDbWc6UKyMLDBY/QrZrMHuxsndh4y3E7GC1I9ua5dHvZp449w
         uZRw==
X-Forwarded-Encrypted: i=1; AFNElJ+gxs18AP9GyMcwP30qgUU7pmDrnpb4s1xEzIcHvpNHkb5yUM2zdUACxBTqnJn63TFPVaEVWfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEak9TiacKxrdBxkUHL1ZC0aaKm18YFH4NCxC5PwkpKIanwKq+
	jFwtCLyh1K7cGfm4E94Ai/pOxHEMald5gFyl+v+oIFGM/O+sHa+i7uFcookXNnoVs7RI4VYFEBI
	jc+HrX11RGZuj39vCkZo3WGJ7nmzGHeOugd1uKdHCpSqRBZ+AuY4=
X-Gm-Gg: Acq92OE2rODraJpDh8P2faANbeJSJVupslMANmcLvj+bpwqPg3P5KeGmd2eqKry0M6J
	y4HqFiUsqSezWgZZeBs5FLWL7qbfec8dL25Vtyu9o9m7kttVnvPMILZUmw6rLiW2ys7tFpJJ0vp
	33VsJ8KhMYZTpKWrH0Y/OdqaK7aXax6zT6vShppiTbpv4eYp2Vl8gJuuzQm2uSaC0KCUAoT56ga
	r5rVAc58oKg/4nNT4hzZRlrTIv2vuzhSvP7/qYeCh0X/gziOilbRsUmOk+u54+AHVd97MiEyR7M
	ISKwpWBo9g3GsM2+rbbZghUUUpiZyl7RTpcKD/aRDu2m+kKRrtv5GI21mAoJCTQVlWYEsotRDSV
	vWjai112P5NUISclhrEnDwOB1t3WTP58SzNxYYrumCKgDv5sEmvCvZJK/jx0MXuxlcQfPQl6O7y
	YF2nBkNsnepl6A/7ywXin24AVGKBmXXKYenObbQOmLRLvmU62QLLik+lpUvg==
X-Received: by 2002:a05:600c:c16a:b0:490:6237:5200 with SMTP id 5b1f17b1804b1-49062375334mr331038155e9.10.1779978706926;
        Thu, 28 May 2026 07:31:46 -0700 (PDT)
Received: from inifinity.homelan.mandelbit.com ([2001:67c:2fbc:1:4cf9:4344:20b8:5b16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908e9b0c57sm25004975e9.7.2026.05.28.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 07:31:46 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: Pavitra Jha <jhapavitra98@gmail.com>
Cc: Antonio Quartulli <antonio@openvpn.net>,
	sd@queasysnail.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] ovpn: fix peer refcount leak in TCP error paths
Date: Thu, 28 May 2026 16:31:40 +0200
Message-ID: <177997869357.4170470.2497863930631173471.b4-ty@b4>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260523090244.504790-1-jhapavitra98@gmail.com>
References: <20260523090244.504790-1-jhapavitra98@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255023-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 78CD95F3BAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, 23 May 2026 05:02:43 -0400, Pavitra Jha wrote:
> When either the TCP RX or TX error path calls ovpn_peer_hold() followed
> by schedule_work(&peer->tcp.defer_del_work), and the work item is already
> pending from the other path, schedule_work() returns false and the work
> runs only once. Since ovpn_tcp_peer_del_work() calls ovpn_peer_put()
> exactly once, the extra reference taken by the losing path is never
> dropped, leaking the peer object.
> 
> [...]

Applied, thanks!

[1/1] ovpn: fix peer refcount leak in TCP error paths
      commit: f9e5e5f464d7a7c5b71a48e06d616f57e05a66fd

Best regards,
-- 
Antonio Quartulli <antonio@openvpn.net>

