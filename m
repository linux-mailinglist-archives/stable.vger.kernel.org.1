Return-Path: <stable+bounces-100788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E72A9ED617
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:14:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F007188D085
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D1EE235C25;
	Wed, 11 Dec 2024 18:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmQyy/Xm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E452583AA;
	Wed, 11 Dec 2024 18:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943290; cv=none; b=tzHAEor4STcZ1ABjOEvrGmsndrpFIqcpPwHeeaYYqhya4naMcR8K88ErrqSjKRSrRxXNG7oigpOwLTE3aXo1y/A09Bb64+AJgH4ZbS4XnP1hv0NYfnCpLZzOvqXz8tocv+np4Ynx8c4lVBMYpu3/F+7f/tBIM21qSXl5/fCcqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943290; c=relaxed/simple;
	bh=9pez56zA4NtOTwEXTkUcxS6bKyL4e44NTEfZtg29qYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTz0zKXhPfUJMfqWBiRmQekbaQAXN8141rVjcYKL1o9Bq9oCJ3hRpl5WBoorPLNZXzVGUs0GVBMWKpl4uJnmStXrx6c+0+dt3u5XZy199XXL7b2/7JqlVNR3p/908iiVm5R4t+f1z1ijnjA4GS7JKv51r6MlC3Xtl4O1pHJxYHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmQyy/Xm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5799EC4CED4;
	Wed, 11 Dec 2024 18:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943289;
	bh=9pez56zA4NtOTwEXTkUcxS6bKyL4e44NTEfZtg29qYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmQyy/XmMa0BcKaG4uP6zIP+NqdZ5cjwQ1NalwKu4djrPTsVBxx7xq9WxJc6YvVB/
	 zLLc7AKGNDc3kMFGiVz6MvI63m9S7gGJr1B89gupnLutSRJOBIE+wMHPdXHogNgsBH
	 gMzz+FaJ+FBvZ9dDM2WARAEOjpWQI9kjzolWGc87W9NajQNHiMwG9yD99urzdwsINk
	 uMvGzQTUw1+OlbntKaYLJ0QWQd0fq6gXQ3xc4taS0RozfTi5QHJM6zgq/F//HYoTqi
	 9ot7i+t3PeYjXqLAO24kkaXrKy7PRhKw/YA6VESLvj2Quu+v+Vs9ZjmON3b5U8dHws
	 Uup1CeaX0lAxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Armin Wolf <W_Armin@gmx.de>,
	Pau Espin Pedrol <pespin@espeweb.net>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>,
	corentin.chary@gmail.com,
	luke@ljones.dev,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 4/7] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
Date: Wed, 11 Dec 2024 13:54:37 -0500
Message-ID: <20241211185442.3843374-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185442.3843374-1-sashal@kernel.org>
References: <20241211185442.3843374-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.286
Content-Transfer-Encoding: 8bit

From: Armin Wolf <W_Armin@gmx.de>

[ Upstream commit e9fba20c29e27dc99e55e1c550573a114561bf8c ]

On the Asus X541UAK an unknown event 0xCF is emited when the charger
is plugged in. This is caused by the following AML code:

    If (ACPS ())
    {
        ACPF = One
        Local0 = 0x58
        If (ATKP)
        {
            ^^^^ATKD.IANE (0xCF)
        }
    }
    Else
    {
        ACPF = Zero
        Local0 = 0x57
    }

    Notify (AC0, 0x80) // Status Change
    If (ATKP)
    {
        ^^^^ATKD.IANE (Local0)
    }

    Sleep (0x64)
    PNOT ()
    Sleep (0x0A)
    NBAT (0x80)

Ignore the 0xCF event to silence the unknown event warning.

Reported-by: Pau Espin Pedrol <pespin@espeweb.net>
Closes: https://lore.kernel.org/platform-driver-x86/54d4860b-ec9c-4992-acf6-db3f90388293@espeweb.net
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20241123224700.18530-1-W_Armin@gmx.de
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/asus-nb-wmi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
index 78d357de2f040..18d963916b7f8 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -585,6 +585,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_END, 0},
 };
-- 
2.43.0


