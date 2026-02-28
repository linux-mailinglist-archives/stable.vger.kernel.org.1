Return-Path: <stable+bounces-220065-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LU1M9vZoml06AQAu9opvQ
	(envelope-from <stable+bounces-220065-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 13:04:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9C01C2C41
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 13:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1A994303C501
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8B43C04F;
	Sat, 28 Feb 2026 12:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Wq0JNGNe"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4643442E011;
	Sat, 28 Feb 2026 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772280280; cv=fail; b=X/6tTcDWZyVkhaKS+xUZmrgW4vhJOv3Lzqs1CL9kO/wAN5gbDbG0ieKaFiMxss9i8vmJ5H0S2ibH177p5ssTxNHcUNPmgL6vwGs8UCYe5JlrmC8TtOHAzqpFUyubueJdYOjfKIT7mT0Pm8yd9IheGggj7Vga8rthnLKiYt2pENw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772280280; c=relaxed/simple;
	bh=W6Tdje9ueFhnIrdjsY0oKTz9UnEr+ImS0hrGpvi1jkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IjRKC4CdWo72e9lNOEnrUGB2gT/X/5SiUL1eVHOZhoglLj4LZODZ8alxwJiYujkX1gOmJ0cw8EdbyMnvkO84Sa8C+bB/v+VJvzDYGBromKJZPF7cBWKSL4qckfciV5oWJHBMq8PrIaCbdd9rUHub9XINIYM36dvNNRQsHmAOMQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Wq0JNGNe; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61SBpYNi1467486;
	Sat, 28 Feb 2026 04:04:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=wXeTySDt8ht6XEvvz1v5XzRQQhRSQTXc5sZ/gY51Gms=; b=
	Wq0JNGNe/lRrcGnjKEn68uqI+a5Kqr6KF4naplOqsTk3ah7yl6PC9jwPDr+1P81T
	j/lL+x6qKR7190nSrD1Bsuvx+KPPOSuuVjSZWycfFCA2V6piE/bsnujGGOrcOFJA
	rRwxuB+ocYWv3wiZhOeFrKYhHICuGzW6QdY6AbDmAHTQhM8fkVdf0IAti4h1GiXh
	MUyulih1kw8gpcGImLZ3k0L4TqJJkvjRLH7/cFYmqii9FzJYi9LGHrfs9qXn7aFg
	7G+OMQDpS533mzs0qvUEhV38GrgAqMeiJ8NiGNbTNLo/1LJhMT4+ZzQF2KzDxtz2
	goOAk0y7yArtlS7z6bAuug==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010058.outbound.protection.outlook.com [52.101.61.58])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4ckvh404dj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 04:04:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jePhUjaGCyW5z3+vjAgYBAEEIN99cyp1CGgJS5V59RF4dEGny5MwOUNiJMxKeGEpkuELj8NM/HHV4LohtENpT29Y09DvmcElyWv1Tq4Id8yGbhdN+wukVdqVwtGhd/uG0d7NTb/xklpOOA0NGtksDQizdER0M8pXWu59/uJOG3Gn1L9thCduNVyyZdogAYy9H4Rl+AKUOe2a9hYQRtdJ+b9MHp+J0iq7jNVWs3K5kd5Msarwo0IzKA218RoytRU6Ev9Bh66LCeLwrFH0tZb1/2zma3XO89Aln1RpOPu58kwg3LZKWGBYDZ9syb84zQ/AyU6v8VXBN42sg8mNq2t5Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXeTySDt8ht6XEvvz1v5XzRQQhRSQTXc5sZ/gY51Gms=;
 b=cTB8j4jg7QQVb+ygTpluZaqlGAYl9flarRTuvLQcUubLaiIrbK+1ixqbq9IehSDzo+ncH5h9+wBKFcbSapHd5c+jtP3w3cm8hAz6wlln1BGSNPPSpYfSmFgnFwUmFKykwSb0Ki0HbnWeyOtOF9dI94yjp47ChDNRj/ec3ySntov+8rBTQYWDws5y4dOUqJUcfblKVxW71aT8shjmd6ViUCMSxXgNfu9pXmJVLfB4DaS32gpCwkbOop0LE0ZHR0ACFu0Vpwjq6zzqTAVVT5QTQiV9hQpp/qezvafoB1I+OWqJXOFJXEL4BxlCQlAY2Pmm11m2Yq6rk0FldON68F1mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Sat, 28 Feb
 2026 12:04:23 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9654.015; Sat, 28 Feb 2026
 12:04:23 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, alifm@linux.ibm.com, julianr@linux.ibm.com,
        dtatulea@nvidia.com, ionut_n2001@yahoo.com, sunlightlinux@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v4 1/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for complete serialization
Date: Sat, 28 Feb 2026 14:01:40 +0200
Message-ID: <20260228120138.51197-4-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260228120138.51197-2-ionut.nechita@windriver.com>
References: <20260228120138.51197-2-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0902CA0045.eurprd09.prod.outlook.com
 (2603:10a6:802:1::34) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: b3846100-f36c-4837-21f7-08de76c182cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|366016|1800799024|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	iQfkr47HeZMZKDenTIp9S4p/apeXlXNKhd4kgSPrtik+8tv6TlORdKX8MoxsZB8oMbnZeR1yODhRkpitjX0Hl1QpfdD1EbjIVy0bV0GHEgQWSVpykPjFt4G+znub6FkKsxn8kC+vnavqPk258gjDdvY57MCmFRAs7zlGH0XGdCwIQi3hdcE/YUwdaZYX0t0ifq5UWK0cuw36s2A7GV85jtZO3FzJfKVAMUXdRFXu6aCknhcDP5300GtWC8xOkYjLnlhDMpjTVIxiS8k5bMaPevxfuNbIkrnCzT8ffyzl4HBNh/bCuqEWrBvRSqAh+8RCVX4zyRP86MVbPfXt8YaxG77Y7Uci2Td6475GfbQr3lsCpAWqjJsCecrmiw+v/dBlzhmFq++MJnToObvJfbA5mzquQ/A63jI/MM3eF6eMALuhuvwVFxL0baSAWjPcadNs4QOF5PpMauZnAQReVNaUWMN9q2delZdPMy2Icme3NgMMRNGJKXOsCK/U3ahLmRjAUMd206IfQeeMSmJgNF/hIEbpGrKop1A3CAVIKujkrWeFkcpH2RGX4fNSRFS4+49Iv4wy26E7ndvZUkLQMkDdzddTShiYEUL9X4fujhFN7wim2qpAbvTDGIgWuA9mGhVYMmee7BuaO9woxJqOJdn4F4QCxSyYiexjZ0FuHDXTJV4sSYSu1g0jfeklZ9wRdgA/lf7HExW+wgtjvTP9lfaKYxuZ54drLujYXiGfbwbSNZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(1800799024)(52116014)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lmxHSxqpO5SGbgxE49vrH80Dr0DroAKYE2wDtIzTpG1mvjF7lZQTs88xgMhP?=
 =?us-ascii?Q?M2JwxHN+LqRmubO++RLfIeplu7h8iVAklLtuWOQk4QqX1koNb6muCKuDldY+?=
 =?us-ascii?Q?DE0Trof8RzP7xgoEXWkdVe10hYwTO0Bv4/Qsf7tVzEybm0CY93vEyD33hIvV?=
 =?us-ascii?Q?42NuAVAuZZNfS/eHkqCRSdec5CmVnN4nNOCGFpUv/IO+aGIUuBLLDebwMXtv?=
 =?us-ascii?Q?5rdFhxxYpUXdQRKIKce6qot01qV465TMQg+HLJO7pjdjBqVX0IN34KJZBKZd?=
 =?us-ascii?Q?O/W4BmMYLWvIrNn8KMHjxAg0XnIjG5Y4xEkJUds0h1kb4+/9doqEfiD1hqo+?=
 =?us-ascii?Q?sEgwAfQYbBS4xHsXays+ir7DDBRifFlZ5dgzsnuiV0sePqVJ08OyVJ1qNcAh?=
 =?us-ascii?Q?8xcLsAkuFite6+nITRsazQkWlZdHm0U+N9kYDhiZEkATK4GRgr26JmPpZAT7?=
 =?us-ascii?Q?SGVOi8GEhMs7wCXQqUi2hRTanFwN4WP7xAFfo4OylhbH2tKg1Na8yVkWnSXX?=
 =?us-ascii?Q?m7yCCTp5iamCZGD6ruqaGZhfpx10dlUeQDZlLtrSWS1tpGURPsQWyw0NeG92?=
 =?us-ascii?Q?MXhnCJaS67hJwxsZnSv6X4O52zHcAF3rPSvix1uYSHdfV0SsK0wCNvGUpGeG?=
 =?us-ascii?Q?0wW9ud7P6QboW0dS2Sd7ZgaW8sHsOybZ+B4sMTL8qp2eJP1ji0Lpr5wI6GIn?=
 =?us-ascii?Q?UVhBp4e5HjTu9Kfacp3URWTWR5pa+f52GXvGDu7sTOgHKgB5muBCX0P/eokx?=
 =?us-ascii?Q?0uyiNQMmIFScPoMjKzYuZpiBI2zIVEuN3QHgSR8eae34yepz7TIdwa5MesBc?=
 =?us-ascii?Q?0vYW2uknrJfcRjY9CSVOy8cqpa16tBSLgthLqu7IgDgfQVE8RuQUfEXd22dj?=
 =?us-ascii?Q?0jLvAoBEVkGxhNJUmlBeh2FEtMJTcnWlQweMEsTwTgUDhBSj+IZ70ar/IQWp?=
 =?us-ascii?Q?o1NuOZ2Lxc1g3698ObUlJcQi227b3zlsmUhEK4s6xl8swqXi6011kcVhc3r3?=
 =?us-ascii?Q?G8GEyHNkAFeB69MzmKvC6ijGfcRJEYUhmZwO6gcPjja3a/HP2dkKWWeuYDdw?=
 =?us-ascii?Q?ONrQT1LKjw8Lg84JtTSkjpqVyhpMMZvt9QmlAO2ugCrabYwSevN9+Rvpk8l4?=
 =?us-ascii?Q?nH7aqGMar9qmIboNV4S3UcvOTATaRusUVD2lqSKfKXElwXygPiRaHKpff4Wf?=
 =?us-ascii?Q?8U0wep18XVz4VsPZBUXWSJvd+zLIWiV8g0sICarVA5J8IQNnDhCJP9mOWmTA?=
 =?us-ascii?Q?yq6YpMnRT0JPWoPDY3XL0835GAQZgPfgXYdcM4MzzuY2CHPdemxPLidAk6Du?=
 =?us-ascii?Q?M9+hnIfBZ2YdVWbo3TiIm/Adqa6Wvr040pyZtPBnoEUvjm1MnbGABmVfIV3q?=
 =?us-ascii?Q?CYgrsWIaGci1cE1E36BiLhzisSBeT0pAiezEAUQkFJG9Gik2R09DRAVPZf/O?=
 =?us-ascii?Q?SCE8/R3tXwVT/Nk862ivY5RXl5vmUrUJ9cGus8Y+ptrxeWKaJYG+UcB41Zh9?=
 =?us-ascii?Q?jHX2fVl8vVDggDl8I2z4m2viXmSIUvr9LoQgddjMUyP/AqlQwjrt6QFz5oQQ?=
 =?us-ascii?Q?R8W7nHfWSBoNF09fsNl6Yis84+Q1HB9ZSg9fVKepeEiTTxP0dX8GL5qSDvY9?=
 =?us-ascii?Q?4zqtfObZkmUxD2j7ME54zYReslwoXjYjaHU5bcCLih8FO6gVQZiJtREr7Ttp?=
 =?us-ascii?Q?A7d2P1KM7xGGB0h8cGb6I38uDOXUAb8TCKgGcYV13IwmzTEKA43iMTBdbFIF?=
 =?us-ascii?Q?hXlP43/T1Bir86A94jSXemziPvVCqnyKc0TqYqkswlUjqNjxv9HY7irATKNA?=
X-MS-Exchange-AntiSpam-MessageData-1: 5cs0Le4BxnmULu7MegUT+Rns+08XwDu6uw4=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3846100-f36c-4837-21f7-08de76c182cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 12:04:23.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iV2Dqk9nhRB9cw4dq7vsEhGILNght49wKQX0kynCYvnBx2xZEZJ7zOcA3BQTlXucSjBcbfvr6m8JTtpDkvmWVnWCc9bjmurqERz3SDoKAnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-Proofpoint-ORIG-GUID: 6c914UHZeb8Pndcf1nyL0GTMCdunaZao
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI4MDExMSBTYWx0ZWRfXzPBIeWmCPKnR
 reLUlmsD85f1p1Tb3m7cXe7b2Xs+WaYRfnSl0U8HkpLBxIymPnAcQPMrKpioXSWTP67T0C/PPH3
 tSrH7ujEspTayvUrS3YwhkErqlrTWmDIuH+aEEJLqOkIlZ7USPI8Eb61yBijgf3N8Z0N3oxbpQm
 5Z7DkxfzqFGsdTDk85QDlpBrRRgTYLgzJfUUS0wuq/HNSwldj6kkMyuE/AHnopkaMF4CmpuSYpa
 gpHJr8w7UKPGGX2zhakmMdIEwpEu1XvbTNZkGtzgvsPIK54BrPjR8BGmpVbUPZT5ar+6DI7Z5Lh
 A7vTv4qlG4JN82uxhn63rvnvGhkyTYWb/lMNfEtya4sfbs3g2txQQQyh8hsgI+bF+NN6XxPTOzK
 yehovLuZUgHipCzCSEKtFRw9yeFOAkb859ZGResiNrlT+xdnjlT3CJdvQ0g4pASYL2cgte/YPj9
 ATKva9QzqN8klRsb9nA==
X-Proofpoint-GUID: 6c914UHZeb8Pndcf1nyL0GTMCdunaZao
X-Authority-Analysis: v=2.4 cv=Z/3h3XRA c=1 sm=1 tr=0 ts=69a2d9c9 cx=c_pps
 a=2PUY6gUHBEqav+0eoazkAw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VnNF1IyMAAAA:8 a=CjxXgO3LAAAA:8
 a=Ea_S87Vdr1rjus-4YBkA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-28_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 priorityscore=1501 adultscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602280111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,nvidia.com,yahoo.com,gmail.com,vger.kernel.org,windriver.com];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-220065-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[windriver.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4B9C01C2C41
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

After reverting commit 05703271c3cd ("PCI/IOV: Add PCI rescan-remove
locking when enabling/disabling SR-IOV") and moving the lock to
sriov_numvfs_store(), the path through driver .remove() (e.g. rmmod,
or manual unbind) that calls pci_disable_sriov() directly remains
unprotected against concurrent hotplug events. This affects any SR-IOV
capable driver that calls pci_disable_sriov() from its .remove()
callback (i40e, ice, mlx5, bnxt, etc.).

On s390, platform-generated hot-unplug events for VFs can race with
sriov_del_vfs() when a PF driver is being unloaded. The platform event
handler takes pci_rescan_remove_lock, but sriov_del_vfs() does not,
leading to double removal and list corruption.

We cannot use a plain mutex_lock() here because sriov_del_vfs() may also
be called from paths that already hold pci_rescan_remove_lock (e.g.
remove_store -> pci_stop_and_remove_bus_device_locked, or
sriov_numvfs_store with the lock taken by the previous patch). Using
mutex_lock() in those cases would deadlock.

Instead, introduce owner tracking for pci_rescan_remove_lock via a new
pci_lock_rescan_remove_reentrant() helper. This function checks if the
current task already holds the lock:
 - If the lock is not held: acquires it and returns true, providing
   full serialization against concurrent hotplug events (including
   platform-generated events on s390).
 - If the lock is already held by the current task (reentrant call from
   remove_store or sriov_numvfs_store paths): returns false without
   re-acquiring, avoiding deadlock while the caller already provides
   the necessary serialization.
 - If the lock is held by another task (concurrent hotplug): blocks
   until the lock is released, then acquires it, providing complete
   serialization. This is the key improvement over a trylock approach.

A matching pci_unlock_rescan_remove_reentrant() helper takes the return
value of the lock function as argument, so callers don't need to
open-code the conditional unlock.

The "reentrant" naming is chosen to avoid confusion with existing
mutex_lock_nested() which is a lockdep annotation concept, not actual
reentrant locking.

Note: owner-tracking patterns for reentrant lock behavior exist elsewhere
in the kernel, for example in the regulator core (drivers/regulator/core.c)
with rdev->mutex_owner, and in the PPP subsystem (drivers/net/ppp/
ppp_generic.c) with xmit_recursion->owner.

The declarations are placed in include/linux/pci.h alongside the existing
pci_lock_rescan_remove()/pci_unlock_rescan_remove() declarations to
maintain API consistency and allow use by external drivers if needed.

Fixes: 18f9e9d150fc ("PCI/IOV: Factor out sriov_add_vfs()")
Cc: stable@vger.kernel.org
Tested-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
Changes in v4:
 - Rebased on linux-next (next-20260227)
 - Declared pci_rescan_remove_owner as const pointer
   (const struct task_struct *) to make clear it is not meant to
   modify the task (Benjamin Block)
 - Added Reviewed-by and Tested-by from Benjamin Block (IBM)

Changes in v3:
 - Rebased on linux-next (next-20260225)
 - Added Tested-by from Dragos Tatulea (NVIDIA)
 - No code changes from v2

Changes in v2:
 - Renamed from pci_lock_rescan_remove_nested() to
   pci_lock_rescan_remove_reentrant() to avoid confusion with
   mutex_lock_nested() lockdep annotations (Benjamin Block)
 - Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
   to avoid open-coding conditional unlock at each call site
   (Benjamin Block)
 - Moved declarations from drivers/pci/pci.h to include/linux/pci.h
   alongside existing lock/unlock declarations (Benjamin Block)
 - Simplified callers: removed negation of return value and manual
   conditional unlock in favor of the paired lock/unlock helpers

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 19 +++++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 91ac4e37ecb9c..adbe4ecc587c9 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -629,19 +629,23 @@ static int sriov_add_vfs(struct pci_dev *dev, u16 num_vfs)
 {
 	unsigned int i;
 	int rc;
+	bool locked;
 
 	if (dev->no_vf_scan)
 		return 0;
 
+	locked = pci_lock_rescan_remove_reentrant();
 	for (i = 0; i < num_vfs; i++) {
 		rc = pci_iov_add_virtfn(dev, i);
 		if (rc)
 			goto failed;
 	}
+	pci_unlock_rescan_remove_reentrant(locked);
 	return 0;
 failed:
 	while (i--)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove_reentrant(locked);
 
 	return rc;
 }
@@ -764,10 +768,13 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 static void sriov_del_vfs(struct pci_dev *dev)
 {
 	struct pci_sriov *iov = dev->sriov;
+	bool locked;
 	int i;
 
+	locked = pci_lock_rescan_remove_reentrant();
 	for (i = 0; i < iov->num_VFs; i++)
 		pci_iov_remove_virtfn(dev, i);
+	pci_unlock_rescan_remove_reentrant(locked);
 }
 
 static void sriov_disable(struct pci_dev *dev)
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index bccc7a4bdd794..c7f672eac0698 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3509,19 +3509,38 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static const struct task_struct *pci_rescan_remove_owner;
 
 void pci_lock_rescan_remove(void)
 {
 	mutex_lock(&pci_rescan_remove_lock);
+	pci_rescan_remove_owner = current;
 }
 EXPORT_SYMBOL_GPL(pci_lock_rescan_remove);
 
 void pci_unlock_rescan_remove(void)
 {
+	pci_rescan_remove_owner = NULL;
 	mutex_unlock(&pci_rescan_remove_lock);
 }
 EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove);
 
+bool pci_lock_rescan_remove_reentrant(void)
+{
+	if (pci_rescan_remove_owner == current)
+		return false;
+	pci_lock_rescan_remove();
+	return true;
+}
+EXPORT_SYMBOL_GPL(pci_lock_rescan_remove_reentrant);
+
+void pci_unlock_rescan_remove_reentrant(const bool locked)
+{
+	if (locked)
+		pci_unlock_rescan_remove();
+}
+EXPORT_SYMBOL_GPL(pci_unlock_rescan_remove_reentrant);
+
 static int __init pci_sort_bf_cmp(const struct device *d_a,
 				  const struct device *d_b)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 1c270f1d51230..080950f0bab33 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1535,6 +1535,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+bool pci_lock_rescan_remove_reentrant(void);
+void pci_unlock_rescan_remove_reentrant(const bool locked);
 
 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
-- 
2.53.0


