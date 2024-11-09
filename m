Return-Path: <stable+bounces-91980-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9099C2972
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 03:12:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7041C2174E
	for <lists+stable@lfdr.de>; Sat,  9 Nov 2024 02:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B852E83F;
	Sat,  9 Nov 2024 02:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="ewWYom6/"
X-Original-To: stable@vger.kernel.org
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sg2apc01on2120.outbound.protection.outlook.com [40.107.215.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD8DE1C27;
	Sat,  9 Nov 2024 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731118364; cv=fail; b=iwSO3jD+bXzs417XZFUJ8oP2ntppuA5Lt/OtyrdJRfnxpxdvW/gwZLDkfqIPW+i/PHTR/tgMe3Mf/NnG+BjRgvYLD2BP8apeWmZ/S68pKCXE2YGtXlJj//Sc/6cz/NNbjbUEFaz4gcwrwwEAx/xoWcV/i+7wRk0LyrqfpbTlzbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731118364; c=relaxed/simple;
	bh=WN2JYf11YtqVTXjlzTw8cY3X1g2KRnq6RNcvIDXkkZo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=jfwDlDAJKVrYjiNsqrJT6BlDB+GlUzCaJPDmhlONItb7egZhQ9/Lu+/5lSJpsRshrNVvQLx0Nu0ISc0sXuOT+YFvIuJB9M05QstZBDtktV6lc1pYCZiY/Z7T2KIzM9k2BcLjCxJsXQ1M8NxFnUTaW/9X29qDZeDyCgczLugfo9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=ewWYom6/; arc=fail smtp.client-ip=40.107.215.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IRexeCqa+4IMdesacgZw4JO7tnIaNGLU2RG6P22SMPrsRdnXhnJw/pKRQh0jmtr/y3qCD17SFfHiwNAecYWb6pZrIFQCOTIkA1m4k06s2IUMT/SIfEtYyx22TJYa3/xb9vTFxCjm2DRZznZzPDtV2p5WkV2jfmSNmotOMbo+OFMLks/REupREqMPKqVEjcFAT29U8cB0/9WkKprAmLBuu1SqWG6D/Sb051hUnR0NmluIQFR9DTd87blaSPlip4A7gzizfcUYa9wzek9ZxMlhcQFaETX3IxIghW5evgHp4QBiUMCs+m7New1hhmACUDgFth7k2xSipdga9GkUrLaMQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhrDx4mG+yFOdtrIOhBTn1smP3k7X7Y1nLy6672vIeI=;
 b=o56oMPJNyobqQrrVmGbOMDeY1UEbRs/CMHIJ3ErJDpshjgcwTREfeg1D/N1ToBpQvYIezwEV9oeZvByTi0wgA5kVpkOJImvR6EBG8gGk8qRiluXR1j37vddR+xWrawXX8qwVksFoSfH/Frh3mW74tnr5Pk0AYhU+/Fube9wWGQknpadRDtphVyljSznFiuTg9/pAdcBmF1MPcSO+mWdSCPxQJxvKlkyX/iV8efUwwh/Ef/nCSgZcAIF3Zb2ECvox08kg4/Y0CECaAdARVvStsEHeDcY+CEWo4iUSdzJqbtuNWx9M5TH7FW3A4Y3kYsKzChyi0cSmbmqmOpJzy4FZxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhrDx4mG+yFOdtrIOhBTn1smP3k7X7Y1nLy6672vIeI=;
 b=ewWYom6/v+8H8rET9tZCQgGpDTTaaJIt/eMw+ZP/8H7p/lf+DswGc29ccDhVkccRX4VOebvNAzaKU0S5vPajpDYuAbEOvUS/rlhHQrKherl09+gMi3S6EKC5xr4RjTorMQ5hGhYsdvtykhEdZVxWq26IAAjqS2bKNNKKrZwUuVaVP/p4lanpSpmNt/lCQbTIhcZtA3ffjeZsjzFDdECWTS6iI4zq9pnpo/kXh1Ydc1+cnLJs9SgcEWSxJ6+Apq1IZegwMR01FJxRljuRScJzzZ9KZG61j0uBrOn28yrchSlv49y7RhxUq6isBig6WLyPCxRilLThK0eQI6OBYOc9Qw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13) by TYUPR06MB6078.apcprd06.prod.outlook.com
 (2603:1096:400:355::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Sat, 9 Nov
 2024 02:12:32 +0000
Received: from KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82]) by KL1PR0601MB5773.apcprd06.prod.outlook.com
 ([fe80::b56a:3ef:aa9d:c82%4]) with mapi id 15.20.8137.018; Sat, 9 Nov 2024
 02:12:32 +0000
From: Rex Nie <rex.nie@jaguarmicro.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	angus.chen@jaguarmicro.com,
	stable@vger.kernel.org,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: [PATCH v2] USB: core: remove dead code in do_proc_bulk()
Date: Sat,  9 Nov 2024 10:11:41 +0800
Message-Id: <20241109021140.2174-1-rex.nie@jaguarmicro.com>
X-Mailer: git-send-email 2.39.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To KL1PR0601MB5773.apcprd06.prod.outlook.com
 (2603:1096:820:b1::13)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5773:EE_|TYUPR06MB6078:EE_
X-MS-Office365-Filtering-Correlation-Id: 93d17355-570a-4969-2f63-08dd0063f7f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w/DwCnsCdeb8E5OIzowai0qGwlx0kCuNzGDWsTSbRrCW26TqOLb58SGbDm16?=
 =?us-ascii?Q?d1ImHlSw8P6wBi24fRBwZBWDNzmmqiLiI0pZqop1OTRpQWSYsJIdVg1rEq/f?=
 =?us-ascii?Q?VzaN75sqfIt0avk1pv2kataT2+ajxjW7XAoeB4WoTVP1oe3b7yDOeT1/SPy1?=
 =?us-ascii?Q?HytvFJLNJT5h6GhBzFKJmmqG75Nt35GJULLh4ABxu4IOeGthgznRrkmZqbfJ?=
 =?us-ascii?Q?FqHObi54tXA5k/OfF/pS4qATh+zAnssdM9JxqN8MeTRn66oQR1kQSj63b3Gk?=
 =?us-ascii?Q?jC0Z/77Uh//gBR3LrLykmFd7/6d96oofl8aPaFMshTwm9mjL6Y9ogNf/vUXp?=
 =?us-ascii?Q?3NJaUFXghd46zBW3xuAzEGtHjr3DraCOf7wAN8Xlbx/srqApqRy0DzuEGfaW?=
 =?us-ascii?Q?qSnROCXh1ae3yG9iHDAxcfGydiF4zimN80p7xHloGSvvDjQbyLbShP8w9VnR?=
 =?us-ascii?Q?wYAlvlZeuneTVEJK5ZoqTpT3lee3sMR4JM8P4poG+7jRN4uVW1qhJdF33OM3?=
 =?us-ascii?Q?OLNbtaqUdGADxOhjCjZYz7+ZlzrPM2QRvApApjqFu0XiC4FrGlVv30J+Oxn+?=
 =?us-ascii?Q?y4wDnLto1QCRNO2uIocrmr82jxnNsw54bvvEUiWcA0VVgeyXz/JSLNf1YR8c?=
 =?us-ascii?Q?8HMmsW+AQ/GCQ/l7zN2PJ+Rn0vG5tP2CKh8M2EA1rHnTe5IXl9NaLa1K2z/V?=
 =?us-ascii?Q?XZvQsa0SSeXFtpRUhBnq5OSDSRocuE8aoFPhqAbDxRyZ535nq/5k5mLLSj3o?=
 =?us-ascii?Q?zMT57ge+FA/qElrXtbgk1dmsJoBYAJrz5xq538jEiQm5NnpzA3Ui1NxDpSEa?=
 =?us-ascii?Q?Q0wzgI6nf8di693gNy1Oo8aWnB8gb2wNT3LSqQGH+s9Y/YramTnIpunvlnVn?=
 =?us-ascii?Q?9E3pormCRpnAG0JNi+ThE9wvqDZATUxa7z2AZq2qmgz8bVIqWGAltML3OmbV?=
 =?us-ascii?Q?nj/Bh96puxTQJ1RScg+C3ScG4ZFRCOmt+zst5lg1LnSb7GJ6lpDhzzUNUv5v?=
 =?us-ascii?Q?knrmj9T6QuQSqtXgfFxgAoJ0zRinf0K67aD2VPi8Bu7J89QGFNj1/+BUPCTx?=
 =?us-ascii?Q?8ROH+yNRAiKCnTUxP2hPTa/H2+hmeKcCZercSilg5dnDPOwR7Wi1SXhi+XOm?=
 =?us-ascii?Q?CSf/4LBYsFiTRB/x9szmU7lBTjqiBz+P19rw/NwuvlypIXJ2crdhyf16KENp?=
 =?us-ascii?Q?QqO1QG6p8SOsBow3uC/MYDxMi9VheZKZrdebKsI3TkCIIL32m0WWSYYdnlAI?=
 =?us-ascii?Q?O71k77h0eb8nySNLNy0nJTXt1oSOsphoYkrwhgfuPJBm0cx+uCpYMlQqvhp4?=
 =?us-ascii?Q?RS6QiFjxpXqSfBJurCdBC+bh8ojELdkVW+vnoreFDUe/rdCWjExG1jG2cTJs?=
 =?us-ascii?Q?TlG+4jj8SF3Z/plT7qnxDUAOGCPz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR0601MB5773.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OlNUwFUsbOqjDjUL8qI81ORhvqQs9dOm5oZxbjWDsoLQPnGr9irGW/YOUgOA?=
 =?us-ascii?Q?pfbG/UR+KJLIs79I5SyndmHbeMX+N6wiIbn5OtFsSMfwsMCjEdKl8WL7AXA1?=
 =?us-ascii?Q?axi7xtoqEGq5smGzn9qjYouwHXeSze6rhkqfF8H84vKYWo51KoVHSF8X5DaM?=
 =?us-ascii?Q?YHPvN8DlCgIDH1B9U4MYYxK8bSlHpMRGCYGkdC/q7jFPgU48HunRlVDcNeSd?=
 =?us-ascii?Q?IP/wzxMIAsg9IZ8TobU0bm213ZwUAwUAar5k8UKmbtVfqcSB/WCmIQbapkMl?=
 =?us-ascii?Q?ZUXmS+mVjKPfC+b/xmK6MZ8I05/Tbw2hB/xT23Njhk1NGGvDEbFAFmM53RbG?=
 =?us-ascii?Q?5UiMfeyNe+5OASnfzzZ9Wv7in5sC80c589Dzuqp2/eTY4Au0yTdMO2/14DHt?=
 =?us-ascii?Q?HBovdD9fiX/4x265rk/5994zfUQZzxc3zdWNEHq/aiiN9EOix1PouiehILhL?=
 =?us-ascii?Q?FN8D3ChjyyGQJO38JvXP7XUeLnVLHV1OyGUsL5KEs/fAnhs6UCoJLrLwH7qu?=
 =?us-ascii?Q?Nykm569Exmrs8d1OhaNfbJj73Muf8iJWPmPgFk8pOYRH9+cCU8LUutT9UXc3?=
 =?us-ascii?Q?qiDVQvA0k/fwq3eyTfL6kEnbPv41WWld5adcRdLkjBuR44XKOgD3NvVoB57E?=
 =?us-ascii?Q?Y2eok+ZVShzyfanijiDi987OMQbGSxJG6/KQF2IG/ZlvXQMdaZz9HfYF+llK?=
 =?us-ascii?Q?y9mbkEJiY4q2xAyw3QClrr6MiJ9FC9IcO/4dnHGu6GSkm2DSS4hkG1PpSjh7?=
 =?us-ascii?Q?wGLY3k0tM9HAVv1oM7q/9NAracvGQ46Ep1ov72dXM21ivMksjrhfVKt/qRr6?=
 =?us-ascii?Q?SVO5u/X+q4i3HxKbUzto94diMBojQ5Aa9fUiXTkpgKxb005zch5YcrDPJvv1?=
 =?us-ascii?Q?5ztUCgCDU1jWnmS7/7bCpelJgrMxnjdvqUfjCSVh5fs++FjtJaV2VrBkt7Tl?=
 =?us-ascii?Q?6LRG8kp6PPw/EzkFEyB1Q8UDvBeoYka3P6fwNDwfSbmF9s3u2ZEKD4aF/6y8?=
 =?us-ascii?Q?ANHFkCQAFLuhX/s+QKZaqINYyT56NC13wyh+O7TEOiU1TcpRXKA8NVRSmnLK?=
 =?us-ascii?Q?rg6HC7oOh4KP7VqBvakk8bYwu942mRz5kcwjBPOcwh17sGl4XBaGjlcUeXuU?=
 =?us-ascii?Q?pIwtzKonUFlCIJVP8JCXWUAKdRwHS+pkykunz3MpPR0lgZjLHJbgIByyWHzC?=
 =?us-ascii?Q?tvFItUlldQiwZyV592pCeUUAP4V6AQaVBPFeT8a/0kL0kMmTzBz0fjYaxSRh?=
 =?us-ascii?Q?1fXDUJozOrEwHaRpEmnH5SqPhpb4a9BPuA820jt2d8M1dEY8e3NOO7g+VWIC?=
 =?us-ascii?Q?vdrJd4Y1tZ/0nbs/TYZF+EXFUOqkFWOVJIkkopASTnLOdy3oUFy9BktYbRKY?=
 =?us-ascii?Q?pZvNcbta54fdq8peOROwYFeJwVI+VwHIR+8+aLCMVNrSLfcMgX9fxiVF1atJ?=
 =?us-ascii?Q?Sjht0Qbb07YQcuhq80XhAQi9QopWX87DUW54RHjutD/a/9yo2ib17Mrtzspq?=
 =?us-ascii?Q?Tg5xL6+3Yy4zxDuUMMLlA5XVaLB9c2y3Apz7OfbYPzXkUX32CrdcFbbbW4AP?=
 =?us-ascii?Q?X5q18Gj0HjmF0+y2HeHz8cIwEhzdGrvXmSypafZ35Z+5thzjoR/sn2djTIEo?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93d17355-570a-4969-2f63-08dd0063f7f5
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5773.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2024 02:12:32.0446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAPgwfzj5M+8W3NjfdbnFDZifb4pIs6IcS0ojkvPh8BNj76orD6nM24eQs3+m2hmcuaNKNxxO/FEnGa7/yEBMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6078

Since len1 is unsigned int, len1 < 0 always false. Remove it keep code
simple.

Cc: stable@vger.kernel.org
Fixes: ae8709b296d8 ("USB: core: Make do_proc_control() and do_proc_bulk() killable")
Signed-off-by: Rex Nie <rex.nie@jaguarmicro.com>
---
changes in v2:
- Add "Cc: stable@vger.kernel.org" (kernel test robot)
- Add Fixes tag
- Link to v1: https://lore.kernel.org/stable/20241108094255.2133-1-rex.nie@jaguarmicro.com/
---
 drivers/usb/core/devio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..712e290bab04 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -1295,7 +1295,7 @@ static int do_proc_bulk(struct usb_dev_state *ps,
 		return ret;
 
 	len1 = bulk->len;
-	if (len1 < 0 || len1 >= (INT_MAX - sizeof(struct urb)))
+	if (len1 >= (INT_MAX - sizeof(struct urb)))
 		return -EINVAL;
 
 	if (bulk->ep & USB_DIR_IN)
-- 
2.17.1


