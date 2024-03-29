Return-Path: <stable+bounces-33150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8848D89180E
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 12:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DCA1C222BA
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FF166A014;
	Fri, 29 Mar 2024 11:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="S5/V92NF"
X-Original-To: stable@vger.kernel.org
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163A844C65;
	Fri, 29 Mar 2024 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711712634; cv=none; b=BB4hj+Lgi1pfnQ48W+/GEK6pYO3aubAl/89OxkX53+NYMnTeA0bO96gPn4Jogtq7SDQWr48U6wv0aXdYSi2OFAYpSOPIvAtzvIyJlxPDjL27nO3eQpStq9JhnWJ+hjsC5TASfvM54jDJhq7ZBgvPH2C++VHKiTxAaI2I/1tJhuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711712634; c=relaxed/simple;
	bh=ikoQNMMPUGesR1bkcRId9V2HyehtlVGvNHjsqT5czD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kjBQtOZSmmlNNZWM4elHkb7Lnwp8mOkk9qjuvOUnoLHdqQ7MvNtF6rREDgZzvatPElihLttmJzaE8HF4NTIzHATHJJNO7ALXmnbuudWx49e+WAUqvlWcVi81pAs96Mqi18HK+8XJ5I4fTqsFKEyzMi/ouzdnpza3Vrf8D3yuyzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=S5/V92NF; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 5DA9C100003;
	Fri, 29 Mar 2024 14:43:23 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1711712603; bh=ikoQNMMPUGesR1bkcRId9V2HyehtlVGvNHjsqT5czD4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=S5/V92NF4UMpgfnAS6mULbcqqFOqgQsSmK9KSnbB3648Ypf+JAnvWdSqPaMEoHyrK
	 p+j+tENx45A0BeS7jsojrZh+ZgjGNU2F2XvDWs6+Sy2Zhzr6CGrkjMCa6O6/BwsLSD
	 8AT578oex2PiFQyVwL5dQlM4FmtbUBmHMK/1+8iZdh++eeNCdkmOdJOZif6Tn0vz4j
	 uIpqmo7RfwUU1DQIyZgkR0QsauXFVYU/T/1rVpsUUsAfiPGH7C1yMqaGD/S4N7zlgV
	 /hhCQ4mhaCznkAHX6o3G2a143Sf/nZuoZWSGqju/4Sc7jYlZFsy2UENZaQ/N0Moyv+
	 bweuckDdpXtww==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Fri, 29 Mar 2024 14:42:01 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 29 Mar
 2024 14:41:41 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH 6.1 0/1] octeontx2-af: Add validation of lmac
Date: Fri, 29 Mar 2024 14:41:32 +0300
Message-ID: <20240329114133.45456-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184490 [Mar 29 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;mx1.t-argos.ru.ru:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/03/29 10:56:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/03/29 08:22:00 #24505801
X-KSMG-AntiVirus-Status: Clean, skipped

With the addition of new MAC blocks like CN10K RPM and CN10KB
RPM_USX, LMACs are noncontiguous. Though in most of the functions,
lmac validation checks exist but in few functions they are missing.
The problem has been fixed by the following patch which can be
cleanly applied to the 6.1.y branch.

