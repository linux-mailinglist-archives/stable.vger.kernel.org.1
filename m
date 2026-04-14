Return-Path: <stable+bounces-237926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJvRCoNy3mndEQAAu9opvQ
	(envelope-from <stable+bounces-237926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:59:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AA73FCC79
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 18:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09B9D305B5BE
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 16:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45DEF3E9283;
	Tue, 14 Apr 2026 16:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1kvt2VE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A61F3264CE;
	Tue, 14 Apr 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776185916; cv=none; b=ld0XWzcHLHFUE26u0xnLDH7wXoLkKCrVTkIeKEtQ6qKkY9Re35cXzrWa6UCgh+S4VOZ3ZQdZnd4DCww1586vGpchRvcZ5YoQ/1c0nE1yIW24bcuRoGzE4Q4Wp56kw0UiTjteuVaM270UAVys8yB9I5OwEP1bIDdMpFrkxOLndaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776185916; c=relaxed/simple;
	bh=CDqRdF6jJ/wVX5TXMdX295aYq8/PzSBpFt58rwujQPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ou4xLRYSWe7ye+0f4zqzyss+Ke9R1p2TllJfSGmqkxUQFy4g1f9m5UV4xWlbrfScsigSFc/FZfp6TNG6L5DAIvpWU6NYa3SXgsMh3f/Ado2hjwmuE9RRRaXVRWSCtULGTZNwt+rA/fhCywvlCNakI4eOmTMJrRHOxVVjIPHZZy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1kvt2VE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 841E8C19425;
	Tue, 14 Apr 2026 16:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776185915;
	bh=CDqRdF6jJ/wVX5TXMdX295aYq8/PzSBpFt58rwujQPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N1kvt2VEPs35RNdZxPNDaxvUlalbzFdq60/0bjQHpekLUW6UjJ1D48PLiLtjIIcbr
	 4M4kBEe8V+2BwmX1b+3imTHghfzqDW0p/kPs5EkP4GMShFfElPM+2aktNh6tFgeFjp
	 81U0T4Yd5z6PxxOlp2dB82kaYM56DxPUaXi27lEbyajthKsmKRI8o+91PKy8tS+EyO
	 bZah31UzQkm/1oehVDjZe2+rmRuBrPuP0kZ5WP0PKJKnEQBzqenHHJfMbRwk9Sw1Y/
	 WYGY8kfM5Ded9oWJhL8X/fNQCiEMYh89Ee06E65XOH/Vo98papNP54Y18JItsawyer
	 nTBcwK6oJvT+w==
Date: Tue, 14 Apr 2026 12:58:34 -0400
From: Sasha Levin <sashal@kernel.org>
To: Wolfgang Walter <linux@stwm.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: Regression Linux 6.18.22: ipsec stops working: reason: commit
 153d5520c3f9 "crypto: authencesn - Do not place hiseq at end of dst for
 out-of-place d.cryption"
Message-ID: <ad5yOgkiFfRzy9pz@laps>
References: <2026041152-boaster-patrol-1918@gregkh>
 <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <b397c5b34ed7484aad6e0acf7e1319c6@stwm.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237926-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[theori.io:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 76AA73FCC79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 06:52:22PM +0200, Wolfgang Walter wrote:
>Hello,
>
>with 6.12.18 ipsec stopped working for us. After reverting commit
>
>commit 153d5520c3f9fd62e71c7e7f9e34b59cf411e555.
>Author: Herbert Xu <herbert@gondor.apana.org.au>
>Date:   Fri Mar 27 15:04:17 2026 +0900
>
>    crypto: authencesn - Do not place hiseq at end of dst for 
>out-of-place decryption
>
>    [ Upstream commit e02494114ebf7c8b42777c6cd6982f113bfdbec7 ]
>
>    When decrypting data that is not in-place (src != dst), there is
>    no need to save the high-order sequence bits in dst as it could
>    simply be re-copied from the source.
>
>    However, the data to be hashed need to be rearranged accordingly.
>
>    Reported-by: Taeyang Lee <0wn@theori.io>
>    Fixes: 104880a6b470 ("crypto: authencesn - Convert to new AEAD 
>interface")
>    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>
>    Thanks,
>
>    Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
>    Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>
>ipsec worked again. We use esn here.

Thanks for the report!

Could you please check if you see the issue with mainline?

-- 
Thanks,
Sasha

