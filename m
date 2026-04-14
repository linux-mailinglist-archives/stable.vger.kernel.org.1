Return-Path: <stable+bounces-237988-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iCrhB0DQ3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237988-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:39:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A69593FF1A6
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 923583097134
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:37:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16C13CAE95;
	Tue, 14 Apr 2026 23:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="As9dLqx0"
X-Original-To: stable@vger.kernel.org
Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011044.outbound.protection.outlook.com [52.101.125.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8EA3CD8A1
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209799; cv=fail; b=Mp09u4Fv6zHvA8qqc9wvMed8z8hQUpksP5tVw2Lv/bjiCxiDcj/KPDYVo+dQ55Lg5AtOrK4ZdGZI9BJCf7FQMKzXlkQYorJSORgtt5n1DvhmONMFa9a8Li91desNbvF/xT2/SUaHHFFMZTJrOOxwhXUTy+orA3CDMIiNebyj2C4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209799; c=relaxed/simple;
	bh=tbAnYLL5wv80PZjmpCQeoNFEZqoO51VSQZ76NpZJ9CI=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=cAmlHknjhtQXlbXK80VCr+qGD6jkaxrf8DFgYV+z6RE5dEwrrLLuG6FlgLvhZdbyhoAm6BtSmaZqGkhcnDxp9Eard7FapEcbMaiL3nedxmYrISBJ9Cv08mNZGzOgU5sjv+jZ0cm9XThFKnXPJUFMsTRJRCk5h5uEKIFrE4nOraU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=As9dLqx0; arc=fail smtp.client-ip=52.101.125.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XqeZ0U0Rqe3NC9Go5WzIGKvUJO8mJcMGdYohoKbPWvQKRkaUQUcZq7J0njcY8SKjioGoc9p6xPaNtKfRC4gsscG+ZT3JoS30l4tqCFgIWajVwxQT/i7Md+Exi2fZeGf9NqgpJypobuZqbNy+Mij3cvReg8+VqlEiwOrMGNjLj4yR7VfX1bCdDPBH7iAVIjG0/CApOuqnwA1R88E0ThtUZwL9jpZYQ7+hMfIcrEv1M5jdB7Vc9bth0SZ3PlZWmXCXmxSh/t5jyTlPpA+LE7EpYSas2jNiS2dKmBYi8/YmT7Xl7vvBQxFU0gx9sbHC89Mv/cxSQECHXKpVCE6qWE7phA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=atvwoChfiFPTiGWUSLtZTFVTi2gae+Sp0FwXJMIwQ9o=;
 b=VppSTipEy4G4zqoqwSlEGtfLAjc6gPuCyMYHSJkNMKcYMwlH1hGyul0lEp9d/6xyAPGmvT+YUmKCvIMu/kCgeuEqxiTG+qjGAANl2davJVfDK6H9e/IoeqS/xuwBQLK8B8bCibNMdvfpHLsWRrGR7gJMcq3q8KismxAeyIjPbce8sL9GEYy/H3qa6qhbxQ5LU6W5xpam5AIyTNHRyJSea8REOMLCkDgimfwOZ/73E1Q+FnbGhJasQktAHE1NL9gd/5Yf6ZuSxb/+DU+3fl+tWn9bE7g8ON/7kmy8knNiJzRmJbRIDd3+JHAE85d5r6qcf51AEUWZkWu68xjzmWhxUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=atvwoChfiFPTiGWUSLtZTFVTi2gae+Sp0FwXJMIwQ9o=;
 b=As9dLqx05Vby0dZu44cJYt7dQbJLPuEIWTpvgZARr6K8Am4Frofc7r9a+XEdLRRjoYOINVCA5zgYX7G4NQKwga4u6EvSve/WAsWubBGrx0zn82P7a7g+Oc74XwQsDChekfQyLKuE0VfNPcXnM78leEQP1KyFitANtRkDfNnVhc4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com (2603:1096:400:373::8)
 by OS9PR01MB17905.jpnprd01.prod.outlook.com (2603:1096:604:449::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 23:36:34 +0000
Received: from TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383]) by TY3PR01MB11797.jpnprd01.prod.outlook.com
 ([fe80::1868:c915:c230:a383%5]) with mapi id 15.20.9769.048; Tue, 14 Apr 2026
 23:36:34 +0000
Message-ID: <878qap867y.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org,
	Peri-Dev <oss-upstream-dev@lm.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tong Duc Duy <duy.tong-duc@banvien.com.vn>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Chu Quoc Khanh <khanh.chu@banvien.com.vn>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [Renesas Linux Kernel Test Report] DU/Device Tree: Missing pin control for DSI-eDP IRQ
In-Reply-To: <2026041351-skyward-constrain-e6e2@gregkh>
References: <PUZPR03MB71159178A9463AF8E5C1B4709F582@PUZPR03MB7115.apcprd03.prod.outlook.com>
	<87wlyfeks1.wl-kuninori.morimoto.gx@renesas.com>
	<20260410085604.GD2712636@killaraus.ideasonboard.com>
	<87lder39bh.wl-kuninori.morimoto.gx@renesas.com>
	<2026041351-skyward-constrain-e6e2@gregkh>
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Tue, 14 Apr 2026 23:36:33 +0000
X-ClientProxiedBy: OS7PR01CA0153.jpnprd01.prod.outlook.com
 (2603:1096:604:24d::7) To TY3PR01MB11797.jpnprd01.prod.outlook.com
 (2603:1096:400:373::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3PR01MB11797:EE_|OS9PR01MB17905:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dba438-ebca-47d3-4ea7-08de9a7eaa0b
X-LD-Processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|22082099003|56012099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 a7G/PSmLp381FpwpGUYCw6O98pfql+aBrOlsCS/q1k37/JpzCXVzDg1wkqHTGxWLGqADf7K9EZTK1cEBxiyuoamOwZ+xNU3UJrfGSOpkO5u4yiZvxYgmj2bUoZ5IsOQyXuTXBxmIubP3GG8GnRMqWK31l2IfTmUalw8BfWSK/3Nk/v0HqxaHfePg1wagLupr0B37RoVw8WLIXcIoPIMiahWIy34OLwQxC4UcjFwoSEiUaJWqlx6Qpf5/H1yN0Dra7w1p3fp3rtKDlPG8gTWvV+j4k9s8tKrPjVmy5FRfmKv5ogmFaX6TElmbYvQiDiVHmKykjDkoOaih0ZJYL+RgJZNRlzYsmy7/RfkM3tnsEGe0mq3TYMsgFGdiaNAMokwLSgyd1QJhPq98zRuAGVFDq/CIW/FaAqpey2FiqHJ6PkvTpaLYve4Re7eJtcGYxj9GCyT/PzOK5T8JlJY01Cpd2pvRbo+8GO8tAxlmXbZLthb2AmofcHDG7sPztLmnGOxaQEZSbm2BFQ1oFejTcV4SlzhSRxIEzJyKpail+dMabCAV2MWJjX5SE6PJFvnVJUHbPRfQZC5tOn3FrIgzeVdB7g8dCq8ctEYQtnvK9ycvdTUFo5ZfiDglim/xh8oUUL6roiXJdxGinUtCgKEbAZhj+Fyc6XOI9ZtE+Z/JhWrbAAk0DIMae/K/bAP/GwFco1baGOnmvprstFNmjJHvOhi/SIyQCkUZ74Ms2Cqf024dKbXw3RiEbgV/nIrGhjl92prEabHb4P4gJg2NrYoIK35KqeHq3CRV11KGHKopbYfUwAg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11797.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?qQxzW7+zFF/XePyQUCB/iy4s9YxQzozjRaDly+2igKOQ8WysV+HlyRvh/ZM0?=
 =?us-ascii?Q?1DtZEpoWglapPhagbuLzQExVhYI5sYW9MqQlSDU9WLPS0KqD/6UlX95QsTxQ?=
 =?us-ascii?Q?Z4t5AoF3t2/sni4QSRuVACHGhAmsz4sDnD+o8v9obRU7zbuquAlC1Z4vLwvQ?=
 =?us-ascii?Q?kBJvSYKl0ce8jqlQ2cq6PQXyTcyncb6IvNQkX9nund4mT8lsdTcE3xMlNxaQ?=
 =?us-ascii?Q?6dUbXUVAKrxutq2ouIdYyYVKAnh9D+jWTItk+K3sqNBslfhvQCNW6vkCxrJr?=
 =?us-ascii?Q?MCpOP3LiPu1QFY3hJIv5lvCV+C+5+oHnUGzpQC8kqLXUKTNTBwQrnHhPVxci?=
 =?us-ascii?Q?OnZ9klRukzBaHeKhvX5NBP2+oAV1/ArQdZR/G3V5Nb5AVA1+xZwFNs32U+ap?=
 =?us-ascii?Q?MswbCHoOvU1Ay9K3TCHrX2nfhjgWHn7Y9L3mcjXKlwmUgLuSmuZifK/2xndU?=
 =?us-ascii?Q?tz4Dw/pxzum7dmHz1600b1v0TYPtZgv/+ZBAWOCfY6SL4rc5TYMeL8QuwvJF?=
 =?us-ascii?Q?UeDASo1Jky6uckxCRIGAWGO04EujaiEzB+q/4O4d33CX6RXPh6Kd6yXkrnCM?=
 =?us-ascii?Q?WFkaXeZnTr9Z3agDUJXEfVJ5ov2mihIY2ro8jT1xBWS2zTAL/OrBGRW8I64M?=
 =?us-ascii?Q?kKcdQBw0NHfFAn6NAIx+KWIvnu+ztJlInuAt5x36cj4tsb4cBurw6eUfk5uu?=
 =?us-ascii?Q?mHcF/4yXu/+5Gwdbq5BV9lQ0EcPBbl1QT3mx/bgh7tASor16F/JG3dF0dxLr?=
 =?us-ascii?Q?wdAzpuIwi4J1riXdDNL0NyPGX7adbQCJPwnPZ0zLPqYYAsVYlzxr2qWuc/Ro?=
 =?us-ascii?Q?te/IRzpresIYNMe02+II3fZS9FmgjDMA+8/kU5yxnvn7npFVrpd0qLvoHhZk?=
 =?us-ascii?Q?6t5yWzZjaxQvo5MRoP/47WUxdeQJ/Ob5pmGgeFrQpM91I3wMHx3aH/99sdqU?=
 =?us-ascii?Q?3G0nDtn6cLqv99fglS6GhfeGtdQYy+BCL4fh8omTBYaFpvMu+rkAwXmhyU6/?=
 =?us-ascii?Q?08t5PUPIXrl0Us0RtFvIrluOXMZwyYAwjdfjfqgdw7P9C1WoWJ1PTv4faPtn?=
 =?us-ascii?Q?jVAc0YIvLQXfCF23PZrY/CmGWykzyeI/MDfYNDw+iOaI4BALbEjSSNIgPLtz?=
 =?us-ascii?Q?W5C4ugGkEjbtYgRcNFM2s5Zv0/ZqVv9cmP0ff/iw7ysL9kdiBbjiHo+hDHjP?=
 =?us-ascii?Q?MVjG2Txj01n/N2XGJ6SUIMPUNa1AvKkAnvuMH2vkQLhd/r9Gc9cZ5OxePqb4?=
 =?us-ascii?Q?ruFOwYnHFaZ9wnp+GEVO7cHH3XnJNETq/qIY4zOmnX4tohPMVKwPMfop6yLB?=
 =?us-ascii?Q?M8baBYrRiJUZDe7F/7UNbCVTg61u98z9mVr4v0wMcRvXk3JKS0vU5+k/v9sF?=
 =?us-ascii?Q?BqHbbeXlB8s/iGokwTLrlLJGE/hBMwaZqW8czF3A0gGZj9L2zxIb/URGk37H?=
 =?us-ascii?Q?qVEk7NzTeFnLLVQIGKwO8TbjimFQoro9rXWgr56jhO+Lrw+/HjajYs1Fmazp?=
 =?us-ascii?Q?IQUgQMEuawCZtl1uCjnHY7HNTfhK/kBrw4Hh5FO0kXONIPi+b10KaseYpixt?=
 =?us-ascii?Q?z846N3nTNPdMOie7tO1zEsKfsnTIfJvQkdrGqBZHFa1DqrWkFMuXQHo0iMMD?=
 =?us-ascii?Q?j5fVuiRwhnBhr42rnTVqj8RFc2lWSs2vS+yiptIJTt852q/HkdhzMMmax4ta?=
 =?us-ascii?Q?LItqEoKgwGXTyKGmNApUeMBSCJggQcK+ZIVcR87aFt7U5FB6VCaZEY3jvGgh?=
 =?us-ascii?Q?Xh2Mt4tPOs3lMKDBkoW3PuFaEFo2Im0Xw7Ie7jqFWfOaHUZzmU7C?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dba438-ebca-47d3-4ea7-08de9a7eaa0b
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11797.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 23:36:34.4097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XpsXqROu2BL5OuKn49ANyyOsat+RA65AlwWvT3y3q77/9S4bCLekZZ+mNCOeb38i4llYn/0KKWiEfXQ+UMX2Ldm35dZrxSqOJGkCb8vQOrxcFGXS2O7d10YX0WeDVtI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB17905
X-Spamd-Result: default: False [2.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[renesas.com,none];
	R_DKIM_ALLOW(-0.20)[renesas.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237988-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuninori.morimoto.gx@renesas.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[renesas.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,renesas];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,renesas.com:dkim,renesas.com:mid]
X-Rspamd-Queue-Id: A69593FF1A6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hi Greg

Thank you for your help, and sorry to bother you

> > Linux LTS v6.6 / v6.12 backported this commit
> > 
> > 	9133bc3f0564890218cbba6cc7e81ebc0841a6f1
> > 	("drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD")
> > 
> > Because of that, Renesas needs this commit.
> > 
> > 	8219a455efd4ba11c1d30c1bbc9ce853466c19bf
> > 	("arm64: dts: renesas: white-hawk-cpu-common:
> > 	 Add pin control for DSI-eDP IRQ")
> > 
> > Could you please backport it too ?
> 
> It does not apply properly to 6.6.y or 6.1.y, so can you provide working
> backports there?

I'm sorry, but please ignore abouv v6.6.
It was needed for our own kernel (= LTS + backport).

> I've added it to 6.12.y now.

Thank you for your help !!

Best regards
---
Kuninori Morimoto

