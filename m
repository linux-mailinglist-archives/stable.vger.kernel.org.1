Return-Path: <stable+bounces-124569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A96A63B92
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 03:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6577716CA4A
	for <lists+stable@lfdr.de>; Mon, 17 Mar 2025 02:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F18914A09C;
	Mon, 17 Mar 2025 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KkNJKd/M";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="yzgGyORN"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E527E182CD;
	Mon, 17 Mar 2025 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742178532; cv=fail; b=XWX7z7KEy8NZaiT7VC/1SNrjM/5xdXTvwCpHcw5yyes3RfDqZNAEEvrGqBluWgnJyG4qO27HBm2/oShyG2h99r3ng3VeylYc66UwvzILW3EZ+PUS/C1hvX2lUaMA3SwHnV3wxAFY5+MP/kMkAMQ/wHekl5EAz87f7Vg/+ZhcDNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742178532; c=relaxed/simple;
	bh=roDIzAK/zzHOP/hTPx7Z6E4C2A1Cf91Di12vUtOSwFM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICxT5xbgvYiK117BWdZ6XQVTjVl9cM4DdCd8kpwCzz2VMLYLwIenUwmkVwLoFB5JPmmD4Jw0TW5tOUwYFjLOReGWK2obzCfA21/HPDCv8bQN3DOvImmLJLsoNUUI7slWhGq0ku7OR+r14aRLg4whth4SDyTcp/hj6IQAywNGjFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=KkNJKd/M; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=yzgGyORN; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52GHw8ZJ007320;
	Sun, 16 Mar 2025 19:28:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=roDIzAK/zzHOP/hTPx7Z6E4C2A1Cf91Di12vUtOSw
	FM=; b=KkNJKd/MIFatzpOYgTjyK1a2vDLewhVLCJCQqHSUaplA9E5V98jzN16Dv
	V8ie9QM/Vl39w/3hVCeAJnsapXqWwp/7jvm63AZ4iXZekGlyYVgiR1Hwu1WRdHPh
	7p7xSjrm79ei7VGr0SwV8V4x5DMjTSNOuL6UfGm2Y1Fg8bg1YlYFjhs+AxlCgbfZ
	sDBKwgPB12cAoySIuTCQgEBBUo5BSSPSpl7QZxc2b8fb9rRDgH0lm4P8e3zIhnR6
	9zS4bH8MR2GXfIp/MZ27JZH2Qd1G7yE7l1qalVXgbNvbA2no3smr31Hl+jyklfXx
	asCfZNvckAlM+iAPEx/Pm0zIkqrRQ==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012032.outbound.protection.outlook.com [40.93.1.32])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 45d737a329-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 16 Mar 2025 19:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=govIsoP9gEGUuuH1u826Xqd4D5hjngmPeM1eTDQQmOM9m3Dl4aDAog4RC7nYCbBOCTXhVVNi8Sf9nA4o9tFpIemrn5k09Rd1vi9pvKQPcAwZDJ1DRj9PCFuW3AZ5V5WnrzlNjqtsL2qSnVVKHTHJL1gfcDLeEjxNz1dEfiBXIWOzwmtV0K/twKakpXwvzzZW7BIJEVv4WzpKsN3PkeUKxz5kEyU7Tr6BsUfE0KsujUAI7co5sHfV+W23/eHuPO1IxKF0h1P3l3pX+nBRHUYyeBfn2V5ZjZ8nR+GIqbe0nT/tpTKlLJlZRlCLl8P5tDjzb5NRm1vnm1/jPDykwvA4DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=roDIzAK/zzHOP/hTPx7Z6E4C2A1Cf91Di12vUtOSwFM=;
 b=ZAlL3XTL+e4cjLu1pL8KfgXvDeJt2w2B31xWERKxRATmDeEiYiCvNHP9Wr0CdSMYf26q/9jhSRA1l2eHHWNwCV7IFaR2xckn7aAzzh3Nu9IAwZFIJ0TNkMJfpfoLDkkkcVkCaHo0/ZFFyq+AsaH0bleRIQAJ9lw99TNZCkeCBmcGsxSBFRzS4EM8+5nQDKoo1qHV4/9sJOVLmihZedJE1OIpOcN4RkhxbsLis1u3vVqeA0h9Phjwf1Y2z53RZr2o6LnEBzYMvCIC0qSt/z890d4iuX/jp+qG0zUR31ySt0KOZFqBJqThE8PGniQ5n/r5TsaqfrJiTzN/5z36xzAEQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=roDIzAK/zzHOP/hTPx7Z6E4C2A1Cf91Di12vUtOSwFM=;
 b=yzgGyORN48+VqrOBH4K1gTuLKnvPWKvQjOk8BzegGUQsZI+arS9WTbt+CXGnmLX23T+kDjYJOaxUxcgdsK7Kbz4geTrhpxymAImm3W/tFks0jGy0o0VWWCL8HFgQxAAeEC6TzlSnz6mPkxqIKbwqHX87/IKnek3z3jZ0Rn+qAkml77lom1lkox07a1Vd/gIhhkZ6ILRQ3As/nvueDA4sJ4iNLDcMSvb1maLYz9mDVaHQDY0Fw+ycKDkR+/a2wBUxoF/SSGZYXmAottmAcYnJR0i6Wiof0Wgd7rUc9hb29VsZzpdX+OhdAlPi1BjaXEESNerJUJhe94ND/YIjY2vsSQ==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SJ0PR02MB8466.namprd02.prod.outlook.com (2603:10b6:a03:3f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 02:28:35 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 02:28:35 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Juri Lelli <juri.lelli@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann
	<dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>,
        Valentin Schneider
	<vschneid@redhat.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: Re: [PATCH] sched/deadline: Fix race in push_dl_task
Thread-Topic: [PATCH] sched/deadline: Fix race in push_dl_task
Thread-Index:
 AQHbj6GHm67dhCATrkil96yyudrYd7NvRueAgACX3YCAATetgIAAaUmAgADokICABED3gA==
Date: Mon, 17 Mar 2025 02:28:35 +0000
Message-ID: <71A41F54-E3B6-4D47-A8DA-4BA7075D949E@nutanix.com>
References: <20250307204255.60640-1-harshit@nutanix.com>
 <Z9FXC7NMaGxJ6ai6@jlelli-thinkpadt14gen4.remote.csb>
 <8B627F86-EF5F-4EA2-96F4-E47B0B3CAD38@nutanix.com>
 <Z9Lb496DoMcu9hk_@jlelli-thinkpadt14gen4.remote.csb>
 <59E10428-6359-4E0A-BBB2-C98DF01F79BA@nutanix.com>
 <Z9P3S_GjAQPSedbI@jlelli-thinkpadt14gen4.remote.csb>
In-Reply-To: <Z9P3S_GjAQPSedbI@jlelli-thinkpadt14gen4.remote.csb>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR02MB8861:EE_|SJ0PR02MB8466:EE_
x-ms-office365-filtering-correlation-id: 4f1070dc-044a-47ed-2edc-08dd64fb6b69
x-proofpoint-crosstenant: true
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mn3yrI0c3AYfgqaN252txq8E7k6rBbDYQ3DhAO6YO2eenouIG65f4wx8WMkP?=
 =?us-ascii?Q?XMFBjwX/PaeQUCJvYKrCwFaKDDD1MHMx1ohjOHOw0+MhdL/j4c2n7YBTNgPF?=
 =?us-ascii?Q?jv1yYizq/QCnCpr/iR4I9an1vuW1bBKc0EWwodIwCVWfQtSYR6LMrR6d6Y51?=
 =?us-ascii?Q?Z3ZkYsRlZI8eG1iYEt/W58LA1cgLFJ/ZLXDB0sPmPzup7DfIZ7uEshy3kUKU?=
 =?us-ascii?Q?xoR/346JxV8ctlTAk8hnVemCRus367jFPkEKQYR//9+qq/v3XtrUx9RhRJD/?=
 =?us-ascii?Q?FWqUGfXMlVOm/Ph9q45Ha6gG1Ebp0prqCo8HmZJTg2oC6/C/g4YzjVLUhdR9?=
 =?us-ascii?Q?3+Hz3LKbYwSgaIYLOl+f446DHJya8TIxzEvVqHDg4wR/X6dIekE8iGM0aSPL?=
 =?us-ascii?Q?RhDgXIerk26842IN7MiJpekL0BrV8b5/pwUELDz58MLhFnBifYhfzUoYkica?=
 =?us-ascii?Q?GPNFSldhNFmxYGcT8t7vEZUc5XoVs0NWPH+Ffz1YQWHxQTFt8SLtonw2KIEI?=
 =?us-ascii?Q?2owAho8CLfWEtT3SbipIKoASfB7WXn32D/B+fslHHWteiKoMv5Y9KZBFAc+Q?=
 =?us-ascii?Q?sqP8Nf2QRuH4aAbHuIAFbqeYxDqo9GLfPUbylEYMz3C1vSphe8TCWDC81tR8?=
 =?us-ascii?Q?yG5Cq0faUL5EIz2rpHeOEGPcEGUXZbp/WMfmGcmYYUceq0uK+lQfZEb7QK8H?=
 =?us-ascii?Q?0wxS+S6k48pjJcDnC/lRxv4s6/nkVOjRR2q+wesgTTAKkCVNAZYtuvaYlO6k?=
 =?us-ascii?Q?JA8V37NXQqRa5GdXj7c6IMcDxHn8tZBsfJy8vph9m/EBUeb6djNjj+D2h0PJ?=
 =?us-ascii?Q?cOd+TqBH5O3seQE2g3FmMdWbJQBYbvDqY5ZtLjDldBAna5ZbsG1fSlCcQtgz?=
 =?us-ascii?Q?EMCy9HtbLq3FDmLMn9h9bHHxFmgYXZNxcmv+73lZh0dd9ZPkiFQvfxtHHHKE?=
 =?us-ascii?Q?o4IVpSJPPGd5qsBnFEa/LoUbtC2tcyNKhVwjpTxuGdgz9ojezcXybPyvHC+t?=
 =?us-ascii?Q?V6R5bMjgSZJPIRJG9TZKIF4wW7CAGbuiUvhq0OwMEqt9J3Vj9THHUWD5yM8s?=
 =?us-ascii?Q?xrLlA3rotC+LeTBCBQVo0Bs+LL+0l+V3eGzMFR9G05DgnRDzLXuy2nMZcsMq?=
 =?us-ascii?Q?ne7tetg233hqLMgKkD76UHI6+jtG+4GqR5HiNkY3FTnuP4PrjL1tu7ptlaeU?=
 =?us-ascii?Q?4aOhScerxEv9LiWmNj8sJEFebpt2LmPS7/uis1vdJ3sBNimz0aH36NXeTYgG?=
 =?us-ascii?Q?96NZ5JMcEPveDNHiYTCzmRNEmBGQfWj/AFMm3ngD82OQIDXHjNlFORji/dsx?=
 =?us-ascii?Q?+TEs1Tn9dj6a/yOlx7btBkkR3URuNlSP7DOikocuHTihrMTbRIFPG9dmw/fk?=
 =?us-ascii?Q?e8NM0ae+2LYCqsPAEiUKv1ZPR1nw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Ty3ya+FI9yKKTJOg+IPOV4pMhCatwXEDXkMJCCLVJNei16FaTSxcfrFNP4B2?=
 =?us-ascii?Q?izN3CumNxtp3FgTD05b+ItMie9nfW02EI16abjywV/QAro+i7t0570rhxu/j?=
 =?us-ascii?Q?TpFWk4Wkpd0y8KCCyfVHWMrXFHS9x7pEUV5gYGO4v+eKA642aW/QrAEGfp6T?=
 =?us-ascii?Q?m9Igth8MA5a8yj6pLfGZgy1jYYR8REDBcPeW3wqg7VLZqUAT5Mn+30AEE6Ve?=
 =?us-ascii?Q?RIq2llijFIsKEc21IgnigWrahZSaK1AYEFM3hhxuRJPbL+u7p5fk5KYDBTZg?=
 =?us-ascii?Q?ag34TrvsWZeAVs1dw5XKNwPDcq4VnrnvXqCbDFid1G9cfKZI5Fy/12yMkYy1?=
 =?us-ascii?Q?mkO+mcgFR0ORTE+SZx5Xn5NC5uRZw9WFnWGeHCF/3hMEG6MB7m+QJhoqCY1P?=
 =?us-ascii?Q?0pB8zSPHIRFJHflbg6ARA/6e3+y/FHmbH1ngs5QzOyBbaYH196mI9NUMmr2j?=
 =?us-ascii?Q?CmtvsueZ87EcNOPiVhLLV/68r9AbQOlIQBOgNdrouuNzlXnPijWegv60HAoA?=
 =?us-ascii?Q?yZ1L2dDP5fx6fPZNgc4233queFJyYYNwWtLuAKGXYpeyqramfweQz7g0p9aZ?=
 =?us-ascii?Q?CZTabHTEmgitrcZ0cl9knMKEQQ4Akd5xhxG8Ls+1Pfnckhm0Q9kKfeUUW5M2?=
 =?us-ascii?Q?0VBifoNcmNGKPRE0i8kvwj6kjHBpkJvs1Mb8+SvS2eQWzx6y11xEsIH2qM5S?=
 =?us-ascii?Q?pryUtNNnNPQHLq0f+SxTsC416RT4fC/tuITYNWm8ARGRszZnv9QvnhaxUWVH?=
 =?us-ascii?Q?ET+DHQ3muz1+oT99Xu8CWmtuSVUA3krcTTUZm3DztcDzpG1KrR7FpxrMoUQ8?=
 =?us-ascii?Q?swFybRPwzXqaeyzoIR6thQ7BwzESmnRLlZIHLfnKN3kLzsSaNgTO2YvdV4Nf?=
 =?us-ascii?Q?IchgGdXP9jiLyDyLgsXSjjPVd+YnBGN+ita4HiITLLSsSyNT39Y58U5pyGn1?=
 =?us-ascii?Q?IvD2rnlRElkirKwiBreUoCBwXMPLGy1RggvX7PwiekkNu0AYulC/tG9OX4da?=
 =?us-ascii?Q?/DX7R94BC9L9JPkPALbZtQLSKDcTcj5MqN1UP2Nhe/6Z/ycOut8qZm9JG/dp?=
 =?us-ascii?Q?R4n0SJGCZgp+61DZZg0Aa8BDCyRV3NklIoZEqpC5DrbaPaYO7dyOv6u/Fvb6?=
 =?us-ascii?Q?CCr3yHcCMRUnhDjAthVhkfp5w6e2m3ElPH2SN5auKeqNgRslxUg7Euo4+dR2?=
 =?us-ascii?Q?jpwBzBO0BEWVwNjMFzJohhQAgNZOqTH2Fvm32CTS3iUQbWipjZYupMpWdSIc?=
 =?us-ascii?Q?eciBwkvXDgO6+ycG0R1Eef9fMeXgEEhAzn43WJL1qDOCt8vHstkktWsF8R5V?=
 =?us-ascii?Q?L8YOWxfk4Qwzaq7XfLDiKNwcNpOqSuoLmhwacLQINfpDlzAAVT3B2gWr+I7u?=
 =?us-ascii?Q?EQyZMLiDeecRhSeW10Wew1S3A3YDXcE7yPLSR33/KacX+8ZIeB0+C5u/I+YK?=
 =?us-ascii?Q?e4y5bvOpcS5jwW3bcNekBr//Z0o1sl7Dgsho3uMMZC7+XYSo2fbLkbkkndUT?=
 =?us-ascii?Q?aOj0G8XI8KK6e5tNy8goXnYinlGqbzAqMC3DJf94BK3Rpa8Wd9YGm4UGSgxC?=
 =?us-ascii?Q?GqvTyhb3Lse6kVf3jRnXXKPB6gxHDFbPcDKnNdUNnDjk2o9c4MdJLIZybd1L?=
 =?us-ascii?Q?AkGF3pBVGl57lb7DJmOTyF0x5gi9tb1GDpPTg+/S0IS7?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4505914222669D4B9614F5ED9DEB1736@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f1070dc-044a-47ed-2edc-08dd64fb6b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 02:28:35.7626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gHSePbNH/g0uZRDFIyNcqxAnusQvUB9KIFNY4RV/NPFsTihvAs95WHgdnaBxmaePnSzYwQpgDoE7y4woAyKhHRhTvov5/P1OF9WYXzFDpbA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8466
X-Authority-Analysis: v=2.4 cv=CLsqXQrD c=1 sm=1 tr=0 ts=67d788d5 cx=c_pps a=fM4bIjZpJamw6RFag0UgWw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Vs1iUdzkB0EA:10 a=H5OGdu5hBBwA:10 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=63L2ifQmVesAtp_6NBsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: g6ThbIkNiqBrVcDkzWygwjHymFEE4UZt
X-Proofpoint-GUID: g6ThbIkNiqBrVcDkzWygwjHymFEE4UZt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-16_08,2025-03-14_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe


>=20
> So, it looks definitely more complicated (and fragile?), but I think I
> still like it better. Maybe you could add a comment in the code
> documenting the two different paths and the associated checks, so that we
> don't forget. :)

Sent the v2 with this approach:=20
https://lore.kernel.org/lkml/20250317022325.52791-1-harshit@nutanix.com/T/#=
u

Please take a look.

Thanks,
Harshit

