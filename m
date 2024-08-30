Return-Path: <stable+bounces-71576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0691965CD5
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 11:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50041C23C45
	for <lists+stable@lfdr.de>; Fri, 30 Aug 2024 09:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEB21531D0;
	Fri, 30 Aug 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="QV8KJ4Q9"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2101.outbound.protection.outlook.com [40.107.21.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FA3170A0A
	for <stable@vger.kernel.org>; Fri, 30 Aug 2024 09:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010103; cv=fail; b=mXpCBJIhv8pWD7QT1qsNZstloDMMZpNBPiOukTYBjv0qhpBFWaKPRv2rRqezyMBRVBj6uGOzDXLlA7CiUhMlk7b2I0Z23m+jIOmhzuRUhVquPbMycpG+Dx0N853EekvKGgzSL3L4w1P2xCzRu1Z3adtL1iOHzts+i2SU3SzZQyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010103; c=relaxed/simple;
	bh=naHZKF3jVplGQk14RahM0yoRUC/dZUGE6SFZPhoGhHE=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mwzCXta7pRgQFjbwfsawbq4rhQPTVyh8r3ASAC5Cti+SuK7O/AJmqGFfEEXxxoetupN/UWo86E5Bw0SVNl+OwgSDtWpR4iXsCSbmfHlaewAjEH+EO9EtI9Z/zBnHgs9aF9Z/2XOAX/tmFTgOOm0U3p/WYymsUwq9rcveYduBmLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=QV8KJ4Q9; arc=fail smtp.client-ip=40.107.21.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nAnX8JVjZ5bf3yf+lIHbBm0Fx1vzmp9MSVD1glResPNm5S2rw8tBpoXFGbV9HLgKoCM912i5GIDkW3byWSHkTXlPmV+2n+qCvJvYGOPf6juaEikwSa5EUXWik/i9oVNQAhrFXN4qf3jCnOQlx4AT8lFAaKWbhiC1zwTCuhz32NIWpyHSBWiy03NuiTGhfVmb0p0Eb7+n+gOUzC0k9Y98D82cvwI9sg87dYbttB/C7kL9/EjBt0m0GG08gDUr7ywoedQ36tEvVGZZc+99IHaJdC2/J95dBE7DcKnDdrKRplq2xFU3NLDD/SBFVJq18nptrk5b/dx3MtLJ4Grla3A16A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=naHZKF3jVplGQk14RahM0yoRUC/dZUGE6SFZPhoGhHE=;
 b=VWkqtpkRMlwfBl6Lsi/y4HdSFR+vgs575DQjl95hoAbMXmcxygROp9iVNSy2EQK4hNFPf0fv0l+NJBG5YEduLbp3oF0k8+z9FYmm4Ode9/rv1U49rpVdWOwV14i4pCFAHJ++NplnEu2kHRnt3bXPJAhQ4c4dIJ5jtIWP1vza3onwVa6xfKhhyC/pDNOIBGZphgi6jk3X8ZSsAvC4Ns01PoLAs1bdDLhwUvDNJWeM/uclVoBAW7sMendkjMETuock2jCmyajslICXjX6teZrAd+yN4/mjYxpCxud1GUsOyWAdMuiLvbIDZQanqS1vpKU3XytNCqFl87CKOKj4doElIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=naHZKF3jVplGQk14RahM0yoRUC/dZUGE6SFZPhoGhHE=;
 b=QV8KJ4Q9UyAiWlVFDJ5gLrVrPffg2b5EmZzBdqw9oVOuD4m2jcrAdwpcNMDQHBAeQdw1bhExYfFBXTdX1yaHuBiflmTqJtKCfxq+ukeAYJA9F8yvLUTsI82+LdvAOBSlLglY8CDpAmopadU3ZTrMVtDbvDQ31yd+ixfCoqP3ByIZpDwBIkCY48CvZVFxhaoq7a7k/ZtxrVyXpE0gDfz3KNNL5btjZt3WJGXebJfuqo8XrQnEeoB71HNPVT0HHrfux+MA6nAbxCI71of9+EVnAEqcfzGJC2TO+X3uXe896xxlj5mzkxN4YKmgO+3pr3xSt4Y3VTu7OuutVojZBvV4kQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AM9P192MB0871.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:1fb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Fri, 30 Aug
 2024 09:28:16 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.019; Fri, 30 Aug 2024
 09:28:16 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 5.10 0/1] Fix CVE-2020-16120
Date: Fri, 30 Aug 2024 11:27:44 +0200
Message-ID: <20240830092806.28880-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR3P192CA0015.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::20) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AM9P192MB0871:EE_
X-MS-Office365-Filtering-Correlation-Id: 67c19f81-5eca-4981-7b70-08dcc8d61411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R18/IzCJBZyyn13sCIGfXY0gIIXoul39DRs1Zoa2Bl+KnyTUladUPlBYHXR9?=
 =?us-ascii?Q?QgjLgmuYr1GQ82YpQCRLABqJOThBVaVstW5IwMNnpFpYFOSN8NXjdkNC5JyA?=
 =?us-ascii?Q?d3cWJ45l+nCjwBWzB4uPjZmTY/NHY5+2B6u6TIGy6FwvQsh8c7PPDTAtbIrz?=
 =?us-ascii?Q?/l9VdTNnghb4CkdCVfVyN5kmAf4xpzzOy5IqMVM7EDjPAnMJ4D2igU2V3lSR?=
 =?us-ascii?Q?8cdcr4G56U3zF0BBLGfqTNi3gui+Kg7HdFw3tSSRyTpcCLOanUBkiwiCFIkE?=
 =?us-ascii?Q?/KxkVMNNX3XdpRZ/R/3IHK4/capdF9YrpZsABS7/JZTsA652zEaebDlxTis0?=
 =?us-ascii?Q?21hvXEnivG1rLkodgvdxpyZePhbhz4hKwkk/injV8GJSQPZ/Vdbvc6xTB3mR?=
 =?us-ascii?Q?BZRj9Jg/IUYMoUO1M24X3glgz9mI2CUIirdt/rc8+Tk1VVHjcYnrk0xaU7Nk?=
 =?us-ascii?Q?0OgkX+gLzyK0Z9Ux/xkynWpkw21NsHuKDXmZu9Ea1kA8yUMZneuWWK07PRnE?=
 =?us-ascii?Q?9wZS7QGnIgM0BFKi/lqQRtCW3jJtnQw855uWTzPZL+VFZ6nlyXcciWt1Pf8y?=
 =?us-ascii?Q?vNHVjCMa7ymacDue9ing1lvZVJKUwtrcDWuPAypb7uWXOFGn7rjAKHBwPhNi?=
 =?us-ascii?Q?4AsCkaCHoD+qvFdVPwIRKZwEh5wgbrBO3SngzlUkzGCIMIXrfnyB3nCM8QhT?=
 =?us-ascii?Q?LPwlrLWyUmfdnzhU3O7f2NvtdM3JbH8awV5rXdYTEOVQy1/GmmGuh5f+D5Ka?=
 =?us-ascii?Q?Mwaj094GDfYffm9wCFqxHIsBOjSVcmz+HFLpoBk2etab0UVrHvXH+aNYzr1V?=
 =?us-ascii?Q?ZpWtHXnxClsYTborb0i3XgP8fbYXZAIs+73v/vYCe2h8k8BI8DhzieU+zr42?=
 =?us-ascii?Q?Mt9ah18O1lgvINk1s+cZbz91URdWFY5t1xgtO03AQNhhRJ8zC3yEDxeEBD4r?=
 =?us-ascii?Q?mS4V4GJmZ69Q/79LvY0JO3amAMtdcTtEWnIILWRMhLFouk6N3zGblJ3qhf5w?=
 =?us-ascii?Q?alMHsC5stLV8F+V5/RN5QUwMoogoFpsmFtLKWwrbviFv1BJwGsT/mvBMTYjg?=
 =?us-ascii?Q?q6NRTIXrwyYbPx34J5o9sTzmiMzTLvr3sueG9ZJvVgXlC8hppHpmUIrFUBxX?=
 =?us-ascii?Q?K4ecM9f/cxPE/Y/cXQ9U3dLSFwj/3Bk85NWkEjO2tcjebazUpmsF2JuFCvMQ?=
 =?us-ascii?Q?fDilOnEJmDRqP01PjGXqLY8K6OsV6awOWImarqvcF35mhOhUDp1FSUXrzrp7?=
 =?us-ascii?Q?BQ0UAqKrXVwO+D3bo8zrhvAyOlqeEJ9ZquwnGsQesw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u2Kbwdw5lXpcI99MOdsEPmwVw4ezNRUyL5e2zrOaeLCFM2U+U9kspgEjRiT3?=
 =?us-ascii?Q?dTXFNEUGfgyyZdFEomWM/DsHfH1USYIwICkiq65uxmDOXa7lNBcEuYCe9snJ?=
 =?us-ascii?Q?JtkmlDncS+ieFV8BSa5PbsyWJKzG9pNiUrr0/lujYpT7UJ133JZl6AyPbT58?=
 =?us-ascii?Q?UDFAjziRLhDSbQY4kRg6MMbr94Ctjph0XKF4keDeYVycIwc2NExICQfVHI5E?=
 =?us-ascii?Q?VRpFLSrIAj1QzEHjbyVx6c/oxySC5drWSc6X7YFoQmWrHOUMfg8s2JcgFn/Q?=
 =?us-ascii?Q?GO5NoFme+39uDsR4da7faW+F6WpkTwwSmRI1dHR3I89dFOlJ8ultux9/UnFG?=
 =?us-ascii?Q?A1mWl4rWG8eatv5hb3WacY8A1D2pM+2e7zgWC3byn1XJ6BEU5nSYuEa4co8w?=
 =?us-ascii?Q?4d3yJrsYudQKgdBRxQGDJlvOyXeNEdDAjsxvdpu4KJK0DJ1227+HKX16OKvR?=
 =?us-ascii?Q?cL/23Kz9cfiZO6QXWaBfVetjuwrd11zd+w9NbzoN6QiWeQO9yf0N2IHkzU0L?=
 =?us-ascii?Q?HvWT7RGNestZ2wUNziEyUHyzpX5qm3+NL2Fi4Kz5aKR4kPlvh9nPr+6c9bay?=
 =?us-ascii?Q?brtLULSIGtsXf2hSCxSgZBXBuu6XDh/EtbBDwbL96vH1R3+Cj9NSuqkcFvpZ?=
 =?us-ascii?Q?8WYz0efZeBIutiJPZXw6thbcBUjuz3JEkhZalICurAuJGm77xjzpc8tM6x3Z?=
 =?us-ascii?Q?a19b/tLhSwDzYbS4nB+yuGSHopJoKNlTjwZ2aMVMjLzVJfcGCO8XBbhB4pwN?=
 =?us-ascii?Q?HDbQLfbJ4Yd9WnNKYoOfn9JCw63o7uoAyMdbST9W6616iq+wQcJTAne3R/xE?=
 =?us-ascii?Q?mO4XNKQLsn5HlekRRacGwV5AHjyGTmB01EVUOLnkUrm3uUHVEP6joC05YNLq?=
 =?us-ascii?Q?McExbODzrWSWevTBWhGNvSXL/u5mCe6Ly6Q4Vceo1RyJ9L/xNvFp4Hud8QAB?=
 =?us-ascii?Q?ZdVpl4AidS7lmKXSbvojzYDN+GzY1YRbCL+3T2FN7ravOlNqvBQGA4q6NbIb?=
 =?us-ascii?Q?igK149J/9ZRVUSLVlygvqHgCxo51vWyf2bKhmBaV03gmOolJBPgWbKmcwr71?=
 =?us-ascii?Q?jCs89JuTktf3FiE893/jJovrhUVykmG+prTLEcHqmM76JLBbERaG2g2tAoXU?=
 =?us-ascii?Q?4+FNs8qgGZglTIkaGgeHnyhSb5/Tdet8zJD0sOuJDPnb68JetlrbUv2GJjgK?=
 =?us-ascii?Q?RSb3Qa+UmlxOd0iMGtgvMxFvnUHkrAANH7rIJxAcZztltUyA4gcZUPmYNrwq?=
 =?us-ascii?Q?GAvS1C+y0Cih5Z4vg/hIMz7yzDM8IY5vZLBwEWMTU1d4noyTlQJ+/vyFeVNL?=
 =?us-ascii?Q?9cAkapBrvChH/8I2rXCdsCXfTTErFm1EJ3f5GAh63ylcImxeGGYmyiDTIMn0?=
 =?us-ascii?Q?qclbwFWyVV3xIgi8jyZOukmlkA4mceC6HxTksUzIcPSt9PygSSVR/P7MwSOY?=
 =?us-ascii?Q?twRXMNZTbjEHdYWg2wfom51ztlPNrZfx9z3Is2uMzD8KVOmG6dsa/FittfaZ?=
 =?us-ascii?Q?VNvQGosnnDYNo/VjYwhBd12ZXoTqwEfw5EYN55fVyHVX7SqQq/iQLC5cYEzZ?=
 =?us-ascii?Q?7+NAHBLg/Oq44R6/e8gZL53u+hb4iuROtC+h4PJtRZgpkOvkjQAGnMohVCsH?=
 =?us-ascii?Q?Dw=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c19f81-5eca-4981-7b70-08dcc8d61411
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:28:16.6246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEFH+VuAkJzoOLPZn66gNHyaPpCELjOPnBG2xghu45TgKsC2jeojF35MUcJXa/xJ7GV0DWtM9FLAwt5bmVzv4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P192MB0871


https://nvd.nist.gov/vuln/detail/CVE-2020-16120

