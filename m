Return-Path: <stable+bounces-50167-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27999903F50
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 16:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26B7E1C22D21
	for <lists+stable@lfdr.de>; Tue, 11 Jun 2024 14:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641C12E61;
	Tue, 11 Jun 2024 14:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="lw7YZfzo"
X-Original-To: stable@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2037.outbound.protection.outlook.com [40.92.98.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5C1171D;
	Tue, 11 Jun 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.98.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718117837; cv=fail; b=SC86WaOcLdqwyxyiG+P7l/Ap+5dgtURrN8vMDSs/ySIy46C1e+NM2q+QLVKCiX4Zl6uEqd4VuYJxd0tkh6DHe1ny9Ljnu4n+lQNPH6dUqStwAe16RkaAKVI2i8FIv9d5Fr+t37WxB51wF3roaP6NVTyhfjPeHbkFnM8DoVot+Lc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718117837; c=relaxed/simple;
	bh=N38Q8xF7MsPB2kryy6G89J5rz7NofpVdY4O75aiwP5s=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=FElPt7uRctRWvoIcFZ6SLJ+kJBZ8QUOLWhEPeECUFQ88k5BivFBKjQOPakQzA+9160sFaVbtvo+DM/b7vpZ2PLR45RxNKsfTM4m6ZNV/kVqv9ReRDNNPymaD4V9tQD+vsLYMS8cQg1uNFZLiD+EXzXI5YnkyeH1l9F5vJ7jhmEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=lw7YZfzo; arc=fail smtp.client-ip=40.92.98.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJH+zAm/Ic7Ekd8jw4GeVdd/GS29za6PMSEcrsShtRwQ1tqGMO93uG1M6fSWJEkzfF9l9gkpgkWfvVU30yQBlMpHYLFzvcogqNPxI8Q9GCS2Xtu/j1hmp+HgzDoPfD3/bpgJ3OZakWATR5K0HedIEyZizg+/EtwvUPNBnk7GcQSjU0DGzC02ScpwFgw6MawG2DMbxCfXGhM0XF9DMxe0haNuS4bFrd0RDXyEeq+KPA+y2DPGX+5nFN1YS4I9ucsv6QiXRR9YXDAodlopJjh8uFTF3jMT8AJkoGj2Wti368fgUJNdqfvgUnPVEzTAeHEldpXjgp7ZoQfEU9qKa5p5oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=coxgJywr2MkrvlAobPgWnvOAnhiJPEG3/m6SOlSXgVc=;
 b=TeF9EAzpwRLkl/y3i+jigZuqKmLXmLZ/7ne0qp115bs1GkLBNKCH4lNZoblroZE2xH4XvyEqcK38E46gA3md+0M7mmwCSE0himcq7v0/pltKRffllgCbHrM16ngDLNjXrLyFVsGtt1loseJzGGNYjV01aeSeqzfQX71IzYKs3oAfZx9o94YAhMbwOyBBgDTEWPXRrlPcNV6o3MitZAomQSkRQ/acoH2e1oqqvDDhr+cgOOwKPLxjc5O8/4gXHvMlqi5jBwXK6HupIs6EVfphTCo4WiW6l4q1pmVXIAQu66kUS+vauHwA8v0yBaeRkvGNNj6y6YHxibIJHXfGqYEhvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=coxgJywr2MkrvlAobPgWnvOAnhiJPEG3/m6SOlSXgVc=;
 b=lw7YZfzo62Smx3RdrEopyitSrQlpozY/jGkIQnNe2uR6KRBe1zYU7f8VLIw9B6va3XIoOc4Ul0ePnXQ14IN3M1kZqQgFgwQitk0WNQQ5mQB+OkgWgy/RGVw2pR9b2Tms7I5IQt8pkWdSGnwhOIPv8YIr5ZggOqDoEeDjwAaLCd0AqQDlh+BLkbZ6J0vEdmp6F9gq+RP1/qozjV6d2QJ7uGwofjQ73FExrSUCECdQiTlcGWHYVq4SH9+fiTHcuuE4S0BPtxH1R6BAX1jeRzT4muFFwExZ9TdRnaiaVrIDh3CmUZ+KpC/PofXdZhX9O7w7cK6W5eTkNYR9lIr4UL1zKg==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYCP286MB3752.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:387::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 14:57:11 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::85b8:3d49:3d3e:2b3%5]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 14:57:11 +0000
From: Shengyu Qu <wiagn233@outlook.com>
To: kernel@esmil.dk,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	jszhang@kernel.org,
	devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Shengyu Qu <wiagn233@outlook.com>,
	stable@vger.kernel.org
Subject: [PATCH] riscv: dts: starfive: Set EMMC vqmmc maximum voltage to 3.3V on JH7110 boards
Date: Tue, 11 Jun 2024 22:56:41 +0800
Message-ID:
 <TY3P286MB2611936BD43C24D34B442E6D98C72@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [j4G3/GfiQIV3MZJQ/VgtgGP0dqHSsC51B0/Oz8Idb0A=]
X-ClientProxiedBy: SG2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:3:18::18) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <20240611145641.24122-1-wiagn233@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYCP286MB3752:EE_
X-MS-Office365-Filtering-Correlation-Id: ca733a1a-a014-4d22-9f42-08dc8a26c5dc
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3hhCrx2p8dqnD/jiLnr8VqFKXnECw0o42U6H3o/HKKWAmraMTajeYYTssLi+/r6xVvbUaEj1qDNaX+9dOyPMoPtPFP7GVFIZP+7HY9O7NpGifl3db+GUxJPC03gkRNUbgOl8h3y91WbdKzLpRhtnJmRpv4AoqWfzbJTvjX2W+wiEt36mivxRB09bnfIR1n0i+44zwRM7y7c2cHRBNHGZd1dFkWUfq1eEPp9Mz/t1gS7Z4VIKh+ML0TAbLcA1PDJqPuSWvJP4YeUR2gvQXt1Aw8Gjuprm+reemeCFCsOJZ352stonGFWoRisciBGGpcCzE6aUz5gMDMYriZ61O8v8YITyk+vyjicOisau8dmIlvQfaIZPUrBIiN4Vq6KcLYhxWJplVd2KBHej5awF1rO1kOSyY1veNWfKvD5EmJMG/FTWFsZe19Qi2rSRCQOXX4a5/tvyyeLh9MFHf3HetuxyqPSXHLuJO8CF9Njr8ImyuprROiHX21HEnEDRG2v8U1BBnq3N/4wFOwheW+Hjo6KX/sQRBlmCGpzdlFufgaPwMTv5EzcLtSM6X/g4v9HfFP57PBwRIn8/m0X8BfekYPcD34UvPvWffPVg7P9aOxpMhvYhRCRYb6BAA3vvFW698SVHKoGrN3PnDKjThy+Kk4XDTVfjzgis2T5UBQedAnnbVo+SsayKMUrlnPV7/9V7oKVVifxflhE5goCuHaMKijL2Pe4rrSiquDREQc1LeqemXLPtCTXbHZlqFQt/F55x527a23udrb9TGbIud2CjY6hDI7BOMQJeC9QUNg=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|461199020|3412199017|440099020|1710799018;
X-Microsoft-Antispam-Message-Info:
	ksSxYoeFzZLLJsnnsoQ6fNXm9AV0TIw7Fvzex0WzPYfQJUGVSQqdUmEb8x+JIH22J0r8jtwMTz/xsBsEL/uQsXAyt/Apxu0ImLTXt+ryvUFOXNGuiFz4UwuKinT8RXltTsiTGxbd1OBcQI8gfbWd0z8a7jAZMhHtK9lDAaqtGD4ygV/idPckeLOvehlspeTml2wLe946n4tAa9zy+6OMPw2oRE/QHvEdbSzkkjeUIkeXfK2KATz5wVAHn1JOSmfja46lSHqmSmRnEkM/LrQ9mIa+cQ8flrdeCVhVaDkxowPP2AKp+mfCgQbvTvX+3Kx6MWPMQYSdlNLmk9m8pcGqoOy/HDCEqTHWGFJeVwTq2t8AtFc90CFxpKeJcW1XkBthJbcLLcVpKJXpizpUzEO9poSloPwUytlK4W0yYqmgisdOXjrElOLBT8Pe97MrQpE/BPItDa3hq9XDocNpX42anLLFcEmfyPGJhBHk/DNN32dCZ2xpFTeenMqKj0gFZAnSfg6AgN5zwLdPtSOoOkdfrPIYU9HNq+J4P7ttgQItP99s9P4nTW8X75c70DDhQ3+qwZhiwe7ZMQJBhec35ekT4RpgZ5LrU2V9UFYeKEFhU72LLWoWhGhMouPTXA0zdmd3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cvw9M/qhW5HjMnmuvknkat8nLHOpGTt//dZOxHuMzWF0sxQqn5dqSH3M318J?=
 =?us-ascii?Q?5P43rKf8RbLErIGC/VDPi49GIspEli21Cjx9gmIRX68IIqHc8b/YrjwEOUCU?=
 =?us-ascii?Q?zU91EKyD96GGB0P097zCUrV6dnlYxBtikwo89oUhsvFaVBnDBP+HoCFwwBB3?=
 =?us-ascii?Q?kDcsmJDSqVnHpsFoeiK/zxBGJMycpMQ9sR7I7Sh0de41YW7+b/nimFVLqhB1?=
 =?us-ascii?Q?S+SNkGjT8KdNIykfU7Tjpxzp4E3rl53OsqpbL1qptq49kgBGbUKYcnA449c0?=
 =?us-ascii?Q?5HWQ6NorEJ6i0pErVwVBHsJE0Z+N2gZA8P6iTjeZX8D7plaKC+5J8HrRRXbJ?=
 =?us-ascii?Q?icS25XamYQhUXBZh0VZ/EPJ43Cfb2HmZjOasEuEaHo4vDP+B9cG+Ik9RA7ea?=
 =?us-ascii?Q?DUAewKk7Dbu8eODvik1+WtALz4aBA46N+nFt1A0AAfNjLjLO0cgO9I3VNdUJ?=
 =?us-ascii?Q?pU2IU0XdMoUCL3/3FXAhAg43YZ38VDE/xGLPsCC3lYb4jSKnv56kKz4TN0TK?=
 =?us-ascii?Q?vhougb2D0+48shrWuFWffcSuJP+mBf7odh4la74+Sau8Yc8gUIksdQ/IBeyh?=
 =?us-ascii?Q?GZd/DRtBU/sse5/LqNy4k//43sjEwQmHG5nWCnm98WPeeVzcGR7LZ12l30W6?=
 =?us-ascii?Q?ecNYq33NadmZTMsfVbHpbakW6SGrMd2rdtr8wvKGShaZRA6lyCGEyLT+LH7/?=
 =?us-ascii?Q?bULw3qcrFlDfUhcTL5WmKq1CMQcp932GT4e48BABJJxau/ZbSm2Rxm2LE81A?=
 =?us-ascii?Q?TSFkPzBiScIXbxvGcXjOu2bIzC65QTHbwCTaYn2YlD4PXP2BdGjBOLiBQazT?=
 =?us-ascii?Q?txADc9dImJXDsRXPhw067NR+wtBi4cxTb0UbsFER8DI6GDbebXE/OkBPiuMo?=
 =?us-ascii?Q?RjpckFjRYVmdkjYp5B5vlfNSeHINB8NLr4fqXZDooaG1lO8JBsPrMdNf8EXF?=
 =?us-ascii?Q?W2tOIGS3V0RM9YbxDE//ZAPjxaj1TthS4IhEwneK9F2an26+M3tndiKx8tUu?=
 =?us-ascii?Q?xvIkG+4P57g2fMK/6XDJAXZzvd/L0Fqay663da8jHOerLh5tB+poinE/6Obw?=
 =?us-ascii?Q?u4VXd2rukAnfI6/m3Zj3X+VRr3xtddb9RdVIf0HL+ZBLeu4IMOlPT3PRhgBO?=
 =?us-ascii?Q?mbVswlAquujnJr9ufVH0mD06eTOZT0dQzp4RbWBJ8bxvVERpEqKmc6uitTny?=
 =?us-ascii?Q?2gY0hgpBjsdHzzu+6PZv1jUwf+ob8F+ctZBnqLQF0rZAL21XaBPXKJESN4c?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca733a1a-a014-4d22-9f42-08dc8a26c5dc
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 14:57:11.5468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB3752

Currently, for JH7110 boards with EMMC slot, vqmmc voltage for EMMC is
fixed to 1.8V, while the spec needs it to be 3.3V on low speed mode and
should support switching to 1.8V when using higher speed mode. Since
there are no other peripherals using the same voltage source of EMMC's
vqmmc(ALDO4) on every board currently supported by mainline kernel,
regulator-max-microvolt of ALDO4 should be set to 3.3V.

Cc: stable@vger.kernel.org
Signed-off-by: Shengyu Qu <wiagn233@outlook.com>
Fixes: ac9a37e2d6b6 ("riscv: dts: starfive: introduce a common board dtsi for jh7110 based boards")
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
2.34.1


