Return-Path: <stable+bounces-61858-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F14793D0C2
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 12:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977172817E8
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 10:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BC3176FB3;
	Fri, 26 Jul 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="W7LD1c2M"
X-Original-To: stable@vger.kernel.org
Received: from mail-41103.protonmail.ch (mail-41103.protonmail.ch [185.70.41.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685E91791FC;
	Fri, 26 Jul 2024 10:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.41.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721988032; cv=none; b=ZiDOdsJ2lhx++mlJBwAQqPlfYIoZ4TtPRQn2tHR1WczEy3LDrynX7SbqE6S6Ehi4zY8c3RAQP1ES4H6nYx9Jy//S5pX1681ujsNiB1M3mtr7ea9gzjcZkCrfvrddRd8VuGjgB+8xSUaYBgEYGnZl66I/c1IRv3AtO/gkExvGnwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721988032; c=relaxed/simple;
	bh=Zv4Leq0T7FGOM8/WXnsnpx9DOwRXxIaEyU0CCxFi5Ec=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lw4QVmmNjD6PRr73r+5aD8+1YBV4w5s2Qv/ihnLk0jFFKgngJfTZ9wL2tJrYetyGgoZogKpKxqbjDRNeNXyx/XmSMkGH0oJp+5YpYSxx2FdJDatX/BMvxDIAdrv/v5u2ft78+o4AGR2uKrmL9hjzJQhIzyNoLZfKW1DuyTbnYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=W7LD1c2M; arc=none smtp.client-ip=185.70.41.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721987603; x=1722246803;
	bh=6fHDk1Jf/Gu/4lIQo3Dpo5b6YMyN4d2taB500tn0Ezc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=W7LD1c2MN31wpsLwwZArZR4HNymFEpThuL/urUZOQiQGdvamyJaV3dsunEXZCF56o
	 1XAQQPbZ/PbYK1hBX5lWB43B3z8B5oeqf9m+N+IcaI0IY6EKsOIkG02WKMshy1Q6XL
	 4BrnKhmpP1R28ZShQ+ZGGTOdhRBu7pkthX/+RzLx4fcDaynokL9XoEdBPva0Ss+iwl
	 KKHQS3nAaoKT7kHEqNOS+owJCjhB2sVHnFWm/VcxMYBMqOl7gtIM+UMErjCVVvQB3q
	 36rR4cm6H0qNVzWkBJvk6ccT5npx9N3+4wHFfqLNSUmqGu0RxwRHmSyPfBVYY1T4Go
	 izcVmbYUYIvPQ==
Date: Fri, 26 Jul 2024 09:53:18 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <93RnVgeI76u-tf0ZRdROl_JVVqqx-rtQnV4mOqGR_Rb5OmiWCMXC6MSYfnkTPp_615nKq8H-5nfzNt4I9MXPjUPzXBLp625jtGUJSGPsGBo=@protonmail.com>
In-Reply-To: <2024072635-dose-ferment-53c8@gregkh>
References: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com> <2024072633-easel-erasure-18fa@gregkh> <vp205FIjWV7QqFTJ2-8mUjk6Y8nw6_9naNa31Puw1AvHK8EinlyR9vPiJdEtUgk0Aqz9xuMd62uJLq0F1ANI5OGyjiYOs3vxd0aFXtnGnJ4=@protonmail.com> <2024072635-dose-ferment-53c8@gregkh>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: 331e4a19654de68e489b009bca69bf613be00d04
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, July 26th, 2024 at 11:52, Greg Kroah-Hartman <gregkh@linuxfounda=
tion.org> wrote:
> Also the "Fixes:" tag is not in the correct format, please fix that up
> at the very least.

Some older systems still compile kernels with old gcc version.
These warnings and errors show up when compiling with gcc 4.9.2

 error: "__GCC4_has_attribute___uninitialized__" is not defined [-Werror=3D=
undef]

Following patch fixes this. Upstream won't need this because =20
newer kernels are not compilable with gcc 4.9.

Subject: gcc-4.9 warning/error fix for 5.10.223-rc1
Fixes: fd7eea27a3ae ("Compiler Attributes: Add __uninitialized macro")
Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>

--- ./include/linux/compiler_attributes.h.OLD
+++ ./include/linux/compiler_attributes.h
@@ -37,6 +37,7 @@
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >=3D=
 8)
 # define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >=
=3D 9)
+# define __GCC4_has_attribute___uninitialized__       0
 # define __GCC4_has_attribute___fallthrough__         0
 # define __GCC4_has_attribute___warning__             1
 #endif

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


