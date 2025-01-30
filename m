Return-Path: <stable+bounces-111250-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9908CA227DF
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 04:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9B923A5820
	for <lists+stable@lfdr.de>; Thu, 30 Jan 2025 03:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7353A4594A;
	Thu, 30 Jan 2025 03:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g/gRfNJg"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EB4A23;
	Thu, 30 Jan 2025 03:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738209075; cv=fail; b=bxwH4lJcRIzUX5e/BRVU2yJT1DWOCvWCLCPga2jTZAt1jTxdoHdLCbhe53yy0O8rPez9r72LvOsxDf+zDCd9+o8tjUtEDE3gTtPizNeLQHpZb1OgYt6Z6BqSnxHXn6WvR3EBQBb2U2iyqW1tltrqL9HHKlv2921+woCnJRt4lOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738209075; c=relaxed/simple;
	bh=eL6d+k4PZXbMEjoDhjCTnS7Fgz26Ymgr/P4HymwgKFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oI6EyZfvWEh3iHmIfPw1OhfuFSANB8pqRaAgVADciexdioSEiWez8wuY46capWV0fb8uATMqWg/RqkiO6O3cof8+TtrvG2ej6GzZwkulQEhqZukcsnijxzEWpqva8aTHckvFUrAVNRyPaJ8AX/k4TQvRAzdHph1T5VIDotaZ8F8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g/gRfNJg; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738209073; x=1769745073;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eL6d+k4PZXbMEjoDhjCTnS7Fgz26Ymgr/P4HymwgKFQ=;
  b=g/gRfNJgyVuhfIs0zw8kdM3WiP5D6EAEZcTbNpL1RDlUI24o0uAhLT6P
   uZch6cLR28I7+aDB0UzADMJ2NYvELEiXpKSjAqYqvd3xKtvSTyNYwhHYf
   eCQz4VRAi2Dj1tCsbc8TFsTEH7llRgwTD4zYKGnbCQZx64VPZdsXTNuRA
   fdBL44U1uxkXxvh2JeQ5WuVVeZFqOy5ELjyIyASf3orZLAlc1497+eGWo
   fxbeIBWOXk2Zu5ib2pwKyWbQh8HXQn7QL/vzGrYLRGnwWk+FsYD2qfuEx
   nKh+m/JxcnU4tHEbd2+N8a5Xq2y2H375il0p5jQQm56AgaxD3sJt8eEzi
   Q==;
X-CSE-ConnectionGUID: IUERMscQRpKk1TdLG6Y15w==
X-CSE-MsgGUID: MdvFWWDAR0eQ5KkqpPkaRQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="38849919"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="38849919"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 19:51:12 -0800
X-CSE-ConnectionGUID: fnSzxDVVRpOxt4S0Hfx7gw==
X-CSE-MsgGUID: H3UmREVESEm2/U5Q+mnZ5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,244,1732608000"; 
   d="scan'208";a="114227181"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2025 19:51:11 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 29 Jan 2025 19:51:11 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 29 Jan 2025 19:51:11 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 29 Jan 2025 19:51:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GMC7P2jPTIFm+OKiUgeXnKJ2C2Ncy3NSvSzgfYJPLbgJEDV6au1+4BxQFde/kwmf03hjSynWHShijmj1gd1hJNWuY/cD/8CLmbSXKmlyk4mh5o+Tmetg5t1Em4c57tmyJQFYNM7GN+0xjkVq+W0K3wfZpBvV5wvMsXtfqciXuuR43z2Jolj9DisLSSH1V4b8FS+INWpygcfgLTiWinAHCDTcPzMjpzLBSKRfYzKGMfJBDV7kqoRmiIiSO2RhYZGCK+51Vp2RLoy7egkxJS27ny7ru/R6O5tyxy/mKKJVp1/9evAylT5WRl/c7QPJGU2x0PXgs2GiVA+gM9jZHFaPwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ahFpeidOlTrkyrDYHA9hHP4bez6WHHJhv4jt1vY3mg=;
 b=AY/L4Uh0flEGwl0eDvjqHDGXrcDRRR+iIYW6yF3RupozQZkFRANSJQ4HoKV6yqJgHvkpi8DIvuDg6fS7+yPrxtKXO8msgxqogihZRIGsZSN9PbwDU3ZelW2p/XAcS2wzrvkmlROEzeBwgjdnjWb5gTljwQb+fJUI3CA1wD8g44F5Y44yqNeB8xflC33NAYYLEMYYJl1KFHcR5Mpxaj4cBbV0SMDqB8WOVZOjaihvYX4PtwlDPkNkfHXBx05Obd8ltDbXw66X4Gl+GanDzAyLRXGnA/0kLG6oU8wYUl5IrBsssu/1QVx6inLKdT2+K023eRI2bUYGJayiII3I8P1keA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6532.namprd11.prod.outlook.com (2603:10b6:208:38f::9)
 by SJ0PR11MB5104.namprd11.prod.outlook.com (2603:10b6:a03:2db::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 03:51:08 +0000
Received: from BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f]) by BL3PR11MB6532.namprd11.prod.outlook.com
 ([fe80::2458:53b4:e821:c92f%3]) with mapi id 15.20.8398.017; Thu, 30 Jan 2025
 03:51:08 +0000
From: "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
CC: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
	<vigneshr@ti.com>, "linux@treblig.org" <linux@treblig.org>, Shen Lichuan
	<shenlichuan@vivo.com>, Jinjie Ruan <ruanjinjie@huawei.com>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when
 DMA is not ready
Thread-Topic: [PATCH v2 1/3] mtd: rawnand: cadence: support deferred prob when
 DMA is not ready
Thread-Index: AQHbZ8ZOILCVzRcq3EiB9N8/dGJ/ZLMhBMtugAlQtQCAA0UcDoAA++Lg
Date: Thu, 30 Jan 2025 03:51:08 +0000
Message-ID: <BL3PR11MB65321B556C59C995DC05C70AA2E92@BL3PR11MB6532.namprd11.prod.outlook.com>
References: <20250116032154.3976447-1-niravkumar.l.rabara@intel.com>
	<20250116032154.3976447-2-niravkumar.l.rabara@intel.com>
	<87plkgpk8k.fsf@bootlin.com>
	<BL3PR11MB653276DFD3339ADAADC70CCFA2EE2@BL3PR11MB6532.namprd11.prod.outlook.com>
 <874j1i0wfq.fsf@bootlin.com>
In-Reply-To: <874j1i0wfq.fsf@bootlin.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB6532:EE_|SJ0PR11MB5104:EE_
x-ms-office365-filtering-correlation-id: 8a6780aa-5bee-42d1-d050-08dd40e15451
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|10070799003|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lcfuZR/z6xpO0w2s+Zvv6t9YNvmmPlTh5pU9Y0kPAJkHsj29+TrXxDBCIdGg?=
 =?us-ascii?Q?R2nALkmTSXxFt6tYIdDKeb8z6lU7RKQ0uWAuMaKfnZsS8Nx+PUeqPBrLrsyV?=
 =?us-ascii?Q?lygrmM5+NkZiz/IkEpkA/oqOg0bTB6vxFVndbYAOT2nMRKkktLfx1erMG+Hg?=
 =?us-ascii?Q?vG0B1fhy5J3tqy0mSo3cHXWvAkDAnJLJS+bRKpy32uZD+i7Gty7KMnfyGl4K?=
 =?us-ascii?Q?fOsNzBhEqXlKenw7Agn1qJFsNDObpBhMrjD5U62Xqz+8NuixKlt0g7KJHJM5?=
 =?us-ascii?Q?eGUMlAiKhKTRf3LjLO8Nl7g7TyhSK7SjGe2KQuez56WGfPBiECy3Qj7+Icoc?=
 =?us-ascii?Q?VhT6ERCSeSwZI2UgYOown+PRCnpWEmmoZ8jyir6eKTxSXsKWqLAw6giUeJL7?=
 =?us-ascii?Q?D9kRn9XTK69WoyeF1/N0hlpqv4TkwiIGcvI6WOlTkPh+7OGJz6z4vhCjDpd+?=
 =?us-ascii?Q?jO7GmvZQDZMSNLqa1n2uPMnJLOYw9YKQDQr06ux3A9BmWkfTQ+2EZqdlG4ZU?=
 =?us-ascii?Q?Zsgul7bt0VSJNXAxm9eVQ8g/gZPahDGMEfDG1E/ppV7gNCMeQOoVBBlmpkQP?=
 =?us-ascii?Q?iR+sdNzffNGuzL7cH4S4LYbkT09EF5YGaEApi3qOurSuvF5a04dMAGdk4xbr?=
 =?us-ascii?Q?SobhT82nh3LWIa72k9OeUNustpW0WYxoA5X/TqiAdp1KrstiotXTrASvksyu?=
 =?us-ascii?Q?fT4zKwpXwJXbUzbi9dlDOX9g59btTi8puOaK0ZIqCX9QmpvRav/5Fv9OsCJX?=
 =?us-ascii?Q?1GxShlZMZoa1TvIlJbC1/bSdIqbY9bAyY7k2TpfUkdaV6rfirsD8FjDOhkSl?=
 =?us-ascii?Q?/7/OwOoWAs6zPzPBuIsojKA5pn6zt+waEYI1TZY1Mu5lgjnnjtWcu0vXzn50?=
 =?us-ascii?Q?m9csPHuyqNapvTIrZRExpKE4X2U2F3qwebmYGLJMipL7TrcU4/NBhQMdq9IZ?=
 =?us-ascii?Q?KkjxRfv5TnvP5MHYzxiHDM+/eDZIcOOP2lPJH1HtVq1O5XK0BglY5h0KK0CA?=
 =?us-ascii?Q?gEtUF3LU5nRgygBqoTMReHDsqCwUpLXGWCrTEx90s1/ifkYAeDlg/+DjqH5Z?=
 =?us-ascii?Q?BXjpxhorwIf2K0/jiSDFNIIv1tm1uGzLUg8NqERwLip/i7X9+HZcfrqH5OZW?=
 =?us-ascii?Q?gTBh8UYKO9PLihg5lv2Lf5CnjlfO7vlP+bKdSyEePZOOPvwS76CGsqMFg7Bs?=
 =?us-ascii?Q?itoUZabA7waD8+c+gVrISx1r1ECRlzwOug3eTRxl/yfh56nDsIiyXe/R5WsD?=
 =?us-ascii?Q?GNlR/7J41nPcA0e2notuxddZwQkSuRsbI20IVkf2zToTVpQDegDdzYTsa70T?=
 =?us-ascii?Q?yowY7L5fI2p9nClkwWhZWAG/o8xrNHotpU0ZvwQUWYLwAJRoALpKEprLEilM?=
 =?us-ascii?Q?pLZnkDGXml1CbU9+xOc5lzV4lli2K4wjrzEOv8GiPgPaUgp1XEF/UKgx6IMI?=
 =?us-ascii?Q?xg38rIijLbsMyBwM3lr3rI2i9wueYwjh?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6532.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?st8fhovabkoFIe35ku0VFB6FlGiPv0RWL1OLdsf2r+4Q40vGHAG/CQmc+XOS?=
 =?us-ascii?Q?RzGWCNdtR5QzlVErEbNsDkuMJVWvGYA3ihmZTQ7efM80XHbBftasigR1HHW+?=
 =?us-ascii?Q?Pp263NLgonfqZ4nPk+GNcEaFCQAuhb8JxldwHDL8hMh1RLu9Je+0JTESSvqA?=
 =?us-ascii?Q?OGjdf7hePfzn02xWLr+BWpD5M4S+CcJWLsgpvWVQUNTVY2JoBK/59UqlyoYD?=
 =?us-ascii?Q?BZaM34z1yTh35R5N1drjEFdq4UxQarp/dd753ymKWk1in1irQB4z5UzKWDfI?=
 =?us-ascii?Q?nrvD6jRNxA3H9lGTyoBB85/xY9luDugrP4VBiM2b5WSERCMq4e9/VJJxWt0s?=
 =?us-ascii?Q?77MwWqjRgdvZ2zFGPZbInL4H66ims/2DfwhXOSV6sYNxmlpRWuMTg9qf410E?=
 =?us-ascii?Q?NBERbLM1gjkE/CteMl5cdXgYYhxWo1OizJmBPCoZPT7lHtvvPnwTPXgEU5xN?=
 =?us-ascii?Q?Jnk1+WxM8BSnoIFwQtpO0xCoiRGy2PzjVI3VBfFbbZASDFoWVh/MVwYu32/m?=
 =?us-ascii?Q?EYtNAD5l0tXwtJg5RyxdjHUcqt7AZ3Mz74+QWz8CdJSUDjAzOqVQvMTyeFiu?=
 =?us-ascii?Q?HXcF6iluTkmx+iDph2o0OJSEWTKcp922Jy3f8u+bFIsASd0Cx95e/QL4sxhe?=
 =?us-ascii?Q?4DF9nXByQlNqJrIAUzkxWJ4jRdyu6xu6ILVCl6SpYL0OOGBh6IFdOyfOkSu5?=
 =?us-ascii?Q?EBSkNbw+gCM4b1gzRitbj95dplxMbzQsea46hjkuPsJzZ7OWL0ILRmKeP3Re?=
 =?us-ascii?Q?oTZ8dSfWfP0dVJI7WoB0QNyqymP5lb/Ulmfer7zLFw8itwrnrQQfG8il4naj?=
 =?us-ascii?Q?LlZNaY/fB1j6q9FyuDxsFHai9woQ0zBIUVZkFaJgtzgfyztbhKoHv6tLXBGO?=
 =?us-ascii?Q?3llLaKJB+XZ630INKPWuS72BuYH3zeU7d4xXuGIXOjjLGGNbB6Jhhzw04Lqe?=
 =?us-ascii?Q?9px84PnG6y0OSuC6i7Qlp9/+7MpYD9GrPxxy7p46tQreTya2G0dZ+etWGxNk?=
 =?us-ascii?Q?dXmnhb8kMeiMZkmEuHazAIAMp58mFmofRnd0ljnAH2MtyD6osarpIZ3qH9Lt?=
 =?us-ascii?Q?tGPAduwO3V93YYgFpFbG+em2stwwtd8ce/E3a3vCe/IxjgZrBue7va2AemPT?=
 =?us-ascii?Q?WwG3YqECqeVBLW1E0ukZq73ceSCPcaaeYCxTdA8QWnJhcFkU6lBqjyxmzRuf?=
 =?us-ascii?Q?bQTJH2jQwWmZwvXB/oxt/oPAb2gxI1GDH6J8PU4HQryAAVU5vlMjavHZXQns?=
 =?us-ascii?Q?unvHzu7oOYqZmr+w/Of0nf3MvNpMV4k8AQFwTynj5YATFapkxFWuK1cjb02e?=
 =?us-ascii?Q?oxoXVAhLJHZr+FwXN646ce5Z0hWFu9bvWLkwirPdeqh4DvseaiiNHn2oQ5Zm?=
 =?us-ascii?Q?i/VlDnak7W4jPIyTFzD32rww+nPI/jQT7M9rWj6BPn2mSbzcz4HVykJc5A9q?=
 =?us-ascii?Q?ms7i8GV9AwMxv46NafnPa9JD0dSMMQ3QpIfYWiWF11Yz5a6MBVBMU3NurbVq?=
 =?us-ascii?Q?vRxhlZl1Z908mNfCCvO6fxl3l02hzFqrplkvIlv6zi6HoKBnxX3/iIs+/HI8?=
 =?us-ascii?Q?prgKuhpvWtotHWJKi88zIsiwQqOsH4tXKQyytdBlGJpQ0nvAmq7K1Gc9fRH+?=
 =?us-ascii?Q?v1HYT/0Tx5WLYngO9LM7BrIOsp8BOraPT79txSYzeV/d/jKGHwy8gmAEZNyX?=
 =?us-ascii?Q?mI8oEA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6532.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6780aa-5bee-42d1-d050-08dd40e15451
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 03:51:08.2415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jz1Zea9qR5YfVkRVDpo+dqMNEip5LJklcpm09EFCTDjRQm4+P61LRWWAPf30L3Qe6ALmlcA0wN/Bl9p2GOSHzoVK63Ao2bUVJr/tRkqzR54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5104
X-OriginatorOrg: intel.com

Hi Miquel,

> >> Does it work if there is no DMA channel provided? The bindings do not
> >> mention DMA channels as mandatory.
> >>
> >
> > The way Cadence NAND controller driver is written in such a way that
> > it uses
> > has_dma=3D1 as hardcoded value, indicating that slave DMA interface is
> > connected to DMA engine. However, it does not utilize the dedicated
> > DMA channel information from the device tree.
>=20
> This is not ok.
>=20
> > Driver works without external DMA interface i.e. has_dma=3D0.
> > However current driver does not have a mechanism to configure it from
> > device tree.
>=20
> What? Why are you requesting a DMA channel from a dmaengine in this case?
>=20
> Please make the distinction between the OS implementation (the driver) an=
d
> the DT binding which describe the HW and only the HW.
>=20

Let me clarify from bindings(hw) and driver prospective.=20

Bindings :-
Cadence NAND controller HW has MMIO registers, so called slave DMA interfac=
e
for page programming or page read.=20
        reg =3D <0x10b80000 0x10000>,
              <0x10840000 0x10000>;
        reg-names =3D "reg", "sdma"; // sdma =3D  Slave DMA data port regis=
ter set

It appears that dt bindings has captured sdma interface correctly.  =20

Linux Driver:-
Driver can read these sdma registers directly or it can use the DMA.
Existing driver code has hardcoded has_dma with an assumption that
an external DMA is always used and relies on DMA API for data transfer.=20
Thant is why it requires to use DMA channel from dmaengine.=20

In my previous reply, I tried to describe this driver scenario but maybe I =
mixed up.=20
has_dma=3D0, i.e. accessing sdma register without using dmaengine is also w=
orking.
However, currently there is no option in driver to choose between using dma=
engine and
direct register access.



> > 		cdns_ctrl->dmac =3D dma_request_chan_by_mask(&mask);
> > 		if (IS_ERR(cdns_ctrl->dmac)) {
> > 			ret =3D PTR_ERR(cdns_ctrl->dmac);
> > 			if (ret !=3D -EPROBE_DEFER)
> > 				dev_err(cdns_ctrl->dev,
> > 					"Failed to get a DMA
> channel:%d\n",ret);
> > 			goto disable_irq;
> > 		}
> >
> > Is this reasonable?
>=20
> It is better, but maybe you can use dev_err_probe() instead to include th=
e
> EPROBE_DEFER error handling.
>=20

Got it. I will update the code as below.=20

		cdns_ctrl->dmac =3D dma_request_chan_by_mask(&mask);
		if (IS_ERR(cdns_ctrl->dmac)) {
			ret =3D dev_err_probe(cdns_ctrl->dev, PTR_ERR(cdns_ctrl->dmac),
				    "%d: Failed to get a DMA channel\n",ret);	=09
			goto disable_irq;
		}

Thanks,
Nirav

