Return-Path: <stable+bounces-235873-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id pfv2NiFP3GmvPAkAu9opvQ
	(envelope-from <stable+bounces-235873-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:04:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 382F93E6BA1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D49FA3008743
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 02:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1659849C;
	Mon, 13 Apr 2026 02:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="diD7mRsQ"
X-Original-To: stable@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011049.outbound.protection.outlook.com [52.101.125.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEA51FC8
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776045851; cv=fail; b=Kh49yR5smELoXcQTX+snWGLFtvxgKBBsEadc17QWBhnSiqYMGiJwEG9rKQIbet42vlc3Wgc4ZaPYZHQeNMFKbWvoCYFsVVMmDsAI5XzwAVqF159zU2/Y4ndFI/ypkhCmxloIR2YByTtJQF/NXxFnz4AMMw5fMxLm71FWnxVLOMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776045851; c=relaxed/simple;
	bh=n6sOatdKyosiWfkAK3n+i34X8D/hNQFGLcpIIX4vYrE=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=i3YIHY/SIMUMS50x4PF1zRbnNmF8BZ9OFA1m6d0Z4UfAjJC3gb2mxF2ABv25qMb3TuRG9xj3dhrns/IRGTbazVlKqbRf7kejKP2dDqQs32JdSEBf9ajET1ANon2B0EiZMdyPvv8X0csyX/+guBn7VXYGYISVtSo91X0URwdOX9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=diD7mRsQ; arc=fail smtp.client-ip=52.101.125.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=szLNiDBdhg/E9YC3TU/1y4V0D4r22fwMBCr8iPLWAbd6qaY0fWocu3pHlVszUE09hCpwSOYFzV+zLc4GC9QjW5NvN59YqTCic713M/chYCVRzUm1YRDcCe+ERprhUUW2iCfs8cN6h3fFx8tdAy6SaqLr1TaS47ab/2YIG4eqnUOUPvZjhpYeqT2sqdawB13dUxjFheRHNhWMhfFgONVmvyq8bK7l7ThdostxCZwTGy2lw0X6y8RDq2TU0zp9eV7eQ7ZFk8CkAROJakgB+IeC2sw0hJHrAvP47kbbiQF/EEYv0DwBBiut0FXo7hvb/Ewcxw/oAx6gyWhS4akgzNjEbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QBrVJGCkmkYgV/nG8LubvK34ywic2McrzXlFYgC/i9Q=;
 b=Bht42YTCV+xMFPiGrPpjMdeQtMJwgPH/KfRBQrwdNV9i2GS8cppXzFeNpLNBEUPH+Hr1tBwmy88AjyE0Gi0Y0QCn4c+MeQtPSlyyOTmZUL7g1nXfNwyUn363Don37rGS/0r/CZgzUkLyjr2fKTMPPzxu2jPYvkmZfbTpawtEmqPrsYivWjDswj5MZUx4tESi7AKnfnrXXZ5neKskC94hktRErKDNw/4RA7FADwogT4ctDYQyJuJ4USyKzfpJ/ULaWXcL+qDKyY8Y58hboYWvn5ELY/XXlUv/voeawKz01Tk+OB2GdEbR+hokCXg497FSZ5WP+9gbN4iFvcj366fNVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QBrVJGCkmkYgV/nG8LubvK34ywic2McrzXlFYgC/i9Q=;
 b=diD7mRsQ2X0VT9HVcaRXW2bJp1zSYp2ubJVlq/hWms8Z09HnGtXr0T3Df41OeL+nTWWltStSKjib0UY/pMgcHR0SJ7iUlbyvhT48iqsV/uECPDDqVSdEZ5DnQThv15MlPXfTfur3XWkf0ZS/8ROoaEl8y10wnIVtPzYlPUZmPr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by TYYPR01MB7760.jpnprd01.prod.outlook.com (2603:1096:400:118::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Mon, 13 Apr
 2026 02:04:03 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9769.044; Mon, 13 Apr 2026
 02:04:03 +0000
Message-ID: <87lder39bh.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, Peri-Dev <oss-upstream-dev@lm.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Tong Duc Duy <duy.tong-duc@banvien.com.vn>,
 Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>, Duy Nguyen <duy.nguyen.rh@renesas.com>,
 Chu Quoc Khanh <khanh.chu@banvien.com.vn>, Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [Renesas Linux Kernel Test Report] DU/Device Tree: Missing pin control for DSI-eDP IRQ
In-Reply-To: <20260410085604.GD2712636@killaraus.ideasonboard.com>
References: <PUZPR03MB71159178A9463AF8E5C1B4709F582@PUZPR03MB7115.apcprd03.prod.outlook.com>	<87wlyfeks1.wl-kuninori.morimoto.gx@renesas.com>	<20260410085604.GD2712636@killaraus.ideasonboard.com>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Mon, 13 Apr 2026 02:04:02 +0000
X-ClientProxiedBy: TYWP286CA0032.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::16) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|TYYPR01MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 942435d7-3ccb-4e71-53a7-08de9900ef75
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 8jrjStENDunpnHxZyVLg2Xi7gH41Q05WDb9d+cRexYL+psDh5VbkAHPTVPteSL/lfm1cX67mLiKUwmYOCMs1ENgW6kvZTmQMrXu4x7++XNUaTUL5gYbdhej0Klk830Pks96ITIXeMqPr/Iz2otaWeBbHgzi2ZzBP9s/SAchw7sFHrdNmYtVyAiBxBXgYD9isPikD/iszQayyniUj3rwXOxYAsTou754TyguDP8DpLuQx2xZqcNwqoO2VRLgd15bDfcZSE4p3MMrTJce8K5G36XmaKeIJDMJsin+yOlr9bOU7s+scuqVzgLNg5+Q0iESmtQ0yfBtxDMQEVQ49/BBbSTvS/8FX4IJapNXkmXQY2+5881JenwqDj3NpjYTeXw28KyzkLsyPZN4rwCrlwvX8gcpNqYjEWaqcvNh0Sb8Ck6JBpDYcH2zX1QCFMYuidHc05L9DxbI162mDbZe8A8WVhxiJR4/I+0ynSlh7o/FLFKGQTM2RsG1oyTe5wbVxYhbl5EiXJ0vZZVSLxPTPYyK2HBfqGmqLcl8EMm0qYF4hqqwUWAhP6XGuL+6XvcSjQQPnCZ5Yt7Pq+UZ6w39KjwA2pr8UTvBFnRasOUXf0MuxeI/aDoDmgf0qCjxh9FAXsxU1yK0jQsaVg1a622VM7qFqr+gM/0o3Yg1/2hLarNPZgKgKJxfVccunVjNxtQM+aOi4p4NTp2GPmNjDuDYkf3BdB5ExLpQLjLhZ7yyJyjSge5WLc2u+fgAmWZqtKjEr464XUWR2V2Jnr8gzVczc07VbgvBzaF/XfTVOTH2n1nbPX/Q=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?OcQO8cdt+eWvADY331+zm49kf/iOs4LiWZQGzFH7SbpCNOca/zGtFBV4b+7R?=
 =?us-ascii?Q?U1BLTF+sgwQus0IAFiOrn9j9LDt7c5DkP5m8siGV9NKSsZcZC/Kd87DH9DZT?=
 =?us-ascii?Q?COdoA3vqF+0dJSd7/e7TVqpsVrMebi2SL7JrwfhoLQZnfyB3sR7XcUnIYjg5?=
 =?us-ascii?Q?Oy00iUiLeIpicBTvpdY4QGRPXRiDYMULME+Bfn4EleeVcx4eFaK4ZYX+Lqyj?=
 =?us-ascii?Q?+VYpNodaHWMW9K2mwKkS9yA8yHLElq541o7D5pV1WdEF7zq6ORYn/coGKTdj?=
 =?us-ascii?Q?PXkCAY00EVedE3gjuW2/nKe1s0h6tKg7ME822TlB2WNY6CCzWAR5Gnllhg8+?=
 =?us-ascii?Q?dMIBXQfAK53Nhft+ZoXdJCKBxCS1EfiFyb5c+9+toaDc8IHD/9rPhNHxvN8K?=
 =?us-ascii?Q?zKC+G/M5CjqVwIVyTWUXDFZfnyNq5J9zrtrt3zHqRQzEB8r+wonVWipfAaP3?=
 =?us-ascii?Q?xzPND//clkzlkyLCG9Bc/G6TihiQ65jsd17j60wDtHY2OcDRyR0j9AZPDtrX?=
 =?us-ascii?Q?7FWgJ8S7mo1FbR78zG6ewKCaG4VcebOB9hA0XKyksfTY+zwq9d/Moo7XGG9g?=
 =?us-ascii?Q?IYIeJd5SoZaMH7UQ/O2D7ejW1UqS+47AuVhem6Q5E8tkof4hQ/SHH+/+sPyQ?=
 =?us-ascii?Q?zGPZvQ5exzKC0trqY/xvxaRZYX9iU387Qq06kTuvR2y5b0tuKdzCFQ33dmsX?=
 =?us-ascii?Q?w9AQ1gvMUPp03Zw11zEUxahHjhaBGA97XUJDJ0TzIhB+D0aJPMK1chg72KeA?=
 =?us-ascii?Q?cbMz6jXYqy9tuuD150+W84tLQvNDk5/gQRuRm1GWsisu5ytsjhfhebx6hH2l?=
 =?us-ascii?Q?6DgawSIHCrjhfxBGfGVPIrHj9v4LLOlJEjL6FVEmSQdKfdLjq73Hph4jdS3J?=
 =?us-ascii?Q?3rUUzm3JAmUBwo1P3BS4bCGceUmvo1KQCLzDA+s7818Ab98A5fDVHSWAGlCe?=
 =?us-ascii?Q?w3Wz9c7JxoKuMhb8G7gdiXrM2mBoq8/7Di/2bb1YoHlWt4MW1qDFM+uFjc+2?=
 =?us-ascii?Q?DYSbka/JCCTpSCjpCKp5khImlQFm6yYiKkm14N38v/SeKaOaxH292GJg1TNq?=
 =?us-ascii?Q?rxczxRMsqmqh6K/uRk6dCj1Xo8VvC81AGk+wvRTLcSQb25NQfU3/TDGPK3T3?=
 =?us-ascii?Q?eDYz1tbcrEk5zPoHQfm1Pa5YxBWtlv+LS97/5hFOzP6RkO5iuo/wAq8/VkNp?=
 =?us-ascii?Q?aRA90J8I7Rbmp1DXq2XxGrx8KoLdrBs9VbIbt4lRtrGsjqnyyQGporqWGOO7?=
 =?us-ascii?Q?rMBkMe+XnuTG/BPqippkR8m3LDnm3f2pJGBVBwfAzv5Q0FO5YXoh5ad0HrSH?=
 =?us-ascii?Q?sCsiTBdVsN3XWYcsmhJVhGdW9ri+VxnJftARc8+L9Yk5W1xWeADfPEefi2Bp?=
 =?us-ascii?Q?Oop1zQoKRDSNm6caUK3QH7aU4UZZKvqwSQVgPnTeWmMAa7V8zES7jKoJyhfW?=
 =?us-ascii?Q?Am6Yfpe1AUDJD9onHzHdbcrUKmXVzndKqWTb1e7fR0pVhHpAiyshRxXkyHbs?=
 =?us-ascii?Q?XUS7Fec6sgo4y05GUmNNaz2In8uVx7wHlew43QXai8BVfhhQ6QGpkF2Xb53w?=
 =?us-ascii?Q?2x2KHJrzY1H/WaHdG/0pJLtS4oSGXMyM/Urk6f4UmY/CXu82zwNIAHJYdnE/?=
 =?us-ascii?Q?SWefxyyHHSQyZA0nyJD6QiRyfpKWwjaBwUlo1sTZIpvArAm3vIjN6xA49r/Q?=
 =?us-ascii?Q?Ni/Lm+yz99b/nL6ID+03e0G6nXIQR1Xvoifqy/REgm/b0IIF/pHg1glg9zlX?=
 =?us-ascii?Q?0VAoB/jtMEUN3G+fI2MCeU26wP/7714yzNgiknxzLQ5AI1a4abPy?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 942435d7-3ccb-4e71-53a7-08de9900ef75
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2026 02:04:03.1790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H353w4oCjtTWOx+GLKZsamiIhYDd+67jvQPp6/ZbcoUgtd1vagoa16t0cwo9hukmUG70NRkhnrfgxxMYCySsQJTAzEZ02buclxnbUMiwuufYq0Il3Saaokq4jXx8++eQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB7760
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235873-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[renesas.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 382F93E6BA1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Greg
Cc Geert, Laurent

Linux LTS v6.6 / v6.12 backported this commit

	9133bc3f0564890218cbba6cc7e81ebc0841a6f1
	("drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD")

Because of that, Renesas needs this commit.

	8219a455efd4ba11c1d30c1bbc9ce853466c19bf
	("arm64: dts: renesas: white-hawk-cpu-common:
	 Add pin control for DSI-eDP IRQ")

Could you please backport it too ?

Thank you for your help !!

Best regards
---
Kuninori Morimoto

