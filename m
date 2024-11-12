Return-Path: <stable+bounces-92479-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5E09C548B
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D697B385F7
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 10:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD9C2178E4;
	Tue, 12 Nov 2024 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="biL9g32O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3120217672;
	Tue, 12 Nov 2024 10:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731407776; cv=none; b=gCztx2fS9ZewV+b55c98Xq2aGnns3QLiJ3QQYbTu7ASnugoxlBlQDYC2ezjhYwEKtl1tcGicbgk4v9/bRdW9qJEEP2xeXhOjp/osljau4kdAFEZC5m4WUqJ/buqzxYvaJJnT6k5hVRrMjtFS9dL4EkHgzTSiu0/3aQT3JWB+i/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731407776; c=relaxed/simple;
	bh=Epzx8G6BYbngJJ6zR/oP5V9Ou8PfZXAlIi4S4zWQIz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t60WsOL2/V6Bdd0aKo7yjIIxb2/BuPW+Nh/mSK7mgE6YZolL2pYlLHHqB68vDU4Bc2+FwRCFHtmv0SnfgoRQjOOOy/l5Tm/lyy9/Gg2sTpqaUP9SjsG0IEVc1bhQlael429kbFmbjaoQt0cnJZABK95M7hIjrvqg4DNnWNxJdLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=biL9g32O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5291BC4CEDA;
	Tue, 12 Nov 2024 10:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407776;
	bh=Epzx8G6BYbngJJ6zR/oP5V9Ou8PfZXAlIi4S4zWQIz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=biL9g32Ocp8omJ8/pvfj6c8fPNqdPpeueH1iYxdGks4NHQQsimpGExQw36TLQprXQ
	 DHbfY2beJQb3ngXVWvrQxajSAs34wmD4BbGYbX/ZQGTE1s1LQVlzHtpZCBS+aclIgK
	 +bkxz27nASEQewpnxaObix7ipNsuTaU88n4MvYEQtTe+VP/7rwRw8cVNaDWIb8kUSA
	 kHisvUymya+woYBLBXXz5CVZK6izAkx9PwC77SXuvPC/6Avb4Eqq/HlokTcGtLI640
	 9omMwB/9cefgFLCxrt58OFhqkxWs8x9Tuovwx5M2jAgEttKLNCEVTNpM5YMRF1OlFL
	 lUR6f90nMIQTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Renato Caldas <renato@calgera.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	ike.pan@canonical.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 06/16] platform/x86: ideapad-laptop: add missing Ideapad Pro 5 fn keys
Date: Tue, 12 Nov 2024 05:35:48 -0500
Message-ID: <20241112103605.1652910-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit

From: Renato Caldas <renato@calgera.com>

[ Upstream commit 36e66be874a7ea9d28fb9757629899a8449b8748 ]

The scancodes for the Mic Mute and Airplane keys on the Ideapad Pro 5
(14AHP9 at least, probably the other variants too) are different and
were not being picked up by the driver. This adds them to the keymap.

Apart from what is already supported, the remaining fn keys are
unfortunately producing windows-specific key-combos.

Signed-off-by: Renato Caldas <renato@calgera.com>
Link: https://lore.kernel.org/r/20241102183116.30142-1-renato@calgera.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/ideapad-laptop.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/x86/ideapad-laptop.c b/drivers/platform/x86/ideapad-laptop.c
index b58df617d4fda..2fde38f506508 100644
--- a/drivers/platform/x86/ideapad-laptop.c
+++ b/drivers/platform/x86/ideapad-laptop.c
@@ -1159,6 +1159,9 @@ static const struct key_entry ideapad_keymap[] = {
 	{ KE_KEY,	0x27 | IDEAPAD_WMI_KEY, { KEY_HELP } },
 	/* Refresh Rate Toggle */
 	{ KE_KEY,	0x0a | IDEAPAD_WMI_KEY, { KEY_REFRESH_RATE_TOGGLE } },
+	/* Specific to some newer models */
+	{ KE_KEY,	0x3e | IDEAPAD_WMI_KEY, { KEY_MICMUTE } },
+	{ KE_KEY,	0x3f | IDEAPAD_WMI_KEY, { KEY_RFKILL } },
 
 	{ KE_END },
 };
-- 
2.43.0


