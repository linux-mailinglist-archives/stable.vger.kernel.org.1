Return-Path: <stable+bounces-123150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D78A5B977
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 07:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06D523A7B60
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1421EE01F;
	Tue, 11 Mar 2025 06:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b="R5sPKmPX"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05olkn2067.outbound.protection.outlook.com [40.92.91.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C61C3C1C
	for <stable@vger.kernel.org>; Tue, 11 Mar 2025 06:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.91.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741676309; cv=fail; b=rvjbUELKx8LWc61D23mM4QiMuPV/aOqvh/XMyxPs/H1Dre+RRXA5PCRY0k9F9fDZoCzJJpx32ZrhnDBdxdG6cyPkmirMqaTs+RAJPYo9rm5Ff+d7U98KaQpQwCrnsLhgCoLgFy0YwxoJvJCweVoukOURSJixZHmGtk0vn9wcreM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741676309; c=relaxed/simple;
	bh=/IAtOHhBIZrdt2xIU5totNom8JUzGCX75qDFzRjR124=;
	h=Date:From:CC:Subject:In-Reply-To:References:Message-ID:
	 Content-Type:MIME-Version; b=Dz+NHqXD92+gsfYRS9ZqqbbzrolAzLm+DYIw3vfrkVZ4UHCGmbdHWsyEq4+l066RJP8DSCYaZHBMo6cB4Vn7g39kfrtJbJXvka8q1gqYOsq25HPjv+mI+niPNat98yNRMPlMJlWUlraabkCc+x5INe3fteGOI1khfdW2ALicR3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk; spf=pass smtp.mailfrom=live.co.uk; dkim=pass (2048-bit key) header.d=LIVE.CO.UK header.i=@LIVE.CO.UK header.b=R5sPKmPX; arc=fail smtp.client-ip=40.92.91.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.co.uk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GCje41PkyUYI8lhhjXS0m4AeXaxNs5f/9qD9GDgnuW9AutUoSo2ljah/f2hhoUFbIYgbuy/xzI0az9oL7O72eqOPEB1xUW+9BuuqCazGPSUyu+lQ1dHrRvVslmwzPuoxvEPlgp8uLeMwa/w41f7h/2EnlSRy+snS7LfjyZb1e6AJQgeA4XuaA/pvJAN57t4mQdXetLDYT6Wp/4lv96oG6ZprgjZSLKAxhF+BDHM3OZTYEtUPqZgG27KIA2rf+C8Rv4qQe4dTx3EDXtrvvTQxHrL/qqK50jGCg62IfCfE0wc4U2KdMf6vxHxRcObvTUFYR+dOSGwlBWC6aD+gB//j7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tdH57fPTbz5C931IBSrorYHQREcIDaFF8HANBjHNY0=;
 b=gXYcFzwRj585MpNTgXWbn2eDN7qLi4OD0spi1JAmqnsR8UmvMcw3DAVjIgSceVm0tXtKNVbQ5DlD76P0mRhpzi8aL5KbABjR44w5xp2i8UOug890AhkrTkHI/l1hvratYtIKnacjE3PpaNUZqMG9TsqMedx9kyD67pcCCs1jyOq7VJ0blU3bZyjSfIxS45t2LkHzAW6ggk68uEGhGGbjuZb8N4W/C+0JBYSWvuJLT8CMeAUKgExTcN51Igt4sLDMUFNyaGhU7fduDQNKzZ+5+A5L9XZalsBmuuKdJ5PwwyIF9ehZUsPPKkaUYSvZ1JZdchb3glwESXBJYi5Ay5Zqsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.CO.UK;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tdH57fPTbz5C931IBSrorYHQREcIDaFF8HANBjHNY0=;
 b=R5sPKmPXWCcBX1HH1oIscR9tqLIHa8rtT9rKHYfOetVk81wE0UkwO9Sn8hxtYv+EXE5nBtdo77X52K/qKll1AUMHAcZynAHs0rgXigVO/uZUqslTNcrHHbzgiOQi1tbr55vw/u7nFFKmuQC9X3XCzRP+fOMMdAREU25ZC5CS9yEVzSvaGdnGns2mgW8Z/HDS80RbMN2mATyGUXhrukBlF+57Q06RqBa5tX/nQQzBT5H65Ny7mwkQz7AHwoeP3M0ZIMAeaPRjTgEqw6qNdqHj9La98ZPJMysImvlrS2CKGTbf3If3sheAlf7GJx40AxtsPraptYXp77VayNBk5D0ayw==
Received: from AM0PR02MB3793.eurprd02.prod.outlook.com (2603:10a6:208:41::14)
 by AS1PR02MB10347.eurprd02.prod.outlook.com (2603:10a6:20b:472::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 06:58:25 +0000
Received: from AM0PR02MB3793.eurprd02.prod.outlook.com
 ([fe80::e01e:5e25:e074:79a0]) by AM0PR02MB3793.eurprd02.prod.outlook.com
 ([fe80::e01e:5e25:e074:79a0%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 06:58:25 +0000
Date: Tue, 11 Mar 2025 06:58:23 +0000
From: Cameron Williams <cang1@live.co.uk>
CC: stable@vger.kernel.org
Subject: Re: [PATCH] parport: Add Brainboxes XC cards.
User-Agent: K-9 Mail for Android
In-Reply-To: <DB7PR02MB38021759513B50CAED9A939BC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
References: <DB7PR02MB38021759513B50CAED9A939BC4D62@DB7PR02MB3802.eurprd02.prod.outlook.com>
Message-ID:
 <AM0PR02MB3793DA7AF377B7525CAD6B1CC4D12@AM0PR02MB3793.eurprd02.prod.outlook.com>
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0662.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::18) To AM0PR02MB3793.eurprd02.prod.outlook.com
 (2603:10a6:208:41::14)
X-Microsoft-Original-Message-ID:
 <E0228E25-8233-416A-B445-C550190C413C@live.co.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR02MB3793:EE_|AS1PR02MB10347:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b5e8c06-02d6-43cc-e8ec-08dd606a1e8c
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|6090799003|19110799003|461199028|8060799006|5072599009|7092599003|15080799006|3412199025|440099028;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHRwTEwySzVQOVNNWjY2WHNBdEp3aUdBMFJHZHdFeWdZOWpPMEI0Ty9sZGNJ?=
 =?utf-8?B?cmRTMTRDTTI4VHpseCtyRzhHbXBVYjJVOGxuYnpiOWRVRXozUlNLTFZQWDRU?=
 =?utf-8?B?WTRWL0gvaFFUOU1lM09YajBzalcwRi9WMTYyVkNEazFxZ09Yc0VaU1ZGN2lq?=
 =?utf-8?B?V3JScUJLeG43bUhETXhGZDl3NmxITm1LR1N0MVQvdGg2NTZpTzd6dmVSRHJ4?=
 =?utf-8?B?cGRaekRlTFVWU3IybVc4MGNoRVNtc3k1elh0dmtGNlBFZnh3NVZwRHhRVWdO?=
 =?utf-8?B?ejU5enc2UzNrcC9lNFFDeVZZYVU3YzUrQzBVREFqYVE1Wm5IMjlYRDc4RE15?=
 =?utf-8?B?OXZEd2tXckt2bE5Lc2dZdDhEcGs4bUJRQ3ZWbUw4cG94UzNoU2FYOFNmRkQx?=
 =?utf-8?B?dThBbmJqb09rTU9oMDFwWk9nVWlST3lwanZtNmtOVHFweEpKa1lRd3QzanFQ?=
 =?utf-8?B?K3NjUnZVS1BtWXFwY083eW5zTURZOU41UlZDc3VrZGo0QUtyU3hBTXFQYUt5?=
 =?utf-8?B?QnFhaEc4aldpUTluSVorR1FmVEp6R09tNmtsWVV2d2lDSTVkbG9VaXJGMGpn?=
 =?utf-8?B?Ukxkakd6WWtpUHRUdDRVWTVVUEJVYUJEaDdLNm1vKzdocS84VkxXY2tzaHBI?=
 =?utf-8?B?Q3h5Y0xnTlIrTXJKLzkxaHdrZjEzOXh4MXE3a1RtKzJGdnl4S2QrNkpDdDNG?=
 =?utf-8?B?THd4dWJzbEh6SGY2SWtTSEZTOTNQVWUvbk5yVlc3Z0daY0hZNWtPbTdYS3kw?=
 =?utf-8?B?dUMrWUxFenNwU2VOa1V0WXJtcS8wU29xOVpPOTlSdEM0NnNmUmQvdER6L21p?=
 =?utf-8?B?aDdhMGZYcWk4K2dPKzlJT053UFppdmtRL3dmdUc0V2hCQUxDVkl6RFc0TnZn?=
 =?utf-8?B?L2Urcml0K0hod2Jsd2lHVXBESjRMTSt5ek5CS1pWMVgrWlJ3SFFsTlNab1c0?=
 =?utf-8?B?VjJEVTlMUmhXdXJTNWMzOWI2S01LMncwU1V5KzNsdFE1ek11Uk9MQ3BqU2tj?=
 =?utf-8?B?Y0Q2QUlnNGxJMk5rMnY3THgvb3pGV3Mvd09sUkg1QVVjY0FRZEFUSUU0KzY1?=
 =?utf-8?B?L2xYcDhyOCtvMTUvWFV0Q1VSbjE4am5WaEczQWtnREJrYmFzM3AwVVVlN3Zs?=
 =?utf-8?B?YXM2U2lOSEFYbHV1cis1a1RqQXhlRFl1b3g1YnBXUGYyNzJuUytnWXNQaWY3?=
 =?utf-8?B?ZzdwdEFLaS9KUzMxbmh1Q29XVkZTTXV2a3JIVG9td3BsRi90Z2VQV0xObExj?=
 =?utf-8?B?MTBBN0t4anpaSThneUVTcFY0YkxkSUZIWWdtZlZoc0FtdDVHVkM3cDJYTVYx?=
 =?utf-8?B?RjA3SW5oQTRCamRKT09xNmd3Z3JnL0dWQWVxOFRJSXp4UkgwQ3I3NktqazlY?=
 =?utf-8?B?Y05YUmh6bDArQ1JHdXkrVHVZdFZRQitQeGJvOHlEd05wSEs3REI4TnBpMVVX?=
 =?utf-8?B?RS9SYzkxYkczYU9NS3IwWWlJQ29yamJ1K3IzWTBsenYxT1JTSlJHc3Jveksw?=
 =?utf-8?Q?iVBEEo=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L2ExTkQ3M0p0UC9ZZmh4SzJXbS9EL3ptSTZ2cmZjYXBjb0VCcEk0Tnl0elBl?=
 =?utf-8?B?cGF5dFVWRnFsZ0xLaG1KQjhkMFc4M0ltYnd5Tm5jcU5GRU80N2lzcmJ1UFF4?=
 =?utf-8?B?eFY4NUwxVVZnVE9RMVBsMDlseHppTGVTeTNOSlVPajZKd2hGQWNqOGM4Q004?=
 =?utf-8?B?UHU4cm9CNFZwM2I0ZXAwaUR2bVNMTndNdUVMYkFESk1uZ3ZxVUIyUDA3Z3d3?=
 =?utf-8?B?UnVvUlMzZXJBbjZ3czViaHZSTnFyVUFwbWltNFdUZ2NqTk5yNVhHWXVKSk1O?=
 =?utf-8?B?TDc0YVFiUlUvbkR5WSt6ekczcDJyNFZENnhTUjM0Q0ltM29LbGhBVGpLdENz?=
 =?utf-8?B?NlRrMzVlOFpFRVJvMlkyaXRQTEw0REhmdzN1V3l6a2h5S2xlRVErdUtNall6?=
 =?utf-8?B?V3prU3ZpcVA2SFlEejNFWEcxN0FSSDZzZnhkd3UrWThoOGVsNmNITW5GRWlP?=
 =?utf-8?B?VjFmWld0eVBkYjJGQldEb0VHOGpydTg2NzJ1NjVzUTNyQk9VSm1ubXA2YUJ3?=
 =?utf-8?B?Y1phZ0hpS29vMEtNV05RQmh4VFVaVUlaUHhIRGl3aUVlM0wySDdWOUhhZG1S?=
 =?utf-8?B?azF6V1dIbzRlVHRsUUN1MWFHUnBzYUw0ZC9yUHlUR2xvVkxJTWg0QUQyZTV4?=
 =?utf-8?B?T1FmZXMwRG56NTlHQVp0UndZa2ErdHgzVnJzT1hiR1VJRzVJVWVMc3ZoQ3pz?=
 =?utf-8?B?d0VxS2Ryb2VWTXNtdHZpOWE2d1FTbmhOOW1hSXRGbnVTUjJqMDN6bGYxYSsy?=
 =?utf-8?B?UDliVEx4YS80bmovaEc2ankxc05iT0wxQW53KzVvYzN1NVlGWWZOc0o4czRQ?=
 =?utf-8?B?WXBDYzRSb2tBU2hiRTZUL0wxeHovd0VVc0xxTVFOVUlQeGVqWUM4aUJneHE4?=
 =?utf-8?B?SUZ4bmRkNE8zdVFJNTJpSnhUbmVWcklYZkIwRFVNd0lIeEk4ZU9Sc2FSSW0w?=
 =?utf-8?B?VlJTUG8zVzd4azRXOGRJOVhjU0lLVWhBK2U5L0lyNktkMG5Xa3cyQU5YK0R2?=
 =?utf-8?B?eVJ3em0wWkJ0MUY1NTdNaUhkU3g3NVJ1RHkwbUN4ZTZGdG1YVE9Cbis2emxI?=
 =?utf-8?B?Y1F5YU9XNkxxRXZManFHWmNNUE9JU3p4OFJRRmc3VkRrVDBWRVg1eVp5a0Mz?=
 =?utf-8?B?U1hkWkVXOFgyK29lRGFsK1FCNUZaamVPTUt4L2g3SEt5bXRHTlpxNmdrSmFz?=
 =?utf-8?B?NjF0OER0S2xCZWY2RSt2VGcwc0I3UkgyOU5RcS9Va0g5dmlzMDFINU9YYXpT?=
 =?utf-8?B?VXN2bDZEQXJyM3JSSWs3RFlqaCszdy9rVW12dmtaclZEK3FVcVc3dmFkYzU4?=
 =?utf-8?B?Mm43eldVMHp1OW1Tb1NDV01sUEFua05ZRWF0bm9jTEVnWC9JU1NHaXArT2tM?=
 =?utf-8?B?MkpleDRFY3JZcWZuTko3RUdXSkZTSWkvUW14aDVlc0tIWUg4UnoxZm9XSEQ3?=
 =?utf-8?B?T2NFT0Q2cmFaUURqNG9qRWlpalptWTZJVUtNSVFYV2RpN1pmaWlmUjNhT0Q2?=
 =?utf-8?B?eWJVdkJoWE00c2dUOTVQQlNOWkZhbjdlSlFiS2p0ZVAxVnEvQURoYkVqUndO?=
 =?utf-8?B?UFRJZjl4RWZLMUdQUnoyTVNoQmFoSGwvWERZZ2hycncrc0NnUzJadFNKQ2E0?=
 =?utf-8?Q?sRL2FBLuMjLHf69lMso4bkfMsKtiKQoYCjxF+Y0uQBsg=3D?=
X-OriginatorOrg: sct-15-20-7828-19-msonline-outlook-12d23.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5e8c06-02d6-43cc-e8ec-08dd606a1e8c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR02MB3793.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 06:58:25.4177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR02MB10347

Cc'ing stable

Cc: stable@vger.kernel.org

On 10 March 2025 22:25:08 GMT, Cameron Williams <cang1@live.co.uk> wrote:
>Add ExpressCard parport cards.
>
>Signed-off-by: Cameron Williams <cang1@live.co.uk>
>---
> drivers/parport/parport_pc.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/parport/parport_pc.c b/drivers/parport/parport_pc.c
>index f33b5d1dd..787e894bb 100644
>--- a/drivers/parport/parport_pc.c
>+++ b/drivers/parport/parport_pc.c
>@@ -2854,6 +2854,12 @@ static const struct pci_device_id parport_pc_pci_tb=
l[] =3D {
> 	/* Brainboxes PX-475 */
> 	{ PCI_VENDOR_ID_INTASHIELD, 0x401f,
> 	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
>+	/* Brainboxes XC-157 */
>+	{ PCI_VENDOR_ID_INTASHIELD, 0x4020,
>+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
>+	/* Brainboxes XC-475 */
>+	{ PCI_VENDOR_ID_INTASHIELD, 0x4022,
>+	  PCI_ANY_ID, PCI_ANY_ID, 0, 0, oxsemi_pcie_pport },
> 	{ 0, } /* terminate list */
> };
> MODULE_DEVICE_TABLE(pci, parport_pc_pci_tbl);

