Return-Path: <stable+bounces-47645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE08D3A8A
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 17:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AD228279C
	for <lists+stable@lfdr.de>; Wed, 29 May 2024 15:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1F7746E;
	Wed, 29 May 2024 15:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="DUUBcx3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC9917DE09
	for <stable@vger.kernel.org>; Wed, 29 May 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716995865; cv=none; b=C9I/4Ira2eEpgjlthxHdfc7vY5q330gck6ZbMWowJOQKPjfr2NvO6nfF7AhCNYu3EROlHXqhHevF77LgbCr6WxoohdNGb3+FDkbtUUGDQVIExQDQsZ70kPrFVhOV1KmOzQEo/XA0WINZZbJdFgb0KoZb7MEM2mSczD9f9wxuS8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716995865; c=relaxed/simple;
	bh=RW0ddUKdWBOeEE1nQ1DMZ4IQ5b8ZtnX9iYFGP0DhxmU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cOH418i3s0k0vygfla83h2OFXHpinrR/VGCBOBB/DEb4WAnoMEO7spE4FDKl+SW5/J7YcCQXxMj+6jfDypFa6ymsMEaLbJs0Lv+PzakrglJgMTKFp/Z99SuxSkrVci4Z864VLNtbH4jPBkub2a7WG1lrfO6PKTsPTpiRpTBYrNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=DUUBcx3H; arc=none smtp.client-ip=185.125.188.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from localhost.localdomain (2.general.phlin.uk.vpn [10.172.194.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id B9AAE3FEF3;
	Wed, 29 May 2024 15:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1716995862;
	bh=Q49R9b6CUKiqGQvcTTQhnQXlKCvRzTKJQS2oq1OyA0U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=DUUBcx3HvikIoXJb0oOKRxy83MSI/ZjFDI4Ep5g1ERX9BnQN9cGWeOvLkrfLTMMAJ
	 E5Z3eyKWzTmwzhiGWzJw9YCfj+E6yWwHrdTQhAqCqHzsoKLTjEMQXrmkKNNH5grg3t
	 R2V27YlIL4RjNNa4g2qFzHvnVm9amolva+ufwFxGoWRv0TfurdA2Mt4a5uL7lQf+eX
	 2ep0mIiu7AZ3auoMyXscezRTpGX4koF2FM50rRYSwSvQz3Yl9c496mYxbsPN3u9on1
	 KYIB1VvEuh3TQTmT8wnnhsugevsKnLnosxVoua3vl0qBBeLdXx9tE73mj33xIP6DSR
	 y/n1x+ykQSkCg==
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	po-hsu.lin@canonical.com
Subject: [PATCH 6.6.y 2/4] selftests: net: Remove executable bits from library scripts
Date: Wed, 29 May 2024 23:16:01 +0800
Message-Id: <20240529151603.204106-3-po-hsu.lin@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240529151603.204106-1-po-hsu.lin@canonical.com>
References: <20240529151603.204106-1-po-hsu.lin@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Poirier <bpoirier@nvidia.com>

commit 9d851dd4dab63e95c1911a2fa847796d1ec5d58d upstream.

setup_loopback.sh and net_helper.sh are meant to be sourced from other
scripts, not executed directly. Therefore, remove the executable bits from
those files' permissions.

This change is similar to commit 49078c1b80b6 ("selftests: forwarding:
Remove executable bits from lib.sh")

Fixes: 7d1575014a63 ("selftests/net: GRO coalesce test")
Fixes: 3bdd9fd29cb0 ("selftests/net: synchronize udpgro tests' tx and rx connection")
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Benjamin Poirier <bpoirier@nvidia.com>
Link: https://lore.kernel.org/r/20240131140848.360618-4-bpoirier@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Po-Hsu Lin <po-hsu.lin@canonical.com>
---
 tools/testing/selftests/net/net_helper.sh     | 0
 tools/testing/selftests/net/setup_loopback.sh | 0
 2 files changed, 0 insertions(+), 0 deletions(-)
 mode change 100755 => 100644 tools/testing/selftests/net/net_helper.sh
 mode change 100755 => 100644 tools/testing/selftests/net/setup_loopback.sh

diff --git a/tools/testing/selftests/net/net_helper.sh b/tools/testing/selftests/net/net_helper.sh
old mode 100755
new mode 100644
diff --git a/tools/testing/selftests/net/setup_loopback.sh b/tools/testing/selftests/net/setup_loopback.sh
old mode 100755
new mode 100644
-- 
2.7.4


