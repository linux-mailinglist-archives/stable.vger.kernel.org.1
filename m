Return-Path: <stable+bounces-225323-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJBFEzAgtGnahgAAu9opvQ
	(envelope-from <stable+bounces-225323-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:33:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A45B22850CA
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 15:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E8131A58EE
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BEA13976A6;
	Fri, 13 Mar 2026 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="kBh8yHW3";
	dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="MsxDBjPP"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CE83A1A4C;
	Fri, 13 Mar 2026 14:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.149.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773412143; cv=fail; b=CRt3C4nbLKxS3YtybH1/4y/skADGjSqO/7ddFB62MT+TNYiNkQqzFOG4mjmiSf5rphbCl9GfoDWyW9kjmTsx1HZprsyK92dMXZ9F29MriBtCWT/essEvpFpywK7K/5X2ulEmAiwHynQktSZ2RUIYQWWjJAPMoOM6Mmj3g1rJTO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773412143; c=relaxed/simple;
	bh=YyEjVa7+rYOvcug/ZgVhMAp+8YZjzz4l37b+KTlMXkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1+a77r0C3ybXPfUwMXmCWTtmG14YXHtIvSEvJUpIXW3JhNHSbjhEuqqPOAsL/fj4Dp3qLU40IexKtsjWo/H6DTGyub/nrmjqxN4UAQDU83EGedfDdX9HWE90diVPSPtI1sjU0XGsXK+KslNd7VZ4zl49HCcL+m8E7YL9Oi88nY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=kBh8yHW3; dkim=pass (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=MsxDBjPP; arc=fail smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62D5PAWY2117611;
	Fri, 13 Mar 2026 09:28:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=PODMain02222019; bh=Pk+TqQGjrwaACg6TIC
	pCQM9EEJpNDhFIMfJJJZrbLF0=; b=kBh8yHW34JJvk2DkEuY3aHW0i26QS8Bc/y
	X2uslfYhjROTZUQOjyVxaZDuBfvDeFVfkb+SpVIcBFoQJVoQZXCL4MOo6RRIL21V
	jcdQ68nDUMbLEc55Tet8l6rSY9X1mSOgavZTW978WgXE8zw8nrsFqSsWHY9PR+iA
	ag98YjaGtHgeqCkXdjuxm2sHfQghniySjhU1tn9J+B6SsGeen6gcIFp9nlRIXojI
	ES1c23+3dJ1FC9Eg4csZXbOexCzNysDDS9ibcgE8jfGoyn39ky0V4R+GVGfeTKrJ
	fsfbKVt7792s9aAjXNEKRKBjSUr1Uk9mrQ+w/FpEtHzc30MfUrMQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023081.outbound.protection.outlook.com [40.93.196.81])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 4cuh78tftw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 13 Mar 2026 09:28:40 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDamJT0/jjpSwLiu87l4UgylUWXwtqnSPPrbe/kd/EUgdxwfiDWKkYAR6mnn7xNxd3AuVnPfx7bXMW4iZv+Zl3wM1YFR1kqLnw7tPFVGSiRkGD+jBuN5klZOaBVdZUv0xx6Ug/PubUY/Z0fXcD9Uy0jcmm82g4AmNQgVR7Qj0weEg6+B3/pGvIyXKwYbvq2buboitw05yfgnIDazz5iIdiutv3yTvl7Nq8qHHKzh83TFLsnZkujuUxGYG7AZ4C0bcefw3IzezW5J5rIFlQnyGlJUAkfpnn07CTHjtNn/gHuDt03hM57Ab5NoJ2KZdPZT5TWJTrJrUtDXvAlH94SacQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pk+TqQGjrwaACg6TICpCQM9EEJpNDhFIMfJJJZrbLF0=;
 b=Nq8N1d4LO9HdfJWgB2EWeXtJ/rwRCAFav92X3isIGSzdJ2txQpY5Eq+FWNUlQBr1EviPrz+f6XSOHhfnoC0ZRnK/juD9VFEI/orDNEp01U23ize9GdFCkUCC3XZ+ZWqOAJh78F8MTBGaOi/70ahdL1xwFHRiuWL58TNi8K44SeNk7tmQ3Clv8r94KElasfDHImDu46G3SKG4GzpFkIIoV3tGjhYMMTqj+uTAFncujO8fwq5xgT4NiKuBh6+C2eEUNy4dEltW32+yTwAWcEX55tTzvM1nGAzOSqYPjO2ooMDkpCxLnqpzlhPhn4mOKcwB69NnOZU54bKGh9eah24HXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=intel.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pk+TqQGjrwaACg6TICpCQM9EEJpNDhFIMfJJJZrbLF0=;
 b=MsxDBjPPlyJGdbXchD0DiNVHuJjkD7VtmENd6m7yIcOngiIx2v7HLFjduO9356byL7SHYKXFUs6j3/pBZnhlk2OroJAwTgWHe7HUoBc0y6Y+eh95BJwMeOihpgTp6gdfgj1T7Ce3Glz3Uuk1daamVpbMhJaBNrcO6fkZxriRx9E=
Received: from BYAPR02CA0030.namprd02.prod.outlook.com (2603:10b6:a02:ee::43)
 by IA0PPF65309C1B4.namprd19.prod.outlook.com (2603:10b6:20f:fc04::ca8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Fri, 13 Mar
 2026 14:28:37 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::cd) by BYAPR02CA0030.outlook.office365.com
 (2603:10b6:a02:ee::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 14:28:37 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Fri, 13 Mar 2026 14:28:36 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 01B67406542;
	Fri, 13 Mar 2026 14:28:35 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id DE07B820249;
	Fri, 13 Mar 2026 14:28:34 +0000 (UTC)
Date: Fri, 13 Mar 2026 14:28:33 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
Cc: gaggery.tsai@intel.com, linux-sound@vger.kernel.org,
        mstrozek@opensource.cirrus.com, yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: SDCA: Fix NULL pointer dereference in
 sdca_jack_process()
Message-ID: <abQfET9Yi3ad5hIF@opensource.cirrus.com>
References: <20260310183829.2907805-1-gaggery.tsai@intel.com>
 <20260312143218.2008222-1-gaggery.tsai@intel.com>
 <abPe1EUHUX9ZRZJk@opensource.cirrus.com>
 <809fbe87-2154-46e4-94ca-da75f8d4b817@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <809fbe87-2154-46e4-94ca-da75f8d4b817@sirena.org.uk>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|IA0PPF65309C1B4:EE_
X-MS-Office365-Filtering-Correlation-Id: f0a182f8-dea8-4757-505e-08de810cd040
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|61400799027|36860700016|54012099003|16102099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Nc/Xrq48eJSulkutsYaSb1/Zlqqjn5lN+7eAsvNNdcRLN8po+yc3n6BggkCl0K3K6eg82ae51iLkxbcGrNBk0pchMsdG+x8uREoEQIQbgsxIo+4ImwPC9TFbTqUCjfE9w8zxQNtiQzeWzYraXI0kKHxkTBnDWXzAlJc7qcXdfokZcXsa15zED0un6qA1bGaj2SnjFoJXBnytZeltMUUMUXmRYYKQta1n+6vqDtai/DsJWlKEC064U1gXIe4MBhPzKquYFEFZZj2fyBq8oJYpm0kouJdyjF2TsoTe7h3OB5UyFlDA6Po0VrtFKTutZiSDss5laVxom9+MEn52DFzrd3at5I502jDQ7l2Dd/lzo/3ATlATUkNZoBGBnXVl74zJQHiAnXmkp3zzX5uRfC4Xnr2/qGXBZ7YNIvU/oUIBKeQcYmR+nGPaWL4diOugKD8liCiuR+X1/dutUHPH9yppZDDpR9iD/RCnscYai0OLGMRKjPxgffXDtyzFwlhDlc9XsMrgCfrPraxj4Jo3Y9fHksMpUWZEZYiLTjmHikmfku2lNboMD3XwIUB4E2AOSv8ov1/sph1X4MlMqZ2eXNlXSec2LYbI9glSRj11eyvAlxA9HLECsJrUUK0PH26Sq0QDMuveZT4D/yRjfjE7or80z+dWYPhbKeTtX8lYaGky/INmFywejMwrNV97PDwT8eZ2HRjusS9+ClQ0iUebn4uLU51Mxi8a7m0HcyoSMi6D1dPlD4CHMrFQohio9ToPCIDkjClpWlI9+oFtAaiLxHv1Gw==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(61400799027)(36860700016)(54012099003)(16102099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vsrwknr1x2aOGKl6aK1SAySK46iWbuPVc3ly9/wec0DjVVdW5kor8naq4z8n9RPPl8eI6ZLMO80J905dukKD9duWhkGKnhz02lqSzHam5U2UJnJlzsvx2I6UkwOo9K1toyfbArSD3ArmQ9GIqlUYYbtaoOkwy9TRPZrdQfraLn+6aF1Ih35duVyI9DUZWvills0KT/KlDnCL9Q/ttKVKUM2E2RdAQhIOPRtmxPPoM69Hp8gWEmkEj4fHk9+zszTnkYBl/fmUCYo+N8m9tVFh2CpdKTXAJVGCxyTXkhKBdSIzcODjWWgeEJephbNSZpryfNAxhFlo9LNL92lKmYm3mRI7jIMXPsS8fwR/jeez9jK82MP5Dv6QtL3/Lc/H9QUschgWZHBRdsGruCgzvRU9+YD+OzD90NDEaDJBKio7ucz+7a0dOIxqGodTfQxo62i2
X-Exchange-RoutingPolicyChecked:
	I5oTSzh6lxzKDu0DFmFJgrDe9I+J+P5LX7RGKtGs7jPypl1axabR6eZ7Dn+x6FNIR+uGRZVBEKiqvv/mHOovHzmoW0as8ejBZK5hap9Rs3lUIBYMqitG9Mc71DOAjDNBNbPscSDe8XkgM3upDnhg/k8e7Gslmc2lGPrCG+zbqbK60NydI2mkqHnC3B9VIQytqQ1dSn/SUv1/TU52Gm3WtilPI6JJiFYWqWwuf49w4BdxCaAb+dMYWGVGjlkpzFlPTIq1OQvWk2vHKnjQnU+IZoIWSIoT1obmTOfoSkaUw96jqAABALVMF4NQFHDJyUgVhZxIXQ0uwz925cxd3qdpAA==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 14:28:36.3390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0a182f8-dea8-4757-505e-08de810cd040
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF65309C1B4
X-Proofpoint-GUID: wgcQvoCMkg1e3ykLWRtnVmppR2C_8yEG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExNSBTYWx0ZWRfX3C46Vnc8jxDL
 QRIp+wtj5VbcQLJ/SsQW8Q7W3oyan7mSiyxKQDXMyRxpIqk+3Nj0j1o58quQXoxTHaIK2Mlv9F4
 NMPOvSPeRdarPCg3RLr4EBd6qRUxU/N16U4fSzpbYQVKk+QuiXpMtglOOfx8FzGvUOQ7DaD9yBf
 7rI+ove7fViutJHFSr0evZzPzYtVrX7HIHDps3CKvWd9rhpGv9RRmGHlupzdQYnZ8slt1omGFrB
 7Gzvz31Ru2g9wsH4CYxo2UwlILfpPrbPOnVBOsyUUszrx6ZdotYCTeZ6pT6Mw5Ier2KeAEh6D43
 a3u4P5B3nCJo8OqJHFK7fblXJ+0glItLsbIPIbvhaNVkQ3ZcBvGZ7T5Gx+Ez1ntIDFJpEI/VMXN
 RTaHUvB0ONOTB4PkbdR8wazak6z9ojrSpHDzFOAcxkHq7sLT9VERrV02ior/TB6LfxFMTQmEAgL
 X2sEgNagqRo+nVuRVyw==
X-Authority-Analysis: v=2.4 cv=NMzYOk6g c=1 sm=1 tr=0 ts=69b41f18 cx=c_pps
 a=EI6zmuMIMY+nXR31EdRrtw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=Dj2-6B8FqX4mGL0U3gbX:22
 a=gA7lReuBuS9Ek5mMOVYA:9 a=CjuIK1q_8ugA:10 a=zgiPjhLxNE0A:10
X-Proofpoint-ORIG-GUID: wgcQvoCMkg1e3ykLWRtnVmppR2C_8yEG
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cirrus.com,reject];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019,cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cirrus.com:dkim,opensource.cirrus.com:mid];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225323-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A45B22850CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 01:28:23PM +0000, Mark Brown wrote:
> On Fri, Mar 13, 2026 at 09:54:28AM +0000, Charles Keepax wrote:
> 
> > Let me have a look at this today, I think really the problem is
> > we shouldn't be devm'ing the IRQs since they are not being
> > handled at device probe time.
> 
> Yes, or just request them on normal probe.

If memory serves the issue was as some of the IRQs actually
depend on interfacing with controls created by the card it was
nicer to register the IRQs fairly late, and probably nicer to
remove them if the card goes away. Although that said, we did end
up having to deal with the IRQs happening before the controls
anyway (since there wasn't actually a good callback for that) so
it might be worth re-assessing that decision.

Thanks,
Charles

