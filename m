Return-Path: <stable+bounces-47642-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0B28D378C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78E142847DA
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 13:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1711185;
	Wed, 29 May 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="AwzxRkA7"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C6010A03
	for <stable@vger.kernel.org>; Wed, 29 May 2024 13:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716989098; cv=none; b=Sg9T8Alu4KH4zp7FSsu+PIvSWQSyvtm+VrUfee4hHbEYE9J/VmD79J9FOKEKDuJvdqg2evce9PzLP/aG+dnfCSQ96JQyAMLDDYTVJ1ksWzpcDJeO7Nrd24Tl3KTjxYC5GyhHagTr/+eSOATSfYq7qWWPKI8rvwO4zfT4bKOR/UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716989098; c=relaxed/simple;
	bh=fHkrc0w0BiARplzsfWvIw8MQTpTzY9fd1/+3M1NlQYo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jjRQWVhtEf0E0yOnxZJG/96nbnUSC/4kp8aWkZFY5KSvJdUcNDT1GrdgLhDnNiSO/mJ8QtiYOj7dYKXhDJeg6stHOABMsCd090Zmvm2ef59AH0zXtD4zQ/Txvo+9nadQ7KlMYR7JHLujqDvSJsTkeAfFB0iy9UdtJpmmV8ZwXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=AwzxRkA7; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=fHkrc0w0BiARplzsfWvIw8MQTpTzY9fd1/+3M1NlQYo=;
	t=1716989096; x=1718198696; b=AwzxRkA7wxqeU5vdAoSjJoNtSDltjlcBoOQyWv3gOBRmQtP
	3Kq4rmRPJ2fOOgx/gGPSgplvocIbQPAMGjGX8DqDx1n3MoYlYtdQHW2QLxDAGddhVwKLlXcxTq6lJ
	K4BFbL60P22laUvuUcAeu8QNwWm63QXM++wzLslBLA6UECSfrKtwduMBRFQHKmIWwmH38QKPhK/e7
	JC61skZbuDACXGLhInMDcO06E3OrJ6av+IxV01gSIMWOWJZC+azwAT17GfUUX6j8HTfGxUw9Fdm9P
	GL7LYXYAoUucRfVAduZV5as+u1XN0Ubuqdm51qvHJ29ovTqag7EL3yOPigdDpUig==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sCJIO-0000000Gxq4-2VKU;
	Wed, 29 May 2024 15:24:48 +0200
Message-ID: <425dc5349dfa6a86a6523a30c62ec812f6cb25ce.camel@sipsolutions.net>
Subject: Re: [PATCH 6.1] wifi: mac80211: apply mcast rate only if interface
 is up
From: Johannes Berg <johannes@sipsolutions.net>
To: Alexander Ofitserov <oficerovas@altlinux.org>,
 gregkh@linuxfoundation.org,  "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>
Cc: lvc-project@linuxtesting.org, dutyrok@altlinux.org,
 kovalev@altlinux.org,  stable@vger.kernel.org,
 syzbot+de87c09cc7b964ea2e23@syzkaller.appspotmail.com
Date: Wed, 29 May 2024 15:24:47 +0200
In-Reply-To: <20240529115602.4068459-1-oficerovas@altlinux.org>
References: <20240529115602.4068459-1-oficerovas@altlinux.org>
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

On Wed, 2024-05-29 at 14:56 +0300, Alexander Ofitserov wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>=20
> If the interface isn't enabled, don't apply multicast
> rate changes immediately.
>=20

This isn't even in mainline yet, I think backporting attempt is doomed
to fail ...

johannes

