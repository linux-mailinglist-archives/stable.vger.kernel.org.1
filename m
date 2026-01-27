Return-Path: <stable+bounces-211865-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oBMcF4bseGkCuAEAu9opvQ
	(envelope-from <stable+bounces-211865-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:49:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFB097F29
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6DF51300E26E
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 16:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D9B31B80D;
	Tue, 27 Jan 2026 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="jWD8pLUh"
X-Original-To: stable@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011042.outbound.protection.outlook.com [40.107.74.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9B0308F38
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 16:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532544; cv=fail; b=dxJze7aocLpCIYuS0moMH4qn+uuY+y0fYY5zrAhFHV/IWaJvErL1pL3vjNZyAxLB1bqM7WvcNLyIywP4Hxodnei3xgilq4BXgyjBXO+4Uw5GfYvdL63q2gScKI4FeEBjqSHPtp+yhB4fHprnEje0pq0A/dx6DNCNRN3VmA7smmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532544; c=relaxed/simple;
	bh=XH+EU6gx9TBg8t8BUp1NXbMwJSZyYeiI9242P54YJO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mz5r0J/TePVRAWfez/63oScqJNOew86BnPQrWLHK5C9g6IBonFUy20HGjnIhlfa2czwYyfFNBU+QtAHyGAikmve3RKD4bCdvu7+SZP1oWd7xJ0Cc5mqj1cu0eJ1ObHuWohFcvxyUp3BkCpyu3zyhdUDTBWKiYaCICiNqarNi4c4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=jWD8pLUh; arc=fail smtp.client-ip=40.107.74.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plxM41pgEFy9pZuOssj7g8LRqsnGiArb+W9vVsFBA38Opylp0mghKdGVfHtS6wHZaxqemVI0ipiDjB3dm6gX5zTdqdLH8Uh4oSt2ZtWdpidQgj4QF1YybRTNnwaUDMeqaF6lLUraui55zbwclbPCxLNfDE4qAPdUrQYhYeyZLjWLXK2MwveFCaHPl4QGoZNw/61Slj9chDctAUB4J3AhBV2Ol5dsZOK5tUSho32La5KEOCR0OJHqah1KzLhWgmcI62mqlylbMEYqqem3YVCex6+G87j4SfUBTwhYqbJxa6CDFmBrqQCG1eDx+1xQ4AnSqCPg9tgSXTinXnfYDMLgkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wkika2s4T2/MgORLUOlf1hyE1HAdvAdS6drUcSYAweA=;
 b=X3SSFz353JkpRyvWyok9Sm12iQT3jlyqH4NHKi4zxWKyMVfs7lxCKMA3C1kRIY5UkYx4xTr55t03sT7Su+7gdlcMBjWThYtMib0evrN9kMFmienBh1tqCM33vthJT98JfPOJar0bkRz6MKFv3XIUBxy0Hry1Pe/92d8rLuL+AkD/Mh99Dt8vACaNqxvvIT0tWotQR3dp/qxeE/RKuuQsMqZUrPZXhlmf6RTxtPeYAbatslWy+NtEK9Z+VbOWFiSLUZ/9MFBcqvxNW12KXV2iVuejYZNjFqdKuFy1Hg5ZNx3RpWVDYkHW91rwrViFudA0/JCnW5eOhMewtjP/Ep1NjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wkika2s4T2/MgORLUOlf1hyE1HAdvAdS6drUcSYAweA=;
 b=jWD8pLUhF6fAeTZWS/fZyTmUeOg68iLPXSq1FysrfGKf+d3ITn5MFycVfQ7y1RU2j+dheoEtzleQmlantWQTRLNBOz0M8CHaKx30sQclIJKBZltzsB4c0NFko4Jid6DIEgSJCUxZPxbGK9YmRSP3K0/3M0VKm21xPCH4Yii5d6E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com (2603:1096:400:3e1::6)
 by TYRPR01MB13342.jpnprd01.prod.outlook.com (2603:1096:405:1ca::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 16:48:57 +0000
Received: from TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8]) by TYCPR01MB11947.jpnprd01.prod.outlook.com
 ([fe80::33f1:f7cd:46be:e4d8%5]) with mapi id 15.20.9542.015; Tue, 27 Jan 2026
 16:48:57 +0000
From: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
To: stable@vger.kernel.org
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH 6.18.y] irqchip/renesas-rzv2h: Prevent TINT spurious interrupt during resume
Date: Tue, 27 Jan 2026 17:48:15 +0100
Message-ID: <20260127164815.526921-1-tommaso.merciai.xr@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012759-decrease-extinct-45cc@gregkh>
References: <2026012759-decrease-extinct-45cc@gregkh>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR2P278CA0019.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:46::14) To TYCPR01MB11947.jpnprd01.prod.outlook.com
 (2603:1096:400:3e1::6)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB11947:EE_|TYRPR01MB13342:EE_
X-MS-Office365-Filtering-Correlation-Id: a57223fa-5bd5-4335-aeba-08de5dc3f6bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AdV0+BjORKg2QZJCsc4o8MTQBqw9rqidPupPcCTnUQNAVmQKOMwQEHuuzvC?=
 =?us-ascii?Q?xmsJpvvJUIpSBSUQV5OPRGyVdMtjp26sUS11osrZ0EEgotXsfcXyvx5rkuSR?=
 =?us-ascii?Q?p7hxzx0UQ9wniSOyQR9ojV0/g6CEJ39rdqu+KDLDHzbm9hA7mrVcY6T8ciw3?=
 =?us-ascii?Q?0pnFyp0cRO6TpTRiJBRrSt03ywe8Zz2mOMII3P8BhmzzRIuU1yEDbxqOW+XF?=
 =?us-ascii?Q?doVlQQPrr7/FXLHdiKP+MxYNFs2c3Fjac0PCk21KmFDG93+nBduft0wKjnbt?=
 =?us-ascii?Q?hE0NIoSwWnEyAhrsVJxbk4wIMXB9/La7VnKxh7/hGl9Rnxj3CRf+GJM/W3bj?=
 =?us-ascii?Q?E13Rcqq5YXlfeUBQ77GRySkT/Kznh1OcYcgSuZuJcGYwHUz5Oxe8uDea7vb3?=
 =?us-ascii?Q?W7p0kYmJne1hbX+S1tGhRYCL29HxOwP+UewRGc+qs4V9GbVbIuz37Fn9Kit0?=
 =?us-ascii?Q?iheHi6ARVvltOXBXxTcla4DVdl6DVJbZ2OpRRPbzgSx0P2KqkqkR1Vch2Lpm?=
 =?us-ascii?Q?hNfKZDimT5pvwFVTYSCFe+tbhADlsSaqOVnJX8e1MzE2RJ/IUgyabjiC19dy?=
 =?us-ascii?Q?F58hNOI+FREC8El++6sf3KB0XNKUViFTB0vfhxT1iXgYj3NfXJTRAkvblibM?=
 =?us-ascii?Q?62mUup/1emGx0eCu0gv8neaf1bQo5zvO+mdJByDzo4Ge4ddVWkMOhCI0phvf?=
 =?us-ascii?Q?6n3Ne9Uvo/k8lk/OWnNUoEO0m9mQgpdk85zng7p+1IccWg/O4fvOcw7Vgs+M?=
 =?us-ascii?Q?fqsdZJKRWnSvhe8WkBmlV6xitIWGVa7OqmgYGATHxpedrCH+SqxxrhTyDCCH?=
 =?us-ascii?Q?yMTPyG+BS+rkJ9HhnOOyrLYU/lN6cN09o+WG+ZDHiLi9WhIh4eVyJ5IW/Bym?=
 =?us-ascii?Q?/oW54WipLdSdRFHn8esERYns1FKjY8LI+COyMAKcRFGYp+fqi5H0FgrHIqFZ?=
 =?us-ascii?Q?E+474fk/wtG21WJcEZOAXz1ZeU5WlIY98b8qXZ/FMOHgpXjs1zrdIeFRAvoG?=
 =?us-ascii?Q?pDcyzd0BsjF2GKpn+m1kYE/C7BregqKsEJiK9hLmL1iZ+uLhqKgkqm5Z3ZpD?=
 =?us-ascii?Q?kXczEw8fXu7G3l09X8zKG6Wl7RjIdP4cyH0J8OGYxIONlWv6UAzGLEXJzh2j?=
 =?us-ascii?Q?nB9i8J/1SEET6QPAXCXA5bU2qMR+ev1zraLb6pWuMRhFvPTlkWt5yE5RWPJT?=
 =?us-ascii?Q?v6SWeAy0zzC7JKNsO/GvjAiAu7d9z6SVigUeDCuy+0vKFrj4s938T4YY6yTJ?=
 =?us-ascii?Q?JOntrh1uyZTFwfaVD3ezxhyujGqhhbnB9WioOwXzf3iG9p6c4W5IRHns7piY?=
 =?us-ascii?Q?q7mO50RmD+vyJilnnKxyeLfmzWhewkugW5oGgdGuWA/NF/6wA+o7fexmX1jC?=
 =?us-ascii?Q?OI/YmZtHwX45N7n/hj4CfxHgrt/U591N1dLGXBtJrAxklt2MrGclqk7lqcUj?=
 =?us-ascii?Q?9L++de1e4wmu85mp/gBRMYq7JG+CZXkfSsi88NndWKcOxC1Hgv2xH/rxfhyR?=
 =?us-ascii?Q?TJeKwxcZvd9MyJdiDZ45qwYA41QOUoP3ow/kC0koyc6OeN/LqmNcMyKnkmNJ?=
 =?us-ascii?Q?i54eNj/YY9HsmAuSHSImsxi2CpGpFtGskldk9c/v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11947.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7053199007)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bDPqIrNlB8LZ/6HgAQ59u85+5PqxPKNe0JS5fTV8PwVTrc4Rs+fH0+BEkYV1?=
 =?us-ascii?Q?SfIhoY3iFAFYKUWTrrcCEdj9hYoG47KDPVfqut3KbOllcmzo0VATnmhEy21/?=
 =?us-ascii?Q?mohPeKze7TDrxJ22g6EUEGaKibSEVQrFNItb9U/X23ygGSirEh3zppl+8EaY?=
 =?us-ascii?Q?m2wdQ+PHDkpudyTmdnEtOThP/2OHBrMhK1NyIkiJmztfC9IpT02dJtHxzlVT?=
 =?us-ascii?Q?GaJPvskDR8aaMyTyjQNvLljQIhfZAY3dwt0eTZ37C1VHyfPYqkvMds4crwu0?=
 =?us-ascii?Q?Ixr8wPHtKsiOCrrkXGyd+Pj0koaKLCsq3PJMynC2BVIyu7JW/ApZTslRJk11?=
 =?us-ascii?Q?Y1rhKPGSeLz6+7VneAxBE/Yzl7fVRfB+8j6ZseNAzVzqETDGCgrmZhhpCW+F?=
 =?us-ascii?Q?aOPGmvzPbDD9ot1asA21DhtRPhfgoNPMLqYUl3MTU5QY8zkyvGqdmKbcSjk3?=
 =?us-ascii?Q?xn76FnvYw/qMtziixqMg++JwnBNhHdjF4tnkY2PxmmTS6sfPg4u3PKue5pPW?=
 =?us-ascii?Q?11mZa2gWGfLKb1C1fzWkQMY0YV5JTb5Mp9YIEmLq+otwiK0wVDg+vptCsSuF?=
 =?us-ascii?Q?Stq6sSCGOjlNFZkt24yYWbsROVSqsbclr14ulyrO/FpqcwldZ2uFbZBNdiH6?=
 =?us-ascii?Q?KwvmwXOhL2/RnU9HhH0618w2YgVxm6iLXDpALgUsP5NhLm+1Ph4zbPpi3Sw+?=
 =?us-ascii?Q?bAzNfDs9TNQlIaTuMkpu3uvYdwksL0jmyLgEKxsYgFUidnQUFm0gWc/LsjUZ?=
 =?us-ascii?Q?VvBj72ZkS7p6Gry5XRZCZYt/0j++McHnbu3ZjBDlWF1wfwk3iVssXdY9iM26?=
 =?us-ascii?Q?NOulbPWZjiYzire2KWFBDlgJJ3bD3vnWKebf1UDxQYVWjebe81yg/mkWADQU?=
 =?us-ascii?Q?LYAF2EXG0zwM1LfFno9pj3t6Z7dWOXLgZqnERmTmL4SOew9o7xOGAg+I/lc2?=
 =?us-ascii?Q?Uy6xfRxxlwwDo4qzbix+uY1g3/XvflcRx11IpiyAVP9Rd2auBORBR1b4yJDV?=
 =?us-ascii?Q?pWNUCPhL0g2EEM5yjsOPpOmoqLdghvfBClbllK/3pNGVjjqHrWfIftirGrJP?=
 =?us-ascii?Q?L2q63RiOcS3Tyz8WuG2DZqpNrhZytkxhmSrGcUUHiNye9rIc71evK713A6q2?=
 =?us-ascii?Q?7j73weoAOMXLedJIjE//8WHDIGcBKSP/fOUObhjCiMRh83m+2ShGAbKfRWXm?=
 =?us-ascii?Q?lxBYGiw+3JUCvfPIHsRDk6YICnXwm+aetr+tJ3PxQ76Gg88sigNYi1MbqXd2?=
 =?us-ascii?Q?o18/lpHTvGE2OlS/IHrEcaHoVo/q1CX5pmBw+B1X8mZPT0jLsOV9VKacy14L?=
 =?us-ascii?Q?FpV1EuFSLN8MEMuTk+e7uRFNolUL/YDy8j6eKh79w5m2SP8tzIPGs/6dRQpO?=
 =?us-ascii?Q?J+ua00w6l/PHG0DiTz0PBPBxTxbhhw64yfn7QFd239uQK5feyW107f3BgKXJ?=
 =?us-ascii?Q?M0KXwHRQgfmvpCNL0dBFjqLUxSoKHfWPOe7gAMwQag3ZE3IGHMZFk0Eqf4zv?=
 =?us-ascii?Q?NtHlKzReyBBve9FOPnPf6VEt5uvLP9ur35LZDBigSP2kJi97J8HmrLqerhbR?=
 =?us-ascii?Q?VFg1tnXvGXYTRAoWiBKzNWZHyIPpBSHxgBKLVHYai7782G5nSlWSKeEu529X?=
 =?us-ascii?Q?pSVMVuOC0i0GFLijUX2/2j8Po9URvyIbysdBzh9q+v7/GMO/WAIrebmT6QB5?=
 =?us-ascii?Q?lEAFXw0GD/LyFdtcBJWO6lMHEfSrdLXDtMst1+8ATk8mvhAdatu12SUs/Oy4?=
 =?us-ascii?Q?UNFo4O5+cnH+/upSiQW+QL3cBgMg/dpCYtJAWSieMVZfGHa/yX9s?=
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57223fa-5bd5-4335-aeba-08de5dc3f6bf
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11947.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:48:57.6022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ydLMdhIb1JgXeBBrkZLKBLTDjEkRbNihuNLWqqZQPsOaw5RlCUIi2AH9Jh//MH5W4P6CLTDtmyouygAzewEbcYVmWv1LBqtBe8uI6N5eseaWAsn2pU+jKGtk/i+/Du7s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRPR01MB13342
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bp.renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-211865-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tommaso.merciai.xr@bp.renesas.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bp.renesas.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CFB097F29
X-Rspamd-Action: no action

From: Biju Das <biju.das.jz@bp.renesas.com>

[ Upstream commit cd4a3ced4d1cdb14ffe905657b98a91e9d239dfb ]

A glitch in the edge detection circuit can cause a spurious interrupt. The
hardware manual recommends clearing the status flag after setting the
ICU_TSSRk register as a countermeasure.

Currently, a spurious interrupt is generated on the resume path of s2idle
for the PMIC RTC TINT interrupt due to a glitch related to unnecessary
enabling/disabling of the TINT enable bit.

Fix this issue by not setting TSSR(TINT Source) and TITSR(TINT Detection
Method Selection) registers if the values are the same as those set
in these registers.

Fixes: 0d7605e75ac2 ("irqchip: Add RZ/V2H(P) Interrupt Control Unit (ICU) driver")
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260113125315.359967-2-biju.das.jz@bp.renesas.com
[tm: Added field_get() to avoid build error]
Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
---
 drivers/irqchip/irq-renesas-rzv2h.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 899a423b5da8..3dab62ededec 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -89,6 +89,8 @@
 #define ICU_RZG3E_TSSEL_MAX_VAL			0x8c
 #define ICU_RZV2H_TSSEL_MAX_VAL			0x55
 
+#define field_get(_mask, _reg) (((_reg) & (_mask)) >> (ffs(_mask) - 1))
+
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
  * @tssel_lut:		TINT lookup table
@@ -328,6 +330,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	u32 titsr, titsr_k, titsel_n, tien;
 	struct rzv2h_icu_priv *priv;
 	u32 tssr, tssr_k, tssel_n;
+	u32 titsr_cur, tssr_cur;
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
@@ -376,12 +379,18 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	guard(raw_spinlock)(&priv->lock);
 
 	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
+
+	tssr_cur = field_get(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width), tssr);
+	titsr_cur = field_get(ICU_TITSR_TITSEL_MASK(titsel_n), titsr);
+	if (tssr_cur == tint && titsr_cur == sense)
+		return 0;
+
 	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n, priv->info->field_width) | tien);
 	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n, priv->info->field_width);
 
 	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
-	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 	titsr &= ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |= ICU_TITSR_TITSEL_PREP(sense, titsel_n);
 
-- 
2.43.0


