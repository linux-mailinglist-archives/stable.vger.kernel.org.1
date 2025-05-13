Return-Path: <stable+bounces-144111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC128AB4C3D
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 08:46:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B276465DE9
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 06:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D19B1EEA5E;
	Tue, 13 May 2025 06:45:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82DB1EB9F9
	for <stable@vger.kernel.org>; Tue, 13 May 2025 06:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747118749; cv=fail; b=ptv0y9tkRA3adHpe93rwljgUR5u/MuYcRkEg1bghxJkkufHzzgFK3bEucTO54s64CJg/5aDFgwRHz8jOH/yOOoUDhwqMugpUKcNxQVuqRVSf02VYRBQL6igJVb2kI9Gom/nRgfOvuvct3T/CkFZVZw1PKpR7lWW8uRsv+DwKGko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747118749; c=relaxed/simple;
	bh=24IpAtVv5+o+f+DMcLd3Aa/n+TYg2XT+dzxDb4omK1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cda9uz+34wg60UFG6C20NGX1TIbsy7qDs4vCcJcAT1WoHVjUDyQr4t5c8CCHg5D/+5sJnFWbZBDP3Rk1tGKjBVhllzJUOnlmnMDjRQ//ERURnn+rBlDfwSKb0y7fMkNEWyd8Ks83e+IZP9yxsxder/ouGfVQ0FfVd4haOwmqu84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54D4fq2U020492;
	Mon, 12 May 2025 23:45:32 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46j233jhpg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 May 2025 23:45:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qA7ixiliB1g9hA3EHGmi99G6Yb1Mc4mfBsMouBI/6MQgjB9mmqVj7WWOTxlLcl4Ms4hjmUfuRLmPxv/MLSMU7KYog9Xvf8m1jaFvFfYXUBVkX5bXl0qPHSlNrSJ/awvzuAJ7HFDdVaBS7klf1wzAEkCwNs/F0hLnjDLXDlCJuxVrzpxpy6KZNUjDziMYg76OeysPg4Qts2E5E8Y9YRqwaxczlX/sqKDWtONspKrl8RgJv9/Wkaihq0P8y0XkNR5PHMsCKUXmbW2x4dBQ0Fg6d1LregpOC9qnFDrAkb0r4WAQyXjJYLeLonFyIZDL5K61norhcr3PMhwrTdWbTqJrcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQpLRMtogwR53azxgdIP93pQRISocMpSe2CLcZjP+jc=;
 b=Aj0zGY+Eo25altkZBMWKBq4VpVlZYvGsLD9o6ofrTaxUJhIgYUn+jC9uXUZYPw1r+PF0GfU3gkCRVQLsyQbQKf2AMZdPX7ObeRdip37jWBHJkFt7svbcOb5sTfIqmVjryuY87LRog5bhYyVAMjRthXChxG8RMpORCrh9HTd+3kTxW4nBpsZPD9las28NVY+mwtNS4rb6zql0t2VRSSiWw3QIuJCEygJULIAFsu88jF+dfCWtzRr6/FNR7ZF3bL60kHnzXgD6+FGUAMZzGm3t8nX0/Y0XUT/5H56S7Lmt4ziGvOAs0IYa3j2e87VCK40ndWuu9ODg5z5oppBqKeKjvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by CY5PR11MB6318.namprd11.prod.outlook.com (2603:10b6:930:3e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Tue, 13 May
 2025 06:45:29 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 06:45:29 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: puranjay@kernel.org, bin.lan.cn@windriver.com,
        SJ0PR15MB461564D3F7E7A763498CA6A8CBDB2@SJ0PR15MB4615.namprd15.prod.outlook.com,
        daniel@iogearbox.net
Subject: [PATCH 6.1.y 2/2] bpf, arm64: Fix address emission with tag-based KASAN enabled
Date: Tue, 13 May 2025 14:45:11 +0800
Message-Id: <20250513064511.1282935-2-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250513064511.1282935-1-bin.lan.cn@windriver.com>
References: <20250513064511.1282935-1-bin.lan.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0020.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::7) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|CY5PR11MB6318:EE_
X-MS-Office365-Filtering-Correlation-Id: 96c52eea-3b33-4bb8-19ce-08dd91e9bfec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XhGhQOUekrgeJn+C/v2XjpV87C4oHtBU4PmjzCzdhRl/MxLOFgo2LyLY7XwK?=
 =?us-ascii?Q?GMcMCRblPr9eyilpVblusWiIZTV8WkJu0LV/cy3OyKPQNwa4Q/w/7O3rn2Ct?=
 =?us-ascii?Q?FFKqW08U7mo+HCBy+fWU2fLb7OjW37rDYCZrPmVToBWy2oxibdRHn0j977Gp?=
 =?us-ascii?Q?FXzpB5wKs0aW2eTiXdz2DszYW40NzJkjDIdt1A37fE9fjA/54QL21xfIptwm?=
 =?us-ascii?Q?AjIhpO9nRMmsiGSwpmFTF5TR/4tLSTWZB7Y1qfWTpUiS/3cYLJWMCwCHx1Rl?=
 =?us-ascii?Q?8gARWeMPTsLEq2fTjV3kk9AhmuTjXR/hEDHheX2kuaP4MM3KCo5M7MNH9mkc?=
 =?us-ascii?Q?5izX7oETbNDqb7phEQkyLIMjfGNqjByf+rAh5XrbkUm2Vc3JKGmFYrvgXpEt?=
 =?us-ascii?Q?Keo9NR/ZT9BGcSBf6bTLURDXrOKdNPxJoRFxasw98CS8eTzPR8hr+U4p+a26?=
 =?us-ascii?Q?kdb/yQxaSdZPe6Lhd5fGKDNLBmuYnEDZfwBxMsDEop01DSNl9u0WBd3/32QK?=
 =?us-ascii?Q?FhKZx2AWXOmnsgObBOsvtkFUftCVZRlPOJ0gD4aHAzkl4CTzKdW4gk8zcioC?=
 =?us-ascii?Q?0F9mk7DPGFgFcRDDYlGYoalWcrJBhH2HXR0uEY/QaS7VQ9FSzq06dBGYO0cZ?=
 =?us-ascii?Q?n6q9AWbF+b0pl3lkfH6apT0f6pIpePK2aaDQEzpWiHu7okS2NAQaOBcc9gUy?=
 =?us-ascii?Q?aLBGqvBgIVX4+9C4HE4peRCHdqgGaNb7idEHJEpaos/sSyQGkaA8oUvR9Bwt?=
 =?us-ascii?Q?OzYgcXzRJKKKHR9oypaUoTvgqw1M4OODanLQ3p+heF7En2x35FQU4UNVjCw0?=
 =?us-ascii?Q?+JfAoM0IZXKs3Y+aqLVho7QOdp7Gw+zTOmb5cmhsPBJaEUCeqvYwsOSxJrzs?=
 =?us-ascii?Q?UvICxMJCV5DNFSJLFrBfMu1KJpk/W21FnRlnNVgcfBt6/N7dqRLW9bfyCHo1?=
 =?us-ascii?Q?39HsIFG0mmmv4fCyL6a91UKBqKiI9qrt+DMLxdqKazwQsuTorcEFRIRH1CX7?=
 =?us-ascii?Q?8hHMZ/Hond5gdwPm0iYVnIt3iLwfEYzAemYiYSDn+GEThaHpONwt4iRFjNwd?=
 =?us-ascii?Q?c/p7kS7zw94kcreXOlYbNIlwvpHWI4t4T2rnZ+A8752vnYvcgpQfeKU20XX2?=
 =?us-ascii?Q?z8P6tRVKJVpVVIaFh5KxiGiXadWU0H1wiZ1E+2b6Fm80OFfirOJSHAbPzH+8?=
 =?us-ascii?Q?phfcXGSsO+DsEDMhA2fVO4FV5a0vMeQbsCuAoNdFdyE9jI53H5sm+5PVo/Ck?=
 =?us-ascii?Q?aBJXapoHwAXrqNyz7/7cCAnL8KCfdo6YvGppwqBAw0NFq5fRCdsdMgG1AJ6c?=
 =?us-ascii?Q?6qBbbbE3tRwHHiaz4yTtjNPGjpeLK4kDUByW9AW2pMgaLPDAoTp6PegmZEgW?=
 =?us-ascii?Q?b0799bfOmcMXyUnJnZba1tPtGvsbgzg1fX6qGS+EENhG9cruzfd4wEUcypFV?=
 =?us-ascii?Q?hUDyy3GN3U8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1gM3qGWh+plAV80/+XvRV4bY2uWGNwnTnMLShUqUogJ/M4U9L+kCKUCA0YwR?=
 =?us-ascii?Q?m+6c3Lz/O9l+RdyneJPIGksIiTqAzQNGVN0AyWMSIbMBmZd/vb2FWE6nrL5F?=
 =?us-ascii?Q?wzPS6jay/YrWnBHYF5NHjVB22bHjpAQrzdEXF8cyZWbdrhPhm2r1knugTPX1?=
 =?us-ascii?Q?7tqkumoJJb6wSTgxGxPSH+6LLU8XPvz4d/GO3dOV7QrNoLmTNZIVARZ+Fllx?=
 =?us-ascii?Q?KslOjcyEZsyTdeyDwcOAd5Z6e6DkVT0/uBGdLFlXIL3iEDr4CE9CMomerSGf?=
 =?us-ascii?Q?+p/UY0a/p6Wj0n2osgrNixvz/Lft+cS2oiHW8d5snQnZhvfs0WQoVaSF+vRk?=
 =?us-ascii?Q?suOzzoLDFgAXjJADwPK5G6Gmg9BsEpON+g8PZr7sq6n53v5BZUf82KXjMlPQ?=
 =?us-ascii?Q?XajMyRmNkTmNtDeBmZ7QAqPPzS1gFTIYlCbWiR2gfN8YaHYatzUHW5m4dlHD?=
 =?us-ascii?Q?frHgAbytwfaSFD2TxPnPa56H8E8qzySy/lLjWbGO4/HvTb7U/Xf5+7CEb7yE?=
 =?us-ascii?Q?FcVq1yRfNldL2IagFUHdeze5GiHq6jKl5kvdNJwEBpxxTvn8ymBwXQhqvuVt?=
 =?us-ascii?Q?LI0rMLi8gD02TzqVU7+sZojw6MQ3NuHWu17gD2rTei4TgqFV3mPHhxA72tml?=
 =?us-ascii?Q?dQ1aLO/1O0vAUXhlGLizZDWXBm0QXxU6RX5dligtLZBB4cl+4eTpeEpqntC6?=
 =?us-ascii?Q?nyMkBaplx0yOT+nPYlgktzJ8b9KzA0w9ZQselZqc9yQpfHv2NK6GP9dmWugY?=
 =?us-ascii?Q?m1nL4mw2D3GvkdLa/FTODKUdlmpxZygQbAjJ6Akjaxp9Qq9+FKLFXtRmc4j1?=
 =?us-ascii?Q?mmjz3m5wwG/rPpp5Jeakw5HGjiUDey9FoIEsYRlmfwcWqPGbWUhjJAr3kmgO?=
 =?us-ascii?Q?0D6IOQdPxuXT01bYu8PnVNWFU1/DHboQxiCL0JxnCBgcJHTp/Xg+kQ6htStn?=
 =?us-ascii?Q?bsLAbHlSpvhXVe1yHm5g1tEp0Fl7ZIu+hqUez/vj/lCI0hcLDjvQqgS8sLj2?=
 =?us-ascii?Q?1Tvfu/CeitcVdK0Iq2RerN+wzC2PriK7jyOlFR054tG/t0GpAA2JV0b4o4Yb?=
 =?us-ascii?Q?JImoAzupSqnsg3F+RpFvb0wqSXvC+w/kpmFUY6kTEHUIp9CmpevAPCtoxbHn?=
 =?us-ascii?Q?QCNM/ORnjgggOwjJL0V5lXQabKOzVh57ai09nB3+WBGXXF/ua0Il4G4zA7yS?=
 =?us-ascii?Q?8p8OvCphb0DJ/q2WNA4dZHUL03QOeEDiixOBWXFGhVTmlcl5JrhFf5NGYAsp?=
 =?us-ascii?Q?YVSSFrmCoaCVj/kCPwPksCFwxcGe9QVASAlbc2sfh170wuUSkDT0TRvOclDL?=
 =?us-ascii?Q?+2fJHNpQAdPWGgV+O+x0QxVW6utH62Ytr0TIpeDNuLh+coSle3f1mnvEOQCD?=
 =?us-ascii?Q?GkyQnZICCYM8N2zPE8vaAnzRu+QAqxWJJ4FZzyPjh9VEeMHhjuvuvBo+cuKu?=
 =?us-ascii?Q?WEwbmDtfm3GAhS8YzAyV+RVbJ21SGJYZ6y9AHwuuPpDhajV4tc5XUbxrX34+?=
 =?us-ascii?Q?igvM11juNsDmeIikd2B3d0nk3UC3307hc7S2J+KWopqLnZimVRfPhZz/b4VP?=
 =?us-ascii?Q?/fRQU/1qLIOVSNRwQ6Y/kWM/sxsxVIZDy0yFjtUhVCcwitLFRgYbBSQ3/Pa+?=
 =?us-ascii?Q?+Q=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96c52eea-3b33-4bb8-19ce-08dd91e9bfec
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 06:45:29.1793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WAGQ0p/jZIviTtChz0hGKNusMaafMCh1wl0GOHcZjCY+y04/986G+u6JMaquHFnJro/K77BPvsPz/pt4/VVF+GYE6KL+tpP7b8CE5UWjVKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6318
X-Authority-Analysis: v=2.4 cv=EojSrTcA c=1 sm=1 tr=0 ts=6822ea8b cx=c_pps a=G+3U1htxrnhIFlrbIuZW0A==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=Oh2cFVv5AAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=hWMQpYRtAAAA:8 a=i0EeH86SAAAA:8 a=t7CeM3EgAAAA:8 a=Y_K549ye1V91rRi3LcIA:9 a=7KeoIwV6GZqOttXkcoxL:22 a=KCsI-UfzjElwHeZNREa_:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDA2MiBTYWx0ZWRfX9h3l5tMOtkUY 66+7U4iP/ffQy2nwX604dBzL+GD9f51wO85Dv1GhWmzVHhl5sVAlf2DrbeQM9fOk6XZD1tXSxpE 9ndsw1gCzkpStNXXta+KQfF2JtVSZ9Ee1R5NMLI6a9ZgEK588teV2a3JgaoT+bQnJMuZ0TQZYsR
 YC8A14tCvcL9q/hdrY4TFlzJuKMV6o5hERwF9PTQ/Xu/jru0bFba0jS2JhTvjz34guWaPxMnSCJ FH/uOEW4Drb7tV8vzQqzbu9f6UviYfvZSJrWIzWBW4G2zNe9OU1AtDRFOHlFDcjrKdkZondgBoK ZK8M4em6bGDkmDhrx6/7m2Zssoo3P+pFFW0ORJbEhsxd7Spr7+h3PBO5cUHrJpnHkHdcp73LFvu
 fX+d5RKGMXg6vr1FMNY7FTth8M+Ex2aKbVI1P4kmOPAbnd7qtmwF+u+pVHJ670wGRdiNqZ9d
X-Proofpoint-GUID: cxHq4HJTu1p0IdhmhaOkxSvhUwKhdguq
X-Proofpoint-ORIG-GUID: cxHq4HJTu1p0IdhmhaOkxSvhUwKhdguq
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_07,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 adultscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2504070000
 definitions=main-2505130062

From: Peter Collingbourne <pcc@google.com>

[ Upstream commit a552e2ef5fd1a6c78267cd4ec5a9b49aa11bbb1c ]

When BPF_TRAMP_F_CALL_ORIG is enabled, the address of a bpf_tramp_image
struct on the stack is passed during the size calculation pass and
an address on the heap is passed during code generation. This may
cause a heap buffer overflow if the heap address is tagged because
emit_a64_mov_i64() will emit longer code than it did during the size
calculation pass. The same problem could occur without tag-based
KASAN if one of the 16-bit words of the stack address happened to
be all-ones during the size calculation pass. Fix the problem by
assuming the worst case (4 instructions) when calculating the size
of the bpf_tramp_image address emission.

Fixes: 19d3c179a377 ("bpf, arm64: Fix trampoline for BPF_TRAMP_F_CALL_ORIG")
Signed-off-by: Peter Collingbourne <pcc@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Xu Kuohai <xukuohai@huawei.com>
Link: https://linux-review.googlesource.com/id/I1496f2bc24fba7a1d492e16e2b94cf43714f2d3c
Link: https://lore.kernel.org/bpf/20241018221644.3240898-1-pcc@google.com
[Minor context change fixed.]
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 arch/arm64/net/bpf_jit_comp.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 3168343815b3..4afbbfc1d488 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -1893,7 +1893,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 	emit(A64_STR64I(A64_R(20), A64_SP, regs_off + 8), ctx);
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_enter, ctx);
 	}
 
@@ -1937,7 +1941,11 @@ static int prepare_trampoline(struct jit_ctx *ctx, struct bpf_tramp_image *im,
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
 		im->ip_epilogue = ctx->image + ctx->idx;
-		emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
+		/* for the first pass, assume the worst case */
+		if (!ctx->image)
+			ctx->idx += 4;
+		else
+			emit_a64_mov_i64(A64_R(0), (const u64)im, ctx);
 		emit_call((const u64)__bpf_tramp_exit, ctx);
 	}
 
-- 
2.34.1


