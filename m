Return-Path: <stable+bounces-225400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hwg7FyWetGn8rAAAu9opvQ
	(envelope-from <stable+bounces-225400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 00:30:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B022C28AAD8
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 00:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E786F305A8B3
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 23:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8003D4133;
	Fri, 13 Mar 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IsW95amD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDB42DC32C;
	Fri, 13 Mar 2026 23:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773444639; cv=none; b=bJckChliSAuX3FJVo1pGu65cMR9CIPe4z+n8OGG+K40WCj/6dIrl2tUA9K9seSHDWTOmJGh+g3QAkSvYqYaff8NwmgRnTVzdorqnTJW5cCST9ZWSAsGnixZVkhoXVEBY9mJUrl0xERJ441yASVj9aC4/BfCbFec3hW9srSP8mCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773444639; c=relaxed/simple;
	bh=uTeSeSlCgaPeffCAks/hHxOGsjXpFVGlrY/BtJT+Uak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kHIf8XC8kPiprM1Cm8hLCk7xjHSUNWZ4YKF/L8pMByiUl93ElSLBbaMsVlAdAORuloI6a9Zf3NUJM0Ztbexuh2SlLqQFRanj/KrsM0xJwULcClY+ReZzJx2BWKhgAx6IfCJ39KTV09Mpn4xbms+xlkpjN7aqm5v1kPN20CrL4KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IsW95amD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC1DC19421;
	Fri, 13 Mar 2026 23:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773444638;
	bh=uTeSeSlCgaPeffCAks/hHxOGsjXpFVGlrY/BtJT+Uak=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IsW95amD6AcCIi/6297AVrkAky2hs8HRwQoqHc+xJ803QJ3i7Qeo8H+bHv4NzC0G5
	 yrURZxqrR/9NzBwestFt03Q0YOUHXbdw1LzpWtn72rHZ0it+huASDfO8mHLL0o7zIp
	 V4xJvCOUYKg96y2t+yUahKaJK/7uOl0kLwcqjFizJ59ZfYuUtoznuFKDCJTHGRw4gi
	 fveVzGvBWvCpkhzQAwUhnU9DeHIPj1RH1Tzt5UhzFYE7aPEiqvZ4260QYiQQQQStrb
	 zo96yyTc7TJMjRhOLFrMDPtpvy82VktKbOexiDOXLR+5go5kNEBoY+y42XaaZBNekt
	 SgvB/rM4QZnIg==
Date: Fri, 13 Mar 2026 19:30:37 -0400
From: Sasha Levin <sashal@kernel.org>
To: Cal Peake <cp@absolutedigital.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
	stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Re: Linux 6.18.17 -- build regression
Message-ID: <abSeHSCt0CYJNuyX@laps>
References: <20260312112454.940017-1-sashal@kernel.org>
 <b1844e83-80a5-973e-93bd-9e721e27ebb@absolutedigital.net>
 <abNdx_cQR_BqMm3z@laps>
 <df7fe0-786-bfe7-511f-b147fa6138c@absolutedigital.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <df7fe0-786-bfe7-511f-b147fa6138c@absolutedigital.net>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225400-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B022C28AAD8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 06:20:18PM -0400, Cal Peake wrote:
>On Thu, 12 Mar 2026, Sasha Levin wrote:
>
>> Hey,
>>
>> Thanks for the report!
>>
>> Could you please confirm that cherry-picking 93d0fcdddc9e ("cxl/acpi: Fix
>> CXL_ACPI and CXL_PMEM Kconfig tristate mismatch") fixes the issue you're
>> seeing?
>>
>
>Hey Sasha, thank you for the reply.
>
>Took me a minute to find that commit :) but, yep, it fixes my build error.

Yes, sorry, I should have pointed to it better since it's not upstream. I dug
it up from -next.

-- 
Thanks,
Sasha

