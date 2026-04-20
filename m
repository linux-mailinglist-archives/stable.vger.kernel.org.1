Return-Path: <stable+bounces-238743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APvRLX4a5mkprgEAu9opvQ
	(envelope-from <stable+bounces-238743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:22:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17C9042A9CB
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 14:22:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12580308E790
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 12:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8163876AB;
	Mon, 20 Apr 2026 12:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="c3vIXsZP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bthaLqs+"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F46387362
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776687615; cv=fail; b=aMvZ3dpnhIFv2kfXFPbQ/BBfaWtU18HmjlECI56ER0dQw9Rry/oG68yJ66eYFRE+03AKZ5PUks9GoHsd4Wl4+GGAKoOW1ojk7sk+PDjBI0wUAcpwaWoIZ7HRsB86tA0ScBPaP6RrIRv1YrPNEAe5CazXpYs/wzkwgdzAzZBPWuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776687615; c=relaxed/simple;
	bh=yt/lY0QusWTj+72PntFOFh6PpnlJb+jfkhbEJ+p6elQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jGQekpQhruBAS0cUFSgopywZrPhSP/gPUcj8nkiFz9wWrrQ2tgWX5S+25U7BYnseSvngB4+cavLrYBnoCtWztkxoDI9vxJvq5IiJunHn2ly5LkKTjWcqjn2dHkyb2Bl6AdHttVE9oUy6eC2OARstimlGbpPEL+yB8Xct6T2HUxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=c3vIXsZP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bthaLqs+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K8RIBN2999214;
	Mon, 20 Apr 2026 12:20:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yt/lY0QusWTj+72PntFOFh6PpnlJb+jfkhbEJ+p6elQ=; b=
	c3vIXsZPhO0Vf7M9ztvTAQdRNZ/DpJFgPvQi0Ru9uq5w0ECqZ3knEx08fM0K3azH
	5TYY9cED6BL4nw0BVOZ/Ot/fi5Jp4lMjD6oF6Kezntf7xzGXtH/g1KySDWFfnme2
	phsmyR3A8WGsnd5F421ybQV0xd+AD2l+yqAQ8JrfpKxlcr2PqHy+W5gknhawFc0m
	UdTtm0yh3dJHhRTvg9A9DK7CZkft2NYKEw7t7giQuogl0FV2sVwnIU7esYxebwM3
	NyPmFetKO4xeifKxJJ7u6e3vDlt2EqroBREbwyZsGh297jv3pZM0b4WuXtkllc8i
	V7QP3j+ofKBPGTi0LRjKKg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dm2grb4qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 12:20:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 63KCGDdu039230;
	Mon, 20 Apr 2026 12:20:10 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011032.outbound.protection.outlook.com [52.101.52.32])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dn18736jm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 12:20:09 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i+VFfTveTIBY7mG0ZRodPZMD+ji/k4JGPIh7Zu3t14Uzx5CR9SrRSr3hrIb2aNoWWQY0quaqpyoLWkjN3gzE2IApeopqO/09OFBShm5XB5SDDYQDoBuhfkpPUm+4MDiLlfygmVbG60oQ5YGBkUmxzqeegg5wK60JxZE6tlGLLemH1619JY+nDEcpBgb0O6JGd5FtKEK+4yrVpKuU9ANSjImusqIHT+HR3KQR5vrCMMSOmr8+n5+0DSClQTi7qQjylRH9AtczwWsJugi2hX8Jk/q5L8q9tAp3Lr4XVmVkru8iof4lsyThSwzSHT9z6b5Cg6UgFAQmwXHYWQUO4AA8Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yt/lY0QusWTj+72PntFOFh6PpnlJb+jfkhbEJ+p6elQ=;
 b=ccQzCDa20JCXKsqnEw8VCh6oJsc9pfCOobueyZbuTRusR+QWNs+GzpTJ45xnxtA9tKsOU3Ym6hLkF3HhKL6Idme5PKEHWtScP2nwxe/nHfhAVoALbRW8qgIP9kHZH8JjlbgaRktYsqmfWpgnwKAtxg2R8RE0aYEWIgcoJSQZYcDIRg9lvbDKF9fJU1Shx0gF/ZzSxKtEHsl3qTEYLKtm9NYfXpcv+wqOFkjXDkYc0OUT+e0jMyWMDv4sfHCj8hjPvPnDoBCw8Ub1bC36UpmoLd0WY75ez6j9BlrKu8M94X6ArXwAjIVDRoLsUensgV0YTobB5yL9aOWPqQ2FTImaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yt/lY0QusWTj+72PntFOFh6PpnlJb+jfkhbEJ+p6elQ=;
 b=bthaLqs+EZcGHBwGU2VdbI1gsGlMBPrv3YFUWmvXjxgJISwaKXZeh6CXK5iHuuvhZKruzxs6q/HWWoNftr3i3PpCvbQ8J0voard+bn72jP18gozuZ2E8sgYpNxQV2xnMP6aFmiD2d0bAAVbXrRLE3aIGg1a0GSvGMr2k/KuxLIM=
Received: from CY8PR10MB6826.namprd10.prod.outlook.com (2603:10b6:930:9d::13)
 by PH7PR10MB7693.namprd10.prod.outlook.com (2603:10b6:510:2e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.32; Mon, 20 Apr
 2026 12:20:05 +0000
Received: from CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63]) by CY8PR10MB6826.namprd10.prod.outlook.com
 ([fe80::f9d3:19ef:4ce8:4d63%2]) with mapi id 15.20.9818.033; Mon, 20 Apr 2026
 12:20:05 +0000
From: Haakon Bugge <haakon.bugge@oracle.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 5.15.y] PCI/ACPI: Restrict program_hpx_type2() to AER bits
Thread-Topic: [PATCH 5.15.y] PCI/ACPI: Restrict program_hpx_type2() to AER
 bits
Thread-Index: AQHcsXr6c4IQAChxZkWUPN7o8jgYE7XoHQYA
Date: Mon, 20 Apr 2026 12:20:05 +0000
Message-ID: <7226713B-8871-40FA-BAA1-6AC5E516AF46@oracle.com>
References: <20260311171736.343422-1-haakon.bugge@oracle.com>
In-Reply-To: <20260311171736.343422-1-haakon.bugge@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Apple Mail (2.3864.400.21)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR10MB6826:EE_|PH7PR10MB7693:EE_
x-ms-office365-filtering-correlation-id: 563d020b-840d-466a-f891-08de9ed72777
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 9NgEWX/pdasncDk+9S3hVkhczFjqP4nqC+Lk3DQUG8pq4LVb0X3768rhyuK53qHpno9QIpq8oVJ/pwdi3r9d04OORQ3fdH/Ukcu7mZghEeufHu640ydHDMmGSzX10Y5T5AwB1cllRiEF5HwiD+BGsgW22aKFzho6Uz2d6Zk8aLcHM51jWxCzU5po6DlBcbF/cCtFeier5Q2hfSjEkz6fsDReZMyf09Tn69c7yfamGiTJ1y65+mV+nyvhoRRKJp4YQayRvcgoevO70dcvkcnRgdicM1un78IzVpqZ9FQV4xXuosdI27vmh7yo0CBAbT6WqViFByYV5N8YJKksM+B5rpZNwXDpFVmxrKKBw4Yxc1e8GrmKFlRXcDtF8QInA4PeG20Fe88cBq5KbdcGneZkpqH/G67HHtoSwxPdVsSttevj1FhVzNYuQFZUuzhCFJk9MxBRjpVFdcMwAZUzHZ5TWvZat0KkgiuP3rxX0IRwrd0li0LLsiuj2Lm0mqD0RMpKI8+1smMTogh/PbeVaG3Vr4lPtvo++5pjbqOKWcgJL8MpRnw31co6BCa2+kbA7fhtwEVQzfg7kWC7YAnnw7xyp7NIPSqEmocVY4QrWm9cJhwbGtw7g3gOrnR5Ym/n6K8sTKUCorGIkws74+XZqOB5pfLIWrhFV12Ru0evmbXcwNnNpVmpaAo5+uLt10KMcPwH5ZjneEn94Jpw9HmydPfztURuJLvV1SaqWxubU3PVOd6WoQarwMWuJIc/ixL/IqAH
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR10MB6826.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWFySTgwaDRLWWp0akdLRUhzMTBXNnd4Mll4NkVqdS92OTUzQ2Jvc1lsVlVO?=
 =?utf-8?B?aHdBb0F1eHVPSHdzQUFHcVlrTVFSYTBiRmk1Z3NWbVpsWlIrMUdDTkVoUlBv?=
 =?utf-8?B?YVhDYUpBa3RjdExORlZHdE1WM28vcWZCK0RLMHJtUTkrS0xidzA3R3owZHpL?=
 =?utf-8?B?RFkyRmQ5WmRlTTIyRWMwejFuZXZldXhJUk9jVzNldmprMnNkMHJiUGdiYTF2?=
 =?utf-8?B?SkhVVkUxa2NxNHovbEpNNHdsdUVLT25lVkNPRm11ZmhCRGZOVGMwZC85NmNo?=
 =?utf-8?B?ak1NV3RPKzVFN2MzR1U2dW5IY3pGYVBsUmNOeXpNamt0cU5BVVlFb1ByNUdu?=
 =?utf-8?B?OFN1dlRxT0VPWSt1WGxsa2xtY2I1NWorYjNPRHJ5bHk0a3M5S3BKWkx3enA2?=
 =?utf-8?B?dkhzamVUZ2JKUEF3U0U2bTB5Uk9Xc1Vka1FrRXR5NjIvZW5MN01jdWJXT0Uy?=
 =?utf-8?B?b0plVEJzcFpaNlIyencveUc0WlEyNWlqYzlYSWQ4UDlHbHlIcDJ4ZlRVUk40?=
 =?utf-8?B?cXJDRFFHbEFQMXNXU1FyT1BmczJ6d1FtOHpYUXZiQVdTakdlYUg5T0FFRG1V?=
 =?utf-8?B?clJEU29FU3l4NDVDcndKQ0djdisvU3VnUlhXR3pYaXBYM2VRQU0xTWE3M3JD?=
 =?utf-8?B?VmJLZXRFN2VBTG5hZ2pBSTVNZGhOS3FaZGhSN1F2TDRyKzRNUExtamVkY1dQ?=
 =?utf-8?B?YzM5N2swOVZkUXpKSE9VUmd4MVVKQS9SMVFvVzZnWk0rZi95T1IvSUMrMXRS?=
 =?utf-8?B?aUd4bEVZeGtVeVpobE40bDBGakt5QUFjUFB4REN5UFc5ZGtrU0lyVDI1R09a?=
 =?utf-8?B?MWYrMmE3VGc0YWlJVUEyWkxZeGd0SFZvcmJhRlFzdHorc2NjVG1NZ1hYd2NL?=
 =?utf-8?B?OXRLYTU2alJPdkVTTkFTVVBROGdQVXl4VnY0WVplZFdyTXZZVmcxKzBaZDR1?=
 =?utf-8?B?NTZTN2RzYi9vRTdRcGYzL1lkSkl6SWNyZWYwODd4bDBJSElqd080T3dEUEFp?=
 =?utf-8?B?NEF5WnVNemNiV1gvY2VxUHF5QnpMVFpkM1I2dy9McCtxRDlmN3hXV28zMTVZ?=
 =?utf-8?B?ejlhVHpYNm1TNU9taFNIV3hEY0NhL1Z3cUlmUElkWGxEOEVBR1g0cWkxaTN4?=
 =?utf-8?B?NDlodExyN01JcFZnS3FoWkIyYk9hMnpOVjloL3BhdkhjUzVCUWtVdW1Xd0N0?=
 =?utf-8?B?Z3FjQzUzcVR4c3lwWnI1K1dwK1lXZldPK1d1S3lMSG5DTXd6WTFLZC8yMVEw?=
 =?utf-8?B?UEVQVmtMY2doR0hHZXBlSkp2NGRTQy9PQnJFZlljTC94a05RWjNzenFBdVdn?=
 =?utf-8?B?QmFCOFhzdmNjZllYdW5udjBiSzJUNEk4SG9VeGsvVU9iM0VzTHpCMWRTSWJN?=
 =?utf-8?B?WjR6Mzc2VlNCV3ZnNy9RMHc2bG9HY2RveFQrdjlUbEp0Y0V0R0lxV2F5L05a?=
 =?utf-8?B?c0xwdnZpTkpTSkloVUFXUTErdXRxSmlrWXo3Kzh0OGluNTA1SU9QMDV6VkdU?=
 =?utf-8?B?VjZzZk5FTnpSRGRwM1c4clVNNlRiVHR2b0JpNFlndFVHSkJMRVlJSVhlUFpF?=
 =?utf-8?B?KzVDdkY2V3BIaWhOVXUrS3E3YmExaEpOZUxmZ0IwV0w4NGFWYTJvbWNWbEtK?=
 =?utf-8?B?RG5hWU1MZ0lNZVZtOWRHSEZoZ1EvMlV0anZyMkNldENJZmQwcDc3WWkxTFFG?=
 =?utf-8?B?UjJsN2Y0S2tacXlNdkJ1Yk4xNjdmaFFwKzBaTER1aVdTWDJZMTlpQ0tSOXd0?=
 =?utf-8?B?K1JFZGtKL3Q2cVNtV2ZhdHhGZ3Y3M0syVXB1VFBvMWhQc1p2S0Q5TjJVZGlU?=
 =?utf-8?B?V1VXeFVVNER2WnRyL2VGbTJTa2NobXJTNXNobk5JaHlrSW5pYTFRWU9kRkdF?=
 =?utf-8?B?WmU3dTNtSitXV1hDemJ2S1ZyME9hVWhGZml5RFB5TDNVNk1hVVBsNkdkQVR3?=
 =?utf-8?B?Vk5tQUFCTHpCMVlGYTB5SlJSOG5vOFl6OVNtOFhaUHVUMHVwRUZ3aGV4U2tj?=
 =?utf-8?B?Ym4rMXcvb2ErbGorV2d5RHZPSUcyZm01eDRZaHpldlczY1B6VkxmVjJtUkNJ?=
 =?utf-8?B?WDdFeFJEa1M5TFZTM2hOUU05cEpkcDZNTThaSHhzRExSZm56ZldGcEJaTEFs?=
 =?utf-8?B?YlJRdjdzVlVGbVdobWppNWZHOElRL1VMelVrTndUZUgyQlp6bmlNZnVROUhM?=
 =?utf-8?B?cCtXRWZzTG54c1QwaWtrZDFpWTl5eFFhUVlBb2hrbHhGWmMwbGo5MlJEQk1a?=
 =?utf-8?B?VU96L2pkSjMvQUwzVjk4NCtDYlZHWmpLUnBtUnZPdHcxUEtzQngyY05PN0Vx?=
 =?utf-8?B?eGpQZzdvRkRWc08yVGpkYStJYldBdDN1VzRYL2hGNWcwUnZnZUdWS2tUM3ly?=
 =?utf-8?Q?5arGr7LnQQS0/uaE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA389A0EAA0F3147BACF15C0540617CD@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	UWvGyIYz9KPITXl9IIaozzxVlb6PlcgWMmyYG72lGlqafyUXE8dqCAgxNN2zEKuxLaWEcJHzVdoAFSuOf7DhK47BdMAgls1hEJAH4ZQMtwmkLJ0LlJj3b3QSd2p+yzJgISMKzpctg/SIusOOMa4z/5ZnW3QptDT/cwA1JCEIRTL/yEJuRDPODWnSKM4hAX7XkE1zoRm6DMYJ8bodcQ+fjLS2IM8jKUB10D3zcq9vxXEXX2qXO6fMJxhWD6RdWRTgMIieGIyXWCAxlRqh+A3s1QEb0MfNQKMCjs7i2E49MyMbTi2tvyZ0wzeagdwnjzewfnujIpQS6z+onSBQmeB9ow==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zhyXN9R7RurG75g0fN1BYg6Zyw4SycEF5kAi7/LszdJwuM5fuRdz5P9pgRxS2mrWs4qTUxn0S/41a7YQqZcIkQFc+hHWlgI1rCF2fQaK5TXKFzZFI7G0NdD/j8pWT1xz2ygKHEROzf4YxvA9q2xvYl3XeehnFHe2K7GsszEXgK7vdRJ/tGpWg8aaGydqwXAs22V4Yd0F9PGM617Y46tTe4hD0jZaZsn3F7vpjgBKWugfq3ObKL3vAKRZTQNmOGCIFYNPk6C7FUAkpw+OPQXZY4wq8laglcOP71ipsq5W7OD4BSvFHJsdk7XTPwsxgnVr8hUKZrBf9HWDDDaeJWH5zpEj9M9itS8Va5wZgdAuX5Q5iSY3kuiVfuCjQf+ZneMHne1hmoYUxypU5oBJEybDyHQCb9KCjhGefvRUTMEcefZOjy5p9EyoRX/T4FBwMWqGzQolA5dHbQ+o93u+q1a3zEPULRpUdLhOfyrSqjdTE5L3RRNx/cmErr/BJDq7TdH9Y8Gdp48ROSBaaKKinEDNUjaMVBKdRn3ldt4IkfmAA6zsh4hzA+PjJtiswZktChC80uF6daCzzpnBH+2+iKkDC4WmOjntUivz2ZP60V1Bnw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR10MB6826.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 563d020b-840d-466a-f891-08de9ed72777
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 12:20:05.0324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nvbdwl27V0acWac/defdNMHNz2H8ThZ95HCHsNuAAk4iv5+CyK5jEIjWxWrnHs9wZuyemh5Pfh36+A8OR6Ok4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7693
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604070000 definitions=main-2604200120
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDEyMCBTYWx0ZWRfX40s0rGfAUFp9
 ZPx53XHU4BkUzRQ8FO7P6GsXoFpQr63KumEiyzIK9NJAbfUKqopbtF5yg270LXLFUToBMlYGJti
 9vIkEG27cE6aDSGmfRVWCYYwr10lTsnX+BrRHJQ2QNIK4JCaXaRSRe52zBy1eHEzh5JsiOnOO1W
 BBCtWU7boR3ueJzRvmtkhYF2lcjcBrnZgGQYsXfJcR4Uev4jmO+y30fTzu7PF+E6jbOq5EoORSP
 qLNu4jGdlC43y53sJq219U8Ag9n0WMk1KTRGZeJNLU+KAaj2UXdG4S2OnAuvo68chlIC+1Ij0cP
 cnvkKN77CV6dENhn5QAGKHt3YNQSKcum42EvVs8/inDI+xeUcBlKUeOiZ+tPOoVLzUU6v0GAgre
 b9GzspZOlPrjZEDqkJrhkap50KsQ9Z3G+Av/sFhj7jWzBTYoMK15qOpLjmaVruridKqWFviWUso
 qgyRQ4uF4m6CLsuC2/A==
X-Authority-Analysis: v=2.4 cv=TN51jVla c=1 sm=1 tr=0 ts=69e619fa cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=7Gl3-_t3PgB9XO-mQDs3:22
 a=bC-a23v3AAAA:8 a=yPCof4ZbAAAA:8 a=1XWaLZrsAAAA:8 a=Drg2qkJOE1I2gPUPBsQA:9
 a=QEXdDO2ut3YA:10 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: DR4mgOGsh4v7PY9Fz5brkneUz6pxSGFq
X-Proofpoint-GUID: DR4mgOGsh4v7PY9Fz5brkneUz6pxSGFq
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-238743-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim,oracle.com:email,oracle.com:dkim,oracle.com:mid,msgid.link:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haakon.bugge@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	APPLE_MAILER(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 17C9042A9CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

PiBjb21taXQgOWFiZjc5YzhkN2I0MGRiMGU1YTM0YWE4Yzc0NGVhNjBmZjlhM2ZjZiB1cHN0cmVh
bS4NCj4gDQo+IFByZXZpb3VzbHkgcHJvZ3JhbV9ocHhfdHlwZTIoKSBhcHBsaWVkIFBDSWUgc2V0
dGluZ3MgdW5jb25kaXRpb25hbGx5LA0KPiB3aGljaCBjb3VsZCBpbmNvcnJlY3RseSBjaGFuZ2Ug
Yml0cyBsaWtlIEV4dGVuZGVkIFRhZyBGaWVsZCBFbmFibGUgYW5kDQo+IEVuYWJsZSBSZWxheGVk
IE9yZGVyaW5nLg0KPiANCj4gV2hlbiBfSFBYIHdhcyBhZGRlZCB0byBBQ1BJIHIzLjAsIHRoZSBp
bnRlbnQgb2YgdGhlIFBDSWUgU2V0dGluZw0KPiBSZWNvcmQgKFR5cGUgMikgaW4gc2VjIDYuMi43
LjMgd2FzIHRvIGNvbmZpZ3VyZSBBRVIgcmVnaXN0ZXJzIHdoZW4gdGhlDQo+IE9TIGRvZXMgbm90
IG93biB0aGUgQUVSIENhcGFiaWxpdHk6DQo+IA0KPiAgVGhlIFBDSSBFeHByZXNzIHNldHRpbmcg
cmVjb3JkIGNvbnRhaW5zIC4uLiBbdGhlIEFFUl0gVW5jb3JyZWN0YWJsZQ0KPiAgRXJyb3IgTWFz
aywgVW5jb3JyZWN0YWJsZSBFcnJvciBTZXZlcml0eSwgQ29ycmVjdGFibGUgRXJyb3IgTWFzaw0K
PiAgLi4uIHRvIGJlIHVzZWQgd2hlbiBjb25maWd1cmluZyByZWdpc3RlcnMgaW4gdGhlIEFkdmFu
Y2VkIEVycm9yDQo+ICBSZXBvcnRpbmcgRXh0ZW5kZWQgQ2FwYWJpbGl0eSBTdHJ1Y3R1cmUgLi4u
DQo+IA0KPiAgT1NQTSBbMV0gd2lsbCBvbmx5IGV2YWx1YXRlIF9IUFggd2l0aCBTZXR0aW5nIFJl
Y29yZCDigJMgVHlwZSAyIGlmDQo+ICBPU1BNIGlzIG5vdCBjb250cm9sbGluZyB0aGUgUENJIEV4
cHJlc3MgQWR2YW5jZWQgRXJyb3IgUmVwb3J0aW5nDQo+ICBjYXBhYmlsaXR5Lg0KPiANCj4gQUNQ
SSByMy4wYiwgc2VjIDYuMi43LjMsIGFkZGVkIG1vcmUgQUVSIHJlZ2lzdGVycywgaW5jbHVkaW5n
IHJlZ2lzdGVycw0KPiBpbiB0aGUgUENJZSBDYXBhYmlsaXR5IHdpdGggQUVSLXJlbGF0ZWQgYml0
cywgYW5kIHRoZSByZXN0cmljdGlvbiB0aGF0DQo+IHRoZSBPUyB1c2UgdGhpcyBvbmx5IHdoZW4g
aXQgb3ducyBQQ0llIG5hdGl2ZSBob3RwbHVnOg0KPiANCj4gIC4uLiB3aGVuIGNvbmZpZ3VyaW5n
IFBDSSBFeHByZXNzIHJlZ2lzdGVycyBpbiB0aGUgQWR2YW5jZWQgRXJyb3INCj4gIFJlcG9ydGlu
ZyBFeHRlbmRlZCBDYXBhYmlsaXR5IFN0cnVjdHVyZSAqb3IgUENJIEV4cHJlc3MgQ2FwYWJpbGl0
eQ0KPiAgU3RydWN0dXJlKiAuLi4NCj4gDQo+ICBBbiBPUyB0aGF0IGhhcyBhc3N1bWVkIG93bmVy
c2hpcCBvZiBuYXRpdmUgaG90IHBsdWcgYnV0IGRvZXMgbm90DQo+ICAuLi4gaGF2ZSBvd25lcnNo
aXAgb2YgdGhlIEFFUiByZWdpc3RlciBzZXQgbXVzdCB1c2UgLi4uIHRoZSBUeXBlIDINCj4gIHJl
Y29yZCB0byBwcm9ncmFtIHRoZSBBRVIgcmVnaXN0ZXJzIC4uLg0KPiANCj4gIEhvd2V2ZXIsIHNp
bmNlIHRoZSBUeXBlIDIgcmVjb3JkIGFsc28gaW5jbHVkZXMgcmVnaXN0ZXIgYml0cyB0aGF0DQo+
ICBoYXZlIGZ1bmN0aW9ucyBvdGhlciB0aGFuIEFFUiwgdGhlIE9TIG11c3QgaWdub3JlIHZhbHVl
cyAuLi4gdGhhdA0KPiAgYXJlIG5vdCBhcHBsaWNhYmxlLg0KPiANCj4gUmVzdHJpY3QgcHJvZ3Jh
bV9ocHhfdHlwZTIoKSB0byBvbmx5IHRoZSBpbnRlbmRlZCBwdXJwb3NlOg0KPiANCj4gIC0gQXBw
bHkgc2V0dGluZ3Mgb25seSB3aGVuIE9TIG93bnMgUENJZSBuYXRpdmUgaG90cGx1ZyBidXQgbm90
IEFFUiwNCj4gDQo+ICAtIE9ubHkgdG91Y2ggdGhlIEFFUi1yZWxhdGVkIGJpdHMgKEVycm9yIFJl
cG9ydGluZyBFbmFibGVzKSBpbiBEZXZpY2UNCj4gICAgQ29udHJvbA0KPiANCj4gIC0gRG9uJ3Qg
dG91Y2ggTGluayBDb250cm9sIGF0IGFsbCwgc2luY2Ugbm90aGluZyB0aGVyZSBzZWVtcyBBRVIt
cmVsYXRlZCwNCj4gICAgYnV0IGxvZyBfSFBYIHNldHRpbmdzIGZvciBkZWJ1Z2dpbmcgcHVycG9z
ZXMNCj4gDQo+IE5vdGUgdGhhdCBSZWFkIENvbXBsZXRpb24gQm91bmRhcnkgaXMgbm93IGNvbmZp
Z3VyZWQgZWxzZXdoZXJlLCBzaW5jZSBpdCBpcw0KPiB1bnJlbGF0ZWQgdG8gX0hQWC4NCj4gDQo+
IFsxXSBPcGVyYXRpbmcgU3lzdGVtLWRpcmVjdGVkIGNvbmZpZ3VyYXRpb24gYW5kIFBvd2VyIE1h
bmFnZW1lbnQNCj4gDQo+IEZpeGVzOiA0MGFiYjk2YzUxYmIgKCJbUEFUQ0hdIHBjaWVocDogRml4
IHByb2dyYW1taW5nIGhvdHBsdWcgcGFyYW1ldGVycyIpDQo+IFNpZ25lZC1vZmYtYnk6IEjDpWtv
biBCdWdnZSA8aGFha29uLmJ1Z2dlQG9yYWNsZS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEJqb3Ju
IEhlbGdhYXMgPGJoZWxnYWFzQGdvb2dsZS5jb20+DQo+IExpbms6IGh0dHBzOi8vcGF0Y2gubXNn
aWQubGluay8yMDI2MDEyOTE3NTIzNy43MjcwNTktMy1oYWFrb24uYnVnZ2VAb3JhY2xlLmNvbQ0K
PiBbIENvbmZsaWN0IGluIGRyaXZlcnMvcGNpLmggYmVjYXVzZSB0aGUgY29udGV4dCBoYXMgY2hh
bmdlZC4gXQ0KPiBTaWduZWQtb2ZmLWJ5OiBIw6Vrb24gQnVnZ2UgPGhhYWtvbi5idWdnZUBvcmFj
bGUuY29tPg0KDQpJIHNlZSB0aGlzIHdhcyBub3QgYWRkZWQgdG8gNS4xNS4yMDMsIGhlbmNlIGEg
Z2VudGxlIHBpbmcgb24gaXQuDQoNCg0KVGh4cywgSMOla29uDQoNCj4gLS0tDQo+IGRyaXZlcnMv
cGNpL3BjaS1hY3BpLmMgfCA1OSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4gZHJpdmVycy9wY2kvcGNpLmggICAgICB8ICAzICsrKw0KPiBkcml2ZXJzL3BjaS9w
Y2llL2Flci5jIHwgIDMgLS0tDQo+IDMgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKSwg
MzggZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLWFjcGku
YyBiL2RyaXZlcnMvcGNpL3BjaS1hY3BpLmMNCj4gaW5kZXggMjY4Y2E5OTg0NDNhZi4uNWU4NjAz
OGYyZWE1ZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvcGNpLWFjcGkuYw0KPiArKysgYi9k
cml2ZXJzL3BjaS9wY2ktYWNwaS5jDQo+IEBAIC0yNDUsMjEgKzI0NSw2IEBAIHN0YXRpYyBhY3Bp
X3N0YXR1cyBkZWNvZGVfdHlwZTFfaHB4X3JlY29yZCh1bmlvbiBhY3BpX29iamVjdCAqcmVjb3Jk
LA0KPiAJcmV0dXJuIEFFX09LOw0KPiB9DQo+IA0KPiAtc3RhdGljIGJvb2wgcGNpZV9yb290X3Jj
Yl9zZXQoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gLXsNCj4gLQlzdHJ1Y3QgcGNpX2RldiAqcnAg
PSBwY2llX2ZpbmRfcm9vdF9wb3J0KGRldik7DQo+IC0JdTE2IGxua2N0bDsNCj4gLQ0KPiAtCWlm
ICghcnApDQo+IC0JCXJldHVybiBmYWxzZTsNCj4gLQ0KPiAtCXBjaWVfY2FwYWJpbGl0eV9yZWFk
X3dvcmQocnAsIFBDSV9FWFBfTE5LQ1RMLCAmbG5rY3RsKTsNCj4gLQlpZiAobG5rY3RsICYgUENJ
X0VYUF9MTktDVExfUkNCKQ0KPiAtCQlyZXR1cm4gdHJ1ZTsNCj4gLQ0KPiAtCXJldHVybiBmYWxz
ZTsNCj4gLX0NCj4gLQ0KPiAvKiBfSFBYIFBDSSBFeHByZXNzIFNldHRpbmcgUmVjb3JkIChUeXBl
IDIpICovDQo+IHN0cnVjdCBocHhfdHlwZTIgew0KPiAJdTMyIHJldmlzaW9uOw0KPiBAQCAtMjg1
LDYgKzI3MCw3IEBAIHN0YXRpYyB2b2lkIHByb2dyYW1faHB4X3R5cGUyKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIHN0cnVjdCBocHhfdHlwZTIgKmhweCkNCj4gew0KPiAJaW50IHBvczsNCj4gCXUzMiBy
ZWczMjsNCj4gKwljb25zdCBzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpob3N0Ow0KPiANCj4gCWlm
ICghaHB4KQ0KPiAJCXJldHVybjsNCj4gQEAgLTI5Miw2ICsyNzgsMTUgQEAgc3RhdGljIHZvaWQg
cHJvZ3JhbV9ocHhfdHlwZTIoc3RydWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IGhweF90eXBlMiAq
aHB4KQ0KPiAJaWYgKCFwY2lfaXNfcGNpZShkZXYpKQ0KPiAJCXJldHVybjsNCj4gDQo+ICsJaG9z
dCA9IHBjaV9maW5kX2hvc3RfYnJpZGdlKGRldi0+YnVzKTsNCj4gKw0KPiArCS8qDQo+ICsJICog
T25seSBkbyB0aGUgX0hQWCBUeXBlIDIgcHJvZ3JhbW1pbmcgaWYgT1Mgb3ducyBQQ0llIG5hdGl2
ZQ0KPiArCSAqIGhvdHBsdWcgYnV0IG5vdCBBRVIuDQo+ICsJICovDQo+ICsJaWYgKCFob3N0LT5u
YXRpdmVfcGNpZV9ob3RwbHVnIHx8IGhvc3QtPm5hdGl2ZV9hZXIpDQo+ICsJCXJldHVybjsNCj4g
Kw0KPiAJaWYgKGhweC0+cmV2aXNpb24gPiAxKSB7DQo+IAkJcGNpX3dhcm4oZGV2LCAiUENJZSBz
ZXR0aW5ncyByZXYgJWQgbm90IHN1cHBvcnRlZFxuIiwNCj4gCQkJIGhweC0+cmV2aXNpb24pOw0K
PiBAQCAtMjk5LDMzICsyOTQsMjcgQEAgc3RhdGljIHZvaWQgcHJvZ3JhbV9ocHhfdHlwZTIoc3Ry
dWN0IHBjaV9kZXYgKmRldiwgc3RydWN0IGhweF90eXBlMiAqaHB4KQ0KPiAJfQ0KPiANCj4gCS8q
DQo+IC0JICogRG9uJ3QgYWxsb3cgX0hQWCB0byBjaGFuZ2UgTVBTIG9yIE1SUlMgc2V0dGluZ3Mu
ICBXZSBtYW5hZ2UNCj4gLQkgKiB0aG9zZSB0byBtYWtlIHN1cmUgdGhleSdyZSBjb25zaXN0ZW50
IHdpdGggdGhlIHJlc3Qgb2YgdGhlDQo+IC0JICogcGxhdGZvcm0uDQo+ICsJICogV2Ugb25seSBh
bGxvdyBfSFBYIHRvIHByb2dyYW0gREVWQ1RMIGJpdHMgcmVsYXRlZCB0byBBRVIsIG5hbWVseQ0K
PiArCSAqIFBDSV9FWFBfREVWQ1RMX0NFUkUsIFBDSV9FWFBfREVWQ1RMX05GRVJFLCBQQ0lfRVhQ
X0RFVkNUTF9GRVJFLA0KPiArCSAqIGFuZCBQQ0lfRVhQX0RFVkNUTF9VUlJFLg0KPiArCSAqDQo+
ICsJICogVGhlIHJlc3Qgb2YgREVWQ1RMIGlzIG1hbmFnZWQgYnkgdGhlIE9TIHRvIG1ha2Ugc3Vy
ZSBpdCdzDQo+ICsJICogY29uc2lzdGVudCB3aXRoIHRoZSByZXN0IG9mIHRoZSBwbGF0Zm9ybS4N
Cj4gCSAqLw0KPiAtCWhweC0+cGNpX2V4cF9kZXZjdGxfYW5kIHw9IFBDSV9FWFBfREVWQ1RMX1BB
WUxPQUQgfA0KPiAtCQkJCSAgICBQQ0lfRVhQX0RFVkNUTF9SRUFEUlE7DQo+IC0JaHB4LT5wY2lf
ZXhwX2RldmN0bF9vciAmPSB+KFBDSV9FWFBfREVWQ1RMX1BBWUxPQUQgfA0KPiAtCQkJCSAgICBQ
Q0lfRVhQX0RFVkNUTF9SRUFEUlEpOw0KPiArCWhweC0+cGNpX2V4cF9kZXZjdGxfYW5kIHw9IH5Q
Q0lfRVhQX0FFUl9GTEFHUzsNCj4gKwlocHgtPnBjaV9leHBfZGV2Y3RsX29yICY9IFBDSV9FWFBf
QUVSX0ZMQUdTOw0KPiANCj4gCS8qIEluaXRpYWxpemUgRGV2aWNlIENvbnRyb2wgUmVnaXN0ZXIg
Ki8NCj4gCXBjaWVfY2FwYWJpbGl0eV9jbGVhcl9hbmRfc2V0X3dvcmQoZGV2LCBQQ0lfRVhQX0RF
VkNUTCwNCj4gCQkJfmhweC0+cGNpX2V4cF9kZXZjdGxfYW5kLCBocHgtPnBjaV9leHBfZGV2Y3Rs
X29yKTsNCj4gDQo+IC0JLyogSW5pdGlhbGl6ZSBMaW5rIENvbnRyb2wgUmVnaXN0ZXIgKi8NCj4g
KwkvKiBMb2cgaWYgX0hQWCBhdHRlbXB0cyB0byBtb2RpZnkgTGluayBDb250cm9sIFJlZ2lzdGVy
ICovDQo+IAlpZiAocGNpZV9jYXBfaGFzX2xua2N0bChkZXYpKSB7DQo+IC0NCj4gLQkJLyoNCj4g
LQkJICogSWYgdGhlIFJvb3QgUG9ydCBzdXBwb3J0cyBSZWFkIENvbXBsZXRpb24gQm91bmRhcnkg
b2YNCj4gLQkJICogMTI4LCBzZXQgUkNCIHRvIDEyOC4gIE90aGVyd2lzZSwgY2xlYXIgaXQuDQo+
IC0JCSAqLw0KPiAtCQlocHgtPnBjaV9leHBfbG5rY3RsX2FuZCB8PSBQQ0lfRVhQX0xOS0NUTF9S
Q0I7DQo+IC0JCWhweC0+cGNpX2V4cF9sbmtjdGxfb3IgJj0gflBDSV9FWFBfTE5LQ1RMX1JDQjsN
Cj4gLQkJaWYgKHBjaWVfcm9vdF9yY2Jfc2V0KGRldikpDQo+IC0JCQlocHgtPnBjaV9leHBfbG5r
Y3RsX29yIHw9IFBDSV9FWFBfTE5LQ1RMX1JDQjsNCj4gLQ0KPiAtCQlwY2llX2NhcGFiaWxpdHlf
Y2xlYXJfYW5kX3NldF93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsDQo+IC0JCQl+aHB4LT5wY2lf
ZXhwX2xua2N0bF9hbmQsIGhweC0+cGNpX2V4cF9sbmtjdGxfb3IpOw0KPiArCQlpZiAoaHB4LT5w
Y2lfZXhwX2xua2N0bF9hbmQgIT0gMHhmZmZmIHx8DQo+ICsJCSAgICBocHgtPnBjaV9leHBfbG5r
Y3RsX29yICE9IDApDQo+ICsJCQlwY2lfaW5mbyhkZXYsICJfSFBYIGF0dGVtcHRzIExpbmsgQ29u
dHJvbCBzZXR0aW5nIChBTkQgJSMwNnggT1IgJSMwNngpXG4iLA0KPiArCQkJCSBocHgtPnBjaV9l
eHBfbG5rY3RsX2FuZCwNCj4gKwkJCQkgaHB4LT5wY2lfZXhwX2xua2N0bF9vcik7DQo+IAl9DQo+
IA0KPiAJLyogRmluZCBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcgRW5oYW5jZWQgQ2FwYWJpbGl0
eSAqLw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmggYi9kcml2ZXJzL3BjaS9wY2ku
aA0KPiBpbmRleCBkOWQ3YTc5ZTM1NjNlLi5lMTYxNGM4ZGMwNGJiIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3BjaS9wY2kuaA0KPiArKysgYi9kcml2ZXJzL3BjaS9wY2kuaA0KPiBAQCAtMTEsNiAr
MTEsOSBAQA0KPiANCj4gI2RlZmluZSBQQ0lfVlNFQ19JRF9JTlRFTF9UQlQJMHgxMjM0CS8qIFRo
dW5kZXJib2x0ICovDQo+IA0KPiArI2RlZmluZSBQQ0lfRVhQX0FFUl9GTEFHUwkoUENJX0VYUF9E
RVZDVExfQ0VSRSB8IFBDSV9FWFBfREVWQ1RMX05GRVJFIHwgXA0KPiArCQkJCSBQQ0lfRVhQX0RF
VkNUTF9GRVJFIHwgUENJX0VYUF9ERVZDVExfVVJSRSkNCj4gKw0KPiBleHRlcm4gY29uc3QgdW5z
aWduZWQgY2hhciBwY2llX2xpbmtfc3BlZWRbXTsNCj4gZXh0ZXJuIGJvb2wgcGNpX2Vhcmx5X2R1
bXA7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpZS9hZXIuYyBiL2RyaXZlcnMv
cGNpL3BjaWUvYWVyLmMNCj4gaW5kZXggYThiZWMxYzNjNzY5YS4uOWI4NmRmNWI4MjM1OSAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvcGNpZS9hZXIuYw0KPiArKysgYi9kcml2ZXJzL3BjaS9w
Y2llL2Flci5jDQo+IEBAIC0yMTQsOSArMjE0LDYgQEAgdm9pZCBwY2llX2VjcmNfZ2V0X3BvbGlj
eShjaGFyICpzdHIpDQo+IH0NCj4gI2VuZGlmCS8qIENPTkZJR19QQ0lFX0VDUkMgKi8NCj4gDQo+
IC0jZGVmaW5lCVBDSV9FWFBfQUVSX0ZMQUdTCShQQ0lfRVhQX0RFVkNUTF9DRVJFIHwgUENJX0VY
UF9ERVZDVExfTkZFUkUgfCBcDQo+IC0JCQkJIFBDSV9FWFBfREVWQ1RMX0ZFUkUgfCBQQ0lfRVhQ
X0RFVkNUTF9VUlJFKQ0KPiAtDQo+IGludCBwY2llX2Flcl9pc19uYXRpdmUoc3RydWN0IHBjaV9k
ZXYgKmRldikNCj4gew0KPiAJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqaG9zdCA9IHBjaV9maW5k
X2hvc3RfYnJpZGdlKGRldi0+YnVzKTsNCj4gLS0NCj4gMi40My41DQo=

