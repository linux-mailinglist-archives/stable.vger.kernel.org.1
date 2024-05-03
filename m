Return-Path: <stable+bounces-43032-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 988DA8BB38B
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 20:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38E271F241AB
	for <lists+stable@lfdr.de>; Fri,  3 May 2024 18:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9990913A25B;
	Fri,  3 May 2024 18:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="Emlxzy2C"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE00E1586F5;
	Fri,  3 May 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714762539; cv=none; b=vDN1W8QqOn681NvxgN7F9yKsrpQb3wOJNtkovuby5d6bXCv3hISaHqqwp4CIAnK30i5nnDSxBXgq5t13oiNktwrJaGwyAHXwyuhVxQymJY9eC878gy7GKM9ALJ6fJdNb+JbN31H4O4Nliwt5xqimWYBPlj5M0P8R8dbJtVRPbPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714762539; c=relaxed/simple;
	bh=wl+r04Bxtdx5730pRhC5psuyglWn0ij++T1W+Ah0vlA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VFPgO41DgGbrOLaSBEdaqfOGq8duqkXI+gnfmzV2dtMVdpjqS2PwzJ39911i5fhLeCLHX7g29qeGp57wsXu4h4UHKGLL7B+BCJg99ADDnVDU4lzCV6hRNtlrppQlwB8GswIxfhJKf1noPqGVHENGEhTbZwEwKTwxByOGGPxOwL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=Emlxzy2C; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vDG0CYP/+ZkUkYNGf5oXeMIkclEwmqaV52ygX9axAc4=;
	t=1714762535; x=1715972135; b=Emlxzy2CrI2ghwcxxGnVkNFOLCKVXuiQcyejW+GezPLfQTT
	6jpaRv1nn3MALdxI/7wlWcZPVGPPuEu46hq43Vm5NCs5AAykE4RgZwYmsJYx7PfLHg/Hxryr+eOsf
	scpgdyPgwPVFhseBDNSZwe2Ytw1z1X9tGQDGqrW8CQ1kA693/4bQ6lhk3fopzZqfVcQNKcydd09pB
	XFab5LBliVpo0j1H/W2wU2PABn+A+9pgwYcjqmlbOgDg11chnrBYm7gMRx2WLya0CrGroEG/l5wxk
	7Ux/0whw/HXPeokRxpWC8FkTYmxXwk5UwNqFNJTMYWHye4ffIV/LcX4bLBlGJBaQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1s2y4A-00000002Hcg-1dpI;
	Fri, 03 May 2024 20:55:30 +0200
Message-ID: <92ffa00872ed66d634df22b49ee960e0da9ef232.camel@sipsolutions.net>
Subject: Re: Patch "wifi: nl80211: don't free NULL coalescing rule" has been
 added to the 6.8-stable tree
From: Johannes Berg <johannes@sipsolutions.net>
To: stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Date: Fri, 03 May 2024 20:55:29 +0200
In-Reply-To: <20240503163849.5887-1-sashal@kernel.org>
References: <20240503163849.5887-1-sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-05-03 at 12:38 -0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
>=20
>     wifi: nl80211: don't free NULL coalescing rule
>=20
> to the 6.8-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary

I was sure I pointed out before (to Greg?) that I made a mistake on this
patch and it should be dropped.

Anyway, please drop this from _all_ stable kernels. It's obviously
bogus.

johannes

