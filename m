Return-Path: <stable+bounces-56878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1570924682
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 19:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E34BF1C212A5
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 17:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0998B1C2308;
	Tue,  2 Jul 2024 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jRjUOzhr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD09F17B416;
	Tue,  2 Jul 2024 17:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719941665; cv=none; b=RH6AznbTd9728Dk570V3i31H7mfKTvIN5PnmvDEW2CBP5+G58iY3afHCYk9m4Ey4LGSSdeVaEYU3dY7bW3GZmAlPO8jp+bzO5fXpx89n/Rcct2n5ssjbGdP21tlZBqMlvTtTw5qN5A5f85LWANXgsjnXlGpuDM5bNPt1kpjXn/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719941665; c=relaxed/simple;
	bh=hDHkhF4jN3MoqcsQhsxarLiee5HE6BYBouQtSwLXFJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdEPo3veK/lcgotoRJhOxpH3SDZxqLMoMYlAcfQiwLdkDtJWKZHdqHGBMFuPPgz7lLVfvKyUUuM6DuNw0D0hBZgHEdr1q/qn07x6q+cWY/w92zbOO77tbey/qW1GdTqFNzahx1UyvGTsT1Tw6PcnonS7dvaURTU9+ddfYbc3VTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jRjUOzhr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F5BC116B1;
	Tue,  2 Jul 2024 17:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719941665;
	bh=hDHkhF4jN3MoqcsQhsxarLiee5HE6BYBouQtSwLXFJ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jRjUOzhrJZwiPoUrlWkQHQ+pNmOlpE+hyy47qURwfy5x8Hin34frk02l88cfLcm0A
	 ghTCBmO2eTD/H5dxAT1QQkVAM0YaffLbJnIrSviyMHjfu0GF03sWHtRtIK7K5IRBL2
	 Z4tbK/1Hvc+UxuxBtG2SN77QVzKMCL804ZFsR0zg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Diederik de Haas <didi.debian@cknow.org>,
	Dragan Simic <dsimic@manjaro.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 6.1 100/128] kbuild: Install dtb files as 0644 in Makefile.dtbinst
Date: Tue,  2 Jul 2024 19:05:01 +0200
Message-ID: <20240702170230.004404408@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702170226.231899085@linuxfoundation.org>
References: <20240702170226.231899085@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dragan Simic <dsimic@manjaro.org>

commit 9cc5f3bf63aa98bd7cc7ce8a8599077fde13283e upstream.

The compiled dtb files aren't executable, so install them with 0644 as their
permission mode, instead of defaulting to 0755 for the permission mode and
installing them with the executable bits set.

Some Linux distributions, including Debian, [1][2][3] already include fixes
in their kernel package build recipes to change the dtb file permissions to
0644 in their kernel packages.  These changes, when additionally propagated
into the long-term kernel versions, will allow such distributions to remove
their downstream fixes.

[1] https://salsa.debian.org/kernel-team/linux/-/merge_requests/642
[2] https://salsa.debian.org/kernel-team/linux/-/merge_requests/749
[3] https://salsa.debian.org/kernel-team/linux/-/blob/debian/6.8.12-1/debian/rules.real#L193

Cc: Diederik de Haas <didi.debian@cknow.org>
Cc: <stable@vger.kernel.org>
Fixes: aefd80307a05 ("kbuild: refactor Makefile.dtbinst more")
Signed-off-by: Dragan Simic <dsimic@manjaro.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 scripts/Makefile.dtbinst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/scripts/Makefile.dtbinst
+++ b/scripts/Makefile.dtbinst
@@ -24,7 +24,7 @@ __dtbs_install: $(dtbs) $(subdirs)
 	@:
 
 quiet_cmd_dtb_install = INSTALL $@
-      cmd_dtb_install = install -D $< $@
+      cmd_dtb_install = install -D -m 0644 $< $@
 
 $(dst)/%.dtb: $(obj)/%.dtb
 	$(call cmd,dtb_install)



