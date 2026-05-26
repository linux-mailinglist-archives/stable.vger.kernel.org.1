Return-Path: <stable+bounces-254350-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBBYCMaeFWr9WgcAu9opvQ
	(envelope-from <stable+bounces-254350-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:23:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 596185D65A3
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B63C73020E02
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495A33F7886;
	Tue, 26 May 2026 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f5MI+4iC"
X-Original-To: stable@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013071.outbound.protection.outlook.com [40.107.201.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C827422DFA4;
	Tue, 26 May 2026 13:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779801188; cv=fail; b=sudeKIYssWV4s/wo8Bd9I4KIZgu35IRsykrTMl1anykPO8rH24WX1+AiZCTxnWrQevGiOZ7w2ijDCQK1QHstpmk2R/C8CPFl0Gd0orNFkq0RvI6Xwp3QEE3IeyD7T312HmPVr0ZbN55v6YpuwSZ5Q57gSaNbAx/NV2fSr5Q2qsw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779801188; c=relaxed/simple;
	bh=bxaz43QxnYh+XVlHygMMuA3drr3oFfcM1bxOfUvYc6E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X17RSh86xkLJQeLSBGpNNeUGJcYkGBCPxcpyRT/Q8jn2/FoYk+OFK4tb20VDP8bqbVfRDQ/e+ahLjwS81bk6F8pyknTYy9WrA2oGKR0yzW3ejP6H+E+RnsKvkjfSsjFbebsK/pvGNiXzV3pTUTqnz/pdonQGreIn2ArpU5yxEDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f5MI+4iC; arc=fail smtp.client-ip=40.107.201.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGQ/b0E6mJYhztG1wrIGRtSckN79Oum7azdpHk3tiiZzefsxalfx+M60+nwsOOznx3ZDiK3S0UOz1zRSbfYzMYW+ohuM8mlw8pvJGxpeJjae4V+CrKw3UeLcuCqpq48IF3vKth5owjaAu0oqV5Weu4AB3oQuoKWonPUeaO0zAJtQ9iygVZJ3KeAMjc4oViQHSEHKy5tYAmI/Q925b3ZOWYBa7o/NzWjI5I++9NSS5AEMFsfIL7U+x0e/3ehDSlmqkNoMO5iyGG4d+sK8Z9idlXWN3rs+2ZwWzg6VnRgMj1zdp1cYDPiQ2X43NblbbdXcJyWDH6DEkuQwQDlVKC+gkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxaz43QxnYh+XVlHygMMuA3drr3oFfcM1bxOfUvYc6E=;
 b=glUKyoEbN6mMi/IqPUgcOCDxCsGBjPUZUFVd9VC2vLNvoxbw8zbFPocuvNUVWy9kdIbVwZlhMmWcFDe/jRex/FublFsfYSsDH4cPqSc5eYQdvt2jpI7LVGZAWnQN56eSpWI5FdGQZ3NMDUQTezf++b01tLTevtPD9DlEt3zPXngPnJk604Pz7sRYhgqpy6D7123KtDU+5u3sXAfaYPs2JEKoTGEM/7FfmYINuqbvUcQW4ziZv+a7XrHt5nznZwCKrQO0faAK5bX8FqWzp1qFiuNNoqbYHvv0BL8WW26/Ksz/3iAoDgGjs4jBsAY0yB53MeDen05iz6mWV3mDeMJ/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=leemhuis.info smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bxaz43QxnYh+XVlHygMMuA3drr3oFfcM1bxOfUvYc6E=;
 b=f5MI+4iCP1hyIEpPizwWfWVcp18qInCpvF0Wm2m1TELuKyCBYI4ALgOGoeFwKFQAjFFRiJEu1ZbhzCA/g49ov5S1YnJAu/jab9d0BE5Yt9QETAh/eYkBkWO5jiFSM50eIXN3Cj5tl3zC4XKs/L7f66/Bul75hLzt+eioSm4dq0SKKrU8yu+J7TCFzWcNEFSTzoyG9NP3iDcIdOrqprCC/JgLE0HgQLAr2Zhr+YWuasbXhgeGZpoqHI98wPWCtdSgwMoe/XYU+EggMk+RZse9ZzdtUgDgLpZ+R8mu7xK7Th2ozeEU/ALqVesIE5Ffp77vmlcOiQOrv/rTsmGHE4toFg==
Received: from PH1PEPF000132EB.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2f)
 by DSVPR12MB999150.namprd12.prod.outlook.com (2603:10b6:8:388::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.21; Tue, 26 May
 2026 13:12:56 +0000
Received: from MW1PEPF0001615F.namprd21.prod.outlook.com
 (2a01:111:f403:c903::2) by PH1PEPF000132EB.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.11 via Frontend Transport; Tue, 26
 May 2026 13:12:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MW1PEPF0001615F.mail.protection.outlook.com (10.167.249.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Tue, 26 May 2026 13:12:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 26 May
 2026 06:12:30 -0700
Received: from arpithk-kernel.nvidia.com (10.126.230.37) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 26 May 2026 06:12:30 -0700
From: Arpith Kalaginanavoor <arpithk@nvidia.com>
To: <regressions@leemhuis.info>
CC: <arpithk@nvidia.com>, <brauner@kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <olegchaun@gmail.com>,
	<regressions@lists.linux.dev>, <stable@vger.kernel.org>,
	<viro@zeniv.linux.org.uk>, <willy@infradead.org>
Subject: Re: Subject:[REGRESSION] fs/qnx6: incorrect pointer arithmetic breaks dir scanning completely
Date: Tue, 26 May 2026 06:12:19 -0700
Message-ID: <20260526131219.1683509-1-arpithk@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <28aa7450-e4c1-43d8-acc8-16a95df1d1a1@leemhuis.info>
References: <28aa7450-e4c1-43d8-acc8-16a95df1d1a1@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615F:EE_|DSVPR12MB999150:EE_
X-MS-Office365-Filtering-Correlation-Id: 9317cd7d-2759-4b33-de74-08debb28802e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|82310400026|13003099007|56012099003|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	WEmps/DJwkdBcSjMVaz0fsOI6qdLgOrtHwvUSpwFppsgvjtgj5/Nxt9lNNTL4fjt6LhVJuND20F6z43Li5W7ja/Hli4KeYSUAeU3MtWMJnHI2vjJBe7Nu/j8wr8Lp9YGAmqQcGd/3MzpE6o1TqcYNymvDLY3xpyDg1nbaqfxDa773wSqvSdtAJQjQHhwyvaldiIrVNTF5wucIUK+YeELIWcjAjHnw28+z7pp8QyuiSJqjp0pFQTZfULww22friaPlxY3uy261WDDbKBtRBue+ryV7TxP09PTP3h4E4kChxnKxS4cpa6OTAcJuFEP2WqnmenWGnyn23Ad+Zl4kFMPZiUmuFggJde5cW7c+ri+hpEh7ieTUS1mKjAIccIJfT+00JbI8mA8MC64USMDUQpiqbrNRC/R7yoRjH5fcEHXhTeEjwWzfI2YzX5KOLmp9eZcvBgz9IhUCEeXfF+54ISRbzpjE9zVMvn3mnLYX93UHLArBy2JTfjwRzx9/Fop4pHyaWm0Hx4+1SEbJVzd6DU5tTKhwyP9XrHY7BIxgKRcOlk635om1YV5rsduRj46enQP82o4VgW4bNPef/PraKGGuD9kLkgv0nZsQ5C1iMFhc72vIcwNyM1i6CCg7qZ+c5ucJlvg0HVCD76dA15iYTAAXNbWEUO5rvx6SkdOtXZYjsENW5IACZKZ8bJY6SeUIG2rOhf8aF536LGotpBUpLMHzjSoXPWG1GzybibsyyAf6z8=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(13003099007)(56012099003)(18002099003)(22082099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	2ueNLAhH9HQSxUYR/KCuiWeEe8eFD+eoyo1WVTgG3AwrfuXg1nhG2Su/im+8lOFFwrFzFbr7GZpQ2xy6T/w1MSIU2YUfcru52c9S63Sk4GYFkSjpOnFA6bYw/iLnOEgxFcVv0UTP1t0I5tuWkueHgLDIioOv5ytzGdcca803JQ71jp4VKGp6PtPJJF6AUrOuCF3aygjypdQttUaoMY55Rz3NC11IXMrqAKOspkfcKESyekkgtZlNA8o8zjXAtuUzYL+0RNyzNgFiatbWXAbBqBDgFz4K3s/3B+WJgVuV8ys4ftxCVb1MwJQDUjSAATUtkAA45tVrTgznCNGxGfPHu+mpcuA/xuyPlCp1HoSdb/3VkA7dzoEuE+eWZKGGiKdZ5RtG2geayW9bqXexsXHEfvrVBbVRxiiTia+n7jphHscY2hFtG+qWj1VoweFJ7JR0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 13:12:55.5649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317cd7d-2759-4b33-de74-08debb28802e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999150
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254350-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,gmail.com,lists.linux.dev,zeniv.linux.org.uk,infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arpithk@nvidia.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 596185D65A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Thorsten,

I have submitted a revised fix for this here:
https://lore.kernel.org/all/20260526123858.1683035-1-arpithk@nvidia.com/

This follows Al's suggested approach from the earlier thread.

Thanks,
Arpith

