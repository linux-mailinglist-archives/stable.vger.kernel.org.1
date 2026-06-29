Return-Path: <stable+bounces-269763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XgnLOMl7Qmo08QkAu9opvQ
	(envelope-from <stable+bounces-269763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:06:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56FE36DBBA8
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 16:06:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="HnkWCUK/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269763-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269763-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC6D730F6F9D
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 13:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710662236FD;
	Mon, 29 Jun 2026 13:38:33 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E1320D4FF;
	Mon, 29 Jun 2026 13:38:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782740313; cv=none; b=o44E+lPQffQBz6pE1F/sxFRypqxolxzLz42/ix2DkM5L9rB2fqaHyCT3NuVGBvXSC251lKQX86RJFUv/HAUYrH6OQNhiRDez5PMjWn1/nWprY1H9I3W0V6UCZAhBSwt65fT5ARXPX5KrrHAAB5kNAJfpUzxqONodsp5b/w9B3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782740313; c=relaxed/simple;
	bh=mpTA/+VYC+HA6+PPcCutu0WbAvD4u+OnjtqhaSGNV3s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=CyJApcL2NgOBlgG5kfOaMOzyryTUaNaLh72hIwPC2bO4QZFnDeM94w1Qk0ee5b6Z0AciSOwZni1BBGXjvK49WDwXyNikIBGOglYyjSSmqoan6OKT4msNQGfSpTl9SXbip3V/XbOiImZKg5kgjbTevrWtsADNApUW6ZK5btDaQz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnkWCUK/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D57C1F000E9;
	Mon, 29 Jun 2026 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782740311;
	bh=Qq2Mf2EDmQCeExhAhcrHh/rJ+mTJks6sKOKIPqJwvSM=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=HnkWCUK/dKIRzXomT9pCP6n+H3Dsy9KnYuDLu9MkprSo7DuyqB3EVuIrq7QN+bJlL
	 mgN6edFRGHvaNh2q0Z4tqskCdI4TW1Zy1taK8Yzv38NGzaGj4W+sqsVNH/wM7R39Xv
	 QipaH83TZYxkUlKeLeoaFaj5VmZO6PaJfGmqUELut0S9BrW4HeW/tN6i/cozYyUiE1
	 oK8ULARX0hGGE8v5rsGOJ3N96NKoToIY48EFAXToeihLQFrD8UsaSTGvuIv8spnqRa
	 jRr6cnFLxsONoLrF53SeLnOxRyNNtCsn18B4aWKOKonxdWEwcQBQYkdwIqXjHslP6A
	 UpCpEaAvZ987w==
Message-ID: <3207beca-c18a-46f6-af1e-63f5b7e3b400@kernel.org>
Date: Mon, 29 Jun 2026 15:38:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans Verkuil <hverkuil+cisco@kernel.org>
Subject: Re: [PATCH 05/10] Input: synaptics-rmi4 - block s_input when F54
 queue is busy
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Bryam Vargas <hexlabsecurity@proton.me>, Hans Verkuil <hverkuil@kernel.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260626051802.4033172-1-dmitry.torokhov@gmail.com>
 <20260626051802.4033172-5-dmitry.torokhov@gmail.com>
Content-Language: en-US, nl
In-Reply-To: <20260626051802.4033172-5-dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dmitry.torokhov@gmail.com,m:hexlabsecurity@proton.me,m:hverkuil@kernel.org,m:linux-input@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hverkuil@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,proton.me,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-269763-lists,stable=lfdr.de,cisco];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hverkuil@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56FE36DBBA8

On 26/06/2026 07:17, Dmitry Torokhov wrote:
> Changing the input (diagnostic report type) mid-stream changes the
> report size. Since V4L2 buffers are allocated based on the size at
> stream start, changing the input while streaming could lead to a
> heap buffer overflow if the new size is larger than the allocated
> buffers.
> 
> Prevent this by blocking VIDIOC_S_INPUT with -EBUSY if the V4L2 queue
> is busy (streaming).
> 
> Fixes: 3a762dbd5347 ("[media] Input: synaptics-rmi4 - add support for F54 diagnostics")
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.5-flash
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Hans Verkuil <hverkuil+cisco@kernel.org>

Regards,

	Hans

> ---
>  drivers/input/rmi4/rmi_f54.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/rmi4/rmi_f54.c b/drivers/input/rmi4/rmi_f54.c
> index aebe74d2032c..e86dfc9ce7d9 100644
> --- a/drivers/input/rmi4/rmi_f54.c
> +++ b/drivers/input/rmi4/rmi_f54.c
> @@ -445,7 +445,12 @@ static int rmi_f54_set_input(struct f54_data *f54, unsigned int i)
>  
>  static int rmi_f54_vidioc_s_input(struct file *file, void *priv, unsigned int i)
>  {
> -	return rmi_f54_set_input(video_drvdata(file), i);
> +	struct f54_data *f54 = video_drvdata(file);
> +
> +	if (vb2_is_busy(&f54->queue))
> +		return -EBUSY;
> +
> +	return rmi_f54_set_input(f54, i);
>  }
>  
>  static int rmi_f54_vidioc_g_input(struct file *file, void *priv,


