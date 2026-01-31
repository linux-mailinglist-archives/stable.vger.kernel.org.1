Return-Path: <stable+bounces-212949-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4/MzC7AxfmmAWQIAu9opvQ
	(envelope-from <stable+bounces-212949-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:45:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F7CCC30FC
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 17:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02C053018C1C
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 16:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D1731A813;
	Sat, 31 Jan 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRv89Blx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A32DEA7A;
	Sat, 31 Jan 2026 16:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769877932; cv=none; b=rNTdHBIJBv2U75L8AqCQqAUjCVqZw765h8K4REmqueeY652W2+Lj20L3d1SCXHObnnbbfFf+rnebkcXRVO99NGnFZjqxQ7C8U4oqu9IaJs/IBQqPXxsDXNe7+NhiiI9CYONxs486L8rEcasM1YF9S9X2hZbGP2N7q7rQCHBuO7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769877932; c=relaxed/simple;
	bh=YRNNboMA42Rg8JXJNEe3s09TLdrWGIdAUFc72lUOX0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IkB8A5UHBX4eLYpupVZLAai4WZ5rKlv9u1db4hKrq9quVaCnftRRxyaAa3MB8zxdrnzdOeeVE0dChRm8X1+cMxbV7LNVwu33oKA7bIzqJ1bJrWrRYvACyF5KOJBRn/W3k8xYvViBnZ0615Kfdaj+1Q0FAPgL2Q3CloH5YprPUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRv89Blx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 791D2C4CEF1;
	Sat, 31 Jan 2026 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769877932;
	bh=YRNNboMA42Rg8JXJNEe3s09TLdrWGIdAUFc72lUOX0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FRv89Blxzku1tdaroBO1cASK5KDvnvnudJZ3CHfeI14xyEeSWjT3uOiBCwPAX5N4r
	 y7QddbAwuC8GTNrxFIekSbCXP7edHxUxlrrzsWfTBTe5IKMLYltF7J2+u+GVHKc8uE
	 e7I9LmhufIl5nW+ADAOki/49AdApE8+rTbt6mIVpWX/mn+X6xZCxtEBx/baj4Dimjv
	 +oZSA+ChGInokaCcp+W+MmmehQaMTiZuVsFRMysZIjzqF9T9Vbzdgm2Qz+yhXatpcV
	 5CbPoD9ZjcQVeSXLeKkbAHtVokN3ZO+RykrANDy9Iqyfj/2tt4lYyQMQrOLbsRMsz8
	 inSQEf2WaCxAg==
Date: Sat, 31 Jan 2026 16:45:23 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_icm42600: fix odr switch to the same
 value
Message-ID: <20260131164523.18a9ecb1@jic23-huawei>
In-Reply-To: <20260130-inv-icm42600-fix-odr-change-v1-1-347a03a57fa1@tdk.com>
References: <20260130-inv-icm42600-fix-odr-change-v1-1-347a03a57fa1@tdk.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-212949-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,jean-baptiste.maneyrol.tdk.com];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tdk.com:email]
X-Rspamd-Queue-Id: 8F7CCC30FC
X-Rspamd-Action: no action

On Fri, 30 Jan 2026 16:38:47 +0100
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> 
> ODR switch is done in 2 steps when FIFO is on : change the ODR register
> value and acknowledge change when reading the FIFO ODR change flag.
> When we are switching to the same odr value, we end up waiting for a
> FIFO ODR flag that is never happening.
> 
> Fix the issue by doing nothing and exiting properly when we are
> switching to the same ODR value.
> 
> Fixes: ec74ae9fd37c ("iio: imu: inv_icm42600: add accurate timestamping")
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Cc: stable@vger.kernel.org
Given we are very close to the merge window and I have the main pull request
set up already, I'm going to apply this to a local fixes branch that I'll
rebase and push out in a few weeks time.

So there should be nothing else to do here, but you won't see it in linux-next
for a little while.  Maybe if I get a bunch of fixes I'll do a second pull
request to Greg to line up for the merge window.

thanks,

Jonathan

