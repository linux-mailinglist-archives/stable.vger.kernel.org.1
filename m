Return-Path: <stable+bounces-192921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDE8C459AC
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 10:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48E6E3AAD37
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 09:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 460BF2FF658;
	Mon, 10 Nov 2025 09:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="BfTnUQDI"
X-Original-To: stable@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010016.outbound.protection.outlook.com [52.101.84.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC00A1E47C5;
	Mon, 10 Nov 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766580; cv=fail; b=c+sa9yHXjghUNCVBf5vNEouLqZRrXUF5QT2aG1W9OMCEF7fcIKfShugCifaZ2+MGpRRoGaWmMRRo8IPW4lKSLYkdGushwevwOxNTq3JXo6Hd4F9n+JbON9uhU+N6WNps9rHzBOMDSo1UgAiitmhXunGeFfARn+fAlSGU8P47Z7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766580; c=relaxed/simple;
	bh=x0ka67Wtrv6PMu6+3hS/jlIf+gxnh+4ilOhv8QXL3pk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pBGrLFoP3nAHItV+7WktZtMKvss6NpkUouJqiR2QSRPB+65qQ/yZ2whKhsGLJEtAGIQ0Oob0+YQwOL8++y6CPr4WX/nSlEKGMMBk/Nfi8FxElMTG5BecWgtr+yMlHuiIfFzwqvvxbTvFOAqhmzeSpf73wXny6FEtcRfPD3E4zG0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=BfTnUQDI; arc=fail smtp.client-ip=52.101.84.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TuK3fleAsn+XNFK1QF2KC/USkb7DmVDX2R5jnR6oxHVExTWlOQI7qRX9SMIdX+mccK3OOfX0VUiX7wdEr2PRMcFT4W6z9L0S5yqq302/Cbv0J1eHYiNMrxpyEcXEv8TIgCFfWh8lUszGxGPQLAlCsIMQILbgIOweZtPsuIS45RpV/90oNF8J4xpLaZ1mZLwUC6SmvjNYm7NfPMwaWaRJSLz4HgEbmpZF/1CS+qQkNrOC6cYgrVyPPTWI3csxWtSbhE2eQm/CUwC0lqkXOOz126LHvPXNLgjDxcneBbx93pfI9U9vZKsxuV5tZB81rhGk+zGvUwAq0ShCSUwbH4Dwrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnQ7gglthdaN4xcLqDhNCKsIFLig4ZBv2GfX+MqC7e8=;
 b=nPtTtlXM1fhQ6y3SNobqJMhHmiYqtVFMxUOhoOSYab601ivLyrgJyxnIBRIcCKTW5nNzEYyIg6hq8b7zC7dNdipMzuS/AzuXIIQaU7aDVWshhkcV+iFMH6tSyxCVVivW6e3yTjDDSIibnQPyqWIrBySIV4Z3jVHEGeGfScfaJd89BzxtIgCPfONoTgIjDppsYdyr8dLswgEGmuN+Ub34bF1MtuPhkTjBvJh5Q3VDubssk6CG/Cnv4uRzAf2qa3m4mjIqN4RmE6Ma2feiaFCHVGNmBng2w239tjLh/o7bu4rsXCdns5dzl08I1KfnMhZ6argL/cQEYiih+CbbZoRakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OnQ7gglthdaN4xcLqDhNCKsIFLig4ZBv2GfX+MqC7e8=;
 b=BfTnUQDIXW+OLgJzYxn8WzgiwOuApwKMupDg0DDfUiBqmpnMaDSi0C+/t4g4lT10kiV1B4gHGBcFr/dNrVDO7s/P4PprSHkAmYICGnBsGqEJh14tJEAvJebty39eD/nDMGlJrN47hJ2mFTedlxtRfN/9xB25+/O9F1UYJ3jZrJLyFUmRh/hYeUS5BojBdWZ+wT5M3uCgEbQXiVXEqWnMDkTOEOOV1+oXbxPKQFGv/Kkl1dGwIYZqlcDMh9HWEl9bZ1h4r1U8V0GZIIHhcQbNKGZ4GLh8XULm8RmujOz22ea2ah+I7jhqU8qq0aOphPA/4VCE2uEhjvLbSOj4FMKfUg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DU6PR04MB11229.eurprd04.prod.outlook.com (2603:10a6:10:5c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 09:22:52 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Mon, 10 Nov 2025
 09:22:52 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: linux-phy@lists.infradead.org
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Josua Mayer <josua@solid-run.com>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 phy 00/16] Lynx 28G improvements part 1
Date: Mon, 10 Nov 2025 11:22:25 +0200
Message-Id: <20251110092241.1306838-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P190CA0026.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::31) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DU6PR04MB11229:EE_
X-MS-Office365-Filtering-Correlation-Id: d2234213-48c3-4301-e6cd-08de203ab8e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c1rbwU709e4sWdKSmFPAqCa7tnasygXlSV7rW46GQQ3zKLRXq+twNKTeHamx?=
 =?us-ascii?Q?G4OekmtXrqqPqJ2h56IA34ehO4E/ep0+tIm3KwZeSM6Sb1cZVcP9g++B74VY?=
 =?us-ascii?Q?m015TvrX7n3LySl2jgT+TaJ6lubhgW/OglDF0VR4jyr5bi8pXdVGEABSsMhG?=
 =?us-ascii?Q?wymbMLrUwiaDxMRPiM2wwium1/rpwn/fBJt8bOMs2HxZ9TmUjjT5rcBaSzSA?=
 =?us-ascii?Q?oFmWzPzovjG2kttpOH1O36gIj0fXwS2rs9E9o7QiYe8woNgGLbplvSOsliVh?=
 =?us-ascii?Q?+E6ZFxpbZn+8KkDivO3oz2W+df178cIEMoaLJ/Z6Fc1h2wdFKxW3aDoo+Euu?=
 =?us-ascii?Q?VpE99Dj99rqUc7MsnaCj5TsgfGES3LrzBVPXpRD8WQGk2WyB30glkkQs1ODF?=
 =?us-ascii?Q?ewyQljWunjakhBz2SGUXIV4PBnjRylqU/t31XwjW0ppvn22q63YqV3WDtDye?=
 =?us-ascii?Q?AVQ/2QaJTjmh0UOZXP93p62lOu0FzVy3/oAQIexafpR9PTpohVF+aRAcADLe?=
 =?us-ascii?Q?Rkn0hZC0Nih1xQlipI7AJvi4V6CjP7QTD5ItTPZrKMMlRrIDjgHk4vWeYBpH?=
 =?us-ascii?Q?plkBnZlbYIH3aMT9kGWf5fiBkPsAh4Qve483saWDnfyJSBcrkwBIkBn35l3r?=
 =?us-ascii?Q?grJcWULNH+cKC1mCXvlbwVnvuW3XHP84WFSeG/DvVaG29bMpSS0RTp4Fiw4d?=
 =?us-ascii?Q?kbkUOjkjik7SF6IsIMgNYQpgshkpIyJ5zCy39iACXnCzUUN7irRIw+SN24mT?=
 =?us-ascii?Q?xUpLclAmV5UKfItIV64O8CiU6rZkNMA2OK2xkm2KQ4Y1UfnWSBbv7Ck0550L?=
 =?us-ascii?Q?FXVQGqeH/1+C3ObkCcJGfyghmKZrL34EylEGx14A4+VicfDuhCqo1UZfAkEo?=
 =?us-ascii?Q?LJj5AqCUAY0YQLs/3Vz5DRpbqOKoShfAdgISz3988vAxrz7IprPTLKeZrhcn?=
 =?us-ascii?Q?I1Sx+YlkByPPsV4AfiHjokgj46CFZ1nVXCyF3ujhx7ORRQeczYWypTbqNjUH?=
 =?us-ascii?Q?EKb62l0eKtDMi1WPovtpsjsn/bPh5rp/l3eqcTkOMJ35SW+61tql3n9VogBR?=
 =?us-ascii?Q?r/H+K32jeiH+xMX/BZPwCi/qjWWLxW2zr/dyR/NgpmT4NcjTsxlLYkVTk3aH?=
 =?us-ascii?Q?x0sNqqisENUNMgDFln/6az3tIigTc4DupIgsbli0CDcXIZ224QEsMDU5m4FK?=
 =?us-ascii?Q?PF2xVNetFN1zNTkfzmLdYYzgnwqSTFe9qio8xEwCtqbOHnN66v8gyGOnrWmd?=
 =?us-ascii?Q?QlJCbhZswUQcIcN56R5CNSAWZ6QQKx916QgOoVMiTYKFdN7SSZrGf03RKwJ4?=
 =?us-ascii?Q?bLQtGvecb9ryt4b5W4jlB79phkYGOMRadauyLvF2LLcV56ygtsrVFFrWRVTX?=
 =?us-ascii?Q?OGOnejRCApVs4Eb4XZGpkY5m7sft5fQqmr8rtkvpc288J6zDTAjOhjiauuGB?=
 =?us-ascii?Q?xbGgYqh0ieRwNmSbOC7b2Wo9hPvWrg9H/TZySjqTW3jwDjxmIF/dJwOXxsU/?=
 =?us-ascii?Q?3p2j84BHuBSRlXtAgqld3fRBY3TMvuayF/i7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6GsV4MOoCVs+qt9bVjj+giP0xnZkgvxjO94B/ED1QsOU3uRYLHToWqZFFtE1?=
 =?us-ascii?Q?IBd3Rb368DLCsikC+y2ji1PNRbr5sJCu1wopKZ6SP46m2uJ8Ne6Qu096jLzi?=
 =?us-ascii?Q?kovjaSM+yKv2X8RyONNbwPcl3tYQY5Yb6d03Jr7vOf2QQIcZCe13fSWXVni0?=
 =?us-ascii?Q?phzZe4J2ZkU2jBuK1NT1Rl6O35bB8aI9svW6GDPvgSl04bFM+lxZ0xb1Uxbs?=
 =?us-ascii?Q?jJeN0R1ZZ1o9XYr5747eG7o8TTS6Kmrmki1amt1WeYPofylrZgHrm+LIZPBR?=
 =?us-ascii?Q?F1Fac/NcdzIKXp2wtIBG/mfOT1ykq3wbMOU7AUVIOAoUlTa8Wt6dC3YLYsZp?=
 =?us-ascii?Q?5i/nZU/Yx+C5wp2VGVbmRnSBho0z0bqSoEF13XlRHEB+qFq02wF0/F1r85aP?=
 =?us-ascii?Q?l8t9eXgIXdiRqjZi84Flus0yWeXjAM0evRXHx9DP55o0jA6FXR2mEm/xBchC?=
 =?us-ascii?Q?ZdMHEcH5xrc23TpYwCLSrYbv+1fiuBhjYYJIsk/lcHUjazWk/rdAZ5JQHb1l?=
 =?us-ascii?Q?2SEkfFKDeVaS26GzJl5XXVCAhQbwQWNSXcdUE2ymaCy93tWQOWSheEKP0G+X?=
 =?us-ascii?Q?LGJyhO8jmjQS2j02ndJlXdMT0IHTiHkeM0x4LxNy9pi4FOLQLAvEHPvufGL+?=
 =?us-ascii?Q?j/WTqQO4AaQeYA8gHrA8Iir/rDYgjykCLQfTUP5yBWMGaiJnv4OZa4LBNM81?=
 =?us-ascii?Q?IM6F3rZPrgah3I9R+h+9h3EmqJ/Vebo2RSK2JERdQk9h1OwOgFW38W2KYPkz?=
 =?us-ascii?Q?K0GTpeSdoRoi+DznEG/gUnBe+0TaBuCZirjYCUBie1+gr+niQ0iT9v7oHg2T?=
 =?us-ascii?Q?ROoTPxb4fdNJMgv6/Z2tW63r9gp6vagoG1To1MSxjKz0YB6gU1Yj9QxtxeP5?=
 =?us-ascii?Q?rBsIvzF8HzGbZS/DP9yAISRtf5UScv0oUrNZV5Ej94ernK38MZ+rbuAhN6E2?=
 =?us-ascii?Q?xlZ6/WaLauzMoafcqkJtWF5WUZzVH8RLI/MuVs67js5vhgmkmGW0vzt7ga8j?=
 =?us-ascii?Q?dOEbfjv2UUTgbAyb3GGmFmNy6cYqQC9gB2K45yg5AwfNm1vdhVfUhg31CLwt?=
 =?us-ascii?Q?x40gxQ/tXf8cGjLRWb+4YwVkKnroE+oGuX7H+n/p674nT2e73W0OX6Fv6xVv?=
 =?us-ascii?Q?I1i3U5Mnz0c4NivLtZNPNiEVTSvGv+712tFfwiAcLYOt/cMDr6BffGLEjLIg?=
 =?us-ascii?Q?eCJ5YUp1fnQxR9HJCESazTImXxz2H4awBWJZYGRfLCchPYexbN6bSlSUw4T9?=
 =?us-ascii?Q?lS92buQKHbANeGpet/WxyjBhnkQpM+GFq6rmhBcwDR/978HfN6r45xU5wpyC?=
 =?us-ascii?Q?Ex/oq+htpvwHDNsPM1Wr/LqTOJOsJD5IhzPhJ7njMUACWEzdAKpuf6bvdAAp?=
 =?us-ascii?Q?tDrq4yhCuCifxsYEeKfweXYiUSfvwgkv5HtZfET9/WBuLHg77o72VFwOsBFG?=
 =?us-ascii?Q?gU+n3DOP6K64mAWiwtjkBJPW/QugMKA9BXMTuGFGpkrqIA/VmkiCD4Tiu2Uz?=
 =?us-ascii?Q?MP5D6s4WoxfUhq9BddJ5I9Rw+yRSpKVmSAXu0C/RYLT0gBJ2UcKOI7QuEGqQ?=
 =?us-ascii?Q?8sBwGV+2eT4LDifDnYocavk7L1KCg+ber6RzpwaQiThY5LKLtnvsk2bHpmg7?=
 =?us-ascii?Q?3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2234213-48c3-4301-e6cd-08de203ab8e6
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 09:22:52.1164
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k51FCfHqw1/nOxYp3UpvPjOEIXjiAXbAcHgSQqizUsKI1qhqrFY4tKclX5eYq52qob55iwuK6csvhFHfoAAxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11229

This is the first part in upstreaming a set of around 100 patches that
were developed in NXP's vendor Linux Factory kernel over the course of
several years.

This part is mainly concerned with correcting some historical mistakes
which make extending the driver more difficult:
- The 3 instances of this SerDes block, as seen on NXP LX2160A, need to
  be differentiated somehow, because otherwise, the driver cannot reject
  a configuration which is unsupported by the hardware. The proposal is
  to do that based on compatible string.
- Lanes cannot have electrical parameters described in the device tree,
  because they are not described in the device tree.
- The register naming scheme forces us to modify a single register field
  per lynx_28g_lane_rmw() call - leads to inefficient code
- lynx_28g_lane_set_sgmii(), lynx_28g_lane_set_10gbaser() are unfit for
  their required roles when the current SerDes protocol is 25GBase-R.
  They are replaced with a better structured approach.
- USXGMII and 10GBase-R have different protocol converters, and should
  be treated separately by the SerDes driver.

The device tree binding + driver changes are all non-breaking.
I also have device tree conversions for LX2160A and LX2162A which are
also non-breaking due to their partial nature.

If I were to replace patterns such as:
	phys = <&serdes_2 0>;
with:
	phys = <&serdes_2_lane_a>;

then the corresponding device tree conversions would also be breaking.
I don't _need_ to do that to make progress, but eventually I would like
to be able to.

In order to be able to make that kind of change in a non-breaking
manner in a reasonable number of years, I would like patches 1-3 to be
backported to stable kernels.

Compared to v3 here:
https://lore.kernel.org/linux-phy/20250926180505.760089-1-vladimir.oltean@nxp.com/
there are some new patches, but it overall shrank in size because I
deferred new features to "part 2". Essentially, v4 is like v3, except
with a better plan to handle device tree transitions without breakage,
and with the following patches temporarily dropped:
[PATCH v3 phy 14/17] phy: lynx-28g: add support for 25GBASER
[PATCH v3 phy 15/17] phy: lynx-28g: use timeouts when waiting for
 lane halt and reset
[PATCH v3 phy 16/17] phy: lynx-28g: truly power the lanes up or down
[PATCH v3 phy 17/17] phy: lynx-28g: implement phy_exit() operation

Compared to v2 here:
https://lore.kernel.org/lkml/d0c8bbf8-a0c5-469f-a148-de2235948c0f@solid-run.com/
v3 grew in size due to Josua's request to avoid unbounded loops waiting
for lane resets/halts/stops to complete.

Compared to v1 here:
https://lore.kernel.org/lkml/20250904154402.300032-1-vladimir.oltean@nxp.com/
v2 grew in size due to Josua's request for a device tree binding where
individual lanes have their own OF nodes. This seems to be the right
moment to make that change.

Detailed change log in individual patches. Thanks to Josua, Rob, Conor,
Krzysztof, Ioana who provided feedback on the previous version, and I
hope it has all been addressed.

Cc: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: stable@vger.kernel.org

Ioana Ciornei (1):
  phy: lynx-28g: configure more equalization params for 1GbE and 10GbE

Vladimir Oltean (15):
  dt-bindings: phy: lynx-28g: permit lane OF PHY providers
  phy: lynx-28g: refactor lane probing to lynx_28g_probe_lane()
  phy: lynx-28g: support individual lanes as OF PHY providers
  phy: lynx-28g: remove LYNX_28G_ prefix from register names
  phy: lynx-28g: don't concatenate lynx_28g_lane_rmw() argument "reg"
    with "val" and "mask"
  phy: lynx-28g: use FIELD_GET() and FIELD_PREP()
  phy: lynx-28g: convert iowrite32() calls with magic values to macros
  phy: lynx-28g: restructure protocol configuration register accesses
  phy: lynx-28g: make lynx_28g_set_lane_mode() more systematic
  phy: lynx-28g: refactor lane->interface to lane->mode
  phy: lynx-28g: distinguish between 10GBASE-R and USXGMII
  phy: lynx-28g: use "dev" argument more in lynx_28g_probe()
  phy: lynx-28g: improve lynx_28g_probe() sequence
  dt-bindings: phy: lynx-28g: add compatible strings per SerDes and
    instantiation
  phy: lynx-28g: probe on per-SoC and per-instance compatible strings

 .../devicetree/bindings/phy/fsl,lynx-28g.yaml |  153 +-
 drivers/phy/freescale/phy-fsl-lynx-28g.c      | 1271 +++++++++++++----
 2 files changed, 1134 insertions(+), 290 deletions(-)

-- 
2.34.1


