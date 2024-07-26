Return-Path: <stable+bounces-61831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F393CED2
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 09:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C563F1C217E3
	for <lists+stable@lfdr.de>; Fri, 26 Jul 2024 07:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B9F17623E;
	Fri, 26 Jul 2024 07:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="x/NiMpts"
X-Original-To: stable@vger.kernel.org
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A159175570;
	Fri, 26 Jul 2024 07:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721978738; cv=none; b=m/ouTBlZY61JapwfuNcc+LSAgQ/KbpxALi3B6NY9OZs+F1IGfHHw0+7bSgP0T9s/n26wUpIKpDz8WiqCCtmHqBHzUZTu0nJDTUzAaElx3f4/4HuIoSYS2uqidNyw3k2fk8nsM2SWnbU+U4lwHANekjgIIoEpJfublfU7HS6/49c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721978738; c=relaxed/simple;
	bh=2chJYvRP+8+f9KuL68diOk2F/ADBS8HJYKbGAf5uXKM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=lDsHmqXVFyhvWKR9mt0HzZex5wapHJHrTgaDk1/YWteEIVU92dl88+3aqO/Oz4v+VrhWQbCGqnZuGJvfJb+WGJfvBRgbkotrjoDj+taM5O+2Yt6dH0AAmpMT8B9TkYWED9+vftZ5xV4A4uFEWBEU3+f1CL1BVdbCrdZYXs4B3rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=x/NiMpts; arc=none smtp.client-ip=185.70.40.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1721978728; x=1722237928;
	bh=7EHBeSctJfRaCXRzEB8omHaT6kFi5fQzZHGUvWENIEs=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=x/NiMptsiDiZt6XNMGDQUSSI8qa6Q/hK042w8sltVxsoklr/kc6L8LbmEU+pws0zE
	 i46A708TthqmWGuH81pF0Mepsr00Eb8/LnUDpPlVD4m4ZuxJ/gv2IMMzurjJ34nLbF
	 aFdNCiGCfLPd7A/dhU3XzUxEgI3odlh6Z7ypEtCFeNIYWB9We9hefLvp94mYmDkA+U
	 ruvCcYCMj4UP7uvDN15IN3YWefUsgbBulh5iLFpoRwkZVYJMZtbtd6VN9CrNBzJuwo
	 ICqn8kDv29B1bafZ4+/tz1nGLc2boxeIreBUL8cIEPW+BsHcaAayJWhgk0tV21fjSW
	 VIOZlRYbkhUww==
Date: Fri, 26 Jul 2024 07:25:21 +0000
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Jari Ruusu <jariruusu@protonmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10 00/59] 5.10.223-rc1 review
Message-ID: <veJcp8NcM5qwkB_p0qsjQCFvZR5U4SqezKKMnUgM-khGFC4sCcvkodk-beWQ2a4qd3IxUYaLdGp9_GBwf3FLvkoU8f1MXjSk3gCsQOKnXZw=@protonmail.com>
Feedback-ID: 22639318:user:proton
X-Pm-Message-ID: b9f24cc3b1d8734e160a8521738b6d029ee8f775
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Some older systems still compile kernels with old gcc version.

$ grep -B3 "^GNU C" linux-5.10.223-rc1/Documentation/Changes=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
        Program        Minimal version       Command to check the version
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
GNU C                  4.9              gcc --version

These warnings and errors show up when compiling with gcc 4.9.2

  UPD     include/config/kernel.release
  UPD     include/generated/uapi/linux/version.h
  UPD     include/generated/utsrelease.h
  CC      scripts/mod/empty.o
In file included from ././include/linux/compiler_types.h:65:0,
                 from <command-line>:0:
./include/linux/compiler_attributes.h:29:29: warning: "__GCC4_has_attribute=
___uninitialized__" is not defined [-Wundef]
 # define __has_attribute(x) __GCC4_has_attribute_##x
                             ^
./include/linux/compiler_attributes.h:278:5: note: in expansion of macro '_=
_has_attribute'
 #if __has_attribute(__uninitialized__)
     ^
[SNIP]
  AR      arch/x86/events/built-in.a
  CC      arch/x86/kvm/../../../virt/kvm/kvm_main.o
In file included from ././include/linux/compiler_types.h:65:0,
                 from <command-line>:0:
./include/linux/compiler_attributes.h:29:29: error: "__GCC4_has_attribute__=
_uninitialized__" is not defined [-Werror=3Dundef]
 # define __has_attribute(x) __GCC4_has_attribute_##x
                             ^
./include/linux/compiler_attributes.h:278:5: note: in expansion of macro '_=
_has_attribute'
 #if __has_attribute(__uninitialized__)
     ^
cc1: all warnings being treated as errors
make[2]: *** [scripts/Makefile.build:286: arch/x86/kvm/../../../virt/kvm/kv=
m_main.o] Error 1
make[1]: *** [scripts/Makefile.build:503: arch/x86/kvm] Error 2
make: *** [Makefile:1832: arch/x86] Error 2

Following patch fixes this. Upstream won't need this because
newer kernels are not compilable with gcc 4.9

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

Fixes: upstream fd7eea27a3ae "Compiler Attributes: Add __uninitialized macr=
o"
Signed-off-by: Jari Ruusu <jariruusu@protonmail.com>

--
Jari Ruusu=C2=A0 4096R/8132F189 12D6 4C3A DCDA 0AA4 27BD=C2=A0 ACDF F073 3C=
80 8132 F189


