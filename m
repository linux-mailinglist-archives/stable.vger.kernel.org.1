Return-Path: <stable+bounces-217943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHkYBZYBnmkfTAQAu9opvQ
	(envelope-from <stable+bounces-217943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:52:54 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C96D18C3AB
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 20:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0C006303CEEA
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 19:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C46E33032B;
	Tue, 24 Feb 2026 19:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nlTjUP9Q"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2E532AADB;
	Tue, 24 Feb 2026 19:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771962770; cv=fail; b=Qob8tgmudSZf1fUt2ZGcn9R9ppOHC1QVFTBDnSckDF2kDTNZ+PhlaGT+hKNyzlcIkqw4/eHJ8dBYSu6YtMx8iYrUz9ANnac5VE0E8se7oy82zL7XHJlWfLV5GbMV9tVRruPeWJ0RI4TvjFv3xhz5iFtH5OYWwYokydS/NT+r9K4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771962770; c=relaxed/simple;
	bh=OYy4LEwHs+4M9p1Pib18lVB9vUqTgRA0lM9fv4NwXPo=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=qsSJve/Wbd2Ma8sYmpBghw308dx3nG2VllOPTxAil15lt9d3OyUfG7H0EUAR85O3QfDhywx9mLNxKkx+NAPvsQqZ9JApH9SRB3gBL4zl+o9zt3Ei+UdEQzDiMLhp/yT1iuXfSDm/1mnKsZOG+cYkVfnq22j5dlWbgnuwprAwAu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nlTjUP9Q; arc=fail smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61O9L9iw3016712;
	Tue, 24 Feb 2026 19:52:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OYy4LEwHs+4M9p1Pib18lVB9vUqTgRA0lM9fv4NwXPo=; b=nlTjUP9Q
	56JmtkXq45IupKnV89/ShePzO4I4zCofjO07HMKhgpbezGfqn6hE9JtTdaUHoWuy
	x/WVuCvf+lR/vUULcub3t1CNKyClUL4iOfJT4SbvF6Y40wDj6cCqd3/bfFozaoMC
	S5IPBKxGI13XLm7aYvJok2kmNEtlB/M1rP+zt2iTuLqEAu/KvDsJURB7i9rgKSpF
	OxiozKHT4yMxBMGv1xdz7JkIS6BxUipkssOTHpOLVnd4kqsWcEYhwOAnu7rKEIrl
	H+lLG26ns61ldvsJeI/I4eTrCaTD4DMq6u1uilO9CWBHd/A53qwW0ijeFeTQzhUS
	0p7PQohlJewjeg==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013002.outbound.protection.outlook.com [40.93.196.2])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4brvnqn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Feb 2026 19:52:45 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSz5cQiNvFCM6UmnQINc6zrNL5Gd3G3iGCjCyemErazNtVY8REjZuQhaHE9cO/YTuRT+b2LU5YvwT8RruTCJCx4DdIWTFQEUbn9nCSclvTNr+8ohiilPA/omXYy+fxzHehmizUuV+OWjS8wiAmekkXpmylAyzkRWR5HgdGJbthbB2fgfbcneaiOXI30CqiRCvSyaEvxTBfja4SvIuzJY4ONnGYJcHViosxHpKgPT76xIFCAbiXAcmPhfncjGYUxoTNhDQtPVXCudt6msxbmGR610Rn/yAJigr+KfKqRV7aL3Y1f0v3E+TYvYH1Sn7B0haVvfV/pDsEF+8fSDIXt3yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OYy4LEwHs+4M9p1Pib18lVB9vUqTgRA0lM9fv4NwXPo=;
 b=GZKtk/UxaoPvra+DoOsUOMWox0ycs4xZGWGtWYxld1FIv4palO4pRx5vTXsO/JAyPvFMF3/B/fuzjQ7eIPhj0m0blT+Lpmj6xnX3ZWSo3Klgpnkkqf0DiKB/rNA8nJDHwxUUeTwS/FhkYU3oqS9COazYo50OW4sAVJO7oxoJM7RQH9ihh3jLx+xekDxBgBXhfO5oeyFyj28kkDLoBD32YB2gL3bN6v9j1l8LRLgfMHBDd9kXSkkyh1tNbPxOcg3mSq8eMpS1JdeQUrsNV83dtdeMQFvRwHNRaElgTq2QYYbFwuAJUrLSiP76p/rnRr/giCNXiClA5B4aA1vX6hnx9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by PH0PR15MB5053.namprd15.prod.outlook.com (2603:10b6:510:a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Tue, 24 Feb
 2026 19:52:41 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 19:52:41 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "max.kellermann@ionos.com" <max.kellermann@ionos.com>,
        "to=idryomov@gmail.com" <to=idryomov@gmail.com>,
        Alex Markuze
	<amarkuze@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] [PATCH] fs/ceph: add a bunch of missing
 ceph_path_info initializers
Thread-Index: AQHcpY8Pp/sFKKrxxUyGuMmoUhFAkbWSQyUA
Date: Tue, 24 Feb 2026 19:52:40 +0000
Message-ID: <d312791eed442c275aa449c2428889907b178992.camel@ibm.com>
References: <20260224131030.3049328-1-max.kellermann@ionos.com>
In-Reply-To: <20260224131030.3049328-1-max.kellermann@ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|PH0PR15MB5053:EE_
x-ms-office365-filtering-correlation-id: d7db1f97-4508-4bbf-8348-08de73de44fa
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODlMYnJVU2xFL09WTy9qZEdjdVFMN0V0WGFQZGl4UzA0N3N0UUY0UmZTOGRy?=
 =?utf-8?B?YzB5ZE5Yck9IVGU0eDJkcUtWb0pCWkV2QzRpTUgwNkx1L3Q4SFlNSi9LbjFK?=
 =?utf-8?B?RmxDNDZJc1hIVGZNTFBKRUtYSmUyS3ZJZXYyR2Rkc1gzZCtvd0tOUFRQN1M0?=
 =?utf-8?B?eUt3Yjk4RHNUd0cvT3RWY3BON05kTTd6cytwc2VxM2ZMcDNaUlZuWGRDdlNl?=
 =?utf-8?B?YVZuUnFneVE0YjlrcHV4VXp0MzhIcDFtRU1rM3BEV1BjV1FKWXNFUmhOVGg3?=
 =?utf-8?B?ODF2NzJld3lKMVBLNjJrZTg2ZzY1Y0RNUjRiaHllbTVIMUpEckdMWGhXMWd4?=
 =?utf-8?B?NDVpVURPODZwVlhIUlh0S0NlUWZtQXdtZnBHbHU2ZHY1MExUYVhLNGNhRWtF?=
 =?utf-8?B?UXREUGFLYmpMcUsxdXl5cTJlcVd4QmNCYUxaMXhWYzlXYzF6WEl0OGZXWHdQ?=
 =?utf-8?B?MU1sNC9XY1F5YzYwNWkzRGtpSjh6UTNBdzc3cVQvRWZrTnpPczZ4aVYzZ0dj?=
 =?utf-8?B?UzlwK3JvTGZIY0dKZi9KOEtoczlHSkFyQUNKZnFGUmxybTRHM1p4NUZrNThV?=
 =?utf-8?B?enE3WUJRTXBiMlJaTUIwenNreG5sNG00c29ndERoVTlvSU1rNVZyYURxRHBK?=
 =?utf-8?B?VXdzUG9Mb0svOUtTTWFOOUQvNnZieHFuVGV0eG9rWWxGbDU3TTlIVUZnUGpR?=
 =?utf-8?B?QmU3SlpmdzVCVk1SbWtuaVlJYjc5SUErNTRNajc1Z25XY0xEU2xEUGlCaWFE?=
 =?utf-8?B?RzBzZXcvOXJkckxyWWsvVnJUMHJlclFNekxwd0sxaS9rMXVOamloZGkrTE1L?=
 =?utf-8?B?S0xuOW8rTXp2VVFCSi9kRkwyL2FTRU9heXNkdXJEWE9qSjJZU3NXODQrUVRK?=
 =?utf-8?B?cks0WFBoTncxcFo4RjVQVVZLbDRUT0ZzMGVCOVdsUmFSY3BnQllEUzhzeHVz?=
 =?utf-8?B?dWx0dmVhL0NPNW9GdGxzeEtscy9Ic3BYREc1R2xPeDBJdzBsT05yS1ZkQ090?=
 =?utf-8?B?aTZjMEVWSlROZ2lUbnh5dGpBc2t5S25MOUxFaWg1R0tvekFIVGd4VFBTZDVw?=
 =?utf-8?B?azZJRVVvUkpTdUlVcjJXRFN4TUhCdzVjTW5SNWVJaWlmU0lIS24vSTdqYjAz?=
 =?utf-8?B?M3gzQituSS8xdHAxK2NXUFlIeXRlUng4ZWJ2cFljajVrbDZyL05TeUtiYlJH?=
 =?utf-8?B?RXhaanBZK0daVEF3RkdaTzVHU0dxRW02NnJ3S0NpWSttcXMzS1NrNDB2MmV5?=
 =?utf-8?B?OU5NMVF0Rk1NSWRZSEoyTTZCKzErZU9CVU5PSlpWM1U0a3ZYaTdFSzFpa29o?=
 =?utf-8?B?RjFvNXRrNUxPZlhwY2tlRG5pNjVDMHZOdEZtNGN2enlQN2ZuMk5oYStkNnNh?=
 =?utf-8?B?RTNkZlpTS0ZkOHVtT25RelJZVDRua0FIbmY4STVmYi8xMEt5My93M0x0SHk2?=
 =?utf-8?B?eEZKMW9nRncrcVhEQmNDaVdvY2gyUXZPRC9zSTFDT3doUG5VOVl6OG5sc0oy?=
 =?utf-8?B?elpEUm9hd3lzOXphUHFHU0FSbnpBSllOa2dqR3pPSEJVSG5IK0NsVHE5NmV3?=
 =?utf-8?B?elRRTXU0V0ZsMENkWmQvUEFNMXoxaHZJVHAvb2h3dkVMWTFJaElPOVNTbzNV?=
 =?utf-8?B?cnozMmt1cGpnYjU2S3ZreDNaQzRoUEJnQ2UvVWNzRGFVNi9rZzhZT08zUjg5?=
 =?utf-8?B?ZGcrZmpib2RaU1NuUjEya1dnaUhIM0RYY3FuSkRqazloRTMwR1VUWi9JNHU4?=
 =?utf-8?B?Y0FRaUlEWmI5WFkzRUhxM3pGN0F1YmtHN3RjOGRBZStUZnhMNXlWYzNac29N?=
 =?utf-8?B?amt3UWF1MDQxWEQxVTFvZ1pFdHkzaHJjLzZlelVobkNFaGtRMEFQWU9EbU91?=
 =?utf-8?B?cnc2bW9vNGhiTmU0L29rcmswbElqUjF6cS9leWdzRVR4aCtET0h4NWk2L3lo?=
 =?utf-8?B?OWhJcmxzbGEyZmpiS01JZTFjZXpETEJPVGE4anhad2dpd3J0WU5RMS85Z0NW?=
 =?utf-8?B?cUw4VWt2MHJRckp1Q1V0cUNLRzVDVFJqUmJrYlJaa1k5OURHemxTcTU1S1Mz?=
 =?utf-8?B?V1VWOTY4VUV6RGoyWUM2ODNlOFYzUlc3aUI2Zzl4WHdvNEorbFFjSjRtSGJQ?=
 =?utf-8?B?SzE3WVRHek5kVk1pQWZGWDNDMGZ0am1VZmlaWlM4YjJXRWR5QnVBRkJ5emlR?=
 =?utf-8?Q?8Rkexs3h/lQq6gsyoReN2is=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGRmRXFnb0lkQ1Q3RkNEMG1nQXM3QnhuSStvTDJya3hTVWVUaFI1YkVoMlVE?=
 =?utf-8?B?NG5LR2loM0djYnc2TWZRSGtUak1oV0drVmhGM1NYY0t6WCtVRHhoSDZkWWZx?=
 =?utf-8?B?ays2ZW93TXVjSGpLaC96NE54T3VKY2RoVGpaS3BtUmsza2VXU1VtcGRqVFZZ?=
 =?utf-8?B?L1VDOG9jY2hqMUNBek1mOFVQYVkzU3hUQVVhampGRVJhSWZHWjZOY3duWW85?=
 =?utf-8?B?Q2VYU2E5OGErYVhoSVNtM0h4WFVaalpabnlnUW5tUktQMGRNTkFIOGdZM2N5?=
 =?utf-8?B?QkE4aTdNU3BWcE1ROU9BMnYyU2M2bm8vajM3S043NE0rejZnRktFTmc2dDR4?=
 =?utf-8?B?SzR4ODJJU29DY1FqWlJoeS8xd1JLdVFkWWZKUFZ4OVpoTis1Wmx5LzFtRjdJ?=
 =?utf-8?B?QXh4ZFNXUndZdEw0bC9MNHRtRHNhakora0hSYmN2aktDNUdDdGVGd3J2YlY0?=
 =?utf-8?B?aWpCcUtnSlliNnV5OUdiWC9FWDEydXFNNXlzY2NFVkFyUnlrdVppbFlDR05Q?=
 =?utf-8?B?aEV4dVZaWUFOUkdqSi9zY2RYUjdEOXVaSHU3QkJBeWQwQVdHL24zT2JEQkow?=
 =?utf-8?B?ZW1VTksrK0FTWEVlK0ZHV0tRMHA1eGxTWFpYdHRhVEcvWGhrRXdRYUZ6WmN2?=
 =?utf-8?B?REpmMjNRd2xhdzRPME5sRWxZYXhlaFVmNms5MEtZeFREaUZIaTl3a1FhQTho?=
 =?utf-8?B?Tjl5STE5NTBQcXJ0YXZYQmFrNjRuSkE0TWJ2UzRYNXcrcUFzdUswbmI2OXha?=
 =?utf-8?B?bTY4RWMrSk0rdnpQSmp2ZHlJU1FSSWR2RmpONGRPNW8wL0FiZmtVT3pwM2Ro?=
 =?utf-8?B?MC9INEVWS1JOdnJaV1R1VkFwYmE4QkI2dnRDYTh2MHljYUZBUkhmQnU5Yzd4?=
 =?utf-8?B?QWRzNDBUeWNLTUVEeFdSVnVMTlo2ZUxHTlNMTnFKVExaSEZVU3pRRC9lQmd5?=
 =?utf-8?B?M2RvR0VwdXdCMFZVVUptdDU4UzJyMXFDdkcvZlhLb0Z2R1ZWVExyTWpLYmI4?=
 =?utf-8?B?eU5iWDZ4NUpBdTMvMVFPR1JSdEhKcUNPeXVmdEYzbVJ3TlZNYzhGcFhXeWky?=
 =?utf-8?B?d0pEaEM4c2xaajg1Q29aZ0NVdFU2QTZMakFDR0dPZnNDMGdVdjlwUm9mb2JR?=
 =?utf-8?B?NGo3by9uZ3dWbDF6OHNhMEFMRlRiL0VUV3QrUUtQSlNEcUwrbmRscnpHNUgx?=
 =?utf-8?B?bXovUW4vdVlrU2lSQjU5MGI0OFN3RTNDQVVZOFhwRTFGT0dld1NiN21udU03?=
 =?utf-8?B?OUdUajlmMjJidkdNUU1SUUxTcDRSdWV0a3ZRSitsbWNucVYvdFVBUDVUVGdJ?=
 =?utf-8?B?YVRRQW1DaFU4Z2FEWmtISWlKMTFJaFRXRS9GSG84QTNzTmxOZUpNWCtvcFZk?=
 =?utf-8?B?K0FwTW8yMVkxTktqOWptRG95TGJSR1ZCbzVKU09SdUx5c0pOL3d6dk03ajZi?=
 =?utf-8?B?YlpFbDcxVWhrMUtHMzlxQ1ltUVZoRlFOSVR3YmlRNEZTR1oydEdsV2pTbmVn?=
 =?utf-8?B?dGwyNjFNZytvbGhWOTJpVkxYWmtqWGtMWGlTQzM1amp4U21PNTFGSDI2MVA2?=
 =?utf-8?B?eWVxYkduWlphYk1DOHdMbk41OHFUblZaRUNOYkFKUFkzMjlDQkZMaXBqcmZy?=
 =?utf-8?B?b0lYNmNpc3RldEhkZEZ6RjlqYVdvR2x5dmFnSUVYUlFFTmlUbitpMU9nTzRH?=
 =?utf-8?B?M1FPbU5Oam5ETEJFZjBaV0ZQNmU1TUgreXBaNytTNktnNmpBVVlZemEvekor?=
 =?utf-8?B?UXNLclpxM1dybWd5eTM3d0dWYWlEZnRGYmdWWWtFS2dHbUpRR2VGWklBa1VN?=
 =?utf-8?B?VDZ4aUNOU1hWZ0JBOTB6SXpaalZqa0ZkMmVGM2o1VE0zQUFMMElNcXF3OVln?=
 =?utf-8?B?TDFDT3FXTk50MjBoS0J2SHZlMGcreVdqL3o0WlJxdHFaai9Nb2RZd0cvR0tV?=
 =?utf-8?B?RnF6SWE0MW1KL2V1ZFFaa1ZNQTAvVHdyZW1ZMDlaclVxbm8vdUxqVmNmbjV0?=
 =?utf-8?B?L2Q1dVNnVU83ZVRNRnBVLzFxeWJkLzBkK0R3RW5JSFFZaVJ5cWF1Rml3NzQr?=
 =?utf-8?B?MEc2Y05BdW9MSE13WE5EdWpWRVUxUVA5cHN0bThHUU5ERjBDWmUwOCtmeFBz?=
 =?utf-8?B?UnJyK2EwRm4wMmNlbHlRVHQxZVlteWN3REgvL3h1aFFOLzJOSTJlRWdBMmxM?=
 =?utf-8?B?Zm15QWgzd1VHMDNxQ3o3YmpHZllkVFdyS2tQenlMRTJYZFlQbU03enJrRmhY?=
 =?utf-8?B?cnQzb3N3NUlRdU1aa2hKay9TUlUvWnBmTDJGRTVRWkFHZDRFdDBRUUpWclhF?=
 =?utf-8?B?ZkhNYW40aXdlQ3FtanJaanVXVjJkTW1Dd3dyZ3NnWVFtTi8yQmc5RFdIYTJX?=
 =?utf-8?Q?VNeMG4aUfnuhcJYaoQ8d4jCxOkmmR9oJLjME7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D68721446470764383E6C48006D58A30@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7db1f97-4508-4bbf-8348-08de73de44fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2026 19:52:40.9886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DRnX4IVrR/iykp6bVjzf+DiAIxXgU2JumyIUCrd9Skm6WH5OTlS36sDcMwN5J3C9gEXmiDdlICr8LuWyPxJfxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB5053
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qMS_DGR8hCSeGE5PQ76WiA1fRQMo8LEc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE2OSBTYWx0ZWRfX9I9M1cCNMWfC
 0Ev4Bl9fdmhyiyMMyU+D0FMQhfJmwS6H9iJLNTswGbqt6/p6M8ngaPbXLgnbxaePo35fYB1PIP0
 QQ9g8gvMorbzwtmIubAhu8NB0mI8Ln1EBcw5ldrcYYD88YA6ruPnnDXyNGRmAC9R3yHhwThn7t7
 0/CKWTpWemQnsbLoAeEurO2Zz5Z7TVh+pPKuua6Q9blyf5pYlGxVhL81EAR+12epJQVyTRFsboW
 KT4T1LGH53yZlDwZXpcjJcSGfYVfmF3cbk1kuulW7lGan64EyuurbJ+Klx2MMNYYJeXqby8/MQr
 K5/Cs7uzcijD32K5S7RQMlrsW8RLrHH9Y4ugFkkRxG7VBmEbhKlwXMyb5w0AHTfnbMrvxoz4XR7
 1IaTI/yGqRO0ApTbUqXkikYhepe4D2SXcQeVy34MsEcHSAVqrStP0cDLhpvdMqv98OFf4mvNTYQ
 OzHvmuFIU1zzw12CEAA==
X-Authority-Analysis: v=2.4 cv=eNceTXp1 c=1 sm=1 tr=0 ts=699e018d cx=c_pps
 a=qSv8Sft3UEt4GReRCOm4JQ==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=0R7wPAsABEriyCdN:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=UgJECxHJAAAA:8 a=VnNF1IyMAAAA:8 a=69uCEDPUtj-vSVdmZ_AA:9 a=QEXdDO2ut3YA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-GUID: nBfRhfE2_cm3qRgEWQhGq-cFv7g6dfZF
Subject: Re:  [PATCH] fs/ceph: add a bunch of missing ceph_path_info
 initializers
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_02,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602240169
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-217943-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[ionos.com,gmail.com,redhat.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 7C96D18C3AB
X-Rspamd-Action: no action

T24gVHVlLCAyMDI2LTAyLTI0IGF0IDE0OjEwICswMTAwLCBNYXggS2VsbGVybWFubiB3cm90ZToN
Cj4gY2VwaF9tZHNjX2J1aWxkX3BhdGgoKSBtdXN0IGJlIGNhbGxlZCB3aXRoIGEgemVyby1pbml0
aWFsaXplZA0KPiBjZXBoX3BhdGhfaW5mbyBwYXJhbWV0ZXIsIG9yIGVsc2UgdGhlIGZvbGxvd2lu
Zw0KPiBjZXBoX21kc2NfZnJlZV9wYXRoX2luZm8oKSBtYXkgY3Jhc2guDQo+IA0KPiBFeGFtcGxl
IGNyYXNoIChvbiBMaW51eCA2LjE4LjEyKToNCj4gDQo+ICAgdmlydF90b19jYWNoZTogT2JqZWN0
IGlzIG5vdCBhIFNsYWIgcGFnZSENCj4gICBXQVJOSU5HOiBDUFU6IDE4NCBQSUQ6IDI4NzE3MzYg
YXQgbW0vc2x1Yi5jOjY3MzIga21lbV9jYWNoZV9mcmVlKzB4MzE2LzB4NDAwDQo+ICAgWy4uLl0N
Cj4gICBDYWxsIFRyYWNlOg0KPiAgICBbLi4uXQ0KPiAgICBjZXBoX29wZW4rMHgxM2QvMHgzZTAN
Cj4gICAgZG9fZGVudHJ5X29wZW4rMHgxMzQvMHg0ODANCj4gICAgdmZzX29wZW4rMHgyYS8weGUw
DQo+ICAgIHBhdGhfb3BlbmF0KzB4OWEzLzB4MTE2MA0KPiAgIFsuLi5dDQo+ICAgY2FjaGVfZnJv
bV9vYmo6IFdyb25nIHNsYWIgY2FjaGUuIG5hbWVzX2NhY2hlIGJ1dCBvYmplY3QgaXMgZnJvbSBj
ZXBoX2lub2RlX2luZm8NCj4gICBXQVJOSU5HOiBDUFU6IDE4NCBQSUQ6IDI4NzE3MzYgYXQgbW0v
c2x1Yi5jOjY3NDYga21lbV9jYWNoZV9mcmVlKzB4MmRkLzB4NDAwDQo+ICAgWy4uLl0NCj4gICBr
ZXJuZWwgQlVHIGF0IG1tL3NsdWIuYzo2MzQhDQo+ICAgT29wczogaW52YWxpZCBvcGNvZGU6IDAw
MDAgWyMxXSBTTVAgTk9QVEkNCj4gICBSSVA6IDAwMTA6X19zbGFiX2ZyZWUrMHgxYTQvMHgzNTAN
Cj4gDQo+IFNvbWUgb2YgdGhlIGNlcGhfbWRzY19idWlsZF9wYXRoKCkgY2FsbGVycyBoYWQgaW5p
dGlhbGl6ZXJzLCBidXQNCj4gb3RoZXJzIGhhZCBub3QsIGV2ZW4gdGhvdWdoIHRoZXkgd2VyZSBh
bGwgYWRkZWQgYnkNCj4gY29tbWl0IDE1ZjUxOWU5Zjg4MyAoImNlcGg6IGZpeCByYWNlIGNvbmRp
dGlvbiB2YWxpZGF0aW5nIHJfcGFyZW50DQo+IGJlZm9yZSBhcHBseWluZyBzdGF0ZSIpLg0KPiBU
aGUgb25lcyB3aXRob3V0IGluaXRpYWxpemVyIGFyZSBzdXNwZWN0aWJsZSB0byByYW5kb20NCj4g
Y3Jhc2hlcy4gIChJIGNhbiBpbWFnaW5lIGl0IGNvdWxkIGV2ZW4gYmUgcG9zc2libGUgdG8gZXhw
bG9pdCB0aGlzIGJ1Zw0KPiB0byBlbGV2YXRlIHByaXZpbGVnZXMuKQ0KPiANCj4gVW5mb3J0dW5h
dGVseSwgdGhlc2UgQ2VwaCBmdW5jdGlvbnMgYXJlIHVuZG9jdW1lbnRlZCBhbmQgaXRzIHNlbWFu
dGljcw0KPiBjYW4gb25seSBiZSBkZXJpdmVkIGZyb20gdGhlIGNvZGUuICBJIHNlZSB0aGF0IGNl
cGhfbWRzY19idWlsZF9wYXRoKCkNCj4gaW5pdGlhbGl6ZXMgdGhlIHN0cnVjdHVyZSBvbmx5IG9u
IHN1Y2Nlc3MsIGJ1dCBub3Qgb24gZXJyb3IuDQo+IA0KPiBDYWxsaW5nIGNlcGhfbWRzY19mcmVl
X3BhdGhfaW5mbygpIGFmdGVyIGEgZmFpbGVkDQo+IGNlcGhfbWRzY19idWlsZF9wYXRoKCkgY2Fs
bCBkb2VzIG5vdCBldmVuIG1ha2Ugc2Vuc2UsIGJ1dCB0aGF0J3Mgd2hhdA0KPiBhbGwgY2FsbGVy
cyBkbywgYW5kIGZvciBpdCB0byBiZSBzYWZlLCB0aGUgc3RydWN0dXJlIG11c3QgYmUNCj4gemVy
by1pbml0aWFsaXplZC4gIFRoZSBsZWFzdCBpbnRydXNpdmUgYXBwcm9hY2ggdG8gZml4IHRoaXMg
aXMNCj4gdGhlcmVmb3JlIHRvIGFkZCBpbml0aWFsaXplcnMgZXZlcnl3aGVyZS4NCj4gDQo+IEZp
eGVzOiAxNWY1MTllOWY4ODMgKCJjZXBoOiBmaXggcmFjZSBjb25kaXRpb24gdmFsaWRhdGluZyBy
X3BhcmVudCBiZWZvcmUgYXBwbHlpbmcgc3RhdGUiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVs
Lm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBNYXggS2VsbGVybWFubiA8bWF4LmtlbGxlcm1hbm5AaW9u
b3MuY29tPg0KPiAtLS0NCj4gIGZzL2NlcGgvZGVidWdmcy5jIHwgNCArKy0tDQo+ICBmcy9jZXBo
L2Rpci5jICAgICB8IDIgKy0NCj4gIGZzL2NlcGgvZmlsZS5jICAgIHwgNCArKy0tDQo+ICBmcy9j
ZXBoL2lub2RlLmMgICB8IDIgKy0NCj4gIDQgZmlsZXMgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCsp
LCA2IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2NlcGgvZGVidWdmcy5jIGIv
ZnMvY2VwaC9kZWJ1Z2ZzLmMNCj4gaW5kZXggZjNmZTc4NmI0MTQzLi43ZGMzMDc3OTAyNDAgMTAw
NjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZGVidWdmcy5jDQo+ICsrKyBiL2ZzL2NlcGgvZGVidWdmcy5j
DQo+IEBAIC03OSw3ICs3OSw3IEBAIHN0YXRpYyBpbnQgbWRzY19zaG93KHN0cnVjdCBzZXFfZmls
ZSAqcywgdm9pZCAqcCkNCj4gIAkJaWYgKHJlcS0+cl9pbm9kZSkgew0KPiAgCQkJc2VxX3ByaW50
ZihzLCAiICMlbGx4IiwgY2VwaF9pbm8ocmVxLT5yX2lub2RlKSk7DQo+ICAJCX0gZWxzZSBpZiAo
cmVxLT5yX2RlbnRyeSkgew0KPiAtCQkJc3RydWN0IGNlcGhfcGF0aF9pbmZvIHBhdGhfaW5mbzsN
Cj4gKwkJCXN0cnVjdCBjZXBoX3BhdGhfaW5mbyBwYXRoX2luZm8gPSB7MH07DQo+ICAJCQlwYXRo
ID0gY2VwaF9tZHNjX2J1aWxkX3BhdGgobWRzYywgcmVxLT5yX2RlbnRyeSwgJnBhdGhfaW5mbywg
MCk7DQo+ICAJCQlpZiAoSVNfRVJSKHBhdGgpKQ0KPiAgCQkJCXBhdGggPSBOVUxMOw0KPiBAQCAt
OTgsNyArOTgsNyBAQCBzdGF0aWMgaW50IG1kc2Nfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKnMsIHZv
aWQgKnApDQo+ICAJCX0NCj4gIA0KPiAgCQlpZiAocmVxLT5yX29sZF9kZW50cnkpIHsNCj4gLQkJ
CXN0cnVjdCBjZXBoX3BhdGhfaW5mbyBwYXRoX2luZm87DQo+ICsJCQlzdHJ1Y3QgY2VwaF9wYXRo
X2luZm8gcGF0aF9pbmZvID0gezB9Ow0KPiAgCQkJcGF0aCA9IGNlcGhfbWRzY19idWlsZF9wYXRo
KG1kc2MsIHJlcS0+cl9vbGRfZGVudHJ5LCAmcGF0aF9pbmZvLCAwKTsNCj4gIAkJCWlmIChJU19F
UlIocGF0aCkpDQo+ICAJCQkJcGF0aCA9IE5VTEw7DQo+IGRpZmYgLS1naXQgYS9mcy9jZXBoL2Rp
ci5jIGIvZnMvY2VwaC9kaXIuYw0KPiBpbmRleCA4NmQ3YWE1OTRlYTkuLmE4N2MyYmMwOTk2NSAx
MDA2NDQNCj4gLS0tIGEvZnMvY2VwaC9kaXIuYw0KPiArKysgYi9mcy9jZXBoL2Rpci5jDQo+IEBA
IC0xMzYzLDcgKzEzNjMsNyBAQCBzdGF0aWMgaW50IGNlcGhfdW5saW5rKHN0cnVjdCBpbm9kZSAq
ZGlyLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnkpDQo+ICAJaWYgKCFkbikgew0KPiAgCQl0cnlfYXN5
bmMgPSBmYWxzZTsNCj4gIAl9IGVsc2Ugew0KPiAtCQlzdHJ1Y3QgY2VwaF9wYXRoX2luZm8gcGF0
aF9pbmZvOw0KPiArCQlzdHJ1Y3QgY2VwaF9wYXRoX2luZm8gcGF0aF9pbmZvID0gezB9Ow0KPiAg
CQlwYXRoID0gY2VwaF9tZHNjX2J1aWxkX3BhdGgobWRzYywgZG4sICZwYXRoX2luZm8sIDApOw0K
PiAgCQlpZiAoSVNfRVJSKHBhdGgpKSB7DQo+ICAJCQl0cnlfYXN5bmMgPSBmYWxzZTsNCj4gZGlm
ZiAtLWdpdCBhL2ZzL2NlcGgvZmlsZS5jIGIvZnMvY2VwaC9maWxlLmMNCj4gaW5kZXggNjZiYmY2
ZDUxN2E5Li41ZTdjNzNhMjlhYTMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2NlcGgvZmlsZS5jDQo+ICsr
KyBiL2ZzL2NlcGgvZmlsZS5jDQo+IEBAIC0zOTcsNyArMzk3LDcgQEAgaW50IGNlcGhfb3Blbihz
dHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSkNCj4gIAlpZiAoIWRlbnRyeSkg
ew0KPiAgCQlkb19zeW5jID0gdHJ1ZTsNCj4gIAl9IGVsc2Ugew0KPiAtCQlzdHJ1Y3QgY2VwaF9w
YXRoX2luZm8gcGF0aF9pbmZvOw0KPiArCQlzdHJ1Y3QgY2VwaF9wYXRoX2luZm8gcGF0aF9pbmZv
ID0gezB9Ow0KPiAgCQlwYXRoID0gY2VwaF9tZHNjX2J1aWxkX3BhdGgobWRzYywgZGVudHJ5LCAm
cGF0aF9pbmZvLCAwKTsNCj4gIAkJaWYgKElTX0VSUihwYXRoKSkgew0KPiAgCQkJZG9fc3luYyA9
IHRydWU7DQo+IEBAIC04MDcsNyArODA3LDcgQEAgaW50IGNlcGhfYXRvbWljX29wZW4oc3RydWN0
IGlub2RlICpkaXIsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCj4gIAlpZiAoIWRuKSB7DQo+ICAJ
CXRyeV9hc3luYyA9IGZhbHNlOw0KPiAgCX0gZWxzZSB7DQo+IC0JCXN0cnVjdCBjZXBoX3BhdGhf
aW5mbyBwYXRoX2luZm87DQo+ICsJCXN0cnVjdCBjZXBoX3BhdGhfaW5mbyBwYXRoX2luZm8gPSB7
MH07DQo+ICAJCXBhdGggPSBjZXBoX21kc2NfYnVpbGRfcGF0aChtZHNjLCBkbiwgJnBhdGhfaW5m
bywgMCk7DQo+ICAJCWlmIChJU19FUlIocGF0aCkpIHsNCj4gIAkJCXRyeV9hc3luYyA9IGZhbHNl
Ow0KPiBkaWZmIC0tZ2l0IGEvZnMvY2VwaC9pbm9kZS5jIGIvZnMvY2VwaC9pbm9kZS5jDQo+IGlu
ZGV4IGQ3NmY5YTc5ZGMwYy4uZDk5ZTEyZDExMDBiIDEwMDY0NA0KPiAtLS0gYS9mcy9jZXBoL2lu
b2RlLmMNCj4gKysrIGIvZnMvY2VwaC9pbm9kZS5jDQo+IEBAIC0yNTUxLDcgKzI1NTEsNyBAQCBp
bnQgX19jZXBoX3NldGF0dHIoc3RydWN0IG1udF9pZG1hcCAqaWRtYXAsIHN0cnVjdCBpbm9kZSAq
aW5vZGUsDQo+ICAJaWYgKCFkZW50cnkpIHsNCj4gIAkJZG9fc3luYyA9IHRydWU7DQo+ICAJfSBl
bHNlIHsNCj4gLQkJc3RydWN0IGNlcGhfcGF0aF9pbmZvIHBhdGhfaW5mbzsNCj4gKwkJc3RydWN0
IGNlcGhfcGF0aF9pbmZvIHBhdGhfaW5mbyA9IHswfTsNCj4gIAkJcGF0aCA9IGNlcGhfbWRzY19i
dWlsZF9wYXRoKG1kc2MsIGRlbnRyeSwgJnBhdGhfaW5mbywgMCk7DQo+ICAJCWlmIChJU19FUlIo
cGF0aCkpIHsNCj4gIAkJCWRvX3N5bmMgPSB0cnVlOw0KDQpMb29rcyBnb29kLg0KDQpSZXZpZXdl
ZC1ieTogVmlhY2hlc2xhdiBEdWJleWtvIDxTbGF2YS5EdWJleWtvQGlibS5jb20+DQoNClRoYW5r
cywNClNsYXZhLg0K

