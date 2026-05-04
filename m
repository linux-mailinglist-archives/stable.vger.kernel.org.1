Return-Path: <stable+bounces-243914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p4Y3J5cI+Wlt4gIAu9opvQ
	(envelope-from <stable+bounces-243914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:59:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDFA4C3D38
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 22:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6D41301BA5B
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 20:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45031F987;
	Mon,  4 May 2026 20:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="NXd/Jm0j"
X-Original-To: stable@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011053.outbound.protection.outlook.com [40.107.130.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3279E40DFD4;
	Mon,  4 May 2026 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928338; cv=fail; b=YL+Ds3B1OokhrbQu9o8z4R8DcqmZp7hoJ/TqiO3Uls3cp431wMBJc4Svi1/k1L9MZoL9+jsEBXyXAspp1jLKrm6FAm6vTsrCLY+yQLnjAlIOoHmdW00AI4b8APDoHZhTdhLQu4/ywBfpgIirBFXDlXxXTrKNeNoL4H783EVXs2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928338; c=relaxed/simple;
	bh=rc6OJa2n4PF97A+ASnLmqGEaareWwBYRVwQzAkp7zpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NXJvtEHsqqEcRB0FpCZPhUWOjZNVSL1K586pTkfeaQGQQ1hY5dzYbRC0V8gqrykgVW+4ZuyD4Tr9hkhmgwQKROkp9HPZQcT0FcuxXMYF3X31Zid6JkiguxUy3yIvlqEoaG1bNaVKKjmsBeRsl1iLju5Bq8btxWQM+YXnL6VwtZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=NXd/Jm0j; arc=fail smtp.client-ip=40.107.130.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kt7mY10TI3Ptr41EPdkXFC0s2iqr9SDFfpiQ1AL7R8nwPFJ5qE5uIw1IoUSMvWpbFs4DU3sSpbtdRo0Ou9yXSCiw/ZMPjJuAmETWqG7D3n40+Knd6Xe4gvVCTItY3RjIFS8DuA36vysUtfjK2km6CaeDcqBccJAQAwOOfQ9Wov5IE6Xk4SX2UiF1M9cawFKSDHlqfxi18BZvABFNla4X33vVlkVl62VBKwW3MIusfb9dRXs5PWVUUh2kTJ+sDDLMdZb2VXQWG/jesHojf+4pYIMUd9mTGTAn2dNapKlDV3PWT1+FcX+BUsUjcmcMuyJ+6G92YFkZQi99r2/ur0Dwqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PtoXoQl/9FfBIks32nWqVJ8QQRJzbZd93sacceaZXww=;
 b=JIdp8dPo0UmZsLd6jjuzu/TPo4/lXvh+LjEL9yOtUG04LR1yQbzCZPu7k2blKX8+ZBzrpv+sCWg/PliOXKSqXA+Et0ROMTaqdZBlRXQaRkuMT2e8YjOUz7luSeUVEwz2ImVwvbY9FbHoDIk/xCiqPPBltPwmPu55PjCun9DWTmN2zqJNp9KJ188Mw1Ru3HLzETNrlzQa6Cp53WtGJsshXf81BoPpDKRKQi5JPFz0DF5Pf54MjbLjMnGM/VEB74XK4lFWmgiRXg8DslLnBhZCDjEKiz7lvoeeY28EsQ62IISo/Gd9/jvr9WEDYurNZtDdxkDAeIo0EmEJwOW1t22OMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=bootlin.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PtoXoQl/9FfBIks32nWqVJ8QQRJzbZd93sacceaZXww=;
 b=NXd/Jm0jf3XtjwhnzD8nbBFBeT1AsLRgASee2jcd9GTgjpL9rEokYr95//svFn/aGvovDnukiBFomJzWMH5UkaSMU5+U6R/Zyi/VAciOMhoM38s471kA/sZN/UFbghKfgf23TX3Hu8wzMW007gE6+wQFYW9N1ZOEuZta7YEdJ1C8U9iAeDYQf9u3Zln3NSU/HrZyUpiecJvHp3QWB36MBe8zF7IYNdncZu9c0JWjlMV1AAF46Lz8QkWOJioRqqg/aKmihcJB7BDQBtHbvUSryS4f0EOh6CT+SiYo+yeT7D9uIYFA0XJ4I8o0rivoa5iF2VRTnDVuIk5gPLveXvEokg==
Received: from DUZPR01CA0042.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::9) by VE1PR10MB3774.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:168::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 20:58:52 +0000
Received: from DB1PEPF000509F1.eurprd03.prod.outlook.com
 (2603:10a6:10:468:cafe::b4) by DUZPR01CA0042.outlook.office365.com
 (2603:10a6:10:468::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 20:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 164.130.1.59)
 smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509F1.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.22 via Frontend Transport; Mon, 4 May 2026 20:58:51 +0000
Received: from STKDAG1NODE1.st.com (10.75.128.132) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 4 May
 2026 23:02:26 +0200
Received: from localhost (10.252.19.99) by STKDAG1NODE1.st.com (10.75.128.132)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Mon, 4 May
 2026 22:58:50 +0200
From: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
To: <luca.ceresoli@bootlin.com>, Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, Osama Abdelkader <osama.abdelkader@gmail.com>
CC: <stable@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] drm/sti: remove bridge when sti_hda component_add fails
Date: Mon, 4 May 2026 22:58:47 +0200
Message-ID: <177792809197.128301.8006898969562443963.b4-ty@foss.st.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260423200622.325076-1-osama.abdelkader@gmail.com>
References: <20260423200622.325076-1-osama.abdelkader@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE1.st.com
 (10.75.128.132)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F1:EE_|VE1PR10MB3774:EE_
X-MS-Office365-Filtering-Correlation-Id: be4daade-883c-4992-f174-08deaa1ff1f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|7416014|82310400026|22082099003|18002099003|56012099003|921020;
X-Microsoft-Antispam-Message-Info:
	cOb+tdsj/oDardP6hCwon+qudhwRqi/Nh2nxB/Z1XrK/SACK0rww13QtPAXWgp+qEVGuOPZMTQ+zDKfDnXKLSKKesElX8x9Jo2M4dxbmt7Qj3/KqEy8A6GxvmTRMwywko3AfMH2+e4g48wL5b4xKIxHkzSQvgosIFzCiq83FXG3VMuQeIbsA5pBES4OBTmFOYR1T6QPzJaaulXW39Piu0IOzzwlhtKJpMODiOMnFPNJxWuDZUl+YBJK7ObgrcknrZ/AwX++NlakcWFlN+Q90KB2MUNjSEsB/dhcv/Hq3M8kx4owoxYT/LgE1HbTvNA87I36dsnP1ARmLLMIryr/r3qI7tTYwV00CRLPaezec7jxv+UHeVY4bpWTfOsOIchKPxD02UhkHU5nFEOggUNqtWABeS6e4sCgE94tUsnFnheSWTiIhN8YcZldUQUCuaTmfajbbUwnS7EqaOTKdZ4DVR87hyPc5YxvyPm4kXKtQxui38qRM1ZEEjZoWBQt8sutZMO4s+WiLksWxlRhaK642BChFnk9we4tJg/1WxjfaveC4E06e58J+93WeC2U0++Rp5KSfdcAcYnxIzFJ8pJ214zuw0LRFPrR8eLMT+KZVIXs+T7Azf/iycjgEtaonvFUg+ffDZt4ztH5aS8iPZO1Aw+bHEGSBXksKY2w/ICCT/s3nr9GJb9B6chy1iEStUPH8Wpt5auq9AWPdHY0mLb4QNdvzzgf88/xXe2ltd5A5LfoZMB55wiOf5Zorg5npbC+lEWqYcVPzkCdbBIwMquokIw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(7416014)(82310400026)(22082099003)(18002099003)(56012099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NOF/FEJvrFS/QtqPHtPbMOr/cIcSiOcZHZXswMUDOdPSU4cWe0u4v4oWoWaI4US9sO5r1+8fr4RuekysHU/PGEVJDyDwjoOIymNn3ViAUqR9TvkjUlUnB8oOOLi1RjCg8YgYx9fKyhZgPjAt/XkP2kqXtVTO2paMAy3SzeZzuJfCbt3at481IcEmGloUY7Fya+HyINc6NRrF/Pf5QMsJb+j2erXZHPQM6NVQ8tRJ4OHlVivs0Sf8PLndCGobgkFo7fbaHPMlai0N4YT9pLSri+Mpfi6byTDqi6xzBp+vYtooqghvIVSPOgEM3ct4VpQuOS5GOoZS2ALDMtS8I7UlnoqHiCdg/AVczrCXawg90ULNsfdSRvwyvyE24tj9byPT+UCEjRi4mKQT1r/YVV5Mlo5caK61Pj046ijwM4Qvktn8s8ryTZndKo3Yx2GSoQly
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 20:58:51.2271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be4daade-883c-4992-f174-08deaa1ff1f6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509F1.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3774
X-Rspamd-Queue-Id: 5CDFA4C3D38
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[foss.st.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[foss.st.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243914-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[bootlin.com,foss.st.com,gmail.com,linux.intel.com,kernel.org,suse.de,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	DKIM_TRACE(0.00)[foss.st.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raphael.gallais-pou@foss.st.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]


On Thu, 23 Apr 2026 22:06:19 +0200, Osama Abdelkader wrote:
> Use devm_drm_bridge_add() so the bridge is released if probe fails after
> registration, and drop the manual drm_bridge_remove() in remove().
> 
> Check the return value of devm_drm_bridge_add().
> 
> 

Applied, thanks!

[1/3] drm/sti: remove bridge when sti_hda component_add fails
      commit: 84ae1840260fece9b6b70d3872b79384bbe5a90b

Best regards,
-- 
Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>

