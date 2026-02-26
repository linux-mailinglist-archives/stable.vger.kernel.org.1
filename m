Return-Path: <stable+bounces-219773-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAKRMdD9n2n3fAQAu9opvQ
	(envelope-from <stable+bounces-219773-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:01:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 375D11A232F
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 09:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AF713099145
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 08:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744083921E8;
	Thu, 26 Feb 2026 08:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TY55YMad"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D2438F92B;
	Thu, 26 Feb 2026 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772092801; cv=none; b=JzbUd0waLhNQV7jKhzp2cYEDD1NJDGiWhATZsZMave2URfEvq0xD6Vqx/EWqSLFaZWp+0voPB3UhRyE+tvHKnV5pkDLAtYEKZflLCjKmIIIJ/YkCRf+Me1TJGUW6aG5XRjvnTF/E+kckgnmG8kmhlME8DePnkgC6i0NijA3qpjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772092801; c=relaxed/simple;
	bh=OxUA/HKHa6M8YsD678+VwxX0wvygG/XYGujEnxOR5kI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egA/C5f3vAcYAPb00/zxeDpAS7Dy83EF5UvY01MLUvyNsUqkbTH0OEePPEP4vgTnKYI17wQnuGbR7AV1U00zWvaojhXILofUhe9nzb32vV8RSf5BhKOfOXQF8hJSpTWAzD8RPut5FX7S+Nw1EXIN+Iwb1yO0u4ja6lc1vUsXWF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TY55YMad; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A6E7C19422;
	Thu, 26 Feb 2026 07:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772092800;
	bh=OxUA/HKHa6M8YsD678+VwxX0wvygG/XYGujEnxOR5kI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TY55YMaddycepVTow/cdH3CDljHX6p0U9otFd+fUlysIMTqhz+hWFZ3SC+W/HBiN1
	 9Dted4TS+xLrl528CtqvOekC2gLmbLkjB5dpAlvxABYunQXKG3vH2lniAmQ7IGq+We
	 a1YoPI+JGpJv4XEwmiCzSia3wlsPTuFtG93/dlXOoHe2QTUszTfYuVpNjK7na27D1M
	 JZ4VhfyhnPaZpfuMB1ykowx5EnC4dUJ/6nVqn4KErAJEo0rKGp8aWVrA/JOYKORnil
	 HUf1SjPWy0BlSWW9FihA2VmcYqjH316TUzKFwKcckO9Q3bqqatH3twVFtlHiJ6PgOm
	 IOxdLwCDk6GjQ==
Message-ID: <2925f3d4-ee22-4dea-958b-fbcab94f76a9@kernel.org>
Date: Thu, 26 Feb 2026 16:59:57 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 767/781] ata: libata-scsi: avoid Non-NCQ command
 starvation
To: Jiri Slaby <jirislaby@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Xingui Yang <yangxingui@huawei.com>,
 Igor Pylypiv <ipylypiv@google.com>, Niklas Cassel <cassel@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 John Garry <john.g.garry@oracle.com>
References: <20260225012359.695468795@linuxfoundation.org>
 <20260225012418.528826275@linuxfoundation.org>
 <4bbeb69d-698f-4fe7-86d0-67c6f7e2ebdf@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <4bbeb69d-698f-4fe7-86d0-67c6f7e2ebdf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219773-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 375D11A232F
X-Rspamd-Action: no action

On 2/26/26 16:45, Jiri Slaby wrote:
> On 25. 02. 26, 2:24, Greg Kroah-Hartman wrote:
>> 6.19-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Damien Le Moal <dlemoal@kernel.org>
>>
>> commit 0ea84089dbf62a92dc7889c79e6b18fc89260808 upstream.
> 
> Hi, this one is broken and needs (very fresh) fixes according to our 
> tooling:

This is not exactly clear to me what you are saying here. What is broken ? What
is your tooling saying ? Are the original patches broken ? Or are the backports
broken ?

Be a little more descriptive please.

> 
> eddb98ad9364 ata: libata-eh: correctly handle deferred qc timeouts
> 55db00992663 ata: libata-core: fix cancellation of a port deferred qc work
> 
> thanks,


-- 
Damien Le Moal
Western Digital Research

