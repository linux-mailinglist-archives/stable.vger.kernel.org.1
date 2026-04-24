Return-Path: <stable+bounces-240992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCYgF1WO62k+OQAAu9opvQ
	(envelope-from <stable+bounces-240992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:37:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C89D6460D73
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F00DD3020107
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA423D5244;
	Fri, 24 Apr 2026 15:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="OCnJ8hH2"
X-Original-To: stable@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B43C944A
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 15:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045066; cv=none; b=SLLEqQ2dgF8+c7YdCNH9sMaOMtUlahCPKUc8ISl7x4gRqO7kB4HhboxPsHaRWodTh7Y0N7YH+7uGcgFH390jKBCMZ02f5djf1Q39iwQgXxrHHzpGCKz2U7bMVzEt4wUWSvo6ZRzaiG6E8o7y+fi3mAcM0strD6NfWQb+QeMEW94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045066; c=relaxed/simple;
	bh=joTQCSisSejxx5EDr/8wY+lbu5NUvCu/58i9SlUJgeI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hH2X/os7KFuKsDX4ke1n1dUPPagPazzGrouwyCYzjIALbA70D2WSq0NsoDcVkyoPS46GgiX7ZdaC8JLn20MuNaxOB8HII6oWjCBcS/AYHrx9A5E4YOGkQVCLCh/Xq2EFhqm9NYgUMiZeDOBMM3IfvQNPI4weav1uWPcsRfJ5wrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=OCnJ8hH2; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 15D9F240028
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:37:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1777045056; bh=/+koihDAy0q08mblule0I/lAVVbNH3IkitxS0KiKHEE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=OCnJ8hH2Bqmja4Q5VAU/ET8Jl7NLoLn89RM1jQQU9gLBMGdQ/H9G4JG23Mt/S/khU
	 n2eZeouMFUel2brNvzNHrRbLDZBwxe6valRX1gFfHyfZ4b8RInc8aQuITEK609MKzH
	 WvQSkRG6qAdZjFXi5fhxv9bqtLNQVWnE1e35DAGnHk5JR4fsDG6B6dCNvh8HgMbKRW
	 a/s4i2wZIXMG9gArW5OmjC3pUXBWhGoqGJI3qWdoiDjrSbA3+MHnnD6q/m9Ej4gB+R
	 oMlgbfQCpmQ/mBzksy607xmR5+1atVvMGfDkvzXGco2vqoo66M3MEI2b+4NxegrVc5
	 kOcQ+1q8CBF9g==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4g2HCM0KR9z6tsf;
	Fri, 24 Apr 2026 17:37:35 +0200 (CEST)
Date: Fri, 24 Apr 2026 15:37:35 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] hwmon: (corsair-psu) Close HID device on probe errors
Message-ID: <20260424173734.4ab5765f@posteo.net>
In-Reply-To: <20260424135107.13720-1-mhun512@gmail.com>
References: <20260424135107.13720-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C89D6460D73
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[posteo.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[posteo.net:s=2017];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-240992-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[posteo.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilken.gottwalt@posteo.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, 24 Apr 2026 22:50:51 +0900
Myeonghun Pak <mhun512@gmail.com> wrote:

> corsairpsu_probe() opens the HID device before sending the device init
> and firmware-info commands. If either command fails, the error path jumps
> directly to fail_and_stop and skips hid_hw_close().
> 
> Use the existing fail_and_close label for those post-open failures so the
> open count and low-level close callback are balanced before hid_hw_stop().
> 
> Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>  drivers/hwmon/corsair-psu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/corsair-psu.c b/drivers/hwmon/corsair-psu.c
> index dddbd2463f..76f3e1da68 100644
> --- a/drivers/hwmon/corsair-psu.c
> +++ b/drivers/hwmon/corsair-psu.c
> @@ -796,13 +796,13 @@ static int corsairpsu_probe(struct hid_device *hdev, const struct
> hid_device_id ret = corsairpsu_init(priv);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "unable to initialize device (%d)\n", ret);
> -		goto fail_and_stop;
> +		goto fail_and_close;
>  	}
>  
>  	ret = corsairpsu_fwinfo(priv);
>  	if (ret < 0) {
>  		dev_err(&hdev->dev, "unable to query firmware (%d)\n", ret);
> -		goto fail_and_stop;
> +		goto fail_and_close;
>  	}
>  
>  	corsairpsu_get_criticals(priv);

I really had to go back to the initial commit to check, if I introduced that
issue later. But nope, I had it that way from the start. Good catch, I totally
missed that. Thank you.

greetings,
Wilken

Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>

