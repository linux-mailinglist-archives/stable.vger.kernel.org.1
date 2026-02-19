Return-Path: <stable+bounces-217513-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDGfHImAl2kOzQIAu9opvQ
	(envelope-from <stable+bounces-217513-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:28:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E0E162CE0
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 22:28:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E61D304DF08
	for <lists+stable@lfdr.de>; Thu, 19 Feb 2026 21:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D02F329C71;
	Thu, 19 Feb 2026 21:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="HNCJaSI/"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD3E329365;
	Thu, 19 Feb 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771536457; cv=fail; b=gFrVA1i+QokaRZtmk1wiZAT4ZVThCYDBwJIOnvKQhI5PU8Y/JvTGOd3h+xUgIrcvdPOqKRweLUKvIxOW6zwo9nDm+cJSCqNYYxe5Zrwvv6/E9/gTfePGeTeYpiqbpCb/vbjPEvPcAluHIbxIKK4gm/4wBNHvCUIyfeMynPszAbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771536457; c=relaxed/simple;
	bh=zFhxKPPGmOju7cq4LKBbWaC1ZvbmUmoViHQR2PrsUMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQyN8cL8DOWcSXFqlYqJFh/6F3fml58N7Ve/fqH2MUCtQYIbDM7cCvhfnALW8CbMzhbxSyWsCBkHDmZiMQgPNa56Q9sG9oFqSUKKwpDzVB2QeyliOpv7KAk101mweEkmI4safY22AIDxkfGmdCSa11DrLKv/xusUSvEzyGo1eV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=HNCJaSI/; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61JDLmQM3810379;
	Thu, 19 Feb 2026 21:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=hIe7IPsblkg4xH7BMX9gjepEbXdB70T6CZg9cVEP84Q=; b=
	HNCJaSI/fmomf4evC1alI9rUNVCz6lOJsUd1UaAhj1adXMkejOi2jJss2DFaOXZL
	4sNE+u0FJNJcOlytSzsmLPRY1TeFc0Ici6mx0a361ZDachdAMHpmCt7QHjweb7zw
	4TrjiYsBs2uUDzSqn61xzXPHKLbBmFgD/g0iXBfzFDY2LnutYvvYM9BpZyt/gPhT
	oR87Q1R/+FwPAzNn/2MnYqNYwUf1A1wupRA5ZJDQXNLrZnwpCzoevkrndrO52P+9
	ro8418aOlqAPAyNJj/6XBacLkvOOjPD8c5wd9PxPp7JwzqpKChlTFS3Uq60br4Le
	2c0dMEIJE5Mi9CT2Z/XgcA==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012014.outbound.protection.outlook.com [40.107.200.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cdtuqgwy1-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Feb 2026 21:27:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mfyxMut4F+7QHdtrAul4hBk6hCNUZRsxh3rkfEuHDbmr6U2fjODAoKIPpePy2pfBodyrjvPQQ9VslBIY/kA/k/fnr4/bZ1N2RtcbqToyPgSX8mI7nAl4Trdg313j9e8Rnghw6/U7XvjIShDxIFz8XWSuoYe5hdLx+1BmLtaUnE44jaGel7pL4NRU+hmvsUbnYNNpnYhvq+ij9AU3uaH9yp18SfV36Fy0Nm6nn31xqhtxlk4j3tP3wMQbsomNEQp0d0zGpdnYlbh+FDr+xKzUt2+QpXEPKOIZoLGJC1l/3xne3w5NESTfl4ogvRibptjWjjFLV78TD9jgELqmrGpEmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIe7IPsblkg4xH7BMX9gjepEbXdB70T6CZg9cVEP84Q=;
 b=nGAdgrryqpB+SMg5Anffu6QSD2nakMdkI8i5hdkcyF92pn505h8W1t/nuYluUUbc2iQddJSljIh7Rfa/I4X3oYqkV85p2LCVbIHFzQjqoh5gqqff02AHpNKGaj7bNAOCfMAK0MzUOB/ajOOS/h++8EP8vfyG5m/X5egz5wzM/tdOdadiw1vdWeRArCyOR4ysJp6Om94qF2kJCgita5kz06bFX8Exi+0P2nPXF/0iedAgyWGlzVNYYKDHuWQUCXlH79svPUa6kJFwv7d6M/06hy/8GqYIWMZ0A395X/xI3E/1mtbYoD7LDWNNIcp8yv6uE+aOGCCH4ZIyh21qgAQOtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by MW3PR11MB4732.namprd11.prod.outlook.com (2603:10b6:303:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Thu, 19 Feb
 2026 21:27:17 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::a8bb:9703:986e:845%4]) with mapi id 15.20.9632.010; Thu, 19 Feb 2026
 21:27:17 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Sebastian Ott <sebott@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Julian Ruess <julianr@linux.ibm.com>,
        Ionut Nechita <sunlightlinux@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ionut Nechita <ionut.nechita@windriver.com>,
        Ionut Nechita <ionut_n2001@yahoo.com>
Subject: [PATCH v2] PCI/IOV: Add reentrant locking in sriov_add_vfs/sriov_del_vfs for complete serialization
Date: Thu, 19 Feb 2026 23:26:48 +0200
Message-ID: <20260219212648.82606-2-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260219212648.82606-1-ionut.nechita@windriver.com>
References: <20260219212648.82606-1-ionut.nechita@windriver.com>
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
X-MS-TrafficTypeDiagnostic: MN2PR11MB3885:EE_|MW3PR11MB4732:EE_
X-MS-Office365-Filtering-Correlation-Id: f26ee63e-aa7d-4aa9-269b-08de6ffda836
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|52116014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RL5bykDqC0lvvp78+IkfbGRlKE8TRBnITiXcW7mfuH/q1mXYQpwEyIQD4HEm?=
 =?us-ascii?Q?gFafDPru6O1Q4WxmqU4+7a4+X8r9GF6pxVwxG2QrXtUY0Lv4B5ZVhvax2q6i?=
 =?us-ascii?Q?CVxlbZnYiSKC4o10v0dzyof2zfgeiX6FAwqIrOlU5ETlrnvtgq4WzW0xUjb2?=
 =?us-ascii?Q?soHxo3GfjYhoioyhsdtd14PGcAJEvJx0jkngl/UA09rsYmIb6aA4jkQj2J+w?=
 =?us-ascii?Q?j74TgKC0RqMaaGzyqBIzc75/QYhO7FsiwGrJ2RbY8p5sHG20PYTXjyjOXJN7?=
 =?us-ascii?Q?OG1SJEEu6U20ayHYoTLQt64aRrgIn7GhSJpP4SDv/QhxkivtDrbpscgqC3og?=
 =?us-ascii?Q?lTCzysmfSPa7FDEAqnVWzOwu+h+Ew55Svx44alonLsrd4jwqrlcWQOS3Emq9?=
 =?us-ascii?Q?VEOwxFQXjxp6gofIND9GE2k7Ubt83qe9/vdf0NSVWiMS/bg5bEd04NWaAhDr?=
 =?us-ascii?Q?HmbpPr9rlkOC20+tVjL1JjzICiUqCRagQm1vz003buNX2md9qgrUGj3TCIrC?=
 =?us-ascii?Q?YHN9lYSKbXLi9PEO09JxyNX3VUSLJs5windIXXURi0F2GBMokEny9mrj7DMh?=
 =?us-ascii?Q?Bt5TAKsETsHmvhDdjYYlUSWP7mitRZ8yEpizm7PuNnpo7fbrauILaVmbmSyG?=
 =?us-ascii?Q?T57WqVRTdFL6Qo7l7/vdNHSOsHRT9nxVXEiIIVZfJjFQJbjGL3/JblVxBbLA?=
 =?us-ascii?Q?+KFmcNO5JI/UW/0Sh1xQV/E4dLm9tAzmVycBGe0oKGVVuZp0GlgxOfTLD1Ta?=
 =?us-ascii?Q?CSjZsftf2RRhIlTZ9zclsUXohu/5AuIhcywJoFL68u96gnskdoPrUGw4rekb?=
 =?us-ascii?Q?joswdYZDzyY130FnpLPScSVhBXDgOWLpzbikM+1XpVSyYz9CjWeh5AynNJvs?=
 =?us-ascii?Q?Y6y45D6jCR8iSm/eEPz5NVcbjXmlrorsL0cYKVo7hxHDo4rVsioYwJWgXLj7?=
 =?us-ascii?Q?C/aYYIOmqkq2TQpyiTCALz3LlXJn/tU16L9HKG2BZoUJZebNLHzgfzIf/JIV?=
 =?us-ascii?Q?adjVd6F1VzNUOFa7CfFo7mXWYl/c1IZTQtSbNej9cVZmFgyBtQ3BNfh6Lyb7?=
 =?us-ascii?Q?bTQB67MKFEvnxgPCxzrR32GfHyzybecYGuyTL/JvS0nwomA7wa24JQqH7Rqb?=
 =?us-ascii?Q?vT1Ckp9O28XwIm8IRQQORmlAlT3lcNNtdPwjopGzkKpeP58GK5tQlVdtg5xU?=
 =?us-ascii?Q?7ApSzFSGZ1zKu74I1w6Qk85OR92GqwfhnGmJuhvAfYLOKc7DyfBDxosTWDpj?=
 =?us-ascii?Q?jMFgQQHWLBU+GPHwnZIZoEXyIBN7R/U3J//WWdvlcoDiiIWqZkdxZTTpdA9h?=
 =?us-ascii?Q?7mkWnJS7Ux4D/ivavXme0wbUNB7wAMc7bx6jBJ+x9H3LEsjxnzSeS3OnlVr/?=
 =?us-ascii?Q?25K05FRCztvPnNGAwbZ8eFKljWLAviHwemISXZwf/jW+lc+LXdl34vFDCpAa?=
 =?us-ascii?Q?LTAYgC27FYhdyBTnXMNUMcamYYdTnKwNoVsXHOaiGjQKXSUgr2PmJbFmNWS0?=
 =?us-ascii?Q?vtdJvYLavLbfodP7lvTYHuAZhiJMmFkYIio3sHXr4zY6eH54PyRO7vrB8OSY?=
 =?us-ascii?Q?uBe+19jb3PynLgjCWyo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(52116014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jPPH/KGbassn6+McxtAsfq/KePHt9Y6BteUKL+UiKC7AnBoBtxZukHsBmJxd?=
 =?us-ascii?Q?o97XqM5s97SpkCp0yNvi5K56ld0JlCNR0T849yPIsOpYGvTIOce0It7pcOqX?=
 =?us-ascii?Q?Ri3Gipp3Nt4zJB8xVURv+SRbMf6KGA0HvRO2rj/SADsk5Vuz618ryVGzA2bN?=
 =?us-ascii?Q?4rz2Suf9tRYAReoPOUCZGznr5lQC1isF7FbvGNljrsDBTF/oLq+6KGL4V3it?=
 =?us-ascii?Q?79VJqXKu1sYgfmQDX6FJVIH5Z+lB5Hny3j4kM/8waqNmBiifOI10vMIgIqQW?=
 =?us-ascii?Q?77ROHO5W+UyvjU9YFpCH8XI56IIUfpGSO4U6CSxVE3Z02mPesNSzBnAGYFLF?=
 =?us-ascii?Q?amApcnbQl/oi9zehC7uB+OMNfvMILPZPPQSGIfMBSeWgiMc03RNjH6zTglxr?=
 =?us-ascii?Q?+M923omAnY+8r5ENu3MUqXEnxG3RPCEygTBDTcKHZmtU8wCML4IFj7ePHlSx?=
 =?us-ascii?Q?I7rRqx1l1TLA96BnYF2DUnrrKA7acpSvd793iARJ2BibfB45qwz/0TovTsht?=
 =?us-ascii?Q?gIWxq5NnZVfoRdHza2IlEpuPCnhbf18/vIYtSBwYjSLDB2Llrjjo4Wx/EqrK?=
 =?us-ascii?Q?HsATfceKIY8DMwFJX5BuzUGMgjErcOo/yT1242mJZdUviEMqbhUeruMqfWzL?=
 =?us-ascii?Q?Xh2sRh22+2giTmp6jUFD4YFACkF7DHaUW3FVr3G/HP5/tkbTX2uEgLlRR82A?=
 =?us-ascii?Q?yimuTHSQ3c/C5tM/nKPczBoi/nIENS/9dEv+bB14QSz9lhSZBesO+DMWV/Ib?=
 =?us-ascii?Q?yVfZfiqGiQ3aArL/JtKmCmkQBsFgRyoKAW7ZzAClwUfl2Ly6+F97xfS36yKA?=
 =?us-ascii?Q?W9CRUbeqeXjD3T1oo/sbP6kgpgnUd7HC7T6yy3zEM5rU+hnsAEdfbtpsLM/B?=
 =?us-ascii?Q?qW/wEfBo+zQxkn5SL8LtZn8Hqs3POsIfzg6PxvcahMSdC2trz9sCVudNtt4x?=
 =?us-ascii?Q?s54TnFMl0Tk0zgq6+vQTB9iGI+Xu+jNeLeGjXyEkMxekZMeGszSThi2fSmWH?=
 =?us-ascii?Q?B30l1ltux1qXX7SwGkVBnqwLNN4gOUMUSQd+kMlz7QCGK8PcXdtRBz13FaGb?=
 =?us-ascii?Q?oPld3/OPUvk173VTsdWyhUDWm3ynB9fdgtQMaEfK+/qA3mC6kqKAuAihwWRn?=
 =?us-ascii?Q?A4Mx4pmx/bOwkz5LsUrW0EfsTqUwIVuxVt6rdZYeFu9S/OFBuuUBBo6hDBy1?=
 =?us-ascii?Q?tuiK7BygGOgaCqmHSuI+Z7LfcJ8C4GRIwK1MuyIr/dpojnqrqkFmk3TMXGM3?=
 =?us-ascii?Q?Jm8wkqIECQOVoureWVIz0zfZV7RurqLLmzKE2VgFmrZOVXoGTWT7kimb6F/1?=
 =?us-ascii?Q?qQc1b3Bjpc8YH27uc4/vqjrOC7fLfToyX5X9WiJAsf89Vg5QOXGz+QmRbRLg?=
 =?us-ascii?Q?iUdwBAhn/oWPjV7s74ARFWGP0wm6MdfSHCvGGVF0y/YC5vGr1gy2M5vuKBCD?=
 =?us-ascii?Q?/fXXinZ+U9oVQO7nJTgHCQiEow1KvNJHsHXg0C1xKQbC0mvkE+tK6Or0dMtN?=
 =?us-ascii?Q?BHB6F1xY7z/tSgFSrwcY0IObfBl6auOwh0RxxuF2vdMoZJX4uvU5KHg6yBGQ?=
 =?us-ascii?Q?hA+w6/AQSzlU+Vv1JErAKslzOx60uoNDHCfmmjgKJQyRL28fmFuG7hM3ZVbb?=
 =?us-ascii?Q?TfZ1QKnrlhXpwRGUpYfthOKJAKLJuU3Om6Q71t3ZQvqUzREamQpFrtHU2ENh?=
 =?us-ascii?Q?Dgrw9G9uT1RP2w/GYoYBumB5ulW9Prh1fxc97pL+M3ohB0S4OQsey28yhIvv?=
 =?us-ascii?Q?UvG1bbWCpiZ25RJ1pIYq2K1F9F5Wh3vosteCZLvWdLwewe2uZnGeMq63cKWl?=
X-MS-Exchange-AntiSpam-MessageData-1: 1vNqC8UIsnG5vg82yEhVgUGnCpyvTnMsKhU=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f26ee63e-aa7d-4aa9-269b-08de6ffda836
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2026 21:27:17.8108
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H3zegTz9sPS4fttUdiu3zwTb7Whj/UrDBMJlj9h39PwpLDaglYldZpLIARZJ+BdBqKAWI12swVdgzUONBYXPspIAGOFDbILwLxyBQvpo7W8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4732
X-Proofpoint-ORIG-GUID: Ehw_IEUTVYlkYQEWGCIefFceWwQ51SfZ
X-Authority-Analysis: v=2.4 cv=KpNAGGWN c=1 sm=1 tr=0 ts=6997803a cx=c_pps
 a=3EeCZaq8L1ZepF5DamB/SA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=t7CeM3EgAAAA:8
 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8 a=QekT0dY8-05RRyt2v2AA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE5MDE5NCBTYWx0ZWRfX0TVAXtw0iIrp
 jgY2+Snsv0ULqjB6jI+kUlt1q2UbZcHL1fQGexdbZD4MBOM5MM16MzG5JnfxFD3gDtvZ/HJbAdP
 7DG9+Ehstqwby7fhjIvpPd/bhuta9qy9Mdz9EKYxq/n9U9ATeuMgBpYFpC/u5s1NgDCLKUJ6A+u
 Nz3Y/lsCnaDew8+Ty6Bgw9+w/bU6Tn/p3Y9j6OuF09CkOQ4jM/hfjD3V7JGwwv3X7FHNrm0XMQk
 vFN3xFTDR4rbcRDiEsSYQECe6hmpPW/wHHMJZ53Q/krD4m4naoasIUs31dPAqQw5ZEzCtIYcGbh
 YfGZyUDclDSNrRetox6fi2rFsD5nfJgGxQFTkR3sD5sBEstiwzm80bvWZ024QeebFojcP1/Bnzy
 pa6/YTeJobXAoM8BDHuDDPol0Q1y9uby0HB9vhZeNJr1uOqrFW/8N7H5nnTrfvxv9EusdnwJmyH
 OXABk6kDpcwwFejF0JQ==
X-Proofpoint-GUID: Ehw_IEUTVYlkYQEWGCIefFceWwQ51SfZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-19_05,2026-02-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2602190194
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[google.com,linux.ibm.com,gmail.com,vger.kernel.org,windriver.com,yahoo.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217513-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C8E0E162CE0
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
Signed-off-by: Ionut Nechita <ionut_n2001@yahoo.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
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
index 4a659c34935e1..9a2784863be7f 100644
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
index 41183aed8f5d9..f4cdcad7729bb 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3540,19 +3540,38 @@ EXPORT_SYMBOL_GPL(pci_rescan_bus);
  * routines should always be executed under this mutex.
  */
 DEFINE_MUTEX(pci_rescan_remove_lock);
+static struct task_struct *pci_rescan_remove_owner;

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
index b5cc0c2b99065..0fb1d7709dba2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1512,6 +1512,8 @@ void set_pcie_hotplug_bridge(struct pci_dev *pdev);
 unsigned int pci_rescan_bus(struct pci_bus *bus);
 void pci_lock_rescan_remove(void);
 void pci_unlock_rescan_remove(void);
+bool pci_lock_rescan_remove_reentrant(void);
+void pci_unlock_rescan_remove_reentrant(const bool locked);

 /* Vital Product Data routines */
 ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
--
2.53.0


