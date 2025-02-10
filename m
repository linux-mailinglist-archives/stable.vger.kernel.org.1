Return-Path: <stable+bounces-114498-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C324A2E817
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 10:44:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A64A81889CD3
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 09:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497091AF0A6;
	Mon, 10 Feb 2025 09:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b="P4CpTz1l"
X-Original-To: stable@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2108.outbound.protection.outlook.com [40.107.249.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF612B71
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 09:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739180678; cv=fail; b=GxICF+dKieaO9wHvImI0k3jEZpreNgOqYWRANQ1Uwr/rs+f7ie8ZchZHlVdzLH7OKzb8YtlzocuFEmYwnTjY8Nn7NYVc7Q5QMOdwsEr+7RjBaCuRB1AvsAVeRlpDzL8sQG5uyPDJa/vkfjMCDZ7bi4luN+ndsXNHEdvHxaVh+ME=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739180678; c=relaxed/simple;
	bh=6/mk3M3fOmHPmfrlh4ZAeB8Znc2MJvCZc/cahCqTtLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pHbx6tpDlgUnOaBDQtWBB50s90N+iREo9Iq0nhOEWl0UeGZtzaNZ8IBDpBZ4p2mZhWE78fo6CmQjVSkEKny0rjcqqTL/ouKsAwPILSz/AZ+kTg6U1SPwvLbAglAzqIUfuks6R9gtpI3gaiU+dDHECrxpM7y1fQSJBviQ/pjevzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com; spf=pass smtp.mailfrom=witekio.com; dkim=pass (1024-bit key) header.d=WITEKIO.onmicrosoft.com header.i=@WITEKIO.onmicrosoft.com header.b=P4CpTz1l; arc=fail smtp.client-ip=40.107.249.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=witekio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=witekio.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wADTBXXhIN1g9y4CbCTOrFb2Ku0HjWkJzKLaMOB9zj0+rphd8dR4LhXUI9VfqO16GVTjdiX6tI+bB2MM1nNgASQ4T+4+ZxMRxsD2nJ8hqycBWI990vT2Jaw7zBUkfoPNawRU8qS/qxdAg4bT0X29Q09ct3IEg5BTA2O2vOJus247vXphW64HKtv5fvtcAzlfD5fcOB9xh5e2C0JnVutLnPMWHwVZUPh1rGaTHD3jZ7noPmfIDVNb7l5/9qL6I1a6z43vAIbjV9qwD06GPPLAtFcCkYxhUdq47rHQHVRfFKmY7/wmOHYb9ufvcFZHbAiFFU4/mHToQ/k0jESqwllxgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6/mk3M3fOmHPmfrlh4ZAeB8Znc2MJvCZc/cahCqTtLg=;
 b=KeZMdkFNq5ZfrRxCBrHqICBcsSqDbbqTkSCtSEdc9kIkgeAeYlhycCcd5f4FbxSi7+b8c9XE+JSvwyk5HJbYQENJ/01wf5mfbQlX2yjQLip8/4oabvg8aj3ji0EFKwSU5nBuHOoxQthkm56BIUEv8sZhKPs7J7dICaXhRBz8OKVe1jknTnzY+QVTNpKIU6FSuvuJ0u/ORfgMJYPsthIvoXc8L5zFDR9JwUHGfhgKJVZHqG+y+02ETmQ1fgJd28E2ZJMOcW/n8p+62CkHQsSoeVm2NfYENBM3NjpbaXuagL5fEYx2MttffPvmR1HQGdTRzQYlu2mMQmN4szDuXP31Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=witekio.com; dmarc=pass action=none header.from=witekio.com;
 dkim=pass header.d=witekio.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=WITEKIO.onmicrosoft.com; s=selector2-WITEKIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/mk3M3fOmHPmfrlh4ZAeB8Znc2MJvCZc/cahCqTtLg=;
 b=P4CpTz1ldZBUl1hE5Vf2Hny4F4xlQmZrtZBpRK5zpa+cHiY8wgeAapXzuj84L8aIZlSoFz0SSkN+iScnQjY4Ox/vL1tNV+fj1+jl8bGe9XDhmNqAcVdM/zZfWN9k3mfJ0EkkcpvlSqzgKIPR62NV4GeCNiXgjyzsaXOXKR1Ynk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=witekio.com;
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:48::10)
 by AS8P192MB1725.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:525::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 09:44:32 +0000
Received: from PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091]) by PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 ([fe80::345f:a9e9:d884:3091%4]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 09:44:31 +0000
From: hsimeliere.opensource@witekio.com
To: greg@kroah.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bruno.vernay@se.com,
	hsimeliere.opensource@witekio.com,
	stable@vger.kernel.org,
	xukuohai@huawei.com
Subject: Re: [PATCH v2 6.1] bpf: Prevent tail call between progs attached to different hooks
Date: Mon, 10 Feb 2025 10:44:07 +0100
Message-ID: <20250210094407.209620-1-hsimeliere.opensource@witekio.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2025012138-quarrel-uneaten-83da@gregkh>
References: <2025012138-quarrel-uneaten-83da@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MR2P264CA0085.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::25) To PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:48::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PR3P192MB0714:EE_|AS8P192MB1725:EE_
X-MS-Office365-Filtering-Correlation-Id: 238fee55-8391-4f94-a995-08dd49b784d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3uInh5HVnEqlaOLJgABqWIywfaSVKvK1IHDV1NdFGoAZS5LDeHwxxQ7ZeANF?=
 =?us-ascii?Q?RAmDSSjkr+h4MWnug6AFDvm5/VWWlq2mPdrb3xfqxbj/8+aK+eVg2k1oU6o/?=
 =?us-ascii?Q?UCYQHsa0FhN/dnkKbzoAflmj/8k8TaEW02T5Ho5ECAcn2I4WFn/Dst+5+ViR?=
 =?us-ascii?Q?BZ/iXCdxlpBI+jZD2j8xo2PadSgITOollkCmOE5Wxm9ISjw8lRVX2s4cbPYC?=
 =?us-ascii?Q?zaUqSP+oc00avFfp66sqrEOIb1E7ppBKUwlUs6i/cGlMypBgsiS9CuPqhC1F?=
 =?us-ascii?Q?zuUtfrMyeb/fL8m3X7KxZBaFFbr5ETiQZ9nix4jM1iHWaffyR4S0A3MrPu8e?=
 =?us-ascii?Q?bLoj1DTRwnAYf6KFOdVNkvT0e+woT606CPgkIrr7UwzP8+0/1X+WDtBcKFvO?=
 =?us-ascii?Q?bDRkslXIhkf3fIA/swlCXB99OGQySzSvu4OcvcCi3hPuUq89R8cynCEqnos8?=
 =?us-ascii?Q?iJUqb2PxpxPOpSDMIY+pz0dwMtllZqD831iCGd5KD1SNw6sPFocnL34ZotiO?=
 =?us-ascii?Q?fyQrOwLVe08EkHRwyifzatx6lGUsG8eP/FtdF8YxnuLZrndPjeUcjGwEFBk7?=
 =?us-ascii?Q?UfrneP4/qB3MKWcN2JknYmGeA5rEa5qESo35Ba4Qq0Ks9glQmLEckLUBie7C?=
 =?us-ascii?Q?4HfLuHO32HAm6WjJ8cs5Woe1ua+9utLJneUJKR2oC5yqmCnIAifmthFjnQ6y?=
 =?us-ascii?Q?ZHJkAVzdkx/GUHmZxxJ58rx589mjwXe1fSYEAdfLot001WNWI2jf1xC68OYq?=
 =?us-ascii?Q?trcZJjHr7v84TUmcWjiB4fLHbwhh+uZnu4w+VfiXnJnBgDflClnMk8BF4BE1?=
 =?us-ascii?Q?G3oknD9vlFwc+Jq9eUhPVWuVwZkvxX8gyN99rj8Kbek/OteataGuHiQWMAM/?=
 =?us-ascii?Q?GEl7DIDTzTypoXNml/rvBAHmnpXHf7kB2AGHNvv/J1PhEoifl6XWAPvnhX9m?=
 =?us-ascii?Q?UKSYWkGPq83TLD3WH9+LoDqjxXk9o0ZNColzdl/YTVlEf1OJ+pL9vDaFXlWD?=
 =?us-ascii?Q?JPCpC6JwOA5vkoU562HfDL9qX3EmkvQ1CJY5RVkmFLNI6PPbw1o5QmfWwlcy?=
 =?us-ascii?Q?eagUdOpmAyhBcbSBQ7ADXNYKlK7dIJ1QnZdcT5kscENlca1jtdG8I/O0bSUT?=
 =?us-ascii?Q?n3KSew9ZL3Yz2j+Lk+21uy15t/eWK/WoxlA/QlqUIj/2bYGTTUlDxnfLAG1Z?=
 =?us-ascii?Q?RQVeRfkbCxPNefvXH17wyWTSs9SeXrh1QBA6e61Q6j9dxyU7Smy3/U2IiAa6?=
 =?us-ascii?Q?oAAqMJiAexAMJlA/yUDYPP74WFyWUVwHn6onnX1x8FyCNu6VkkF77v2K8/Px?=
 =?us-ascii?Q?eTEwyinvEUonnMUnqPcPK77myBCObuX/9nsm7LLc7YzW5NCQ/ETTJ15A4xt+?=
 =?us-ascii?Q?m9cz/fsel+yoJ3UkSOZBi6heAdYg9Oirhvrfp7Rsn8VDpRolVU7vNrn6+VjU?=
 =?us-ascii?Q?eIlxs20u6t2iwIkNWQQ7svvsojlHg0YR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3P192MB0714.EURP192.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AuOO1nlQA4jvU/68i3T/uD5Yf7gFGxiMYGvgavquYgL4T2Fo64/Z5UCGU4pM?=
 =?us-ascii?Q?N6aneZ51ewYVRiSA9Fdfswhna/Zop0R1KqDZ2BQryr4V6obrgrqo3ks4VXXc?=
 =?us-ascii?Q?CV2+OZy7jPe1yDV1CNb96JOTO+kIKkZuq/Rib3GGv6ASFsJ7a2FoA5jMqQPW?=
 =?us-ascii?Q?i2zK5nDFSjkPYV5gQ63Ws4h7nVYbg/nqgdT2BXxkVuU3lWmiuISdLagtDAWN?=
 =?us-ascii?Q?21HqkYBXJivWlLnuhloC7g/Xg+KtJc2k4+p6bbk+9J/SEhgqu5Kjym3+5ie8?=
 =?us-ascii?Q?Haw7TdbDpstTsYwJuQMx9CMd1Gg3OojVfpT3iAl3Gf9+a5RPETz/d0ntkW+O?=
 =?us-ascii?Q?wPfJ/JaCgtxpX3UvDVuiHGl/FK3DsTcTih1NUkFQpU0xkzc8o1vlFiTrqaks?=
 =?us-ascii?Q?CZ8oBeNDAESSHKtseHyVSqKd50y9u31qr2N2lCnBNTRiVxEzZZzD29LD/Ris?=
 =?us-ascii?Q?Q2O1x8CNG4cHGk4+wgGvWaSQdz3TJG3EFrTKVyxBZD8dbn/Fw4TMLUwnTBWq?=
 =?us-ascii?Q?XGULUd4gEJny6q/gur9VlVVdMssRZ/tpHciuZZptP4ys7jZRlosuOfMHd1Nr?=
 =?us-ascii?Q?Q4hc3qrM+Ig1DIxuyODdbG/JZLIx97pUSJr2+K6Zy7tHPKTGSKbPWYXu7/kR?=
 =?us-ascii?Q?foscL/Z6SN9q0OsjPodWkAiG3y+prZeWrYBltzXLJ8bDy6m1jPD2fuHp1AVY?=
 =?us-ascii?Q?5G6foxlqz+Y9utL7gp+vWW7sj1MKFORlhxXNfOZcKRMwY5mlyHc9kIn42mxI?=
 =?us-ascii?Q?8dRtj9n+DhLjOuExvqimaJBka+X387RVNhNAF3H0BN9hYyfH/h2a2oP09aK5?=
 =?us-ascii?Q?yQUfAVYFeeFz3xLBRxlDpmSuHOfpwO5W7c9mqJy3qFBiztykLX7ZgVS3jaLq?=
 =?us-ascii?Q?ApQk1AqodjfTlLuehzgBB9i3NxjCLRyEd2cHsUa3n7JbIgIJ43aJXKAGKiNs?=
 =?us-ascii?Q?JdmazwoZhADAurwuM1zoA+pplHmuN0zON/CT2rs2TtaEc8D1enoxZZLOVKbA?=
 =?us-ascii?Q?Xe1MshfpznHLWiI7hRrx+DIX4etr/b5L9qkRMs2teV1v2ZE7cOLkMxLkFuEW?=
 =?us-ascii?Q?apEnHSyKdgQWkce8YZbl+8Hy8fd1NL1NCU+S2sNJqKqnmuHZg1gg0e7qvoF6?=
 =?us-ascii?Q?CJp6pXzbpIZaA01+OwGlpKpG+B/l+tziG9GLVEoVm5+iXFWgVhbWIGxHXyF2?=
 =?us-ascii?Q?EjxaIaYcsgxz3jlrb1UgKypc+vPgEhPF+odlTuo6U4k/w3TkexjobB9mcBPS?=
 =?us-ascii?Q?CWZ92a99MtfDHAHus5/o8J7Sg7shtpaQN1AEOR40DmQ38bEeAlh7cAWIIsuX?=
 =?us-ascii?Q?CL+qdaVZmqh7ZPAA6nMZgvSPDWdiVzdNuFv+IdEWt2CmObQqfgHavKUl9Jqy?=
 =?us-ascii?Q?lyb99qRlUnGii2HNlBaTDCTUNZTLK3yzR42zNY9QPNyGrJiCnB1RWQ8uO9hc?=
 =?us-ascii?Q?2gWuTT7aAzmzNBHY5USbK73arv8ukHahIO+kHenlOgt1DsWnpH/+OIytz4EB?=
 =?us-ascii?Q?2mq1xtNSNtck4DoWEKfP43L2UxyptK84CJMVvWNVkXF7M38sWgHVhB86cadB?=
 =?us-ascii?Q?vLUcNzd9OlG/EEvy3/PyvRvDqPtPDe2ir2zqmSuPurv0om9SaKNv3f5Pyn7N?=
 =?us-ascii?Q?pQ=3D=3D?=
X-OriginatorOrg: witekio.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 238fee55-8391-4f94-a995-08dd49b784d3
X-MS-Exchange-CrossTenant-AuthSource: PR3P192MB0714.EURP192.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 09:44:31.9377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 317e086a-301a-49af-9ea4-48a1c458b903
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cuYdbjpkpOjDCPRunmuyF3q60oPSVnmTJ4bE7RSS22WJONWQRBmZDq4kxH7lyOG/MTUvSAdJXbR+vvWsjmPLCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P192MB1725

This patch is needed to correct CVE-2024-50063
https://nvd.nist.gov/vuln/detail/CVE-2024-50063

Kind regards,
Hugo Simeliere

