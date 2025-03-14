Return-Path: <stable+bounces-124751-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5679A661E3
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 23:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D775C189B4BF
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 22:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B798204C31;
	Mon, 17 Mar 2025 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="f4+s6LOG"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C967204851
	for <stable@vger.kernel.org>; Mon, 17 Mar 2025 22:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251338; cv=none; b=fe6Jar1C0cT/klsHw1XX7ki+iqV0gnAx9rBRTfOiPzAEzdHP2WKxXHrMOPlXKRAcXHIBLjk+vquY4ujHnIchX2ElxKHjdemhvcsHS9fUfhdo3bcESWMZOT68xpsSKBUZMZR0ucrim6A+TN+R4LlSfUh5VKn8TctNhVa2ZwpORAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251338; c=relaxed/simple;
	bh=o6y+XyffX9wmjk0Np+rMurFlpcoCW1araA3fSvob6fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=BxewPqaoDBAXb3rPJSACfICJTwRZMffcINHMjAtbroC7jubjSymgK0cA5R/dY8m4lLIyRn0GtUewSnvdHC5gkrpWo+r3CgkEpIdXr78+c3nOSCOhulkeI/98AMVLmanQGuclRKgXdV0gwkKrEZOfBkKyb0e5TmDfkhPDZWTHNHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=f4+s6LOG; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1742251335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KXBti98LcS5GzDZjVFDN2KRvwCsazYpAUZPSb/VmakA=;
	b=f4+s6LOGi3PFbiPFmjv9qXQ+8S7WErahm2cIoroAi6Ig1IKldfPyd6AsIuS4Xo/hU5szea
	mB/lbd0nMHAPJexzHaMmyLnmAcjDNynH0WI4kuT+51nXT5SontYfE/GigNLBOLQ+e7WY2u
	vopuM0/kadgDTKURDDZnHr8AKNNqd4Q=
Received: from g7t16454g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.143]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-GE-CncSxPaS36qHP86rU4w-1; Mon, 17 Mar 2025 18:42:13 -0400
X-MC-Unique: GE-CncSxPaS36qHP86rU4w-1
X-Mimecast-MFC-AGG-ID: GE-CncSxPaS36qHP86rU4w_1742251332
Received: from g8t13021g.inc.hpicorp.net (g8t13021g.inc.hpicorp.net [15.60.27.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by g7t16454g.inc.hp.com (Postfix) with ESMTPS id 2815060001E3;
	Mon, 17 Mar 2025 22:42:11 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g8t13021g.inc.hpicorp.net (Postfix) with ESMTP id E2BD56000E9D;
	Mon, 17 Mar 2025 22:42:02 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: masahiroy@kernel.org,
	nathan@kernel.org,
	linux-kbuild@vger.kernel.org
Cc: nicolas@fjasle.eu,
	linux-kernel@vger.kernel.org,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] kbuild: deb-pkg: don't set KBUILD_BUILD_VERSION unconditionally
Date: Fri, 14 Mar 2025 13:10:53 +0000
Message-ID: <20250314131053.23360-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: la5LG7jKjWL9P5eFTdU0PUkWzyhx3VrVBvkyfaBJYqs_1742251332
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

In ThinPro, we use the convention <upstream_ver>+hp<patchlevel> for
the kernel package. This does not have a dash in the name or version.
This is built by editing ".version" before a build, and setting
EXTRAVERSION=3D"+hp" and KDEB_PKGVERSION make variables:

    echo 68 > .version
    make -j<n> EXTRAVERSION=3D"+hp" bindeb-pkg KDEB_PKGVERSION=3D6.12.2+hp6=
9

    .deb name: linux-image-6.12.2+hp_6.12.2+hp69_amd64.deb

Since commit 7d4f07d5cb71 ("kbuild: deb-pkg: squash
scripts/package/deb-build-option to debian/rules"), this no longer
works. The deb build logic changed, even though, the commit message
implies that the logic should be unmodified.

Before, KBUILD_BUILD_VERSION was not set if the KDEB_PKGVERSION did
not contain a dash. After the change KBUILD_BUILD_VERSION is always
set to KDEB_PKGVERSION. Since this determines UTS_VERSION,the uname
output to look off:

    (now)      uname -a: version 6.12.2+hp ... #6.12.2+hp69
    (expected) uname -a: version 6.12.2+hp ... #69

Update the debian/rules logic to restore the original behavior.

Cc: <stable@vger.kernel.org>
Fixes: 7d4f07d5cb71 ("kbuild: deb-pkg: squash scripts/package/deb-build-opt=
ion to debian/rules")
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
---
Changes since v1:
 * Rework logic so that dpkg-parsechangelog is invoked just once
 * Adjust commit message to reflect review feedback

 scripts/package/debian/rules | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/package/debian/rules b/scripts/package/debian/rules
index ca07243bd5cd..d1f400685682 100755
--- a/scripts/package/debian/rules
+++ b/scripts/package/debian/rules
@@ -21,9 +21,11 @@ ifeq ($(origin KBUILD_VERBOSE),undefined)
     endif
 endif
=20
-revision =3D $(lastword $(subst -, ,$(shell dpkg-parsechangelog -S Version=
)))
+revision =3D $(shell dpkg-parsechangelog -S Version | sed -n 's/.*-//p')
 CROSS_COMPILE ?=3D $(filter-out $(DEB_BUILD_GNU_TYPE)-, $(DEB_HOST_GNU_TYP=
E)-)
-make-opts =3D ARCH=3D$(ARCH) KERNELRELEASE=3D$(KERNELRELEASE) KBUILD_BUILD=
_VERSION=3D$(revision) $(addprefix CROSS_COMPILE=3D,$(CROSS_COMPILE))
+make-opts =3D ARCH=3D$(ARCH) KERNELRELEASE=3D$(KERNELRELEASE) $(addprefix =
\
+=09=09KBUILD_BUILD_VERSION=3D,$(revision)) $(addprefix \
+=09=09CROSS_COMPILE=3D,$(CROSS_COMPILE))
=20
 binary-targets :=3D $(addprefix binary-, image image-dbg headers libc-dev)
=20
--=20
2.48.1


