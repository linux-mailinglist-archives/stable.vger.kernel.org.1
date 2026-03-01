Return-Path: <stable+bounces-222394-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA8fFS2mo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-222394-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:36:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EB81CDB8D
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEDCC3016EE9
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07298309EE9;
	Sun,  1 Mar 2026 02:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="LcPOsvmO"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EAB1F91D6
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332586; cv=fail; b=XKpwM6BQMIqzrnxEKoGxGP6DsDW3o405VvVzDRJZeYDfaQTp/NVN0hrPCLNV8sZOzOVs785ntm1Elr7VEORs9BV1BauYQeDfg3zWYCAGHjvljIJByNldq/fHFtNxPAbTtV1BEhqEhRR3df+1bRtSDn6fPFeVThZBtK/E4xM7//Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332586; c=relaxed/simple;
	bh=uSe7xRdeOkqYyZV9tDAO8Zyeg0tgEE/Xc73uObjJv0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r49eubAPw+A0FfNVEn6Xl/yiAYiAaXKCTeVX7VnJ+CDjHaqGvTMiVnIBaUUlcyOcmo3m3hIWULkcZuTKFfFuWutWdYdiC5sb5lx4AfVfPUKcrvINfzwt1xEnIYPnjLju5N59BTmcFryxNr7Owj+l/JskTZg29CARGeNLXjjhMVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=LcPOsvmO; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6212U0lk3013380;
	Sat, 28 Feb 2026 18:35:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=BYAOpMQb42jlrMQrnd6CjokVsZVROa6DkbBiFbsq4bI=; b=
	LcPOsvmOxdvVsnLi5ZNC1tqF7G+NvF45/oAEZqVx4rLCqDSg6sv8igVqrtQn/dXF
	/JZQPOZq0AGX//aIYK75cN/VO08qE5u3iKkpdrjAa+fznQjz6QDH5Vf4idhf9tPb
	laRkxiNMfmqNeXijya5oJ0YmPDZy2TEAU8L61dw7/a6nUa3M4gWD3RUp/mNqHY+A
	DGXQROZH7Inkzf6jnqZBe5uED+9xLUO9858DZ8BCsh2hylHNutFJ1CTQ7XAnm095
	SQHRfE1oM9v9cO73cHqzXpihkHTt2Yx3tdLz+Dfn+0EzbdWTNLnX4vkq8a+zqTtB
	T0vzo42HdlQdl7+UGe3sRw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010011.outbound.protection.outlook.com [52.101.193.11])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cm0rggn40-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sat, 28 Feb 2026 18:35:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQ9cHWKW+Bq8/6qr1gPYHRN1otQjO3tRnfpzADVkp/Qw638x7UwrQhwtgvTK/cbi4kmBxbp+QA9toKuc3DBPyOfgy2pOL3KD8GeJCSlRoiS+3YVvixB51E+uS1iKe9kesvD4e+tHHJhkyvh1+QpIi0VCA5Oz8ueVFd441rWIURIq+7r1VB94f/MVYRKbbVYA+9Ng/HZh74QJfbcqVh8oPkNbziN6mF3bBqs+kTjGemJ25sVKm4KpO3Xg40NoOU4WKb51jmDI3ic1ZxSDpZ5dLa+35VDGg1v/VfIasDdYVFfKd7+ynSLZHT6BXUcaL5PH/t+6umOrQe6ViiBPs/EWhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BYAOpMQb42jlrMQrnd6CjokVsZVROa6DkbBiFbsq4bI=;
 b=bDozcoFDFeh9aaHpmwBPfUOLmXBP3KfCKWve8hyDl9fzHZV9yabKWQf3FbO4NQndjPk5SmBAwgyCzCLOa89i7kwcUGBvKtVRqUXFR8OZaBeM10sRPznvrazX32c0ICQdbB/5XJixeu9AKUi/m6M2TTmfb+Xwb0ygHvHnjXKFpy6q6mdt2CPy58XcnIETfXdNAsctJt/GcCm0QAI0X28TmyK/RyZ5akCNCJx4iXGSTJslewuMWXRZhqjkkBCOkaihM/UXQ2WiclR9WV5sJ+HrokU3BAK5cNRXFz5geT+o3ZCg9wIxC/PLaVGypNYTyOSHjj8L19o8NJntmLePZ6X/Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by SN7PR11MB6874.namprd11.prod.outlook.com
 (2603:10b6:806:2a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sun, 1 Mar
 2026 02:35:54 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669%2]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 02:35:54 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: sashal@kernel.org, stable@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, hverkuil+cisco@kernel.org,
        Xiaolei.Wang@windriver.com
Subject: [PATCH linux-6.6.y] media: i2c: ov5647: use our own mutex for the ctrl lock
Date: Sun,  1 Mar 2026 10:35:33 +0800
Message-ID: <20260301023535.2438766-2-xiaolei.wang@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260301023535.2438766-1-xiaolei.wang@windriver.com>
References: <20260301023535.2438766-1-xiaolei.wang@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0038.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::6) To DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFD667CEBB6:EE_|SN7PR11MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 478c27bc-41b5-4469-c7d9-08de773b428a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	G4PGclagAavjOFHjQteyuQYi63zcTOnFkwqmF2bAtdYC0Ly4iSyfHdDE9o5f2yhWzlkBc17k+lP8cw01r14jXsjjU9vX1VLztxKDsWa97GWs+ccfS2DsFnJ3SvPLwlDAjSoyt83a3x78Jf8Yopf3zGcwLDI7f8dXCl0TqElZUgj5DPQseff/ZtwJOHrjIWUsjE89S6uzGiOK2DgKL4xCTx5+9C5VQGdlWozFuHKHVYxAZP0dnjOvbQWNzfVUwI+JwcTwzuqanL54fXGSwNWF9UenZmHK4Y8XIVJZVQjalN32nOAGYot2fMBDLD5x+Ud+5UUPqJATWsWQGGyWqSsErj40rGchk1KIuM1IP0qTkdFlC/5C1PkLjhG6u6Y3F9xbuAjm8J7nkFvmS1qVFveVQPbl94FMtFwgE+33zhW0DJDPODqjUaVvK6kQW+NIJx0KUBBtNnNCfAwAayAQsxmdqVB9BVZyyazt73dHxOuELoYtyH0ejJc5GdIQypTMN7fLrfI8fNwHVPCrTSwkSedmfc/RkbFED79409WD6/5w7NYPwhhDVNX2jF60iJM5Eg8W3LkQalVhOcc/pry/vHFjHc1DX/bk7S1ElyEyTVWSdORaXiWVPhBj4jajyMrHneyomc27u2zOZeh/9e9v6ZdbDpL2imclAQYdaAVTI1M4zcG11d+uNa9rLZJBXk35fxYTC1I/eL6IvsqtIcWwWptbPfhzis4BGMf9XRZg0mg4aVfRu0imnVIqPoYTqwMN3rk6tMhtUcA8qw1Fs1KZ9K9hJ3d83UHmgWKZa5Uf+PblZ1M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?il76wwGs59C5+X+o7/u/0ayqQqAwNTr7XtSnO8tB4qmEtEX7HWjxsX80mKsD?=
 =?us-ascii?Q?TWu3aczOe4c3nBbVEqmNmN1jstSgJ7+oOBHu+xH0dnolfRaB0GJoMwctoY7K?=
 =?us-ascii?Q?Zz8hpV2aICFkhuT6jwfFQkzwnWrtng6YU+ZL3EZC4w8HSJAWbo5Ub+krgRvv?=
 =?us-ascii?Q?qq3RKXY3ShxIyY5p6L+9+iPHP/PQ1+ZngTqI08oeJHXqkcOfHZueheqnun4K?=
 =?us-ascii?Q?8ZqO8tp+YlFc2ZmQNIC+fgvBsXefDlzs503w3T3yhPbrAE1rqJSh62931Va1?=
 =?us-ascii?Q?mB7D/R52fBXWfYF/sYJcYnMdyNTRAU4l78wUESeTFT83hn3hzBYenQYGnIlb?=
 =?us-ascii?Q?WgbIhViS5HYrZAMj6U6SP29EcZ+Hy6e/PUJIqW0pmcXBdOcKGCKDBBCrANoB?=
 =?us-ascii?Q?LT2mKORK34/+btQAncLbBbNR78mTe1ew74W5ynOHB9GG9VXjxjt4rPIAt/ek?=
 =?us-ascii?Q?IlGEHd8ddLKErf1cqhi3PfNT/U9liDhr3yzGY+X+XPhyGN7/gt+L2pc51Jfb?=
 =?us-ascii?Q?VxavF6B6570QqFl0GuQaWGaqntYldT/kkNvOewb+TySXP1M8IRoP4ICzZwpZ?=
 =?us-ascii?Q?JIs3hd5pPDcQpfMYoFvxgLS5qiFRJizRQH2UCu1U9lDN2waneHDTKdYZbJZg?=
 =?us-ascii?Q?vhrVf+V+AWLlpHJi3WR6heYd8kQIj0aVhkbB0nZG4EXSDt2GMBRBpcKYqL9V?=
 =?us-ascii?Q?GZb7HpU3Kc1zMYQdxzc1nB5GPpLbn13gNiRwqdL2NQiL2Lj0vZIYrVY7BZfJ?=
 =?us-ascii?Q?rNtmBKI8c/5VIuri/T6WbQa4+KCUFHimHd2jpow3rmu1hKml5XdjITuqvY/2?=
 =?us-ascii?Q?AeFejO1qlpRC+B3pPtHQNHE290lN05SHQKtGpS2nf7xbE6qVJQPOtd511BRp?=
 =?us-ascii?Q?6WetwF8kzaKEHrV1kvHfJ+KEueeYYwLWGXL1gxxMuOk5l0UoB7xla/b8frXF?=
 =?us-ascii?Q?68J9ORp2lZf9E8G+tI9/jiOawt5tLgnRGCYNnUWg4o/GDmLkyWJoKbUXON5Y?=
 =?us-ascii?Q?8wUEWKuEpmBOWYvXV/P19vk9H6PRo/zrUKVby8RDoFzzIRh6cMm25qJ+XCQZ?=
 =?us-ascii?Q?Jp22l//x8A/06lnt9lkftQfATVdH8e1gn8VhgFVHPCV3QnNYx9sMB6s+arEV?=
 =?us-ascii?Q?TnnmpXgadfEOVT2RTu1VYibDj+HhO4GgZ604sZBKjse0NeGNasDaWcWxGw1J?=
 =?us-ascii?Q?AsCerGy69Hihrrd20Z972zryath62CJ6qz61VY1tETqbtT9soZj8Lf631N5x?=
 =?us-ascii?Q?niSJ3vHXHbRPmqVL7qbs/uHnSghekNEW1ZoAXzA3HYcur+FJquSMD6r0OraG?=
 =?us-ascii?Q?eNgZZgTwEKU/yzw5dPfuzTdhlkpKBx00cz/02OsekgE4V6JsijeGpJ77SliQ?=
 =?us-ascii?Q?af7Xc1tNg8ekfkwq7KV1v/6jWdHfwZx2pFiApJU0MwAiHF0h461vBro2BfGu?=
 =?us-ascii?Q?NC2ye0v1cXdP2NqQ4jpg4lOIFXHeHGJV3+BYGcZgeO8PI/raMwdH8nBSiNXc?=
 =?us-ascii?Q?opqUny/xfGnMxiQM04Nc13WR2sjQVUkDniz8425kP/QMxIiNHj6lbnuMUiFD?=
 =?us-ascii?Q?fL0T6xsLEH/nqA3JspK/BrfyfH4AAMsls472zPMk2Pa/TIGhXbtZc8B656bo?=
 =?us-ascii?Q?Rb4X+WU+1lpC8aqO8pSO+6UV9Q+1mOWllZw/wLS3gjrDRwXozyk5mlCZjdur?=
 =?us-ascii?Q?9PYQOb1NniAEYHfcB/MRlR0DpDvwsXWS/dp9X/SX2RR/PCxzaSvMec7uKXxw?=
 =?us-ascii?Q?BBV80aPTj/crn/oELohZvijoDrrGUAM=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478c27bc-41b5-4469-c7d9-08de773b428a
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 02:35:54.0417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PyFVB1bdQuKeruOZGs5saWihpKokjj31L9YdjG2QMrTTggauoSgrCOHX8RSydtnDfFRlWP6tc6E3lCJliSkcBja3H3eENj/dqupMLwgaM3E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-Proofpoint-GUID: gBa01mniIG3OIbpyWRbm4clUnIM-q10f
X-Authority-Analysis: v=2.4 cv=Of+VzxTY c=1 sm=1 tr=0 ts=69a3a60c cx=c_pps
 a=OswsEo8IlqVTC7zrgcx7Gg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=wk0Ph_KwOMu3z5TwrfMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: gBa01mniIG3OIbpyWRbm4clUnIM-q10f
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDAyMCBTYWx0ZWRfXy6MAXhil6Qdb
 ZgU+Ulh9Bto5dxw4JhTLDVlN8IvH0nT/95ENDqs/FSJf0GjRotVh6Wq88ccnDrkNg0xiaTJe1ve
 T6U8Yf+5RoV5WJ9m8jOB1gWb0NXpmP42ZRkTFpZL6mern1QbSFeoBCG4TV0fYAOq2O5ORJCRm82
 yRWhTODWBJAL094X5/elNnI2K7jan7470oHmzCzeyVaM8cqRvru7qHkXfibEW4zaJciMoh2Q2c5
 uonYII8hwjw+ePmy2r6UVPmQ8wPUacAFcBYh5bISTuwPWcZYNBDS17h8jNfh4BVG3/8PPqHMowt
 MyXb7/7VUV+m6P4fr1mwQcNCPCz4H/mnjMaGgZUZN+emT2O91cIMrCOoNz3wF4gg4amq2ZXHvla
 80rLEg9tPbJ8cK/8t+DsV1BIH7oDzP1vXAlpXt0TBWBzWW2uKzO6FpDaREuCbTtis8r1PEE97Qc
 Ks6vXbkWKyVDfmF0LPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 impostorscore=0 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603010020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222394-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaolei.wang@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable,cisco];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,windriver.com:mid,windriver.com:dkim,windriver.com:email]
X-Rspamd-Queue-Id: E9EB81CDB8D
X-Rspamd-Action: no action

[ Upstream commit 973e42fd5d2b397bff34f0c249014902dbf65912 ]

__v4l2_ctrl_handler_setup() and __v4l2_ctrl_modify_range() contains an
assertion to verify that the v4l2_ctrl_handler::lock is held, as it should
only be called when the lock has already been acquired. Therefore use our
own mutex for the ctrl lock, otherwise a warning will be reported.

Fixes: 4974c2f19fd8 ("media: ov5647: Support gain, exposure and AWB controls")
Cc: stable@vger.kernel.org
Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
[Sakari Ailus: Fix a minor conflict.]
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
---
 drivers/media/i2c/ov5647.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index a727beb9d57e..548fde4276fc 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1291,6 +1291,8 @@ static int ov5647_init_controls(struct ov5647 *sensor)
 
 	v4l2_ctrl_handler_init(&sensor->ctrls, 9);
 
+	sensor->ctrls.lock = &sensor->lock;
+
 	v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_ops,
 			  V4L2_CID_AUTOGAIN, 0, 1, 1, 0);
 
-- 
2.49.0


