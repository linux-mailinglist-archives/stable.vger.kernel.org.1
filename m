Return-Path: <stable+bounces-230309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFZVBnG6w2nUtgQAu9opvQ
	(envelope-from <stable+bounces-230309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:35:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F9C32314B
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 11:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 56522301EBF9
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D45B3B0AF0;
	Wed, 25 Mar 2026 10:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vE/t5Aub"
X-Original-To: stable@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010068.outbound.protection.outlook.com [52.101.193.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80F33AF670
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 10:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774434614; cv=fail; b=u7lKOFSNJgz3s8YzeaWlI2TIk5HMzg3jIKXfgjvMfh7GDKNpEgxfvJ0YHIPcnVl3cKqV6J1fVujWpRMYcdIFDyNgoDRhc37xTRSZyCYWUZt1qNRTG+Zaw3/mKiFIsRTvNLjnpfvs9Gr3qYUTqRjLlyyMV1e14FUCypnrabiFXLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774434614; c=relaxed/simple;
	bh=pEtBZAOJjPMfvcubILPUbjTbMNBTmOsrNyf5hsZMhGk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TM2sSIjuW7QPXtR5uL3oXZIprb60Cxco7yr8tQXwlgEbSLkS5ICZRCkDXVLNStYdkejbDAOJ8WAYPMF1sQ80whSFhUysuFdz2oi0wCcDo+gXOBqqzNDK+XAuN5GOWpEu+Q2CIiI60CTcagcuXUoaVRjRyNCqVLBlB/CKZm/eUYs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vE/t5Aub; arc=fail smtp.client-ip=52.101.193.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VLgcYlk/BcMdwXolHI9RJcWFI8ewAA7hB/6py7bQxty1zcmp0ShYCrQyp7+7rL2OpcOU0KqD2o5pvZb4KYEF0wvOig6GKb9O1xI3009ray7L5l1gD52O9mSex1EgjbYOKMsKJ6iL2dcqkioE4GD6v4BoA7ifi33h34X8Lr4CthmJ31no4dZ2BJf07xjW8aSN+9ynKE2SX4nbIVmxNm9aZExx86C3YsVO7sKDan6EYvK8QmDtUVxDIMrA0dY4G0ksC1JF9iFvlzIbB8N0lEETsMfIwSZ9yCet58H0mBkiCj5qO7s20NXuszxzQ4vPZ+dbPAUH6t9QD8U1OqzYauHo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPDxsi4FC4oSnVlcCG6cLQwa7QcGfg1T/4DzR9FmhbM=;
 b=MWxOqOHvFPNdtmUMxfE1jERok1iehN2amxhQ3aHNV183rjQtCmiTr6jpmYb+IiJf71ndneJPuHEj6g+x6LGap6s29A6Doo0Xf+JT9KBkMww3qxywAsG0Espws2Iqn8eoFHFLPgSbWG49pc9gUr16LP1WrImiMDiGJeGtXSypMjzLnRPFhFfO2o+igjnLG2C+cikc338JOIBuNCT5F6532qVyHxuQno0pCzlNYOhywtzCKXnrqmBDhjguuVeCRQDYzVrCyVnGflUSNpxYmWzsbx9qI82ehRjJ/oRD4CuVttuksucnZAZMWne4gORdue4S43rJiQvc2X28nAh6icsgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPDxsi4FC4oSnVlcCG6cLQwa7QcGfg1T/4DzR9FmhbM=;
 b=vE/t5AubSh308yF/+/bANWk0PUays6Ph+HltrDKly5PFhsvVLQwyi22zgu3awAk+QKzzg1fLikXokhx38rnxaDY62DEDR9NoCyxs03nABOpaAVu0FkKeLEiWOv7vlFS/G6GsF3ggw4ARoNvTNApx1KPBIMx3/0/29ajYx8XTDkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:30:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Wed, 25 Mar 2026
 10:30:04 +0000
Message-ID: <f54a9107-a19f-47b8-83ee-6ebe0d305499@amd.com>
Date: Wed, 25 Mar 2026 11:29:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND RFC PATCH v3 1/6] drm/amdgpu: Change
 AMDGPU_VA_RESERVED_TRAP_SIZE to 2 PAGE_SIZE pages
To: Donet Tom <donettom@linux.ibm.com>,
 "Kuehling, Felix" <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
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
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <79783c4d-13cb-4ae9-b2ba-45c066fb515a@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0220.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 596623ff-4e61-491f-9938-08de8a597a00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	TbPmmYWFVhFUQdEHJt74VVwZbS7SPlWy/gClZQSfNSn9cFzD+2xYfqmv5iW4oRKVrHsR7llCn+I4yIaN40Jm7OOJ0mu2Dg9GniQgvoMcIfHAmaOR+bSVzFBLOxnf3kNXyFZmnexxyrfOJ+1djdTReVgHFLnrr8gaNVFveNvmccRzNS3CR+0QmKsTZO7vcdlnAfn9s6ai2z4/8NwrNJdfQhpWEcm7kU7H148B97SLTjq5Z1BzaehUmdDOifxrhvWOj8ygW1odI+VQRWJbA6N33qNf7LnRKRjNI+8U3Y7exnv1rkGr7ZT/S1IgVuEeoheXkppSGX3U8/ZuHByYIkXXg8oOnERTfBMEe84ghtZ+FcdMjGSI7EZ0GrwcWegoZf2ebbd1ncaJARu46DLjRi2VLdV6VIBfclk3WFFvMSpsZjOkJqNk/d5517bZ5vunWMMN74GqNGl9/3N9P83Po0dPbYQyOyyyyThq7MDq1qwyz4a2sFcuWNG9K4h2CY2mwSpUhR5ndKzmUeEn+PO3LovAGAL4v3B7a2PYibZufsizfGTu6Ro140D4LfGWiug+m/H566Xz/RMVwL6KEOgpQFCCH5wK7tF5vE91PXrHfiYfPLG9rr9sI23tNltaXHTEVA+njmR3Oq3BrTC7Z13vPyyYP8A+o7UB4ydifwnZ4ZhbgQEtLLc/9dKPnp0ms5zjr8EYTjSohc1vGsXLvAxS/PiSri4ddr++J5txWqCAoaZMAuw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpuc2haUlhWbmdqcW5ZWVIzQnZ4Mk5HVUpBNmU1Y25GZ2VTS21GbXF5UEtC?=
 =?utf-8?B?bkhYY1d3ektkSVNzWjlOMDRMVFllSWlCeVJheU53cGo0T1FrdG16cTZGRTRB?=
 =?utf-8?B?dExGQkZ5K0kxOWhsR0llWjNaQmtKNU0rMXBpSmxPSUFJU3N3UEpQeGU1bS9q?=
 =?utf-8?B?Y0tsQndnZ3pUamhCUElueVIvNER0bHBSeHN2LzdwN1lTb09SSGU4UU1lMnRO?=
 =?utf-8?B?K2F1ZE5XbGdyb3Exd09aZENrY2JmNFp3WTE0T2htSnVibklXVjRGNkI4K3oy?=
 =?utf-8?B?TzhpaGRMd25Sbmc2OWRoMnMxNWtBOHpiYXIyeXZFdnpuZGlKdXhOWGRjVjlm?=
 =?utf-8?B?VUluNDhOdVA0c0pSZ2JoeGhJdWdRSFhBc3doQkdYYXpqcTZLR3NHck4xL202?=
 =?utf-8?B?OS9YejEyanRTRHVLWm9sUjQwWThwZjJBQzZDREJlYkZWWW5zZ3RRUkRVQjFX?=
 =?utf-8?B?dEtBdEgzenBNVHpzdUtmNjhsTUJZVmhEdnI1cnZBQVhlT3VENGF2Y1d5MjJT?=
 =?utf-8?B?UFJsSWJpaCtLN1YwdjBzbWM5ZGxUQjVMQTJTeExwN0RNR0U1OXowbGhNTXBB?=
 =?utf-8?B?OU94eXFtdjZrVTVzc0Qxc1RQbXhoMGl5bWFIVGhPSFNsSmJ6UnlPM1l3SjU4?=
 =?utf-8?B?eVF0OHprYW96V2F0QmdIMzc2OStycE5vZTdWdE5hSU14cWdxKzlYRTZWN0VX?=
 =?utf-8?B?aXdhL2QzTloyRkZsN2k0cjVnejBaQ2JQNWV6b0xMRjNWUzNsZ1NySG0yTk41?=
 =?utf-8?B?dkREVmsxTGRiTXdOM3BPbHljNXAwblQ5VWNLTGl2V05MYjMzckcxeXR6bXZP?=
 =?utf-8?B?c0pXYitFa2M3amd5NHk4eU5paWErZlFNakZXS3BSZk0zMko3SlhjY1I5ZlFj?=
 =?utf-8?B?b2svR2dQYytNbnQ5K2dtc2h2ODBpYTZ0ZWoyRUc2ZEg2c2hxU1BEU0IzSHZ0?=
 =?utf-8?B?emZRN0I5aWlsRnh1UVJ4dVNQUEFRUTJkV1UxTW83ZG1BWXRWdC9PQlkwQUVJ?=
 =?utf-8?B?ZjArRFcvdkg5cXpyS3V3MTd3TkxDWlJkQXhIWFRLdkRXSjhlODZsZjVOM05F?=
 =?utf-8?B?ZDBZbW9KRnBuVGUyS2lGMnFsUERhc3NWdjZEeDVQdFlib1o0ejlhWVhJak56?=
 =?utf-8?B?dE9ELzZXTnpET3FwZ0o0aUVDaFpzblRkeW1kbWpzbUM2TXVvYlhoWEh6ZEFT?=
 =?utf-8?B?emdLSkM1dTZNWnJhNk5DalV0WUdmMHV5TzJ5dXdnMzA2Z2pETUtwaEtMZG1Z?=
 =?utf-8?B?VWdZZnpsbENQQ2ZCUjhlNTFuV3c3dFV2djkrb1ZKdGxKNnZxSzM1N2ZzeXVD?=
 =?utf-8?B?ZUVDOUtUekt4S0ttK1h1RnlDRXcvbVlTSzc0WG1OZGZseHpEcmJ2R29QZ2FL?=
 =?utf-8?B?bFl0d1F0U1dRTnZIUEw3ZmJUSG1obTNiOUpqTVU1N0NScy9FTjFPR3Z4UEFQ?=
 =?utf-8?B?UkhNZW93NUdRNysxcW43M3NXdjUvNDBpUlBaZlJjV0c2dXRaVjlsT0VOblhB?=
 =?utf-8?B?MWJ2dXltU05tcHJBRGhkb1dIbEZadWFmL00rZjZJZXpZTDhuRmFkNlA5ZXc0?=
 =?utf-8?B?L0Q5N2F4NTExV0lkSHNDeVlxakFydzZYT2FmV1U2ZXVmekd1bm9vWEpUT093?=
 =?utf-8?B?Zk5OWlpzUFREMDVhWVVJVDBPY2xqMm1BRityeTNCQjZwWVNLTGdlRnp0dDBD?=
 =?utf-8?B?LzMzanQwWDF6aXZKOGlLV056Y2l6VlloWWRFdENKY2NGV3NjOXZOc0NEMXVK?=
 =?utf-8?B?VkREYVphQVkwa1RzdUVuTXhtVlJpSjJjeTBIbi96ZGRJWjhWY1Jzc09XSDNQ?=
 =?utf-8?B?VDZFK1h4T1BsSTN5c0wzL2s4RzdOSmJrZEhubHVHVjVJK2FWMTN2WFFLTm5a?=
 =?utf-8?B?aTB5bkdibUZyak9Jamw3K2F3ZjB1QStwc3pMb2xBVG9mcGRzYS81ZGtiNWxt?=
 =?utf-8?B?QVcwNnlTVkhVbFJUREx5ZDJnWmtreks5eW1JL1k3bnlubzA2QkluUGlvTldG?=
 =?utf-8?B?M2lteFFLUWMxVjh4Ujg1UVdxZ2g2MEVubURERzdCUW1FcEJEb01sUi8wRE5Q?=
 =?utf-8?B?clkvV2FtWjU1SFo5S1dLT096bXJmTjNia01jamtzS1ZtN3hPRXJKVkFtN1Fp?=
 =?utf-8?B?YXlsRkNyRkQwOGtPUnY2NDdzakZXR2Q0SHAvMk5mcmtzSStjMHpBU1Q0QUlj?=
 =?utf-8?B?dUxrQXlpOEMyTHVHakRaellJR01HQnRkQnFWTFBwM1FQalViUVBHZjlwNkRB?=
 =?utf-8?B?am52bFVMZVZRa1FBL0RpVXlnK1ppbUVyd2cxUkNMdEQwTG9RaHBOVy9yZytr?=
 =?utf-8?Q?QYN0VjjOojHWhPlOBW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596623ff-4e61-491f-9938-08de8a597a00
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:30:03.9974
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PVod3k/EH83oWn9NKVcJ+vB5eh04wz9ybbYwoylV3SoVGOS9OiYFwF4tZ1BNABq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640
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
	FREEMAIL_TO(0.00)[linux.ibm.com,amd.com,lists.freedesktop.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-230309-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[amd.com,gmail.com,linux.ibm.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[christian.koenig@amd.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid]
X-Rspamd-Queue-Id: 19F9C32314B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/25/26 11:26, Donet Tom wrote:
> 
> On 3/25/26 3:04 PM, Christian König wrote:
>> On 3/25/26 03:26, Kuehling, Felix wrote:
>>> On 2026-03-24 14:19, Donet Tom wrote:
>>>> On 3/23/26 6:42 PM, Christian König wrote:
>>>>> On 3/23/26 12:50, Donet Tom wrote:
>>>>>> On 3/23/26 3:41 PM, Christian König wrote:
>>>>>>
>>>>>> Hi Christian
>>>>>>
>>>>>>> On 3/23/26 05:28, Donet Tom wrote:
>>>>>>>> Currently, AMDGPU_VA_RESERVED_TRAP_SIZE is hardcoded to 8KB, while
>>>>>>>> KFD_CWSR_TBA_TMA_SIZE is defined as 2 * PAGE_SIZE. On systems with
>>>>>>>> 4K pages, both values match (8KB), so allocation and reserved space
>>>>>>>> are consistent.
>>>>>>>>
>>>>>>>> However, on 64K page-size systems, KFD_CWSR_TBA_TMA_SIZE becomes 128KB,
>>>>>>>> while the reserved trap area remains 8KB. This mismatch causes the
>>>>>>>> kernel to crash when running rocminfo or rccl unit tests.
>>>>>>>>
>>>>>>>> Kernel attempted to read user page (2) - exploit attempt? (uid: 1001)
>>>>>>>> BUG: Kernel NULL pointer dereference on read at 0x00000002
>>>>>>>> Faulting instruction address: 0xc0000000002c8a64
>>>>>>>> Oops: Kernel access of bad area, sig: 11 [#1]
>>>>>>>> LE PAGE_SIZE=64K MMU=Radix SMP NR_CPUS=2048 NUMA pSeries
>>>>>>>> CPU: 34 UID: 1001 PID: 9379 Comm: rocminfo Tainted: G E
>>>>>>>> 6.19.0-rc4-amdgpu-00320-gf23176405700 #56 VOLUNTARY
>>>>>>>> Tainted: [E]=UNSIGNED_MODULE
>>>>>>>> Hardware name: IBM,9105-42A POWER10 (architected) 0x800200 0xf000006
>>>>>>>> of:IBM,FW1060.30 (ML1060_896) hv:phyp pSeries
>>>>>>>> NIP:  c0000000002c8a64 LR: c00000000125dbc8 CTR: c00000000125e730
>>>>>>>> REGS: c0000001e0957580 TRAP: 0300 Tainted: G E
>>>>>>>> MSR:  8000000000009033 <SF,EE,ME,IR,DR,RI,LE> CR: 24008268
>>>>>>>> XER: 00000036
>>>>>>>> CFAR: c00000000125dbc4 DAR: 0000000000000002 DSISR: 40000000
>>>>>>>> IRQMASK: 1
>>>>>>>> GPR00: c00000000125d908 c0000001e0957820 c0000000016e8100
>>>>>>>> c00000013d814540
>>>>>>>> GPR04: 0000000000000002 c00000013d814550 0000000000000045
>>>>>>>> 0000000000000000
>>>>>>>> GPR08: c00000013444d000 c00000013d814538 c00000013d814538
>>>>>>>> 0000000084002268
>>>>>>>> GPR12: c00000000125e730 c000007e2ffd5f00 ffffffffffffffff
>>>>>>>> 0000000000020000
>>>>>>>> GPR16: 0000000000000000 0000000000000002 c00000015f653000
>>>>>>>> 0000000000000000
>>>>>>>> GPR20: c000000138662400 c00000013d814540 0000000000000000
>>>>>>>> c00000013d814500
>>>>>>>> GPR24: 0000000000000000 0000000000000002 c0000001e0957888
>>>>>>>> c0000001e0957878
>>>>>>>> GPR28: c00000013d814548 0000000000000000 c00000013d814540
>>>>>>>> c0000001e0957888
>>>>>>>> NIP [c0000000002c8a64] __mutex_add_waiter+0x24/0xc0
>>>>>>>> LR [c00000000125dbc8] __mutex_lock.constprop.0+0x318/0xd00
>>>>>>>> Call Trace:
>>>>>>>> 0xc0000001e0957890 (unreliable)
>>>>>>>> __mutex_lock.constprop.0+0x58/0xd00
>>>>>>>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu+0x6fc/0xb60 [amdgpu]
>>>>>>>> kfd_process_alloc_gpuvm+0x54/0x1f0 [amdgpu]
>>>>>>>> kfd_process_device_init_cwsr_dgpu+0xa4/0x1a0 [amdgpu]
>>>>>>>> kfd_process_device_init_vm+0xd8/0x2e0 [amdgpu]
>>>>>>>> kfd_ioctl_acquire_vm+0xd0/0x130 [amdgpu]
>>>>>>>> kfd_ioctl+0x514/0x670 [amdgpu]
>>>>>>>> sys_ioctl+0x134/0x180
>>>>>>>> system_call_exception+0x114/0x300
>>>>>>>> system_call_vectored_common+0x15c/0x2ec
>>>>>>>>
>>>>>>>> This patch changes AMDGPU_VA_RESERVED_TRAP_SIZE to 2 * PAGE_SIZE,
>>>>>>>> ensuring that the reserved trap area matches the allocation size
>>>>>>>> across all page sizes.
>>>>>>>>
>>>>>>>> cc: stable@vger.kernel.org
>>>>>>>> Fixes: 34a1de0f7935 ("drm/amdkfd: Relocate TBA/TMA to opposite side of VM hole")
>>>>>>>> Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>>>>>>> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 2 +-
>>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>> index 139642eacdd0..a5eae49f9471 100644
>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>>>>>>>> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>>>>>>>>    #define AMDGPU_VA_RESERVED_SEQ64_SIZE        (2ULL << 20)
>>>>>>>>    #define AMDGPU_VA_RESERVED_SEQ64_START(adev) (AMDGPU_VA_RESERVED_CSA_START(adev) \
>>>>>>>>                             - AMDGPU_VA_RESERVED_SEQ64_SIZE)
>>>>>>>> -#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << 12)
>>>>>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE        (2ULL << PAGE_SHIFT)
>>>>>>> Well using PAGE_SHIFT in amdgpu_vm.h looks quite broken to me.
>>>>>>>
>>>>>>> That makes the GPU VA reservation depend on the CPU page size and that is clearly not something we want to have.
>>>>>>>
>>>>>>> Where is KFD_CWSR_TBA_TMA_SIZE defined?
>>>>>>>
>>>>>> Thanks Christian for reviewing this patch.
>>>>>>
>>>>>> It is defined in kfd_priv.h.
>>>>>>
>>>>>> /*
>>>>>>    * Size of the per-process TBA+TMA buffer: 2 pages
>>>>>>    *
>>>>>>    * The first chunk is the TBA used for the CWSR ISA code. The second
>>>>>>    * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>>>>>>    */
>>>>>> #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
>>>>>>
>>>>>>
>>>>>>
>>>>>> Could you please suggest the correct way to fix this issue?
>>>>> I'm only looking from the POV of the VM code on this, but my educated guess is that KFD_CWSR_TBA_TMA_SIZE should be 8k independent of the CPU page size.
>>>>>
>>>>> Background is that this is written by the shader trap handler and that byte code doesn't care what CPU architecture you have.
>>>>>
>>>>> But I think only the engineers working on that trap handler can really answer this. @Felix / @Philip?
>>>>
>>>> Hi @christian @Felix @Philip
>>>>
>>>> To remove the dependency on CPU page size, can we use
>>>>
>>>> +#define AMDGPU_VA_RESERVED_TRAP_SIZE    (2ULL << 16)
>>>>
>>>> During reservation, we reserve 128 bytes, but during
>>>> allocation, we use 2 * PAGE_SIZE.
>>> We only need two GPU pages here. I think what Christian is objecting to is, that the GPU VM layout should not depend on the CPU page size.
>> Yes, exactly that was my concern.
>>
>>> @Christian, it sounds like the BO allocations happen with 64KB granularity, but the mapping is still using 4KB granularity. Is the right solution to GPU-map only the first 8KB of the trap handler BO to keep the layout the same across CPU architectures?
>> Well that would work technically, but I agree that it also sounds a bit questionable as well.
>>
>>> I guess then the "correct" solution would be to change amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu and amdgpu_amdkfd_gpuvm_map_memory_to_gpu to support mapping of the requested size with GPU page size granularity regardless of the CPU page size. But that would increase complexity for a very niche uses case.
>>>
>>> An easier solution would be to PAGE_ALIGN 8KB to the system page size. But that results in the virtual address space layout to depend on the system page size.
>> Yeah, that dependency is certainly undesirable. We could easily end up with issues which can only be reproduced on systems with 64k page size.
>>
>>> If that's objectionable, then the next best solution is to round up the trap handler size to 64KB byte unconditionally, so its the same with 4KB or 64KB system page size. But that would mean unnecessarily wasting a little memory per process/GPU on x86.
>> How about we always reserve 64KiB address space (or maybe even more, if you reserve 2MiB or 64KiB doesn't matter), but only map as large as the allocated buffer actually is?
>>
>> I think that this would be my preferred solution.
> 
> 
> Hi @Christian @Felix
> 
> Thanks for the review.
> 
> I have made the suggested change. I am now reserving 64 KB
> in the  address space for the trap, while allocating
> only 8 KB for both 4K and 64K page sizes. With this change,
> I am no longer seeing crashes on either 4K or 64K systems.
> 
> Does this approach look reasonable to you?

Looks correct to me, but Felix clearly has the last word on that.

Regards,
Christian.

> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index bb276c0ad06d..d5b7061556ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -173,7 +173,7 @@ struct amdgpu_bo_vm;
>  #define AMDGPU_VA_RESERVED_SEQ64_SIZE          (2ULL << 20)
>  #define AMDGPU_VA_RESERVED_SEQ64_START(adev)  (AMDGPU_VA_RESERVED_CSA_START(adev) \
>                                                  - AMDGPU_VA_RESERVED_SEQ64_SIZE)
> -#define AMDGPU_VA_RESERVED_TRAP_SIZE           (2ULL << 12)
> +#define AMDGPU_VA_RESERVED_TRAP_SIZE           (1ULL << 16)
>  #define AMDGPU_VA_RESERVED_TRAP_START(adev) (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>                                                  - AMDGPU_VA_RESERVED_TRAP_SIZE)
>  #define AMDGPU_VA_RESERVED_BOTTOM              (1ULL << 16)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index e5b56412931b..035687a17d89 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -102,8 +102,8 @@
>   * The first chunk is the TBA used for the CWSR ISA code. The second
>   * chunk is used as TMA for user-mode trap handler setup in daisy-chain mode.
>   */
> -#define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
> -#define KFD_CWSR_TMA_OFFSET (PAGE_SIZE + 2048)
> +#define KFD_CWSR_TBA_TMA_SIZE (AMDGPU_GPU_PAGE_SIZE * 2)
> +#define KFD_CWSR_TMA_OFFSET (AMDGPU_GPU_PAGE_SIZE + 2048)
> 
>  #define KFD_MAX_NUM_OF_QUEUES_PER_DEVICE               \
>         (KFD_MAX_NUM_OF_PROCESSES *
> 
> 
> 
>>
>> Regards,
>> Christian.
>>
>>> Regards,
>>>    Felix
>>>
>>>
>>>>
>>>> -Donet
>>>>
>>>>> Regards,
>>>>> Christian.
>>>>>
>>>>>> -Donet
>>>>>>
>>>>>>> Regards,
>>>>>>> Christian.
>>>>>>>
>>>>>>>>    #define AMDGPU_VA_RESERVED_TRAP_START(adev) (AMDGPU_VA_RESERVED_SEQ64_START(adev) \
>>>>>>>>                             - AMDGPU_VA_RESERVED_TRAP_SIZE)
>>>>>>>>    #define AMDGPU_VA_RESERVED_BOTTOM        (1ULL << 16)


