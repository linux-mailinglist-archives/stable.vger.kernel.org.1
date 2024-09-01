Return-Path: <stable+bounces-72229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FB29679C7
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 18:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA020280C9F
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 16:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3714518454C;
	Sun,  1 Sep 2024 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TgpgZe3T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0318453F;
	Sun,  1 Sep 2024 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209256; cv=none; b=rNsfbsY7LxxqHrYyC6/7LJiEiW2QsiCbdeGS6qJzaDYWfmfvS9+jcYo9PSW/nKPFbRfh78bvfEufdsPf++xMC6qK83hTu9ZRbmZ5WVwweeFWg8pSzIactaAgNf+yQ/+9XrowkXmUzKjiKaoor2ebWimtClOL0fVF0bCPw0GaLeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209256; c=relaxed/simple;
	bh=nvj9Foac1CGdiRAshlDaUZ7ovmzWlOn7vIW+mP7Mbec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Co/+H8/QUUw7rLeQKxmnjlxc4vYcmigZy+x1rwYy1JvxMxwSSNtZJlHT2UHiLDMihYUtLUZIIcS0idqAldpuKxgsRmrgLl6jej9uTZ9LJ1CZEwBJd0I/Vj0XRoPSgbm1r8w1p17VYhVZMHVi/zW63KLgwxZc2f4Wh+ZpoUDFrDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TgpgZe3T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DC7C4CEC3;
	Sun,  1 Sep 2024 16:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725209255;
	bh=nvj9Foac1CGdiRAshlDaUZ7ovmzWlOn7vIW+mP7Mbec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TgpgZe3THyGl7LJ5mK3zzHdtRDyYJPks3uU4stbmhp+Z26eNXrm9JHPzWy6E/7OVr
	 /s+LR+Nq/r5BROMzJ1cwPEdrflArALWs/Sc4KXYlahSoxZOwGcQB7vYNG/nO15PsF0
	 uYDXvYAY7fV8qidFCANjZElq0LS654AfmxLuKEIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Machata <petrm@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 48/71] selftests: forwarding: no_forwarding: Down ports on cleanup
Date: Sun,  1 Sep 2024 18:17:53 +0200
Message-ID: <20240901160803.704421092@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240901160801.879647959@linuxfoundation.org>
References: <20240901160801.879647959@linuxfoundation.org>
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

From: Petr Machata <petrm@nvidia.com>

[ Upstream commit e8497d6951ee8541d73784f9aac9942a7f239980 ]

This test neglects to put ports down on cleanup. Fix it.

Fixes: 476a4f05d9b8 ("selftests: forwarding: add a no_forwarding.sh test")
Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/0baf91dc24b95ae0cadfdf5db05b74888e6a228a.1724430120.git.petrm@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/net/forwarding/no_forwarding.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/net/forwarding/no_forwarding.sh b/tools/testing/selftests/net/forwarding/no_forwarding.sh
index af3b398d13f01..9e677aa64a06a 100755
--- a/tools/testing/selftests/net/forwarding/no_forwarding.sh
+++ b/tools/testing/selftests/net/forwarding/no_forwarding.sh
@@ -233,6 +233,9 @@ cleanup()
 {
 	pre_cleanup
 
+	ip link set dev $swp2 down
+	ip link set dev $swp1 down
+
 	h2_destroy
 	h1_destroy
 
-- 
2.43.0




