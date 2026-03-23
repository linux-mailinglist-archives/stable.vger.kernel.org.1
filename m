Return-Path: <stable+bounces-227891-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nV9xCfTkwGliOQQAu9opvQ
	(envelope-from <stable+bounces-227891-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:00:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F1F2ED344
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4E5993009987
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15E5335C18C;
	Mon, 23 Mar 2026 07:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h5ptl03S"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B7740DFB7;
	Mon, 23 Mar 2026 06:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249200; cv=none; b=VRf71BjkFYxt4dIXP4n1BmTfnGIeQmOnvTc5BIhBzH0m3tCmdA5zfMzaqFwF5tnsALXx8LzCffx91V6w8aa19cLVBOdivseEQb4h+IlGDaxa3Y6YssKX63iewMi8DV6kIZwO7l0O8P2h6agHPQK/OGXKYCkxny5pVqDjSYqeUc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249200; c=relaxed/simple;
	bh=Lcj/Gee0UpM9Xk/jVZA5FS4QcAKvheLDzjGabhxrzXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8aN+MPKiR/C5NFzLYgDbahY3VzHx04/JgjIVO2JuCHGVSb6eW9mqMxQE22PNUJUzCQpgMpZyssYaiBDgAZ1IetgPM8PjrMF99msvf/MMOsrVVVm3IM74EmmGgzEfgSZ2GCbPbJjrQp61Q3YEaZwwj7Wrgkyy5ObNKB+iOfS6tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h5ptl03S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.94.160.76] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF36820B710C;
	Sun, 22 Mar 2026 23:59:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF36820B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774249199;
	bh=DgKL1yb46UK0y3VEQ8WvvfyLRsyFgHC2JnO+Y9Nmqbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=h5ptl03S5oBYYxMddh95ko2tIiGbYYe+byOoKy9xY4lUzmSFmy0aoq/9C44ywpwp6
	 qxryqwwLaAsRszxEhpp79/0MtYc+M3Pfxs8PbPqmf3hPZmyBgzxFkNknJpoepOYTZD
	 qm8xNNhJMvO6yDE90RfcAmNXt7E7SXMxZFcBZqck=
Message-ID: <bedba89b-f2a0-4f5a-afbf-486b30ed9e25@linux.microsoft.com>
Date: Mon, 23 Mar 2026 12:29:55 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] EDAC/versalnet: Fix device name memory leak
To: Borislav Petkov <bp@alien8.de>
Cc: shubhrajyoti.datta@amd.com, tony.luck@intel.com,
 linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260322131107.1684647-1-ptsm@linux.microsoft.com>
 <20260322131149.1684771-1-ptsm@linux.microsoft.com>
 <20260322161506.GBacAViv5G6Ul-0WUX@fat_crate.local>
Content-Language: en-US
From: Prasanna Kumar T S M <ptsm@linux.microsoft.com>
In-Reply-To: <20260322161506.GBacAViv5G6Ul-0WUX@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227891-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ptsm@linux.microsoft.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 86F1F2ED344
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 22-03-2026 21:45, Borislav Petkov wrote:
> On Sun, Mar 22, 2026 at 06:11:49AM -0700, Prasanna Kumar T S M wrote:
>> The device name allocated via kzalloc() in init_one_mc() is assigned to
>> dev->init_name but never freed on the normal removal path.
>> device_register() copies init_name and then sets dev->init_name to NULL,
>> so the name pointer becomes unreachable from the device. Thus leaking
>> memory.
>>
>> Track the name pointer in mc_priv and free it in remove_one_mc().
> 
> No, get rid of the name allocation and allocate a char name[MC_NAME_LEN] on the
> stack in init_one_mc() which you pass into device_register(), it copies it and
> we forget about it.

Sure, I will do this in v2.

> Thx.
> 


