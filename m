Return-Path: <stable+bounces-212798-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFUBI92Te2nOGAIAu9opvQ
	(envelope-from <stable+bounces-212798-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:07:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A991B2A42
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 18:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62B56303A25B
	for <lists+stable@lfdr.de>; Thu, 29 Jan 2026 17:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7C33469F6;
	Thu, 29 Jan 2026 17:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="zJJW5Htw"
X-Original-To: stable@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A6B25C809;
	Thu, 29 Jan 2026 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769706285; cv=none; b=PHe6zfAfi9/tsEGbwUHfCh6qn+3U+Sa9tmMLL1uFCREY09oyekrQJ4Zvjo8tU8mDFt6H8IJpnFanmFGi4m+3TYky3/k42w9LN3JeCK15dXuyqncGu7Qq8H4LtlMcQ5p69fBHBVXMFuVEaqNUBjcUGXUv0ztAVYwfN7+4pYn6lXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769706285; c=relaxed/simple;
	bh=boCPdpXYfD8PuSLj09gk7+Jv66FTxmWiUC02IUa4mFw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5wqDjG9u/PdIZJvvZr18ahYWfitFgsZo+X731iDl0kB9hDqbsAU/xRhHFcJBKFBLDLRYx6DNrn/XaJz8kIgbBnlR+GNHjjvZJIkcH7jRcaNflL/EcH5xKHVxodqBG0FvGeBLVvmpYFA7wxARbLwW6TIw2DQEyWxLhJ2RHWA7BQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=zJJW5Htw; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f259672Qbz1XMFjh;
	Thu, 29 Jan 2026 17:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769706280; x=1772298281; bh=Ty9IjOGh7/WAsF8C/6LQywzE
	GewJekM7qjkPanmf2lA=; b=zJJW5HtwS1bY/jmG6pjreZ8NuzaObClcf5rVLMGw
	m+ghQ/4muF0DmG7TtiwyE1LwXWMjRCTP0wAY7SPytVbXeFxaNdhA04/hMEW0eZwW
	WNjc3ABZkiKEKsDfnQ8pabeEzXz7i+1dhESn6Fa/JmtPn275nFKCKW2kwJ8HbCAs
	0zUR+ZRiFCwid3Th71o+3b4dWqISCmyDKI9wqYZ7gIlBcSkWB3guSaNThYcDkTsE
	vyYg2vdkjhcDw1PwPrXJEFlnyDJCiv+ghzFB4QtN52znitJmHfeLbuleWvxAIeGa
	I5MLLxMdSdjS1ksFqL9aI/hxEVNy4IszM/50W5DhSMqUeA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 4Ypt1cFNEEWt; Thu, 29 Jan 2026 17:04:40 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f25912MN0z1XMFjf;
	Thu, 29 Jan 2026 17:04:37 +0000 (UTC)
Message-ID: <491d53b9-a110-431b-9a5e-3b46d833fdbb@acm.org>
Date: Thu, 29 Jan 2026 09:04:36 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] scsi: ufs: core: Flush exception handling work
 when RPM level is zero
To: Thomas Yen <thomasyen@google.com>
Cc: Stable Tree <stable@vger.kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Avri Altman <avri.altman@wdc.com>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Peter Wang <peter.wang@mediatek.com>, Bean Huo <beanhuo@micron.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
 "open list:UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER"
 <linux-scsi@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
References: <20260129070657.678532-1-thomasyen@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20260129070657.678532-1-thomasyen@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-212798-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12]
X-Rspamd-Queue-Id: 2A991B2A42
X-Rspamd-Action: no action

On 1/28/26 11:06 PM, Thomas Yen wrote:
> Ensure that the exception event handling work is explicitly flushed
> during suspend when the runtime power management level is set to
> UFS_PM_LVL_0.
> 
> When the RPM level is zero, the device power mode and link state both
> remain active. Previously, the UFS core driver bypassed flushing
> exception event handling jobs in this configuration. This created a race
> condition where the driver could attempt to access the host controller
> to handle an exception after the system had already entered a deep
> power-down state, resulting in a system crash.
> 
> Explicitly flush this work and disable auto BKOPs before the suspend
> callback proceeds. This guarantees that pending exception tasks complete
> and prevents illegal hardware access during the power-down sequence.
> 
> Signed-off-by: Thomas Yen <thomasyen@google.com>
> Cc: Stable Tree <stable@vger.kernel.org>
For future patch submissions, please place the Cc: tag above the
Signed-off-by tag. I think that is a widely used convention in the Linux
kernel community. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>


