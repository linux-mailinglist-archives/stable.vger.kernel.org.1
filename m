Return-Path: <stable+bounces-230376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHqIH/whxGmZwgQAu9opvQ
	(envelope-from <stable+bounces-230376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:57:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3E32A2CD
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 18:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ADEE6301D567
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 17:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA8E40FDAA;
	Wed, 25 Mar 2026 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2PMXgLzs"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9240825C
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461308; cv=fail; b=fVdWyDa7p8+XwMfQlnm7RkLb/t8EcQCMLmlJVdvzB+cEqBX+scDoebmqNjQrX6nH6LzAx3K4/aKtCcl6ZTgrokHKKmnFVRvmurEpDFSgKHu+6GL1ash4I/GH0TDVy4L9P8Ndya7UQLn/glmiOeT8mOf2ObMoUdmmYVWqaWeIfO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461308; c=relaxed/simple;
	bh=CaLoIeWt5fXhGkdx37+/lNUpOUw8Ej0HaqurTeYjFyQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xv5nfrRch3smqNAQTUH2nF2v3CAFjzxsdqoSl6bEs0mMey0wybqvEr81ooMNSxyQV83fZaJZr1WiyYHGlIA1hsD/GBcIhHh61+n7OKIN2rdLWv4mlcsKM2/u10lML4P4cREE9O+mJULCULvHSxVgyKdCfxrik83jnSDwDn+dxWA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2PMXgLzs; arc=fail smtp.client-ip=40.93.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZUhsI0HehXtFZm1MjFPf/Z17HOLa3FGsxZDbzsYBRHHRQ85yVcIxOxNMQL7GwFAFICPhGReNJ/dtjVw3C0kYoncXD+RqEQLNZypymBR7nRy6MsoHjtTBuRCZ4J89qezhLA7AHKPFVkH5WFKle9EWZdhMfbxTxwVqOLobiEHDbCTfxROBVU6rx4uc9uAGsfH3tB+5Faa/iPUsGoCKlDGs5Zssr+GSIfM7wIpzVuF9FqcT905wFeFQ4CCOwpAEheNFxGuwX/acHjj2bYCvAK5D8Cm0VZx6/oIuiBPOJdXLtvjTFGiIgn+autFGl1IrAlas7m3DrUBNXliB3JXqOJE40g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7U/8V0Z5oPigqAGT0hiOSAvb8itpwdc2CSCvj6yeqWw=;
 b=ow9SklcEhJRBH/BwH4NJ9Tzoz/YgbEmqA815RpfdVghnTGoOnA0nk+vlTi2VBI+3olLx4Iiuan2tC4ARuYWuUTbGdjYXWY0mavNHtc6+ebKRjevcR8zLfKxiqIO7EIFi5UC08HG5E1E29A1U2eMu+hl7URP1f9/ee5sIZovzig8Rlo2qFu3miBuHzxaJhD049bp15dgBo5YlepmzZYeu6r+zGZTxcGA363QuzGqE6QAivPjORjc2+OMWQJPx5leY0n6imlyNJhJxPxBcJkTlieWBTzVJZRUBJ6daxcF9/VyIu8LTtCprL4FUitvobKo/u5KF/9wMSbUIp2IgCjpmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7U/8V0Z5oPigqAGT0hiOSAvb8itpwdc2CSCvj6yeqWw=;
 b=2PMXgLzse2jiQ1gvPCKeugTEzCH5GkhZgp8aPp7sf48HoQatW2AEwElVFqngiFeQyh1f7WybgquPh6Ngs9HttOQDoVrIGHcMMHE9hpCQ8pz2E0Q6ltTtGnge5rnRfVVLnAU6E7mDZCijxaAHcDb2JfTXlOFBfWVUmrmmY4ZxGsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by MW6PR12MB8950.namprd12.prod.outlook.com (2603:10b6:303:24a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 17:55:03 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9769.006; Wed, 25 Mar 2026
 17:55:03 +0000
Message-ID: <00db9c57-9d16-4123-8e2c-b9251aa702ad@amd.com>
Date: Wed, 25 Mar 2026 13:54:58 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Donet Tom <donettom@linux.ibm.com>, amd-gfx@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, Philip Yang <yangp@amd.com>
Cc: David.YatSin@amd.com, Kent.Russell@amd.com,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.ibm.com>, stable@vger.kernel.org
References: <cover.1774239489.git.donettom@linux.ibm.com>
 <d3a5bd9b4bcff28c1c43c4c46479cd95d4dcf7f0.1774239489.git.donettom@linux.ibm.com>
 <65a96159-1266-4b42-91ce-359fcd1a76ea@amd.com>
 <7beedf3b-99f7-4096-9a49-88f98b9b4eb5@linux.ibm.com>
 <bf255b34-0def-4a0b-a07d-30b9271b0166@amd.com>
 <6171f849-4164-4fd5-b31e-79c08df936c2@linux.ibm.com>
 <6b2d502d-08ef-4008-8399-f5630de2385c@amd.com>
 <cbbc63ba-0c21-4fd9-b701-d79356b75d12@amd.com>
 <79783c4d-13cb-4ae9-b2ba-45c066fb515a@linux.ibm.com>
 <f54a9107-a19f-47b8-83ee-6ebe0d305499@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <f54a9107-a19f-47b8-83ee-6ebe0d305499@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY1P220CA0009.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59d::7) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|MW6PR12MB8950:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ac2ec6a-67ae-4c83-d673-08de8a97a3d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0cKvsm0Pu5KEEIl25d2bfp8fO3kYoX8UK7F5pB0kTV5LzCSjgyiSRZk9PaCPB8p9Jzvyg8z5Bw67BafYaklwLXUzD8fsPccGFCWlsQKpQFKI7MB2CJ8gV5poYQ275F+yAZAasFmoMESPUazXqHc7B7naZbypSHz166BDCHxvzwHfcnMVu1YULbh87eDrHg1Y08UV0MwwOBWnGSfMugfGVqd/7IuutPjhnFNZtg6Db4iAx0mmTS8ipC60dFT0w2IiXZQxZGHo/VqKpBINggQ//unF8h5vD9GcreYfXXIH2bM8z03cXmT3ClE0nuFROB1qJJBJprLJSRbI0CGA+yCuIUkTCH9aOyXlIlCwPL6OHmxOYvMPiZHTRZznO37j8MFFVe1gMFb3c+jYqSdAOAiJpAMz0EImOISBt84uGJuVCmt/gP3its9ZNkg07o7y+uod9ujjWR69y7WGq2e653F0Krc4uKXjcDfNyyuYRkWacNtFqFnruiaeVL2LZ5ig3/TnfBCwx9UXxrW6OXBWAhq1jkx1OoCMorK/s/1hvRHF8fh6tRFgShSS1tG5zRIThi9WP49zjjKpGwSe5k4KGZI1wKz0LP92KDvk7ZuqxGQ9k8SipXHqgf+KIbadH4EG46aDRx6FBny2+pJ9EqZ4+/0+FEs95p0vHeJ3GhBSqD78cc48+3yqohZ14r/CR8Mx/cUgABMJq+BypoCF1vrw+WZFS+TFICnVp+I4vKSGHUid9MI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5112.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1N2eDZlUk0wSXhXbUY4OS90TXVBbTBNZ0ZaV2NwR2drWi9MNkNTWlBoZGY4?=
 =?utf-8?B?M05sRGY4OEpHRlVwU2xqVysrZW9CNGtSNlZOKzBJV0xaMlJLNk9lbG1haitt?=
 =?utf-8?B?U3ZDTXJRdHRTZTlrclBscUptVmhxR1RPWHdpMGlKdzZRK21QSTF4bEordlN5?=
 =?utf-8?B?M2RnY28wQmxPY2QrMDVJWm1JUzJ1dXBnbHV3NWxma2IwdmxvYTNuY3RlMTZx?=
 =?utf-8?B?MnBtRkhGSUdqb3Y1aHhrNExvbXRHZVJmOTl4R3dlSHExc21JMmhxclNRR24v?=
 =?utf-8?B?TExHMmszaW11MWFjVDBsZTZZSGwrM0V2SU9qdXZESHVLYkZLVFpTcSs4WHgv?=
 =?utf-8?B?bDZUYUhyb2RTRkxnSUdZQU5RSnY5cFlUQTgrZE5ldUh6Z1hnWlBYa2J4YzNJ?=
 =?utf-8?B?a2JVejNlR3JNeERHc042cXBLZC96MDdidTlTSVhBTFFCVWxzOGx5Ny81d01O?=
 =?utf-8?B?Y052MVJTbUVzUzVaZ2JRS2N5YzdjNFZENEVYYThkbmtrb0FSdEpkTG1YNnlL?=
 =?utf-8?B?M0RaZmE2OFZEODJjK0RzeEVrYjgyajhISzhra1Q0eHZpRVA0b1RiMUJmYU5n?=
 =?utf-8?B?c0FJSFJOU2FYd29QUGdIQkNoYk5Ia1NxV1V4ZTE2UTNvZVFCeVR3UjRUWjd4?=
 =?utf-8?B?YllFY2YyNHNHY1pSREZMaXB3UFJTemFIRzBFZjQ5WStRR0s3MXhOaGRxK0lp?=
 =?utf-8?B?cHBuNm9oVTFQMm5NSXhlMDlPd3NCZHlzcHdNSlU3MHVhR1czR3dabjYvUDdM?=
 =?utf-8?B?b2F0ZW94dHBqYzQwUjNoQll6MTFueDdIT0hiY3RMa1RKdlNUUk5LS2czaWdF?=
 =?utf-8?B?akpxT3JPN050dUh0TDQrOGFoNE40eW03Sk9zZGN6Z0tBK04vdzd5TFUrcXQx?=
 =?utf-8?B?dG9SSWZjQUFFbm55ZS93dXlHMGlNRkVkeGxJVW1Xc2pYd2xKbFg0MCt6cTF0?=
 =?utf-8?B?Z0o0a3JGZkFVanZKa0FKdGcrek5STzlVdTQ1K3JqQ2N3ZDJ3T01ESWQxTlhT?=
 =?utf-8?B?Q1ZJZkwvRDRHZUNITVhteXhidC9mNVFUSHJlYmRKemE5bUJqMnBpRUwwZTQv?=
 =?utf-8?B?Y25BblE2ajNQUVlXY2orQy84TWYzR0g0SzBpMHhCSHVZTU1YR2tCTTFmOHRs?=
 =?utf-8?B?TTBiVmg1ZFBPZTdlOHVXZG1NUHo0aWpJT2tBRGhoQ3NUdzVCMmxOd1hJd2xI?=
 =?utf-8?B?VWs2UmdpSHNwNC9ER0NjODQ5YzFxQWFqelowdnp1eEQ2UTVQQi9RSEN6QjVp?=
 =?utf-8?B?eHhSYllmMzJuU2RtRlZIcHdHVm95Tk4rTkViRmN5OWVla2VqbXpHemVFN3l1?=
 =?utf-8?B?UXRFejkvOWpmcE83dTRDcUw2NFV1bzlkWW1uVWZINzM5ZFI3WC8xRGg5QmFD?=
 =?utf-8?B?Q1l3WHJLdEtvcnhPeDNWenE2N1JXd2pmbXVsSi80bW0ra1N5ZkR1UjZNNi9F?=
 =?utf-8?B?OU1QQzBSZXhiQm1DSkRERVE4MjNPSGUzaERXWnZzQVF1Q0szK0kzZSsrMlZQ?=
 =?utf-8?B?UHUzeW9wZmF1Mmsxc29hQlVqcEtoRGpQM1JjZjArOWFHSEs1RXJsUVBZd2py?=
 =?utf-8?B?ZDNwN2pSWEdhVVhkU2JxajRaQVEvOXd1ZUMyZVl6MTRQbnRXZTM5dXZ1c0pB?=
 =?utf-8?B?bVR0c2g1VSt3WGRGNHFJdVY1QjNjYmszemZhS0Jqdm5jSUpNSjBMbHFPNllJ?=
 =?utf-8?B?Nzc4Y0YvRlZhY0lGV2lEYkt2RmVTU0tCUDdKWkk5S1Fudk5hSmhrV1VqWWFx?=
 =?utf-8?B?SGZPMXR0V3RtbjVIQm1QcEtUZFRla3JScUQ4djZkelh6NGhucUVjQjZpTmUv?=
 =?utf-8?B?bjhucVNsU1JzZUp5RXNSRXZ1TThXZ0ZmRmdOL09nRzdqRDRHYzQ0OHFSTS9M?=
 =?utf-8?B?anpSZ3VUTS9OOWtxZlZrS2RKV29RN1RnNTkvRm5rR1lHSk4xLzBkTHByNU5t?=
 =?utf-8?B?ZjV1WWMzdU16eVRiRGlYK29ENnVrWGRpZVpCcHRLQkJyclBRTmNvUUIrUFZa?=
 =?utf-8?B?K0JibEo4a01ST1VjYkxtWHFBOGZ1b2k4TFg2N1Jvc2xTbUhMdldWVU5SOXhn?=
 =?utf-8?B?MHZkaGJQRTFjSk0wMlBZOG0ya0pCZXNMSGJXcFh1TGJmSVFucEtXL05KeXMz?=
 =?utf-8?B?Yyt3bnNYVUt3aG1XdW9jQTVKdXhFbnhpUnpZYngyVHNLSy9zUnlDSTBrVmlX?=
 =?utf-8?B?WWUwQnp0dEN1azF2ZHArdnRXUHQyaThWN1hpOHVFUU5mcE1EcWtucWdsaTM4?=
 =?utf-8?B?YWN5ejRxVEdxT1NKWjEzMUlDN2U1eTJPVEF6V2Q0SmV3aGFkS0Z3YVJoZ2FB?=
 =?utf-8?B?Z3JwSUJ3d3BSNStYL3VvbFBnYmRLWFd2NGp1YWZHdFVaZEwvWkMyQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ac2ec6a-67ae-4c83-d673-08de8a97a3d5
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 17:55:02.8801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jS7acs18qalW942uUuULCGmOjL68dVkZRq+P/nRD5rJo0TPOm/wc2iWKsBV0gE9AH8gn+im4kAzX1D+92mtt1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8950
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[amd.com,linux.ibm.com,lists.freedesktop.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230376-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[felix.kuehling@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 77C3E32A2CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 2026-03-25 06:29, Christian König wrote:
>> Hi @Christian @Felix
>>
>> Thanks for the review.
>>
>> I have made the suggested change. I am now reserving 64 KB
>> in the  address space for the trap, while allocating
>> only 8 KB for both 4K and 64K page sizes. With this change,
>> I am no longer seeing crashes on either 4K or 64K systems.
>>
>> Does this approach look reasonable to you?
> Looks correct to me, but Felix clearly has the last word on that.

That works for me as well.

Thanks,
   Felix


>
> Regards,
> Christian.
>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index bb276c0ad06d..d5b7061556ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>   #define AMDGPU_VA_RESERVED_SEQ64_SIZE          (2ULL << 20)
>>   #define AMDGPU_VA_RESERVED_SEQ64_START(adev)  (AMDGPU_VA_RESERVED_CSA_START(adev) \
>>                                                   - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE           (2ULL << 12)
>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE           (1ULL << 16)
>>   #define AMDGPU_VA_RESERVED_TRAP_START(adev) (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>                                                   - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>   #define AMDGPU_VA_RESERVED_BOTTOM              (1ULL << 16)
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> index e5b56412931b..035687a17d89 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>> @@ -102,8 +102,8 @@
>>    * The first chunk is the TBA used for the CWSR ISA code. The second
>>    * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>>    */
>> -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>> -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
>> +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
>> +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
>>
>>   #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE               \
>>          (KFD_MAX_NUM_OF_PROCESSES *

