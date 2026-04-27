Return-Path: <stable+bounces-241239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFMBIbQM72kq4wAAu9opvQ
	(envelope-from <stable+bounces-241239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:13:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E367D46E2CC
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02D9230097C6
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 07:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8582D390998;
	Mon, 27 Apr 2026 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="boTbjjxb"
X-Original-To: stable@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D190738F653
	for <stable@vger.kernel.org>; Mon, 27 Apr 2026 07:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777273906; cv=fail; b=tZyLIVNbfEADTWj6wHooIlwJVLM7EdyfZ343EJVnpiOooeRZVOBLz/F+bdZ5IKJ+nCc+6egSw5ZHv5I6PGRy6W6AT02kpAefvFN2qz7VPL0832RrxTA8G8iFgCv6TqAQ15IgCZ1S27mcVgUKyr6en4UxtpPszWPg1T86TyjH3C0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777273906; c=relaxed/simple;
	bh=Srju9BNbZAEcd3PCDxa7RMW1N3aoJMbpDqvTwT8cTvA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kAyMlwH6EpUB41bRgoIWy+VbcbG+HPzq7D2c+waGcsUUxIQyWCoarE6T7SXCLjYG0RuzKf7nxHILVSY5HD2lnlU3XfOf6AKUsfPdL0MrIyr1qt5f/dTmYBbgafDXhaVxiNzeu6WdKCDRF5N2+qvrw/ltLMDv1YLxDhM2vOJSG/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=boTbjjxb; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GW78sbUp+X75ty5eDX0TT9EtCIS6LL5PH+kS6JGEChr+qRgk9CaGPjUBLpnC5dqADCsDbHtd8snghp5GHq79XtsUOpmNtNhUXpUW4OrhmVHwQBEm8mKgRnrRb7uu7LIDQHv62BXalxP8ylGfmkjPwVQsCLw3jsHJQq5sJHsz6q3qP5kWKbi3BJhRC80g4kbkWs4Dic3RhtVi+pmir7iqY3RYV5ouQpbxJOhHLJnUDdSdec88qwJsOo3sNesX9QEDBRadmXCImKo1oTSAPc8T4zSCTRWnEMMEVKL9+XmKTxJvk4jBFCwgpyDYFBOKLNozJClViagS5BmUEIvsfN9Kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LE0ndR+2f99xdEEWIKYfQkxSJmDpluKjcE/12FSUSg8=;
 b=n7i1jMP9ekmSnSIHIdjvH2FBJ6We7ScC42CKQqwSafSRRmvTNq5nrGIBpCEnlDsW1AcV/zx7Na/aGsGvBHJgIvpyUZheRc99V732Tt+n60kj6Twp+ZIAXZJlzp9e31sGL2Xw4wFix9UaMPRN0OWdUcsI/0mZBgrosN6aikn+nQ+P5ZBXqKUMW1tnGs4tzhKnbahnag1AB0+ZibXufdaD9cGfvGz52qhiJi61vomh/Nwj7Wj600PEIf+LXy8gpgArp+dD1TWmOTEBt5vlu795Ifti4G0d8EZcIDHyxl+1SGNS5g5aPeWXnH0YK4CIIPemAnOr+MEVP5KBxHV1fi1KUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE0ndR+2f99xdEEWIKYfQkxSJmDpluKjcE/12FSUSg8=;
 b=boTbjjxb7xxhkjxCW9eZhLgFY8NFz8V6s0s9gNZQ0J0yEXpxv47okuAo9pgXfEMYDJbsmdpCMl+nobr60AKERP/ab5RmZw2ZMryxHdOe71X38XJMA2eS8Su47ePBy9p/e8g6594xP3YkZ23Y6Z7YzY0ThMEJ4CoLlbu9w2BUO6k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by BL1PR12MB5802.namprd12.prod.outlook.com (2603:10b6:208:392::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 07:11:41 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%5]) with mapi id 15.20.9870.013; Mon, 27 Apr 2026
 07:11:41 +0000
Message-ID: <926aba60-b9e1-4a10-8be7-53cddbcbd237@amd.com>
Date: Mon, 27 Apr 2026 09:11:36 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drm/amdgpu/vcn: prevent silent fence drop on 64-bit
 flag mismatch
To: jbmoore <jbmoore61@gmail.com>, alexander.deucher@amd.com
Cc: stable@vger.kernel.org
References: <20260426215256.50722-1-jbmoore@nooks.dev>
 <20260426215256.50722-5-jbmoore@nooks.dev>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260426215256.50722-5-jbmoore@nooks.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0233.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::15) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|BL1PR12MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c1132e9-62d7-4ad9-0562-08dea42c3b14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	1aWEsNplan5E/WjNoZiv+fODnJe6Agr+MXRbV6dGnnR6PulzjrBt/evAXegElL/jCQ109Il3tPWX8o36f7zNjG96awj5Ug69Vphh+6LsCJPwpzro+RToY6kx1imbsKOdh7hJYZCyMupX9L1lMTuEtW6w2sctpRGp37xoVXCVVbjD5dtMzurtmxDYEJ/Mql18IIvTNl37mJerdAUB/cr2He92j9JfyrW4wDRGR06odhmcI1DsaTv/2WsseSLQUlL0O0FnaE1oaqKpfghSuxmfk43JoOGAkznuiwj3oq0HaoX5i+M+Iuv7r4LclJ87eJTc0h0HatdivB6CvadTfqu3G65aIY3TEp+c/p3/muGCkzcsLH8mUIbcln9zE6LdwuFoKyEmk3hwV/ATMZCKoMQ9p2fbXN9IIHNP0qsijCMdjUmzWqA/S0VXRNr8ilayYj8znPQJ/YNz1q+WvTwouPbaJU9pl80de5Tfu9BKNNgX6v1tnZaQMmoK4HFHQ9slHZ1uQhwTXmIAvOX3tXhDIeAWvMrP8//Ur7Qj/JD5uXRm8E8bJMt3D6B6xT4aYRtNDE+jokAYjoO2zFIB+uCNKbdEtiUuK+NhHNkd78XszAwT8H70IhRbrxD1sZjtfEmE/6FP8Nmh0AxQ77C5pH6Jw1S04zknthPr+ayCxE8wltkKpT+luplSHU/KtW9oabpdt+GTtvjDl0dZsiduf4DpD/g26eLuiSiQ39TSTPLt7wltR3k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5673.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?djg5bVJWNHBMVzE5S2pwYkZ2NExGUjRWd0I0b2Z5dm11RlBhYW85RkxINmFx?=
 =?utf-8?B?eFRWeGZZTTRRQUhBL2RCWENxZmNjNG5QdFZQcEtRSkdyVzR6Qmp5RlpyeWVW?=
 =?utf-8?B?c0dteGkvNldXV2kyeXZvNGJVR0Z1Q1JMdndWa01kaStrNG4ycHJHVW8zN1FG?=
 =?utf-8?B?T3Y2L2gwSExaRWdEVDd4eFhORmo2eWVQamZtZ0t6T1hZVTZVTDRuaUpTMVFZ?=
 =?utf-8?B?RXAySVJDTkZEMWdDNnkzblZsMHVJWGFtZVg0Uk5ONGhFRWFZUkpNcDhMTWh6?=
 =?utf-8?B?dHpVNXZKN0gvWFJBQTM5dWhPa2g0MitqdEE2aS9hSEE3c0d1THRGL0QwMFlm?=
 =?utf-8?B?enZFalRhZVMxT0NFaUhyV0xOaW1FaGoyeDBCVTdkdTdpaWkyM3JZbFhhSjBx?=
 =?utf-8?B?RVZJanFmTGg0elpIUVJ2ZFpOcmFsaUVqd3hVSXN5NER1V2NjNUJuUU8vdFYw?=
 =?utf-8?B?YU9XY0tYVUFJak5PeDBUYlJhbGdRVWh6OHhnY0tGUTFXZklVL3JNYzZib1l5?=
 =?utf-8?B?bXF1aDFyenloeW5sQmwweE1VVm5aK0E5TXBiU3BoNER5MTI2eHgwRDFqdVlY?=
 =?utf-8?B?STFuUG01OURTVDRHOGhsTVpDaitiYXFiYmhrbWdlelhEVjZPZFhmc09iQ3dL?=
 =?utf-8?B?c2dWdWovZWd0RVZXRVp0VDZRdTgrbStOQ0hGa1I2YjA0QmlhZlUrY0lnWW1R?=
 =?utf-8?B?bmYzUXhETExXQngrODlpSVFFMTIveWtJdXk5dnZKeFJMTDVna1JqVVA4R0JO?=
 =?utf-8?B?cWw1UDBibVZXTjdlUzluSmIwaDJBRUtESHVMRE5mdXhqNGFFRm1RcGxwNGgz?=
 =?utf-8?B?YkpXWlN4bTFJaVE1TUhpVHJGQWVBbFZQY2VKRkZLZlFDOTg1eVMxcTgvNUc3?=
 =?utf-8?B?cndOOFl5WEN3aWRZVWI0YlhkTk5QcngzWUQwZitVejVtWjh2b2YyK2FDOWMw?=
 =?utf-8?B?TE4xNlN0c1lBSFJKbzM1WmgrdUJ0M2VaSkwyZnJpS0E3N0tmTGluc1NvZzNj?=
 =?utf-8?B?Tjk0YkJ1S0t2d250V3Q4RGp2dlltQUQ3eHJzcjVxdXU4VlVjT1JkcmhweXAy?=
 =?utf-8?B?Qlc2cmFwL1ZMd21mSWZkUlV5SHpaVTBGZEZDeHp0KzFuT0pGK2RIVEpvdWpD?=
 =?utf-8?B?TWUra2hhOGkxbUF6VlFaQUZkOWQrYkluaFBxcmd1ZXBYUWEzOU5vcFV5Q20x?=
 =?utf-8?B?bHJrRUxkRUVvWnp2Y3dwSlphcllWY2hOd0wvQm44TmdPbktyc0lSdGtLN0Ji?=
 =?utf-8?B?aHdUMUtZZlljQW91YjBNbVUxYmlSQjZjb2xoQ3BLRzYxQ2UrcHJmek40SE80?=
 =?utf-8?B?RlB6OUowbzRqcDgvc1lCNk5tcXQ4VWpGeEllN0xsS2JYaWYvcm10Wk9DWXgy?=
 =?utf-8?B?bkxNVS9yUXRWdWxoRkR3cDliS0NGOWlnOGNYbXVNbmVHTE1jK2FBQ0FCWUdy?=
 =?utf-8?B?ajdFOGFqYkZmOVptcFRYL2VHQTFNV0hzdlZDTzhzc3pXUHB1RGZKL0VqLzAx?=
 =?utf-8?B?MitYdklXMlBCU0pWVjBsZitQdDlnb1R0a0xnMXdPMkUzMWdsaEoyelRsTkVr?=
 =?utf-8?B?WUZ6Q1ZvbzA1WEFzOUVYdnBjUzRZYWh0bUhtM1pjazc5amwzazdBdUJzeW9M?=
 =?utf-8?B?QWg3M0FCOUNtRVZoRXlRQlMwTlNZT1lMbHZwRE5YNTBTSWxzcVJrdGhQYmJo?=
 =?utf-8?B?UG9sejAyNW5KclFvUWdTd3p0SHVSK3JmWE51dkZiaWVZMVBZU3NFKzVTcWZw?=
 =?utf-8?B?WXk3dkJVUXVFVTkyaHYxbjlzT2dPK3h6K1VYN2IzUWNVOXFBbUFlU2ZEaFYv?=
 =?utf-8?B?dEIrMjJWZko2SDlPWjljUDVuTFV2akl5dEMxN1dKekJmTjdqWEVnNmpYc3or?=
 =?utf-8?B?YVdsMjdqVzNQUG85NnRPMDY0ZlJZbW42QkZJdUJSS2xPSVhmUTg2VHk0c2x1?=
 =?utf-8?B?UEYvNTdYZEZvcWdSMTdUYVJaYmp2eDlCNnlrSVdNaDFXbm41SDhTa25lL2dO?=
 =?utf-8?B?Q0pzdmhSSWZzcnl3am9tR0w0Z0tHb1N1WGdFNFhkK2lmcWk0U3lpcXB2c1Zt?=
 =?utf-8?B?Yzk0b0Jzb3hZM1RTVTU0QlVzeFVjMnhrbFRYRklQVkFjallMMVVDNGYzNllY?=
 =?utf-8?B?YnhCNDFjVjgxL3JXUVhYMzk2aCs3Nk9BN1lLeXF5Z1RVMzg1eEZkRGkwRWh0?=
 =?utf-8?B?RlROeG5lalV3VCt2R0lkQWlnM2l1UnEyNGlWU25jbmpRQlBrdWsyZHZHZzZ1?=
 =?utf-8?B?citUZkpUVDhNQ0R6eHNFdVpQUzB2VGZUNTEzWFZBSkxiTnllTk54TE1tYkdJ?=
 =?utf-8?Q?Zu2ZtTWyWWwYLHsUuS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c1132e9-62d7-4ad9-0562-08dea42c3b14
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 07:11:41.1331
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fa18SZz5RNy/LD9lKeA91hPhfaeU0hhL1opE1gHPqrV805ebcPLTgBSLuOZyTVyl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5802
X-Rspamd-Queue-Id: E367D46E2CC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-241239-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,amd.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On 4/26/26 23:52, jbmoore wrote:
> From: "John B. Moore" <jbmoore61@gmail.com>
> 
> VCN, UVD, and VCE encoder/decoder ring fence emission callbacks only
> support 32-bit fence writes.  When AMDGPU_FENCE_FLAG_64BIT is passed,
> the existing bare WARN_ON() fires but execution continues, emitting
> a truncated fence that causes the VCN hardware unit to issue a
> no-retry UTCL2 page fault at NULL address (0x0).
> 
> The hardware fault is non-recoverable: the VCNU client is permanently
> stalled, the VCN ring stops processing jobs, and all pending fences
> on the affected ring never signal.
> 
> Convert WARN_ON() to WARN_ON_ONCE() and add an early return to
> prevent the corrupted fence emission.  The early return is safe
> because the WARN_ON fires before any ring buffer writes in all five
> affected callsites:
>   - vcn_v1_0_dec_ring_emit_fence()
>   - vcn_v1_0_enc_ring_emit_fence()
>   - vcn_v2_0_dec_ring_emit_fence()
>   - vcn_v2_0_enc_ring_emit_fence()
>   - vcn_dec_sw_ring_emit_fence()
> 
> The missing fence will be caught by the scheduler timeout mechanism,
> which will clean up the job without hardware damage.
> 
> Using WARN_ON_ONCE instead of the bare WARN_ON also prevents kernel
> log flooding if the condition is triggered repeatedly by a fuzzer.
> 
> Found by a custom amdgpu DRM ioctl fuzzer.

Absolutely clear NAK. Not emitting the fence is even worse than the page fault.

Question is rather why that isn't filtered upfront by the CS IOCTL?

Regards,
Christian.

> 
> Fixes: 8ace845ff0e8 ("drm/amdgpu: add vcn enc ring type and functions")
> Fixes: cca69fe8ff98 ("drm/amdgpu: add vcn decode ring type and functions")
> Signed-off-by: John B. Moore <jbmoore61@gmail.com>
> Cc: stable@vger.kernel.org
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c    | 6 ++++--
>  drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c    | 6 ++++--
>  3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> index 2b9ddb3d2..aa0022deb 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_sw_ring.c
> @@ -27,7 +27,8 @@
>  void vcn_dec_sw_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  	u64 seq, uint32_t flags)
>  {
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
> +		return;
>  
>  	amdgpu_ring_write(ring, VCN_DEC_SW_CMD_FENCE);
>  	amdgpu_ring_write(ring, addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> index e9d790914..2acf6e621 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
> @@ -1548,7 +1548,8 @@ static void vcn_v1_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
> +		return;
>  
>  	amdgpu_ring_write(ring,
>  		PACKET0(SOC15_REG_OFFSET(UVD, 0, mmUVD_CONTEXT_ID), 0));
> @@ -1724,7 +1725,8 @@ static void vcn_v1_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
>  static void vcn_v1_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  			u64 seq, unsigned flags)
>  {
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
> +		return;
>  
>  	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
>  	amdgpu_ring_write(ring, addr);
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> index e35fae9cd..6cfb5aedd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
> @@ -1537,7 +1537,8 @@ void vcn_v2_0_dec_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq,
>  {
>  	struct amdgpu_device *adev = ring->adev;
>  
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
> +		return;
>  	amdgpu_ring_write(ring, PACKET0(adev->vcn.inst[ring->me].internal.context_id, 0));
>  	amdgpu_ring_write(ring, seq);
>  
> @@ -1722,7 +1723,8 @@ static void vcn_v2_0_enc_ring_set_wptr(struct amdgpu_ring *ring)
>  void vcn_v2_0_enc_ring_emit_fence(struct amdgpu_ring *ring, u64 addr,
>  				u64 seq, unsigned flags)
>  {
> -	WARN_ON(flags & AMDGPU_FENCE_FLAG_64BIT);
> +	if (WARN_ON_ONCE(flags & AMDGPU_FENCE_FLAG_64BIT))
> +		return;
>  
>  	amdgpu_ring_write(ring, VCN_ENC_CMD_FENCE);
>  	amdgpu_ring_write(ring, addr);


