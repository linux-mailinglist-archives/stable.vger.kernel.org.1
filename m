Return-Path: <stable+bounces-244578-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFCHFzGk/GljSQAAu9opvQ
	(envelope-from <stable+bounces-244578-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:39:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDD24EA57C
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CADCA3002527
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 14:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7223D4135;
	Thu,  7 May 2026 14:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cRqRek+0"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41422BCF45
	for <stable@vger.kernel.org>; Thu,  7 May 2026 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778164562; cv=fail; b=jqr704q3fIts7GwY/SMl8I6bIbhE9uTmLyvFJXkFOlZyPeyR4ujkCuM1Ys7r+ZAzIeHs/CyNCw/dDQQeT+O6V3sekWmaOSg0t8JhbAy9kzSZBj95ugWGT0SipYk2zLZ5StYahtXaPi4Oggv/wFnTX+5463dMjRAeJJwQdNMzceo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778164562; c=relaxed/simple;
	bh=dSPK41iFwKpCzYLb414GZQ6aBVVZ4z6HN7JZSrQeASM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=WWQFOzgwC6hjgTFmw1FZIq+yJZ2G2UPAwRfpLcrKj957DK7mrCMrZ1bHT7A25+ScaNXstZ71DyzDoVXxc+mjZz/NwB6/au2/SI3skZPIoOlYSXEePgkldem8cJpfii7DpNCZOlSKf7YhDIYuOeamYxhjBjkPlICwvJYLqr0UbYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cRqRek+0; arc=fail smtp.client-ip=40.93.198.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lWqSV0gy9DkLIM4xilJ3wknGJ4TEcyZR6SRWDdT86jkgjICMMcJWGTRuZAfXG+CMSxC26Btuv7GcR1SVsXGkuT6kqi/tWunNc6rybKCZsQdV/kYhsJNTr7fNUyig1TZv+KmL1riw/SbDgq/7DT+4CmO5iQGQimQduaJ+md2z/VV2HGBbQfiCFRslym3PvWmBoCCiLfBX01V7klSfFIfg2gy3/CByWR3qpogYet3ILvT0RoVqx8Ux4YIjEyOUCy4z9xwZH6XWAnD+v4Bi4zo9T4Gh7Dx8W/e0I4NK+YKvBSlkZh0zgbs6iT2wdyty9Acg1cVhX6R3tcwHEjLptSiErw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0NPHpo2m0c8GxAbLRNfk/jXTV7bS5E0mB41Dcn81oQw=;
 b=PWVkvzpebdE03I45s6MXSAPcBqXYZ1Vt726YTTVEHUylWi1NbDe3Mag3CBgQDQxZGZvPUMWjb8QvI6bC0Uwk6smOEtsJB3RBIQpbJmN1pWC5pcBX4k7EIC6t0HqCZdE2GHTwZOMpns0XD/FzDaW1HLwwf22XnVp3RlLGjQOCqI6xlEYomdJ24Bi5UiWk7mRouGrA2i3PrQwe93ewuXE+FNFTHrqU0L2mmDydftaxv8e/bAQc3Rh66bhmpL7Dum/7i5s5Ia8pDCGT2+jI0co4052YJvuEvyJGpMRowN2HRmaAUjDC+ZqFVty+FGyo0X+I3ahFV+pd+P3deWWHLszKew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0NPHpo2m0c8GxAbLRNfk/jXTV7bS5E0mB41Dcn81oQw=;
 b=cRqRek+0VLKn7oGs+6D9jP22Ruk0x/K7z93Av6oe42F/q9x7MQG5TrFGtBJSQhrWBc/rKvBlr2zmh7Zwx1J1QoxZx76e//x//BUXpUVV1zZNZ9TId+/Q+K+Rid1A3k4BaTokCHXSD9qVXeSQCJFOa/l2/o5zuFGrNVeezWVFw+PVt6y3IFug4+EbBPntgPF3ZGolykNrWBvu/XtDQ6diLKfggfncLaKdJmJQKVA6QlIHeN6x0+5kUSmJs+0bfb0oWQejOHg+kqiRUHhjaWBx1ubcR/l9T00yvNezcpl7fu5PcTihdBDz/5XwaaGDisgVJV6CF47dpv9V0qZGjSfchQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV3PR12MB9411.namprd12.prod.outlook.com (2603:10b6:408:215::20)
 by PH0PR12MB7839.namprd12.prod.outlook.com (2603:10b6:510:286::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 14:35:56 +0000
Received: from LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15]) by LV3PR12MB9411.namprd12.prod.outlook.com
 ([fe80::98b7:86de:b69:2a15%4]) with mapi id 15.20.9891.008; Thu, 7 May 2026
 14:35:56 +0000
From: Alex Williamson <alex.williamson@nvidia.com>
To: alex@shazbot.org,
	kvm@vkger.kernel.org
Cc: Alex Williamson <alex.williamson@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Carlos=20L=C3=B3pez?= <clopez@suse.de>,
	Matt Evans <mattev@meta.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	=?UTF-8?q?Joonas=20Kylm=C3=A4l=C3=A4?= <joonas.kylmala@netum.fi>,
	stable@vger.kernel.org
Subject: [PATCH] vfio/pci: fix dma-buf kref underflow after revoke
Date: Thu,  7 May 2026 08:35:46 -0600
Message-ID: <20260507143548.1018405-1-alex.williamson@nvidia.com>
X-Mailer: git-send-email 2.51.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CYZPR14CA0034.namprd14.prod.outlook.com
 (2603:10b6:930:a0::19) To LV3PR12MB9411.namprd12.prod.outlook.com
 (2603:10b6:408:215::20)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR12MB9411:EE_|PH0PR12MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: e022e477-fc58-43e5-e277-08deac45f2d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nc/IRx3z4iL1+53yr0xennpm7y/jMeXncJmESIexslRawN94IJJXEIRMdxkc+jwJ9ha/WtfZXX+boNBdDKwgV4oZ5/S9ZdkSTHJqFZeSwNuMvVf86Nf0zQnbzFLnnzUJeTrcpvG4OF074Zp5A4kGgZIveOxBZXfMVtneXJh3KiJd3gnl9DoBc8dgVTZmn1hnkTUCE+TFURs/FLP8Jg22ShXJPGOpTfp2gM3l2vS0CoJaZYXB+P+/k61WRrFL93Q8iWHB3hu6mXIJ7QtAOxT8HFm1CB/pEZg534aE31Jm8Q4ubCJHDjqN8Ge29Qm7R0p0xzBQ9Va8/TOzxJ1hZi9k5MHT02xGLhvz9jaKaex4vFQ0XA7rImUci520s4iO2+WJHtvVp2wNubqupf0neZBDHLlWmBr5oxmGgRmI8T4j4JJz3ZoutyFH0z1SP18wENB0E3rmZ1h2A8TG/Yqf+Wk751xgQf1vV5nFxQxCz3KIKzlyOFC4n3auf6G13Bzq6rH1N5Y4SUNjdPcfDDIn14nAc8sGhpE3NLINq2V+PvEXFjPNlOLU+ddMhmHfZ9lx49/ZL+j9rC+I2raPCRPrDP1VL21icxD/sMNVE211r3mz6jPzTOuAU53e8XT68bU1s0D3iF8AfnU5tVxHCYiO5V0xcbUE7oONL9tSIaECzdwvrPtw9d0ke9TDRNMIQcNm836IwyD6eU+pgImqL4Ww8QjgJQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9411.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDZBTzc4cktIVjhEY0VPNFJtU1lCY1Z0RU5sZXVpOTNFN0VsV1JwQ3poNlhC?=
 =?utf-8?B?d1Y3NGhDOHlIM3cxMU1VSU52WXgrd1BtVDZxUS9FaDVQOVd4clVnbVN3ZGVR?=
 =?utf-8?B?eDRMKzJVNGoxTldqRDFTcFUrYXlxUVgzUExJNjdiT2pSUEFBb21Mb2x0RnJW?=
 =?utf-8?B?c0pKZmhDczBYa3pyejUzdHpTcnN6NG5iQ1N5dEhMa1ViL2JMNzlkRUxLelVH?=
 =?utf-8?B?Q3RRbFNEYWZVaHp3QlVmV1R6K3JYVm5McWJYQTFFSjErWGZBK0x1dlNDY1Bh?=
 =?utf-8?B?Zmh4WFVjTHpWOVZJZTZ5cld3U1FXU3czWXJuSmFxYXlLNjFiNXhQbmlHRmFa?=
 =?utf-8?B?amdaWEVwbkZXcXRyY3N4b1ZobkFPWTJQL2Z6YVhoWFA5RVFDVW13OE1UQVRT?=
 =?utf-8?B?dGhMS3QxdGliNHdOakRDeE9GT3RTMVZXN0NHSmpmSS8zU2FnMHBHNVhHNm84?=
 =?utf-8?B?YUNTUVlOT1VyM2pRSWc1eVFzQzh6b096NDFjZ1JTNGt5L2FWSlhyZVpLc0lt?=
 =?utf-8?B?NmNoRE5ta3ZEUVB0SXF0SEpuUGNnWmQzL3ZpQUFCejR6L3RUd0NpOG5sbTVD?=
 =?utf-8?B?SzJYY3JDRS9VZkZnMTgyeHlJMDVnelZWcWVONVVRUThRYW5laVRRcUlHTkpV?=
 =?utf-8?B?TEp0by9ObVJzTGdaM0xRZ0U2YXUzZmRBSFFZMkRrL284Z3BCT3ovdTdCZjNr?=
 =?utf-8?B?QUd0SXUranluODM2RXNaYkJxeGRmUy85Q3pEMjRuMGVZVW5UQUgzdkVvcHpD?=
 =?utf-8?B?TG4rMVBjcUNQTkU0dkxmZE55WWNxY29PNkRvMXFCeTRaMHBmUzZHVU9Hb2Zr?=
 =?utf-8?B?MkkrUm5qRFlYS2V5OFc0eHpxOEYwdEhGTDlwK0xUYmd2RkphUHJmaWRJTHBp?=
 =?utf-8?B?OHRrTXYyZ240bFpOSEcwZlFTQWhWZk9WTy9GdStOUlRRSHNESVRDYkpKQ0tT?=
 =?utf-8?B?cmlzNDNLUFJKOE1xdWRrb05jT1Q5dmgrMFVaVGtPczRpWmFRTElST3lmdnBZ?=
 =?utf-8?B?clllaG1NeXFFSks4R1VjdEFuNXFJYTljRHdpeHBkTCtlT1V6ck5kaVUyRGQr?=
 =?utf-8?B?YzZHR2xXdDlHQ0FJWC83Zjd0SzNPbHdrTjlkalk4QmNkZnJTcGN1Q0FPV1dr?=
 =?utf-8?B?alA4UkJMUS9ZUHRYcWFkS08wcjJCajdZOVhjUGNKcWxkYm1mNkJKOFpHMnJC?=
 =?utf-8?B?NzBKSGVCYk8wL2F2QWxndXNacnJHekk0SkRMM3FyRmE1SzdEOHE4aFYzdVRa?=
 =?utf-8?B?ZU1LTDFxZWoyeVh0cEhtMitWSlB1VjlFaTFnUmRJRlpIWmg0b2p2Unp5dEFM?=
 =?utf-8?B?OG1LS3J2OWpIcmJaYmhhNnYrbDh6cENRQjFqUTVVZDN6SEo3Q25PZHcwbGd3?=
 =?utf-8?B?MXI2dFg5U2ZrYVVhUHM0QVN6R3I1ODBNVmo5eVB3dzRTcXdDeGsrRnk5RTR6?=
 =?utf-8?B?cXNuK080VFZUUEMwSGxpRDZvQWdkYzVCNG1qZkYrOHlmc2pvKzNYYks5a3JL?=
 =?utf-8?B?a05UOW5oU2NoQ1h6Q0RWTHE2bWpjT091QWxjNWF6K1lmaUhKTTRkbVZ2aFR5?=
 =?utf-8?B?SndsbGFmODY2YytSc2o4d3hpOTlHbEhlZHp1QzRKS2M5aUJOOHBvNWlxWnB0?=
 =?utf-8?B?aytUUFBxTS90Zy8zcUE1a3lzN2ZoUVowYmtzQWJoUDR2REJNbENXYWJkN3Ar?=
 =?utf-8?B?U2NxZzZ2SjJwcGJoaHlHYjV6NHdlSHpGT2xzd2hPTlBjdzRFQ3pFWUQ1MmMv?=
 =?utf-8?B?djl6MUdpUkxNaVdmMTMvVTBPTDAxcGVZUlJuUGZ5aWlFVnhPcmNwd2p3ME4x?=
 =?utf-8?B?UGN0ZzBWOGErY3RMVzNHOTI5MXBIeWdQaTI1dThXZnBtTkhzVUI0QzljVkg0?=
 =?utf-8?B?NXdOYUpBREdkSVlwV2QyUE5OekhwSWVDaXBrTDVQSjFjR0JkbkNBTFBTMGdn?=
 =?utf-8?B?dkJ4ZUFPS0VBSHhtcHJEVUxaellnUWd6NU5VYWlGVWpPNFBIMHhDUHJrM25y?=
 =?utf-8?B?bkxQai9LN2VVQURGOWZRWmMycDF3djhBY3ZsN1NSeHRhc0MzTUF3MnZtUXJ2?=
 =?utf-8?B?cFBsVUZwdlAxNEkrYUZ3VWpZY3ZHWUNxR0pFQm9HVmlTb2gxdXR1dWRwVnYw?=
 =?utf-8?B?dzgwZjNGQmRNc1IzRzI0bjNOOVI4aWdZYlMxVUpzZlNvd2E0YUlvdnNKYlFD?=
 =?utf-8?B?UkozUlR2VVA4Qnd0R2ZuODBaR1ZHRkxmWjB2OWl3bmV3dG5hTXVGVDNETzFH?=
 =?utf-8?B?Y2d1aS9hT3hSdzFmdTlzRlhrdWdOMHEzbWlQQlg0YW9yMjVwcm1tRE44L0VS?=
 =?utf-8?B?cytFV3lEK2xXdnlQWkdVbDRJNFBLSkp4NTgyY3RDRXJEd3Azd2gvdz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e022e477-fc58-43e5-e277-08deac45f2d1
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 14:35:56.1370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zohwk34G5UCr5C3OMTvwzDWzbj3RDEmOOO/xmY8jz3R3NQkXNMvlaX9hVdt8vIEfThAkX+qps6qcDzRIeEIjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7839
X-Rspamd-Queue-Id: 5CDD24EA57C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244578-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.williamson@nvidia.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netum.fi:email]
X-Rspamd-Action: no action

vfio_pci_dma_buf_move(revoked=true) and vfio_pci_dma_buf_cleanup()
ran the same drain sequence: set priv->revoked, invalidate mappings,
wait for fences, drop the registered kref, wait for completion.
When the VFIO device fd was closed after PCI_COMMAND_MEMORY had been
cleared, both ran in turn -- the second kref_put underflowed and the
subsequent wait_for_completion() blocked on a completion that the
first run had already consumed:

  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
  Call Trace:
   vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
   vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
   vfio_df_close+0x4c/0x80 [vfio]
   vfio_df_group_close+0x36/0x80 [vfio]
   vfio_device_fops_release+0x21/0x40 [vfio]
   __fput+0xe6/0x2b0
   __x64_sys_close+0x3d/0x80

Collapse the duplication: vfio_pci_dma_buf_cleanup() now delegates
the drain to vfio_pci_dma_buf_move(true), which is idempotent for
already-revoked dma-bufs.  cleanup retains only list removal and
the device registration drop; the dma_resv_lock that bracketed
those is dropped along with the in-line drain that required it,
memory_lock continues to protect them.

Re-arm the kref and the completion at the end of move()'s revoke
branch so post-revoke state matches post-creation (kref == 1,
completion ready).  This keeps cleanup's call into move() a no-op
when revoke already ran, and replaces the explicit kref_init() that
the un-revoke branch used to perform for the un-revoke -> remap
path.

Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
Reported-by: Joonas Kylmälä <joonas.kylmala@netum.fi>
Closes: https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Reviewed-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
---

Multiple fixes were proposed[1][2][3] to resolve this issue, thank you
all!  This is the solution the Leon supported, therefore I'm posting it
on its own for a clean reference and visibility.  I'll intend to push
this for v7.1-rc.

[1]https://lore.kernel.org/all/20260416131815.2729131-2-mattev@meta.com
[2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
[3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/

 drivers/vfio/pci/vfio_pci_dmabuf.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
index f87fd32e4a01..fdc22e8b4656 100644
--- a/drivers/vfio/pci/vfio_pci_dmabuf.c
+++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
@@ -354,19 +354,18 @@ void vfio_pci_dma_buf_move(struct vfio_pci_core_device *vdev, bool revoked)
 			if (revoked) {
 				kref_put(&priv->kref, vfio_pci_dma_buf_done);
 				wait_for_completion(&priv->comp);
-			} else {
 				/*
-				 * Kref is initialize again, because when revoke
-				 * was performed the reference counter was decreased
-				 * to zero to trigger completion.
+				 * Re-arm the registered kref reference and the
+				 * completion so the post-revoke state matches the
+				 * post-creation state.  An un-revoke followed by a
+				 * new mapping needs the kref to be non-zero before
+				 * kref_get(), and vfio_pci_dma_buf_cleanup()
+				 * delegates its drain back through this revoke
+				 * path on a possibly-already-revoked dma-buf.
 				 */
 				kref_init(&priv->kref);
-				/*
-				 * There is no need to wait as no mapping was
-				 * performed when the previous status was
-				 * priv->revoked == true.
-				 */
 				reinit_completion(&priv->comp);
+			} else {
 				dma_resv_lock(priv->dmabuf->resv, NULL);
 				priv->revoked = false;
 				dma_resv_unlock(priv->dmabuf->resv);
@@ -382,21 +381,22 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
 	struct vfio_pci_dma_buf *tmp;
 
 	down_write(&vdev->memory_lock);
+
+	/*
+	 * Drain any active mappings via the revoke path.  The move is
+	 * idempotent for dma-bufs already in the revoked state and
+	 * leaves every priv with the kref re-armed and the completion
+	 * ready, so cleanup itself does not need to participate in kref
+	 * bookkeeping.
+	 */
+	vfio_pci_dma_buf_move(vdev, true);
+
 	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
 		if (!get_file_active(&priv->dmabuf->file))
 			continue;
 
-		dma_resv_lock(priv->dmabuf->resv, NULL);
 		list_del_init(&priv->dmabufs_elm);
 		priv->vdev = NULL;
-		priv->revoked = true;
-		dma_buf_invalidate_mappings(priv->dmabuf);
-		dma_resv_wait_timeout(priv->dmabuf->resv,
-				      DMA_RESV_USAGE_BOOKKEEP, false,
-				      MAX_SCHEDULE_TIMEOUT);
-		dma_resv_unlock(priv->dmabuf->resv);
-		kref_put(&priv->kref, vfio_pci_dma_buf_done);
-		wait_for_completion(&priv->comp);
 		vfio_device_put_registration(&vdev->vdev);
 		fput(priv->dmabuf->file);
 	}
-- 
2.51.0


