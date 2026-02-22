Return-Path: <stable+bounces-217668-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONoEJc4Qm2lArgMAu9opvQ
	(envelope-from <stable+bounces-217668-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 15:21:02 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E848D16F53E
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 15:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8A53300FEF9
	for <lists+stable@lfdr.de>; Sun, 22 Feb 2026 14:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B1625DB0D;
	Sun, 22 Feb 2026 14:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4C964Ig"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98A226ACC;
	Sun, 22 Feb 2026 14:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771770059; cv=none; b=lPvH9C2ch6oqJSprTJhdhgdM3Q1t/aR+XKPHRHEGKHCaGLjSBcWuZk8v1vZK8WBRvv8VDgpFtAfKuYpN15WqA+BZkCvaWaWlwdBBUdTfjpDz4oC+MsIcBPU4lH226Inhyb6AxxDTWQ6l7sPwFaMOCLnqfNCly1bDgQTUwFxOfVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771770059; c=relaxed/simple;
	bh=3oTU+XEbaPXGy+j3xY8EfbQ6eZw/pXPEm8jMR5L66+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TIA35LzzQok3oz7ycjJDaV5RGPYWeyoJvO6xsRwDEOESAUJ/lHzZrX1/1qOxf0hShy3Eicevki0wwj98tg0qWLCR783T9+Mm+8Iy+vdeRiyrx++VRIeedBJ7GljJMA0GB3uyjWi+RlZz3xoPAZMUUTjDa09fNO4lmXHXRGlg+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4C964Ig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38737C116D0;
	Sun, 22 Feb 2026 14:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771770059;
	bh=3oTU+XEbaPXGy+j3xY8EfbQ6eZw/pXPEm8jMR5L66+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U4C964Ig34olcXMVTqx2c572dZJOi7t8P9JwEXTpPKAw06p6dFsOhCZ17VYThiIVs
	 QGHoFyOj/Y87/PCiADNE7EkGy/iSTs+WJlOrmcE7zN11/eFt0Iku7iLQH1m5qUDhLj
	 XckhPQqLOSF4tgqzvVfe+Ots+aWCZDeq0H2HdDBv40e6x3txnqfrQslrEltgcpbDqa
	 WPBhkKWzj76c3DkY2VIqbR8AIzDYMqTlBFc6oNSKpwTlVHxK9LQhHAOILP72hAw/XX
	 vnPbbGVfyttk7LvNMbKx3szyjaj4BSI82OWxl2q3e2yEx1MqKnLfDYtpDZ3z3JFjLA
	 XLZkD/hsgvNJA==
Date: Sun, 22 Feb 2026 09:20:57 -0500
From: Sasha Levin <sashal@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Simona Vetter <simona@ffwll.ch>, tzimmermann@suse.de
Subject: Re: Patch "fbcon: Rename struct fbcon_ops to struct fbcon_par" has
 been added to the 6.18-stable tree
Message-ID: <aZsQyanxUc7MEPYr@laps>
References: <20260221162238.4086398-1-sashal@kernel.org>
 <610d6de1-e5ec-40a3-b1b9-bad3bc76ed12@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <610d6de1-e5ec-40a3-b1b9-bad3bc76ed12@gmx.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217668-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E848D16F53E
X-Rspamd-Action: no action

On Sat, Feb 21, 2026 at 06:26:07PM +0100, Helge Deller wrote:
>Hi Sasha,
>
>On 2/21/26 17:22, Sasha Levin wrote:
>>This is a note to let you know that I've just added the patch titled
>>
>>     fbcon: Rename struct fbcon_ops to struct fbcon_par
>>
>>to the 6.18-stable tree which can be found at:
>>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>>
>>The filename of the patch is:
>>      fbcon-rename-struct-fbcon_ops-to-struct-fbcon_par.patch
>>and it can be found in the queue-6.18 subdirectory.
>>
>>If you, or anyone else, feels it should not be added to the stable tree,
>>please let <stable@vger.kernel.org> know about it.
>I don't think we should backport any of the "fbcon:" patches...

Sure, I'll drop those.

-- 
Thanks,
Sasha

