Return-Path: <stable+bounces-230996-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNGxMYzpyWmP3QUAu9opvQ
	(envelope-from <stable+bounces-230996-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:10:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B616354F93
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 05:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 507E83016EF9
	for <lists+stable@lfdr.de>; Mon, 30 Mar 2026 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091337C921;
	Mon, 30 Mar 2026 03:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b="tRqSDbni"
X-Original-To: stable@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022108.outbound.protection.outlook.com [52.101.126.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3F375ABC
	for <stable@vger.kernel.org>; Mon, 30 Mar 2026 03:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774840175; cv=fail; b=riLPE3W5YX9QSPDRBalpYGc9VBQ/7QJt5lfxbjDsVQ5FcFZclWoTbzo+Q5ARMkcnRgmWdk7jkMdbAaJP5TpggvAjnrKBwKU2xrU0kNkykXPxMtRmyfZ0Y6Lf1bGLIAJbJWdL5bUMswRQqcY6OCxl7VQDCY71OVoQoCAADCMq/EM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774840175; c=relaxed/simple;
	bh=VkNma8+LpnrmsYqwPpj0rYvaSX5DOtmx+8OPhX5c9G8=;
	h=Message-ID:Date:To:Cc:From:Subject:Content-Type:MIME-Version; b=nwnBEnOyzJ57tKi1PmvXL2PZ5SRIVCgtcQeEhitTDms5SDixeFb3qwk0/8SfB2VE0qXA5heEfMiuEcBQWMgQq03LoY5s4HbE68JbGx9lGKUHWGKA0xLdmIJlxbAKLvul13CV42xBldxeycT26q1bD0CDhSGLsI6PjhCHySF40Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com; spf=pass smtp.mailfrom=amlogic.com; dkim=pass (2048-bit key) header.d=amlogic.com header.i=@amlogic.com header.b=tRqSDbni; arc=fail smtp.client-ip=52.101.126.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amlogic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amlogic.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKiHilomO56Rj5xZ7MS8ZDpmI+3PhN5ysXFz/gX60b1a7wA7U5TqNte+o43VFgCNuk1IvIC5o1AsRcqGBsFRUvVmAmJWRwaQmbQDnpGOmGSSMmw7RK+nE0W1QMnsWXvtgFYhvGAQ0H95oDqEAidyPX7hE2WL+tg7Drk+wyoKc+v6BvJUoYWGDq5PaJc2bwvEeiZOf7CtcFW1ptsUve5R3szfDZbM26lFv1I5jIBOTOzZxwSwyAgMcCFphVYC3NKUas+/+iPzYGWhxYhKKGooEtuDfM0uMqTja0AdqwjRHR0+1hibJ1nDb8KeKzyKP0OJtldcSln7GL4XbUQlYccxlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VkNma8+LpnrmsYqwPpj0rYvaSX5DOtmx+8OPhX5c9G8=;
 b=AYV5kZAVVLNI7r+ztSMUOwtwvXqFZYNZO0MD3rFtQqPjypoB8CWllzIr6y3HaH1obkHwMt5+DYhMzGgFkrM5ECvzRLQz+8ygG6oDtVhVEU7bdN4eAgXsVeRozfi1Z1kScsVGQKFivmR0XMs0AnHBQrVuIflOs/2NYuUPa+vJ27hoooK95TISOB637uLi/3Xh3bd9mF7/sb+sd7E7Pls2dBvDW0cebvL5a2xwhDmimeb7oHg9/QDphHQXq2YYJ9hVNz0qy3z5GEsTCDUAPxY4qEiflIx3VQHmf1V0W1d4JWM09Fj11qno3hOvDPA/8k6/14cv2TewLDnfKRrmh1zYnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amlogic.com; dmarc=pass action=none header.from=amlogic.com;
 dkim=pass header.d=amlogic.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amlogic.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VkNma8+LpnrmsYqwPpj0rYvaSX5DOtmx+8OPhX5c9G8=;
 b=tRqSDbnikPVhHendq+guFDsPsIZAOg1knimTseQv2xRaA+qFk5Z1ydqlvK3KO+PKTRjAF9osEaz+xBJl2cM8HFO2/3PTG4+dvMlrwDjRBP88svtQ+Jsx1GsW0pQ+8sjkLtxGBUWT8PTb3EGXAyacdARtsGdTPg6WVhEgoFbYjEQurK7BWq29Ke7pjTmHUWNQiz8YTnx/UPUYY2GuPwOs26JuDE9QOB+LL9alu93Qf2RuIX/ncJiTBp3SA3xwMK/Kc1ZRBQQdgozzLLIEf0ma5tNhPjffA/uuZW6mYYS5h+9b2/sXEmHluu1MZiiikgJ7p8K1JHvljL5W8tAJS1ihlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amlogic.com;
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com (2603:1096:400:354::5)
 by PUZPR03MB6909.apcprd03.prod.outlook.com (2603:1096:301:ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Mon, 30 Mar
 2026 03:09:31 +0000
Received: from TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f]) by TYUPR03MB7232.apcprd03.prod.outlook.com
 ([fe80::525d:fa76:296a:a64f%6]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 03:09:31 +0000
Message-ID: <ac74cd6d-c695-4a47-b551-6ac65bccb57a@amlogic.com>
Date: Mon, 30 Mar 2026 11:08:32 +0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: stable@vger.kernel.org
Cc: tuan.zhang@amlogic.com, jianxin.pan@amlogic.com
From: Jiucheng Xu <jiucheng.xu@amlogic.com>
Subject: erofs: add GFP_NOIO in the bio completion if needed
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SEWP216CA0040.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b5::12) To TYUPR03MB7232.apcprd03.prod.outlook.com
 (2603:1096:400:354::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYUPR03MB7232:EE_|PUZPR03MB6909:EE_
X-MS-Office365-Filtering-Correlation-Id: 022c3b64-255c-447d-3fcd-08de8e09c30e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	uAhlTQewF7SJOwZ+YpEhxwNd5JrUFGfmL0fE1DpvbJu1+ptiOE/keeJqDE6CYcCwuiPy/w9NBLofXZGWzmlaj0gdy278kYAu9LhicZZ6N/FnsBTrW65aR4qTb10xIKpijOoK52/HIBnUQNZgRIEqabOzH1PMzGYmQtdoQBdjmrGb84on8Db0M3WtHVwJuKeXqvHAvo5mFrKeO0xhbOxjrzTpD+5QXXQ8o/0xXLHf1AGoOlgW4cCxJAmAeW7LGAdBFlKWEE9HwWX8uM4KcSeUIB+YAG/WJxsVcfwQiMsHI4vBQ5xfd6soQ/RUaO9P/h5jJakzsGyrGLXqPV1BSJPk25wbuTWawOOFqCdfDHimhu1T3WqWgxVGZZ9UDWLWUkD5jVcgQnwW9DSqz7+y6I++5yY0UMmScKDkdpR5hDELPT5Hj5Ualc2sLt+pFsEF8MHzccg/bLJ8v9A6bTOqOdKPt5/fByjXhnPCgf8XyyPNK+X+PphiEu/etYezVEhSVCH1U+lMJ91UcHsjZrKff0Pwhg9CoACA84ld5zzZfUinyeGPseI9sGOCGaiv2PxZtSwnB8vpX1JlwzJGS1WS1bRbqGjzqDkUQOxdslAE23+Fb6XXUmgfEC3TRpFl9zu3Ud7oCH8aw+YgRkler+1NPLSpPm4/nNEin+VhXXC6duU35/h/iq8p3cbJWBeG2qAgOC1kSO80YM30O7bjqfPUkvf50EnIS0xVb5VJjxjTcq30WKc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYUPR03MB7232.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blpBaEl6QkttZEtpK2wyREtoUDA0MDRjL2pVTHlKdXZodUk4dW5hemhtcmVo?=
 =?utf-8?B?eWFlTnJxSFRaTVpVcVA3SXlNZkRVMys2NFRpWHpUb3lDSEhYVjNKMUYzRGdp?=
 =?utf-8?B?OVg1dmdWVittNEdTTk1lN3VGQUVVc1ZpWXI5dVJ1RkpRaVcvTkEyYXJVRDFS?=
 =?utf-8?B?NDRtdHcrNWdmYUlxMWZZY3g0THluUkpWY1dkV0pLOTJaempxTnAxUkY5Sncv?=
 =?utf-8?B?Q053UzZ3TTc1UE01SGVPOWF5K3Z2STRzSEV0czNaRWhzR0t0QThjejhramhK?=
 =?utf-8?B?dzF5SVllRmlRTG5Ld0tlY0s5OEx0ZDRIb1lwVkhjSGNDRDlwNm9YazRINkF1?=
 =?utf-8?B?TUltZysyUXFtMTBmbGExbkJMeTZ3akpxMmRUQy9ubExwQnBPV296aWIwakFZ?=
 =?utf-8?B?ZjRQYUVGUDlQSjNHR1RmQVpBVnJlQWYvNk1id3cyVFBLaTBkdWIxaFR4bkIz?=
 =?utf-8?B?aytsdXh5SEFCbWN3U0RiUGpPOWNvZmxnNThyNTNLc2twdVk5MDBxTTBCT1dt?=
 =?utf-8?B?ZnB4ZDR1N0V3RlJocHI5YngrZmFSUkwvMVovSWlEd2VuK1daek9PaEhwSlZV?=
 =?utf-8?B?UHg4SjkyckZ0NzRuQXd1Mm5UVDJsaDMwd1A2dEo3TkFob085M0ZMSWdSZDdN?=
 =?utf-8?B?cHFjUUJPWmU0N242bSs3c21jaVArdklWU2pHUUlGcWhpODFMUGh2NU5Nc3Nj?=
 =?utf-8?B?SW1wYnZmemZwRHJoSnJxTG5KZGpFaTdBUVhNSlNDUmZnd2p5cjlyTk5SN1JJ?=
 =?utf-8?B?ZTg2V3RLdE02c0xzcGZCTUFmenh4T1BFamxOaGp1dklDVHVwWkpLMnUrUVVj?=
 =?utf-8?B?SDBPT0ppQW1iV3JZa3RIdzNjbk5VcWVRNXI4THFrZjVaamwreHJRSnhrMnV0?=
 =?utf-8?B?dVVpOWxQNDRRZ2piUFdlNXh5bXh0UjJkeWpSRnBxa3p2L0t3RDlyKzRPN2Zn?=
 =?utf-8?B?d3ZubXZzbmM3YW5pTDBRUklzUW1vZjU2MDlEbjFwRU8zdVc0Rzd1OGFSRm0w?=
 =?utf-8?B?UXphNlZaMHJzbkIrdVczMCtBL1NIY25FRVpTK3hneXJ6b2xlQVlkVEdrV0Yr?=
 =?utf-8?B?VHZEbUtuK2VhaTgzeVA3VkUvenhzOFNFb3puTXd2dEE0bkxjVldiRStvZFlo?=
 =?utf-8?B?c3dLT3h0Ti9lNUxDbG9iSGxUcVphRlVkQ2Rkb3h1amJvYnQzU3ZhTHFCRzFq?=
 =?utf-8?B?NEJYL1YzNTNHZDJwc2JyZlJsWkxIRG1sWGRiS1ZuQ0hCRnhUbTdzczcxOTNZ?=
 =?utf-8?B?MVpKdkVQb0phbzEzdFFra3J6d1NHSmVZSjNYNnFSQXFpWkhoKy9Wbjg5dVlj?=
 =?utf-8?B?cjNVUlJrUFhtRlFiOG9QOEtuVzNSRmRTbGhkMnBpc284Z1V2U0RMMHhVZ01H?=
 =?utf-8?B?NUJLanh2R3liY1lieXZuYjBhZDh2T0xrSk1TZnhXWlhucFBNNWk4M3VCOFJn?=
 =?utf-8?B?a3VmVXZ0NGdSZnZSRjBWbFpiamRFd0locjhHOWZta0Qva25zZUM4amo2OFB3?=
 =?utf-8?B?ODNmM1pNZHo2S2hvWXQxVlg3SVlhcHVXSWdwMFBYUVYvQU55VVk0U3VyZVBa?=
 =?utf-8?B?M2hoa3dNYjVqaHBCQ1d4MzN0a25RcjRMWlFpSURrZG5EaVNjS3E3UlJUTlJ2?=
 =?utf-8?B?RmdXRTZPVWZjMmp2NGxlSFVKaFU3NDE1N0tocHhISE5XTkJtd3BlSm52alk5?=
 =?utf-8?B?UmhQUWFZZFJmRVJoU3lwMjNjTFQ2YUFsTDlxMEdUTzZISHhIYkZFYWc3YmFh?=
 =?utf-8?B?c0x0L0EzcEZhTVYwSHpVSmg4UHd3bFptUXQ4RC9BU1Vja2J2bG5CelZCVXBK?=
 =?utf-8?B?dEpxSHkzM0tHUzBjYTJBNGFuWjV3dU03Nm9QdTBZRWMzRWFNRDBtN3pOandh?=
 =?utf-8?B?VEdxZHByeVIzYnVRL3lRaitCTXZ0Z0oyazhiUnhiNkdjajhWWDl3bGlGY0VU?=
 =?utf-8?B?TlBsUGVwVnNjNzh5YUVWaEVQeEZwN0JMaklGZ3dWdS9WT1RielFuQjVaVVpy?=
 =?utf-8?B?UDNwVVhhQzlTbzZSZjdjRGFPQjRHbjlJS2g1ZDd4YmdabENiU2tHeXRWWERQ?=
 =?utf-8?B?akRiUUErWVlENUJQb29TcFF1OEtIUDRhU2VDOXFIRkFLWjY1RUtnMEJocDc1?=
 =?utf-8?B?c3JydlZlWVNQSWQ5aTBEOGlDZlU4U2VUSllJVEV4TGsxbEFNNWR3ZmVReGND?=
 =?utf-8?B?QmV6a2QyQXA4MEF6enNvWWh3QXNTZ2cvTjN2QlYvM2NGaUtacFpsVUExUnM4?=
 =?utf-8?B?K21oM3N1YUFiYzFKd3J2WFBlMU5IVmFKSTczSUsveVZ2Tk1ENFVLZFFwcVZH?=
 =?utf-8?B?RDJwaTIvQlVZSloxTC95bzlFeGQ3cm5GdVJVYm85NzVlR3JReHNFQT09?=
X-OriginatorOrg: amlogic.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022c3b64-255c-447d-3fcd-08de8e09c30e
X-MS-Exchange-CrossTenant-AuthSource: TYUPR03MB7232.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 03:09:31.3876
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0df2add9-25ca-4b3a-acb4-c99ddf0b1114
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 88isBNQpvpx7msqMHSpIoPs4H/bk2KH9snk7esfbup47Z35cRtmTnNX29+sMKJEq3xnsrqHyJzc04nSE3OsLbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR03MB6909
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amlogic.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amlogic.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[amlogic.com:+];
	TAGGED_FROM(0.00)[bounces-230996-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiucheng.xu@amlogic.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amlogic.com:dkim,amlogic.com:mid]
X-Rspamd-Queue-Id: 4B616354F93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Dear 5.15.y and 6.12.y maintainers,

An erofs patch should be backported from upstream mainline to the stable
5.15.y and 6.12.y branch. The patch's information is shown as below:

[Subject]
erofs: add GFP_NOIO in the bio completion if needed

[Upstream commit ID]
c23df30915f83e7257c8625b690a1cece94142a0

[Kernel version]
5.15.y
6.12.y

[Why]
Due to insufficient memory, vm_map_ram() may generate memory
swapping I/O, which can cause submit_bio_wait to deadlock
in some scenarios.

Thanks,
Jiucheng Xu

