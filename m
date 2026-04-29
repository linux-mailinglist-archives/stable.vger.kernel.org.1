Return-Path: <stable+bounces-241897-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKdxGvMU8mmKnwEAu9opvQ
	(envelope-from <stable+bounces-241897-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:25:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E671A495AB5
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0F5F30C8C45
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 14:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83933282F15;
	Wed, 29 Apr 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVUedMLb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E7E3033F8;
	Wed, 29 Apr 2026 14:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777472422; cv=none; b=YYWMU2GC0C+WtaOsa+5dTNZWCo+CyEi7cfhGwOujpJT6ysKzdYqPkemQX4tljTZaECsTZqMfWpsqH41Jj0hCQL7gB2zoDFdtIvcO+w3R30dYJt58FfpWVEg7OxQOexiAbNi25AXAxQhcVnAkO+MBz4/K+58RSMRZ/iz/R1YWiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777472422; c=relaxed/simple;
	bh=GgEoWjI2LF7k28fEnd/rNFOLYablFhxdSoW/M70SQY0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=C62RJWPHVuz4hYtQtK7I4cgS3zxrHg5E7jB4O6TtnJM7fQnDJs4jr9Mu2YXpLX4dD8afJKvJkUlgEd4L5P6T5v13D/LuvfVMqvxScfmNcaHYtPnM/m7ECPFPBxz8dcAcNHSZaPmJx1dgd7DmCwTP1YBvhklfjykgLYYuH1LZovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVUedMLb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA591C2BCB8;
	Wed, 29 Apr 2026 14:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777472421;
	bh=GgEoWjI2LF7k28fEnd/rNFOLYablFhxdSoW/M70SQY0=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=eVUedMLbcR9rzjSW5bHDTimw8hlc5PSO8VEQkMRqeAK2lCVYEX68eFNhKqEB55xbm
	 VGCLH3gyIpj1YNijn5CLTwS+kUqoqVzzl7gHM2mxkKwwka3ibaH/W6xxXN8IZhgNAZ
	 lyeIXc6oYc+Rn+ItH8xVYOLbk7OoNsqvca935bi43//mPWOecbwEHPSkdfmVxz1Se6
	 0tYS1dpV+acHg+mMhsVDAviBcSJnuMC9jgQNinUEIIiq+Bu05gcnhI9ZY6WA6dNOYs
	 7+F9X0Mtu0umr0GO16HGiE6mHJ/xP+Tbo/fGGESuj/V/TtNHf8aIzQ516F6HhZ7LgP
	 2+Wamy+L4qPnQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Apr 2026 16:20:18 +0200
Message-Id: <DI5PDWIV7N7X.16VB7OPUTJ6ZK@kernel.org>
Subject: Re: [PATCH v2 1/2] driver core: faux: fix root device registration
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260424153127.2647405-1-johan@kernel.org>
 <20260424153127.2647405-2-johan@kernel.org>
 <DI54XY4CNFCD.30M3UJGK1M3BE@kernel.org>
 <afHapCZz5C42euaD@hovoldconsulting.com>
 <DI5KV97TNS9D.28EQTYL46PKT1@kernel.org>
 <afHpUxQ5U_4RWjDZ@hovoldconsulting.com>
In-Reply-To: <afHpUxQ5U_4RWjDZ@hovoldconsulting.com>
X-Rspamd-Queue-Id: E671A495AB5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241897-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

On Wed Apr 29, 2026 at 1:19 PM CEST, Johan Hovold wrote:
> The stable rules have been relaxed in practice since Autosel. Anything
> that looks like a fix (e.g. has a Fixes tag) gets backported.
>
> And people get tired of asking the stable team to drop patches that were
> not marked for backporting.

There is still a difference between this happening in practice and using th=
at as
a justification to explicitly request a stable backport for something that =
- by
the official rules - isn't mandated for stable backport.

If the rules changed to the point that they don't apply anymore for decidin=
g
whether to stick Cc: stable on a patch or not, then they should be adjusted
accordingly.

