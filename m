Return-Path: <stable+bounces-127029-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC44A75F00
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 08:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C274167A87
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 06:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 517A214A605;
	Mon, 31 Mar 2025 06:48:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436B333EA
	for <stable@vger.kernel.org>; Mon, 31 Mar 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743403688; cv=fail; b=fxA6nUJHL76i7mt6WFUqK7sr0VP8fTQl11A3RKBUOJICR6Uf7oba2sSiysBQS0MJE3U3T1egunHDrhmnP6HscnszRB7YQ5Hf7PXJHvdN33AdxG1WjdOsc5kBCIWvUMjXGBhto7Ehf1edjfo4MfSVH4Cs49MIyeII2XfRa3oDNM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743403688; c=relaxed/simple;
	bh=EAf2BZURAf9zCd05g7OM/An/hyEJOFRNiwqg+xC+Uy0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rZSl7lNfvWnXuQZA8UE4/A5nBa/cG7riha9Ed8qmoGIvVxiCFV9Zr3frzyVEkTA0Xs3V6SZ4KxggQ+vBPvlAEXsX8fPHtphVMSuEzE+QQK3D/OJoXM4+mOXWGJwvE+LtmNNOUpvTzcwkjf62NItLsM9t3vRCnGF2nOqn1s26WJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V5IX35008674;
	Mon, 31 Mar 2025 06:47:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 45p6311tnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 06:47:53 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YP16SFUKul9SN84CGn7cWTggOJ3CqBnrnG80UuMRLdgAjMe+UnSE8yQOZPCc3GTWSwqMr9zMeFE+gken9FFj6yP961BbEtqLqB9VobPIjGoKiCydLhitooeQ1QQwbRvfr1bhCrXGkf0zFvgG4hZoNmYH2oOsoz46R3v6C4/+6oyn/ncl6sshvABWXQuLAsFcjPWcBwJ+jKyGtb3PdfpBvBAQWJRquT/YydI8u41GUgQEj8iWFUpDkS0UbUeYZsldd7fLiOiKaDfgkgMsPfMnRNIZH/aLVuYk9Jre585U8eQI6qjEWPZszT+EZQsJgPcNr6sCDF8pxFnmB5AqBq7dng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GoHJloD9EmQk/O5OqwDDCWvcr439O87cEW4Hj0mmN/o=;
 b=Tw0T3EsZDkHKdPa6bdF4sC6GN11tMJUJmgzYJNgk78lioJVJuXH2XI8v/Y9OrKDF7BHR+QllB9nHMt94Eieq8rioMmRZWUs0y4CavNzW2X+qDO6oFG4zPCvlDjexm0zlB1l3vd8E59nvy5CiKaCGF05r7WV9cy+DNYwVFqbM9he6AZSt+R4eybDZXYDmWhJ+YfpfeChpQ1CSSfR+DElTSTM0ey3L9SiqZ5qRHjSHuFTuYzW/dFdgEWGpSiTf5/hgpIT8ULoR4KF1lnvDWngBLw7X4An6ZKaNirGxaPpevjiilGEBdoj75bKHaVn/fIB4RgVNGj4imJRtvImne93enw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CH3PR11MB8701.namprd11.prod.outlook.com (2603:10b6:610:1c8::10)
 by MW3PR11MB4586.namprd11.prod.outlook.com (2603:10b6:303:5e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.52; Mon, 31 Mar
 2025 06:47:51 +0000
Received: from CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0]) by CH3PR11MB8701.namprd11.prod.outlook.com
 ([fe80::5727:1867:fb60:69d0%2]) with mapi id 15.20.8534.045; Mon, 31 Mar 2025
 06:47:51 +0000
From: bin.lan.cn@windriver.com
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: bin.lan.cn@windriver.com, sakari.ailus@linux.intel.com,
        u.kleine-koenig@pengutronix.de, hverkuil-cisco@xs4all.nl
Subject: [PATCH 5.10.y] media: i2c: et8ek8: Don't strip remove function when driver is builtin
Date: Mon, 31 Mar 2025 14:47:33 +0800
Message-Id: <20250331064733.3180764-1-bin.lan.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To CH3PR11MB8701.namprd11.prod.outlook.com
 (2603:10b6:610:1c8::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8701:EE_|MW3PR11MB4586:EE_
X-MS-Office365-Filtering-Correlation-Id: d91214f1-3313-4758-89c4-08dd701ff502
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UnIvS2U5OTdKVFE2M2lhNmY3S0N0MEd5TmRGZElVNEFDU1hKRnVCVUtRa21Y?=
 =?utf-8?B?dytBbElvdG9RcTVsa1hQbmRUR3ZRcVoralh3dmJvckhNVTZUa2ZDOG5MMVBu?=
 =?utf-8?B?R0RJWXowMzBlcEhEMTI1MUNWenFucVhua2xTL3c1cUUwcCtLOE8rWDJrQ3BH?=
 =?utf-8?B?bmw5UWdJb1hCSTUyMWZ2Yk9uSXpYQWg5Q3hVYndEdzNxdVBlTlhaL2VKV0Qv?=
 =?utf-8?B?U09DT0dEZkJrbi9YQituYnJTWU9oOFc3dlZZaG5qdm40cUFHSFhoYWdYZHBT?=
 =?utf-8?B?TG1TWVZ0SnZYelJ0UllBUS9jNkN5VXY0NHNibFYvdEw1OE9aZXBNTnZXakhm?=
 =?utf-8?B?NmNwRmdHUnBKZlNKdWxJSUNGNm1KMC8vL2M3cjJ6VmxKa0krQ2lZRHZXK0w0?=
 =?utf-8?B?bzd2RmUrWGlQeDBvQ3N2ci9Sekk0WTN3S3RxNnN6TGIyRHJUM051blRzc1Bv?=
 =?utf-8?B?THpEVytGTXZ6K2UzYU5HVXUycmhaUFBoRFAvdjVjMEdheUFnQ2Mxb3gvV3Nl?=
 =?utf-8?B?YmFyUDRtdi9ST1BOckdNTHd4TzdwWlJ1bWUwRzhDMXJrTEhNbFpIUm9jVXdH?=
 =?utf-8?B?aWk5dUdKdmlwd05KbkZ5LzlMcjcra3hndXFNQU9vK1lqVG8yRHRQTmZvM3Ew?=
 =?utf-8?B?SDJXa2tIUGFMQUE5dEdhVW9FamNnOWxXK0xURE1pTUprOTZzSGNGOUgvbjJV?=
 =?utf-8?B?bGZtKzFndFgxVS9MOWpFdHlHbW16S3ZNbTZERGVlamtjZXRoNkxlaUt3eUtr?=
 =?utf-8?B?R0g5UmtLWW1EYUNRNmNqRDkrVWxIZUdQeVZJL2IrQ1lwaFhmdi9scXhXN3lN?=
 =?utf-8?B?bWo4bkNrNkRmOXpQZWpqbkhldjFtakR5WGk1elVLS3VEN0puZEFBa3MrOHpK?=
 =?utf-8?B?OHQ3U1lhTUpCSWJva09iU2pJRnozU3IrZStLM2JXQ2VQNk5McFczOGxsWXJ1?=
 =?utf-8?B?SlAvTTdRS0pmZTQrRFVURzlzOHVNcTQ0WjgvTnNSck5VaDJZSTZyWnE5Z0N5?=
 =?utf-8?B?TkwyODEybzlrbDdIU3hoUTgrUWs4cnBvL0U2LzVUMWZmckVnTlNIc280WnVx?=
 =?utf-8?B?bXhyK0R0TmYyVjZpYzlkbjB3VDNDcTdZMUgveTFYUFlFUXNMQ3d6TVdXNURJ?=
 =?utf-8?B?OTQvdFoyRWtOdEVYOUtFSTVPQSs5L2s5K0lPT0ErTk4yZFJFbndHK2p3bVJk?=
 =?utf-8?B?YWdlRmxWalFNa2QrRVNYbUs3UkJrU2JVL3NqV0pyMkRVaXFib2VkUzV6REhw?=
 =?utf-8?B?Y3NtbDlIdGJQdUwwVmY0OTJJcFdJRDFvelB5d0I0OEE1c1lCUjdzR2J1MW5S?=
 =?utf-8?B?K0JNZm12NmhkUnhjM3gxd1hwaGtFYWdkV2k1UVFybEd4ZEtXa2F6dy84a1VM?=
 =?utf-8?B?cWYxQWtxMlRnS0xWT1VKNUkvaVd6ZGNvWUwvc2xJbm5ab0JRNzVyZ1Fka2lo?=
 =?utf-8?B?VUo3ZzBISWQxeGpwdWxQNFdDRTQ1b0JqdVBrWnZodnlXVjJYLy92RURWZDBk?=
 =?utf-8?B?ejFZYm9mcy9iK0ZHMkxpeEFDZS9UeWYrNkdkWXZiU1ZTRDgwNHRMSnlmbmh1?=
 =?utf-8?B?aXl6UzhwTGtJRko4U1gyUVA4c3N3UU1GSzZvWDQ0QXZNQmxNQlo2NEIwR2F5?=
 =?utf-8?B?b1dqUEZwcVlUUWwwWCtkaU1MWjlneGk4YUVGR2ZJZENvUXpiTS9EemIzSXRD?=
 =?utf-8?B?STNrYVJvaldkaGx3N2RiWlc1Z2NoQjR5N3JvdjNvQ2ZEcWxneUhFRkRXVVE1?=
 =?utf-8?B?L3Q0QitvWS9vSVRWQ3IyZVcxbFRsZEp6QS9ySXlkVHZ2SmlPSmR5YjV2U1NW?=
 =?utf-8?B?ZnRZTlZ6dHpVTXBUMTQ2cndlR20rR1F5UTBaTFIzVUI1empjcS9wS0xCaERm?=
 =?utf-8?B?Zi9NYzkrWXd2ZitOcnVPbEpzVGV2S3hjaTJkY3pGSU5aNXYrM2NTVmwvZjRE?=
 =?utf-8?Q?cf1U3mL7It5Cl+G2EtnvZ9Tif1iYzZAJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8701.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WXE5L3cxNTV4UXNMQmRxcm5FTHFhd011alhRbktGRzdMOXpiTGtBeHQxd3lp?=
 =?utf-8?B?K0phbjVmR284QUgwMWJreWdyUGw0aXpldkZDbkJKVzlvdGVOejAzazQ1eDQ4?=
 =?utf-8?B?UE1UVk5KdVgzVEdWVG5IK2p6NDNyanY1cjJkcmlvUHJJVUxhQTFqZWtmeFhV?=
 =?utf-8?B?ZWp3OXJIVzhBOGFILzVDT04xYmxhUGRtMXRsVXByWG52WldhU0dvMDVJNWZT?=
 =?utf-8?B?czhyWHVSUjhOc05aRjZ5RFRCajE3RXJKRjdtVkR4VFRiRDdlNWEreUowSGdw?=
 =?utf-8?B?SDEvVG5wMHFQYjNFV2V3THZXZUZUOEtnSmFHMkNXR3VDWURlWDlrMVZFOVlZ?=
 =?utf-8?B?dnBQMVFCTUNMSjFzZE5VUXpYU0plUUFDcHg1b0pxUWlJL3FlWWg4NkNzbmRB?=
 =?utf-8?B?Z2hwWSt3dGhTSUZBTnlkbE4yTGpRTm9saXZEd0tTUmFlSkFZaEFhTjBjeG9u?=
 =?utf-8?B?dW0yeFQrMTkrK0RrcERRaW9RSEMvZGtwS0l6Q2dyZVdNYzBhZ01hNjZ2bGJI?=
 =?utf-8?B?UnhFR1VVUFlHOGhqTWpvTXhoNzg3MFlFVEJZVGszelJQb25uZTd5Q2pQd2R0?=
 =?utf-8?B?dEMyVk9BTk50YlV6U1NPSlBydzZxQXhqS1VZdEVKaHFoU2l3Rm53ZWFadnRO?=
 =?utf-8?B?Y3pETTUwbTl4cXJNZUkrVnJJY0RjZjJCbmEyazczWkltN21RN1V1a3AwTzNQ?=
 =?utf-8?B?NDJCaHoxQU90VCtyZ25nM3F5dXVaNVRMUVB1RXBFU3g4emdZaFBDeGVpQk1l?=
 =?utf-8?B?ZVhLZ25qdHYzNTh5dmg0OFRQRVkvRjg3UzJkczJObzgvMEZMWXdwT0RDWjM3?=
 =?utf-8?B?d0hzdU45SVcwd3ZSaGt2OHBaMTRNRnRCV3hvK3A3SGc5R0t2a0c1eEc1STZU?=
 =?utf-8?B?NzhwRDJGdkRKRmEvTDZaeUlsTEJPUUwwTHplMkg4dXhiSFNtZmNkZWhZM3Nj?=
 =?utf-8?B?MDIxMHBjaVlNYTNJL1FJcWdTN2lUZjEvdjl0UGdFSWJJSHpkYzJGSmtETmsr?=
 =?utf-8?B?K2F0TUJmanUveTdsZzNJYWhpYlcrNzg3MnNGc3BMRk9QM05lSVBMK3hoMENv?=
 =?utf-8?B?aE1YQnQ0eGN5c3E3MUpXRVRCOUpKZU9Dckw1L0pCZjJ1NlhjMFBnMWRJV09N?=
 =?utf-8?B?NUR2ckdHL3IxL3VLOUVTQTFTTHVaZmlXc3JNdGNFc0xHU25kU3NBQlZNeFNh?=
 =?utf-8?B?dXY1SXdpMnZRU3JXZGxaT0FDb1E3b1pwTkxtKzY0aWp3RG1GK0dVZjA0NEdn?=
 =?utf-8?B?NGF5MDlNOFQrWm5rM3hhNUs5UC9vZWNYRUFZMHBueHNaTEpjK2dpNVU1a0ZR?=
 =?utf-8?B?VVhzNXVOODR5U2c0OHhjWHk5OWtJRURHNDlNaFhibUozSG5zQzMyYmlSN0V3?=
 =?utf-8?B?R2E2N0hZUW1KbTRGcnJkMjR1Z3BQZ1pzbW9PaVpCajhBeWQzS3FvSDdhWnhX?=
 =?utf-8?B?cGg3OUd2WHJXSDQzdXQ3aWEvZmRhK0FxWTZQNThBVkZ1YTNCN01RMVZZZnNL?=
 =?utf-8?B?VkM2cWVnWTdwV0ZlV0J0TWZNd3NVSEltSWY2L3N5NS83THV5ZUtaMVJNcDhl?=
 =?utf-8?B?Z3hiVEJkSlpEdTV4ZTZ6RklBV0xMTkVwZUVqUUMvcXNGNWd6eWFGbDBybUtC?=
 =?utf-8?B?YzdNS0FGUTRGdWpPS3BhR0tQOG9PQklHVkJyZFJEQUhTRzJtRG5OSkYrYUs3?=
 =?utf-8?B?U1ZUMVkrRG0vNWRGSWUyM0ptS2ZmWEF5SWlteDdlZVpNVUhoOGtrcVUwT3lw?=
 =?utf-8?B?WWE0L2kxaTJZTGpJUmdibk1kNTFJNmdCSVpmdkZDMENzQW9ENjAybXlUa1dD?=
 =?utf-8?B?aG5MUGtPb1ZGYVE2NHZSeGR1Ynk3aFFGREMyU1p3OHQ2YUkzOEJFTHBUYlBt?=
 =?utf-8?B?czFRMFFYM3hXOURidTRkbFI4eFEvdHl4bkxhTlloK2hHYThvWmxaUGY4WHdy?=
 =?utf-8?B?RGxlbjg1VW96cURvcnRPSlRGTEFyZTBOeURzaVFZNlRyS1ZHQ0t5MEhVcmNS?=
 =?utf-8?B?OU4zSGVmUFI2aVl5QXdrTzBXdWZ6a0h3NHp5MTlQelFLQ1lsZEhjak9qMSsz?=
 =?utf-8?B?MC9vcGt3U0c5Z05ybSsyNDNwcERWSkNyVXdRak90MU9HTWtwR29PaTBuWklm?=
 =?utf-8?B?RXEzZlFFZHVpd2pvVSt0ZjJTWDBXV0lrSnVoVVNSckRZUjRUNklXaXhvTUNq?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d91214f1-3313-4758-89c4-08dd701ff502
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8701.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 06:47:51.5225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a817PCqVeq2oZqoQ6tyyT/sNhNIosLhIsmhzdafOMiA9XzXJakT/4uVtE+MpSCwHTYdAn7RPiC1rzR9w263ZMF0m4Q7jLGgIOcpaiTGqHQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4586
X-Authority-Analysis: v=2.4 cv=C+npyRP+ c=1 sm=1 tr=0 ts=67ea3a99 cx=c_pps a=l9lnEPKonMfu/vbXsUzXcw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=QyXUC8HyAAAA:8 a=xOd6jRPJAAAA:8 a=t7CeM3EgAAAA:8 a=yxFpyxf4MhevmFWHfCYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: Pf7YlL92HnNQJ2UfV1lkcCriAFGhLAoc
X-Proofpoint-GUID: Pf7YlL92HnNQJ2UfV1lkcCriAFGhLAoc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 mlxlogscore=984 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2502280000
 definitions=main-2503310046

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 545b215736c5c4b354e182d99c578a472ac9bfce ]

Using __exit for the remove function results in the remove callback
being discarded with CONFIG_VIDEO_ET8EK8=y. When such a device gets
unbound (e.g. using sysfs or hotplug), the driver is just removed
without the cleanup being performed. This results in resource leaks. Fix
it by compiling in the remove callback unconditionally.

This also fixes a W=1 modpost warning:

	WARNING: modpost: drivers/media/i2c/et8ek8/et8ek8: section mismatch in reference: et8ek8_i2c_driver+0x10 (section: .data) -> et8ek8_remove (section: .exit.text)

Fixes: c5254e72b8ed ("[media] media: Driver for Toshiba et8ek8 5MP sensor")
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Bin Lan <bin.lan.cn@windriver.com>
Signed-off-by: He Zhe <zhe.he@windriver.com>
---
Build test passed.
---
 drivers/media/i2c/et8ek8/et8ek8_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/i2c/et8ek8/et8ek8_driver.c b/drivers/media/i2c/et8ek8/et8ek8_driver.c
index 256acf73d5ea..4d7c4eac5e20 100644
--- a/drivers/media/i2c/et8ek8/et8ek8_driver.c
+++ b/drivers/media/i2c/et8ek8/et8ek8_driver.c
@@ -1460,7 +1460,7 @@ static int et8ek8_probe(struct i2c_client *client)
 	return ret;
 }
 
-static int __exit et8ek8_remove(struct i2c_client *client)
+static int et8ek8_remove(struct i2c_client *client)
 {
 	struct v4l2_subdev *subdev = i2c_get_clientdata(client);
 	struct et8ek8_sensor *sensor = to_et8ek8_sensor(subdev);
@@ -1504,7 +1504,7 @@ static struct i2c_driver et8ek8_i2c_driver = {
 		.of_match_table	= et8ek8_of_table,
 	},
 	.probe_new	= et8ek8_probe,
-	.remove		= __exit_p(et8ek8_remove),
+	.remove		= et8ek8_remove,
 	.id_table	= et8ek8_id_table,
 };
 
-- 
2.34.1


