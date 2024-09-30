Return-Path: <stable+bounces-78289-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F095098A9CA
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 18:32:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E097B2285F
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 16:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F3C192599;
	Mon, 30 Sep 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="GgEaPat3"
X-Original-To: stable@vger.kernel.org
Received: from rcdn-iport-8.cisco.com (rcdn-iport-8.cisco.com [173.37.86.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC783D0D5
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727713967; cv=fail; b=cC/89RPtc94/ReWuKvH34PgfDB4w08qhhFVUUonDJEJpMN1yz8yRmQN4u8JdwA7FCJUZMj1BDplyW0tVcQHJbF5/97U5AOHiUKwvP1IqI9/NuRaEyAZMylShace13qkONshaxAIEWLBHXWaeEd1m3G3kwZNpmMbD3vnvOmAJfSo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727713967; c=relaxed/simple;
	bh=WXzHa+bRqNe2GeCeakH75sztxUDHCbuYoxSPVQkdg7Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oep13r+zWCyx37E+3kfnU4SGY/3wMCdCzBGhm4O19hK/66ARjQe4USLQRF6IKUiIHRsrZwzHLNvMsYfMvnP2JmMsei2QGfyyZ2Y4Nlz0vEqOMFf3sU1Q1XqYSHkwPj09J6zpEfdizdP/lVWVKQZd8QVZo7FzSDEGyZFmAFPOq4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=GgEaPat3; arc=fail smtp.client-ip=173.37.86.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2653; q=dns/txt; s=iport;
  t=1727713965; x=1728923565;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s6MHaAuzygb8gvy6Yn6ZW2hpFSlXuVWDjHiP9aXch4E=;
  b=GgEaPat3QWS13ITTP04Hfsj+FcD9TrdNvLCLYCNgrtYuAPoOKVSv36LU
   tvy6p4ize547sed2ppXH5dn8vT0IImap98epcWbAcogJoNzIOvb49UDth
   T8T/DQ+GV+AqQIu0uzOIIvysol00IilRQvH3nSWIwyTDhcG1SQFfb2Wgu
   k=;
X-CSE-ConnectionGUID: a+PsdMfTROeWZD3YjCEeLA==
X-CSE-MsgGUID: H3X7N3LpRKyy8zsR+z+q3A==
X-IPAS-Result: =?us-ascii?q?A0AQAAC60fpmmJFdJa1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAJYEqgXJSe4EMEkiIIQOFLYhzA586A1YPAQEBDQEBR?=
 =?us-ascii?q?AQBAYUHAooOAiY4EwECBAEBAQEDAgMBAQEBAQEBAQEFAQEFAQEBAgEHBRQBA?=
 =?us-ascii?q?QEBAQEBATcFSYYChlsBAQEBAxIVEz8QAgEIGB4QMSUCBAENBQgagl+CZQMBo?=
 =?us-ascii?q?04BgUACiil4gQEzgQHgHoFIAYhKAYpdJxuCDYFXgmg+hAo7hBOCLwSRew6Kc?=
 =?us-ascii?q?nwliFtwkQFSexwDWSECEQFVExcLCQWJOAqDHCmBRSaBCoMLgTOBG4JXgWcJY?=
 =?us-ascii?q?YdnYoENgT6BWQFGgnFKJAuCIX85gT4FOEmCUWtOOQINAjeCKIEOglmEdigTH?=
 =?us-ascii?q?UADC209NRQbBQSBNQWsQkeCKSCBBAocgVyBK5JfAYMmmlmVDgqEGKFyF6pFL?=
 =?us-ascii?q?phIIqNghHECBAIEBQIPAQEGgX4jgVtwFYMiUhkPji0NCcAWeDsCBwsBAQMJi?=
 =?us-ascii?q?1UsgVEBAQ?=
IronPort-PHdr: A9a23:SkThVhcb2mAppF3k0pVyq6C8lGM/gIqcDmcuAtIPkblCdOGk55v9e
 RaZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:vvQ7HKk/DH+RO5CMg1gTxyzo5gyTJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xIcWTqPafqCYWWmedp+PYyx/RxXsZfQmNI3SQNlqnwwE1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaB4ErraP659CkUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pS31GONgWYubjpFsPrb9HuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FYRbwv17JG9yz
 9sVFwIhNSGBrM+75JvuH4GAhux7RCXqFJkUtnclxjbDALN3B5vCWK7No9Rf2V/chOgXQq2YP
 JVfOGEpNUidC/FMEg9/5JYWn+6ymnj7ej5wo1OOrq1x6G/WpOB0+OKwYYeKJozSHa25mG64/
 VKZ2T/dGis5Jc3P2yG/sWDvn7TmyHaTtIU6T+DgqaUw3zV/3Fc7EwEfX1+2iee2h1T4WN9FL
 UEQvC00osAPGFeDVNLxWVizp2SJ+09aUNtLGOp84waIokbJ3+qHLmFHdiVNTdIajug7eg4Gj
 W6LtP7kIRU65dV5Vkmh3ruTqDqzPw0cImkDeTIIQGM5Dz/L/ttbYvXnEIoLLUKlsuAZDw0c1
 NxjkcTTr68YgchO3KKh8BWWxTmtvZPOCAUy4207v15JDCsnNOZJhKTxtTA3CMqsyq7DEDFtW
 1BfxqCjABgmV83lqcB0aLxl8EuVz/iEKibAplVkAoMs8T+gk1b6ItoPvmoiex4xbJpdEdMMX
 KM1kV4OjHO0FCb7BZKbn6rrV6zGMIC5T428DaGOBjawSsMrJFfelM2RWaJg9zuwyBd3y/5X1
 Wazese3BnFSErV80DezXK8c17Rtrh3SNkuNLa0XOy+PiOLEDFbMEO9tGALXPogRsvjeyC2Lq
 Ik3Cid/40gFOAEISnOJodd7wJFjBSVTOK0aXOQNKLHZclI4STB5YxITqJt4E7FYc21uvr6g1
 lm2W1RTzxz0gnivFOlAQikLhG/HNXqnkU8GAA==
IronPort-HdrOrdr: A9a23:62yue6jK1OWhIVciSNgL4S+kD3BQX5V23DAbv31ZSRFFG/FwyP
 re/8jzhCWVtN9OYhAdcIi7Sde9qBPnmaKc4eEqTNGftXrdyRqVxeZZnMTfKlzbamHDH4FmpN
 1dmsRFebnN5B1B/LnHCWqDYpgdKbu8gd2VbI7lph8HI3AJGsRdBkVCe3qm+yZNNXB77O8CZe
 GhD7181kKdkBosH6OGL0hAddLu4/fMk5XrawMHARkI1Cmi5AnD1JfKVzKj8lM7ST1g/ZcOmF
 Kpr+X+3MqemsD+7iWZ+37Y7pxQltek4MBEHtawhs8cLSipohq0Zax6Mofy/AwdkaWK0hIHgd
 PMqxAvM4BY8HXKZFy4phPrxk3JzCsu0Xn/0lWV6EGT4vARBQhKSfapt7gpNicx2HBQ++2UF5
 g7mV5xgqAnSC8oWh6NvuQgGSsaznZc6kBS4dL7x0YvIrf2LoUh7LD2OChuYc099OWQ0vF9LM
 B+SM7b//pYalWccjTQuXRu2sWlWjApEg6BWVVqgL3f79F6pgEx86Ij/r1Wol4QsJYmD5VU7e
 XNNapl0LlIU88NdKp4QOMMW9G+BGDBSQ/FdDv6GyWrKIgXf3bW75Ln6rQ84++nPJQO0ZspgZ
 zEFFdVr3Q7dU7iAdCHmJdL7hfOSmOgWimF8LAV27Fp/rnnALb7OyyKT14j18OmvvUEG8XeH+
 2+PZpHasWTW1cG2bw5qDEWd6MiXUX2CvdlyOrTc2j+1/72Fg==
X-Talos-CUID: =?us-ascii?q?9a23=3AV41eI2rZiBSuyr0kX7CFkm7mUclmSmbR6XnsGWi?=
 =?us-ascii?q?1NlRFE4yXYnKd3Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:2y83AAWzE3djv/Lq/B+3tG5Eb+Nw2Ye/GRAfiq9FqYqdbgUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-9.cisco.com ([173.37.93.145])
  by rcdn-iport-8.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:32:38 +0000
Received: from rcdn-opgw-2.cisco.com (rcdn-opgw-2.cisco.com [72.163.7.163])
	by rcdn-core-9.cisco.com (8.15.2/8.15.2) with ESMTPS id 48UGWcto003354
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 16:32:38 GMT
X-CSE-ConnectionGUID: LaS42LdrTCmNW2JVBtiq+g==
X-CSE-MsgGUID: uwNjYRt4ToSrgT/FdS65fA==
Authentication-Results: rcdn-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="22723199"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by rcdn-opgw-2.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 16:32:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=amu2ijq5Wb8/1VLv3ng+j09Fql4nW6JpqYceDlpbTZUuUIyi7ar1RPKzMiBMKX0C398YbTRJETCyKshZ7f5u2M2gb6N6K5McLOJZfhxzQH9XWc/lKY39mDG/xXfCYZTtLu3dWaled2/9ULMZvKcwun0d/k88byuVU0gzeMCqx/MDqC4/eo83UwK2SQVPaxNBJHmNmNr/T2kBZVpfcXHKdZ7sIM0cMtKvHxuBLdumHHOoqgeZ57cfg0tJmfNyA7hR2yHZqb8wVB6rb+krgMVNNQFrPfR0rP9ymo3iIVvdPVR6x4t0bIFzOWXVd4SWucBrGQ61gUeJ1Pxc6/MXn4VZVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6MHaAuzygb8gvy6Yn6ZW2hpFSlXuVWDjHiP9aXch4E=;
 b=RL9Z8pWcW4edScB1qJ5ud4a2LkmTBKmlF6/AN5FEoU4MpK+dv8jXfMmkWHQ0j5Ylv3sKsHio1SpunsQUt2b9SZh9w6tMLGgBgWSmJzPa4yYbQuz1QExq5q4if0NkwlZRhQVvArU2TXKojDLSHHnRI0miromDfwUX6eFCK5dOFCOuvcFUxlmkPDRkdLXRhxkwbGYGuJkvNhqmzwY0tMplW3Jd4WJaj+uapxjUe/lV/5DSOdUsW4yuF+W1H8YdmZzAZmOpH2ZBlMWhiaLX9hIJA/0lHZfNv1yIl2H/co0c0xRX4HvBeVMCDSct93XuYLnB0z7p5N8rM9s1+eWDlUdSrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SJ0PR11MB4861.namprd11.prod.outlook.com (2603:10b6:a03:2ac::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 16:32:32 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 16:32:32 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Martin Wilck <martin.wilck@suse.com>,
        "Satish Kharat (satishkh)"
	<satishkh@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC: James Bottomley <jejb@linux.vnet.ibm.com>, Lee Duncan <lduncan@suse.com>,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] scsi: fnic: move flush_work initialization out of if
 block
Thread-Topic: [PATCH] scsi: fnic: move flush_work initialization out of if
 block
Thread-Index: AQHbEzxIAYwreWA0Z02Kp2x78n3UOrJwhWvQ
Date: Mon, 30 Sep 2024 16:32:32 +0000
Message-ID:
 <SJ0PR11MB58962AD33539841107B1DF46C3762@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20240930132517.70837-1-mwilck@suse.com>
In-Reply-To: <20240930132517.70837-1-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SJ0PR11MB4861:EE_
x-ms-office365-filtering-correlation-id: 4cc5f0d0-5a56-4d8f-4ded-08dce16d7bba
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7QE2dONRWCQjFqvUbNRsZknpJ38ysSLItmNIMU9lX7x0AQQ6/bZxs6tDaFMA?=
 =?us-ascii?Q?XVcdd/dvSxo0oQTw0lKNam2kd6X17/IklIdt2MGOPYMKUYawzDz7vZVR1uxa?=
 =?us-ascii?Q?tkNR2bv6JHE7wECWvZcdGr/jd/2H0xVwQrosvIBiQ6RszoeE25xKHYVsBBzf?=
 =?us-ascii?Q?Af+gCeQ0gP00rqc9zWKXGVAjnzLjChQWqLJDv9dtpzfeCDSgUY6JNmI3cijF?=
 =?us-ascii?Q?gUnstevdSJnZm3qRk2FoeLjac1XLW6GE244f4xXlIaM4YeSM/0qPR7f3aZdI?=
 =?us-ascii?Q?eh2i7616aYlygC0wvwHSy65HPgK5ooxg1CAcGydzQp34XYs6kqc1veETQF2m?=
 =?us-ascii?Q?JyqR5MxZ56FglF8xImgyYKTBUr6kCCkh89C2SXTufIY6zy5mPt92ctlf9wTz?=
 =?us-ascii?Q?QDyA15VDsMzjp2CMr7Yahz0df60kAgR0OnlAhwqnMBtB20n6nrJzU++JjmFC?=
 =?us-ascii?Q?JHLpLyG3cQoq47+VY3H79rK5sQ0HGCPBQAYbcxu8esDpna4Ddklrmyyp6nsc?=
 =?us-ascii?Q?cQgGWczfZIk1QCScvz49dXb9qTQ8ZUeFgt0iJg3mln9pkiPpgvY8fzxmtl0B?=
 =?us-ascii?Q?W7anlqvRe+J6Mtd7SPnbma6w3Lb8wZrOekMFOnPVKx1bU15EYcPODPVIamvZ?=
 =?us-ascii?Q?kusN9dRaiOvo8aY9th9619xxwpZnfCuI73ZKl+B3z0z3KkEgDU2gHHTqGZKi?=
 =?us-ascii?Q?H2rxD6Ec5efNkZDQ2kZWO0RaVW6xa+nvcQmCqGRqtJQR/0GHm3ZNCewm74sB?=
 =?us-ascii?Q?UA/tyf6byL0x0cjRNEzkjvJ0hv0hpFoxwzYbn6qEFFfrrtUkRCmKYWyjVb3s?=
 =?us-ascii?Q?VD1gSV6phQrECDLNTj9qj/xJ/ZaC8k9uleULEYyb7yGNuDRKUvTzOCtwEjcT?=
 =?us-ascii?Q?1GfvStNl7JxOyoI4RLNjlLIT5DhDpLL3/jeQv+wvWnYiv507Oc982hTOJ3D1?=
 =?us-ascii?Q?LeRJcZKOMx82uExDUrewcuLUF4c0sL5fDPWt1prAm+0q0nStk6cJSvh8hvdo?=
 =?us-ascii?Q?/7djqJzOgJPJKUBZHNrdNfMEG5A1kfL9gnncJ/6tvtHyszoKMruDZjpJ7AP3?=
 =?us-ascii?Q?5n+vEQw6gJ62SYbNnEVO+I5949mMW2cWwQ907m65+1Gq5qKvVuxM/Tw7BJQZ?=
 =?us-ascii?Q?M7evl8ToK8mfe4zsnGSVm6hFgI10sh4ixQI+iT9Ferzal/pt0AhJE76PNQ/u?=
 =?us-ascii?Q?JEk/jpXhulZQfVvv3I9wJkO07CU4JXi29ov9rBVzWUGYVAsUnzArWDzPwCUo?=
 =?us-ascii?Q?CrDgXh65FvScEhfzWLNdZFx32CzI4uoMT/jBFhzy54iP5unYqRCmOBa6A+Pc?=
 =?us-ascii?Q?F6hY/cnK1+kE0w0JsQDVSnu7/RS+qHWOYg3ArHg5aOTsCknFgjhIIKZdHrv5?=
 =?us-ascii?Q?xplxyIqFNMafQMXEVtP12uVojZegT/OxvooMGxQTH7myqDBuXA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rm2jGdGKT2FSihqLP0lmIOSTY9qIEGVNtVux+buOai7F8dpN0o0hTtQS9KSO?=
 =?us-ascii?Q?Xyv0ghTLEs8XjblOvNXd1L0vadAsmVEf62XFwi+U8yhkAEjyDG17QQAs2Gbz?=
 =?us-ascii?Q?ehQyYNiRZZLB59Z+gcLMiSLEh0EXalhxV0Lw1PvDMwLpOcGdGGZp58q5H10a?=
 =?us-ascii?Q?69jsOGFP1nYXLdb0ToSLokTcabkjsEbmPRe+6uR4J5ZDYaIB8mJlYE+bF9kE?=
 =?us-ascii?Q?jgiH95iil12FLI5kRKYhNh7qfndS8HSbWCzV4dTK9dL7IQYJl3uSV9WPYGYM?=
 =?us-ascii?Q?nIyhqnnVELLZ13GsEA5n7q4pANfb6qNyNB8FTz5Y/jXylO5LIQnDggtOzA6c?=
 =?us-ascii?Q?BXRcKvJ3fKkz/hw28JvsVY9ql1dK5CIPkY4aOJSB70/wUY7wxoH7amg8GAg0?=
 =?us-ascii?Q?tnJ2XhGvKYceQnk/QXccoBsimSqS0q0jn7TtCBTbT0q7WK96teN51n4Axzy1?=
 =?us-ascii?Q?V8q2UIkoOWtgb2Ri6KatlSqOkwOaQ3NKwN2tP47sswC4oWr5ffvFgk+mu8lC?=
 =?us-ascii?Q?fBwDn5Sn7DVHNlhZozcmCI1JDevP+tfiRL5Re3DEnftYMsbJz55b/Gz75Qle?=
 =?us-ascii?Q?01SPwBW057gYSq+J1jHKZnsAwgAaM0hDKWWkLEsdgz0vmsOlo2aUv7eiUu6U?=
 =?us-ascii?Q?WeYLRmjpUkOGMrk9XiBzlizmZRqGYh65pVWE38hdoZn/uzBXv/R4HQyyrFif?=
 =?us-ascii?Q?zjX7f2JIBhR/2ecZywHDrnIgzHyDttBkByRlJHh0K9+UZmAXlXzf9E1bCKmD?=
 =?us-ascii?Q?mq5F4fHrNjEdY6nja28bPn5aaVmFhfTqsonwAvfN/Oi+/pK7oMMITiOOvoQD?=
 =?us-ascii?Q?z268rfCEtGJNq9fiBmqPEvy4qY8Bm+/uyEm5AeGvasjsaW6eQiWyfxiv7CjM?=
 =?us-ascii?Q?6V3wgiKITIKzdR02MvbgI/3dRfrSPg0/5jGoSnSMn3krqfvhCCcR6ZR1Pezo?=
 =?us-ascii?Q?gBf8UXwOpZAG+LH4Y7qJEoX8CzdOeS5SYmhbL488nPjBMG9tnkWP/BH7khH8?=
 =?us-ascii?Q?TsqI4GwZlnWQdK4LMjsMlBqoqSt9Br+IvPW17/2aDrrreAf8j8aC15LAgbkI?=
 =?us-ascii?Q?aB7T+J5TZovaw55FPFa800ixJRKxJDiJJSPFUsL2WpPNrEBjxzoalKxZ9dex?=
 =?us-ascii?Q?z6JKeWNcgCibo9R/NqmgPT321yTAHN9wX0v27IdmQ2pzIpiyoLa5BbWTNR7y?=
 =?us-ascii?Q?jYn6eTM4IYyFgPgWKxIXdt3mrfvtJxMvE3WJCGrP5vM1+NeADTr8OcRqojEt?=
 =?us-ascii?Q?ktqHtDmkUl3nR5lcGrFsKuyv35ELfuAAnEew5yPSmgZfgsuXpHYd0ENrXY0U?=
 =?us-ascii?Q?al9zdqTvPRJDrD3VrwB21IHkXam894fymEI+TQ3vTboIPrLAH/2c8tJ6EaXv?=
 =?us-ascii?Q?7bF/a1eBVHncFJRvAhMUoBJarbGcXOo8LRptwIwc9siOesoQ0MVxAoUYZaE2?=
 =?us-ascii?Q?d/l//fuCR0lw3pO2iZtA3lZvgHAAgG9li2DfhV3LlxGpv9u1364r9e8H1RVB?=
 =?us-ascii?Q?RpulAMd9bovwIygzWGIcU9HyG1LkNZHZ7jD8435ChebTwoqENr1AEXCMtjYt?=
 =?us-ascii?Q?bBSeqQ2qZe1aWtuxD62ALWphQFQuIdSPYa/m9OeH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cc5f0d0-5a56-4d8f-4ded-08dce16d7bba
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 16:32:32.2817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1melqkC8OzyzRGLP2+qg0cqjmd0nC0FlnVAD25bxhJrC27dD0mmEcp2NyvaK+XcNKLvjJ/BSiomS0cmBbdllqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4861
X-Outbound-SMTP-Client: 72.163.7.163, rcdn-opgw-2.cisco.com
X-Outbound-Node: rcdn-core-9.cisco.com

On Monday, September 30, 2024 6:25 AM, Martin Wilck <martin.wilck@suse.com>=
 wrote:
>
> After commit 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a wo=
rk queue"), it can happen that a work item is sent to an uninitialized work=
 queue.  This may has the effect that the item being queued is never actual=
ly queued, and any further actions depending on it will not proceed.
>
> The following warning is observed while the fnic driver is loaded:
>
> kernel: WARNING: CPU: 11 PID: 0 at ../kernel/workqueue.c:1524 __queue_wor=
k+0x373/0x410
> kernel:  <IRQ>
> kernel:  queue_work_on+0x3a/0x50
> kernel:  fnic_wq_copy_cmpl_handler+0x54a/0x730 [fnic 62fbff0c42e7fb825c60=
a55cde2fb91facb2ed24]
> kernel:  fnic_isr_msix_wq_copy+0x2d/0x60 [fnic 62fbff0c42e7fb825c60a55cde=
2fb91facb2ed24]
> kernel:  __handle_irq_event_percpu+0x36/0x1a0
> kernel:  handle_irq_event_percpu+0x30/0x70
> kernel:  handle_irq_event+0x34/0x60
> kernel:  handle_edge_irq+0x7e/0x1a0
> kernel:  __common_interrupt+0x3b/0xb0
> kernel:  common_interrupt+0x58/0xa0
> kernel:  </IRQ>
>
> It has been observed that this may break the rediscovery of fibre channel=
 devices after a temporary fabric failure.
>
> This patch fixes it by moving the work queue initialization out of an if =
block in fnic_probe().
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
>
> Fixes: 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a work que=
ue")
> Cc: stable@vger.kernel.org
> ---
> drivers/scsi/fnic/fnic_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.=
c index 0044717d4486..adec0df24bc4 100644
> --- a/drivers/scsi/fnic/fnic_main.c
> +++ b/drivers/scsi/fnic/fnic_main.c
> @@ -830,7 +830,6 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
> spin_lock_init(&fnic->vlans_lock);
> INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
> INIT_WORK(&fnic->event_work, fnic_handle_event);
> -             INIT_WORK(&fnic->flush_work, fnic_flush_tx);
> skb_queue_head_init(&fnic->fip_frame_queue);
> INIT_LIST_HEAD(&fnic->evlist);
> INIT_LIST_HEAD(&fnic->vlans);
> @@ -948,6 +947,7 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>
> INIT_WORK(&fnic->link_work, fnic_handle_link);
> INIT_WORK(&fnic->frame_work, fnic_handle_frame);
> +     INIT_WORK(&fnic->flush_work, fnic_flush_tx);
> skb_queue_head_init(&fnic->frame_queue);
> skb_queue_head_init(&fnic->tx_queue);
>
> --
> 2.46.1
>
>

Looks good to me.

Signed-off-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

