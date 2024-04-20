Return-Path: <stable+bounces-40337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E0288ABC4E
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 18:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAD0128172B
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 16:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC99839AC3;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SsuM/aYZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA542942C
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628813; cv=none; b=Ll9lxFUMItR1r2s5EyQgjIHfrMGn/EU2on9TPZZGbsyj0U4SF9lGNSwpVG4OtJMkcZpvyXThW/jcDu/6gqQAYTJVr9EaPMEnhUYmZLeIy6dJMShyHDDDrvPdLz4VJubC5rmm7OyWxVCdb09QHaw1yFii/u/iRQcYK7Y2BiqnjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628813; c=relaxed/simple;
	bh=/ed9nH5y17K10P4P954SKyt1HWbeQ6IpmCrsuHQLQyU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QrKTBQYqC8yZ/PQQkk5pery3VL7J+hhRNxBU0oezjcU/XylMyc6EADcWD8fpoVLkXHI+zKkYH3bMHnStthChzNGARBJMwhOJbIrkzYaD8kqG1kNNGbY17AbxGAqbJRiD7hIuDsrIa4GFRlOwIpWaf/YnfTZtUqPDiyoZYiNywM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SsuM/aYZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12330C072AA;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713628813;
	bh=/ed9nH5y17K10P4P954SKyt1HWbeQ6IpmCrsuHQLQyU=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=SsuM/aYZYtwLb4EjwwN34czLfosJp2qOmBfiPsoKJ5uocgHksvM/Bu4eUVVuk7hDS
	 AUPNzZOqcQewiWboFuU1O+maJ40lhq/z4U0ZaJXc9Yfs/kmPYkoBlrnmRcI0RoM0vz
	 ZQyz/si/O+OSVs//M5ADEa4dirlWYQUdt9Tiixq2Yzpe9qc3YLxuX+d7pdlVhjQOy8
	 o2mRH0h7n/29D0u7mpr43/om5kg5LB4PyZT5T9Y02CV6t2fBik7GImZMNJ0elX43NL
	 fOAgi+0G6qhgXcmiEaKm5ext/z8L7DYGuESt1/9m9D+MyeiBpx4C6eUUgH2QgGuLh0
	 epX9R7JXwYAgQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2AE8C4345F;
	Sat, 20 Apr 2024 16:00:12 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Subject: [PATCH 0/4] Please apply these MT7530 DSA subdriver patches to 6.1
Date: Sat, 20 Apr 2024 18:59:49 +0300
Message-Id: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAHXmI2YC/x3MQQqDMBBA0avIrB2IaaqNV5EuYjrWwWJkJogg3
 t3Q5Vv8f4KSMCn01QlCOyuntaCpK4hzWL+E/CkGa6wzzhqckqDmMP4IW2xwDHHZkmTFp4v+4W3
 XvjoPJd+EJj7+6+F9XTeL+m67agAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713628810; l=1085;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=/ed9nH5y17K10P4P954SKyt1HWbeQ6IpmCrsuHQLQyU=;
 b=WRUPxDNFQaGV6hONFMqLFp9O3RYgthoAXxRcy8GTTy1nyFvb4zuuCfpFUM9wv18tu87zkNkpI
 JG8bxp7is9dCTLJDM6J7DOTQaTAOW7jc9p1U3GnResKp2Kbd9AcsdxJ
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

Hello.

These are the remaining bugfix patches for the MT7530 DSA subdriver.
They didn't apply as is to the 6.1 stable tree so I have submitted the
adjusted versions in this thread. Please apply them in the order
they were submitted.

Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
Arınç ÜNAL (3):
      net: dsa: mt7530: set all CPU ports in MT7531_CPU_PMAP
      net: dsa: mt7530: fix improper frames on all 25MHz and 40MHz XTAL MT7530
      net: dsa: mt7530: fix enabling EEE on MT7531 switch on all boards

Vladimir Oltean (1):
      net: dsa: introduce preferred_default_local_cpu_port and use on MT7530

 drivers/net/dsa/mt7530.c | 52 ++++++++++++++++++++++++++++++++++--------------
 drivers/net/dsa/mt7530.h |  2 ++
 include/net/dsa.h        |  8 ++++++++
 net/dsa/dsa2.c           | 24 +++++++++++++++++++++-
 4 files changed, 70 insertions(+), 16 deletions(-)
---
base-commit: 6741e066ec7633450d3186946035c1f80c4226b8
change-id: 20240420-for-stable-6-1-backports-54c939276879

Best regards,
-- 
Arınç ÜNAL <arinc.unal@arinc9.com>



