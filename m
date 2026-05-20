Return-Path: <stable+bounces-249767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OEJZIr9dDWpLwgUAu9opvQ
	(envelope-from <stable+bounces-249767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:07:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05890588AAE
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 09:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7541F302BCE4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2A534DCC8;
	Wed, 20 May 2026 07:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="FXdhoMso"
X-Original-To: stable@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010036.outbound.protection.outlook.com [52.101.69.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D4364024;
	Wed, 20 May 2026 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779260856; cv=fail; b=NZIBW/Pu3UP/orRmbE2Mgmz8efNiIEpgA4F+mD8rvVP602BAsGwCoPvs+ZIiR6LLEUVUmm8qysySJeSA9MiCYxobpBpPGlqyW2/PQa27ID3qrbbX2C/UGE1TAzyMjemGD2+ZPdYv118aPTyfH8TO95sFR8+uOVGO/3VIUWjgoR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779260856; c=relaxed/simple;
	bh=/+CbY9heiz/gaQzhSKBixlT/o7GEoGYaeW94zwEskEA=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qo2F8ii2q6BKnUSBCVyBOIHBVQxSI0hceSrhUMGi3eHd9EhCd3rv8SeucgFttTC1s7nhv0zJYklO5HYZrg+PKU6V3AnuRbGJ2d58wEy3cdloLlk8Uhaj8YN0gD+mFqIuf/b+HxDN/qMS72WASQwDQVhQq5nNA77jCWLHS2FVPZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=FXdhoMso; arc=fail smtp.client-ip=52.101.69.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqWeg/8I2KcLUrp8OIuS3Yi9D0kCAPGxcoqY0WgrSJAr+MMZSQQymecemsILFGPeVvJYvXCuYXjIp5dlQk47FLnPYcD/EzsR3Nm/Ln2UULqn+0QWEwR+wUwICdzfxl+ej6T50yGuzihNwQCTleHZReEJuRbYo0u0uyXQiaclOBQip3yVvM9sjFJA5bHGmoPcoTHKRBucwqF5WhUbDsR8Jsk8gh+yTt8+xCCipGcxBDo480Hd2PMPv0a9Zu3uiH5W/YYSGY5HlDR49dW2BS+BCJsYyO14kjqP5awnw6r5ilcutHbSC8kCCrCyiBKAwWw8n7WDAO7qzrIs53VXIYragQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4jmx6mNI17trKxUFwHiXdlbwfgwbEnV34NvGB/UgtqY=;
 b=l+TdQY9EF1mimcLoUJSOo6VfydvHQqd3bAg5SRedFkYDTCTawH5Pb8vQ0uOLIFNp7xmHLNznw5cr716RhwxLp6ykLZodNUPdWE3gmbtm+lli9py4H6ohcjSg+vsVxpKZVCINI7ASZDIPO/wM+vt5hpYTvThcQi2WqZwcCjEe0FM0mW/DqueCq/Klryw80nEn0XryWnXpJVheBQREveElbVarAnnC7XlYqk8+zp5z8Ldi+M30Y/WAp+fdefAMdOqfHm7FWd62mcdcF2NPMPTKtSuFK6ECTB8zAQsy133QkcRvkt1rq1HvnIjS4a4tiuJVtFOYN/hO74CsK2AQ74na9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4jmx6mNI17trKxUFwHiXdlbwfgwbEnV34NvGB/UgtqY=;
 b=FXdhoMso+GRrapE/c2fJwuHrMH7O1JjUQMatRHzawd6BinWTUea6xgpLWWsFIXNGLH8G2NH0vsSHnc3mp2Zoeu1S//C3yv9Xdp+eXSQWToel7gsbgxisLhuWN89VN+xm9Hf4a0PXPuPKlBAlwMVgFxE/fBhWxWht57PdZGS6cQQUPzOm9VxyAvltLtziK8byPuOBb9qQR6B4JF8P0jiTnlY9xx0dPd8GRWHlm6HPHtueCNTJpB4UGOl2xdIupVfhZOcCOneoNf2Qxb+49tVNinaRVPI9kglTP66esWx/OpK31kUNIBWf+v7ZEqTVU6ytJvePO5FZC/wQTXBXEM4rEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com (2603:10a6:208:184::17)
 by PAXPR04MB8160.eurprd04.prod.outlook.com (2603:10a6:102:1cb::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 07:07:31 +0000
Received: from AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51]) by AM0PR04MB6802.eurprd04.prod.outlook.com
 ([fe80::dc36:17b6:e5b1:fa51%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 07:07:31 +0000
From: "Carlos Song (OSS)" <carlos.song@oss.nxp.com>
To: o.rempel@pengutronix.de,
	kernel@pengutronix.de,
	andi.shyti@kernel.org,
	Frank.Li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	carlos.song@nxp.com,
	haibo.chen@nxp.com
Cc: linux-i2c@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PACTH v2] i2c: imx: mark I2C adapter when hardware is powered down
Date: Wed, 20 May 2026 15:09:34 +0800
Message-ID: <20260520070934.2874114-1-carlos.song@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To AM0PR04MB6802.eurprd04.prod.outlook.com
 (2603:10a6:208:184::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6802:EE_|PAXPR04MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: fc806088-6927-4ea8-3b18-08deb63e7588
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|366016|52116014|7416014|376014|1800799024|56012099003|18002099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info:
	aOPYzIV83nHbGOlq37X0jxIlvrlJbMAl/ySNgVT0cOb7qx/NJCypb7XUidN84+8DxOfIAvZShIkKbDHBAsd+Sc+XkULijM0H27IS5ZlXMa7n0ccG7irGHBMKGeBCxq1/bpoLqHXi772KzZHIGO2n6p0ZOXs1Hluhg0NbtWe5Q2tdMEKUw8C+9HAtM49lHN7nWz7Vl0GHfY9XgSBO+adEaJc3N374BWKSLINBUKZBp5G7Noir6JzJ3UxkiuYFVGvaPg6b6bGOBqYXHZTb+KCQKpMOP6ZzklojirWs/M56NhG7dfX5yb1HD/Rv4TLTE+mUfZPObFLmiA1HsbXRYdG3SFjypSlAJeBYnxY5JxSCGoKafZfirgfiWXX2H572XWYCbVmFJKRueXzO8XxGIV8i6LaLZ7+1MDwEB6DhSpE9Qae/7T4MwxbxhZw7z2FxtLJgVimIuHCPZ92oVt4/QRSFirrbHhLkNYl6uMiireMYrIGg+cfgYXksTD5hhD1fkSuPXcwSloPzHGN3oo4k54npfDXJ3RJ9pjNBYVnDncu3yC/exCOYAlQALorVza3ZUzEmkljSX+/cT4rwUCAaxKEbfAb5Q6HINXRO2yJEsyN1dxLaQZAG/AJtm8orc9ICsz8dasxltltxBPAGqurAP6i0KduCrW+DyXyr0nQZRCFi9cZLX8ayFboWwOfzoV6QQMElVdTdKW4eUS6eUxFcC7/4/R4TeS3FM/lFvVmOcXBrlB8jknekd0U0sVG1w2WprLRg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6802.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(52116014)(7416014)(376014)(1800799024)(56012099003)(18002099003)(38350700014)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g1tkee3nWTCvzIXclWHeVvqeYGNTYEoieLDecMFEgdAad7nXj6HbYc8yxIVu?=
 =?us-ascii?Q?7qyXh9YTmkZavoyn0VbSyQasxMbKbKWcOXo8k6zhE3oqfNmfsjvBdd2axEKr?=
 =?us-ascii?Q?XIhIYCoXChCfWRz9m+/gfkPzVS73U64zda56ifXlcRn8seQp8e03zmy2tV6o?=
 =?us-ascii?Q?24TNdu8kuYW9mW70HUcQsGGPw6gmHoDlT0pR7Ces71E1LTAj4PkcJOW8itol?=
 =?us-ascii?Q?/+LoYyxslGqJ8qL8zXrNuz3Q5zZNWVqcbw3CtZIb0en2R3V57eLjb9YonK4B?=
 =?us-ascii?Q?1YAv/sxqn1KDpkwcjl7a/Z+4m6dXde1oJWbcjAGjAZQNE23N9U4it7AZ4fV5?=
 =?us-ascii?Q?aQWtq7kiOtiX6YD4vzoJmMuehKUxrv6jxrE+1hUfARKiWVP3IiciycAPm0fW?=
 =?us-ascii?Q?qSydFgU5knNU27+9zYiTNvwr4IoGV+lau4tiWheW6h9TWKxEl8GK+xXV4s7q?=
 =?us-ascii?Q?KFrajJ+hCMosT/FKOSj0BhVmdZ/lfkHNpy9QWtsIt3f+YDZgswlOV2YmfheN?=
 =?us-ascii?Q?4USN3dEpntABb7/TqxFYt7IW8JDHTDno7tU70iP2dXAO7XtYe1mUxsedvfu+?=
 =?us-ascii?Q?p9dSavnP5kpwGh4v3r79DOPcAPEGn8ICbMqYCqoJ1utRSPixGRewCV3MpNka?=
 =?us-ascii?Q?a2HTc3JzWK4NiGZDwJ39j80mjPvx8PeMIn8xlRztn4LTjz2osSL3eEOds4Iu?=
 =?us-ascii?Q?RAa114bm30wJRH+S70+3lugT16ic+j9Xlro+Ax22o23HOw50EKaxjIh+q1X9?=
 =?us-ascii?Q?V+sOBZ0gRcco0FF/FQctEsHcjWhVk8gC92xx105BIe5ZU5rwGL3C31by6kgu?=
 =?us-ascii?Q?dGGZH5JvoNhLiclsRQyMTXlzTqkqirNY35qzOgJpcc1j8F+/swvc/QbDymSL?=
 =?us-ascii?Q?+Zzm9fh6cZIFWCv6Deutybq4jtwQzDsDXuB3dMEcg1PL3w0GV1HHpZipVsy7?=
 =?us-ascii?Q?pd8GhU3Yf99GQalTnpA8TGt2uGk3T+1+uafp2QyL0Z4q7/KPPSOoTFTOHLdv?=
 =?us-ascii?Q?E2ZMyQvjVxL0B+gTw/YfbjdJPm/jRHfIqq7qWN5yq9XW3bYlnIyNGxPuMw0K?=
 =?us-ascii?Q?hG4UPGbnoHgXgfIYClsfLRtlWkiwx/ridC6DNTRPdwZ53knpYX8GulcHMZ75?=
 =?us-ascii?Q?13yC3cdP6hGVQflGgL/T/VFt/8xybsHqtomwm0zZFHPAYvCWyyqjwxO3AgUb?=
 =?us-ascii?Q?7yKe7sUfcR7bOoSdlcPYC/TeRWV3VWPci+X75+4pQjJ31YCUodT1uqU/xaCy?=
 =?us-ascii?Q?kFxEgDJu2rq0u0FRurKR73prbzbH2cJ4RqHlstl67LpJPpo0ql0zK545FC2n?=
 =?us-ascii?Q?uLkUX1UbA4VwGmudQj/HJE+/G+xFBzsiKMEUEjWb+1Fhp84jWvc01zbP/Q+l?=
 =?us-ascii?Q?Bd7EIe/+r1LAvrH9b+Zbf/S8VcA0BrRi1bb8wDAe9E9iNQC2Yme8ufBxjT0H?=
 =?us-ascii?Q?bW6uaoXLGdzQbhCB7fLtnWPwIDQbcOK2NmBubxgbESuGAmVLxth9fRFQ/ADx?=
 =?us-ascii?Q?iUZkFV5WR5lTLkUUR284Mk6MPD/IzCRC/q+33GUZCaEqABtYSXcnV/nOq1+y?=
 =?us-ascii?Q?AGoO0xPM0hf05DzBf3tq7zM4QUcVA4t8UtBO2ZvA0lPbcz8mnO0qLPkQaYwm?=
 =?us-ascii?Q?+8i6nG+XH0t7GLzf/qy/4gJa0GZTH9ucAVVl1bnILt8fPtyWsfPim4ylxHqo?=
 =?us-ascii?Q?bYYXFSYbsatTLb5/oCXpyhYBBTQzUGV8t3VhUf70JeTDykn6aJJDfwnoisnn?=
 =?us-ascii?Q?y5G9/khMWQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc806088-6927-4ea8-3b18-08deb63e7588
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6802.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 07:07:31.2090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3WGC0wLI1hK/3NT+0e6zbRVzJ7Wx9GhTJJoH5BZ2/c2j9ofHXJapK/m42Rj5Xkg0t7rjioxIiNxFVeFIQ4s61Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8160
X-Spamd-Result: default: False [1.94 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[NXP1.onmicrosoft.com:s=selector1-NXP1-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249767-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[pengutronix.de,kernel.org,nxp.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[NXP1.onmicrosoft.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[carlos.song@oss.nxp.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[NXP1.onmicrosoft.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 05890588AAE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Carlos Song <carlos.song@nxp.com>

Mark the I2C adapter as suspended during system suspend to block further
transfers, and resume it on system resume. This prevents potential hangs
when the hardware is powered down but clients still attempt I2C transfers.

Fixes: 358025ac091e ("i2c: imx: make controller available until system suspend_noirq() and from resume_noirq()")
Cc: stable@vger.kernel.org
Signed-off-by: Carlos Song <carlos.song@nxp.com>
---
Change for v2:
  - Call i2c_mark_adapter_suspended() before pm_runtime_force_suspend()
    to prevent potential deadlock if a transfer is active during suspend.
  - Roll back with i2c_mark_adapter_resumed() if pm_runtime_force_suspend()
    fails.
---
 drivers/i2c/busses/i2c-imx.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index a208fefd3c3b..cf6e1333b084 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1913,6 +1913,36 @@ static int i2c_imx_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int __maybe_unused i2c_imx_suspend_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	i2c_mark_adapter_suspended(&i2c_imx->adapter);
+
+	ret = pm_runtime_force_suspend(dev);
+	if (ret) {
+		i2c_mark_adapter_resumed(&i2c_imx->adapter);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int __maybe_unused i2c_imx_resume_noirq(struct device *dev)
+{
+	struct imx_i2c_struct *i2c_imx = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_force_resume(dev);
+	if (ret)
+		return ret;
+
+	i2c_mark_adapter_resumed(&i2c_imx->adapter);
+
+	return 0;
+}
+
 static int i2c_imx_suspend(struct device *dev)
 {
 	/*
@@ -1946,8 +1976,8 @@ static int i2c_imx_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops i2c_imx_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				  pm_runtime_force_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend_noirq,
+				  i2c_imx_resume_noirq)
 	SYSTEM_SLEEP_PM_OPS(i2c_imx_suspend, i2c_imx_resume)
 	RUNTIME_PM_OPS(i2c_imx_runtime_suspend, i2c_imx_runtime_resume, NULL)
 };
-- 
2.43.0


