Return-Path: <stable+bounces-52057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EADC907559
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259C91F22D9F
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7AB146585;
	Thu, 13 Jun 2024 14:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rW86Pd7/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9614430A;
	Thu, 13 Jun 2024 14:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289570; cv=none; b=puEuFmzNMPwtkfvrn774OPyRj5BwtelyUl9bTHBC7Z5di2Ll1uXUbI/MR2qxNMbnaEEBLwNKGcumPGPIeUpvFTp67immGQNLKcu2euVSJukD1s4+K928W3wbcZc7JjuDAGRrP4SRh2kGhyXq+RLClucyQCYqhqL0H0GNI2FD8oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289570; c=relaxed/simple;
	bh=vg38Qqi1NtxVq+iaIwtVrD3TpEsJBbdtQTUi7OAhS/o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BLMGkWTGTh35W1OKzO7LHgKwl4s73UNDBASTAsl/Td27H+O5/92GG+9ytIkwKR+MP8uTEmcGt5nVZn8KuhInZoo2Rm9RM7CC9ot8/JCwqnCFzZAaAW5knH5AvQyyqv9IOZySSfk17BzAqpP8/t9Yu8OSNFQBE3GQq934mNROeGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rW86Pd7/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13C86C2BBFC;
	Thu, 13 Jun 2024 14:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289569;
	bh=vg38Qqi1NtxVq+iaIwtVrD3TpEsJBbdtQTUi7OAhS/o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rW86Pd7/xdZnfsZZ+P4pF/+Qg2cZzpurIGyesU+kAajpc6UY4eqqCdPRGNF3VbH7e
	 so4wfnvSxKinTnNDGmYi3DIlv4yL21jBmBmN47sadmzR9vL7ksigappWFCCbkIPywY
	 Vi9mD5HcDPRscWLM+UUD5fLDiuhBS+UzjSeaJnMOwIOccQW4ubhss+iR6Twk2CO/dq
	 xIArb6wB1WcwZXL/6yFF3cLUe4t8DnlfDC5kPDerM4gsVeCcBLMvQZdpQNydPG5Grq
	 vTgNz5KIS+zymR8RZHJDovr1tDPMldApYVcwcJgIAfQ5aylnmq+FLwazPrveB37ljO
	 wnG0Yz1x1dwbQ==
Date: Thu, 13 Jun 2024 07:39:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ziwei Xiao <ziweixiao@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, hramamurthy@google.com, willemb@google.com,
 rushilg@google.com, bcf@google.com, csully@google.com,
 linux-kernel@vger.kernel.org, stable@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] gve: Clear napi->skb before dev_kfree_skb_any()
Message-ID: <20240613073928.5d588cf2@kernel.org>
In-Reply-To: <20240612001654.923887-1-ziweixiao@google.com>
References: <20240612001654.923887-1-ziweixiao@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Jun 2024 00:16:54 +0000 Ziwei Xiao wrote:
> +	if (rx->ctx.skb_head == napi->skb)
> +		napi->skb = NULL;

There doesn't seem to be much precedent for directly poking at this
field in drivers but I don't have any better ideas..

