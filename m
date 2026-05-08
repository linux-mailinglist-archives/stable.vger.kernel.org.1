Return-Path: <stable+bounces-244693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AJ9xCESW/WnBgAAAu9opvQ
	(envelope-from <stable+bounces-244693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:52:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABC34F3555
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 09:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CCB330031C3
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 07:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B125437DE99;
	Fri,  8 May 2026 07:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g/jODl+e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ENdrczLq"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FC137F73A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778226740; cv=fail; b=FUDSsiZ+mi/alphE3dsSzM2zKUojZ3OWys6uJcqKYDgs8HAmq0WUqFbR1P9gPEkhB3zwwEhspzMQ6Yw6dEqDgvw4YRk0AeKpFkf6l7IqQp3C6IRBruhhHQzprv+95YQX/yeymHGShq3K1U/CuhepFfhAjIaQ+HkEw4Y2MJpU3VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778226740; c=relaxed/simple;
	bh=QSqeNvbWoLzm2o5vS9GY+Rt7QGwcDI63Jfh0ZkUk3k0=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=FeKmAJzEEjS3NGOAuKTmT/W/CA2qZfMYFhZ0qpT8yHp6ClZ8I0U9ATc4915nRYa+6Hu64ekJ/mxgVwQd7l73JZfkVw0cNYZW1Ap90dsMgdf4K7iP8Vx8oHjEdmYKiP7pYI8A2pLAgqSZ5BHDT9HoF4MYKkH3VLdMluD4sFxWTBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g/jODl+e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ENdrczLq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64872NIQ527608;
	Fri, 8 May 2026 07:52:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UKc5Yeg3Ged7OnYnAG+UmjCXizaItIofSk6Vu0XW7rc=; b=
	g/jODl+ewA+h3zGeC5DTrj9xIHXzuWqNfluyl856mdKFY2xN4jnGfMKzdIr+PM60
	FaOqLVN1ZLLM9RoTuvjFlNSBXoEpzSUJBuDemAARpr0XcgQc+An2Yz+4lDjD2Y+S
	veWe560vEl+5njvwYckgCwGO3mpcE1zU8fkxrvHnPxvVPzpyV6DQDujI18DUP7ka
	t7hkoraxGg4kbvf0CQNJsAI5JA5A5Lh1TD/tcZzHh4aLlZS9Pxw05L3o9aPI4Xuo
	1wN0FsQZsE6jSP720EkE0zN7zd9si1c5NVadRfWg75UM/CLPM7ng28ufJJ1EYrxL
	TsCriH3SyBZ1h8CE1GqgFg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e4jb9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 07:52:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6487pOK1030115;
	Fri, 8 May 2026 07:52:11 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4dx579m351-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 May 2026 07:52:11 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYOdr7UakHDgoxXdmaOGBatOFZbgCGjAg4qI5Lndg8p8dbz4TbQ93S/7e3Kh1FX3X85F2auV9rWEto6tqZMVIl00Tg6H7aHjNMOURnYPx2ed4v5tEX6nehmXeC4hXQP7DzBKS9hcmwc9X5RwbHsyYvF6pD8RNxmdP7qQgjqpPcjPKiWudk4zrFlFwN00P2XiCm1MqU4gi8x1mwyVDYw+79tY3ceeWqS0vzoc0MI4zk/fy4kiHtbszEh9Gou8C9YAk2ex3Yx9mviZAJzRPOV+sIVaxbQLE7Qs0VZT03ILKJ/YVoFchbSvVhDncaMtc9H6Ks6lHwJEPi13C/SOVZgGBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKc5Yeg3Ged7OnYnAG+UmjCXizaItIofSk6Vu0XW7rc=;
 b=y0TVyX7uaI5quVtrHGLZ+/DlTNekAQ/Xap0QJ5yYYOnsQ+e6uC3bgEMs/Ar0C+qN9ceWHGbSg0aXjnD+DH0UF5GAXsnXzqBV94tWhZBUp9d9FXgwwoK0tl+2Rz0jr4XxEziTE9qVrsnPV8yJE/83T7954IJWXeUJn8MY4WZxDsGZnjFJx1aiyjUli92afZUjey2lWoGS8DVuEhk5IxBoC4jua4dRqkkr0SAkHVYVUTE8Umr3oIzOvCHRQKozugh4g/5zKwKPoDIZt3xC1HFXTFgR6Bp5JSQegVlDqk/3N6CT95pVUcPImLgfdvRosrCiT4OAbksctAm2SGxFlW7nfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKc5Yeg3Ged7OnYnAG+UmjCXizaItIofSk6Vu0XW7rc=;
 b=ENdrczLq6fqYE8KPIuI1GkJgBK5Ofmc5uKTfEh9/rX3YuY+jauJAzgmbTfBzSIMAtOPGMENufMngQRUKEkZeY/JahdbH+7VrFCIe2KkI1E16YCI+7REKoSyZOlkPD4yqVbZciGVixnd0iuPkU1Z3tU0zvKKqINrzCRVH1ULNhtM=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by CY5PR10MB6095.namprd10.prod.outlook.com (2603:10b6:930:38::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 07:52:08 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%7]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 07:52:08 +0000
Message-ID: <b2cd99e4-2369-44bb-a7fd-0035241ad0d7@oracle.com>
Date: Fri, 8 May 2026 13:22:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0.y,6.18.y 0/2] Backport io_uring commit to affected
To: Pavel Begunkov <asml.silence@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        stable@vger.kernel.org
References: <20260507124253.97596-1-harshit.m.mogalapalli@oracle.com>
 <5fed66f0-ea72-4f36-bf50-2d7c39c4fdeb@kernel.dk>
 <12c809f5-1326-4cd3-9d4d-2bfb011b23e4@kernel.dk>
 <33d232bb-29be-4f6d-b148-3daae9df0776@gmail.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
In-Reply-To: <33d232bb-29be-4f6d-b148-3daae9df0776@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0001.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:4f::6) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|CY5PR10MB6095:EE_
X-MS-Office365-Filtering-Correlation-Id: e11b28d9-6f9a-48cd-3636-08deacd6b459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6x3uIX/hkURi1ntq1teFS44we9OyxKY13Bll0guPK628BiZ2kHmEWtlZeQ2xpOmvgj1cE1okhecYgWdxe1GpTN6vEGHOYPfHZHEAFDd5j1+hD7WRu25kLhR7whSSodJ8uBSaX1jk43Uj5D0vY6ljRjjsQ4lhQ+UAc0sXPCp1esAKTq/w+HCjnJYjRfMBovf7LBVV2ichJ4Fw1HXmSAsbp/l5hVHR2Xg3HGW6nOFtmX4NsVOUVQn0SBWyQSGl1MeNiAIYpTpPfXntsxL50uQWzKWE2X4eMUOycBwfLI3qP4fjPdWiHIlEOfzJ8cDBwOsJkeDRpPH5EBgbBmQeUCZqr9KbKnEWXU8sGFOOhD8r9K2o4Md9KsbOCUpqicEJcp3EES1Cw5TmvRj0epn8oSEvbztrX/fFfWDA4ndK3YdTXgrgNzDDpApDNcbn47/GGLsBW5EGMDKE6PtS/7ZWdZ9xRaZWQK6HGa76nwoWArILC3GL2EGKNwR5PyQy5xaiMHUhaYFvFSaW+GV/aK8lVkFo4ORUG8p5Aa58BHWB7SVqpc+4jVcZxW4s7Z0DBZRF1BjslKTSouwFOcpP5J1+8CEusv6W61CUvSD1oQurO8of3p0LLUyqwTNjfRnjrgZiM6g8bmj1sG8n5dRaOdLVXL7FDg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnU2c2FYbDM5WUlDVk8yd1o1d0duUTl2UHY5MVBMWmUwZXpPTGpVK2Z5bE9U?=
 =?utf-8?B?NE04MGJmTENqSHIzOVlXS0ZZLzNseUdJdnowYzMwZFJoZnN5THA4elJPQ1dN?=
 =?utf-8?B?bDZ1QnhWT0dMZUpIaDE0R0JhcWRmR21Pd1Z6QTY4SDRzOEg0Q2liTE9OTlYy?=
 =?utf-8?B?WWxDR1cxMzZWblR2R3VLRmgxNzZtMHVXbjJjb2x4SW1EM0k4NW1UMkhtMEEy?=
 =?utf-8?B?SWNvN05NNFp3R21aVG9DYzFaTzYrS2tudFhRdEhIQStUNWppY0hiMWdhc0Mz?=
 =?utf-8?B?MTMrTnBBRHN5byttODhDREFwWFMzZjhuREl0K1V5UXo2bm15cmpGZ3gvWWkz?=
 =?utf-8?B?NkNqMTVYK0lsVFptRkN0OFBMakpMYmtlamVsLytYOE8wT3o1NjJEZC9NYUl5?=
 =?utf-8?B?bGZjbjgzTzhydUhIbUVtWFdnSnpHeVFNRDN6NzBZNXBtRkdNYmFwdWpBOS9j?=
 =?utf-8?B?ZXNaZ2dSaFcxd1g2ek1RRFA4MDN5U1F6bFArUktkUk9UMUpaeE1jMnhZYmZV?=
 =?utf-8?B?SHRHU1RWNS9tdTFoUzB0RVZiUC85N2cyamgwNjBUZmtQNzFFUjdKMDY2aUxN?=
 =?utf-8?B?YjVqQmpPNzNNN3JqTHlrUXozTSs3WHBIdG1sWFBPWmZhakhDK0kyQjFPb0Vh?=
 =?utf-8?B?aVZ2d0czQUVQTisvdENLeXVHNUNqZzlxTzZyeUduaGdIOTFOby9XeHpFTXdz?=
 =?utf-8?B?NE5jNERTYjZ4alZ0bExuN0ZJU080K2hONE5aNUhvMnNDcGlQajJXdDBCUmNy?=
 =?utf-8?B?dFhPajNralJ1U29LakgwZnVDMjJZbUpNOUJPb2Q0UGlDY09jeS9BYmRHOXZU?=
 =?utf-8?B?b1ZYak9KOERZWCtiYUF0a3lHaVR1MmlKd2xnT0ZPMUh2YTY4SGdCdS9Sa2Zh?=
 =?utf-8?B?YXNrdEpqV25aNzg2VmRQa2FnUjZGVnlrK0ErQUR6WkRNSlZsYVQ1KytNcXpk?=
 =?utf-8?B?UElLVG41d3NYOXg5NFRoSHAyQ0pIYTJPYWdRazBFOCtDVWxtcG8rRWZ4UlB6?=
 =?utf-8?B?T3p0Vkp6bnhXWDNzOGVGRnE4YVN5NXpsaTNwNlN5cG80UjVLRkhSRWErWXdw?=
 =?utf-8?B?RHBEUzlhNE90RU92S0d0VGRER1UwclNTQ2hEVy9tNlZ5ZVFMakVBaHdqUkdn?=
 =?utf-8?B?WGZ3b3pzbmdPZFpPaHp1Y1c5dmRaUDZXZWpDU0tldWgzWjJxMk1jd0JmQ0cz?=
 =?utf-8?B?L0ZRMW9TdHB0NHJhTWo1amd5cDBhUzBnWHpQaitodjNTanY5ZUVKeFVqNE1O?=
 =?utf-8?B?K2wvOVI1SUtMNjhOZXc3eWE1a3Y4UW5OQk5mUEFGUmhtTTNhSG9VZ2dmOFBj?=
 =?utf-8?B?REUxV2UxU1oybHJodlo1aElVV3RRWGtOeW9sbDNSMnRtTkNSNHdkSDRvVjh2?=
 =?utf-8?B?bEdSS2JVVXhYS3NxVkM4S3ZLVFRKMnBXMEJwS3JKWU0yYmc5VUgwdldRaVpS?=
 =?utf-8?B?WG5RblhrMEhsQWJ5NVdDZmxjUXVkRUtMQXVhT2p6T0YwZG82VmcyN2dkdGNY?=
 =?utf-8?B?REpJSTJSUFc3VGNOWnhiMitpaTJOYlJVNElTVDNhUFAyVGFmZ00wTTJpR2x6?=
 =?utf-8?B?aU9zaTZCcXNUT25hb3ZUWlZBc3ExU09EN01uWFc0UFRvMXhtdVRCcHhzVlZl?=
 =?utf-8?B?dlVNSUJXcmFVb2NqNWgzZElFdWJKajIrOTBYTDlPQzJZOExGMzNXNVVYWEJM?=
 =?utf-8?B?NkltYVdIQnNBQ3ZPY0V4VURDZU1PQWluMEM4cFd6YVh3WUlNODIwbmhyRWIy?=
 =?utf-8?B?aDdCcUlBSE40S1pJZkh6RVhQckN5T3RQaTI0TXNsZ1VqOHZqV3lJblZnbm5m?=
 =?utf-8?B?NE84QkNmVGpLNWhBYzUyNmJwa1FYTGJwY2dYL1QvREdneWx3cW03dHo1TVB6?=
 =?utf-8?B?WER0b3Z0WUZzR3FGL1pBWnZueVQvaHJIcDBabFN2VU1ic1gvVXF0eFZsdTN6?=
 =?utf-8?B?RU00bXFzVzdxcm1zbmNJUjVKR3ptVzVpZ1U0eGxNaXZnNDhoUGlsQWFzaTZt?=
 =?utf-8?B?Smtkd09JNnRnSTdMOHdEM2dCS013R3pPQk9QTWdqMzJWK2pzd3o1RElLSUM0?=
 =?utf-8?B?TS8xQnM5NHdmOFYyV01sNXo0eGFQdDJmU1huZm9pR2VScS9jbXY0QXc2N3ZT?=
 =?utf-8?B?QjQxdEN1dUVLSHRycTlhb21tZkNjMTVTSUVUWHFzSURRcUNzamNSdnlYdGl3?=
 =?utf-8?B?bVBkS3pwc1BjR2piNi8ySDZEUXZGdFJ4c1hZdnBQS1VFWXVsbUxmc0JnL0xj?=
 =?utf-8?B?b2MzamJMRGJ3YjN2QWUwWEMrd1c3RW03OHpERlV6QnhHeTdZVXZwUytyU0Na?=
 =?utf-8?B?YzNMWWFHdkVEVXR1bEpFSXZlRk9tVURpMVdjQ0huL3paY21zOSs2SURxWkpX?=
 =?utf-8?Q?jRBMLw9SL71yKxolEyfZqA4EXVIb/3KHIQ4Dy?=
X-Exchange-RoutingPolicyChecked:
	lrnK9x30bhbNQbcg0a5wcKziWPA/2OeZz2wOwmTJi6xhpJPD8ektX5SKGs1g7VsKykd3UDG/w6HVJ9yqF/DyQSwosQ+V4IRhYWSGQpH31hPuHL2fiDwC1UkHulnTJYmHHRO08W616sfxRz3QgUUNiSqFZ6UoQdJhv/F3VtQQa/+fZd90ba6fkAY8im0yX9eqxijUPwP931rc/oiLBSNlDy5BciRQiM65QLDmPJdTcysoIcgLLqWhFFO2LSSgd/M05DP3pHK7Cfgf552y5xLaGPG7GSX+DvO+hZ38RwY0RSfArtaf1FcXTkkDPYVRFXSwT8MX7NLrdibQC/JhRWE6jw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0E1DuLrLeJfUVYbFkuj3cnU5kbDks/mdhlH/2+VVknaxrP38LjO+BH4/CkyZV1duNnXYN980RThuHUncSH6Z33cKCqI+vJq3viBSFvrw+84UgvtuyLoNXIeNonzph/PbUpgnIzZ8rqOncLzqUbwEaS4lxjT7yRnCyGijkx/bFJofNwuUL67rH5ZaJTAawO6vePkijF//B6m0deATuoHx0bmlI9Sha5P9ggvdd1l3+7ih+Z5XQdmGR+ahVnVHTT4fXg1g1z55ldLzHcnsVV7LKP7M5xAXTWud7aoXCnT8uqzRO1tMv3PMjoOxdXtDdWun4kP3hsIPrrgLttfyOZJahD4c+0VbCjVCABL1+i0Eqn0QaS2eryGONzOeyCnWraQhfTV1op87oLs+lW2L4eoil65NrCc5Cha9hU6sRN44ABVBRrQh9h9zpQwNlEGTcVCrzTx5+yLziwKviaRW4vKeP7zXvstiOARsPyCkki9wj0pndhnOVadTEyEIJ88j17mPRfkMJ5fTpkoouS0PNvRMNMi+DR9Nqv5GdcZn4vUFRPNPHnIMSBXf7tbx9QE8sFl8XohOOHIPJwF0reG5I326NCF9LScdZLUR2nqOgVOu6QU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e11b28d9-6f9a-48cd-3636-08deacd6b459
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2026 07:52:08.3496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QcD8c0dq5kWRFoSnDdEdu6DGFvW461zjvz2bOA94CyMmF+TX49+Lh7DT8oniRUfBJJgiadlc3qbvQVYF8km61UbpdPJdeBJRITqavKcEAkWiKvs1xBSO7tDpUuEEchFx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6095
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2604200000 definitions=main-2605080078
X-Proofpoint-ORIG-GUID: qz56l_rgBdY_zEA0TTMaMr01x8RLfDLG
X-Authority-Analysis: v=2.4 cv=O+YJeh9W c=1 sm=1 tr=0 ts=69fd962c b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=3slly-rGAAAA:8
 a=YMrsih_wQt1GCjrbSCoA:9 a=qcg49hLlgF0N60+LroqrWnV/Vu4=:19 a=QEXdDO2ut3YA:10
 a=TqRHHxeWdYveMAlw628n:22
X-Proofpoint-GUID: qz56l_rgBdY_zEA0TTMaMr01x8RLfDLG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDA3OCBTYWx0ZWRfX/ofu9++fLaP0
 Xs42sKQnRaF+qP1Wr5hYKOLXis+gdNABJu9TkXKsxeqJEpIAdsrqceUw3url93j0M9LtVQ8O+Yr
 VrZ1kD/7f88lAf4uUN/XxYcJ8JtPkcgYwa5JHpPy0vN/oMO9dmcugjZ2xmVwZ+fR/P3RkUn5tsJ
 FiigxgkD3r0xE3bXZOT51Z8JZHnoSd7PP4OC0abcFKWZ0yb/9ezW/q4ny+kNa6J765gxZu77Azi
 DZQSd60Jja2otVoRxwr/sEtihDlm82TdB2b/GGLR5LFEhudxSL8VdIm+XWVrV+sLl/01FmlkFiu
 JIH46ppx4E+dUXzR0p9OhjPxyKWWHtEbNfLDe8xH9CEjVT22rEyF0er6xb6+ZNZZU9JulwjW3RG
 DXFc5+4LM+6L4BcRflw4ev2qkHrBjcgC8j9yG2WorVLI0IFAdgaE0LbNojlaxrAGZdc4T+VwAv/
 zaf7AC2Su7jWUkWSJ3w==
X-Rspamd-Queue-Id: 8ABC34F3555
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.dk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-244693-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[harshit.m.mogalapalli@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

Hi Jens and Pavel,

On 08/05/26 07:37, Pavel Begunkov wrote:
> On 5/7/26 23:46, Jens Axboe wrote:
>> On 5/7/26 4:41 PM, Jens Axboe wrote:
>>> On 5/7/26 6:42 AM, Harshit Mogalapalli wrote:
>>>> Hi Jens and stable maintainers,
>>>>
>>>> The intent of this series is to backport commit: 770594e78c39
>>>> ("io_uring/zcrx: warn on freelist violations") to 6.18.y and 7.0.y.
>>>>
>>>> This above commit likely is fixing commit: 34a3e60821ab ("io_uring/ 
>>>> zcrx:
>>>> implement zerocopy receive pp memory provider") in 6.18.y and 7.0.y.
>>>>
>>>> Pulled in a prerequisite to cleanly apply the fix. Only build tested.
>>>
>>> I don't think these are actually required, but at the same time it does
>>> not hurt to add them. I'll leave that to Pavel to decide.
>>>
>>> In any case, thanks for doing the backports!
>>
>> Adding Pavel, I had assumed he was already on the email, as he's the
>> maintainer for that file.
> 
> What's motivation for this? I don't mind to have it (after review),
> but it's not a fix, and I know people want it in stable to claim a
> hallucinated CVE, and the CVE part is not going to happen.
> 

Sure, thanks for sharing this. I was reading this: 
https://ze3tar.github.io/post-zcrx.html and thought of sending backports 
to affected-stated stable branches. I looked up at the fix and checked 
probable broken commit and sent these backports. If the report is bogus, 
I think we should leave these but if its safe to backport these I think 
we should ?

Thanks,
Harshit


