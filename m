Return-Path: <stable+bounces-164849-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5968B12DC0
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 06:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E70517B5A8
	for <lists+stable@lfdr.de>; Sun, 27 Jul 2025 04:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0042D199EAD;
	Sun, 27 Jul 2025 04:29:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397DFDF58;
	Sun, 27 Jul 2025 04:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.187.169.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753590547; cv=none; b=NFsPQerSYIXziXnk1ir6rP3fP1qiHF5l8lW+AN99eroJjzME+PnQCRoRvUfzatFBIiQmOYvmTQd2VarpW3yvzahA1YV/Wkt17ZsZ45XrpjvYFYXhxJ41TYVrlWKi6WJmRvvpZzN2pa6KLS24XgWI4TvP+75OB+nlatPkfLTQJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753590547; c=relaxed/simple;
	bh=fU2xMoyWhwe2f0BUvCh9EG5Kj3/nPlAoDJgKfhpTVkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kqzT4ruW3RCPANEVMCPkl8TRalkcBKvvuTtsOMnmiOn/MdmDoVeAYQSuTEnQJwpinOVHtC7PYj/CGm3DmFHZA3f2OIvgopJN2N4+tc8u9ekI8Jf2nzvrykGJ0ts8CLHbiTVH6e3pzqOwsXAg4DFucWINz/wzt48jtxtKouRJ+/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hogyros.de
Received: from localhost.localdomain (unknown [IPv6:2400:2410:b120:f200:2e09:4dff:fe00:2e9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 919C03F108;
	Sun, 27 Jul 2025 06:28:53 +0200 (CEST)
From: Simon Richter <Simon.Richter@hogyros.de>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	1109776@bugs.debian.org
Cc: jeffbai@aosc.io,
	Simon Richter <Simon.Richter@hogyros.de>
Subject: [PATCH 0/1] Mark xe driver as BROKEN until fixed
Date: Sun, 27 Jul 2025 13:27:35 +0900
Message-ID: <20250727042825.8560-1-Simon.Richter@hogyros.de>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

until either of

 - https://patchwork.freedesktop.org/series/150230/

or the (same but rebased)

 - https://patchwork.freedesktop.org/series/151983/

goes in, the xe module will Oops on insmod when kernel page size is not 4kB.
This disables the module for the time being, and should be reverted for fixed
versions.

This should probably also be added to the stable kernel series which will
likely not receive the fix.

Simon Richter (1):
  Mark xe driver as BROKEN if kernel page size is not 4kB

 drivers/gpu/drm/xe/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.47.2


