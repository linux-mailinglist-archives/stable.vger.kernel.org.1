Return-Path: <stable+bounces-233562-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFa7KPXm1GluygcAu9opvQ
	(envelope-from <stable+bounces-233562-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC233AD870
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 13:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C71730221C4
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 11:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCC63A784A;
	Tue,  7 Apr 2026 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b="VBtCr2w6"
X-Original-To: stable@vger.kernel.org
Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazolkn19011035.outbound.protection.outlook.com [52.103.68.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D886387367
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 11:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.68.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775560118; cv=fail; b=BZwW8wOag9DjhJTdpIYkjRJ6Y/g5wtfoRVskXK8Yew7ZJx2260dEoSGEQfJSj5b1Z2MWmdu1OyoHitt/SYyBxfUDGJf+nYvdZ3z/ZHZByoNwxeT9pEsUD4LmyEtqxrGVb+hF9S2p4XSfZOLszQxKVn38psgRt5OW+VnMNbFtJfg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775560118; c=relaxed/simple;
	bh=+2jNHbJgSimPpAvyghrg67kYyICmq1idvgzfBPQJOyE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SQBwbuzW28PpFGhfacHZpil2e73jejRgtCTJPFJ/YdzVhdjr2sBxCSICl1gFxYFLYPNXEM9zbcQ09968FbVm7R8DZ3pv1Kz08WGD9nwbjVS2CmMM9fFAl/maDB8u3lbq2+7FbOb0HZsiCGocOmaXjDFf0kazoee/YqypKXf8a7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com; spf=pass smtp.mailfrom=live.com; dkim=pass (2048-bit key) header.d=live.com header.i=@live.com header.b=VBtCr2w6; arc=fail smtp.client-ip=52.103.68.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhm98c/MwM1GC2QCgklg/N8WUc1x4PtZVDkSqKncPl2ljdWnKiDL/j3WJatUECBxP6JrSNKestzS7NlmDXntueo2XJ5bUWsiMTHI2Cze0haKvrzREccwv2+/cnWajmfneITXg0m9yyq1s0NVWba9YsqHHLxNhY2YqLclas4z/EKloJjQzuNKWJpvP4IGq5nvOh6GwXjcEE2BSC9Qs73Kp+1YqJDQlsulFsXUAdonkdVy5I2JWBzyOmWUhvok6wQQKJeGb/eUCHeOreU9K4ABFPo5JcxahNel0lEWZwiUZBgYnDWka9xmit2trBp3nDV1XPh/kYGCibylqXJLXpaKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MMVxN10PDuio2Yzh//096J0cWf2nQ6m8DkjI2goJvyU=;
 b=tUX3UKBLPFJR9uOusHyYrbwbOb7zUUT/ACndk5VU8Xx542sc/OXC+wZftmRSL7NpZsXrbVpDSkGQ4wb186v1TOsbEfExvdsxmCSRPfUpIcbvN1v96evZ+I7fO/Dz0bK+m056Z3AtIdlRC3YxlmxNBXqD2bcPwr/vIMuRJnlycLhAPGmDEw3cNdK3q3dBp2MyvbfzGrhh8AmpA/sPowQGxMjsnMSV039VzFyRcb5mMOBJLj8km4bALgJNgEP0DlAAOGVvjjcWelqMwUBkcOySN+kjZ+/0XuY5R7Pv60JaNXTd9un9WMG86q+2xFcq7d51C2BaFfRy/Eu1tMnb0ZQRZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MMVxN10PDuio2Yzh//096J0cWf2nQ6m8DkjI2goJvyU=;
 b=VBtCr2w6Q0LiqEvQSquFXPeZM0MF9J2LfyzLuTy4Xc1zrcbH+UJFW5KACL/ZyUqjg0jwl2jBYlWi0TUf/gytTwuD/vU9t2jjzM3LVRSgXNqmQFnHgzclHQDKgew/kqo77WQnMO3D1hcfB1YktJbOrwlH2c5+f+STP4F50CiIv60kmOCVxVJEQXgRD30jKkTLP58Gnmjyb0qJPZtfjPSSI6Bdo9ZhGQmLS75ms4LSdc82hj89xL3Ok/7GI/wdmFCWEQGJ55e+380H3qW59EAzQr2iux7mZHwZar4liRvYOhkQYMuelL+1ZYkok7aZ3VjCEJlVnbkdOBB7DeQ5bcT4Rg==
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18) by MAUPR01MB11530.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:18f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.21; Tue, 7 Apr
 2026 11:08:34 +0000
Received: from MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295]) by MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::1fed:9b0b:69b:9295%6]) with mapi id 15.20.9769.018; Tue, 7 Apr 2026
 11:08:34 +0000
From: Aditya Garg <gargaditya08@live.com>
To: stable@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>
Cc: Jiri Kosina <jkosina@suse.com>
Subject: [PATCH 6.19.y] HID: appletb-kbd: add .resume method in PM
Date: Tue,  7 Apr 2026 16:38:22 +0530
Message-ID:
 <MAUPR01MB11546B54A7BA6A80110B9984FB85AA@MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.53.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PN3PR01CA0172.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::16) To MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:19c::18)
X-Microsoft-Original-Message-ID: <20260407110822.1363-1-gargaditya08@live.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MAUPR01MB11546:EE_|MAUPR01MB11530:EE_
X-MS-Office365-Filtering-Correlation-Id: 286ece47-de93-467d-5a4c-08de94960232
X-MS-Exchange-SLBlob-MailProps:
	KW6s2gPZH1eaZMsDFrtnScTYUpn8LGIXHJmomHoxOg/Vw+W5PFtmu03HLon3vpV/ND62W8te+DxhPZKrmKssQ18AZwn7w/uVSDuRDcRreZj8AeisvCMZ6FLfIcUkuV1h2MJSE32jxKVPYrjmesFkS4Nkb6gqns8YC8pw+Na4YsNB6a6f3FrLFCaYaNRmDNKQ5Wc05Lbl0xErIJG2zLTiuNTJi8qLT1jTL0dcQYEDw+ew+gS/jLqC5B0lcmGCE8gMQwX4gOBec6MJkSOPF4baI1vFsz+GbMek9ESZFVDK1gqCzr0wWCDTrANacW9DE0+Zfuxa7ilCer0ElcvN/2lbkZdMyCFN46WDgBpvmf54r7KBjsFRU+/oZPuYTzzHg8UhtY8ojNrYMI8FdO9FW0M7zjNArdTULpUptOB/zSIQfPEDWiqgXJC4WhcodhLvRoQJQUJ6UVZ8vilHUmXrNHI5CieEK6eoOvtZk2vyy3guxuzTDyIZOtwKr3iXTEno5yMa82LMz57C633sABfsaV58LRwkhx3XhWmCM42S+0NNxLq4dayaH9zpel3s6VjQKfWbggpXu5yU34S/x6akrPjq2Vym1BKI5LemPn9s1EgDIPt72FOVr1IkR1hBeugUfeRIrhX2pWzBeb8mIm1qmu0pfd0WgshBQRVwoCdyfOV4zzX9ojTiVWmrLVDnpra21mw6OBQJDssK4phQ/VU1dsC6yPXg6ZR/EAaRemFwDgSxPTU=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|51005399006|25031999004|19110799012|23021999003|41001999006|5072599009|5062599005|461199028|8060799015|15080799012|40105399003|3412199025|440099028|26121999003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5xZ13aiAkR6m1nOMQ/eIVRISKakqb3Kej1DadIC5XIyFV1c7RBPSeFILGdJB?=
 =?us-ascii?Q?a5KGev/WXsJO+cBNQ3xhMIpA004jD8A72IaPP2khLkaN68CPhymkTSarQcA0?=
 =?us-ascii?Q?WZfztl26B4OX9/nsGxlTZFq40rURUimDz6OfqBkrPqlotFJYOr+c+9FSJL7n?=
 =?us-ascii?Q?bljhd09bPeq53BytWl1I9Q7XX1h1CRn8QB7p7DAZ+4HKbvBw94VwJ2bRwj1U?=
 =?us-ascii?Q?6Xf84W4qW5ZaPjIQcgMYyiDYI2tXX9FDS+eD58Vc6dzCv1vnynVc5e1TiIkT?=
 =?us-ascii?Q?4VpGLIBnpjF7G4w7lTAcOOrIKpv1SP7SQ1Zq/2kIlANGpExn/MSwGray+E9D?=
 =?us-ascii?Q?JpXr1d/kgZ6q4T9N3T1RCTOaUzJtBeDZrW8D1pIO8g1h5V3T9NfCSb0+6dKk?=
 =?us-ascii?Q?0aRBrdB7lSUVY1TYGdchyR++vizT3dVbJZi0XQyJLoE4op5dsJfelXnBg0pI?=
 =?us-ascii?Q?fC0tgvnvOm5XdUncbYviaE0pjt3yxNE0J6ntKuI+lwnpXB8RSUgcep8SE0Qq?=
 =?us-ascii?Q?T1BchpNeIzaFJKylOf9h3RTv24atmqTnvHnshm09Lyn2/t+ME3PkakjmKSqh?=
 =?us-ascii?Q?PNGSXdJPLuYN4bo7w0G52y4gpFQVwtoKb2etaNh+dPleYa8YvJldXgDDyH9u?=
 =?us-ascii?Q?VuMBYqtLqeqYJ+8HUoDry6hSlHOkKswTa2IUNamQm1CxcagL+yd25IAWdNap?=
 =?us-ascii?Q?jat0wmjOS+XJjKwv4hUNsbVoAUifSMLapbqiUBxIyMHILuVHbeSFuBHFuNfD?=
 =?us-ascii?Q?GaXacPt/KTQ2QPJAgsJMBXBxZk//0Qnxn9jNXpUmr8ceLfh/5YYZ4oBmHbyQ?=
 =?us-ascii?Q?IwfH2W8KnHOAOM+d42rR7YYw42jWo4IP2bwQliKxhNqLhrFyU3u4kgRi4t+c?=
 =?us-ascii?Q?EKb69N45u5v/73gGvQOuJAjoutqw7UTPRkJZB2y8OWvtHFxY3ZQ0NEqEeeJ9?=
 =?us-ascii?Q?P/vFTXUWXFT4IuV7F4HEGmqtCBTW2HEhKX2VdCYRxfkF+W+B+NTaV2lk5CV7?=
 =?us-ascii?Q?lDRbEw4/3x3fDCOZWKg1dz/fRIBeH+lxOStqc9Iz2U4M9Wc=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KEyvKpeKLBBXX5T9zGrR90JkFY0KzJpmsRRegVY2DeV33rMIt+6KmlypF9kC?=
 =?us-ascii?Q?aFoDpwzkTEWXA4ukYdhpyLYmumGfbxfhiKX8FRLZrJbicADfOH9G/Xz8XhqA?=
 =?us-ascii?Q?UsU1KRbDyyr6pWbeS9cVLyTLuYw6QgU5xOVDtmActzwSgS7B36E/KRPH3Qya?=
 =?us-ascii?Q?U1BOUNEGYPGBvYbFStBl1rW1Ik8cqVdK/U0fkGTabYZgdXsLDruxhwLtaD8M?=
 =?us-ascii?Q?gVb1oA+Lv6hhkHElDkKQGiZlCyZTsbB8CaOr0LnYQd4rwkJ06NWSpbs7OByx?=
 =?us-ascii?Q?L1KDmcJmjheMuf6tiZBAuoootx30+0QYD7i88CXrD7Opxre2ud86bu6FF9WN?=
 =?us-ascii?Q?VYgNAMwD0217jskIy15LzfvowKEsH9uagAMEyPp5q9xn5Xk0EGoCzcg6HoFD?=
 =?us-ascii?Q?Pv21hsn9FbjDeGKhpSJetbrfbW2UsGmtunRzd8QGzBKxATrP4wasSeJ9G7nW?=
 =?us-ascii?Q?xD9yhGIovS797pXUMamueHOPYX03mD90lTr4ftmsaWJSu/2PN+7MtI4ay2vT?=
 =?us-ascii?Q?H2Ji0JoMiNZzwDf/I+ORgjKGgC/SWO/jhbRuOtx0xHk7qtWADzCeuoMZHQMT?=
 =?us-ascii?Q?e76rfOacAFf+daQb8lXBS/NDJtFyzaF+SOGu007uQv6M2w6vnX67HHQqSGnh?=
 =?us-ascii?Q?+T9OoVWAnTlI/6WoSRw9kpRB3kW+JIUCmrK5FnVMn/lejBi0bI9kpoahELim?=
 =?us-ascii?Q?cXDCjaU70lWX1BFVbRnS9oS7Z0pJOWlUmAe8NS0JBJ9BNOz6PlpXndf7M5i0?=
 =?us-ascii?Q?GBPr65n2aUTmiJAlWwf5fIgiqNZbmok6nlu18HsLs559Fc9Q8y5Xzf4OePF4?=
 =?us-ascii?Q?HsA7Zujyn2yNLb7W+nballOXE4qvh/N5/WwfnHeb99bAxQQWacMkWk3NckFO?=
 =?us-ascii?Q?QzgNxqJptJ6RwV+GAshDtbEdqVzfyU69WuuP/qil4WeTS4aMk5/iD+zGBzq5?=
 =?us-ascii?Q?KcvdusFbROAT/hZ3dstV4frj2G+acBCUaVSta8EzGyr+VxNeKv5CiHNWVRlR?=
 =?us-ascii?Q?oKVJ0w0GRFYH/RsgLMVFIUxQAuTDm5ebOh1QXCkw8FjZhjVZ4aKeEPmOSlt4?=
 =?us-ascii?Q?Bpbm8v6sqf4jr03sQX1bAK0LOuGb26G77zg2R4fKGgQk07NmTZvyjS9J3x2g?=
 =?us-ascii?Q?jonntdFiuupRJAiRqBWwBMlvPjxW7J5qHut5HyOWP9qnrA7xA1yoGTRcSV78?=
 =?us-ascii?Q?/Lepnx5tAhFGwC7z0bvT1R0DDK0O92YMhjc6/xbjhiQrhjFtvmfhL4f/NKx+?=
 =?us-ascii?Q?uXZ+TjpBwUJr6zfBDpc3NOHS3NbHINhbeV9QZBd89+LkBvut5Su3dWWlrcZo?=
 =?us-ascii?Q?u0KGs0QaG5AfB1qmOZKO5a2U8IeTW40eU5RyWsMH/lblF7sezP+bQJyDQMx2?=
 =?us-ascii?Q?W6rRluMhGpF1AzhjwfxGuenL9+dKYW1kf4tsadOOfIm505sSL9G1hDH/sXmT?=
 =?us-ascii?Q?/iZzrzw+ikD9j49jBe1ylChSUPKG3U3U?=
X-OriginatorOrg: sct-15-20-9412-4-msonline-outlook-63b91.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 286ece47-de93-467d-5a4c-08de94960232
X-MS-Exchange-CrossTenant-AuthSource: MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 11:08:33.8776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MAUPR01MB11530
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[live.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[live.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233562-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[live.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[live.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya08@live.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,live.com:dkim,live.com:email,MAUPR01MB11546.INDPRD01.PROD.OUTLOOK.COM:mid]
X-Rspamd-Queue-Id: 4FC233AD870
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

commit 1965445e13c09b79932ca8154977b4408cb9610c upstream.

Upon resuming from suspend, the Touch Bar driver was missing a resume
method in order to restore the original mode the Touch Bar was on before
suspending. It is the same as the reset_resume method.

Cc: stable@vger.kernel.org
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
---
 drivers/hid/hid-appletb-kbd.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-appletb-kbd.c b/drivers/hid/hid-appletb-kbd.c
index b00687e67..0b10cff46 100644
--- a/drivers/hid/hid-appletb-kbd.c
+++ b/drivers/hid/hid-appletb-kbd.c
@@ -477,7 +477,7 @@ static int appletb_kbd_suspend(struct hid_device *hdev, pm_message_t msg)
 	return 0;
 }
 
-static int appletb_kbd_reset_resume(struct hid_device *hdev)
+static int appletb_kbd_resume(struct hid_device *hdev)
 {
 	struct appletb_kbd *kbd = hid_get_drvdata(hdev);
 
@@ -503,7 +503,8 @@ static struct hid_driver appletb_kbd_hid_driver = {
 	.input_configured = appletb_kbd_input_configured,
 #ifdef CONFIG_PM
 	.suspend = appletb_kbd_suspend,
-	.reset_resume = appletb_kbd_reset_resume,
+	.resume = appletb_kbd_resume,
+	.reset_resume = appletb_kbd_resume,
 #endif
 	.driver.dev_groups = appletb_kbd_groups,
 };
-- 
2.52.0


