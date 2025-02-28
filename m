Return-Path: <stable+bounces-119901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4288A49274
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 08:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1AA716F231
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41D31C5F35;
	Fri, 28 Feb 2025 07:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="eM8rylyL";
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="EUwH3kU0"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C4276D12;
	Fri, 28 Feb 2025 07:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740729052; cv=fail; b=YH2ejWsgwibU5BEfGoXl9oiUrR0OXaRqNTHRmOJg826Bqcg7W8TPKzCz2gBxY93WTeiRr7yXih/D5+q6qsX43wFrQvNZDjiXaFkEiBHscz+UwB1WzBvsrGbNkkjtOsrhsFmjeHrBnsoSd5PfxdeaU2D+K9sFVmRQDLG2UTR+izk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740729052; c=relaxed/simple;
	bh=Tr7QBXNzEy42FaQ+jaVY1GsgppPB/xa8A2GTbkHKjUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hbciTihTrqLCH9EN6+9x3WhS0I3RMX+jpkM5JqJqwXoiCpEtg67mJKPkfk9oML6KjRfM6ikvDb5U3TfEVx0KVxEQEzJDozBkHPlj2C+sqgG7fe+y1TKeDyYLiXGrVYX12gemFLJGtlNdkfXVxxwGHPMFlin29aG375kYTgjWsZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=eM8rylyL; dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b=EUwH3kU0; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51S71EQr007094;
	Thu, 27 Feb 2025 23:50:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=Tr7QBXNzEy42FaQ+jaVY1GsgppPB/xa8A2GTbkHKjUo=; b=eM8rylyL8uIh
	CC1khwXjkIPK/OULhowGGeWffVqZbe0vgvUuqEUJLdyYhJ6bjtXq1rvBQLUZbICJ
	Q3FG8/D6s4CpCIwGT5UbEYyn5yFDeIwBMazsAGIv/KsSorBkbRF/Zo/3Ar/ocjLJ
	QSz6wbQ1jzvds+1LyZ0aSPavEk3jJw5B8BatOK2TLDqJoN0vEAtJHcFP9Qa29B//
	pWWghDbvSHuSIfif7Qb2oOSH/KMgQY5TYjd54CjPEg+u0xeihNngisZM4TJCHtAz
	BKq5anHpadDmTlASy8lCKUjolNnJWl/jK8sbXpLu8vyLOE/nFcJ8UEgKO6OXPhA5
	NJOxum7EJg==
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2047.outbound.protection.outlook.com [104.47.55.47])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 451pt7v1bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 23:50:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RD/AO2C7aSbFI5nl0V24ZqwXFJZJzpJQhpz43GCcrE2VMCeKYpqaNIaS+jaXdD72KTvlf0QdtAqt+PTVCKhp5wBajN7+z6Ioy9660Z/20xyztLTsWSxfEmotzbgTAwG7Tfdx5BPvUTFh8QiZcaX0KUZLQvfxg+nj2afMLJmVph64+vCLSxpVncGTamBCXQXatGYhRvV5RBwZpWWqbRSR0qAcxG6NOP6rvepY0e2gdOcr19A782XfGe4FZgyB5xoeFuGtbWcKY65KzLakHxakHZd07E3vF8nD0vi7taQqljL0xAZU+9d2xxxq/9cG1LI3/Iqk8f9xT9Xy1/wC8Q4Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tr7QBXNzEy42FaQ+jaVY1GsgppPB/xa8A2GTbkHKjUo=;
 b=XDpfPMci3dspYAFUmWcSH6LxH3TynsXeZJqGvyhn4p2mWTNAV87OsujJTp7+1qdwS+w1LZzIEHx5Rx9YXgpdoXnoPp6nlDkDLwlWeNH/BxxMMP0uFfx6JQ86BLOvPHc6KtqAva8FO7/dVZqj2iUFhCygg7+46Ch8envJ9BcioysoGA+L6ql4yqCXmZ8sq8aXK76OjT90Fcke/CMcXJY0U2wTFN0+HZhuda0Z8jLO5EIWkq66SpqvUgBNkyez3CgvUErUWoyCr8Aaeun/TnKRFK7xBXJfjAuLlSq4lFtXSTFsavOyJVwvDcaxxq/GmttUhkvXau+iYBSQdj73hdQKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tr7QBXNzEy42FaQ+jaVY1GsgppPB/xa8A2GTbkHKjUo=;
 b=EUwH3kU0v9gaXLHGZ/lE9zZDz2k5aIykm0vMPn5e9JyvkNhLKf0PEwQSl/Jwe+rTRWTG81daxYdH+ZehUmxGcflJBFNwZ0k887Tijr8AfrrBra1adx9F5c/6LlUaEn30FqwPrz2BhDfx4TxNg+zxgRHQ/oiym6f41Imi25x93rI=
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by BY1PR07MB10842.namprd07.prod.outlook.com (2603:10b6:a03:5bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 07:50:26 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::5dbd:49e3:4dc:ccc7%7]) with mapi id 15.20.8466.020; Fri, 28 Feb 2025
 07:50:26 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "javier.carrasco@wolfvision.net" <javier.carrasco@wolfvision.net>,
        "make_ruc2021@163.com" <make_ruc2021@163.com>,
        "peter.chen@nxp.com"
	<peter.chen@nxp.com>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Pawel Eichler <peichler@cadence.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH v3] usb: hub: lack of clearing xHC resources
Thread-Topic: [PATCH v3] usb: hub: lack of clearing xHC resources
Thread-Index: AQHbibVtMdBQbgcSHUi7NaX2HmZ3QA==
Date: Fri, 28 Feb 2025 07:50:25 +0000
Message-ID:
 <PH7PR07MB953841E38C088678ACDCF6EEDDCC2@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20250228074307.728010-1-pawell@cadence.com>
In-Reply-To: <20250228074307.728010-1-pawell@cadence.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-ref:
 =?utf-8?B?UEcxbGRHRStQR0YwSUdGcFBTSXdJaUJ1YlQwaVltOWtlUzUwZUhRaUlIQTlJ?=
 =?utf-8?B?bU02WEhWelpYSnpYSEJoZDJWc2JGeGhjSEJrWVhSaFhISnZZVzFwYm1kY01E?=
 =?utf-8?B?bGtPRFE1WWpZdE16SmtNeTAwWVRRd0xUZzFaV1V0Tm1JNE5HSmhNamxsTXpW?=
 =?utf-8?B?aVhHMXpaM05jYlhObkxXRTRZbU0zT1RkbUxXWTFZVGd0TVRGbFppMWhPR05q?=
 =?utf-8?B?TFRBd1ltVTBNekUwTVRVeFpWeGhiV1V0ZEdWemRGeGhPR0pqTnprNE1DMW1O?=
 =?utf-8?B?V0U0TFRFeFpXWXRZVGhqWXkwd01HSmxORE14TkRFMU1XVmliMlI1TG5SNGRD?=
 =?utf-8?B?SWdjM285SWpZNU5UZ2lJSFE5SWpFek16ZzFNakF5TmpJeE56azFOalUyT1NJ?=
 =?utf-8?B?Z2FEMGljWGxxVldjekx6VTRXbFI0UzFoak5tdHFhM2hPVEVSalNtTkZQU0ln?=
 =?utf-8?B?YVdROUlpSWdZbXc5SWpBaUlHSnZQU0l4SWlCamFUMGlZMEZCUVVGRlVraFZN?=
 =?utf-8?B?VkpUVWxWR1RrTm5WVUZCU2tGSVFVRkVXa0pFUW5KMFdXNWlRVk0xTmtWV2Vq?=
 =?utf-8?B?Wk9jbHAxVEc1dlVsaFFiekowYlRSS1FVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVoQlFVRkJRMDlDVVVGQkwyZFZRVUZLU1VKQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVVZCUVZGQlFrRkJRVUZyU1ZveFdrRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGS05FRkJRVUpxUVVkUlFXSm5RbVpCU0ZsQllVRkNhMEZIZDBGWWQw?=
 =?utf-8?B?SnlRVWRWUVdWUlFqTkJSemhCWTJkQ2EwRklUVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZuUVVGQlFVRkJibWRCUVVGSFRVRmlkMEoxUVVoUlFWcFJRblZC?=
 =?utf-8?B?U0ZGQldIZENkRUZIUlVGa1FVSnFRVWRuUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGRVowRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVZGQlFVRkJRVUZCUVVGRFFVRkJRVUZCUTJWQlFVRkJZM2RDZGtGSVZV?=
 =?utf-8?B?RmpaMEpxUVVkVlFWbDNRblpCUjFGQldsRkNaa0ZIUlVGamQwSjBRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVSkJRVUZCUVVGQlFVRkJTVUZCUVVGQlFVbzBRVUZC?=
 =?utf-8?B?UW5wQlJ6aEJaRkZDZVVGSFRVRmFVVUpxUVVjNFFWcEJRbXhCUmpoQldYZENk?=
 =?utf-8?B?MEZJUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-rorf: true
x-dg-refone:
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZGUVVGQlFVRkJRVUZCUVdkQlFVRkJRVUZ1?=
 =?utf-8?B?WjBGQlFVaE5RV0ozUWpGQlNFbEJXWGRDYkVGSFRVRmlkMEpyUVVkVlFWaDNR?=
 =?utf-8?B?bXBCU0UxQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlVVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?TkJRVUZCUVVGRFpVRkJRVUZqZDBKMlFVaFZRV05uUW1wQlIxVkJXWGRDZGtG?=
 =?utf-8?B?SFVVRmFVVUptUVVkWlFXSjNRbmxCU0ZGQlkyZENhRUZITkVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRa0ZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZKUVVGQlFVRkJTalJCUVVGQ2VrRkhPRUZrVVVKNVFVZE5R?=
 =?utf-8?B?VnBSUW1wQlJ6aEJXa0ZDYkVGR09FRmhaMEpvUVVoWlFWbFJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVWQlFVRkJRVUZCUVVGQlowRkJRVUZCUVc1blFVRkJTRTFCWW5k?=
 =?utf-8?B?Q01VRklTVUZaZDBKc1FVZE5RV0ozUW10QlIxVkJXSGRDZDBGSWEwRmtRVUp2?=
 =?utf-8?B?UVVjNFFXSm5RVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRlJRVUZCUVVGQlFVRkJRMEZCUVVGQlFVTmxR?=
 =?utf-8?B?VUZCUVdOM1FuWkJTRlZCWTJkQ2FrRkhWVUZaZDBKMlFVZFJRVnBSUW1aQlNF?=
 =?utf-8?B?bEJaRkZDYVVGSWEwRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?Q?FBQUFB?=
x-dg-reftwo:
 QUFBQUFBQUFBQUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFKSUJBQUFBQUFBQUNBQUFBQUFBQUFBSUFBQUFBQUFBQUFnQUFBQUFBQUFBY2dFQUFBa0FBQUFzQUFBQUFBQUFBR01BWkFCdUFGOEFkZ0JvQUdRQWJBQmZBR3NBWlFCNUFIY0Fid0J5QUdRQWN3QUFBQ1FBQUFBT0FBQUFZd0J2QUc0QWRBQmxBRzRBZEFCZkFHMEFZUUIwQUdNQWFBQUFBQ1lBQUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUdFQWN3QnRBQUFBSmdBQUFBQUFBQUJ6QUc4QWRRQnlBR01BWlFCakFHOEFaQUJsQUY4QVl3QndBSEFBQUFBa0FBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3QmpBSE1BQUFBdUFBQUFBQUFBQUhNQWJ3QjFBSElBWXdCbEFHTUFid0JrQUdVQVh3Qm1BRzhBY2dCMEFISUFZUUJ1QUFBQUtBQUFBQUFBQUFCekFHOEFkUUJ5QUdNQVpRQmpBRzhBWkFCbEFGOEFhZ0JoQUhZQVlRQUFBQ3dBQUFBQUFBQUFjd0J2QUhVQWNnQmpBR1VBWXdCdkFHUUFaUUJmQUhBQWVRQjBBR2dBYndCdUFBQUFLQUFBQUFBQUFBQnpBRzhBZFFCeUFHTUFaUUJqQUc4QVpBQmxBRjhBY2dCMUFHSUFlUUFBQUE9PSIvPjwvbWV0YT4=
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|BY1PR07MB10842:EE_
x-ms-office365-filtering-correlation-id: c661c5da-ffa6-43cf-d170-08dd57cc901c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RGQrYmk0bTNRYjJWN3Z4dm04OGs3eHAwdHZheDRGZkNqeEtFdElScld0bUE1?=
 =?utf-8?B?cE1uRlBVU1J4TXZZUkkvT1ViZGFxQlNWenNXUmgrVEpmcmNXRnROeU83Rno4?=
 =?utf-8?B?Ylp0VVFFcU5sMmkrT0hRMS9UNTBlaUM2T21ndXRSckYrUXpaOGRHRHhJVUNY?=
 =?utf-8?B?MmdJN2QzZjNqUzR5a2s2UWsrMFZmeEZkZTh1WWthSDdkZENzMlE5ME5lbWJI?=
 =?utf-8?B?dGpyQ08vb3FGN0dSK2I4L0p6M1NRTWhRc3AwdzBlNkJ5Nmt3enNEMjF5Y0VP?=
 =?utf-8?B?ZU1qWkd2UVVQWkJBUTFOVDlFK00xZTh1R1REQmgvRWZtdmdvdUF3QVdrd2dR?=
 =?utf-8?B?ZUFKM285dThQUllzR2lNb1Y4Vk4wZkRLQStDODNtZWpmL3JHU1BhYW5NUy9p?=
 =?utf-8?B?bmIvMlhaeXFtd3dMdDJqd3ZSTTErS0p3dWhpeUlkQW9Ob3BKRVhLQ3JjSXlF?=
 =?utf-8?B?MEFPTUdzSG5VamU1Sm40cmNKdGN1em4yUzM1aHFWRVRPTHJWZmdrcUtrMmp5?=
 =?utf-8?B?S2psbDdVNjdEQ2xZMUJjRzVoa01rWTdFM1dWdlRyazM4U0RKQVE2Z1NRa0JV?=
 =?utf-8?B?OGdSZG1qbFV1ZXpXa3B6UVpjVElMd1BNL0lVWTJ5T0d1K3BZU1JZdnUvdlpx?=
 =?utf-8?B?SGNYcDFQa1Q5WDBUV2tSYzI4eE1RRWN3NU83YXBrNjlsakg3V2VJUmFGQXhJ?=
 =?utf-8?B?TFR3UG50TlpJeXlVZHlYdXB1U0preGhDalRtbnl4eGxyQkJFNzZKL09pbk9y?=
 =?utf-8?B?RXFKK0w3enFzNWFBQVRSS0VCMUFZeUw5T1ZNMFk2ZkFjT3dDRVNYUk4zTWVF?=
 =?utf-8?B?NXVqL08xRnN3dWt4NUxZRTR5c0xMUzEwSnN3aFlHZitNQkEyRlBFaC9pcUp4?=
 =?utf-8?B?dUlOcGROemc4QnVWdG9KL24wdWxOYzE4bEtwZHRFY0Fsa1FHMlh6cng2Z3Mx?=
 =?utf-8?B?bERFY0FVMEFxWHF5eHRFUTFwNlU2K2VqUlRHNVpCeVZNV3Vqc0MvZEMxWnIr?=
 =?utf-8?B?VVUrTUxIdHVhdEN1TEZJZFpLREJVemhUOEF1a2ZGNjhJQU9lOTZ2UVovT3dz?=
 =?utf-8?B?OWl4N1BOUDFpVmxpZU94Q2NzZVNzaUJtVlVVL3VEeEdtd2svTXdIbnA4Q1NF?=
 =?utf-8?B?K1d2cUo5cVpIaVF3VTRzVkszdExINmFkd3pGcUlWNU50MDROYnpKQ1RsODVr?=
 =?utf-8?B?dVkxdHhQZ1N3Y1dnTHRWbFBLWi9Dd1JpZU5YY3gzbTBjeml2UDllSXhDM0hh?=
 =?utf-8?B?TGluRkxCeW0wS3BISUJ4amVHL1k1dVZiK29lN1hWaVRUcExlaFRacTVjSlRU?=
 =?utf-8?B?ck5aMDdNSjZzUG4zZjR4blJDSXE3OXl6SDA3MGd0VTc3RDJVMDJIS1BwV0xH?=
 =?utf-8?B?NDA1d1RDd1ZmcVl5dzVyY2REMzNIMFhKTWhENlVwYjdQYjdlZmpyVkgvakZ5?=
 =?utf-8?B?a050NjMrdTlLMEt6VC9sa21IWExCTnlUamlDSlJ5VWNyYk9ZNEJlMmFDRk9C?=
 =?utf-8?B?SFJlVGhOV1hmdFpPWDJoZnZOTkFqYW9xU29yd1ZvRWVCVEY0Q0VPYjN4T0Q5?=
 =?utf-8?B?SXFibVJkaExEM2xlcVVqYUN3M1M1TnlUMzk5YzMvQzR2SlVvbTcwRDlGVm16?=
 =?utf-8?B?QUVOdEtiZnUwYmU2U3pjWlJpVmk1NXp0b0xDOTI2aVE3Q2VJMXhXd2k2ckxF?=
 =?utf-8?B?eUxsVGJ3YjdjSldVOC96OW9ka2dOWm1SMy8xTWVhNUlvbk9YMkhkOWZNaUsv?=
 =?utf-8?B?cnIwZ0VVNW90dE9DR1BrMFQ5K3RZNERBbHhPd0FFRjNGdlBpQ2p5bHM3VGNM?=
 =?utf-8?B?Z210RG02SW9WN0J3ZEJjS2FCeXFqN0I5aEQ2V0lzNC9sZU5lbFpOVnFhM1RE?=
 =?utf-8?B?cGVETWlNSEtXZSsrRzIrbjhXYnN6czNJTCt1ZnJFQ2NLT29pcGRPN3lubytL?=
 =?utf-8?Q?Mb9uw/yysMGOHff1ZVMSTGX+5nchySIO?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UmdZVE1scytXakxOa1hvY1F3RXBRT2JqVE5RQXZJZVdjaFZneDN0ZVdJellK?=
 =?utf-8?B?akg3OStQN0tXTHhWVldubndLeEZ2SElpRDlrdExVUDFxVWtER3hHVUxMdFJR?=
 =?utf-8?B?SFU4RnlqajJGQmQwRnF0bGgxYUhhSXMxSnU0SlY1M1V2YUd6UFliYUJ1MnZs?=
 =?utf-8?B?cUtMWUVESUxJSlFZRE1pcjBrbXZOcEkrUHU5NUdzL2Z2c1ZrMjFrZ3lmL0M0?=
 =?utf-8?B?bWNCbmNQNDJ6aVJPQ2tqU1lrTWJEL1JJTThiQWNYUXovUWdmYzA2Nitaemty?=
 =?utf-8?B?SkxlMFVNVmhPNXRNcGhPV20xemhva1VuUE5FbER5R1orVmViZ0hqemYxa0pQ?=
 =?utf-8?B?N2pRVHozb3ZHanp5aEdIZU91REV4Q3c1UlpGSG9HU1RObTFmYlVIaWtOZXhm?=
 =?utf-8?B?WEVLallSSk5tWnEva3BCWWtELy9WSVk1QW4vRUNyNk5uUlowMXN0OWZ0U2tT?=
 =?utf-8?B?NUpnbHM1cHJoMEN0Y3o5WmZpOWJJUDJ1YUNTNExHR1FDc1BhOThqU0pETzV2?=
 =?utf-8?B?dk5oWUpibDUwNVN1QTlSTmNyUEhvd3hoTFZRZElJZ3dLSGhibjU4cEtVc29Y?=
 =?utf-8?B?bHkzbHJDYUY2ZGZmK1VuQ1hrV2NWUlhDc2FxbGRGMmc2elNXZXVtVmpSSDc5?=
 =?utf-8?B?eEN3bXZYdk0rYWNGZTRyZjJaOXZWbDl0K09TZFdzeDZqOXgvZ1NabEJYT3Ro?=
 =?utf-8?B?Y0pRQUtYNzZIcTJxSWJ3cW0xWXVJWXZlYWlHOGUzakNRZ3VWK1Fvc05PSlRy?=
 =?utf-8?B?SGdsc3NlRWtaa1hHeUErYVhPNUFNR2d2N2NWa3VqOXh5NTNBS1lCMm44YnVv?=
 =?utf-8?B?TXpXT0NNeEgzU2haNWxhdG1KVUNCcFZoRWwxdmZUOCtZZDVBVHZsSmYyUWt2?=
 =?utf-8?B?RXpVaVdKOElJZGUxNldoWGJrRWliZXM3N2xYV2VCbFBhVVFHb0E0MEM3QTd2?=
 =?utf-8?B?RmlVaE5CK0NYWkU2OUhkZXg2V3JUY3VIUTd0anNsRVE3MmwwYy85NGRQTXUy?=
 =?utf-8?B?QzFvSjRZcTM5RGh4T0ROM1V4YklZK216MllyNERXL0dEaHo2WGZJMjNkT2Vi?=
 =?utf-8?B?Z0RLeEdzN0lWWFdGK1JkblRRbEFiU0VDOVR2blJMTVRrRW05anJsUnlGaU15?=
 =?utf-8?B?RW1QUlVycDVyeDRXZTE5TTh4RTJGbmY5NlFLaFdkQzhDK2ttV2tuVjY0WHNt?=
 =?utf-8?B?a1p6ZG9GZVpEb0lJN2JXMW5OTDVUQnNCWnFKcTYvbCtvZWJFWkpqYWlPTDFX?=
 =?utf-8?B?Qmp6c0plTmJvVzIzUEVJdmhtb0Yrd0dJRHM4OEtCOExuRWUzZWpJMkErNU5V?=
 =?utf-8?B?bzNVczNGNksxck9MMmIxeW9mUFZlL2Q3b1R6b0FacXhOWnYreUV5T1hYcEQy?=
 =?utf-8?B?dEtwRXRycjAxWSs0a21Nek1COXhROEYwRnFndmhuYXZ3UDlSaElDS0pPMEY4?=
 =?utf-8?B?WmYzZ3piS0FBRGxDcTcwYXJiTlB2WnppcmNBM0JrclJtV3FndzM3SjNFNkYx?=
 =?utf-8?B?M2NYYlJPcy9kbzNoTVlIS1JrR1lCbmpaVWFvS1RpTnZVcnYyU3BLSlErT2Vn?=
 =?utf-8?B?VE1ZMDgvWHdpeG1YTzJDNU0zTWt0RXpsOVZIdFM0eEJESit0T01BSkJrdllB?=
 =?utf-8?B?ekI5eUc0MVNzWkFqVzhRMnlMdzRCcVFNYTdvajhYbDBrdHhzOUcyN3pZd3l2?=
 =?utf-8?B?TDZHSlFXc2thcmtqNWVCWkhzQTh0eS9xUXpucnVqTHRSVnIzY2F5ZVJYMGor?=
 =?utf-8?B?SzB6UFVUcnl2S0dva0hVcjRMNWZsQzNLN0RLbVpLU012V2xpWk9CYkREMUtm?=
 =?utf-8?B?MGE1cDE3bDBxOWRaVC82WFFOUU5LL2dIRm93OTM4ay8yZlVPVHMrM2Z5L2J6?=
 =?utf-8?B?UUFSd3RxUXZHZjVmRStET0xqRWYzakFYNlNvTTA1L2RYNDBlZnI5VVBtZGw5?=
 =?utf-8?B?WUhLK0t3dkF3OEZ3YUJuR1JnVjRYanpOeEpUZE9uZVVES0t0b0w3cXU4UUUz?=
 =?utf-8?B?MDZmK1N6Y3pwdkl5dHJhRVcrUTY0eVp0OUIyM1EwSDVrbUJvZlhYVEFlQlh6?=
 =?utf-8?B?RWhDcFNCVkJwS0ZOSlprM1NHalpNdnErc2RsdEdZM2tLbSttWVJ6dXJMelhO?=
 =?utf-8?Q?p4H4VoEaK4AJEZ5flRZ77YFBq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c661c5da-ffa6-43cf-d170-08dd57cc901c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2025 07:50:25.9001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /1Oq75DbcJYy8aYapYr7DFGzQZDvM7GT+938pi4QRisBkEVO9+xB0ZYoPs2nFy3xJDV9Bx7BfDJ7Pu2FnzifGbXN47hhAtzlTcxRaHPuxw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR07MB10842
X-Proofpoint-ORIG-GUID: eb2_ixCJhCOZM7KRCz6h6G9co-SYfKgW
X-Authority-Analysis: v=2.4 cv=B8xD0PtM c=1 sm=1 tr=0 ts=67c16ac5 cx=c_pps a=2/f09Pi2ycfuKzF0xiDRrg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=Zpq2whiEiuAA:10
 a=VwQbUJbxAAAA:8 a=Br2UW1UjAAAA:8 a=fAtflJM7RsOH10yn2owA:9 a=QEXdDO2ut3YA:10 a=WmXOPjafLNExVIMTj843:22
X-Proofpoint-GUID: eb2_ixCJhCOZM7KRCz6h6G9co-SYfKgW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_01,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 mlxscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=756
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280055

VGhlIHhIQyByZXNvdXJjZXMgYWxsb2NhdGVkIGZvciBVU0IgZGV2aWNlcyBhcmUgbm90IHJlbGVh
c2VkIGluIGNvcnJlY3QNCm9yZGVyIGFmdGVyIHJlc3VtaW5nIGluIGNhc2Ugd2hlbiB3aGlsZSBz
dXNwZW5kIGRldmljZSB3YXMgcmVjb25uZWN0ZWQuDQoNClRoaXMgaXNzdWUgaGFzIGJlZW4gZGV0
ZWN0ZWQgZHVyaW5nIHRoZSBmYWxsb3dpbmcgc2NlbmFyaW86DQotIGNvbm5lY3QgaHViIEhTIHRv
IHJvb3QgcG9ydA0KLSBjb25uZWN0IExTL0ZTIGRldmljZSB0byBodWIgcG9ydA0KLSB3YWl0IGZv
ciBlbnVtZXJhdGlvbiB0byBmaW5pc2gNCi0gZm9yY2UgaG9zdCB0byBzdXNwZW5kDQotIHJlY29u
bmVjdCBodWIgYXR0YWNoZWQgdG8gcm9vdCBwb3J0DQotIHdha2UgaG9zdA0KDQpGb3IgdGhpcyBz
Y2VuYXJpbyBkdXJpbmcgZW51bWVyYXRpb24gb2YgVVNCIExTL0ZTIGRldmljZSB0aGUgQ2FkZW5j
ZSB4SEMNCnJlcG9ydHMgY29tcGxldGlvbiBlcnJvciBjb2RlIGZvciB4SEMgY29tbWFuZHMgYmVj
YXVzZSB0aGUgeEhDIHJlc291cmNlcw0KdXNlZCBmb3IgZGV2aWNlcyBoYXMgbm90IGJlZW4gcHJv
cGVybHkgcmVsZWFzZWQuDQpYSENJIHNwZWNpZmljYXRpb24gZG9lc24ndCBtZW50aW9uIHRoYXQg
ZGV2aWNlIGNhbiBiZSByZXNldCBpbiBhbnkgb3JkZXINCnNvLCB3ZSBzaG91bGQgbm90IHRyZWF0
IHRoaXMgaXNzdWUgYXMgQ2FkZW5jZSB4SEMgY29udHJvbGxlciBidWcuDQpTaW1pbGFyIGFzIGR1
cmluZyBkaXNjb25uZWN0aW5nIGluIHRoaXMgY2FzZSB0aGUgZGV2aWNlIHJlc291cmNlcyBzaG91
bGQNCmJlIGNsZWFyZWQgc3RhcnRpbmcgZm9ybSB0aGUgbGFzdCB1c2IgZGV2aWNlIGluIHRyZWUg
dG93YXJkIHRoZSByb290IGh1Yi4NClRvIGZpeCB0aGlzIGlzc3VlIHVzYmNvcmUgZHJpdmVyIHNo
b3VsZCBjYWxsIGhjZC0+ZHJpdmVyLT5yZXNldF9kZXZpY2UNCmZvciBhbGwgVVNCIGRldmljZXMg
Y29ubmVjdGVkIHRvIGh1YiB3aGljaCB3YXMgcmVjb25uZWN0ZWQgd2hpbGUNCnN1c3BlbmRpbmcu
DQoNCkZpeGVzOiAzZDgyOTA0NTU5ZjQgKCJ1c2I6IGNkbnNwOiBjZG5zMyBBZGQgbWFpbiBwYXJ0
IG9mIENhZGVuY2UgVVNCU1NQIERSRCBEcml2ZXIiKQ0KY2M6IDxzdGFibGVAdmdlci5rZXJuZWwu
b3JnPg0KU2lnbmVkLW9mZi1ieTogUGF3ZWwgTGFzemN6YWsgPHBhd2VsbEBjYWRlbmNlLmNvbT4N
Cg0KLS0tDQpDaGFuZ2Vsb2c6DQp2MzoNCi0gQ2hhbmdlZCBwYXRjaCB0aXRsZQ0KLSBDb3JyZWN0
ZWQgdHlwbw0KLSBNb3ZlZCBodWJfaGNfcmVsZWFzZV9yZXNvdXJjZXMgYWJvdmUgbXV0ZXhfbG9j
ayhoY2QtPmFkZHJlc3MwX211dGV4KQ0KDQp2MjoNCi0gUmVwbGFjZWQgZGlzY29ubmVjdGlvbiBw
cm9jZWR1cmUgd2l0aCByZWxlYXNpbmcgb25seSB0aGUgeEhDIHJlc291cmNlcw0KDQogZHJpdmVy
cy91c2IvY29yZS9odWIuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0K
IDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3VzYi9jb3JlL2h1Yi5jIGIvZHJpdmVycy91c2IvY29yZS9odWIuYw0KaW5kZXggYTc2YmI1MGI2
MjAyLi5kY2JhNDI4MWVhNDggMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jDQor
KysgYi9kcml2ZXJzL3VzYi9jb3JlL2h1Yi5jDQpAQCAtNjA2NSw2ICs2MDY1LDM2IEBAIHZvaWQg
dXNiX2h1Yl9jbGVhbnVwKHZvaWQpDQogCXVzYl9kZXJlZ2lzdGVyKCZodWJfZHJpdmVyKTsNCiB9
IC8qIHVzYl9odWJfY2xlYW51cCgpICovDQogDQorLyoqDQorICogaHViX2hjX3JlbGVhc2VfcmVz
b3VyY2VzIC0gY2xlYXIgcmVzb3VyY2VzIHVzZWQgYnkgaG9zdCBjb250cm9sbGVyDQorICogQHVk
ZXY6IHBvaW50ZXIgdG8gZGV2aWNlIGJlaW5nIHJlbGVhc2VkDQorICoNCisgKiBDb250ZXh0OiB0
YXNrIGNvbnRleHQsIG1pZ2h0IHNsZWVwDQorICoNCisgKiBGdW5jdGlvbiByZWxlYXNlcyB0aGUg
aG9zdCBjb250cm9sbGVyIHJlc291cmNlcyBpbiBjb3JyZWN0IG9yZGVyIGJlZm9yZQ0KKyAqIG1h
a2luZyBhbnkgb3BlcmF0aW9uIG9uIHJlc3VtaW5nIHVzYiBkZXZpY2UuIFRoZSBob3N0IGNvbnRy
b2xsZXIgcmVzb3VyY2VzDQorICogYWxsb2NhdGVkIGZvciBkZXZpY2VzIGluIHRyZWUgc2hvdWxk
IGJlIHJlbGVhc2VkIHN0YXJ0aW5nIGZyb20gdGhlIGxhc3QNCisgKiB1c2IgZGV2aWNlIGluIHRy
ZWUgdG93YXJkIHRoZSByb290IGh1Yi4gVGhpcyBmdW5jdGlvbiBpcyB1c2VkIG9ubHkgZHVyaW5n
DQorICogcmVzdW1pbmcgZGV2aWNlIHdoZW4gdXNiIGRldmljZSByZXF1aXJlIHJlaW5pdGlhbGl6
YXRpb24g4oCTIHRoYXQgaXMsIHdoZW4NCisgKiBmbGFnIHVkZXYtPnJlc2V0X3Jlc3VtZSBpcyBz
ZXQuDQorICoNCisgKiBUaGlzIGNhbGwgaXMgc3luY2hyb25vdXMsIGFuZCBtYXkgbm90IGJlIHVz
ZWQgaW4gYW4gaW50ZXJydXB0IGNvbnRleHQuDQorICovDQorc3RhdGljIHZvaWQgaHViX2hjX3Jl
bGVhc2VfcmVzb3VyY2VzKHN0cnVjdCB1c2JfZGV2aWNlICp1ZGV2KQ0KK3sNCisJc3RydWN0IHVz
Yl9odWIgKmh1YiA9IHVzYl9odWJfdG9fc3RydWN0X2h1Yih1ZGV2KTsNCisJc3RydWN0IHVzYl9o
Y2QgKmhjZCA9IGJ1c190b19oY2QodWRldi0+YnVzKTsNCisJaW50IGk7DQorDQorCS8qIFJlbGVh
c2UgdXAgcmVzb3VyY2VzIGZvciBhbGwgY2hpbGRyZW4gYmVmb3JlIHRoaXMgZGV2aWNlICovDQor
CWZvciAoaSA9IDA7IGkgPCB1ZGV2LT5tYXhjaGlsZDsgaSsrKQ0KKwkJaWYgKGh1Yi0+cG9ydHNb
aV0tPmNoaWxkKQ0KKwkJCWh1Yl9oY19yZWxlYXNlX3Jlc291cmNlcyhodWItPnBvcnRzW2ldLT5j
aGlsZCk7DQorDQorCWlmIChoY2QtPmRyaXZlci0+cmVzZXRfZGV2aWNlKQ0KKwkJaGNkLT5kcml2
ZXItPnJlc2V0X2RldmljZShoY2QsIHVkZXYpOw0KK30NCisNCiAvKioNCiAgKiB1c2JfcmVzZXRf
YW5kX3ZlcmlmeV9kZXZpY2UgLSBwZXJmb3JtIGEgVVNCIHBvcnQgcmVzZXQgdG8gcmVpbml0aWFs
aXplIGEgZGV2aWNlDQogICogQHVkZXY6IGRldmljZSB0byByZXNldCAobm90IGluIFNVU1BFTkRF
RCBvciBOT1RBVFRBQ0hFRCBzdGF0ZSkNCkBAIC02MTI5LDYgKzYxNTksOSBAQCBzdGF0aWMgaW50
IHVzYl9yZXNldF9hbmRfdmVyaWZ5X2RldmljZShzdHJ1Y3QgdXNiX2RldmljZSAqdWRldikNCiAJ
Ym9zID0gdWRldi0+Ym9zOw0KIAl1ZGV2LT5ib3MgPSBOVUxMOw0KIA0KKwlpZiAodWRldi0+cmVz
ZXRfcmVzdW1lKQ0KKwkJaHViX2hjX3JlbGVhc2VfcmVzb3VyY2VzKHVkZXYpOw0KKw0KIAltdXRl
eF9sb2NrKGhjZC0+YWRkcmVzczBfbXV0ZXgpOw0KIA0KIAlmb3IgKGkgPSAwOyBpIDwgUE9SVF9J
TklUX1RSSUVTOyArK2kpIHsNCi0tIA0KMi40My4wDQoNCg==

