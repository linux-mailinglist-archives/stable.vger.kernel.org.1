Return-Path: <stable+bounces-253568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UCNoAeYVD2qVFQYAu9opvQ
	(envelope-from <stable+bounces-253568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:25:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 786BA5A7378
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1091318BB31
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 13:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D214A2C11EE;
	Thu, 21 May 2026 13:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KU+L1bhn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A627225B088;
	Thu, 21 May 2026 13:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371454; cv=none; b=NtNnYZ05dosy1JRtBno5z3BOYpajiXn+C8C1Y/Zl/qX9F/qO6C9Vr1vOQ17cOyt3YYHcbxwDtq6dsK4o84zn/my6yLlUZDi6P3d8GZCNK1QlMo2Oywuj5e8OCwcyu/A0ysTjXawr1eHZv6lxkWSxPX0ma/6RjxaISoMrl7Q58n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371454; c=relaxed/simple;
	bh=40lnbX/B4TmZrLxtLmrUvKA+bAtTrq5zUrcmu01Pr18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E9Rg68mbGPkkl8Mjb2zglYHJdPtp5XGZkQlRNfQnYEXQIAasvzjNmsnNAv/BbSgFMf58ybIn7PkX+vDrUqICddEtB6h7Ch8ek9HbhveK2pigDRG2axVNb06gQWxVIkxxTQV9yzOvFWnkZcbmHHJDbAN+wAAt3gJ77O/mC0oBpOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KU+L1bhn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2431F000E9;
	Thu, 21 May 2026 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371453;
	bh=T5hUWqoBcetWurFLT+WqKkXg5w0LR6aXBSY+HmvYLjY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KU+L1bhnkhJo/MV32/XO49EHNota5MiSQTx1Oho3nvbRjIneiUuzV9T1KvRs3UzWv
	 POaTH4viRB4gKePFpkcdETzOTfHI4PQgQOegI1huOrOkyfb/s+dnBJvofHtIL+Pp/Y
	 kArxZHDsWup0p9xyM/dAJ8iH+GLxYL55pMPdj1e2WFPONwUtlzgB5b9mxTy41/so2y
	 JbmgvUgCk69QQLSBsGL+vVmi55Kt2NKPdNj07oUsgguhbnuzyA1Ny5LWrhnAjSIekg
	 gXOwKYvtCWzBfmfbT5Nd7yI4LSPrtF1zYv838vxPQgnQs9BDS72HRE91OQ8SvqnsdD
	 mz7aRlS0nPS0Q==
Date: Thu, 21 May 2026 09:50:51 -0400
From: Sasha Levin <sashal@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: patches@lists.linux.dev, stable@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, James Morse <james.morse@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 7.0-5.10] arm64: cputype: Add C1-Pro definitions
Message-ID: <ag8NuyPjvHmz8K5Q@laps>
References: <20260428104133.2858589-1-sashal@kernel.org>
 <20260428104133.2858589-51-sashal@kernel.org>
 <afCWPTqKxIqGPe1r@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <afCWPTqKxIqGPe1r@J2N7QTR9R3>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253568-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,arm.com:email]
X-Rspamd-Queue-Id: 786BA5A7378
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 28, 2026 at 12:13:01PM +0100, Mark Rutland wrote:
>On Tue, Apr 28, 2026 at 06:41:02AM -0400, Sasha Levin wrote:
>> From: Catalin Marinas <catalin.marinas@arm.com>
>>
>> [ Upstream commit 2c99561016c591f4c3d5ad7d22a61b8726e79735 ]
>>
>> Add cputype definitions for C1-Pro. These will be used for errata
>> detection in subsequent patches.
>
>This definition is only needed for a workaround which is only applicable
>to v6.18+ (and the downstream android16-6.12 tree).
>
>We needn't backport this patch to v5.1.0.y unless there's something that
>depends upon it.

I'll drop it, thanks.

-- 
Thanks,
Sasha

