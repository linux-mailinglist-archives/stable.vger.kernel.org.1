Return-Path: <stable+bounces-142771-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98DEDAAF05B
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 02:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051C07BC2B3
	for <lists+stable@lfdr.de>; Thu,  8 May 2025 00:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2082E1519A6;
	Thu,  8 May 2025 00:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fg51x28b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91AD86358;
	Thu,  8 May 2025 00:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746665909; cv=none; b=YvAtZT0DDcSWwdEueApy7O6/xdNkUSTvG4F0D2aMyLDTUKrEdaaLD3vd1JXcjQmI/cfd/vsHzCPTQ3Cmx9ASyeCXJn1U/Q5juhmkl75nqr30/oxCSNRZ36OXiI6FiaUWu7QFV2G+KvP9I6puUUNcE5nVIa76oBZGnX/2WXrwhv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746665909; c=relaxed/simple;
	bh=QtKwOdcIyTG+SJjJmvHcWjDBvCE4AwX6cnVmpWUWvN8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=WvFe4ELWOfOl5Eht6t58fpbZlaruO0CFAp5MaNPTxuNBZTEfHZeLK+j/M9R35byw1cH4ichuV0/ll5IRsmLyQRdOCARtQw/Nx5BVopwDKInbTsxPGqaVfgGAZ9t2cFWbYrbunUnDV2xPE4118sGURaeprWcgs9X6+4V64U8J+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fg51x28b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7ADC4CEE2;
	Thu,  8 May 2025 00:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746665909;
	bh=QtKwOdcIyTG+SJjJmvHcWjDBvCE4AwX6cnVmpWUWvN8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Fg51x28bfL/qRAoMP7ryxkvmaNX0sD8/esq3nYN19gpK37BEn3nA/RPbjoVpAi0AM
	 t5Vinlfo7KuS4wgv3SdWsOjfIesmjvl4KNHXy0vD5muJ6dUdmeFR2JA2taL5Wkppdt
	 jGU4hTEQgxhTECc7dUp2UF1vSN3FpvIeq7QF7OZGsfXJ6xAu4ruPKr0V/uN21E9aKj
	 f/22SpKOZP3QT/oRCYOYoU03neXaHRJFZfhCrlycNT2JOWw3Q0tHf1ylZFmcf4ydF8
	 MaZoX5c5IkDvuPRgr8EzuHogCybX0H3MPB8WgatGGehVDwpQ4OVYUwUAqimk98cAjj
	 UGy1b8KKaR++A==
Date: Wed, 07 May 2025 17:58:26 -0700
From: Kees Cook <kees@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
CC: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net=5D_net=3A_qede=3A_Initialize_?=
 =?US-ASCII?Q?qede=5Fll=5Fops_with_designated_initializer?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20250507-qede-fix-clang-randstruct-v1-1-5ccc15626fba@kernel.org>
References: <20250507-qede-fix-clang-randstruct-v1-1-5ccc15626fba@kernel.org>
Message-ID: <198CC0C3-5009-47B5-AE6A-B43A9D2EB126@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On May 7, 2025 1:47:45 PM PDT, Nathan Chancellor <nathan@kernel=2Eorg> wro=
te:
>After a recent change [1] in clang's randstruct implementation to
>randomize structures that only contain function pointers, there is an
>error because qede_ll_ops get randomized but does not use a designated
>initializer for the first member:
>
>  drivers/net/ethernet/qlogic/qede/qede_main=2Ec:206:2: error: a randomiz=
ed struct can only be initialized with a designated initializer
>    206 |         {
>        |         ^
>
>Explicitly initialize the common member using a designated initializer
>to fix the build=2E
>
>Cc: stable@vger=2Ekernel=2Eorg
>Fixes: 035f7f87b729 ("randstruct: Enable Clang support")
>Link: https://github=2Ecom/llvm/llvm-project/commit/04364fb888eea6db98115=
10607bed4b200bcb082 [1]
>Signed-off-by: Nathan Chancellor <nathan@kernel=2Eorg>
>---
> drivers/net/ethernet/qlogic/qede/qede_main=2Ec | 2 +-

Oops, I missed this one with its 1-character different filename=2E =F0=9F=
=98=85

Reviewed-by: Kees Cook <kees@kernel=2Eorg>



> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/drivers/net/ethernet/qlogic/qede/qede_main=2Ec b/drivers/net=
/ethernet/qlogic/qede/qede_main=2Ec
>index 99df00c30b8c=2E=2Eb5d744d2586f 100644
>--- a/drivers/net/ethernet/qlogic/qede/qede_main=2Ec
>+++ b/drivers/net/ethernet/qlogic/qede/qede_main=2Ec
>@@ -203,7 +203,7 @@ static struct pci_driver qede_pci_driver =3D {
> };
>=20
> static struct qed_eth_cb_ops qede_ll_ops =3D {
>-	{
>+	=2Ecommon =3D {
> #ifdef CONFIG_RFS_ACCEL
> 		=2Earfs_filter_op =3D qede_arfs_filter_op,
> #endif
>
>---
>base-commit: 9540984da649d46f699c47f28c68bbd3c9d99e4c
>change-id: 20250507-qede-fix-clang-randstruct-13d8c593cb58
>
>Best regards,

--=20
Kees Cook

