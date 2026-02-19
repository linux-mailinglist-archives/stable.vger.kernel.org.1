Return-Path: <stable+bounces-217512-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KE+InWAl2kOzQIAu9opvQ
	(envelope-from <stable+bounces-217512-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:28:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6533162CCA
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58D4A3045C3E
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37FE632937A;
	Thu, 19 Feb 2026 21:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="sj8DIk0k"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC482405ED;
	Thu, 19 Feb 2026 21:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536456; cv=fail; b=RCL//QIM+AmJRhBToiv5Xeno3ea98lZEV9R6UB47NpSl2vLgvn7QYRmW5lYOslFHpdRTgSVugdIxfYyeX2w22GOQ5lrOrHUfgGLaBv6SBvmzeDuyXQ8M8LPHg9trR+u8Pc9M+PE+VCzecGYuH2ewCVNve+FM6BOe4ZzUvIrKSyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536456; c=relaxed/simple;
	bh=hHREOt0P0AIsG6y1UNWKs7Zwq3YrThprApzweIvTFuo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jsG/6Yre4irZOUO05afqAviVd3wCnhhUxaAcqXJkpBFMCBW2wTy4pjmGaoBp4Ec/eDzcmrMGp8TuTkSE+iQ7HImQRsQIsbYpUjZmyMY0SHSlxGoLzvFbncVmi8uPtimaap/3E4unavRoPpl6dqMW+0/yAy6icROaNhM30ZuVSDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=sj8DIk0k; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JCF3fc246742;
	Thu, 19 Feb 2026 13:27:13 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=M4oZ/TwFM
	oCdA+xur+niGQovwISJ0fwNt6/jwbWNVcU=; b=sj8DIk0kMzw4yrLTArrqNRdOB
	sXcmi7gCp3H2lzpKhzf1dbhvRuFis2beuFzwJqbf3H9tTKItHHu7mXMiXD5qY7Ih
	6+Uqf0jR7voVnQevh6e74vvJWYwvBScd12gvwalZVdn78BE+vWI9+iORf6TAgwqF
	tjJU/XE5gNpdQYZLiBhvFEbVzAilYzxj8MJMZLNN+zI+dhIiKnGlHe0q13J3eroE
	3WJd+bGnlLJ2+S1uvu7/DpkGpt8R+j4KwIvdr4uDxlizQOhaEue1RelrNawwM0sH
	ZLdi8cWqE6dYbWAslfrnVqC5qcHeEpBhApm/PIl0zvq5jW3QRS0QmTuT/zUyQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013018.outbound.protection.outlook.com [40.93.196.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cdu158wf2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 13:27:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mnnvLeW8TllXKGvtEyDQZWVWK1eGcipGwTXX+L4o2lfj8jSrRIkIpcMscajYBXN4J1SVjSxIFCr1x+jD5dvQKGyfkZM3FuuY767i2YZdyVWc6Cu29khedAjsnkt1BfI9HZuPjIKFCmDlAWRs7s+w1erpLQ4Obki2TRloVuDjiN7eQE3wh07Vyn4a9FqPh7p7nitlUYDVFcpnTtRM6D1eQZJvT7QjORxFosqYut8eJhuYWn0vXAZDwwjGxi9z1FmBz4Ci3WVuaGTJL94FJNgG7MKTGwxfYx8YshO40SeeRWNUSUuSfDcJadCww9HS2M4auguWrYITsTRQZ3/50HZSHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4oZ/TwFMoCdA+xur+niGQovwISJ0fwNt6/jwbWNVcU=;
 b=eAI0yp+41GJRFPFWegcH+1eEKrNXE3zYm5yz9TOXhs2qC6W4Gb2kRJyfraZkilwNB0GCC9O4h96lWtS+IXZH8NPBmMi9zrRBQ70w/v74GQ+nXqqixm/0x0TY0dCk5GgbfajIHqq0ChHUFccSbrnU6PVoIelcB4kuQ4mM+sppcunYoMTYDTXQxS3/3dDTkLVUfC5IAC2FM6+8glRmtCEknCyLs/VWMDeOFHBoQQKB8IvmhZpfFvBqFMZzkOg3AJT9DhDSrErPiTele7WrLPiQpog+XsVfBOYM00/Ge+6m5EBtSDXsXoeXDT7vMWKEunsQaYWPG/IA7jM4bJ9WJH1Oww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by SA3PR11MB7433.namprd11.prod.outlook.com (2603:10b6:806:31e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 21:27:10 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 21:27:10 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott <sebott@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <sunlightlinux@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 0/1] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs
Date: Thu, 19 Feb 2026 23:26:47 +0200
Message-ID: <20260219212648.82606-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0200.apcprd04.prod.outlook.com
 (2603:1096:4:187::15) To MN2PR11MB3885.namprd11.prod.outlook.com
 (2603:10b6:208:151::27)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|SA3PR11MB7433:EE_
X-MS-Office365-Filtering-Correlation-Id: ca74aaca-7cbf-4327-a010-08de6ffda3f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|52116014|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WLoagOsyUtytA9PBgRPVSoDnB66CB5dBt57qIRfdK+fAAjcXxNMAvUjCHaAE?=
 =?us-ascii?Q?Iv7F3RKXKN3z3lWej9q/YBhcyV6NZbj8kJGwG022I2uUnGJ4ojIMznkPp1u7?=
 =?us-ascii?Q?X47bng7tlsMLO19zIhgaJ1uPe7E7ZfclKkUIfINRrtYWctd15jenSX5mK2/o?=
 =?us-ascii?Q?NtHz3f8xePvYr253ssX+WrnGbVhht9iiqQlf3wn8/5pagDo8BYPaY0+k3UPM?=
 =?us-ascii?Q?HAHvKgd1e/gEv7/DM0R3GLGHjb36vjkXIYzQkhIrgIr4mBpdj0z+AIVdYtCB?=
 =?us-ascii?Q?+E5G1SailvSAx7KulFyYqCprJyNBqYxknkR0Nmig/VknfBE8wZhrpGNV5ewb?=
 =?us-ascii?Q?Tw5f1SFKWGAiU6ErOJmt5SzmC5bD9shutGfOxcex80D+lKi/EBQMPOes8RWW?=
 =?us-ascii?Q?sHWL4XWHxwn9JLg3PL9u5lez3gdQRh788YnokTN7ESOJbzJ0QW1Hw3BlTKdk?=
 =?us-ascii?Q?uR6IMdDuN+YVggqZrpjMd7ErltSvUvXryIfdB8S2VziPeQVyR3+AmYqw0kfr?=
 =?us-ascii?Q?o5OrWau7Q6HS82BifjX9POcRF+Os5/HyUW+FE5qRYeFPtwbVgsdrZQ6z+eib?=
 =?us-ascii?Q?rHu0nWzbbOMcznMvfNFb2UsEvLz/gy1tU0A8qdV+XcrALZtux3pPftsZPJQM?=
 =?us-ascii?Q?WQd28JcpieRIXdfWjioypkHjV4hwdeOwrKQO56UC9qTz4tkwqzg3wT293evP?=
 =?us-ascii?Q?ZjtWIEXmvgACzBIg/6JzjbOG2P5d06kjgbJVaCPd1ZFPhWk/4cmLMLFuac13?=
 =?us-ascii?Q?3+K4sfNG0mc5UNuoF8IQB7AdHFCwn/nZPbSPqZnhGQagIJdmdCpul9S3T9J5?=
 =?us-ascii?Q?rg0aqUiIcjbrRjfSIyOdGV+igTwMn97sgi9/o65RzQzroNXD3tK4nurQVvFf?=
 =?us-ascii?Q?B2wvrZsuAqvGy9Isw8KLfdeV77r7NeCOkqkTF6y1rTabKoMN00kVDmzRKPs7?=
 =?us-ascii?Q?FmrqdeKoFoUhrH28wGaP2V0lJgFGoDL4YLwLWIunOxq1+qLOvsAOT6T2N2Il?=
 =?us-ascii?Q?Cb1cMflJTT0IpiNGpUkM69huLFuXLUz9D3PPTcGeog4guRnY/c7BwFixbCs/?=
 =?us-ascii?Q?cfjTKXVdgvsc9vF791PSiOjQ/YSyQ34CVBw/R9nFxigmjHi7lJE1UITNH6wK?=
 =?us-ascii?Q?CX7W5HHVKcsqLCashIicjtL9jD9CUliPq6zYMb3Thq+zpQB05cuEBrffecB+?=
 =?us-ascii?Q?KYIuu7YZf7HevC7nmGFt3owk7MgcR4NuFE5dvicQBEYaO/uCUzVN0R+CfcT6?=
 =?us-ascii?Q?H6HoFnk+goIL5uKXXRCPVQYa0ys9UnpGs5RefN6kxqrLA2oWuCwizJiLBgYj?=
 =?us-ascii?Q?GxBosV8KHOPKMFeeb1NmVCPgNbF2vYUOjOhUSJnplJ3PR42NdeTuCHpobhLj?=
 =?us-ascii?Q?2YBMv93hqIonXHSDfx9A6UTlg++zYaYvR1opO/1WpY2Ob8Da+Qo8vPc/ORab?=
 =?us-ascii?Q?pk0/qQ03p2p86eks2mfVD3ipxYWs6Kdf+n4L9qI0Ydi/XfFveHZ7Dayx8fTq?=
 =?us-ascii?Q?sa6oDsAkZi7wxPUarMqiFvv7Q2jKzc30q8hrCkgpT3nUfe9YBnx/q8Q+F8IN?=
 =?us-ascii?Q?GqryKQV/kcwp0ggBtCQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(52116014)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QMnd/5eLVU6UX5QwboGON/NIlK71IeZSOuLnMUZchD47+3kUXn2Xrj2eb6LH?=
 =?us-ascii?Q?NBtaHstDAZ7a25yXIINjVkLPzPxIO+xkZM5Pg83IYSJPmaTOX9KjBNYvZVMz?=
 =?us-ascii?Q?+oaT/iofMbbf4woFXre25YTFkQXxObixoLM4L3MMzX8sK/5SKw/G54GeuyHv?=
 =?us-ascii?Q?MOP9zETmPzJ4OViV/1QwzjNSJmMZrIwmyhG4NmBA5gYVOZcywJhnp6J7W5HE?=
 =?us-ascii?Q?HBPuGkWA5TXDXiQXS++lJ6th3cgX6Obg5iyD4naMnQA+bVyHd4qq5bDBUwYu?=
 =?us-ascii?Q?2d7O2Mxx08Ex3ePkx5/GI7+S2XPHvueDorR474nreHX2dD3UJsDylHxMTMKJ?=
 =?us-ascii?Q?d109exwXlXhnVtI1sxWDnbgEA/rKY0v6aaVK8MulMpnpX32TnwSAiNGsrIVO?=
 =?us-ascii?Q?BuuG0MDZyestuipT08YNMEuctb527a5UcftVE1ZpeiDZtlfA7HEgtJRy9yYA?=
 =?us-ascii?Q?OCUeUniwQFdQ2tQtm828iExZ0zy2Yo77lCwBmeu/uFkt5RjxzjQvbII/kpWk?=
 =?us-ascii?Q?m3Z34W9yNp2UrmIFEwgYxHh4UH1PFbwYcC1GGFVxsvC5SQwntYeizMSrAP10?=
 =?us-ascii?Q?SZ0POOY45Op8dFqfOJHIYOrurQRkh2mlnBT1F+aBIr5HrthQjNKdxYaxJvBF?=
 =?us-ascii?Q?P1lRQqmNer8x2kUL4kB0JmxnQMZwv0pqP/2NeHzBWJD3VF5UGlGtxyhYIMUc?=
 =?us-ascii?Q?RWl09ljVQgCqSu3NuSgfW25OxuWzdsrE/EW3ei/0kTbGa7ERpqer6Rmoy69e?=
 =?us-ascii?Q?IY0JyhtNc2M336jqJgNcHAJRUoys/j70iJfgCdoNRJwice+JTbxGiVUQk3Yz?=
 =?us-ascii?Q?y/NZ7tZ/6A/Xm+skWWVsLhIS9v8viZMS0mnbdJ3HVTNqpFujmX7w4TS8bKwo?=
 =?us-ascii?Q?eIqGNz9JwVmnWia2CCItaqTuITeUb1SWwDmJOmnbRdS4ZLd2hJJZvcdobiWD?=
 =?us-ascii?Q?nIKQzgvF6xYchyYNqCi03g0LOM1dwOj79u0zY67ZpAhWlnWm1CndpH6Jzlug?=
 =?us-ascii?Q?V7LwANlkdlJu8InIGesK874EnrJGoGlYeN8Vr1m3P+fOBhH1Pg6C5oeMVQDf?=
 =?us-ascii?Q?jqYGOvsn18eZP8pk8Ux2MU5EQohAY2psAYLgu0pSikut+4nyyA9KgxyGjp0F?=
 =?us-ascii?Q?o/FjzLdi/vq0lz3ahByt+CqWOogejVVWzLCnI2lnXx5NTwCYbi5rvIs68TIE?=
 =?us-ascii?Q?qe7pMYeRT719qTEVeK5Tsydnd5UYT/SizlPDhufIfV7mPiOB8TR0E9wYG6dN?=
 =?us-ascii?Q?/D4BxEfegtH8h0TH4LmERzBSXm0edDKbrzxezWT3Y7qnuSKvzCl4INolIBzs?=
 =?us-ascii?Q?L/BZJIk9AhI38WYEON4+lDp3XNLAoiCCt8AJjz+JqABHo5ApQqzrm8G5ldnv?=
 =?us-ascii?Q?bpXnVHfs+adacsnnNNuquRq9GfaspcjDH+xVvVUypVFRnC2t9Rf0vQCuErFi?=
 =?us-ascii?Q?3lbun1V9JKtKJDJXT3JJ1TBMPWPvEZ/l/Jq3FTxfznFrkXpLgVe3zO6FYgTZ?=
 =?us-ascii?Q?MFpjX1xYLHy5UNC4dg6Me6Upz/A3lnVZ/WudGR8GVPLQbiiyT+kvW3mMt0yI?=
 =?us-ascii?Q?LuzTQ7NDV+hKbVbc5SY8XVnWLG0v/acut/Uq99KXTts4W/J80D4M0Jt2mpHE?=
 =?us-ascii?Q?jGs0OA8Ad68zYbCURWu3u66FIeQVdfU4EJlPWJj6IgM4gLeIwYVIojGVIwOK?=
 =?us-ascii?Q?aG5m8FWUvpneT+X9EXBC6XMAZduyoBdZPlJQJIlbEo74+7EayHQkQuvgv6Ox?=
 =?us-ascii?Q?EKou3EMWl1iF7DgsbZ/EcVXgorXaqEbDytkQbBNPch2kS0Qb7vdFrIdF7Aaa?=
X-MS-Exchange-AntiSpam-MessageData-1: HfUBzx6cjST4WAh1LuxKKXRfMnWuI2613r4=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca74aaca-7cbf-4327-a010-08de6ffda3f2
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 21:27:10.5176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DgX9tQ+7l5mt84jLp4bsimbEVtx5GY/dupolH0SlTa6/C6UWH2/gU+DhaIw/avUnGy1FZ5WknItJaemRBnlu957FV+p9hmU4J4i7IGjbQJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7433
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE5NCBTYWx0ZWRfX+dh7TQaLQ6gj
 vNZdBV44E9TLl0do06SoX+TrqGqQYCvgm1pSSCBD2bekhId2VNBJT5PPxNr3tzjQ7HysT3O7sY5
 YVAFIopd4wqA0za8bMn9NteR0EkqR2kvMjKm4ourxtXQaaXkxn3wHvqhF01vy+RLlxQ1YTN2nt6
 CNhKWUk50lqyDOnmHuVBfuSTaHOVOrIodn1fw/L/8Jt4MEL7gwZLgIoEBB6VF4fObLo2b1UZImw
 FBy0PVkIAWQ6jTMDsm8gjk7lkai1FtZTZkz7Fiz87zfNZOCfX5xHg9VvEgyXtk9f+CQB5xGxWw5
 WOs3+CXSJom3qTqVPs1vj9Uogbtp0DhUxr7jfZfYO5bTGfcps41T33OGfB+QBk1mvtzje1Kr8nu
 6jEIP7bzqE3+ZKxrdIJtuusUKqPW0ybCmCqVNV+IKP7G9TW5d66QQQnF+1bhGt8TPaZeNtn8naK
 Z0+mc/cDE3Lytw1Yq/A==
X-Proofpoint-GUID: McduZh_RnAgR98FmSRFwP_D68OMuRmd-
X-Proofpoint-ORIG-GUID: McduZh_RnAgR98FmSRFwP_D68OMuRmd-
X-Authority-Analysis: v=2.4 cv=e78LiKp/ c=1 sm=1 tr=0 ts=69978031 cx=c_pps
 a=H/ESeL7FTwDXaNlIHo07Cw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=lwgsdTXzEhOGwcqcKhUA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 priorityscore=1501 spamscore=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2602190194
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,gmail.com,vger.kernel.org,windriver.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217512-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D6533162CCA
X-Rspamd-Action: no action

From: Ionut Nechita <ionut.nechita@windriver.com>

Hi,

This is v2 of the patch adding owner-tracked reentrant locking for
pci_rescan_remove_lock in sriov_add_vfs() and sriov_del_vfs(), to
serialize VF addition/removal against concurrent hotplug events
(including platform-generated events on s390) without deadlocking
on paths that already hold the lock.

v1 was tested by Benjamin Block on s390 with lockdep enabled, including
hot-unplug events and driver unbind paths, with no splats or deadlocks.

Changes in v2 (all based on review feedback from Benjamin Block):
 - Renamed from pci_lock_rescan_remove_nested() to
   pci_lock_rescan_remove_reentrant() to avoid confusion with
   mutex_lock_nested() lockdep annotations
 - Added pci_unlock_rescan_remove_reentrant(const bool locked) helper
   to avoid open-coding conditional unlock at each call site
 - Moved declarations from drivers/pci/pci.h to include/linux/pci.h
   alongside existing lock/unlock declarations
 - Simplified callers: removed negation of return value and manual
   conditional unlock in favor of the paired lock/unlock helpers

Link: https://lore.kernel.org/linux-pci/
  20260214193235.262219-5-ionut.nechita@windriver.com/ [v1]

Ionut Nechita (1):
  PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for
    complete serialization

 drivers/pci/iov.c   |  7 +++++++
 drivers/pci/probe.c | 19 +++++++++++++++++++
 include/linux/pci.h |  2 ++
 3 files changed, 28 insertions(+)

--
2.53.0


