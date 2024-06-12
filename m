Return-Path: <stable+bounces-50222-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6F905089
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:38:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25E572824A7
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 10:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB51F16EBF3;
	Wed, 12 Jun 2024 10:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Z2gWX/CZ"
X-Original-To: stable@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2027.outbound.protection.outlook.com [40.92.99.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B607216EBE8;
	Wed, 12 Jun 2024 10:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.99.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718188702; cv=fail; b=efqqVBInmC8WlnbNXgs1uSe/jQ5WHsVhMgUkimg9T923UhHyVJgqAfXmZ2aXd5ZwOThC/b/87yQ6S6Pfg9dXwpBOTdBKjekN8uH1lTN8LYmgoD9d/zjv6kioA54ZMt1Bm6/zmYY3baAhX9JkcIXuBUZSdgIliCmFbLeU9zQ7AWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718188702; c=relaxed/simple;
	bh=+XUVXU+GnYeMP9gQXZx51MfXjzuOQ9IMDc1KSz2WNnk=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=HPkpozhXbhE73jyfWliUfA8N+5+1zMJDgg4mHC/icVfz6c2uDy09uqoDZbO749V5ysEfrwG8d2v1WK7NLnN3CAQ3MdxuiQS8mcJrexw02uJg5VdVtrLkQNrkYiziSMN9XUdYJKBs2rkP8llZa4X2qg3Bcqust1D4KCFLzPdkaS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Z2gWX/CZ; arc=fail smtp.client-ip=40.92.99.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOMPYWp7M+OYAacCHnyNiDynkKzsCkAyEuvXR1rU2fLdSmEulD5m4VFRRs6kDNyRqzE0gwVInQwaR/KvPKMlhkjSBI6EKkKN+yiRajyCBxoglFHQXuQ4xp6PoJYtZlTinGAqoJ0Cu7M4AGzh5xY7Ra868EvgIRFHXXQrc68i6kq1qcNX8NVYyYJPz12FXfVqP5acglR4m5ll+guxiuKCJncbfdCXTD8Aa05aPRR3awOss/jgjajB0r5YlXaEzIUIwcHTGOll0PnroOQMYeLCdBr2aSkWMtk2ayluRIWZEHYkhwMcGOe9FyVLdljEerT+lLBKb68XD6+rP48FY17L/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BGVrSRCvjD5dJcnAsvpt9t9djgnirPYJ6kPJLhgjknY=;
 b=IpIVKS21UkGSZVTlkSlf8+E4s1MFGG5WEOF5Xaf0/S/EiM/lflTW/IeIehUxibD/larcEH5DV3Af5xkJSmMuziLaO02X4jLwZKJILEkjpZqJLSMdTaY8TAX78osFaG7tjFqlJDsyiijhdTujgfFQ5F9RZ2RUQs1gBK9aWUVxfuCZzL2EjRbWZkjIAuxFcW8ciEZmMdohtkgEggGozRROq8CIYvqMrrBfXFnEY4QKNtBtLQP+Ij+msE2lYH1RUJ756HRy+wMYovzz7YCOGGbaVuo0ZAW2Fus6/3qdoqka3GpWcKdRqvGjocYNPbxdqfqN4FutS/3xbJLZ57eapgIAUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGVrSRCvjD5dJcnAsvpt9t9djgnirPYJ6kPJLhgjknY=;
 b=Z2gWX/CZv/Db8yhzIGwnMs/qGtksnyoAYCxRjsMESJIcS7dX07qeNiyesZwVIgcaJUCMjZHwtlKpZF07iXsBg7QlrvQMp2c4JHmxNQRRCaVwwiMkY75u6KxSIyt4wXsoH1hbXWBvrw7z1kJHT6EYVjExBwaudfniLS6fD6zY3tBlUtZpEQVbJ3hGfXVQN/GS2o8R49hLbF6WUjbJxRHnWVNrhxfNf8BciSH5jAGZoy5e3rMKaNuEb5QyTNXLv1pe8/BaZgiPA3yLqiWhbxPoNtCvNlpqGyF6puqfY4EIKawKgcrVMxXnyT8Rl4mP8fM7e2XARTj3HN+NcsQobF1ctQ==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYWP286MB3208.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:2d7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 10:38:16 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7677.019; Wed, 12 Jun 2024
 10:38:16 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: kernel@esmil.dk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	william.qiu@starfivetech.com,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards
Date: Wed, 12 Jun 2024 18:33:31 +0800
Message-ID:
 <TY3P286MB261189B5D946BDE69398EE3A98C02@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [G87vWAOj5j+EnV6LHJTQcIMi3nWtEb0LNSHZCwZ0pFM=]
X-ClientProxiedBy: SG2PR01CA0135.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::15) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240612103331.1475-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYWP286MB3208:EE_
X-MS-Office365-Filtering-Correlation-Id: 93b217a6-a3dd-4ca0-2101-08dc8acbc4a6
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199020|440099020|3412199017|1710799020;
X-Microsoft-Antispam-Message-Info:
	IOFDULolZfQjmEf6+rPOAZzBo5mx0jqHG0mOQ2pyo6QLORaO+A+tc2CHruNrxe1bDQMpGuS89bMmx4Wn3rHW85g5eBbeJaCbTDLwcgfbzNMBwqDNW8cefXXFsQHH0sB0hMUVaYW0/XuOxPQHg65HMFktPbFmRl/46TFRDvYxZRu4tAiJxsypN4dOkY1g1IrZ1+fkaIz9Z8EN3iJXa/grIyJh6EA+k5v34uNir1AaV+b0c1ZF7mJ6bqtHR3uubhF3phwB/uop0rORnuFVz0Lo8Tg/ELQQROgAee4ia9YOfOqJw+K3QZkfj+dvNhY5elkD7R5zeqK9jLQZJbhiy2FzJHWz8DpF6hSn0L6TZBJO+0gGeRBkthKz81Ga9ak4nBqJBS4ytwQCgqg7hOmk30e1a8Usfo8l69wNF2gCf6+/n6P+6DErdI+heU9ubWrpJXXMQ0vG6fI8jYfz8wfrh1q2r+w8MnggYAmwm+cQi7Y10ZsHgWgUOovXWeiJOBH84Ou4+lEQ6e6KJKmfrzBZH2P5m2iFPcfn4E0MnBStgfA8mDHCX+ImkdKvWJna0ZztOFeJvgAeY1emnYhca4+kPe+Wvm01Dk4r6wB4VQtrVIzErXSpyxQoxr8bDAd9/e++wBrp
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CM7Li2Z+dk+l04R4/ZCW+vHrsuJpcqOdL6EENMZslva7cFGxVR7xDpS+uy7A?=
 =?us-ascii?Q?N/N/OdLuC768uYf0fIjXfLyX+vPEmQAUk+j9EOkqJW7cTUMgYeOa7jX/Il3J?=
 =?us-ascii?Q?vEGCd9nFkiZs7IzGFHcqxxQmcmRcCAmItfkZzG/gbckH51aAFC51ViEPADP2?=
 =?us-ascii?Q?nRhlPD3LfQHqVzWvaB65zCmk2YpmTf0+gbTG76n5faGeuOggWA4I+XXqsN4B?=
 =?us-ascii?Q?ylZ5UyZUlN7N6gjkFe2GIHx6rHI4/5H/X9g4RIS9zw2XG3cAC/s4QKriS+DP?=
 =?us-ascii?Q?DfqQrw8gR9lqYokDiiTpAi/6EtO3FOIyE6POjrpv9u/+gUCC81RtDCkBOWZg?=
 =?us-ascii?Q?GnM5U0FzgTH0qwW+sHKukoU/B3NK55itHFSVcAucBYSRIN9q1nCe5HdK7KCd?=
 =?us-ascii?Q?L9GC0s/x9jl4JXe50bQ9d7rp94bsbDFU7ixvCWLl8sWRpjSRJ+WR6EfGhjhI?=
 =?us-ascii?Q?zodoV5lIPvNj7kRDYjgOUvlKD6NTydbnmAWB+R7xBTDmFa+X39xD6TWOGltz?=
 =?us-ascii?Q?fg3HYKLuEbJYQ3JhbhYmL/kyCRJrMWdtkSxpRXiX0zw+1/RwDXENwiWY+Y+n?=
 =?us-ascii?Q?0bgv1hKKB7YYa/d5w+OajaT4XLpQ7OfdycSEd/p+ScsYqVEeP5TEkqIc1G0O?=
 =?us-ascii?Q?2H58ltv7JkKFoa/GiCbfsqQWuwwAkBdgM5E3WbVsB8BzlotSJxMRdLlT+yc5?=
 =?us-ascii?Q?l0yySN88TfOsB+a199M4zKdh8F9ToHiel1ihAzrbolOWRg1fV0DUKDSl1ayo?=
 =?us-ascii?Q?Na3VQ9Ii8oFYD8L+TR0iF9J/w+6pcV0UQbVRbGCICV9bDoiKutvlH0UL9jEd?=
 =?us-ascii?Q?KpAc2wzEnIi5QvtQcB1vwBp+2DdUM+YwElkTgXZ5yoUqOLYDo8Jj2KkkUet6?=
 =?us-ascii?Q?EuQuA6LbR8ezaPdFtDEOkOZZkfzvg53eD4wsGE2m3cLIBRSFwxJCkLMTX1To?=
 =?us-ascii?Q?Wb3OfMxEy2xIcg7LPpWSOnHfH4hZ8uuMiZg218QlXkL9Ag/r+OHJKYgAqcqw?=
 =?us-ascii?Q?8rl29l8Jh/bpoOmM6RNDnzNAb/DEv8poIEsOE5VnJGkaFQ2PArQhvhVscZDG?=
 =?us-ascii?Q?8zEFyD/hQnsPwk2BOvTR2zvFAHIvbpEyOhfxRqr/Z1y81oRShc568jCYLjJq?=
 =?us-ascii?Q?XrYce0aSzaE+Fek2EPNb1LwFskMu6WP1zPjwLbYcMqMEfI2dIFR7kPGScYI+?=
 =?us-ascii?Q?wXR23d0cAAM4R8skezQWjlhYokHsuKV5yMXvcZdnWqMSrx5lWT7xrU4wv1A?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b217a6-a3dd-4ca0-2101-08dc8acbc4a6
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 10:38:16.6270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB3208

Currently, for JH7110 boards with EMMC slot, vqmmc voltage for EMMC is
fixed to 1.8V, while the spec needs it to be 3.3V on low speed mode and
should support switching to 1.8V when using higher speed mode. Since
there are no other peripherals using the same voltage source of EMMC's
vqmmc(ALDO4) on every board currently supported by mainline kernel,
regulator-max-microvolt of ALDO4 should be set to 3.3V.

Cc: stable@vger.kernel.org
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Fixes: 7dafcfa79cc9 ("riscv: dts: starfive: enable DCDC1&ALDO4 node in axp15060")
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 37b4c294ffcc..c7a549ec7452 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -244,7 +244,7 @@ emmc_vdd: aldo4 {
 				regulator-boot-on;
 				regulator-always-on;
 				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
+				regulator-max-microvolt = <3300000>;
 				regulator-name = "emmc_vdd";
 			};
 		};
-- 
2.39.2


