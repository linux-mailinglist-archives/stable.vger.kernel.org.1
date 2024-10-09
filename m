Return-Path: <stable+bounces-83180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 071B7996784
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BD68B22CEE
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 10:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEB618F2FF;
	Wed,  9 Oct 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNus6zy1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CD217E003;
	Wed,  9 Oct 2024 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728470673; cv=none; b=jSeuWxo/AQxztrm1Pkc3UiAH5k7oDJZFXuiEvS4WLKShou19J8pLXsT49x+/N0DIz3tJd4fJryxEdEA9nV0Eg+be7m9stsD2STdOevUGlGbSmXedmLVKJ/zhPFqwdfxx29pwLtN0kyZH+ABFRk5RHC0lFM6TKLLw0Rp+fxBEy5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728470673; c=relaxed/simple;
	bh=fSCO3rIX7xGxdlryS43Gp5Vpac4eFy0z6a6csZoY4w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VOYvAqRol9QIsImXZJQNEWlh3dwrEb5fof0zFu+PneA2QK4eKPlZAgsnfM+MNvK21QUQDylP7y4MvpZ+sR6EXFMfLR04BkNv+stUWxVmGX4pt3m51WtFCvzVcjJHBXrT3wizUoRaMNtLioROaXZKLxrz0jXgbRI+ZljfS0KOegk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNus6zy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 588D8C4CECC;
	Wed,  9 Oct 2024 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728470673;
	bh=fSCO3rIX7xGxdlryS43Gp5Vpac4eFy0z6a6csZoY4w4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kNus6zy1/6zNmZGIPpJHl7dSYQxfNlSwoLYnk/x/Z5cMkbcaE6wLcENdlepp7wGxh
	 LDTIgR2e4c/DWyuYF5YkHllWG141mKBzTfkwOpYFOP+elxKa8/Rt84zoYcmaCW7muG
	 fOQyb9z74MoU+JmqGzPBvzL86mMDVjE4Ygtla+Jlze2r0cSPrx4zvUsT9RKKDai0Yz
	 tnqC9Sz4UruASyiiCiNAF+KDRf8y3aWMLx1NthN1FvhvG8oH7H3xFDAiMauWtklbl+
	 bk9yU3hvokb5A9WA57YipexwMoH1Mir/X+XpIMHbKw2xYXznKnSFvh8Jtui7VEhCx8
	 AIMaJdlhzxaJg==
Message-ID: <5bd13541-4ac0-4171-b4e5-0dedaa9e88b5@kernel.org>
Date: Wed, 9 Oct 2024 19:44:31 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ata: libata: avoid superfluous disk spin down + spin
 up during hibernation
To: Niklas Cassel <cassel@kernel.org>, Hannes Reinecke <hare@suse.de>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: W <linuxcdeveloper@gmail.com>, stable@vger.kernel.org,
 linux-ide@vger.kernel.org
References: <20241008135843.1266244-2-cassel@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241008135843.1266244-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/8/24 22:58, Niklas Cassel wrote:
> A user reported that commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi
> device manage_system_start_stop") introduced a spin down + immediate spin
> up of the disk both when entering and when resuming from hibernation.
> This behavior was not there before, and causes an increased latency both
> when when entering and when resuming from hibernation.

One too many "when".

> 
> Hibernation is done by three consecutive PM events, in the following order:
> 1) PM_EVENT_FREEZE
> 2) PM_EVENT_THAW
> 3) PM_EVENT_HIBERNATE
> 
> Commit aa3998dbeb3a ("ata: libata-scsi: Disable scsi device
> manage_system_start_stop") modified ata_eh_handle_port_suspend() to call
> ata_dev_power_set_standby() (which spins down the disk), for both event
> PM_EVENT_FREEZE and event PM_EVENT_HIBERNATE.
> 
> Documentation/driver-api/pm/devices.rst, section "Entering Hibernation",
> explicitly mentions that PM_EVENT_FREEZE does not have to be put the device
> in a low-power state, and actually recommends not doing so. Thus, let's not
> spin down the disk on PM_EVENT_FREEZE. (The disk will instead be spun down
> during the subsequent PM_EVENT_HIBERNATE event.)
> 
> This way, PM_EVENT_FREEZE will behave as it did before commit aa3998dbeb3a
> ("ata: libata-scsi: Disable scsi device manage_system_start_stop"), while
> PM_EVENT_HIBERNATE will continue to spin down the disk.
> 
> This will avoid the superfluous spin down + spin up when entering and
> resuming from hibernation, while still making sure that the disk is spun
> down before actually entering hibernation.
> 
> Cc: stable@vger.kernel.org # v6.6+
> Fixes: aa3998dbeb3a ("ata: libata-scsi: Disable scsi device manage_system_start_stop")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

With the above nit fixed,

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

