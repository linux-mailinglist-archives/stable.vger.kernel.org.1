Return-Path: <stable+bounces-253566-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBDwIagUD2otFAYAu9opvQ
	(envelope-from <stable+bounces-253566-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:20:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BA9C5A71F4
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5257331FF6E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2D3296BAF;
	Thu, 21 May 2026 13:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGMOd0dM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB922475D0;
	Thu, 21 May 2026 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371317; cv=none; b=u/EVTNmBXxQ19Lpp3fYHRC7ZKUf0VO1foV7JxB52UyVBg70cToFELvJDXgj767tDX4xSwIcwHbhizn1R/4hl2TPdqtuKSR/qcGJxsaCfb/kKl5V8NhuIb8Lpuf4UXCV3V1OkpaT5Mx33+VwNeVlvzy/Jo2T7KhClpZnrQ64JNHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371317; c=relaxed/simple;
	bh=m2asofVTv85VSPVW+mhXZ5SAuGDh4pyWl8zspJQhsY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sqHT83kN9bO1QXWChWCJ24j2rKOqi3CB6fZS4hsgpFogjnZQGewXmghL/crTDajN9D2u3YddbLpy7jqBKXVTx1Dxu1NqoJhByRk2W1/P+kbYaAG6JvJ2j7MIdVrnt7qKVeEb7da07lXXj4PLkBW1JWxcIkfmtlHTbATMrDC7xeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGMOd0dM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A801A1F000E9;
	Thu, 21 May 2026 13:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371315;
	bh=v9n2/V1TR/adB6rGlayiaWR3IoulH62eI+d+Pt5mXeE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mGMOd0dMAFn+3GkT8YeZQsPYDujoTpLfv8IS+jtP3bO1fJlcwlw3nT97hqlVfduJF
	 lnF0n9By8IVmTglOqqSx4v9xmWbsNFpv3OSaiDzMrP6Db7wciNlLhqKdfni7U0GfT2
	 MmYhM8G6+gvgcPKU/H1PgDwV1WGQ5dQU17qqfllJRG0yB/cXns9g1N67bDg4UGIqe6
	 DwQ+5DAcPQRz8LRnkNF10oC7v+hcrMpju9m+tHmYkDGgYVscBrUNEwYsMVWBRG4tjS
	 auZpvOzCq+/xY/5OD3X9KW+Oe6fJjO6EBNrt3rahwhiYkMK5K0J5Eq6XdfZba+yS71
	 ORiufHB3MeaRg==
Date: Thu, 21 May 2026 09:48:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 7.0] dsa: tag_mxl862xx: set
 dsa_default_offload_fwd_mark()
Message-ID: <ag8NMiVCCF8fx1IB@laps>
References: <20260420132314.1023554-1-sashal@kernel.org>
 <20260420132314.1023554-153-sashal@kernel.org>
 <aeYrbNyGsx4mvo9J@makrotopia.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aeYrbNyGsx4mvo9J@makrotopia.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,kernel.org,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-253566-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3BA9C5A71F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 02:34:36PM +0100, Daniel Golle wrote:
>On Mon, Apr 20, 2026 at 09:19:07AM -0400, Sasha Levin wrote:
>> From: Daniel Golle <daniel@makrotopia.org>
>>
>> [ Upstream commit 4250ff1640ea1ede99bfe02ca949acbcc6c0927f ]
>>
>> The MxL862xx offloads bridge forwarding in hardware, so set
>> dsa_default_offload_fwd_mark() to avoid duplicate forwarding of
>> packets of (eg. flooded) frames arriving at the CPU port.
>>
>> Link-local frames are directly trapped to the CPU port only, so don't
>> set dsa_default_offload_fwd_mark() on those.
>>
>> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
>> Link: https://patch.msgid.link/e1161c90894ddc519c57dc0224b3a0f6bfa1d2d6.1775049897.git.daniel@makrotopia.org
>> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>
>> LLM Generated explanations, may be completely bogus:
>>
>> Now I have all the information needed for a complete analysis.
>
>This commit should NOT be backported, it only makes sense with bridge
>offloading implemented, which only happened with commit 340bdf984613c
>("net: dsa: mxl862xx: implement bridge offloading").

ack, dropped.

-- 
Thanks,
Sasha

