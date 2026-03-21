Return-Path: <stable+bounces-227748-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLsiJFlyvmmGPwMAu9opvQ
	(envelope-from <stable+bounces-227748-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:26:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED80E2E4BB8
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 11:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F8353038ACB
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E2D3128B0;
	Sat, 21 Mar 2026 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="nByYPr2K"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68C218A6D4;
	Sat, 21 Mar 2026 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774088730; cv=fail; b=fTQJNXIYVOEdofF5pyrNrAcdw2fQ7+LO7wVec6e3GQsU8HUqe0zEFX72Cw2JGL2M+nE77hp8pP/MQPB88fBv2mpwcT8G84NtZVdf08YHu6HYL0tJja8yae4cdssGDJVLknCK8YJ0i29asz3z7x7mFX1mnzS3D5LXAUGeWi56zis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774088730; c=relaxed/simple;
	bh=URRdEekukjX0spxDEpSwnTEsc5gDmhOuOTNsAq5AeHc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oIEWG9gvAAdz49wIjZm8vMwFion/QOqYkPBd4G7Ifns69Hfnd7xgSXI/xIC9PcnG1Jd+IjiLGCU0NqakVexLneNZ82yEmSxdL0HsH/ZMZebTAdBSqVvquTs0DsWZlEG2T4Gyt6k70Q7rFL5BW1GN7E1i3l7kdLnptr/b9mCaL/0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=nByYPr2K; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62LAK2Q13719413;
	Sat, 21 Mar 2026 03:24:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=HeYQvyeAS
	96+ndYum3G+cZwE1+qBd+8F70+nZs2mrlw=; b=nByYPr2KxZvsFFVVPcC4JYlIh
	gEomybr5FKo8ubALaEs6EgtdI0JQbQbi8T7FFXzCP1ziVdtlqdd7/4VoOqjtbI47
	ydhDZw+SkUXgkDkWXo+h9NorizZJnsUWXDJOO7e18Rts8X5FgEa1azPsN2aBMdLE
	wJMHm/+vCUn44POr7jy3tvjuXCVAAzn4DY6AFvTXcx0M/rgUjJzjkG5XWTlNLVe3
	kdzvuidHzG6MIwzgd/S16yug6Yyhzd2Gw97KQIYfVPVNo2xNNHyV9y6suaIxEoSO
	toVUr5tQvbkLa1i/jBAvWU59BlYohLGLa83t+f77PYBgkc93FZNx4qPTuQ4xw==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d18uggv7m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 21 Mar 2026 03:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cONIB/VnYUYuMRoVZEzVb9ahSPxZsFWNI3pjyNKpD7wZ26sHWppvHINkYwb6BldLO1cJjLCKg9RoAMdTiHKCxmjTKCvSAc6ah4zOVg3VeBDje3kdUrtxo8omCF8K/UWNsGc69kd1M5XxUC1OTMgMNEGRZOS05vG2tMgDi8QBd01byQVBhGdHvxhAABjkdtOYJmn57Iko+aNCB7UyWq8WBU/rrzyxFclvTMlqaFkjlVNJLLiAAhSBQHuuMV6I6l4Us+7cQ7ksaeLtT1N+A80yZ3IrNJrjcWiB3BkKcgTuz81w61wq4P3dTZNvZCqWMmeupWmJftaaWasbVlN5f7Ea/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HeYQvyeAS96+ndYum3G+cZwE1+qBd+8F70+nZs2mrlw=;
 b=i2K+l5ybpqKCgRJLYojklV2qdRE7qLiXRhaDlFNvL4OG8Dh98/qARSIQpiCdsbwcJEOUpZTfUOnmHnGEttAymj60CA4tHIxrWajOPJfwx8k1wx4yI/TkCBc301g1HgdquQBb7HIRmOVd+ltPBvqyBGMUu52fzCbxC6p9+xEi1gebYyvmKfrPWDDCcy7OoSqSNpdChuFb1Q53JbdXEA0IcgfO6Wbrmyjyx/NalTFiqVILcoCM/M14t6n9TXOxxIguePyux5OkKacBIn7rqsZy63gN1xqobb0nDDIsjPuc9Qsyu5iQM8qfaP+A96Y5XDG3A5ZgYzKWz/Wd0RpY3L3cYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by LV1PR11MB8850.namprd11.prod.outlook.com (2603:10b6:408:2b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Sat, 21 Mar
 2026 10:24:56 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.012; Sat, 21 Mar 2026
 10:24:55 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: stable@vger.kernel.org
Cc: frederic@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org, ptesarik@suse.com,
        "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Subject: [PATCH v2 6.12.y 0/7] timers/migration: Backport fixes and cleanups from mainline
Date: Sat, 21 Mar 2026 12:24:33 +0200
Message-ID: <20260321102440.27782-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
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
X-MS-Office365-Filtering-Correlation-Id: 3cbd3131-2bc6-41d7-204f-08de8734189c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	7e3P6aR1CqL1Cl8NnycwVIgjCCuLSh85PYsGtrSwiciSJ5fyBwukCY5/5IMVgHS2rNQtaNlPBRZmI9414JXc6HgIBRxSjvWUoXOzMZ/kgdHsx7+/DkKZ3i9VxOaQc5cmdd6BTU3cbX2+S2c5M8RUSlGQcLehQ5khvM9WEKiLD2hEj7a4C6Pi7JL3JddOr51Z/qkJCS8t6MxifWPgeFSdy4rpwkNKvLvL4SIfqMatuaWl/OTtYwPSLctliBcfoNhClXozCUZJssntju0qI+wm/56rRylMh70bIAVSR/a1nHiBh8+EZ7LolpnKECN4GOe52gpD6JAhq/R9hzXzWbvfbFzDTGNJ6gK2InbcL/PpOYSO403Xk+1A7fDYWe2q/nR9PZjZxkBzo9gZtmB5fmvMyswGwGjfp7+XVE/uBa01uKwu/9IE7V8Ff4uLbDuAlqdFjhYNH8uyYjEohwNC3uiH0j0Rx0gUCoWl+110hQ/FzUOdq5jgCdM2FSMLDbQqLvhsMqPFnbZj0DVqPtDld/c7i7xBUb3zcWRZ3WShWBfI520ZuVB519Bc5u9rOZ3KOUFEuGbJ1mk3RXQZ8mIxrq6flykC2ME1sslG4Fof60KyrIxBqp+UlE0qjliBmqMeC+AXD1ABL2Cq2yfibevWkGCnlU5FA+AWiOy7/VTOA/QFgrwVIk/vmuNwj81xfnFVrgI2zY3hOyaV9Jy5rEmAuTL3YN3S1JlZ3Y3RA266WF2ybpeJb0VK7ioOWAzoebgCM/GSc2+O6zOStqzoJTu7B2XBai5TYlCWa0szcnSv3p1C1M0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4HnVnLTKSdGAbUA4BCMEUz4sVrJ2HtxzBR1532ANHu3Cp6FGBGtIuA4sozPI?=
 =?us-ascii?Q?YWmFevkkTMkmFw6F+Gif/gbSok/CkQqBV0Shv9Jp7XXGzJgRb+uqSZF7HZy2?=
 =?us-ascii?Q?hqPRrO/FTFhnwOoII14D7m4PeaXRe8DEc4hqoaXB6O+RzqSwCFmKMF7iY4pO?=
 =?us-ascii?Q?lbpTCrnb22AdJhB+0uqRcISxeul8VeBn2ESpOmHumihjNFkxhdl+UNCNhnNC?=
 =?us-ascii?Q?+1DU3FOVsuO1WwnnTrnFV5ZixM74qC3VRUnjLyPqPIAxCIdSF9mwk5n5bDQl?=
 =?us-ascii?Q?myue/kNI3Tjx5utucDUhHac1morsUJOYlPerZiFts903h05pj8zX+o80Zqsq?=
 =?us-ascii?Q?YLsJxgfv8/814lx9a0abwyGxXaa6NZxlXnakfnAfQ0VV8axJ1QxW9ns68a8m?=
 =?us-ascii?Q?emZ6B8xP3AaLpwByGrqwtq5SjdYPkz/MBQWRNybSmHj/npuun3KC1nauyhhE?=
 =?us-ascii?Q?mKps7B4U0bHhBB/bL6RXHwpNpD4BttLEfnj/y2GfimZeWtxtrf6hOTlmcU72?=
 =?us-ascii?Q?lZF4Yr0hGKlsh9xnSzZmJp15bet208khMNl4pCvDbCDJm/HDKL9OsugWi5oQ?=
 =?us-ascii?Q?qaEfAXETHpFEZOXCgaL1+Nr1cidL5ntJYEIk1TslkHFDabA/KN6pzvMsNutW?=
 =?us-ascii?Q?IGDoUw8iYjOzTFV+RNq872V9zOohAbVKCgVm++tKGSn5AzTEv0mYoop3ZyH4?=
 =?us-ascii?Q?0q987T8h+L8epXEw81wyHwS5t9QMSUsCfdUt5KHj/0XAzZY+iAWeDk+GOd2f?=
 =?us-ascii?Q?832vp/evNjltnsA9CtndveWoTTukUA8ozBxZCny5fUOQ/zvMjwUEm30J7+jH?=
 =?us-ascii?Q?W+sneQ17A/4uYLhKk2akQZF4+/ifuTMLAk1+Jy44TfkMw6wztLzFh6N6iWda?=
 =?us-ascii?Q?clO31kK/D9gxr67BxOIb7BVZpyqDgt63xYaPjXhJg2HH34DUCCdlKoIlUyMh?=
 =?us-ascii?Q?B5P+9N0LbUUAKedu6rzYt5nErJSwKeNKR8AozMNLxAji3TFGq9FYzb2SxRoF?=
 =?us-ascii?Q?ve5lDPq4POEUyWrkHyB/Tc4g45QC6/v9InUdBhekO/xP2WUcGVQRCSFDykpO?=
 =?us-ascii?Q?RuKOe+ChW8APxVjwQJpJ7I2DpUa6qUpylQDbT0nQpc2V3qaOzBjXnpbmhv2w?=
 =?us-ascii?Q?XMbn9PtkDCzxeCPzHXPad9mH28NrzE8+Expl2Oi8V6tfwwRU3eovhgL4C3NU?=
 =?us-ascii?Q?VRbCuoUWWNmEPop+m5cTCrqqioahWtMPSBiuTEZRLupFG4/fiTbHKOheeRZX?=
 =?us-ascii?Q?pZ/64HSkfWj2RfpG9a10G/Eiv9blQ3w23eIcG6DIm38okCAI0paqnxeCqO0D?=
 =?us-ascii?Q?A9+c+hVBcCWRuN7/dZ6y/prAteXnW7SA8qSx7+XcgCWz2I+KyRcwiSkMpwgI?=
 =?us-ascii?Q?i34hyH5TZE0adVBrZzFNAK2lNUvGbdZL58lqzoYdHfIfdIVLCjlPlCMA1RI3?=
 =?us-ascii?Q?vjU2v4Tvf4C9Jv6OZry0zCHdx35Ytd8080yagoBleqf2qQL4Qej3/dS+OVuk?=
 =?us-ascii?Q?2Nz4ormy0PubRwLQs3201eZbu4o4SKaa71JdSDwgVnOoewR6ku3J9Goyy7Ra?=
 =?us-ascii?Q?PlmDX7gsyHSEQ+dqUtdOODsHF8XBPTvad4M41ZM0pNeG8nYVAu6mS6Mh8NZX?=
 =?us-ascii?Q?Vp2L5H8VodxtiauP3Gp4rAav2SUfXST3bpmsNDSzLNYRA5f1CBnOtZ6LoCFh?=
 =?us-ascii?Q?uE24iLxoH8vq3jq0SoCW8s6y3AM6SFxItPr7H+RWTEQku/tmAyKpvYrIrCjx?=
 =?us-ascii?Q?Jtg/dnl1BEXsrlk96Gco92mEogNzLXE=3D?=
X-Exchange-RoutingPolicyChecked:
	oG5wRdz2cYZ4BbyK1ixO6gQMvGsenDt5KSfx3OST2YDOTQUjMmci18CPN7XUuA7psUVMCjKfSy0UulS1u32btyqT8NHPVRkddIbu+/rM1W/hXHEZ/MkbdH6roHjiDNTJgjiqsWBQUay6PPb2+2eZcrb0M+T71DjD2F5RmQsvOETLvI9VG5EhamkqBAIlygDr4Cy/uXy6EKNDNWJjCbW/T0QNKwkaRzHYGl0d1Uswrnum6oIR26pUU+c2UArgqFaqo/bQ84mRD44wqRgfVyZZGwfQ7NvTEOM9QeNw/upYeBm0drKdNNxqiOMY4EJb0YPJLqzMzpjKWI5ZaJqRncovjQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cbd3131-2bc6-41d7-204f-08de8734189c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2026 10:24:55.6787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mtebU+yo72lcecwhtJIAFx92mZrUoW20Wr4Lm5j5nd6VVwv542rdIgC/bAMN9SNnD6xSzdf39pl5DHH1KXGa2FGWDW86rMRQqr7u06xadXY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR11MB8850
X-Proofpoint-ORIG-GUID: cZgxHWAuJgjBp4Y-YEE7KkbFXpzxNr7u
X-Proofpoint-GUID: cZgxHWAuJgjBp4Y-YEE7KkbFXpzxNr7u
X-Authority-Analysis: v=2.4 cv=A89h/qWG c=1 sm=1 tr=0 ts=69be71fa cx=c_pps
 a=Sj0aQRr/q75bZ+qk1Z6sNA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=lhmC1fM8IaxBRRmklmMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIxMDA4NCBTYWx0ZWRfX6pp6yhQoMa7n
 SnGo4nCOuc0iaxVEVXCf1QR1IY5SLIsCpGB4EXRFcfWojEZAY8oyfOhJkrnVotP/212pKojMNOy
 /jAJEDLPRfO73+gcizXqxJrjYon1xYtjmt6KUWOZdDoPRgltXZojRQCHsdltc8uA2C4Lq6q+Jxk
 owEjTYroOkWy97hmgeVMBix998oPpdnfqQvP3hCFE4+fwR9MbvU8BnAZGaEAPXcbpQLANHKyTKs
 w+UgJYLmCt03EVO7uSXRhEL0H70UsarMV7ExAJDZ0AfnQitMsyah4AwC87J+n/piHUk/ls4iZdS
 wQi6IMAFoybyRuru39jjzz9YD0Z5SqNkDlnQupN/+LzAr4Tzf6lK6C67baQDOHNSML/3r18fytt
 Rv/Ju99F0nrJFHBWI+/j3S7LSR6kVdOHzplG2Nkekwu4VdDZZF910dx70QP+F9rVmNp/w/Xs2YT
 oyEZSjgJumHj+9bAsyA==
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
	TAGGED_FROM(0.00)[bounces-227748-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[windriver.com:dkim,windriver.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: ED80E2E4BB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series backports 7 upstream commits to the timer migration
subsystem for linux-6.12.y stable.

The most important patch is 7/7 which fixes imbalanced NUMA trees in
the timer migration hierarchy (Fixes: 7ee988770326). Patches 5/7 and
6/7 are its stable dependencies. The remaining patches are cleanups
and annotations that complete the backport.

After applying this series, kernel/time/timer_migration.c and
kernel/time/timer_migration.h match mainline exactly for these
functions.

All patches are clean cherry-picks with no conflicts.

Changes since v1:
  - Added upstream commit IDs to each patch (Greg KH)

Upstream commits:
  4477b0601471 ("timer/migration: Fix kernel-doc warnings for union tmigr_state")
  922efd298bb2 ("timers/migration: Annotate accesses to ignore flag")
  dcf6230555dc ("timers/migration: Simplify top level detection on group setup")
  ff56a3e2a861 ("timers/migration: Clean up the loop in tmigr_quick_check()")
  6c181b5667ee ("timers/migration: Convert "while" loops to use "for"")
  fa9620355d41 ("timers/migration: Remove locking on group connection")
  5eb579dfd46b ("timers/migration: Fix imbalanced NUMA trees")

Frederic Weisbecker (5):
  timers/migration: Annotate accesses to ignore flag
  timers/migration: Simplify top level detection on group setup
  timers/migration: Convert "while" loops to use "for"
  timers/migration: Remove locking on group connection
  timers/migration: Fix imbalanced NUMA trees

Petr Tesarik (1):
  timers/migration: Clean up the loop in tmigr_quick_check()

Randy Dunlap (1):
  timer/migration: Fix kernel-doc warnings for union tmigr_state

 kernel/time/timer_migration.c | 296 ++++++++++++++++++----------------
 kernel/time/timer_migration.h |  21 ++-
 2 files changed, 167 insertions(+), 150 deletions(-)

-- 
2.53.0


