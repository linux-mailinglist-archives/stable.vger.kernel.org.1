Return-Path: <stable+bounces-35923-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 231738986DB
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 14:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AE6AB24A4B
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 12:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0973584FCC;
	Thu,  4 Apr 2024 12:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b="Gp63qabd"
X-Original-To: stable@vger.kernel.org
Received: from email.studentenwerk.mhn.de (mailin.studentenwerk.mhn.de [141.84.225.229])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2E88286B
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 12:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.84.225.229
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232778; cv=none; b=Kada+RrmsSoi5PBiyCFpqbG4aC4BAqDThr7+S9DEwa6FfnLYQFDmaf3flYlTTlwheP9eY6fyAVXdxuXsmfUU8SOrrSa5CjLV3X2Uohb0l/PLPUz2CmZ0loKd9wiUvTfdX45qW41frb/OQLK0ZCi8vZ6YHQyutcI1ehUrjr1v4Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232778; c=relaxed/simple;
	bh=9NnwbsnlCM4IfYShXmOjD+z7xiAxvwDp1zNM1VQv/HY=;
	h=MIME-Version:Date:From:To:Cc:Subject:Message-ID:Content-Type; b=u4fpa8Y94FQuJuHJaFZDJpFfFqMAPamvHB9i0GtOpuZf4JlW8UHQLOO2SAoQz8ZIXyewSTTE1s0S01bT5N/Rx6TGnttdMFxZvlMmwYr7bSoVylwP0DO5sKXtFyR9olwz7+38ocuQNy5pHKZQKuCPhpwgynpGttMrHSbce2j4fOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de; spf=none smtp.mailfrom=stwm.de; dkim=pass (2048-bit key) header.d=stwm.de header.i=@stwm.de header.b=Gp63qabd; arc=none smtp.client-ip=141.84.225.229
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stwm.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=stwm.de
Received: from mailhub.studentenwerk.mhn.de (mailhub.studentenwerk.mhn.de [127.0.0.1])
	by email.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9L2l5GZDzRhSv;
	Thu,  4 Apr 2024 14:07:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stwm.de; s=stwm-20170627;
	t=1712232431;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=svG5PJjDjErJ1+S+a4xtTFYadJzURGKkERsa37xbkuA=;
	b=Gp63qabdzcnCgUsHdLZUyh1LU3iGHw9PKxI8Mzt9jxlpe9uEH3WmS0hDbW7rMgNyvpRXQx
	8AXExo1vuXyEm6fFihsPqFzElrYQMtG5AsknQG1xIJvj/5oVVJOaXj3NrBGr2jagQXbSgJ
	yBue4nebqFY4cjSlMLdDEGGVM25nuAkk2EsfvdpXy1I6G7Nt1SzM2cOfpd5r9zhpsANZxI
	OrMRoX4lstMq8lUTe+AghwUYbg3ZseWIDdVRaGlfMyqktTN4uiJdHabgFRToCfG4loFVyv
	6YS6nJVUryUqg6kFyGEa5y/CITNa2f7ExbWkvPMKh34481Zwuc5ABVeQB6zHFQ==
Received: from roundcube.studentenwerk.mhn.de (roundcube.studentenwerk.mhn.de [10.148.7.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailhub.studentenwerk.mhn.de (Postfix) with ESMTPS id 4V9L2l59FbzHnGf;
	Thu,  4 Apr 2024 14:07:11 +0200 (CEST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 04 Apr 2024 14:07:11 +0200
From: Wolfgang Walter <linux@stwm.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, stable@vger.kernel.org
Subject: stable v6.6.24 regression: boot fails: bisected to "x86/mpparse:
 Register APIC address only once"
Message-ID: <23da7f59519df267035b204622d32770@stwm.de>
X-Sender: linux@stwm.de
Organization: =?UTF-8?Q?Studierendenwerk_M=C3=BCnchen_Oberbayern?=
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit

Hello,

after upgrading to v6.6.24 from v6.6.23 some old boxes (i686; Intel 
Celeron M) stop to boot:

They hang after:

Decompressing Linux... Parsing ELF... No relocation needed... done.
Booting the kernel (entry_offset: 0x00000000).

After some minutes they reboot.

I bisected this down to

commit bebb5af001dc6cb4f505bb21c4d5e2efbdc112e2
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Fri Mar 22 19:56:39 2024 +0100

     x86/mpparse: Register APIC address only once

     [ Upstream commit f2208aa12c27bfada3c15c550c03ca81d42dcac2 ]

     The APIC address is registered twice. First during the early 
detection and
     afterwards when actually scanning the table for APIC IDs. The APIC 
and
     topology core warn about the second attempt.

     Restrict it to the early detection call.

     Fixes: 81287ad65da5 ("x86/apic: Sanitize APIC address setup")
     Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
     Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
     Tested-by: Guenter Roeck <linux@roeck-us.net>
     Link: 
https://lore.kernel.org/r/20240322185305.297774848@linutronix.de
     Signed-off-by: Sasha Levin <sashal@kernel.org>


Reverting this commit in v6.6.24 solves the problem.

Regards,
-- 
Wolfgang Walter
Studierendenwerk München Oberbayern
Anstalt des öffentlichen Rechts

