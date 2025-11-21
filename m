Return-Path: <stable+bounces-195447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 90948C76FDF
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 03:22:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 75E014E3F2A
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 02:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089F425EFAE;
	Fri, 21 Nov 2025 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="nn7OIkCi";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="gzhyMNze";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="s08lhX/j"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-00230701.pphosted.com (mx0a-00230701.pphosted.com [148.163.156.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907684A35;
	Fri, 21 Nov 2025 02:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763691749; cv=fail; b=oGZs0sPHKsdfLTCdDlYOUfpljgyLtO6rLN6Nrm/wxEGFE/EBnZJMR/iLqB9YmGF9JC/lUIizwzVqIA811CYcIR5RM6yoWnx+3ZfzzAYY9mRFhEMhLTb90e3YmL4HYmn0gxyNOGtdsnJ/b4232+QmiA53Z7hZa6gAcMkLBBqmd3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763691749; c=relaxed/simple;
	bh=ut4ZzFO8AO0+gboLqrcjKkKV3+XrBJnqBK/aT5taAmI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sldIHBaS0Pu09dqsE1A45fK6EKttMdzpSRzAksR5STWJZ779rOQN6GCY9mVvVW7R3nEN0NCdgee96YvPU7In4u1z9WkMp+mWUusXuiIpmTBZVZ9vm+fbr+aymdwtRRUk+FSuUCUb0GGCO4Tw5cx2Zi/48y5EweprBrlJH75uHlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=nn7OIkCi; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=gzhyMNze; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=s08lhX/j reason="signature verification failed"; arc=fail smtp.client-ip=148.163.156.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0297266.ppops.net [127.0.0.1])
	by mx0a-00230701.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AKJCYQQ3963795;
	Thu, 20 Nov 2025 18:22:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=ut4ZzFO8AO0+gboLqrcjKkKV3+XrBJnqBK/aT5taAmI=; b=
	nn7OIkCiUxBYnKtPET4IbtfKCH7aA5iffBu5wPsoifezuKsv1PII2FR6Lm2LP6F8
	LnE9BwUyN0Yw6RS48dJBfd522hj9JoCzyEI1JAKwarug/3QdB+SGvdlrXtP0cLTN
	AS0lY6U9A8KyIhF1h8ZCZA5eNsUUVvtzOQsQfW2BEBknmeA9YvOJbg1V3lUzkRWH
	xJRVW+u/ZTur8sHSX601eLSo/CIlm+u1EcgH1yr+pMTQfNP7UAhTg8H2s+tti8aO
	pKkvlZpZOkXrTNT0KKYemUZEa0+mIqP8GFbt+0By0cEpQFjChHg7EUB9soCDbY70
	mW9z/+oGvR3Gq0CicfaVBw==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
	by mx0a-00230701.pphosted.com (PPS) with ESMTPS id 4aj6fc2m9y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 20 Nov 2025 18:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1763691731; bh=ut4ZzFO8AO0+gboLqrcjKkKV3+XrBJnqBK/aT5taAmI=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=gzhyMNze+Puud5QlR85gzLRDbYZR5vik1m6i5zb9mi/1Z6cj8NHM4T/K9Gu4Baw7u
	 rGZzhX7W0Zn2cm9zIe7pva8zBNoFX1n709y+2OeOyW30H3nSANcmByCZ+E5y9mX5yk
	 YimCl3Bu8anCHpvuJqfscod8W042xBLXfTn5FjWAu9+35whz9K4xeGYsX1yrxVCn9p
	 9OIt5Y1/G66i1J0CCyV/hbMbthxlmH5govD8ZQQoiluFSmC4+5BKOTdtoCrbGbaczD
	 I9BYiWDYHwzVP3OKh/1bW/00rClxDG3NFMPeTAUlW58u2keUgzVYkQXunlGGCgpCw9
	 zPjPV3rKTrGrA==
Received: from mailhost.synopsys.com (badc-mailhost1.synopsys.com [10.192.0.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 53B2440520;
	Fri, 21 Nov 2025 02:22:11 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Sectigo Public Server Authentication CA OV R36" (not verified))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 8D5E8A00CE;
	Fri, 21 Nov 2025 02:22:10 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=s08lhX/j;
	dkim-atps=neutral
Received: from CY3PR08CU001.outbound.protection.outlook.com (mail-cy3pr08cu00105.outbound.protection.outlook.com [40.93.6.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 21D2B40532;
	Fri, 21 Nov 2025 02:22:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rg6rLerB3H8+28181/sOXCRJbaFlXsctVLTjQ1NKEF2RynDx3prGnOuKweqJbQIRT8TgZJ6aYuSfZLj/qdeejjail0rqgLA37kn6UObn5qBvQ2zu7/XmFp1Jwlg107TFYqu9ym0n7DwdK7lIVIesAZZ6+f6en8IRMwfsWMOIya+ywUKfMNI7pjXkOr8fxLXpCAURq02ROB4jPIeNZ/THXI47NseiIv5WBaVmYO9J8Geh2eNApJnF/rTk7UYMqYHbGjPCANYro1WJ+KpdzX35lUd5alqwVweTcfC6duN8BP0wADVKeVYFsqmp3GEPvzarSJ/ewZCXVhFR0HTLYNUUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ut4ZzFO8AO0+gboLqrcjKkKV3+XrBJnqBK/aT5taAmI=;
 b=pvO9T9ehqfjqTD6DD43lckgHnEN23XG/A2EoJg9WrdVNPK+mU25EhWkmTZzGjbGPRFweWPfvW3flS2hiVkQoEtEcUVm1j7ubmvEk/5r6N0M0d24Mf4cu/0LPfnX5yR9PScYclqavWohalx5MWiy0ceAXzNioWJXTAZqZOTJcRMHRWWJIspP7DwPheteT3pVRF6+EJmddxNtf6if9mP7nOgVjeMmejPVnsmX++5agvYuHqAW7ncnD30K22cCkUBuK6S+Rz/AHsmqrn2oifcmJAKB0dYvAAAfkJzCkSVMqJgUx9EyIxQysMVLbl1Su4wDrCC2QB1sr/14SVmBU6hNH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ut4ZzFO8AO0+gboLqrcjKkKV3+XrBJnqBK/aT5taAmI=;
 b=s08lhX/jeRXIyvOZ9H77rJ5HYDofYZeHeN9wZGiDW+B8KWeyUFGkQL29rVt/NqE5GMgbH3L9TfeqtvYzUq8lKb4SN8tNBW852ZDAADPG3Er4SMSEI3fXhIvz3ChlgFItq8S4cDjESk777t2C+4Uz0Zklhfy27N9vBp9v1hYpWoo=
Received: from DS7PR12MB5984.namprd12.prod.outlook.com (2603:10b6:8:7f::18) by
 CH3PR12MB7548.namprd12.prod.outlook.com (2603:10b6:610:144::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 02:22:02 +0000
Received: from DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb]) by DS7PR12MB5984.namprd12.prod.outlook.com
 ([fe80::e2e0:bc6d:711f:eeb%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 02:22:02 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Alan Stern <stern@rowland.harvard.edu>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Selvarasu Ganesan <selvarasu.g@samsung.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jh0801.jung@samsung.com" <jh0801.jung@samsung.com>,
        "dh10.jung@samsung.com" <dh10.jung@samsung.com>,
        "naushad@samsung.com" <naushad@samsung.com>,
        "akash.m5@samsung.com" <akash.m5@samsung.com>,
        "h10.kim@samsung.com" <h10.kim@samsung.com>,
        "eomji.oh@samsung.com" <eomji.oh@samsung.com>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "thiagu.r@samsung.com" <thiagu.r@samsung.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Topic: [PATCH v2] usb: dwc3: gadget: Prevent EPs resource conflict
 during StartTransfer
Thread-Index:
 AQHcV9toCE6cPYUMd0yodGWwqzwGUbT3tFIAgAAhQQCAAWgNAIAAJ0QAgAFwPYCAABgXAIABfkgA
Date: Fri, 21 Nov 2025 02:22:02 +0000
Message-ID: <20251121022156.vbnheb6r2ytov7bt@synopsys.com>
References:
 <CGME20251117160057epcas5p324eddf1866146216495186a50bcd3c01@epcas5p3.samsung.com>
 <20251117155920.643-1-selvarasu.g@samsung.com>
 <20251118022116.spdwqjdc7fyls2ht@synopsys.com>
 <f4d27a4c-df75-42b8-9a1c-3fe2a14666ed@rowland.harvard.edu>
 <20251119014858.5phpkofkveb2q2at@synopsys.com>
 <d53a1765-f316-46ff-974e-f42b22b31b25@rowland.harvard.edu>
 <20251120020729.k6etudqwotodnnwp@synopsys.com>
 <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
In-Reply-To: <2b944e45-c39a-4c34-b159-ba91dd627fe4@rowland.harvard.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5984:EE_|CH3PR12MB7548:EE_
x-ms-office365-filtering-correlation-id: e1abde82-0f93-497f-002f-08de28a4c1f8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?U2ZmdkYzQW82S2REQ0lqcmwraEhTQXM1SU5rblNXcTIyVHVBODliYnRtTlZZ?=
 =?utf-8?B?eUtoM0l4K3Z6c2YyTW1EamtyMU92dEh6MlJjaWxWeHo3M2N4NVdrRVlMdVlM?=
 =?utf-8?B?NXo2b0ZZY0JNNWxiVGs5eUxraXAyYlcxR01JQWtURnlDa1B1UmdhTU01V1d3?=
 =?utf-8?B?V1NIckZ4OGpJU05SK1dQeWIvS1FsK2s1alZNTENMdWtJNXkvMVUwSWx1dE9i?=
 =?utf-8?B?T0kra2hmcVlsWkxBbjgxcDF0N0dlaThBcnhwc2l5WUtLNkhKTTgxckZReWNt?=
 =?utf-8?B?SXB4azhDRTk5V3hpbGc0ZExJN0lMUi9WV2xTRFlhRDNQZHNueTVNclJhZ096?=
 =?utf-8?B?aU8xcm41cmFpcDBqVG9pblQwMytHV05GYnRHZkVBWnV2MkRRU1J0QVRzaWJR?=
 =?utf-8?B?SVYvRXM5VmhHODFVUUpoUlNLMmRkYXBPbmpxdHRpcDhyckU2U3QwQy9NeVVa?=
 =?utf-8?B?RDQ1Y0JNS00yclorOUdEOUd5TWdqTXZrVmZmeDZreHdndDJWYWlwMk51S3Bm?=
 =?utf-8?B?TEF3L3MyWXhZb3k1MDgwejE0b1JNRXY5aHJoOGtsNmY0Y0ZVWmNTeXdHNnFa?=
 =?utf-8?B?cXpMeWswZlBHS2x5UDRCbk1aL0pwWnlrQ1N0RTVkSFhEekFJeXk0ampKL3Yr?=
 =?utf-8?B?aU41dU5iQUY3bjF5T3ZDdC93OHVoTnF5aWMxVzNUNFRuZjlNRGVJbTZBUHE4?=
 =?utf-8?B?ak9IcUswdEFYZWlhMjFZVG00RWhHNG43UGlxYnNVVDZTeFhQNzNOMm5GNmM3?=
 =?utf-8?B?N2Znci8zS2hZdjNvUGIzeWJ6T2d0NFhYTzhtZ29RNHUrL0lQOUxCbWZhMThK?=
 =?utf-8?B?b0QzRzRERHlqeDNhaGk2VDBvTmxuMXgxcmdVY3NPMUhrSUNZSFRteUE1V3VM?=
 =?utf-8?B?Q20va1RpNkgwTnlCRnRTSEhUTkMxcjNKcTk3bXM1SmVCS2hlbzdWZm5Fc2pt?=
 =?utf-8?B?QmZsZHlhNUY5aUM5amZGL1diVEVWZnBlK29ndWMzS3hVM2pvNEpwaytKcGs2?=
 =?utf-8?B?VUNWSm41a3JVZ1lwc3F3YjJCcUo3SUlNSk1CbTA4b1VEVkF2ZjNoOEJISkVZ?=
 =?utf-8?B?LzFqUmRzajkwM05uWDdMWFBaSjd2aUUrYk9NUCt0a2dBRzFteFBUUENNU3A0?=
 =?utf-8?B?dzU2dGlXTUxnVFdxS0pRM1ZWNlNKSUFvem9IT2RuTGNQbHdENmdsbnRjS1Jq?=
 =?utf-8?B?d2tpY3I0ZkZ6S3ZIckdqdWNCdEk0NXV4bjBVS3FPOXhncmt3eTUrdlloZmFG?=
 =?utf-8?B?cTNwcnJGTWtSWFJONDBNZmovdEtSOGNvcXB2N2djaVVqSmIxUnpEbkg1YTMz?=
 =?utf-8?B?YWpWbzNidk1wVGdjekRXc0Npdk44QWNXU3loeXVVRzNuYkpnL2hHSEVIbnJr?=
 =?utf-8?B?L2NDbXJsK2s3cjBzcExoaXZKdElUU2dQWWFRT0Y5M2NLWWRXRTlFaTkwWnFZ?=
 =?utf-8?B?MDFSK0Jxd1NINUZic1kybHovMEdzc2t2emdkNUs1YzB6bGVBR2JOdU5mS0R2?=
 =?utf-8?B?R0ovMWpPR0N0alduUUdaRGN4VFd5L2VUV1V4Qy9aQWF3WTA0MnhrQVZIOGty?=
 =?utf-8?B?WU02NFBaSWcxRTEyT0FycDNXSC9OU1NFME9ORlVRZUEvM3NETHR0a3RoY3or?=
 =?utf-8?B?WXlSYzQ1Y2pMT2VaalA1TThHSDZhR0Y5UHdoT1RvSExUYk1tc2NrWEU0RTln?=
 =?utf-8?B?QlI5QmlVQ1VnVVk2VlZXOVRqWWNkNUtSQ3RacU9NcTEvV1MyeUplbnVoK0R5?=
 =?utf-8?B?N2k3ZDR2Wm1CZHVCN1BsSlMxZENVdU1WQVdmUE4wektSNUVJUmhGR0I5bmo0?=
 =?utf-8?B?SitydndlWldyS2VENnJKV2s2MVRjUGxvbzkya0lkRXNOY2t1ZnJNakpWYjIv?=
 =?utf-8?B?UHJlUEJ1OTJNOGFvUkxvYitDbFNUTk5sb01XZ2hMcXFLdDFLaUluMkZ6SVlZ?=
 =?utf-8?B?MGdlOU1HeDdZM29CUHBCZ0JjYjBmZC94KzlrV1o5MTQ0M0VCTEFzaGY1bWJj?=
 =?utf-8?B?ZUIxcFdNc0ZMemk2K0NSdlo4Uk1ydlRGLzZLTjJtRjJPOTRZUlRDU09oaGpH?=
 =?utf-8?Q?rG4OX/?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5984.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eE1nT2hXb3hKZ2w5QzRXeEtBVTlXdjl1a09KTS8zVStRSThMelBkbUM2NGpa?=
 =?utf-8?B?RTdvSlBaNlk3YW5EQTRjSWpMeUJONkVKaUhpZ29LOXc1U0FOTnNoZGNGT1Jy?=
 =?utf-8?B?UnJHNFlwOHF2QnpQNGhtYlU0VlltVXNGNU9hbmNmcHViVVRONFEvcWdURGNH?=
 =?utf-8?B?SVZPdUwvdUFndmhvL1FCeDdrWjhvcmloNFV4VFVwVjhyN0xCa0tGU2d3OWlu?=
 =?utf-8?B?SkFlYXRkNDViSm9mUVFWcWRSVXZUdWhLMytSamJUaWJNOUZGNUNsL3RVT0Iy?=
 =?utf-8?B?TzR1OTRKYWhCRTBhY3F0dWwrMEU0cmpYTWUwVHR0RzRuZHJSV2hhY0grZE5B?=
 =?utf-8?B?N0RMSGErNThJdU9udUxGWWxBWkgzejU1S2RyOFRyMFRla0FvOEFrekVZRDBH?=
 =?utf-8?B?eDdUeThlaURyUWwrWUswbTlyMlBjRytMT0VDd3hKeGlaaHpxZ1RCMDI4VktO?=
 =?utf-8?B?cnRValdPQ2pUTHpTQWFMVlhwMXd0bUZMWjJxUEZkcUdrcitVYi9hbjFhVHgr?=
 =?utf-8?B?ZFFoTlROWGZYMFJCcDNtcm8xSDlPUDk4WmdsemEvK2tPZkxsbGFCU09GazFq?=
 =?utf-8?B?T0sxU2dtOFBOVDlseXpRTm5RdC9Vd0hUdk1RbGdtazNOZTRWWjJMdGVCaXNE?=
 =?utf-8?B?MWI4a1lrRStLTnNIakVPQTVPNHF2Nlc2NFI1eHBUS2ZxakhPcGN4bWhFQTFT?=
 =?utf-8?B?S244ODhWNk5SRWRkZ0VHdUswSDlGMFFYMWVESW1pT0I2VllUeVcySUJaZk84?=
 =?utf-8?B?UU5YUkJGUHI3cVRGRjdpWnBnSmVvUWY0VnQ5NFllRnVBYWV1SXkzeElkR3ky?=
 =?utf-8?B?L29nTUFDVDN6UmNEWUtHakpmblROa0JvL0ZleEZzTlNYcjM3TDN3NjlWVU16?=
 =?utf-8?B?UmtFdEVzRDBnK1RJdTBnZ0dZNEo3QjlpSU80R25GdmZuQUJ6am4vRUJjcFVP?=
 =?utf-8?B?Qld4VGNpN1V5WklLMjNZc0ZMRlRtSGVvanU0VHFNaGtTZVE0YWljSEpNc1Bt?=
 =?utf-8?B?VXhNWmY2OVJXVXJSWm83NW5UVStzQ2FFYm9tMXNMMC8vK1J2U0g4bXI4b0hM?=
 =?utf-8?B?ck83N3FkWWFMV29sTi9CREVvdWFpdG9TVFlnUE1XZUtRN1VjR1BQU0E1ZjZU?=
 =?utf-8?B?OGJmRm4vazVqL3lPa1BOYlpJbHg1QWxEUzBaMVk5bGlkUWtjTzZ6WHhYZWFq?=
 =?utf-8?B?dDF0MW5EMGk2bzVzbnIzQTlyQmpTclR1MVhNZ1E5WmhIRTkyVktyZ0UxY0tY?=
 =?utf-8?B?K2Z1MVgzby9FVXNWaEQwSFA2c2ZzcVQ4NlJDMEszb1poSE9LRUU1bTNVWnhB?=
 =?utf-8?B?cHh0V2N3a2d1cDJrVGlwenlHS29vTUQ4Y3NDbXZTcSsxOU4wRnQxWDlqWEl4?=
 =?utf-8?B?bTZKRzVrdmdCdGNIWFJNMENXUFZhQVRmOVJPYUo4akcwUERvZHZRSTJrZXJH?=
 =?utf-8?B?RUZLam5YZGwxYVFWV2JsckVsZEYxbm9TTitNR0I3VFhUbjNrTUJtbnBzbHNI?=
 =?utf-8?B?TFJveXQvaHdmRTgvN3F1aDI5MGJrcXBGRDNQdHdvUkRJWFZHTzMzcUVzR3g5?=
 =?utf-8?B?eXF3dWN4eTA0a3BuNGtFVXE4dDN1QW9vbTBEeXNCNnNKaXJoa1AxTEpyN1pa?=
 =?utf-8?B?RmExV1BrQU8vWk9SZG5oeEdSMEtiRlBBandjbkVEakxZRk9xUHhLSGhRb1No?=
 =?utf-8?B?R0dKSHJqVCtCYVZwaFd0TmtVN3N5VEpxemFiQWNNek5iN0Nwc29BOWYyRy9Z?=
 =?utf-8?B?akdWdHhxMm9aUzN4UkZYUlJhTmU1NjY3b0t0K0N6a2QrN1Bid1NaSXpsUkRa?=
 =?utf-8?B?Q095TXRyRmR6WG9DWTUxcXNPWVZ1aGZGbHhSRkxhN0JTN1FTendXbGZFQ090?=
 =?utf-8?B?blVab0NTdndYVGtiWGQ0RWYvVHVUQWpDNjBhQUN6cktxTlZ6ZytyWkZNVlZR?=
 =?utf-8?B?ZE5sT3V4Qjd4SUhGK2FDRmNHWTl6dFhWVTdYeHIycEFDVE1WbThVVXY0ZWpy?=
 =?utf-8?B?cDNTMnQ3MHRJSkZNaDk4cDFkSFh4eDJOWDJLU2tDWGUyUHJLVVJLc1JhNGF0?=
 =?utf-8?B?dHFSdzI3K05RZHIraUJqa2VXa2wvMzU0ZmM4TnhaTXZDT0Q1ZzlFTmN0eXFQ?=
 =?utf-8?Q?8f8lQT3OmAwbCwVvblEdhTuVH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4D4349EDF05D441BB51D9EAE7764BB1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/es3VrtvaqvncbddXrJGwFg0JsBY3mK8yH+luJx91sDSFMHL9S8QfbV7JvsHrOu7AZfx2s1WbHSk2qHc3/XUkqnvT6pTroxaAxM4bHlYE3xsFsAnJS+YL2stijq5IZ7R4sg0zFozGumu1iWrY1my5BRAf+3J5Tze+GK3wDaoe0YZeYk4MkZERzoYGjNEt4Wos6Ds5k04hZ/f1G9ugPTZizIfRmfpnVekASQ0VhCQeri2jPRFQ69J8sKqUHwoVmcxU/a563xIIrBO5Im16HJP5fGM6Kcz5x/esLA8qKV0ebvCUa5ZEwhGaAjZ/DGb0Znaru2OXUdR9TkLrrg+OsLf7ovNx+kOKzUHv0XPRK0g1JEv3i0BjzQJJQr6isMdMFOZqjl0on+XyLpANWRUbIwu0NLEDG/rRY54fpsxFDyYjtev2CyeFmfoJdOt3Mdl+E2q+ekf0z/1Rkw3RiA/n1+2WsSNkEAmXbAtRzwS8dPjiWHiNYtJavNZposJHpbTOVOsjlU8/d92qjA2HqdpudyiDpny8QfNYNIboqFdrtFwpkEOLs1dkMRzetixLiJGnplAZeA9Dcp8krVz3ojhmWUrcx1UJmj1v7eXW2Ty/6atDGUjTKRkTDp1zBFBgC7kCLAq40T+t/9atPCyNtkA2cqVdQ==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5984.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1abde82-0f93-497f-002f-08de28a4c1f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 02:22:02.7128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zbrU3TL/zSew4ZpdEC9wEgQIxzrHmxjGhprT40fcZqz+KVTxkX7u2ul8PAt+HDDIibsbMpQgCrb66+xd0rHFnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7548
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIxMDAxNyBTYWx0ZWRfX4XHba5NUWYd6
 OOKMixth6JbZShSf9is5GL2ggnidfMPUw9ghYW2QGIiiazmw8J9fDBpCbuQpXqEOu1xoDXI3jKz
 5Mrgkm88UeVlUmnW9ZFr4HQ8PTb60O1rTHeEc66G1AvLGv0jqfCfHbzJz3sh7aJMUrIII9vN2YC
 EOlvAfzz5GTAqG3j9sTdblPKjj/cTO3OGJNE2tM9bj1Lx68yOD8uJPh939LmOIEDWWnQ/VmQtRd
 NhwLdTQt7/wGVthGu2540W5uU0CXf7J1d4aZ6VL3iHfK/hUVflc9usrO7PB88jBSgToOXlTeRl7
 vDm8fMj7Fg0OVYQ8BtGUbTJWk0s8nOHiC5Z6V3IpnrMku4EL0TGNzgvA4zZTrTSvXDPAcmHF6K9
 NFq53Gh8rCp5smRwbhTHowNrA/iStg==
X-Proofpoint-GUID: gnsSKsykTalsKg1EOzVK0D2GswxAzRmx
X-Proofpoint-ORIG-GUID: gnsSKsykTalsKg1EOzVK0D2GswxAzRmx
X-Authority-Analysis: v=2.4 cv=GpJPO01C c=1 sm=1 tr=0 ts=691fccd4 cx=c_pps
 a=t4gDRyhI9k+KZ5gXRQysFQ==:117 a=t4gDRyhI9k+KZ5gXRQysFQ==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=qPHU084jO2kA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=-yyDTxWLEx4hjuPUsOkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_01,2025-11-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam
 policy=outbound_active_cloned score=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2510240001 definitions=main-2511210017

T24gV2VkLCBOb3YgMTksIDIwMjUsIEFsYW4gU3Rlcm4gd3JvdGU6DQo+IE9uIFRodSwgTm92IDIw
LCAyMDI1IGF0IDAyOjA3OjMzQU0gKzAwMDAsIFRoaW5oIE5ndXllbiB3cm90ZToNCj4gPiA+IEZ1
bmN0aW9uIGRyaXZlcnMgd291bGQgaGF2ZSB0byBnbyB0byBncmVhdCBsZW5ndGhzIHRvIGd1YXJh
bnRlZSB0aGF0IA0KPiA+ID4gcmVxdWVzdHMgaGFkIGNvbXBsZXRlZCBiZWZvcmUgdGhlIGVuZHBv
aW50IGlzIHJlLWVuYWJsZWQuICBSaWdodCBub3cgDQo+ID4gPiB0aGVpciAtPnNldF9hbHQoKSBj
YWxsYmFjayByb3V0aW5lcyBhcmUgZGVzaWduZWQgdG8gcnVuIGluIGludGVycnVwdCANCj4gPiA+
IGNvbnRleHQ7IHRoZXkgY2FuJ3QgYWZmb3JkIHRvIHdhaXQgZm9yIHJlcXVlc3RzIHRvIGNvbXBs
ZXRlLg0KPiA+IA0KPiA+IFdoeSBpcyAtPnNldF9hbHQoKSBkZXNpZ25lZCBmb3IgaW50ZXJydXB0
IGNvbnRleHQ/IFdlIGNhbid0IGV4cGVjdA0KPiA+IHJlcXVlc3RzIHRvIGJlIGNvbXBsZXRlZCBi
ZWZvcmUgdXNiX2VwX2Rpc2FibGUoKSBjb21wbGV0ZXMgX2FuZF8gYWxzbw0KPiA+IGV4cGVjdCB1
c2JfZXBfZGlzYWJsZSgpIGJlIGFibGUgdG8gYmUgY2FsbGVkIGluIGludGVycnVwdCBjb250ZXh0
Lg0KPiANCj4gLT5zZXRfYWx0KCkgaXMgY2FsbGVkIGJ5IHRoZSBjb21wb3NpdGUgY29yZSB3aGVu
IGEgU2V0LUludGVyZmFjZSBvciANCj4gU2V0LUNvbmZpZyBjb250cm9sIHJlcXVlc3QgYXJyaXZl
cyBmcm9tIHRoZSBob3N0LiAgSXQgaGFwcGVucyB3aXRoaW4gdGhlIA0KPiBjb21wb3NpdGVfc2V0
dXAoKSBoYW5kbGVyLCB3aGljaCBpcyBjYWxsZWQgYnkgdGhlIFVEQyBkcml2ZXIgd2hlbiBhIA0K
PiBjb250cm9sIHJlcXVlc3QgYXJyaXZlcywgd2hpY2ggbWVhbnMgaXQgaGFwcGVucyBpbiB0aGUg
Y29udGV4dCBvZiB0aGUgDQo+IFVEQyBkcml2ZXIncyBpbnRlcnJ1cHQgaGFuZGxlci4gIFRoZXJl
Zm9yZSAtPnNldF9hbHQoKSBjYWxsYmFja3MgbXVzdCANCj4gbm90IHNsZWVwLg0KDQpUaGlzIHNo
b3VsZCBiZSBjaGFuZ2VkLiBJIGRvbid0IHRoaW5rIHdlIGNhbiBleHBlY3Qgc2V0X2FsdCgpIHRv
DQpiZSBpbiBpbnRlcnJ1cHQgY29udGV4dCBvbmx5Lg0KDQo+IA0KPiA+ID4gVGhlIGVhc2llc3Qg
d2F5IG91dCBpcyBmb3IgdXNiX2VwX2Rpc2FibGUoKSB0byBkbyB3aGF0IHRoZSBrZXJuZWxkb2Mg
DQo+ID4gPiBzYXlzOiBlbnN1cmUgdGhhdCBwZW5kaW5nIHJlcXVlc3RzIGRvIGNvbXBsZXRlIGJl
Zm9yZSBpdCByZXR1cm5zLiAgQ2FuIA0KPiA+ID4gZHdjMyBkbyB0aGlzPyAgKEFuZCB3aGF0IGlm
IGF0IHNvbWUgdGltZSBpbiB0aGUgZnV0dXJlIHdlIHdhbnQgdG8gc3RhcnQgDQo+ID4gDQo+ID4g
VGhlIGR3YzMgY2FuIGRvIHRoYXQsIGJ1dCB3ZSBuZWVkIHRvIG5vdGUgdGhhdCB1c2JfZXBfZGlz
YWJsZSgpIG11c3QgYmUNCj4gPiBleGVjdXRlZCBpbiBwcm9jZXNzIGNvbnRleHQgYW5kIG1pZ2h0
IHNsZWVwLiBJIHN1c3BlY3Qgd2UgbWF5IHJ1biBpbnRvDQo+ID4gc29tZSBpc3N1ZXMgZnJvbSBz
b21lIGZ1bmN0aW9uIGRyaXZlcnMgdGhhdCBleHBlY3RlZCB1c2JfZXBfZGlzYWJsZSgpIHRvDQo+
ID4gYmUgZXhlY3V0YWJsZSBpbiBpbnRlcnJ1cHQgY29udGV4dC4NCj4gDQo+IFdlbGwsIHRoYXQn
cyBwYXJ0IG9mIHdoYXQgSSBtZWFudCB0byBhc2suICBJcyBpdCBwb3NzaWJsZSB0byB3YWl0IGZv
ciANCj4gYWxsIHBlbmRpbmcgcmVxdWVzdHMgdG8gYmUgZ2l2ZW4gYmFjayB3aGlsZSBpbiBpbnRl
cnJ1cHQgY29udGV4dD8NCg0KVGhlIGR3YzMgY29udHJvbGxlciB3aWxsIG5lZWQgc29tZSB0aW1l
ICh1c3VhbGx5IGxlc3MgdGhhbiAybXMpIHRvIGZsdXNoDQp0aGUgZW5kcG9pbnRzIGFuZCBnaXZl
IGJhY2sgcmVxdWVzdHMuIEl0J3MgcHJvYmFibHkgdG9vIGxvbmcgdG8gaGF2ZQ0KYnVzeSBwb2xs
IGluIGludGVycnVwdCBjb250ZXh0Lg0KDQo+IA0KPiA+ID4gdXNpbmcgYW4gYXN5bmNocm9ub3Vz
IGJvdHRvbSBoYWxmIGZvciByZXF1ZXN0IGNvbXBsZXRpb25zLCBsaWtlIHVzYmNvcmUgDQo+ID4g
PiBkb2VzIGZvciBVUkJzPykNCj4gPiANCj4gPiBXaGljaCBvbmUgYXJlIHlvdSByZWZlcnJpbmcg
dG8/IEZyb20gd2hhdCBJIHNlZSwgZXZlbiB0aGUgaG9zdCBzaWRlDQo+ID4gZXhwZWN0ZWQgLT5l
bmRwb2ludF9kaXNhYmxlIHRvIGJlIGV4ZWN1dGVkIGluIHByb2Nlc3MgY29udGV4dC4NCj4gDQo+
IEkgd2FzIHJlZmVycmluZyB0byB0aGUgd2F5IHVzYl9oY2RfZ2l2ZWJhY2tfdXJiKCkgdXNlcyBz
eXN0ZW1fYmhfd3Egb3IgDQo+IHN5c3RlbV9iaF9oaWdocHJpX3dxIHRvIGRvIGl0cyB3b3JrLiAg
VGhpcyBtYWtlcyBpdCBpbXBvc3NpYmxlIGZvciBhbiANCj4gaW50ZXJydXB0IGhhbmRsZXIgdG8g
d2FpdCBmb3IgYSBnaXZlYmFjayB0byBjb21wbGV0ZS4NCj4gDQo+IElmIHRoZSBnYWRnZXQgY29y
ZSBhbHNvIHN3aXRjaGVzIG92ZXIgdG8gdXNpbmcgYSB3b3JrIHF1ZXVlIGZvciByZXF1ZXN0IA0K
PiBjb21wbGV0aW9ucywgaXQgd2lsbCB0aGVuIGxpa2V3aXNlIGJlY29tZSBpbXBvc3NpYmxlIGZv
ciBhbiBpbnRlcnJ1cHQgDQo+IGhhbmRsZXIgdG8gd2FpdCBmb3IgYSByZXF1ZXN0IHRvIGNvbXBs
ZXRlLg0KPiANCj4gPiBQZXJoYXBzIHdlIGNhbiBpbnRyb2R1Y2UgZW5kcG9pbnRfZmx1c2goKSBv
biBnYWRnZXQgc2lkZSBmb3INCj4gPiBzeW5jaHJvbml6YXRpb24gaWYgd2Ugd2FudCB0byBrZWVw
IHVzYl9lcF9kaXNhYmxlKCkgdG8gYmUgYXN5bmNocm9ub3VzPw0KPiA+IA0KPiA+ID4gDQo+ID4g
PiBMZXQncyBmYWNlIGl0OyB0aGUgc2l0dWF0aW9uIGlzIGEgbWVzcy4NCj4gPiA+IA0KPiA+IA0K
PiA+IEdsYWQgeW91J3JlIGhlcmUgdG8gaGVscCB3aXRoIHRoZSBtZXNzIDopDQo+IA0KPiBUbyBk
byB0aGlzIHJpZ2h0LCBJIGNhbid0IHRoaW5rIG9mIGFueSBhcHByb2FjaCBvdGhlciB0aGFuIHRv
IG1ha2UgdGhlIA0KPiBjb21wb3NpdGUgY29yZSB1c2UgYSB3b3JrIHF1ZXVlIG9yIG90aGVyIGtl
cm5lbCB0aHJlYWQgZm9yIGhhbmRsaW5nIA0KPiBTZXQtSW50ZXJmYWNlIGFuZCBTZXQtQ29uZmln
IGNhbGxzLiAgDQoNClNvdW5kcyBsaWtlIGl0IHNob3VsZCd2ZSBiZWVuIGxpa2UgdGhpcyBpbml0
aWFsbHkuDQoNCj4gDQo+IEl0IHdvdWxkIGJlIG5pY2UgaWYgdGhlcmUgd2FzIGEgd2F5IHRvIGlu
dm9rZSB0aGUgLT5zZXRfYWx0KCkgY2FsbGJhY2sgDQo+IHRoYXQgd291bGQganVzdCBkaXNhYmxl
IHRoZSBpbnRlcmZhY2UncyBlbmRwb2ludHMgd2l0aG91dCByZS1lbmFibGluZyANCj4gYW55dGhp
bmcuICBUaGVuIHRoZSBjb21wb3NpdGUgY29yZSBjb3VsZCBkaXNhYmxlIHRoZSBleGlzdGluZyAN
Cj4gYWx0c2V0dGluZywgZmx1c2ggdGhlIG9sZCBlbmRwb2ludHMsIGFuZCBjYWxsIC0+c2V0X2Fs
dCgpIGEgc2Vjb25kIHRpbWUgDQo+IHRvIGluc3RhbGwgdGhlIG5ldyBhbHRzZXR0aW5nIGFuZCBl
bmFibGUgdGhlIG5ldyBlbmRwb2ludHMuICBCdXQgDQo+IGltcGxlbWVudGluZyB0aGlzIHdvdWxk
IHJlcXVpcmUgdXMgdG8gdXBkYXRlIGV2ZXJ5IGZ1bmN0aW9uIGRyaXZlcidzIA0KPiAtPnNldF9h
bHQoKSBjYWxsYmFjayByb3V0aW5lLg0KDQpZZWFoLi4NCg0KPiANCj4gV2l0aG91dCB0aGF0IGFi
aWxpdHksIHdlIHdpbGwgaGF2ZSB0byBhdWRpdCBldmVyeSBmdW5jdGlvbiBkcml2ZXIgdG8gDQo+
IG1ha2Ugc3VyZSB0aGUgLT5zZXRfYWx0KCkgY2FsbGJhY2tzIGRvIGVuc3VyZSB0aGF0IGVuZHBv
aW50cyBhcmUgZmx1c2hlZCANCj4gYmVmb3JlIHRoZXkgYXJlIHJlLWVuYWJsZWQuDQo+IA0KPiBU
aGVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGFueSB3YXkgdG8gZml4IHRoZSBwcm9ibGVtIGp1c3Qg
YnkgY2hhbmdpbmcgDQo+IHRoZSBnYWRnZXQgY29yZS4NCj4gDQoNCldlIGNhbiBoYXZlIGEgd29y
a2Fyb3VuZCBpbiBkd2MzIHRoYXQgY2FuIHRlbXBvcmFyaWx5ICJ3b3JrIiB3aXRoIHdoYXQNCndl
IGhhdmUuIEhvd2V2ZXIsIGV2ZW50dWFsbHksIHdlIHdpbGwgbmVlZCB0byBwcm9wZXJseSByZXdv
cmsgdGhpcyBhbmQNCmF1ZGl0IHRoZSBnYWRnZXQgZHJpdmVycy4NCg0KVGhhbmtzLA0KVGhpbmg=

