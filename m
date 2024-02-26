Return-Path: <stable+bounces-23713-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C13986798F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 16:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B223C1F27020
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 15:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1A12CDB8;
	Mon, 26 Feb 2024 14:53:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87904128368;
	Mon, 26 Feb 2024 14:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708959193; cv=none; b=oGwnoqgJZvIDCbdQVUCTb2JdkOecYeWq3kRlBjD0MmgU/78Dv5IrLHmf+yuY8NSICkajfC6H7spnaKFNs6mmM8/DZTDzoAcm+c03aHoKU6D+oY7c2j3xuf7aWm/jGE+6/QPeUOmavipNVmnT+QZH+gMIl+R9V9WRCMISo3WLA/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708959193; c=relaxed/simple;
	bh=hZdW92wKtpC15HVD9lT89vdv8fzQoI5i2f/txb1VViM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T88YrWnT/0PUkP9221nIkUEgKwzWtMC4FSrzSpk5doj+DokAWLcwrPsGVlTx8L6wKMeVBq+4Bdl8KCKsI2eQekiojzb3uWvjm+IJ9lcqvhofuCmx8OWYrXY031n9vVnQc5aq8ryio+q7IAuG8fkorYvQ1m7oP8UewZj6FcY0J8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id BB40561E5FE01;
	Mon, 26 Feb 2024 15:52:45 +0100 (CET)
Message-ID: <ec827479-3561-4155-91c9-82c39a687c49@molgen.mpg.de>
Date: Mon, 26 Feb 2024 15:52:45 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: port: Don't try to peer unused USB ports based on
 location
Content-Language: en-US
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 stern@rowland.harvard.edu, stable@vger.kernel.org
References: <20240222233343.71856-1-mathias.nyman@linux.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240222233343.71856-1-mathias.nyman@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mathias,


Am 23.02.24 um 00:33 schrieb Mathias Nyman:
> Unused USB ports may have bogus location data in ACPI PLD tables.
> This causes port peering failures as these unused USB2 and USB3 ports
> location may match.
> 
> Due to these failures the driver prints a
> "usb: port power management may be unreliable" warning, and
> unnecessarily blocks port power off during runtime suspend.
> 
> This was debugged on a couple DELL systems where the unused ports
> all returned zeroes in their location data.
> Similar bugreports exist for other systems.
> 
> Don't try to peer or match ports that have connect type set to
> USB_PORT_NOT_USED.
> 
> Fixes: 3bfd659baec8 ("usb: find internal hub tier mismatch via acpi")
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218465
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218486
> Tested-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/linux-usb/5406d361-f5b7-4309-b0e6-8c94408f7d75@molgen.mpg.de
> Cc: stable@vger.kernel.org # v3.16+
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>

[…]

I was able to successfully test it on the Dell PowerEdge T440, and the 
warning is gone there too.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218490


Kind regards,

Paul

