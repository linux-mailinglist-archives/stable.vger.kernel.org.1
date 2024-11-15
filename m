Return-Path: <stable+bounces-93501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 191509CDBCF
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 10:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 807401F23580
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618C118F2F8;
	Fri, 15 Nov 2024 09:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OVzztAye";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sv923cn6"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8090317C21E
	for <stable@vger.kernel.org>; Fri, 15 Nov 2024 09:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664149; cv=fail; b=YdZXrthraHCqnaCaHbOLr4EmsNgqh8g2qymu0hiv5EWbCSUcinERGDK2gIF1aZnLtAyjzD5Ca+7W9mIDtQ6eYrC11v20WrB4CK7l3deWMIki/DqvCpfUznvPBBJWQr8HTUoUsuJf3SQQ3FkAv4ltRBXox5nCPmBkumuKroLVSa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664149; c=relaxed/simple;
	bh=oQ9/SKneLzZAYKNUgVVkmYLdkUs+HtRsR/HJb2w8lhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KmZJCjeakRQdyEgnCDWFL5d60HAsiTwPWyyCVNH+Ax4MS6Wx/l7pamAEVaFBnXoagJ+jWy/OvR8xjhIJUJbmMXAQWk00kCfmWx7AUuUyHhcHWlfz4K4xbHHu+W7s62v/Bo+rZDtcP1dI902v5eki3O0nnH6C3rlom44AM3rAcF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OVzztAye; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sv923cn6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF8taZg004040;
	Fri, 15 Nov 2024 09:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=oQ9/SKneLzZAYKNUgV
	VkmYLdkUs+HtRsR/HJb2w8lhg=; b=OVzztAyeERSF8j6Dq9YZ29mPMat6F9KW9S
	iK2xXnC/J9v9F7rVw41orqqZ7LADYqv9ONOvkIBtebLBSPBmtFGg7R1BX0U5Vb9M
	MtsQ/4CRyed4iyRJV2ZlKCdypHW00Kud7BKnVLGmfTVKnClrCkw8hradxnI9QoqH
	F1blJ3zDcVYpuJ8iM4HnqbjLla9uorrjD5YgH7ASGA0uzfLssyTW9F/Zmnj+OT3A
	EmsJiQcZjNm4hEhFS1oavDVetnIrlGA2Xi9qCjCSxcO0lnWaA9yL48r7p42ozeUD
	VLJpT46zSjZT4LJxg8CQJOLryfZIJorCBdH1J8TZBKLq/HgdkvVQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbk5rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:48:57 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF899LB035895;
	Fri, 15 Nov 2024 09:48:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6c01ae-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 09:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqucYz8m2hGIQrqhv85IVt9+sNAHQ1jk9m/2FLXlUVfiN65nGoICZ769xM5HAizyFkZKeo9/lHMZGNAhGntMJajXBIzOBjZWxP1v4iv0FaEZ7NyP1CKPjZvXsIZMVOfqc3PGYnEvTN8HmKkMr8CtL9RSBwBYLKx7h23YNM+XrWz7EI9b/POoqIJXuG4f3I5LrRHQ71B46Wz96BixyeEZYn2dxp3w4YmuPWA/88bd3TIpt652WXpERmCC/mxZ+2Kd7xy3rc7Ls4+d91mwIDqT1VC+aAdwt4ocTEwVbrq/Hd+WhZl7d9Dw4eRLRj3WbfpVCIlEXCNzuS7ZogvSsmSZEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oQ9/SKneLzZAYKNUgVVkmYLdkUs+HtRsR/HJb2w8lhg=;
 b=nlliTWu7/9jBaiEkd5n2flsY3BkqN7oxQg4vrWaR5re4485bAzcqHnjeL3CiWzeknSEUcR0H4mc5xOrXp+PVCdMUhEGh8t6CV7C1QKXFjJqwjjnmKAfGEwqXRN0/UA99UYnqAm3pzc/w2rHhmqSEXw0PU5TiqyzraklIZkHAfxMcek3QBtzBTe+hZkQjXtmjxaXaztZnEfTcvafYsuBXa/jidDhyotllYhoqqC++BUp+4iRjpaunMDh4drhJKOV6ELq5phPrZOQjX7/Sp47poc8mZ1y5zMnvNaleV/wqEC1FqsBJBU9VmQ5EYU0CmSgywk0Lpi4x3t/fTyreaAkh3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQ9/SKneLzZAYKNUgVVkmYLdkUs+HtRsR/HJb2w8lhg=;
 b=sv923cn6G7MoxlIDJJtszmRqUqkNrS/U2jsxh3lf5u45DrRzxhdE8dPqqBja4KLIvmInnw8osk6qM2W/3r0Y15fIW0hOujcFrQuI+ekyT2iXnUC4cp8jpta7lGKfvEpbxKll+nM34CwiyRcp9oQMmRa3onVwluT3dEqWwtS1NlA=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CO1PR10MB4754.namprd10.prod.outlook.com (2603:10b6:303:91::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 15 Nov
 2024 09:48:54 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Fri, 15 Nov 2024
 09:48:53 +0000
Date: Fri, 15 Nov 2024 09:48:50 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Jann Horn <jannh@google.com>,
        stable <stable@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 6.6.y] mm: refactor map_deny_write_exec()
Message-ID: <001b2b0b-97b3-4a10-8779-3b780bd53250@lucifer.local>
References: <2024111110-dubbed-hydration-c1be@gregkh>
 <20241114183615.849150-1-lorenzo.stoakes@oracle.com>
 <2024111540-vegan-discard-a481@gregkh>
 <bb420574-76ab-430e-838f-18690196b175@lucifer.local>
 <2024111520-freemason-boil-f2de@gregkh>
 <64dc674a-1152-4107-a382-b1167cdfb202@lucifer.local>
 <2024111523-energy-punctual-7b85@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024111523-energy-punctual-7b85@gregkh>
X-ClientProxiedBy: LO4P123CA0182.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CO1PR10MB4754:EE_
X-MS-Office365-Filtering-Correlation-Id: 7deec952-f3c9-4275-3138-08dd055ab761
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EuhON3SYwlVGzcm5B8yjFsUxFuGgfOgr4fxXaartodVbuokScEADUuXSKDk0?=
 =?us-ascii?Q?2etnchR2x8MKKmcVKjZAxjarSirDAc5AJUJtb0YkLkLI4GGLGeaRRwFySgGv?=
 =?us-ascii?Q?/2e99lvYDbOTaO3tTAzWzKnk48oPnpAW2S4PskStpfDj5v/IYZ5SxZ2sgWFF?=
 =?us-ascii?Q?JirypLvm25E62MATaYYLQemOaBsWEz3THC290BhKzWl0BQwiqNxIUqzcXbjl?=
 =?us-ascii?Q?3p63veghjgqhfwgtMus3KV09Y4mt4Ta5byg4x2aMvMjI6IHm+hctDpk+w5RR?=
 =?us-ascii?Q?lKL4NnTzXjKUjxh+CvUh+aJ9XxEVEE0ZGmJBdREx8uVr7k3KP4i5pZNeRX/9?=
 =?us-ascii?Q?K/hnzDZcOuyr9BvXH5j0OfRu3Avp9XV1Pf0ftrVPkXGJyc0G+Rff8/wx7h52?=
 =?us-ascii?Q?H+392ZwC4LsM7Yk0E5iIuuARX7FhEwrVizCYZuRPaP94cI5NwoX8fpCMQYzH?=
 =?us-ascii?Q?7t9Kliyykcu50Xt/bqydHhV30hO5/3PRomeRQdCU4G0GJHv7YkFruKLHondv?=
 =?us-ascii?Q?bCUFcDiDB68TV3PLvkdjh41zJkZuNpLsZK8OVEqkFn29TqaVBVcEJBMhMDJp?=
 =?us-ascii?Q?jOw4OuX7yCzW3/Ci+jA2KCvNWuX1F1tHZfXaZSv+BxnZjjOnp0ZWV6kAFuc4?=
 =?us-ascii?Q?sQwrSZjdTNR11WYyEnxlb/WIegdsKCgvWgzgxfazydrSS1MKuo2Mf5Lb44m3?=
 =?us-ascii?Q?NXKTE+1zxSGREaY/D2yHtFguWbfLRRGjjwIpFazpEaJp13xvKuKUtRugz31u?=
 =?us-ascii?Q?BCpbljY5NAekxc8rWdoji338AxFoRQm+/HRQqEmEjoHCE+QYv59QGTRBDyPM?=
 =?us-ascii?Q?pemLD9pW6bj7E4Q6bz7dfYuEPgZaqhp16ozpBN40epH/+j6UeIA6xq4XrID0?=
 =?us-ascii?Q?cO9C1Mn4OthhwylA2owKRwxFWHICdgJal2lW/QYFxahuzw6fJD+dXds5wMKt?=
 =?us-ascii?Q?Ft282g4Bs09MLyU1VuSGRc0VquGbBq7yEcJnMsp2N97mBLrzD2uWCSZW2Je5?=
 =?us-ascii?Q?w1G5WE590EV1Wai2DRCgyV4i3mWgzUUjd55rcEQLv/fXTJ2ujeMJePMG3FfM?=
 =?us-ascii?Q?IYPgWTlJIVTLQtwpB635oIErXSIR8ld1KgUu/yk7DkEAh7ye3q1EXnsRlAs4?=
 =?us-ascii?Q?bzmdja3/HIrI17HYY2tqDyw2K45P+pqsaxdReAB9HGFowOXaMOUWtBGUsmxe?=
 =?us-ascii?Q?anqEKc0uUd64X8EoSgy+XRXEzldE++Af9QbWOdRYg7nsrv2TCBUtDJWKfvs+?=
 =?us-ascii?Q?tYMchmKkGbpxlNivwFY4gn2U/xYOt2gynIteKaJmjsBuuudCATKVmy0Pr1WQ?=
 =?us-ascii?Q?p/PfNCtw+VXZ+oEjY5Oy33zC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9N3pkbDnUkTz7rd0N/XcROjz94yL6FCuDTWhAn1Ft4FnO+0tbzOA0nklU25S?=
 =?us-ascii?Q?wDx15lHTtoSfaE+rJ+EF90mxL8f9FeznUjzF5sVZv3ng9+6Jy+Zz1XcZzK2M?=
 =?us-ascii?Q?xQUK0HrNjg+EjHMIm857/NmQbwvBgJ2r4fnwlsrlc412w2ID8NN3o0gn6mGm?=
 =?us-ascii?Q?g+fiAeR3PpY6tATUvtieRyGvRvCPBSXWckxukfINJ2a8BW4QkOooFeVwPGbG?=
 =?us-ascii?Q?j5QQiSBeflFjYSzgFP+6US4Y4n18GQVOXG2ypGgilMgSK3DVA/Z1PwHRK4kY?=
 =?us-ascii?Q?nqt/FiA9AuYjQp3F3XAKHYr89/UNE15UOHlhzICOMf1w68M4KNf3pO7WoG/I?=
 =?us-ascii?Q?cad2ehhBptRdrTSJSsqZSoa0CZO5aMCzQNISgCZ3ANuLXU6zvq2gKpi5hPd4?=
 =?us-ascii?Q?KJZWOXU+pYp6wazU9XJ0TCPWoV4IoTqVDvJwb0x3TNO14QV5WCjm7GBGg0MD?=
 =?us-ascii?Q?vr8IbSNIIfvSN9xbG1v6wSntUZdgbQ0Xl/C5mn6jV9tQkQ8dY7L0HlujdgeK?=
 =?us-ascii?Q?0yjsrRxEXYxQFYrpOvgBEqdV6Gu5/KROP3mhaLXmv3BJJwUlU5LTse5/sT6T?=
 =?us-ascii?Q?BAm2Hp/FoPM+1ovC2H/JF14BNnl9p8UoCPHW6jGBRL4pe27BGqCIWut5QKNp?=
 =?us-ascii?Q?O1+9AfCF89jdEo8NWk3v5wgwyateDtoI3GBZlrzltrd/k5Q/TYqxe6/REouD?=
 =?us-ascii?Q?ciXIh6SmvRIu2D+moMfPAtTZpfYyr77zW9Ti+H7ln61QyM/i8tBx29RA8CoD?=
 =?us-ascii?Q?q2Tm2qvpUujgK52vzBhtS7f0jQu8zOlgkUq+ZewhE0XpeBHFTLmiTUoyslwO?=
 =?us-ascii?Q?MmzQXXXZbpL9sCv76jQkPUgBwx9bDVwEqTMAhCLkiksf5owmYlRvR6Ljw9wF?=
 =?us-ascii?Q?cQyDFVakzuQI+Wzc9sz2JU9RyALNvSCwxf3vHBC/5Ige6wROO+8U8KzA1e4H?=
 =?us-ascii?Q?w05Te3ziUgrDPp4R1KnXq4m/Ix0w75nRdEK89knIHLF7s6LzDjBwnKMNNWes?=
 =?us-ascii?Q?KecRRmCD/p1sXb08xafT7xLBiESfzWn++JAFfUT3KfjHQ+axNO8rEgzarlwX?=
 =?us-ascii?Q?SQ7WmIFCrAbhS6lVf+k8nuB047I2rB25+r3q08AuV/8ulAQf8atBqiWP90Zd?=
 =?us-ascii?Q?uQR/lVyr6tT1dCvxLAoViqQcbo50WyPAqxYdSTzVfZXy551mqFdr59+Y10IP?=
 =?us-ascii?Q?STi9E3S+5uY8Bx21RYGtaSWmo5TXVxdMQ3TDlXYOmPl+XiTCDCHACW8Cqxgr?=
 =?us-ascii?Q?cOGLjjXzIUOE9D5rwYYm5PP9IgVIApLV1P31U21LWyfjoFCPEzBE4dqWR0qw?=
 =?us-ascii?Q?Jfsj5hKAhRN/AMs1QxfW3Stoca5Wqlhfv0zh5BwpSoy0Sd0/8jwt3l4Ab1hf?=
 =?us-ascii?Q?2Me21bNcEQbRt1BjJgp3dxm6jXLrfP+5lHEUTjSzyV386HWVQqJTX2h2tfgY?=
 =?us-ascii?Q?WcjytqlURO1bVPvaooU81cCmDB9KLE0xpgY0QuLQQPpFWqnIMjsXK19eHN61?=
 =?us-ascii?Q?O1vlqsiqTnwALcveb8EyHJHmduDLnHC2hvmIZrUNlgBpfx+avj/nrT5tqQGm?=
 =?us-ascii?Q?OIihlw1uU0ySTWiI+JAMLXojdz/GKJxIog1ZNAejRgK3QxioJTMf//P37MM+?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SoNoPcUtZxeurRa6o/F3X71eg00HvO/YdL0KK7NAzKftAJ5CcCG+9C+Hi3TMr9yCyfIu4eHVR7oV93jVnKE5NCqszQsMA8AxCIR358eCN47qnLr8LG1E2vWWMe8Fwq8aeSexkutuMrsp0gaBZ7V5UueF/Ciql1DKZsxttw4g8SbfoXhl5CITErkAM2GjwisBZedV38U7tz+cmZdB6k6KAll8Pwjhf/M2pWBrwStio7UJ1QN358LTXQls47KzPcFxArzlFcOegQaJJZ/7quMdN41GoVhwxcNIa2M5bE4nzNSycpHIjmFiedxkoP1a6hF+lxoSZOWcJqHazOMW/cAhHl/jd2h2dtgbQcbBdV/WCayudMfg+W+IHxBLhFzsHmCVcbOqr7NcX2Od0ajR1AdOGxSehNgyp5OixQ50TBPM2sLDaP7rqgkFMDZCYjCfL87krgZkK4stOl49zUkhaRaZIH4bxVRygs/t8YjB0+subMLVvUMnjmbGx9fFWUQi40PsKs27FUe/MB43ycVUNsbAb7tRHqsp+ufya0pxHZUBZj7VUdMDhnXCYZtM3DKhlsFpQHBCqKf73S7DaP8pYdh1QGYs77G9QptYRsOuH4yDvS4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7deec952-f3c9-4275-3138-08dd055ab761
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 09:48:53.9284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V01IIUCUu8r5BOdcOCapqn5g69ZXLgbFmMkN6UEgyf2DYgjWOJypbXUNNNGHTBolMMb82sS2CXsxev2whJwDlS23HxfRJDS0E2MLXQnOwh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4754
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411150083
X-Proofpoint-GUID: EtX-ltyrZYcKuehcEv-EnSN_g31vo0Kd
X-Proofpoint-ORIG-GUID: EtX-ltyrZYcKuehcEv-EnSN_g31vo0Kd

Please ignore all of my series for 5.10.y, 5.15.y, 6.1.y, 6.6.y that I sent
yesterday then, and I"ll resend _all_ just to make sure they're
(ostensibly) correct.

Some have cherry picked upstream git id's some don't depending on whether I
had to (painfully) manually fix up or (painfully) resolve merge conflicts,
as I erroneously missed that -x added the (cherry picked...) comment.

This way I can make sure to cc- everybody consistently too rather than rely
on the git send-email auto-cc.

Thanks.

