Return-Path: <stable+bounces-227530-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGKyNc8yvWmI7QIAu9opvQ
	(envelope-from <stable+bounces-227530-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:43:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5557D2D9BEA
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 12:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF6D3081BFD
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 11:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17953A8743;
	Fri, 20 Mar 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7L0HXo/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F72D3A872B;
	Fri, 20 Mar 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774006963; cv=none; b=seGagg3ju51smDvl04OpDN2+EyI4hWTYeWtXpj9J5ipdVy1yjlv+wWCMtjPy/Gj9gjb7oU7LjXi5Om32sJHVzlFS+AZbp/rQdHBvppat7B2mSMfcU7k/+Wuws/QGxpditbhMRELG0zhzNBAGM8mAUViWoh/nWSClISdBwpOrdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774006963; c=relaxed/simple;
	bh=pfwqquKiEo0VbHgcnAXDufnCzaL/367Uwzu8J+/cRw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X3UZxEsuLj8YsabQLziIZsIp5ek+gS/XbHkzsD72wL8Tgp32AGfe1Oygwi1fKWHL0uzAOVEI6kWYQAzLOBY1jdBsB7cHbJV8JJZ5eHAxC27j/5AX6uA1XD300VFI2pRvi/ZxEp5otxtQLRYMdFvmsbCh+q5RDLVbarQD7HrxqbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7L0HXo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91733C2BC9E;
	Fri, 20 Mar 2026 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774006963;
	bh=pfwqquKiEo0VbHgcnAXDufnCzaL/367Uwzu8J+/cRw4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d7L0HXo/6CRGpjqYQqOmyW286cvgUiff4bXe3v06LLQQ7mXUaz2097pPKyfQQfbMG
	 KFx8rLGJcGYqTjcWVMGqMjaNbTHQ/o79tpjR7R7A0XX6rLSfqe5jatiu/Jpfjd1CMt
	 FxIDBig/3C2WI0GHkhloBS1P0i9X1WRqJLQoEzHQwFtWm0t7VvLbZcS+p4lPJD8oZS
	 Gd8WUIa01+Yhm74/Zs5L1oPNpwl+e38GkZ/1JVk3DRzMhP1BqIHBSAWc2A3LrfQsCZ
	 NDM9RMzmno2UBG3DqoTEZHnHVZgb5jj8xPlpyhrXCcNy1rcOZy+JkNwNe9U1t3dGZz
	 g7wz8n8dIe3pg==
Message-ID: <1ce6b64b-47e7-4e73-a73f-58bf5f5202b1@kernel.org>
Date: Fri, 20 Mar 2026 06:42:41 -0500
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <1be114e1130ca59ee91fc5a73aaf43a912d408ea@qpok.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-227530-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 5557D2D9BEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/26 4:28 AM, Mark Somerville wrote:
> Hello maintainers!
> 
> I run Debian 13 stable (6.12 kernel) and have encountered a regression.
> 
> My machine has three GPUs, the iGPU that is part of my 7950X and two dGPUs - one NVIDIA 3090 and one AMD RX 6400. I use the iGPU for the host and only use the two dGPUs with virtual machines via VFIO with libvirt.
> 
> Although I have specified kernel parameters vfio_pci.ids for the GPUs, I have not blacklisted the amdgpu driver so that the host iGPU can operate.  Previously, starting a VM with the RX 6400 dGPU assigned to it (via VFIO) would work fine. However, doing this with more recent stable kernels causes the machine to hang immediately (and then, ultimately, reset after a while - ~30s). No errors are logged, at least as things are configured just now.
> 
> I can reliably reproduce this crash and a bisection revealed the commit that introducted the problem: 8140ac7c55e75093a01c6110a2c4025fe7177c57.
> 
> This is fixed in the mainline kernel, I have tested and verified my RX 6400 is working with VFIO under 7.0-rc4.
> 
> I *think* this is still present in the 6.12.y branch but a second (currently ongoing) regression is preventing me checking this on the latest and greatest 6.12 release right now.
> 
> Working:   6.12.63
> Regressed: 6.12.69
> Working:   7.0-rc4
> 
> #regzbot introduced: 8140ac7c55e75093a01c6110a2c4025fe7177c57

If you bisected to 8140ac7c55e75093a01c6110a2c4025fe7177c57, try adding 
f7afda7fcd169a9168695247d07ad94cf7b9798f.

