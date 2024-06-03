Return-Path: <stable+bounces-47873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D18BC8D8511
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 16:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBA1B25915
	for <lists+stable@lfdr.de>; Mon,  3 Jun 2024 14:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7D5D757E0;
	Mon,  3 Jun 2024 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PDAx90oo"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2064.outbound.protection.outlook.com [40.107.244.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FBA82D8E
	for <stable@vger.kernel.org>; Mon,  3 Jun 2024 14:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425101; cv=fail; b=pVppNqk+ciidRbVziy1HW4cgNrKl+t8m6NJ+zSiFFpHxtGgwLg0LaMF+psJvddGMJ0OdZbKLdeZTP/Gg6QharYn7GTDogg+r7d1TgqZJEADILS6SHkUkTK4CZqfia+FZ29kZR7tbL4I/6AJ5CDZPcefei5fzSG9fc37Z9h4Vtp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425101; c=relaxed/simple;
	bh=NUEpdyHPh/IrKoWfeGRDzy1hIXwstxr9pe93wdqCjj4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D/ccQFJA6me+Ah43JbeRBknAJ2L2ez5ejnCh2CksrDu/82ttAI6NitfFB1HEard7gfdusXIQeL6C+5Otx3YwRvI+9Wr3kU5BO3mJnm+D89r0cEyQBgkOfzZr7ZduCQ6LbSEehAFUcDlBbJpSBuz1waPoiFFRTwvsvQbtC0iw1Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PDAx90oo; arc=fail smtp.client-ip=40.107.244.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2Jc+8WfjyLaNtlPKh0yKUAQEfC2fgVz8JyN/v1t/KJ9n94sNzjOSLuGR1L37+bRL2aSzdimBgvkiyyzzCu8gGobIi+OX4KuJieP7XokvNFxRtu8gftMzOyYIXa/aFTyEbKbjYMvA/eAyzAoFqpOFK8bZoYBD0gdYDD3+4l3sdYZSLLsGerrTt46LvuS+pWq9KD11z22H6wbCfaV9l1bwGUoSkV9BOzcU33o51qZWYymUoOH/x7vfRLAbYIDfDiK4SuM2bfWFGmTiOBP5BfzD0Z0RHtaGWaikwBMa940HHtGlg4Utc6jWOP3EZBPRn6DC349Utkvq+H2BxN7WEZO3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUEpdyHPh/IrKoWfeGRDzy1hIXwstxr9pe93wdqCjj4=;
 b=dUs//8Xjd6dn1hG8Acx+wU2GIyVMRWLT8L+T6+maTZJpun4v0uObBIgYix0+hjHnDCzPJpae+N7ACiQWajvYVw5B/qjIAGJ0bmXbTpcNITty9BlZNC2IQC4nttzlAG8niSKiiS6D8vjjj1r9HOKI5/O0OOTBHeAngoIbbE/lET+0OVX+aniXN/vl4qEOInu5F8n7e0XfBxM4u5jqDSOilO3WJlb7veFN1K7bFRMIoogc97MB2SmfvFfEVDGaYtIyxR+vCJOEc3QLZ8H/fVhN9FmMute8jfGs4PuB+Q58r8ze92vX4BB7XU1nn/MoxzsejF1Lpa8BUEBadK0hSwqeSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUEpdyHPh/IrKoWfeGRDzy1hIXwstxr9pe93wdqCjj4=;
 b=PDAx90oo9g2teYMeNzU/v6vxetPSZpuIDcH4NEFBQjRejnS9GVmEsz8mLc6vGPT+mtrP4PAlXXtP1HGp923UPaXuJSvYF1rTHdiaQSmPLNYHszSCRj3PYA5yMw94Z2GNk9VVed/DAZ0I97ThgmB/Zh6emKj1J0Cz4/IN5oO9NRc=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Mon, 3 Jun
 2024 14:31:27 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 14:31:27 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>, "sashal@kernel.org"
	<sashal@kernel.org>, "Yu, Lang" <Lang.Yu@amd.com>,
	=?utf-8?B?VG9tw6HFoSBUcm5rYQ==?= <trnka@scm.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
Subject: RE: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
Thread-Topic: [PATCH] drm/amdkfd: handle duplicate BOs in
 reserve_bo_and_cond_vms
Thread-Index: AQHas2VpAAnaYA54dUCus4EoStbEd7GyYRQAgAO9YdA=
Date: Mon, 3 Jun 2024 14:31:27 +0000
Message-ID:
 <BL1PR12MB5144EA4E60894AEDF352D61FF7FF2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240531141807.3501061-1-alexander.deucher@amd.com>
 <2024060148-monopoly-broiler-1e11@gregkh>
In-Reply-To: <2024060148-monopoly-broiler-1e11@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=4c308ba0-dd0f-428a-ba19-09917553c3de;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-06-03T14:30:57Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|LV3PR12MB9234:EE_
x-ms-office365-filtering-correlation-id: 4ad17bf6-ce37-49fb-0ee3-08dc83d9da2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?Q2FnUm9RMitwNTErWEhXZm50bkxxL1VDT0h1ZTBHd0UwcGNLZVlNREp2ZzNZ?=
 =?utf-8?B?VFBoTXB1Tmtnd0NSYWZFUDV1V0ZjT2dTSmg2RFl3SnlqUCtINkZieHFzSTRF?=
 =?utf-8?B?SVdsa1lVUWdPL2tWUkcyaFZVV1ExdUtnOUF0cnV3TnkyTEtXY01mbFBYTGI4?=
 =?utf-8?B?akN4eXQ4ZlJOQXRKdUYwai9Ha3NuQng4RlI3VE1ubjI3dHEvVXdaYlljRHNY?=
 =?utf-8?B?UVBFckxFU2o5ZFE0VFJBMWlMUnZLOHEremgvdFp5U1FiOHplSVRkVFhXV0tH?=
 =?utf-8?B?MSt0VUhjVVpjcXlZNEtTNk5RT3pueWJpQUUreFBFWHhTM0Y1bmpJUE1IaHh2?=
 =?utf-8?B?VWRST3ZGZU4xUXU0MFQ2RlR4L2Vnc0RzT1A5aTJmSUNpN2F3eTlGUDZITUVJ?=
 =?utf-8?B?M3FQUnk2dGRQY01vdGw4NWIrWmlrMUhQWGp4QjFtR2hOb0psVWl4ZFViSlpZ?=
 =?utf-8?B?ZjlCMHc1b2M1TGtyclBLZXRrTG8zM282ZVkrbldQQU9UQnZ4bGFtN1F4am1u?=
 =?utf-8?B?cUwwRXhmbVY2YmpCQjNPd3N0OTNGejB2TXB1Q0M4Q2N2TnNJSVZ4YkxnVGNO?=
 =?utf-8?B?aVlvS080OWVEQnJtUmt0UXVLSWlmLy9PcWNYd1VFdFB6a003eUticlZjUVhR?=
 =?utf-8?B?d3NuNXQ5OEFjNkFCdjJxbm1URUFPdWU1NEtidDlWVmkvWVVpRklKSUhqUFFr?=
 =?utf-8?B?K3dLcm54ZmRUTWFQZ09mSmt5RG1BOFpVcmh6VktoTXhFMnE1V3RSaUN3d29E?=
 =?utf-8?B?RGhyM3ZENUhBbFR3WE10a0hwNVBDd3JQRGkrbHZ1Mk5aeXllMkR3bHBhcmcz?=
 =?utf-8?B?dEcxdTNpN3VYdm1XWVFnaEtRQkZISmJTYWQvcnYvc1F2c3BSMU15ZlBvVDA1?=
 =?utf-8?B?ckw4K2p0YytLWnV6bDFvQkRpQW9HR2tLUEFXenE1eHVLRlV6d3RtSGwxVW1z?=
 =?utf-8?B?OU1XRDhWWWlPNGlpRk00MSt4SmJsNFh6bXl6cjkzeWNqekV4Y3pkbzdEOWYr?=
 =?utf-8?B?MGZmQW5HUzQ2M1pjSmNEbnlGV3BQeXlKdllISER1UFhkRXF0K1U0WFZibWlD?=
 =?utf-8?B?bVhSK2tnN1lUNTU5N0hzR0JjaVl4MGpZZzloUVhrNHY5OEZDU1YzTDVKS09j?=
 =?utf-8?B?aFg5Z2IvM3lPd2plUGNPY0wremNVSGpycSsrWkJDVkpCU1JXdzh1M1lhdUtm?=
 =?utf-8?B?Q1NUbjREd3RSMzc1YUhaQnBTVWsyLzFxWVNkS09yZWdmaC9yZ2dJeEJNY2px?=
 =?utf-8?B?UUtKdTB3OWoxaVhQQjc3aElYOE1jcWZxRW1CaXZ0UDJIYzFTQWtYUjF6OVZQ?=
 =?utf-8?B?VWhCOXF6bUJONWNDeDhhRlhVZ3dBNUIzc3lxZEhZdGI4QVZOSFNaSVJHREl2?=
 =?utf-8?B?TmhVb2RZTHhucmNMZjZZcFZaRDViaUI2UnA0L21zSERaeDFnYmZMa250RDdO?=
 =?utf-8?B?ZnIrbWxFQVUrQW1uYUtzU0dnck9NSGtQRG5uZjNIUFJHZkhTRXJXbEg1eGND?=
 =?utf-8?B?SXdyYUZ4ejlLQmlhZk1hUEVyNWFVeFhGRUxvR0VmVmcrTWJGaU1aRTNjSmpC?=
 =?utf-8?B?bXlYZ2pnR3REeU5JVlZ3K1N4V21ZdFpnU2x3QzMwaW00NlNScFdpazA0ZGVx?=
 =?utf-8?B?THhnS1ZkR1dRZEQ1aXBUb1FCWEdITStKbGlMSHQrNzJLQnNoYjE3K0taTFlY?=
 =?utf-8?B?WU9UMG9jUHBZWGNJRnMzaEJvZWdCN0g1OEYxdUw3bWc5OEM2eXdlanBnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OFI0ZlBnWkFxMWZGNWZJWGYzdWJJWmYwOTlSNVY2bmh4K0dIeU9CY2NOcHB3?=
 =?utf-8?B?aWlZQTczWG5JMFc4eXIxTEVtWnpSMVBCMDZzMXRzaUtkdzExZFRXbTFYZHkr?=
 =?utf-8?B?WHg4c01GMXo4RmJLK3lHM1VVdVpHaXgyNERUdDdvRk5XK2VUWkl6aUh4cXV4?=
 =?utf-8?B?UGpqVFNhS1MreGFvNndxZmErUmJXRTFKOU82LzlVYWVaY0J6cmd4bDgrRlZL?=
 =?utf-8?B?dWM4WXBHUDVHZTRmZmcwZVI0OW9qZXZ1aHJNRWhtWUFwMVI4RlFyeStIOTEx?=
 =?utf-8?B?cW5FdXFlM2JkUkVESlNsSnQyUzNQVjY0QkFIM0hVNTJTWEk3USt0eDIrUHpF?=
 =?utf-8?B?eit5N1FaTmt6dWpQZUszY25tNG5iNEZQQy80bDR0cEU3Q3dwTTQzbXN4a3Rs?=
 =?utf-8?B?QzdxOTlXR2oxZG1uN0hKZEw4WVVBTmJKNWV6cGNQY2gyTTN6UmpJMjFuTU1D?=
 =?utf-8?B?dTJKZndDWXpvek9iVklpWlVvb0dyZmJHSjBldjM4WitJdDNZdGUwbktMazdG?=
 =?utf-8?B?MnlIM1A3dEdTeFFFNjAxN0FFQmlNeVhEcUNLTjBVWGtFM0dnWTc4L2o0QlpR?=
 =?utf-8?B?dSs2L3o2ak1vRzhYZGpldUZMTDJQdzJzVnJibnlzVVV6dHFRSnlQUjZNNnZz?=
 =?utf-8?B?dUdvS215UnN6MXR2WFo5T0R3WGVRR2I2dEZxM3lSTkNzaEhUd0VTTWhwYzZB?=
 =?utf-8?B?bjRJaEJSTUVKSjZMQlY1Yk90dk9hQmpKYUk2TGd5VEZEK3MxS0l1MEE0Z3Q4?=
 =?utf-8?B?YjdGLzJURE5ndExZU04zdDl2TjY5UzBZVnN3cXprVHYrTWVDWnZaSy85UkU2?=
 =?utf-8?B?NWQrZmxRSG11SVRwTkxVSFVXNFY2VGNiL0d5bEtHeEpqSDU3blBZUm9RYTR6?=
 =?utf-8?B?dVJUcms3eFRneHlWMDdhREx6RHAvblZHcmVKeHRQNkkzRDlJZjJCZUdoRG5k?=
 =?utf-8?B?NXV3NE03eXZJTG1KeU9ORjVTQVRjTHgvNW8zTkhCcktvWU04Zy94bG5pU0Z1?=
 =?utf-8?B?dWpqSmhVczJGUERNSy9kc3ZnTnhERzFvUWdST0x6aU5rOVBlM0FhclRwWjNT?=
 =?utf-8?B?TFBjM2pLSzRFblEzeS9lUXRqQmU3KzNUd0NqaW1HelduVjlyckVVT0VZWjRh?=
 =?utf-8?B?M1l5NjYyNVdKcUQ3NkhQUUgrNWp1aHpZWDN1Mks3eG5yVk14TS9JbGl4UDhT?=
 =?utf-8?B?bVZwSTA3Z1BiS3BDRHFkeGo0MjhnMEs0OGdvUnFnTGdPZHB3MTQ0WjZsQjR2?=
 =?utf-8?B?M1J2czlVL1czK2Y3LzJXOFNZRC9sLzd1UG1xdkY5Ni9NZzhzdndnSVFjNTZh?=
 =?utf-8?B?NHJ4UG10Y2ZnUWVtb3hBRlFKb0I2Y1RHSXN5NEYwbUVkYVQ4U291QUlZOWF4?=
 =?utf-8?B?OVNURjFoVkpCRThkWEFhRmpKZVlLMWFqb1lTeklpaENkR3QwTWJxaVEzRW9a?=
 =?utf-8?B?eGNIMjh5SUhZWWl0TU5GTks3NHdncmhlMDlLdlg4QWRpRVNlckJaaTFrd2tK?=
 =?utf-8?B?b0tzcW9aQlZWZVMramtnVmtXK3RvdVMzbVBTSU0rVVpZK0NFRjI1dE1yY2J0?=
 =?utf-8?B?UlZIOXBvL015UFRaTmtCdzV6TkpNU2dOcmtOL2d1dDgycFVxYm5DOGdtQUNN?=
 =?utf-8?B?QS9XSFY2dk8yejM1K282d2JkcFByNjNNeFhyOW9VWnpmZy8yM2VHekJWTFQw?=
 =?utf-8?B?T3ZJcGJ1UktGbkhWdmpDQTh6NlBveXlUdDdpK00vQ3Y3NEhmRXZ6blhyQk5N?=
 =?utf-8?B?M0JySjgvSFNZQ2N5Z0tIemxHTzh2Z1ZyUHR2VGJNWWNNQ0FXYmVWYXBqUnB3?=
 =?utf-8?B?WWFTOVlFaENRMlNybSs1aEdVVzJycHRXOGs0N0RCcWo4SnY4WUVscEdpM1FH?=
 =?utf-8?B?UjlHeEljVUZEM2pNNlZGMHduNGROalZCRTlNTFJWK3E5aWVkcVVHQTFpUmEr?=
 =?utf-8?B?WFRZajRFa1Zjc1kybXkzUzUzMHN0R2ZINVpzZ0tZUDBJS2lPdU1kUEk4WnQr?=
 =?utf-8?B?T1VmeEViNWtlMHFuWGhQMlN6aGFDOEtjTWxmTUFvR1lpLyt5bVNSL05oYnRv?=
 =?utf-8?B?WnZHSi9lUzVreUNXNnNMc3cxRVVINnFyNWhWSGI1dUxvdmRTcWdPcVZxQVRr?=
 =?utf-8?Q?dfoM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad17bf6-ce37-49fb-0ee3-08dc83d9da2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2024 14:31:27.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kfpZUH5qH8aVrFsVhg6D6Ynm8lkYUGiqg2QdxYZw0Q9DP8QsrPRhU/ngWAJaMxU+biX6DeVOx/6Q+igo/Ok39A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHcmVnIEtI
IDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gU2VudDogU2F0dXJkYXksIEp1bmUgMSwg
MjAyNCAxOjI0IEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVjaGVy
QGFtZC5jb20+DQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnOyBzYXNoYWxAa2VybmVsLm9y
ZzsgWXUsIExhbmcgPExhbmcuWXVAYW1kLmNvbT47DQo+IFRvbcOhxaEgVHJua2EgPHRybmthQHNj
bS5jb20+OyBLdWVobGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIGRybS9hbWRrZmQ6IGhhbmRsZSBkdXBsaWNhdGUgQk9zIGluDQo+IHJl
c2VydmVfYm9fYW5kX2NvbmRfdm1zDQo+DQo+IE9uIEZyaSwgTWF5IDMxLCAyMDI0IGF0IDEwOjE4
OjA3QU0gLTA0MDAsIEFsZXggRGV1Y2hlciB3cm90ZToNCj4gPiBGcm9tOiBMYW5nIFl1IDxMYW5n
Lll1QGFtZC5jb20+DQo+ID4NCj4gPiBPYnNlcnZlZCBvbiBnZng4IEFTSUMgd2hlcmUNCj4gS0ZE
X0lPQ19BTExPQ19NRU1fRkxBR1NfQVFMX1FVRVVFX01FTSBpcyB1c2VkLg0KPiA+IFR3byBhdHRh
Y2htZW50cyB1c2UgdGhlIHNhbWUgVk0sIHJvb3QgUEQgd291bGQgYmUgbG9ja2VkIHR3aWNlLg0K
PiA+DQo+ID4gWyAgIDU3LjkxMDQxOF0gQ2FsbCBUcmFjZToNCj4gPiBbICAgNTcuNzkzNzI2XSAg
PyByZXNlcnZlX2JvX2FuZF9jb25kX3ZtcysweDExMS8weDFjMCBbYW1kZ3B1XQ0KPiA+IFsgICA1
Ny43OTM4MjBdDQo+IGFtZGdwdV9hbWRrZmRfZ3B1dm1fdW5tYXBfbWVtb3J5X2Zyb21fZ3B1KzB4
NmMvMHgxYzAgW2FtZGdwdV0NCj4gPiBbICAgNTcuNzkzOTIzXSAgPyBpZHJfZ2V0X25leHRfdWwr
MHhiZS8weDEwMA0KPiA+IFsgICA1Ny43OTM5MzNdICBrZmRfcHJvY2Vzc19kZXZpY2VfZnJlZV9i
b3MrMHg3ZS8weGYwIFthbWRncHVdDQo+ID4gWyAgIDU3Ljc5NDA0MV0gIGtmZF9wcm9jZXNzX3dx
X3JlbGVhc2UrMHgyYWUvMHgzYzAgW2FtZGdwdV0NCj4gPiBbICAgNTcuNzk0MTQxXSAgPyBwcm9j
ZXNzX3NjaGVkdWxlZF93b3JrcysweDI5Yy8weDU4MA0KPiA+IFsgICA1Ny43OTQxNDddICBwcm9j
ZXNzX3NjaGVkdWxlZF93b3JrcysweDMwMy8weDU4MA0KPiA+IFsgICA1Ny43OTQxNTddICA/IF9f
cGZ4X3dvcmtlcl90aHJlYWQrMHgxMC8weDEwDQo+ID4gWyAgIDU3Ljc5NDE2MF0gIHdvcmtlcl90
aHJlYWQrMHgxYTIvMHgzNzANCj4gPiBbICAgNTcuNzk0MTY1XSAgPyBfX3BmeF93b3JrZXJfdGhy
ZWFkKzB4MTAvMHgxMA0KPiA+IFsgICA1Ny43OTQxNjddICBrdGhyZWFkKzB4MTFiLzB4MTUwDQo+
ID4gWyAgIDU3Ljc5NDE3Ml0gID8gX19wZnhfa3RocmVhZCsweDEwLzB4MTANCj4gPiBbICAgNTcu
Nzk0MTc3XSAgcmV0X2Zyb21fZm9yaysweDNkLzB4NjANCj4gPiBbICAgNTcuNzk0MTgxXSAgPyBf
X3BmeF9rdGhyZWFkKzB4MTAvMHgxMA0KPiA+IFsgICA1Ny43OTQxODRdICByZXRfZnJvbV9mb3Jr
X2FzbSsweDFiLzB4MzANCj4gPg0KPiA+IENsb3NlczogaHR0cHM6Ly9naXRsYWIuZnJlZWRlc2t0
b3Aub3JnL2RybS9hbWQvLS9pc3N1ZXMvMzAwNw0KPiA+IFRlc3RlZC1ieTogVG9tw6HFoSBUcm5r
YSA8dHJua2FAc2NtLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBMYW5nIFl1IDxMYW5nLll1QGFt
ZC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEZlbGl4IEt1ZWhsaW5nIDxmZWxpeC5rdWVobGluZ0Bh
bWQuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXggRGV1Y2hlciA8YWxleGFuZGVyLmRldWNo
ZXJAYW1kLmNvbT4NCj4gPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiA+IChjaGVycnkg
cGlja2VkIGZyb20gY29tbWl0DQo+IDJhNzA1ZjNlNDlkMjBiNTljZDllNWNjMzA2MWIyZDkyZWJl
MWU1ZjApDQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV9h
bWRrZmRfZ3B1dm0uYyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4NCj4gV2hhdCBrZXJuZWwgcmVsZWFzZShzKSBpcyB0aGlzIGJh
Y2twb3J0IGZvcj8NCg0KNi42LnggYW5kIG5ld2VyLg0KDQpUaGFua3MhDQoNCkFsZXgNCg0K

