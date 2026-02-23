Return-Path: <stable+bounces-217811-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iIn+AxmVnGnRJQQAu9opvQ
	(envelope-from <stable+bounces-217811-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:57:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B48617B2DB
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 18:57:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 238FF3066E67
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 17:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC191339843;
	Mon, 23 Feb 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQrYR4MK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FE39334C18;
	Mon, 23 Feb 2026 17:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771869276; cv=none; b=GTCU5OK7eMyPFmf+JVwhJ4isuoxLOSSGj5PHhr4c8/sfr6CtbGCkMzJK/EJJczrhFcHm1xou7Py7PKl2uqWmu0oR5IxGMC2cZe/srhCOWNAbTiFbOamtQemxrbhrCELLnHB3sNvBGf6kxvL+W/DvmZmqXcTkRjT5s+o9deeLs/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771869276; c=relaxed/simple;
	bh=Rm4T/pDYcGvssUO5PpapbjLkzXwPnMG4gk1bwLlllng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK3CLk87EAkg/9xo0umhyjO7N6ENj7TusduF4uHvBfpve1XPe+Ml8uwsmPLU5klsN9qiIm1WoqfYoMjGzN6IFHkILZAK5WhL8EqIjPZpmpQFJyvni0b5kiTwvLNd+yekDhWrf+WUtY6kmxpVbPoQpP7FbPFqOixqRDMkzsZcx8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQrYR4MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F753C116D0;
	Mon, 23 Feb 2026 17:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771869276;
	bh=Rm4T/pDYcGvssUO5PpapbjLkzXwPnMG4gk1bwLlllng=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IQrYR4MKSExktTpskAQLWxJOS4B8nNB11kJGJZo91+H4Yi2sZpAdO4XO5YYKHEsgd
	 sVW0hmqjlTpeSW8KQWtINXlXdsBhcL80HBqNy/7rmogFfqKAC7P+TDTAah9omm4Z08
	 oqtEAAf0TuNcfiG1+pXkXxCovxGMQ7Daj3gx2iEhYC97s4uB5JdvE/jDWIpPtlaiH6
	 ogDnhvTzp4TrcGjkYNph3kn5H8fhBasMN+IV8Kl0MEapajOmvDHn81k8uvXfkL+Owr
	 NaUX5PoGyTFhsxz2zigsmIYVaBpvO4t/Grzjj/NnW1i2/ouPWUOIZHMPwJWXltoVtS
	 AgyleooLfS64w==
Date: Mon, 23 Feb 2026 12:54:34 -0500
From: Sasha Levin <sashal@kernel.org>
To: "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Patch "ACPI: button: Convert the driver to a platform one" has
 been added to the 6.18-stable tree
Message-ID: <aZyUWn-r-jNy-4Gm@laps>
References: <20260222233852.1322850-1-sashal@kernel.org>
 <50c2aed5-2ca6-4a64-97c4-ab87c23ea863@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <50c2aed5-2ca6-4a64-97c4-ab87c23ea863@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217811-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B48617B2DB
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 05:58:56PM +0100, Wysocki, Rafael J wrote:
>On 2/23/2026 12:38 AM, Sasha Levin wrote:
>>This is a note to let you know that I've just added the patch titled
>>
>>     ACPI: button: Convert the driver to a platform one
>>
>>to the 6.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      acpi-button-convert-the-driver-to-a-platform-one.patch
>>and it can be found in the queue-6.18 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>>
>Is a driver conversion really "stable" material?  I wouldn't think so.
>
>Same for the "Adjust event notification routine" patch.

It's not :) They were brought for:

>>     Stable-dep-of: e91f8c5305b9 ("ACPI: button: Call device_init_wakeup() earlier during probe")

>Please drop those.

I'll drop those two, but I'll also need to drop e91f8c5305b9.

-- 
Thanks,
Sasha

