Return-Path: <stable+bounces-78294-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC51798AAFE
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 19:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AC731C22D47
	for <lists+stable@lfdr.de>; Mon, 30 Sep 2024 17:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71ECD1957F4;
	Mon, 30 Sep 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="gcsXppHi"
X-Original-To: stable@vger.kernel.org
Received: from rcdn-iport-3.cisco.com (rcdn-iport-3.cisco.com [173.37.86.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F55193416
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.86.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727716812; cv=fail; b=P05XCsB56H6+9LHvVyuW/qRxiiU/A8jzVVRqIBntZhJQF8cT5RlvgZvqSSTi/AwmWTO9vV9CXnug6+dzxxD0crCaguBF2eOwnPH06s3cXIdg1yDduacL3nHnshW9aSrG7eHifMoaslObFrXT4Zuk+MRnd1omRVkG4J9upI44RNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727716812; c=relaxed/simple;
	bh=V4TWOKesGUYTKULgI2Vmh7gf2tXpPfZLgSK/RsQsWis=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fsZDbKrjxHw4DN8mi6bInzvc9MjreZjA88Jft0dvfIvZIThEeQHNP29LW38qopcrwh1qRrPqn33eA2lRlWKnJ97v48n2alySGNqSy1zK06wZqyAOyOrayxanXzaErYx6gnnmBnO7FRt/GGCsAx8r9izYRE9LbctsYCBNXcxgamw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=gcsXppHi; arc=fail smtp.client-ip=173.37.86.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2660; q=dns/txt; s=iport;
  t=1727716810; x=1728926410;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EfFw2dB/JI5WFrGWIJMAq/tEHFmNHVRs6eRm37+6Pho=;
  b=gcsXppHiBSjZpFuOFQ9BJYI++fKghg/LbDykdgG8hpRMNWZVEtiv/J1I
   zbV1zEdG+UV3EuEkGbm7Yq2DR24cotSiPEpYkWdabbTDdLLn7FHorAlDs
   s96x7jgW/44Nwo0QjnfxREZqusxU0+kRNuVVy1Lu8Mqyi2JIs3CNc79M8
   k=;
X-CSE-ConnectionGUID: rfCRk8WOQQ2r2RCLBW0xdA==
X-CSE-MsgGUID: yAM4JfFZT92IISAweRgjXQ==
X-IPAS-Result: =?us-ascii?q?A0AQAADY3PpmmJ1dJa1aGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAJYEqgXJSe4EMEkiIIQOFLYhzA586A1YPAQEBDQEBR?=
 =?us-ascii?q?AQBAYUHAooXAiY4EwECBAEBAQEDAgMBAQEBAQEBAQEFAQEFAQEBAgEHBRQBA?=
 =?us-ascii?q?QEBAQEBATcFDjuGAoZbAQEBAQMSFRM/EAIBCBgeEDElAgQBDQUIGoJfgmUDA?=
 =?us-ascii?q?aNbAYFAAoopeIEBM4EB4B6BSAGISgGKXScbgg2BV4JoPoQKO4QTgi8EkXsOi?=
 =?us-ascii?q?nJ8JYhbcJEPUnscA1khAhEBVRMXCwkFiTgKgxwpgUUmgQqDC4EzgRuCV4FnC?=
 =?us-ascii?q?WGHZ2KBDYE+gVkBRoJxSiQLgiF/OYE+BThJglFrTjkCDQI3giiBDoJZhHkqF?=
 =?us-ascii?q?x1AAwttPTUUGwUEgTUFrEdHgioggQQKgXhIY5JfAYMmr2cKhBihcheqRS6YS?=
 =?us-ascii?q?CKjYIRxAgQCBAUCDwEBBoF+I4FbcBWDIlIZD44tDQnAGXg7AgcLAQEDCYtVL?=
 =?us-ascii?q?IFRAQE?=
IronPort-PHdr: A9a23:KZAZAhez5qpxNbi5YrvYjTJZlGM/gIqcDmcuAtIPkblCdOGk55v9e
 RCZ7vR2h1iPVoLeuLpIiOvT5rjpQndIoY2Av3YLbIFWWlcbhN8XkQ0tDI/NCUDyIPPwKS1vN
 M9DT1RiuXq8NCBo
IronPort-Data: A9a23:hu3wka+h1XF9M46qrXc2DrUDkn6TJUtcMsCJ2f8bNWPcYEJGY0x3z
 DceCGyAaP/ZZmX8eN1zboy//EgBvZLdyYBjG1Bp/3hEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEzmB4E3rauGxxZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qryyHjEAX9gWIsYzlMs/7rRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2ksM6Yi+bZIJlh3r
 +ZCEhspRC/bl+6flefTpulE3qzPLeHxN48Z/3pn1zycU7AtQIvIROPB4towMDUY358VW62BI
 ZtCL2MyM3wsYDUXUrsTIJE3hvupgnD8WzZZs1mS46Ew5gA/ySQrjuiwaIuEKobiqcN9j2+9+
 kDI0VbFU0s7Fee21je//XCcv7qa9c/8cNlPTOLjrKECbEeo7ncPARcSWHOlrvSjzE2zQdRSL
 woT4CVGkEQp3FagQt+4VBqirTva+BUdQNFXVeY97Wlh15Y4/S6DCEM+TW5+T+Uf7tVsfxcO/
 GDRj9/AUGkHXKKudVqR8bKdrDWXMCcTLHMfaSJscefjy4e5yG3UpkyTJuuPAJKIYsvJ9SYcK
 g1mQQAkjLkVyMUMzaj+oxbMgimnod7CSQtdCuTrsoCNsFIRiG2NPtDABb3nARBodtbxor6p5
 yVspiRmxLpSZaxhbQTUKAn3IJmn5uyeLBrXikN1Ep8q+lyFoiH5It4LvG4nfBk1a67onAMFh
 meO5mu9A7cObROXgVNfOd7Z5zkClPK5TI+0DJg4kPIVOMgpLWdrAx2ClWbLgjiyyxJz+U3OE
 Zyaas2rRW0LErhqySH+RuEWl9cWKtMWmwvuqWTA503/i9K2PSfNIZ9caQfmRr5itsus/l6Km
 +uzwuPXkX2zpsWkPHmOmWPSRHhXRUUG6Wfe8ZIILL7bfFs3QAnMyZb5mNscRmCspIwM/s/g9
 XCmUUgew1367UAr4y3RApy/QNsDhapCkE8=
IronPort-HdrOrdr: A9a23:QLitXKAZTCeXDJTlHeiysceALOsnbusQ8zAXPh9KJW0vA7zo1f
 xGzc53pGeE+UdTZJh/o7rwQdj/MDPhHP5OkPYs1NCZLVXbUQqTXdxfBO7Zsk7d8kLFh7BgPM
 1bAs1D4ePLfABHZLnBkViF+robsYC6GE7Bv5b0859CJTsaQ52IrD0JXTpyKyVNNSB77OMCZb
 ChD6l81n2dkcF9VLXuOpBmZZmdmzSRruOyXfduPXdOg3jr/E7Yns+xYlbomyvySwk/vcZnzY
 GsqX2C2kzJiYDg9vaz7R6J03yW8OGRvaoJdYOxo/lQBTP2lA6yaYhtH5GEtiskufyi5T8R/q
 iq0mVQdrU/15vIFVvFwycELmLboVUTArzZqGNwQ0GNnSRILwhKXfapSbgpBycxk3BQ+u2V3c
 lwrjCkX2o9N2KSoM013bi4MWAf5wLE7QtirQcbtQ0Obbcj
X-Talos-CUID: 9a23:3fV23G2awGvfqpiNEDj5VrxfAM4OSH6N81DpGhWiU1xCbJeqEU+c0fYx
X-Talos-MUID: 9a23:W6pzuwrWP42DdBnQVU4ezyBLEZtK7YqcNBFXsLQ9ktaJDyNyCw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-3.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 17:20:03 +0000
Received: from rcdn-opgw-4.cisco.com (rcdn-opgw-4.cisco.com [72.163.7.165])
	by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 48UHK2XX030353
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Mon, 30 Sep 2024 17:20:02 GMT
X-CSE-ConnectionGUID: TSGLVcdFSMGaJU4WBHpOWQ==
X-CSE-MsgGUID: j11acWt7Sf2Zmy8/nsuOEQ==
Authentication-Results: rcdn-opgw-4.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="42693731"
Received: from mail-bn7nam10lp2040.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.40])
  by rcdn-opgw-4.cisco.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 17:20:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9beVL549ynoW4SN6HPpPI8nXIr1H3LMh2HZnqSyw/Yq4bNpNcuQ3yUKZEHKKYw2LVitYQ6J7fQyT7Xegz41Ge3mvJ0Gslx4PnygqC3+A1gPFN79RFdyuIrmU66RbswApQqvVeiixa/BvgOvC7yCT7ILUv+lqnu5qGdnaa8Y+/fKZ64MscGcO7PVa5OtW8n/aqWpghzMy/rc5krxIhGe+7tmmejzspI99XPdW8FF6UVmgrbnlM3jTZV6rVS7h4QU2+VvSeOowuMHybMTjUZzmxBz4cOl9O5UkHexCczGoriICNe5XRXjG9oYqnJG8KlAOlmeSCLbtmCLOLbjjt7Yvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfFw2dB/JI5WFrGWIJMAq/tEHFmNHVRs6eRm37+6Pho=;
 b=y+mUJ1IJ4veWk7EauYSjeQRYR3gMP0ufWOkpYx5XxHR+t73DINxE+NrevLiBtDu/U30VaMl03XVNIJrhjrQM9nCFrYFpH8crArkKfWUP8/8rzmFpjkqZpJVmUrzm52y6u6RfmeYVrW3cSUkVCOeIEoBKCzm30tETdM+pEmNSn3Wz2gnxDxvfiV5JNxspq2Onbzg1aXN1JQe3qc5Iiq4f53tzBzTsJYkQpZoATECau/zYWQ8Re7GpXIDb2FO8ipt1xVsKtkIpBa1MqqJj1lY6leSTRyRyQtld2pdgRO275GF9y8WbdSYm+ZQI4aazFdHyUApoq0TwL/Ql6lJ15XvbJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com (2603:10b6:a03:42c::19)
 by SJ1PR11MB6250.namprd11.prod.outlook.com (2603:10b6:a03:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 17:19:58 +0000
Received: from SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd]) by SJ0PR11MB5896.namprd11.prod.outlook.com
 ([fe80::2081:bcd4:cb3e:e2dd%3]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 17:19:58 +0000
From: "Karan Tilak Kumar (kartilak)" <kartilak@cisco.com>
To: Martin Wilck <martin.wilck@suse.com>,
        "Satish Kharat (satishkh)"
	<satishkh@cisco.com>,
        "Sesidhar Baddela (sebaddel)" <sebaddel@cisco.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC: James Bottomley <jejb@linux.vnet.ibm.com>, Lee Duncan <lduncan@suse.com>,
        Hannes Reinecke <hare@suse.de>, Martin Wilck <mwilck@suse.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] scsi: fnic: move flush_work initialization out of if
 block
Thread-Topic: [PATCH] scsi: fnic: move flush_work initialization out of if
 block
Thread-Index: AQHbEzxIAYwreWA0Z02Kp2x78n3UOrJwkuEw
Date: Mon, 30 Sep 2024 17:19:58 +0000
Message-ID:
 <SJ0PR11MB58968F1353D70DB188CD2E14C3762@SJ0PR11MB5896.namprd11.prod.outlook.com>
References: <20240930132517.70837-1-mwilck@suse.com>
In-Reply-To: <20240930132517.70837-1-mwilck@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB5896:EE_|SJ1PR11MB6250:EE_
x-ms-office365-filtering-correlation-id: 2eff9b9e-9783-4f84-2f14-08dce1741c30
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?m0jDMOjh1RqXctHZNYj+sMnEre1mYRXrwBMxFrv3TngHQY+w5K8DJ+OpGFOQ?=
 =?us-ascii?Q?w2b7og6zU9Bb9xg7C+1NzZBwuQ0Laxg2GDX3l+70Rvrg2vujjvgHJ0RkL/JH?=
 =?us-ascii?Q?+cAYIcZVuilBRmJd4PGb2V9PGUxgGrrJgxsPy6o1OHEm4GTlNVDb0m7dau/E?=
 =?us-ascii?Q?SgnxSzqFDx3820NxvWuH5W6yv+7QHjnQn/XTALm+KHpEYBPcNN8yTJ2QMlfR?=
 =?us-ascii?Q?y+hPttlrnAuJVu2cT+YuRDS3/VYHnwZ+fHr+Z2ceZa4Usorr47rdEQWfuRVm?=
 =?us-ascii?Q?RBBG4yRsVnS9M8qk6qSr8ogY64fjswZpmmrWWCGWErhKJTJUXI4KIi/zQ1Be?=
 =?us-ascii?Q?AllrFVcPuSymMmK3YtVsLYB83auL7JmvsyyqBlMhLn0Y44PEGhwthOC2jAKF?=
 =?us-ascii?Q?fahkWNvE7bXerXa+sJQfh21sYICtL0Bb+O8NBIfMMKR8XB3VXClgxywWr5zz?=
 =?us-ascii?Q?fwg6amMOo3sFVd/niTWvKDLRUfxNHyV2vvBaVwUJDpLZi4XiSdJzr5OAUInZ?=
 =?us-ascii?Q?TILvd2kz3mAcVBQL57yzsJEpQi0maqioxCSSDV5IYsleEcxHcIUsFZiSRY51?=
 =?us-ascii?Q?seHFxyfPMccBlSiw3gO+VdONxtVyL1L9m1Zb4WZCznNfGJlBtKO0JJsIywQo?=
 =?us-ascii?Q?lUhUP26nAxX8QkLQXuNY6b2MFU0ZXKseCsNBPtT3lsUaz4LSZ812xkIfaTuO?=
 =?us-ascii?Q?1ZlgenBsSRFcKAUZuLvuOHUTQ8zGB/8LtxY0QogedgqkgBCZrfIQ/H+xW9Ck?=
 =?us-ascii?Q?BY45Y6+B7d7I2YA1Kl3IIa61MLMEY9S0bAcMHSmYmecz0M/WIL7HLMuLahz7?=
 =?us-ascii?Q?s4mWhgje9EPiZU5NEuFSE5DfCK+jwrktk+TDht2uIYpWhAU8eiQfbs2YPsny?=
 =?us-ascii?Q?iO6nsYktsFLPawrYWzDttk6c3fOQ8pU1Pmlq1mBgVwp9QywkQk/rQXAHvptB?=
 =?us-ascii?Q?W+d8SxTeEi5bRskces3kjhTb/tEpTzzvm6ai/AF7NyM6N/KIorStaoZKKMyu?=
 =?us-ascii?Q?1d+Anko/CgkrCssdKoGr4UpptxjP2STdSGboXzbSryWeAQxxnuWrmCe5UWqF?=
 =?us-ascii?Q?4p4yO3xMqLZsIStTnrsfcfHZoJU2shjX84gQxZwpnRNgDp4sgdnWwmd3KO1i?=
 =?us-ascii?Q?+nyfXhHd8hf7As7WCUPBvw/79h1TqUJ3MwSO1I2HjtRyhE2uBaC9qyQNStG/?=
 =?us-ascii?Q?KXKA1s4bx48oAS8adC/lFuPXzO1Zc6LRC1K5EknTq03phQltxZP3EIGsBRxL?=
 =?us-ascii?Q?6f3s2GwnJ1TPnhTrJoCvyPOpD/2A3QvRNPe9P8dLqr8Dw152Gcl54m0UnBo3?=
 =?us-ascii?Q?4Y4e+SwUDzGXDfXUSJRFVkQZKMLPL9xF2Cq3d/NYllj7SBNQXo0fzhHhCEKI?=
 =?us-ascii?Q?Zk3x2bcN0h8pT194aFmC9IUSzm9Nt6pPU6mmz6+IlBU/pFYfdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB5896.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tVMNlbV9fZF3+6jtkPUq08JMYDuGQpnJaRBTIoED5AvAlmNg5HE5870f0/pR?=
 =?us-ascii?Q?ak18lteEfG2mbvrOlc/VgSwuzQIan6AmtIuc/SBHZXgpHU3b+2+oF0v9Mr9e?=
 =?us-ascii?Q?ohgen5jTqiiRP4fjG4D8+W7yoFKXV1Dlv2qDhFG/nd62vFiXS8tAZWnYg8K4?=
 =?us-ascii?Q?6jHYyCS7LRH+LE8PtyBBmt/np1w+c38c3vfAE+zTwNCID3ocngkyilwhvWtZ?=
 =?us-ascii?Q?MpKpWyfGJgDO0BjzdFH++JoTt/WMlIQONPUXhC3u6izMZz/8vqpmpGMvTQHI?=
 =?us-ascii?Q?wIMC2+ONlcrGT3YTKjXzacVjaKdW5/WMrjip1rd2b72td/z+Re+rzNOlYfWA?=
 =?us-ascii?Q?naJ9/XLn16hHzDwsZNwBbDavCzOoDbURexCmgybzd/9m1LxehX2fSEKXomFI?=
 =?us-ascii?Q?l5P+0ZgObIvQnH1iw7HSMR2gwPW4S/rurdbNfV5KgAyUkQNZwBfGHMN4GfOu?=
 =?us-ascii?Q?hV3fthoWXWhFcUT9McOoV2+jD37+yjXE2287RTiU08cw4GgcG6j38O3fqe/i?=
 =?us-ascii?Q?1mxythT9B9cCQECaE3vmyMVap1zoRl716lhirTB9cq+Ea4qeFyaymlBxbDyg?=
 =?us-ascii?Q?svWzBlIMcgO4tVPWcoAZ262g/QfzbBzrsR/gt3b4/hNuod48fICEIEJxDjVd?=
 =?us-ascii?Q?Vp6JlGsFJo/WF6R+cRGkvKVqEPeSqItZo1R0Z4bAoyXc58P2R7eOd9DeXDrR?=
 =?us-ascii?Q?0F2PDwAEr0qlfrv3FHOUCP706W+B/liGa3xBX2S8H5uv3zPShwUds6o/bCvu?=
 =?us-ascii?Q?F2dWEdjEvxbP1xcvaQRn/2IbETbwJv9VzkSgq90GKQAMzbtwd/ebwJhFpaHm?=
 =?us-ascii?Q?wxBxoPNvsNlnBI6Ah6CbtURJcD8uxAJ6z30aqElhzV7sIN+4pF+pBZyIwIQP?=
 =?us-ascii?Q?m5uHOlrw4kREtgzYJ3giKLY8MX6F1g71Cme9LAxgw2D7nXU49mfPfEMi59Eo?=
 =?us-ascii?Q?jOeC33Vw1z1yknS6gdxI7uWXRw3ECBqgytnaXBOGL9AYc5WNlReeBsSKc1h+?=
 =?us-ascii?Q?aiyLZ4MkV3gSbQBDWDyxwgd8P7ljQLr2FqUray71mF3danZfk1YGsWfMMdlp?=
 =?us-ascii?Q?s02S+VDW8y21MXZusKKbLU/6HRSDq2onqmokPRXYQ2Ck51Kw7HLr5exGLzjc?=
 =?us-ascii?Q?JNCNx44uDo2lpSJi7PE/A7/zWoF9TkN+iT99ygodyZrsnXBXJGcNmlOgxLju?=
 =?us-ascii?Q?nTf4yl1LTgPXPfs1AFcTAHweR3kU9kRefiMovRLeLuqfuH2wQJi9EAOyLbJq?=
 =?us-ascii?Q?bpngu/gRtwRSDdxqehgpN4TQhClZxnvkWoI0BaKMswpAySoz1d/XQTUFb9aa?=
 =?us-ascii?Q?snyIbO/ivL1h06duGQEzZAqfb+jzTJ/q0xZMZoTTkx0SlB3Vuz2tEafaoPHl?=
 =?us-ascii?Q?V1YbkDWSyCuYxsVlFuOmVcAojXHAHyVx488u1u7C6ieKDteCYiOdivFtdsj2?=
 =?us-ascii?Q?G/x4XtxV5+vUmIsufp5MxN0Ljg/tm3UETNuj4qESHxAVWAgEjp4jHCI236cN?=
 =?us-ascii?Q?JE1LJ6zv/pQmzv4UHiJkrGK7i16gcRGnvlOtK48qwwEmoxq6qQT6avEVLytR?=
 =?us-ascii?Q?G6WilfKrg16IEYXOBipoaQQCfU/3Tp8GunkPcVVc?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB5896.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eff9b9e-9783-4f84-2f14-08dce1741c30
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2024 17:19:58.4920
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/9c+DlpmWPboH5eF7uJmG+kQ8di8SzjHdPPtiJfWfuK+tpUITRc6WFejpcTsGKul+jyabym2MileGU+3KGeqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6250
X-Outbound-SMTP-Client: 72.163.7.165, rcdn-opgw-4.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com

On Monday, September 30, 2024 6:25 AM, Martin Wilck <martin.wilck@suse.com>=
 wrote:
>
> After commit 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a wo=
rk queue"), it can happen that a work item is sent to an uninitialized work=
 queue.  This may has the effect that the item being queued is never actual=
ly queued, and any further actions depending on it will not proceed.
>
> The following warning is observed while the fnic driver is loaded:
>
> kernel: WARNING: CPU: 11 PID: 0 at ../kernel/workqueue.c:1524 __queue_wor=
k+0x373/0x410
> kernel:  <IRQ>
> kernel:  queue_work_on+0x3a/0x50
> kernel:  fnic_wq_copy_cmpl_handler+0x54a/0x730 [fnic 62fbff0c42e7fb825c60=
a55cde2fb91facb2ed24]
> kernel:  fnic_isr_msix_wq_copy+0x2d/0x60 [fnic 62fbff0c42e7fb825c60a55cde=
2fb91facb2ed24]
> kernel:  __handle_irq_event_percpu+0x36/0x1a0
> kernel:  handle_irq_event_percpu+0x30/0x70
> kernel:  handle_irq_event+0x34/0x60
> kernel:  handle_edge_irq+0x7e/0x1a0
> kernel:  __common_interrupt+0x3b/0xb0
> kernel:  common_interrupt+0x58/0xa0
> kernel:  </IRQ>
>
> It has been observed that this may break the rediscovery of fibre channel=
 devices after a temporary fabric failure.
>
> This patch fixes it by moving the work queue initialization out of an if =
block in fnic_probe().
>
> Signed-off-by: Martin Wilck <mwilck@suse.com>
>
> Fixes: 379a58caa199 ("scsi: fnic: Move fnic_fnic_flush_tx() to a work que=
ue")
> Cc: stable@vger.kernel.org
> ---
> drivers/scsi/fnic/fnic_main.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.=
c index 0044717d4486..adec0df24bc4 100644
> --- a/drivers/scsi/fnic/fnic_main.c
> +++ b/drivers/scsi/fnic/fnic_main.c
> @@ -830,7 +830,6 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
> spin_lock_init(&fnic->vlans_lock);
> INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
> INIT_WORK(&fnic->event_work, fnic_handle_event);
> -             INIT_WORK(&fnic->flush_work, fnic_flush_tx);
> skb_queue_head_init(&fnic->fip_frame_queue);
> INIT_LIST_HEAD(&fnic->evlist);
> INIT_LIST_HEAD(&fnic->vlans);
> @@ -948,6 +947,7 @@ static int fnic_probe(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>
> INIT_WORK(&fnic->link_work, fnic_handle_link);
> INIT_WORK(&fnic->frame_work, fnic_handle_frame);
> +     INIT_WORK(&fnic->flush_work, fnic_flush_tx);
> skb_queue_head_init(&fnic->frame_queue);
> skb_queue_head_init(&fnic->tx_queue);
>
> --
> 2.46.1
>
>

Sorry, the correct tag is:

Reviewed-by: Karan Tilak Kumar <kartilak@cisco.com>

Regards,
Karan

