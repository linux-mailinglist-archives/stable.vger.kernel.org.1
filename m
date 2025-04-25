Return-Path: <stable+bounces-136654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1FA9BE36
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 07:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26FE1B684BB
	for <lists+stable@lfdr.de>; Fri, 25 Apr 2025 05:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B5722A7EF;
	Fri, 25 Apr 2025 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="DORD8eEK";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="rDQR6UOT"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0a-0014ca01.pphosted.com [208.84.65.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F33CA6B;
	Fri, 25 Apr 2025 05:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.235
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745560560; cv=fail; b=nxmuwfDFizblD7yEU6nt8ERNI7rZmxQ/pdptw3KuCSU7rQ5sxRoVQ+M76QRkZ+Vdkk2xZEHRAgyuyX3bSnCHiBec1rFioAr2qcRchBOacvfNZMgrHM5fqOMZcryBOkIcLRJhJBUgJUEtzNvoKGICBQkazfifkJK4ah7pENMP+V0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745560560; c=relaxed/simple;
	bh=o/EJTq/oMsQrm7hyz75NKEGgIQJY+xjsjQ0yinlBuaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JbrhBAxFjOIFTXf/NDYcE8HOS47+e/jaA//CtN26iudJdIwNQZlRcKfK41YjkiuR59rJys1lKCvcB6UcTAEmQnltfT2jBQSGLfx/r4v2Bi8izpXCVKLKu1QCmZCdGkWDtvA6REwsoY4Tc9KNtnmVcuTrdflWKJNob9NA/pyf/+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=DORD8eEK; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=rDQR6UOT; arc=fail smtp.client-ip=208.84.65.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
	by mx0a-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53P1cIvS028369;
	Thu, 24 Apr 2025 22:55:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=OAXTVofzwh5gNVrVfzeGiJhsZUy/viRUf6ahzgzwlp4=; b=DORD8eEKjeqn
	vUlvJ7dJFwrR9AVo3uK+5jnX3oVrzGjNsfOB44DvfavuXaTl1ocup1gH4GscD+GZ
	8CGFfxAxyChOLvH0KoRC7s2YBbU/TXkiPp91/iR72VmisxwMHUnLVwUzEQEvOCKs
	FFLdXxfNR0Az5Cn4Trv8hN/Obb9fomVfiw0YHOORYHF7FyX0oUaHWTsBdXHi9gym
	UBJlL4oKt7sadzVzSH8RAtEXazAIxiWS7/DEBHsgXE3ptrAg/EzvXS5PYiH2JSt4
	rsiwfD0b02PPbjHmznDih6cGMKtf9T43J7Vzipfrg9MMzkxI1z/pDz8IkrB4zw0g
	mA/PcLK8Ew==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazlp17012033.outbound.protection.outlook.com [40.93.1.33])
	by mx0a-0014ca01.pphosted.com (PPS) with ESMTPS id 466jk0uwtb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Apr 2025 22:55:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FDbsedDjuo6vJV2Nh3+XyAxIEArgJWdWbBCB1QExuXfObI8IV9zKRASljvl+RNKlU8zqIGsyJdDxkL8pF8g6FSTYPFNVRfqXto5Nsqvc1OpVBq2LqUwwxTig5OhTN/CvHYUFGCkCxovUowDx/pHMuXt6bVZIZ/iBkvzwk5+LBEj+m8IilCisUZ+KiVyk3sGz2xgHFufuWzbrqecZMM2o1ICFI11nDI3W+aUTDXAndthHZ9Ufppr/7CsJwyMY9DDvpuIgEdWs3ps3kDBKr6b8W4Qoefq0IP1RHMJVq/A9XeNyGQI2CQaam5RS/wX1YpyyFwzT43ttAPnDeRVdyL9qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OAXTVofzwh5gNVrVfzeGiJhsZUy/viRUf6ahzgzwlp4=;
 b=IU5CwHbz/lam/MCr4/jsbJ0LUdqVPryBEcxUGzqSZbweV2JyDo8hrC+b1ERJjDMEvHlHJlXfmOWNEz8cILUIChBPq9VyUK8vteyAc0AqKdW9jW0abxVeCqJkG+dKP7lLLN+usPS1Q/knObcugfLOX3fE/LKTkqgSjllp2R9TfW8yj/JdZKBfA2s+k6dN6ywwqarLLeiXUfOONfs/8vlcdiYigVJ5TG3GLARHuzU6RrMEW+Q307L6N94WvZMjKrJtibUXC7+tVktZkmKi2VTw1FXjGpsu1tLv6u1v6mldF2Pi6e41G7X079kNSq1WkzfEvbfO9ggOQa9wZNvwa9UO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OAXTVofzwh5gNVrVfzeGiJhsZUy/viRUf6ahzgzwlp4=;
 b=rDQR6UOT0RSGnK32EVcdfxyROO5T0vemGse4jXtE1Vt/L8x7sKzi9M+RtYqRNnf2uoe17Zt5FbieE2D365gmJcPQE5Ic1kbOfjY4SiDsykcyDxrdgLArBJ5QbhpMr9CVTjTnf/At20uUV08mW92QyZvbw8HJKwWINoEgwf0qiFc=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ0PR07MB7791.namprd07.prod.outlook.com (2603:10b6:a03:287::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Fri, 25 Apr
 2025 05:55:41 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%5]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 05:55:40 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "peter.chen@kernel.org" <peter.chen@kernel.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Pawel Laszczak
	<pawell@cadence.com>
Subject: [PATCH v2] usb: cdnsp: fix L1 resume issue for RTL_REVISION_NEW_LPM
 version
Thread-Topic: [PATCH v2] usb: cdnsp: fix L1 resume issue for
 RTL_REVISION_NEW_LPM version
Thread-Index: AQHbtaXrJKGsv9vy/kiYVk8dX2omNbOz4W0Q
Date: Fri, 25 Apr 2025 05:55:40 +0000
Message-ID:
 <PH7PR07MB9538B55C3A6E71F9ED29E980DD842@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250425054934.507320-1-pawell@cadence.com>
In-Reply-To: <20250425054934.507320-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ0PR07MB7791:EE_
x-ms-office365-filtering-correlation-id: 45029c4b-7985-4d72-3e33-08dd83bdcf3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kjhvMlfkwhPMh4G8zBuYn9KKIC6FmZfuFi3Jr9CHytXyWrWIlp9zuc5rORuN?=
 =?us-ascii?Q?1ZAHKngCeUDWRM3DCOzTSrMW6K2SRLDAAxk8XV9PdbHObGPOMYR/v2AR2g3D?=
 =?us-ascii?Q?OLAZ466N427jIBE72hfVWwyzyaWr4AF5uef+dHluuZ1dHUPd/SNwboBnKHGr?=
 =?us-ascii?Q?428M6ciphOq2Fa5wBwLMz6uU6q79alq132XcUHmvMvDGoWX7peTEWRL72w2m?=
 =?us-ascii?Q?39TtQ4FH4eFI/ZHU8P2N1AgVBxkmWfUJGJ0Y0oxMIuB3ArBCus3ZkmduvqtX?=
 =?us-ascii?Q?4nlq27HqQt/tOdOdYpD80mrfCyfEbuSq/FYvkA9A7LauMOL31p19SZqCOLBJ?=
 =?us-ascii?Q?ZUg/6Xoc6fcvM/sDzcMNDDm2aa5FsbrRx/g9YQMxXBwEuHfwnhqLtjjp/r1Y?=
 =?us-ascii?Q?2oTWQRSL7EjfdCz4KlWE0j81NT1Jf4yDvxtcZGDD2QMsjJcyA9DbNKu+ts9q?=
 =?us-ascii?Q?6qlstgXJ4DVJa2szDpXPSc49D+j14Y3WBQ8aCpveHGymR8fuMZ0NH8C6Pzii?=
 =?us-ascii?Q?znUB+75MGS6B89J88Ni2YWJUPQ1u8mC2Dh4y7XlICJOd5l0qxpQtoeRsbFAW?=
 =?us-ascii?Q?pKRddsZgNME/i0rsy3LLDu85Ms3VqeaH1oQJRiV78s+vOu58IucUrfBSmtGP?=
 =?us-ascii?Q?2wea+4kjDiK+yuMVWS58TJ0efMTOdjNzn1/5Ayba3v2xip9dlo7mn7daw08J?=
 =?us-ascii?Q?BsshZSKZAjl5fj7Kk9ZdQwNaWk+YadHDFyPKKJK4noHNm/9lRtvl/CN8V0lO?=
 =?us-ascii?Q?EBD3xn89st07ramaCd6miwPH6ueiETwb+WNFTCkpTvghk+HXccYrF4QUMvyz?=
 =?us-ascii?Q?REzCIG9SqVtcWNILcH6A4R76Ma0RkHI3RtdFp6ucdUlToma43O7alYDWLURL?=
 =?us-ascii?Q?X8Y58u8bxXOtzCtOxvRf6/+aAG7QgyxFsVnaXc9Z3LrP888tRrIAbKZ9ntBy?=
 =?us-ascii?Q?rgLGu4LBqJ5itt+G15yagLgIyCPjydundmCdKHnzU3VSz5rUB4KyxfNdcERM?=
 =?us-ascii?Q?SAaWR+k+3NpZOu0Ev7/KQkJe5KnSbwsSYj8rIkjlYit9Etk/GKT8XnIq9dnw?=
 =?us-ascii?Q?mIqE7O8Cm6QYjcr5MjeKWOsqs9otR48flLN2/c3O9PQRZzsjhsqvkqwruZda?=
 =?us-ascii?Q?hi3VGERNXbwP0fJnen+olSUsjiXmS3g0CS14sX7/qPVoXrsc4GfwrKFE3ogN?=
 =?us-ascii?Q?qxPYw9wgEikiENRHHxlsM0eQ3VnMvFxDplyO3XGNjZ2bIbUs/CnFSLsc9jbz?=
 =?us-ascii?Q?gHxeRXPaRYt+gRcOS6pimMbW1pGe/Ui0VFYrtWCAAL10TU34p0+MmAt2fbuN?=
 =?us-ascii?Q?hgvpPFhjG5Wi5cICu+MUrOhWaQMadoOQKe2+V3AEM1yO+qJvfZ8FLLKfTelf?=
 =?us-ascii?Q?Su2lWRtgdCiziduom1IQRC3OEEwxISAJ/214q5mBQKIXLyprj39mBLrYtUAm?=
 =?us-ascii?Q?lr3YA9QkpgjR1pCFIRJWY9HKjhFV3eVPrYJQJvl+b0M1oiHGFxCbuLUCgPYL?=
 =?us-ascii?Q?FEWXVZXWbvLC3fs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Pa/hAyM1gTWGv6ZnmHDlpcaqhefvN03YZSs1auEkaPQsP5Y9J2d22lOHYLIf?=
 =?us-ascii?Q?zvBdEdqVfwRVnIdH6WfL9UuoqocZTB6CJnxl7FVpXrjbZuY3npgPPtnnJUka?=
 =?us-ascii?Q?wsK50hrGMrPZ3ub4eJqjXEyURnVX8q+Onr5xl0k88vnDhIXFs5QVQQlaYMCM?=
 =?us-ascii?Q?DPYJTPO6uf8T3lGsrX3bJaiRAk4zqKUl7aZqMpKjbaE6vLZjsbLaQED8kP01?=
 =?us-ascii?Q?CC0cOX1DJcIY7OkDuIbIc0uzA4YV9d/84DdDVLhbWw/1Oo2pZghdNFnZ4r7+?=
 =?us-ascii?Q?0Dtf2+Wkdk0KOPyAmjCumzyh2ANxkUAbCIygKUtv5d4bLsxziWpLbsPGFOXB?=
 =?us-ascii?Q?oczlnLAj8iSLyIqvx2F4McwmsOpAGU4XW+PLM52K2cty/xInCHlIdFHN/NY5?=
 =?us-ascii?Q?skeyxd+wkY1H8vqFd9T1C0DegFlANcJeuXe1UK5psxxy5AgWfb2WK5+b+uPo?=
 =?us-ascii?Q?TihrnasK8Q+W/GNYR98ED0pzgWzTEs2Lwbqm8QUjOK8aFwih4uKRlCIUtFz9?=
 =?us-ascii?Q?K04SFni+3Q9hXKRXWarmF18F/N8q/3rOwOeIcBwKoxrF0UCfV6JNsyV3H5hq?=
 =?us-ascii?Q?+3VovP75e5ZIRkHw9LXNNaZLVchvM04lcclNi/L2VOybbr+1TAWiWgmjufEX?=
 =?us-ascii?Q?WFojt/Z4cfN8E9cgiSGCfCYy/pCJOsBzVEUsK6aucAnibVLny9ML4OSl/K2O?=
 =?us-ascii?Q?RVOoS35YKnoYg9ZgCEYFDTXXiMbygKrIvyd+KEHLCChuuOqSyg2zehelKXuk?=
 =?us-ascii?Q?iXtF8k/+l8XUtmSIqgpN4Uxjlx8bfLhieAaSQTErB9yFe0MGjrf6W8ZrnFQx?=
 =?us-ascii?Q?7WnmGcOCvwgpvqflYPkA8V/Qhuo6/jVsaRYKa6pMgTtFNEwlIjs/ilr7MF1I?=
 =?us-ascii?Q?F1h/zZnFFJKLCIDEm8JgP4rayBdRYsvk0NNRZFexVEc9K8TBGNe/8EHbQ0S2?=
 =?us-ascii?Q?5/iLwcINeHaHaf72vK+3sPhqTUod9bNJ7QaZnDI3Sx/NuLbxHf9nkURgnAno?=
 =?us-ascii?Q?nEu1WC2pLp56JND9E0HMO1xkIdWzXoUniVxHzuDZZ6wsjBe2ERmZqzA0IRLH?=
 =?us-ascii?Q?Swnvmvvvj0EKrWKSf9l4B39bcJAByluHI8fn947Nz+X3tO6pM0STAcdV3hqA?=
 =?us-ascii?Q?zZFdglVHnh4DTN0/s0oAT3rZ0W7GhxMkSbJzRLrbuArVvH92FPjBvwaxjztO?=
 =?us-ascii?Q?6x/wcImOAKTisJxxDFHfWj9+zLp7cD5vxj0GYHuFnQ04KSpz3Xrna1fSsboe?=
 =?us-ascii?Q?QaLOwic1twv5G5boJ5KTOLXSQKdVoJZU5D2Hr8hignyItjJVtJjCClkygzur?=
 =?us-ascii?Q?er6n3Fbx4ZUG31Rd4kZPcltK5H6icGoaN0CWYzuV1c8hQTYTMvdRxFX8BcgV?=
 =?us-ascii?Q?I4yyi6OHmlSmST9nLyLYl9GIWxgzQYR48nLe8qR/ozdOxTvE0QgxwtaBzGxA?=
 =?us-ascii?Q?dAJjF/IiQNsPl9+rSlOdJTRuERBhJmFpr2b7aMEehb//r94pbO8J9I/Jjwn7?=
 =?us-ascii?Q?2JZBEUNLUW1yHuHVHfeEsuAtLD9VUgDmO3P7dlc2mNDq/muTfaWI0LwhdAWI?=
 =?us-ascii?Q?KwQs0f1wVo8PAij06gZooc8wNHeU3qqKG5XTEQd7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45029c4b-7985-4d72-3e33-08dd83bdcf3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2025 05:55:40.4896
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HSxqP9Rv6NtBBao6lhD2TKIVHYDlW81kdqLAQDubIdW6Y7Iq3XAtvgMixj3lCNj/Gd/2zA9seyTX4kUSpfv6tjKNdj6XtNA0Wf33nMwKRhw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7791
X-Proofpoint-ORIG-GUID: qgP4ParOTKhLbWpb1V-59gt_8OlzgSRn
X-Authority-Analysis: v=2.4 cv=Z5/sHGRA c=1 sm=1 tr=0 ts=680b23df cx=c_pps a=eo5EBrZojstUK48b9mIPDA==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=XR8D0OoHHMoA:10 a=Zpq2whiEiuAA:10 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=G1atfvnaOGGz1WnFNfwA:9 a=CjuIK1q_8ugA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: qgP4ParOTKhLbWpb1V-59gt_8OlzgSRn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDA0MSBTYWx0ZWRfXyDXr8TDaYjZJ O4lCab5OScOUnnti7DHZvUrDVVeHansSYgPB3mNhMhD3uaJ181fl0lp4daJjLzNR0WLPNDttDfS vOniaGzyaKirS8i27RHYhqPKMzW1I3JC8/bSeDolojO04ZqhPZ24fQ6ZDNUYd6UPBRW3/hu+709
 fW8zm97S22uQSTV6DzS4ekxeuJsfUD+/6wv9jXDZzOZ6X3q6x6DGYyK4q2gMB6iMGGlQql8bY6T 12hl42m5/qrcv0lsAXMXts5/uhtKxYO7VuHAvpXi8F5hz0vbkpEz70VFy74+bzcrk9wuaoKl2N6 4CL7GPBINERg/3jM7WaQff7UQhg9FKAOGmMS9WOtGrKDeIlJ6ENI64DPP8DBDglIqV1auiBPuyB
 7lIzI0UKEMvH1QAl4fA2H6/B0DAsfYE+XTKbEXqPqpoJd+pj4l2cRWuYEXi/9NTx5L1oi2W8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_01,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 mlxlogscore=955 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2504250041

The controllers with rtl version larger than
RTL_REVISION_NEW_LPM (0x00002700) has bug which causes that controller
doesn't resume from L1 state. It happens if after receiving LPM packet
controller starts transitioning to L1 and in this moment the driver force
resuming by write operation to PORTSC.PLS.
It's corner case and happens when write operation to PORTSC occurs during
device delay before transitioning to L1 after transmitting ACK
time (TL1TokenRetry).

Forcing transition from L1->L0 by driver for revision larger than
RTL_REVISION_NEW_LPM is not needed, so driver can simply fix this issue
through block call of cdnsp_force_l0_go function.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD=
 Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
Changelog:
v2:
- improved patch description
- changed RTL_REVISION_NEW_LPM value

 drivers/usb/cdns3/cdnsp-gadget.c | 2 ++
 drivers/usb/cdns3/cdnsp-gadget.h | 3 +++
 drivers/usb/cdns3/cdnsp-ring.c   | 3 ++-
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gad=
get.c
index 87f310841735..e64c8f7eb0c5 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -1773,6 +1773,8 @@ static void cdnsp_get_rev_cap(struct cdnsp_device *pd=
ev)
 	reg +=3D cdnsp_find_next_ext_cap(reg, 0, RTL_REV_CAP);
 	pdev->rev_cap  =3D reg;
=20
+	pdev->rtl_revision =3D readl(&pdev->rev_cap->rtl_revision);
+
 	dev_info(pdev->dev, "Rev: %08x/%08x, eps: %08x, buff: %08x/%08x\n",
 		 readl(&pdev->rev_cap->ctrl_revision),
 		 readl(&pdev->rev_cap->rtl_revision),
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gad=
get.h
index 84887dfea763..357ddbe53917 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -1357,6 +1357,7 @@ struct cdnsp_port {
  * @rev_cap: Controller Capabilities Registers.
  * @hcs_params1: Cached register copies of read-only HCSPARAMS1
  * @hcc_params: Cached register copies of read-only HCCPARAMS1
+ * @rtl_revision: Cached controller rtl revision.
  * @setup: Temporary buffer for setup packet.
  * @ep0_preq: Internal allocated request used during enumeration.
  * @ep0_stage: ep0 stage during enumeration process.
@@ -1411,6 +1412,8 @@ struct cdnsp_device {
 	__u32 hcs_params1;
 	__u32 hcs_params3;
 	__u32 hcc_params;
+	#define RTL_REVISION_NEW_LPM 0x2700
+	__u32 rtl_revision;
 	/* Lock used in interrupt thread context. */
 	spinlock_t lock;
 	struct usb_ctrlrequest setup;
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.=
c
index 46852529499d..fd06cb85c4ea 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -308,7 +308,8 @@ static bool cdnsp_ring_ep_doorbell(struct cdnsp_device =
*pdev,
=20
 	writel(db_value, reg_addr);
=20
-	cdnsp_force_l0_go(pdev);
+	if (pdev->rtl_revision < RTL_REVISION_NEW_LPM)
+		cdnsp_force_l0_go(pdev);
=20
 	/* Doorbell was set. */
 	return true;
--=20
2.43.0


