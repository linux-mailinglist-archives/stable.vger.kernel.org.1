Return-Path: <stable+bounces-176759-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8D9B3D41E
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 17:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1459B18989A4
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 15:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E47126F293;
	Sun, 31 Aug 2025 15:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="JisNLMvg"
X-Original-To: stable@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1D32580D1;
	Sun, 31 Aug 2025 15:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756653563; cv=none; b=W46vRNJ26B9ZNsCtKvkZW+P0mqMELFBuMkHSYP32ctI2kJAuMjwdvcEzBh7wFz7tbt3pcrM40O0mJzfEYcH4Wz8ImX1rsKcJ+GyhAsZbxiO/dHM6NhZ/Y8jiyelgyhndPVHtu4op31yyL9EKYTBfoatfKi5+pOjlrUj5YLHNfYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756653563; c=relaxed/simple;
	bh=4ePRRex/GG9RYyyU/5XKFJ3L/dp3XbV6QBOj34gg1Tc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J76b55T0kxNnCtvNaF/mzvrHJoVPvT76Ba62rLllk8zGX5M/yyE2klco93XlEmJx18SOEA7Nmtmxd7UV3ov3FsyetzQxN+yr20+eQpfQwHTq8gjgUfQTEwXVGGkK1Exnk7DUtTELB/13zt/MUiY+m9IXNnk6ypwEsUbQ3E7zWwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=JisNLMvg; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 3072A20000;
	Sun, 31 Aug 2025 15:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1756652951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=crdcp8etfaKPi7nRe4woJB6Vpl8jxEOkT9Rr52gb7aY=;
	b=JisNLMvgegqS02gjV+g9EXc8bgjlZdE9sARjfDMbMkT5xnm1AZEmM3wb1ykqFd2EWAAgCe
	LA+z4LE7cJcNmBrmR9OsJl5UNqrPxXoDWA97jYwvfu36QBm2heBXPc970cRTacnSS4vixJ
	ECF1b6HEhrLZeegFEBkB0D7GK4W2R08=
From: Sven Eckelmann <sven@narfation.org>
To: netdev@vger.kernel.org,
	Stanislav Fort <stanislav.fort@aisle.com>
Cc: Sven Eckelmann <sven@narfation.org>,
	Marek Lindner <marek.lindner@mailbox.org>,
	Simon Wunderlich <sw@simonwunderlich.de>,
	Antonio Quartulli <antonio@mandelbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	linux-kernel@vger.kernel.org,
	disclosure@aisle.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] batman-adv: fix OOB read/write in network-coding decode
Date: Sun, 31 Aug 2025 17:06:38 +0200
Message-ID: <175665260151.58639.6084959400627208281.b4-ty@narfation.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250831145623.63778-1-disclosure@aisle.com>
References: <20250831145623.63778-1-disclosure@aisle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 31 Aug 2025 16:56:23 +0200, Stanislav Fort wrote:
> batadv_nc_skb_decode_packet() trusts coded_len and checks only against
> skb->len. XOR starts at sizeof(struct batadv_unicast_packet), reducing
> payload headroom, and the source skb length is not verified, allowing an
> out-of-bounds read and a small out-of-bounds write.
> 
> Validate that coded_len fits within the payload area of both destination
> and source sk_buffs before XORing.
> 
> [...]

Applied, thanks!

[1/1] batman-adv: fix OOB read/write in network-coding decode
      https://git.open-mesh.org/linux-merge.git/commit/?h=batadv/net&id=d77b6ff0ce35a6d0b0b7b9581bc3f76d041d4087

Best regards,
-- 
Sven Eckelmann <sven@narfation.org>

