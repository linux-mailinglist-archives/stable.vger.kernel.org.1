Return-Path: <stable+bounces-254460-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPwmM65CFmrnjwcAu9opvQ
	(envelope-from <stable+bounces-254460-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:02:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F195DE213
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A9C43027D80
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7DE2D3A69;
	Wed, 27 May 2026 01:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CyNzGevL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B202AE8D;
	Wed, 27 May 2026 01:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779843755; cv=none; b=mx9OhGD9NZWxlPt7M2MIWO8Jq8C2cOUe87xbTwjwh6DbIVJ5Nn42i8rPlhIevzOKCZQhXc4D9W1QKX+UtPSmp/kddGxpJhTkEIZpfLYS6UJZE5+yHe/taRdf6Ct5KI/cyddRtvoCpGP8eD37xFP/s5L147ODMyiTgH5jxyVEi6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779843755; c=relaxed/simple;
	bh=Z7A8aH8+gGhTh+ua1E6eHUGTKg/R+gEV89gBLqLZZLo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lU2TRnKXx1LBrOd7ZSz88WxT7V8COeN8empWep1G7G8rO+bAozgSrlfprgBQNpjx8UhgrWIV2E83dA33RSgOpaNoZgI6CuVkPkqzhIhKX+9i0+3I+6AF6ukEOQD9seKkSL8lFN8PS6fCheDAgT1JR5iv/yfZu27O9SJz6RiP3cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CyNzGevL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C58FF1F000E9;
	Wed, 27 May 2026 01:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779843754;
	bh=Z7A8aH8+gGhTh+ua1E6eHUGTKg/R+gEV89gBLqLZZLo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CyNzGevLetjSzKwKqh7PqnYgr1yWTPH61MZmdFMmE0Je4/w2EvR0y29qFr85B/fIR
	 qxRrxSMZ9Zwe8H61jX4m7MDPAKGAtIZUOUdgDzw9M9x4F3zKrsyc/tkG0/esqm178G
	 xxfcZM42SieIBNtt9x3OlD6pqZWbh8Y5Cd5RTj9v3WHF6vymofrKAseuESBDEh1RBq
	 6BDaJdCV6T8R7/n/ZsYc2kkO97+Edrj+Qs39TzZf/1NDSDkJjzCqF/1ssvDMPNy+PF
	 8f3dVEEYaD/FcMVdKUp2m9rydB41i1PZZb+6exaNJg4KDrqT5S1TPNKw1oI0jawgCQ
	 w7TCp0T6cirVg==
Date: Tue, 26 May 2026 18:02:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Junrui Luo <moonafterrain@outlook.com>
Cc: Sunil Goutham <sgoutham@marvell.com>, Linu Cherian
 <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, hariprasad
 <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang
 <danisjiang@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to
 same PF
Message-ID: <20260526180233.4323832d@kernel.org>
In-Reply-To: <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254460-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 36F195DE213
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 24 May 2026 15:29:29 +0800 Junrui Luo wrote:
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>

Really? I thought I saw this reported in Sashiko..

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260520154157.1439319-1-michael.bommarito@gmail.com

Either way, Marvell folks - please review.

