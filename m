Return-Path: <stable+bounces-235822-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GHaEM0Sj22kqEgkAu9opvQ
	(envelope-from <stable+bounces-235822-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:51:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 741033E40D1
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 15:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C101A3011C77
	for <lists+stable@lfdr.de>; Sun, 12 Apr 2026 13:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DAA2673B0;
	Sun, 12 Apr 2026 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHX78UPP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A35125A9;
	Sun, 12 Apr 2026 13:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776001742; cv=none; b=GJLKWO26dBHUE2luMjKiazjkVnTMk83DVMyetIkmxWhGspdk1IW/uKZ6AUhFVHiEAs/Hjj6LkJiv4Wh+++7ibO9jlND4HmeRh3WfZkd7ahUK6AYMYVAXlWZ1dhsRaD1ZFqrHGZqzlI/pPJpojj8Uy+YrWwerWfIlhXziN7AAg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776001742; c=relaxed/simple;
	bh=xRit3coA5ALjqymrXb9Jm+t1aohcwzdracpGa7ViDpo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bn3yyaBkiKp2c2WsxcIDweJ0pZ+JwRGDO98OdjvXVqHjwRDievBr3UBzc9F6Bf9EUVrTciYOFjIU8yTcY01fJC5CjHPMkzPG5fNL+plvs9Ovd4SZMc3FubwGcl+g5P29iBdkSFKf2wc6amsZtLpjRYjcFDWoGJM36O4om60fa+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHX78UPP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884BAC19424;
	Sun, 12 Apr 2026 13:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776001741;
	bh=xRit3coA5ALjqymrXb9Jm+t1aohcwzdracpGa7ViDpo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eHX78UPPYC/i5w0AO0mnUByU5g2ysz2YmpabquM/5ppN2V9E56Qgvj7Lcg6T9aVbC
	 uSBq28PYKBa4i+muvHMAunaMqlz7DBwxPVuXQEdapBwqKnIzgTWg53xj8yFMQIADkh
	 w96UWBZKuPkKF65t5MHym5ZWqVk+siKUaYpoL8QVta2JFl37W7GBh4VjTesaNz8CrQ
	 T3AhjeeyWbJnLJp6bR+wTRV8VlwgI67/Qn3IeJDDlpz9w/dhPAZLkTwSOsGH7jeQ2T
	 MD4r3fdxTJeO38gJ8yMOcdW8H4pYC3Lr4MOIbZd4uVKhM/6PvslZ2qg/S5HGClrtMG
	 5F0VL8EDEB8Jg==
Date: Sun, 12 Apr 2026 14:48:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Erim, Salih" <Salih.Erim@amd.com>
Cc: Christofer Jonason <christofer.jonason@guidelinegeo.com>, "Simek,
 Michal" <michal.simek@amd.com>, "O'Griofa, Conall"
 <conall.ogriofa@amd.com>, "lars@metafoo.de" <lars@metafoo.de>,
 "dlechner@baylibre.com" <dlechner@baylibre.com>, "nuno.sa@analog.com"
 <nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, Victor Jonsson
 <victor.jonsson@guidelinegeo.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
 <stable@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: xilinx-xadc: Fix sequencer mode in
 postdisable for dual mux
Message-ID: <20260412144852.3173a284@jic23-huawei>
In-Reply-To: <IA1PR12MB7736D5B150CA36406ED7384A9F5AA@IA1PR12MB7736.namprd12.prod.outlook.com>
References: <20260304090727.1800289-1-christofer.jonason@guidelinegeo.com>
	<20260307124118.1d527749@jic23-huawei>
	<1166aeef-0c93-408d-b265-9037f2840074@amd.com>
	<IA1PR12MB7736AE6EEE95D5D184A15B9F9F50A@IA1PR12MB7736.namprd12.prod.outlook.com>
	<GV3P280MB00657EB1524612E9BA0142DEF35AA@GV3P280MB0065.SWEP280.PROD.OUTLOOK.COM>
	<IA1PR12MB7736D5B150CA36406ED7384A9F5AA@IA1PR12MB7736.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-235822-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jic23@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 741033E40D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 7 Apr 2026 14:30:57 +0000
"Erim, Salih" <Salih.Erim@amd.com> wrote:

> Hi Christofer,
> 
> Thanks for the details. That confirms it.
> 
> Jonathan - this one is good to go from our side.
> 
> 
Applied to the fixes-togreg branch of iio.git
Very unlikely I'll do another pull request before rebasing that tree
on rc1 though, so it will be a few weeks.

> Thanks,
> Salih.
> 


