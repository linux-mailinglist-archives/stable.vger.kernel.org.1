Return-Path: <stable+bounces-211908-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEe6HEtleWl1wwEAu9opvQ
	(envelope-from <stable+bounces-211908-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 02:24:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DC19BE4D
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 02:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31D2E301952F
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 01:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4906227EA8;
	Wed, 28 Jan 2026 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9Y5hbQz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942E0224AF0;
	Wed, 28 Jan 2026 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769563443; cv=none; b=oxv8917JbQalMYgYwtf6h7dCVBiv86arV63KS+TPCVa9tG3ZFLOA5hWNMgSWE+cFVgfea+RMyTSHuAXSfPEetdxd76qLutlClrbr6PNx9QeBzLot92JK4Qi3hwFULDqcKJUaSbpSpHKDKiU4Uk/ur+m9AocRBf++KMHVIqT034E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769563443; c=relaxed/simple;
	bh=zWQSF+eV1gOie95S0/r7LJ+YoKdKXI9YPlReRAkCHLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1atAKejij3uovbuImbPiNIXEm6Kx/bWWZCGWX7Psxr8BNXpIyqkbgexF1pvpekQgFmi1hTsIDNTRbdzfolyWYl7n4W+S61BP3+VyO3yZt3JLXUSKf4/wBUJyGzs64CVlcku+Kf/G15dPUh++mFfgdO9DXtBnAWU1IdHF1BD46M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9Y5hbQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F6F1C116C6;
	Wed, 28 Jan 2026 01:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769563443;
	bh=zWQSF+eV1gOie95S0/r7LJ+YoKdKXI9YPlReRAkCHLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G9Y5hbQzTbBidacihpKIJr9Odc/oR5CFooSJKh0uzM2rdbMVg/AYYDyi7y8Alco0w
	 n4Ln5QDS37K+tGmojlFAg3SSgtztPQ0to6qXDmDoyaGw/qgvrUggHx64Kd0CBpqxfL
	 x6620UeVKJj9VmWCeBv4jvvSPXOS40V7eY+DRQIoSFfiCOhad1F7om/oVPseY2T81b
	 OJIlOrhASfg3/A3B5fUBzXU+csTqgCkPb2Ih1P5Oh93TXI2N7KIFKVChGvUYPTvuvm
	 iCzyLqelec34/prSs/6NGNqAL+8q1CS5U4vTtZErx0ExZreKvh2emETD6sJ0POypZ9
	 /Jkn3q2ZL2CTA==
Date: Tue, 27 Jan 2026 17:24:01 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vivian Wang <wangruikang@iscas.ac.cn>
Cc: Tomas Hlavacek <tmshlvck@gmail.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Yixun Lan
 <dlan@kernel.org>
Subject: Re: [PATCH net v2] net: spacemit: k1-emac: program frame size
 registers for jumbo frames
Message-ID: <20260127172401.4bb7bd83@kernel.org>
In-Reply-To: <9f424b4e-b83b-47a0-8637-3df25e504be7@iscas.ac.cn>
References: <20260126135919.77168-1-tmshlvck@gmail.com>
	<20260126171449.83288-1-tmshlvck@gmail.com>
	<9f424b4e-b83b-47a0-8637-3df25e504be7@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211908-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07DC19BE4D
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 12:58:21 +0800 Vivian Wang wrote:
> Oh and... maybe these should be priv->ndev->mtu + ETH_HLEN + ETH_FCS_LEN?

+ 2 * VLAN_HLEN perhaps?

