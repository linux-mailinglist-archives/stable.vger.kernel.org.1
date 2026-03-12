Return-Path: <stable+bounces-224827-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF+pF36Bsmm6NAAAu9opvQ
	(envelope-from <stable+bounces-224827-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:03:58 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E5A26F569
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D56B305E374
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BBC38BF77;
	Thu, 12 Mar 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACnH9tBi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59CA32B98A
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 08:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773305901; cv=none; b=rl9caoURea9aFFkAXAsf4XNRTavDXKbnJWMtChvrsDaU28UKnqAugD3EO40oCNNqeoP0xUlkwdYZlcWWuTiTJLSVaCj7J6nxVBXqWJf516lxtPLi8GYnbcA2nC5i+ydFBX9KO5efj0xt5X3SZLCWs0dXDu0aBaYcCW7CugFkIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773305901; c=relaxed/simple;
	bh=yd9dTnuEPaVCMdPoTWlSnyuXsB191Tq7bJHQNSnx/0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=iESsfzwY+7MW7cTSDUYQqdrXJ7dQ9UMA8iivibUphs5P89mps6J4tw3UC0RHGreMIzMt9JXjRmz7uur7PLZE+lMTh7kpegot3zdkY4m67TIdGTLHw/c17iSnC7tYAC5tCl1anJwgfJAeAmr5ojcvOxsVn9wzFScVX3tyhMjZ3VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACnH9tBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D80AC4CEF7;
	Thu, 12 Mar 2026 08:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773305901;
	bh=yd9dTnuEPaVCMdPoTWlSnyuXsB191Tq7bJHQNSnx/0k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=ACnH9tBi2rKxLExhfeBp9HdgShllKrcZnB8IENWUFizmljaEq+PWE4Jv8CAZNJ+5K
	 kviGYk5HD9a2d7qEBqQPlHNS+YHzMA5SzCNj0tuq4MY+avtOjbfb7uXcHj5tDP8S5S
	 cAQvlBArN/1lkAesJDzlRo+GNdxCgwwA2UM7DRUoWQP4gZzntx5GyMUC1ttoGMSaJT
	 asLBBwopWOXdR0RjAJd22ft0jBJLXlNfrR1cOC3l4UaM6NkMrIhwMtyt1oLmFGCBfn
	 ejsNunhqW4/CuQpXC9USnzjJ4lrd7jo/Hu/vGTwfUY3/3ZOlZJgoDWmeFY38CD2Uzq
	 4CtDXRUBOGGhw==
From: Srinivas Kandagatla <srini@kernel.org>
To: linux-arm-kernel@lists.infradead.org, michal.simek@amd.com, 
 Harsh Jain <h.jain@amd.com>
Cc: Ivan Vera <ivanverasantos@gmail.com>, stable@vger.kernel.org, 
 Harish Ediga <harish.ediga@amd.com>
In-Reply-To: <20260119093547.3583707-1-h.jain@amd.com>
References: <20260119093547.3583707-1-h.jain@amd.com>
Subject: Re: [LINUX PATCH V2] nvmem: zynqmp_nvmem: Fix buffer size in DMA
 and memcpy
Message-Id: <177330589994.2413514.5926618043707689822.b4-ty@kernel.org>
Date: Thu, 12 Mar 2026 08:58:19 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224827-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,amd.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[srini@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RBL_SEM_IPV6_FAIL(0.00)[2600:3c0a:e001:db::12fc:5321:query timed out];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 15E5A26F569
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Mon, 19 Jan 2026 15:05:47 +0530, Harsh Jain wrote:
> Buffer size used in dma allocation and memcpy is wrong.
> It can lead to undersized DMA buffer access and possible
> memory corruption. use correct buffer size in dma_alloc_coherent
> and memcpy.
> 
> 

Applied, thanks!

[1/1] nvmem: zynqmp_nvmem: Fix buffer size in DMA and memcpy
      commit: 93a1b86f51c8c552db86216f065af42cadf5595d

Best regards,
-- 
Srinivas Kandagatla <srini@kernel.org>


