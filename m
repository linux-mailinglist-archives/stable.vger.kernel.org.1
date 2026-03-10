Return-Path: <stable+bounces-223775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHb8NpTMr2nWcAIAu9opvQ
	(envelope-from <stable+bounces-223775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:47:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D3B246995
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 08:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FAAD302ECB0
	for <lists+stable@lfdr.de>; Tue, 10 Mar 2026 07:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013C13630AE;
	Tue, 10 Mar 2026 07:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzfJerQ+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F29361DDE;
	Tue, 10 Mar 2026 07:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773128826; cv=fail; b=le6sxF2Wb1hyQeJ6dK9e7UhPVBBM0Ez3JfmpwlF4KdquFtkkzL4EsfGIWtN5LwUDYLo3+omSdPvYA6saKriGBWIAYz9q+QOk7K994Pvhh4oxADfsKtQCl5tGrxAvhTBuuXUKnaPwuRPU2vITZ8g/C4Z+k7yGQ6XSuvzwxnkmEaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773128826; c=relaxed/simple;
	bh=ckoTC9As/3Y1oWMCwfdvnh79ha1QCBxFPU5YktbPP/c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CITUbPFBBNxyeo+fsjkbbpnUMMlWRwvIQ4xDXfXTl35O8lqfm6C5OoT7in0vnJSOdcFRbnEPbqapU5m0KC5hBeieu/8p8TvulFUZ9JqoTh39N9okkvKsLSLyrZjGNMXencYwUJ6nlQLjoLW5iFDmRiPBR9Q54DeL7pC+7DDDFTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzfJerQ+; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773128825; x=1804664825;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ckoTC9As/3Y1oWMCwfdvnh79ha1QCBxFPU5YktbPP/c=;
  b=dzfJerQ+tSvXi750XGfPJepNHZr5Pl/CFHseU+TwzHpelxbBqTaKU3l7
   4JDPqogcTiDiSp5MHWtJib332FHeytEGkXJPI7emy+Nry6+zuR+MZKtQx
   7le26ALfYRobDPk9PlRrdfhht2Iq+LtOPlVuW+F2NwLO01asuaLGE4Gs5
   X/8zTJJiPO5N+odlXd539iLztUtpKwKOm0d6VMj426OW+GpsFCWJuqydx
   48mB5k88UDdaQ/qgI8GYPem42pMZX4Nu2C2HZ6orbE7Q6is77oV2YOSfJ
   W83/x0UlogeJycJLq6QymYI8FM60ZblB/QbOJ8aIN3j7kWoX82pwwyWsM
   w==;
X-CSE-ConnectionGUID: ggpvWKz3SaOgHk2EuLK9KA==
X-CSE-MsgGUID: Q4fFgq5JQI+fp966d88Jbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11724"; a="85523111"
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="85523111"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:47:03 -0700
X-CSE-ConnectionGUID: junV4PgGT0K2+wyIix18Vw==
X-CSE-MsgGUID: Eek9cBmtQrSiTx9S+SmcTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,111,1770624000"; 
   d="scan'208";a="222642003"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 00:46:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:46:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 00:46:49 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.52) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 00:46:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x2C/mkKwtHV95q8kB+iJTQ9w0kfZfCuxE3CFF0aRaXV+BqY8j91za8gMQxjuYJ1+W3T9A+wDh0QBaVpDF14qiGTnLIhiNioxbjGQh36CA8a0Q1gWH9Jlje92psLBY5ljfsF7FAxJ1+Bs+YXX9xHw7aquGMl0MpvgkvDEgU2doZ/g8vy3Vl22R31RZRj1YoECQvuPXY0i+byBvHInwfBOY78KJBp0xvJfpY8+xKBS2vtiezWxWR21K+Zl0mcFq4gNZvJK49hDTMgZcBKku8DdExkE6HvLJFCWxmC0AEyYnBrH61VcwKa2mXG2JQ2LOAEm0Ol61VwgrfkkHXRv8utLvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckoTC9As/3Y1oWMCwfdvnh79ha1QCBxFPU5YktbPP/c=;
 b=DZ9OePRA9U4WXDkKp4iOUNl1KuVNVXHhKL/ceFrKbDxEJISzFnvEK/rKwOIgXqBFRZzsT/xREVXxfjQAgfbXymUW9wrgMAXC75miv784lxGF9FpnSQnrbd6Yd+dDqlsPcFaKFY9FTqvot2p52z80MjkKl5ozBxOg/1LWiogLsodRN3HFsuGhRK2XhNncEy4D6d3x3JOvrhrRIJjvOwYHlbQMMEFBe8HZncyRTGf+iSr0CsYvoqerelsJho5tZA9FnOedw8DwWe5hQ2JocKJp6lvFhLvMXPgz1vwYHfxZipzKfrDya/iwHsptB7eKQ9n2yt3zOWdFf4mEP3yC8DOmfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA3PR11MB8986.namprd11.prod.outlook.com (2603:10b6:208:577::21)
 by CY8PR11MB6938.namprd11.prod.outlook.com (2603:10b6:930:5a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 07:46:46 +0000
Received: from IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c]) by IA3PR11MB8986.namprd11.prod.outlook.com
 ([fe80::e6f0:6afb:6ef9:ab5c%5]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 07:46:46 +0000
From: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
To: Alex Dvoretsky <advoretsky@gmail.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>, "kurt@linutronix.de" <kurt@linutronix.de>,
	"Fijalkowski, Maciej" <maciej.fijalkowski@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH net 2/3] igb: skip reset in
 igb_tx_timeout() during XDP transition
Thread-Topic: [Intel-wired-lan] [PATCH net 2/3] igb: skip reset in
 igb_tx_timeout() during XDP transition
Thread-Index: AQHcra5AQcGjrwkYA0GhM29aLBa3urWnaKBA
Date: Tue, 10 Mar 2026 07:46:46 +0000
Message-ID: <IA3PR11MB8986B1B1D85E69DE79670A12E546A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260306211310.1213330-1-advoretsky@gmail.com>
 <20260306211310.1213330-3-advoretsky@gmail.com>
In-Reply-To: <20260306211310.1213330-3-advoretsky@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA3PR11MB8986:EE_|CY8PR11MB6938:EE_
x-ms-office365-filtering-correlation-id: 74fe77b8-2894-4937-f455-08de7e792e03
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info: XRtz7ULRTK6tLJyMRhuEyziZ3b8EJPXIxPfZukoj8DaXSCE0VwuYjjBJKVjfZHhFnVVkmrNPEg6bdIxckc2n7vEsCHjN22Z2EQatXYIpn/DOfY/jwhp0FS6tKmrQy+1DD3vnlYqh+NZ8dnXeJhb01Tka+oQfJX4PaigPcz6+10NFVza8vq+MTXTlq6JueBZi2yWO6Hg9ZwvQ9KoBxFYn9zec1VBnshi1HE9Jj9L07yN0A+P8IH4uwsNUMDvDR030mk8QZTR7Xa4aXpf/w96n2D60RMWgKpl0VqJumIw3DHqnRNzyN5wKEo4+6iSvkOFEMb+De3sFOzlsa81pvwx4SEYESitti1mS0FdYljxFFzP64nAMgcK8atU6c+lZVbGexi7C8kVKsdQhfhh1TOYJdkA7Wit19H23X04S7JQkvhW6UVp8EMcnUXB7XZ5eDrtntqIHEbfY0OHPqEC/SmQdhjXOdhPKcBd/+H9Jl8DOhttAHp78sQsla8pYq+a13eLmJIOLwv3pc4M8qbXLEiyrRePvU1DD8xjUg6XikLDBuD+baGVkeg8XHUr3x4QTE3dq7bhrcRd0nzFSpLt5kJ+Okn0udZ9rFgMAVyM/TKhMzYUiyVcwt8gn+Ibs3fQqmJDOcGExBGHtJsZlN87kAe5LuwZa8z0/WyVgxNjYeVaEC/9WB/LNhTAhghY3XauWJ1na55YX5Uvpf6ZHGWzUmza5AAk/GHzL9/58idlPEtaKxJpmMKuRnSyjxhe0DKDtVkv9Z2mJFeUC31b6AN85JcvhlKDrvcRYZM74Q7pecXkzoPs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA3PR11MB8986.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZFFBYmxvQmZJRE1QR0hSMm53TzFNMnVaRkVoTFFQbFBwZCtWLzhyZTFERzhZ?=
 =?utf-8?B?K0Fxc05sTWljakJEcWkvampXUmxBMXYyeEU3dXIzcUxXam1uZUV1aUJKU2dV?=
 =?utf-8?B?OXBSYndkS09mY1dYR1dwNElYNUNualVBMlh1TDhhV3RyN3dkQlN3akpMZFB0?=
 =?utf-8?B?SjBMQjRhV3F6dmpFcURWM2dFNzlZSkxmZkdBTTJnR2FmYlRCVllsK1RyR1cv?=
 =?utf-8?B?dnlYREgwVGt3c2hEeEo5MjdBdmFnVU8xZWs4UXhSUjFTdVRWdmFjSFQ5Z3hM?=
 =?utf-8?B?eFl2T0hyZmxrN1RNcVFYaUIwWXNGbnc2a1NRQmlkVU9pbWlMcmRXdm5PRnRn?=
 =?utf-8?B?aDlZa2JTd1hsMmZBVURPM2JiQVlYaGlWOXBHMnpIejZSZ0RUZDhCdk10bUVz?=
 =?utf-8?B?eUNXc3FTUGNtWTB5bWt5K0haT05RUjdJYkNNUEdRVU84VW14QUxkM2JFMmxT?=
 =?utf-8?B?VXRwT3lJcEtwUTg2eU0veWZoL2lWd2dHL20rSjg1b1BEbWdyZHpLSHFGdlpT?=
 =?utf-8?B?RU94UmxoT0diSUxBdStPREFvRDZSSEVDSEJaRFk5VVoySzFWZSs3WWJZUXZp?=
 =?utf-8?B?YnV3YllUNzcrMDE4Z3BBc293S0dCYkxmUmg1SUpsZTFqVG9jU3R1RmcyMlY2?=
 =?utf-8?B?TTFlLzVxY0luMWhNN2hicUJNZjJFUGNwRzR6TkE1UUIwb1d5dUorb3FpYysv?=
 =?utf-8?B?dnpFdlpwTnNKVzlLTWJqN1c0Wnd2RXpCVkdFMExlWnV6azhvU0E5NTI2Ymsy?=
 =?utf-8?B?dlRpTkNjZXZDdVJtblJqVWRNWjkvbFZ5SXBmTEhuVHY4MVJoaU5oNHduOGJ0?=
 =?utf-8?B?N2xYMTZVQW1PdUpDNGdFL3M5ZWU2T1NiTkVBak5nbEphek12L1dWQkFXbVBi?=
 =?utf-8?B?N2tIWnBiTEVZVEJDMzR1ZlBYQlBlZm00S04yOWRWcnFFWXk0VHBYTC9XcW1Q?=
 =?utf-8?B?MDhtMkFyRSt0QjJmdWljZW9uSGR4NVl1b1hLYjJBT3ZoMUZ0S1gydmlURkx6?=
 =?utf-8?B?QU1raW5UTHNUcG5IdVRNdGR1RkcvZDNGVlAwdkxpZ1dSZXp5R1ZVSWR4ZDFl?=
 =?utf-8?B?eE5TQ1Y5aVVMM1ZwZ0tRK1pYQXhnSzU3a251WlBHZlpMNDRmTXhVLzFnVjN1?=
 =?utf-8?B?VkZJVlFDUHlNbk04Q1F3QXF3NFcwMWs0SjJDVU5kMEtXYzViQ0VWYW9UdGdl?=
 =?utf-8?B?U2ZDRkp2MUhhbm9OQ3pTVUxYQngxdFdkT1ZjcHF1QnkyaUhTVUFGK1ZyRHZB?=
 =?utf-8?B?ZkxJK0FjZzFXYjdnZUZFRUwxS2hKOWZJc3BvWlRzUEdoZGU4ZldCNGN5TUNF?=
 =?utf-8?B?WjA3SXg0djJTZkpycnhPM2tZbHlSaGdKRDViemhzOUN0NFVDWWtCbHhBQ0VU?=
 =?utf-8?B?UkJ3aCtTTytxSXBuV3BsdUhBdDYxOUkzQk0yNlVORndHc1ZMSFFQOFlySW9p?=
 =?utf-8?B?TVk2N29QOXFodHlrTVpzWlo3Wk5DeHc1dWExb2NDWWthSkFWSFVudngvaHBp?=
 =?utf-8?B?dWgrNFhMUWhXWDB4Z2lSc3lqdnFUbVpRMld0cVdQRFVIVlJhM3IyKzNzSk5x?=
 =?utf-8?B?U2M4Rjc1YVBVNVQ5RlRaSXhmZDhwMlZGOThMTU5zU1pydHBhOWhMckRVMmZJ?=
 =?utf-8?B?UmRJMUtBaE0xUW0xa0k2eS96dW9IS0swZUxzTjVtVmR4MHM2L0NjejN0Q0dl?=
 =?utf-8?B?ZGFaMnZNZ3d4eGc4aTVuMGNqYzBDL0VnUFYvcUcyclp3Z3JNckQvNnF1TzVy?=
 =?utf-8?B?OG9yN01Sb2kxU1dGK1VlaW1DT0JWYWVrVVl0V1VEcmRTcnJ3dDlkVURRbDh5?=
 =?utf-8?B?cjU1c3pVeFBUZXpSVFNjQ1VYYmwzZUczdGxhaXB5dVdlc0VDaG9oM3U5bnBW?=
 =?utf-8?B?eXVLL3Q3OXpNd2F1aU5UZWpKUTZpSHlFb3I3Sk9Tb2xFUGN2cWJtNXZueDBu?=
 =?utf-8?B?MnE3ZkxSdDB6M3JzYnJZYkYxV095NUNXdnF5a2JGbEIrUngyVmxzbUlqTlFn?=
 =?utf-8?B?endyK3dka0oyZjN6YzVEWDlYU2NZOFhIUzFvSDBjRmx5Y0cxbmpGYlRNY1ZG?=
 =?utf-8?B?SHQySGw2VXUxeW5NcDhXMnpYZVFLeTkzQzRqSVBCNzdFN2RxaEI2OHZGSy9H?=
 =?utf-8?B?ZzhjbU9GYktNZDlnOWtWNHVuOFFPT1o5OVpBeGF0NjV3Uy9MN0JkRzVvaHBr?=
 =?utf-8?B?L2tIRThnYk9HUDhIUjVIN0RWS255d1ZjSEhMUmI1b0dvK2pHaW9xWG1IbW8y?=
 =?utf-8?B?bjRSaDhicEY0NjcyMVBOWlV6ZDdxaFdjKzhYaXBEQ3Frd2xONEtQTDZiVzZB?=
 =?utf-8?B?MHIwbXZtZ0hBL2hPazBjVGxVbGZROXByTnA2dUdJNG9WYXFRQk03Mzc5ZS9r?=
 =?utf-8?Q?Yi2eqJDrMoBRTVHk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sYHyIesy+0NhMrVCACaWzHtI3zwR4ivcxW6xnMieJAQfu6/NqC2kzkD1bb+uHLrkR2MLlNl/Fq1sn1ZOm+D15WxF+jYIK4PasUjKBhz9gyZwc7lMa/wVB+AwKbxTDOFS1eOBy/MRMYxFj+b4yMYbMGzTFGQmIvR+4w9Z2NI/NvOQr/pK5YIKGb20tlgNzaz3bNPmT9oR83t4wOiLq28asc/7KnaF2RkJXAZ5VssTvZTd0UzHswZ5X78Zb/BTZWVW0Mo3ek5ipVY+dutkU18iqkgD90P+I7pwGuwWCTsyu7E1GxA+SUJN8RHo1JOXmJiUHqpN1SikugrE7v60Ga5rNA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA3PR11MB8986.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74fe77b8-2894-4937-f455-08de7e792e03
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2026 07:46:46.1043
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UcWS4kxuTMNwiGvXgmjlgcWkDNvjCQugeh7iyxZ4sMWXUQLREWWlRvl5TON9+OMcdX927D+mEYKPIILF4QRIUzxxbz5gZMfzMtiOyvFbXnU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6938
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: A0D3B246995
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223775-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linutronix.de:email,intel.com:dkim,intel.com:email,IA3PR11MB8986.namprd11.prod.outlook.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksandr.loktionov@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSW50ZWwtd2lyZWQtbGFu
IDxpbnRlbC13aXJlZC1sYW4tYm91bmNlc0Bvc3Vvc2wub3JnPiBPbiBCZWhhbGYNCj4gT2YgQWxl
eCBEdm9yZXRza3kNCj4gU2VudDogRnJpZGF5LCBNYXJjaCA2LCAyMDI2IDEwOjEzIFBNDQo+IFRv
OiBpbnRlbC13aXJlZC1sYW5AbGlzdHMub3N1b3NsLm9yZw0KPiBDYzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgTmd1eWVuLCBBbnRob255IEwNCj4gPGFudGhvbnkubC5uZ3V5ZW5AaW50ZWwuY29t
PjsgS2l0c3plbCwgUHJ6ZW15c2xhdw0KPiA8cHJ6ZW15c2xhdy5raXRzemVsQGludGVsLmNvbT47
IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGt1cnRAbGludXRyb25peC5kZTsgRmlqYWxrb3dz
a2ksIE1hY2llag0KPiA8bWFjaWVqLmZpamFsa293c2tpQGludGVsLmNvbT47IEFsZXggRHZvcmV0
c2t5IDxhZHZvcmV0c2t5QGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW0ludGVsLXdpcmVkLWxhbl0g
W1BBVENIIG5ldCAyLzNdIGlnYjogc2tpcCByZXNldCBpbg0KPiBpZ2JfdHhfdGltZW91dCgpIGR1
cmluZyBYRFAgdHJhbnNpdGlvbg0KPiANCj4gV2hlbiBpZ2JfeGRwX3NldHVwKCkgdHJhbnNpdGlv
bnMgYmV0d2VlbiBYRFAgYW5kIG5vbi1YRFAgbW9kZSBvbiBhDQo+IHJ1bm5pbmcgZGV2aWNlLCBp
dCBjYWxscyBpZ2JfY2xvc2UoKSBmb2xsb3dlZCBieSBpZ2Jfb3BlbigpLiBEdXJpbmcNCj4gdGhp
cyB3aW5kb3cgdGhlIGFkYXB0ZXIgaXMgZG93biB3aGlsZSB0cmFuc19zdGFydCBzdGlsbCBjb250
YWlucyB0aGUNCj4gdGltZXN0YW1wIGZyb20gYmVmb3JlIGlnYl9jbG9zZSgpLCBzbyB0aGUgVFgg
d2F0Y2hkb2cgY2FuIGZpcmUgYQ0KPiBzcHVyaW91cyB0aW1lb3V0Lg0KPiANCj4gVGhlIHJlc3Vs
dGluZyBzY2hlZHVsZV93b3JrKCZhZGFwdGVyLT5yZXNldF90YXNrKSByYWNlcyB3aXRoIHRoZQ0K
PiBpZ2Jfb3BlbigpIHBhdGg6IHRoZSByZXNldCB0YXNrIG1heSBydW4gd2hpbGUgdGhlIGRldmlj
ZSBpcyBiZWluZw0KPiBicm91Z2h0IGJhY2sgdXAsIG9yIGltbWVkaWF0ZWx5IGFmdGVyLCBjYXVz
aW5nIHVuZXhwZWN0ZWQgcmluZw0KPiByZWluaXRpYWxpc2F0aW9uIGFuZCByZWdpc3RlciB3cml0
ZXMuDQo+IA0KPiBGaXggdGhpcyBieSBjaGVja2luZyBfX0lHQl9ET1dOIGF0IHRoZSB0b3Agb2Yg
aWdiX3R4X3RpbWVvdXQoKS4gQQ0KPiByZXNldCBpcyB1bm5lY2Vzc2FyeSBiZWNhdXNlIHRoZSBk
ZXZpY2Ugd2lsbCBiZSBmdWxseSByZWluaXRpYWxpc2VkIGJ5DQo+IHRoZSBzdWJzZXF1ZW50IGln
Yl9vcGVuKCkuDQo+IA0KPiBGaXhlczogOWNiYzk0OGI1YTIwICgiaWdiOiBhZGQgWERQIHN1cHBv
cnQiKQ0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBBbGV4
IER2b3JldHNreSA8YWR2b3JldHNreUBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
ZXRoZXJuZXQvaW50ZWwvaWdiL2lnYl9tYWluLmMgfCA0ICsrKysNCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiBiL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2ln
Yi9pZ2JfbWFpbi5jDQo+IGluZGV4IDIyM2ExMGNhZTRhOS4uZGRiN2NlOWU5N2JmIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiArKysg
Yi9kcml2ZXJzL25ldC9ldGhlcm5ldC9pbnRlbC9pZ2IvaWdiX21haW4uYw0KPiBAQCAtNjY1MSw2
ICs2NjUxLDEwIEBAIHN0YXRpYyB2b2lkIGlnYl90eF90aW1lb3V0KHN0cnVjdCBuZXRfZGV2aWNl
DQo+ICpuZXRkZXYsIHVuc2lnbmVkIGludCBfX2Fsd2F5c191bnVzDQo+ICAJc3RydWN0IGlnYl9h
ZGFwdGVyICphZGFwdGVyID0gbmV0ZGV2X3ByaXYobmV0ZGV2KTsNCj4gIAlzdHJ1Y3QgZTEwMDBf
aHcgKmh3ID0gJmFkYXB0ZXItPmh3Ow0KPiANCj4gKwkvKiBJZ25vcmUgdGltZW91dCBpZiB0aGUg
YWRhcHRlciBpcyBnb2luZyBkb3duLiAqLw0KPiArCWlmICh0ZXN0X2JpdChfX0lHQl9ET1dOLCAm
YWRhcHRlci0+c3RhdGUpKQ0KPiArCQlyZXR1cm47DQo+ICsNCj4gIAkvKiBEbyB0aGUgcmVzZXQg
b3V0c2lkZSBvZiBpbnRlcnJ1cHQgY29udGV4dCAqLw0KPiAgCWFkYXB0ZXItPnR4X3RpbWVvdXRf
Y291bnQrKzsNCj4gDQo+IC0tDQo+IDIuNTEuMA0KDQpSZXZpZXdlZC1ieTogQWxla3NhbmRyIExv
a3Rpb25vdiA8YWxla3NhbmRyLmxva3Rpb25vdkBpbnRlbC5jb20+DQo=

