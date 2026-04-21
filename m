Return-Path: <stable+bounces-240059-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNvHHVon52kf4wEAu9opvQ
	(envelope-from <stable+bounces-240059-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:29:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F5BA437958
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 09:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4F0D3068D35
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 07:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30093392C21;
	Tue, 21 Apr 2026 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="CYjPogzN"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832B23A1682;
	Tue, 21 Apr 2026 07:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776756065; cv=fail; b=AIbA6JTku7OxjugQD5JfwcicoGl2iJ6kFQvtW2pXDofQtq9q+wlRppMQg0KfXSvJdweW6cR62/71jYTzQ38I/PBCn+MQZevducVc2fVrqkgFtWu+pZ7N/P0tc2Y/2I/uiNBWSgVfS0AEQh6IKYqctnAGzdxpunTWtaOJxOr8fc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776756065; c=relaxed/simple;
	bh=vrJgq2ubLedxXwnejb8xqvFNi+iBVzJof5NUXTpqQ60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ltPpI4e+3S1+74+mSxiXOmNv+WssK99ormQfzhbphTqBcd8b1Qg32tjy8Lh81wBvND8KlWdEsthj7NT5ruOUyM8UuT4+IPhVOL5uOc5XdEhjt2N3rZaUUGgKRF0SF0m4v7Wuu93XknPyesGsqgFGuk6/duHCPGSQUABz5ECSVjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=CYjPogzN; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63L4U27w411528;
	Tue, 21 Apr 2026 00:20:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=edruRNhOFxoTqLpoRttq5X20SXLnytn48rYp1IqcNcs=; b=
	CYjPogzNUvdXmEt2k5w/+Y1WUra8/t4+4YNV1vtPObd94M50obhHRF8KV6D+BdCk
	w84130TndOivrWyIINS2joFyZB1oS+oh69CMTI1pL4dBmLqLHs94Jem+n/s4+e/o
	DTGMmYyDBulBhO705jnCaMvuzlRNryAmtJUHdUTovsphC/OSgvnR+8fI4DVsm1aj
	J0SaWHoafv54G3cPwSZRk5KNy/iKcbDBOVTWdfWN9TTEuMpQtSTr/J7oRQ+n0N2Z
	zl0DKW5IHU+CgDC+msacxLLgRl0r29Y2Q9pXqD5W3L9RMFdK4oOeLYnXMsASENxW
	dvs2DrO6yGN6ZzAqW7St/g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4dm580awnw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 00:20:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hspPyKfhgoe7LSDwc7R9CokqhWHkq9NkxodycqZhc2fQZgymP3nGU/dka+VmrpCj8nNLNVL2grNpIBeBdrvsyja6GHNxQ4Cv5+S5833xobbHF3GCqxqY+U6taXL02XRM6nFhdwO6CvFIZ0wg+8g+s0BPd7R+8oGmM64HVt8aj8dKEngVzS6SVu31NyNnCFFChocCULXiwh+96q8OL5lI2azWDzypVQW+UTdDSVzM6Cnp+HE6itHB/7gV9mP4raoyzXqUXpAepRqpSBpFEGYmHDSEyPeODFTEcEWK1hhNLofB2Ahb3qSpi+VL28OLcn38p8ngIqF7uIuh+H9PFKJLcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=edruRNhOFxoTqLpoRttq5X20SXLnytn48rYp1IqcNcs=;
 b=YqVHBpLigeK6D0ViiY5coqQbMsxRJC3t4yEpgO/ieeovxY8zUO/J+UqwnMlLGywp5tFxYQp/CUdNVxDNr0KoMzqL79NIn7g7Eq5Ez2bDwZwQu5PVMXiQnK1GSsdWUC8WJwt6TmA/4TwfAm3rVnER4veDnHAm+oGlYaOCWhGzH4PRGuP72gYIm99tq+WUaoR34NlNi4zijFqzKcAMs2B9wrXOiOR/UDZLzYCCM3DNpaHJCB+kFeu0brQqFWmrxmydwEiMBEbv5/eCRkbhiHZpdjBeE4K33u1DhYQ0B0Uu17CvC8wcAX9c8PKno668I4OnXRG1QAEX7zYR2MwtQ/fg6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by MN2PR11MB4695.namprd11.prod.outlook.com (2603:10b6:208:260::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 07:20:25 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%4]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 07:20:25 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: linux-pci@vger.kernel.org, bhelgaas@google.com
Cc: helgaas@kernel.org, sebott@linux.ibm.com, schnelle@linux.ibm.com,
        bblock@linux.ibm.com, linux@roeck-us.net, lukas@wunner.de,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
        michal.wajdeczko@intel.com, piotr.piorkowski@intel.com,
        dtatulea@nvidia.com, mani@kernel.org, kbusch@kernel.org,
        lkml@mageta.org, alifm@linux.ibm.com, julianr@linux.ibm.com,
        ionut_n2001@yahoo.com, sunlightlinux@gmail.com
Subject: [PATCH v12 2/2] PCI: Fix AB-BA deadlock between device_lock and pci_rescan_remove_lock in remove_store
Date: Tue, 21 Apr 2026 10:19:32 +0300
Message-ID: <b378529b4afc4f2a6e393498fe9b9b7f056f95c4.1776755661.git.ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1776755661.git.ionut.nechita@windriver.com>
References: <cover.1776755661.git.ionut.nechita@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VIXP296CA0001.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:2a9::16) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|MN2PR11MB4695:EE_
X-MS-Office365-Filtering-Correlation-Id: 8590fd5e-f50d-4987-1765-08de9f767540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|52116014|10070799003|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2IXgywzv3ycO5LuIIKvHTW3Vzpn8dku2JV+iZJMaBoJMabLJtWG5DxQzMTxz5tqEoWv/Kjsg354AUwcomksECtsqgzRAjuCvZIWmO2Y6pbrJg0ds6q6hOrnV4BvzWwG5GLaWtF8E/06T1+EGlbbE5PRsi53g69qW+UElwGffF6GikptQ4ROYKN80Yqx45kQ9Me3V3sw3caSVFOBU9ceQN+YKoABiaoQSq06bvuyZstzuxGNOstlFKhpa3wqY+bgg7NJDVTj9ChlBBiQrtn5FVjevdMYHnRwlOBwi0upwo6OvonzPrtZeB6L7axmOdOtgrR10ytii0kst2h6ie2L7VQM+ZSAZRva8WdlfaXSLmDiAHpkxDiGPov58VgPIkY5d6Ae9daJVKl08g97+fZSkcxozi9SBDHNyATgIaDalk4EufrIUjuJq5kIRhfLvCJsrgKWDsIfu+NCupIdcVB14Fcg++YLHUBBxcRzNyCga8iN8DJNq4xxo/xMoqvSWvvxlRzLm7xO7e+J7uWIyTPkuMuFUjbBdNZaDyGLl6YRIsHexcLeFbyDQsYTPfDesAR2DcOn6eprptQwR5unEJZvuTJEiQU9PXmYYHqeeN0/n9Y8Zzz+3w8c3HGpWXg9I5xviCk2U/MYfg8i3sv2eb/l+JFwcJ/bBPVIhIJHITAstuAgMOAsi487hrfu9bPN1CVkT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(52116014)(10070799003)(1800799024)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?H0UahBbuzl1GPYCg+r8dSaIFgAzBG9+Jhl2nmblEwFW5fzcNoHpylpBY/46v?=
 =?us-ascii?Q?wIK+1u5pRbr4qm+r2XH/RAele0HXuxU7SOkbozStOeRR0LlmeKgtEwMnIkb9?=
 =?us-ascii?Q?U6wDRpUXY5RsEzhbh5GdEjt0pY+fKDrXtYryZRYsCk9JH6GZn5SYrxKpXFuC?=
 =?us-ascii?Q?HpKFHryNUvGaMUOe2gSfwFBke7dyLWru4u1Qi07maCYGW2ClAHdsP0KbejUz?=
 =?us-ascii?Q?yoMRnLroN+pxuftr5/l2KKjXU0AVIsdpQoo+rAK0fyxPunluiNfKOy3En8MU?=
 =?us-ascii?Q?W12y4ND5RHSA9SlXZEij6gcqTsbipYBCkmAInQf4wBMqkcP5j0POK5EdhRjc?=
 =?us-ascii?Q?0LGYBzia1b9MSu3croceC/fDm1/eAavBYc6K2FMhXWLlCXJY5inwfm7ukPFv?=
 =?us-ascii?Q?LiJu4SZkSBaKNY6l6R5V7bvfROkiielnmjaYamtU+2F8qlDlihn6IsHJMD9v?=
 =?us-ascii?Q?3m0nDSNtLVSDh5ZhQfecy8s8TRSvSU8Y/EZ3u0qGUXyzFQW+9G3SEwQqMAPO?=
 =?us-ascii?Q?6FmE75xqmMUaJgrdevalTKodul5L4zX23suxpqvfusZDsS3j7eOy1V0JdG29?=
 =?us-ascii?Q?b0h+utJCD8FAV8+jtZnNWtrKSlcFtCiCmO3IqOTy+aLQ4bLLY85Eif+o+Ay/?=
 =?us-ascii?Q?MuAUHWn7rXUDYRlgDS921XTdljRtzaC5U3YCkO5hs7VwU8/Chal4LaYk0VUu?=
 =?us-ascii?Q?Rm39fv4Xzi6Jm7fyf9s7pd/H9JSrrXb9+oQVCvk4hrAnr8uLDxT+c89vN8It?=
 =?us-ascii?Q?o+Rx6558I5HY2LmV1N3Ex7UCHEeT57o//sE4V2eNhDAe3aZ7Oc8IZhnIHXKC?=
 =?us-ascii?Q?TM3aB9I542+x9/0r2Xor/28OrzPYY0dvmhdBU8J+K7ImTO7RZMgh43hF7Ef2?=
 =?us-ascii?Q?NLew95QQej41tmKO2k5QXu5+Zwz3Bt3/F66K6MQQ6C68vBCh/ft2abIVQldT?=
 =?us-ascii?Q?DXT7CS7pGwnU5lrANritPV7z0BECeSCs8FcAEtMYX4AABv8QoK2pUzZacKJr?=
 =?us-ascii?Q?3W9d7Z+KMwb9R7JscZeBDgE8AeBFmtFnkeZiA4Qeho6SFljitxEL+9uuvtld?=
 =?us-ascii?Q?t9GLR4NUFbI6aG1UQpivHJw3aDPMBM8d1OGhJWWHbRb/Jn9fljJZY7SIykv4?=
 =?us-ascii?Q?er6uIhGuXpmX2vfQe+miXZwHHNJ7NUFdP+zxIfwiUjNXCC+D3M9we9zNtZaT?=
 =?us-ascii?Q?q81NBr0bQtSv3RHED6pkUdanIqXsPj7cF7mjvrihjJu7HXJVz8LaqNMNewmM?=
 =?us-ascii?Q?YRXvre939BT4GQm3TX4ZGHf2YYbs7MoMizz+3zC/EqDBTq9pK71ikTlZrA3+?=
 =?us-ascii?Q?JRUu+KHHHSFcDyB6hhpYgq0y4yHmKmVuI5ig4eBNwsVH759abWfopqomvAvL?=
 =?us-ascii?Q?FlI5owk4fyrN5Rb9MlpeUQBh6qEWFmOFMBJ6FWbgtPrsvdvLpA66cPAfMwHO?=
 =?us-ascii?Q?ye0FV1YtTe/b+r7I/2cC2Ho4+y0qIMvA6rBQO7aYW11YMOJVIJUlJKop5IWf?=
 =?us-ascii?Q?PvA1fPRl4sO5eha/Pep2chCqeYSyC28r6wTkVhBtaEPyH/jkHI/5rN/r5Qty?=
 =?us-ascii?Q?RLv61604QpVA3U7uxQfCrT8uWvuBrB3oguXw7NHqTFD4jhMIR3swGIccwijo?=
 =?us-ascii?Q?/8V2EuTetaibeXTc9Ar/Xy+vVl680kmA1wrgwbZrS/jUnuVIIHc/KU+Lz5xz?=
 =?us-ascii?Q?jW550kpMLqt/qMnFyPjiG85kzy6PXesDlra/XlRLl3ZhDpSBiFLaiv186do1?=
 =?us-ascii?Q?ZcIexW+0AY980lBtHSVmMamV6wGs4bbYyfOhac/0ABTVAui9U5kozWe4IPAP?=
X-MS-Exchange-AntiSpam-MessageData-1: vfxu/O1Gm/pDz1g1q7hRw1gu1tbYoX5v9bg=
X-Exchange-RoutingPolicyChecked:
	KLABhi5k5Vj7sqYUB7kWzK0TFVOgXM1vhHmUsZWhYr41Zq7UI27dEHhuuJt3BXwmI5ml3d31Lt/NCpTpmwRYJGPLE/emHlP7n454TCZwPTXmMhcchOenTTNp5OPdIoAsBdNry6eW10oyWFWOigrNmfLSa12bUqcH0WBHMXVOzOuNIVxBRRDuOalEZQXErP93lkT33XEoTV9bcZAXVse7w+js4XXlSlBqn4WXboTc/G9B+QXa67rP1yXcEcsFcyMpwhMIUotzgDNjPHKrRbyA9akXL8JSwFSOyUFokPgetvGVG4gFKG1PlfE40Qa2fZLcMKMDRr3z1CSuZM43249Q5A==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8590fd5e-f50d-4987-1765-08de9f767540
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 07:20:25.6289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SuMh1+xQBKOmC1iGeeNYPOuwX/wPij7YV2OGMjlz3PdSRZ+ykW3D7APFZnR34TiSVIFgM4U2hf3rUI9zq8lv97/glrBxZ1K7EoRq9Q/mu4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4695
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDA3MCBTYWx0ZWRfXyXWquYledp6l
 XPVMysv/9YVCh4BKsvZDeNpSZmDgmBm/bmQUMYsUIkV1Ji9IGTQMDKCp6hH9uQQ68k5B9X8AWQo
 g2RlSAVYHzkjS6+VPX2dyIdsAWMR4ZUnTQ92MxR2ZrAl26ionrH78UwfHLULV+LgyKlhD8LN+e2
 B0XWhuC/ReiL0dAkeMeRdH2SeQ/3NOXlAjL4QxS+Z24WUsCuw4T7+l9aiziZpBWk1mZdeeFvJdS
 znyG4ENdd42lmY3BHt7OGWGV1yKv3mcbjTBqjeP2Ho3yC35qsrwXuQlSZhPx57sqtWRFX9H+Zi7
 g2fEsNrtNoe6M7W0AxvgMKscxYPaAoc7o5FMGZb6gZFehyJXh9KjomFDuwZ3T8yCD/oP+2KqdTy
 lpx5WSgHQiq96wpeWrOqc1h2syhuA1Or4nV+RmRJyMOCbQew86qaan8KQKmuczQimc0H4GgCred
 xgh4me3TlhqslArQMYg==
X-Authority-Analysis: v=2.4 cv=LLVWhpW9 c=1 sm=1 tr=0 ts=69e7253c cx=c_pps
 a=JgOmb2+ItGzuqF5frRSN9Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=HK-ge7EqtdluswH-FwHe:22 a=VwQbUJbxAAAA:8
 a=_jlGtV7tAAAA:8 a=p2eoyRXnAAAA:8 a=t7CeM3EgAAAA:8 a=VnNF1IyMAAAA:8
 a=mm2UkWPFonPHBTd3Hn4A:9 a=nlm17XC03S6CtCLSeiRr:22 a=KSHYvF9M28j0gckGFaEs:22
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: Tb9VWSpBDrjyQLWCkzJkCZkoDmbNkzcn
X-Proofpoint-ORIG-GUID: Tb9VWSpBDrjyQLWCkzJkCZkoDmbNkzcn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_01,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210070
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240059-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.ibm.com,roeck-us.net,wunner.de,vger.kernel.org,lists.freedesktop.org,intel.com,nvidia.com,mageta.org,yahoo.com,gmail.com];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[22];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,roeck-us.net:email,windriver.com:email,windriver.com:dkim,windriver.com:mid];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 3F5BA437958
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ionut Nechita <ionut.nechita@windriver.com>

remove_store() calls pci_stop_and_remove_bus_device_locked() which
takes pci_rescan_remove_lock first, then device_lock during driver
release.  Meanwhile, unbind_store() takes device_lock first (via
device_driver_detach), and the driver's .remove() callback may call
pci_disable_sriov() -> sriov_del_vfs() -> pci_lock_rescan_remove().

This creates an AB-BA deadlock:

  CPU0 (remove_store)               CPU1 (unbind_store)
  --------------------              --------------------
  pci_lock_rescan_remove()
                                    device_lock()
                                    driver .remove()
                                      sriov_del_vfs()
                                        pci_lock_rescan_remove()  <-- WAITS
  pci_stop_bus_device()
    device_release_driver()
      device_lock()                                               <-- WAITS

Fix this by first marking the device as dead using kill_device() to
prevent any new driver from binding, then calling device_release_driver()
before pci_stop_and_remove_bus_device_locked().

Marking the device dead closes the race window between unbinding and
removal where a new driver could theoretically bind: once the dead flag
is set, the device core will refuse any new driver probe.

After device_release_driver() returns, the driver is already unbound,
so the subsequent device_release_driver() call inside
pci_stop_and_remove_bus_device_locked() becomes a no-op.

Fixes: a5338e365c45 ("PCI/IOV: Fix race between SR-IOV enable/disable and hotplug")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/linux-pci/0ca9e675-478c-411d-be32-e2d81439288f@roeck-us.net/
Reported-by: Benjamin Block <bblock@linux.ibm.com>
Closes: https://lore.kernel.org/linux-pci/20260317090149.GA3835708@chlorum.ategam.org/
Suggested-by: Benjamin Block <bblock@linux.ibm.com>
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Tested-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>
---
 drivers/pci/pci-sysfs.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index d37860841260..1426328e9f05 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -521,8 +521,36 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
 	if (kstrtoul(buf, 0, &val) < 0)
 		return -EINVAL;
 
-	if (val && device_remove_file_self(dev, attr))
+	if (val && device_remove_file_self(dev, attr)) {
+		/*
+		 * Mark the device as dead so that no new driver can bind
+		 * between the unbind and the removal below.  Once the
+		 * dead flag is set, the device core will refuse any new
+		 * driver probe.
+		 */
+		device_lock(dev);
+		kill_device(dev);
+		device_unlock(dev);
+
+		/*
+		 * Unbind the driver before removing the device to avoid
+		 * an AB-BA deadlock between device_lock and
+		 * pci_rescan_remove_lock.  Without this, remove_store
+		 * takes pci_rescan_remove_lock first (via
+		 * pci_stop_and_remove_bus_device_locked) and then
+		 * device_lock during driver release, while a concurrent
+		 * unbind_store (or sriov_numvfs_store) takes device_lock
+		 * first and then pci_rescan_remove_lock (via
+		 * sriov_del_vfs), creating a circular dependency.
+		 *
+		 * By unbinding first, the driver's .remove() callback
+		 * (including any SR-IOV VF cleanup) completes before
+		 * pci_rescan_remove_lock is acquired, ensuring both
+		 * paths take locks in the same order.
+		 */
+		device_release_driver(dev);
 		pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
+	}
 	return count;
 }
 static DEVICE_ATTR_IGNORE_LOCKDEP(remove, 0220, NULL,
-- 
2.53.0


