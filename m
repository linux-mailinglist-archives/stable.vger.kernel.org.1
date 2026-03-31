Return-Path: <stable+bounces-231377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0MjKFHiby2lBJgYAu9opvQ
	(envelope-from <stable+bounces-231377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:01:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DAE36783E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33C323006236
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 09:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 922163EDAD3;
	Tue, 31 Mar 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="gj2gg+Ol"
X-Original-To: stable@vger.kernel.org
Received: from SY5PR01CU010.outbound.protection.outlook.com (mail-australiaeastazolkn19012008.outbound.protection.outlook.com [52.103.72.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FF33E0256;
	Tue, 31 Mar 2026 09:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.72.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774951135; cv=fail; b=oylAei2UgO8W/SsHokH6F2yd0hjKg1vK5vouNlEqYWcWTSExJs1DGNKfuwL8+ZR3wJbIGJ7JMvX7SNreH0JpPh7LyrUDexnpcnlVF6lHd4P38uAle9R/O4fJhvpnnRD6H8fp6xtc5Ik/pGOgitKchcYcA7e2G3RAQ8mHv9cvOFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774951135; c=relaxed/simple;
	bh=9ji3mQSU6QpVeIhWc5EzCvADWjtsrjzjdB7CPLiAQrg=;
	h=From:Date:Subject:Content-Type:Message-ID:To:Cc:MIME-Version; b=MKwNWF2bMtdjQeNU5YxnIbaeLaA0/hPiIb30CArZu/UblHNBU0L9Trc+SZbiTSX96b476E98loMdYunZn/CYDWrI/yFacmAmhz0cAmzD0W0tRVRn8w4dl0g6YPRQ01uyPvOjE0BmpQ1L09N+Ot2In9pWvcO/kvH4Xqk6haM+8Cw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=gj2gg+Ol; arc=fail smtp.client-ip=52.103.72.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FP5ODcIiD31HezYKZQsxRDnJM+2WVOX9VsnT3KZ5J0O9cC6ZcSBrBoZoY5/pbQWXDJCBTRMlX3LC/+4+OI4jUsEWtBUoTj+N8w+czxJXYlR7znLz80MNFzIWcplSBKrisK6eH404VvZnx7F2Vx2XxlZgh7oyQW0eI0JVh+Nz/WX4dj9r539BJdc1Ty9UTQ4xJS9auGgcrWDVkipbr2eBCRU+PuFBe/kWmdKw1JOPvlVq+KWmtpPnLUdsH1TG4K2aRZcRP5L7KHeQ7hdfDZr6OPVudedhVXgI64bxf5/UEgHOc468I4wYgdc5uP9HUkgVpeylIKobymlN8iChQ54jUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FlTu+MOQpJrc5wi0wiRvFNaK4gEz4vdMA0ApkAsjwqQ=;
 b=QPCUtfNS+curaJYENVpvFgMIlS8vrLkXgDFOl9i1AvKYF7NTsCKo54EOSpRYg6h6A7OYyWU8ziRbz8EvUiye5IT4DLvIO6lKwPmOzeQqOx2IZJvTYQKg0KBvHxkO5v/XY2m+3Moq66PqmYH+eDejVna8HGp2IvjESWpRt1wZqwXugv0avxLQ7WalxkBCnFxeg8OE9EsDKugtoInQYkcWtPXEopSx73NJ6DMeN5JOwye1/oeD2F2MUyhpHrKK351s8ktEL0+0hlpsJNIaUkDrX9rHSgJA8oJlzTW2OE9KeMLBgtsU/MAYMQt0EDjfo+0cMrnnaVGzuQwui8nEkAwDIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FlTu+MOQpJrc5wi0wiRvFNaK4gEz4vdMA0ApkAsjwqQ=;
 b=gj2gg+Oll3yrEpecL6cBLdRyWfws5CKOeBPAW5dy0W3/voAi/52xqTl9Stmog4CpIO1JLYZ/wWN3JArEcMdDam2zPDDWkBng5BzaLkVGO7yJdWgtDu65KeaKUpn2eCKzIynMXIM3lmkf7Razs8VOSA5vBRfAoBe4P3EW4zU2iBF/fYMRXmzqS9r0wc2dByC+OoxkK1HKxE6k99ZuHUBwk7CFGAF3V4t4J2TXpmZqdZeDw4a8CBOimk1xhhTNXYV24BivcgnzEaJB0lfiS23Nmamp3HqBmB+mC05wvYq1YNGAweXM1vn/RyBLcq7xGwfAKDJv8P0VyMjYhCFLvYTs5g==
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com (2603:10c6:10:1b0::5)
 by MEWPR01MB8726.ausprd01.prod.outlook.com (2603:10c6:220:1f7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 09:58:47 +0000
Received: from SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c]) by SYBPR01MB7881.ausprd01.prod.outlook.com
 ([fe80::7cd2:d6e8:3fa0:5f0c%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 09:58:47 +0000
From: Junrui Luo <moonafterrain@outlook.com>
Date: Tue, 31 Mar 2026 17:57:10 +0800
Subject: [PATCH net] bnxt_en: fix out-of-bounds write in
 bnxt_alloc_vf_resources()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID:
 <SYBPR01MB78817B7EE349BB2CF0FC6873AF53A@SYBPR01MB7881.ausprd01.prod.outlook.com>
X-B4-Tracking: v=1; b=H4sIAHWay2kC/x3KQQqAIBBG4avIrBPUAaGuEi3Efms2FhoRSHdPW
 n6816iiCCpNqlHBLVWO3GEHRXEPeYOWtZuccd4wW53kQdWAQ4px9ByY+nsW/KGvM2VctLzvBxw
 6X61cAAAA
X-Change-ID: 20260331-fixes-ee2efcc963a3
To: Michael Chan <michael.chan@broadcom.com>, 
 Pavan Chebbi <pavan.chebbi@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Prashant Sreedharan <prashant@broadcom.com>, 
 Jeffrey Huang <huangjw@broadcom.com>, Eddie Wai <eddie.wai@broadcom.com>
Cc: Michael Chan <mchan@broadcom.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
 stable@vger.kernel.org, Junrui Luo <moonafterrain@outlook.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2076;
 i=moonafterrain@outlook.com; h=from:subject:message-id;
 bh=9ji3mQSU6QpVeIhWc5EzCvADWjtsrjzjdB7CPLiAQrg=;
 b=owJ4nJvAy8zAJVb4wiKgu++DA+NptSSGzNOzytythN007lXN2Oi3e9XTq++ztu5w1p1w9WF4h
 Ljfvru9Hs87SlkYxLgYZMUUWY4XXPpm4btFd4vPlmSYOaxMIEMYuDgFYCI52gz/7I+orAg8seTt
 5w5j3sBTbfH/5bxfRm/2Yz/9faJDT4/eSYZ/2mwy9p8uJ2l48a9/HG3Wq9DMPa/4xX2th6dPuc3
 9clCSBQDBlU4N
X-Developer-Key: i=moonafterrain@outlook.com; a=openpgp;
 fpr=C770D2F6384DB42DB44CB46371E838508B8EF040
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To SYBPR01MB7881.ausprd01.prod.outlook.com
 (2603:10c6:10:1b0::5)
X-Microsoft-Original-Message-ID:
 <20260331-fixes-v1-1-ec550e500f3a@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SYBPR01MB7881:EE_|MEWPR01MB8726:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f7cdac1-601c-47d1-05e9-08de8f0c1a16
X-MS-Exchange-SLBlob-MailProps:
	dx7TrgQSB6d5vbofsfC/jnGJ+j4hG4ECyPl+el1MCkcEK7uteWdN7mFPclpnakeBPtQtyyvhpdlL3v+GPuhfm5wR/weBAz6J4crKX3oDF+8DB0NrexL0WINKp8sZ1hAey1QD0d9AAjIRxpZmCxZPygJ5n1mBl3TzDfOm6kFWRPTBVXcaa0u0zgWifjXrn1OqA3bPfA0TC3H98RmpK8rEz7lG2JOx0bSt+3TH5VfdRyQFshc9EmE5TTxMPsCtKqoG6dttzoQtd1g3sNdLIOsBSGbUc+u2NSH7nWi9glittXjbWQXrG9emxw987FXQkjg+toOtp/NvKVMUtzVhShJVzQ+tKWaUfEQg9c1mg0vZ9iQivvbwO4cUh9XJbIyYlTe63xICCJdu5XX/FxLs95zcSOd2WLuFmCvL9DrEae5j2hNr4sL2kunoepc/6KsxPcgBFil8xnZ2z6ze9H7FEfSKqsGzRVeSJ3uzDsLXaxlEQliXsn3zdiuk7ElZfOj/rqDY5g+kMuVp4XEYrDxK+tOurJEVqRdkPAFT2CnROtZsl/w0JchXPxz0un3R4LXaZz6J0W7ExI2wl3pSq3vbpJx/JpMyMyf+88aVkD86JSc6TGkuGc65P5yOqnsTL5m+KCiQs+kdJlPjSfcUb0bwGIa0P012ZazLmc3h/COTd5OT4Sn+QhL2kyUsOogNZIAkW2xz/655gzE0NnVH9Be3ifBkX+iyQfPn9ci/9wVBpbl6vmLclL59fTG1IioPA4LouczU6V0CASBjCzc=
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|5062599005|5072599009|19110799012|22091999003|24121999003|8060799015|51005399006|15080799012|6090799003|23021999003|41001999006|461199028|40105399003|440099028|3412199025|26121999003|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODlSb2N2YTlMUDlTcWpnY1g2SWpVeG00bDJvd3ZZV3hzVHFva2UrVVBYT3Q4?=
 =?utf-8?B?ZDZwZ2ZFaVhrdlFXeFBvRzBRUU0reks3c3FnWExuLzNnYkk3WU1oWkhCU1RY?=
 =?utf-8?B?THh2ZUp3enN6eW53TDIrSFM4cXk1b1RaMWlkVTA2K3NqT3htMi9CTGNGOHIr?=
 =?utf-8?B?L045UHM3OUg0ZXBPNmlOc0l1YlFhQkNyd3BYN01vV2lOa0xmVjBYVm0yQVor?=
 =?utf-8?B?eE01YnZFNkd1L095RTIraU03N3VETkRQbWpWMzJCZFVJYVJxMnVWQ1J4UWtU?=
 =?utf-8?B?ZVZrbXJIckVoQVBpbnZ0WloyRW54T3BuL1NTS0RnTm83WFlNZW9EdzJtWXA5?=
 =?utf-8?B?RHFsaXEvSWxoQ01wbU1TOVpaTldXUkFVdWhqb0RBa21KYzJxQnVoNzc5eGVx?=
 =?utf-8?B?bFk3TU1DWlNBN3I2UDM1bEk3K2ZBcEYzem1BZTZLdmJKWCtScW4yTHpEa2xK?=
 =?utf-8?B?V3B2L1MwaGpGR1N6WEN1V2ZOdmhtaGVIdGI3cmpGNDY0NDIwQnFYTkFBaHd0?=
 =?utf-8?B?UTh6c0VUT2lKZjNIWkJmWVlOVlV0SWdNTWtpMjZvRHh0SmFPVTcyd1QxcHkz?=
 =?utf-8?B?OWk4T0FZZHh6bEhKT2hRdmVJWFJGMG82clNnWUlNYmxRRGFZNTZzYnVVakNV?=
 =?utf-8?B?YkRkQWZCc1VKQ2dlRUxNUC9aU1BlZUtEZzQwYW9GL29CeXVRbHg3RVdJMUwv?=
 =?utf-8?B?bjVNbU1tRVdhbUZIV01nMVJpTW5RdlRVaEZ1VFNSWEd3alhVY2hYMmhGN3ZD?=
 =?utf-8?B?THpMUTVjS0tiNXk4RE9UQmV2QncvWEJoZmZSQk94UnZNUVFCUGtZNVZxUGVU?=
 =?utf-8?B?bit3bzFrU2R0c2VmRUFIOHF5Z0p6bS94VHcrMGN5Mm9DVUlrdE14eVN4Zi9I?=
 =?utf-8?B?UmduZVEvM1lybGJiR1VlSHE2WE5CM0RieVVSYVJPc1lJbGdYOWx4TWZYT24y?=
 =?utf-8?B?UTFzTEhZTEpGcDZuN1hqbjRlRE9PN2Nad1E2OEpzUzRMOHVvNmlPaTk5aWox?=
 =?utf-8?B?bzFxV21idW9MTmlTclR1Mjd6R3drU00ra2hvVEIzUW5VOWxLdC9MeHRMamhG?=
 =?utf-8?B?N1ZtSlVmdnRFTEFsa2tUWVIrWGR1UmRicmRkT2xaNVZwWmJzZFFKdzM4Sm5o?=
 =?utf-8?B?T2t6N1Y2R2dicUppTE1UZVhIbStBcVBxSFJRb2JlWU4rdStGcmovUHlpMGxV?=
 =?utf-8?B?cW5ZR2NFamhoc2dpd2U2VHRyellpNVJCanRqUVZGUkZ3Q2Nvb2NTUEJidjhD?=
 =?utf-8?B?SS9FTERoa0pJUlNnQzlXZVFRcDZGY2JCdlV2c2xVV1VQZDFmb09tKzZNU2hK?=
 =?utf-8?B?VURrLytpMldiLzRscVh0NEp4S2xJdGxEV1JqRHFwOGdhT1UwaWhFRE5lMXZq?=
 =?utf-8?B?ZERoeTFDOXdyRUs1Wm0vSWpXcXc4a1MrcmtsMkx2Mm1vbnRWc1NSbkVadFZ1?=
 =?utf-8?B?c1N4dm1RaFErNStLY1lzK0Q3SldML25MdFU5ZC9GdlQ2QU5vNjMxb3YxeW45?=
 =?utf-8?Q?7/8LYqZZDU1fZQuXHdKghbNKoTG?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2JEV29DWmxPVlFBRDFRdjdKRENqSk51Qjc1cHhIR1hSeDBOSllCZnhDS2lU?=
 =?utf-8?B?TjBxcTdJNnpmNUtTakJKaTZhYlVVWjRpOUc0Z01YVVJYbndycXcvdEN0YmRW?=
 =?utf-8?B?RkVzaWt6QlhNOVpPZkJwUEN2ZzZYMXFVWVhmQjN2NXJHNU02QUp6UGpSYXhu?=
 =?utf-8?B?RndJQ2hEYnVNRWt4M2ZnSHpNQ3NHQ0Y3M2RjaDRRbjRBbzNaOEhJQXh3VzAz?=
 =?utf-8?B?aVpqZTgyYUh1bDFrdnRtSjdCUGdwakhwOUFJSDhXUllXZFpTSHMrZ3dQYkhm?=
 =?utf-8?B?cWZtdjZPSkRpcDBOUjJiQkpNYjJwUXBZamRzdnRoUlQ3OGl6aDM5ampkUzRm?=
 =?utf-8?B?Wkg0NFgxMlpqQURwUDhOWC9UZFBHeEdpeTdUZ1l3YkNYT2VVaEhWOFdOaGZY?=
 =?utf-8?B?MjFXZTJGRnpleEJ3QytHNDJweStuOE5ML0lUUGZxUzBUc0FMNkxiOE8yM0lM?=
 =?utf-8?B?a2tkQnlBS2xmYjZYN3JHcVIrL0svSnY5bUpoRlY3RmZualVKZ2FmNHVTZEEx?=
 =?utf-8?B?WTkvcXdxTWpQdDRKTXpIS3ZOcXByWWZuNXowYWFiRlE4MFlFKy9xNHU3OVNx?=
 =?utf-8?B?Qld3YlZBcVJOaUlHM2svWjBOdWdCV3F3WFM1bHpxMklaVkRqTXNUNjZEVkk1?=
 =?utf-8?B?Q1Q1OWlEVkppV1VLSXJjZy9MK1NrT2J5UFYwR1lLTlcxRE9yUjY0Y1d4eVpO?=
 =?utf-8?B?NUpMT055WkxvUE9vUURVSFh4S1hkNElweHQ0V2cvTnZtREkwSDBPc0svMmp5?=
 =?utf-8?B?Qmo5Y1ExZTNjOVFHYVM1YjJTV1FING56dkp4SGNJb2JxUnMveUU5NlM2OHNi?=
 =?utf-8?B?VUkzR1pEV0dtSkg3VXM1Y1ZEdHB6dHpFOFNJeWdYcmRTNWFXWHZLQWlEbXFj?=
 =?utf-8?B?b0F1enhseFZBblRYYi94Yk0rUmE5NXFwbGsrSHJsc2FTcDhoMjEzcXRDN3dG?=
 =?utf-8?B?OVBMdkwweU96RzNmbk84NU1RWFhDV0lEWHhZUFBsbVBvLzc2OWJsZVJHZTV2?=
 =?utf-8?B?MzFVNCtleWFEclV4c0VPRmZsQTc5bXJVNWVFZjlYbVVjRkFxdzBvdEI1MWxx?=
 =?utf-8?B?ZXlPV1dTVnpVZThHc1pCbzJLcmplaW9CMUYreW9lOUxSKzYwRGVVMTEwTHFI?=
 =?utf-8?B?ZmFhVmZCQ3dUWHdjY3NmQ3FwZS8wQ2ZuU282ZXVBMG5LSFk0NHU2U25HMmp2?=
 =?utf-8?B?K3dTQVJUMlFVSEpxc040b2N2c1VRUXpJcFlaaTVZV3lGL3FIdnFrZnpnWkxP?=
 =?utf-8?B?K0dpSSsreDdaRlNPWmRxeTZSbFl2ODFkVE5KQnNhbzRaQmMzMXQzMW1XcmJN?=
 =?utf-8?B?WmNwdEJieW5CWm1ERmpnV1VLU1lPNTNDU2RJSW1MM0V0UHpRREFPWmhtWlBE?=
 =?utf-8?B?QkpQM21yRjdDSjdINDJyZnVRSFZSQ0tCakphT0QrUjA4b1pNcG04ZzY5Rit1?=
 =?utf-8?B?c3llMnlaRzAzNDNlMmFSb3RCNWFsbUk4aWxXZjVadlplZHErdWczY3J6cFh6?=
 =?utf-8?B?WnIzUVdLMzRWYVd3Zm04aTgrTGtwYlNER08yRzI3N1FzVHhEc2RabE1CbHJX?=
 =?utf-8?B?bHNyWllUMWhJT05jaGhYMjV6bk03ZXE5azNzSENaN0VCWVpzaFlnUFdlUFhS?=
 =?utf-8?B?SVFEc3oyMEtaZHJ3azk2TEw5ak80cE5TTUxlb082Vm1UNzRtTE5rL3Jjc1hF?=
 =?utf-8?B?OVJ6ajFweC96bHR3bzU1eXVIQ1ZrMmdGYlZtWU5vUnZvcFUwWCtJTVQxSnht?=
 =?utf-8?B?UDYxN042NitJRDEyd3RUVzhtUEM1M25rbjYrQlhSbzR0Ry83bnF4Tk5TWVg0?=
 =?utf-8?B?VHcwVU94QlluTnRDVEFCd0wvdTE3SFFMRkptVE1BRzgxYWFhRDVqL0tsTDlx?=
 =?utf-8?B?NklPSTV3VWg3NlpuUml1bjZ1N3pTNXhqRTJQZjg5YkJnS1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f7cdac1-601c-47d1-05e9-08de8f0c1a16
X-MS-Exchange-CrossTenant-AuthSource: SYBPR01MB7881.ausprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:58:47.6526
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MEWPR01MB8726
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[outlook.com,none];
	R_DKIM_ALLOW(-0.20)[outlook.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-231377-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[outlook.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[broadcom.com,vger.kernel.org,gmail.com,outlook.com];
	DKIM_TRACE(0.00)[outlook.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[moonafterrain@outlook.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:dkim,outlook.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,SYBPR01MB7881.ausprd01.prod.outlook.com:mid]
X-Rspamd-Queue-Id: 47DAE36783E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

bnxt_alloc_vf_resources() derives the number of DMA pages for VF HWRM
command buffers from num_vfs and stores them in the fixed-size arrays
hwrm_cmd_req_addr[4] and hwrm_cmd_req_dma_addr[4]. The vf_event_bmap
bitmap is similarly fixed at 128 bits.

If num_vfs exceeds 128, the allocation loop writes past the arrays,
corrupting adjacent fields in bnxt_pf_info.

Add BNXT_MAX_VFS to cap num_vfs at 128, matching the existing array and
bitmap capacity.

Fixes: c0c050c58d84 ("bnxt_en: New Broadcom ethernet driver.")
Reported-by: Yuhao Jiang <danisjiang@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.h       | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c | 6 ++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index a97d651130df..cee67ca2955d 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1398,6 +1398,8 @@ struct bnxt_vf_info {
 };
 #endif
 
+#define BNXT_MAX_VFS	128
+
 struct bnxt_pf_info {
 #define BNXT_FIRST_PF_FID	1
 #define BNXT_FIRST_VF_FID	128
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 7f9829287c49..18ac0aaf4166 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -459,6 +459,12 @@ static int bnxt_alloc_vf_resources(struct bnxt *bp, int num_vfs)
 	struct pci_dev *pdev = bp->pdev;
 	u32 nr_pages, size, i, j, k = 0;
 
+	if (num_vfs > BNXT_MAX_VFS) {
+		netdev_warn(bp->dev, "Too many VFs (%d), max is %d\n",
+			    num_vfs, BNXT_MAX_VFS);
+		return -EINVAL;
+	}
+
 	bp->pf.vf = kzalloc_objs(struct bnxt_vf_info, num_vfs);
 	if (!bp->pf.vf)
 		return -ENOMEM;

---
base-commit: c369299895a591d96745d6492d4888259b004a9e
change-id: 20260331-fixes-ee2efcc963a3

Best regards,
-- 
Junrui Luo <moonafterrain@outlook.com>


