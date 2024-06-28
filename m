Return-Path: <stable+bounces-56033-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 08ED591B594
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 05:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADBA51F225A1
	for <lists+stable@lfdr.de>; Fri, 28 Jun 2024 03:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3DB1F951;
	Fri, 28 Jun 2024 03:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="shdHHfxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA3836AFE;
	Fri, 28 Jun 2024 03:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719546525; cv=none; b=W7Z9APsJHTvSrjMEEMlH0z4C6HmsqMXg7Omfut/bkiZq3vZWuTVUPofYfwwV4x91FtpFLxNUQCbZeAJdkCBsLHt8WfSUomPA/BkHK8t7l/VAYxpzTWmcktG7txhsf6X56De4kCQjdxnJAfwVNSjD1P7vHGHHe8Yu2C5ZJW9boKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719546525; c=relaxed/simple;
	bh=miZ+emwkg1RNLjiDVvPKsQyljnBI+eqFccb7s8arH8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hbUQXNvqIR1BTgbJrADY7flmXHWjlC4U/qWGOEC212SkcAJX78XGg163Zs7+pG/FeqMGZEZkb4HOSFT+dN3lmtEjGXsgHZ5WAJuphVw5ZZmrSVvHo/WYAKPrS4YPNzXzC0dV99X/rbTR35TayD56gpG7QL6KprqFqJVpRweP/L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=shdHHfxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA32AC2BBFC;
	Fri, 28 Jun 2024 03:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719546524;
	bh=miZ+emwkg1RNLjiDVvPKsQyljnBI+eqFccb7s8arH8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=shdHHfxZkqUafXehPtkdL4tbunl8j/oyYzmdwTU2lzHhuvDT11fEPEbu92LREbSFR
	 U6wCIUCe55OJnTdKqE/QIq+kmsxb6nU401hQAWPi9o8Sqo24SR+Uacxzy1zOK+5qjR
	 skVnoMgot8yOX+IAPnmr9bIPCmLBOIqRoM46fZ66uOWGdAQnnxVk8/tGYuW3tSo5T0
	 eh1s1dc3esVUjyr5kKwYOLsvYHYPnYy2/d8sd679/PuHgybNWR4cH8DXEQ4hrwCqiM
	 jGgPJffcoh2j5kDX1LgEp/irLAxVhN6epEVv6TyEBQzUY5tDIkOBoq94TSBPxF08bJ
	 XI81hc1xivdqw==
Message-ID: <97d8fdb9-7477-4eef-a570-10a229eb48be@kernel.org>
Date: Fri, 28 Jun 2024 12:48:42 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] ata: libata-scsi: Do not overwrite valid sense
 data when CK_COND=1
To: Igor Pylypiv <ipylypiv@google.com>
Cc: Niklas Cassel <cassel@kernel.org>, Tejun Heo <tj@kernel.org>,
 Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240626230411.3471543-1-ipylypiv@google.com>
 <20240626230411.3471543-3-ipylypiv@google.com>
 <785a0460-36d5-4e4a-99ea-114081c55bc7@kernel.org>
 <Zn3R3R_xJFvyNJU-@google.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <Zn3R3R_xJFvyNJU-@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/28/24 5:55 AM, Igor Pylypiv wrote:
> On Thu, Jun 27, 2024 at 09:16:09AM +0900, Damien Le Moal wrote:
>> On 6/27/24 08:04, Igor Pylypiv wrote:
>>> Current ata_gen_passthru_sense() code performs two actions:
>>> 1. Generates sense data based on the ATA 'status' and ATA 'error' fields.
>>> 2. Populates "ATA Status Return sense data descriptor" / "Fixed format
>>>    sense data" with ATA taskfile fields.
>>>
>>> The problem is that #1 generates sense data even when a valid sense data
>>> is already present (ATA_QCFLAG_SENSE_VALID is set). Factoring out #2 into
>>> a separate function allows us to generate sense data only when there is
>>> no valid sense data (ATA_QCFLAG_SENSE_VALID is not set).
>>>
>>> As a bonus, we can now delete a FIXME comment in atapi_qc_complete()
>>> which states that we don't want to translate taskfile registers into
>>> sense descriptors for ATAPI.
>>>
>>> Cc: stable@vger.kernel.org
>>> Reviewed-by: Hannes Reinecke <hare@suse.de>
>>> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
>>> Signed-off-by: Igor Pylypiv <ipylypiv@google.com>
>>
>> I wonder if we can find the patch that introduced the bug in the first place so
>> that we can add a Fixes tag. I have not checked. This may have been wrong since
>> a long time ago...
> 
> This code was first introduced in 2005 in commit b095518ef51c3 ("[libata]
> ATA passthru (arbitrary ATA command execution)").
> 
> ATA_QCFLAG_SENSE_VALID was introduced a year later in commit 9ec957f2002b
> ("[PATCH] libata-eh-fw: add flags and operations for new EH").
> 
> IIUC, ATA_QCFLAG_SENSE_VALID has not been set for ATA drives until 2016
> when the support for fetching the sense data was added in 5b01e4b9efa0
> ("libata: Implement NCQ autosense") and commit e87fd28cf9a2d ("libata:
> Implement support for sense data reporting").
> 
> To me none of the commits looks like a good candidate for the Fixes tag.
> What are your thoughts on this?

Then let's just mark which LTS version need the patch.
E.g. Cc: stable@vger.kernel.org # X.Y +


-- 
Damien Le Moal
Western Digital Research


