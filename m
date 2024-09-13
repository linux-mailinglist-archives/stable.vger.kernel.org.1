Return-Path: <stable+bounces-76056-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091AF977D45
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 429D11C21207
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 10:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8BB41D6C7F;
	Fri, 13 Sep 2024 10:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="TcJ35mBg"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2099.outbound.protection.outlook.com [40.107.101.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF0D1C1AB8;
	Fri, 13 Sep 2024 10:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223056; cv=fail; b=ccm6UUTY8nXioP7QRyIX+urW7JMyXPOit8z0JCs1+4blxaHIUx04/+djoImT5vxOAKZjA7HihJ0Yt7bwgIvnuKX9ICcjv8F/hP6SwNgQLZl5fccRZBa7rtKfCq+BfQW4tsfW8PRCrGpZOont0bS+L2MlmYAFURZ/NjqvEeyxmjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223056; c=relaxed/simple;
	bh=xzGbFIbgdtiQNj6GoAHe1xNsccpJoGiweb4pyy5Rv0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=aaIHoMtc+gQLxdtK/WFurjfWD9fWH8iE18l2iNbqXSS0PwvY6sy2l/k098lPUA3oLG9peNf3iw/fyvS03ZaBs7fYbFNVS/gaSC324vPnecNVFYbKpdwk3pA8o6zlRzc8gnpOzhFsvDW1gNzXMyfArDvKVRIoIFt8kPteot5WXK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=TcJ35mBg; arc=fail smtp.client-ip=40.107.101.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HdhTxdqJnjfeMpq2/Y08lr1Nn102Ao5jcDXiW71ajUegr1MsfPosRf64uPADVf2+HQ26Kis6Hh+TxzRSwhx3LTIPZFL20/VJ1b7uB8zfRpVgxj72Qzwy7Y7ZSkjxnP54abOMY7+cD95ga4yhEA1kJSHTv2I9ii3iqNJ85W6dUglhWqWYr6wSCVgDbG7KThlGIpAr0uaEK1zTLS8ZTgyj1plMk5g8aHldZjoKO4HD3dsCufS63sg/AZFdV9LY2SDE6E0BcXC/GxFgjl8fnaYIg/o3ccQEgxPHNoPX/dthH1CoNq9upykbpZWJnVFPdKEWvBEB+JNHeQh9gYvYToxVzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UdeeZCB4RybyyNg4J9DnsTyumq0gIgnJOHnK1hfOtPc=;
 b=H7hLLgEkN+8OEtYMtT7RlqSze0kgHsjkALtfuLHst1xEG6Cw1/MpLhktEdfERDIFPRDrlsVrCdM/sezW+2GE6CpUEcjlFFGRAhjJtolTCECEdvNCMyk3pJ6VZ5I+Ygm1HV0xcO8djrX6G3sZAigLhhHb9kwD82ooA9TtajU/D+cq5d8b9rU9cM4svXh6ueR2LpqGh5UdVNfo1uo8GZbJ1lqRiYlCV8JOP0vrIlqhhGzNszQxq5SauNSEAY5mt2QnjhR4TUtl8ee5k73tZBT0ahPOXK7BW79f4sSqov27aNyH85h3ZvxFzzsnjjnP/0oiDr3gdH2N/xBapRqWiY2/jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UdeeZCB4RybyyNg4J9DnsTyumq0gIgnJOHnK1hfOtPc=;
 b=TcJ35mBg+4lkIBEGr9R/ERxvUgfjlJz6nO3Z2D3X3GU7lAgaqOFzcPqzNqPgFBYHLc0nTv7T/p6SCN6j8NGH9jVFL7Q0ONMgABl8BwfaJeYzZcfYkqDHrjhrqXL6Fc3WlQUNWA1EzxL8bYDFP8LXrSeGpNFXsSR2mLmrOc6lvio=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by LV8PR08MB9584.namprd08.prod.outlook.com (2603:10b6:408:1fb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 13 Sep
 2024 10:24:11 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::55b3:31f1:11c0:4401%6]) with mapi id 15.20.7939.017; Fri, 13 Sep 2024
 10:24:11 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	stable@vger.kernel.org,
	Roy Luo <royluo@google.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Krishna Kurapati <quic_kriskura@quicinc.com>,
	yuan linyu <yuanlinyu@hihonor.com>,
	Chris Wulff <crwulff@gmail.com>,
	Paul Cercueil <paul@crapouillou.net>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] usb: gadget: core: force synchronous registration
Date: Fri, 13 Sep 2024 11:23:23 +0100
Message-ID: <20240913102325.2826261-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.46.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::21) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|LV8PR08MB9584:EE_
X-MS-Office365-Filtering-Correlation-Id: 006f8322-bc29-411f-a335-08dcd3de3535
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8j83nZM80ELIPyQmbc5oyugppw8d+DMRMNl2E4BFWX+nmQdaCJHGYeSxKtFh?=
 =?us-ascii?Q?48FLHALmgvkszCOzgXtjX8YshidtJ7Ju9kh0kFGz42rjChrr+gBhIk/MtD7p?=
 =?us-ascii?Q?zQhdJkfGNb463iU+Bdyt5O5+e2WV1mxHQix0A6MMw0WYjRCol93+jj6y3Cbu?=
 =?us-ascii?Q?sweAPLgCnlLRfOfiz4TXsDQYV0QUYTZLv7mWknwlJ0hldV8SSBCk99YyFjxS?=
 =?us-ascii?Q?mNrY9UqLZEaBy+171r5O/yvfOaLj6Us6BNSxMyWiFd+6uLEtyoZoWcCJtTUE?=
 =?us-ascii?Q?EYC64zVs6xn5CLNbyXtUVNR/9I/6gJe3QxqN2snXxm/sKRttt3nucNJK6k3z?=
 =?us-ascii?Q?UN7SGtay800dlNPkKP4ZDucoJYQaw0eqzBRqa7P1KutLuY3cy0UNmmwsG26k?=
 =?us-ascii?Q?2KEUgcxZIufFlFH4kuxyYLa8maOxcDwpaaJs5xdkkVIFkbF31DFYfTPQ9XoF?=
 =?us-ascii?Q?vi7tGLJIuhw8RQVRk+b1qFWKCi+h8dDB8OSkZAFFqd/J3KD85hhxOgKbM8m6?=
 =?us-ascii?Q?BfRxKY8NjrzVOz8t8TayNyNXIN5yV77ElUAmMmciGT/2Iai1jKA4iUQOxnef?=
 =?us-ascii?Q?b1iCkMRVqJ1YMQdNp8eeUvPUXp1IPJAo3Uy+IYo9BxcNO95R7KaaheGHLbFq?=
 =?us-ascii?Q?kbf5+rjMZZ2yyZPFsnx31mGUaRBFeS2quuZI6137rQW5wAxHzSsnbI7kzwTV?=
 =?us-ascii?Q?fsIb06rpY31T4mQWqk7leAnZqvQdNllX2PXQh7QI/8hkrh/oO2AH+gdooycR?=
 =?us-ascii?Q?Tmr7sdhXuk/YzyaAXbInMm70zG1QMuQUtMTpD9Jf8TVMkzvvgsW1lkE93NRA?=
 =?us-ascii?Q?I648VlKO7g/BZX1P+pwucuvI1P+gJ9RwZEgM3X/PUCwUnPjlyQAMfEWfuWw0?=
 =?us-ascii?Q?jVkfq3aNNje8Z56mCUiFMK8QDHAXt9W2u9Ek5BzB9vEk/ClfrVGbt8FnKVkg?=
 =?us-ascii?Q?YwP+4mG+fC9vb4KIsR+LF3drcGonOyX4rK+3T0maKDkpUA2oOYTe7ID0E6FR?=
 =?us-ascii?Q?otJNr3MT9ocMz1apc9jJGxNmES18L267Saq1Jo1bIlYS5uAy/2vN9gXwfenV?=
 =?us-ascii?Q?T31/EhkCCbdoQ7raQqPiTihDOxAwL/D5H3v2PxyI8tMo5xouYxN4DRUMqnjo?=
 =?us-ascii?Q?4OI7KqEcZI/M7ddWsXIJHx/WYt8YzwmcitZHlEDD15TqxoCE9Y7WWKYm87hO?=
 =?us-ascii?Q?X7WEl5NcZlrnaVYhBeCLX4WWbTOsLUgKHmS7FESKVUMXzgXcpTxmZlkvFPx0?=
 =?us-ascii?Q?fhg6TamDEZktO8zQY/gl4TZNjSHhSXOBUtS6FMQEwR8DCPsuWpkVFHmOdOLB?=
 =?us-ascii?Q?OXUbSFY4Zm1EBpJo7T1JyKrIsBPcc4Jv23aAGAqAxYrXEKhQ+XO22UuuV+ud?=
 =?us-ascii?Q?Rb7y16ZVayXS6hYiqDNgTWPJmISBu44pRU/IQ2mN5EfnESIlmA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nKoIXua68KJ1B3iP0zJtrQah0aUmFLeEfG/ymyDMPlw/T+ubh9UYslDhH8Bv?=
 =?us-ascii?Q?xznA/fVPi131aiCxi8sQSqcWRNqb3Ib3GZqdUft6550LPc0HFhyZY155JHkW?=
 =?us-ascii?Q?fE4owAUUfTHdJo8qn6y02zif+RWBlBP0sI7Zwbe45HEydTlaXwQLu+IT9VjZ?=
 =?us-ascii?Q?mXPcLhRYjBz4IZXSj7aWQAmTJloxBLuDUeEJ4TqPr9JSm3vK3VPA1p38f7pB?=
 =?us-ascii?Q?DuTndb3Yra4iXVP5G8IVEiy87jYLg0QbYLbYBztJxgGUgkWr1zgz5cPpdOCt?=
 =?us-ascii?Q?gytNNK66TYiY2f696Cu5eudeuklHCXiKfloWDHh55FG6pXqvADUOzGbRJNY/?=
 =?us-ascii?Q?RSzsmXUXB/3Y2m4ny1YlQI8h9WddE7oUtk8t0FIv6vgnR3VKTJJweNZ/JCFK?=
 =?us-ascii?Q?6fyEYpJ88xnTvgdyYU61YV+nu+E6Hg5JfTkftok3MPo3vAbyy02dsp1bv4xx?=
 =?us-ascii?Q?Ki5kZ61gNwMA7BXOC34Z5shfnDBqo2kleDHet3ZOVL2X47BQxJUGsyUt6E0I?=
 =?us-ascii?Q?zkDSwAwaYGu3Ry1mfLN7/msC4mUa1xnURLO35/AJK7KTM9mH8pT/J3v+UjG/?=
 =?us-ascii?Q?NVIA9Vyg9v3TEWiVVCE3iV7cVnqva1RirzMcBV1mS417RxjkQW3lFmlYDaYQ?=
 =?us-ascii?Q?Kf+o+CI30ImLzNLGSWEeUcZ/CH7W/kiCmql777A51q1gehkpXggxctG6uf9R?=
 =?us-ascii?Q?485uvPYtEkIb3zq1S66dyXdQUkDQ1gh7JCp701mSBOhEJJKHtf07Q4OcZnj/?=
 =?us-ascii?Q?STeQuC6FaGOpXfoREztLXtBtUagQHmBHezuvbQzh6ExGWbaAtq7+NifD/x6O?=
 =?us-ascii?Q?bFUzzqITw5VkuDiLAFrCi0YbWZ06pX5j3xXXPuiyLQHsXl2oPxbFJe8gJK5u?=
 =?us-ascii?Q?J6cSghJIqyEUERzcx4BdkRJ/Hn9GUkPLJMpNuHPgp2CnXoKVx1ck0gfdnJWh?=
 =?us-ascii?Q?kQGSnmDzMWcFud8I3bRJfFeLUAKBjR/E91pDgbVkFhBf7VSB9OOc1njoWhSj?=
 =?us-ascii?Q?gh/4OXygfzaTaPhjxp/fwlpJ4Ywy0Q1ThARLVQ4/rq0kPYGiu+fY7Z2FA9sC?=
 =?us-ascii?Q?XjlnDyEvghBPALFTIwLBumAFrxDnZ5M3+34UtWZWzHDW3y3mhbeLuxNdEvnQ?=
 =?us-ascii?Q?OdHuGrXzZ8slDA+NXYtV4OtFmgP7jMJVXWLsUf1JRC/XpLd9HsOlp08E72bu?=
 =?us-ascii?Q?1GglN0MpDTee9iRYno8+cx1KpNAHiA6w7XyqsF1QknlLy5dKgSNnTRx5q5+4?=
 =?us-ascii?Q?p3yneq1TwO/rgxvfZ/uiKFcTPIo0hDscUvfa7rGm/DJCFVEAOFERk8fYmAl2?=
 =?us-ascii?Q?n7qQmXOxjNvh6zwjJJCVrfaA2Aw/XuAKEotIVuwuhWGF3lyQFahjKRa2Xh67?=
 =?us-ascii?Q?D/FnEfn8tsebb8jDGAHrVj4xIkF6PgWscnU4ODJG+Dmxu19FBM+Wvb5+vli3?=
 =?us-ascii?Q?qhxcQ6CHgjfYL4VnxLKQSuEjpjrUg1sVxPbHervyzOtVQf4l7WEodCv5mX4c?=
 =?us-ascii?Q?XtftGXoXpz2adYitXmBM/wfyeEoosQq14kGD0nec1af0LHdMUVfZuq4AXg/L?=
 =?us-ascii?Q?ugk+7F0r4jjPCh3beBM1Qt39ItVlMCdQdxw9mSPR/AqIseOo9Mr307K2DrZm?=
 =?us-ascii?Q?5Q=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006f8322-bc29-411f-a335-08dcd3de3535
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2024 10:24:11.1599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzoc3WnsruK/aE8zlH6xzNFWolmTbfCqqbFXU60QJqlOp+lQ4/VWLcMyAs8lKpzsZ/konlodICfSRFw9Ww2x6TTX8G3NR5gRjRLsLE9e2Hk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR08MB9584

Registering a gadget driver is expected to complete synchronously and
immediately after calling driver_register() this function checks that
the driver has bound so as to return an error.

Set PROBE_FORCE_SYNCHRONOUS to ensure this is the case even when
asynchronous probing is set as the default.

Fixes: fc274c1e99731 ("USB: gadget: Add a new bus for gadgets")
Cc: stable@vger.kernel.org
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
v3:
- Add cc: stable
v2:
- Add "Fixes" trailer

 drivers/usb/gadget/udc/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/gadget/udc/core.c b/drivers/usb/gadget/udc/core.c
index cf6478f97f4a..a6f46364be65 100644
--- a/drivers/usb/gadget/udc/core.c
+++ b/drivers/usb/gadget/udc/core.c
@@ -1696,6 +1696,7 @@ int usb_gadget_register_driver_owner(struct usb_gadget_driver *driver,
 	driver->driver.bus = &gadget_bus_type;
 	driver->driver.owner = owner;
 	driver->driver.mod_name = mod_name;
+	driver->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
 	ret = driver_register(&driver->driver);
 	if (ret) {
 		pr_warn("%s: driver registration failed: %d\n",
-- 
2.46.0


