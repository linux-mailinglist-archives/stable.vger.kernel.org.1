Return-Path: <stable+bounces-246838-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG/oJiBvBGprIQIAu9opvQ
	(envelope-from <stable+bounces-246838-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:31:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 177025330D3
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 14:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B23AA301CDAC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 12:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC441B352;
	Wed, 13 May 2026 12:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ViZxXrhi"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010054.outbound.protection.outlook.com [52.101.193.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF912402BA3;
	Wed, 13 May 2026 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778675483; cv=fail; b=MPYyMkYSuWx85H7L3OBElawE0IUzQq3HkDSSZLt9U9TbIVQvG5pfp7ReYjKKrYbxdnAkutzpyhrU+/oej1XmVxTMZZCGEl43mLeV+STOR08NrZtapLlRYZ058XFIc4w8W2i8JEQHwHB+02LJPbSI1BGXJiUhNmaTxsbatuQoi6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778675483; c=relaxed/simple;
	bh=JE8KXEQrTAoks7lycDICZuC9QBK9LvrG2PTMXqRX/XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=cVDBNwYClIjFGBS2fnGtoEwjZfoaw5VlZBJjV5XRq0d5lEqgqQSq5+9pMCtC+xxHgZwBZzfcatoCecA2iGbX8lwoiuinRWNV0Hg1IW03w1It/L4/P5pTa5UYOzyTBJvgHbFcDOwcA+aY9IC6bZI1Xy6HlUnQJF0iIDVaqpZip/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ViZxXrhi; arc=fail smtp.client-ip=52.101.193.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTSzNlFAjgM0q3hs2WP4mNeWG3Mr5Z+DRiu6n8bP68KNk2fPoPwykjhLe9Od4+ICkIczwC1YmCOVq5NJT+h/IKVI0n10ud+0O5WHngI8AbZioyFrVk2e5LVbUug07+uzXsFRzw7cp6Qt51EC3noqhEkj1wYkz/u3o14wPED/Y4Fg4FBHUVX+rND+/73YqcX+/L2zkVGKkaBTncVtOWmFS2bo8B1lznnsmw4Hd03O2vJqdqDszDHherkz54d7wzu3qfMZzQ/IqPUrZIM7Sv2F0tsqj9Ol53vpfk0kUjDkuRIamBCF2eJ9Xp9SBLj9HhF4dkuVsqGXm+Q45+Wqvpkffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JE8KXEQrTAoks7lycDICZuC9QBK9LvrG2PTMXqRX/XY=;
 b=X23RTrts7nyrG4Ygm0oTOmxeG70xfPk3j7iHZMJBqYeRPhxsenbkTFKrUoxOrGGf3r2eNXVD7PA1aAqvSOY7gy+14b95VdcXduONMoJdQC3aPeD9klUf2T5TP8jra/UIu6JKbAYvdwckCyB0+4hkoZB3xexVK2FdXSy+sB+Sql4Cw2HxYoJ8a1KFbl/NhPVGRWSXOXK3ZjX5f3RFtpyWj1PjxSn0KuLF6OZmEfirX7Y5ALrWH7GkDhYsQc2QAeREWA00gw+nUbLz3WG5m68PSFhr8VUwLse4zFG9e63rca/l/VnP0MJhgYnBtxaGiNRGsEaVCUNpOCHOuQxH3KOYXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JE8KXEQrTAoks7lycDICZuC9QBK9LvrG2PTMXqRX/XY=;
 b=ViZxXrhi/a/bM1qMAMpkWPfwDqDRLrYVuln+JqdqCZct1mtGIyhTDdiSmJEDTw2GftYAlLKpAtKiNtLdZBzPA0pPozlXiP5mdByQtuvCFoYOV77/CkNBdB9aacA+BtK5wYTuM7VJwRabHOHdmt3KRY00CBOx9cLiB7A7uQpfUfuY4vbARFARWYJdDno1XINeQGg/+q7SpkoegHrRpr8IT3OH2Z7g5hjzkGl7Zr48ADADSY5F/PQQpu8YSWmROiyTranaC5GvVZRuy92FA6L/EbKV5QdLXrUjSDHW3ixgrateFipK+wxi+anNL57aCv8R1YZ9EeUdx9xPjxtXnICKHg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Wed, 13 May
 2026 12:31:17 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 12:31:17 +0000
Date: Wed, 13 May 2026 09:31:16 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm <kvm@vger.kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Yishai Hadas <yishaih@nvidia.com>, rananta@google.com,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] vfio/pci: Fix racy bitfields and tighten struct
 layout
Message-ID: <20260513123116.GH7655@nvidia.com>
References: <20260511221609.3837652-1-alex.williamson@nvidia.com>
 <20260511221609.3837652-2-alex.williamson@nvidia.com>
 <20260512131812.GA7655@nvidia.com>
 <20260512122355.22132e61@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512122355.22132e61@nvidia.com>
X-ClientProxiedBy: MN0P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::17) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: b97c11c0-8bb4-4c9b-f980-08deb0eb8783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|11063799003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	N4hLG85ltX8wnMNzMued9ZzOVWdSCzJcBNjBj83jFgaTbjvr2eKozkt57tZfQTLrBRurSYCwUyitHVZcPRySCi+CzgQVyzQdcR0lPs4tmG/C21cTIAfTVDnSVcYR1NPDA4LiIZixCIW8W/3E+VnFjiygFQb+On5fFHAqjpPkVO2SWehQfU4Mp5bDotKlndnaNKUROVG53jd0xWX2fVnlrndQoWhZt/7dKfLHLhlO3WqFP3NfQqOa2dwnfWX9Wrlsu/8WpA7Zd1lvO6NtZ+PCtWSeGMfv1SrDVVwGxjkA61Cs7CB+UIyGAVSH2PUL9l0GQP1rNu1flk/NsonlJ/h0PLPeMN6S/n/ucleTUgkxAZETEZHWv6F1A+BGsG8GgqhfvpL8I36oSD3dghUKNRpkvuKBFBUbRdNWXXDrEs1YLwpJPf/atv2uoMhaByj0mmFG0Yy7W+ny5HatVBqxExe7O2X84PXbPkla7I7qVNzo9dYU4LHs2u8nk3qV9DeYc9Bwj1bQ0tbeDimpvWW1xckRf+FqpAHCsp2P8ooZOvhWMP2Tf5vNFnE4Oktsl7EzC53c1MYfx42OMPkrsoHQfIiMXSZgQyUy2Eb//d6U72PSBUg3YECCIKI26MfyWN2tbJH52Ay2ZH8ykKpiK6KuiRLeyi4YeTc4aU/zwb87D6PfCvSZZeSXotpiE0zwPek2Fjyh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(11063799003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rT0bkSI1kGY/YkcgUnHskuRUaTdGwgPOeVvdoQQBvMp+XO7cN4pWM/uCwOJN?=
 =?us-ascii?Q?qRbF66s+LwCR31flHDlNmfTUtDTzpu91n676fpO1e0wLrnUOt2b/lM6p+0Z5?=
 =?us-ascii?Q?+ucBfAwZEBEC7qlckiARAEDn/qibmj2xBzGYmgO1awuSQhGLUuWQf4Pn1Poz?=
 =?us-ascii?Q?aKCly5Riu/6fKEy/Qn1zAA5RvbxDmIEx/Y8La+RkTUUfexHqxSILq6XNG0yd?=
 =?us-ascii?Q?GYd1NTuuwHLJFTHb17D3GqIcsbYy/6m5wWVRidqU1NxptOu3NXo2Vmbu7bdZ?=
 =?us-ascii?Q?i3jqjlyDiZl0YG+tYxsQ5w+rqB1BKMkJhqkZvmKuzB7JFLDAKxTNQyiQPKtD?=
 =?us-ascii?Q?vM1sChYdkKTmt1AVWLEeMxnXJXovT9DM74Ir13iTJ2Zce0MnLBdW6pgDXTgu?=
 =?us-ascii?Q?wFKsAfRO9UMF0VkTOMc274h/lL98iWOxa34inyhPdLZM5cbidXJR1GFRKRHT?=
 =?us-ascii?Q?tP1/k1kTiZ+WmR2hyOYxyNpBow7pQWbyic0h837VocR2CzMIL8cgpk3IsMj3?=
 =?us-ascii?Q?PvuCrWxQJGzcTI5YlbNlkQXaRwJtsY92o5kfe1XBES+5Z+xdW9XSZ3LEGyXy?=
 =?us-ascii?Q?skGncC3WGLpp0G5Gh+iV+45fydcCfrX0f6q6yTDLxeD6SQRRN5oKsuE4W0ga?=
 =?us-ascii?Q?2x6rTF4HJLOfodO4526v01hjZ9NxppXuESUXV5kLqtxVXD9roXD75ZsnZ+TB?=
 =?us-ascii?Q?02ckxLdmguLjoK2H10SnOahZSd0qj0/Ty9uF2h4qm4V7rJ45ZgjqlM+IZ6Uz?=
 =?us-ascii?Q?64A1c/AArjMDy8R5oOF5cr0ZSduuCGq1UnLdAyUrEqxWpHemrHIjHlX1pE27?=
 =?us-ascii?Q?aoNX1iV0OoVkm/L3qCrfyW0dpMrL0XqQNIyEplNv/TF7wrPVIi5qR/Bwp/Y+?=
 =?us-ascii?Q?xCOf3HhTKfEdYtJDgJ67KqqPD+GmqUYu0mz/QQjg7RgXTV4u3t0g6DZrwRr0?=
 =?us-ascii?Q?lw7V/A/IzQ6J3xskYFNW02KWi7/UpsNK5db3zJE11ecCnnWREzOXtDkr5zid?=
 =?us-ascii?Q?wDsa91Dc4mgXT9bod4H9d8GRp5xcWkoh3JSb+JXvB1lbedvyjUq+gGSMJf8J?=
 =?us-ascii?Q?Mn/FIz7VjQbzh9VaBULoog/q/3LAvuUfNRbrPCqVnAxnGGlEAI8Rw/jL3Klm?=
 =?us-ascii?Q?juitxQ971CYDA8aie3tpEW0t2Hxix5P84k7bIO29S5QJ/FNsfsbEcCZ2/vEE?=
 =?us-ascii?Q?rR97nwVKq3mGkbRbF7TuM2pj6ERi5tWi6BFm05uF/tedXMkgLlSW3RdLiqgx?=
 =?us-ascii?Q?AkbGyGb5k1C8Ne7UGcJ/zykgh0CBdEc7rz9o2qNh7IghSLjOWMrLyVDtf6IW?=
 =?us-ascii?Q?xibh9gMawLO4/KWk9/1GGuf3EAQgNAxHID2vTFdxiS2vgdMlDJ8JJeQxZ8MU?=
 =?us-ascii?Q?//N9tWdzhfwUYBi8IesZjJJxBBHwT3yTRIttFAMn1kWDmQmHQgi0K0Wzqotg?=
 =?us-ascii?Q?42gLnSOo+soX8CgpuwpWqaS+t8yR0FIOFNWnmceKxmQdhgpddHvsGVQfOYHu?=
 =?us-ascii?Q?qSasUrQqvyWU4p/x7h/k66CrsGXh5VxkNiIzLrmBjLvelc4JoFxxtJ9Nesm4?=
 =?us-ascii?Q?vyxEhem0qXEjrUSKLXOX6GkLkJl4COVjbYw3YAyxheElTN+ytgD4M5whNFBp?=
 =?us-ascii?Q?4zxf0sy8XX8iWfY93I6Q2GizHE9X6FYdun0c7Ritd1xpoRXkxLelxRaXCBA2?=
 =?us-ascii?Q?sN+RQwupEBewfffqNbg2Us+Z7UFl0W2P5UaomATgBQMuPEGG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97c11c0-8bb4-4c9b-f980-08deb0eb8783
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 12:31:17.2044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 79w+z/QrUjPhezUVq/1V0sft+m8MavDKL2KZ0OPY5RfuE/1WNNInDCEOeLCozSO+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Rspamd-Queue-Id: 177025330D3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246838-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,Nvidia.com:dkim,nvidia.com:mid]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 12:23:55PM -0600, Alex Williamson wrote:

> It's not clear the bit compaction is worth the subtle RMW scenarios.
> What do you think, should we reserve bitfields for setup/release-time to
> avoid this class of issue or handle these as individual point fixes?

I think one patch is fine, just that every group of bitfields should
have a description what the locking rule is to write to
it. 'setup/release only' is a fine rule too

Otherwise the next person to add a bitfield will randomly select a
group and we will be back to this again..

Jason

