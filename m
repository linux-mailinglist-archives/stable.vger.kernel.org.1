Return-Path: <stable+bounces-100757-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5991D9ED5B0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D720164AA6
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CBB0251B0E;
	Wed, 11 Dec 2024 18:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUNSI/c6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BB251B04;
	Wed, 11 Dec 2024 18:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943213; cv=none; b=c/EYcmr65Qn36tPRPbxoh+9q65Q3R1SMgmrdzb7IzWOXzD2rRfuVgWRVFK6yBYpswZluOnzv7tG72VOv+m8/k9Wys0ctnqFREArqO9BldbD9CZnk/fvAYLAkL+tne23PUM74mwvF0B3s8USjtr+hGbeY/9VDIMfbg0+k+DyACfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943213; c=relaxed/simple;
	bh=AFFFYm0TzJs28HaW0/KZYqN//Zf7bl9GumaR7p3vuws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZSOPg8U8+zyMUh2jnpArTKYUkZJUZV643HFyMQ0yGAroWRqVjX8ji2/Ub62ghxulQiqh4M9Jr2D1/EL5xkWeRXUOxkQ3/jQd3tadlxJAyc5OAXskDYiC70Wmlj3kTZKj7VWSY/h0IsBRe3R3FibQGRi46e8UzRIEAZEoGW1l+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUNSI/c6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EEBDC4CED4;
	Wed, 11 Dec 2024 18:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943213;
	bh=AFFFYm0TzJs28HaW0/KZYqN//Zf7bl9GumaR7p3vuws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZUNSI/c67Lub7VdOjnTsy3CKSQEq0F8dFfxd0usj5utWoIQ20Z9Vse95x5OIY1K/u
	 BlHlKsjuG61RrDbUNed7y12U/cLVRgbvuY8Rwlw8p6KruvJBffptuOZdPmK64F1MnI
	 iWtgSlIwVpUKFovI5Qipo9UgkDdNIGb4mKgjmkPL9ue0EXHWAspWKSaWKbd2fXkB9s
	 EGqlLYh75herf053y88cgv1Ye6DfrB3IZEi7mazrOL/V0QOt3z0xMtUwx8bPEVLEkR
	 dIIxQNt2UL1CxqNXF9Kd1h5a2xU8CP+Pgc/1g7roJHuOUWqvSt0ZReWxNVkXFx6+kI
	 tSJRys54yB/3w==
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
Subject: [PATCH AUTOSEL 6.1 08/15] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
Date: Wed, 11 Dec 2024 13:53:00 -0500
Message-ID: <20241211185316.3842543-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185316.3842543-1-sashal@kernel.org>
References: <20241211185316.3842543-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index af3da303e2b15..cba515ce3444d 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -590,6 +590,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
-- 
2.43.0


