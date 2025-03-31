Return-Path: <stable+bounces-127027-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2538A75EFC
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 08:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F0A18891EF
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 06:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE0514A4CC;
	Mon, 31 Mar 2025 06:46:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46EF70805
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 06:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403591; cv=fail; b=Z0cOHtCI62wUleNU2YNTb6ppYSLArNojUOcNOGrw4wSPh2MppRFmLGfJP1NSyGM35fX1/fZCor0M2I7vU56RsQma+v/5u7zHzvECnU2Uj42+XuLQGo1nWLfB2Pq+nqBeDkcFeVsbL83blSeepI17mVmKk/eJsXySH+Vv25bVEnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403591; c=relaxed/simple;
	bh=5hvMX094V5FJbwCJKADf/vbAAnsYHuBW9L7ubSyRZLM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F9BqCY5owBLw9BaPizsnWG+/GkVfgowwUQL+fpKYnucAIuICR43pu+bDiSQ3ySYXOQMWd/p8lNOVpzjAd3lwNJ2hXgQUngyx1LaGd9mBn417OZVdEzYm9EaMPe6afLIqiq/WB/JZtKHfx3VBPvFsl3WSjtM7CTWVRNUM6DBSncU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V4xUu2027928;
	Sun, 30 Mar 2025 23:46:18 -0700
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45pgck9ev2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 30 Mar 2025 23:46:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZQo0dXJIuxjHxOZsmxirkQwC+NsHg+3/BJWy/kWKNlXWYye6vaG8TWrFZH5mDwq66lWLXFZ3Xsctw5ejBTVHCYxa/NUQUjDQfurzgaspy0wq1jEs7/iuvWBjLC3nzXxsOeeMhW1kWRIubIXkjb1qw2C85rzPvObcDVMI8Dkptwrryvj5n37bbO41PdASr5WrqVsRg6fQxQInW50ukVJOzB0sBhoDOUmHwFOuEocjjMDcOPDNY9EGiUTHmEmr6FF8N4HokCCFNDKSOXFLSFpMRzNdAwECqYqVkAvjpJsgHIrETLfXoa5l9eg8yoqyUuLeStg3MJetpT6ltl7+wwpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N19BIFHNMm+tyHF2GpbQa/kiGyv5VWXNClVg7FtlRSk=;
 b=E4TXZ3zlyZdwkGHmwkrhFhkoiwEDH1PgAEvoFuuJriwjiUvTrREi9N6gWGIklA2nKM7YI6EJdSwKfTkMyGRnkxewo6sOXMmrzbuvXxkY8adklNx9xgPOwbhY+NlMGqPTgvzJLYsVLEpYcPYBEiOQFiw7F5gyCwlQkUAMjailfPC3JMMBa5q1r4ZTlR8/x9VdXZIFZ8R4A9FpXHRNTyX2aJTtIFs3rcbsiQF9oIAHRQ3BKi3Tpi09iHe7gOj/qZIDeyguCGMrsNZmrWAo3BCI5BtNN3hmy2EzGSqFYrJae72wEbnggKBqoLdRwcEK7QXAw4DPXwcBzgiztXcQST6Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Mon, 31 Mar
 2025 06:46:14 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.045; Mon, 31 Mar 2025
 06:46:14 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: u.kleine-koenig@pengutronix.de, sakari.ailus@linux.intel.com,
        bin.lan.cn@windriver.com, hverkuil-cisco@xs4all.nl
Subject: [PATCH 6.1.y] media: i2c: et8ek8: Don't strip remove function when driver is builtin
Date: Mon, 31 Mar 2025 14:45:49 +0800
Message-Id: <20250331064549.3180155-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0021.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::19) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b9de17f-a991-45e1-7081-08dd701fbafc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjAzUVE0Z2dneU16K2x4SHNCTVY5RUN5RmRKRFJlSWtCVE9QTTBQVTFlb085?=
 =?utf-8?B?UUtKRWRoQmo0QytWdXIvQnJQNXZ6Q0ZSYUsyMFNBSDJ4SWE3ejhqWnhaSGE4?=
 =?utf-8?B?cEdxZURTejRtTVZEMTFmRDZlNUFMdzBDRXFtbUdlZWxuOFN0WjQ1aGxMTjJt?=
 =?utf-8?B?SzdKN0dBWXE2WW9MN3YzbFRZZXM0alM2cWZrS2tiS0p1N2JiNTR2VldZeXFm?=
 =?utf-8?B?WnFNbmRoZGVBem9MWVRtU1pXTEhnbXM4ZmxkZU1CQzFwS2xhSEhWR1VhOHZx?=
 =?utf-8?B?Sk9LOGNrVGp3dUVwWk80RVU2ZlRta0ZoQ2JibFI5U0hjVUNkWUFmUExQYXlE?=
 =?utf-8?B?UUNlMjlKUXhhWmV0aXpoZjI2NUtPaVhyNXBsckxhOERnWWhZVHZicUM2WDAx?=
 =?utf-8?B?UzZRNFQrOFFkbHpVeWJDZFFac1BPQ2NsZ3hFRlM4WW5FNW9oSUhTeVp6MTNx?=
 =?utf-8?B?UDZNbG9taDVmdUlPM000ZVJTUHZ6bjkxd1ZtMkV2TXlNT2F1SGlHN2FYMitL?=
 =?utf-8?B?VXVNSm8wdGVMNzZOeWNwc1NtaTk2eWdQZ0dKRTQzNGVOT29ZcXJqK2d0S0Ir?=
 =?utf-8?B?WkxnUGJTa3lMZFZpSjFsRjNrTFFmVkExRkJxOUN3NDRMZjQ2dklCczVXclov?=
 =?utf-8?B?WkduVVZGdGVOUUxSczJrMk0yUXY3OFJhY0Y1TDB5eC9ITUNoZG9JVXRBUENU?=
 =?utf-8?B?M0RHVTdsd3BvbTdNQXZOQUYwK2xmUHpEV0FCWHRNK0N6eXdCZkJDUC8xQThC?=
 =?utf-8?B?SVlvb0tDNys0bDd0N29jS1RZYVAzSzFqRmpualVRUFNpb0JYaDgyVjlrZ0dH?=
 =?utf-8?B?b2tpeS9vUi9EdW5Cb2RVTkxPbGVabXEvVkJGU3BsSENTQXNiU3RQT0RTTUNj?=
 =?utf-8?B?M1BMcWhXRm9od1Y3bmsxdFJzeUlUVUVmZnVEWEl3L1UwU3hmU1VvUDNieGl5?=
 =?utf-8?B?aHpDUlQvaEVmMUg4TlN1ZG5LeFdQU2tWUkJtUHVvUW9wNlBPbHBzaEt3VWpT?=
 =?utf-8?B?dUlFYUsvbjhmS3JQbHVncVZTeWZPdGo3amdzWURrQUx5S0pReXdYRnRPWmFi?=
 =?utf-8?B?M0pNb0FiOXRQMTc1OGJOdXJCaURBUWdmZEZxRDEzdmdCZ0psNlA0bmZ2Y0c4?=
 =?utf-8?B?dXFabnRvRVQ0c0l5ZStVTVdublYvWlZwR0FPV3kyVGFxYkF0eUlGT0lnNE9F?=
 =?utf-8?B?QmtLUXp2cCt4SXZjTVhHV3VaOEJ2ODJSc0FYNkdEMGtiOWRDV2Y4YllLUmpD?=
 =?utf-8?B?MUNUVGk3OTQ5Q0gxR0RYU2k0R1o5bDVkQlFpVENJWDFrQm9JQWFrR1lqRHdV?=
 =?utf-8?B?RDdERWZoZFdnTUJQTVpWQjNzdlNzWHdicHY5d0lCUEt3dkxmSkF3R3lzNll2?=
 =?utf-8?B?OElXTWpYSml4ZUd0S0VXbWlYN3lreUM4bUJNNnRpMWxwS2kwVCtYcjJpRXJt?=
 =?utf-8?B?eEx2aDZXK1FVdmkwelRkOU9WRUFVeTRwc1BEbDhwVkY0dFZhRWc1K0hFWElW?=
 =?utf-8?B?YzVaNHoxcTF5ZklWc3NBVHAxQWdtQlBPTzBjUCtuRVVKYkU1MWgxRnRoZmRM?=
 =?utf-8?B?aTJQendLNyswb1ZMV09VRTgxOHB2d1A2dStwMmIzQmZ6elFPZWRoUjA5bDZl?=
 =?utf-8?B?NitadktmY2pwdUhSWC82QWFWNkhlTk8vZHNBMEp4SkJLdUR2WVhlbFVHcjVS?=
 =?utf-8?B?ZkFGSk1NdlFQeWFjNG1jeDYwdnJNNG9wKzJMaldtZlpER29UOFJTNXpzcGtp?=
 =?utf-8?B?TjczUTlmaEgzbFVXdldHYXV0STI0bE1kY3pDT0Z5cnFJVUo5Rjd6eTRnbFMv?=
 =?utf-8?B?SWxkT294aTdtbnVNSlpFTk0yMVFQekVyWU9LZU5pY3BUVDFFOEF1bk9iZ0FB?=
 =?utf-8?B?RlplWndCVjVpUGt6YXpNUFl4OEhQdVduZUZFOWI0SURYM1FWVThPV0ZpdE4z?=
 =?utf-8?Q?nJ2v/dqDNB4CYY/miSjnc58/sEfHyByq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UDljOWxYc0dxWjhWMG85YWhkaG9qeHVJejkzTmt2eDZBeGhxNllVUG9LV3Mz?=
 =?utf-8?B?azdObFczVHhGVlZKcVpDVGR5alA4NGFWUloyM0phaWhvWE04c2FKQkZRQXBY?=
 =?utf-8?B?a3Jqd2lRMXEvdlRlWDMyOTZIOFlGdGFxM2taeXN4QzZaZS9JZmJOVmhXaFEy?=
 =?utf-8?B?N2ZGSmVhZFJjVEpYWEFnblBTcTJxanlTWUdiV2t4Y2lOWlNnZTcyWWhDMVZt?=
 =?utf-8?B?dS9Dek9CU0h4WlBrb3pGSk5KSnprMHVuVi8yc2RuOGcxc3cveVozSStpcnJ2?=
 =?utf-8?B?TUJ6NGtJa2hVZXJzZzRDRjNOWEhCL2JGR1pCSnBVRDlQd3E4cXIwSjZMcG9N?=
 =?utf-8?B?SjZhSml0K0Q4TW1qSC90THRQN2tLZU1vbFQxNHhodFRWWlFEQ1BYdmR1N21D?=
 =?utf-8?B?eW02UDNpblFMSGRScWlINnN4ZmtnMEx1azJQMTJsV2RySDBhQVBiL0Fid0Nx?=
 =?utf-8?B?VlFsZzJaUlVPcVpjMXh0V293cHF1S2NsNk5reGtISEgyN2lYeDkvNGJETmdx?=
 =?utf-8?B?a3ExSlhsTXVCZFBSWjB6aEZuRGx6NE1vT1oyZWZobGhDRWw1bWtqZFlIcEpC?=
 =?utf-8?B?emIwdzhQbHdZREU2OTFpZU9aVFNWVEZhMGNHVnIvclBoY09CWWZ0b25UdXZj?=
 =?utf-8?B?WkZkQjlIaXBBenB5YS83Q00zMlA2R2dxc1M0WDVta0t2dTBaRXV3cldwVFF0?=
 =?utf-8?B?SXBQOU9wS0gwYlJ3d2xsNjFjaTNkMGt5d2tzSjllL0taV3lPY0JXZ05EV0Qr?=
 =?utf-8?B?Yms5S1luZTNiU3p5SnRKeUZGN1hMeGdsalZuczN4M3pKTXdyWU8xMTVKeVBi?=
 =?utf-8?B?dVlvcW9xM3M2QXd6Y3o2UDFyMFVsb2sxVkc5UUJiMVl0RG5nSklsV0I1c2p5?=
 =?utf-8?B?bWhiYnpRWXFyNVFaNDYzelkwaTZ4aVB4Zm16NFBVUDBPZFN3a1BCVkQzdzM5?=
 =?utf-8?B?VkxFdUFxb2lnZlRtVmZkeXpGMnB6b09KYTVZLzNXTG5hRHNVMDJ0U0J2V0Ft?=
 =?utf-8?B?ZkhSemM4a25IOVRDTjYvU1hqZzBZNGpJZnhjbWIvTEVUbWxiTmkxZmkyS0ZE?=
 =?utf-8?B?cVBLc0pEZ1dnWTNwbVJKY1VsU01wemZ3Q3dNZ2xmUkZmYkF2YzBJNTJYVVR6?=
 =?utf-8?B?cTFrWU83YjZkMHJEYXhBZXJudUpTUS9aVEp0a0x1cVdwL2IwUFN1Uzd3N3JU?=
 =?utf-8?B?a3dRTEVSYnFBamx5OSt2UGlHN2MzLzBKMm5scklwcFViOVdacnR2WWQxMUg1?=
 =?utf-8?B?ZjBlajRrK2RqREw4SFZMMUI3NFh6YnZzcDBXNXRwaDljb2wvd0JCVVZUVWgr?=
 =?utf-8?B?Rm1UcFVJeG9pT2F0UkxWU0dPSGRyVVk1SiswdjR5SHZFSFp1STRYeG1vci9W?=
 =?utf-8?B?TzNZRTlzVytxOWhmR2pzRXBwbUFiUzQydUgrR254cnVyajFWM3J0Sm9wMXNH?=
 =?utf-8?B?Zys3eHhZN1dWd3pWdjZmK3FYaDlQRU1CSEN0TFBQRWlpK09WL3dMdVhmSU5J?=
 =?utf-8?B?bU96N2VtQ1hLZ2hBVkhaS25qY0JPM1VYeXZNWVgrMzU4dDNNazcvbXZVaTlx?=
 =?utf-8?B?a0lEeVNHSnV5ZHRWdTkxLzRlTTNBbEt2cWdFSGF5emphTExZV2x1YitjZnQr?=
 =?utf-8?B?UkdPaUVkRnA4Mis5OUlaRzJicVZpdnlUZzZBQ05MUnFEUkxFelpDY2dOb1pV?=
 =?utf-8?B?NGF4VDRaRkpOTGJUclJxVCttS0hnL041VytBRmlSdGxYZU9vZ0JmTkdTQjFL?=
 =?utf-8?B?cGx1eEFSQktRMERLNTlVUUN3QnlKb3VqUmVYanZwMjFJclRMT1ZYRk8zbzNN?=
 =?utf-8?B?UnVzc0hVMGVnajkwR21Ba3ZvL0RuQkV5ekF4R2Zxck5za1c2VjJCdHlSN01m?=
 =?utf-8?B?VUNNQ0ZJUXZFa2dNb2dCNTNQWTUvYXpYVE01ejVMMm56RDVYUTl2QThiQkZG?=
 =?utf-8?B?STQ5Z3M0SEhtZThxTzJxN1FUVUtPQTV1UFFVeVR3MW5oRlV1a1dLcjRkNjFi?=
 =?utf-8?B?cFNFNW03UmR4V1VubDRxU2R1dXpCOVdxZUlKM0xrRXFDSGtjRUdSOTZxRWY5?=
 =?utf-8?B?Z3VQUWNCZDJKTHFNcjFvOWFDNmJyWlJocFBHNW9uWERyTTZBUER5azI2OStH?=
 =?utf-8?B?NUQvbTB3MGRQY01vT3lrZGxpRHlNYkxMNkU1bFhiUzVaSWdpZCsrRzB6YVM2?=
 =?utf-8?B?ZEE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b9de17f-a991-45e1-7081-08dd701fbafc
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 06:46:14.1668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FzvUpAX1456I3Jh0Le0wx1aJpC95/nZS5FmzLE3rGxERbB+AmD1uWPC5wybg31TlJ+RHF4N5kYdYk24Ag0DgdUT5cSFhn32Nq1MkZZOH36s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-Proofpoint-GUID: flkkr-AJL3weIk_AhGWb4J6osD4d7WvB
X-Authority-Analysis: v=2.4 cv=Paz/hjhd c=1 sm=1 tr=0 ts=67ea3a39 cx=c_pps a=mXs27GP3B2XOU+bPH1EGlQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=QyXUC8HyAAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=yxFpyxf4MhevmFWHfCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: flkkr-AJL3weIk_AhGWb4J6osD4d7WvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503310046

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 545b215736c5c4b354e182d99c578a472ac9bfce ]

Using __exit for the remove function results in the remove callback
being discarded with CONFIG_VIDEO_ET8EK8=y. When such a device gets
unbound (e.g. using sysfs or hotplug), the driver is just removed
without the cleanup being performed. This results in resource leaks. Fix
it by compiling in the remove callback unconditionally.

This also fixes a W=1 modpost warning:

	WARNING: modpost: drivers/media/i2c/et8ek8/et8ek8: section mismatch in reference: et8ek8_i2c_driver+0x10 (section: .data) -> et8ek8_remove (section: .exit.text)

Fixes: c5254e72b8ed ("[media] media: Driver for Toshiba et8ek8 5MP sensor")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/media/i2c/et8ek8/et8ek8_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index ff9bb9fc97dd..49fe2bd702f7 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1460,7 +1460,7 @@ static int et8ek8_probe(struct i2c_client *client)
 	return ret;
 }
 
-static void __exit et8ek8_remove(struct i2c_client *client)
+static void et8ek8_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
 	struct et8ek8_sensor *sensor = to_et8ek8_sensor(subdev);
@@ -1502,7 +1502,7 @@ static struct i2c_driver et8ek8_i2c_driver = {
 		.of_match_table	= et8ek8_of_table,
 	},
 	.probe_new	= et8ek8_probe,
-	.remove		= __exit_p(et8ek8_remove),
+	.remove		= et8ek8_remove,
 	.id_table	= et8ek8_id_table,
 };
 
-- 
2.34.1


