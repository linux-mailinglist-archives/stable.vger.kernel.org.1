Return-Path: <stable+bounces-219134-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGKtDgBfnmmaUwQAu9opvQ
	(envelope-from <stable+bounces-219134-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:31:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD586190E8E
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12C1830D6F71
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD15626F46F;
	Wed, 25 Feb 2026 02:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QLVrjOoE"
X-Original-To: stable@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010037.outbound.protection.outlook.com [40.93.198.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E30E22B8A6
	for <stable@vger.kernel.org>; Wed, 25 Feb 2026 02:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771986673; cv=fail; b=giXX2upYjBhF1l+w7XahP6n0EFgdhtu8F/ZGGmaCrZ0xm4Ye7XUgK5kmn+fPPRw4La3+b5ZL/6ITMss6pynQeqBGVvQSheGKU8GibYET5Yi58D6iXGUoj64hUIOboF4Wh6PXPwbF3dLjK48UATNVZ3B7jJTrumyKJrc0uLKfjmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771986673; c=relaxed/simple;
	bh=j1uCfvTRJCOHW0/4wFcDZmRsD7dsqsjgC9mmZtLRPrw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r+Mf2iFcYScCAP75vq67/m87/KCkPJp6IsNQs/p1KnPWcTk/K7biI/1Zdj0skLgKEftI4ouoAj/tHUoaYeBey1LuzYMx0r23+efFb8uGwMVKarcTipKhGbIlYufRFIhhrcpsurOitn73/KD3/FJLZv8vTRHCHS/7QLY7tT1D4kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QLVrjOoE; arc=fail smtp.client-ip=40.93.198.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hggJESnkscp7di+zPQhxqGreN7yqcEnZrFMle0LxEcl3ZR7poYySaSNVycYS7wFjjOjePAfiUHBKbjVIMWQxGu+XinyULBzM6TUAIq8oheBS4j7tG0F3cCH9GXawgFzxLBu7nHHgt4BkzRAxTx1Vkb71XasGl9niIvBX6O6qzt27S1L9mZqwg4tZEap5isc2hYZKOC+zP/xmqB2DaaonQF/N5XkBZbxNLnmaJcfqAwuiod3xDtUH0M74Tpyw67UA/mGrAOZNGnFO92ypSPjN+5LwbbN75jUkaO5FIqgmgM1MPhyULs5SFBpmkygXAU92bwp1yCWOJt9FEtQZR1A98g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PCa75y1EtcG9owDS8dV6qTZNAGjRqfmfccET1TH8kwI=;
 b=d1ii9jCMyppk+7nJADehve+fxKNwZL7nk9mvexuZqaYJrAF+KHRqtLE2reVOBvkowIHzxlBD8b9FyEUZ+wIVZryT5nLjol67fW1PfX5yMjtZG/aoBdKnAg5WAKpKxFlm8z0Il1jJ5xrhkVMEKOQML+CQOV2yNcDXdL5PXrxgMVNnTcgu5O/YWUwTxx8QEtkb8RR4UjYZl+w8YqlApvlley8QHRxuy6LfkO1NXADC2Y8GRdLVvSkaYfKRA/bVRa4DaJZMRZk9yAyyVg6sLasOCPZTlO3u/ItXiz20CkliVU9R9BsyjfN3oXtlMSmWEK5Y9bA+dcgV8T9iCRoHFRwIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCa75y1EtcG9owDS8dV6qTZNAGjRqfmfccET1TH8kwI=;
 b=QLVrjOoEFUHMxb1BdlKUO3RtvRmXvsexjuJIulNCfMI1FavOrld2p6RbzeFDygwzvHC4prK6/qSD6hGOrAfkLqGTzq8MthzuQbP1xTdUxpdtgtWmrSiyJqQhlvpdI0R7A3Qj+MxpdwHFULzxSFblXo3UO0v+zhKMfYKU2c69tx0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 02:31:08 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 02:31:08 +0000
Message-ID: <c6996c83-db35-4f2c-b11d-dbb4eaeb7269@amd.com>
Date: Tue, 24 Feb 2026 20:31:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: A few HDMI fixes for 6.18.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Pananchikkal, Renjith" <Renjith.Pananchikkal@amd.com>
References: <2525eb93-1515-4213-ba81-6d654c5db2ee@amd.com>
 <2026022401-fondness-unburned-7a44@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2026022401-fondness-unburned-7a44@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0225.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::20) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 1537a1df-7e6a-4113-cb22-08de7415eebf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2lIQ29lc1p0SVhMMVduZTduSDY5T013ckIwL0FYMEpSZEZic3ZWTWJSNUtq?=
 =?utf-8?B?MW14cE5lOXZiNTNsQUF0K0pmMjdhWHlBNEhYZUI2R1pwamNkZzlOZEJYZ216?=
 =?utf-8?B?NlVreXVYMHo2ZnJFaWxuQkJ6bkRQblhmODlWcjNmQ3NqcjFLREdZRE00WjZY?=
 =?utf-8?B?T3BDb0gxMHIrNW04aXZIUFJjK0ZyV3JtbFJPNXZQTGNhNVdYQkdseS8vU0Zv?=
 =?utf-8?B?YWJsRmNXemt4ZU9yencxVThUVldqYmtwRDBJTG5ZMVRKQTN6OUtlL0tHQzlk?=
 =?utf-8?B?OWhTZUdZMzhHNlFRVU9rU0VYU1VjQkd5bm5SWVN3czY4eUo3NlFOTVZTWU1K?=
 =?utf-8?B?N0VkQ01qTmFYSi9HMHYwMDRwcVFsbHBXYVV5dmtVWG85aitCMEhRU09KMWJW?=
 =?utf-8?B?Tm02dlV2TW0rL0FzQ1ZpeXRtM05iUnhwTEJGQnFNb1pkdEFxZXUrR2I3Qzlk?=
 =?utf-8?B?eG5vOG1LYjRTWU1XZitQeldVd25RclMvd0l5d0ZYS2VqWVBMMGk5NW5DbDQy?=
 =?utf-8?B?U0VVZFZUYmFSR0xsenRNeTd2YklzN2wwWXIwSjllUGVnd2VqMGpTZ2FvRE1B?=
 =?utf-8?B?ckpBRHlvU0xvMlArTkEzTDE5Um9MQU5LeHhqc1RkQ2hQNEcrdVhadWtJeVFm?=
 =?utf-8?B?Umt1OFE1dXFUT3ZQUDczK2Via3R5OG5kZE8wbW5MRHdjMG1saWozSGNXdWI4?=
 =?utf-8?B?VkRHYXV0bllYV1ZQY250RFpDaWVucytZWmI3dGI5UG5qcWk5YnFGYVBTWnBl?=
 =?utf-8?B?dk5ZMC96WmJneXNjbWpKMTRwbmdCcUpxUTJ0dXhxWUhNVExpNWljdFViOU0z?=
 =?utf-8?B?NktpMDZUckxRK1N0K2t0RlRlRHV1YUxyWTdyODhwU0llL21SdGdON0Z2RkJR?=
 =?utf-8?B?SFBUcDAvcXRJeWhRMEZjeWlWNTI5V253Zjh2N0UrK1J5ak1KbmM1MWpMSnVa?=
 =?utf-8?B?ZGJjZkxtczhVcm94OTE4Q3lJdkZicmNBQjQ1WmNOQzJEdzkrV1pybmlFQlVT?=
 =?utf-8?B?bEFjM3dFTG1OVldmWHBtZXZkR1RWS1B5elBYYXFVNm40RUxvNG9ad0pDYmw0?=
 =?utf-8?B?UHZUZjEwNjZYbnF2akFqeStsZUNJNWRrMWV2bHVoUU1GaVA4ZDVwem1hMkRq?=
 =?utf-8?B?YVY2ZzdNYkhkVlZCS2NwdFRPTVVyMUFIdFFtQkpFSWJLVFhEd01YYktrc2t6?=
 =?utf-8?B?UGpCRzN3QjE1ay9GanZTUWVhcW1vRWFTOEo4azZRamEzdTNwdHpNTTgyY1h6?=
 =?utf-8?B?TXMwZmhYS2hwTE4rMkg1UkIrK0w2d3hpMlFPL2R0d2l3V1lmYmJsclR2djcv?=
 =?utf-8?B?ZzhvOW1VSUVqMExQbHFvTDVxS2VWT0ptaVEzMzRLQTFEMzM2TEEvM1NYOGp2?=
 =?utf-8?B?dDlSK3JyUFVpbDg4ZVNlZFZYSlp3dzhWNDNyNVNIT0RJUXJjcUU1Nk1YN1dm?=
 =?utf-8?B?cG1LS2RIT3JpZ2VSSGNSRWRqRG80eE0rUloyY3k3N09UdW9manpSV0s3cjA2?=
 =?utf-8?B?TXVtRmlGS0tGOWJ4bzAzWVRrdHM3UlpNYitIazIydmI3TGNzZzNsL2c1d1Fo?=
 =?utf-8?B?enRWc29IM1V3SGpnS3ZjUE9KVE5JVzJmakZBK0FVbmF2ejJvTDJlVy9VZE1y?=
 =?utf-8?B?VmdwMlFmVkZSUVd5U0RSb2lUNU9vVFBRZngrS0h4L2Rkd096YldiY2k0azBz?=
 =?utf-8?B?QlRMMVJ4VHNHcDdIeVN1WHNRa1pnZ0tKTS9YUSsyMUdXZjRMc3dMUUJueXRw?=
 =?utf-8?B?aDdMZzkxNGh3NzNCbnU4UGEwQzVWTUM5T0F6dUFTSk8rL3Z6d0JWYzFSSmd5?=
 =?utf-8?B?SHY5aGFjbnhJN254aFlKREdTUWR4cWNnQlYwbEVibktYYXlBcG5OMWoyTDhB?=
 =?utf-8?B?U2J4MlFBbWo2SWdzUndxRWFocHZIZXYrYmxTVXlKbnhPcVl3OS9ucVFMNDdI?=
 =?utf-8?B?WVYxN1M0cU1MVlBFNEdCKysySWNmK0lxMDRCN0ZQL0ZFTFl5L3h3WjhKcmJU?=
 =?utf-8?B?MDdTSUxMUmhTM1hiamtqT0V2ZUd0Y29pa1ltQmdPTmVBdW1VdnRqekpNVkRX?=
 =?utf-8?B?RmQxWW1kRmsydWxMeVNHWEFaalA3YTlVUWpOTE4yVFhwdDhhdXhKMEk5OVAz?=
 =?utf-8?Q?mcf4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnNkamdWS01QMjRIUlN3c2MrU3RTN3R5QjhZQVljSTR0VllyUVY3Z0EycEtv?=
 =?utf-8?B?SSs4RFllN2xrWlRsNkw0YnBGMjkvQUVsTW5WQllvbjFDQ2ErdTQ2cWNpUEx3?=
 =?utf-8?B?d0pxelgvTWlvOUQwWThpNWt1THIxL096SjBTZGl3QmtSc3Z4RHJDYkphZ0wy?=
 =?utf-8?B?OW9OSy9NWEQrcXM2dVIwWU5pa2lHcG5uQU5aR2ZGeXU1T0JLTm1oejZxTWcw?=
 =?utf-8?B?djJ0dWU0MmlncEJXS0FhQnNCeDRubm4zdTIwbkZHS3RpdkQ1Z3ZOenh4c3Z6?=
 =?utf-8?B?N0NGMExZdkNrVmIrNnpEaEZXUW0vQUx6YWtHOEFGUS9qS2U1Tm50ZFl2dGN5?=
 =?utf-8?B?UUozemN3NWxJaVFsZXZkckg2TGd5dmRsS3hvcG0xWVBlc1JMekZIZ0NLSG4y?=
 =?utf-8?B?V2FrTjlyYW1wZTlUUWpZeHZiOCtYZ1lzOVpVV1RmT2JtWnN6aXAydThFRXBh?=
 =?utf-8?B?ejRSTFhENmFQNUxoa0c4bDFQUEZUWlFORkNGeDNpUVVZQ2tCS29NRjZwQkgr?=
 =?utf-8?B?M2FZQVhSazNSRWVkR0JZM1o5bnNMOHJjZ2VMTmNsMDl5NTVpMnJJR2xqNXV1?=
 =?utf-8?B?QndzT0dyeVptUklPRHl0UjZiMVJoUCswd3ErY25PbmpwSEtNa0FPYUs3d1Z0?=
 =?utf-8?B?SHhCYWNEU1JWMFBjOCtYbVh2dzRETW9SbDA5bU5hbXIwMjlBQnl4NjM0K2h3?=
 =?utf-8?B?UzVvL3F4ZEJOb2tWVkpGVWRqYjBkWThRNHMwZ2RZMnNWYUIzZ1V2eHR3QSsv?=
 =?utf-8?B?M05UZW11QUtSU1htNWY2RWNudFNZcERGbDFlVXMwQ0NLcjgxUXpTSUJRZkdx?=
 =?utf-8?B?dzRSNWtRdzRHSDBkQ1E1b003OHJoMldhM2lQZ1VYcmVPSkhWVk0zVyt6cVBB?=
 =?utf-8?B?OFg1bFd2WWwva1JyRDhnYlNDS0MyMHBtRHhLZlN5RnNYVHhna1VzTE10RmxO?=
 =?utf-8?B?R2o0WHlVd2FmcVRpLzRhVitxYVppM0h5cUMrUUFzS09rMy9DcURqNFVlWlVQ?=
 =?utf-8?B?QlVtcFY4SW9yK3k4UUJOQmN3RzlLTDdWRlIwK1p3V0V2dTlFTWo4UGpST1Yv?=
 =?utf-8?B?bG9WaTRWV0Q0YU9qMUVYSUhYNkZGUXRPWFJuTjd2SDJkd3MwTmdHY241Z3hh?=
 =?utf-8?B?c0FJRXNQdThDSUNiRVVheHRsUkZOaVFxTnFtWHZyQlAzR3poQVFFMjNpS3cx?=
 =?utf-8?B?Vko3VDBLRVZrZXg3b0thd3FCMWhKSnJVNHdIZGpJWmdxalpXeVd4eHo0MXFP?=
 =?utf-8?B?c0t3SnRwMXUwbVhUdndoWjBPN1ljM0o2VWExZW1Zb1BDVXVVSEo3UkoxYVdj?=
 =?utf-8?B?cjhTWG9iSjZCOGpZNlVLdngxSHB0bUZVcE9DTERlWDNsMTQ5MXpRTW90MDNB?=
 =?utf-8?B?Z0xSTC93c2dMaDFOcUJBOGpVR3hvUmtrVkFlYVpBNnZYRDVNV1VyN2xSWWZz?=
 =?utf-8?B?V2NrTTZuaXJ4enVCSjVQL3hyRVVWMFEyVWFtNXZCNzBhc1dWYmVtQW54MFdZ?=
 =?utf-8?B?a2w1WEE5QzZmclJNcWUyb1ZsNk1ib01EVDRVR3hxdy9rSXN3OUViKzJIRmNE?=
 =?utf-8?B?VjFVRzVHVDFVUlovaDV3Zlc4MXYwaFhmWktKbDlJV3h1blhDeVJVdlJTYlht?=
 =?utf-8?B?bDliNFFRWm5haGJ0TGpBdlpka00ramVqbGo1SnNhbS9oTVRxM0JKTHEzWFJJ?=
 =?utf-8?B?cVgrKzZXemlDbFlzRXB6d1lIUi81a3FVUThTUXRvaDJGKzcvQ254UkVDMk9Y?=
 =?utf-8?B?N005MndkdnE4b2l3NlppKytWTGVCNWJwZnNCaUx6YzBOOC9HSVJVa2V6VS9Q?=
 =?utf-8?B?NFVUNGViZExWSEgweXdESjB3Zk5UTEpnanhoWFUxU1JueUdTOVZMWUhjS1R1?=
 =?utf-8?B?RFg0RitVdFVQMFluREdSNDIxa3hhajgxZFBQcFE4Szc1NE0zUjY3L3NzSUha?=
 =?utf-8?B?WDZtbnltcnRHc1pQUjhJMHlMNi9oZjdVYnFPenZ5MkJZSThsc05rWTA5N2pE?=
 =?utf-8?B?QnJGNlZraVpDeFR6SlZKeUx4L010QThXQ2hKeTcvNDViWTNNUmMrQVRVcUU5?=
 =?utf-8?B?dlJYRUd4ZXhLbGowbHVVMG1xcndpSUVRTUx3SExXZU8zUTAwa0NqSFZOaTVB?=
 =?utf-8?B?R3dhck4ra1FxYmlFMDc2UVZjd2c4UER3RXd5UFV2MGtnZnJJSUJYY2Fzdkxy?=
 =?utf-8?B?anVZeFBoR0VCMTI0T2p0Witxb21kaFpYS1N4ZHZvTEdKRWpudlBOdVQ3dFRO?=
 =?utf-8?B?YmwzVHVlYmpXUkZySjJkNldYMUpkTXlrTjFrN1B6ZElZaTRUTjRwMzhIL1Zp?=
 =?utf-8?B?ckNGdStOOWM5MUZNbkw3YzNWeFpETllUSkxialc5U1J4eEl4R0NhQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1537a1df-7e6a-4113-cb22-08de7415eebf
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 02:31:08.3208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW1zgheQf5j9v7pAYVQfaoiSQe+FLL6swFIG5PYryDjAu/9MVYUveXExqGM4j65b5Elsv5TGRguorfCYYNCi0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[amd.com:+];
	TAGGED_FROM(0.00)[bounces-219134-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mario.limonciello@amd.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BD586190E8E
X-Rspamd-Action: no action



On 2/24/2026 6:56 PM, Greg KH wrote:
> On Mon, Feb 23, 2026 at 02:04:05PM -0600, Mario Limonciello wrote:
>> Hi,
>>
>> There was a commit in 6.18 that caused a problem:
>> c918e75e1ed9 ("drm/amd/display: Add an HPD filter for HDMI")
>>
>> This has been fixed by these commits:
>> commit 6a681cd90345 ("drm/amd/display: Add an hdmi_hpd_debounce_delay_ms
>> module")
>> commit 17b2c526fd80 ("drm/amd/display: Clear HDMI HPD pending work only if
>> it is enabled")
>>
>> Can we please bring to 6.18.y and 6.19.y?
> 
> These only apply to 6.18.y, but not 6.19.y, so can you provide a working
> backport for both?
> 

It looks like 6.19.y already picked them up!

❯ git checkout linux-6.19.y
❯ git cherry-pick -x 6a681cd90345
Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu.h
Auto-merging drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
On branch linux-6.19.y
Your branch is up to date with 'origin/linux-6.19.y'.

You are currently cherry-picking commit 6a681cd90345.
   (all conflicts fixed: run "git cherry-pick --continue")
   (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)

nothing to commit, working tree clean
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

     git commit --allow-empty

Otherwise, please use 'git cherry-pick --skip'
❯ git cherry-pick --skip
❯ git cherry-pick -x 17b2c526fd80
Auto-merging drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
On branch linux-6.19.y
Your branch is up to date with 'origin/linux-6.19.y'.

You are currently cherry-picking commit 17b2c526fd80.
   (all conflicts fixed: run "git cherry-pick --continue")
   (use "git cherry-pick --skip" to skip this patch)
   (use "git cherry-pick --abort" to cancel the cherry-pick operation)

nothing to commit, working tree clean
The previous cherry-pick is now empty, possibly due to conflict resolution.
If you wish to commit it anyway, use:

     git commit --allow-empty

Otherwise, please use 'git cherry-pick --skip'
❯ git cherry-pick --skip

