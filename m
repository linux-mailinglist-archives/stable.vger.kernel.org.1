Return-Path: <stable+bounces-212928-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uK1tE4ZsfWl7SAIAu9opvQ
	(envelope-from <stable+bounces-212928-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 03:44:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA87C0546
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 03:44:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41BEF300C273
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 02:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5828130F957;
	Sat, 31 Jan 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hO9cHJa9"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012015.outbound.protection.outlook.com [40.93.195.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707211624D5
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 02:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769827458; cv=fail; b=sHkU68kCin/h2SB2xC/XFt5w9JRARycmwzm3+EOWhcpXCOvOchJtqy8wCdh0R74e2DBS1pJwgckfkWrv2EbzUi0A8iGJTYIRcJMULDEneGHSrobDSiZKaTkzugaiU2hcCb+L0pKHZaklfr6OUbsVghMOACu4dP4Rq7E82HQgh7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769827458; c=relaxed/simple;
	bh=o5wBj30Yv22kfAXPSllFlE2m4MtMzS2nDHTD8+vBdhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R6KQFVZtgh/6ToBxGRkMS25nDCoiisQgB4eIBStS+wbxSvI0MqnZkxd8EcFpOfeA+mha43hpcRElxbsDNapY1JvswqhJReIsifOS9Qsp6VfEqaCUUOUn/j4Zjrdj11XsvpQPlAnD12bMR13raY26PCsAT/eqUYzmJGZ4fRxPRR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hO9cHJa9; arc=fail smtp.client-ip=40.93.195.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JM/WvrQ5deU09h/tIA8nd+zBj+TNMDMFXJVXfHUMg7JeqCCNQkA1fWIzlYPmx6/gStHcS1OaR+Ei4l49wii9fo+Thsy0EwFO7loFm2+Z5pcd2FlgVaL8WKtskmIJOuw0BDwpd7Ee5kX/Chd/2IvCBkGlDGSS2xCC8NTmEiUdobDOXU3UJwZTkWtyZhXxeQJwI29X25T1e3HwZAjrQBwQtFGDukPN7evMGx4chdKIkL1sEogqJWL5+zwzgAIgFa6pi69HVJEUQfgkxfeVpbaQVr6hMx5KbyBpISF1oEstESyAzZ3yKTKD/Ih2kbsAFO7CP9ShvS0zipQEEUqIlQcRww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/B/sX93QcqXgtlSsA08JkRxXjLNVt0vkhM9/8eoyEg=;
 b=sCRlAOdjmeQ8U8dclatF8SyLZ58k5xJP1E02AEFLcFSAX5emUMV3PilY8ZJ4M0Mh5MUhH/DpqQwMvE3BFWxHGsFxrWX3NHA+BKOvXGFrGqblE+3EjjASLyiPzLBDkjN6K3s9bKpg+iG2Vhqmu5gOHcXew0hK2oEwiVuflTHTi7O9iguAQLYPWDsMU8n/zxuhQq75EsN58PGCqGF8eRyLdRwar+Q8+5hTuc1MD5GhMLdTdU0YDg7wgZi7BOjCHwMlSAx63jXPXO5HY4+dEvvxxfM4ks48yZsqPgtlh/eTHB71ofFnmny2n5gGEYhSDOh20dXiziASronOHIl5hZXUEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/B/sX93QcqXgtlSsA08JkRxXjLNVt0vkhM9/8eoyEg=;
 b=hO9cHJa9KHcXm3PLcceiI+c9zEW73Moiq4AtuILYGkN4ZlCkBAqOBnh7/PuWY0A7hH4nahOszv//siT0nT1sTlzRmMrySXe4fvZPg0dzsU4cbiqBFcxTt6wJDLAnk/VZRQ74o+5NxPCCe+EXqOiPMdN131H1AJOzXEwY4dl9c/ifK6Ll6Ptwh3TSk/8q9SojPmF/MY4YXaVk5gepvW+YgRaxIVom17Yu9QAmmkplK/bfUDIQZkGkAn32gqBqGznrAeEiSoaadyAvUVLO8jKnqyXRlq9QnkEO+IXwnzAa9KU1T12tB/5Z6IKGn7oOknlcpTWTjymR+AocGeOoGomr6Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 BY5PR12MB4132.namprd12.prod.outlook.com (2603:10b6:a03:209::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.13; Sat, 31 Jan
 2026 02:44:12 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::f01d:73d2:2dda:c7b2%4]) with mapi id 15.20.9564.010; Sat, 31 Jan 2026
 02:44:12 +0000
From: Zi Yan <ziy@nvidia.com>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: akpm@linux-foundation.org, david@kernel.org, lorenzo.stoakes@oracle.com,
 riel@surriel.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 harry.yoo@oracle.com, jannh@google.com, gavinguo@igalia.com,
 baolin.wang@linux.alibaba.com, linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: fix early failure try_to_migrate() when
 split huge pmd for shared thp
Date: Fri, 30 Jan 2026 21:44:10 -0500
X-Mailer: MailMate (2.0r6290)
Message-ID: <178ADAB8-50AB-452F-B25F-6E145DEAA44C@nvidia.com>
In-Reply-To: <20260130230058.11471-1-richard.weiyang@gmail.com>
References: <20260130230058.11471-1-richard.weiyang@gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:208:239::6) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|BY5PR12MB4132:EE_
X-MS-Office365-Filtering-Correlation-Id: 242c6065-33dd-4b9d-ec8b-08de60729dbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d8x7qVDju8IXkoouSHdLbQdBd+jLnX8iSOKtxdI+twlNrhWvemRlZzEp5f0j?=
 =?us-ascii?Q?0iwU9RkLQLf0ylJKb3Gc9LmusIYjNSTseZSwe9wGQLCgn+58IW1FtanDtF48?=
 =?us-ascii?Q?pOdT0X3JYZP7JSjtU8CxlgmMtnQGZSwfkAT0LOeqIt/vpHFYX2rlKOg2Ws9O?=
 =?us-ascii?Q?tHJLrEz7PV42tvGYwSGM2W723D/GdB0XiNqNR5fpqca/jbTpGKlVSmUXMO+3?=
 =?us-ascii?Q?oQz3zwbunX2A1qqNYb+nly96slRw4Byk4Re94JDxqj3ifyz1nzLqc5FSTeP+?=
 =?us-ascii?Q?dLKwbUcSD0zAhbMQIC5wo9fIekyyFnsDGRmfvrlkQP5DWWQDGCerfkdQ75b+?=
 =?us-ascii?Q?Ogu80+PMewkv0a6fyLAXCaosMBOowPtlbgS1jROMlvJl9ZfN8Gk0oYAI7K+8?=
 =?us-ascii?Q?fEYoKPlrWHez4Xj2SMalEQ23Q0XWvtwlJ7ky+6fXmcSbn+uTUWTQjL2HPgor?=
 =?us-ascii?Q?LjscGpwmLZIprPSmlMyjpfKHDqaBayuK25ERIzWq4T74/gqYmXjI7p1FpCfd?=
 =?us-ascii?Q?L4xCaV7eUZuFro4CvH97WUEMGd3AusJqRKWvVjVtPMB8NAZrIv1niuILBpt2?=
 =?us-ascii?Q?Lr+VKaf5EN5zZjOTiWneKxYI9/s34uIEnXFpjEpiISF0wk47umhyLTSDDQsT?=
 =?us-ascii?Q?e8L+WWvw2HIagpvfrcCSw2c2JhO9+sHgdnSYj2rWeyjDsRLCvoZlCohrceMZ?=
 =?us-ascii?Q?CHp6Jui63JtAB/5iDwlB4xRV36wTUflZ334kaqUoePXVjbsJ9GwJVFobETIu?=
 =?us-ascii?Q?hsTpz86zOg0MsRol1T6UQoYFlL825glg0snKnXincKne+NODDDI4iSY70MKY?=
 =?us-ascii?Q?UpzEpI62LKgsMrU6VEdOjQ8CXHRHK0/ED1VCOZuPpAUdYK6Q64HZ6F2bV83Y?=
 =?us-ascii?Q?3KWVOmThOMJeqpOq+V0dgpATAOM2xC3ayD25FkCd48r19dXjkE/LfYhJ7NL3?=
 =?us-ascii?Q?cfR+Y0la2C1iTdci8eh2BFF8iQciWK1FMHEMFF2QB1+w/uyNDPea7vv1Dee9?=
 =?us-ascii?Q?4ICozdmgFuBFziaTsofvhaBr8ujwcC6e+knDiCwQRkOcbAdZb17f0If/kiaX?=
 =?us-ascii?Q?2P1MAcnQXxXorxpNaK77QLq91bD/GfhnDFrVeVFVcNbbwCI+xdbLMlgBCKUA?=
 =?us-ascii?Q?wANq2KCe9zmbfRfHYKOeLA2q2fZFwOdiqUDbbWkrKZGEDAw+Bckwx3/KVaGc?=
 =?us-ascii?Q?b0rf8gVa1i0OFWoQn/zgAH1ZmZdC4ROl3M2Apq8WZtUIamGmObKCoIaO8QEH?=
 =?us-ascii?Q?vHbijlhbPTsaew3ysm3eeqOW5BLvHwzwLSuHczfSAwMfn+vql3URjT4a3ZQD?=
 =?us-ascii?Q?C58M8x5kKCw5MewgCGQYPENwA62F3RCBZ+NhkDELH9ojqpmslkH/WTq7R+2K?=
 =?us-ascii?Q?YJhU51+WATVIBTFWJTDyxgUIGngSjljQgJMWD7VunwrHNWmml+0E1NBirJME?=
 =?us-ascii?Q?BAXZT4H2A3UTwS3Vx7Vfmo8JfiUjbqdyZUR5Fs6iYLnrbuYXBC+Xy3YV6g+p?=
 =?us-ascii?Q?KUrIsVEOd7NJ7UleOQnOIoB7eBTQFFNIYxO+gI1cIAZqSunNMI4mPlLSH0Je?=
 =?us-ascii?Q?VvSDWrvonKAWNikY/IE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5US2+g9EbPNmm6p5gNBtX4aPo1kZ54ezKkScOt9O4IHUqGVeBg4G0K2vp1vb?=
 =?us-ascii?Q?s8KaXuAD7VHslqwkIvs7CSAdGM/BoQlIjJjBDGApFvl7xqEfs98YDsEQLHo7?=
 =?us-ascii?Q?N9UziGaBCEA9HTQjRudJQcqS0hcx57fVQTxYHHUUxmV4DklQPeq21RJpf9jt?=
 =?us-ascii?Q?+qjh9nD39KPWDGROTCU2/oAsj3x3ZqoNXQxK2nzJrNtKkhEsp50G4Qj+z3kT?=
 =?us-ascii?Q?VG19U4cCwazpAK2pbHtSudv9bnviVjE35oUTy/Phyv6CyvCf4GT8ByT0JlWC?=
 =?us-ascii?Q?uZYncDdAvxSl0MFaEUuobRxJGbN+vH49VEDrHzYUy6YcClbAvdxHw21Tz39r?=
 =?us-ascii?Q?BJWp5y3NrPtEBFPkhJu2sx2c4WWg9Woe0h58gGbgsB0wsx6isZL6q2pQE2vR?=
 =?us-ascii?Q?FXSq9a6rjtTCEUKyYomgRih3yERG9X5uHmagB/C2epw5v7eerEBQ4N4HZCbl?=
 =?us-ascii?Q?Sh1xzDb6xRNEmeOSHJ93rs0deEJJQej/VzOTuNRi32/E3iFv2HApN7kLjOhT?=
 =?us-ascii?Q?CSrPqTwOhzZV/Xc6HlaVhei0IX12B0RWMN12AGYpjt4++LerUCNpSZ5fKBCP?=
 =?us-ascii?Q?iXC2YnTqRv5q8Irs4Pc5EnY6nvb+tUICvX6yK+v3MNzyAYy746XvjRCf5mpL?=
 =?us-ascii?Q?ngfC2UiaAZBKRGNmN/BFtAQJieIRk0o/GVvZ+hKpKcmhzoM/HOQ0k4q+UHPg?=
 =?us-ascii?Q?LZ0FBZFN37KP3ITJN5Phtyo7zXDVkdfOabhwohvF5u4m5sdqpOvJ0xBXLb7F?=
 =?us-ascii?Q?35DCfpmTOt7LSl6XFthvZ0RLiKQCuTLqFIPa87tz5Eb0IDCY+FxPFwtuZ5ms?=
 =?us-ascii?Q?79jF6psIsBtlvRKM9QEdLe+Efdaz8WYmYRVuyvR6nF/7bC/H86Bz8WK3U0jV?=
 =?us-ascii?Q?Uc8iIFMY54ll7MElZggfzYQTDehvD2e99PptysJb32x4OmQSo35vzS5D/KGX?=
 =?us-ascii?Q?zg3j0UMkI6YBB/Q4DAgasghRUtph16hUsB1pzVwMgvLwqCa3NIEkxSV3O86y?=
 =?us-ascii?Q?HFElIH31k5flie1kl2mOs+Xc+cZowk0WuqcneXIP4HPgoWsS30YQ0DwKbq8H?=
 =?us-ascii?Q?48OPyXbIKXuXWn/Tls9d5XbOj0K1Jb+M727kwZu3LTORAWXEnKAcXvfvHTgR?=
 =?us-ascii?Q?4+1+NjL/ii8OiNLSea4//2mPKXB0M88Ig0zgcZfVdn14zewWvsy+4BKrBE68?=
 =?us-ascii?Q?Cai/SFo+G8R58k55+rw0A6g30e2ugbR13qZe7M0yxzzHb4AFR/sSV2RZEs76?=
 =?us-ascii?Q?7CWUs+cCxzGu3wxyQuO4e48NfPVITc0DWBSt0g2bCx8RNyRV2K+Bz7CIpTgr?=
 =?us-ascii?Q?g1eMMk7e4AdElltukOp6PfjP8gGUj4a0jgPbkZWXfKAyrt2natkRyLNxGQkP?=
 =?us-ascii?Q?+yW+oQOyzsohJTlfrw3RPhpUTWQ1y6eyM8xWz3L2DfB8sNaD6kBExOMabF3I?=
 =?us-ascii?Q?9Hw9y90Jdzzo4zFASeVS+8v6u2YtVTo/qIK7n5P4CiBalUCkyO8FADd1sPq1?=
 =?us-ascii?Q?j6x3+vKXcc4oWJrr4yOSVvJMwvbppa6GjDi/d50f+OsHsp7XebTiMXwG/wgP?=
 =?us-ascii?Q?57FoeYPbPMG0IeCa4NC/Xk/OiSol1OCFDDclkciAti1ZJF2P0AmOxlsOZGAX?=
 =?us-ascii?Q?/S6bR82QM6+mImp4gQwfH9a0CTok5LCYCJ4bsZT3XV51DGlL7e3x6SWNbDkK?=
 =?us-ascii?Q?dyEN0q29N2F7IWeKBfTq0i/PD+EsXdIhCc37VuOMHxVCfD2Z?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242c6065-33dd-4b9d-ec8b-08de60729dbf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 02:44:12.4884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AbQqaoibRmz2AxwPbPB6E0dlngTNyc0urPvIGGIgmloShfBSUpjsa12GbdpzGv/4
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4132
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
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-212928-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,igalia.com:email]
X-Rspamd-Queue-Id: BCA87C0546
X-Rspamd-Action: no action

On 30 Jan 2026, at 18:00, Wei Yang wrote:

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

The reasoning looks good to me.

>
> The tricky thing in above reproduce method is current debugfs interface=

> leverage function split_huge_pages_pid(), which will iterate the whole
> pmd range and do folio split on each base page address. This means it
> will try 512 times, and each time split one pmd from pmd mapped to pte
> mapped thp. If there are less than 512 shared mapped process,
> the folio is still split successfully at last. But in real world, we
> usually try it for once.
>
> This patch fixes this by removing the unconditional false return after
> split_huge_pmd_locked(). Later, we may introduce a true fail early if
> split_huge_pmd_locked() does fail.
>
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> Fixes: 60fbb14396d5 ("mm/huge_memory: adjust try_to_migrate_one() and s=
plit_huge_pmd_locked()")
> Cc: Gavin Guo <gavinguo@igalia.com>
> Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Baolin Wang <baolin.wang@linux.alibaba.com>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/rmap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 618df3385c8b..eed971568d65 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -2448,7 +2448,6 @@ static bool try_to_migrate_one(struct folio *foli=
o, struct vm_area_struct *vma,
>  			if (flags & TTU_SPLIT_HUGE_PMD) {
>  				split_huge_pmd_locked(vma, pvmw.address,
>  						      pvmw.pmd, true);
> -				ret =3D false;
>  				page_vma_mapped_walk_done(&pvmw);
>  				break;
>  			}

How about the patch below? It matches the pattern of set_pmd_migration_en=
try() below.
Basically, continue if the operation is successful, break otherwise.

diff --git a/mm/rmap.c b/mm/rmap.c
index 618df3385c8b..83cc9d98533e 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -2448,9 +2448,7 @@ static bool try_to_migrate_one(struct folio *folio,=
 struct vm_area_struct *vma,
 			if (flags & TTU_SPLIT_HUGE_PMD) {
 				split_huge_pmd_locked(vma, pvmw.address,
 						      pvmw.pmd, true);
-				ret =3D false;
-				page_vma_mapped_walk_done(&pvmw);
-				break;
+				continue;
 			}
 #ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
 			pmdval =3D pmdp_get(pvmw.pmd);



--
Best Regards,
Yan, Zi

