Return-Path: <stable+bounces-134995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B2DA95C65
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 04:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30E55174ED7
	for <lists+stable@lfdr.de>; Tue, 22 Apr 2025 02:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A373A15B115;
	Tue, 22 Apr 2025 02:59:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A929CE8
	for <stable@vger.kernel.org>; Tue, 22 Apr 2025 02:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745290742; cv=fail; b=MuvFfp5ZfOSCnfIX0VsDCQfLI1faMxfQ7n762Jr3PxN9Rod6um/jtlS/iKDKzn3plmgujNizmXKdCuA2YbFBmcTpbs2Z62IskdA0hcDRlyQUM1A8Qna66iRwp3I3jrxKVkZVtSHyqJ4IIya0/wSa/K88ADygPI6lY3yKF2sVw28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745290742; c=relaxed/simple;
	bh=BoQFJJxWtFYBkdYtp2YGeUDP+sX2Lhsy580G3DwQ4yc=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=a1I8CQRzxXDdhOy1IcyfghO/3pYjiiJ8TpQa6MpYwxtv/aAwQLkH497k6VLs6IlgcHIwI+yh4M29qg54OZFg5wtWxk7ENc0wZY7UKZpzuPQcZUaJ8IVEzR+RlHMfxc88NwwC4gkJDFNAGRa5jVhpgPJfWeCEmms8dcTM03/PT1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53M2wmlI006414;
	Mon, 21 Apr 2025 19:58:48 -0700
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 46474429as-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 21 Apr 2025 19:58:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r285nCKv+9BQdS3GGRCOICE25oVcaMst2fuJGgotpGQuVtSSB0Rd7/eC+jVWNLcJJPZxvlLjX/leu3hgW3DZIB9bt4onhvYMKTyFO5Ke6BTZVhaxXVXBCPXaAlosueL278NzmM5E1KsdYBwMtn0ayIP/CTYxuqVCAC1450KZkejXvu4nWg5hiQVYpUJIemBlkNkjE8vGiuDIyj1ixysoZGAlDFMoJYhSUynAWb43Od1O/R171g2X5GrTElU2xJbDtpgBRm7zafnct8imsYWlUfri76QWt+A67Azs+/lOzN0sWGi+BGsjH6kL1ms5o46L1XdUB9Zj3HUyi6g+BJtGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Gsz1Tw/hwI6Vg/s5AHvyeu9xrM5Kv8PjnU8LeiazZs=;
 b=UsDdm7isa9e8WccIQss/9V6vVw4/lxo7PJKzEKlXp6s3fN++o4ZPDpfu8Tvhf1mvm/H4+gv6d0n2tiU6sa94hy7aopKjOg0KKp1XtLCKSHpNJFILW4I/IMtc+4I8NgZPyLEAkEwZaZUYWSNWRKOq4OIyxTElF2iuggrXIDSqia/HeA796oPArx2ofS78jaXOXXsgESnuMJy1/1033U7yRDWskE8ornc38RfO8WIQsB4XKThywBRzLEy0cJO0PFObFsLdL6od/OkxGRHf/NnzXVqrf5+qZ3rNmdhCeCe7hqjg7MglksWkMvO2cJt8chdmRzJTZmNXk4uAS7XLneChQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from IA1PR11MB7174.namprd11.prod.outlook.com (2603:10b6:208:41a::7)
 by CH3PR11MB7771.namprd11.prod.outlook.com (2603:10b6:610:125::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.34; Tue, 22 Apr
 2025 02:58:44 +0000
Received: from IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4]) by IA1PR11MB7174.namprd11.prod.outlook.com
 ([fe80::562e:b570:2775:f6d4%4]) with mapi id 15.20.8655.031; Tue, 22 Apr 2025
 02:58:44 +0000
From: Feng Liu <Feng.Liu3@windriver.com>
To: mfranc@suse.cz, hoeppner@linux.ibm.com, sth@linux.ibm.com, axboe@kernel.dk,
        Feng.Liu3@windriver.com, Zhe.He@windriver.com
Cc: stable@vger.kernel.org
Subject: [PATCH 5.10.y] s390/dasd: fix double module refcount decrement
Date: Tue, 22 Apr 2025 10:58:32 +0800
Message-Id: <20250422025832.3525312-1-Feng.Liu3@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TY2PR0101CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::17) To IA1PR11MB7174.namprd11.prod.outlook.com
 (2603:10b6:208:41a::7)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7174:EE_|CH3PR11MB7771:EE_
X-MS-Office365-Filtering-Correlation-Id: 5210f8fe-5cd6-4b6e-6cfc-08dd81499818
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWFPQ1lvYUpvcnhNaWtwMHdzVjhQZldsNWtrNnQ2eFI2RzlLdHFKcDZiY3lq?=
 =?utf-8?B?V0lJS21ocE1lQkRrOUp0WXJhYndpVng3OFZOSnBMS2tHeWliVFl0emJ5blVV?=
 =?utf-8?B?bk03a0xTUVNIRGE5YXVCb2RxWm9WdHlDMnJsQW1YRmh3ei9wWThLSWl4K3N0?=
 =?utf-8?B?ZDlTanVMUkxRRTdSNmppRFYxRWV4UENmNGtucCtGTWlLd0w3YVc5NmFwTFNt?=
 =?utf-8?B?empxM0h3cElQelcvRUsraE1wTm8xZ2s2MG50RnJJNS9OTHB4YUVmY05EdU5D?=
 =?utf-8?B?Ukd3b2c1MG5KUmh3eUNtN3NqOUZiRjZObmI5TW1IbzAzcFgrdXRlMytXUURo?=
 =?utf-8?B?UUlETUlXcmMxa08wYm55dlBLQ0c0aTUrTGF6aEdvR3dRNGpXbEcybVp3RmhN?=
 =?utf-8?B?bVFnNWtMWVUyZ29LUXNCNXdYa3JicENCK042OWhhZllzQ21iSTR4RVo1TEtB?=
 =?utf-8?B?OE8xSnJJQTM0bVVaNlJmWitSMTB6SGNPZjFlNSs5cWRkd3lQOXhZeGhHRlZk?=
 =?utf-8?B?em42WCtuZ0J1NU9ua0dCeXU1OHEzK2t3NmE5UUFLck1UY3FpbW0ycFpDc1FW?=
 =?utf-8?B?aU9ETDVrZC83azJsQktaRWVrTTZuVkVLdWJKZVRzSHJvVWlZVUlUNk8rZ1hy?=
 =?utf-8?B?RkYzbWxFdkpKdDRmbUhzakxBU3ludkNWdjVucnJSNzFlaFZDY2x3MHozb2VC?=
 =?utf-8?B?L0dla0Q5Q2w5WmRoVC9LVWNVV2VDaDBTR3RMSFNRMUhPS1JHbkg2bFIxalpB?=
 =?utf-8?B?eG1MZU1LNTg5SVhmYk1FQVpWWlZCVUp0N0V0R2toeHc2c1VoYlFoSWV1MDEv?=
 =?utf-8?B?aGV6SkVweDZCTGgvamY0UTluN2grNzR2cW4xeWZpVWpDcVFSaGYzdHNpOVlB?=
 =?utf-8?B?RHFJTitPWUVQUHRvVXhUUjFDdWhabTZrMGlSUEZkcThuRlZSS3dNcWJOVDVG?=
 =?utf-8?B?Z3BVTE0wNTRXU2VXZVVtd3c1UFNEUU5ZSWQ0YkNDc0F2S0NiZnp3T0tWdzJ6?=
 =?utf-8?B?OWJjRllvbTZ1dlFKMWhSd2dObm1SaG5qbktIZ3EwbmZ2LzV1TGoyS1F6enBD?=
 =?utf-8?B?eG1XTzVmRGduQWtOVmRJMDhHd0tTeXl2elBEM09oNXlQdmpaQlNUMEdNeE14?=
 =?utf-8?B?QS9uTktRelVBQ25DYWlkSWpGMGttRWxBbzFRSWJseHdMT0pBYmhNT2VWYWc0?=
 =?utf-8?B?VjVHOHI3TDdRMkh3RHpTQk9PVS9FNzlOVTBHenU3VnBNL01zbmpwcWoydW5Z?=
 =?utf-8?B?VDUvclJQMFphb1BpOU1GelhZaFpham83QWt2S2tEZDVhaDN6RXBOcm1QaDc2?=
 =?utf-8?B?dHFaSzd3TkpJZ0xTV2RuWGhaVTQvalNHZ3J2ai95S2tqdnhwZWFQM1hrVDQz?=
 =?utf-8?B?ZjljZTBYbDdYamhpblFDMWF0OG42Sm1ZaHUyYlUraG04MFV3RVh2cXpDR2xJ?=
 =?utf-8?B?SVFHbG9IL1hiRUJyMVprdTdNVTlLbGU0YlgzNy83QmVjWVhEODM2L0EyL2J2?=
 =?utf-8?B?d1BGd3Q5dStKcC8wem5Nc0hoT1BoTWRVRlczZC9xS2s2Y0NzRmI3Zm42WlVr?=
 =?utf-8?B?UU9IWEdNOFB4V081MGFJbzBheFEyT2hRRzlNQlM1SmlqcUUrRkkrT2lDMkU1?=
 =?utf-8?B?ZUdlU2gxM1pnRTJuTTJmczFtNUVrSHJGdDdTT2N2eStSQXZFelQrY05wcnl0?=
 =?utf-8?B?UDVvNWdaL3RsT09ucCt3M2I4TzRxdXNJVENFQU1nUFVFUHpmS0gvM0tmblJK?=
 =?utf-8?B?Z2xGUkNEZFJVNzZNME5YaXYxVzBlT2tCMnZQbEkzR3lSaFJVM2ZwNm9xZzYw?=
 =?utf-8?B?cVRMaGFobHJnWC92Z1dQYU82ZHJqNUwxWEhZSEM4R291Sis0MkpZSkJQdWV5?=
 =?utf-8?B?c2ZqQXFsVVM4WHNSUzRkWUFPV2h2a3hWa2svZjNtM2gyQ08zWVFuVmU0ajZH?=
 =?utf-8?B?QmJVRUNSU0hkdklDalVsMDYwNnZPc040ZExpUTJxZzNmOHhsc0p2YmJIc3FK?=
 =?utf-8?B?SEJXSi9kRXpRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7174.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SmtJeTNGa0xHSnRVczlpYWpwWTM3ekh3TDVhMjEwWXhlWXozM0pYbzV0NFBY?=
 =?utf-8?B?cW50cDNoWm5SNzJFU3ZWNjdCY2xqeFZuMkJmZzA4N3Q5WXdGaTJWMkRvby9s?=
 =?utf-8?B?ZDFQS2VVUzRoNlB5eE5FdWVneG9BTUFDVjBzeWlMdTdZYzNXLzk4bEZ5d3oz?=
 =?utf-8?B?RENwd0dQaXdpRjB4dHlVT0dNWVhjSmVKakU4NVV1c1BWS01FK2tTNFRHRFEv?=
 =?utf-8?B?Uk5yQ0R0L1RJZmVMRndTM0JMOVFCazZqRGxycXFnSzRlemsxMFBOOXVIZzB2?=
 =?utf-8?B?QmlpeUxVZVh0blZvcjBHRGpjdjI0T1ZzVEp6YXhiTkNCM25QbFkvNnc3UnUw?=
 =?utf-8?B?Q3BqaEdXYzJsdGl4QkI4SGttTWt5aUcvNUZaY1plRkh0Z0JRNm9KRGdDaTZT?=
 =?utf-8?B?WG8xSkd0Sk44VjRUZnB4aXQ1ODk0L3RYWnBoa21wdTd5d1JXSDh0TjBCSVYy?=
 =?utf-8?B?S1pFV3J5eXN5cWlJMXEvZU1Tb0wyOGRNQkhpWVcyR1FsUWpLREdSQjZsT0xp?=
 =?utf-8?B?by9DcFBBZGJ0cGFvQlJ2QjIwWTNEaVluZUdtVy8zNTQya3NzUFZyNVhCeCsz?=
 =?utf-8?B?Nkk2ZkhaMVpZZEdZS1pwNDYrRzRVSERJK3IrYkFOVnB6NldIaDB3eGEwYWNT?=
 =?utf-8?B?YXJYT1A4WUFUWkMvblRvcTFqRUszMWRxSmJ4dm5pSVFTbmNRaHA5VlBGbmQr?=
 =?utf-8?B?MDZPN1VtSmVKYVdmN0hjZXoxN2FFbU5BaVZxaEMxMVRlQUxIQ3J5cVpHMDRI?=
 =?utf-8?B?OHA4MmxVQVpBaGpYc3ZLOVNaSnBOeXpDOWFFUGZ2S0NGSTNvclVzTlJyKzFB?=
 =?utf-8?B?eW9MY0tNMzZUUUlEYWJSejU0dC9nMFU4blJpaEVHWEk1NnJiV2hzT0tlQkxk?=
 =?utf-8?B?ZlMvbUtnSjdqaUZqRkZ6Q21TNXRXT3oyeXdLN2tsMDk4aVhHNHpmdTVsSysy?=
 =?utf-8?B?cmZnRUVHYWVHcEFNR0twMnYyVGZMZDA1a1N5WHJwMXh2WkhwRmNhcTR2UWhI?=
 =?utf-8?B?YzJGcWZsWmxFMWVXVCtDbXV3M3FWQTRpcHhsRnR1dWxmRU1OQmVtZk9IRFgy?=
 =?utf-8?B?Tk9pKzE2NEwya0NaeUJwR2ZOak5aTXVWZzFnbkJNYW9kOEx6NUd1SHV2MFlP?=
 =?utf-8?B?WHVoZXlZV3BCblJCQmhZbGJKdVpOb1VWV2lFZmp4TTNXazMwcE13Yno5ZC9o?=
 =?utf-8?B?RFhPN2QvMm9jV0JVdThxSk5wU2Nzb2l1SnlOVEFHK3RWcWdoaE45bmt6RTRT?=
 =?utf-8?B?Rnp6TzJjQ1RwR1RjZGRJWVczUmpoMDU3enVadEtvWW9IcG5OOWFzbHVYdWNa?=
 =?utf-8?B?WVN6TkFXY0xmeVJQaG45aEgyQjdPekN0NVh3djNsekFSQVdRMTNueDA2RklS?=
 =?utf-8?B?bEdnVGZ6Ri9JMVArZXFueXVCdnl2RUNBR2pobGZPYXZUMVB6UGV1eTY0YjRq?=
 =?utf-8?B?K0hXVTZpWFJlZjJ5cUlTOTRsNHFHNkxGT1VGRUhSaHFJcmZ6Q1ZRdXJBV2l5?=
 =?utf-8?B?dEVNUXpvUUpCS2JLT2p5WVUzMEJBcTVtTXpEcXVPR240a1FsZzR2d3c3WTBM?=
 =?utf-8?B?b2tVTFY0bSsxb0p3REN1bnV6dlBlZkNoSDlsS2VBckhub05SNjJIUTB3bTk1?=
 =?utf-8?B?NVYvR2ZYMi9JUU9aL3lXTzN2Ykp6Y1NKRnhLbW9nNjlYVGpGa210RXJHWkRR?=
 =?utf-8?B?T0pMVDM1ejUzdXJRWUJBREkybXJsWER0SnJVdUh0T21KVEYzWi9oYmFNUzQ4?=
 =?utf-8?B?bVJJbk41NVdHSkJRa3grT2xBNWQrak5yQ0xRa0duL3FKdThxUmlpRk5pMGpR?=
 =?utf-8?B?bk9BdVBKdGpUeDh5TWcxS2EyMEw1bDVZQUpjSnVGa1FYUXhpd1BkMFFOT1pM?=
 =?utf-8?B?bzRoL0xBakJnNk12Tklsd2N2T0tDQXBaRldpMjA3RHhscGYyVUtzdXU5UDcx?=
 =?utf-8?B?Y0x5TDhVV1JQTXNaNWp3ZUM3akUxVE5UWXN2dnI3d1BtYTRxRE0yZ2QrYUNI?=
 =?utf-8?B?bTNieC9vemlSYVd4QU1wM3dYN256Y201YjJlam4rUkFqTWhRRkNiTXVHaU9M?=
 =?utf-8?B?VUtVcnExU2JlRVh4bDNrc0laVTRnS0dDR2hINVFkMXdhRUdHNE9BWjgzSXNp?=
 =?utf-8?Q?Kd7wr2dGNDyU1Iwa9TNnRWY4Q?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5210f8fe-5cd6-4b6e-6cfc-08dd81499818
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7174.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 02:58:44.2971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tGOEJWOxkUCwEzNjnGjwnFb21gO68g4kx8xMnEij51bhljdqV6v2O4/BvzeiuzlenBoicH8+XhurwbVgi2FVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7771
X-Proofpoint-ORIG-GUID: xsbLrPqioT8YrL9vvUu49ns8r26HLlD_
X-Authority-Analysis: v=2.4 cv=UpNjN/wB c=1 sm=1 tr=0 ts=680705e7 cx=c_pps a=ynuEE1Gfdg78pLiovR0MAg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=XR8D0OoHHMoA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=t7CeM3EgAAAA:8 a=zHNwpl9C4nhAup1xqrUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: xsbLrPqioT8YrL9vvUu49ns8r26HLlD_
X-Sensitive_Customer_Information: Yes
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-22_01,2025-04-21_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 clxscore=1011
 classifier=spam authscore=0 authtc=n/a authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2504220021

From: Miroslav Franc <mfranc@suse.cz>

[ Upstream commit c3116e62ddeff79cae342147753ce596f01fcf06 ]

Once the discipline is associated with the device, deleting the device
takes care of decrementing the module's refcount.  Doing it manually on
this error path causes refcount to artificially decrease on each error
while it should just stay the same.

Fixes: c020d722b110 ("s390/dasd: fix panic during offline processing")
Signed-off-by: Miroslav Franc <mfranc@suse.cz>
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Link: https://lore.kernel.org/r/20240209124522.3697827-3-sth@linux.ibm.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
[Minor context change fixed]
Signed-off-by: Feng Liu <Feng.Liu3@windriver.com>
Signed-off-by: He Zhe <Zhe.He@windriver.com>
---
Verified the build test.
---
 drivers/s390/block/dasd.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 0b09ed6ac133..a3eddca14cbf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3637,12 +3637,11 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
+	device->base_discipline = base_discipline;
 	if (!try_module_get(discipline->owner)) {
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return -EINVAL;
 	}
-	device->base_discipline = base_discipline;
 	device->discipline = discipline;
 
 	/* check_device will allocate block device if necessary */
@@ -3650,8 +3649,6 @@ int dasd_generic_set_online(struct ccw_device *cdev,
 	if (rc) {
 		pr_warn("%s Setting the DASD online with discipline %s failed with rc=%i\n",
 			dev_name(&cdev->dev), discipline->name, rc);
-		module_put(discipline->owner);
-		module_put(base_discipline->owner);
 		dasd_delete_device(device);
 		return rc;
 	}
-- 
2.34.1


