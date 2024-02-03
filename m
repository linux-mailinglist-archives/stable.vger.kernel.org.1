Return-Path: <stable+bounces-17788-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1BD847E30
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 02:34:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB107B287E8
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 01:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441431C16;
	Sat,  3 Feb 2024 01:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="l5mhZTzf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NdwaiOcy"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F4A1FCC
	for <stable@vger.kernel.org>; Sat,  3 Feb 2024 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706924034; cv=fail; b=SasnD/AKcxLfFrP9SapC3cY8kXgNx2ZHG/ojbutsdyr6kMSV8BwMuF8zsw9yGn4vzFKbvYPYleMnzQ6C5tNvGfvHOogR8pt03/TQpRF2uRDZiDA+5u6s5sNowzRqmGH1C/g0X4gZ3WgCdSz4BNt5BAKThdFk93+k0DV6Y9Rr4iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706924034; c=relaxed/simple;
	bh=TsT2l4aCeyDS4TpOhNLMEsXXAt1bkPYU+Y+qdd8UKB0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YLiM9AC3XYUgBeiSRAuTD9V+elX/zpONvG0fGs2Zf/HoGoXhvyxvAfz/0K5q7MD6/DYaEwrpVDq6vvBKyEwG6sXPuVa7No22d1f01WHEZpK1nFwUmvWrtKwQEWJ09KdlPzCqmVRQWtEZk5xK9/M7iIFwrqEsDFSN7+w8bF27cr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=l5mhZTzf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NdwaiOcy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4130EPYY010504;
	Sat, 3 Feb 2024 01:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ivsSL28RzbcAIiU5qR5Ga6z3ZKq3pdFrG4eJQJqabrg=;
 b=l5mhZTzfQcrz/hAUhq15z1dk/diREtS1AGYuGrC+1q0UPj0GGFR9eXOkiUfeA71ubH1R
 31ZqobaXaGspG2Mk85BwllZfzyOWzEgMnwknKQiq5/P5fvm/frtPtAPyBF/cX/BSViR6
 HxnZMEuod8AshvqEy59MgGjIdCKfxI0QSuFanNlOx0xongCGYOIqP4sxPMU1Aqs9+kSt
 Q4LH1tvbFN60xlrfSPb8eDtmaLjvhlFxVMaNUvIOPddCo5MnrznpGJ5veLeJ4zbk3Db+
 tstuEqgI2OrKb74CSIj+0X/jxxlFVUIxImdSLLMU1HPhFFKVr9W+rAKsw5Bb86ZxClCN 4A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvseury4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 01:33:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4131XOQW038318;
	Sat, 3 Feb 2024 01:33:41 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3w1bx300ah-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 03 Feb 2024 01:33:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6yf0uxc+YxTFo5owOnnFUQs1UBx5JBWGzFTlbhPm9/GITaZ55239pJ4E1VV/4TNW8X/wmQpdSlEK1eDMbFWi2M8i8YX7mEae3/EDjXy1zz1ItR2aHq1AnsLMpzVA7FeGPKuP+kg/ucOkCO+UttxsHPgr5NstcJBaDpgeb4iIbzUmrHilv1BrfMqmIa/zKxTjrmtE/2KFQOZX+b71+W9OnLIq4FaElwLkOhZ7eTRNkz+sR/I9Uw56wkfmaE5swdLeCbQj1BBM6XojkQ2U+z+lJGsh7BqAGUCE8A8NR3wshrCpR/Wwn2RZ899C69eXhmhTdBb4LVJFUrdP41sQwLlFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivsSL28RzbcAIiU5qR5Ga6z3ZKq3pdFrG4eJQJqabrg=;
 b=dJWtMU6Cnd1L2AtGISIkJpyTVVoK7C0hczhj1T7xTewxorXJvBbJd483/9L9qd4I0dsdME+QW606YdPHNKLN9DBFxOi4wTsr/IycmsGWMVnKiewIknygwQhxr4OdSTST8gdpVgMbxaii+t2aUPmRGE7eSOBwFrfndjX4RptW0dgHk8ZOQbjgJ1yVOP99vyOxXOfBLiUcJBkT5X9CLGhEtTkP33DwWWOQiLXFoTHHiOn5f4YOIHIq+//jgowXRwgjyCuoMxFzM8h/vVXCXzBlzPWi0GLyj1cK4s485uuYORmHEvd0cLOKflcQv+3etgKCYdEtO+b+3NHwt517GY4Etw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivsSL28RzbcAIiU5qR5Ga6z3ZKq3pdFrG4eJQJqabrg=;
 b=NdwaiOcy5q4aoYz+wGvSqoZotLyZY11xBIjvqlvkLbiw03f5pxbFJg2ZLw6kmYqCnEsTEPZKOiop1zlAyktihzo535O2TBc0CLc2wFH38QVs+L4mGwpiOmIVy76Hw3BXliuE4HK0WgH/imRoDhJUixnkluWOH0qerIUNkP4O+1g=
Received: from DM6PR10MB3817.namprd10.prod.outlook.com (2603:10b6:5:1fd::22)
 by PH0PR10MB6981.namprd10.prod.outlook.com (2603:10b6:510:282::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.29; Sat, 3 Feb
 2024 01:33:39 +0000
Received: from DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::ce3:f0f8:1003:30d5]) by DM6PR10MB3817.namprd10.prod.outlook.com
 ([fe80::ce3:f0f8:1003:30d5%3]) with mapi id 15.20.7249.027; Sat, 3 Feb 2024
 01:33:39 +0000
Message-ID: <a602e2cc-292e-40bc-8ab4-8c1b339ccd78@oracle.com>
Date: Fri, 2 Feb 2024 17:33:36 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : Re: [PATCH 6.6.y] selftests/bpf: Remove flaky
 test_btf_id test
Content-Language: en-US
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, harshit.m.mogalapalli@oracle.com,
        yonghong.song@linux.dev, ast@kernel.org
References: <20240202034545.3143734-1-samasth.norway.ananda@oracle.com>
 <2024020204-enchilada-come-ded2@gregkh>
From: samasth.norway.ananda@oracle.com
In-Reply-To: <2024020204-enchilada-come-ded2@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::26) To DM6PR10MB3817.namprd10.prod.outlook.com
 (2603:10b6:5:1fd::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3817:EE_|PH0PR10MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: b7312cc2-bbbb-4a55-7181-08dc245825b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nwQAQwUtecPujpl9sfZ+g2FHIDtUGeYs6i8QJdxIwm+doknppumaRA/KrWlksbcMvAVfC0Mzf0qwsWhZCpNlm71McE2u2BMtiW7CI4pmKuXIpQvfhzmpz4dSikjngN8Owx01sEcrkrfjtuBslYgWI6Hfw7dD2fxQyP8CevheRS1kDptmGWnWWo52hTD49FmdKTAt3WFQbwd81mgdnNbFP8ZnHqiOmYmZ0+de+5ShOycKLRZk7RgJWXHA5MHZA+IPrfgZT36lila/W2Nz6qvQPzEXi3h0LvM5heQL1vsZHAHEKk01YUub2Tj69kZvRHcyLsV1/Abir+foAUksa6r5QTjTNPuD0PDFRpdcYXow4p/l8BxwTSaCv4vC3zToQOkN3FjayqD9txa7IZuGALNPF70nyMBJD2NHOdhLKe7ic1RDER53zmh501pg9cG4IUWIBjFizdYv5Bp/rtr+YRN31rcOLaZ54gSQc8a2LonD95NAmKpeWekha1T/FMp51uNwFr0zvhtQBh9LEVn+Pdw0m5WmWE0rRwYV4J4Fa1ZiE0OWr4JaOrufJB0nr9XUIWNxSop+tgLBX7sPSthHMW0fVRHT4OWye5Ot6EpDgV8+jGA=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3817.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(396003)(366004)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(26005)(36756003)(8936002)(66946007)(31696002)(4326008)(6916009)(316002)(66556008)(2906002)(86362001)(66476007)(8676002)(6486002)(6506007)(38100700002)(53546011)(5660300002)(966005)(83380400001)(6512007)(6666004)(478600001)(9686003)(41300700001)(2616005)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?ajhFNTlYblV5aUUyQlNiWEpSM013VHBkKzUzVHRDSlg5b2FubTVJdFFWR0FS?=
 =?utf-8?B?T1Jobmt2VjBub3JicUgzUy9VcG55dVhJTGc1dEV5ajAzK1doNGlidHQwNWVQ?=
 =?utf-8?B?WU9KWDgzRjk5Um5QSEZVZHZkS09BNG1OMFdMTnY0c2NEZzJ6YVRES3AyVDAz?=
 =?utf-8?B?YithRHpaa2hYdjRKb0h0RkFqM0VHa3dndWdZbWtjRmRBcXlaOGVPUG1LaWZp?=
 =?utf-8?B?R3k0SzROMGl2YkN0ZUVaSjMwMVZ6YVlRd3oxWXlmNE9VSENLMEoxVWZUMUJB?=
 =?utf-8?B?c3N6azFUNnVGRW96RE1oZDZKd3JxdGpadVNiRVA3U0ZXWTZwMHZyRGQreDI3?=
 =?utf-8?B?V0Z3bUZnWkxyK0RsYmY0Ri9SY2xaWVBqSWlXL1lRQkhvcnNNRTR5emEzT0U2?=
 =?utf-8?B?Tk9ISlphcS95cFpMVGpGeGVMY3E0MHg1ZDhMaTNzWlhKM0tqTG51TVR0aTJk?=
 =?utf-8?B?OTBtZ2RzVFdnSCtIdW9zMFEyY1JGenRWbmRzRGJRaW5jYkpmNEE2UjFSYmtY?=
 =?utf-8?B?bXcvWUdKRlhIVmtwWE11ZFI3T1Nxa283RUJ4QVZTcnI2L29PdGxycllkc3R4?=
 =?utf-8?B?dUxObjUrWWE2ZDZycFpCdEs3dklSdng5dE1MUExRNmp6VHB0blhJbE9kWHpQ?=
 =?utf-8?B?MnlCbmlCblVnWDNTYk44T0xUNDdmTm1XOHYxZnpaNEg2YkFXU0FBZU9QM1dp?=
 =?utf-8?B?YndscjRpTVQ3czdsbTQwb2RDSTRGZkhxTWZxbHVER3VVYXJkaUM2TERxY0JQ?=
 =?utf-8?B?SFk2WGp1ejVWL1NaVjJqSTJhbkx4NWVFQTljbHczaHZYUEpPQnErUkZ6VGMv?=
 =?utf-8?B?cmcwaVY2OC9SRXFVTVJDZm42U3Y5TEJTMzVzQSttbU5QWExnM1p1U2JOck9F?=
 =?utf-8?B?UFRMVjRyUW14Qy8xSGZYdGx3UzVaczV6ditUdnV0RXQrTElHMnczRy82YzU4?=
 =?utf-8?B?eTFvMVFSSDR6VmZzb0hnYk44V2FWczc4a01tWDE4NEgyS1RoajdEOUZidFhT?=
 =?utf-8?B?R3cvR2pEWlVZdGh3Vit6N0ErS0VsYmJqcENVcGh3K0w1T095eUZuays1MGpT?=
 =?utf-8?B?NjQwZEF1LzdZWENQZE83NXM2UThDUTFHYjJVTE5qQnZpMHdBK1JSSnJCZmVn?=
 =?utf-8?B?dWF3dlhUc2RWWXlnME0vd0ZCODQ5RitNaEQ2b3dHZXJpMGh1dFlkMGRSUXhK?=
 =?utf-8?B?cUthT0Ezc0s1WjhTQ2t6cVo2SWE2WEowbE1XZEpOMjhMTVczOE5XcDdXMzFE?=
 =?utf-8?B?NTVUeUVCZWl6RjVZWWZFZi9xSHFmSC9HeXZJd2MvTzdtZzRvdG56dGNkSmhR?=
 =?utf-8?B?WW4rRXR2ZU9DbVY4M2kyVjdZZUcvc2k2ZWV5VFo1Z3FvWVFDd3hGa21iZElj?=
 =?utf-8?B?NTBhVUZ2NXNVcG9OMW40bUNaTjV3TjgyNFUxdzJXZjkrdCtOUGhqcElXWTFa?=
 =?utf-8?B?T2luaS9CbG1qQ1c5YTF4M2orejdIOFM1dWdDNjZsWnRvV1dvNWJ2VnVEQmRV?=
 =?utf-8?B?WmN6ZzFsNnNqRUhEaW5CVzhiNUlSa1M2dWFHWVVaOVFTeUE0eTJLZWNmSnVS?=
 =?utf-8?B?UXF5cWdmTWhQWGRvNGVWcFZVWmFMc01OUm1vWWpvcVJnS3lxQzJpY0E4cVVR?=
 =?utf-8?B?Y2l3MjdqeE5YVHEzUWVEbHRyMG9OL0MxVExZeVI0VjdiZitmTG5oUitYSlZu?=
 =?utf-8?B?NU82MitxVXVBcVM2RTFYWURtTzFGU2dNZnphY1VhQkdJNFIrdW9wcGVnRVhr?=
 =?utf-8?B?dzZVTkRZdjVXMGdycFhOSHV6SjN1UTZFYnNtOXZRUjh3eDRQQkdOVEF6T282?=
 =?utf-8?B?ZGp1OEtkcVV5RE9Zc1l5VW5xbjcvUUc1U01PV1NIcE9MUENvN1BMTHY3Nmsv?=
 =?utf-8?B?alpGbEVQdDdlclBPRndoWVlQTHpOejJZT3BLNlI1NWhxQjhuendOMXZ0WkNl?=
 =?utf-8?B?S1VrS0h5cmJvYXRqR0RxYm9OYzVqdlFxZVlQMHo0eUMyaFhOMk1EYkFMSDUy?=
 =?utf-8?B?WTVjaE0xd3Y4UEtVMEJSVzJJUmN4ei9XekV3UWEwVUpiMHpoZVdMSTZyeEtS?=
 =?utf-8?B?WFNuRU5SaStxTEpzRTdJTmdJNUR0d1hPUlk2bGlsbC9ucGhFak11aldIdWg5?=
 =?utf-8?B?dGdydW53ME8zL0JndHdWV0pkbmpxR0M3WU5lTXZmTDlsV1VlRm1DU1IyTDYw?=
 =?utf-8?B?cHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	iuhcNdMKoI+WJMvGsdlLfqypuVKvVs4Q/0MGXqSpUI0AiAlqV3GKajIsUauSk21dg7DSi21OLETsFB2bkSgT8xd9v/sjV+u9IfjAnhYpEL6aGPXCDrTeTXjDARA+uojTZh4t1Nrq1K07a+hv51bcmbEG83d6p+KSB0VAxK/SdIB5rfl0yX1qxwgs9Ro36NbbpM+uEZDtmpyrm7pN13zSBpYh2kcfmcc0lEjrW1Xeki8tG1nYQT5Y5XzXOSiZ8CcfcNSU3Wkp8hQfxBr8r5159QTUeFTkAEwW6ls2V+8VauN1t53CKyPudh5LYv+al1ndBmLBtHKysSvz94XIUgGHBKnU4lmtYcWcWtrr9TQxKtFuUPkGOGFhArLjrTqZX2GhvG533EWTyxwKQHBdEu8fVzCjBJrJz4fcu/phFzrKRX4N/aQl6aoU4z3C5ZgyCu9GSdRTkSQGuqFkzNiOZRCdP3E3AzkSMlNghuwyxYW8MSKOjzikGuM8qIRIjQ/H1m3Dj3PRdSq4CCGUms5Xwckj4yRFQKrDxt0Kb+HbAX71l8nZBWsdVikCAN61cJJqmKbmA+y8lmb2knLOH9IaeMtCMHpWx0EyeaBD69J4I8/h2Xo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7312cc2-bbbb-4a55-7181-08dc245825b6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3817.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2024 01:33:39.0422
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QI2LnFFGVZo07RZfVyqxYz961tbg83pQJhOG+IfYehZmEd27HV2JS329qhWY1IPGGHtxk3bperoj/wp6dDXkg7VlyLCvxs56FKFv+UAKSxnTKL/ri1/Ib0lfH5tVyWpt
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB6981
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402030009
X-Proofpoint-ORIG-GUID: q0jBaNWVNdtzkPIJlgB38QnmQy8DlI0P
X-Proofpoint-GUID: q0jBaNWVNdtzkPIJlgB38QnmQy8DlI0P



On 2/2/24 5:31 PM, Greg KH wrote:
> On Thu, Feb 01, 2024 at 07:45:45PM -0800, Samasth Norway Ananda wrote:
>> From: Yonghong Song <yonghong.song@linux.dev>
>>
>> [ Upstream commit 56925f389e152dcb8d093435d43b78a310539c23 ]
>>
>> With previous patch, one of subtests in test_btf_id becomes
>> flaky and may fail. The following is a failing example:
>>
>>    Error: #26 btf
>>    Error: #26/174 btf/BTF ID
>>      Error: #26/174 btf/BTF ID
>>      btf_raw_create:PASS:check 0 nsec
>>      btf_raw_create:PASS:check 0 nsec
>>      test_btf_id:PASS:check 0 nsec
>>      ...
>>      test_btf_id:PASS:check 0 nsec
>>      test_btf_id:FAIL:check BTF lingersdo_test_get_info:FAIL:check failed: -1
>>
>> The test tries to prove a btf_id not available after the map is closed.
>> But btf_id is freed only after workqueue and a rcu grace period, compared
>> to previous case just after a rcu grade period.
>> Depending on system workload, workqueue could take quite some time
>> to execute function bpf_map_free_deferred() which may cause the test failure.
>> Instead of adding arbitrary delays, let us remove the logic to
>> check btf_id availability after map is closed.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> Link: https://urldefense.com/v3/__https://lore.kernel.org/r/20231214203820.1469402-1-yonghong.song@linux.dev__;!!ACWV5N9M2RV99hQ!I-3G5NyOo-Xom0b0NmUHYWm_hs6Ai1qD4A9smNew_5_8jyyEXbISpxoAPa4wSD_eXQr-IOAd4_TM2NBscejS$
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> [Samasth: backport for 6.6.y]
>> Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
>> ---
>> Above patch is a fix for 59e5791f59dd ("bpf: Fix a race condition between
>> btf_put() and map_free()"). While the commit causing the error is
>> present in 6.6.y the fix is not present.
>> ---
>>   tools/testing/selftests/bpf/prog_tests/btf.c | 5 -----
>>   1 file changed, 5 deletions(-)
> 
> What about 6.7 as well?  Shouldn't this change be there too?

Yes, it should be there on 6.7 as well. Sorry, I should have mentioned that.

Thanks,
Samasth.

> 
> thanks,
> 
> greg k-h

