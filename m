Return-Path: <stable+bounces-245598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA30LXQwA2qN1QEAu9opvQ
	(envelope-from <stable+bounces-245598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:51:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9BB521AE5
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96CA130736FC
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D84B394E96;
	Tue, 12 May 2026 13:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f1E1gGQW"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72182384CC6
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778593490; cv=fail; b=MBYEGxE5yGHUI100pv9aL6SA3LqQX8F9E4+/NfHclVLmZ8ylgOqB/BIuP1PS1JcQCjr/EDJbwxNlKUIq/HOu0tKFa8iple6wEFc5ESf+WmNcTlRzR1hvoXYmgKWsSY0Co0zTa4pqNW3gbSLW6PufBVf/qRR1KRmUHUHepiVEkIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778593490; c=relaxed/simple;
	bh=og6XSQXuU4Qfd+z/AfjRGViB51Ql44g60lb89uYuqfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Pkzazm6V2rto4Q+K9gp5GqxqQaOQ7tHv8JYFq8r+dkLRW9u6Q0Yw8t721Du8jV691sjC7v9FoT+1KrKTaIFeJDV7iF1ZOx9FG8rPmiYACYuS9j9zifVgSGvj8XCUsojQiGpWbIkyLEe3hLAELLtyYz8Q9Iqsy2GK3Cw+CAOkySU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f1E1gGQW; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooG+565Xpfoxau6mTV+ghFZarzvlVn09GsO1SBQE8v4kgV9Seri5qkhSzaSLUjauWlm3WE3duASwytSPBxUPvO47gBQwQn3ZGtd6rKt4agJilX1M3a6brjtpY7ycT1Hc102B+BV3FlLCXXPnRLDrqY2C8Ddth2zoIbHY77gJmZMDGkTnxiR5HNoHfxUqT87NLKLaexbxpQTO3TdCU0cVbaNw1IvACPRcMXafSuzMoeNCmiPm6zHlM8Xtt+swkNO30hvYwdnXurZ05HLuC9DZQhoXh0zJh43th+xT6hKge4qaVFBEGiOAJ8CyzasKE3rQvwra08nxDuHZ/Q6LhI6IiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+PpVBjJhdtwPBgA43dpOd1Yetlje93tbL8IiFi/OtM=;
 b=P+GshJXCEtN6lGVbVe9UTUgFFsjj+HJBZRZNqEvu7i7UJIMZfN8Xs0zML5uXEA1BPtO8QE3XnxAU/lzR6kQpAy6RPsXeXWma3UoQ5NojTG58vUIRUd4vjIYqSR+hsuPNrl2mBBXrHx5ZUO+YYPBt100cBXoqoqePKVarBXFK3Pm0eMq+V34C7loOSqJrgFpcdLpWSWVLWI4fMJ7f0wkrm5uKN5fiAZ/Mm6Ui/VFxo6GLhqZqnwTm8JRn4sd4G3Wg+ugXvJ0lpXTgJtJ3U/a0Aw1J32xdlKzYzryRXT5UcvOlUWcqLfWkT6uk9htTfebMBKoWO/s2v6vUeitsBwN/kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+PpVBjJhdtwPBgA43dpOd1Yetlje93tbL8IiFi/OtM=;
 b=f1E1gGQWW1TrPjh4UAnAvR1eJzFwpASLi/D4KloottMtmkCfWPaYPZrZNnTlkmVdOhq1VVHwxywkT5U1PY+FNZHvpdUoaNaWj3XKKrw3gnHSrCppjKq/Ck/Opz1Z1eUamVFfnVUiUIzM/zGvkJiUrWlcdE9hYuKgurxrLCV6s4wwo4cSwmXaziFjP6wZDUs5qrQFOs3Y2hmkF7DUFaXGMHz9ZRZ5rk1kkwHpPBw93KV6w4CruZH76an6DMz/WBcmkzLwwROs+FUGerjj+D1sJQKidS6c4lx//8/a+d/oVu5RX/iyq/JIIFdfEsESObG2xYrsVCrE1OnYwjnT5jCEUA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY1PR12MB9601.namprd12.prod.outlook.com (2603:10b6:930:107::16)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 13:44:43 +0000
Received: from CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3]) by CY1PR12MB9601.namprd12.prod.outlook.com
 ([fe80::cd76:b497:475f:4de3%5]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 13:44:43 +0000
Date: Tue, 12 May 2026 10:44:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: alex@shazbot.org, kvm@vkger.kernel.org,
	Leon Romanovsky <leon@kernel.org>,
	Kevin Tian <kevin.tian@intel.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>,
	Matt Evans <mattev@meta.com>,
	Joonas =?utf-8?B?S3lsbcOkbMOk?= <joonas.kylmala@netum.fi>,
	stable@vger.kernel.org
Subject: Re: [PATCH] vfio/pci: fix dma-buf kref underflow after revoke
Message-ID: <20260512134442.GB7655@nvidia.com>
References: <20260507143548.1018405-1-alex.williamson@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260507143548.1018405-1-alex.williamson@nvidia.com>
X-ClientProxiedBy: YT4PR01CA0046.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fe::14) To CY1PR12MB9601.namprd12.prod.outlook.com
 (2603:10b6:930:107::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9601:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: c6763944-0ed6-4bd2-4090-08deb02c9f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	IRo+c7KdfldgdN1xKM1EpqvHDOLVgtzOzKoW4mkJZ6dD6n3TET7+ykYoLqRfAq9RKrlxcqZAmAx+s8L3wsMaLMM0O5tWKFKpb02aW0mYo6FBcTHZYFbrgwCQ7pI9lanczrWb+hkMcr0P+Jh2Krtjj7HUSSWWNZm5SQna+7mPVjPHr9ueNMbS2XgA2VvsAzNIMawZT+Pj16zptLJ+RqW6pXrek6D9QJFBLrTTr/Wn6Rz/a//Ee1BvF/oR3Egf9DztSWTb5NkOGCVXZVxKp2hmZ4y+jOqx1tkLxZ5W6DHp+7eQT0wuEymyC033uOYapb7PRtkha/01EcTD2I4OFDyxXr2irCFl484PS7XIkNBum1vhmsLOBo2qIQa/LME78NiqLE7aCV7Rp63eHdiICAh9Lxi84st/ZA23VXBqQAMgpjLivtImcckQXwPYpvYI6RelZpy6WFgH9+31pR1NDMkS5QAeFrbxRd3DttLLXv5kp3pl+JJC4CnoLwxwjA/lIaiuAQ40BzlYYCqOESYfDFDeKS2HDZy1KFTrFTEnNQuDtHe35wYdwOaI7WgAh4QQpMZlRTK9CMkCmMxDP5amMudG9/nJt7feeOaR1+ulLoKTviajSGY2+gWwJzWxQJfb7lJkhOzVewGpOKf5HoLe24HyWFCJJx5hYqCN6R3VOe0vzhy9xZV7SCx/Sv1NJEVTeRYx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9601.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cTBzbXdmbHdSUTl1RUtSSkIzS2dvaHc4WS9rS3l2YlMya3ZYRDVUVEFZQlBu?=
 =?utf-8?B?MGdSTzlDcDlEa3VtWDQ1M1FjOWdRNStsRHdxaU9SbkVsRWNHWnJTV3VEcm5k?=
 =?utf-8?B?MWlxVjBuVHp6UC9XRWVDVnIzVWNFS3hWY0lXV0tuZkp1WmpIOGNRMGZmeGxJ?=
 =?utf-8?B?TUJrY3M4eUFCczcvOUlLS3A3NFNGZ2Z5WmlTUHNpeUQ5WG9NYi94UGpBN2Vy?=
 =?utf-8?B?VkQ2NTFRY2RQVWNOcHY5aGVtY0JGTkluYUc5MDhzS1FlbDhIc0hXRUhMUW5v?=
 =?utf-8?B?eWYvNkZ5dkROVWdpTVpsOUs1UXN2RFd2aU0vZ2IzQVdManNzT3lEWDZMUXc2?=
 =?utf-8?B?L3hRSTJFWk9CckJXZkdWQ0NDNGo1c1NkRHJMdk1ZaTFxM21QVlo0NEF6QjFw?=
 =?utf-8?B?WUU4Z2w4VHhkVXlJUnE1dmVVb2FqYzdWTDAwTWVJMFl0eXkwVkZ5V0FiTjdk?=
 =?utf-8?B?RkI4bEo3clpsblhva2xFK3BKSnhheVQyVlJvM1NLL1lGaHU4MDNPTWtSWk1Q?=
 =?utf-8?B?VHdSVnk5UWNudUx4QUM3OHUyektvSHQ0dDVpbmJ2SUs2OC9QMGp5eDl5NE13?=
 =?utf-8?B?K0t6bGM4OGpDQ2ZrbUtoOWhPMGZ5b0RBb3ZhdjFVcG9pUUZ4QVU3dDEzR2JF?=
 =?utf-8?B?aHRxUnJNSjdqSUhMbzZqb0gxUGwrQ1o4eVU3TUhjWGNFTmlSRFFleEtlaEVy?=
 =?utf-8?B?T0FLdkZzdlJtSGVxWHFuMXhNUkF6M2FoOFhNWFZ3TytxU2ZSa2NWcDFvNXp1?=
 =?utf-8?B?VTZHZlBMY0x3Tkh2U3JxVE1TZjMwWm5SYi8rWm9adFpoeFc5UmZjVTIxcXRX?=
 =?utf-8?B?WEJVcUl5OTNqUnVFeHB3MW8rdm4rU0RUUlpaVGpOMFJQV2JKMk9aTXZkcXBW?=
 =?utf-8?B?UVJjbjlHUmZxTm05N09ydzBnQm9LQjNQazNuVzRoOW40ZVJXUUtUL0dCVlhs?=
 =?utf-8?B?MllrTXpaWVVZbWNvTWlZM3hpSWhFK3hFdUFnY29Jcmtibm9yK2ZlM2pxVkll?=
 =?utf-8?B?WlFjMVVRZCtXVlc2by9KR29sczZRakFDdXVDWndXZEhYaW80ZTR0M3JxaHg5?=
 =?utf-8?B?OTh3eXJKOFZDVm9GcXhrM2FZbHo0YUFBSWRJNmJjQWpkYTZvY0pTcnRBN2Rm?=
 =?utf-8?B?VXVQUnduaUhvVmQwaW5LR3NLaGNrOWdLOVJSclpIOUZaaUhXa3FJeE14TDdn?=
 =?utf-8?B?bUhuZ0I2OXYxWDFzR2dVNW8ycFpGbmdFNGpHcWxwSXRYdzREbHhqQ0JMcjZx?=
 =?utf-8?B?c1psSjZOWE5UQnhramtZSDIrZjdxWDloaEJocldDQ0NJcG5XM2ZyK0loWXZJ?=
 =?utf-8?B?Qlh1ZldDcG9pZ1RMSmV5TFZRT3dyaGlIeFNSNVp2VWZ5Qk4zcmNyd1ZUeTl0?=
 =?utf-8?B?NWh3YjFTVTJ4MERmL09HdHcrVG4wVk1ONDh0NWNmdGNJdjdZN3pPQ3E2MTBG?=
 =?utf-8?B?UGZmbUxmN1hIQXAySXFBbWp1c3BqVDZORDZmUUFWemdhcnFJUFdWVndTTVRZ?=
 =?utf-8?B?VVhuY1pucklrUi9Dekpab0ZyU0hGTmJvM3BRZXlBcXJpTjMrM1FBcVVtbnNN?=
 =?utf-8?B?a0drb0JZUjg4WDZhemdqU3FGZDBia2JITzBCditYMHhSRWJiYUY2TGI1VmRI?=
 =?utf-8?B?cENZUFBRZjVwZmNPM3pDeTJVbjkya201Yko5YlNpeGlZN3BlYmNkOG8wdUdl?=
 =?utf-8?B?dGpKWlhHQVBrZVk3aHlYeTlyOHQxUkp1dGNKTGt4QUYzeUpmTytLMHNIUWFI?=
 =?utf-8?B?cjZETnhEa1A5STUxczJENHkyYktobStEeDllbUZCajhveXlwdU9qeDR2bzFV?=
 =?utf-8?B?dDFLN2JFRm5kbW51N245TmNPLzNaeWlBa1YweDNCeDJScGdKNXdrNncxQkJ0?=
 =?utf-8?B?MnVNNjdoYUdyaFVvWkFyYUJxcjAraWpjYjFzaEI4eEtqdWpLcHBCM3kzSUtu?=
 =?utf-8?B?aTdBQ2h6d1ppcXhVckZETEQ1aDZMQ3UyZUZSMFFmOHdDb1ZMeVhONFpWemdS?=
 =?utf-8?B?QTFOQmtxclM4bnpWWWo0T0Y0UDI5djZESlFzSThWcGJaZTJybG5Yc0dYcCt6?=
 =?utf-8?B?NFRjdXZ4RDc4NENnTjYvRm9BQ3Z6YzBDUGlZdlZ3YUVxUzUzL2pha2hwQWN4?=
 =?utf-8?B?T1AzbTdmMVlWVG1vdGMzVUd1MVhoVlFEQk5vYXJ3b0dSOFpEUEVLWXpONkF1?=
 =?utf-8?B?Um9jSkxjcTlzb28rUWVxb0h0N0tyNGZxd2VQd3BLK0F5YWdDMVM0Q1hsU0F3?=
 =?utf-8?B?SUtsVDlMdE5QZWkwVnZzMk5rNm8yQkVkNHoxVUd5aFdpUFZjM1IzY0phK0gv?=
 =?utf-8?Q?rfNcl7G4+5m9kWuzx3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6763944-0ed6-4bd2-4090-08deb02c9f8f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9601.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 13:44:43.7334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1wECxTFXnQFBICvezyyaJeHdchmbEWHLcryvJdce3I7yLLrno0E949mKnemxKB4q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
X-Rspamd-Queue-Id: 2F9BB521AE5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245598-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@nvidia.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,netum.fi:email]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 08:35:46AM -0600, Alex Williamson wrote:
> vfio_pci_dma_buf_move(revoked=true) and vfio_pci_dma_buf_cleanup()
> ran the same drain sequence: set priv->revoked, invalidate mappings,
> wait for fences, drop the registered kref, wait for completion.
> When the VFIO device fd was closed after PCI_COMMAND_MEMORY had been
> cleared, both ran in turn -- the second kref_put underflowed and the
> subsequent wait_for_completion() blocked on a completion that the
> first run had already consumed:
> 
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x59/0x90
>   Call Trace:
>    vfio_pci_dma_buf_cleanup+0x163/0x168 [vfio_pci_core]
>    vfio_pci_core_close_device+0x67/0xe0 [vfio_pci_core]
>    vfio_df_close+0x4c/0x80 [vfio]
>    vfio_df_group_close+0x36/0x80 [vfio]
>    vfio_device_fops_release+0x21/0x40 [vfio]
>    __fput+0xe6/0x2b0
>    __x64_sys_close+0x3d/0x80
> 
> Collapse the duplication: vfio_pci_dma_buf_cleanup() now delegates
> the drain to vfio_pci_dma_buf_move(true), which is idempotent for
> already-revoked dma-bufs.  cleanup retains only list removal and
> the device registration drop; the dma_resv_lock that bracketed
> those is dropped along with the in-line drain that required it,
> memory_lock continues to protect them.
> 
> Re-arm the kref and the completion at the end of move()'s revoke
> branch so post-revoke state matches post-creation (kref == 1,
> completion ready).  This keeps cleanup's call into move() a no-op
> when revoke already ran, and replaces the explicit kref_init() that
> the un-revoke branch used to perform for the un-revoke -> remap
> path.
> 
> Fixes: 1a8a5227f229 ("vfio: Wait for dma-buf invalidation to complete")
> Reported-by: Joonas Kylmälä <joonas.kylmala@netum.fi>
> Closes: https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-7
> Reviewed-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason

