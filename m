Return-Path: <stable+bounces-206240-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F30C1D00A4A
	for <lists+stable@lfdr.de>; Thu, 08 Jan 2026 03:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A1A93075CA2
	for <lists+stable@lfdr.de>; Thu,  8 Jan 2026 02:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC9B24A076;
	Thu,  8 Jan 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb7bOhoB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 519C9246766;
	Thu,  8 Jan 2026 02:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767838521; cv=none; b=tYMKyckYMKdJz+98zhOEwiKiBxN7U7AtQUsjtUTocCr2EGGArXzhyvDJozsHMCK9FxNA/qOPbvCVgF01ko/6adYbQCfgtR+v0XUYBN894d5JVhhwnDJ8MI6e0jPryHyt3TfmgbJpSidYAAE/Jrt0sPYvdPrfRhCwvuO2Yfq6jY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767838521; c=relaxed/simple;
	bh=wAZTQnqcF1nNKTk27pKmI4uoOHR8LKk80Ax8cowOUsY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UX4e5kJs7hjrzujQYCfN8jwCuxh9tkObID/mZI1fTZ4EczfWXP3/OaouMcy9piUYeckpGGUhRMJ+bPYzjIo5Ni2OmCx8qIkAv2WKUtJ1nGP1+z2g2ZQ5AbeZPJ83mycR72BhArcAUpgqTiyMf9Q0xfWI4ltc9QYsR+/eCj/11HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb7bOhoB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74856C4CEF7;
	Thu,  8 Jan 2026 02:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767838520;
	bh=wAZTQnqcF1nNKTk27pKmI4uoOHR8LKk80Ax8cowOUsY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Tb7bOhoBrO0HhFmEt+YUCQ/KzQvUQEt8cZqm2RkOZ1YDZIE8qbX+pjD6iacmVhh/K
	 POfa86ny4pNoSKAlEv7s2iRTzAqKszU5rOOKawI9LuxvCoIC7/yWqvY5GuxMvWL6W3
	 11JEzmrY1D5cNl8CY1tuir3fMIWD7uBU9nh4Br9RbD6rve/21PFbzWm0e+pELn2tEm
	 sgJzDB4Rvh7Zgi9A6ft+xwSOKniSLdwZiJp7HwvfqZr6ydG5dke4AldJAAypkZqWk9
	 EYXr+D6DZmsLYUAmQ0sj9zj7+tWhZLdyifp20xb8oubr+CNTMCKiklr+Re36Ydqo6m
	 qYOASiNTs6w5g==
Date: Wed, 7 Jan 2026 18:15:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Thalmeier <michael.thalmeier@hale.at>
Cc: Deepak Sharma <deepak.sharma.472935@gmail.com>, Krzysztof Kozlowski
 <krzk@kernel.org>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon
 Horman <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Michael Thalmeier
 <michael@thalmeier.at>, stable@vger.kernel.org
Subject: Re: [PATCH net v4] net: nfc: nci: Fix parameter validation for
 packet data
Message-ID: <20260107181519.1e6dbfc6@kernel.org>
In-Reply-To: <4d6a1f0b-946e-4acb-bfe4-1e9317fd144e@hale.at>
References: <20251223072552.297922-1-michael.thalmeier@hale.at>
	<20260104101323.1ac8b478@kernel.org>
	<4d6a1f0b-946e-4acb-bfe4-1e9317fd144e@hale.at>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Jan 2026 11:06:27 +0100 Michael Thalmeier wrote:
> >> @@ -380,6 +384,10 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
> >>   	pr_debug("rf_tech_specific_params_len %d\n",
> >>   		 ntf.rf_tech_specific_params_len);
> >>   
> >> +	if (skb->len < (data - skb->data) +
> >> +			ntf.rf_tech_specific_params_len + sizeof(ntf.ntf_type))
> >> +		return -EINVAL;  
> > 
> > Are we validating ntf.rf_tech_specific_params_len against the
> > extraction logic in nci_extract_rf_params_nfca_passive_poll()
> > and friends?  
> 
> You are right. The current patch is only validating that the received 
> packet is consistent in the way that the rf_tech_specific_params_len 
> number of bytes is also contained in the buffer.
> 
> There is currently no code that validates that 
> nci_extract_rf_params_nfca_passive_poll and friends only access the 
> given number of bytes in their logic.
> And to be frank, I do not know how to implement this without either 
> cluttering the code with validation logic or re-implementing half the 
> parsing logic for length validation.

Don't think there's a magic bullet, we'd either have to pass the skb
or "remaining length" to all the parsing helpers and have them ensure
they are not going out of bounds.

There doesn't seem to be a huge number of those helpers but if you
don't wanna tackle trying to validate the accesses maybe just add a
couple of comments that the validation is missing in the helpers called
in the switch statement?

BTW are you actually using the Linux NFC implementation or just playing
with it? I'm not sure I'd trust this code for anything but accumulating
C-V-Es, TBH.

