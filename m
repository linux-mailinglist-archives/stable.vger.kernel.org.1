Return-Path: <stable+bounces-246747-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CwJNsAGBGoHCQIAu9opvQ
	(envelope-from <stable+bounces-246747-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:06:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEC252D71B
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 07:06:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 650313055D62
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 05:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5A539DBDD;
	Wed, 13 May 2026 05:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="uVsc1U82"
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013006.outbound.protection.outlook.com [40.93.196.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9694539A077;
	Wed, 13 May 2026 05:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778648671; cv=fail; b=cbJRAxbJp+qmdmdiz+KzZB5Olr6p1Zq7N8s6IoEJznnS6H4ehfTWw1nm+3ZxgXClsOthIgYMyuN2/w+nEVn22Sx/VQdhlMJurtXFtFnlT5mWNLWMV56WMn+xTU2vxVuxwWU2I1cdgL7qrd9GLHb4AZ0sY+/xObNJ0RSo9nLWsBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778648671; c=relaxed/simple;
	bh=S8UMfKAoDotNWSMDECgcvBI5TDDVAWTmwLh8LrqgiFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uc+O+HicuLglald+PLSO2pJF81NPL9V7mS5PFe8RfNApgwKq3SpZ5bC2JkYnxyZgC2vQXW/JQE+d0axIhWwqOjS3FwHIKTyI8w4PelZVF4/ghwmC84hpuzXIaG470pH04g85kMxPpYcpMjFC8q0SyDgcGUKsMTPd4f7795UoQk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=uVsc1U82; arc=fail smtp.client-ip=40.93.196.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cJKTgi0XQnVfOZG4ttDbX6iEnarhrwkaQP4y2D1OfgGoHvqm0q0J+GEjBqyALSIVjeOipgFiO1G+8fENV3RASe/AuEGzjnR64ZN9m/f7aumDtGLG1gCV1wf8qfKbj8INfXbelLBPZWkrOEWrL44ecuwBYSPxnRgCvijEnyDFVhiSAdlAiT4FE4NOm6zegdSztSefFCOpvqEcVRIa25Cz8F8kFPyqOCwCv7z2KfVusRzIHc/Cbw0Ix7dPLqBOgeZCNIqR6ntN4t9l0nlk9tGdJZ6G+nNBiVjjEAJoNxxt3CzcNVgDVZ8JPEFrmKPYOqlwhCUXpkbJv5NBk64TsQbgIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0L7e9lIqPC8X3+V82e1SGUuk3M422PvAD8xYZ4mDock=;
 b=QE2ZIkcMsE1+RwzJhbVkiXkvQD5zbx+hxmRmV2qrpFo2CeqrbNOebwZStjxrpIq2uykcMCAmXIfPqUUHflHhxTsDMggFlSNLWEYyyLIwLz02q42t3p69yctwgRRJndTy4/gW+YN+95mEL/A8fKUE9KbHcLrWT05vnizAnt0CtZ8fII5XnVnLyzObGEeChjmdKZeHGgaQ/hS8ou/qySwHug3h0LirLMdmsATI562CVhfLhj4RmQB2X8NvlU1PciogcNb9cVUbcd4/NpnbWWYMao0Ywzvl43eARozCZlrOe0KvvEi2Y8Z6hVAQbmO36hWM+LU6r50osGc9w4NCL9F6Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0L7e9lIqPC8X3+V82e1SGUuk3M422PvAD8xYZ4mDock=;
 b=uVsc1U82COtMB94q48uqlHLrfxyDmu+sB0vRqKCGEm6QU3di2S0PmSjCiDLNf+CjseC22A6oZKYB9w2MvnuePIkvuAa0VFYJvR4DWZK0B40BgviKMTnjd9ddPiK/VeO/BQZ5yxQdYXscIpZW3jFNGrx+2FfQBZkYpQr2TfP7mpgJ0qZfhC4poaUyUiR686sTapK/+PuYnovYMb3SC0NoKZ5oBH/phTVRwPgPQEFFNSBkmUQz/NAEevAOyyH7tKEz16hCdIG3L8hR+zLUcrQmEcYHuYuXx8tNN5a960Wc3DvGGDXnUVlU3ebCdNAqdBjYh64QQNTVk8jnceceOJJSNQ==
Received: from BL1PR13CA0067.namprd13.prod.outlook.com (2603:10b6:208:2b8::12)
 by LV3PR22MB4845.namprd22.prod.outlook.com (2603:10b6:408:1d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.15; Wed, 13 May
 2026 05:04:24 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::a2) by BL1PR13CA0067.outlook.office365.com
 (2603:10b6:208:2b8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.16 via Frontend Transport; Wed, 13
 May 2026 05:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 05:04:24 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 5D970131E4;
	Wed, 13 May 2026 08:04:20 +0300 (EEST)
Date: Wed, 13 May 2026 08:04:19 +0300
From: Ian Ray <ian.ray@gehealthcare.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	Peter Senna Tschudin <peter.senna@gmail.com>,
	Ian Ray <ian.ray@gehealthcare.com>,
	Martyn Welch <martyn.welch@collabora.co.uk>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Archit Taneja <architt@codeaurora.org>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 3/3] drm/bridge: megachips: remove bridge when irq
 request fails
Message-ID: <agQGU_N7DtT4nvU2@zeus>
References: <20260430195700.80317-1-osama.abdelkader@gmail.com>
 <DIAUSFCMDQEJ.37TV8SIXF9OTP@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIAUSFCMDQEJ.37TV8SIXF9OTP@bootlin.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|LV3PR22MB4845:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc33f7a-ffce-4e67-7f0d-08deb0ad1a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|13003099007|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info:
	8hVaLmKiCkfJGEkD3oJcSKY3dIyMVpUIQdf1+EXpDSwn7IvCple6E/+Pu33wnslIUir02yxmLF+w1NQyH8EjzvBZCcXq2IkGSW9jzE++wISHsyQ4/QahJ3VmNP9eu6onvtqiAawINlMsZSmT4aM7o8fvJcALHQouktBkKJKYTnH9Sad7b4FrCynPLwDAsjKoecQ2OZSX9J3EIDMFFKT2MDhN1b2XAyF+Dlqs5YyFAs+qc3z7uyo2z+GMFrACzmAXlC4PqvOjp98nTTXoN2RYaW8ypBb9EFW/T0iugHEq4Z6VQCkWT4JebjqPh0yw4sw4k3LDJo4/UUWtJz++B/PeZqP3NhnOPe7HbylSCqQ9cIggEHCGi5p8O+aUi9CScyTm8Z1MniOCydKXwUC+SWBeuwnQqgqXUlY4gf8x0+s6N9pBQms5EXKQGjdnNc5RqjzSUK1/PhJy6xNTTKBsPBPBSQLrfEVmNEyONXOBv25+QjhT+h0N+hIGFBM24E/bwzzJaTuunlvpNh8NDFTrsZOzcTYrwGlijP/JRGV/qDo7ipM4hOTzj5ns1LJYuh1u1fXf/6NmNKj3PC2FKHcbWV0ccBCvCH5y5WCzjw8d8Cq0alsEIr0apglIBnZPrjWGNbj5RF9xXnPfP5ZaJl+B+Z2m6IOiSHGuF6rppicwGaqnQHTvcjJQaYMFGKX3w6T9TGnT
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(13003099007)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RF0a8Qfk+/YeliMQB7I4PMnNjfujNTCNZvsV6gChFHCAjModTRhcy7QDrAJ7Lm7XLYthqZyzdC0N+NvhsbsYmGUTBhE/v589v3sHG7SxGpaM0an5XIR9GE0sgA5wTH202JgmkE+vNRcj33dLmgILKfVaFsomLoO7HiXVxgpNkwVBT6rw0WExr8lSZrQME1yQSSSFJc2oiCUV2jSurv6fDMYf2Pcnp3g8lHefC7Wg42S/zJZKKezSc7HQuUIlF4hzXrJ7ZbrhDYPWNAQos9D4y+9wsNYSBFPdlc8MDC2y5/12mrsNonyhImNDzr+4zjsc6pmVge8E1fjVbrC/InuBs7OWTVA/oFuKU65j5S+RYcqZ3ZqrdqovievlKxG/kxKWH5Xk292QF10035JxHybG6pVdZIvkyu+2yZOSYNeWoRrhG9C3rJq/bXC0x+I12Yu5
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 05:04:24.4451
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc33f7a-ffce-4e67-7f0d-08deb0ad1a1c
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR22MB4845
X-Rspamd-Queue-Id: 3AEC252D71B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-246747-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gehealthcare.com:email,gehealthcare.com:dkim,bootlin.com:email,bootlin.com:url];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[gmail.com,gehealthcare.com,collabora.co.uk,intel.com,linaro.org,kernel.org,ideasonboard.com,kwiboo.se,linux.intel.com,suse.de,ffwll.ch,codeaurora.org,lists.freedesktop.org,vger.kernel.org];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 05:37:42PM +0200, Luca Ceresoli wrote:
> On Thu Apr 30, 2026 at 9:56 PM CEST, Osama Abdelkader wrote:
> > If devm_request_threaded_irq() fails after drm_bridge_add(), remove the
> > bridge before returning.
> >
> > Keep drm_bridge_add() rather than devm_drm_bridge_add(): registration is
> > tied to the STDP4028 device while ge_b850v3_register() may complete from
> > either I2C probe; devm would not unwind the bridge if the other client's
> > probe fails.
> 
> I had a hard time in getting what you mean, until I noticed the global
> (ugh) ge_b850v3_lvds_ptr and the two "Only register after both bridges are
> probed" checks. Pretty hacky, but definitely for the sake of the fix you're
> introducing your patch will be OK.
> 
> > Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
> > Fixes: fcfa0ddc18ed ("drm/bridge: Drivers for megachips-stdpxxxx-ge-b850v3-fw (LVDS-DP++)")
> > Cc: stable@vger.kernel.org
> 
> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Tested boot and hot-plug, no regressions found.  Side-note: an update to
MAINTAINERS has also been accepted [1].
[1] https://lore.kernel.org/all/20260508234835.38732C2BCB0@smtp.kernel.org/

Tested-by: Ian Ray <ian.ray@gehealthcare.com> 

> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

