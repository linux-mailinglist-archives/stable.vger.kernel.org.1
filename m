Return-Path: <stable+bounces-220004-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DIkEWf1oWkwxgQAu9opvQ
	(envelope-from <stable+bounces-220004-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:49:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06DCB1BD15B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40E2B3168CF5
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E145046AEEC;
	Fri, 27 Feb 2026 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bwqGOc0o"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E17447887D;
	Fri, 27 Feb 2026 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.156.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221424; cv=fail; b=snB8f57fLR0r7XUPpM89Kzwe/PWknRDexlqO0qgYq2Ex6dqPTCM0muKBugUMqwJZMJQapc8l0BRmJxLY7DwwY5nzM1xlBNl4OSdabhbm+bg1tebXxo1OC6Y2ja1MpZ5itzHcd+J2N/1v1KOKCivDIvSkb6ENdv36xA+jOSsfI8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221424; c=relaxed/simple;
	bh=OT4tcuqwIymJmlk3oo/pK5vQy6qs1ts0bS2QoWpOxSw=;
	h=From:To:CC:Date:Message-ID:References:In-Reply-To:Content-Type:
	 MIME-Version:Subject; b=SmVgut7oGOLjNL1yoNT1XoWdJgIkTwOitk6Hu3tPftS/yfh5NUBPjHY9D4T505A82JS02ACeVynjtyiaagzMRECMHd/d9B9xZ+XnvhgLD9l32EVv2KvKYDBfYccPDfvx3kxVN94jUg3t6ksNz3dF2CY7FWe0P70HsZTKFLypVxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com; spf=pass smtp.mailfrom=ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bwqGOc0o; arc=fail smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61RHkkUY3039381;
	Fri, 27 Feb 2026 19:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pp1; bh=OT4tcuqwIymJmlk3oo/pK5vQy6qs1ts0bS2QoWpOxSw=; b=bwqGOc0o
	GbCYfT9uQnUcGMRrz8ZdtU/t2pvsiRhHrTHhbSukca3yPS5h+g90/1DdEPQxSwgF
	i2On8/tayscJKQtkU5Ly4jkjD0rIqongeRMls7FyeQumnUuOQQKDa3rAD04CYn09
	VWHj1/VVE+5wjYrto+Lk/At1DTY+qrSlsU5ILq+jbTKNFilVdZOVRvn5om5B10J8
	h2cyabqcNmKQMb5tRQzhPmrPc7UeBifKtpe5wj6aBqBPRzWidXHNqHJSvy2XQxcp
	n+N9yb1N6Ncas1gvKl+m/VeqcMCU/UgaHgCcWXTAq8PHdGwjoSxqlyxaRWfGmu28
	rMoPGhNlDILmzw==
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011033.outbound.protection.outlook.com [40.107.208.33])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cf4crea48-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Feb 2026 19:43:35 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzMvU25VAiCZovpsyRy5wCF8FicoFQXLcdVEQN/cYkG98Xd3+ECCMuZX21whdulKmx3fjDbDavLeU3M7ZXDalxfhgY2Z8GL+k3XQBIBVzIrhKLnMBs+GwgdsDZcQrZLgEQMVsyIY58WUIUYQ9Efm13eBU0iG29m31nwWXqTK0mo2seq+Cpn9BQEGzQrsrT7nEHo+67RroiR12YE1kOi/Z6YkyZGIjzOEog8EWnV7WHEjx5adB+8SUGAAuwYMH6lyz5aofBGE7GtHVDlHq/phsG3YFwroGbz3eyUJbx/hlSneUoTjLAfAqdCZ0kbU8NN7xrwsheKBd104ND11ns6V4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OT4tcuqwIymJmlk3oo/pK5vQy6qs1ts0bS2QoWpOxSw=;
 b=Me5W6nYdyt7pJZRyw9F7k1L7umrFlr3hPi+UA/NZ0KC9QUtL7PWqLt0z9B4RpwZ45h6JGy0oCENha2sxtDU/gQp5Yn8S5wxB2YFhm70UOS8GAqV9BTTPBrtm5vTqj9DY0qOPXA0Cz5rfC7fjW1EitVo7SKa0s0YE0OoDViZKVToqrZXHZsa7iJ+/adp+D+Ewv9PRZyr/GCU2kr4oR9mGS0cpK2CZ0cklUJZDjjDT3eLRelVPp+HHdtv+2kShyfTnNrvCIFeMvCKlsdmQvFjqRo9hAqgLAQJ/YxktlCWOIPjkQtW0HqPXx7388S4Q/SC5SSEYoEGeCF8wdk5oytPpPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ibm.com; dmarc=pass action=none header.from=ibm.com; dkim=pass
 header.d=ibm.com; arc=none
Received: from SA1PR15MB5819.namprd15.prod.outlook.com (2603:10b6:806:338::8)
 by CH3PR15MB5772.namprd15.prod.outlook.com (2603:10b6:610:127::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 19:43:32 +0000
Received: from SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539]) by SA1PR15MB5819.namprd15.prod.outlook.com
 ([fe80::920c:d2ba:5432:b539%7]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 19:43:32 +0000
From: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
To: "hristo@venev.name" <hristo@venev.name>
CC: Alex Markuze <amarkuze@redhat.com>,
        "ceph-devel@vger.kernel.org"
	<ceph-devel@vger.kernel.org>,
        "idryomov@gmail.com" <idryomov@gmail.com>,
        "slava@dubeyko.com" <slava@dubeyko.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Thread-Topic: [EXTERNAL] RE:  [PATCH] ceph: Do not skip the first folio of the
 next object in writeback
Thread-Index:
 AQHcppgDS668W704B0iRyTKXxOujMrWT6I8AgAF3MwCAAAMxgIAAA36AgAAD5gCAAAN4gIABfyQAgAAIkIA=
Date: Fri, 27 Feb 2026 19:43:32 +0000
Message-ID: <fc5419280ed72a5088a28f86217003385b3b78a8.camel@ibm.com>
References: <20260225170758.2014172-1-hristo@venev.name>
									 <50447e5d0d4e3bf993d05dc9da9dde1c20371378.camel@ibm.com>
								 <4c074e71fd58851a84596c4798b9378a3006d551.camel@venev.name>
							 <1d321c24a2c4045e8bd79922a94fb4264a40f7de.camel@ibm.com>
						 <daf3f64ab55d5c6e6c4bf612db609e5505795d05.camel@ibm.com>
					 <b7c3c502da0d135fe1d57014f9f1074f8a2d4ceb.camel@venev.name>
				 <c1c033c44edf8d20b0a9dd8944a2f21bec942c1e.camel@ibm.com>
			 <e714d8106a492077707cd31df96401a08caef6fe.camel@venev.name>
		 <0c8d905c386f5f9ca2632307802ada7423c82c2a.camel@ibm.com>
	 <c4276585d30375876dfbdc4a538359addec5f1c3.camel@ibm.com>
In-Reply-To: <c4276585d30375876dfbdc4a538359addec5f1c3.camel@ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR15MB5819:EE_|CH3PR15MB5772:EE_
x-ms-office365-filtering-correlation-id: f16ec498-071e-405e-bda3-08de76387d3e
x-ld-processed: fcf67057-50c9-4ad4-98f3-ffca64add9e9,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info:
 JatPRICjVhwRpOMOvYtgCVpxix1Cp1NbxPVSkIwc1K5tIuGIgn67tdLgMrhqhT9io7Ja+qore/djvpFgzpAGmOBdC6m1JuTBdV18rEfrOj1l1n81Qux5sVPc6G4oVnA5qkojBihMwYY184kRYTUNPJHQ1Na0YvB+bJuMZJtJut8tup5c0Ipsj6Pg+e6c1vlt3VeRKDcrJo/XJPFHRJ5HTepcdIhSt3YbYFeAbeEQeHMTdIj/iciZNrwH7QHnRNM1YRRee4VZJOT41baZpHLYHlTZ1dWLzP49gPwJdpsBDxUhm2bbVzBdGrWMQfmRaysbUOwOVCLOUMLomhdSTlK3Pf4HyqIlG3f/VPUtIXnSMI9wr0MWAJc7juUmqokVKAOWJM6nOHeNBaJme2CNCP/jBn/G73WsspSwvnJycjrkYTkGWQTohjMWiHlDCmHUsXd76IRTXl13R9jRINhWZY8ywNOSsuBnAVIea4h+wYgLvZnf5RNUQKia7GVTZhKu3J/FZz7X+lNaWlC8AW7WtZuQb9YQbN2fel+zAca8om2ocxdQwG9JU3zRceVJCOtwDdsrOxBywtXdR8quLOJKTffIYeqCwpkpaXcwYkviJvOzbcphF0VoxhTCQaGjevrkftQ8UWeLuvyO3u2H99kN1T7Sv5LJ4T0Pj2dFyd7dpQ+WWU8p2EOc/tuiUvNS7tgwnPV7UKWWd5H4Di98acUnQdpJmmetlZasbt61Cx/0jjBsatFbUPffl1x9BSe6gxoK8sob
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5819.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YTdBMTRVcjNUbjFka1drTjFyTFluK2FwanNpVFQ1WnNKS0ZBeGp5UWx6di9q?=
 =?utf-8?B?SGc4REllc2JvU3lmUG5MZ0swRjBHSXJNb3NBV2t6d0NDUDMzcXRObzgwVW1y?=
 =?utf-8?B?TWNLOUk3V2YvRWFYVWxVRWhjdlNOSDdHNGV4a1JqR252MW03a1BERVB4enVo?=
 =?utf-8?B?Y2FqUGhrd3kwcUFGTjdIWlJ5eTBXQk9mS1dsWk1JUE5NSlFyRnNSUm9pUWRX?=
 =?utf-8?B?Z1QraGU5bFAwYUIyeWpDaVNoc1EwcEpMN0VVZFNqKy9qQUFVcTU4cE44VXRP?=
 =?utf-8?B?UVpYalVKSGlQL1oyU0tMS2RTS1ZKV3FXQzlTQnVHWSs1RkhEVnpHMUgwNDly?=
 =?utf-8?B?aDQzRlJnS2Nhb1RUcm9wUkdSamE4eXJkRFJGQzlIeE1BMmFSTGhpcWpmaXN3?=
 =?utf-8?B?cExGbHhjN1k3NmVjTXgydklCcGxCakxIUEZ6WitlZkw3NW1hWkVqVEpuWG1H?=
 =?utf-8?B?KzVEUUoyRFpzNmxqS1crY0dCTFA0M3VHT2JyY0QvbFcrandHRUxzWUVxc2xi?=
 =?utf-8?B?ZVhXV3Q5UFZOallpa05tNFVwdFRsS25EZGlOYm9RNkR1dmdaRmY2NkNqV2Uv?=
 =?utf-8?B?ZjNCQWpTUTZqZ0FXZHZ4Qy9MNi9oYUI0bUtzaGZ5Tkp3UnFyN2tRMUJ0bCto?=
 =?utf-8?B?U2dxdzBFQUxZb29hSWMxRXVGbU1lbUJueWlBRVJQRXVFL1dSVzFrbHZpUmF0?=
 =?utf-8?B?Zk00MkZTcG5oMVd5bHROeWdWWUk1ZTJhYUtBeTIwNHVKZ2xGMHBqdHNNM0tm?=
 =?utf-8?B?YmRFWHBEbERaSzJuVWw5NCtkMjZDK2ozZzFhKys4N1dWRGUzN09jKzA5bU5z?=
 =?utf-8?B?YzRQOVFtWk9tSzRhRFppTmkrNFdsc3pIZVJVR0xPTTdCTGZkYklUSWpLSndD?=
 =?utf-8?B?NDc1aVVXRGRKaWdYakpqQ3JlVmREdElXWklCbHlia2tuc0pPSTk2UlB2M05q?=
 =?utf-8?B?ZHJuL1dNSS9RWFIrUUZGcjVueUZFaWR4QWFNRjRTdEpBYkZEMEtkR0svOFl2?=
 =?utf-8?B?VXpiR2p3SU5nVExveFVnOXJnbFp0ZHZ1NjhrREx6RWZQV2F5eERKbmdoTXlF?=
 =?utf-8?B?Y0U0Zk5PWTkzYkx5WFB6Tk1IM1VKTTNpMXFDQWJHK0Zqbi83REV3Zmtaa3hp?=
 =?utf-8?B?K1p6YXJReGViaXN5Z2krWUJIQXk3WTRXdWYxUHJGeDJXaWs4djdmYVQ0cVhU?=
 =?utf-8?B?eDlhM3djTW9CdGl6NDc3OENPdzZxcDRnanZGRURkQ2RHNTRXM20xKzJ2QTRp?=
 =?utf-8?B?V2RLTW9YemV1dkswUlhYbzBLUUVDL3AxWllSOVJ0aXFEOGhTY3FCUzJ2ZlEr?=
 =?utf-8?B?Z09oRnRQWEUwWW0xTVZ0MER1WTQ3cktmbGJ5UFlndEdKdEo2d1hjaWFYVmd6?=
 =?utf-8?B?VHZpTVRyQUtRRGg0RjQ2VnJQeTNmMHdnbXg2SGZidW9PaHN6VEVuWjB1RVVo?=
 =?utf-8?B?WFFqNHdXUmtCc0h6dXJPZTM4N1RlaGNJQzlVdThFeWI3bklzb3hkQlhCc25R?=
 =?utf-8?B?YVUvNEh2Uzd2YUhIbmxjaTEwZ3dxbVlsTHN6WDZTdUNpcWlHM05INUVNdEpi?=
 =?utf-8?B?STVKdWFKeS9vNkpqcW15dm81TWt4Ni9zZVJVcHVKeUVSWDR4OG8yZnlRaGQ1?=
 =?utf-8?B?YWhGL1VjTUczMnBPZFNSRU85SnExVkp0d0U2TUFyVm1DYlVYM0UycXkwaE1p?=
 =?utf-8?B?eVFyYWZkWi9jSzFCdThnS2ZtOTg0akJUeW5SeXl5Vy91V0lJVVVXUWN2bDdz?=
 =?utf-8?B?dCs4Z2VtbzlDUXlUcjViOG83MzBVSWhrVkhGOUhrZXlTODhNWWdDd1hyRG9m?=
 =?utf-8?B?MXB2eTFlZC80T0U3dGtNa05sb2VTK3VYTy81ZXNwbHYwbEtyVndpSWIrbVpt?=
 =?utf-8?B?aUpGYVd3SWNXU0xHSjNLM2hLa2VMa1NHNjJzU3NmajdqT2ZSSUVyb0N3N1RU?=
 =?utf-8?B?QlVkdjZNSU52NUFvVGFQQmQ2a1UveVFjTDJNY3grd09WTnVyN1RDbXd3OXc0?=
 =?utf-8?B?bmpLSnp0K1ZYdVVkM004bm55dnlKSU9XakRmY1o5MS9YaURFZ05hYVFjY2Fv?=
 =?utf-8?B?NE85cmFPemZXVy9GYWVBWEFGMFVNRWFrUGFlL1pad1A3c2ZocGp6UnprL3Qz?=
 =?utf-8?B?YnVkaE9LamhwNlpjZktlTS9NQ0txc2N2UjVqbGpVb1FOS3lFQ1kvekxiNWJX?=
 =?utf-8?B?MVBkSmtQZVRDSm55Sy8vMzlwZ001MGlmaWlkRjVYcGpxNTZMZFFDRmM2L0xu?=
 =?utf-8?B?bGRuR2thYkVORmNjR1NSQjBKbkRSZjNMNHVZNmtDODJEUXpVbk45Y1lPN3hV?=
 =?utf-8?B?QUtDdUlvc0hTdXU1Q0RUZ2FKalRZUzdXRWdOaU0ybU0wcDFhRFg1YUs3cVU1?=
 =?utf-8?Q?0WOFE+rVDYzINoPa08hmOHn4MrsA0XFqLU9kv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8AE845CC0CE85C408CFCB59985D05E2D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5819.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16ec498-071e-405e-bda3-08de76387d3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 19:43:32.4267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eOKUxp0iB6jizYlrmGRMRfwO5K5TsGuJx3lNPlbAPya6u9ofuxLUIgpIqihUhrKPBGah4CBPhQ+KUy2km2eGRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR15MB5772
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: fVZ5c6-7QjDpRzxnidmbhGs4GI_RmHYK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDE3MiBTYWx0ZWRfX6Kejjr4YDdUJ
 Bb4QR09f7tDxgGgFqLm0vDglHatDA8MZ59gdhsoPw6iykQorEcWDchIBQhjfAndn2NAHwP+gj8a
 /iAvlaFGRjHLRUOWwlCacnjpx8n63ObrAKtwLjspX4JOFCK6hK0L+8BUQPtIKGnBPIm97d2Posp
 4STLyeqoBjSjVgUuj3C6ftHW6HExtAp3gbGwRZ83gPPjV817DwPRj618N+evg3pirvld36rhym/
 S/rtW58bhhEcVRSvTK1qXioTufscGVtMzuMqQo6ITQC6u7xvgrQL+opE+Tsx65BRJ7vew0Kpwww
 CGgIdxCt0a1gkerqOI3rQF83dM5Khg7TGX85q9c4SAYUzejbyfHSqzjXKLgd6eJwDwbhPyEFS7W
 mFmW7x7QQMIbwj+UWfMHSamRt1Tgd92sAr3rCunicPVGy/zptFJll0LBtBjBSOqbWoUur0j5gCD
 5eE7m+PXEwxss1NxIBA==
X-Proofpoint-GUID: n2Kse6dMxWv4Ezv1dTmn8BRewN4xUYAq
X-Authority-Analysis: v=2.4 cv=bbBmkePB c=1 sm=1 tr=0 ts=69a1f3e7 cx=c_pps
 a=GRGg88i0IYp+MSRJKvRoYg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=GVT9W4Wiak6UpZ1B:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=NEAV23lmAAAA:8
 a=VnNF1IyMAAAA:8 a=ZoXreq4flXyaE3h1zoEA:9 a=QEXdDO2ut3YA:10
Subject: RE:  [PATCH] ceph: Do not skip the first folio of the next object in
 writeback
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_04,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602270172
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,reject];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220004-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,dubeyko.com];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Slava.Dubeyko@ibm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 06DCB1BD15B
X-Rspamd-Action: no action

T24gRnJpLCAyMDI2LTAyLTI3IGF0IDE5OjEyICswMDAwLCBWaWFjaGVzbGF2IER1YmV5a28gd3Jv
dGU6DQo+IA0KDQo8c2tpcHBlZD4NCj4gPiANCg0KPiANCj4gVGhlIHhmc3Rlc3RzIHJ1biB3YXMg
c3VjY2Vzc2Z1bCBvbiB2Ny4wLXJjMSB3aXRoIGFwcGxpZWQgcGF0Y2guIEkgZGlkbid0IGZvdW5k
DQo+IGFueSBuZXcgaXNzdWVzLiBTbywgdGhlIHBhdGNoIGhhc24ndCBpbnRyb2R1Y2VkIGFueSBy
ZWdyZXNzaW9uLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFZpYWNoZXNsYXYgRHViZXlrbyA8U2xhdmEu
RHViZXlrb0BpYm0uY29tPg0KPiANCg0KQXBwbGllZCBvbiB0ZXN0aW5nIGJyYW5jaCBbMV0uDQoN
ClRoYW5rcywNClNsYXZhLg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2NlcGgvY2VwaC1jbGll
bnQvdHJlZS90ZXN0aW5nDQoNCg==

