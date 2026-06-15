Return-Path: <stable+bounces-263156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cvuQKtW4L2pwFAUAu9opvQ
	(envelope-from <stable+bounces-263156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 10:33:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33AF06848EF
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 10:33:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=hiKhHkod;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263156-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263156-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1414130262DC
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 08:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B3C03CBE9A;
	Mon, 15 Jun 2026 08:33:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B3243CAE61;
	Mon, 15 Jun 2026 08:33:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781512396; cv=none; b=pMhdpEvSNxnG0tw/+Jxq9ORD2i2ok0HvVEM0fE2jAc0ls+9YaLN5KhuB0UuLYo5a8x4Jv42jXbrXK42X94H3uTkJzjvlMIiCCiAdAlvS5DT8pMRJL8cG3Yf2CscRMvrrBez3XLOBCoFV3wtrFbWrVObN0qhZ+oFraY/5yvH+Ci4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781512396; c=relaxed/simple;
	bh=bhNdERKO+2zOaNEe5hebDG3dSwA8uHn1jQ9in5tSBko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4At3nGywtm9lnDQVaulHa1p2Kcf0L/w/ud/vFjY2wDLNBj5JGAyNp1P76gxSST5Ve/9HA0RmlPIL+m/1FCytJcoE1Jrjo6jHodBCuo2s9JhpxXlJasstOjdxV5RKtBo3iC5hMVAXm5/Rv+6JSn5c0p/eN9MhJil+AmHXbHNPr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hiKhHkod; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E74C61F00A3A;
	Mon, 15 Jun 2026 08:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781512390;
	bh=LJgk49lZh6XkT3vT7lnSu1LzZgJc7yNDIBCNptBuK3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hiKhHkodjr8F1lTnZSfkNelArHKuwZFvaMO9NZ3kHGojJoYvnYvo+9oEgK9tYy8yO
	 K6LWUwWYBJ7H7s/SpN1JR0m89FPDHrCe78Vqhwxjq/4iFZntiZJF2+FKd3xg0dJEZX
	 SXukZovrHXKWLJZtO/vBTQzMHS0dUxc57AayqQ3pMpF8k1YIbwb86M31eWLkdK04jm
	 aSEuOO9wf0JPitNpyjpWvvva+IwajkFG0BL8rJCB0vslLnszOjQ81CJmQmKavVwZCk
	 K+ZzUnwe6h6e8GLmZVgKKQQu0h80O+fyFYLbgXpXtpCjCzOFarcBc3DaZIePSZXW27
	 gs04kaRsSn6CA==
Date: Mon, 15 Jun 2026 10:33:06 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Hongliang Wang <wanghongliang@loongson.cn>, 
	Binbin Zhou <zhoubinbin@loongson.cn>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, 
	loongarch@lists.linux.dev, Huacai Chen <chenhuacai@loongson.cn>, stable@vger.kernel.org
Subject: Re: [PATCH v6 2/2] i2c: ls2x: Add clocks property parsing and adjust
 bus speed
Message-ID: <ai-3ZiF7RL8J4lNP@zenone.zhora.eu>
References: <20260608024533.32419-1-wanghongliang@loongson.cn>
 <20260608024533.32419-3-wanghongliang@loongson.cn>
 <ai8o9vxUX6rbZNV4@zenone.zhora.eu>
 <338facef-6893-c8d9-0efc-b4fc3aea756b@loongson.cn>
 <CAAhV-H5R9fPvUs7dvNrZAbXrGiWvE4YPkaca2nxnhgS3A+TVYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAhV-H5R9fPvUs7dvNrZAbXrGiWvE4YPkaca2nxnhgS3A+TVYw@mail.gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:chenhuacai@kernel.org,m:wanghongliang@loongson.cn,m:zhoubinbin@loongson.cn,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:wsa+renesas@sang-engineering.com,m:linux-i2c@vger.kernel.org,m:devicetree@vger.kernel.org,m:loongarch@lists.linux.dev,m:chenhuacai@loongson.cn,m:stable@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,m:wsa@sang-engineering.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-263156-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andi.shyti@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt,renesas];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,zenone.zhora.eu:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 33AF06848EF

...

> > >> Based on i2c bus reference clock(clock_a), i2c bus speed(clock_s)
> > >> and div, calculate the prcescale of i2c divider register. The
> > >> calculation formula is
> > >>
> > >> prcescale = (clock_a*10)/(div*clock_s)-1
> > >>
> > >> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>
> > > I think Huacai has not reviewed this patch, his review was only
> > > for patch 1. Am I right?
> > >
> > > Andi
> > Sorry, it was my mistake,  I will send a new version later.
> Why? I really gave some suggestions in previous versions and you accepted.
> If an explicitly R-b is needed for each one, then
> Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

Yes, no need to resend it. The R-b should be added only when it
is explicitly given; otherwise, I can't tell whether the reviewer
agrees with the changes.

Thanmks,
Andi

