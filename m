Return-Path: <stable+bounces-72687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D6E968226
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 10:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F8B1F23251
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 08:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E2917C9B3;
	Mon,  2 Sep 2024 08:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b="VOyau3Ol"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2094.outbound.protection.outlook.com [40.107.20.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798A1865EA
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 08:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725266264; cv=fail; b=MYNCpd71p1m/3TYzTkxTyhOtcivQXKqiYxX3yO/SsRbxsK4OsTLiUQTcyjTtDKcgoR6u+0gMMeFvlBDWqHf52hJGP2NlTLg2PydSz7mSCOzvVb9INZw13Iy4J3FjQ0+wIWAtabY+2Y0SCwZIsrwio51d8dSLd5pzvllw7hG/Apg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725266264; c=relaxed/simple;
	bh=CekBpzUzIoDeUU43Ft7QuXOq9TnZ/MOhLyYqza8svRw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=YX9te+Lv8Nbr7LdyLWzis2inU0TFOSzstW5A3oOgZxBQoO8r1OclBvsMKxHcrwiiVz0vRh1ThaTMPzZ4GQPjetWniKQXsubqh77VqHP5Eb6BRWPrUKfgQXUIr5RCF8Gc38Yd7JDv01zthRKkAavYkSwvLaeLnYU5O3ZmIn80uqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (2048-bit key) header.d=witekio.com header.i=@witekio.com header.b=VOyau3Ol; arc=fail smtp.client-ip=40.107.20.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFfF6SK4+Q1ujpd6ZSFoHRSsmMglOPPo5nn7NboZKyLL8Qo4KHvoOuNFNwZVFk7dC+39pUYSDjqeYOEy4cl4oyQNTKvLkjJ/GnePoUkLaanNWmeQUQbCvNDvsBzZyw1Yv/f7c3P5fD2dJSkqwcldCcs6UzlAWpTBHJz2uSZnR95Cheb+sHAC/pLIpugOkLhVto/CKBrk0KboU9tI0Yl0d3dMRdqcReGMHMQWzB6erzgUg+KoYX1pMTcIco0EfiMhaLG0Jsn5ONfvxWow3sh2oHCYqdWD6UWIzTczlK4C6U59MXnG6Rz67mdHpE7YmVitDRGv5lnGP4DkdQTQ0zjWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CekBpzUzIoDeUU43Ft7QuXOq9TnZ/MOhLyYqza8svRw=;
 b=G0hshirSq5wPxyCIx1RLZLRtAQ3XTp2eiWZ7sOUok9X3jM7p3FXywQ2zPpZu5BweI8COf8ypB7OB+1Mb1dzr2Ck22XswUjrHvctFSIOhj6DUjdcKxQYqCM5CZuAYR/2Zc0PkuSJBqDjR2h/u6M2d1Cb0qBZxHBkCBqi8XVK1H5sszRj8TAmfzwYmh6FGh2DerpRSVXWbtBqbiJfiUGsHDkK/To7BBgSwjsPvUaU3HUuZCik7z5AqthHtNXxiis5ESaDsxie2SiTiU5EekEESyQ6YRYCHpNUJD22rI15M7PU2Sg1OVIONX73KnMdkZwDj2p4BCj5K6wzbBYWN1ApVqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=witekio.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CekBpzUzIoDeUU43Ft7QuXOq9TnZ/MOhLyYqza8svRw=;
 b=VOyau3OlQeThRdJwLBqGBxkEIezlOJxJoKoMsgFfQB0bhQIb8VDW+fu+Lzt3uVx8eFnabV6R/kPcx+donEKIWM5B8saqG4DZOdWRSwJH/CG1vqpARHLlqOjAhT/rPRy8E1VdtSiQAzC+yNBOHpLJpccid4ECdOpu2N+VQ/Q1ydNdkOf0CW549qzgKo+/QsSHJrPdo+h1qqSbaS/wDPBlmn6zFjfgHjxpvW8rj5QU3Rf4Uleb1bCDqbLTOiWU2XDL2s2019lLrwdMWU+yf5wTsxbu0INhFZ6Cv7xYqfAOb4Er7KIYem+VmWunoZ0kw+Fun9SJAgPGUxVqcKeADIF16w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by VE1P192MB0607.EURP192.PROD.OUTLOOK.COM (2603:10a6:800:165::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 08:37:32 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%5]) with mapi id 15.20.7918.024; Mon, 2 Sep 2024
 08:37:32 +0000
From: hsimeliere.opensource@witekio.com
To: stable@vger.kernel.org
Subject: [PATCH 6.1 0/1] Fix CVE-2024-41096
Date: Mon,  2 Sep 2024 10:36:41 +0200
Message-ID: <20240902083709.6216-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PR1P264CA0113.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:2cd::14) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|VE1P192MB0607:EE_
X-MS-Office365-Filtering-Correlation-Id: d145fce1-7715-44a7-25a6-08dccb2a7cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLHoIb9JcckxfHjK66VLx6Py0eL39/FN4WaRp6HM7F/Zq1Gzeet7GFAEvpSI?=
 =?us-ascii?Q?2YYRLmSlV5dp5ySdZYihEejcPY0EEWul4JPvEhqdys/g5RLPuPV7d0AEHYau?=
 =?us-ascii?Q?TxH6a4r9TUkptY37sefDtFYj0W5SMs2gcIBJnJq99ZEDgz0Of06oWDkvN9cb?=
 =?us-ascii?Q?xZWaf1RTdCT2FRBM2aIToBtBsGb/bJXSn70ZVjUmEUxkPiU7re7NETnbczll?=
 =?us-ascii?Q?5/rTUBK9uElz5B03PVy+1Pd5O4yZRX8j2ZBuZsGvitj1QEKQIRGdkgJDchvb?=
 =?us-ascii?Q?6Zs//xzSPOkX9JLEIA99N1ls1Z7e18LRXQEUm5YDV3F4FNlgA4s30bp/E+Vz?=
 =?us-ascii?Q?bYfsNLmYBSc1pfb+Ceehnv4+noJ4dWPYukKIkYGysMrY4u35w78X1T5p4Tav?=
 =?us-ascii?Q?URgHGCKaWdM3m9nuBfxBfJxTL3k+9tskUn5XeANb58F1FW1apsdVJJRcNzLt?=
 =?us-ascii?Q?8BgOLJOkVY5sHp3QYlEUBslTbKgcnU3QNmv6bEeXuNn41LLhe3OFHOMLDGue?=
 =?us-ascii?Q?+G3MVLEfB1NmQHo6NKaQBNHS8YE81VYG7+zEL0Y6ooTBMmgscul3SdVw7QMK?=
 =?us-ascii?Q?evbCUqIZ1Jg19oafy/jGXc1CxNimq4XIpktCuXXUk1KpdwGq5ByD5lFKNXho?=
 =?us-ascii?Q?U7GmEApLks14oPusOFRKcqDwmsqPFKb0WIrABZsGH9BMjr8tVIUg84rwl5Jc?=
 =?us-ascii?Q?An4RIvV591OfoBoiz1zG71aKcNyiNMmruoI99Z5kAhVesADIod0TMKuXF6FV?=
 =?us-ascii?Q?POMw/M71HnLCCIxcAsUhBaxLz507EeRxS9y61VnKCOYewAQ31vlfXD3kXoJ5?=
 =?us-ascii?Q?g72BwjBfvl+nqNSd2T0S/oX5FdACUUJerEvt9iXX8OKc1fi+5A8kHApBFq8D?=
 =?us-ascii?Q?RBMU7af7RtDWBfEDMU+lcd3uJyCxaUo3dYMTNOstwoSFbRJhTfhngQ49SAn1?=
 =?us-ascii?Q?HWB6urQrM9MYIyten+T6G7S61kGijKF8jwPZptBeQvbOQ0bBtKJnarPuuEax?=
 =?us-ascii?Q?5uAGRd3CNrfbC3BKBPqzh2QtLqDMntnUOnsQh/wuimsbM9m/B3ULJrlKArym?=
 =?us-ascii?Q?6G93R+fyI3YLDHLzZ5QWfeS5zITu2DtElyRnRSc63ihQdwZCqfzHAGXG433v?=
 =?us-ascii?Q?IfpUgXnrZ5GuZeVPjh3srW78dRKrBEqWxepfPdNI5Fp+j0GKJSAFG75HoEO1?=
 =?us-ascii?Q?GjGyjhSnTguNJhMyyOjSf8llKzZt4zkx/OQDbTOREmXALsPQebuW1djv5y47?=
 =?us-ascii?Q?j5/IxXK/xETfEbmiKh/qIoZ69e7McmWQd50hPsARgw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?B94t2MikyFhD8jm/Yy/j5I4/WSWzTCZ1rs8zcVEThtk0TSAkjTMmTp92pyE/?=
 =?us-ascii?Q?r37Vv4HpGfSqGo2qBqo6+9CJkb9oB/yQ0YK6FKCHcBL7KVCUlTlAgp6rSs5i?=
 =?us-ascii?Q?DqIUVKe7bPphyxBfy38eKBYSmy05BsZFrvo3kuHhSLm7f8NSMMQ5iSkG73mR?=
 =?us-ascii?Q?HXe/4Ys+Xa9KYuz/eXHYpJuzBli8KzYiALlMaQx70q/6QT/gA6xFP9lD8Io9?=
 =?us-ascii?Q?69gxSPEkIVJ0tOZXPnMzp7VrMSVJMWx2xdoSWwdtNTcUGLNtP/s9L4fVT5aT?=
 =?us-ascii?Q?A3WWZnxdlsGkg+ZE2+S4uEgNHlNDk0vkvep9qbKioxAEAHEf5c44QmnsiB8u?=
 =?us-ascii?Q?pg0W8JPxNesuN3kbTROdf6Q9Txh17mgywa4w4JRMckBtlEXEOts5cgmWTRmC?=
 =?us-ascii?Q?uN4F43IW8SWaz/aALQBHuPsmjx5/MR4v6PyZmDwAR6jGMj6t4IMUtf1+8jpe?=
 =?us-ascii?Q?aj17XvRs0FmdtVDuyoJeZzGlo04JSXtmOtzTfkD2AZCp4Kry+WJtL7ySMVXo?=
 =?us-ascii?Q?aX51YV/MCVZpJYct935DP5ob9lYb+P2Zzyl7QqW+9NbRHbO38eLjlslOsPMf?=
 =?us-ascii?Q?xCCCWm+YDjofxMlVjRyYaWRUp3eyKRKB2chjeQy8Dw9Ir5nPc7A7A6eAAzA3?=
 =?us-ascii?Q?1NnF3G2bHgTvT5XpRNNY7xev+B1HH2LDVhlFLaLZrXPBY4fAtNOZN04CPq5w?=
 =?us-ascii?Q?Hf2mOWK+gBwNkJkzDzcuNmY4BYnHOVaSA89OxnAe835jxmRvS+AtefJIxV4Z?=
 =?us-ascii?Q?kqoLbuy+z5ory5rDiVwz9L4W4l4sTLe0ihg3X9dk7K96+GFQ/FFT2rFkmVwt?=
 =?us-ascii?Q?JMsAwCiZmBI5ufQCaGvDaO5LUzXGh7D0V+TqvnPpNKNOC7ZPcC52nulsVp7F?=
 =?us-ascii?Q?aReQufsuyMwitJDs0AFpuhy2YWLJDncrD23iiMNkQLeW8JnyGdtyNFPIrXxY?=
 =?us-ascii?Q?WZjmS2kSlICf5C/QnCwVZPHB3iwBukHFkJTWjTWkpHAKcbUt23TRYgeHCe0X?=
 =?us-ascii?Q?VZ3KTRKbgkwci4v62QgBgnT8r3K97NSLFAIjOVpZEIN27SkZ78WM0eOIxiOi?=
 =?us-ascii?Q?ykj+56M2bckMDHkZ9NxjKF2CnbH94TSn+sWfahJ2r4IkY8OzzZ25gIek65OE?=
 =?us-ascii?Q?lsTw6F/sbxfnLOD22Omopkeyj1+bPndnEknGNmGUK+V8k4EMbZ3ycl+FhghN?=
 =?us-ascii?Q?AfRKbvk2DUoRS/2EyVdrlgddiRjZ79sY9ijmd/gsA/a+12UoB7Tpv5rquU1W?=
 =?us-ascii?Q?SWwpEIoRbFiNkRt7/SKg1L0Wq8AeKxQcNJvoZvyJqWD/AufRrIzz7HE0TwrX?=
 =?us-ascii?Q?vxXaH/jdsVTeu5zkh9C69JrDWy9BuT9ffc3CMiTI18iT5Q35qC7TpanVGU8r?=
 =?us-ascii?Q?sLA3jhLSVDYgafTv65ft59pccg0miyTsfhf4kd4Gb7Rc6vfppCAAlyf69KtV?=
 =?us-ascii?Q?hL4lFcT0frj3BDW7688m8k88VnwUn5fSkE+ygbxfqmFWxXdQQTQh8Zy9535Z?=
 =?us-ascii?Q?JrwaXdnIg7eAgds7PddBBlX83Qo16zGpM+Q4ew8lPHEDnEkcU2uVaLHlkFVY?=
 =?us-ascii?Q?pWKksk6LV2jiGg83uD3O5I4h3A07OiHVhK0RIDvFuNNCf3u/wsuwPdzh2NwO?=
 =?us-ascii?Q?dQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d145fce1-7715-44a7-25a6-08dccb2a7cdb
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 08:37:32.4653
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GU4PpO3fSycqIFVHjMSNKD6q9lN5ZcmE38fxyOxg8cDMTgaZH/QARA3R8hB8Tz31IF5VWHB7mhr+VF81edYXkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P192MB0607


https://nvd.nist.gov/vuln/detail/CVE-2024-41096

