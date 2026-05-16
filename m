Return-Path: <stable+bounces-248953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EEvLpe1B2o0DgMAu9opvQ
	(envelope-from <stable+bounces-248953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:08:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBBB55980D
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E97C301C3E8
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 00:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D0F3C8CE;
	Sat, 16 May 2026 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5LV9J3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072A632;
	Sat, 16 May 2026 00:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778890129; cv=none; b=h5iEZKoyiXalPnmM9Ml+UpSV9gvRdkja1TesXEEwBKF+B1ZsNjSs4sTiP4RoiNnZED/0yzX0cQbkbW9um25XKKRG9Yh4d3UYxzbVE/MwRknoQSvLPz6fCmXr8dXBJ0W/40M/PEW4y7aqS7Tp+ljHZ0JxW0EagVE0RVGn0/okjgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778890129; c=relaxed/simple;
	bh=+rEMLvaJ/O1NBIlGLObcKcwAdS/IyXxZF2zKynfYMEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gNOXJBAdLhFweymKO3MqIbxXGoDD+mmyx83KVAEt+LZyJjvYqa6VABD3qbNDnBbpcZ0+hJ/BzhGq9XkZgwJ6VebWILSEyxHAV0ZRl1tvZsIapA/BEZzo9Hsv5lGgjyt8A8C1kzymRzDYdsJp56uyDCyq4HYBVi3ldXzIEYZKmg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5LV9J3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45283C2BCB0;
	Sat, 16 May 2026 00:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778890128;
	bh=+rEMLvaJ/O1NBIlGLObcKcwAdS/IyXxZF2zKynfYMEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A5LV9J3H7g+P5ImyZESwq5dkSQ4P4/eKjjB5WGXATaKfcnGZrhp7v2rpGBIOQbDDX
	 67gM549VBrfRCo5wVGYh4i3RoNzHse0pXGMPM8B7LxW33b+/TgwrME5dP9G1jSIUVQ
	 WN5lKKYChFVjPZEqHluMCIierJu5aGLvR+uch7sSO0SFZDvSDdL6MoeYrw/pCMy2hD
	 0GIMUyvAvSuz+FcRZM1oBBfbf3X3Ddsb0dEXCoZ1FHdWL72nkt9FDG1yb0im54M6EM
	 xYXw7JRcSK0Ad8QbdkSkKUxXt+ifNWl/IsHf7olr0B7MaxdDDzqmpqM2cmONna2yeN
	 pE6i8b+pdNq4g==
Date: Fri, 15 May 2026 17:08:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Aaron Esau <aaron1esau@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 sultan@kerneltoast.com, sd@queasysnail.net, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH net v4] net: skbuff: propagate shared-frag marker
 through frag-transfer helpers
Message-ID: <20260515170847.254135ed@kernel.org>
In-Reply-To: <ageR2qzTRtpH8JGY@v4bel>
References: <aga1VyHpHaUhnGZa@v4bel>
	<20260515164121.2608076-1-aaron1esau@gmail.com>
	<ageAmZcEMu4Yjyyl@v4bel>
	<ageR2qzTRtpH8JGY@v4bel>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8CBBB55980D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,kerneltoast.com,queasysnail.net,secunet.com,gondor.apana.org.au,vger.kernel.org,linuxfoundation.org];
	TAGGED_FROM(0.00)[bounces-248953-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Sat, 16 May 2026 06:36:26 +0900 Hyunwoo Kim wrote:
> In any case, v5 will be submitted shortly.

Slow down, follow the mailing list rules.

