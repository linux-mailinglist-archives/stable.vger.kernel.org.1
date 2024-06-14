Return-Path: <stable+bounces-52165-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E158B9086CE
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 10:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81EF428731D
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 08:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3111922C0;
	Fri, 14 Jun 2024 08:52:28 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69AD188CC1
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355148; cv=none; b=XF/ZQw/sEsb/Nnh8SMSH1ozCJWHdl0XiiXGqGnVvRP3Wurbv3uujtZJBbvnhqDDo+qiyWdbD8Vyn7Rzjt207xahbQWI81iKz/9kS83imN4zaH/XObFwHrCjIuvkHwkRjmUq4jiiMcEHHKlLjwSBnDENN1KJnxS1Uneasn2+OUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355148; c=relaxed/simple;
	bh=ZKMpzDXUK4fhe7o6fH8FbyHCJ5II9HYO0ilqaiwCHLg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4liPMfj/Lp40lDRqw4y4F12vyVCIhRpieVZlmpkZQyjOCSZGops/mPE/LlY3BSUj5B2ja7qeNsQMF8Y8nmiUVNmNNJD3L669VLN3Blv1/oB4CkK2KLScNJlxnwYqCp/vS2a8BK/Us2hSZlzcDpwyiHta/yOZQXzz6SsCXuLeuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: leah.rumancik@gmail.com,  stable@vger.kernel.org,  Miaohe Lin
 <linmiaohe@huawei.com>
Subject: Re: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
In-Reply-To: <2024061400-squash-yodel-4f49@gregkh> (Greg KH's message of "Fri,
	14 Jun 2024 08:41:23 +0200")
Organization: Gentoo
References: <CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com>
	<87zfro3yy5.fsf@gentoo.org> <2024061400-squash-yodel-4f49@gregkh>
Date: Fri, 14 Jun 2024 09:52:21 +0100
Message-ID: <87tthv52ka.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain

Greg KH <gregkh@linuxfoundation.org> writes:

> On Fri, Jun 14, 2024 at 05:55:46AM +0100, Sam James wrote:
>> Is it worth reverting the original bad backport for now, given it causes
>> xfstests failures?
>
> Sounds like a good idea to me, anyone want to submit the revert so we
> can queue it up?

Thanks for the nudge, I wasn't planning on but why not?

6.1: https://lore.kernel.org/stable/20240614084038.3133260-1-sam@gentoo.org/T/#u
6.6: https://lore.kernel.org/stable/20240614085102.3198934-1-sam@gentoo.org/T/#u

Hope I've done it right. Cheers.

>
> thanks,
>
> greg k-h

thanks,
sam

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZmwExl8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZBrEwEA4tejq0hMk62JIaLWqoO0H9PLf5No23qhYlka
xc0fEGABAJwEXMXtfYGuugjpcSwgYoLtZWOpnJLc5c/pritLN9oM
=aoG9
-----END PGP SIGNATURE-----
--=-=-=--

