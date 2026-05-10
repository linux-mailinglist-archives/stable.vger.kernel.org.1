Return-Path: <stable+bounces-245038-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PvmDxaoAGp/LQEAu9opvQ
	(envelope-from <stable+bounces-245038-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:45:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA1504E7B
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 17:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CDB963009FBB
	for <lists+stable@lfdr.de>; Sun, 10 May 2026 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FF4738E5E9;
	Sun, 10 May 2026 15:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBlrIHLt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AAD24886A;
	Sun, 10 May 2026 15:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778427921; cv=none; b=ozB9TDG9vv+tL2v/NskXz4zF89e8zJaO1qNegDDv4Bedxpg4VD7GS4aSJluQ9m/wtstRVyxe98TEcGNxKOIuIKaL4xeAoYbV/luxsjWWTdcVj3IIBVp9szlMoc1M4wLM3vuKtm7CtL1WhxvsB6bCh7mwgSejt/V2sKkwPYmOxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778427921; c=relaxed/simple;
	bh=TOsx3GwWQv2ZQronrWI31p5VMwMdImgcimzYMlnzxuA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EorBRRgv8QpbHIe0/CippiWn1r5LIlADee8MMRJASFd24p3WSGCn2aaKacilUG3LwMiDrpOnsvuHOVypatsDF6KUOG6Xj9htYZoC/IgOOr0tE/fSSdgS/ONhYWs7PiijrL37kV+gwlYcVLjNb8UIcKM/IjlA5YCMgKuRDwl4NKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBlrIHLt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DDDC2BCB8;
	Sun, 10 May 2026 15:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778427921;
	bh=TOsx3GwWQv2ZQronrWI31p5VMwMdImgcimzYMlnzxuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PBlrIHLtbZLx7dOpGJs/e3YlMwB8sTnvGdFBvzXH+HUaVkBlnHFs2FO5FhCbySOI2
	 P5lYfDLVby+IdiSgZxI0YtyVM4c05YbSNO2k6gfPHQ5PtXQDBa1Lh94gXSLGYqD2aD
	 gKVkt1/h232siZFz+xbwExc5iVx8RZWy0ldkkUS8zvJEIi+vytTZsijxShqQjcr0KT
	 QXGIPUudH0dCQ31kFyjVr7FfNAPhCCOJe/R1NRuX049dyJrV8SPYmMXDgCgj9bmeqL
	 NzTP2PtSd41RAOEIdZ2r/LOWrVSJAeNU6Rht2bm48q/REHsr6pJncanlgdFpVYkad8
	 vqlodqgM+Xwnw==
Date: Sun, 10 May 2026 08:45:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 qingfang.deng@linux.dev, jiayuan.chen@linux.dev,
 linux-afs@lists.infradead.org, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v3] rxrpc: Also unshare DATA/RESPONSE packets when
 paged frags are present
Message-ID: <20260510084520.476745b5@kernel.org>
In-Reply-To: <af2kdW2F1gJ9U-Gg@v4bel>
References: <af2kdW2F1gJ9U-Gg@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ACAA1504E7B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245038-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 8 May 2026 17:53:09 +0900 Hyunwoo Kim wrote:
>  			    sp->hdr.securityIndex != 0 &&
> -			    skb_cloned(skb)) {
> +			    (skb_cloned(skb) ||
> +			     skb_has_frag_list(skb) ||
> +			     skb_has_shared_frag(skb))) {

We seem to be getting a lot of fixes for this issue, and this one is
incorrect :| Writing to _any_ frags is incorrect. You have to copy
if skb is not linear. skb_ensure_writable()

