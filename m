Return-Path: <stable+bounces-227544-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKYjMZpSvWlr8gIAu9opvQ
	(envelope-from <stable+bounces-227544-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:58:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F25C2DB7CF
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 14:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74B9630166DA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 13:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D91D3AA4EC;
	Fri, 20 Mar 2026 13:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltQbG26H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33EFC3B894B;
	Fri, 20 Mar 2026 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774014707; cv=none; b=fj2uAeZqz+2b+J+ssSfDAA2+v/6vWp/JiNIK3CPYpORq0RRgmOJ81vNYN9+/yJAOsX5dIdexKQcgZwz2GAucjrHknxtBYup+GHjXcKOpAPmQuqj/6FbmZm23iOunZZFkX5p0gV4ZkQdukPO54SVcyijQZcX0Ta7WAjNvSQwV/ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774014707; c=relaxed/simple;
	bh=W56nhz/OJe+engKy6ybW//z+tB6M9vtVQzHrI3fzpnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UXme37TxDD0eSIUiDZuUPz6AhGGOcwx/74YsRyT5QWOb2FSXyHJJ+nc6M635HuOlfHTGfUbV4E2aoXHXTEyoM+rpUfSqvqF49hbc1QBnag7FHD8wT5hWY9mqcJiz6iNo3acUinTV7+YbrQddPJFqn+4eDV/1hL98V5WT0z4WGq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltQbG26H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B004C2BCAF;
	Fri, 20 Mar 2026 13:51:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774014707;
	bh=W56nhz/OJe+engKy6ybW//z+tB6M9vtVQzHrI3fzpnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ltQbG26HdfD/d3MAH9qAWMjd9pgJh5kOAEBpZyISm8lq/F8hMCNyHAZrjxfGtSYvR
	 Lpe6E8OQo0HvZeQZ4OPm2B8gfZE+vXp5P9zRvGzqxJbYb4Q3wVhCuE04xk0woNQWMn
	 sa+L4AdqGbacrHr90yQ/j9PZ9mwYumhbqqBEDdKKxl9+BNuqwcsqdsEFptft//0Na3
	 DBI1CWWnL8uv7swapW/bk/M3L/qX/2gaMx5feWSo6J568teyY/88xGhk6qT8P0g4Bn
	 jmPNrUJ0BQaVE+G2nAvUo+YX7oW+KBzEy0CV+PRm6bKpyZ+/vtX/M+G9Na3vd2Srg8
	 YlYIiXHDxuUgw==
Message-ID: <87878ae4-dd03-41fb-83bd-eb89809e8e37@kernel.org>
Date: Fri, 20 Mar 2026 08:51:45 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Unable to pass AMD RX 6400 GPU via VFIO
To: Mark Somerville <mark@qpok.net>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>
References: <1be114e1130ca59ee91fc5a73aaf43a912d408ea@qpok.net>
 <1ce6b64b-47e7-4e73-a73f-58bf5f5202b1@kernel.org>
 <dab036c7ad0ce6c28fa25b8c30e68cc20ed2a8da@qpok.net>
Content-Language: en-US
From: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>
In-Reply-To: <dab036c7ad0ce6c28fa25b8c30e68cc20ed2a8da@qpok.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-227544-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qpok.net:email,aka.ms:url]
X-Rspamd-Queue-Id: 3F25C2DB7CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/2026 8:33 AM, Mark Somerville wrote:
> [You don't often get email from mark@qpok.net. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> March 20, 2026 at 11:42 AM, "Mario Limonciello" <superm1@kernel.org mailto:superm1@kernel.org?to=%22Mario%20Limonciello%22%20%3Csuperm1%40kernel.org%3E > wrote:
>>
>> If you bisected to 8140ac7c55e75093a01c6110a2c4025fe7177c57, try adding f7afda7fcd169a9168695247d07ad94cf7b9798f.
> 
> Ah, nice one! Just tried that and can confirm that 8140ac7c + f7afda7f resolves this problem for me.
> 
> Also great that it's already in a later release than I have been able to test!
> 
> Thanks a lot for the fast resolution and apologies for any noise.

That's great!

Not noise at all, you found a problem and we have a solution that should 
be added so others don't hit it.

I think Sasha and Greg just need to pick it up then.

