Return-Path: <stable+bounces-40345-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 786078ABC77
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 18:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 204D51C21192
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 16:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0268A29CF3;
	Sat, 20 Apr 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LK15WaBh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AFB2629F
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713631567; cv=none; b=P8NnwNwaloan0HTXCUwzMMkaBhKhhnsYwlwrx3rWSkyDd1X3k8gn4xfWW2s//y9c9I7uGSDE4xQNinqJHfHCk5cpcMfLfyiJA9oZVJGF4dCHuuVgtmaJoKGoCjQpxImJtH/wTnsEIGrSWk/yE+MXWKRhZacMoS7pCkxQAFqRBzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713631567; c=relaxed/simple;
	bh=U5w5XLDjKEPCeq7w47hHR25jd0gkNMbwdkJrMl+gd8Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qRJhPj9rAjhBGUWYD+ljhE1yjyyu/tux9xcPfdV0Ie+UcTICF+NCeWM39HqHHEigsGfrd7OhN6KhJ57ZFuzcEE0h20CW/mNR50/D124ycntH+DitOnPTFc8kdig/aupOkfswHLLRuJRfR7GdnFmI9eGF6FctG5hKyC+HomgTxaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LK15WaBh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4868FC072AA;
	Sat, 20 Apr 2024 16:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713631567;
	bh=U5w5XLDjKEPCeq7w47hHR25jd0gkNMbwdkJrMl+gd8Y=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=LK15WaBh1hAK5FaeLQVJ+u0p5fz714RfirdyB+ilgd8gErBh8zmHfNrMA7GWEUEWT
	 f+lFzvk9ABU6tV6/aajYaJTETg/liCoVP3lreadN226LEa/te3nSJXPu2T9cRqM6Y8
	 WDvppmjknKxZFX7vhd/R7A306R0XafeWzj1ccd5a/bNcshG+dlh60DLQQl+QwVmXiK
	 OzklHIOGGq7sVpZ5iuqmG+fAxLiAWtlMm7IGIGJRk4fRE8wI7h9wKfH7XjgbfYuGI1
	 S1wWZqseEkNH9LQCsJ5/o11xuFyBsDkvY/toP6Jj1GFl+MkeemUQSAQb2nsZL7XmN1
	 9sX6tDrqKVdEw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 320AEC04FFE;
	Sat, 20 Apr 2024 16:46:07 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/4] Please apply these MT7530 DSA subdriver patches to
 5.15
Date: Sat, 20 Apr 2024 19:46:02 +0300
Message-Id: <20240420-for-stable-5-15-backports-v1-0-007bfa19d044@arinc9.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAErxI2YC/x3MMQqAMAxA0atIZgNtUVCvIg61phoUK4mIIN7d4
 viG/x9QEiaFrnhA6GLltGfYsoCw+H0m5CkbnHGVqZzBmAT19ONGWKOtcfRhPZKcipONwdtI1IQ
 Wcn8IRb7/dz+87wfBYEZSawAAAA==
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713631565; l=1085;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=U5w5XLDjKEPCeq7w47hHR25jd0gkNMbwdkJrMl+gd8Y=;
 b=EFbit9hXHwWbmlJ1EswPFwHGJIXqp1jO6dkGKDAXa1r/N3xaxt7m98Y3b/FBduIYz+C43Peur
 FH0O6jBKVZ5BqiE519an+/Y0J6QCN4Yi95tpkeXxc3709bPyesnOose
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

These are the remaining bugfix patches for the MT7530 DSA subdriver. They
didn't apply as is to the 5.15 stable tree so I have submitted the adjusted
versions in this thread. Please apply them in the order they were
submitted.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (3):
      net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

 drivers/net/dsa/mt7530.c | 54 ++++++++++++++++++++++++++++++++++--------------
 drivers/net/dsa/mt7530.h |  2 ++
 include/net/dsa.h        |  8 +++++++
 net/dsa/dsa2.c           | 24 ++++++++++++++++++++-
 4 files changed, 71 insertions(+), 17 deletions(-)
---
base-commit: c52b9710c83d3b8ab63bb217cc7c8b61e13f12cd
change-id: 20240420-for-stable-5-15-backports-d1fca1fee8c9

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



