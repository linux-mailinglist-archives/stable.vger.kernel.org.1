Return-Path: <stable+bounces-69409-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C97955C14
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 11:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A301B1C209E2
	for <lists+stable@lfdr.de>; Sun, 18 Aug 2024 09:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7AD17BA2;
	Sun, 18 Aug 2024 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TjQzTwGn"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554E317C60
	for <stable@vger.kernel.org>; Sun, 18 Aug 2024 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723973949; cv=none; b=UQfBt7MuhI15eKPQ1eW2ixsrfOKHNOjZs1aSg+D/YZ6EjappfsKDAB3OkFwuRcIAZJp8T14emohXz5SQVXY/JhnOWufNVrm16g7mIBptlJ9YIBEp0IkNWuP7P64PbLPELzb7uNj4L+f/p8+QblX27y6yVIr2bZqw9AEr7+G3LF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723973949; c=relaxed/simple;
	bh=M4nmkyH4QHTg3SbxLSHLMsr/yRq0Mzky4QvzjGSfkhM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UPoMJXY/6Zw3X114N3Zu1M2O0P3TPcAcCO0rTegbpSqg1iyFnXAD9hQ5f6W61CreM9nxKpDhYu5rOTnfU/crSupqAPO3swiy5s92DvrlnrDmf1on5rZPt0d+NtkKTUP+FDQsY/lAuGP5NBdUlTpjU+TnrT31vHHPU0Isf8mOzPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TjQzTwGn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42817f1eb1fso25674565e9.1
        for <stable@vger.kernel.org>; Sun, 18 Aug 2024 02:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1723973946; x=1724578746; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkgFy/p55P7RIRDwFamIanzv8uC6eQMVCp6t1WqK4Xc=;
        b=TjQzTwGnvOLOq20a0R3wij5WhEgiZfifQYjbTQLSNdSvDjGyq6BrFC4pqVpql3sn2g
         AWA57/rRPbU1bu51PFx9KDWqu4khgvGvr/8f+huBUmIgBwzAIh7SvRPsGaqn4rtU7FY0
         AtJRT6I7xvo0J02rLeTO58jDZJsOmSGISkwzwS/hyO86KD9xrHROpqPB3PCs+RWKOXoy
         RcfVBG9f5xn0toDlxpovTrfMgWzuT8DKc2Gym+ym8+kzCUEtquB0JnnThhwxLUu5xgZj
         0puR/xwb+bCz/S0HeObkXhlXJtSwZR0HMfYDjVq/WTaukzmNx21HJ/gh4+n+JEUIp+cZ
         9Kew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723973946; x=1724578746;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkgFy/p55P7RIRDwFamIanzv8uC6eQMVCp6t1WqK4Xc=;
        b=fTQSw5VqzECIdY59VuOqVuK0MS1NutHRpB3T9qbNBoJYLVph5lD6odf0reF+/C2wex
         u2sRFQvNvPq0+AfaLsukWlyKCz3SWX8xBtD0Jo1qL3WCO8vpPR3Lyfg9hFpJqpFViw5L
         /DhqBadfU3f/SfzgdLbbIgsolM1bqcF7gQ04W0Jfv2ZFIFw4vYc2Y4UF/aq4Qg/4NTvg
         VxZC3Maa8rCSHUlxacXqOox0a0IzWSqLVZ3Rlae40+noILOzkGc6RbhSFPx28jc1tR6c
         WSN0POmri+OVU6QHjPpnnznjuuP0cdSA7An+6ssibQjsUspMUpRqB0FMJNdg/JClvtZC
         1qcw==
X-Gm-Message-State: AOJu0YwBDXeFEKamnT/SJZfs0r2Hrbp9JKC6vrShhOIUHxteEega9kKp
	DlJLaGdtby+e9BZn5BED0Dw6G2dJwSBqmDYRVAubeefaa9/8sMyLCZRDiv/SdKg=
X-Google-Smtp-Source: AGHT+IFXb8fjdiT2Xm8fHTulYHtR/9V8Hu00cB5x/SrdKXxXpuY0B5+19YogSEqixXuNd9H14u5oDg==
X-Received: by 2002:a05:600c:4746:b0:426:63b8:2cce with SMTP id 5b1f17b1804b1-429ed77dc4dmr47476475e9.7.1723973945445;
        Sun, 18 Aug 2024 02:39:05 -0700 (PDT)
Received: from smtpclient.apple ([84.9.81.215])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ed79d9a7sm70328355e9.39.2024.08.18.02.39.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Aug 2024 02:39:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH 6.6 046/139] selftests/net: fix uninitialized variables
From: Ignat Korchagin <ignat@cloudflare.com>
In-Reply-To: <20240709110659.948165869@linuxfoundation.org>
Date: Thu, 11 Jul 2024 16:31:45 +0100
Cc: stable@vger.kernel.org,
 patches@lists.linux.dev,
 John Hubbard <jhubbard@nvidia.com>,
 Willem de Bruijn <willemb@google.com>,
 Mat Martineau <martineau@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Sasha Levin <sashal@kernel.org>,
 kernel-team@cloudflare.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <8B1717DB-8C4A-47EE-B28C-170B630C4639@cloudflare.com>
References: <20240709110658.146853929@linuxfoundation.org>
 <20240709110659.948165869@linuxfoundation.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3776.700.51)

Hi,
> On 9 Jul 2024, at 12:09, Greg Kroah-Hartman =
<gregkh@linuxfoundation.org> wrote:
>=20
> 6.6-stable review patch.  If anyone has any objections, please let me =
know.
>=20
> ------------------
>=20
> From: John Hubbard <jhubbard@nvidia.com>
>=20
> [ Upstream commit eb709b5f6536636dfb87b85ded0b2af9bb6cd9e6 ]
>=20
> When building with clang, via:
>=20
>    make LLVM=3D1 -C tools/testing/selftest
>=20
> ...clang warns about three variables that are not initialized in all
> cases:
>=20
> 1) The opt_ipproto_off variable is used uninitialized if "testname" is
> not "ip". Willem de Bruijn pointed out that this is an actual bug, and
> suggested the fix that I'm using here (thanks!).
>=20
> 2) The addr_len is used uninitialized, but only in the assert case,
>   which bails out, so this is harmless.
>=20
> 3) The family variable in add_listener() is only used uninitialized in
>   the error case (neither IPv4 nor IPv6 is specified), so it's also
>   harmless.
>=20
> Fix by initializing each variable.
>=20
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Acked-by: Mat Martineau <martineau@kernel.org>
> Link: =
https://lore.kernel.org/r/20240506190204.28497-1-jhubbard@nvidia.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
> tools/testing/selftests/net/gro.c                 | 3 +++
> tools/testing/selftests/net/ip_local_port_range.c | 2 +-
> tools/testing/selftests/net/mptcp/pm_nl_ctl.c     | 2 +-
> 3 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/tools/testing/selftests/net/gro.c =
b/tools/testing/selftests/net/gro.c
> index 30024d0ed3739..b204df4f33322 100644
> --- a/tools/testing/selftests/net/gro.c
> +++ b/tools/testing/selftests/net/gro.c
> @@ -113,6 +113,9 @@ static void setup_sock_filter(int fd)
> next_off =3D offsetof(struct ipv6hdr, nexthdr);
> ipproto_off =3D ETH_HLEN + next_off;
>=20
> + /* Overridden later if exthdrs are used: */
> + opt_ipproto_off =3D ipproto_off;
> +

This breaks selftest compilation on 6.6, because opt_ipproto_off is not
defined in the first place in 6.6

> if (strcmp(testname, "ip") =3D=3D 0) {
> if (proto =3D=3D PF_INET)
> optlen =3D sizeof(struct ip_timestamp);
> diff --git a/tools/testing/selftests/net/ip_local_port_range.c =
b/tools/testing/selftests/net/ip_local_port_range.c
> index 75e3fdacdf735..2465ff5bb3a8e 100644
> --- a/tools/testing/selftests/net/ip_local_port_range.c
> +++ b/tools/testing/selftests/net/ip_local_port_range.c
> @@ -343,7 +343,7 @@ TEST_F(ip_local_port_range, late_bind)
> struct sockaddr_in v4;
> struct sockaddr_in6 v6;
> } addr;
> - socklen_t addr_len;
> + socklen_t addr_len =3D 0;
> const int one =3D 1;
> int fd, err;
> __u32 range;
> diff --git a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c =
b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> index 49369c4a5f261..763402dd17742 100644
> --- a/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> +++ b/tools/testing/selftests/net/mptcp/pm_nl_ctl.c
> @@ -1239,7 +1239,7 @@ int add_listener(int argc, char *argv[])
> struct sockaddr_storage addr;
> struct sockaddr_in6 *a6;
> struct sockaddr_in *a4;
> - u_int16_t family;
> + u_int16_t family =3D AF_UNSPEC;
> int enable =3D 1;
> int sock;
> int err;
> --=20
> 2.43.0
>=20

Ignat


