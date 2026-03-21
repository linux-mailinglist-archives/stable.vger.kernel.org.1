Return-Path: <stable+bounces-227751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNTGI35yvmmYPwMAu9opvQ
	(envelope-from <stable+bounces-227751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:27:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B05A2E4BD4
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DAC1B3042885
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEFD317177;
	Sat, 21 Mar 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="alQUqKsU"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D061C30E858;
	Sat, 21 Mar 2026 10:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088731; cv=fail; b=CPSj8aBJjLryS+lAF+XSeNMhHULiGw7v79+SQrKrsfTz4fFXG5hrUBnCFSW5A6LQ8AuqIlT+GBHhQBTs81abtiZOmJ9E+54hU3IhTVUHkaW8Vy9Qxa+dNRhtr68OXGdVJfMO+e8RBZdDZo3dVtOBV9+0RE9OcjqrwglDVeC+rok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088731; c=relaxed/simple;
	bh=tFrGOyLT++IWpszsEV9kdoYGRpqfVeB7OcId2ZDgPwU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XN2zREGUeDt/+AyzwkYjCLDV3vYGYlgiOxedqoTcI88eICYR16353KIQeiuIJjVbC59Xm29P0xehtGIlDwXHDfPis1uKE+z311iwuCWHXN2ADSRzCqXO85KZ++ziGHv40/koDZZlI5hXWjA1kUvIS3DnZ0C92X4CXg/HUeB8+II=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=alQUqKsU; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9uBOM3678324;
	Sat, 21 Mar 2026 03:25:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=crM6nqs1oXBnkfasMFilS+oumh6KD223+waFGgeGxdI=; b=
	alQUqKsUNJKLAeJavSr2YOGK+8uJCww4lC9b4JOtBi58WZJfeN7PO6Yo/0AatXR2
	cvcDjF4Afo4h8kjJ/VIQAblCDbPcRXK76cXfSntSu7eSrHgU96PY21p8aTgcX5NK
	23jraELTbODrnTFzHFQv3hh0lIbnTgVETtB/4pc0NHu1V1lBIXMDVTyEl2GBX0f+
	Fy6r9BJQxsA++I/+/pvP5bG3F2rOK2YHqp9pnKB2S4G6GTq1gsqoidir3SfG7lpK
	+bcyISaLY4JTUNRkrW/LrMs1tGvQ2/b7aelbXKZFNk5gSVjKzraYjKgd28df8JHw
	qF+wN6lTdB23qXUVMHgFOw==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggv7y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cF1x1qxIT0EkJDxxFRBMQnpbMkLXDau9PdrBZefkexvJrX4uRe9+0YabxrdU6MqZzwtwvdpQsU/Bya+epIbSI2KHhZYBIwnmrkOmMkn3EXG4ulpcYgogRoE3gAxKLig4BV/HW40hfci05gsq9D4coT87Eo2iG5YywugW9Jdt3we1gvHZnB98LNZeSnaiHY7qTIXwIrTYsRQKJseO5IJ3m2AZVaSMukZ149YnfRmRdjtCSDezHia4kjZLj5BIH5AB4ZpY2mUt1/SHBPVobU4rjlvCfbCjrvlrymM4EMqlbNeC3e9RfQwDUE+DKt7ECQWRyWuPjMPWhvh1YmKUugpvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crM6nqs1oXBnkfasMFilS+oumh6KD223+waFGgeGxdI=;
 b=Kdq0o+6+STEDw6ywfk1jrjpzJy6KWLYF5BAaywnQKYTYOZlGlqAPbCXiOA2opn700eqkcb6UPiW9QGZBemczRVHHDBtsk8KulcmptTMY9MjbRTy3BmmQlkBjzrMmw2AgY6FLBKroxpcxkTLeUcqhCHq/Kl7cb5BXL9112vT3oJ04/gTw2CODto6lSyAS7zqlcrFj56oy65XqfalSbqsqwlJqy9Lpv90QT3DiybGDhMoLpFDrTN+iEZgEKxAIimBQv6IczMT/ZPvRrhi399WIeKvKKenRuj8kXC8mxDLYv5Lcva8FScOwlQH1o7P3pveVp4UHxLOX+DQa2A2dQX6D1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:25:15 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:25:15 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 6/7] timers/migration: Remove locking on group connection
Date: Sat, 21 Mar 2026 12:24:39 +0200
Message-ID: <20260321102440.27782-7-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260321102440.27782-1-ionut.nechita@windriver.com>
References: <20260321102440.27782-1-ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIZP296CA0002.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a1::6) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|LV1PR11MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: 2576efce-8337-4b04-f4e3-08de8734244b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	oyioT1QFaoERRCuNlM7BirTPfuFZ0NfxiRkDCxR8fwGgxtVT1FJ0e2HLmzVR343Gsfxxs9uCSSIyKWG5dCvFwMTqWYHB5TwoiZR8fHbXhepSb+Iahduhm+5EUb17S/OjltznCsT7LgU8trJeGTYRNVzRneNL48cS96QixhB9G+zHxqi7aKX9rU0kxKkv6tE/qwTQwQOYtv50ORPqre6tnevkqdVNOnZET3+r5KLWEo69q2BfZH/JPj1EukZx4KdGTnGQgjZM8tRQcHJOLRWdAjgWi9wam/oo6HsXxwmdHWYt4Ew7NbHhqIK079+bL+Htnk+WHkLSV/w+quyDV4SjmojOi3AiKJ9d6pMqaZt5CIG9Y+q6MKSMBaCPHIyVzMhtuBNScVOH1fe5bobrrQ/eXPzWNAJFAFKF0vLztS1PEGQFBzdnykF6wfA1tk4hwrzQOvA3qs2yCzDk049GyO6DTVxvXcAC5KPzZZYH8pLcJscHgqDplvrlfDIkxXEt7Ne5v0CN+uGDZOx5CG3nGLoMxV2901xzMpKXeGFmveQeEcLrNYw9+XtF3g3EiE3PPKBftt74xF4Xmo2qmvC3ZE2g85OE61FayAV7DPfIkXymJSvKrBr864/0Q+2X0Y/DH9DANSRTW6KKBiM5PofvKgUcRK4hYK/GecoeGSdu3fMeYes3J7A8WnXMojqy+mjL7+5hicr5/0dy8BXtex9ieu6b0Xq8YX6WG/mal0+hpLk8sN6XP6QJdPiZh7+ENrFy2CeJ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ce4N9/ApmuokMmscJZsEhI5SAUOnvlA2Gl5BT3CRVOyBCOtstCkJB/tSLs6+?=
 =?us-ascii?Q?JANlORo8YydX0Qg7cbdb7i46CdvVpO4eswe3Ssyp+PIyr+57X/kCj4NirOUA?=
 =?us-ascii?Q?CpOExtMs2yNotC95Gi+4ioFtn+61tMeM/eRfYtBs5EOHUru/Mn+bM/+LzXC+?=
 =?us-ascii?Q?7/2PmTbDKX7/PaUTvOlPVLGbtt4ZBwKI9G50uU+1Xp7x39KN/Zil3Z9zj4Ej?=
 =?us-ascii?Q?3gnzjk5TAiE9h24TfAxo1LUp21ISrEGAY5Az8TIwMBEABgzD3T2Xhee+AP8Y?=
 =?us-ascii?Q?4MM1o+X7f+JEwSJyExUrOK93m+qwXLl1+9PAHaji9duXIuyr4v7sLET18XrT?=
 =?us-ascii?Q?EqWqXik0huD1gmDa3TCDCaRd15nvrhV6ZNVe3qEZfwPpnMIZhXrdKJCW4qhV?=
 =?us-ascii?Q?nZLJjFESA7O7JRnRZUWX/O8+dwL4vUIOqsiY1XikeXz37scCzE0hhAaTw/xy?=
 =?us-ascii?Q?ZQUkmQLged57zl+sh34j1vfOCDA/2QpglM75w1jyWVgUv7riXbVHx1ocMYgJ?=
 =?us-ascii?Q?WQBew4albVWHewqkAd5BLRulvkDSqQ8DVrtEX1OgjmyLH2isBuMohKsf117S?=
 =?us-ascii?Q?3DMXIkmyyfBPBkTCgJMyfIl3VdXtXHvYcIJdzWlDr4q5nz7P5NUI0U6fKPKq?=
 =?us-ascii?Q?tE2B7J+/dQJJ9rtMsqtongxSuCCFC7IsEJf2pTJ5ZjRWZ3jZqN5/s8QxlPEF?=
 =?us-ascii?Q?5ZztSmHU+qvY4Ga7ahkXaXtrGDBCEJ8tiVMfQkAmOjA09sOj3G+MerZUV/JS?=
 =?us-ascii?Q?7kLn8h56gqGfv+epxEKiJxte6krCqWl7hlD8sTm+1fqHPNVKU77X6IqHtVPv?=
 =?us-ascii?Q?3u468sbFTOx01euBUYb6UMZeCxEYh+M1ZFXJFhXr/DvSAOQOBB0TSE73DubU?=
 =?us-ascii?Q?WnSwD8Z5U9t8guT7vvPZ+zxzKkCyRs1Tqk+aIWIuBa0DN28ko8VZkvg+0L6z?=
 =?us-ascii?Q?RE0eYBz9Vgi0hwOUdMIyJK9OyNmGiQ9EYBz6U3d8KMU1U/F+zFzD8jg0x0kO?=
 =?us-ascii?Q?omYfQNbrSt5Gc6rBDXtyxlTpqKXvobLLgZWoM5hXtxMW8GONcZd6cqgCUlSi?=
 =?us-ascii?Q?e8zTygcaHAVnNmRltlbB8klIs9CSYSxYoT1VaCaX2uwz2K7arCriGKE5oxAs?=
 =?us-ascii?Q?CjxoXatY2jGh5fWxD4qYH1vrWdZ4DdVNoI6LlYeV6UN+TCrRR42pYdH1/Vbx?=
 =?us-ascii?Q?iDOYKaq239iz4pvx8naMpS4BMADYP/pS4amdHqjbrdCjUK0tMu7vZgIC6iFa?=
 =?us-ascii?Q?LFoE1i9SQN32Iw+wSIp7xr9gk8VGl12kknZNAGf+ywE6JjKr6LmkEU88amej?=
 =?us-ascii?Q?FALiz7b9QMRAeopW8/vY+YjiDPvVZIJdxhJ/2bi/C6ONk3wVULuDjolE+rQz?=
 =?us-ascii?Q?okg8mEe685NR91a0GNu+c8T6BeKN1wcTUBDityNHgi6vvDa6rYQchFSqS5J/?=
 =?us-ascii?Q?y3erfMV5MTd+m1ZUgatlPu/k+2ukoG7NlRcpgnPdySNOUU672w5ogK/tb3Hp?=
 =?us-ascii?Q?SAeB+1NVnQl1J+Hxlz12LY6xob4vFAJX5Szt9eS7aHGuMjQMxDSl8Pv3Qeab?=
 =?us-ascii?Q?qVW0eZyaisNqtdiPmv5Wa5ub6yCg/li8AjWlqrYfYq3oex6nuSMvDngDtfLm?=
 =?us-ascii?Q?6Iq+YwYEQtdHU1nq4B65IS2nExnd4BmV4rvxZG9cMiGHk91A6cL51ObXnnzR?=
 =?us-ascii?Q?MQ+gJU6i0kRttgZgUI97OQ7GarKbRqZFQk1ZMwyFRuwLQDki52PsNse6hNX1?=
 =?us-ascii?Q?ImKRxYmoBmPGbPut+P86DogvmEwszl8=3D?=
X-Exchange-RoutingPolicyChecked:
	sUXYuOvHlswZYD3+We1x8RTLTcH3a0VON3w/mQtlrPHCOBgT4QU2lMqKTXersTX1hai7QsQG24oJOb1eCkXBNIF21KB95Y55r7TVkN92kACG2woItLWFIiYFzb55aMdlErUI+Hf+BCzC0K0q4WOP6pfwleT2UcXn5TOvheC4DwXwaKC4hlmwC2yy4tuIVQoZkcztnUg0IKb+fKoRZUFpZz83z1vZcig2qffrjlFAkQN52o+KVvS/B4e5fiWzYxoSM/WcTkPKo4dDnzkEJFmzSDmM59gI1e+GeHgGYio0Sw52ark4PlaMhriRzRf3wDTFkEY0gOESUowGlm7Hy6bgJw==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2576efce-8337-4b04-f4e3-08de8734244b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:25:15.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: owyunJTxmVOG787y77Xoqp3S1UElGQ443zEiFKwM1cmE6EQBPKaCP1XRUCAJJOU06hFKJ0zgDt8I/HEgh0G8mkmIkwJWeE+RBFeZ+dCSZWI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-ORIG-GUID: RmsZDCDF3BSbK5o6TF3l0JgC23dFKYxE
X-Proofpoint-GUID: RmsZDCDF3BSbK5o6TF3l0JgC23dFKYxE
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be720d cx=c_pps
 a=Ei0IHGVoEhmO3RFfwX1Atw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=7v3I3WkK9OejaAtlTNQA:9
 a=FO4_E8m0qiDe52t0p3_H:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX4PhyFO9/a0w4
 6TOjJ2OSbSuppCt/Dh0s1OGwQyu1ps5xlkVCclWlgzloYC9J4xlOawk0dVBukNl3bFiy3ftup1S
 f7qHMhLp8FuQ19MLATvUklJEXMnZZYJO7+3q1UCGIQ1lE7l+Pblu0PVYxX8Qiw8PQpUoZDZDLVx
 4DLE3QRr93jO4fpaKLTZPzQZdrICW5xvEHkL52fwCKPiKtNgEcBPzcrfqkaTWGI4BTcsk89CET0
 Mt/B8jH5tc7y11NuomdhBvV0dbSu9DOWg6ckKz5J8YRj9LpJi3Ee5UrlmS4kfiz+/lBvmre3uHs
 U+WPE+S4iaII96kssq/DtNlAJyazvh4mJvfIsnN6wK8dIMy4bG0Inmjv1E+5E4KFqaTK53tX/v3
 0oZJYCQ2Iwkxuvo0TaFMB6fmBPCzUjSC1wmRBLx8Qaosp7JKh5HOD1MTc1z67G58Yg22P+EDaEw
 TTtDglTlNeQPMHek+Bw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-21_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 phishscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603210084
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227751-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:email,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,linutronix.de:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2B05A2E4BD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Frederic Weisbecker <frederic@kernel.org>

commit fa9620355d4192200f15cb3d97c6eb9c02442249 upstream.

Initializing the tmc's group, the group's number of children and the
group's parent can all be done without locking because:

  1) Reading the group's parent and its group mask is done locklessly.

  2) The connections prepared for a given CPU hierarchy are visible to the
     target CPU once online, thanks to the CPU hotplug enforced memory
     ordering.

  3) In case of a newly created upper level, the new root and its
     connections and initialization are made visible by the CPU which made
     the connections. When that CPUs goes idle in the future, the new link
     is published by tmigr_inactive_up() through the atomic RmW on
     ->migr_state.

  4) If CPUs were still walking up the active hierarchy, they could observe
     the new root earlier. In this case the ordering is enforced by an
     early initialization of the group mask and by barriers that maintain
     address dependency as explained in:

     b729cc1ec21a ("timers/migration: Fix another race between hotplug and idle entry/exit")
     de3ced72a792 ("timers/migration: Enforce group initialization visibility to tree walkers")

  5) Timers are propagated by a chain of group locking from the bottom to
     the top. And while doing so, the tree also propagates groups links
     and initialization. Therefore remote expiration, which also relies
     on group locking, will observe those links and initialization while
     holding the root lock before walking the tree remotely and update
     remote timers. This is especially important for migrators in the
     active hierarchy that may observe the new root early.

Therefore the locking is unnecessary at initialization. If anything, it
just brings confusion. Remove it.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251024132536.39841-3-frederic@kernel.org
---
 kernel/time/timer_migration.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 1e371f1fdc86c..5f8aef94ca0f7 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1573,9 +1573,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 {
 	struct tmigr_walk data;
 
-	raw_spin_lock_irq(&child->lock);
-	raw_spin_lock_nested(&parent->lock, SINGLE_DEPTH_NESTING);
-
 	if (activate) {
 		/*
 		 * @child is the old top and @parent the new one. In this
@@ -1596,9 +1593,6 @@ static void tmigr_connect_child_parent(struct tmigr_group *child,
 	 */
 	smp_store_release(&child->parent, parent);
 
-	raw_spin_unlock(&parent->lock);
-	raw_spin_unlock_irq(&child->lock);
-
 	trace_tmigr_connect_child_parent(child);
 
 	if (!activate)
@@ -1695,13 +1689,9 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		if (i == 0) {
 			struct tmigr_cpu *tmc = per_cpu_ptr(&tmigr_cpu, cpu);
 
-			raw_spin_lock_irq(&group->lock);
-
 			tmc->tmgroup = group;
 			tmc->groupmask = BIT(group->num_children++);
 
-			raw_spin_unlock_irq(&group->lock);
-
 			trace_tmigr_connect_cpu_parent(tmc);
 
 			/* There are no children that need to be connected */
-- 
2.53.0


