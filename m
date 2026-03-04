Return-Path: <stable+bounces-223039-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KC/ICM4bqGmYoAAAu9opvQ
	(envelope-from <stable+bounces-223039-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:47:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A581FF3D3
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 12:47:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97A3C302A7CC
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 11:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AEE385527;
	Wed,  4 Mar 2026 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q272EwYa";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Q272EwYa"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021073.outbound.protection.outlook.com [52.101.65.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD0D351C3C;
	Wed,  4 Mar 2026 11:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.73
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772624601; cv=fail; b=A2Kn+I3VOdwVADuc5ekxT8ISOCNVauaeutxe822jFCkOoa+6yBJQ3ZjXwZw0Q9pVwMn8EYkuBSp/WjE8QkOXlVuWfOsXugB1piWSxYQ3UXUMg13O2lZcaQykEM/EJKGamGAcoMDYfmoH+j82ZAgBiEPtZuNLeniaj0s846Fsb+A=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772624601; c=relaxed/simple;
	bh=adBPtnzoFf7N+jiTOIdZocJGE9S10iVLW7t6HLfaNho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/M76eJkKRRMlrr26HEVZXKJYpWZ+v3gn4Gg17LK700KD7/LtdwGN8vwExLUQVzTpgux+SMvrwINtHrw5VqJ+Z8F/s1bTxPsjCPtTw9dmleLAe1Ckc3v/CR/6H39AJNXfcsNuVXcNygvIibWsumfsF7P12vwo8mRa7Ae9JCKTOA=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q272EwYa; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Q272EwYa; arc=fail smtp.client-ip=52.101.65.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=pq45lxPzDd1U+e6aHCneRIJ66W8d5i9LfcSaf+PUzZfjVPHP9ptxmH4u/R7UvZ2j3pGIoTQT4KObCgDlbXMMT4cIzgRpPzNR5EtP9QEwHLeqgHUpip4FpkX24B+VRqTK5AW2pciaf/C51BmqQ/NDCe/CWOZ6gwIxFAYl3Q7NhAPFJcLTPZ2MNehLtFjsh1+CE2PuT9T3k2D/MfdRWa24eJRyjfPQyqwD2TVtr/LpT4BrtAPfZEhyKHBUOWzxTuHv3fdx9ASbONEnmvA48UpaN07SAJ3VpKli2twUVnaAGk5S+l3m8tmRAunxxnLD4wtywhg3MACJHM8WYG2qMg5NbA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adBPtnzoFf7N+jiTOIdZocJGE9S10iVLW7t6HLfaNho=;
 b=mQpQ0jatOzybypFmnwLU3msBkDEztwqBwMEJf2IGu1jJm6DovJnA9Fxn8A9M2jfmE7s5GcGFw4OAbfT0iZ0QUjqaxJ2Csi5ydyB+2IQHr1xfkBuww6pJ4qQGJRK8EeTEiIqQKsUUqyXCwaWWfboDtGUco7onBJJK82uRzpmsvx9VSKKHiYP9wEcjkvGWMteTgYLBnO/dB/lh8zccrlKtL6arYhV2qtib6nbYwGSPBQDaKaepgkuDSnRLHZf9PPAwya/+y4BotXtpPJXq3LEPmn315iCXc8dAXpC4r87RHS+cNAXa2QBS6aWSwFZtQKn2O77gcj+kIDlOiVnINrOghA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=softfail (sender ip
 is 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adBPtnzoFf7N+jiTOIdZocJGE9S10iVLW7t6HLfaNho=;
 b=Q272EwYakzCL5i7C2kv+4vcmjwSsLjoPqvGTGhZRV2Mcth/396XAJiZWLIozJgq/ZNV7af9GGoQB7J/ELY0ezw5erf6dZYezaempAyoxIsq21+MvxCzXAYNQveNSxpi0vE2RgKYGswnTSAGUtkdFx681T3SvQyEybXfhByKCrIY=
Received: from DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) by PA4PR04MB7615.eurprd04.prod.outlook.com
 (2603:10a6:102:e6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 11:43:15 +0000
Received: from DB1PEPF000509EB.eurprd03.prod.outlook.com
 (2603:10a6:10:4b8:cafe::be) by DUZPR01CA0333.outlook.office365.com
 (2603:10a6:10:4b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.22 via Frontend Transport; Wed,
 4 Mar 2026 11:43:15 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 solid-run.com discourages use of 52.17.62.50 as permitted sender)
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 DB1PEPF000509EB.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.16
 via Frontend Transport; Wed, 4 Mar 2026 11:43:15 +0000
Received: from emails-4983932-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-6-248.eu-west-1.compute.internal [10.20.6.248])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 640FB80146;
	Wed,  4 Mar 2026 11:43:15 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Wed Mar  4 11:43:09 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=opldjwSKmSNH8FEboa1fvQPMXBbhUp6fCqX3bBdwok5+O3QxINrpzl9r1WnPnSAk+sOCT72LThd+iumx+OY+hmqbvvh+uNWop7xeMSve7wDGBfFq2qJgdjZJRKx1duu21RgPDQpdUkGOfQ+CKOk+bl+ZSIWDqytAOysiiQdQA3k65SMjl3oP/jVGGWDQLpLTdqnSANlZ+OAVWofus3nZx3PQm3ZTUxKhk6zJLsKaxkDU/JnWCiTXjWVI7yISjyDJrvqxt1GS8/JK4aRlvUmCG0JdCh7miRilN+Br4Z1rJO7+L4H8xlipkWeWo9Bn44K61sOzE9e2yI8rL/b9chrCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=adBPtnzoFf7N+jiTOIdZocJGE9S10iVLW7t6HLfaNho=;
 b=x/4bn9hq/9DTRkLQ3s8G364norT7a15EI8jdiEuJuiH0kpcRxOG9WrptfteWukA8Zdcdmv0W0TM6cmEGugcjr38FhOiTIlb95esoFwaw9pjBTk7xWmysvU2QZpBoBAcrmUJohxb/p+3wcKFuEtwUu0K2uPN/7x+PwpRV29ns93TvPcMIILgN5BzRN5M/yWhq0f0O9aKN6+nNxrxGTt8jYHkwGPQ0milyCYNo/5kVX4L6fKPpTHvIooxyMmvKxOljfCnQpkRLxLO8wNUBu9z/z/YhgIrh1M5iII9Gw1vo7m1156VHzwfjVdxpsst/DjTAGib0VvL6FHMfbQ73ZzZGSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adBPtnzoFf7N+jiTOIdZocJGE9S10iVLW7t6HLfaNho=;
 b=Q272EwYakzCL5i7C2kv+4vcmjwSsLjoPqvGTGhZRV2Mcth/396XAJiZWLIozJgq/ZNV7af9GGoQB7J/ELY0ezw5erf6dZYezaempAyoxIsq21+MvxCzXAYNQveNSxpi0vE2RgKYGswnTSAGUtkdFx681T3SvQyEybXfhByKCrIY=
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by PR3PR04MB7307.eurprd04.prod.outlook.com (2603:10a6:102:84::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Wed, 4 Mar
 2026 11:42:58 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 11:42:58 +0000
From: Josua Mayer <josua@solid-run.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Carlos Song <carlos.song@nxp.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/5] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Thread-Topic: [PATCH v3 1/5] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Thread-Index: AQHcq8kFmGQujAWzIUaoJv5AcvpNt7WeQIYA
Date: Wed, 4 Mar 2026 11:42:58 +0000
Message-ID: <11df8829-8d4a-4016-9da9-6e447f0e8b6e@solid-run.com>
References: <20260304-lx2160-sd-cd-v3-0-dee4523600ef@solid-run.com>
 <20260304-lx2160-sd-cd-v3-1-dee4523600ef@solid-run.com>
In-Reply-To: <20260304-lx2160-sd-cd-v3-1-dee4523600ef@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-traffictypediagnostic:
	PAXPR04MB8749:EE_|PR3PR04MB7307:EE_|DB1PEPF000509EB:EE_|PA4PR04MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9b4553-f2ca-46d5-202a-08de79e3391a
x-cloud-sec-av-info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021;
X-Microsoft-Antispam-Message-Info-Original:
 K/qas3OiINKTH4QWy1NnfTsMQjgIfJmWqMRW30QMi+RdRjZ9n19Ll0D2IsvPknJRXB99Z/j04kDYUwCRWeb3Cu7qjan+amsZtmO1wyUEF0BTO7PGAJCRghuMOZRDe0frdpy9EVP6tW9Slm7zo7LEKzbdrtbPC+74tuqaXdHxiujTyUFA8heh/hNLeD9URRjL3kPyeCcqR7kfO5bbRCeEOvn6jzBZHLaSGtWOvL9JDkufmSUL5E/gkUdOd61byYBXdHtw3V/+HaQrW7WwgnUWRwBwfGc+Opuitf7R+Qwl+YSURagQbWlN4F21HGwfDOYXveVZm43CwpKBctwGDczCo8Ew8z9BsBDqrI18dLuIEGodXdcPaf5bWfk7ytx/4AgXt/23bYNo203nOsGHhyK9ISRSBnj0lUmQRcd0iQvc936V1tTtE1CBpMaJ4QJwn10t8tGR1PecCcZmGoBp/5iueVk97t4z7Hxg+Ja0qnx2mRL0ZMkvTT5QzMJO6OTXwJGpyOLo+7Lcd2s6dewWhAnNC4m8BD/y6z14XgeSCsFnqNzcd06A5tVs2pqOinPPmxpAJm8TRguw/aNp1iqKrimE6TI8cHEk6Wb5U/Xy924IA9tfNazdUaIfKMF9YIBQ4VhKM2E/Gd4SVvL33OBn9kZ4whye9154jj3xdMKfZMctDG2CAO+wQ2YnDZUeiJlNrbX7QGgcXD6AFs4GXeWRIy3dLsItK8AFqapSVkxbUOuVexwwmcHxoY1wvkr7Wr5Yao2CF7qxP7H2O3WH3utEFCK13tEm6k/fmQnOcRKiLOeaN8A=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E023A63B0DB064E8E7D42B695599F7C@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7307
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 62e5c9d36c5f4b89a6024b4b89226a43:solidrun,office365_emails,sent,inline:5fe62c288d9ebe6d23bc11618dd9b0a3
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b62f601c-fd20-4bbb-78da-08de79e32f10
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|14060799003|376014|82310400026|35042699022|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	Gf3B6STGhL2rM8WSKquRbP7proDkJLd7NOORTnNbw9UAi9G0laodow7OZ9ojcIpb1Fc2taM36p39GszGJjMS4zIM2vJiq1P1zr3dtdDQ+1UczlELZ2/j4Jx+UwqZJpJ3ac9GOMD2YzvZ2BEzk3k+du5tYevrSC0/MtDii2vhyi69fs3lKtbdNyXt1dsIRpDTuH2Cnt/KCSWDHyiL+S/He3J7LDwwh674GxDHfQV5nW4BgGEjY9b2zAGKWfgiXhIwQ6y6xf4cJHCJBDD4sINpEVhKqh8AfVW3JXQynNM8P1p7IQKzGco4i09EYKYECbXq/cUkvC/YdnbZ5TSKFr9jBiGTyxP08GNReFKoVP/lB0mHj7xQRGaFXd/FhNa6ItRcLFLHcIngr72BmY4+frcprGZy1V4MVdvHTHz4nefgnearFX0AcZwcFQ2ARdhvgqMrwoOJFGrc5/baE2puN+tQIC03hLTxoqWz9hKtcHl3XL30vYsyCWhcLbqj/Szdzu0ctrM1KWWfIWXcJG9dS26zIjT/U3LNEobiQVWXBOQ7WWF+Ku0hYDVDaasiRZs3XFW3u1tR1eMiqwdlnEl34OGfYjim6vG5bIULNCg/Oz+jNGRKPiyNRr1zuuJ2aRUG6xzfheyJOgNWrMItEhEjkovuo/X7W3MPIfv4dC2ERvi9hnhxZLvyPQ+1LYNVAj1NuWY8rbhDygOCrTuiot4RIqs229/7SUwyy4TazT4mGBr7kFjfC0hf3fKr5bJN5lesFWGbs46PGMzSc1LuLcVgegHVow==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(7416014)(14060799003)(376014)(82310400026)(35042699022)(36860700016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CTdFZHVP0KWsnKyDdFOQVneg7ojLBpPwCUvI162WVzGrDKXMw0SUmwRnoVfFNAPkY7e45ZrS0jWyn30ykxaQHqS1uOHqzCZYYYWmRpFVZfOLiYK5+s0MYssClzKuRqu932UBJNfyhC15/uEZMZE/jMZQ0UaygXQ+I07ZVhpqWTtNN1ivT9hXPY2ylVwbbb7L/+w+PcprTni9DVT2EMl6cqSY/oVV6HLQlAUcz18FPVqJUkHXOv6Gfq6Ii5/fQkk6S2j9fHjujLnEYTNVN1uAnzWOGjixvhrP7p20zq/+FdqjE4cITDyjYSNSVTpouPkkBxBEN4vqBOmSvKOFVHSCoVZ3JOoRjMT69vLZs9PtC+sKJ2Y/4l/pS9EjdKQ6xWzIPP7Lu3nLmxZ5loE7oeOfM93bKbgdQTOW68dZnYpvXRKPIPvgWRdfFWN/+iYf0kBl
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 11:43:15.5290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9b4553-f2ca-46d5-202a-08de79e3391a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509EB.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7615
X-Rspamd-Queue-Id: D3A581FF3D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223039-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.51:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,6f:email,0.0.0.15:email,solid-run.com:mid,solid-run.com:email,solidrn.onmicrosoft.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable,dt];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

DQpBbSAwNC4wMy4yNiB1bSAxMjoyMSBzY2hyaWViIEpvc3VhIE1heWVyOg0KPiBDb21taXQgOGEx
MzY1YzdiYmMxICgiYXJtNjQ6IGR0czogbHgyMTYwYTogYWRkIHBpbm11eCBhbmQgaTJjIGdwaW8g
dG8NCj4gc3VwcG9ydCBidXMgcmVjb3ZlcnkiKSBpbnRyb2R1Y2VkIHBpbm11eCBub2RlcyBmb3Ig
bHgyMTYwIGkyYw0KPiBpbnRlcmZhY2VzLCBhbGxvd2luZyBydW50aW1lIGNoYW5nZSBiZXR3ZWVu
IGkyYyBhbmQgZ3BpbyBmdW5jdGlvbnMNCj4gaW1wbGVtZW50aW5nIGJ1cyByZWNvdmVyeS4NCj4N
Cj4gVGhpcyBoYXMgY2F1c2VkIHVuaW50ZW5kZWQgc2lkZS1lZmZlY3RzIG9uIFNvbGlkUnVuIGJv
YXJkcyB3aGVyZSB0aGUNCj4gZmlyc3QgYXBwbGljYXRpb24gb2YgYSBwaW5tdXggbm9kZSBjbGVh
cmVkIGFsbCBiaXRzIGluIGEgMzItYml0IHdvcmQNCj4gY2xlYXJlZCwgY29ycnVwdGluZyB0aGUg
Y29uZmlndXJhdGlvbiBwcmV2aW91c2x5IHNldCBieSBib290bG9hZGVyLg0KPg0KPiBUaGUgTFgy
MTYwIFNvQyBpcyBjb25maWd1cmVkIGF0IHBvd2VyLW9uIGZyb20gUkNXIChSZXNldA0KPiBDb25m
aWd1cmF0aW9uIFdvcmQpIHR5cGljYWxseSBsb2NhdGVkIGluIHRoZSBmaXJzdCA0ayBvZiBib290
IG1lZGlhLg0KPiBUaGlzIGJsb2IgY29uZmlndXJlcyB2YXJpb3VzIGNsb2NrIHJhdGVzIGFuZCBw
aW4gZnVuY3Rpb25zLg0KPiBUaGUgcGlubXV4IGZvciBpMmMgc3BlY2lmaWNhbGx5IGlzIHBhcnQg
b2YgY29uZmlndXJhdGlvbiB3b3JkcyBSQ1dTUjEyLA0KPiBSQ1dTUjEzIGFuZCBSQ1dTUjE0IHNp
emUgMzIgYml0IGVhY2guDQo+IFRoZXNlIHZhbHVlcyBhcmUgYWNjZXNzaWJsZSBhdCByZWFkLW9u
bHkgYWRkcmVzc2VzIDB4MDFlMDAxMmMgZm9sbG93aW5nLg0KPg0KPiBGb3IgcnVudGltZSAocmUt
KWNvbmZpZ3VyYXRpb24gdGhlIFNvQyBoYXMgYSBkeW5hbWljIGNvbmZpZ3VyYXRpb24gYXJlYQ0K
PiB3aGVyZSBhbHRlcm5hdGl2ZSBzZXR0aW5ncyBjYW4gYmUgYXBwbGllZC4gVGhlIGNvdW50ZXJw
YXJ0cyBvZg0KPiBSQ1dTUlsxMi0xNF0gY2FuIGJlIG92ZXJyaWRkZW4gYXQgMHg3MDAxMDAxMmMg
Zm9sbG93aW5nLg0KPg0KPiBUaGUgY29tbWl0IGluIHF1ZXN0aW9uIHVzZWQgdGhpcyBhcmVhIHRv
IHN3aXRjaCBpMmMgcGlucyBiZXR3ZWVuIGkyYyBhbmQNCj4gZ3BpbyBmdW5jdGlvbiBhdCBydW50
aW1lIHVzaW5nIHRoZSBwaW5jdHJsLXNpbmdsZSBkcml2ZXIgLSB3aGljaCByZWFkcyBhDQo+IDMy
LWJpdCB2YWx1ZSwgbWFrZXMgcGFydGljdWxhciBjaGFuZ2VzIGJ5IGJpdG1hc2sgYW5kIHdyaXRl
cyBiYWNrIHRoZQ0KPiBuZXcgdmFsdWUuDQo+DQo+IFNvbGlkUnVuIGhhdmUgb2JzZXJ2ZWQgdGhh
dCBpZiB0aGUgZHluYW1pYyBjb25maWd1cmF0aW9uIGlzIHJlYWQgZmlyc3QNCj4gKGJlZm9yZSBh
IHdyaXRlKSwgaXQgcmVhZHMgYXMgemVybyByZWdhcmRsZXNzIHRoZSBpbml0aWFsIHZhbHVlcyBz
ZXQgYnkNCj4gUkNXLiBBZnRlciB0aGUgZmlyc3Qgd3JpdGUgY29uc2VjdXRpdmUgcmVhZHMgcmVm
bGVjdCB0aGUgd3JpdHRlbiB2YWx1ZS4NCj4NCj4gQmVjYXVzZSBtdWx0aXBsZSBwaW5zIGFyZSBj
b25maWd1cmVkIGZyb20gYSBzaW5nbGUgMzItYml0IHZhbHVlLCB0aGlzDQo+IGNhdXNlcyB1bmlu
dGVudGlvbmFsIGNoYW5nZSBvZiBhbGwgYml0cyAoZXhjZXB0IHRob3NlIGZvciBpMmMpIGJlaW5n
IHNldA0KPiB0byB6ZXJvIHdoZW4gdGhlIHBpbmN0cmwgZHJpdmVyIGFwcGxpZXMgdGhlIGZpcnN0
IGNvbmZpZ3VyYXRpb24uDQo+DQo+IFNlZSBiZWxvdyBhIHNob3J0IGxpc3Qgb2Ygd2hpY2ggZnVu
Y3Rpb25zIFJDV1NSMTIgYWxvbmUgY29udHJvbHM6DQo+DQo+IExYMjE2Mi1DRiBSQ1dTUjEyOiAw
YjAwMDAxMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDAwMDExMA0KPiBJSUMyX1BNVVggICAgICAgICAg
ICAgIHx8fCAgIHx8fCAgIHx8IHwgICB8fHwgICB8fHxYWFggOiBJMkMvR1BJTy9DRC1XUA0KPiBJ
SUMzX1BNVVggICAgICAgICAgICAgIHx8fCAgIHx8fCAgIHx8IHwgICB8fHwgICBYWFggICAgOiBJ
MkMvR1BJTy9DQU4vRVZUDQo+IElJQzRfUE1VWCAgICAgICAgICAgICAgfHx8ICAgfHx8ICAgfHwg
fCAgIHx8fFhYWHx8fCAgICA6IEkyQy9HUElPL0NBTi9FVlQNCj4gSUlDNV9QTVVYICAgICAgICAg
ICAgICB8fHwgICB8fHwgICB8fCB8ICAgWFhYICAgfHx8ICAgIDogSTJDL0dQSU8vU0RIQy1DTEsN
Cj4gSUlDNl9QTVVYICAgICAgICAgICAgICB8fHwgICB8fHwgICB8fCB8WFhYfHx8ICAgfHx8ICAg
IDogSTJDL0dQSU8vU0RIQy1DTEsNCj4gWFNQSTFfQV9EQVRBNzRfUE1VWCAgICB8fHwgICB8fHwg
ICBYWCBYICAgfHx8ICAgfHx8ICAgIDogWFNQSS9HUElPDQo+IFhTUEkxX0FfREFUQTMwX1BNVVgg
ICAgfHx8ICAgfHx8WFhYfHwgfCAgIHx8fCAgIHx8fCAgICA6IFhTUEkvR1BJTw0KPiBYU1BJMV9B
X0JBU0VfUE1VWCAgICAgIHx8fCAgIFhYWCAgIHx8IHwgICB8fHwgICB8fHwgICAgOiBYU1BJL0dQ
SU8NCj4gU0RIQzFfQkFTRV9QTVVYICAgICAgICB8fHxYWFh8fHwgICB8fCB8ICAgfHx8ICAgfHx8
ICAgIDogU0RIQy9HUElPL1NQSQ0KPiBTREhDMV9ESVJfUE1VWCAgICAgICAgIFhYWCAgIHx8fCAg
IHx8IHwgICB8fHwgICB8fHwgICAgOiBTREhDL0dQSU8vU1BJDQo+IFJFU0VSVkVEICAgICAgICAg
ICAgIFhYfHx8ICAgfHx8ICAgfHwgfCAgIHx8fCAgIHx8fCAgICA6DQo+DQo+IE9uIExYMjE2MkEg
Q2xlYXJmb2cgdGhlIGluaXRpYWwgKGFuZCBpbnRlbmRlZCkgdmFsdWUgaXMgMHgwODAwMDAwNiAt
DQo+IGVuYWJsaW5nIGNhcmQtZGV0ZWN0IG9uIElJQzJfUE1VWCBhbmQgY29udHJvbCBHUElPcyBv
biBTREhDMV9ESVJfUE1VWC4NCj4gRXZlcnl0aGluZyBlbHNlIGlzIGludGVudGlvbmFsIHplcm8g
KGVuYWJsaW5nIEkyQyAmIFhTUEkpLg0KPg0KPiBCeSByZWFkaW5nIHplcm8gZnJvbSBkeW5hbWlj
IGNvbmZpZ3VyYXRpb24gYXJlYSwgdGhlIGNvbW1pdCBpbiBxdWVzdGlvbg0KPiBjaGFuZ2VzIElJ
QzJfUE1VWCB0byB2YWx1ZSAwIChJMkMgZnVuY3Rpb24pLCBhbmQgU0RIQzFfRElSX1BNVVggdG8g
MA0KPiAoU0RIQyBkYXRhIGRpcmVjdGlvbiBmdW5jdGlvbikgLSBicmVha2luZyBjYXJkLWRldGVj
dCBhbmQgbGVkIGdwaW9zLg0KPg0KPiBUaGlzIGlzc3VlIHNob3VsZCBhZmZlY3QgYW55IGJvYXJk
IGJhc2VkIG9uIExYMjE2MCBTb0MgdGhhdCBpcyB1c2luZyB0aGUNCj4gc2FtZSBvciBlYXJsaWVy
IHZlcnNpb25zIG9mIE5YUCBib290bG9hZGVyIGFzIFNvbGlkUnVuIGhhdmUgdGVzdGVkLCBpbg0K
PiBwYXJ0aWN1bGFyOiBMU0RLLTIxLjA4IGFuZCBMUy01LjE1LjcxLTIuMi4wLg0KPg0KPiBXaGV0
aGVyIE5YUCBhZGRlZCBzb21lIGV4dHJhIGluaXRpYWxpc2F0aW9uIGluIHRoZSBib290bG9hZGVy
IG9uIGxhdGVyDQo+IHJlbGVhc2VzIHdhcyBub3QgaW52ZXN0aWdhdGVkLiBIb3dldmVyIGJvb3Rs
b2FkZXIgdXBncmFkZSBzaG91bGQgbm90IGJlDQo+IG5lY2Vzc2FyeSB0byBydW4gYSBuZXdlciBM
aW51eCBrZXJuZWwuDQo+DQo+IFRvIHdvcmsgYXJvdW5kIHRoaXMgaXNzdWUgaXQgaXMgcG9zc2li
bGUgdG8gZXhwbGljaXRseSBkZWZpbmUgQUxMIHBpbnMNCj4gY29udHJvbGxlZCBieSBhbnkgMzIt
Yml0IHZhbHVlIHNvIHRoYXQgZ3JhZHVhbGx5IGFmdGVyIHByb2Nlc3NpbmcgYWxsDQo+IHBpbmN0
cmwgbm9kZXMgdGhlIGNvcnJlY3QgdmFsdWUgaXMgcmVhY2hlZCBvbiBhbGwgYml0cy4NCj4NCj4g
VGhpcyBpcyBhIGxhcmdlIHRhc2sgdGhhdCBzaG91bGQgYmUgZG9uZSBjYXJlZnVsbHkgb24gYSBw
ZXItYm9hcmQgYmFzaXMNCj4gYW5kIG5vdCBnbG9iYWxseSB0aHJvdWdoIHRoZSBTb0MgZHRzaS4N
Cj4gVGhlcmVmb3JlIHJldmVydGluZyB0aGUgY29tbWl0IGluIHF1ZXN0aW9uIGFsdG9nZXRoZXIg
d2FzIGNvbnNpZGVyZWQsDQo+IGJ1dCByZWNlaXZlZCBwdXNoYmFjayBpbiByZXZpZXcgd2l0aCB0
aGUgYXJndW1lbnQgdGhhdCBidXMgcmVjb3Zlcnkgd2FzDQo+IGltcG9ydGFudC4NCj4NCj4gSW5z
dGVhZCBhZGQgcGlubXV4IG5vZGVzIGZvciBhbGwgZmllbGRzIG9yIHJjd3NyMTIgYXMgdXNlZCBi
eSBhZmZlY3RlZA0KPiBTb2xpZFJ1biBMWDIxNjBBIENsZWFyZm9nLUNYICYgSG9uZXljb21iLCBh
bmQgTFgyMTYyQSBDbGVhcmZvZyBib2FyZHMuDQo+DQo+IEZpeGVzOiA4YTEzNjVjN2JiYzEgKCJh
cm02NDogZHRzOiBseDIxNjBhOiBhZGQgcGlubXV4IGFuZCBpMmMgZ3BpbyB0byBzdXBwb3J0IGJ1
cyByZWNvdmVyeSIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFNpZ25lZC1vZmYt
Ynk6IEpvc3VhIE1heWVyIDxqb3N1YUBzb2xpZC1ydW4uY29tPg0KPiAtLS0NCj4gIC4uLi9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpIHwgIDcgKysrKysrKw0K
PiAgLi4uL2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2xlYXJmb2ctaXR4LmR0c2kgICAgfCAg
MiArKw0KPiAgYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSAg
ICAgfCAyNCArKysrKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vYm9vdC9kdHMvZnJlZXNjYWxl
L2ZzbC1seDIxNjJhLWNsZWFyZm9nLmR0cyAgICB8ICAyICsrDQo+ICAuLi4vYm9vdC9kdHMvZnJl
ZXNjYWxlL2ZzbC1seDIxNjJhLXNyLXNvbS5kdHNpICAgICB8ICA3ICsrKysrKysNCj4gIDUgZmls
ZXMgY2hhbmdlZCwgNDIgaW5zZXJ0aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpIGIvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2V4Ny5kdHNpDQo+IGluZGV4IGVlYzJjZDZj
NmQzMmEuLjdmNmUzOWUyN2NlNWMgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2ZzbC1seDIxNjBhLWNleDcuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1jZXg3LmR0c2kNCj4gQEAgLTE2Miw2ICsxNjIsOCBA
QCBydGNANTEgew0KPiAgfTsNCj4gIA0KPiAgJmZzcGkgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZmc3BpX2RhdGE3NF9waW5zPiwgPCZmc3BpX2Rh
dGEzMF9waW5zPiwgPCZmc3BpX2Rxc19zY2tfY3MxMF9waW5zPjsNCj4gIAlzdGF0dXMgPSAib2th
eSI7DQo+ICANCj4gIAlmbGFzaEAwIHsNCj4gQEAgLTE3Nyw2ICsxNzksMTEgQEAgZmxhc2hAMCB7
DQo+ICAJfTsNCj4gIH07DQo+ICANCj4gKyZwaW5tdXhfaTJjcnYgew0KPiArCXBpbmN0cmwtbmFt
ZXMgPSAiZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZncGlvMF8xNF8xMl9waW5zPjsNCj4g
K307DQo+ICsNCj4gICZ1c2IwIHsNCj4gIAlzdGF0dXMgPSAib2theSI7DQo+ICB9Ow0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEtY2xlYXJm
b2ctaXR4LmR0c2kgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1j
bGVhcmZvZy1pdHguZHRzaQ0KPiBpbmRleCBhZjYyNThiMmZlODI2Li41ODBlZTliMzAyNmUzIDEw
MDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYwYS1j
bGVhcmZvZy1pdHguZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9m
c2wtbHgyMTYwYS1jbGVhcmZvZy1pdHguZHRzaQ0KPiBAQCAtODksNiArODksOCBAQCAmZW1kaW8y
IHsNCj4gIH07DQo+ICANCj4gICZlc2RoYzAgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVs
dCI7DQo+ICsJcGluY3RybC0wID0gPCZlc2RoYzBfY2Rfd3BfcGlucz4sIDwmZXNkaGMwX2NtZF9k
YXRhMzBfY2xrX3ZzZWxfcGlucz47DQo+ICAJc2QtdWhzLXNkcjEwNDsNCj4gIAlzZC11aHMtc2Ry
NTA7DQo+ICAJc2QtdWhzLXNkcjI1Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvZnNsLWx4MjE2MGEuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2ZzbC1seDIxNjBhLmR0c2kNCj4gaW5kZXggODUzYjAxNDUyODEzYS4uYmUwY2NhYjVhNjI2
YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2
MGEuZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYw
YS5kdHNpDQo+IEBAIC0xNzIxLDYgKzE3MjEsMTAgQEAgaTJjMV9zY2xfZ3BpbzogaTJjMS1zY2wt
Z3Bpby1waW5zIHsNCj4gIAkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAweDEgMHg3PjsN
Cj4gIAkJCX07DQo+ICANCj4gKwkJCWVzZGhjMF9jZF93cF9waW5zOiBpaWMyLXNkaGMtcGlucyB7
DQo+ICsJCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgMHg2IDB4Nz47DQo+ICsJCQl9Ow0K
PiArDQo+ICAJCQlpMmMyX3NjbDogaTJjMi1zY2wtcGlucyB7DQo+ICAJCQkJcGluY3RybC1zaW5n
bGUsYml0cyA9IDwweDAgMCAoMHg3IDw8IDMpPjsNCj4gIAkJCX07DQo+IEBAIC0xNzUzLDYgKzE3
NTcsMjYgQEAgaTJjNV9zY2xfZ3BpbzogaTJjNS1zY2wtZ3Bpby1waW5zIHsNCj4gIAkJCQlwaW5j
dHJsLXNpbmdsZSxiaXRzID0gPDB4MCAoMHgxIDw8IDEyKSAoMHg3IDw8IDEyKT47DQo+ICAJCQl9
Ow0KPiAgDQo+ICsJCQlmc3BpX2RhdGE3NF9waW5zOiB4c3BpMS1kYXRhNzQtcGlucyB7DQo+ICsJ
CQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgMCAoMHg3IDw8IDE1KT47DQo+ICsJCQl9Ow0K
SGVyZSBJIGNoYW5nZWQgdGhlIG5hbWluZyBzY2hlbWUsIHRvIGZvbGxvdyBseDIxNjAgcmVmZXJl
bmNlIG1hbnVhbCBiaXRmaWVsZCBuYW1lcw0KY2xvc2VseSwgaW5zdGVhZCBvZiBkZXZpY2UtdHJl
ZSBidXMgbmFtZXMuDQoNClNob3VsZCBJIHJlbmFtZSB0aGUgZXhpc3Rpbmcgbm9kZXMsIHRvbywg
Y29uc2lkZXJpbmcgdGhpcyBjaGFuZ2Ugc2hvdWxkIGdvIHRvIHN0YWJsZT8NCkkuZS4gImkyYzEt
c2NsLWdwaW8tcGlucyIgLT4gImlpYzItZ3Bpby1waW5zIi4NCg0KPiArDQo+ICsJCQlmc3BpX2Rh
dGEzMF9waW5zOiB4c3BpMS1kYXRhMzAtcGlucyB7DQo+ICsJCQkJcGluY3RybC1zaW5nbGUsYml0
cyA9IDwweDAgMCAoMHg3IDw8IDE4KT47DQpJIG1lYW50IHRvIHJlcGxhY2UgIjAiIHdpdGggIjB4
MCIgZm9yIGNvbnNpc3RlbmN5IGhlcmUgLi4uDQo+ICsJCQl9Ow0KPiArDQo+ICsJCQlmc3BpX2Rx
c19zY2tfY3MxMF9waW5zOiB4c3BpMS1iYXNlLXBpbnMgew0KPiArCQkJCXBpbmN0cmwtc2luZ2xl
LGJpdHMgPSA8MHgwIDB4MCAoMHg3IDw8IDIxKT47DQo+ICsJCQl9Ow0KPiArDQo+ICsJCQllc2Ro
YzBfY21kX2RhdGEzMF9jbGtfdnNlbF9waW5zOiBzZGhjMS1iYXNlLXNkaGMtdnNlbC1waW5zIHsN
Cj4gKwkJCQlwaW5jdHJsLXNpbmdsZSxiaXRzID0gPDB4MCAweDAgKDB4NyA8PCAyNCk+Ow0KPiAr
CQkJfTsNCj4gKw0KPiArCQkJZ3BpbzBfMTRfMTJfcGluczogc2RoYzEtZGlyLWdwaW8tcGlucyB7
DQo+ICsJCQkJcGluY3RybC1zaW5nbGUsYml0cyA9IDwweDAgKDB4MSA8PCAyNykgKDB4NyA8PCAy
Nyk+Ow0KPiArCQkJfTsNCj4gKw0KPiAgCQkJaTJjNl9zY2w6IGkyYzYtc2NsLXBpbnMgew0KPiAg
CQkJCXBpbmN0cmwtc2luZ2xlLGJpdHMgPSA8MHg0IDB4MiAweDc+Ow0KPiAgCQkJfTsNCj4gZGlm
ZiAtLWdpdCBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjJhLWNsZWFy
Zm9nLmR0cyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjJhLWNsZWFy
Zm9nLmR0cw0KPiBpbmRleCBlYWZlZjg3MThhMGZlLi44OTIwMzI2YTA2NzM1IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1jbGVhcmZvZy5k
dHMNCj4gKysrIGIvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtY2xl
YXJmb2cuZHRzDQo+IEBAIC0yMjMsNiArMjIzLDggQEAgZXRoZXJuZXRfcGh5ODogZXRoZXJuZXQt
cGh5QDE1IHsNCj4gIH07DQo+ICANCj4gICZlc2RoYzAgew0KPiArCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICsJcGluY3RybC0wID0gPCZlc2RoYzBfY2Rfd3BfcGlucz4sIDwmZXNkaGMw
X2NtZF9kYXRhMzBfY2xrX3ZzZWxfcGlucz47DQo+ICAJc2QtdWhzLXNkcjEwNDsNCj4gIAlzZC11
aHMtc2RyNTA7DQo+ICAJc2QtdWhzLXNkcjI1Ow0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9i
b290L2R0cy9mcmVlc2NhbGUvZnNsLWx4MjE2MmEtc3Itc29tLmR0c2kgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1zci1zb20uZHRzaQ0KPiBpbmRleCBlOTE0Mjkx
ZTYzYTFhLi5lMTM0NDk0MmVhYWVlIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1zci1zb20uZHRzaQ0KPiArKysgYi9hcmNoL2FybTY0L2Jv
b3QvZHRzL2ZyZWVzY2FsZS9mc2wtbHgyMTYyYS1zci1zb20uZHRzaQ0KPiBAQCAtMzAsNiArMzAs
OCBAQCAmZXNkaGMxIHsNCj4gIH07DQo+ICANCj4gICZmc3BpIHsNCj4gKwlwaW5jdHJsLW5hbWVz
ID0gImRlZmF1bHQiOw0KPiArCXBpbmN0cmwtMCA9IDwmZnNwaV9kYXRhNzRfcGlucz4sIDwmZnNw
aV9kYXRhMzBfcGlucz4sIDwmZnNwaV9kcXNfc2NrX2NzMTBfcGlucz47DQo+ICAJc3RhdHVzID0g
Im9rYXkiOw0KPiAgDQo+ICAJZmxhc2hAMCB7DQo+IEBAIC04MCwzICs4Miw4IEBAIHJ0Y0A2ZiB7
DQo+ICAJCXJlZyA9IDwweDZmPjsNCj4gIAl9Ow0KPiAgfTsNCj4gKw0KPiArJnBpbm11eF9pMmNy
diB7DQo+ICsJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gKwlwaW5jdHJsLTAgPSA8Jmdw
aW8wXzE0XzEyX3BpbnM+Ow0KPiArfTsNCj4=

