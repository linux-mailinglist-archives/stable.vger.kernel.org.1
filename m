Return-Path: <stable+bounces-225417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8KgYEkFPtWm8zAAAu9opvQ
	(envelope-from <stable+bounces-225417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:06:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B7828CFFC
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 13:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBF72303E498
	for <lists+stable@lfdr.de>; Sat, 14 Mar 2026 12:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146D92E9729;
	Sat, 14 Mar 2026 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rr89gNAK";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="rr89gNAK"
X-Original-To: stable@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11023103.outbound.protection.outlook.com [40.107.162.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349072C1585;
	Sat, 14 Mar 2026 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.103
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773489937; cv=fail; b=M177PK29mENpmzZ7B0jB05q8gkZgKl7oH5BcUmdHPn6jVXF/LcDMfI0zr1tTNrhq4y8/jlzm2LSKp6NCm1sIyMgMsQflujIuS3i76dZ9vhK0la3VSNMU9oonD613E7QIv7a+xRzj7WveCl26QBOc36X4xbAEy5DNwTUXzYIaMiI=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773489937; c=relaxed/simple;
	bh=L6i3uLvmSadccOMIJKdH/iFQSPR7TGJITPGoC7rFl0o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=udpQYotXl2C0utqCwJmdhsvigHRwKIDdBZIOYeh2fhOVaYgPuSbyB6OuvtbeyKaFa7xdTKeSG4nEff3qiCe9gOpzkzygJgArYqN7N6/NQVE3unqFtfEaV5BRG8WK/UpIgJmHIMd4HaAOmoPiwDezK8Od2dbuOExl9iHlaxI6GHk=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rr89gNAK; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=rr89gNAK; arc=fail smtp.client-ip=40.107.162.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=CQFqME0iuR71LXrCShLoMb7LJx8E6HSlrTvjJY6DNVojfeNehoHGb6BicUU1kLYGvUAh/RsGe/6I3uRfyGrhksqN4Iim3/w067NwaneFNrGZfG+A2EOPVJugzCkzw8z9VkJas7ugry/3RReGr+iHp8FTA/p0d16ote6iq7hTaQjHWSl/uNUgJe/NkHwpOR1HaEL8Ug8O2wfL5XWzAQEa3fNZVqSV4PPX1xe1WMowv6QbCeHFDLsC9TSKQuoHx59JZjQvf4TZAve2Gk7M8t0TGe6T3CVF+Tre3feeO9djkOc68todzVrLwRthB3KxMKjHgwFeAxiGcygrvQnkVZzAvg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=gYRzOUo6HrJqkpYLdEXP29prxl9aP3SGvT8zvDdZsxCAzW5eCNkOPrZPvnAcnW2t6PKlClddLJYHejdoZfbtE5LjJTIqgD6XsSIkj5+21EsZNFxshVYYaULit5Ku7qq/AgtnBw1jyNe5xULaAcRYJup6EqjayhxoPuLcgTsdG0umDBJB9RjBzwsLH7uA2+MUzaNRf++9Qxxy2f8mfgd2yM55ybRvANnzB1293lL4nc4/sojjPQvhT6h4SElJNgEfHI0bZly34yTIJnm5zLDf46Bsi3vjbNliDLsYS65hcB/U+E6mO+MBbqTvrxOnY21OJ6Q89Bc2u/TD6oxNWxYyDw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=rr89gNAKle3puBxmq2WCAiDyX0U21YvG+FOUa/cnDKmfjHe6/SjKU4KdzJRptWtFUEzNHc5m7OLF+iKyxg7byFiThfQTA8appLVd3aQe387Wt5A9bAmCE51R3JPjIZ6Fy1crwl6uTLRn4AuNRERJ8QSrDG2+9s2N6RZS7W1oo+c=
Received: from DUZPR01CA0274.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b9::13) by VI0PR04MB10173.eurprd04.prod.outlook.com
 (2603:10a6:800:245::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.19; Sat, 14 Mar
 2026 12:05:17 +0000
Received: from DB1PEPF000509E2.eurprd03.prod.outlook.com
 (2603:10a6:10:4b9:cafe::65) by DUZPR01CA0274.outlook.office365.com
 (2603:10a6:10:4b9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.19 via Frontend Transport; Sat,
 14 Mar 2026 12:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509E2.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Sat, 14 Mar 2026 12:05:31 +0000
Received: from emails-2311019-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-180.eu-west-1.compute.internal [10.20.5.180])
	by mta-outgoing-dlp-834-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id CBDEA7FEF5;
	Sat, 14 Mar 2026 12:05:31 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Sat Mar 14 12:05:21 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nS5h8xb8LxK8kPpERefh+zKsRnt60FBzCeR/lI0fDZec2XmbO6TViIDd4lkh+BdoeDtkoSfGJOy38FjCys1PY3RPTgtIDsdXDuNAfDDXyPO/3vft/kkl6IFa1sDdvfgiPwxK1LxH5ALG3CfsKEGt6LpoY11C4hCBubDL9jE/p2NLQ1A97D6hI8PmlthIPdplGmPlrQAab04v7RCpjGJrYj4ovMi/9s8/gT+59jzLr31iAkONQHRY2ceDe6anowNZnhKXdpZbWdg3z78FLeo1kqdo9rB+XKzs4oCfDoBnCQsrIv0lg7cHpzwPWEDl6KEg847SXTwbG/oEqacNKLy+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=Wo9znD94IcygHG2Xo1QvWInVxsghsKF/sVZ1z3tDboJQ/ccsX2tYmfDK7hhfbYyA1DoFLrEhbYTBvXfTGuJcz3N9QO9R7ZYZCcdmrURPUtDKsaj23Ry/LHnRrusm9LBnkEMuvqmJGuoOK7eo8jxNkG3+aaLJfY0QPSu//pH4eS8WziBlCPFetu3VhfQH39ZsTpt4662bgVFv8gpO7oF7wx3s98GC+l6RgpdiJJCNXsVk+kbdxrY4vnSlxdMmV3GErRGGBwJNoRKqnsocAvjyCBVHrjpjZQT+46XiRGDtmuwbPtf1Cwvpvp2JHZhaEMXQHIlelqne5pbvEE8tUjIvZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=rr89gNAKle3puBxmq2WCAiDyX0U21YvG+FOUa/cnDKmfjHe6/SjKU4KdzJRptWtFUEzNHc5m7OLF+iKyxg7byFiThfQTA8appLVd3aQe387Wt5A9bAmCE51R3JPjIZ6Fy1crwl6uTLRn4AuNRERJ8QSrDG2+9s2N6RZS7W1oo+c=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by AM7PR04MB6805.eurprd04.prod.outlook.com (2603:10a6:20b:dc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.18; Sat, 14 Mar
 2026 12:05:00 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9700.015; Sat, 14 Mar 2026
 12:05:01 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sat, 14 Mar 2026 13:05:11 +0100
Subject: [PATCH v5 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-lx2160-sd-cd-v5-1-83de721585e3@solid-run.com>
References: <20260314-lx2160-sd-cd-v5-0-83de721585e3@solid-run.com>
In-Reply-To: <20260314-lx2160-sd-cd-v5-0-83de721585e3@solid-run.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0184.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::19) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|AM7PR04MB6805:EE_|DB1PEPF000509E2:EE_|VI0PR04MB10173:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b467d32-df80-4ad4-8a6d-08de81c1fdcb
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|22082099003|18002099003|56012099003|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 FftnGhVfrSToW/vFkxCBI4SNuh1QVSZ0M27vckQdK3LWJWDw9mG7t1Ay/Ofxw4vdx+PiSrwH3rjsmarbChXOXdQVuuobnZDNL92yUd08DOc3D6OoRmRcKYn8mVaE0DZRhItMsJEW6cqKKA/nSF6zIWjO+OsYd6FuknIaMN/W9CVGD8+n76mpAqdXDo3BNu6fF+SQ85HrOJHX7ymIHn/WGj79HIIMvQc1gtox71PXkBPctW0Q/Ks/VpZmyGnW33MzV3BXH1IGc2SjeL9DM7397q1belSdyOXAuC+7ZhX0bDtg724DNYRB2hp2le6++gL8CPN1nGSyYQ5/yHYzO22QhBisOsBZY+lrQ3rRRXK1Ez1lWlFuds+DqQ7A07LuS1K1uA0pOrR5VxrASKJD9nBjr2I9w26yNJJ0kMsEPBhzm97od/hEY1hM7hqJB1sp08PsSVgsbz8HSDXYmQOYxrycPylSiVFy00b8HqOoIc5FYiAdHOONWf/z1V+s6eTdM0zzLU7Q+rfLSo16LiZOKRcOmEY1y+Nk9ANGaT8DZXq70QJtHYU+qbfo2mfj2th09wX/+cBeLXLKFLLc4Krnst4bKkYn+eNnyY5ywqrXeOsXHCptohY5IqRaxbfXH+Q8ygJFwEP66zPSMmRzR2u5JZ2DhvqTvATUdRE0P2QqI7gBCOlqawF1/FYXS2XIyvpztvN6pilISF5xLU4pTy3yi94si83D81FOSBBlyTYDYF0lxxgoM1hqiuNN7HKXoejuX0ob/iXwPBA2DV2TILZWf8U0BMRAMp1CrSt4rAptCcfvi8M=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(22082099003)(18002099003)(56012099003)(38350700014);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 cVM/+qRH5ibu9uuTlZY5H9ALwkx9OmayO8vPhQ/W8Z5jmCwRjO1A2l0azD+7e3Gwr4bINIDObLcLznhIKbVSd7cus4AdppPVGC6refiiXPSsm//fXgJ74StqSGSMgqDl5YweqPMt61PDBoDQNnchwcRy0CGbESNWhgU+I9rWY4AAl6rueEvnPO3mG/4ruQiST3FnbHzISpbUqgJT+RhlH8+KFU2HcmLsyG90NBXNG9ykxDiQb9bfzt+dz/01BQF3C2M3geYKvZPLeOSbPiZez0dTw63yrPA8uHlGs9el5qJW2gb5CtKO62SXNmIFNFTgeNeJcrrwqxwoNVAmEMLbXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6805
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 0b2c7327a58347aa9799c4f9ba4af384:solidrun,office365_emails,sent,inline:b584d2d6c8d2dfe2d0d28b1b1905f14d
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	c9c2f2b1-6149-452c-83ae-08de81c1eb3d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|14060799003|36860700016|82310400026|376014|7416014|35042699022|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+rlpL2lu7fAHUKpAZZgOFSInz89ze2ycaa2sCwPG6Y3nf3SWMpsZe4fwdYRqxgY1KcsYbRSwW1MbGzYGY6rZVCVRsFJf299Sss87cPWF9h5yd4FHMbgmrQABx4kHJx6+fn7xfZNWBVlhlzMEj/pc1YteyRyMfljJiLEyy+bpBkgVViKISYLZ1OzNZNfg4zayw+20E+7IhRG4qKCSc8E4fZO7pIdF+v+Txgz4/qZpul2amhQ7dPU0L0u7h5qW56eO2ugFSctPeorPTwpD2UizPOr8/TATAhAJCKgX0Tecl1hZk5Ao+0ZvAPsCbkuyomDHbWfLdDNbbWtd33LaVdrUM9/a235GUVIVJ99jYDCkX6gXJsorrOLcFzmDooPFV/kifxK0TLBFXVH2S0i7zHbXjYEWouUzdh9KMvN2g/4UqvECDFtMV/heFBOO/M3Qv27CjhpN72zeUeo2PjVUdfyoALjdck2M9aNpfVcHH25/1cqqUg6fX2y46OEkZGRL8eoAQdNoHX7sUYgpEYeZtzvUo00x6ROA1i+4qM316ktUM4wvYdJzDj1NUJa1C8HFsiuCRUBeJWYmxy3oT73P0Qz50FASXKUQjHaX9/LBhsl43Ut9N94+Fysg7OSegHW/hHCN4DcVbKaMMSkEQrRewRl8UBxfL2hko2/9FZROMR/SxC/daopRwajqv45Rn6nM8jmlYbceceG2kkmZhhOxeLMsB7INFVdLaN/5urQ7j/fXXX6+0ueZYeUBcUGI/bM7OtT0nE6BmadrfAU4CIN5a0/k3Q==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(1800799024)(14060799003)(36860700016)(82310400026)(376014)(7416014)(35042699022)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l1/VGA4A/A5CwBYctyKu+lBa8px4C+33mOQsy2JbyLRPLGqsrmD9inGDAXMyxOM+WjXO6HOxvKPI1+42KMiMZEqNULqsXcPvXsfdam8GhniQRPxzE+HVUdpyqecOUnPrmQlCh3tp0sub58+LKdeZ0DHfAhk3RqeOYRtU4xjan43IXxocFukoS2y8dHMZZi/2ztaJolLzM/ZqEODDPseYWsh9CC0LpDKIWL42Q08761pYEN9PzPkgsAbI4XdOhtbEz5YuJ0IZeT8sT9xkwJKstt4FRs3ILAS57chFGkZsOuD7tPB0zQbSQl7SDrlCys1VzYEUOatossFnKX8NN4MTMfxc23CsfdRdLSdYtK6QDO/uSMZj5xHAGECGQxW+FZElL3S1pIevjGIRip8xAr9Q7q3ZAnOMOCVI/iJ6HTZ4sKdm5tgZPh3UyIF98o6pvkb/
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2026 12:05:31.9404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b467d32-df80-4ad4-8a6d-08de81c1fdcb
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E2.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10173
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225417-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,0.0.0.0:email,6f:email,0.0.0.15:email,solidrn.onmicrosoft.com:dkim,solid-run.com:email,solid-run.com:mid];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_PROHIBIT(0.00)[0.0.0.51:email];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: B4B7828CFFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to
support bus recovery") introduced pinmux nodes for lx2160 i2c
interfaces, allowing runtime change between i2c and gpio functions
implementing bus recovery.

However, the dynamic configuration area (overwrite MUX) used by the
pinctrl-single driver initially reads as zero and does not reflect the
actual hardware state set by the Reset Configuration Word (RCW) at
power-on.

Because multiple groups of pins are configured from a single 32-bit
register, the first write from the pinctrl driver unintentionally clears
all other bits to zero.

For example, on the LX2162A Clearfog, RCWSR12 is initialized to
0x08000006. When any i2c pinmux is applied, it clears all other fields.
This inadvertently disables SD card-detect (IIC2_PMUX) and some GPIOs
(SDHC1_DIR_PMUX):

LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI

Reverting the commit in question was considered but bus recovery is an
important feature.

Instead add pinmux nodes for those pins that were unintentionally
reconfigured on SolidRun LX2160A Clearfog-CX and LX2162A Clearfog
boards.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  7 +++++++
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |  2 ++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 24 ++++++++++++++++++++++
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  2 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  7 +++++++
 5 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index eec2cd6c6d32a..7f6e39e27ce5c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -162,6 +162,8 @@ rtc@51 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -177,6 +179,11 @@ flash@0 {
 	};
 };
 
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
index af6258b2fe826..580ee9b3026e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
@@ -89,6 +89,8 @@ &emdio2 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 853b01452813a..af74e77efabc5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1721,6 +1721,10 @@ i2c1_scl_gpio: i2c1-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 0x1 0x7>;
 			};
 
+			esdhc0_cd_wp_pins: iic2-sdhc-pins {
+				pinctrl-single,bits = <0x0 0x6 0x7>;
+			};
+
 			i2c2_scl: i2c2-scl-pins {
 				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
 			};
@@ -1753,6 +1757,26 @@ i2c5_scl_gpio: i2c5-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
 			};
 
+			fspi_data74_pins: xspi1-data74-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 15)>;
+			};
+
+			fspi_data30_pins: xspi1-data30-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 18)>;
+			};
+
+			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
+			};
+
+			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
+			};
+
+			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
+			};
+
 			i2c6_scl: i2c6-scl-pins {
 				pinctrl-single,bits = <0x4 0x2 0x7>;
 			};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
index eafef8718a0fe..8920326a06735 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -223,6 +223,8 @@ ethernet_phy8: ethernet-phy@15 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
index e914291e63a1a..e1344942eaaee 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -30,6 +30,8 @@ &esdhc1 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -80,3 +82,8 @@ rtc@6f {
 		reg = <0x6f>;
 	};
 };
+
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};

-- 
2.51.0


