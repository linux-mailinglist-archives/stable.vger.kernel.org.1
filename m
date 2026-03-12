Return-Path: <stable+bounces-224893-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LryNbLusmnAQwAAu9opvQ
	(envelope-from <stable+bounces-224893-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:49:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B82275F22
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7400C301022C
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B22E3FB061;
	Thu, 12 Mar 2026 16:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GE2xnE2v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEAFD3FB078;
	Thu, 12 Mar 2026 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773334161; cv=none; b=bITon8NomABz0sHLfRqNqRMLcmDT5DT/wCT+84XpPd5SFjz8FNoIXL9QtXaLgSkbtxlaWDzQq7VaoktsgKBbCnu5nRMV5Jw8VqddaUv5jFTt0OfyNB42KfqPwwtaaT9gwR4y8y0NTe5E84RG26cBUjLY3xPoxXal9i2UoDlnTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773334161; c=relaxed/simple;
	bh=CKjsMtBY0Bir9Asltf6sE4JGRZVkGB1mbJpvZHhLBik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eRs23IxrQ1V7Fozpsq/TGze5OetgDND4aAjObq6YYZa+M1MewRC3FGiaY6G0lr41rqq8m4SD8/vEgtgoM7UT1FTdvrU0KAyPD/qqEpPpDz8G0fCsRALpfCfeMEcvN9j0XMBzfX4JN2WPVubx75pp1FaSv6RbPUQsB0oFp9K1f5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GE2xnE2v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04C1CC4CEF7;
	Thu, 12 Mar 2026 16:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773334161;
	bh=CKjsMtBY0Bir9Asltf6sE4JGRZVkGB1mbJpvZHhLBik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GE2xnE2vDgMFa+mX0SH5Y5jcTy9ctXVil1fgizeAU12FPbmSuI+pbd/5//d7RXzb8
	 a19hcU9yCBn9gj37FQCQkdBfYDUWTYrfHeIHO66+PDRdH/ox6f0p8Aag8pqwE6Qt9p
	 1yGF1Vr7kK7xY1VaJVnVke2u/RM/tcGPKmvkdlUSiI9+FHXxNveGxKIdOgwrzetopM
	 5t9znwqV49D6+TxeY7zqVe51CUOTN8vB+AwF+42KQj7ZGx5tJG6AUBtRfdCMdATKzO
	 btZXdDfF7PlS5hlw/ExbwKdJ6d6J55HjoL/FmupS8F7ZmzK88pn+1gWo09vXN5zFcO
	 Hky/jioUHi+nA==
Date: Thu, 12 Mar 2026 12:49:19 -0400
From: Sasha Levin <sashal@kernel.org>
To: Eric Hagberg <ehagberg@janestreet.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org, peterz@infradead.org,
	kprateek.nayak@amd.com, shubhang@os.amperecomputing.com
Subject: Re: [PATCH 6.18 022/314] sched/fair: Fix zero_vruntime tracking
Message-ID: <abLuj_pax8huB_BR@laps>
References: <05467440d95c78161254bab895be5692e4f0a3f3.1773141555.git.sashal@kernel.org>
 <20260311161400.1003322-1-ehagberg@janestreet.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260311161400.1003322-1-ehagberg@janestreet.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224893-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: 54B82275F22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:14:00PM -0400, Eric Hagberg wrote:
>Shouldn't this also be applied to the 6.12 stable kernel as well, since it has the patch
>mentioned in the Fixes: line?
>
>The broken tracking mentioned in the test case is seen in 6.12 kernels as well.

Could you send a tested backport please?

-- 
Thanks,
Sasha

