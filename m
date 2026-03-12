Return-Path: <stable+bounces-225215-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +MEBDfQps2ksSwAAu9opvQ
	(envelope-from <stable+bounces-225215-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:02:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B9A279B6F
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 22:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AEB1130CA5A4
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1E73A6B8A;
	Thu, 12 Mar 2026 20:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vXYHvlLp"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB776398900;
	Thu, 12 Mar 2026 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773349188; cv=fail; b=vCIwQhuQ7ytfBtq1Ghqjrw/nlP3uTg3Tn88O5HPLTdSHgZZ3yw7D4QVlQaGx/dJUyTJgOHrvqCL5Xa8ixyDjN0RKyrvUIvH9qNYLqGbG5lQdJsf/ImP0EJF12FQYe7Y8pM/PWf7mxPIOK/WsYxDz2f1rTHt7CG9lnBCBOvMR/vc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773349188; c=relaxed/simple;
	bh=8MAxwkNulkPgYOI50G5l8XGcGX2gCHVUcqVru46hRCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F89vgS+BMTI2y4OfvDbYXnr0mUMqjLkKqTxY08UD7G6vQFNd//xWpxm//VB/jSP7zFJdox5d6OEs/z7xyz6z0uIr0T15WAWIO6uTKdfayFVzyo0AQTPWNCupTch4EyD8K7GqvaF0GN79gxuD3VHo7tos+3vSe7VPrIcEqJKvlak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vXYHvlLp; arc=fail smtp.client-ip=40.93.194.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QuLHsz4tE7GZT/TTA0xb00UmMLer0wps54i9ODZjQYil8PMwzFyO7RIwn0gDlNE6gNdvuPIjFeQDA/tC89Pt7H9P6qMpN8B2bW5N94B2rjzBZNygpUEXkjifX53dq7upAKIAWlsFi5MgdztscDfoWuqsx03JR6EAn2nHdGaE15ChQRqe4ewRlKR26RvV//ZlBbStnJc9BAu74l/cZgVB4bVMRwTDIEMPTRnDfKfXq+m0Fo0Bxmr+3eWWPrtxGyYqDvy9m/ZJDHUUGbFPpASPOy5HhSnIRXV4cDyTsWVUw0VoJPK6rx8ofHpaAxw/2T4FKHg7qmJ6xy7/BzG1quC37w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlAufmVX7khTnepUgmlAjuMlIpKIOKJ2UdD/8lqur8Q=;
 b=OMD2XkDDAiWotySiLZJR6LnH7y50Q2YX0gmRlqttNvbBug/FjQyplBhmejunXX7GZxbj/3CY7sskbFbf+SWmoPxRTt6UZyf3kByqNjOowdW8KR2qEFWDLnlVhZSdlqxiqFYolW0Scn6+SE03c60d6P3FBjBjw7+VfxMOaeG650vsiWS1SJN+0Ua0NhTYyJJwgb1B6SQEttqG6Qwz1Om88D53zdFxR39REjIwXx39lbOeAAwh1zYxsd45tyVTqwFTCXO++ZXic58U64x6dpIRifD0mDuig6iOo9reIU9k+K0SlfV95PisCsKLGkCOs8tnmHmgU3nWNgARDP0YeTgW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlAufmVX7khTnepUgmlAjuMlIpKIOKJ2UdD/8lqur8Q=;
 b=vXYHvlLp95iWkzmjMjhjgrmoYWI8iJiiNXlbWr/Dj0MeawVIjgcGfNy63Riko38mCAw2Zc7wi7mX50kbrdR3RlON+6DBTKpMsMj15ZEiyHKivI3MG7+VDmltAawPmAJ6jqVXOBCV0JrHdRkWpVba8xloDkTXeZs1PG07zXBCcfw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SN7PR12MB7934.namprd12.prod.outlook.com (2603:10b6:806:346::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.4; Thu, 12 Mar
 2026 20:59:42 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.20.9723.004; Thu, 12 Mar 2026
 20:59:42 +0000
Message-ID: <44081170-4572-4807-9ac8-0886c77e6e0b@amd.com>
Date: Thu, 12 Mar 2026 14:59:39 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Wrap dcn32_override_min_req_memclk() in
 DC_FP_{START,END}
To: Xi Ruoyao <xry111@xry111.site>, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: loongarch@lists.linux.dev, Mingcong Bai <jeffbai@aosc.io>,
 Zixing Liu <liushuyu@aosc.io>, Ard Biesheuvel <ardb@kernel.org>,
 LiarOnce <liaronce@hotmail.com>, stable@vger.kernel.org,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Alvin Lee <alvin.lee2@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Ray Wu <ray.wu@amd.com>,
 Kees Cook <kees@kernel.org>, Yan Li <yan.li@amd.com>,
 Ryan Seto <ryanseto@amd.com>, Saaem Rizvi <SyedSaaem.Rizvi@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260306062805.1464383-2-xry111@xry111.site>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260306062805.1464383-2-xry111@xry111.site>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0310.namprd04.prod.outlook.com
 (2603:10b6:303:82::15) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SN7PR12MB7934:EE_
X-MS-Office365-Filtering-Correlation-Id: 946a4f27-ec29-4203-1d9b-08de807a4891
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	Cf+hU5sC8nrJAZFSX7d3zVZvAhwbU5qrOKH8Hprfrs8LQbmyaRjqqRC2yTPITKSM7Nupc8wNMcP3FeU2x8m+ucneugc95NOAt8kGlAfNsNL88Tme0hwQL+8Pg1vdvHpT0tpE8dptsR02CzlCW6Il2a9SGGWZP2SCAh/sNfECQmXMCH97+WI/DtK93SPcl/aWDEcDeI8tE1N+hio7CIBZGVsHq4H+0CDxi325z2dyvR+xc9fSgCgZMneSZG/dZP2GL0KXe8z+yfu6gCFMXuRM+W6KSwRqXiwFbulnISrVos4LUMvw2c7roiLGQnTFzNvjAEHBTLJDQyxN/YbFTDZriw8+JgwUEBFmKJXXxWan3VTnisOpUxpPlpODfdjHz1a/QlOHJHSypF7ZtXe/sOcv1K3xIjc9dJ0nooGEJk4SLYAiSkHV2dfbr38aTU5VbE9+F6RqfJhiiK8ZAVnurFitBVCmWr0qTL4GM37B8Ds0LScGL56ygyK94vXA2g4OtSlJkEk+UH4QsIJPA0PlkeJ4AF/KPBwqHjYIrpAwRH/pHwgo1O4H0fhipvHugB7urkdI20fBXG/IpVkigIhzxi+DugPJ7NVOecy/9koRIO4bu7GK1kbEf6urD4mssGpVEMP1f8PO1iNB6AbJh8I+fSkRGtTZd9XjOjzpu/nYzwFYYS+0RAWnsBjU92/AuI68Wdw4KxqOcxCOxxEgnWDzuO3imPltnPtYNg1ndUH7tExuWJ0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UENhQWxpUWF0WnlOa3ZTbWllUDgxUnJRQWYrZWRQRHZzc2tRODVhSVJUbXR5?=
 =?utf-8?B?RXF4TzIxdkhlVldFLzFVVnRCS3hMNThlVVVJdDcvcTUrc2MxRzQ4U20wZStu?=
 =?utf-8?B?ZllhcDJkcWYvcEw1RGhXTERETy9Vdzk4dGYxOXNNSG1DT2Rya3lxdERuUnpy?=
 =?utf-8?B?dmdZU01GN3FDYkE4cVJjVXlsb2xLcnEwL0kwMTBJelJYZWl0ZmxnaGdhSVIy?=
 =?utf-8?B?bEdUUUZlSFVxWGlDMmdMOVlTZk8xZ1A1c05saVBKNjhwZHduSCtaaXRFOEtn?=
 =?utf-8?B?MjhTdnhrV3F1ZkxwVUVtUEhKYmhwekVpQ1JNTEcyeWN0TVNxZFRxMmJiV1pW?=
 =?utf-8?B?YWt6cHRkeTVIQXJFNUVqaXRaTEllSWxod3ZVbFNVTFlydnJrQUNaaUdDZFFY?=
 =?utf-8?B?bHlzcWZLOXNGTmlYa0k5WkxPVG1oVFpIcXhubkF4cUozVlIwMjQzZ1V2Qy9a?=
 =?utf-8?B?RXRyMUo0WWxxc3RLYmdDSlZYQmdjZlAzWkluZ1VuR3lSYkVMWGh4QUNObGE1?=
 =?utf-8?B?cTNpcWFKcTRhdVBKb1JBQ09qWXdyVDJqcHh6ZVhsRXh2eFh3dFMxbFZLdkpp?=
 =?utf-8?B?WUdLUThpakpWaWF2RFlSV0hTTmVUOHNsdVVJRlQydGZ3QzZ2aDhHODlkZnR1?=
 =?utf-8?B?WjVoMlh4SkpSS3d3RFhRN1N5S01TS2pYM1haUTVGWkREdHM3K1JpcFQ1U2Zj?=
 =?utf-8?B?MWNPdHA0NUpyY2JkcWF0ejE5bFk2L3VTTDBjTkdEQW55dFl4QXlhU0ZSb1ZH?=
 =?utf-8?B?UDdwdXZMKzdIdkNRSGdXRkc1R09ydkRQYUl0Y0pqYUMvLzBEVUV6a0dRY1J3?=
 =?utf-8?B?QnZId0lWazRVN0VFS3BhcUwzS2hDVmxHZTU1bzdTNHJ6Y3BDUkVNMVpMZ0lw?=
 =?utf-8?B?WHpRUkNmQ0E3ZWUwRnlxa0hrQ01WUmZEbDlpT0d1RGxPT2ZaMlNLRUs2R0FQ?=
 =?utf-8?B?QVVyUmlkODdHMTZ0VzZLR0VoZmc4VzBJUE56R2ZkV214ajcwVExxTDhrOVp2?=
 =?utf-8?B?Ly9JRUw2NFpGUzVmREJmZkZPLzJTeXNOdSs1ODc2Y3RsTVlobUpwaUJmZnpF?=
 =?utf-8?B?US9MVXhRL3lCNVpBSHQ1N1B4MFpXbyt1WDdPaHlZSkd4NFhBWlF5TnlqMVd5?=
 =?utf-8?B?YzZ5QllEdEptZzRMRld6aWc0ZGNnLytqck1pczJYWC82UllHeTBhdWtDcDJU?=
 =?utf-8?B?eHgrZW9USHgzdm9uaUREVFFDM1VnT0lobnNaSmFIeEZHNWZ1QVdaQy9FSXJR?=
 =?utf-8?B?ZHdnOFd4TC9UVVkzdndRa2ptWVozQlZwZ2JreFJ0QnVzMjk1LzRBSzBtWmRJ?=
 =?utf-8?B?ZFZPRlB4Mms2dk1lY0hHUDcxV3VuOVl4cWVtbEhPRUZ1YkFqZmJiVnJwVlh3?=
 =?utf-8?B?R0NnUmh1MVQxUUhjekNJaGwxK2xGei9FbkRXSTBpaVpNVFI0a1M0NFc5WCti?=
 =?utf-8?B?aTVTcUs3cTB3U3hnUTVaUVVlbjhCSURsZHdoMW83ZDlONHFBSTNmaStZc0hx?=
 =?utf-8?B?M2E4elJyc3pKUDRIa0VvaSttd1I1WnlGbTZsMHA0NXRXT1E3R1lzNHlLa3lq?=
 =?utf-8?B?RGo5Y0UyaStIY3dXWEhpQ29pNVpOdXNkcDdVSEZxa1h4WkJrV1pIeVJ1MU1I?=
 =?utf-8?B?WTE4K3BBMDYrM0ZQNlhMTEZDMHhsSHpBQTUvdkFvQmQwdDRpVGZ1eE54UFVj?=
 =?utf-8?B?emRVZ0lRZEUwN05MaTNtVGhHMXd6K1c4alRNd0ZBMUVBWExhWVE1L2RpMjhp?=
 =?utf-8?B?anlicFZYTFkyek1oZmpTVnNQMS9xNzVnWlpqbnJmZGJhMitMS3dlVmxFSGJ4?=
 =?utf-8?B?cExhWlYrbGVIbG5zWXZIU0k1NGp1dGhPRndOWFdkMGlIa1hxOURDTHJNMkNw?=
 =?utf-8?B?ZUo4ZVlYTFJFQWNWcnJPd0ZmbEptV2d1VTZNK1M2ZFZLa3BYdlpSR1k1T2U0?=
 =?utf-8?B?d0RyQ2E1UWl5Uk1LcHJWblFLK21CM3RmY2RuZzI3ZnpNNWZPbEttTE5lMnBM?=
 =?utf-8?B?b04rcERZTENLbTB6bUhsSHQ3aFBGN2JyVVA4RE0rS0kyVEJsWG4rbmEzYmlQ?=
 =?utf-8?B?WFo3cXdQM3dJTGFrN2QxZlJFMlg1TnFDSkZ1T2tYUmUzcFk5TEJvdGY1a2sx?=
 =?utf-8?B?enJVLzJ3TUZsWnVHNnpXT3p6YVh3MUdQYnhrTlh2Rk1uVmtIQk13c1dicDRn?=
 =?utf-8?B?UVFUMXV4SjJ1M2xYa0gvaWFITGxvY3BIbE5yTXZ5S1YxWm9lazR0djZtU1BW?=
 =?utf-8?B?WndOUmhrOEZrOThJeVV2eDhTWjBvSCtQOXRONUFSVHRTL0dDUXFLMlRwK1hj?=
 =?utf-8?B?QTR1dE1iRHhIbEtGdmx3WTM3cUovWm84RFFYYjU0SXppU1VOMGtqZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 946a4f27-ec29-4203-1d9b-08de807a4891
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 20:59:42.7328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2Kx9Ufm706v5ouN7ISEmc7ObJmdYGBgUVq8CEBSQg0uB0bI4Ux8dAB5f9MRzIbj2P24cOCrQxj4bE9H3H6Xeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7934
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	TAGGED_FROM(0.00)[bounces-225215-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,aosc.io,kernel.org,hotmail.com,vger.kernel.org,amd.com,igalia.com,gmail.com,ffwll.ch,lists.freedesktop.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alex.hung@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,xry111.site:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A0B9A279B6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 3/5/26 23:28, Xi Ruoyao wrote:
> [Why]
> The dcn32_override_min_req_memclk function is in dcn32_fpu.c, which is
> compiled with CC_FLAGS_FPU into FP instructions.  So when we call it we
> must use DC_FP_{START,END} to save and restore the FP context, and
> prepare the FP unit on architectures like LoongArch where the FP unit
> isn't always on.
> 
> Reported-by: LiarOnce <liaronce@hotmail.com>
> Fixes: ee7be8f3de1c ("drm/amd/display: Limit DCN32 8 channel or less parts to DPM1 for FPO")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 7ebb7d1193af..c7fd604024d6 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -1785,7 +1785,10 @@ static bool dml1_validate(struct dc *dc, struct dc_state *context, enum dc_valid
>   
>   	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
>   
> +	DC_FP_START();
>   	dcn32_override_min_req_memclk(dc, context);
> +	DC_FP_END();
> +
>   	dcn32_override_min_req_dcfclk(dc, context);
>   
>   	BW_VAL_TRACE_END_WATERMARKS();


