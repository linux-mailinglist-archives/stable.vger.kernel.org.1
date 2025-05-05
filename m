Return-Path: <stable+bounces-140431-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E125AAA8AA
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 02:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20B61886E0B
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 00:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64496351E75;
	Mon,  5 May 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpVH7Co0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C484351E6D;
	Mon,  5 May 2025 22:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484839; cv=none; b=KPFLuPdCvKG3bFrfLbmdA1G0VXIMy+VfqYj/SpsLYzhNGcrA7IwlYnB7C9lA6fH0Lirb5ChQCaxedZO1VudPyflND9OGcoH6p9Hw4C8QCVhF7neOINOdgg+dqKU493NYiamUG40CxbFYMGKh08qRmgOz8ILKjOhA/g5uNPotEvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484839; c=relaxed/simple;
	bh=1PrNHOHhuibT+vTnw7e2eIyUZGNoXebaMpOR501bUac=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZhyXsbYPHssIqeOPHV6PvBaEIRBpJARateZeUPgWaA6hePtYSOnUkbkXPWgrKXTgcOvlW55sHOMmmjq5fP+JiJBjGoD1dnzYJYFeZJrqi4kpAl27/yZsGgwA/TIBLnpBvnVd/eFgDgpF5Qaa86Y8YBzQohq3dJDAocVv9FoJ2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpVH7Co0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D23BC4CEED;
	Mon,  5 May 2025 22:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484838;
	bh=1PrNHOHhuibT+vTnw7e2eIyUZGNoXebaMpOR501bUac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hpVH7Co0DK1B3qyl2h+10k5YOjoKat2htSvkhWxWYH86gO8ti+LJ69JBUFiGG+Nag
	 BIC/wCW1VRy8pgor+aOAY63Hcp8aa0a0YCrk/tVI2F20zFdhAez+lqa+1UdaOCVLC0
	 Z4eFklltI5VpB5fSOhqXexsL5Z9yB5ZmdwjfmJ95GDteT6YVcIFTBZukrgDEDc+52I
	 AOsCFmHlVELx/bvZRq2rJ+1X9HiVspDvfyJFkrVy9DQC0PdOBN2ZE/fe/IBHq0ShYN
	 NT7SUafWTDMH0UVp1oEJZexBAz3sj3axFmn5JjmcghRRHS5vPKSXEDgZPnHpHHIiYq
	 32DZ2uaU7NcJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pedro Nishiyama <nishiyama.pedro@gmail.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 040/486] Bluetooth: Disable SCO support if READ_VOICE_SETTING is unsupported/broken
Date: Mon,  5 May 2025 18:31:56 -0400
Message-Id: <20250505223922.2682012-40-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Pedro Nishiyama <nishiyama.pedro@gmail.com>

[ Upstream commit 14d17c78a4b1660c443bae9d38c814edea506f62 ]

A SCO connection without the proper voice_setting can cause
the controller to lock up.

Signed-off-by: Pedro Nishiyama <nishiyama.pedro@gmail.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bluetooth/hci_event.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 96ad1b75d1c4d..97868d353219d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -932,6 +932,9 @@ static u8 hci_cc_read_buffer_size(struct hci_dev *hdev, void *data,
 		hdev->sco_pkts = 8;
 	}
 
+	if (!read_voice_setting_capable(hdev))
+		hdev->sco_pkts = 0;
+
 	hdev->acl_cnt = hdev->acl_pkts;
 	hdev->sco_cnt = hdev->sco_pkts;
 
-- 
2.39.5


