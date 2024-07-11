Return-Path: <stable+bounces-59136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D97B92EBBE
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 17:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8C3DB20B87
	for <lists+stable@lfdr.de>; Thu, 11 Jul 2024 15:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBABA328DB;
	Thu, 11 Jul 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dryBYtOG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1B14A9D
	for <stable@vger.kernel.org>; Thu, 11 Jul 2024 15:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720711921; cv=none; b=jbvSEr2BBftVZAa+bAnl+LS4alZSvfla7CEQmSl9ifSYriJH91muA2X1o9ERx5OYtl8cNocYX2SG1PnT41D5Zurkknt9Hhs57Sp4Etf/EsPMUJ9Y9q3bpdEIW74sfUo+tS4RPmSeVI3FTFlUBKzUFpiCMASYB5g/J5Fkt7AqGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720711921; c=relaxed/simple;
	bh=M4nmkyH4QHTg3SbxLSHLMsr/yRq0Mzky4QvzjGSfkhM=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jv3D0MSUYAJIxmvQyQSafcOND34Uk/M6jy7DK2Dpr5qM8MPas26PK8tVFsh1B7RG+sLl7Nn/HXL1man4U3cnGahNIvn+gwk8Gg5EDBTnfW8clwG1c5ut4F5GfdGhGSwF47u9npAWfzfXuUY93L/w7PVMd8v+fLfmwl7FCFSylHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dryBYtOG; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3678f36f154so533702f8f.2
        for <stable@vger.kernel.org>; Thu, 11 Jul 2024 08:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1720711918; x=1721316718; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkgFy/p55P7RIRDwFamIanzv8uC6eQMVCp6t1WqK4Xc=;
        b=dryBYtOGV0pegE3UirP/+N21bGGL0QKjbMsDBceUbEVqfbn8Q6gJ/lxb82eCMNjpMU
         OI7EGJezai1uerQS9lXre8nXwZBa5ycK1RuDKckD9lL8ejxsZDvGojRhiNTfF5WjphIW
         TclQG9KbSsd+oCY7x1+EAevETXMC0aMyctBwm9CL3huLsqC79DKpiQcVg1QzB0snz9QQ
         m7DbEl5frYWlywpUy/BBKD5qVGSqGgQcucfH5oijeKEstA34hMDNHDxe8bOeeRwi3OaN
         06IqsJ6fP8+uRh/PIc3soOz2Zsav/BasFpQ+c7UrD6LnEpLAqDWXrpWlVsMARvG7XDi1
         a8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720711918; x=1721316718;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkgFy/p55P7RIRDwFamIanzv8uC6eQMVCp6t1WqK4Xc=;
        b=taOj59ANKsxgT9ObbPMNOGLnyJAXAKfOke4oqkNQD5ArT0D+72Rc0DMWANdgTf7q1T
         oFmHOWgMdDFM+ON2lr2gUaX4huXVbHnv930IxFhyCTpCTamZTsMfvU4Pd3b3kzGdmFpc
         s6+juWrYGBc1VQkAgwwFO9lGiAfOD4rNh810SR2o9KVfFSBvKPu+gOvHRCWXthjfQMWe
         AAAnDBQP4JHDDl70hKEOJiJ90gVHwmViwGLerEdzxVVjBCPlkqlFK8eFIpfn8pcY2Qqh
         mX2RkmnJ2NmJC2CejCjsBQMT5BR1qxgiRmzuBr/oq6NN+/OSpWMmZZruHBYh4tc1uQ/s
         dQJQ==
X-Gm-Message-State: AOJu0YzJKrTm/MQjlc2j+xcnl8SfsClbbgFEISS2L22Poo95qCLhes7/
	EAmmOmStSu3iEMQ1hn29J6ZVxhAojAgCkjJA+rFakeEO4CTEasiovzt1GssCUZ4=
X-Google-Smtp-Source: AGHT+IH/QgVm7rk7j08fEbHhm8EIHvMEnO1SEFaNr+NzPKB+Ns5nFIYcWbf7p5j2+CTtD6cVBIAYgQ==
X-Received: by 2002:adf:db52:0:b0:367:905c:823e with SMTP id ffacd0b85a97d-367cea7372amr5457142f8f.24.1720711917946;
        Thu, 11 Jul 2024 08:31:57 -0700 (PDT)
Received: from smtpclient.apple ([2a09:bac5:80cb:ebe::178:16e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfa0672sm8085510f8f.79.2024.07.11.08.31.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jul 2024 08:31:57 -0700 (PDT)
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
X-Mailer: Apple Mail (2.3774.600.62)

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


