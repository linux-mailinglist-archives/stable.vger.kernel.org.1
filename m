Return-Path: <stable+bounces-227824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Ok5BJf2zv2kb7wMAu9opvQ
	(envelope-from <stable+bounces-227824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 10:18:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D38CB2E8B32
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 10:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E9B5300F9CD
	for <lists+stable@lfdr.de>; Sun, 22 Mar 2026 09:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D3A2D77F7;
	Sun, 22 Mar 2026 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cW4/ckiX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4WG+Ux8M"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4C11D7E41
	for <stable@vger.kernel.org>; Sun, 22 Mar 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774171128; cv=none; b=aAWRG4gEJImcH7obXEb3m/OLGmDt4rXThA+HnVFqveHhUPJPF4p69O1GlccZSm70mA+GgCRKyxOfmAdwF5ApKugsMXuUEZiKqTW1m7CSPNGRsI77W6izpossfAQqRDlPnj4xoa8ADPpOwgu1gKEIgoo8L1S23VTgA7t4DMAPnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774171128; c=relaxed/simple;
	bh=DoRJ6IZNknFJUlmqDY1ByglGu/uMlEGw73d/nYzf+pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5VoT/HSOXDAjJR10nyrMy2Fd8S8fLjHtBI1KMt3MvaV7tFJbDs5Wcy9vXUP5GgRM4aN069j3nyKfiRVeUWjEdY81eW51ma6oanL3iUF2oJOSpwQFg3fnsQKbQdIQrJpfX4yiPpP995QIizh4QCJOo6JBNGLkcXhOyNWWjBUm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cW4/ckiX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4WG+Ux8M; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6FEBB140021B;
	Sun, 22 Mar 2026 05:18:45 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sun, 22 Mar 2026 05:18:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774171125; x=1774257525; bh=YL7tMpEnwf
	+TLfWo6RsWwqUaD/xfeKjDCvzRXvkkBt0=; b=cW4/ckiXH5yF7HSyY7GF9Rr/tk
	PmWcsdt4L0XLRiSu11IDMa9zlK7MhkcbWnfx6NLS87ZW3ViwpUE7CrG1z36ETLk+
	ak3OOil0/MJC815DiEnoemXuX72BYPoj/XTYXB9W9d8OyN8lRazdshNpCmd2t+2c
	Ra17igmhj8/rl9Fj5jIRSLz9SfatgtSt7be341O8bNocKkVY0r7ibp+AI3CdDZM+
	H7KnDT4N0TUSeCJo8+zLjV1XnU06GgsMRXeLiFaTpssGxK0TQWuw7J5gGXwrocec
	RGAMqS7Y0yxsT2fFmY7hv4MnaFhDCvnJUxQTwk5fJVshWdFJ5rPfbl3A55bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1774171125; x=1774257525; bh=YL7tMpEnwf+TLfWo6RsWwqUaD/xfeKjDCvz
	RXvkkBt0=; b=4WG+Ux8M0QjVpSDnEvfLH74ihEC5pPss/08QJO0slrfmROh7goj
	YObat0WLPdP96Medx9ExHbufLPvGnui5ZedTo5S1fViHgZAIjF8O0K2KMqMy8QUv
	L1hXR/tR9Qr0ha6Nta5cYixph1MYYP1fNaO4DauTjWGbUWWiNTMnGHEcwPYTKbhG
	KtW81sjI/WhLyt76+JxeNjJ8aqtwkc7Pc3aH5UPSqnqOyDvjBnrgoeiQiy+CR6U+
	emALzKmdaIGEme+t27X/upoJ5R4NlolAUKBP1szIHjO2wiFXU5pvGiGVf8cZwU+Q
	OT17GKYNjxcpESxs7jVUQKuaM7dO+pQyByQ==
X-ME-Sender: <xms:9bO_aeMlnS8tFVLjz6HRRSHDF_dXX25vwKhrXacn3KBiY5Kavg_orA>
    <xme:9bO_aawhVxaCRURum4N1q9OeAwaQMfQRQN4cXlYlppl6X4D2Ptv_zT1Qqr13EeLAI
    IOUJfNC_Vw-vy0yV9_XistAkWcRgHv18i-_Dc5K-cKY2akzOw>
X-ME-Received: <xmr:9bO_afsTK6sTQc3MS21k54HrQAMxF97Qc1BiV0UUllQTvmB2BBdUyQgORD79zGMj0ypcWsFsN_di0zAW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudehgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeen
    ucggtffrrghtthgvrhhnpeegheeuhefgtdeluddtleekfeegjeetgeeikeehfeduieffvd
    dufeefleevtddtvdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehlghhsvddtudelvddtudeftddvgeegsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsh
    htrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:9bO_ab5RRfnZoXw7bo60wKIHcGB3fP_gkZdKhrxlKjcOwMOXARH_ng>
    <xmx:9bO_aWSVBxHS36CW7RPDEa17xg5jFwCFUk6ywcv77y9UFcsBchRHuA>
    <xmx:9bO_aSpaz5taL5C8gIpx9P-hBd8KMbzBpEtcrBuAwBkZSA1ObAZYaA>
    <xmx:9bO_acKyFdD-IuW3kqaoJlEMVHguy1JIVLwAm7VTz3pXwpApOfuJIQ>
    <xmx:9bO_aRK-vowlpnN0lfysBHr3L_JlRbTbw6DOXPtstwrkqzv1bGr42TpZ>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Mar 2026 05:18:44 -0400 (EDT)
Date: Sun, 22 Mar 2026 10:18:42 +0100
From: Greg KH <greg@kroah.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH] maple: Fix refcount leak in maple_attach_driver() error
 path
Message-ID: <2026032237-acid-cradle-6b86@gregkh>
References: <20260322084405.868743-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260322084405.868743-1-lgs201920130244@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kroah.com,none];
	R_DKIM_ALLOW(-0.20)[kroah.com:s=fm1,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227824-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kroah.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[greg@kroah.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: D38CB2E8B32
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, Mar 22, 2026 at 04:44:05PM +0800, Guangshuo Li wrote:
> As device_register() calls device_initialize() before device_add(), the
> failure path in maple_attach_driver() is reached after the embedded
> struct device has already been initialized and its lifetime is expected
> to be managed through the device core reference counting. However, that
> path frees mdev and its associated resources directly via
> maple_free_dev(), rather than releasing them through put_device() and
> the normal release path. This may leave the reference count of the
> embedded struct device unbalanced, resulting in a refcount leak and
> potentially leading to a use-after-free.
> 
> A possible fix would be to use put_device() in the error path and let
> maple_release_device() handle the final cleanup.
> 
> Fixes: b3c69e248176 ("maple: more robust device detection.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/sh/maple/maple.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/sh/maple/maple.c b/drivers/sh/maple/maple.c
> index 6dc0549f7900..20b7c2cd852b 100644
> --- a/drivers/sh/maple/maple.c
> +++ b/drivers/sh/maple/maple.c
> @@ -393,7 +393,7 @@ static void maple_attach_driver(struct maple_device *mdev)
>  		dev_warn(&mdev->dev, "could not register device at"
>  			" (%d, %d), with error 0x%X\n", mdev->unit,
>  			mdev->port, error);
> -		maple_free_dev(mdev);
> +		put_device(&mdev->dev);
>  		mdev = NULL;
>  		return;
>  	}
> -- 
> 2.43.0
> 
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

