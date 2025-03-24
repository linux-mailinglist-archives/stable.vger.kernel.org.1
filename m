Return-Path: <stable+bounces-125947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EEBA6DF87
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D08211887A13
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC5B263C6F;
	Mon, 24 Mar 2025 16:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="G+Vr92Eo"
X-Original-To: stable@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D7D2638A6
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833426; cv=fail; b=qTYRoPbBr1XC8yZJsJZd+kwl8uZ1NICVMteXwOT1EmBpcsF2J6kEwfn2xgzI+o9WM27YH+OZe7Lyw/AaZ7aijEX4ICSCIbBp3WEcuAoanRLKUilwJiNCZmPwRQ+vrG1RvO86cFCsSY9Nb+x5kI/8vEVTe8sVlcbm5WMqvyb7CTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833426; c=relaxed/simple;
	bh=ijtUDauUBomF+SO/caQTBpsh187jwpvp+lJihXAs2DM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UyxaLRxVLnXL9OgyfTByhM0BOVJA7CDPT2xuPXZFTHdDIj5ASwjJ30RgGnHqxvaJayjQu/eHMcRlNDG+8dS4erAAB7bzvEOyYUtK1Q9SV+bgpEsdmMwpFeSddbg+NzKkvB5Mb0+vzkNDbin+dTfgMMlOBbjoM376qd9SN9rDscA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=G+Vr92Eo; arc=fail smtp.client-ip=40.107.92.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FhFnhdf+rAEyWwP7qsIAqBIKY/ZMHU0YP/MqY6+HO+SZOMcV0lC3NkoIntUR2zp813Q4FRfstyZ3tGl4kNaIRwQLYPbmPhPg2VgC4VjcOK5OI9EduU85xX17bn91kL4jxYkhf49j2WL1WICLmxCQX0MA4gMEzvgsHqEsqKFlJbiYhxb6KxQxw7g9moI32mSmDIBQT1yfVl6knY2AXFxmcwN+yUFqT4pltu2DBSIArCGRSnklhlqbVv3Igg3wN8/Uu/juZKDDLKafHYqLOB7L7dR9GUbxGL4X5n0iblMOBgsafXv6tdFVZpUDeBrrKYDtjVKYhrfmdmDiHUd7VDhUnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5P4QsEYftjD0VIw1tYNEwEF5bjICOr0FO28dyBXdaUs=;
 b=JJhSnZNJ+prKgoThoIPAbw9mby+1tvMSA0aJ/H2JvkDS6/jB5laiKahHEU5wkmHZPV6sXE5Ely43sHTbbYIuxNDn72WGsCnPa/30NnS5qkZ5UMp3lRecMarL1qrA/MNjIBDu96VBl7R/eXqXS0bTL28ClBccu/wpsiANzfU6nRjNfH+1e+uH8Y/NRDuvgabyCfpnX7uwQWVZ6iO8y1HzXMKzFrFduymm1EmFB6iOK/qDiQX/irZfrjT6j/6WroMXUd6BESc/UjJ6tJLTEK+A2oIs0shMv/kqT51InehZsh9JuzpGRx9l+SKYyx9imEdZMZUVAVBbyxtwixIwb7rMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5P4QsEYftjD0VIw1tYNEwEF5bjICOr0FO28dyBXdaUs=;
 b=G+Vr92Eoi2CkmWPAuXa+tzDeAewkYhqv3XDJKPqvlJuma3V0bIADQWLnzP5iNVCV52M9Mz9ERHAeP9lOKcnOv65Shkx9Celdw3BnZIEYYX9RmmtcNhhF3nCGXeTKOBhMMr8eF9tFEumjhPk6l2ofwgmlFSYVwWOuNEbt53FGQKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM4PR12MB8524.namprd12.prod.outlook.com (2603:10b6:8:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 16:23:41 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 16:23:41 +0000
Message-ID: <18f1de8d-3fd6-40d3-9458-a0d71241d40b@amd.com>
Date: Mon, 24 Mar 2025 11:23:39 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Use HW lock mgr for PSR1
 when only one eDP" failed to apply to 6.6-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: alex.hung@amd.com, alexander.deucher@amd.com, chiahsuan.chung@amd.com,
 daniel.wheeler@amd.com, stable@vger.kernel.org
References: <2025032441-constrain-eastbound-09d8@gregkh>
 <69bf7189-358b-40ca-9b4d-60b61e1b89d7@amd.com>
 <2025032442-quotable-consent-ac5e@gregkh>
 <2025032408-keep-amplifier-ec1e@gregkh>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <2025032408-keep-amplifier-ec1e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:806:27::34) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM4PR12MB8524:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e887ae-63d8-456b-2e4f-08dd6af03d37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk5MNHNlcnNWL3dFTU0xY1ZONytTRS9MY0JQK3lneHVIcE9POFR1QVk1cERI?=
 =?utf-8?B?bnkrTC8waTZoQzM2NUtUWGpCUGpVeUYrL3ZoQ2U4am9QRnhYWXlUOS8rcGh1?=
 =?utf-8?B?NEM0QXFhbUU1R1NWUWRnN1lXa0prbHdzUUU3RGVUam9ueDZMZDRXQkZnZEM0?=
 =?utf-8?B?aTlpL3kydStTalNGUHhnTVo2RDBzMTlIY2J0Tk9CYWhHSXU2ajN1N05YcG9p?=
 =?utf-8?B?ME9Bc3hjUzBTOTYzMXlHVFZCWXFYbXd6OTNZaWNxc2UrQUI3cndGNE4wQzQv?=
 =?utf-8?B?ZVVza2xMS3dDUG16QTVrREpkN01TbmpmTHFFdnQzZjFIalZvTklyMjhHWEdC?=
 =?utf-8?B?Q3dSMVJQVWZGOEZNM1p5N0FKaFlLMnpMWUpFU2tsU1FDbXB0eS9VN3dDN2hy?=
 =?utf-8?B?b2ZFQ2YwZTlHSjgzb1dQdnphdjdjaHo4R0hSZnBRZ1B2UjlnN3pwQi9teTMw?=
 =?utf-8?B?WWl6Si9VdFRvNHhFdFhlQ1VORng2VHIzL3ljejBjdlNZSDhoRWZ2eE8rTHRX?=
 =?utf-8?B?Q0pSODJpS3pBWkFPbkVZbnJRVjdBd2RJcHNsVDRGU010b1pVVmt2SkJMdzBo?=
 =?utf-8?B?UU81eHVJSXYwNm9iN1FkSUhkdHZlUzJ6SUhOejlSYnlBd2VkQjMyRGlrS2NK?=
 =?utf-8?B?ckhzMy85eEdGYlJnakxQME9SeWZ6V3RVRStOV3Y5d2dYVjY0dmMweU5nY3gy?=
 =?utf-8?B?eFpBVjNJbkRCQVlDdk42VVM3MG1DN1hLZkR0OTFaQVZEN0V1ZXJ6YjFlekpY?=
 =?utf-8?B?U0RwRjd2d3RRN2lDZG5RRmx6a00wUFN0ZTF1S2NUVVNYSDhET0I2eERzVkk0?=
 =?utf-8?B?UmpyNmFtU2V6Q3Awa1dTMytlNVhBTnI4ZGZQcWNFemRaazl0ZjArMDBkMUUv?=
 =?utf-8?B?SFR3TGlFdTdoVnQxWXM1MUlkT0dPRjl0REkyYjA0ektmZGtYSWZMbm1GVFR4?=
 =?utf-8?B?dVFYSVVLaDN6dWE5TWRkeSt0WTFVVWprN0dta29ySm5HYnVJSEU0S3ZiUGFi?=
 =?utf-8?B?SG5IY1kzajdNWVhhMC9MNHgvSnp0U3NZUTAwc0VHc00wMDkxbVBXTWJac2Y1?=
 =?utf-8?B?T3J1cWh6U01nYTlUQkVuYjJ4bURaZllBT0grbVBwVHlOQXNKUGJZRmx3QURC?=
 =?utf-8?B?ZUUrZjRmMmpPck1aQXQ2c1dpUjBhVldMS2VEdExmT2ROU3Y2UjkxVHhGdlFM?=
 =?utf-8?B?NklLUTRMQ0l0Z0J5Y01oUFQrUVR5ZkJoTHVVOVJjZVpnY21scHJyRjQ2eXJC?=
 =?utf-8?B?M0xmWWxzRk9HWW4zdm1aQWF1Mm5zZDRqUkJ1SmxheFBoeWlwZ1p0WnI4cEtu?=
 =?utf-8?B?WnM4TzQ0T25aemlONzVkODZteHFFeFdjUDF6WmYzNlpnY0wwS1U0RFNOSHd1?=
 =?utf-8?B?WXJQL2psRXArZ29sbFJZR3plL0dqMUlna1hqVTNIL00yTTVIdTJPZVRiaUxo?=
 =?utf-8?B?YWlVRmtXeEtwaS8rNkRkWDJTblhVSFBaUndVbUtoZ1ZkUnlrcUsvdkcyQkJS?=
 =?utf-8?B?THA5TWpzKzI5R2xKcHJwOTB1OWtTMjB1VW9obWZ1aEdLeGR1Zk9hUjFDNWQ1?=
 =?utf-8?B?R2YwczU5bGtnQnhJYUxCalRBQXFHbXl5eW5JTTZiMUoyU2hxWlpOQlFkOFpq?=
 =?utf-8?B?REJlemYybXpIRmE1aTRWUWsxWStDSk9UdzhSVWw1UEc5ZXl3RFhJc2NsSWkz?=
 =?utf-8?B?a1g0RE1ZeFlPSU56RE1adytURjVSVWo5NFYrRHBqVFBWb1hpYkJaNnVxRUYy?=
 =?utf-8?B?MjU2aTlvT2sydXhJRUdqbGt1cUVkdFVIR0I1VmtQbjFxejJTcGNvNlJDNU1o?=
 =?utf-8?B?WkhMTlpZdDlIR0tQZDR5dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NzJUbFFJMWVQSXBrTWFqVWYrZk9sSUU2bWdrNGpwYWZ5QVRjTGtxQ1dESnJH?=
 =?utf-8?B?SGkvRjdTT0UzYWZKeUQ0UkxIYVkyWGZwaXVDOUhxUUttRGEzMTBDVnRSR0s2?=
 =?utf-8?B?ZTNYSVR5V1FTZUVLL0tsT3AzdFZKSVdtbXJtME92UlByWFlsbVAvekZQQjBB?=
 =?utf-8?B?eFBVUS9LM3FsQnp6MS9zZUptS1ljSXloMjdCb0ZIcHI1NWdhd2NTVFdxbUZ1?=
 =?utf-8?B?enJsMjRwOWsvMTIzOEU5UUhxK2NuSHF1SFRURW93dlNWZzlPbWZ1Umd4clcz?=
 =?utf-8?B?RTMxcWRNNGNFQmsrZk5QK0FsR0llajRiMHY0ZjZ6ZytjR3RneGx4bWxZRWdL?=
 =?utf-8?B?MVlrejkxbUtDSTRxWXBYZzlHV25DdVNCaFdNQmxIR0ZZblBBVXBRcUlWVU5T?=
 =?utf-8?B?Z0RXSEVYUTZZQS9MZkFMTVdVa3lLc01DQzlsVVZScHRxUEZEZ0pxYUN5OTcz?=
 =?utf-8?B?K0hXS3djR2pVdDduVklmZmRxbUJnL1RJU3MrdkFEZE11NzM4MEppR2JPZWFO?=
 =?utf-8?B?NkthM2lLSWdrYW5JS3lQSWpYTnNQS3lSanppY3ZZTzdKQmVjRE0waXNBeXBy?=
 =?utf-8?B?c2NlM21xRCtwQlk3MVM2T1BRS0M0K1Z6QnlTdUhVUTZKeDZuSVVnUDRpOWk0?=
 =?utf-8?B?dG9qUGRVWnBRVlM5Z2M3ZnZiTVlCWTRVNWIyUXJaOWIvZkpQWXB5ZGJJRVI3?=
 =?utf-8?B?QXZiMnlrbzJ1TGV0dTY4bk1BWHdaN081alJDUnRGcXo4NlExUjVBQVJuNmky?=
 =?utf-8?B?dVptd252RVcwQUlpOVJBWHdhWEdiQ1RvRWNjU0wvbUh0WGhWVnNoM2FHS3BD?=
 =?utf-8?B?ZXA1MHIyM0NXRFVVdGoyNFV3NC96VXdwVXV4eFk4VUxKZTEwRUo5YmFsM09T?=
 =?utf-8?B?ejFkNWJJa2VhVGRBSURiT3Z2NFhzN2lUWnNob1pjNlFxdkNEbjN1V25vZVRN?=
 =?utf-8?B?eWpiOGF2dGloeWtxanRaZUxwTnZkemJCbk12aFYxTVp6ekFCYU4rYWd3RXNz?=
 =?utf-8?B?dk5OeEpGa0VWNDZwOFh4R2pQTTFNK3ZLVE5pL0NpUGtDODhpU3RPZ0JFZmdH?=
 =?utf-8?B?bEdKZEZ1Uk5nV1NJZWF2V0NLR3EvQ0NyaWpaV1NZODdzSktQTzBuTEFHbjF6?=
 =?utf-8?B?dHQ2d3hqbno2WHUzckVFSmw1SlpmQ2Q1MDMxTVVaaFB2cnMyVXY0T0o1aC9W?=
 =?utf-8?B?VXBMREZWa2hwYWtkd21MNTFzdGxxejFsWWJUdjNwcXVzZ2JoTTZxT3lPNFh6?=
 =?utf-8?B?eVU0OXJxQ2o0cTVReVVieWM1aXRjSlJFLy9sNkNqUWVWYUpPYVN1N2xYZ2VI?=
 =?utf-8?B?U01FQlVmSW44amFRbFdmV3pFVUpxRkR3WUdmbEJKTVJVTGU1KzQrd0dpUDdm?=
 =?utf-8?B?VEYybFJuNENWampobW5helRjWjJiMk1UZEs0RS85Z2JmbUtvQ0twdmdYRHEz?=
 =?utf-8?B?T0IwdjRGYkhIWGNLYjA0dFp1QnhQM08rd0N3M1ZORnVvQTM2c3VFQTl3QmJX?=
 =?utf-8?B?c2UyZGszbzlOOVdCcTFJSzA4SVo0dldWKzdKd21lWnhKKytIMnFrbkpaZEZY?=
 =?utf-8?B?SjFsRnZHV1RUTWNHUmVUcEdCaHJZdkE1NWxDWVgxSkd6NjZTMlRHNU9Sczh3?=
 =?utf-8?B?cm10R3RqaFJjY0wvU2J2VjRQQ2ZrbzlBMUdwc3pwSVVaT3VmajBiaEprOHdE?=
 =?utf-8?B?VThDY2lsU1NhUmhSYjRSbWd3QW1qaFVkdVdFMkRuTnlnWDJmNFFOQnVIaEd2?=
 =?utf-8?B?RUI1OXlESEZYZzB5eHVuWDY2QXRvekJ6MWJ1a1RDTXQrNHdhZ2Rza3hXcHNZ?=
 =?utf-8?B?YWFVL3hDck9uaVBvaTAxL29HT0dKK05XUFhSUmhodUZxcXR1SmFQUmRZQjB5?=
 =?utf-8?B?TG55SGR1RW5vdTFsTzBDSmR3anJvb2pvTXlYdEFEYTNOWkpRN1BMSmNlL0h0?=
 =?utf-8?B?dnFoQ0ljNmg3Zm5wRXZQVEJVQnpLcGh5Z0JYc08zYS8zZmthMzFtckIrTXMv?=
 =?utf-8?B?WC9QWEhIeDRYMnhGcndjODl5YzcvdjdCdDJaQUF0aGUrc1FTYnJidm9Wd1Jl?=
 =?utf-8?B?OUV2aitIaHIzbU0zcXNNMWprbmFmdGJ1TFI4aUNYZXN3NGRhdzIyNG84eGc4?=
 =?utf-8?Q?6RImo5ftIMwkmyof+BNgqVsbn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e887ae-63d8-456b-2e4f-08dd6af03d37
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 16:23:40.9818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtahrA+1PA6byPBCwuE+qvwuAZjnk+Liz8FZfJiDiPokLyTFqJb/WmgZysdFzerkFS91nvvBK9eC9y65tifqjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8524

On 3/24/2025 11:21, Greg KH wrote:
> On Mon, Mar 24, 2025 at 08:59:49AM -0700, Greg KH wrote:
>> On Mon, Mar 24, 2025 at 10:52:49AM -0500, Mario Limonciello wrote:
>>> On 3/24/2025 10:37, gregkh@linuxfoundation.org wrote:
>>>>
>>>> The patch below does not apply to the 6.6-stable tree.
>>>> If someone wants it applied there, or to any other stable or longterm
>>>> tree, then please email the backport, including the original git commit
>>>> id to <stable@vger.kernel.org>.
>>>>
>>>> To reproduce the conflict and resubmit, you may use the following commands:
>>>>
>>>> git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
>>>> git checkout FETCH_HEAD
>>>> git cherry-pick -x acbf16a6ae775b4db86f537448cc466288aa307e
>>>> # <resolve conflicts, build, test, etc.>
>>>> git commit -s
>>>> git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032441-constrain-eastbound-09d8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
>>>>
>>>> Possible dependencies:
>>>>
>>>>
>>>>
>>>> thanks,
>>>>
>>>> greg k-h
>>>>
>>>
>>> Hi,
>>>
>>> Here is them missing dependency commit.  Cherry-picking this first will let
>>> the fix apply cleanly on 6.6.y:
>>>
>>> commit bfeefe6ea5f1 ("drm/amd/display: should support dmub hw lock on
>>> Replay")
>>
>> That worked, thanks!
> 
> Nope, did not work for 6.1.y, that failed there :(
> 

Yeah I saw both failure emails.  This was only for 6.6.y that it works.
For 6.1.y here is a backport.

https://lore.kernel.org/stable/20250324155629.2588451-1-superm1@kernel.org/T/#u

