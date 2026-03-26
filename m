Return-Path: <stable+bounces-230400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKJLOd2CxGnszwQAu9opvQ
	(envelope-from <stable+bounces-230400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:50:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92F1432DB47
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 01:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 221A2302020A
	for <lists+stable@lfdr.de>; Thu, 26 Mar 2026 00:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DCA61F2380;
	Thu, 26 Mar 2026 00:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7I5kjO4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E18A1ACEDE;
	Thu, 26 Mar 2026 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774486234; cv=none; b=Xz+BBIPPb079UxNR8pgVe9dduEfTJxk/Up7lTa7b6JdxWqpjOj3V/1Sy3QPImVi8wMVnwj0oFFOwG0usoTJ7DW4NHJV3LM1qzrjIIjpYRPFSeeV/iPdbsrHpAksQvF88OFbJyejrToGouRP0jL3esnPuVMOCOs6pDCv/z07QuDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774486234; c=relaxed/simple;
	bh=Ht8ZWVhXe/g5CJUAlXKokY0KJFyDOB6pwC2sG/WX5Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mW6yrbGvBrFJ0KcB9B4kQSvLEokOrrq9UvZolumeaUhZ3O1SWkqxUycyv802kO2G5wNp3YHJQUZGnN8Sic8F4g9uW9nUQVNmtNnOhkNUG9Tb5ffqoSmkrUWd/pdeZdYlFmBVH1MzNT1eKFrhNPGNQuILq+MNPJgXeInDndWIsGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7I5kjO4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A7E4C4CEF7;
	Thu, 26 Mar 2026 00:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774486233;
	bh=Ht8ZWVhXe/g5CJUAlXKokY0KJFyDOB6pwC2sG/WX5Q0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m7I5kjO4g6s5WNGJwwJRmj49T0+KK1lJaI6pwa4yZp6gh0/AElNfxLRlj4YK2j4NS
	 zM6PNVcCKUYoVRtCn8wQGHOWgPtOY+8Q2NXDpKV/tQOayzWY7JwcZnvgN6QgnypdNv
	 x80pilzlIAbDkjKyElKIqHV4msPHiXYL6Ieds2R2uLXqXMR1j3w5oj+0i5bBOo4cnE
	 i7DmsPM3dngOV2yCL+wqKKSQByp0iof+pXdE+8gzw3ovMRFWhyhL5hnjhvJ31XhY86
	 R9jDX3YFRlAWKP8GaIwRxa97UsyUEbmL41FAmSfBAecLHzMUtbf8Tj/H/twsp1dGKY
	 oMYXHB8ER1JAw==
Message-ID: <858663e3-def5-4cb3-b259-0ba52d830088@kernel.org>
Date: Wed, 25 Mar 2026 17:50:27 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] xfs: start gc on zonegc_low_space attribute updates
To: Hans Holmberg <hans.holmberg@wdc.com>, Carlos Maiolino <cem@kernel.org>
Cc: Dave Chinner <david@fromorbit.com>, "Darrick J . Wong"
 <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-xfs@vger.kernel.org, stable@vger.kernel.org
References: <20260325124312.26349-1-hans.holmberg@wdc.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260325124312.26349-1-hans.holmberg@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230400-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dlemoal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 92F1432DB47
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026/03/25 5:43, Hans Holmberg wrote:
> Start gc if the agressiveness of zone garbage collection is changed
> by the user (if the file system is not read only).
> 
> Without this change, the new setting will not be taken into account
> until the gc thread is woken up by e.g. a write.
> 
> Cc: <stable@vger.kernel.org> # v6.15
> Fixes: 845abeb1f06a8a ("xfs: add tunable threshold parameter for triggering zone GC")
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research

