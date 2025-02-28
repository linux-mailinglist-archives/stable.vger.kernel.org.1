Return-Path: <stable+bounces-119940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD2AA49A05
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 13:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A90223AAA4A
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2CE26B2DE;
	Fri, 28 Feb 2025 12:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b="kL/a3MSc"
X-Original-To: stable@vger.kernel.org
Received: from office2.cesnet.cz (office2.cesnet.cz [78.128.248.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023726A1CB
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 12:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.128.248.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740747352; cv=none; b=ANydmWKOud41CrWiJAmINA3Swd/jE47tQ13VVo4R55UVMNwZGaNP+PaIA6vmnKlhGkWJzKwbgKz1Bc5L32Om2t0D++JkDrEcf3E4h9LV4xL+lJYbmcT0lziMUf+atZPVC5jaNrQWeOJARqdNIXrwh0DwjQJkdYrW7ityaBIXfS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740747352; c=relaxed/simple;
	bh=67gmGWIPpwstbEvKdRbH3D2kk2amRXjsUltSK8rZS6I=;
	h=From:To:Cc:Subject:Date:MIME-Version:Message-ID:Content-Type; b=I+K+4EgbpPHpxbGdR5pvfvFysowF1mVxxm2OvTh4djUvEthws0Jmxq4CSUxfzCoTN3Dp6UCnwaJszQJhP7zWno1P/161Pq30O/CL0TcqRsopq54RJZo76K0EZuraEgjxwTLNhZIXIyC4Xp8T+teOqSsrw7XvWXHhmgKjr3WecFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz; spf=pass smtp.mailfrom=cesnet.cz; dkim=pass (2048-bit key) header.d=cesnet.cz header.i=@cesnet.cz header.b=kL/a3MSc; arc=none smtp.client-ip=78.128.248.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cesnet.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cesnet.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cesnet.cz;
	s=office2-2020; t=1740747012;
	bh=flrAuVSHz0GkE/bDTmZHCVGLALiva4unYMMXQExACsE=;
	h=From:To:Cc:Subject:Date;
	b=kL/a3MScJpUEPy69+Y6WeTRf5sxIk8cLOa+KjhufIIkgNcnrUsW6Ko8LsjLCc5GsD
	 Fb9sTu9dk6U19f82btv2XO3RzMIN/twDNuVxx0oRiODNqKxYSSWoeN+fg0i5Ie3R9k
	 bStoF84oaJnOu47tD5A+DJygp1IiDaaZwTuNpQCIcpjJ+nyqweQhRHS7PSCveeQB0Y
	 ozSse9yLBwxSEPW3r48uUoaBqruTy6hAG6sB2M9zeEpQ7OxQDrAeTd2NS1wLgv2SFg
	 U5rBto0Hq4PmYCJObtMjmSShPpWlv7/hGBL+JEz6ntW/f6p6RTaNLs4Qy25GYPCnWo
	 Un6xGlzDqJFzA==
Received: from localhost (unknown [IPv6:2a07:b241:1002:700:921c:ed49:e10b:7c56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by office2.cesnet.cz (Postfix) with ESMTPSA id 07ACE1180080;
	Fri, 28 Feb 2025 13:50:11 +0100 (CET)
From: =?iso-8859-1?Q?Jan_Kundr=E1t?= <jan.kundrat@cesnet.cz>
To: Tomas Glozar <tglozar@redhat.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <stable@vger.kernel.org>
Subject: v6.6.78 regression: =?iso-8859-1?Q?rtla/timerlat=5Ftop:_Set_OSNOISE=5FWORKLOAD_for_kernel_thr?=
 =?iso-8859-1?Q?eads?=
Date: Fri, 28 Feb 2025 13:50:10 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <98eaf5f0-3a3b-46e0-87a1-33fda0e754cc@cesnet.cz>
Organization: CESNET
User-Agent: Trojita/unstable-2022-08-22; Qt/5.15.15; wayland; Linux; 
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable

Hi there,
I cannot build the `rtla` tool in the stable branch, version v6.6.80. The=20
root cause appears to be commit 41955b6c268154f81e34f9b61cf8156eec0730c0=20
which first appeared in v6.6.78. Here's how the build failure looks like=20
through Buildroot:

 src/timerlat_hist.c: In function =C3=A2=E2=82=AC=C2=98timerlat_hist_apply_co=
nfig=C3=A2=E2=82=AC=E2=84=A2:
 src/timerlat_hist.c:908:60: error: =C3=A2=E2=82=AC=C2=98struct timerlat_hist=
_params=C3=A2=E2=82=AC=E2=84=A2 has=20
no member named =C3=A2=E2=82=AC=C2=98kernel_workload=C3=A2=E2=82=AC=E2=84=A2
  908 |         retval =3D osnoise_set_workload(tool->context,=20
params->kernel_workload);
      |                                                            ^~
 make[3]: *** [<builtin>: src/timerlat_hist.o] Error 1

A quick grep shows that that symbol is referenced, but not defined=20
anywhere:

 ~/work/prog/linux-kernel[cesnet/2025-02-28] $ git grep kernel_workload
 tools/tracing/rtla/src/timerlat_hist.c: retval =3D=20
osnoise_set_workload(tool->context, params->kernel_workload);
 tools/tracing/rtla/src/timerlat_top.c:  retval =3D=20
osnoise_set_workload(top->context, params->kernel_workload);

Maybe some prerequisite patch is missing?

With kind regards,
Jan

