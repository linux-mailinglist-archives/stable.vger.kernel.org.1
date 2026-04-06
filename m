Return-Path: <stable+bounces-233381-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePXsNkbA02kalgcAu9opvQ
	(envelope-from <stable+bounces-233381-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:16:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 447FC3A3D72
	for <lists+stable@lfdr.de>; Mon, 06 Apr 2026 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2D6F301CFB0
	for <lists+stable@lfdr.de>; Mon,  6 Apr 2026 14:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3637EFF4;
	Mon,  6 Apr 2026 14:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcYJUk3n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E937EFE0;
	Mon,  6 Apr 2026 14:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775484917; cv=none; b=oE+d5Kl7DwZRvDWD02ROokVC3wJXFQqJlVpx4kVYvRni4ak7NhZVCzdpCx2gG+OVWXEsR0lgGcLfGKuVqiirC82x9W+Fx7VKxPAH9aMtsVplUE/hmA+cpxB+mG9mqe5EEdFMTCW1NFiuOhiV2UEIrjckYOt1d5DUDRx1hPovhPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775484917; c=relaxed/simple;
	bh=ukroTlAuuyL7iC83lhceMNrUFCFdBl7/DeXxFiCFBvI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=L3+MYwLp2+firVcoKIvnTeUUOTW/UR+jgRdpclXbviDaXrWvDCTUMf0NjqL+WiZMNm1wTscM4yNpzsqLzjCIS5fDly9mc0hD/GnnYB/PqqvIq5x3vo3K5w5X1XbBqq0Z5yd1F0w4cVS7m6DeRYjMup4T4UjrqcT1kL02P57MTOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DcYJUk3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04AFC2BC9E;
	Mon,  6 Apr 2026 14:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775484916;
	bh=ukroTlAuuyL7iC83lhceMNrUFCFdBl7/DeXxFiCFBvI=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=DcYJUk3nSU0zJLdmKjhLze+nFs+4TQGxzCmJR0zfoC0XIUhfRPtMUpdjqLErPDg5B
	 XM16GxuHGe41pzmcGHCdXmGwGl+PuhdVFVQQl1wzaNJNfmnGBRMmIv7cEYTPv9srUx
	 3WkzpSrnGKniGMdnrWsZw/vhpdaomqo38noB/aMnhRCDicYslfgv8MEgNVPCaNQH++
	 vxSExVALfXdX0hb7sRJ0mPSaue6WyJJIyiwhgdnhuvDsk9pbsUkhBGZ8YObAROwLiD
	 zuxJQoXqztu/Bmzn6PiRdbon9ZoM6LTYIpDBoiLg12MnWFueNgEkI6XJTRbA+Yfm9m
	 L9zhLXzv+gXzw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Apr 2026 16:15:12 +0200
Message-Id: <DHM4VGI9GKGB.25R8KA5F89JA@kernel.org>
Subject: Re: [PATCH v4 1/9] driver core: Don't let a device probe until it's
 ready
Cc: "Doug Anderson" <dianders@chromium.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Alan Stern" <stern@rowland.harvard.edu>, "Saravana
 Kannan" <saravanak@kernel.org>, "Christoph Hellwig" <hch@lst.de>, "Eric
 Dumazet" <edumazet@google.com>, "Johan Hovold" <johan@kernel.org>, "Leon
 Romanovsky" <leon@kernel.org>, "Alexander Lobakin"
 <aleksander.lobakin@intel.com>, "Alexey Kardashevskiy" <aik@ozlabs.ru>,
 "Robin Murphy" <robin.murphy@arm.com>, <stable@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260404000644.522677-1-dianders@chromium.org>
 <20260403170432.v4.1.Id750b0fbcc94f23ed04b7aecabcead688d0d8c17@changeid>
 <DHLITCTY913U.J59JSQOVL0NH@kernel.org>
 <CAD=FV=Wgw7kU+Xse6dwjE+U06_A_tWcA93UXu6TTf0Erh+Mt8Q@mail.gmail.com>
 <2026040606-brewery-veteran-e013@gregkh>
In-Reply-To: <2026040606-brewery-veteran-e013@gregkh>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233381-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 447FC3A3D72
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon Apr 6, 2026 at 8:39 AM CEST, Greg Kroah-Hartman wrote:
> On Sun, Apr 05, 2026 at 03:39:26PM -0700, Doug Anderson wrote:
>> Thanks! I'm happy to resend a new version if need be, but I'm also
>> happy if you want to make changes when applying.
>
> New version is always best :)

Yeah, a new version sounds good -- thanks Doug!

