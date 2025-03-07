Return-Path: <stable+bounces-121446-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9CAA5730C
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 21:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DA043B2A25
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 20:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFBD23E23D;
	Fri,  7 Mar 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Nua/HzJg";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="QKzgnLM7"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773AC19DF53;
	Fri,  7 Mar 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741380369; cv=fail; b=UucKMurx1uQtbdgcMpiKfykPeni6mbADC8mj7ILC/MJbGKHVbA2moGHt5aN5JvAmMnSqhqGXbPc5rWi5hLeHX2wGhD0Xawt0xyRggkN5L8JfJHWRs8+XOaBggw74Qd3EfaRLgb0FjGrRB0g/Jc+jzgMJiUv9rWXmClNopzYuFgE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741380369; c=relaxed/simple;
	bh=NR02LZW35ZbIhN++Z1l8tmoxzqMRczhdpxfDC6T2lZw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GKHtgO5q3U3EjQlkZGhyLGpmLtdTriuboirfSC0G/wsLMb/5BMpaarL+TPtr2klsyy+EGHCVSG1gtpDsGaOa8CczMVL7F9d5CUtpzwwM+s9ngQv+a+wjjp+bmreq89Z3dQ7h9+6dDc+iyAMYmgPKRwHZ/P0yewXGkLgpyzOd2wY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Nua/HzJg; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=QKzgnLM7; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127843.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 527Feq1O005163;
	Fri, 7 Mar 2025 12:43:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=HQrfGrNz3OaEz
	KDROWMUTdQ2oApcwnOqPweFVeXkJzU=; b=Nua/HzJg1lpniP0IQt7KFaX2iiQxE
	A2cKGWPeE5xGGlnocniHSwzGsc65Tvn+7igjuWPe77WSh7D3YZHg40iRD9D7Kq6c
	lrlSUhgybfKopavRn7QDWcqNN5LsEr2Noe9UNAH94nIuRUD8dRi8YODTKZeQwbVZ
	gA7TukS6SeUzpGnzeHbu7zxbaPGhCjFlxbUEp7RYfCcdSG3lX1h03VrvoZAaVycb
	JFFCilX2yL+5aYrmIZLAqdYTwJPjacx3KQdfLQ2VrLLFWYm2BpgBxogdhewirvMH
	MusuNyuSXpdedpMeKvn1YqElEm6JTG0D8Eilo8VMNRaGQY5jdQp1dyEig==
Received: from bl0pr05cu006.outbound.protection.outlook.com (mail-BL0PR05CU006.outbound1701.protection.outlook.com [40.93.2.8])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 456kny7qt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Mar 2025 12:43:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCqp8sEICwzLOpuXAEZRD4egaYrNDvLcmxvLPLx8A6bho5N3d0ggHyH4kX7w2F05A9oH0ytbHCPtpXuFbe1iylihBWOR12qa3FL27h4RXQfMTI9db352fGz7cIStRxRs6ZBTkjfotyRXd2QfEU6w3jvmaeCBpQWAnQ8+LrXgZtVjyX4jpy3CSrfDoNSHgzJgcBzKpHtbPtaW5auk+VkQpgKl+KHKEAW8HKSpb4XBRWm5mJCULAaPti7j+RGv57/aTAvtKlCD7tx+owI1tJte9dHebkaGdvZvZ+RgGjZ8PMoK2Q5JRmpFQgrmBMwGvwyN8C02OZ0rniOAvLcoGWesBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQrfGrNz3OaEzKDROWMUTdQ2oApcwnOqPweFVeXkJzU=;
 b=PdEENehWB5GXWxq6nIm287/tyh3IQV3gtISMq5mfwFWOYQoAiS7By8afufrrwTaIMhPXIm7BHmJ13G5HlyLG2k0C+TpqkfZ4qtb9cTmaFrwRHh9W7M1Nj+V6Znh0NKmLk7PQ2FbArX5X6nljlxqUQyfHex/6ViAHhTEH8ZwIQPay+mWM8ms00fNqafGr7t1orw0w4u1CMr4p1dd7WJF23x9KElZu8wbLG2dgWopRkrCLzBHc9Y7Z8zJXhf+ocSsLySeFZZg//vg8p4fi1mpOIrm/A85pyzTWNWO2BAMFvWcFyND/0h1j/3EYP9jv7gaok9Zjys1tWZCBQTrXSWG4yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HQrfGrNz3OaEzKDROWMUTdQ2oApcwnOqPweFVeXkJzU=;
 b=QKzgnLM7z8XoDXvSHfGlNLyRF7BbyEGURhJ0YTY5UyepDGRVRBRoI015M6Ui78YTuIXwFhHiXdCZKbbegAciULbO3vXERtG/gDGIsI9wrRtf9982JNudyn5ouMJFn517g2lLNpSo1qH/nrAm2VkD7kKGtyXiuC77z+qfJZ5IClE4698Sle4vE+tzKXtW2zK0BoIJMGHP+Y7+66gA52+hrXAmgvShIx93XC4PWvYg0MgbYOm5M28yiIgIyc9DZdqa+6HiP/3cciFTLdiDG8MqD/UrMS8Y6sr0ubzw5u6aiNqyDxJaVfe8c01IaxnAQCigqT+hp0XH8JnlslA/kyvR9g==
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com (2603:10b6:a03:3f4::5)
 by SA0PR02MB7403.namprd02.prod.outlook.com (2603:10b6:806:e2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Fri, 7 Mar
 2025 20:43:07 +0000
Received: from SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42]) by SJ0PR02MB8861.namprd02.prod.outlook.com
 ([fe80::a4b8:321f:2a92:bc42%3]) with mapi id 15.20.8511.017; Fri, 7 Mar 2025
 20:43:07 +0000
From: Harshit Agarwal <harshit@nutanix.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Cc: Harshit Agarwal <harshit@nutanix.com>, stable@vger.kernel.org
Subject: [PATCH] sched/deadline: Fix race in push_dl_task
Date: Fri,  7 Mar 2025 20:42:54 +0000
Message-Id: <20250307204255.60640-1-harshit@nutanix.com>
X-Mailer: git-send-email 2.22.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0148.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::16) To SJ0PR02MB8861.namprd02.prod.outlook.com
 (2603:10b6:a03:3f4::5)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8861:EE_|SA0PR02MB7403:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ba3ffa-1204-473c-afe1-08dd5db8aa62
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yZsA1YyvK14z2W4GJr4yNI9IxrNBBFsg3SFIOkB3c7FIVjUr8Juu34WNxJze?=
 =?us-ascii?Q?0VzqZdHvkfDXowTHJP2tqNMCi+SI0GJBbdXn19n5t1xbb8mPmkwKSektbSUn?=
 =?us-ascii?Q?M1UsMANNPB9fvV8QBQM4UzYuYVd2rwuOp0ZnQvQJY6uxb6DMUm9GWznAl4Zt?=
 =?us-ascii?Q?qKD0Yub4H8LvQzzoyDFBETor0NJf+VCN2+MpRw3CwIUkISY4Oapu4TcjtPbw?=
 =?us-ascii?Q?nM+chV3tdKQHo4UCzR75Lcij9vG39qwPUjxLm8m0adU0KRXY1OhJucBPE68K?=
 =?us-ascii?Q?OFMkiZnwUAuZ1IrIBE7R5u4j+2Zl/eWxBUqNG0t84PJt8FCOAIRrwAmWGD9Z?=
 =?us-ascii?Q?jjfOiQTr0gTORjhc2RNqM+HcOEhZy2gMjHPBrURZFfLlxouL0cV/8Zb56r+F?=
 =?us-ascii?Q?AdyrwHxOpDbzm5LRuwAHJe02RJm+J0EbAi4kufk3hZFX3XuEzLdCiIEYLlHg?=
 =?us-ascii?Q?FUQuE+/kmQ/6ESGrfpegFc2LT1M0It3krW5U/Sznj9dxvUspMYCffkYyfIJ7?=
 =?us-ascii?Q?xCuxj2LfVxgmZDNPitIxw2bucNZ8GaF8pLqzabMIpr+9qFg95L4MiDI5zwS9?=
 =?us-ascii?Q?mugEYFhaAM5MrISwrf012mWh0tVTpyE72xuuA7uWrm7P8HeMSLu19odAo4wO?=
 =?us-ascii?Q?83gesg+zZJ8jGmBV2cbqwgVxJ90nTQsYhTZgflARlMc5uPdAIeGOhDXOXDWi?=
 =?us-ascii?Q?HIgbJh811YtQO9vB4iweDULqlsGN3G0KplgG3rWzdikLmGlFx2jCE4RwQzby?=
 =?us-ascii?Q?WZNxyeuar3ZEIwcd5KlIsXDW2/C0ieSTXN+5eC7H3g9gtvieomfC8ra/RKcQ?=
 =?us-ascii?Q?jwdfIx7gOvYV6DA5OFrwGej34SCqgx3MvIPm2foLWAdd/EThFlMXKzZsSk8e?=
 =?us-ascii?Q?f7oJ1IHW25x42psu2E4ZBFG0v1XMHArfm1ILVlzR27vRZVajCVc/45W+8YI8?=
 =?us-ascii?Q?kGULNdEpty+zm1u0W+91V59WGQi7AptejEnfrS2R9MH3gtOxPCvzSLKSH6aZ?=
 =?us-ascii?Q?GVpGEl5PSWnw3lxEmHDAvUifEtjtTUgRNlaz5Hk5xLVnCw+bnZoImK6byFmR?=
 =?us-ascii?Q?+7Bbrjn5qTp2coVNIlJBUwePhGv0Dxp0YTtXVWkPe9gVALhvmvgt7yJPSzf7?=
 =?us-ascii?Q?OhnBd+cFxeuvu+5ReLnsvk/CYTnk9jeXpt/tERoWhCEf2t8OTDFPlJzkv5Im?=
 =?us-ascii?Q?sVHa/O5rx1T6OztkxSBz7dlRcWzMDRsmXCYJXRQHv8n701zqckoUvILPLU26?=
 =?us-ascii?Q?PSdZpSjcCANbq2rW3fOk8ws7AVhkmhoPZ56W9oTC+gVkFxWlmwwTTEQyinxI?=
 =?us-ascii?Q?jjhrSoxHmzayQViHVgI95ufKTT9VXe6HslIZLcB3TLdlH+0ugGDwbYqP2jmK?=
 =?us-ascii?Q?Fv8Q/wl6PNeQdedNpj+EzqCN/2Y4KG38pshezlG1fZybY3GveKPKfG1kPSnq?=
 =?us-ascii?Q?NfEh4d709XCC5EB3T09KS4T34QPsDGTP+OT1042gfiCDGkTnnT2Ktw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8861.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjgraV1N4jBYWYFOHd7bGr26ktV42H+26ljQBsRUQx47CbvPKHB83lTjTaX4?=
 =?us-ascii?Q?ONannInozgwzC/sG2MW997wsPEhhbO1hpEJFW0jkBeUGB1ZL4Kkqt6xz29B3?=
 =?us-ascii?Q?TQe4xPMX5wF4wUQkZUTydOBu7JUuVW3jjcxN24gV1TYC/nBo4G4hXR7nEj5Q?=
 =?us-ascii?Q?pkeAEu9DcC8pvROXE1cZTGrSe+ylX3Gv9F8tpbRf0R6q/0LhI3We0jutg48k?=
 =?us-ascii?Q?fqHiW4yz+R5B94xpweHjeHfDxq9qvDeiAi/B9E1jMpUdPCgCDHCSVAgRrbuB?=
 =?us-ascii?Q?wKcRNhzIDS12B6AykmPAAjXgy6EHb0B1hBWuraogKUa7ob8Y/fOD536YJcGi?=
 =?us-ascii?Q?UXx0DjDnH6tNDpQqLthxIs4tMoO0xrpMXyb5iaVzMqTJmxGjPtY0nU/TpvHN?=
 =?us-ascii?Q?1ZTvLZPz279wnMUiengEEc4FGvX44PbwvLdZCkJTNQirSoGg+hatwNlTgPa7?=
 =?us-ascii?Q?siFKpU82rosLG5IwLEnp7AvyHWU4fkh9CFokKUU0SDfDb5pjrwXOOR8NzV7z?=
 =?us-ascii?Q?0zl9kMvki8eZqZX/cZrZSIrg+IH2/05cKOaC0USnwW7Ymfknvuh49XTm/W13?=
 =?us-ascii?Q?ekoTJ9zEt9z6DCHJth1SQTa7G3c5uanmi/jHeH9zo/vTnn8SaS9TkB7sdg9R?=
 =?us-ascii?Q?e6oAYFuEbyiGnDazJbWn8qkVBPzAF+ERwZtjBAifPZuR9pOqXhjo48ci6EKx?=
 =?us-ascii?Q?B4V/HVVybBBg+dWawZP1c7rKWmE+lEEthC5/GZsk6ooNctmLrhXKC13jeNzQ?=
 =?us-ascii?Q?bgM7m+dgjTVCDzvY6kSgj0wEJRczdf0wIi9Z9XGThwmdGQHQbQ6xtA7QuTOE?=
 =?us-ascii?Q?DIS6GN6Tga85RseIGGXNCFGRjQtt0w/iQ+cok6IJc0inDCwmWye5Q2BvRpH/?=
 =?us-ascii?Q?CPHzgeFcW4oxXLnTpsyxsl7mkyMYpusnV67vWIIXL8eDFTm5Yb4pNbhEe9BU?=
 =?us-ascii?Q?hIevi6wO4FFS0N0vxUUFfxUG9XhiR6lPWP9AjYJvxi7LWCjCyWz3qjHXQ+9b?=
 =?us-ascii?Q?rMEeSC1U/gUWv8oe9a3nnhCwYVsA0aXcZmYC2Er4iX4WetzV2pdlbd1RvsWb?=
 =?us-ascii?Q?dJIJh/CQ5iGZ+aIe0y9cRNpTqyfhPAAnBPJGdtgbNzXodhuBX2RwmPN9Aqdd?=
 =?us-ascii?Q?pjhZvCXJ8lyK8cb9xpjSEspjI6iL+idsWY8gTMe7wFUMj51C/nhU656A2P3m?=
 =?us-ascii?Q?vPnpUmcPwTCK80/zahmNGugiaBnc/9NhleTd/yKfwyTZkPn16vs/p1xzD3cf?=
 =?us-ascii?Q?HWkkYan7MEmOH26FvljrdhjUbYBjNu0oDmWig7I5aRRG+EjWNBHQZNdj8Ogf?=
 =?us-ascii?Q?LuRBqR/d1UFAQdbVa1LXzx65rexIx7OjIzDyItrWORJokILlPUYr5vP0W47V?=
 =?us-ascii?Q?O6tVtDmCpwpv83qQ/lLkcjOeQk/EQ0BWk0gurn+oksa2ktZKSBggech6Xdm/?=
 =?us-ascii?Q?zFDHsKpRkoiQifkIcdKZ167GK96yAi3CecbJhaNUJ8x5LRg3BaZ6WCWQs65P?=
 =?us-ascii?Q?nk39hIZU/MjrLTG1ut/zLjBESct839YoxLQKQFdZsb/dXGkZDhOnC4dofUJL?=
 =?us-ascii?Q?AqHS5y6GboSOT8r/5p3P+NrtYv7qHy3CTHbdXNC2t1+r96K+umiIvuqFRV8x?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ba3ffa-1204-473c-afe1-08dd5db8aa62
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8861.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 20:43:07.2011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X9EqPP6CETY4CTbW6ODUKcPL9eKIaZS6+Bxn42ghXjb9+sgoR8wxi0ZC/sf7GULsncXxlim40abz2kr9olU1jQlfZscDiue7PECqbm3nI4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7403
X-Proofpoint-GUID: q0OKclvs59Zi2IhOHrN4lC8fXgMJYIR7
X-Authority-Analysis: v=2.4 cv=cNYaskeN c=1 sm=1 tr=0 ts=67cb5a5d cx=c_pps a=Kq952KYlFoMAqHE57MuLQQ==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Vs1iUdzkB0EA:10
 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=7T9Mn912R_FWUNc41XoA:9 a=iFS0Xi_KNk6JYoBecTCZ:22
X-Proofpoint-ORIG-GUID: q0OKclvs59Zi2IhOHrN4lC8fXgMJYIR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-07_07,2025-03-07_01,2024-11-22_01
X-Proofpoint-Spam-Reason: safe

This fix is the deadline version of the change made to the rt scheduler
here:
https://lore.kernel.org/lkml/20250225180553.167995-1-harshit@nutanix.com/
Please go through the original change for more details on the issue.

In this fix we bail out or retry in the push_dl_task, if the task is no
longer at the head of pushable tasks list because this list changed
while trying to lock the runqueue of the other CPU.

Signed-off-by: Harshit Agarwal <harshit@nutanix.com>
Cc: stable@vger.kernel.org
---
 kernel/sched/deadline.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537790af..c5048969c640 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2704,6 +2704,7 @@ static int push_dl_task(struct rq *rq)
 {
 	struct task_struct *next_task;
 	struct rq *later_rq;
+	struct task_struct *task;
 	int ret = 0;
 
 	next_task = pick_next_pushable_dl_task(rq);
@@ -2734,15 +2735,30 @@ static int push_dl_task(struct rq *rq)
 
 	/* Will lock the rq it'll find */
 	later_rq = find_lock_later_rq(next_task, rq);
-	if (!later_rq) {
-		struct task_struct *task;
+	task = pick_next_pushable_dl_task(rq);
+	if (later_rq && (!task || task != next_task)) {
+		/*
+		 * We must check all this again, since
+		 * find_lock_later_rq releases rq->lock and it is
+		 * then possible that next_task has migrated and
+		 * is no longer at the head of the pushable list.
+		 */
+		double_unlock_balance(rq, later_rq);
+		if (!task) {
+			/* No more tasks */
+			goto out;
+		}
 
+		put_task_struct(next_task);
+		next_task = task;
+		goto retry;
+	}
+	if (!later_rq) {
 		/*
 		 * We must check all this again, since
 		 * find_lock_later_rq releases rq->lock and it is
 		 * then possible that next_task has migrated.
 		 */
-		task = pick_next_pushable_dl_task(rq);
 		if (task == next_task) {
 			/*
 			 * The task is still there. We don't try
@@ -2751,9 +2767,10 @@ static int push_dl_task(struct rq *rq)
 			goto out;
 		}
 
-		if (!task)
+		if (!task) {
 			/* No more tasks */
 			goto out;
+		}
 
 		put_task_struct(next_task);
 		next_task = task;
-- 
2.22.3


