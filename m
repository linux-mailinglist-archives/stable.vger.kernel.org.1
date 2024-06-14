Return-Path: <stable+bounces-52134-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2536908319
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 06:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8BEA1C21AC7
	for <lists+stable@lfdr.de>; Fri, 14 Jun 2024 04:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFE5146A6F;
	Fri, 14 Jun 2024 04:55:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBAAE12EBE3
	for <stable@vger.kernel.org>; Fri, 14 Jun 2024 04:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718340952; cv=none; b=O7aGVP7tRcmTelVtMUe4k/w4EXdRmqDqidSav4EXBWd9HD/8CEA2vh3QhTbosLZTV6SS5PcO8vQ0eBL2mHaBgihUG0KocsMEa82qmoTWsVy9dyxrCm5rMsmm4FBjClR2+7HqEsTezGTVz1PDTLrpEz3Lr2gwV6mG0pFP/DvIvAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718340952; c=relaxed/simple;
	bh=oOwY1Y92zGhJZ9+ELR0lm3dwy7dn2vwijTTez08xRQU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=r6GsBrpgVOrAjzIkYCLeI1BNTH4ktvUcUq5imxI7NKfnKxbHn61/JlYB8RdYadKKk+4QjEZWLlnsXx6bKxSnyRs3Q5X3LdMctvpH8k36Qr5n4l0lldsNGitYAalFuoQ+2eJbtK+15XfmMqIfqcAdCC1VdJdtLSvzIeyjnxZSuN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: leah.rumancik@gmail.com
Cc: stable@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>
Subject: Re: [PATCH 6.6] backport: fix 6.6 backport of changes to fork
In-Reply-To: <CACzhbgRjDNkpaQOYsUN+v+jn3E2DVxX0Q4WuQWNjfwEx4Fps6g@mail.gmail.com>
Organization: Gentoo
Date: Fri, 14 Jun 2024 05:55:46 +0100
Message-ID: <87zfro3yy5.fsf@gentoo.org>
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

Is it worth reverting the original bad backport for now, given it causes
xfstests failures?

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iOUEARYKAI0WIQQlpruI3Zt2TGtVQcJzhAn1IN+RkAUCZmvNUl8UgAAAAAAuAChp
c3N1ZXItZnByQG5vdGF0aW9ucy5vcGVucGdwLmZpZnRoaG9yc2VtYW4ubmV0MjVB
NkJCODhERDlCNzY0QzZCNTU0MUMyNzM4NDA5RjUyMERGOTE5MA8cc2FtQGdlbnRv
by5vcmcACgkQc4QJ9SDfkZDLiAD/fOCmjubkbcF9mfJM7WpsLWS0OejYvKtJx8hs
SxqMcVwBAMVPjec1Q3vRga686l5CUdP4DxiKNBKKxBdInaE/bv4F
=DjH1
-----END PGP SIGNATURE-----
--=-=-=--

