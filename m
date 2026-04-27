Return-Path: <stable+bounces-241300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICLnNTdR72kLAQEAu9opvQ
	(envelope-from <stable+bounces-241300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:06:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B362472405
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 14:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B82A630297B9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 12:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB823B27D3;
	Mon, 27 Apr 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvqD47lJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7945B30BBAE;
	Mon, 27 Apr 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777291405; cv=none; b=RbBFDgQO/LeLliyN5/I0U2qOmuta9+8TwykuMwkNtYzWcBOi6rtTIMH5IhDofZliZnyJY869GpcG27hLoxfUeHiyQbOCA6HWrqvcVDVV2Oi+myVx5VdBnVhAB5dh8R9o8dg6/h/XDEO13Q0L546hh+sFY+85qipSdCyDiC9GatE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777291405; c=relaxed/simple;
	bh=7p8iCBO5JMzunPBf2N0aodXynUIUu8mlRNHSgTuLrgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLqGChKyVAHYkcaVrejPecfRPee3uGykMgt4R6Z3mTFZ3LnJxcOQnFdFCr2UKZhl/XLmwGCV3//XoTRboD3IvO1fiKY5aQkf1mRdR4jG1cfFqobfGjAmlUpZWYij+IHcLH1HyWDarOMP3jcrmb8udOMJ5pHGgJg6kG/rie7VfWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvqD47lJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05189C19425;
	Mon, 27 Apr 2026 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777291405;
	bh=7p8iCBO5JMzunPBf2N0aodXynUIUu8mlRNHSgTuLrgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvqD47lJ437NIOKqm0877gmkscgflBBCmB07NZBAl0VhGaKXrXL+FzpQhSo5cEvvI
	 r0tpLqUhFtgyQBc8JLjBkaWEi7Ba6W+JF9tSZNyo0YNNvCuDOs2zXQ+vFm6P9uOAoY
	 9u5zpEqoA5RPWehQbLO+CrUFuzPrDLE7PkdkQUAdQuIvG1fUKQAVwoJ+ncw74BbHdj
	 ujsq8zayqsxkpdJwrzBc2Yi11JvOWCip5GgTVYTnZ4MBOQhik0teIODU+qnH488OWd
	 QG/hpoJ6Gxko9mSWhRgOvpEhtuGtjrlqiiU+bWfAmwZ9KKRU8cONP6qcUA/H36oSkb
	 BmI3uTtMvo6ig==
Received: from johan by theta with local (Exim 4.99.1)
	(envelope-from <johan@kernel.org>)
	id 1wHKgK-000000000mA-40vP;
	Mon, 27 Apr 2026 14:03:20 +0200
Date: Mon, 27 Apr 2026 14:03:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Heiko Stuebner <heiko@sntech.de>
Cc: Stephen Boyd <sboyd@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH] clk: rk808: fix OF node reference imbalance
Message-ID: <ae9QiGGPB9gJ0HhG@hovoldconsulting.com>
References: <20260407095027.2625516-1-johan@kernel.org>
 <177714062701.5403.1177541832751457755@lazor>
 <10504733.NyiUUSuA9g@phil>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10504733.NyiUUSuA9g@phil>
X-Rspamd-Queue-Id: 5B362472405
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241300-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hovoldconsulting.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 01:17:39PM +0200, Heiko Stuebner wrote:

> Looking at the device_set_of_node_from_dev() function, this is the
> right move, so
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>

Thanks for reviewing.

> It also seems the rk808-regulator.c might be another candidate for
> this, as it also takes the node without of_node_get and manually
> setting the of_node_reused flag.

That's fixed in 7.1-rc1:

	65290b24d8a5 ("regulator: rk808: fix OF node reference imbalance")

Johan

