Return-Path: <stable+bounces-206110-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6CBCFCFED
	for <lists+stable@lfdr.de>; Wed, 07 Jan 2026 10:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B524730509C3
	for <lists+stable@lfdr.de>; Wed,  7 Jan 2026 09:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB12322B61;
	Wed,  7 Jan 2026 09:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="k5MAatyg"
X-Original-To: stable@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEDD3126DB;
	Wed,  7 Jan 2026 09:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779512; cv=none; b=pXIhASzfcs6pHaUhPTBKYbw/b3s2Q7CRH3yjbzhSeWi5TVEYyJI5bgc4ALs6TTSRuaG57cIO8L5rGvow11O6bjDT+68++JhcpW7akEDtsM1OtvJkLRk2GBcFrzWvKLSMoZG4v9VzbaR5BsAlzGHIS4ZCkUwdH898tdsKZwS+5OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779512; c=relaxed/simple;
	bh=nE5xqdgsLdwjSBCDkh9NrAinC8GAJWzhSEOF62kybxc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lVlfrgnqE1Mo+Jgarq8611tWX0Oh73RNLgGVyB8UmcG/CCbKlDuOt4hAeyjOZOn6Zq1x0ej4sccZGAwC/ZpnOIVX49IvkZXHOY/P5Qpcs942/ZzhfmLEfoXVNgoyP+U3uzGGJ/72vUr/SvvUM+fwLVLA+Ujkf9pzzasV8p2/NjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=k5MAatyg; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1767778890; bh=nE5xqdgsLdwjSBCDkh9NrAinC8GAJWzhSEOF62kybxc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k5MAatygne1vwEa/WKKs0N+JGqvIvXzEvORvNM00jNfhVl74wJ0SWirCSb0cCsHkX
	 zD9QGd2ko9Y9LqU5QBm6MlxZoh5vYC+Ozg+oofm7Y+DISvfxcTll0/8PCO4nE8KozQ
	 r3nSt2FB5dKhEFE8kHS7EFc3IY4zIErAI+LhT1UBH10ybLWeaFkYNfaMw40shQDH6J
	 dDhpOeAYvHvrRgpPq35FCVLOkTwlCulE3pZGzosomAKGrFm20VSTP7hJhfI726TMKK
	 J2akg5PUN4aw5Lj3n758k6S/L5JOJfuh2Wejcp9Toy86dQiGw97wTj7moAWU3liPgB
	 V/YnqNzr5zL+Q==
Message-ID: <4ece65a62bac434de260896d208fcd9067185b4c.camel@sarinay.com>
Subject: Re: [PATCH net v4] net: nfc: nci: Fix parameter validation for
 packet data
From: Juraj =?UTF-8?Q?=C5=A0arinay?= <juraj@sarinay.com>
To: Michael Thalmeier <michael.thalmeier@hale.at>, Deepak Sharma	
 <deepak.sharma.472935@gmail.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Simon Horman
 <horms@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Michael Thalmeier	
 <michael@thalmeier.at>, stable@vger.kernel.org, regressions@lists.linux.dev
Date: Wed, 07 Jan 2026 10:41:30 +0100
In-Reply-To: <20251223072552.297922-1-michael.thalmeier@hale.at>
References: <20251223072552.297922-1-michael.thalmeier@hale.at>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-12-23 at 08:25 +0100, Michael Thalmeier wrote:
> Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
> packet data") communication with nci nfc chips is not working any more.

The commit broke existing user workflows, should therefore be handled
as a regression. Please consider reverting it until more refined
validation code has been thoroughly tested.


#regzbot introduced: 9c328f54741bd5465ca1dc717c84c04242fac2e1

