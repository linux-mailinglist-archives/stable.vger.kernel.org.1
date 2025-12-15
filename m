Return-Path: <stable+bounces-201005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C2CBCFF7
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 09:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8978D302A96C
	for <lists+stable@lfdr.de>; Mon, 15 Dec 2025 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACA5329C74;
	Mon, 15 Dec 2025 08:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="lH47VaGq"
X-Original-To: stable@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923112EACF2;
	Mon, 15 Dec 2025 08:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765788013; cv=none; b=l+NX7lJe0vbq7iTBXIhPNC3xc/VWBwTuR/+oY6RoZfX6fbCPybRhYwfYCawRP/ePYxCEdZn4mVw3rCelbieDzfAECter59e7/J7Ew0bhZ1IFMJJhw8SqbVmG0z0K8Klx5L15a78pMpBDlEzd+O1cHgKSpZEz9JYubi1Hu+IieI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765788013; c=relaxed/simple;
	bh=nTOeqU30kT/x5/9yPNQq+Y+ZK8e5DQKGTbEd03W/y/I=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h9vfPytfnRuwjzpJ1sw3/sFb3LshFYpbD2ImlvJpBsJ5C51GHn1X6A1uo8oXwBM/HWtO8RrbvDm2GIAbW4s31Zc+/emYoX+Olf1MaBTs03zf0OA+fbCIsrOVSoVzeNCT77NUN0ZaN7ewMvUb9+sFGI2U6Egqg/l9alzrZKLsr8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=lH47VaGq; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=nTOeqU30kT/x5/9yPNQq+Y+ZK8e5DQKGTbEd03W/y/I=;
	t=1765788010; x=1766997610; b=lH47VaGquIJg419B5noS0PqbUClGVp3GmyjrjSSYZ8DuTKv
	8sLoIVNrZf74GL9ow1pdrt01keWPJMk4W7oWUfLnhvTPhWt1bUJpv5E5CE0CTVaX9PRs+25k8CuAV
	9/I/yAnskwRJbmb4OG8luan70kOulQPCMPwwxbjb0BzhldWw5dTUvZL6/Bh0wzU0qkEq3/jnXy514
	z102ZDVAPny8dTqvYS37Hghu4Bq+p9SwcKvwPk2jABsT4oJV5Ic2C+4QlofBa/B9150vcjfgD+2A4
	usascUVhBA17EyAXMbv99wRFDPGNWHCn0ccoOSewGrIWo1b8h730tTM5nOP5jJ0Q==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vV47U-00000008pPA-02cI;
	Mon, 15 Dec 2025 09:39:52 +0100
Message-ID: <d24c7d6bdb97aa2f54667366aaaf044042734bff.camel@sipsolutions.net>
Subject: Re: [PATCH] NFC: Fix error handling in nfc_genl_dump_targets
From: Johannes Berg <johannes@sipsolutions.net>
To: David Laight <david.laight.linux@gmail.com>, Ma Ke <make24@iscas.ac.cn>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, 	pabeni@redhat.com, horms@kernel.org,
 aloisio.almeida@openbossa.org, 	lauro.venancio@openbossa.org,
 sameo@linux.intel.com, linville@tuxdriver.com, 	netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Date: Mon, 15 Dec 2025 09:39:51 +0100
In-Reply-To: <20251214135440.51409316@pumpkin> (sfid-20251214_145444_057503_A0AE70B0)
References: <20251214131726.5353-1-make24@iscas.ac.cn>
	 <20251214135440.51409316@pumpkin> (sfid-20251214_145444_057503_A0AE70B0)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Sun, 2025-12-14 at 13:54 +0000, David Laight wrote:
> On Sun, 14 Dec 2025 21:17:26 +0800
> Ma Ke <make24@iscas.ac.cn> wrote:
>=20
> > nfc_genl_dump_targets() increments the device reference count via
> > nfc_get_device() but fails to decrement it properly. nfc_get_device()
> > calls class_find_device() which internally calls get_device() to
> > increment the reference count. No corresponding put_device() is made
> > to decrement the reference count.
> >=20
> > Add proper reference count decrementing using nfc_put_device() when
> > the dump operation completes or encounters an error, ensuring balanced
> > reference counting.
> >=20
> > Found by code review.
>=20
> Is that some half-hearted AI code review?

Probably. They also resubmitted the same patch after being told 3 weeks
ago to go away.

johannes

