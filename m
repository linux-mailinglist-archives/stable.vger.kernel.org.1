Return-Path: <stable+bounces-227746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBV3ES9yvmmYPwMAu9opvQ
	(envelope-from <stable+bounces-227746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:25:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A90292E4B97
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 482B2301C3EC
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5AA2ED16D;
	Sat, 21 Mar 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="U5nrTOi1"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67DD2BD11;
	Sat, 21 Mar 2026 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088728; cv=fail; b=iYtEWu0KAv/q1znPSjVDJS1AhBnheIU68xQgR4zhYLYzrqDGX1mUb8PlYjugYapVc1s+NnRgIXKnI8fnfTVh09jpOnFZCejZ8EUm3TiUPWnJOYnVjciMYvmiev5P+dYvJL+OR/u2SsfPgCWFxTQpw/VKhQYJzBLabf3yIsV7k2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088728; c=relaxed/simple;
	bh=2T2/MqaYUq9EYC5/4tKmixmV6wIGhG5QLHUS6zJfb7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KUd48TJopCxREV2TApyV2YbsgcRpt/tY5j+7tb6pzTeWL4gx++MpZTiS2EOWs1s3EmpGCQq7iXYK7CfAD9T+Ivcz4WEVr6K9O6DbHfpXxcy1ai9enp4EKC7K4rZQlfgVxUBrL4S7LQSpzuMF4R/6D8pRhYnIi3YWMjG2lyMMzYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=U5nrTOi1; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62L9uBOL3678324;
	Sat, 21 Mar 2026 03:25:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=YcrZsIvL4ra4968KR0iwTmP0GMV62rbUJRzSptB49G0=; b=
	U5nrTOi1GdBMXA+HYqgpielVq4J0CbEVC5NlcDPXrzg5faeidgscgAxSRwnPIzOO
	C65mRh/IXZ299ZfRKcJhMis9Va1iAmiFr/w6HGGpuyrStxR8frxGCBA02xXxQYmO
	IEHji8LIMEexMYqz8ALDZjqXzZaOV+7yb6uyC9twXSa/mdJrhrKYkFDvr1b96PxJ
	UlZgtvLI+2fT6S5tqdHfB/1uKobhtMYMIwS7Dr1pL5NnR899y2TRbIlVRlvmUFVS
	YTGYlwyvEg28Rc9QkSR1Wg6Kb1vKjuPU3ref249H8LLVieP1UTzk8GsaR7mWMnkq
	LeU0On5F930lxiku7jIlFg==
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggv7v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=feMKf5rPXRBcpRIGHH2aPE4wMfJRsBErPboOSQp9/UF6rjZtPzsrjR+/FkcEFZmWYtIti2AJvAOHcHB6pE1qprIDNwvBjDZwzK7HaA8ZjXWSy8uw3jKeaF6WFqwm2fevHjWKu5h/K8YgVnJx/PKUOsxSw0XSFyKlqFSVHWvIPcSF4b2891ubCdXp/NRzX9Y03wvftSJhHl4uj+2TyeT2G5TbzN44xE72HOAl/4cCt3Zj27jwOmLEVOUKAz6QjSTGYq4l+sVBe+2iFutEIZKw6yDwzz0Y+9yzgmFi7Hs50WnO13oYL0W0dGwV2jrtEpkysdv+hTy9q4bJabHeu6Cdug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcrZsIvL4ra4968KR0iwTmP0GMV62rbUJRzSptB49G0=;
 b=foKZExZXQPwusaf28vpiP55vKjSogcHmZ8qmrV5qOAiIoKjapkBdtkLfWSizUr8Hgl0nCdZVsDbjsl1fBC2m1xGdHxaGz9u1aee/X0DQv2E9E94HxgegcdWQk3Df3LDiZiRCszkRpgaciz6mj+Rolqe6Re8Im7kd4Z5ONl259MfoH5CT4+Gtzt5pejxqMzI2Ms1x3OJnbTEM1evXH86iqzjB6/d4eLY2WJ0O9fsOU5sjf6SMKZnqdhV7ZbNAA06dWfvtDRmMvILQIU6IrrT2oG4j3+Z9SNxWlpkQEmQ45uScmhS2e+sWdnIuVySR9H4wk72SQqrar99+l0x06p+XGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:25:05 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:25:05 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        Ionut Nechita <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 3/7] timers/migration: Simplify top level detection on group setup
Date: Sat, 21 Mar 2026 12:24:36 +0200
Message-ID: <20260321102440.27782-4-ionut.nechita@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: fd594ac1-db9a-4310-9224-08de87341e8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	AD/tM2uchFANRqkf4wHi7hSXRrpoONtlfBnCtNZdSu+a2OFRayyndbdBJwmFeC2hY3lEYA493+Qc1XEUtLvunOVf8ziaL8RIi7lifyQmuiNJHUhm1ROmyDtjPCgOjhG0NobT+7VRD/c78o31Nvb8c5gxe7lRVq5xiEycJEhOrbu+nNbFkrmuO5/3+RP276Ad2c0L5csKgumA5mY6bgLvarZIeIw5tdhgMqpbQ/SAbD/w0be3H+E70ZaZJaobloiIA6vzTBg8z7s5JZ+XmVqF7rb/5CKp+kfi0ASOjju/IoeAKGX4qQMXYlt6yc/GaMFO4c8xlrcwwX8li1IBeCT9iCi5mtPc3karQwyY/Nv/Pm6vTcziVToawLTCI/akjCHwcMgoayYq88pf1qbzlF/d47MFn2JiLp+h4ysL3vsOjW9UrUd+xcWKlrgPEPwfbR2zFPq00nfgnGdrq+n2eE6+bb14SsvG/X/9r/cH+Ss9yMWdvr8/9e6fShehsfiSwyzkwD+X9NIzrTmWQ2Spn3Uq5P+kzvji1GCFJqX9RWx98pYoOBaPZ6xLWYmCbm9+nypoBTUGnHd0k5mUuR8yEP0XVggyiNS4VdfxqKr2BLrr4VDUbYGSikD+BhlcV2rTSaXUnmvsJtUdPpTYQE1lopkkdkjDqTk0soJX6/ezSyfOw3Nd+zd8m24+CHczw7ECRth7XpASTOQj/xgZPxr1TycBJS9MUo5wfl72a6oSZF4PpoeoQdbcA8oRrG9DK4VOH9N6yVDXWO0Fnv5pr2WOrpOKKuNNDGismJV/ihHOrpQvBVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?o5Kq7NdxiWNod2fFSocJl5JEUqNfJ8BYEVOj7chHUHTJwXkmGawFcinzhZh3?=
 =?us-ascii?Q?3y21kXzPcUMSwA4ZJ7NGp70GCSgpaWzdJds0CBkFRVRv1sBqyLQjSssUX/O2?=
 =?us-ascii?Q?CFf8tge2CoTltrLygqEWDqBOrIqaLoQJl/MoDgGiZvWjK4HICDYhSmnOezsL?=
 =?us-ascii?Q?cLY0idkjaBJIC7F+d5M+4P/1Y6Zbg6cQRqQwg32tAsYoSoiv+dnXXjhs2JtV?=
 =?us-ascii?Q?pANJ4g3cOYmv3CUOs+fSFAAbc266IX3CLG2hXC5xmhlfqCCnAlLB/SbDMNCz?=
 =?us-ascii?Q?4YmRMHABDp8bUbKC153Ak+GNnVSoygPyefr3XdpmwFqX0nEq3ywE9xISHSwV?=
 =?us-ascii?Q?0w30AiYcY/xz3AlqnkSX59nBnbBaPYrDgY+YayJZl3QxyRWc6Na2RKKqhzsd?=
 =?us-ascii?Q?dJx1VbmS8mWvC/I6rAfL7/GOOp340r+MrjBOiDp6aMTiP2EtoO2+Xul5Erfx?=
 =?us-ascii?Q?WmbF2clRhFZ5UneUk9s8me+I88Ewk+EGlwWeXzERlsDKzRbfevAFIGmwz6Ua?=
 =?us-ascii?Q?Ftn8mVjRdiOS7iQrUzkURtsA0Vpps3wXehEBwY4b6LZvZN9YljtwTgvNVr7+?=
 =?us-ascii?Q?B03O6GlbenRH+bpuoxng3JzkMv1zLNsiSEu0i6DhLlmeTGrEhEAthPLMIku2?=
 =?us-ascii?Q?eYt/lOR6HsNMDS2BVoALLW1D1hN4XCfnxveqDmMfjqwE+BvSFrpbT0E+f70M?=
 =?us-ascii?Q?cfJyBYD6TY3FwoQemao7a3EFGeSyHPi+HHDecWou2iiWB9JEyH9mmvyYozDi?=
 =?us-ascii?Q?UGfetbvqsSR1ZxZ3re3NkZgSCjtYJEOOzLcEXDdbySeyK78Dz69ru4XAPvc8?=
 =?us-ascii?Q?LkgiqzRMs8i8SKlP+hYBN3SmGNu23IFzG5bUur6Y2uqwhCj2QYV+GPJUeRrQ?=
 =?us-ascii?Q?h/aUbExhYEE3TZbgb7CIGgt4E0N11QC6s6x6JihS2yFMjmHZ9ToZlMN8g751?=
 =?us-ascii?Q?eRGO92bWrTLeqEscDXf5eYUFf3LCQEzbe/h7BqzBwV0L1AWx7EzYbHFvA8QS?=
 =?us-ascii?Q?JEpfEYOXMUyaMZxYYEamcP4wORRqLhV9GK+O+JX5nqa/NY/8RAA2Q0oyeUJB?=
 =?us-ascii?Q?SK7B38zvWLSMLth2kz7wgsHKWx1ahJXPkA+KuzdkGznsyp2NQ6YKqd+PpMIV?=
 =?us-ascii?Q?+BRhfvi9CTkAnumiIVxfbxvSV2+BEz/g+bIOkHSVGvfD/PMlpQRTcJgSEibI?=
 =?us-ascii?Q?ZU+3VtuAjhzKPuK0bVMMbZDcYmDFCbiMKQt/fnA674LXGzjr6BOSqqmBGNlz?=
 =?us-ascii?Q?Aq9QgwqYA1OUNa7iBvbnmE6yMg1kpujX9urFhgBYuSeSSr6r1M1oodQRN1kO?=
 =?us-ascii?Q?yzg2jgWNdu81bJHgroutW0XMRS4nWu/ZatKHgN0mBbMe8XAfNzMAl2wspkmk?=
 =?us-ascii?Q?3K1ei1EabamBJL4zNYkROmUZCEdVYQoUN5B+4PnWNcNpXwX3uAxe0KXg0IUj?=
 =?us-ascii?Q?D9vzO3fFA1VXSG+R7q6Qu3W6JTpPgVDi+pzaQBscEg6pyH5nDqD6rmNp+OrE?=
 =?us-ascii?Q?Hb/IoNcpHO0eK+kPXB8hVftd8RRr5lqGn+T24ks+ty2b+H9ns9gZR8MAAgET?=
 =?us-ascii?Q?hXwKzEMZANhf3c/9hPScSJGHxq5EadSjiAmxZGuzRrDjc7scVViXF6utMX5V?=
 =?us-ascii?Q?myfQOspTB2dkNEIITuFEQWBYcs8j6EVVrklbbIXmg2Y24lrC0++BARj3Xjhv?=
 =?us-ascii?Q?qasnay1U7gbToG2co4JmWP77TEDdUHCnmF6Ha4kcoLsrf36gpr6cosJkoVwl?=
 =?us-ascii?Q?FxiDi0KmPuD+2ausa9d6IFz5XHvV/0c=3D?=
X-Exchange-RoutingPolicyChecked:
	OFLnlC+6n0nLzaDMFLQFzsEUq3OKwD23YdOaAwijRq+PznwoNJ6QeX9cpr1wadxJLzwaaqW3eL8XFmwn4CosTDlAkmHT1mkvueH0jltK5A1pDDfCf5k+RrnmDkN3OlHyysZ3Es+ds5j1iSzjDnR1qhrvtjw7E1h/hydU0T7sILZDZK0kKbRF8j9DZRqvU3G8khUu2jDpsYnL/89JY5Cu/8qyUV68VO40jdwrxlq88OS3sV6DdjhFfv/3g30eevz6LzTMU20YibReBhnqnGYtUYdniy4rfqe2Y4DKn4jmL/NQlitt2w2Bmb8rLvLTQsow6LV28sHxM2s5NusTn5HArQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd594ac1-db9a-4310-9224-08de87341e8a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:25:05.6702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W5ja6lQibp0/e/SksNyjYLBtg7j589J849QJW8yP/8b01dRTxfU7KwMUUWSfPv9zrUiZe4S+Dlx/RdzYigjV8oevuaarm/AIpFz7xqWCmbY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-ORIG-GUID: 2FNWo0M8VH6V5VQe02AojAYVGPVjznZj
X-Proofpoint-GUID: 2FNWo0M8VH6V5VQe02AojAYVGPVjznZj
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be7204 cx=c_pps
 a=kRgXGWC4h8N5Zk8PQP6WEw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=a_7miW0GuXv1hvqcwZwA:9 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX3FZPLUa7ANko
 Jc8zQKOcYXIEogucmGSldv2Czy3H/VOn3/OUauHUVOXi4xbHF0xKQn8a/796pm7nzXHaVQ2pNQM
 4du2mEPj+U6JvKLGXE8TCSEVZRQLKpQl2EQhvOj7OhZAKWgbGer8+dFLQ9psAftJmh3xpwYnN/o
 9m+IM2xSrXleKYis4HwYHQ/K0+W8F/n7Jqyim+P5YrRUQUkLkvACgBN38J5lK5yuGhSogpe6aQZ
 9oJAvnlAIppTojYC9DGjZdN1aJ5y16Ju9fdrUODv2+I5SESPqIhFh2BR3Te2bCHMELLcBq0fuWz
 XyMFqWL2273k6ZYMiFbX1lHM51Jkq/E611DmPTYWeFwEli8GDp4HiHKGowkXwKDa/MlL7b755Dd
 RIFMaHIZ8UPSG4CgXseQxsHdY+ywzA2zSAl1pIBaBCgCcShrHUM1eQvXd7AaYW14iFnOKcSizxr
 EI4Kc62zFAsUF0WmTdQ==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227746-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:email,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A90292E4B97
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

From: Frederic Weisbecker <frederic@kernel.org>

commit dcf6230555dcd0b05e8d2dd5b128dcc4b6fc04ef upstream.

Having a single group on a given level is enough to know this is the
top level, because a root has to have at least two children, unless that
root is the only group and the children are actual CPUs.

Simplify the test in tmigr_setup_groups() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250114231507.21672-5-frederic@kernel.org
---
 kernel/time/timer_migration.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/time/timer_migration.c b/kernel/time/timer_migration.c
index 0707f1ef05f7e..2f6330831f084 100644
--- a/kernel/time/timer_migration.c
+++ b/kernel/time/timer_migration.c
@@ -1670,9 +1670,7 @@ static int tmigr_setup_groups(unsigned int cpu, unsigned int node)
 		 * be different from tmigr_hierarchy_levels, contains only a
 		 * single group.
 		 */
-		if (group->parent || i == tmigr_hierarchy_levels ||
-		    (list_empty(&tmigr_level_list[i]) &&
-		     list_is_singular(&tmigr_level_list[i - 1])))
+		if (group->parent || list_is_singular(&tmigr_level_list[i - 1]))
 			break;
 
 	} while (i < tmigr_hierarchy_levels);
-- 
2.53.0


