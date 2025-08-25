Return-Path: <stable+bounces-172859-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B0BB34276
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 16:00:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E368A1887983
	for <lists+stable@lfdr.de>; Mon, 25 Aug 2025 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B91C2F7453;
	Mon, 25 Aug 2025 13:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b="WkNJYjt2"
X-Original-To: stable@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11023093.outbound.protection.outlook.com [40.107.159.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C334C22F75C;
	Mon, 25 Aug 2025 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756130076; cv=fail; b=gAYzZfPx2siPF0T0CPo3XutAP5XN5QFsmQ+GcpgSyR1MgrsXYiX7VWlQW46zKVaYZ9eVK2t4igwdcHYo6/APocQgpIkC3hIu4v48yX2bLFVB4kOiwyWpTKvpaTQtnCTaY7K44+JnZ6gDJFKyOBiM5xMfTMyyZiRXnY+HqP8R81s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756130076; c=relaxed/simple;
	bh=CxnThT9y3TSzIgnb/K7buRN1QxBl/v6RVJTWlEPnKs0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qXg1/p8YtTfv4pn9Ixq9GI8OoNYN7z+ohOh4VdL+3e3wq0t7BxFIJowWElnL7WyAqWMYZJpU4YWxxaXjcVpcDTslPTNOrwqksCVV7UzzluIErrzVz704g2DGRGUZ9YkfwisZG3WB8g90E0PnCC6VofTbc11vYTtqcCc9hhvsP4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl; spf=pass smtp.mailfrom=sttls.nl; dkim=pass (2048-bit key) header.d=sttls.nl header.i=@sttls.nl header.b=WkNJYjt2; arc=fail smtp.client-ip=40.107.159.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sttls.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sttls.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KiyAOadbkckgY+nXEjiiN+7uAL0zNCh/3OU2uBUGphPQcqg8vij7CI1HQYe0xK0EdMun+utWns70vwd7R2A2+58ITzaFgRhj+tfAbmaJuc8FZrNkbdEnGdIk+DofLCQN/JLoFixWRJlaQfMBFx5c0txnLRjdXxFT9hdeQlMB6pJnNluJ/bjv5Hubh70+dTUXvLZPeG/IF9lj5g+Ss22jkbOgwdIUtSYOJuLRjbCzPkaBXK6dcMZ7fkPXDqiQVYmSGGFJL6o2TceoJthiWNmJQYf3RN5pq3asp7K7FqiI8Hjg1NWKgygo7S4hsvJ4nrp2bQgSTfQxSr3jlXZ5t11LvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxnThT9y3TSzIgnb/K7buRN1QxBl/v6RVJTWlEPnKs0=;
 b=ySLmQnMzY2SVqAAXc0F1dUqd1+I5LARJHTeN1xoeXNp8dI5lbsIv/1f2UGq4KQuWZdbev0EcXRxyL29I2dSxrLMm7lZvkFW39GYENhce+SKalLrN/qEf2B9vNZ4flAakuKBRkL7EpRp9Ov7iXJztCItnkmtzRKqpNstn7yhdo498TanFlVDYp1chviBj6jepKFkjaEUzRH981ff+z8iu1Zpo2y7+pyqrEyALk0nFRNxemn6eLDCiANFlPE3laE21Hda3Bn3sRdj7TyhXF+8KRBvaE9S4DHMwATsYIR1f9MKZiYNs3Qykm/xY3mqOSmUhxiM3/4iGuezjFaD+UKL93g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 20.93.157.195) smtp.rcpttodomain=linutronix.de smtp.mailfrom=sttls.nl;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=sttls.nl;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sttls.nl; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxnThT9y3TSzIgnb/K7buRN1QxBl/v6RVJTWlEPnKs0=;
 b=WkNJYjt2Lh7s3v2TfEw0ZhGzBhO1TSkQs8hFxBw/TMBWf+D5RukvzP4Am9YK+NgRKT9LJCrpNX9eofDjSBL4mLTvhH9m6NtTCBwR2yXIMZ/dLOxvh5Lh+KuSMQ7KqMKXblHua8NobcQ2Cqhme/jCJWDLcZB0bnQPMTTUX5Tr9NS2XFSXtbkKG8mFUaky0X9IuIhP96poYbWQ8OW206kCnRK6HreynvJnSmRM6piq/k4DrU5+xutZmz/o/Sf8r16d13DtjuRiHN2gaRS1/rulL64dY5Kd8BW6PwvjyV8LnH1swqpDPfoaQDYcz29mDWzMHckcdtu1oTaXOc4lhP3uxg==
Received: from DUZPR01CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::19) by PA6PR05MB11148.eurprd05.prod.outlook.com
 (2603:10a6:102:3ca::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 13:54:23 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:46a:cafe::91) by DUZPR01CA0083.outlook.office365.com
 (2603:10a6:10:46a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 13:54:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.93.157.195)
 smtp.mailfrom=sttls.nl; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=sttls.nl;
Received-SPF: Pass (protection.outlook.com: domain of sttls.nl designates
 20.93.157.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.93.157.195; helo=westeu11-emailsignatures-cloud.codetwo.com;
 pr=C
Received: from westeu11-emailsignatures-cloud.codetwo.com (20.93.157.195) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 13:54:22 +0000
Received: from AS8PR04CU009.outbound.protection.outlook.com (40.93.65.29) by westeu11-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Mon, 25 Aug 2025 13:54:21 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com (2603:10a6:6:4a::24) by
 DB9PR05MB9200.eurprd05.prod.outlook.com (2603:10a6:10:364::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 13:54:20 +0000
Received: from DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53]) by DB6PR05MB4551.eurprd05.prod.outlook.com
 ([fe80::f854:dcd:a8dc:bc53%4]) with mapi id 15.20.9052.019; Mon, 25 Aug 2025
 13:54:20 +0000
From: Maarten Brock <Maarten.Brock@sttls.nl>
To: Martin Kaistra <martin.kaistra@linutronix.de>, Michal Simek
	<michal.simek@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>
CC: Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Thread-Topic: [PATCH v2] serial: uartps: do not deassert RS485 RTS GPIO
 prematurely
Thread-Index: AQHcFaH1MXEkZYlaqEGWd2GEoU/ke7RzQQgdgAAO2gCAAA0U6Q==
Date: Mon, 25 Aug 2025 13:54:20 +0000
Message-ID: <DB6PR05MB4551A2BC19AAE2BCE5ACD00A833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
References: <20250825092251.1444274-1-martin.kaistra@linutronix.de>
 <DB6PR05MB4551C55567E135005F7E6E95833EA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <e25ab816-f05a-4fcd-9a71-8b71e4e3c299@linutronix.de>
In-Reply-To: <e25ab816-f05a-4fcd-9a71-8b71e4e3c299@linutronix.de>
Accept-Language: en-US, nl-NL
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=sttls.nl;
x-ms-traffictypediagnostic:
	DB6PR05MB4551:EE_|DB9PR05MB9200:EE_|DB5PEPF00014B9E:EE_|PA6PR05MB11148:EE_
X-MS-Office365-Filtering-Correlation-Id: d4b02d82-8e37-465f-f097-08dde3dee563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?gWruKtVWfe5VidZF5bBbN5cXwGfVLomXjVfe1P9DP4Lxgi5SdgnIgBr5R5?=
 =?iso-8859-1?Q?gqvw+HFL02jCoS59yJ2BybrjyLLnb8GbZy5m94GZsxYkFCcW4hYUX5ZPMj?=
 =?iso-8859-1?Q?VlhEiRkcLk47LI0LfUYuGrPYBW56aFF4r7afvENwNs288uYJJDd2TlpbYZ?=
 =?iso-8859-1?Q?cBQMagjC2Lf40iCyw6Mfa3EmVPkhiO3AJ+1Hj7TZAADgfI/53iiSs52GyT?=
 =?iso-8859-1?Q?kvKHaqAVDHSxx5wgTZsRtn9wSzrsKhkrtAu3CIi2FVQY75MOb8b8U9St2/?=
 =?iso-8859-1?Q?iLKY2xbRRrHxBkeffwFsfKIoSJ3vEwqzWnJ4Tq1M5xpwgvq74kL+C80xyY?=
 =?iso-8859-1?Q?ZfHZ2J69I3lq7AwsECQ/mcw0OcVQ1Qjsm4xIPS2HIc0toW7ub5a+VtZ0OO?=
 =?iso-8859-1?Q?zjooJ4WYvrFvJccGhXp/S7gUwX2ZriSxIsGocBDU7SFdzu0yPlVBed/4qj?=
 =?iso-8859-1?Q?VKQmEGSenCVJSGzMXnsGexcz4XPEQS/K2YerjGcUjhL0MAm3pEvZc0xXlH?=
 =?iso-8859-1?Q?KZIpBy6r4DAubCnIDznJFYms/76YT76nZIsDg6XaBLdr7ksE2mxEfVon+w?=
 =?iso-8859-1?Q?NXgrtQZBoeJSChy1EBegmsRUiaBsTCNUsiSvdx1EjHmNoyr8T42KGuMa2J?=
 =?iso-8859-1?Q?TeHk9xtAEA/z84TIq8OpKHuee6J5lUVuU81IjnegieQklTxhTHcCA+sBmx?=
 =?iso-8859-1?Q?nfCQ/apPKXgX8Os6UGa3NUXP5H4xMD4rG0W2RSm5BJj+cJ27f23B85CeL/?=
 =?iso-8859-1?Q?KrateyGKKBd8+nU+8YYr8UUiyoe82qcmb5pM7URhkwTKuSJsXxowThBGMb?=
 =?iso-8859-1?Q?dt7IcoUUesp/PNvv7lWa4wNUbZIfNMv92dD1Tr9b+z09e/KSZt1KJu+fgG?=
 =?iso-8859-1?Q?gF22B3JYsI6RHE2vnLQ9x/g0sXP5sVz0yk8hBh0rU1V5ay5ZjRPaA/cB5X?=
 =?iso-8859-1?Q?ppNfylNBPisMc4wlSqpWVbS4gbS7K2z0I15gIZNFPaJQd8SXf9cDUAnyhZ?=
 =?iso-8859-1?Q?7Q9GmKYLgbS3zdSi93zB35Sq1bb9Xtcv6Mo3jwpx5Fkp0h7u8QdIoLawyh?=
 =?iso-8859-1?Q?qL6gjIz0GGKajfPhE+q8fUfB/fQq1jsIOWm6gUgPhIqW7cUCbH66n5b1hg?=
 =?iso-8859-1?Q?9mn+c5+IUiuE9Qh79Bcwfj3wL0LLT2/P/EkMNOCOTishgk+xyFTYrMRv5E?=
 =?iso-8859-1?Q?OHMy+uC63k04K/ANkjH0+VQnGAnEFyj51jM4HrmAfZV6EY1vDyIvfj0Nnv?=
 =?iso-8859-1?Q?+lhOIb2RTPASHxTLqZF1NkyGTS6NLWRKBI9/Bsf0iCDN46D45XYObkTk7R?=
 =?iso-8859-1?Q?pPtgPCt48KrkCcwaldqhalRKLPrmjoo8wNpyGZHnMIJ40x1Cp4/Eh28dys?=
 =?iso-8859-1?Q?gMVczcuBhyQuPqFidl5lgu9Xvzm449hFxK9AtamreJ4xlveJXAFxdNawZY?=
 =?iso-8859-1?Q?nwOoFNGyW+mZtgTXnSPYYjmdpi28np4AohaRPsDoSZSMAvXLX8mklTOCnD?=
 =?iso-8859-1?Q?TAV77M7DK1l0e4Sc1bNrvefGi7FE0UuuBn7dZcLDyEVQ=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB6PR05MB4551.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1102;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR05MB9200
X-CodeTwo-MessageID: ea06f0cb-2f4a-4d4e-9796-e70a89de9551.20250825135421@westeu11-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b1b39d66-c369-41f5-8912-08dde3dee3ee
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|35042699022|1800799024|36860700013|14060799003|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?p7YxJtL3nmkxea9V5KK5i4MB6XF2R4TQxevlXU54lm5SPUhG05s5WSEdQc?=
 =?iso-8859-1?Q?ezUEKx0jgZPiF8vcXEO6sy62MzaPRZsmliG4xwgYBLoQ2A4f+H70+iBrvy?=
 =?iso-8859-1?Q?s62IwAqcpOjsO3DWUQGWaamdDOPiaPvsYUCbgrolp2NMnRqiD3ams7QPJC?=
 =?iso-8859-1?Q?y1dMFxNiT75rQ5692qGpLABGw/XaPyqzPNjDtbuSTuNNmp6QQWtPY55OoW?=
 =?iso-8859-1?Q?gwua76+/qpfM8g8KoEBT+qLDRXuR9Pu7VTXVkDKBXff1bWw2zItZOgXmQL?=
 =?iso-8859-1?Q?R5jFEMP9fF+jEPraefwXsZArRB+klauIyowObTZW2gt9rnV3uLkWS/1LSH?=
 =?iso-8859-1?Q?K3poL/4zEExql0ncxy3ddS8hVz8KsDLF6g7J0JbEDax60PRK82bMVTDCxH?=
 =?iso-8859-1?Q?mQHCkl+k+JGMbeo7oi3MMjP/KdVddUccxRv3CURxoqaYcTuUhRm4qOdFgC?=
 =?iso-8859-1?Q?U0LGqzBHUsw+jxDaHhQJ8AuaUiXlh3NK75aKf2jBw62jsdBItjZHLhGEkw?=
 =?iso-8859-1?Q?BFzxM3AmP6fu0jdoszyYgjo9aqPCSo8rEfLEmUs16+j5EA5JGCs2/nvJl5?=
 =?iso-8859-1?Q?KIKKefLvmNOUXeZZspi6NvK3Hwr85i0vZRuFyE+JsUPLGZsV+8nC+u1s1w?=
 =?iso-8859-1?Q?TJFontM8T5lbC+PBJKxtMwsSUU22PCdCYBF6rIsYmi4gpEJ2UOg62KNILl?=
 =?iso-8859-1?Q?lHbdb9MgRuq/rT56CYpSM/QMNo3dOYPvKusaQzRrG0l6o6lWtZjU4mJmrl?=
 =?iso-8859-1?Q?EhWDtCinynrs/DGn57NfNLdoUwuT0swwstArGV44xLKU7bya3Fh0r8b872?=
 =?iso-8859-1?Q?/eAEcVnt6z1j5S2eClUNI/V/5hzC5ciZWJfIN55oZIDC9TeGbyFh+CW8Z/?=
 =?iso-8859-1?Q?xGtHeNwt7LZmiMzZLJa6zy325seOAg566wA4iq7Z3wZKv2kJDOigttlq2+?=
 =?iso-8859-1?Q?/NjF8TjcOU/kk70RMuHO0+u6iqh7Anl1oGpbELO78NLD3OXk/cNUZK1/T8?=
 =?iso-8859-1?Q?Yyj5yf8I7dnY2yIRwCmP08TsLl0RSVcP5tJ8N06M6wubyV2z8pg3soN2I4?=
 =?iso-8859-1?Q?/rxhX/QyZ3AeXSM44n3fhzCTFsjSaC4E9bWqu1EqgT/ughZz/JCBsPgkfD?=
 =?iso-8859-1?Q?rJ7iZ6TseAVEXynEc6EUJuutkA6YV86OTUMbf+diF2ymQDgnRvBKOfyKvD?=
 =?iso-8859-1?Q?zbvk8VXEQQrHhMPrSt+V+2i1J0WTsIK8yhANjbUE04i1ykSuL3pDNfm6IP?=
 =?iso-8859-1?Q?7NMyrBETTTN9F/RCZ3t+DQEifQq159w27nWvpBkZozBGi7RwXDxaqFe9+4?=
 =?iso-8859-1?Q?+C755ofp4uH0JoIH8EYVcCeqghU6hipu6AsCNUJi0i9EMNszE/JDHVmZ8o?=
 =?iso-8859-1?Q?ypv/gekEzPjwka6bJ8DiymDOG1eKe7dZICMxdL2XvfCKaxV2kD525orVDt?=
 =?iso-8859-1?Q?z38iMxwUEy1ag9HVH6SLq+AWPXmTx/UrhVa7p7/ln2/Yd450fqORZAvAfM?=
 =?iso-8859-1?Q?wWX15iJbPvfLcSmlBiHwlrDl7WPGMpaTWiqSq7qHmyIiCQoZlHC6xKDzol?=
 =?iso-8859-1?Q?b91Qnw5uPia4SqPfqLdYflTk8nFZ?=
X-Forefront-Antispam-Report:
	CIP:20.93.157.195;CTRY:NL;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:westeu11-emailsignatures-cloud.codetwo.com;PTR:westeu11-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(35042699022)(1800799024)(36860700013)(14060799003)(376014)(7053199007);DIR:OUT;SFP:1102;
X-OriginatorOrg: sttls.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 13:54:22.5988
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4b02d82-8e37-465f-f097-08dde3dee563
X-MS-Exchange-CrossTenant-Id: 86583a9a-af49-4f90-b51f-a573c9641d6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=86583a9a-af49-4f90-b51f-a573c9641d6a;Ip=[20.93.157.195];Helo=[westeu11-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR05MB11148

From: Martin Kaistra <martin.kaistra@linutronix.de>=0A=
=0A=
Hello Martin,=0A=
=0A=
> Am 25.08.25 um 13:58 schrieb Maarten Brock:=0A=
> > Hello Martin,=0A=
> =0A=
> Hi Maarten,=0A=
> =0A=
> > =0A=
> > Why not just start the timer and check TEMT after it has elapsed and re=
start the timer if not empty?=0A=
> > It would prevent busy-loop waiting.=0A=
> =0A=
> It would, yes, but couldn't this cause the time between last transmitted =
byte =0A=
> and switching the RTS GPIO to be less than the specified RTS delay?=0A=
> =0A=
Maybe you can calculate the nominal duration of the transmission and add th=
at to the delay?=0A=
But yes, that could still result in a short delay.=0A=
=0A=
You stated that the TEMT interrupt is not useable. Why not?=0A=
=0A=
But it does trigger the question what the RTS delay is used for?=0A=
- Is it to overcome the transmission of byte(s) still in the UART?=0A=
- Is it to overcome the transmission of the stop bit(s)?=0A=
- Can anyone imagine anything else that requires a delay?=0A=
- Is the given delay a minimum, typical or maximum value?=0A=
=0A=
Maarten=0A=
> =0A=
> Martin=0A=
> =0A=
> > =0A=
> > Kind regards,=0A=
> > Maarten Brock=0A=

