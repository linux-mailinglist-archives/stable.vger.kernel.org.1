Return-Path: <stable+bounces-254032-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPpkD/8KE2rb6gYAu9opvQ
	(envelope-from <stable+bounces-254032-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:28:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7B25C2AD0
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 16:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFF18300292C
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF16392C47;
	Sun, 24 May 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f/AMhm2o"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66890305678;
	Sun, 24 May 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779632889; cv=fail; b=n6ZihtXTI77IdrOdHAZQULxoIF7qkFWFNS4yop1jvUvNAGMGKXS0QVse8UeWccRWgvNVSVL6+nCmRiqz2q0QzKwnA68arQjM0D3SjlY5gZuyR81Go/LSd7MlctcF6A4ZGbaA/3bZymtlm/Q3LGEe4fD7yC1iPfF32Sik5YFADLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779632889; c=relaxed/simple;
	bh=zr2GK05F2qsViiUy+W8ukU2UP6HiOgBJ5/TCXsFJi4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IODH5u+G2kAZARE6PqrR0QIVXsDhrBgB3WmVJIYzZ0gxjUACk97LrDrcagjRpeTKzEZTMVXUfrRns2607UALs2pMPSPOijQ+tgO6qwzfVYt18wUgHHso09NIwmdO1YnPAL1gmW9gSvxVPn0WwRFQfvddpDv8oIQckrLxtAbGJlg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f/AMhm2o; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eEBZ+N/I/OdpyhxOAtQ8dVQkT45VMUmYoyulFBrGqo3KblrAAoPA5JMxTP6E0/ck2IBN/ezJs4a+9IreqaEScZtDYawUhwaz1e4GFyAgZEDXSbs8vVLFXsmvD5aPFNEVg0zmuyIousdlpzeVst+y15jsk86XZREgPU1nJabJMG0C3MwKPj3wUtMv6e1e0BVVGVJ76izb35eNLBYY/hphUB3coC5eaWrZdtWcuYtsCglr4q2pn3wqt2bBy5O6aK6HAHYCZyULQTxY/+uhopPFBB3FrpZTiwRL62MTMZf6vT/jYxdw5Oexi5Sn3acKs4BQqBAwE1aPUHEGs1TcvH3FgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qD9EyM42HsvNiOiq9N86Sx+xqP6pNGKBKoSbT8TDEzg=;
 b=ORCjq0eLYW5gXg7K+cnik3oZvqA1v8aNi5odnDuGVDLuZnBNgd18iY3KspjSiMlhcQcrEdV84EFDgzuMY2Emw61sfdlP3j3tYsEeh3RR6McE+47jQcuiOeoEY49XJSuoftUzFsF0yCCijfHipJ11ZtWcqvQ1Ft5L8TeVoIPpdf85ruSspQ+saTNYynk2P5b6ywsPoINnEfnc4pCPX7cAn2PPnRRb/5FTgnhDrWWrVcDZmoUjh/LMKEK9gF0IQ9tJHhX08mQlDvdQijZsSzOiceyftVTPXVsQW/Gu/juVmPDf863wJwUkuisatvLezxylfOivlJMg9EK2qWrrXqOTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qD9EyM42HsvNiOiq9N86Sx+xqP6pNGKBKoSbT8TDEzg=;
 b=f/AMhm2o3Wm26AQAW5Ip99YL0W/38KFFWRBdCyBQSlRFcr9OiJOVLy24tm4VAVLDVZuinDTtV46wpikHeTGHRNFHAT3sRrkt1B/tJXs+FIATCnN0HIK4coj611pbxLrHPoppEPjYRf0Ur5LIrt5HiDzKU13mVpG7bup/5iYRrDWALPh0UMHTQD+i3kOFQik/W9iFxMieQnAeuLEu8dGnXHT2KlPndKf/ft9stpnOPhnqX+1kjomLAfUEAKgthrnlrlA7URXfqrNRl6Eoa6MrUNO2BOE88DlFHpGGp1V8Rrh6SDhu28hB/9LdWae2M6sav36WMzjiFoEvlnDgqsC7+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SA3PR12MB7901.namprd12.prod.outlook.com (2603:10b6:806:306::12)
 by DS0PR12MB999080.namprd12.prod.outlook.com (2603:10b6:8:2fe::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Sun, 24 May
 2026 14:28:05 +0000
Received: from SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2]) by SA3PR12MB7901.namprd12.prod.outlook.com
 ([fe80::6f7f:5844:f0f7:acc2%6]) with mapi id 15.21.0048.016; Sun, 24 May 2026
 14:28:05 +0000
Date: Sun, 24 May 2026 17:27:54 +0300
From: Ido Schimmel <idosch@nvidia.com>
To: Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] ipv6: exthdrs: refresh nh pointer after
 ipv6_hop_jumbo()
Message-ID: <20260524142754.GB93154@shredder>
References: <20260522112013.12342-1-justin.iurman@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260522112013.12342-1-justin.iurman@gmail.com>
X-ClientProxiedBy: FR2P281CA0120.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::13) To SA3PR12MB7901.namprd12.prod.outlook.com
 (2603:10b6:806:306::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7901:EE_|DS0PR12MB999080:EE_
X-MS-Office365-Filtering-Correlation-Id: 578fa2ff-84b8-4adc-d267-08deb9a0ab19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	+RsZZQEUQTNl3wONak/9XnsukYTouga3br+ESMS5imMGSKxoW+bpSt1raFgxnVnUnTFJ6TxO8QrQgdAZe3j5zmvFOGvEtaA6Yu0mD1z4Q2AqTXE4++o9OmRNF/RSf7s16rFE523z2Uu7L7OFsBjSg0TeiJh9K9rtAg3Sz0P9juNclb6V9i9r3kizeZeFP3vULODXXyexisonthzFdQhQsGazxfed7udnjG2OX3olNkfVHjng7cl3fFDXmSNk8hCEyeQEZ9gXwOjPobN/y8Pr8nFoObF/JKVSOFy9s+7sTkVXX1GhIezyWjVi0Zwbcyzut9ZXTyG/rGwtJPDGZPCo3e5GSH/JLagqaihS+DzvBdYBweBC5B+wXGKrE+Ki67IJ9cDJxCzJ6AOZwokFHLl8nAWSW1J/xrNsOU+w6u4wPkBdEYXdleKiA0dHLizJWdJY9yrVPQ0G6+CCFQIt8Za2PWRZNYMQ+2bEmx3srgvwuhRWy5KeiRkfVFU8VEhBVdSyRqvt4Y/PVKnJTqsEWCRF0GgBOrW9JzZ724s4iyxkS96Y50t6td07d1k/dfduSDHrxl1iMyD6g41cNFc7awV+I8h9kxbmpCzA28g6VmVAwI4Fe2FeMv2McQw6HeCsK/aCXd0yQ+aJt7IidprRwPhEQIPPV2zI1FghdIzAd2+IQg9Ksfhv1bHwNmNT1s7idvGw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7901.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TTVV3W7Xd8Lv7a7QBeWzOgiE2FOz1JYytOn33DZbK62GkGKaMQJpQVdk6JmU?=
 =?us-ascii?Q?ISSKmi5h+T+xyvvepGF257GI81L1mW0fziEzCDE/R0krHAKderaCO+neIonO?=
 =?us-ascii?Q?pctL+aGpsec7eepZ8mxZ5qwqhk4X0IQOyLjQsl6VBRNpFYCN+G+zo08ZPCMx?=
 =?us-ascii?Q?YhR0EAxAe/yEl3fh54gD3OEY7syHE+bwduwcrgo7wkA+u1Df93y6LO1cEKld?=
 =?us-ascii?Q?bcCMLxH9KQszZWxQStOARVYOYYuodbRzmPRYW9kjOPmDxX8AMA8sTVYQyWZ/?=
 =?us-ascii?Q?qBLWEZBPd4UxJ4P4r9sgSjQ8p4HhzdgcTqa+kuTCQklHeHmvEejgPCIHqy+c?=
 =?us-ascii?Q?X33auvgEAiXCRKH4o5wZJdTbwLjsLSf0/uUcKqIvDoMD9ezc/+fYZ3YPYgZd?=
 =?us-ascii?Q?VZgu8ulR4rAhZhZNd5NmRR7crgfGRtUZHbNndtjOPS39l4GjPfbIwgfAz/CK?=
 =?us-ascii?Q?Nr3gaJ7IdEYebzvDOpRr/AA4ufZILrBy8swhcfGHB5PEcJwu7onNLIZgU7rp?=
 =?us-ascii?Q?2GFC4UP9qmZPxCuC925HShCnoBEkSFXQUqHtjEz5QXxhZ4CcnX+OMDZXjz5f?=
 =?us-ascii?Q?an68r4XZoM/DhCkx4ed4JwWMDaC7fncDbWO4BLhu8Cue0X8KJ6+snO003eX4?=
 =?us-ascii?Q?2yAJef3ULGpzWbQyatsaFykxZhwgmmrb1fe/HgL4TUPpZsyqAUDvuY5TesSZ?=
 =?us-ascii?Q?fqSrlAoTDoAhrbjT77ljKn1E8nwJK5E5fQGNCCqMmj4AedEM3DOAvlEaGln5?=
 =?us-ascii?Q?9ovIKSYndzsREwodTFZCX3ekBIzIDkkDCJfLZbYxKeEnO+HB/h3skvEsKgVR?=
 =?us-ascii?Q?jFwcSRr9vipoE5ewiUNearss9VfUYCBxjvWWcm/Qw0XTV8NPpxTBlWB1147r?=
 =?us-ascii?Q?WoXDa64iyC7XoPVIPqDfNYoh9J6LSJlefBDY9GQcfi2B9hbYK/L+fdHMFofm?=
 =?us-ascii?Q?sFsqOFNgmue1sASKIXV9CYQJHtDVSCYczOMGfBZ7iiN24f6hcUUQjwAEISda?=
 =?us-ascii?Q?lfcCOFRdezAe2TcucLffRENnv+okVwTYv/dzhogYKH6fQr4e+zBAOPD2IIOV?=
 =?us-ascii?Q?x9uPocHsAlhMdXUhWlWAPtrpctjiDCoEKp2DKhrcIPkE49awtgFBDCuAwMin?=
 =?us-ascii?Q?rseSH+fmhRTdVniz9DVaSryJBGihlyarNO6oapqjifwSg0flY0EN85vligSQ?=
 =?us-ascii?Q?x0KnKNubod8VduHSxB9JOhpiO5SFYZSsb8tyj9nPzdjFEG7Clb+J/oWQy82U?=
 =?us-ascii?Q?KDDDIjeMMi6vemK/LGlMK5mD51e/xlIFKxPwk5JUrCFmuaomZSBqtst6VbM0?=
 =?us-ascii?Q?fxiXWfnk1wL3zZqu8+AOnA4s4hnAWpeNSLUpsWCp+l6QFquKsmcTHwFtA5OA?=
 =?us-ascii?Q?vltJ/N1UoTLJQr0GL4dyAVeAfNUjaVX4+DCdAEclUFil1VTD5/QZg38LEWz9?=
 =?us-ascii?Q?NqqUwkcgPdNYve9xSMtUovJansRhg2JpofiO6YaMbLljR1b0wW2PgxbG7RBR?=
 =?us-ascii?Q?mC9QLk1S7aFoh4+6rowiipkYswHAuRUIor1sTqN5PSHlpyl60hQiAykbFPba?=
 =?us-ascii?Q?cQBSyuH4oTP7vIxcbRxEurELNVM4cXg4mvFmo9UZn/aWuhSW35uuW9XW/Zbn?=
 =?us-ascii?Q?Pdch2HbAqksnNzyStOBarG1ihra+GpdGg0io8p1frr5U3p0XoDOihwge53UL?=
 =?us-ascii?Q?7/5niH8F1IFL3qBDOouVYkPq6/oGbwWDxZ10cbEXJcEikI3q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 578fa2ff-84b8-4adc-d267-08deb9a0ab19
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7901.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2026 14:28:05.1016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 17HNv4yyj4CtoZBxmzL/+aTigJdgSmoeF1auW9KE8oa+51XUGpl+b38u2ht8EEOIPpxkBgwVpWWkqy6QlYXQKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999080
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254032-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idosch@nvidia.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,Nvidia.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2C7B25C2AD0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 22, 2026 at 01:20:13PM +0200, Justin Iurman wrote:
> ipv6_hop_jumbo() calls pskb_trim_rcsum(), which can change skb pointers.
> Let's recompute nh pointer to make sure any change won't mess things up.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Justin Iurman <justin.iurman@gmail.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

