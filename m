Return-Path: <stable+bounces-241279-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIBuGMYr72mb8wAAu9opvQ
	(envelope-from <stable+bounces-241279-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:26:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 98FE746FE61
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 11:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A480230022C3
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 09:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E422C0285;
	Mon, 27 Apr 2026 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="kS4by45B";
	dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b="azSVukIm"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0014ca01.pphosted.com (mx0b-0014ca01.pphosted.com [208.86.201.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957A3378D88;
	Mon, 27 Apr 2026 09:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.86.201.193
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777281987; cv=fail; b=scNeAJUT1lXGGt4ENt37DFwJY7ILgHh1neByl0R+nQZ0FfMm2ZwzyEWKhIcTlLkYFXB29tzASyFoMItSGK9YXIF0NiHRTJWFX6wRjuQBKwbvbVYRrm8oMXCEPhrXneyr9K7+3VMsqYWnR6zyTKh00LaceKNY1foB0D19/oN8QN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777281987; c=relaxed/simple;
	bh=dNLO0UODVLidWOBbmAO7OdW5B8sW2saZuYQ/+sxvM+k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tW8Nl+DOyYdh6N6wVTCKA9Q351iYkWcDgZSFMyYuZyKQo0dlf9m2Yi5cTFRJDHPomT0CKeU7WVyvuHArBRA1FaKQa5bopct8PltdGSxRfPjfL8uj8nvATv1vigSlempzcAN3IVl+WIjE37yMnyRnJ7s2SjdAM+wo8vgcultIJuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com; spf=pass smtp.mailfrom=cadence.com; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=kS4by45B; dkim=pass (2048-bit key) header.d=cadence.com header.i=@cadence.com header.b=azSVukIm; arc=fail smtp.client-ip=208.86.201.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cadence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cadence.com
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
	by mx0b-0014ca01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63R7q692207695;
	Mon, 27 Apr 2026 02:01:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=proofpoint;
	 bh=dNLO0UODVLidWOBbmAO7OdW5B8sW2saZuYQ/+sxvM+k=; b=kS4by45BVDW2
	hsI3xUY9AJaUQX/ichOH41IM+EG6vFAqEeFvBLKGpsP2tXWQ+CL+NT/vOxoYt1H+
	HIXiRMh5L18+UlFu0uTnaK5zlUrNNGckF9iiFG+tRZX8s87M3YwhlBUbgucKaWwe
	yRsPi/pQNe2b0dLZzYUnz4z97p3EoHzp7u++8p9CAK5pKPikKRBBxjqDOG+CI2xQ
	MTPsJe9sd1c9Qo4wfXiw30iHrAZrfxuAAWMq0iR6sW418UDOVAmlQhJQUvpmJ9k4
	ot0cskMaRx0aWTe31We7636unmY3nZ2Ifrh/NOZj6RjFdvH4UakrnSn9zLgOjeQA
	ww4wDCRHZQ==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
	by mx0b-0014ca01.pphosted.com (PPS) with ESMTPS id 4drs6vntau-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 27 Apr 2026 02:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahmB4fYPfwHl15UNItPLYNlv/U/B15bFSG6aJeuCq6utBS885RU18cUR2blHgQUGajEFKuE9l8KVqtlL5qUgCUNsQDrd98VcJB3OiQxDdFl1ndFxDA+lw4SHrQoM0HQAXpaO3aM98PC1rSW6z91BqRXXV8f97yGD108s0Dot1Z5knxL/sHEKTTo1VO7f/SC1bfz9fRgFV4zetxZ1OONVWcmaKzP13Zq7Z5Ias+TGnvT/G2pZ+P2UoirFVMPSXIpclG4MfUL+StAdzO05fhJV3BZ5XIthMJDf5v8Ztmen5Jih+NNlXEXBiVFOV+bxz1faSrZbOUG6q8E0ABbXXVpESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNLO0UODVLidWOBbmAO7OdW5B8sW2saZuYQ/+sxvM+k=;
 b=b4npeFavVtkPzOzRur2AF482x8EVauDuhE/KAwlkbX+v7tufseKBMhhPv2echNUoET1BTEA1x7UFoq6K35VsAkluBuRb4OkzOKmcZ/MFP7iWD4f68yZK0ueltIKyEr8e+48tMNC65oCcyE9CJ2FkCM5oSS2vrED0mj+MDxAiI1vJWxkW8eyJQE1WdCiZx8SQMN3Pj5DE0eKh8ZEKJrsr33DdhRT+pkdRj0E0MCDN1Dz8uzC3/jFhupEEE2S0KmGV+e+En1krhgKCSmvA1viRji4gP8Zv+kR6vt3kQUTIB+hM77ncPbiNUIKYvaWGhl3UwWLQ2fLtZkdPFQao0rEBzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cadence.com; dmarc=pass action=none header.from=cadence.com;
 dkim=pass header.d=cadence.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNLO0UODVLidWOBbmAO7OdW5B8sW2saZuYQ/+sxvM+k=;
 b=azSVukImDDxg5gFcv1Po3InlcAUw0K801s8LywmdgURapEhTXogVnRGk/Itwho/POas1rboaw8jSAbZbpvIUhJZDOB3I7ICXXyxETsbHR+H7RQ+MhZoG3VdKXAla3w02kFt4M9262JZqiP6R2BOnVaeVe7qfNuDpnY9ggbTXE4vknODNBNCCFzljpB4veJIDYyz8XEnWnlePUST1dZ4H8iqrNVttrGVkhtVw8M1tMY0+w8X/imnHSan/TKr9XsqoFL0GX9U2HD9njfF8RbGQ52sZMus7fFEO0uu+cVLmGjkE+jlL0TtkllgmZgxbqFmMQnAxGi9HtYq2OEfhIxE0Pg==
Received: from PH7PR07MB9538.namprd07.prod.outlook.com (2603:10b6:510:203::19)
 by SJ0PR07MB8552.namprd07.prod.outlook.com (2603:10b6:a03:371::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Mon, 27 Apr
 2026 09:01:48 +0000
Received: from PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe]) by PH7PR07MB9538.namprd07.prod.outlook.com
 ([fe80::9088:4354:91a3:3bbe%7]) with mapi id 15.20.9846.025; Mon, 27 Apr 2026
 09:01:48 +0000
From: Pawel Laszczak <pawell@cadence.com>
To: "Peter Chen (CIX)" <peter.chen@kernel.org>,
        Yongchao Wu
	<yongchao.wu@autochips.com>
CC: "rogerq@kernel.org" <rogerq@kernel.org>,
        "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
Thread-Topic: [PATCH] usb: cdns3: gadget: fix request skipping after clearing
 halt
Thread-Index: AQHc0zshyXnKL+kJ40WvjjGf2ih8TbXyIjAAgAB5XSA=
Date: Mon, 27 Apr 2026 09:01:47 +0000
Message-ID:
 <PH7PR07MB9538E83DB108635EAE7B21E3DD362@PH7PR07MB9538.namprd07.prod.outlook.com>
References: <20260423160601.2949010-1-yongchao.wu@autochips.com>
 <ae66WphA+lO6t3rE@nchen-desktop>
In-Reply-To: <ae66WphA+lO6t3rE@nchen-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR07MB9538:EE_|SJ0PR07MB8552:EE_
x-ms-office365-filtering-correlation-id: aefaf5fb-5db6-4cf3-2666-08dea43b9d2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 iTcQ/Aq0fJ26yVNKjzcMoaXJ+eBMIXYfV8xXqbVlJE77EWji57WYEqjp1Qhv2qUl+KNlW2oYHc+9Oj5rI9hGxr2ntLhKIRrn8hKRnfWXpppt/UqEy4M+6yO0HO0Dmz2Rjjjcgw4Xnr/RrfISYm9HHVus0hdrVR5/3tLxzZ4Y/q0ZJ3R/mXhIkJQVsKDwltZq6GCcXdVZ8qTHmSzJpN5sM/MWYk9T0g7Xl8mgDzG82gK3etZULKbC3fCBcUrg/OQ1vvmZ34dzpGIKC3JRyAUngGZOuplG8t6YFA+V1ZC7zO+clx5hDXDk4uK58HSwov3bZBLhOZYje6A0geg03ukoRIVbK9CiKkeRQQQhI4DLfko2Ejs7AmPS0bCb4RC5Hzgxy1P1F9cBjyr8MfYafxEal24EtLw3KAwgdA6NjlZzG6wZ0Hjmxm/vERNWHKs69SzPXBOPdN8ylpZ3wL00gRizMRHm9NLrHsgBYtcu+iF/UtvSNbxFv5EzmQVf1so7NrUu0kZiciJ2Bt79VypgdpfTENXDsVkXFjbugo1MMMjUPxssnySs13IGNY4F9gPGchVoVqBg5lmrkwMYaTBk81/HT6UzBQQo59Iy6G5V5vGPtNcofIsVyrzsJ+q/5lM0q1NJD5YZ64x+m9JgNQq0mQdU4vUnBVHBprE7dnpfta2xsMxnEKt4NCeidfttOPYvHXm1br3BlXm2hJDVJh1AYFIHUXdmHAnyNrj7BQgTdc9I0eSD6KDb1THdIXjFnHbO1GHhn4q6V2/URMS7qYzkP9KHxGI+uOtWor24wmXKNLw4Iws=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR07MB9538.namprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M1RQa2dVVzhMaFV2eG9mc0h4bUhabUVkNDZkbEZCNHJ0TkcwY2FCb0Mwb1Q0?=
 =?utf-8?B?SlpjMzJ2cStndmRYKzBoRXpXeFd6NlJNR2lLZDZvSlFNNEdwb1djM29CbnBI?=
 =?utf-8?B?bWFrcmtmaFZCZGxtblZIaG12OTZydXZIcmRSMkJ3NncxR29TVEtBeDZDdi9v?=
 =?utf-8?B?Z2pSOU1Ec0NwTTIza3hGWEhWU2EyMmgvR2dpczFnM3o2b2hzZkd5aUh4dDRQ?=
 =?utf-8?B?Ukk3RmNjRUFCanFROG1adDlvN1ZXOGpPc0MwSEZucTVqVVNRbGlCaTJVOGlT?=
 =?utf-8?B?N0VyNDB3UHBycjNueEU5NXBWL3lIL2dlajJiZUNuV1A0RHE0eS9INmlSc0l6?=
 =?utf-8?B?NGhzclFQYzNHYzA2SnJZN1k4V1hRRGZJQTNzVEkzTlVMcGFELzBZanU5ZnRj?=
 =?utf-8?B?T0Y0NC9BdHA1SzVQOU9XbzlPZVJWS0xGd2lGVnNhUHZJM2VBZnB3YWRQWC9G?=
 =?utf-8?B?ZnhUazVUUHliUWFzcXdvUEY1cE5VbitZNlJPTXlHcFdpWDc1azd5YmVZSENL?=
 =?utf-8?B?TE55Z3QwUVpYOU56VEVmUG1lTjZOai96Y1V6SlJPVVhhV2tKNkFUWkxpOXhw?=
 =?utf-8?B?bnNtVzdpdHdIampWS1RiNEdXemp2NnNmL25GSC9KeGZRSEJxZmZnVlNYNDFq?=
 =?utf-8?B?YW9tNW96cjZWdGd4Zi9pTjdkNytuSEEzNDdHa1pjbUc1SjlZbXVIVmZvZWF6?=
 =?utf-8?B?TmJoaG8wTXpKa0JibWM3bitLYi9PM0dUZHp2U0Q4QklRZlJwU1ZCbmFSRkgw?=
 =?utf-8?B?dGZ6UVFZUVBROGZKZ3owSDkzbDQzTkluVEczbEprYTRBY3RVR1BZMUVmQk9m?=
 =?utf-8?B?TTdLbzVaSDVveW0vU2R6b3FlMC9HMm16L0lVa0tkOGR2UHJTU05tc1VVNk9M?=
 =?utf-8?B?QVRJOURaeG05ckx4WWg3dkt4REZKQW1lSElUNWZuR3NjcUFVYzlwYnhkQk02?=
 =?utf-8?B?WUJCeVNJdnVhY1poSVlsbndsNDU0M0ZOazhqalF1bE5KQXpWdWVQeitlVnRN?=
 =?utf-8?B?NG9UVmtYcTNnY3NHZ0E2RmVMV3dkMGRmVnByd3lML1IxOGJkcVg2eVlYSjRE?=
 =?utf-8?B?bXJEalE5Ulltb05PNEhvWEtRSjJ5K01vODJqOVdJbVJDc2lvNTU2K3JlZ2hu?=
 =?utf-8?B?ZDF2ZFVpRXNMREpuQjR1bk52OC9NTTFKVkltcWZNYVEzcHJpS1Jabk9DemJ3?=
 =?utf-8?B?a3VEbTNBMmZ3a0NFVDFTazVvQktSbWJ1TDU4VGlKRHhwN29OS0didEpwbm1L?=
 =?utf-8?B?ckIzV21hTUs5NlIrV2tQQXczRG1nR0NmdG5rUkRWSFhpMTVqemVPcHlqWC9y?=
 =?utf-8?B?QWdINUd2M0lESWo5dGgremozcjI0UW9Hb3dBSlZ6d0lON3R4UklUbHRlVnRW?=
 =?utf-8?B?enVlQk5EZ0pvSmd3THV1cjk5T2xYcExlMUJGaFlmeFduNEIyMmpJRnhTZ25p?=
 =?utf-8?B?ZjRRa0hheWh4Z2gyNE1QcnMxamdZbWt5clFHTm11OVl2UlpsNXpLNDNUWHlP?=
 =?utf-8?B?dDF5dWRidjVwM3JlV0Ivd1dQS0lwTlBVOTRsSkZONFVDbXpCSGxUUnpSR2VD?=
 =?utf-8?B?YUhSdHRVeGR2bW1qdjJNRmNQM244N0RYYy8vWkovQWd4Uk13QXRVRk1FZlJ3?=
 =?utf-8?B?VnFyek1qT0Y3SnBkdU1yR1NyMlBPdFZZTCt1a0wxY3lESVNRM1JKS0d3eVBS?=
 =?utf-8?B?Qm5oREtQQWJ2WFVaamxQU1lRTjlQVENlOHR3dTI5REg4MGpQRWowalJhelB4?=
 =?utf-8?B?TFFNbEZKWE9LQUtFeWxmY0txSHlGVno4S1huK3JmUEhITlhEancyQzRObVQx?=
 =?utf-8?B?RmZydUgzVVBtRGpHTFowVVdIN3NPSzhsaFA4Rk5wMCtWQi9DcHJSK1JmR3hz?=
 =?utf-8?B?Q0g3QUZZZ215M3FpTzFTMlZhVkU1bDFTSEg1bkNiSmhiUkJzNVcwSVpCdDYw?=
 =?utf-8?B?ZTNZSHRiU3VON2ZVUDB0KzB1blZyZ1dkdkw0bTZhb1dSbS9JclRhYmQzZWpX?=
 =?utf-8?B?UmRXYnljUHptcTlOMTVteDJVeDhQNTgzMHpXMXN4amw2dk5kaTIyQy93L0k5?=
 =?utf-8?B?NTl3VVh0UmI2K3pFSTdoRE1GYktzTC8zSUgxTXlkbU93b29ZTE9QTHhHNnJy?=
 =?utf-8?B?SkNWK0huNVgyTVRMU05GNWhNV0Q4VHhNVTNXTVV2RzMrS3g3aThtRFk5UWor?=
 =?utf-8?B?MlBlWnZjOGl4RXhBS0FaSEdZVmFJSjluT1g0NzN3Q09qWVBwaHJ4SFZvQjM2?=
 =?utf-8?B?NHpIQ0E4ZE5YNGJBRU1kV29tV2ZoSzFrSmVST21yWmhXTTRxQXAzZXVvOTls?=
 =?utf-8?B?TTUxNm1HZTdUVUJjNGF3VHpFdUd1YkZxNmNHby9WdDc1L3RUKy9RUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	mJMd3eIBYyMeTSbwbdA78AoOEyFq7hZly2liPdkPy47JgWjHG/3gh+f+DH9aqFkIFpLlfryMXFYAk2pFlk2NNAz75WrGv55FIzs31I283SiVI5XoHgEKbVzqb84BBI6OB3aULJ2oCSEAbYsiOA3PKMn8BDcmjCFk3VI3RJaP11979WEgcPQ4HUa2MxCh9U1FLGKCv71Lx+mwrqvOt8T5GiK+mIPQX4sF4zFCT+e/iGbn7wxtvldTVGHY9nV0evtPM9DmDG/RDOt+D5fvIur2oDKfLQ/6VnmDR7b9a/jJerK8X6zeGP+tZDqxryPA7OI+E0fGN3owC3rQU1MEkauZ6A==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR07MB9538.namprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aefaf5fb-5db6-4cf3-2666-08dea43b9d2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2026 09:01:47.9286
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2c7+DFv7cGKXMdAonQmJybqMbZU2oiHe1E16Y05sa70o+AyWt4TgE/5ZM5GLV78B4Oo2jZyY3JqCnIkf/OlD1zxcXg2nUhUCYG2Bg5aHjKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB8552
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDA5NSBTYWx0ZWRfX6gfcr5b1A44m
 vvdnbV+QHAIrwJt7PdBl6ZaUb81GfgV8rk5K6FsYh27WsRSehTEWHOiQJRQXGyjhIGy5P7UOGAZ
 AOjuvLkOPnzuEvWLfL3ntPmqOWi0OVMkCqAp8n5ijnmHhXmqVtixF4rZzsjjRpuUoCpDCEVYjrB
 Ki2nKVVhWwB1UxSRv7asAmnWi33wex0CfqRy20I+C8NwK7teeWq6qNswVkJgzKBh2Y7fQkXrH5Q
 vvthAwu31Kauqtf9ZJTe3oOwxNRK6IxvVdiK4y+j9CiqnQdud7+tnXIK44Bq7S0/FK9D0jwwvwg
 bALtNhOcpIsfliEtyoXWSLxSf0iqf3D/3OtLR4YWQhMspkMAMtMswFOxB5dIFh8QyowPc2//qNu
 crh5ZH7ccZVJx8K3tz0dQomJgoGKZN7YitBCu57W7V3JkJqQIwhKjF3HYHXbgoX36gQZTNPIAvT
 CQV4lSpwqh+xJ2rmDwA==
X-Proofpoint-ORIG-GUID: 6QDNndfjNKLlIGej-Ag0iarTXNfOCDwd
X-Authority-Analysis: v=2.4 cv=L7ctheT8 c=1 sm=1 tr=0 ts=69ef25fd cx=c_pps
 a=TcXP/BJ3gOSVg56PH7Z4Eg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=Zpq2whiEiuAA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W8fx6O4W8wtO2w6lYej3:22 a=tuMieXAyK57eGGFK7xkD:22 a=VwQbUJbxAAAA:8
 a=qu68bWSyAAAA:8 a=1KUcR_3uXCYCbq36IjsA:9 a=QEXdDO2ut3YA:10
 a=rzdfeMbXz1BmwJd4iowZ:22
X-Proofpoint-GUID: 6QDNndfjNKLlIGej-Ag0iarTXNfOCDwd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_02,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check
 score=0 clxscore=1011 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604270095
X-Rspamd-Queue-Id: 98FE746FE61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[cadence.com,reject];
	R_DKIM_ALLOW(-0.20)[cadence.com:s=proofpoint,cadence.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241279-lists,stable=lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,PH7PR07MB9538.namprd07.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pawell@cadence.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[cadence.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]

Pg0KPg0KPk9uIDI2LTA0LTI0IDAwOjA2OjAxLCBZb25nY2hhbyBXdSB3cm90ZToNCj4+IEFjY29y
ZGluZyB0byB0aGUgY2RuczMgZGF0YXNoZWV0LCB0aGUgRVBSU1QgKEVuZHBvaW50IFJlc2V0KSBj
b21tYW5kDQo+PiBjYXVzZXMgdGhlIERNQSBlbmdpbmUgdG8gcmVwb3NpdGlvbiBpdHMgaW50ZXJu
YWwgcG9pbnRlciB0byB0aGUgbmV4dA0KPj4gVHJhbnNmZXIgRGVzY3JpcHRvciAoVEQpIGlmIGl0
IHdhcyBhbHJlYWR5IHByb2Nlc3Npbmcgb25lLg0KPj4NCj4+IFRoaXMgaXNzdWUgaXMgY29uc2lz
dGVudGx5IG9ic2VydmVkIGR1cmluZyB0aGUgQURCIGlkZW50aWZpY2F0aW9uDQo+PiBwcm9jZXNz
IG9uIG1hY09TIGhvc3RzLCB3aGVyZSB0aGUgaG9zdCBpc3N1ZXMgYSBDbGVhcl9IYWx0LiBBbHRo
b3VnaA0KPj4gY29tbWl0IDRiZjJkZDY1MTM1YSAoInVzYjogY2RuczM6IGdhZGdldDogdG9nZ2xl
IGN5Y2xlIGJpdCBiZWZvcmUNCj4+IHJlc2V0DQo+PiBlbmRwb2ludCIpIGF0dGVtcHRlZCB0byBh
dm9pZCBETUEgYWR2YW5jZSBieSB0b2dnbGluZyB0aGUgY3ljbGUgYml0LA0KPj4gdHJhY2UgbG9n
cyBzaG93IHRoYXQgb24gY2VydGFpbiBob3N0cyBsaWtlIG1hY09TLCB0aGUgRE1BIHBvaW50ZXIN
Cj4+IChFUF9UUkFERFIpIHN0aWxsIHNoaWZ0cyBhZnRlciBFUFJTVDoNCj4+DQo+PiAgIGNkbnMz
X2N0cmxfcmVxOiBDbGVhciBFbmRwb2ludCBGZWF0dXJlKEhhbHQgZXAxb3V0KQ0KPj4gICBjZG5z
M19kb29yYmVsbF9lcHg6IGVwMW91dCwgZXBfdHJiYWRkciBmOWMwNDAzMCAgPC0tIFNob3VsZCBi
ZSBmOWMwNDAwMA0KPj4gICBjZG5zM19nYWRnZXRfZ2l2ZWJhY2s6IGVwMW91dDogcmVxOiAuLi4g
bGVuZ3RoOiAxNjM4NC8xNjM4NA0KPj4NCj4+IEFzIHNob3duIGFib3ZlLCB0aGUgRE1BIHBvaW50
ZXIganVtcGVkIHRvIGluZGV4IDMgKG9mZnNldCAweDMwKSwNCj4+IGNhdXNpbmcgdGhlIGNvbnRy
b2xsZXIgdG8gc2tpcCB0aGUgaW5pdGlhbCBUUkJzIG9mIHRoZSByZXF1ZXN0LiBUaGlzDQo+PiBs
ZWFkcyB0byBkYXRhIG1pc2FsaWdubWVudCBhbmQgQURCIHByb3RvY29sIGhhbmdzIG9uIG1hY09T
Lg0KPg0KPlBhd2VsLCBJcyBpdCBhIGhhcmR3YXJlIGlzc3VlPyBUaGUgY3ljbGUgYml0IGhhcyBh
bHJlYWR5IGJlZW4gdG9nZ2xlZCBiZWZvcmUgdGhlDQo+ZW5kcG9pbnQgaGFzIGJlZW4gcmVzZXQs
IHdoeSB0aGUgRE1BIHBvaW50ZXIgc3RpbGwgYWR2YW5jZXM/DQoNClBldGVyLCBkbyB5b3UgcmVt
ZW1iZXIgd2hhdCB0aGUgVEQgbG9va2VkIGxpa2UgaW4geW91ciBjYXNlPw0KTWF5YmUgdGhhdOKA
mXMgd2hlcmUgdGhlIGRpZmZlcmVuY2UgbGllcy4gVGhlIHBhdGNoIGRlc2NyaXB0aW9uIHN0YXRl
cyB0aGF0DQppdCBqdW1wcyBmcm9tIDB4ZjljMDQwMDAgdG8gMHhmOWMwNDAzMCwgd2hpY2ggd291
bGQgc3VnZ2VzdCB0aGF0IHRoZSBURA0KY29uc2lzdHMgb2YgdGhyZWUgVFJCcy4gVGhlIGRyaXZl
ciBvbmx5IGNoYW5nZXMgdGhlIGN5Y2xlIGJpdCBvbiB0aGUNCmZpcnN0IG9uZS4gDQpJ4oCZbSBu
b3QgZW50aXJlbHkgc3VyZSBob3cgdGhlIGNvbnRyb2xsZXIgYXNzZW1ibGVzIHRoaXMgVEQuDQpJ
IG5lZWQgc29tZSB0aW1lIHRvIHRyeSBleHBsYWluIHRoZSBjb250cm9sbGVyJ3MgYmVoYXZpb3Ig
aW4gdGhpcyBjYXNlLg0KDQpZb25nY2hhbywgY291bGQgeW91IGNvbmZpcm0gaWYgdGhlIFREIGNv
bnNpc3RzIG9mIHRocmVlIFRSQnM/DQoNClBhd2VsDQoNCj4NCj5QZXRlcg0KPg0KPj4NCj4+IEZp
eCB0aGlzIGJ5IG1hbnVhbGx5IHJlc3RvcmluZyB0aGUgRVBfVFJBRERSIHJlZ2lzdGVyIHRvIHRo
ZSBzdGFydGluZw0KPj4gcGh5c2ljYWwgYWRkcmVzcyBvZiB0aGUgY3VycmVudCByZXF1ZXN0IGFm
dGVyIHRoZSBFUFJTVCBvcGVyYXRpb24gaXMNCj4+IGNvbXBsZXRlLg0KPj4NCj4+IEZpeGVzOiA3
NzMzZjZjMzJlMzYgKCJ1c2I6IGNkbnMzOiBBZGQgQ2FkZW5jZSBVU0IzIERSRCBEcml2ZXIiKQ0K
Pj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCj4+IENjOiBQZXRlciBDaGVuIDxwZXRlci5j
aGVuQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5OiBZb25nY2hhbyBXdSA8eW9uZ2NoYW8u
d3VAYXV0b2NoaXBzLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMvdXNiL2NkbnMzL2NkbnMzLWdh
ZGdldC5jIHwgMTIgKysrKysrKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvY2Ru
czMvY2RuczMtZ2FkZ2V0LmMNCj4+IGIvZHJpdmVycy91c2IvY2RuczMvY2RuczMtZ2FkZ2V0LmMN
Cj4+IGluZGV4IGQ1OWE2MGExNmVjNzcuLjk2NjUzYzdkMThmMjAgMTAwNjQ0DQo+PiAtLS0gYS9k
cml2ZXJzL3VzYi9jZG5zMy9jZG5zMy1nYWRnZXQuYw0KPj4gKysrIGIvZHJpdmVycy91c2IvY2Ru
czMvY2RuczMtZ2FkZ2V0LmMNCj4+IEBAIC0yODE0LDkgKzI4MTQsMTkgQEAgaW50IF9fY2RuczNf
Z2FkZ2V0X2VwX2NsZWFyX2hhbHQoc3RydWN0DQo+Y2RuczNfZW5kcG9pbnQgKnByaXZfZXApDQo+
PiAgCXByaXZfZXAtPmZsYWdzICY9IH4oRVBfU1RBTExFRCB8IEVQX1NUQUxMX1BFTkRJTkcpOw0K
Pj4NCj4+ICAJaWYgKHJlcXVlc3QpIHsNCj4+IC0JCWlmICh0cmIpDQo+PiArCQlpZiAodHJiKSB7
DQo+PiAgCQkJKnRyYiA9IHRyYl90bXA7DQo+Pg0KPj4gKwkJCS8qDQo+PiArCQkJICogUGVyIGRh
dGFzaGVldCwgRVBSU1QgY2F1c2VzIERNQSB0byByZXBvc2l0aW9uIHRvIHRoZQ0KPm5leHQgVEQu
DQo+PiArCQkJICogTWFudWFsbHkgcmVzZXQgRVBfVFJBRERSIHRvIHRoZSBjdXJyZW50IFRSQiB0
bw0KPnByZXZlbnQNCj4+ICsJCQkgKiB0aGUgaGFyZHdhcmUgZnJvbSBza2lwcGluZyB0aGUgaW50
ZXJydXB0ZWQgcmVxdWVzdC4NCj4+ICsJCQkgKi8NCj4+ICsJCQl3cml0ZWwoRVBfVFJBRERSX1RS
QUREUihwcml2X2VwLT50cmJfcG9vbF9kbWEgKw0KPj4gKwkJCQkJCXByaXZfcmVxLT5zdGFydF90
cmIgKg0KPlRSQl9TSVpFKSwNCj4+ICsJCQkJCQkmcHJpdl9kZXYtPnJlZ3MtPmVwX3RyYWRkcik7
DQo+PiArCQl9DQo+PiArDQo+PiAgCQljZG5zM19yZWFybV90cmFuc2Zlcihwcml2X2VwLCAxKTsN
Cj4+ICAJfQ0KPj4NCj4+DQo+PiBiYXNlLWNvbW1pdDogNDZiNTEzMjUwNDkxYTdiZmM5N2Q5ODc5
MWRiZTZhMTBiY2M4MTI5ZA0KPj4gLS0NCj4+IDIuNDMuMA0KPj4NCj4+DQo+DQo+LS0NCj4NCj5C
ZXN0IHJlZ2FyZHMsDQo+UGV0ZXINCg==

