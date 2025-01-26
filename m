Return-Path: <stable+bounces-110774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DAEA1CC74
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 17:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A023B1C1B
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49BAE23F267;
	Sun, 26 Jan 2025 15:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOQkXRPW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020F423F260;
	Sun, 26 Jan 2025 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737904141; cv=none; b=iruYrNfBCOK/5t1eZnubJY1Qs8+UhG4DQYcKRP6gucfVyR6uLdgj7CsNCOFV6Sroy+SdUoKtws8/dqSQ7LsJrLuZ3jUSNeVlTYvz0jGOMU7HoP9+a05IOisSk/2BiDYUdqB1uH/j92VqHEM1j+KGjz/GzcPPn+GBDWMqE6YsIqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737904141; c=relaxed/simple;
	bh=409Qsl3ktDjiKfhhR4I8YWrT6z+l3599T++9fC/ZknE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW0IPnDneiguGOwQ/6OkskYKgkh7EQOcggcplYGcRxb4QDKiJ+XcplyFRPyOFX5sgEcbKzEIlLQ+i94AONAQE9D3o2g8MTc4YuhPxOwwVvNFZPFm6xu8aUtR1UPhFTWs8QEo2j4vFXuB+MyJ5dlUwXevjvJUKsM0ogbSKDg/9G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOQkXRPW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59456C4CEE2;
	Sun, 26 Jan 2025 15:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737904140;
	bh=409Qsl3ktDjiKfhhR4I8YWrT6z+l3599T++9fC/ZknE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DOQkXRPWspaqdwBRGNtF2OCrjQHLaaiOvHoijESN52T3J1qmP3Iz2tWzyShdcoocU
	 sC5qnZvMaUgtAm5LEVF7R2DJFGgvt6USGwCvrOp25xDKYLo2FTdL5P4sj7lrcgOdE7
	 Qpj7amPgswa1cr0D1XYQdJbytvTr2TR2lNEIDqHQ7TPSjWiRye9iPZTd1GLL2XYaST
	 dv3pDZT5NqC3PecOVnJnCoaQtB5p8H1/JgLB3DFE7P13vGexGsthByZ8OqCjVnqyuf
	 QshffHHM7hO5x7giVjtCysvmrhvf4utydswWGn4fBkrw+1gW5pqk+GdJyzAmrv3gzV
	 D8p/60YxmvrPw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Farhan Anwar <farhan.anwar8@gmail.com>,
	Rayan Margham <rayanmargham4@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jlee@suse.com,
	hdegoede@redhat.com,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 9/9] platform/x86: acer-wmi: Ignore AC events
Date: Sun, 26 Jan 2025 10:08:37 -0500
Message-Id: <20250126150839.962669-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126150839.962669-1-sashal@kernel.org>
References: <20250126150839.962669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit f6bfa25c6665f8721421ea94fe506cc22f1d4b43 ]

On the Acer Swift SFG14-41, the events 8 - 1 and 8 - 0 are printed on
AC connect/disconnect. Ignore those events to avoid spamming the
kernel log with error messages.

Reported-by: Farhan Anwar <farhan.anwar8@gmail.com>
Closes: https://lore.kernel.org/platform-driver-x86/2ffb529d-e7c8-4026-a3b8-120c8e7afec8@gmail.com
Tested-by: Rayan Margham <rayanmargham4@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Link: https://lore.kernel.org/r/20250119201723.11102-2-W_Armin@gmx.de
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/acer-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 377a0becd1a18..868faccfb8628 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -88,6 +88,7 @@ enum acer_wmi_event_ids {
 	WMID_HOTKEY_EVENT = 0x1,
 	WMID_ACCEL_OR_KBD_DOCK_EVENT = 0x5,
 	WMID_GAMING_TURBO_KEY_EVENT = 0x7,
+	WMID_AC_EVENT = 0x8,
 };
 
 static const struct key_entry acer_wmi_keymap[] __initconst = {
@@ -1999,6 +2000,9 @@ static void acer_wmi_notify(u32 value, void *context)
 		if (return_value.key_num == 0x4)
 			acer_toggle_turbo();
 		break;
+	case WMID_AC_EVENT:
+		/* We ignore AC events here */
+		break;
 	default:
 		pr_warn("Unknown function number - %d - %d\n",
 			return_value.function, return_value.key_num);
-- 
2.39.5


