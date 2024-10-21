Return-Path: <stable+bounces-87547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D0C9A6856
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2AD2815EC
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD47A1D1E88;
	Mon, 21 Oct 2024 12:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KMAxHEsy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bz/ekZrG"
X-Original-To: stable@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACB51E908A;
	Mon, 21 Oct 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729513494; cv=fail; b=ZfTH7eHIJkr/apPO8ZS+PLmuMwi99xXDsSw7m5i0CmpiQ3iNnORuaa4iJiDSIwtqr0QCSoeZuBRO3IlwHooBBUTcRxKbLaTNYHVuS5OnDdUZmBhHxpszIUmm/yPORLCsxM7dpoRRnIclJ5lugfFuvwT1+Hn4qrFJ5OhxEs4KX20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729513494; c=relaxed/simple;
	bh=QNa5tiM3DsNgZw1xrjWtz4NbLgGCKw5iG+XLZN9WA98=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bwEJFpSVQBCflfSTN0YPiSlDMgVEA1IYKLEm2H/dm4wqps04NMGMIMOukbJM7hb5WuT+H/vMvKOq3hmf2k6qR+8f7MSR3aWCrf5y1IiRi0DcRSCrIsJSsk1i5LlLEXbpLMbytK68V0DNuv0HgCkwdzloPaYdUTRBXmBZFRI5To8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KMAxHEsy; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bz/ekZrG; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1729513492; x=1761049492;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QNa5tiM3DsNgZw1xrjWtz4NbLgGCKw5iG+XLZN9WA98=;
  b=KMAxHEsygZnrqLr6ohKkVrV8V8o9ZUWr9QfmFHyNgN3Drr/3b4Wm7poG
   hqUK75ax+l5Sl6gzAIMCZMqE53pME/99uTWpNXrZcAzIqvacNy+Z57HQy
   /KvIqE0JMWKbwdiSyZsLSK8tJk9SxpKFlNWrHiAhw81ZjrcXzq4Rpf2vx
   eJP1f1VAr+AZ8AOEZrKemwX04JJDSUW3DlHA3bwOyCkFTBmBulaUVW3hT
   2cIlLDRVX3QukSymcmNiKDTakxv4GTHxaNrKRkNr5J3wATLXXO4jhnDmE
   apHCugB46srsBXWxP4yTtecUAD96Gvryj/y2pTdQB8HUtX1Lc4snifIhs
   g==;
X-CSE-ConnectionGUID: FKdtrgoTSGOn0CuuJrbASA==
X-CSE-MsgGUID: nvJjVp7ZRMuael/wuPqrHg==
X-IronPort-AV: E=Sophos;i="6.11,220,1725292800"; 
   d="scan'208";a="29491722"
Received: from mail-westusazlp17010003.outbound.protection.outlook.com (HELO BYAPR05CU005.outbound.protection.outlook.com) ([40.93.1.3])
  by ob1.hgst.iphmx.com with ESMTP; 21 Oct 2024 20:24:51 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eL5zAY6sGIluVumzCwEOok4eUAmT1O7jbjhp5NUw56M1JrS0QEy2gb7dTwgxNO5M7DO7YlBxWEW4JPEkJrIR0iiYjpJRqgSBqXKWfucQ3RBmvXdY7e+wbvNDw3vY3ot5SeWk0WWdPB3Bo5431oAbGsBAq19vMVuTjnPo22FdGQ4CA2ps8H8U2Ls3SxlqlU9iTt69GQlnFvP670JYuCP0zJL1L8NYGb2JJWq79Vyh1Zxr9+Uw4ZHNrxqvMABJ53ezEsJqD1pU1qtM3bDm0+WesSDfwlbjS4HxCWqCC8v95c0zs4wuVzwnrmfDEgBLDPLymG1JS4+B5zjGS2f9LElAIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNa5tiM3DsNgZw1xrjWtz4NbLgGCKw5iG+XLZN9WA98=;
 b=Hhb9c3+qkichoUYXGS582hRD3cGLn1Rr548ZN7Rb9dVqmwpw5/1U1nUDopFFpr+Fo9nVOPd4DqRIZRyQfe4jO82IfwZOUZsoqlIsU7Y7raMEtHxKmb816AtMHA1UkQ6I22iYcK2SsYWg2TvLeyxru51BZ+LpohjGkJiCkMSjeADZEk8cPcgGlAfaHXWlpetNgsnz1UBhtZ8gcQ/KGX5ClKjtIE6yjUze8S72EA8cTxyKnYf4a+aX8gSnxI8/S4PSo3v6GqKnljjaKnMnzqocAHt/xo/eQ1Nynbe2FZIRjKn8lgdTFwlk/0ScYVwfJx4Td/TzY3pEt53WkZE6DUtlkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNa5tiM3DsNgZw1xrjWtz4NbLgGCKw5iG+XLZN9WA98=;
 b=bz/ekZrG3+8oJ2j3W1ij+KVG9tWTD103Ir4VhAZ7vdXXjmhbOLensxGdkhXR0hsRMQ0/S0Y6q6q+tnUyadYPk/evpmAzlDduqeR/1t3Ks+emvkqG2h8iVlKSx/Ax8kqNoYrtt0KEuPlN/LO3D+CXt+Q0Ua870NspOD5Rfxo60Zs=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SA2PR04MB7708.namprd04.prod.outlook.com (2603:10b6:806:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 12:24:48 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::bf16:5bed:e63:588f%7]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 12:24:48 +0000
From: Avri Altman <Avri.Altman@wdc.com>
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
Thread-Topic: [PATCH v2] mmc: core: Use GFP_NOIO in ACMD22
Thread-Index: AQHbIR7z/IHDru1ufU+CK8sxs4Vgg7KRCvWAgAAaFTA=
Date: Mon, 21 Oct 2024 12:24:48 +0000
Message-ID:
 <DM6PR04MB6575EAADE9A5C775C0837361FC432@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20241018052901.446638-1-avri.altman@wdc.com>
 <59f6c217-d84e-4626-9265-ce5cd8a043f4@intel.com>
In-Reply-To: <59f6c217-d84e-4626-9265-ce5cd8a043f4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|SA2PR04MB7708:EE_
x-ms-office365-filtering-correlation-id: 7a1f464b-8bab-4c09-8639-08dcf1cb5a9f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dkNoTkc4ZFdOQzd1KzA5RmRTNlBDQTlLS3VqQXpPaFdvVm5vRlpCbFROY3ow?=
 =?utf-8?B?Y0thRGpRWExVb1Zxc3BLOTRGcS9mRjdMMzdHeHFPam9RWjdtK3d1Y042cjZy?=
 =?utf-8?B?MVZXOXBnemZENnRWZzNDbWFnZ2F3RFhqQ3JHZnJIcDNxQWFlKzZKcjRmeWt6?=
 =?utf-8?B?ODVLbGdpZkV0aVYrcVljL0ZmdU1FOXhiOXRzbUE3dWJkMzRTVzN6Q0lyTXdm?=
 =?utf-8?B?OHlBb0o0WnUweFJaQkU2aUFSK0hWS3pnVGJyc0RKSlo5WVZvUE5WeERkN2Jl?=
 =?utf-8?B?Qy8zUjFxcWo4OFFRTUFMeUN0aVo4V0NjWjBJT3hlRExRajRJTWd5Wms5THlH?=
 =?utf-8?B?OFQzYThuWGxDL1BqeGtBMXZwSmZYMkx6OWdUVW5HYjZhdmpycXpnOWVNK3c3?=
 =?utf-8?B?UnRxajVJMDN2V09XdExwZVcwR3Z3V0NPU002MjEzRkxDMFpWTlR0WDBna0M4?=
 =?utf-8?B?MmpqMlFUZUxWYnFnWGxOeVV0ZU1pMjhWMWdscjlDQXM1UDdoQURqYVNrMTVU?=
 =?utf-8?B?Uzl2UEFLdlVQbDJyU1E5U0N2T3AyRUd5SnRORGNlQ0dPNitZS0g3RG91N1di?=
 =?utf-8?B?OHE5SCtuTzZXYkZpUzhoaFhQUng4cW1DUWlTanE5UWxBY0IrbE1vT2IxWUF2?=
 =?utf-8?B?bEoyMGFna21MN291aHhLUU9wT1F0UWNHSVlkUEtIclcxa211M0xORjZ1MVJa?=
 =?utf-8?B?NisvaWdETkkxSGlETkJIUlVua0ZqRksvNlBCczlWSGM5YmhWWWtzMlI3Y1B3?=
 =?utf-8?B?SFdiMy9xc2xFVkRLUHVsclQrOUVzMUdhck8wdWl0NGxYNnkvME53SHRmazBY?=
 =?utf-8?B?dCsvSDlWcWt3RXFWdXk1aTF0SlVCSHBiVjBjeWZhUzlRVDFPRi9kQytyUGJR?=
 =?utf-8?B?VFVXR3F2eFZiWHNPSFFUdENFYW9yU0t5eUJiMjZPbnp2OXpNZ24zVHEyeGkz?=
 =?utf-8?B?MUJMUlRNSFRRSW5KUlpadXo4eUl6K0l5UmhwdG4rSWpnMmtnSmhrVVBMY0Y3?=
 =?utf-8?B?NExBcFduWHk4eHFUMTk5VXZWUmR5OCt5MkpwSGliamhmRTE0NEdWSERFbDFo?=
 =?utf-8?B?eitmNlh1eVV3eDNLUGdLMkthaS9GQUFHcHZqclJjM0VRWE54dHBlcGlOY0h4?=
 =?utf-8?B?T0h6RndtNmZoMWp5Q1lnSHhNS2FFVysyblZOT1J2VEFqTFRaK04zcW5jZkVR?=
 =?utf-8?B?YXNTRHRtZk11Z2hBYmltdE9LWlhPWmlhbHJpbm9Ga2d0Z3BFamtzWmxaT3pz?=
 =?utf-8?B?QmdMdEs2Yk9iTGFERzlWWUlDek9Nb0FSSGRtcGJwNWVJVDU3MitlRmhUMklR?=
 =?utf-8?B?aDNPTHFlaG5ob05BeERXdmFpTmFSV3ZXN0phMUNlenhubjRNS29Cb3BoemZJ?=
 =?utf-8?B?UDVYVStyQS9BaTZkQXc0UHQvd09ZamhZVTNRVTJQdnJPSHNIcnpTQ0RENXN2?=
 =?utf-8?B?QjRabmZWRm9MVTVwdzFxZVNDRUE1MWNNMVIybmhUdW8yQkN0TkFyenZuSFdo?=
 =?utf-8?B?UlRHMUVISGNEUUdQUEJLZlRybldtc3J3cWIrR1ZvY3JXbWJRMnlkUHN6c3V5?=
 =?utf-8?B?TC82dzg3VFBvV3NHQnczRnJKdlR5enRkUjBjanF1ai93dVVYMC9NWVdqWTZL?=
 =?utf-8?B?MGVia1pQeW1GTGNWQWVWeWs4NzNNeWI1ZGpnKzM0Wkl3dzlkWTN2Wk96Znpn?=
 =?utf-8?B?TTAyOWx5MHVQaTUwUUo3aWVkK0Nyc2hVRWovSmp1czMrMXNncjRmSTQ5dEZY?=
 =?utf-8?Q?yGn3QVCc1PYI/35y6Xur8uwOVJs9qKoGJSR+yBd?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MS9YeHQzSEg4OFlGejJVMWF3OGZlYjZYQ05mbGZNdTFLaWhFUmZ2K2U4MWho?=
 =?utf-8?B?N0JGN3o1WGE2UmhiSENXeHNoUUR4L0pUM1ZrOEZLL01qLzRVb0hLVjBHYlVo?=
 =?utf-8?B?aWcyWjMyc3pBZlYzTlBlTGdNNm9GSHFIR0E0VjIrTU9MSllITCs2VlNyY2Na?=
 =?utf-8?B?RTZTTktrV3FxejhDckdKKzJqRDFvUjRwTmR2ZlkraS91cXprSDJpeUdJa1BO?=
 =?utf-8?B?UlhRcG03S3o0Q2FWcFFhM09IekRzKzdSMld3SjBYeU15Y3pONGRjNkNlV0lp?=
 =?utf-8?B?K3ErVWdic2RtakpOSWl3eXJYMUZsTVI1bUZuTmVMSmllVnpHZ204b3NPcXg1?=
 =?utf-8?B?VE4zRWhQTys4WXJ6aTNhcXhDTnpVUDRMYnRiVXhvdmtZZEhhMXZFWG1Vc3lL?=
 =?utf-8?B?Z2Z0K1pwRHJzcnBqOUVOcm84eDBMazlSemZZd0dpMUVVNTJUZXBiWGg2YUZp?=
 =?utf-8?B?NHAwZDJFTEtiRzhUVFQ0OTJ0L2tYZ09wdG1OQVhsSFltQXQ4MXF6cFNST0Z1?=
 =?utf-8?B?ek5sclFvclVVZlkySzIvcjJ4eG1OTmJqQk41bmtjMzU3R0FIdmFJdXlBeThG?=
 =?utf-8?B?N2dIQ096SU1jSC9kNnhLVCs1Y2c0TkxTMXFvWmd1RHVEekRHOGdyWVM5eG50?=
 =?utf-8?B?WHpzTTdpSzVLb2hPcFk0Q2pVdzRxNGt6eFk1QnNhTmttMzdsRUtuYWdNYWl4?=
 =?utf-8?B?R1ljZUtlNmFCTVd5NHNSbjlabjlJUEl0Ym43c3lLa050MUw3RW5zQVBKMjFl?=
 =?utf-8?B?Ulc4cWE5NVdiNk1nbXd1YWlGUmRmMko4OGpxajdtRU5DU3dpdVVOQnI4RjlQ?=
 =?utf-8?B?ZkVEV0JEWG9sS3pWWFRRT1JLeWNZcEdrSFhRYWNiMWZJdXpyMElnS3lXckZL?=
 =?utf-8?B?b1NMY1NUazFtckp0SDZERi9uSWw3dWFGNkxBekY5ejFYT0s4SW1pV1RrU2lz?=
 =?utf-8?B?N1hGRnBNbGJFVXdZMGY4Lzc5WHk2L2VoSkpPUDVwVFhqQUxMZjBDeVZpbWVM?=
 =?utf-8?B?RndlV3dNZkdQTXhVYVRkSWFMSEc3c0sydDIrU2gyQzh6b2FRMGFkTnRzUG96?=
 =?utf-8?B?SmR6aDBwOFdKMk9Mdmx0K0d6K0Q2TjlRNFZOU0hVc0t6OTFUeDZyTmZKWTZa?=
 =?utf-8?B?ZkJXQndQN3FwSkdNT2hTSnB0V2FjQkpWYXhzT1Q5bDF0OWxUbE5wN3M5alUz?=
 =?utf-8?B?NjdUL3hpczRVa0h1aWQzNUFKWFBlOTU4OWxNTEd3YXc1L09wbVEzSjdUZ0Jx?=
 =?utf-8?B?azFDVmdkQWhoOVJ4L01zMEM5L1cvdWhBYzBsQjRpVVZQczY3S3RJbWc1dVJv?=
 =?utf-8?B?SDh3K1NpV1pBeUpGa0NYVzBWV2tKV0xkMU5RbmlCeWE5bURYZHQzZ3B2bFJi?=
 =?utf-8?B?NjVtVWJidlFzVFQ2MGRpcjRtTnZMZjhoZHZraFdZM1U1QWx1UytrYnNidDMy?=
 =?utf-8?B?WDR5bStmSG1uSG5ZcTVhZkpseml0dm45OE1ycG1sWFJ6Rk1DYk94NlNTb1lv?=
 =?utf-8?B?aWorSDFjOFlmVHlNeTJmRkxwZUprK1c2VlJQcUpQR0JBN3pZTGFvWmdYTkhJ?=
 =?utf-8?B?MWJCeHBYOFc3eVBneTJBaUtHUzZFR0p5aEtOVnZkOW5sLzQ4SThFM3VuVThJ?=
 =?utf-8?B?WnRtUmJWTHZCbDg1Nm9peW5yU2RKMFRMMmNsS0VvbTQwNUZTR3RYRzlUclBo?=
 =?utf-8?B?UVd4Tlhrdno2czJNRFBmWk9hTlpIcFg0ZlpmQVZWcllGVmpXVWJaYi9JbTFk?=
 =?utf-8?B?bGpXL2I1ZlRTOHFSRFFQbmo4amErOTZjV2t6RE1abFNlQTJDTlpsUVA0MWsz?=
 =?utf-8?B?bTBJNStiQThNV2VGMjdIZjN4SnRMOFhsZUFpRWZUbHo1QVNscGEwdVdGY1BS?=
 =?utf-8?B?STBGeEdtUmc5WHUwejBxSFR5QkVaUlJkQ2lTWlVOZkEybDA4NDhyeXgySkUr?=
 =?utf-8?B?b0tGVVVDNXJGTnBXK0N6TmpOeFRxNHNSMDZQcW5Yc0VJbWNodVpRc2NCMFli?=
 =?utf-8?B?amtCOWo0QUJRSGpRMFljemhCVzRSd2tvK2RZdlpGazNCWmRFeDBiZ2NhY1Vu?=
 =?utf-8?B?dXE2ek9GdUZndkhNS2JVVWZDb1Q0Y2NON0NCMXNHSWtBVThsRmVBSWJscHEz?=
 =?utf-8?Q?o7Y0MjK6jRenZFYynu4bl6GGo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tz4FM70eba+uKXeGHE+z2zl+zqL45ofrw9+xAQBnntsJS0Idmbq8LHk9kIpaWXmBiGqGfko6TPlGbXdDUkgpYB8s5UhbMcqiBvV7zwPzE3D9Jh1QlHXu+mUXG5QV96dJww7OAu25OfDd1xaSwfSRVPTlV5tOctJT+YQLNcv2LL1xdJXXEplTHriDBQj8IMwYAbre4PF3zn7cOlfEC6N2bBCfFaGV1oiCM0qVZMczegwidhyx78uWQ/C0HFq1fIwMIacCIEQcyQ88WgNglmrjvM2mmsUTbG9dvK+Azo/28rNWaWirroXeuV2MYpMroNTlIMlde/oWqoRw3Pa8eeGlGUffBeifaofWkK8UCTXDRJKmHCC3dXzs6Z1mH7X4LuF3LcE0httZzKanl+wZ7CadysYuEmjmIVRqpOd+rDTPGY04QXAWciMk9RseBi1B/fFIkCMzyAelHFz7S16lInFhNqPOobxvKPA7NjYUiTOmyUXo6+8oxjNr84Qz80h6c1tHEpGufNyXdVrZ1Fq/4+ONLsfTvjZ1qfHML9cCYvnCQbQQt7yFwQrhqfXrbJrmbusgYuAizhavNpd0UJ49VgZug+4qEf1ZbZ8CpfuI4WLU5JHcC+iJyNQ9N9fnVMB72gva
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a1f464b-8bab-4c09-8639-08dcf1cb5a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 12:24:48.0580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6rE2I5WkajiXTC9EeJTOXgE/5ngmhU5waPbw3muRZ070e07ARYHXBNpoYDt4Wq/+wiLGxQ4d0fRpVVqJYtfImQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7708

PiANCj4gT24gMTgvMTAvMjQgMDg6MjksIEF2cmkgQWx0bWFuIHdyb3RlOg0KPiA+IFdoaWxlIHJl
dmlld2luZyB0aGUgU0RVQyBzZXJpZXMsIEFkcmlhbiBtYWRlIGEgY29tbWVudCBjb25jZXJuaW5n
IHRoZQ0KPiA+IG1lbW9yeSBhbGxvY2F0aW9uIGNvZGUgaW4gbW1jX3NkX251bV93cl9ibG9ja3Mo
KSAtIHNlZSBbMV0uDQo+ID4gUHJldmVudCBtZW1vcnkgYWxsb2NhdGlvbnMgZnJvbSB0cmlnZ2Vy
aW5nIEkvTyBvcGVyYXRpb25zIHdoaWxlIEFDTUQyMg0KPiA+IGlzIGluIHByb2dyZXNzLg0KPiA+
DQo+ID4gWzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0L2xpc3RzL2xpbnV4LW1tYy9tc2c4MjE5
OS5odG1sDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IEFkcmlhbiBIdW50ZXIgPGFkcmlhbi5odW50
ZXJAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEF2cmkgQWx0bWFuIDxhdnJpLmFsdG1h
bkB3ZGMuY29tPg0KPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IA0KPiBTb21lIGNo
ZWNrcGF0Y2ggd2FybmluZ3M6DQo+IA0KPiAgIFdBUk5JTkc6IFVzZSBsb3JlLmtlcm5lbC5vcmcg
YXJjaGl2ZSBsaW5rcyB3aGVuIHBvc3NpYmxlIC0gc2VlDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2xpc3RzLmh0bWwNCj4gICAjMTI6DQo+ICAgWzFdIGh0dHBzOi8vd3d3LnNwaW5pY3MubmV0
L2xpc3RzL2xpbnV4LW1tYy9tc2c4MjE5OS5odG1sDQpEb25lLg0KDQo+IA0KPiAgIFdBUk5JTkc6
IFRoZSBjb21taXQgbWVzc2FnZSBoYXMgJ3N0YWJsZUAnLCBwZXJoYXBzIGl0IGFsc28gbmVlZHMg
YQ0KPiAnRml4ZXM6JyB0YWc/DQpJIHRyaWVkIHRvIGxvb2sgZm9yIHRoZSBwYXRjaCB0aGF0IGlu
dHJvZHVjZWQgbW1jX3NkX251bV93cl9ibG9ja3MgYnV0IGNvdWxkbid0IGZpbmQgaXQgaW4gVWxm
J3MgdHJlZS4NCg0KVGhhbmtzLA0KQXZyaQ0KPiANCj4gICB0b3RhbDogMCBlcnJvcnMsIDIgd2Fy
bmluZ3MsIDE3IGxpbmVzIGNoZWNrZWQNCj4gDQo+IE90aGVyd2lzZToNCj4gDQo+IFJldmlld2Vk
LWJ5OiBBZHJpYW4gSHVudGVyIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT4NCj4gDQo+ID4NCj4g
PiAtLS0NCj4gPiBDaGFuZ2VzIHNpbmNlIHYxOg0KPiA+ICAtIE1vdmUgbWVtYWxsb2Nfbm9pb19y
ZXN0b3JlIGFyb3VuZCAoQWRyaWFuKQ0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL21tYy9jb3JlL2Js
b2NrLmMgfCA0ICsrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+
DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1j
L2NvcmUvYmxvY2suYyBpbmRleA0KPiA+IDA0ZjMxNjVjZjlhZS4uYTgxM2ZkN2YzOWNjIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPiA+ICsrKyBiL2RyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYw0KPiA+IEBAIC05OTUsNiArOTk1LDggQEAgc3RhdGljIGludCBtbWNf
c2RfbnVtX3dyX2Jsb2NrcyhzdHJ1Y3QgbW1jX2NhcmQNCj4gKmNhcmQsIHUzMiAqd3JpdHRlbl9i
bG9ja3MpDQo+ID4gICAgICAgdTMyIHJlc3VsdDsNCj4gPiAgICAgICBfX2JlMzIgKmJsb2NrczsN
Cj4gPiAgICAgICB1OCByZXNwX3N6ID0gbW1jX2NhcmRfdWx0X2NhcGFjaXR5KGNhcmQpID8gOCA6
IDQ7DQo+ID4gKyAgICAgdW5zaWduZWQgaW50IG5vaW9fZmxhZzsNCj4gPiArDQo+ID4gICAgICAg
c3RydWN0IG1tY19yZXF1ZXN0IG1ycSA9IHt9Ow0KPiA+ICAgICAgIHN0cnVjdCBtbWNfY29tbWFu
ZCBjbWQgPSB7fTsNCj4gPiAgICAgICBzdHJ1Y3QgbW1jX2RhdGEgZGF0YSA9IHt9Ow0KPiA+IEBA
IC0xMDE4LDcgKzEwMjAsOSBAQCBzdGF0aWMgaW50IG1tY19zZF9udW1fd3JfYmxvY2tzKHN0cnVj
dA0KPiBtbWNfY2FyZCAqY2FyZCwgdTMyICp3cml0dGVuX2Jsb2NrcykNCj4gPiAgICAgICBtcnEu
Y21kID0gJmNtZDsNCj4gPiAgICAgICBtcnEuZGF0YSA9ICZkYXRhOw0KPiA+DQo+ID4gKyAgICAg
bm9pb19mbGFnID0gbWVtYWxsb2Nfbm9pb19zYXZlKCk7DQo+ID4gICAgICAgYmxvY2tzID0ga21h
bGxvYyhyZXNwX3N6LCBHRlBfS0VSTkVMKTsNCj4gPiArICAgICBtZW1hbGxvY19ub2lvX3Jlc3Rv
cmUobm9pb19mbGFnKTsNCj4gPiAgICAgICBpZiAoIWJsb2NrcykNCj4gPiAgICAgICAgICAgICAg
IHJldHVybiAtRU5PTUVNOw0KPiA+DQoNCg==

