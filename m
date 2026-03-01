Return-Path: <stable+bounces-222395-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANoLBjmmo2mWJAUAu9opvQ
	(envelope-from <stable+bounces-222395-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:36:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7891CDB9B
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 03:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CAE393003829
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 02:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD7E309EE9;
	Sun,  1 Mar 2026 02:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="VqC+a+u9"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB522C0F6F
	for <stable@vger.kernel.org>; Sun,  1 Mar 2026 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772332595; cv=fail; b=GWDkehiICaG9Rw/84ScocXWgDA6BgsdzCEJ2yZ0JRrUfFeywMx8su0nd7D9Gdv//QDZ1JkcBcxRAtdvsyMvgiOVImkgP654hW8TfBeTeMGkv17pZB4pnK8x8ebjv/UrtnTO9+rMlMO2K6pGL1QXezDvro+z00aE6+dsalki2Ojs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772332595; c=relaxed/simple;
	bh=kTSPNDWYvnJL6CTDQxAcSsOBRHmbg7hRG3+7gfqPaR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cfrCjiajRKTLH3EQaaDnsEqEHe59PpfG/SyZLwMPUO+AZaAQphM+2laQlqPKSrMP2ZW5As47IDovYCm6grrzpbZTcYgMl9PVkX6rUvOv3WFC3qrqAe9lLywnjsCWCT48QpcRZ6x2cccEhIiF0yB2Z2IzSGjR9c6PXbb8bdu9pns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=VqC+a+u9; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6212SCnD2789594;
	Sun, 1 Mar 2026 02:36:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=DZLYIeQk3k6us2OYyD96gRLlywsfwdttRgn70BL/YWY=; b=
	VqC+a+u9iNKcjVIfWyJbcqKBtZVHILRu9B8RmBMC5K+0M3HU3SZfnLyq6kTRY8UH
	F2uSXz81MtGWXSXstyTiMnv54frnWc4TXzEKeEFyih2tZBBWDFUbXGWio0psADn9
	4xCcRXz2+XGkjYrixUR2ROEVTAZ+JCgME2ESUqOWTza0kcFnRbctwb0sLu8U+bHo
	unGE9qQiJCv7P1uz+yPHNwtNg13L1v3rFdYeHgvWNBSMYppq37RtqQtw7LVGJcXf
	BecR7Q/M10OiPIyP7mIW7Ot4hppomdLIOq6bmt+Qwsm3I56Azar8Vo8KxexsA8vU
	CEAOVJNdJhaGGHLpiTwuWw==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010025.outbound.protection.outlook.com [52.101.193.25])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cknjvh5xk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 01 Mar 2026 02:36:00 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ivuHpGeuXZcktr0n1fi/jGSaB7Ax7D1WRft7iB5Gej1XdElAZbUPalJsImb0FedWWeu6JvWS7tEJPuVdOQqjAWm4NCMExL5kt8+rRsiMn2QARIbfZwA/is8tKIqUYwL3Rl8Vy7b9GyOJRyLmBMIcFdhDsRHJQ8+dhTRbfV9xSdZlKIFZEaH+t08VimZabZt0yQ1z0SChZzkSkmNC+s1uqqaaUazAlnGCayMV8ZQVR1CRwHthUrSQOoB6ApZtG2+JE8ICAzUsVwltzEbEisK3NLAde8+nrXgtpGoKBrpaEJO3bEPao8Vhsq+L/rhADrzKIhTz31ru+3zjyYEX4v0SoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZLYIeQk3k6us2OYyD96gRLlywsfwdttRgn70BL/YWY=;
 b=T3pF+0CB4TKtIihBnhjaAdutQXexhxIydwGCl8ZSh0dTJ1qVhyuktPOs1IxSBdP+iPdg1GMOlXupHKJ/HwpXkGuaZf2bOk81mua4EdqxtCcYwxIuuI6yL+x2Iejt4lWdY4Try/dIILz3YQqKg3+VthO2UD4F6m0y1KcsZBFxzJ8Ydd4IpAVymCwoTrTJCzqMoBN5kX6mfJcdLTHsvKQhWMciTCiMgkDqKISLw4Xirdlzj5BoqAPutZVsxWDgNpgSe2q1GjQlRq6GcFDRT2vt6kswiB1zv9QmALNCeAh9wq152HlR4eLDhYjRNe3WyKe6o6qeQOFLxa4fMw38s5gnOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::53) by SN7PR11MB6874.namprd11.prod.outlook.com
 (2603:10b6:806:2a5::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Sun, 1 Mar
 2026 02:35:59 +0000
Received: from DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669]) by DS4PPFD667CEBB6.namprd11.prod.outlook.com
 ([fe80::5f46:caa4:60d4:f669%2]) with mapi id 15.20.9654.014; Sun, 1 Mar 2026
 02:35:58 +0000
From: Xiaolei Wang <xiaolei.wang@windriver.com>
To: sashal@kernel.org, stable@vger.kernel.org
Cc: sakari.ailus@linux.intel.com, hverkuil+cisco@kernel.org,
        Xiaolei.Wang@windriver.com
Subject: [PATCH linux-5.15.y] media: i2c: ov5647: use our own mutex for the ctrl lock
Date: Sun,  1 Mar 2026 10:35:35 +0800
Message-ID: <20260301023535.2438766-4-xiaolei.wang@windriver.com>
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
X-MS-Office365-Filtering-Correlation-Id: 394f1d1b-81e8-4558-25a2-08de773b4571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	cSHnp2+RG7OH1UgsYTW/Q11QNJqdjyQkJXJe8RiZFfwQ/jv4d4RSdwpTsSZoLs2Eh8/M3ocA2+CLMMbv2w2qUe0KbREVH1d0TXikzPOYCIC2QFMoZZGB9dJUJKj5tzBQQUYN9xU9zX4rr4ly2KvfkgY/rHrN4GvhtN/ORAVuHXqz+z0VWloCfHrgIlnx/mJydvXU1H0VPjq41OSh+Xvu/Z6HfJNIJn5T/O88L2d2PAAbsY/1pkAJROzgOrkRuZQKRo94AfBf0GGQh3KRxm44BZrjg5bjLUL/ztvjWZlp2Aq+IanBpqkAoGT+u+7vxpwiW5Cd+BSh0RMPAy/gX+5uFZhbCW5qLxjWDauFEugM7USCdDOpWwipufOe8sucusPt+ShgRYwz8I4aKCsvdYMtGoaqwk+G+YkN9Cfu5d3dGT2hgGz4t84tNSEi1zvF0HXEyiklYJ/3SMcZ0+xgvZNa1KiDvRjeOT3nJxqZ7TzZD2lahIrrV85qgyrBbCPuMB+m0Yre5MNWThUmqx+/1LQ69KrqflusJW1esZVeg+fgOSc1hcB/Ys+0rucSGKvSuWffcUdDTQAPI4nKlA++pbwjaotMFpHljkcKW8RFItQ5zRWHavxgBJSEyHmEJ2BH3cErHYictDczmfsxzEAIoAZwFE2ng4BJVZdzSnatLGjasOF/1kW4KKwFKMNI5n8dGivOuIW530uMDdiqqynzKfG/lbsYq/07riNARF9xbbxdZVTTsatV2bwsQhE1Q+ovjEAB5JjXw/yNzGd8zA2MFBj9wGiC91CU9+LhRv7s5mWdyEw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFD667CEBB6.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EQanpz6PPrB9E4Y2fjQuFGDwABAariqArBCCKTt0gyt8ejZmsQAXGAMgfyE6?=
 =?us-ascii?Q?frmpv1ZQSxujemC29TPPYtgE+9hGVhkYRtlH/4xvJt4VPC19fMpZfPiOvpk9?=
 =?us-ascii?Q?Os6HdKxMOXm0Eqi1YMbqRi4gv4ueiK3qKxVWw+Jwivb7T5hC8FGNM6SAJrXb?=
 =?us-ascii?Q?xX2nuGNmkpRRRZsby2O0uc/C8YD9pgltF/6e+MQGJZS+rGBM040nf2NgsKoT?=
 =?us-ascii?Q?UGVp9IBMDamOz0S4Ifp9bgqYiHTOgIjchvD06r6hYXza4pliTfpcRSp3l3J1?=
 =?us-ascii?Q?kCIdkGoYt/uBGMqjI2J1buo9zTS9hY9yqhU1hhddUih4brLBndNExfddDSOU?=
 =?us-ascii?Q?DDSF/qQSGi6DYBgh0ti47mrvZBFAl0TL1n59lY8ojwbr+grX1c59RZU/Sl+Y?=
 =?us-ascii?Q?nZrm99X4q2JgpThoA5oMXN253gAukN5FOB8dL8pC54nAXp2RoT9sHN7n3b+H?=
 =?us-ascii?Q?CFX87zL5xYDYRui6M3hx0sYrCOOO4nDWsLFjyYM8ZI4/dtD7HM1k4Mo/dxVt?=
 =?us-ascii?Q?zVj32isACemOMPr/kc1oU3gqnczxLjXYmwOV0ZqiDxrqomC0aWEFFY8SojFl?=
 =?us-ascii?Q?ULYp+LhsNu9yfiFrNiK5LHeMkxjBeRq6szcSLEn2zSv9NzVEG6NmjIvplRYQ?=
 =?us-ascii?Q?99aTi16UsWoWWjYXIqHXJv8CsoipjEJd9G5ankjibNcqyLN14cfEEiXV+7Jb?=
 =?us-ascii?Q?T6GbY/K0O9CP1wHvAH9aYLh2jfTW0/ZsRgfPiRrdBTKq11CKGS0JO9n86tyX?=
 =?us-ascii?Q?mHlFArFmttpyQQDmp1EuVJySzR5k1Rba32jAHjMbgV2CcglH9uK8pst0HyhH?=
 =?us-ascii?Q?3+XcVY8kjL5EXfSym2Gi7MjJ1Ddset8Bihl2E60Sn/OOsOip3nslpwoTpAac?=
 =?us-ascii?Q?83Bfr4OnzaO+rAJA7/FUGytFeaZYR+eQj0V+BV4aUBkH4DuFKI4leR/HojLG?=
 =?us-ascii?Q?htHBu3eIIiHJ1avVWVL9wOTRx/O9dhIYq/xUA05oCH8N7NSJUBcalVNThWp1?=
 =?us-ascii?Q?ayYRVn1uxSae96DHjEKs4fVMIG8bqfHxQ7FVtyyQ/fpA4w0IFFbdAyM0Mk7I?=
 =?us-ascii?Q?0VTVTA9kVrvFEs3PU9DMnwdorZeS8AoWwz5ExgQ49bJOAqbPtoBvxbsanOi7?=
 =?us-ascii?Q?eYxAgvF0mo1s1oCTMI3/r6M+ZB6usSwzG41IYqQ5FvQLEw2b/aTD4CmxjDvJ?=
 =?us-ascii?Q?fkdmpS+EIzXCxaGNknrJM7Icm9xwhk5pvyBV3r+uUV6VM0VKEMPMjmp7TYyu?=
 =?us-ascii?Q?IsqQeuyrEh5c61QIrXqsfrouZRWkRAY+7fgL1aocJEyzSBTo1ixWeO1qtoJd?=
 =?us-ascii?Q?WqOeU+5dzQXLojVgnRRDhDaH/XKkzVilX7fGQRYxaiibsupEit7hjTbUX8BG?=
 =?us-ascii?Q?s1TFbAcbLQXbIeygDDzKIhsxxdIz2qNyh6PNWUIpRAsOtC2kuuL6kb3LTn3c?=
 =?us-ascii?Q?nQf59X+Mf5N/Dim4c/H286lSQEWe2zc4g4EqSVvzb2QXK2VaplydSEG9f3sQ?=
 =?us-ascii?Q?ba2KtdTEeT2Ko9ZP/0A+JVe3BmZ3tre30nX6T+ZdURJs05H9HAiYQB/3eJNg?=
 =?us-ascii?Q?A0aouPRT6DaHfFQAGImjLeLkN5UDWaOZ7CsMows4Eq1P4hbeqDPPEcFe3JBT?=
 =?us-ascii?Q?pU7tOLX+LJIpBXHx8xe1VxBL88J6N+izRjxsxxN3tlZ1Ji8okrRiBNXCIgJ6?=
 =?us-ascii?Q?XDf3VFKQHTexVhGB9uvOOVJaWVtE0GeHL6CtZlceSFjBkO8rDwYB35WlS3UG?=
 =?us-ascii?Q?hzomOEjt3H7nek1THkhZ6zTU/1eU70w=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 394f1d1b-81e8-4558-25a2-08de773b4571
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFD667CEBB6.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 02:35:58.8868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7pfZuB6heHgU3LU0OqqPQwNGVtSXe+/7wQe/FgSTMKvQbGSwBbFbxoJPF47NViTfp/dWC001Cq+OtZqrWjABAUP0assyfw6oNzugbBjog90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6874
X-Proofpoint-GUID: KQHy8daycSwf2z698OSu-BZkjrqRTiih
X-Proofpoint-ORIG-GUID: KQHy8daycSwf2z698OSu-BZkjrqRTiih
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAxMDAyMCBTYWx0ZWRfX07ZQghpStwZv
 QCYfgkeqIB6fhg9dmHKqwMLvwPECQOa+9eyVJtvT07O+XHanWzXs62W44CBT6Ahr9PgwPdzLT4i
 Yv/seHCBmAKbex2rI+Ckhs1AV5eCJ8LwQomIWk91dvYQsToAvZYpBKehBs/efeYU79rGQOqjozF
 73DMtqkV9j9iXZuuG8aVDk8vKPegSDMNlmSYjhY9ymLPkLQnvWpwacAEokfU3aX8nCWSvzWGl2W
 RfW3s8w5hLSdV/6ZhsWkleoA4RlndayHI4VaNp5WIatTNsLzGpLj1bKBz57IaJKzsR37gBsLhS+
 t1QaMcPybXZsW5V8ajh7h0RjTIKSzcza6Hhpwc5CS2agsP1wDwPn+s4ojc4DUvEHeEBrOQwUcsP
 tnz7GWkU7AAJ8y27UiKKXaSDOGUgNw1O4Aun4kV9ligL2AhwQxTVAzayI6Ju3hKhIru9U829TfA
 NcaIPh6Iexpb3RaXPCw==
X-Authority-Analysis: v=2.4 cv=P/g3RyAu c=1 sm=1 tr=0 ts=69a3a610 cx=c_pps
 a=Uu/nqymW0mikAGBLwR5b8g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bi6dqmuHe4P4UrxVR6um:22 a=klDOsUkWDRETUCZYPvoE:22 a=VwQbUJbxAAAA:8
 a=t7CeM3EgAAAA:8 a=QyXUC8HyAAAA:8 a=wk0Ph_KwOMu3z5TwrfMA:9
 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-01_01,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1011 impostorscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603010020
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-222395-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaolei.wang@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,windriver.com:mid,windriver.com:dkim,windriver.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0A7891CDB9B
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
index 847a7bbb69c5..cf8a84fa3100 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1272,6 +1272,8 @@ static int ov5647_init_controls(struct ov5647 *sensor)
 
 	v4l2_ctrl_handler_init(&sensor->ctrls, 8);
 
+	sensor->ctrls.lock = &sensor->lock;
+
 	v4l2_ctrl_new_std(&sensor->ctrls, &ov5647_ctrl_ops,
 			  V4L2_CID_AUTOGAIN, 0, 1, 1, 0);
 
-- 
2.49.0


