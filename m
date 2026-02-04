Return-Path: <stable+bounces-213340-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yW3TAAu5gmkaZQMAu9opvQ
	(envelope-from <stable+bounces-213340-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:12:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 516EEE12FF
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 04:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 23832302E0D4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 03:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA692286D7E;
	Wed,  4 Feb 2026 03:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UxkwH3w3"
X-Original-To: stable@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0C7257824
	for <stable@vger.kernel.org>; Wed,  4 Feb 2026 03:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770174725; cv=fail; b=GAlYONkjNwyTkQMic80SZMoOzpXOM9Bcc4cuL2yDKZflOEJBK5fU3nvdSSf0jWYnSZRM5SB9GOddZEdDuhw9By2nrcsFBv6JKDl9/0HbnPc1RLxTWmaV2rvP5/fR9c9Q2LiPbOpZethX+I0xqjuSvYdu/3JPaeaV1ebhPyAauhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770174725; c=relaxed/simple;
	bh=hYpzL5jrv3v1bjs3nkFRcRnkE2JvAS9hU7MIy99gPVA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2plr1qb1cKis7PAyGuZa4HRD01aUIIY0UWi4WHsLGyWI+1pJge0uAsJUlz/bJCLLJtpD1UoRfY/actlUpyVwP7IHvnRTvijZGIO5AlQvbqRlDxPkdgPGTegmdbmusOpIEQBLMdc9TIgVO7vheFMYTkRCLveZk82RbWh5f8g6HE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UxkwH3w3; arc=fail smtp.client-ip=52.101.43.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uswGc5RzFPSPEvJWBIkGNYAdTR+Ck50g11tUuH2Lxt5gNy61jkYSnBS0slSBAqCvpVocrhZFLDFev2pYFYQxvm6rCZAdwylFyf98dROEmxUZiY1rlzrQ/B90G0lW5F/IAoz2twVqoplQaSme3OrAv8TqzK1L/A7fVngW2pBhWPxIQDPGGBrqTlg5IfA8WJ0lxYWKJW23quqnFc82MKswp8xV2W8+AmPVk/Celb6ucBzWWPdD7FXCtylHRLKcDlTkW8UwOQlEvN0WmfzhsZNyK1cFIuVrrHAsDpr4h0pbXOijB7axSY2Ib/iYTHPd16DHEJsmTo3e9ABDXh4ZEUCdDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnvAcJh07ncs2l9x0XIgTo2h+fWrOnfeZciUWrbKG7g=;
 b=EEUFndRyBsl/OqkkdyxJ75iDM2cUG0032ec5fl8u1uwD8mbTc/sfa9Sf0t63i6zfbvPGamiI58GSf5mS1jURltkhvMbf7+tf3iKSeSCtR5dz65rSNHc/Q6u7RgxX2P4XUZnifJxhLBjprSigEXseaV/DVMPDqLzkOzlq2pwQ/qTh74wO3kSVNBa33+zjN4/fRHEmKxndqTt9njpX+upZyDfv9P5dafzns2TyCoyRRpc7wDpJDAsU6eo/icCDnuPOOS5nwq4jDI3dWi+VB0N7oPHyv2YiCdKiJ37yRcCv/BFnsPO1vO3R7ryGkdribUbpW70h4vdsz9bvp7feldOJMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnvAcJh07ncs2l9x0XIgTo2h+fWrOnfeZciUWrbKG7g=;
 b=UxkwH3w35lo9Ni36GnCaN4lxOi2/lpDjfeLND3TWMsAZ1bQnVDLBm26AzWKjY39iZyC7GAxos4SFiAXBFHfW82tH3vfWilf36dkzmNtdH4bzEI3J7DR7wj+or4A2ebm1y8r2vXCKAq4ggq4GJlkxy9L+H0+N0ySxQcsmkEadtVYyx5tTKtnqGA7R3MrjDlxz/T6L8RzCmxw3oBy8AN7FJs4WWG7hfJakr7JEr9DaSP7BsnBPOE26V6cPeFDMDLOZV/SJdzbz4UH3hkbHz0m93tqqAHlVlVNqEqFfOmPSHlYvBmnHDdeSkUkHBMTKQdXJvaSoFLMUao6LsAxkOKnw8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.12; Wed, 4 Feb 2026 03:11:59 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9587.013; Wed, 4 Feb 2026
 03:11:59 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, gavinguo@igalia.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org,
 Lance Yang <lance.yang@linux.dev>, stable@vger.kernel.org
Subject: Re: [Patch v2] mm/huge_memory: fix early failure try_to_migrate()
 when split huge pmd for shared thp
Date: Tue, 03 Feb 2026 21:22:21 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <05C8C526-0434-4912-9AAE-98A70A1841F4@nvidia.com>
In-Reply-To: <20260204004219.6524-1-richard.weiyang@gmail.com>
References: <20260204004219.6524-1-richard.weiyang@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BYAPR08CA0027.namprd08.prod.outlook.com
 (2603:10b6:a03:100::40) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b5d0d6-a1ba-4f02-cc10-08de639b28e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8avDQFekE0UhFehTbTJQznTXWCsRrUW/jNNMEltxSjZtR9fSpVeZgHBVXefi?=
 =?us-ascii?Q?oyl8HeHy//6F92lPnvS5BUEKOIIJ8s+vQTxG9D2mhGuU4WxeAcgsatbwTEIj?=
 =?us-ascii?Q?pcqq706vuBWiqu+h/1kDi5bklC10qp+nwEL5Gx/Y5Im6/c7Xg1DAG15xILHX?=
 =?us-ascii?Q?g2m72w9wuawopEBmzXs4H3yQpo2eyVRfcWgO3inh75yp3vqtyJY3sX32vwKr?=
 =?us-ascii?Q?Vy1iUzsfKmOTz9tTEaN3VQpIUvXnZS1YHrD8RlTPpmjKIdqc/u3ThUapN4t8?=
 =?us-ascii?Q?8RVy7NvtVudW9y3xUJ0GlzQpmiK0Q5dHlDe7ZINUCdlu0AbkqYHbfd5GDAkK?=
 =?us-ascii?Q?OGwwxgWD7Hk4PS6RpYIelsgqUiG59q+C7rIqX0TShoH7YzZzJ2ka3PV/KlV3?=
 =?us-ascii?Q?sjsT6o6nOwT+bAnlkDVW4TfoIZU+bQ8OuSRnnugUyb0HAFaLP9RfXjhj9gWv?=
 =?us-ascii?Q?ISejnL+qB1qKdgJTzabR4tupqw57qdzMWJaUmL5nUEtRjwpyTww3klOlLfMT?=
 =?us-ascii?Q?i969OMjT7f+8Nuid9alum8D/zIuB5F6E++vxJxgqMDiLOf2GDLRY1yjby3R4?=
 =?us-ascii?Q?cLFkRnDpBmkl+iWF5vpg8qjLexQ+gooBJWxt7jmGHvoBLykKvJPD0glIgNWW?=
 =?us-ascii?Q?a6B+tT3vWo4W3CClgKAAp8U52wPR7v7qKZ1cLL3KgTOzXmtc9YGk5hk95d1L?=
 =?us-ascii?Q?2i9P2sNTmmRM3tDHvVEfiv+aknjGRbqAY3cP2pc8GYIz6JT1jjtux7ujiP0f?=
 =?us-ascii?Q?OsnWhdpFr8xCWpveQJvfYok39mXzRFxbLAOKvdqgmFdNBwEg62dlgFq13A7K?=
 =?us-ascii?Q?owTIlAwq+oPvWaAPV+CxOWg9XomBB2GnbhAHU4VhdY6PHOhLRR8bl3ytOojU?=
 =?us-ascii?Q?AawN3CTYMBchjn10Sxxl1U1ASocKHlc5KHujVfplIrRPEVoST1CtQ7IxVTgK?=
 =?us-ascii?Q?aUmTCduwJIh1BU3Y7LFLPiSwlftnMSUUpbidE3VzbRrmfTSQmHo1PFnED5FV?=
 =?us-ascii?Q?iSB+vxOxSoNVaTMfQScYs7vnZu97sGysrje6PI4IasV7NeUsJwi+5FD99wXe?=
 =?us-ascii?Q?tXQhYvL/btFmIiwspTigUQWuXwgI6sYBXOYim8ucXdGENBf9ul1KhalIj36d?=
 =?us-ascii?Q?r7fka0s4u3NG6cVYyIwIUo5aCCqAkk5/ydobPMYrIZrZTTfI0ouqnYfLgqQx?=
 =?us-ascii?Q?eOLB1WwwTHz+c1361N6dZ2Onsn9s6VoZsE4sLM1ughZL7Jl55hk8Eadd7LSf?=
 =?us-ascii?Q?qwL+5Zh11Gbigz8Qj0zJYRwFx2uD3WeNskGH0c7OmgxXnS4sdmEuV8lPzOfp?=
 =?us-ascii?Q?3tCfcmEyNx15Dn18nNUnD99eV75zVNFThaShmVEeNYV75ymU7XJAXnz6vHOh?=
 =?us-ascii?Q?UNmUvPIcjOTOlIZ7ZICmyp9IZ0GYsSPNRBfx6fEABw6tsSsV7FAGDOVHWpZl?=
 =?us-ascii?Q?R3pxBh4gCGIgX+kNRMJetKoSSFgfo9YGdZUrdm2tNERPp+DmUeloI83T1d/F?=
 =?us-ascii?Q?Dt9vK4KGrbjIlYUDdU0JyXnFKvZnCx9u5D8JFlToRoEfLrty9o94dExwdQIy?=
 =?us-ascii?Q?j4gxqRIIhs1/5H3ky44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ewrj/B25lwCaRjUQFXxHk6WMkxDOW+XGetL1yuO9lr+k2A5Y+FbFzXrKwp6C?=
 =?us-ascii?Q?W3YjMpZVrNB9gFs+OCWC7NbxMwG4+jDgxlm2YQpONjhOpclqwvpbMy6dT+B+?=
 =?us-ascii?Q?/KV6hYbgNEFO7Rf4XCnR8sLiIGAfjB4BCh6Ml6bX7Pp+/HxEXkAH5GuhGJqz?=
 =?us-ascii?Q?Lm/D5M+QEVeGBPnlJWVvRXXwYKqk6S/A9iEuaYMPf3Iad+pv3eQ+Ib891PC8?=
 =?us-ascii?Q?ygoRD6DRg8/wyKIWCCwpsawQDuAx62Z+1apzGGBGgOeVpY/BmFS6f4dOi7lV?=
 =?us-ascii?Q?QVdW+FjqfaH4wpdxXIjV+a5eW+hjSF8OASHFw+sxt8yCadMKKlGS6vTbhJZC?=
 =?us-ascii?Q?k6P4XBjYK7/8yCZnkgE9IJmBUi976yI8uM/8ukPSBjNXo4lwTowzEyt4ZwBG?=
 =?us-ascii?Q?f5y1pRtC9/wSzp0wzx6fgaGh57Zlog/6VNULvxkmuElaQa5HfaeSaodGEfSv?=
 =?us-ascii?Q?6vpuGarD2rkCy7kTRb5dnUmWfuh67t2+uSSP4i406TsjC9zu9hNT3mxEW0Lz?=
 =?us-ascii?Q?OG2wIqrVrEFcL4ixkE+0j9FoULOz9pPHH/xeAQwoB5CdoF2PsAhqUZ8+Pdnk?=
 =?us-ascii?Q?qc8252uwF2ktoRPJD80gDrXyNs26knINyIbQscyhQAhqJ4ik6uJrHqLGUo5J?=
 =?us-ascii?Q?fLIh3aK0OTtZQPbKX+DVEjb1dgh8RC2k6yxsMt8fPDD0hsB4gi9WqQEWK3E3?=
 =?us-ascii?Q?oHOHciQb6wrLNHytTVlnDzd06obLS78pyGxprt/SljfsvT0Xs59OoPKNTwcA?=
 =?us-ascii?Q?HXQG5u0MXOzJTpoPnQ3/isuOsfvwsPMjS1XLut4M//GUQTIY5ROsdsS9J4XK?=
 =?us-ascii?Q?SbXiHM5mmKjMyR1tyA2GsjRIxVNwVkeTmS2hTR+KOe/uKvHByjCOtX1JKc46?=
 =?us-ascii?Q?KrUWGufLwzJbf80kyirW+8rG3Kz2jjJm7A4bIHCnTF12txBWnhD5FbMFge+0?=
 =?us-ascii?Q?x03wQgbKMBpak9Ld2F9mdpyhXcWCPf8nN7V8ikzwgoSi7Z/0ljELQpHuzORF?=
 =?us-ascii?Q?biVZ4Nr6HDSncRmNx7SWt6d/1cikD0uKXsaNajUIi+jthG+LxXyYsdO3vwjk?=
 =?us-ascii?Q?cuU+5pajeQ14K+zm3eWqKC8WoTlG4Fu9jRMw5PDJrF4q3NOEzrTIrfoY/ipK?=
 =?us-ascii?Q?hv9YtYTHSTinbG9c6onaRF2swkC/YRY1k0s1KKzFrtV2Ky3LjwkIbMJEWGdj?=
 =?us-ascii?Q?fbIooeTtdk8ulNrmxi4Zz0UluJODHnFjWJRLZ6H/j3ZfQ4LqpHlw20ipV945?=
 =?us-ascii?Q?RTm4nnFuKApR+5MkapzMRTM6yOk9rS6g9duBCzdMdaaXroxS848tElcLu4uB?=
 =?us-ascii?Q?VnbFsG04bTdKDMY02G32/k6wELncIZN87u7COKV6JG/tAjd3Ipy02FwrFy5S?=
 =?us-ascii?Q?V4eKVLOjPKz+cGdjxPs3Hne2SouTciKMho3rl7j2ErfaFf5cvTVm0Uk/8UR4?=
 =?us-ascii?Q?l9uHU8r1SqrOynzIXH/m6orcsnlBoAoJdyRFLHJDvuhSHCR0Eb1v9nT+yZE4?=
 =?us-ascii?Q?ADa3b6mVajjBwlFwJiuuMteVXjxE50vBaDQT43Wb1dTctWcbvPO4NbEzkPHC?=
 =?us-ascii?Q?vOUol79iCHuuCk6EstN9aOOWSdQrhrNbWx4+SBo+JJpOxUh2SKX/0ZSWXCry?=
 =?us-ascii?Q?Ks/+nI5cv9P47uYt4cq63xNcwqw+wPb/kVqgqI/uMuN5aF5n5DEvJtYXKWTf?=
 =?us-ascii?Q?0OKB7BrhcjaLTqT0xp0Dam6VAeHrgCkEeX+JiMCMIkcvG1Bq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b5d0d6-a1ba-4f02-cc10-08de639b28e2
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2026 03:11:59.1654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66c9iv4yf6ciaM5iKl62XfooGi9HQsT8e9e7X+/sF50J8DB/YVrr2fjLhhGwzV3k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-213340-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ziy@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,alibaba.com:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 516EEE12FF
X-Rspamd-Action: no action

On 3 Feb 2026, at 19:42, Wei Yang wrote:

> Commit 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and
> split_huge_pmd_locked()") return false unconditionally after
> split_huge_pmd_locked() which may fail early during try_to_migrate() fo=
r
> shared thp. This will lead to unexpected folio split failure.
>
> One way to reproduce:
>
>     Create an anonymous thp range and fork 512 children, so we have a
>     thp shared mapped in 513 processes. Then trigger folio split with
>     /sys/kernel/debug/split_huge_pages debugfs to split the thp folio t=
o
>     order 0.
>
> Without the above commit, we can successfully split to order 0.
> With the above commit, the folio is still a large folio.
>
> The reason is the above commit return false after split pmd
> unconditionally in the first process and break try_to_migrate().
>
> The tricky thing in above reproduce method is current debugfs interface=

> leverage function split_huge_pages_pid(), which will iterate the whole
> pmd range and do folio split on each base page address. This means it
> will try 512 times, and each time split one pmd from pmd mapped to pte
> mapped thp. If there are less than 512 shared mapped process,
> the folio is still split successfully at last. But in real world, we
> usually try it for once.
>
> This patch fixes this by restart page_vma_mapped_walk() after
> split_huge_pmd_locked(). Because split_huge_pmd_locked() may fall back =
to
> (freeze =3D false) if folio_try_share_anon_rmap_pmd() fails and the PMD=
 is
> just split instead of split to migration entry. Restart
> page_vma_mapped_walk() and let try_to_migrate_one() try on each PTE
> again and fail try_to_migrate() early if it fails.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and s=
plit_huge_pmd_locked()")
> Cc: Gavin Guo <gavinguo@igalia.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: Lance Yang <lance.yang@linux.dev>
> Cc: <stable@vger.kernel.org>
>
> ---
> v2:
>   * restart page_vma_mapped_walk() after split_huge_pmd_locked()
> ---
>  mm/rmap.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>

Reviewed-by: Zi Yan <ziy@nvidia.com>

Best Regards,
Yan, Zi

