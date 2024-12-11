Return-Path: <stable+bounces-100780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97BE89ED606
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 20:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C7E1188AC9B
	for <lists+stable@lfdr.de>; Wed, 11 Dec 2024 19:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D732571CE;
	Wed, 11 Dec 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtLCQA3W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570642571C3;
	Wed, 11 Dec 2024 18:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733943272; cv=none; b=MY//esYkzG2zaEc7o4GUj9HHFo9gcrpXM75jCijedAcjFtXI63lMxtnjiZzQBjkzOXcqXtNNnRjl0+HG6z9hHGyBrtNmlaKFIOHXLu0blgvyCvU/ZXMOs9OQYWzggjPcMSfDZ4BjPfhoZQtBpk/tDA9djPmMhhxtzavH/v/F1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733943272; c=relaxed/simple;
	bh=7ozMWDrtDMO5SKBOtF4GA6VAsjKod8+uLX4ouEbOVZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SfEgB2R1/1fiYj4jCpj6NevAnceKVRUM8PrLRn69AZc7EFwYFhtyPJlMx9X3UYBkE8Vk6Mmsrs7JtGBm5x1qVPs0QS11/PuHMyxdR/vyd4ibNnrKrLOOMw8JNKfbW7AYyLmyIM+9ScGKeptXwXbSOEAQcZhrJtcrk7crf3EKos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtLCQA3W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A763DC4CED2;
	Wed, 11 Dec 2024 18:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733943271;
	bh=7ozMWDrtDMO5SKBOtF4GA6VAsjKod8+uLX4ouEbOVZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NtLCQA3WBUZbs9cblJQyWGs0vbbDjbaA4RXoU1S8QtKxzscivIr2gYN+D0/kpqTv9
	 6k5CEcQExVuHKFom7FKB62Tq0KNBKQZPhbBlBXhkH6eZ3yV2YxWqRu/5y6MTbkqWMU
	 N6AtVQ4/joLDPBuf0d4B6by/2wZShNCdcFm+Lt5tC8+OYfV+SddgVqgdKIwsFuvNMo
	 icFWoG/rBfzzb34IlbdbbLLu03517nl9cXKr7P85HYsqF4UFpobLvEanXIs7TIF77b
	 X/ZpaybNfT7GQKF6Zkvsb9L+CS14nz2QkKy0dR+il6JGQs3d2czi/5nwN5oLdft1rD
	 jklfxkM1v+HQw==
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
Subject: [PATCH AUTOSEL 5.10 06/10] platform/x86: asus-nb-wmi: Ignore unknown event 0xCF
Date: Wed, 11 Dec 2024 13:54:12 -0500
Message-ID: <20241211185419.3843138-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241211185419.3843138-1-sashal@kernel.org>
References: <20241211185419.3843138-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.230
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
index 49505939352ae..224c1f1c271bc 100644
--- a/drivers/platform/x86/asus-nb-wmi.c
+++ b/drivers/platform/x86/asus-nb-wmi.c
@@ -574,6 +574,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
 	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
 	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
 	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */
+	{ KE_IGNORE, 0xCF, },	/* AC mode */
 	{ KE_KEY, 0xFA, { KEY_PROG2 } },           /* Lid flip action */
 	{ KE_KEY, 0xBD, { KEY_PROG2 } },           /* Lid flip action on ROG xflow laptops */
 	{ KE_END, 0},
-- 
2.43.0


