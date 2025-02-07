Return-Path: <stable+bounces-114225-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E89A2BF92
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 10:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00210169455
	for <lists+stable@lfdr.de>; Fri,  7 Feb 2025 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFB51DE2BF;
	Fri,  7 Feb 2025 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJBddyY7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qWVKt+F6"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970D0481B6;
	Fri,  7 Feb 2025 09:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921151; cv=none; b=qeUqAWSejZxT42dhV6ySurCuDnftIf8/Mr4ZhTAmgH8t4dK7cN8jI8Xnodc7iYEQy5OBqnHIZTMvtrEPVtaErSfhmgqK/Jp1ukK2nxMevW8oCEDMw9HQghHbLWY1hgGGePimcopY0Akln+qCvSq2jyXZpm5nO7hH9/Re7LegPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921151; c=relaxed/simple;
	bh=07a7zO22lqqx0uPehtxqwwQPs3Go5oYt4L9UEaHArB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B+WI8ANxE/wuKRj/yCxS48yNo35vSY4BcvaHNGP5MJi2zFytn50OCl2yIz2bLMC4G7bVOfqzRct7CYNktJjuVGX+KK3m/d0Dpn3GMphrUjxtctgM6cSV+F98lSYnWyp6Or84wiXiWuMWWX8NIu8trRlTDdOGb/OlFSrbAVqSJDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJBddyY7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qWVKt+F6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738921147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lPgKIcdFP2NxJcFQKZs1+KGN4CChjbcR4yJdh1Rx6b8=;
	b=xJBddyY7Zauoxo9cQqWv2CL43/m/oP2U2s1DHymNBUX83IL+1AkrDEtlSkJJ0ZSw4ZmzeU
	WwO4D0y3YmEKCm4oTuSsv31i55YWaAMoY7tFWOH2HQZNYetWn9TW+LmhuChJ/1bEPU6Pov
	x6rhXrTEyX6SNqWc6AEBMFZoRMCscBteYc1n/jnUwWV4cgbkeLe8bxww+A8+pOivAJgSUs
	pvUGTyXbZY1FE/5hIaS91JSloh8HOm3tLCoU6gGwSY2spWdjUp0QmQELFJXbGbth59F/Gw
	ZE0ibv1O1MZ9tqliQua+V56hZQvqjwiHGTxM3bgafWsCYW4rpYLrXBSYY8lmNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738921147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lPgKIcdFP2NxJcFQKZs1+KGN4CChjbcR4yJdh1Rx6b8=;
	b=qWVKt+F65rIuo6lnMUh0kT4pZDVJASAewUyP8S5bsB+G5DdWH1SoOLBDaQ3B1xHMfe8MKV
	5VEPs4faUCdl17Dg==
Subject: [PATCH net v2 0/5] ptp: vmclock: bugfixes and cleanups for error
 handling
Date: Fri, 07 Feb 2025 10:39:01 +0100
Message-Id: <20250207-vmclock-probe-v2-0-bc2fce0bdf07@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALbUpWcC/3WNQQ7CIBREr9L8tRhKRaIr72G6APq1P1ZoAElNw
 90l7F2+mcybHSIGwgjXboeAmSJ5V0EcOrCzdk9kNFUGwYXkgp9ZftvF2xdbgzfIpLLGGqX4RUi
 omzXgg7bmu4PDBGMNZ4rJh2/7yH2r/uhyzzjrlR5Qc2VwON0Wcp8UvKPtOCGMpZQfoindtrMAA
 AA=
X-Change-ID: 20250206-vmclock-probe-57cbcb770925
To: David Woodhouse <dwmw2@infradead.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>, 
 David Woodhouse <dwmw@amazon.co.uk>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
 stable@vger.kernel.org
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738921146; l=1229;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=07a7zO22lqqx0uPehtxqwwQPs3Go5oYt4L9UEaHArB0=;
 b=FCeeQ0id5SVolworsceb5H9jhSEHTlZI9xXjZJ995//1a1F3ghCrCla/HtvGCW0OjjB3Z21K1
 AVJbUglZ+3aBCJ7olEjfUs2pu/9Ht6tlyiVjynEPfB64U5u00Te9K5X
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Some error handling issues I noticed while looking at the code.

Only compile-tested.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
Changes in v2:
- Fix typo in commit message: vmclock_ptp_register()
- Retarget against net tree
- Include patch from David. It's at the start of the series so that all
  bugfixes are at the beginning and the logical ordering of my patches
  is not disrupted.
- Pick up tags from LKML
- Link to v1: https://lore.kernel.org/r/20250206-vmclock-probe-v1-0-17a3ea07be34@linutronix.de

---
David Woodhouse (1):
      ptp: vmclock: Add .owner to vmclock_miscdev_fops

Thomas Weißschuh (4):
      ptp: vmclock: Set driver data before its usage
      ptp: vmclock: Don't unregister misc device if it was not registered
      ptp: vmclock: Clean up miscdev and ptp clock through devres
      ptp: vmclock: Remove goto-based cleanup logic

 drivers/ptp/ptp_vmclock.c | 47 +++++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 26 deletions(-)
---
base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
change-id: 20250206-vmclock-probe-57cbcb770925

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


