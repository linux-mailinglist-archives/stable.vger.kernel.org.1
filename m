Return-Path: <stable+bounces-262344-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZuwmH45KKGrDBgMAu9opvQ
	(envelope-from <stable+bounces-262344-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:17:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D00F662D60
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 19:17:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BorsVzHl;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262344-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-262344-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 940B3314298B
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 16:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780244921AD;
	Tue,  9 Jun 2026 16:44:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D73148A2AA;
	Tue,  9 Jun 2026 16:44:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023470; cv=none; b=ZLXnjLrAk91/87SWl6nt0ffUJLawsIDiITzqmOkVtYPk/LDi2CWJxlRglkobZdoRRANOWiZJAKn8cr64ZojxoJ+ha3NjHx51FlQ4S/b4VNbN0w/8XbKuiatRaFN/cpYAKiCpXJ9SuIqSUhJ1qrDkv2wOMwXY1D4T2GkvPeyVvLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023470; c=relaxed/simple;
	bh=qyLiUYQYTimn1rhpf2aWmkrFCd6NM2wRneTiaFmzHlA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdCUfHA3apn3e3MVh9YL/pRE2SHMp4L3UAUy310D4VCYICUlLYSOnevuclPs0G/JLFQySLAkT7QTKDTGvnVP+bE0zjDg1JV83r30s9h6EcpJcyyBmLEak0QGLabFRXcC1CuVpe3KV/HSHGTBxtty95ZxqEe3ZsOIgHDvbRRAOHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BorsVzHl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC161F00898;
	Tue,  9 Jun 2026 16:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781023469;
	bh=BmnzHaguHtKrAa2TQW4hv2Uu6Zp1K1zLfEAoMbU81Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BorsVzHls2J/YBQteZWCZbMXAOp0n+Qm7iccO3JxCW2upxHeITtBNGeiFw1Ofp4zA
	 uzAc9n3mfmV1pOgaaqu9vsZw8LzSXwJBKOGwqjCh+fLy4OPAPEF81h9jWsaiPVrzXC
	 Q838Rm/Z1UerIKhtq+bb/MkVzY0J0YnnUP6ImtNVkUEnBsoLIDa2BV8Pb5x+G3YOWt
	 68KJ1GbUGGuQ0l8eLk+6nUMzctWfcznzn2+1XWIpKd4dH2AcAzItG7TCtX+5IwYfyw
	 4QubjMAYFFMkY14ihVLoWcx3wWEZJ84RTiIAbX/aDTdnC8Vn5oXLLL4imK58duWCvS
	 EGYNXHYFLlJFg==
Date: Tue, 9 Jun 2026 10:44:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] nvmet: fix refcount leak in nvmet_sq_create()
Message-ID: <aihC67cPlS_Y6vB0@kbusch-mbp>
References: <20260609095505.227496-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609095505.227496-1-vulab@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:hch@lst.de,m:sagi@grimberg.me,m:kch@nvidia.com,m:linux-nvme@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262344-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,kbusch-mbp:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2D00F662D60

On Tue, Jun 09, 2026 at 09:55:05AM +0000, Wentao Liang wrote:
> In nvmet_sq_create(), a reference on the ctrl is taken
> via kref_get_unless_zero() before calling nvmet_check_sqid().
> If nvmet_check_sqid() fails, the function returns the error
> directly without releasing the reference, leading to a leak.
> 
> Fix this by jumping to the "ctrl_put" label, which already
> performs the necessary nvmet_ctrl_put(ctrl). This ensures the
> reference is properly released on this error path.

Thanks, applied to nvme-7.2.

