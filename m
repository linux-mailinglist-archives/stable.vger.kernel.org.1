Return-Path: <stable+bounces-100739-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E45659ED576
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181F91659C0
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B025249D41;
	Wed, 11 Dec 2024 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dt+JMIjU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE60248F94;
	Wed, 11 Dec 2024 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943164; cv=none; b=DHQN3KKwfXa+COOqCYbKhXKvElo0VGbrol6BKo6IqrfLbzykETt3/K6GbeWcb5SbFdXvfzeWdEAeOk7hANa2+1i/tObldZsdEruvoik/XW5tkVAKFiGbb5zI/NPZAMfC8gAhnOi/ja0XkNY4SUok7yjqSuDQnlBfVeE1VT59RJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943164; c=relaxed/simple;
	bh=AFFFYm0TzJs28HaW0/KZYqN//Zf7bl9GumaR7p3vuws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q2wrpW21cScfbCafYsibymOLHqSAGUyqJSz10TEXTaP4M/ANWGdi+TQNGPK/wk4ciPqwBzjzUEE8sfcwHerygq9Jzj+oechdukqeniroxsvVPYl+3jwHTvWTLkFJL2RglAM8HlKtzmI4XN3jol/fhJ7Pp14c+WnaRpgQloJj04g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dt+JMIjU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87723C4AF09;
	Wed, 11 Dec 2024 18:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943163;
	bh=AFFFYm0TzJs28HaW0/KZYqN//Zf7bl9GumaR7p3vuws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dt+JMIjUvANqJ8F4fZUv0lOKaIMzKoRmEXm2NvGMF+vG2Pw+MU5vfs4Ld1rNk7+VT
	 lovfQ/XbuXZtzQ573BZmVBzxM4/F3kfReO5Lp9nddU9Yxc7PGnxJn3Pd1oead/m3P4
	 3IvowX8/b9bFF8OpIj9WexpN4rkFSO9DNanWZ+AC+vhqUq0dviloebPNqpVt2YbxsT
	 4QxgOgpiMELPVJO6K3MLCxxY4pTZiN42R/YZ+VcoI/PAaaJN2R0NqsMP1bs5k+glHz
	 jT0FjU8wz7RSdhCc6nH8XbJayTdra2/zdKNPtQ8vMArgPui8WT+pb1B88PFHqVhCyO
	 A4otvMKWnXhfw==
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
Subject: [PATCH AUTOSEL 6.6 13/23] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
Date: Wed, 11 Dec 2024 13:51:50 -0500
Message-ID: <20241211185214.3841978-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185214.3841978-1-sashal@kernel.org>
References: <20241211185214.3841978-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.65
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


