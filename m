Return-Path: <stable+bounces-230288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iJ61GWGow2nAtAQAu9opvQ
	(envelope-from <stable+bounces-230288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD12322059
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA18B3050EC2
	for <lists+stable@lfdr.de>; Wed, 25 Mar 2026 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003EE2E8B6B;
	Wed, 25 Mar 2026 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Mui85wPY"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E22A34E746
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774430298; cv=fail; b=ucxBRSK35CidXPzuhO1tOS7EAoTYJd9VYCu6bg5+Dq4gACgCLifcZxJGs6o9pddb1wWmGj9aG5jKs+YNbnNUXwJvMHkCxORN9EPUZ6o/b8YXEWCt6uxtOruOkfwCsPxNwKVatWt1bnk2gzoaPtTaZ2awzqfLPQbyH8jmsyfKFHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774430298; c=relaxed/simple;
	bh=MZV/VNfJbRFbfSCLeT/IFmimseIWkacOXfdIqV8wIJQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YbX+Hh6mvEgQDSs0LyU5npYPwr2HKfvgMJHC/tHji1I7ckNh8H6LMeGdew/4rg99Th7FTyok238d/QY8QcsUfm+JxZhGnDNKzmIQnGuTVWKfKSG0lu+1/p2ItUdeJNN3G1IXl8whh0k8jilMTBgHlDv7BYE9CQVh6637smMbf6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=fail smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Mui85wPY; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62P65la92107281
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=PPS06212021;
	 bh=k5ztbL637xv3iU7YJyWSzjHfLtcsNT+7Wk5twGIuLIw=; b=Mui85wPYEZdt
	sRwV59sLr1fYh2h+Ng99hQ6gb0xlxk5X0BpwXTYalo0/7p662QbzL9iTPOGuuXGV
	8i2m5/yhFk5Z/n31o8/cnMI+KKiQO5WijxfoBgGlIKxvYdVaVK/vq5Z5S++Wtgev
	XnWGOBTcQ1D3U+vJF1fxvTm1xThotLOeikPW+djKfk+KnRy4UEfAcLtAkUe8YoKQ
	Z1AyZ9Dz8QxoSJc7X3ItK4ZCUpfehnFk9Of3KjwRa2cf6Ez00zMjBu2Dh27xhcl/
	AXB324t5vQ/B4ciA4aAY7gN1EtZHs38YzPVFK+pobsaP95MdlORCrLN0BmUq0y4B
	5V5GBMYLHA==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010018.outbound.protection.outlook.com [40.93.198.18])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4d1ja6vr6t-3
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 25 Mar 2026 09:18:05 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YONqByAFUsayN52kLZQ4r4vOJPJY4+WxVVar4amlk03JQ4XFOlHkXHsPK7Z6QtGFaUq+mC5bwUe2UAqn/VBT07DeMliwToXpmgW8hjrRQZxk5kmXl+kqxq5I5IdrA95Tprnm/OrlHw5PHsv1x3R68Uqie7BFXOZY3MWIUQQnmuaUFwLKvRV1IdseZe4LKa4ai70/Y3MZA4rP6OobpV9KprHH2WyL6vnXHnndVBhVm7IFjEQKGArNZ2FgDigAdlpAdvdtdZO4yab0hheXecFpjUHFgzLDI6pThKvPXAQQbykVQC64sT588iEowCYlxHRAQT9bJhiOuazDB24XrV2kBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5ztbL637xv3iU7YJyWSzjHfLtcsNT+7Wk5twGIuLIw=;
 b=e1SgaRSSZtXezjeR2+XJGLQZqYmYLanm+5xjtERb9cg+O+ykiBAPLXmzVfv7gqiwNRXj8ElTMG/nSdI1EEuo8PevxbCM6/RxF4ji/Scx/qXBfMZI2mj4Slv/ByOADZcq9YSbWuxAcUCZknAW9ONs3fL53sqc18WLfLyCwCRhJAeIl3kdZKBnfdZbtqTgqaPnvfnj2DJGaRfVatHshyvXFlYfmBaaagi3fQeRTpCrwsvMv80dwzCUSk2PLl6kxKtR6plIcUf2PV3+gXtEz36SG9fkp6Z0EsZoe5LYcMTOPasxxSwpPcKdPPpUm5UluFaijjPUsPKXZ4uryWrPvRCp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by BN9PR11MB5226.namprd11.prod.outlook.com (2603:10b6:408:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 09:18:03 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 09:18:03 +0000
From: liyin.zhang.cn@windriver.com
To: stable@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: core: avoid odd length/address writes in 8D-8D-8D mode
Date: Wed, 25 Mar 2026 17:17:40 +0800
Message-Id: <20260325091740.941742-3-liyin.zhang.cn@windriver.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260325091740.941742-1-liyin.zhang.cn@windriver.com>
References: <20260325091740.941742-1-liyin.zhang.cn@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0005.TWNP295.PROD.OUTLOOK.COM (2603:1096:910:2::8)
 To CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|BN9PR11MB5226:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e121009-47a5-44df-ac90-08de8a4f6b05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J1vrdxUUmRfe3VHwoQo9XG0jV0r+0gAPXqPkmZ5mI1sy224K3bW/vxh0rFpDEj5kXTkkOwuaTiTVGg9Zzu2FQ2XbrUCRlc9Se/pdaynMLw0KGIThMGIR80gfbTGntSWFqU/SwAJBYmPUCkqYfEylax+jD7H/1u4tGfMuwy0FXKrmjh19/N7/FqtZKknL9GYP+xRePaA+iB99L1p/PvGLWv+jTVjO9cdu/H3q/MB7uc+KncVUdqw26CKpXvgjidXGh57Habm2K/R+5aQ5tjxhBOZJ6qUe3nYQHsxzH/ikXbHyrzue5iydswDUp/26UZr0TyBzOUO8bUEvwho50UmCz/njGCjyEv/YXF7a5B/SSMFHmtw8Njis4ya2KROwe07MH/eAtTM/sZh8lRg9FYe1WQvIBbjLCy7b+AVn+vNrM7crv0vKjG0bJXWM783sSl6asdB+YHg9LncvAN1tleh7Vt4+aj3JUDMjdys/56y/h601oHhwXVqkUt85JqVfONVFpoMHhIdoIKZgllyBzXqGEKNW02Ex8AZW5wP+mb1uySo2b0mEVfvpPYE+4XJxkFsXUJbsiEzHgHV55Lp0yymaMP+PD9GFnmlkmur2v561nnTQLNxW4ycoxe1xCD2SpbctatWAUDUzfuTm9gT6mR8otiFXn/9R2hztg/+Gm8pwO7Q7F63US/46OHDGssD1Fkya3oeZ8iAJYA00C1qT0F+qn06S+8m87/hCQaVE5mKcS4CLPhEy1oofM07FDfOwdsNULgkkGOtD6JvxnozEvPccMchidwZv+qbo2flMSXVT2ak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8430.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0iLqDq3i88MbWEC0dOCNasKtGHp2vAaGh2GcYWQf8aNGVlnlZca6p0B6a1x+?=
 =?us-ascii?Q?1pgpaNxKXoR0LWc70/rz6ds9b8WVSS94rihyvhDl9TsoGq40+AeEAA8V6NLK?=
 =?us-ascii?Q?7h9zMP++n3qeVIIjQWWiUEzCHn4MjlzXU9X+WkVljcvNtRlsHK9Pmwd2+SP7?=
 =?us-ascii?Q?XbotZ/TaDLax9SgTReIEt2o5FCYd0mMf45zWB9DQgVd9ONIC356UM/l5KPl5?=
 =?us-ascii?Q?LUFt5DpnQmemJbhl8csl7Nj0fKrqZSIIcuu6nuy8gKwzfdl4NkRSo1ZD9OOm?=
 =?us-ascii?Q?CPBzSjyuTuKJXK5i26Gq2gPHiAOyTFUdN5MSgt5gBYHvylssyzC4N7ZHuAXD?=
 =?us-ascii?Q?xnlLIx4VC68b34yOz6GxNP4TMNxJEsMKnm33/bIGSj9f1yF3IjG1in5yHfNJ?=
 =?us-ascii?Q?Ip3BZ4S+4f6NLzmKwmloREZ2TcBJZ468P4xuyyDI7/lAa32Y7/IfzCjAFnTy?=
 =?us-ascii?Q?7hxarwdJlII2fMui8qMgWDc5z6/Q6b7NER7oYrGFJ5ggPi1U9DMYoUCxOLxw?=
 =?us-ascii?Q?mbtHTaFgOMynORcYNPnJwGVZxq2TsWbNJ0u1VEbRXAFLUe570ALi+sIb5+ru?=
 =?us-ascii?Q?DnRsqc2KnlGvQ62SGwCz/BwwT0vNRasqTUQi4MYKuV91HZ8Z+6BFxHYC1RkC?=
 =?us-ascii?Q?OYtHqQ6ph91HcuRUSSYtYx1oocC7ZBRv1DdhnnaL1d9zU/zyM7RtAnpHE6Zb?=
 =?us-ascii?Q?Y8HgITPkb3WOrTXvGklguYIZjhjsuFoHSYiqu11npMayL+peRlmm4ry5ft19?=
 =?us-ascii?Q?XZIZaeEjdKiNd5T/G/0klpF0LPPVufH1jGIpUXD0S91Ygs4UDbeanfTT+L3p?=
 =?us-ascii?Q?vEtqZcUexTN8zVQYpE1cDaSNm/YTLrxI+ti8ROju1aVNoVe2NKpA+r4uakTL?=
 =?us-ascii?Q?Wke8DnnBNiTkxm8aRymOHtoHHMIuGfC6nSCTZZFWSGhB7i4F8H6sITuvHZp2?=
 =?us-ascii?Q?fLbYde/l/M6dY+ZCXOvYYpRmvKddCY7ZKoIz5d1DuiDA7620ttrqS5ejSE6w?=
 =?us-ascii?Q?IYZDbZ3m1czIZ4t2JBgpj2CeK3cIe1Ye3bN2Go6Juey7UEzMfvOkjIh/EhF8?=
 =?us-ascii?Q?0Qe5im5VX4tHpEXhpBUr8KfA1z892yeIbGEM1HC5/qKsZm6XaJmVg1IWVAUk?=
 =?us-ascii?Q?2sNdN1H2XUOwfRKnD0Oki5rdIHgkgas/btHVqU7BqsUF8sNPsk+meGnDoNRy?=
 =?us-ascii?Q?JoTw6E85DLzEFW+j5cTfBwJ9SymRSfq391oIYKh2D9qM0thsZy1n4lJdIr6E?=
 =?us-ascii?Q?uzAW5lc2j9UIU6RfBOFBDXP0vP6fpDjmXu9WVtrqULETWKA7ZbIcsH31kKFA?=
 =?us-ascii?Q?Zj9dxUq7WPotV8YERqpkgmo7rEXC0g0CtrDOLNq9ISu9ZtvxuXS/zse7tN3h?=
 =?us-ascii?Q?K5w+mlQshQwzhWaIxK7i3WD9yu0Lpy0CG8IfruLy3H0/JZHRxpB/ZooUPNAB?=
 =?us-ascii?Q?ws17TjQhyyfBGUmFI4gr0CT5QYbpPcwKA9WPsQHnpfir1yu5AFRjXtBbkCkQ?=
 =?us-ascii?Q?DHody1IqfozAPTdkOWaqvWlnCVLC48ImAg4kmBHlcNvP7XW6RLvo1x6kLeHH?=
 =?us-ascii?Q?f+akwDOjS/fnmPbEEhTV5uUzgrlw1xQp9NROFVwmUl/aWrgvaXUylwxtW2au?=
 =?us-ascii?Q?dLcdgmiZnxBo3kbO1RAiTWTSNwgAcOLlDqpn+USUDtNNumChL9isyIEQAlrK?=
 =?us-ascii?Q?bE04J53RAXoKxKPYnkk7llrvmEX/GjwDwtFQsDH0I3XO02luId0P7FnhnbUN?=
 =?us-ascii?Q?v9/pqy94aySQ6KNr68YkitcMTk5Vzjc=3D?=
X-Exchange-RoutingPolicyChecked:
	djbk1weKBykVsNYCE/uxyLebJdJMWwrjSs4oEE1rM3mJMYNMoB6AXHop9eu+yrYd1kmtgUWzebE2IixZNsLL2ryRrMvOLIz5FkDQQn1tasjp9hC6qKoVypuiM5aTRoCkLK/nfjTzgaz3wnTuc1cWDwtf07xC+eRYacNg6ItNBWm5pm8rMI1cy1L8wLg40igGyVu+j0AD7gDSL4n23Ht3tTnvvKKC4FnBvuhEElKROUL7hRZE7FTuigtLqj0NX0pWb+5oIVw+PzZfgPSqeUFijI109WK3u46NWMXwpR7OaKjyj9b8ZcQY3XvExgx48YrN1JMavTnyX769X26yrCu3/A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e121009-47a5-44df-ac90-08de8a4f6b05
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:18:03.6981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FGYcobENvkSl1lF4tzdXy65r5np6wNakdKSwN1pp/zaLEoIcoqi74xN+3bbABSab6EhujkhuFhEq8p9255t/IDuxnNYtQFBpWTpassRNwV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5226
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDA2NSBTYWx0ZWRfX82E4rlOfYJh4
 pHhP7yMUnFqZAvmdhseHY0nsf0oMx4+jffDOxPg0vDJdzyvod92tjLLpKVzTO0jkdpxlE7K38Dh
 9H0eQg6UdGZmNum8matyMnuZqKWGt2rm8OlHxMNR0prGlqQ/iOat8aLXa/hgGiN3lnq4j251kmt
 rraiQLfCAWWumE5b8od+RFSOy0sy82yTi9TDOzVtnGP/W43PJKsevZ6vkbvw+i9jeqGUISf97O/
 qwwPGyPAE3/S8G3hABrdBlvM0ch25TbnxWRNLDW3cDTO3exBPeTVFJ2+x0IgXhJ5szgnPWWKzJ9
 wOepwcZb2qTUQlndKKGqol0d8hZwA9nxkHWQ40pJG3MY1JmJu1KZaS1MJAjCdWW7ZuBcNuGrI08
 vsh8T46vKiND8MGTDoqkfEkyKTwX4+hv8OKQ0pNJSEEriZglseKPR7rwB1hQeYMxXQF2vLOazdZ
 blCke2uhUSEi6vuhfhA==
X-Authority-Analysis: v=2.4 cv=Q5vfIo2a c=1 sm=1 tr=0 ts=69c3a84d cx=c_pps
 a=TKURuYQIacZDyiG+Utq8vw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=fTW__CHxibyLmBMfj2wP:22 a=VwQbUJbxAAAA:8
 a=8AirrxEcAAAA:8 a=sozttTNsAAAA:8 a=t7CeM3EgAAAA:8 a=JIpqKkT3xelr4lRRA5MA:9
 a=ST-jHhOKWsTCqRlWije3:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: aS6psr84kS6VFD4FTtugtrEzOpxXMu21
X-Proofpoint-GUID: aS6psr84kS6VFD4FTtugtrEzOpxXMu21
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603250065
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230288-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	FROM_NO_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liyin.zhang.cn@windriver.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nxp.com:email,windriver.com:dkim,windriver.com:email,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2AD12322059
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Pratyush Yadav <p.yadav@ti.com>

[ Upstream commit 17926cd770ec837ed27d9856cf07f2da8dda4131 ]

On Octal DTR capable flashes like Micron Xcella the writes cannot start
or end at an odd address in Octal DTR mode. Extra 0xff bytes need to be
appended or prepended to make sure the start address and end address are
even. 0xff is used because on NOR flashes a program operation can only
flip bits from 1 to 0, not the other way round. 0 to 1 flip needs to
happen via erases.

Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
Reviewed-by: Michael Walle <michael@walle.cc>
Signed-off-by: Luke Wang <ziniu.wang_1@nxp.com>
Signed-off-by: Pratyush Yadav <pratyush@kernel.org>
Link: https://lore.kernel.org/r/20250708091646.292-2-ziniu.wang_1@nxp.com
Signed-off-by: Liyin Zhang <liyin.zhang.cn@windriver.com>
---
 drivers/mtd/spi-nor/core.c | 69 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 9937cf3d59a4..6e135581ec62 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2198,6 +2198,68 @@ static int spi_nor_read(struct mtd_info *mtd, loff_t from, size_t len,
 	return ret;
 }
 
+/*
+ * On Octal DTR capable flashes, writes cannot start or end at an odd address
+ * in Octal DTR mode. Extra 0xff bytes need to be appended or prepended to
+ * make sure the start address and end address are even. 0xff is used because
+ * on NOR flashes a program operation can only flip bits from 1 to 0, not the
+ * other way round. 0 to 1 flip needs to happen via erases.
+ */
+static int spi_nor_octal_dtr_write(struct spi_nor *nor, loff_t to, size_t len,
+				   const u8 *buf)
+{
+	u8 *tmp_buf;
+	size_t bytes_written;
+	loff_t start, end;
+	int ret;
+
+	if (IS_ALIGNED(to, 2) && IS_ALIGNED(len, 2))
+		return spi_nor_write_data(nor, to, len, buf);
+
+	tmp_buf = kmalloc(nor->params->page_size, GFP_KERNEL);
+	if (!tmp_buf)
+		return -ENOMEM;
+
+	memset(tmp_buf, 0xff, nor->params->page_size);
+
+	start = round_down(to, 2);
+	end = round_up(to + len, 2);
+
+	memcpy(tmp_buf + (to - start), buf, len);
+
+	ret = spi_nor_write_data(nor, start, end - start, tmp_buf);
+	if (ret == 0) {
+		ret = -EIO;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	/*
+	 * More bytes are written than actually requested, but that number can't
+	 * be reported to the calling function or it will confuse its
+	 * calculations. Calculate how many of the _requested_ bytes were
+	 * written.
+	 */
+	bytes_written = ret;
+
+	if (to != start)
+		ret -= to - start;
+
+	/*
+	 * Only account for extra bytes at the end if they were actually
+	 * written. For example, if for some reason the controller could only
+	 * complete a partial write then the adjustment for the extra bytes at
+	 * the end is not needed.
+	 */
+	if (start + bytes_written == end)
+		ret -= end - (to + len);
+
+out:
+	kfree(tmp_buf);
+	return ret;
+}
+
 /*
  * Write an address range to the nor chip.  Data must be written in
  * FLASH_PAGESIZE chunks.  The address range may be any size provided
@@ -2248,7 +2310,12 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
 			goto write_err;
 		}
 
-		ret = spi_nor_write_data(nor, addr, page_remain, buf + i);
+		if (nor->write_proto == SNOR_PROTO_8_8_8_DTR)
+			ret = spi_nor_octal_dtr_write(nor, addr, page_remain,
+						      buf + i);
+		else
+			ret = spi_nor_write_data(nor, addr, page_remain,
+						 buf + i);
 		spi_nor_unlock_device(nor);
 		if (ret < 0)
 			goto write_err;
-- 
2.34.1


