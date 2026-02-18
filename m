Return-Path: <stable+bounces-217305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Mw58JtnilWmrVwIAu9opvQ
	(envelope-from <stable+bounces-217305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:03:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B98157953
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 17:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65CA93017009
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 16:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDD63446A0;
	Wed, 18 Feb 2026 16:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j96dR2Gw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="U21bVI0b"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970134321B;
	Wed, 18 Feb 2026 16:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771430604; cv=fail; b=bUW8SOqxNpiDnFrLtIAhux1bY7TuG0oDx+pBzIs3Vlk/be5Q/Z6/TjiRLdZQEfKi3pwHZ2ubL0naPCZAunlMSWm4hDIWdrd2I/OHNK7JgbA+bVXZtUcxzNSrN4ff+7+EKd6vZeEGHldBNOFEceDsIXg4se6Br3MB4M6zsFj/tso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771430604; c=relaxed/simple;
	bh=QJQoGL0gsJu/FGdp0xQ3c5blZU/qHJt+n+Xnn6Cc0DM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ckIgyfexchCrreBHG3SESxdUTxx6UZDKN7EGTdl2UuC2nWrKqNw8bT25q8/7+5Ui2fb4vWFZRUxveue8vLgf4sgPhw1AK/8mPImU4681gmSJhmWZagKVTWgt58HngrfMGvNOyIMuy70R/enaN8hbWvES1NsD4DuVXNfBK6iXM+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j96dR2Gw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=U21bVI0b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61I6ADEZ389934;
	Wed, 18 Feb 2026 16:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=J52fym7qgIwd0cswg1
	TyM5WWSdBk0i98k/NuIfl85co=; b=j96dR2Gwj0MGsfCxiJx6UlwD/IU3iCpmrT
	Kl6ZWd3o9UFnISO0R37tNv1R80hx5yoqG7d4mjkSOMT3sa8MicLNF60gD/CJDN+k
	0DI7huiX/EogoQr1zZ3KAbb5GsbVXtkbrRDvrOfHcknXokJKM1yJwiwgEjGBrMiR
	4n6Y2q+iy646R/oANcM6MxoxvoHj3qb62cE9x3ledPZgMKfBQ9yz48nDZkmcgvu1
	64A/vwyDpJoPVKYJ6O4b7cFi6h3ls+MUxnztM7nCtRLi2fn2jfQ8J3bGvcR13NdF
	gAJC3CAPbYN3XrcIP7o/WptZoaEcFFDsqav4dFAzNTbCjee3w4Aw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4caj4awqeq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 16:03:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61IE1AKD033197;
	Wed, 18 Feb 2026 16:03:02 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4ccb218ma9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Feb 2026 16:03:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DK05/r/RtMmwqEY+ymfInY3iBrv1jfWmYqM6e9Zn3YoQKxCJ8IVvfR3qsKc7T4vxO7JqwpTYzGy7aoroxsB+pPy38/x66K10CXk6+UYBpHd+oFk9ymgdSxrUDWdaK3P5jbI/E+3T3kWTW6B4pS30LTPbPWM8zw3xh7UToMd0L3GfWFdV9kp640bwlhTizuVwVKbRej4+FvgpVe/dadZ4llBecnlwXFXfDa0i1zYQdfo95eCWfQFHmJG8nU4yU8kgIxZ3a03HQGAaMp6YmwFAEnmbQducd8cq3KMxgsLTrzmyUVsv0I3krKXQpbZDbtpQChaqReR8Z7J5hsbcyW5+KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J52fym7qgIwd0cswg1TyM5WWSdBk0i98k/NuIfl85co=;
 b=PyEEE9Hg2OvO2ZlpmnVXTM2jwVJ3qhHBv2E0VVfjQT/oAaUxO221Us3D4z7KnAnckhf+kaxTXFZ1Y0rDVrltW6dP1cNrHWZs+6W8bDz//Pvt4JZPQTKxIjxgRPcScngFanFfHw9jCk4W9yKjak8HGYaj9Sbj7RsA2PQfuzGYvEFZo+vNqgc+tg0PyAeRUsO4gvGuKfpbJ/cuaLlZ1CZHPcPH9K63HqWs0bKcxG/J18VyolywBwgkNmLZTf9GBQs/BK9/TJi8hCDNF3lo9LW+finsIldsgIbnREou4ZZZmsNFSuofuscqnL2JoScTUMTdnIGj8AhWo8CwGLlk+4Jggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J52fym7qgIwd0cswg1TyM5WWSdBk0i98k/NuIfl85co=;
 b=U21bVI0bhm5Ci9hii3Dv5lJdgscikC2VlqixJO2YyEtHYVen5mTsNLoyBNy918ew6nMMQQ5hbjA/p8ZFNzT9P9tUHx+xqbNmmJl2cf/YeEJsH6Up5tVhhQWmOmXf5/vVrzUhIFuPJ/Z+0wtoyQ4+M+5gldynyYGKKhpwfJiBLyU=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA3PR10MB6998.namprd10.prod.outlook.com (2603:10b6:806:31c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Wed, 18 Feb
 2026 16:02:55 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::4b84:e58d:c708:c8ce%4]) with mapi id 15.20.9611.013; Wed, 18 Feb 2026
 16:02:55 +0000
Date: Wed, 18 Feb 2026 11:02:52 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>,
        Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <lossin@kernel.org>,
        Andreas Hindborg <a.hindborg@kernel.org>,
        Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/2] rust_binder: avoid reading the written value in
 offsets array
Message-ID: <rnvut3mevmhmqxjqe3v2dnlt2w3vxqbauyvgfgqaqeyqy5cx4i@m5bdotzx3mno>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Alice Ryhl <aliceryhl@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Carlos Llamas <cmllamas@google.com>, Jann Horn <jannh@google.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
	stable@vger.kernel.org
References: <20260218-binder-vma-check-v2-0-60f9d695a990@google.com>
 <20260218-binder-vma-check-v2-2-60f9d695a990@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218-binder-vma-check-v2-2-60f9d695a990@google.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YT3PR01CA0001.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::27) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA3PR10MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: 132b2bb6-aef1-407b-d99f-08de6f072d98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yg10GDQ/uYRojLrvIyLqQZCZCCmXs0WGXuZb4gMO/hqN9WB7B7LVZOBvX39Q?=
 =?us-ascii?Q?EUTKlB1myNk95edlRvKdHveZx1jNJHcXrNh/JqjEKBpmdlOF69hajMpVPr9n?=
 =?us-ascii?Q?gJWntza3eCIEvxEuIKva5PPAboLLae0efnaCM9DjRjDYiL+IS4+Bx0qITpXm?=
 =?us-ascii?Q?TxT+3izljTKHSPATnOWGN9zY8/FC1pNsC9XfgSvsR60h3eUvvUFqV6S9suBD?=
 =?us-ascii?Q?OSYat7bZ5MhqOsiU//Yp3fUwfGGoKgEOxHOOeO2wyHCWSJEb/ltgh1Mwf5sU?=
 =?us-ascii?Q?mZ/cKLI9/kJND9D9BZQHg9IbxS2YpM3mZJdRc6hAm5vsEnRroRXSiMtkDprX?=
 =?us-ascii?Q?UG7EjLrTJe5wBpHu8jZOElu1N+Otr5wAzE2O/Cj32+jwiUEGoS8LJBitPRIB?=
 =?us-ascii?Q?qDInXPcwm7GDoEEJogv8V0FEFokYMs5z2AfY59eA3Ut1bWoCVwocOIJT+LkP?=
 =?us-ascii?Q?AUi70cyZnr8ktCH8h8XfcYX7AEr05v8oCiLHAEDleZhUfeUKAxraa7SzPxAL?=
 =?us-ascii?Q?QDh8RBAx6wUmkhfDRp4Dx5QoB/V1BHpJyPPwCWpxUP70iLHaYDT/b12Vxkg5?=
 =?us-ascii?Q?4ur9+6VyzSmAcpU037P+A2M5Lq0shXF4/EiihYrtdEmDuNbFbD2UfNrKRs/M?=
 =?us-ascii?Q?vDkhJxHtx2Ad4sEtH/f9aeQszkHXTZ4AXZ19bcZYVux6U0YqyosixMURtXvt?=
 =?us-ascii?Q?VMNW6qaZKqj//5lB4zPwQih12y3ichGANxK4lyrXSCqQiDwTbEXMJH9ERz+b?=
 =?us-ascii?Q?aMvDxII9W/HrtS/4mKcqh3/qxWbdwW+qCqRIn5lrJy3grebWK9XTPl6M3ArH?=
 =?us-ascii?Q?Y8ZQ4k137Ij1IkkrQtKewdSCA/SBnKWzV1FEHzqH1R4NR/4dHX65fIeH665/?=
 =?us-ascii?Q?R7kCVRYn0f6XcgS0rLh+erL8CLafgvVdcntyJ9dZf6A0dISxoWuec6KJA1UV?=
 =?us-ascii?Q?hxXimcok1Em5XPL+JGvMjb2CjrLwnpXoQqkovjnsaIR4kFcMus4+W3flvXdE?=
 =?us-ascii?Q?wLNjGZvBkEDRQmqY8B6nuZsQQqDHJUZPYBVg4s5MFK1bgbXEDIZcoCchYmwV?=
 =?us-ascii?Q?1fVIUNW0JfaP4fo0w+UfMLqj/jqEE7bIm4dFghhVEumwUfWfad8tiqHZRfWg?=
 =?us-ascii?Q?vTEcvT8Kr8+HArfkrF1Z8XTnjzGiWhlvD3DYOmJJO4brRpPj0jowDh23kld2?=
 =?us-ascii?Q?E3qQga/zjiism+GPtrR7GA74ucQX4sS7pR709qhFbrwdlQOxRRZC8Typ+O3G?=
 =?us-ascii?Q?5Ff5bfHIyRWxydw5Q5f837t8tPSlVRBReO2zEHjVB7XzFjG3aDxgkgLUIENU?=
 =?us-ascii?Q?V6lhOHug/e7Dcr3p4mau8Da72KCymJzPw56b4bm+Or9uAa5tRIBW+FaKeChG?=
 =?us-ascii?Q?raU4PlW1UExjq1TV5K8XK68sulcOEE4WlF8hZyoEvFMep0r2TusZQS95LHA4?=
 =?us-ascii?Q?cxHuyJZdkyy/KryyzrN1R3KQxSbW+hpQGLDqjFYnfDBhLgOEPBwPRW39cGpW?=
 =?us-ascii?Q?4BICxBZdWwSjTOwZAtVKicpwV1SNAwjRFxHojy+t76I83ERdUux1oIIyW7AQ?=
 =?us-ascii?Q?T2a29m1FMKKur0t4J1w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ngTVEEccZzZCEczQHjjzPEFMmgBRCmrqL9rnh/cq0eU9NSVepO0q1vPUgPWx?=
 =?us-ascii?Q?n+/Ym2PYUD0qMslR19M7n+MWHy223Gh1TQww10pnUAiA4FTLoQi352z6fp/4?=
 =?us-ascii?Q?hIrq2t5KAnhscNU3nQ/zsXBDuqCjuhDkc9W1zkt8MSK1CdplC8Y9U1Nudy8a?=
 =?us-ascii?Q?QLSe6HZBBSk22uJ/9fYOYoFrmJw4Ps4D/gx7/YKR8EM4MEOetFGBBM3dulna?=
 =?us-ascii?Q?7yKi6v/AkxAvkIqSzuFBA+WOSmmAr4VKbTSVNy104n3Puiodr76v3OGpvoj0?=
 =?us-ascii?Q?vL/OyINbSQQ0LCZxc/1Wy6wZAOUf7D6wkZ+UB7psWmticW9128YkpzHPcvSf?=
 =?us-ascii?Q?M6BnN+FpyUyAr+ltKH02yJwmP9TBrKHOggQpJS6EfDsf0PdwKHrAvqB10DUk?=
 =?us-ascii?Q?VbZkovkbf7PBuWhKdckm0si2d+C9Gwo1LJ1CQVC8+6rbvV14A7CUGbVHg+oZ?=
 =?us-ascii?Q?Wje1/PM7XZCSjsExWq+Rkkk7nbnAyeUXcXnd4mo9z6wjZp4ouPlH/HrwelU7?=
 =?us-ascii?Q?8eXJw/deYKMA0pI16Malj7LZ3w/0uJA7yp+r0KS4wvGMjW3uC63UWi6PsV9b?=
 =?us-ascii?Q?ybtqFJkS4WQRnuRl/9BS3TE5n2I92LAMKQXXsOTDsOaj5Kj93Epsa6O8eowh?=
 =?us-ascii?Q?AWY9GDhwRJJl3zIHLGkILn428Eydv4uec/eMpTHlV/hNUHwzSoKTbURV5jX7?=
 =?us-ascii?Q?drmqQhi3bRJl21tdE8ZTkFyWQ4cB1jJreuoQ4uSAbKoKx+gFxwDmMY1WC50e?=
 =?us-ascii?Q?7XTtIvLgDvvLH82IYq36MHkPh5zkeW7vvju2ng0xkalyG3lAlheNmxyiU93u?=
 =?us-ascii?Q?Uc5waj/LdpAPxsFZRnPsaO0Iq5EH5EhB5FC3qloHrKxUR3CFhZbMZTzNDPHQ?=
 =?us-ascii?Q?LHI+KGVnNIoDP9bu5DwrOtYzh+EqOb2WxjyPmOAJUvGlE8sTzTwJXSRCqahU?=
 =?us-ascii?Q?uYT3/Gwa/w9o4/ByPwjSMtYk4HrxWgmfbYx97E9mP+OhPwkPb5fT94wHixTU?=
 =?us-ascii?Q?w1oYT5ryM32QqOYgWzB5SfFtpA7Zca7agYD1ep8m2U3SPT6kORd0ZeoaQZcJ?=
 =?us-ascii?Q?w25XfwAqTmj/xCJC+klEgB0KzPLqzah0Mle390I8ezwQmcf0ew/KAnConTK/?=
 =?us-ascii?Q?SS4smuVrgGVMIeaEavbaYghgdfGm5OyekrYbL3lw7zkVVb4BdlCNcBJShZmh?=
 =?us-ascii?Q?VYvuufmtmvYwUY59Xz+YkFppz+17ss6uf0Qcg+3O5c/ooX1svVOsVsj/76eC?=
 =?us-ascii?Q?ofJ+vDlIxmsvvkkoDmPtxR4XZepx5iGH/TbctLFguQtF+s8FfJD7RK+thaOh?=
 =?us-ascii?Q?vBpSZq5IHy0d9nH38r3Mw8h0yf/RGl+VwvXyFFFpBV1iT5ibOXaDuz7e7ZHU?=
 =?us-ascii?Q?VFNXRnf5WKDc9hpP946+SCfoI3fJ2F7ltFwlPi9BP0LjWs9sUTPI58DKcvAW?=
 =?us-ascii?Q?mhjHW3p+p+iqpznINHQ+a2AajFGSO+At/xGgK64tOV4pgtf0jfynLsnRHNQP?=
 =?us-ascii?Q?5uExopmhNVQuP1wlslqTtR9ukL89NOaR8tsqq5fdB/gGK/4vliq3fNBCXal4?=
 =?us-ascii?Q?qaThAXNWUp2hnwvuEOMc6n2N7A0VwmRe8aTYEsfoflgeg4JqBzBHihgSOcmz?=
 =?us-ascii?Q?+gqWokqK9dM7XJXAlrgUKhyiRtVla0it4nlIABFX/+QaTq8enooBhTR8Ebao?=
 =?us-ascii?Q?EvXv0C8/V6l4/Za+4eZUa0DcLaXYHClScZxaaYtpbig3JhXL0Da3g1C27O/m?=
 =?us-ascii?Q?2KJeRe7ekQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6vn0g/PHNEMJuHA+EK0/pzP//qLvU5PG+DacD8dNxJ3idVmzIirIqtLDsCyGxtpq43h0X+cKwBLDduzLJLIt9495dBkn6iAyrglmoxZJWysDLWCur+x0XIm1/tB/bPf/1CvEsBD9PB2bp/zUMvBAAkUG4q4U8xxMUJ8Zf600ju/TtW4dBC6NvDTu+1maErN3/dfNyy9bk7No9DGw0KsL9tpNU0wA8Ld01dEAt90tutY/iejHs+hPIwPZSMoFrsADPHWK5KrilRtVDpiFT/OA0ikGTgQOLMVQharBJLVZJKMq9hARgdyipU3v0MagqAfJAim6DcBdmlehLCbCfAcX1UeSVb6Te5vppJ1OSCNzG5J5D7CoKeYM1BXeUiOvP+8FGEbCfCe2ThaaNkpBsRJzIsNA8LHtRcQonFq5/a9Orsxet2XpeBEDQuMWz9h21SQrYgcK1Tjdz51GDkZk0JY5usnj294qHOXYel1nIHqi8DAyPx+wrjl18wt8zCq5jt2L3tnpJZgNrDpNg+609KsfJNTtfQ7GDP8MPNCm30tsFEpLAgn7EH605qakQmOs9gl54XRIxppUFZL4Aqoq5YPnW7XQprQJe0aP+qFsGzvobgk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 132b2bb6-aef1-407b-d99f-08de6f072d98
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2026 16:02:55.6183
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z+tfzYPG6UBPwGnvUx01KS0T7sKBYMaTtIv3ffPTzi4yxwOxOH65UhSkJhuCH6Rj+tDNz4QDOPfahRtwdloOSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB6998
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-18_03,2026-02-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602180136
X-Proofpoint-ORIG-GUID: sDnXmfnZSsY568w0ITJrXciDB2R9-cVI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE4MDEzNiBTYWx0ZWRfXxaAGPTL1dlIm
 cFTz9JMeU0ZaRCGCQCM0ILyDepQCPUkw8eg6MqbKIseIitGU6idlgQMAfp3ZmBlkkDSqlJBrsGh
 w9a2Azf6D/WAYcMEB9O5kbLersIaJepN3CRey3f9hAVxRebxKvffWc6tzlK10jn2zovfLq7H2Ut
 6vmK6WBZMXBJDAER0MXNVoy0Bu3nitB4rBeqEIgKGvMDOxF4RSvFAIP5tQBHq9W8TSbIgnEV3JX
 lGZF7oZ0QQQ3RMwpmMBmzHwT+j7ORoQABNLWRQuhg7+OYQ7ffk/X44WBg5uYaTqCThe7ZLfWhNS
 cPPKSte9eoqZqXsj677FDHXYd3THOa4PityrzV/4odHNkyCGwiiXPAEiiAE+LHl1yeCvdWtrtLY
 gpceqJuU089/eGmW2gDpDkV3WMXo0dCqMoT1jTfAzURa9i3r8u0Xoe9mKnWGHL38WhCqcKHXeuG
 coFvg1oG90SxtedXRWQ==
X-Authority-Analysis: v=2.4 cv=SI9PlevH c=1 sm=1 tr=0 ts=6995e2b7 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=FbM60VECCFYQrZsb3VcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: sDnXmfnZSsY568w0ITJrXciDB2R9-cVI
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[oracle.com,reject];
	R_DKIM_ALLOW(-0.20)[oracle.com:s=corp-2025-04-25,oracle.onmicrosoft.com:s=selector2-oracle-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217305-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.onmicrosoft.com:dkim];
	DKIM_TRACE(0.00)[oracle.com:+,oracle.onmicrosoft.com:+];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Liam.Howlett@oracle.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,google.com,kernel.org,garyguo.net,protonmail.com,umich.edu,oracle.com,vger.kernel.org,kvack.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: A8B98157953
X-Rspamd-Action: no action

* Alice Ryhl <aliceryhl@google.com> [260218 06:53]:
> When sending a transaction, its offsets array is first copied into the
> target proc's vma, and then the values are read back from there. This is
> normally fine because the vma is a read-only mapping, so the target
> process cannot change the value under us.
> 
> However, if the target process somehow gains the ability to write to its
> own vma, it could change the offset before it's read back, causing the
> kernel to misinterpret what the sender meant. If the sender happens to
> send a payload with a specific shape, this could in the worst case lead
> to the receiver being able to privilege escalate into the sender.
> 
> The intent is that gaining the ability to change the read-only vma of
> your own process should not be exploitable, so remove this TOCTOU read
> even though it's unexploitable without another Binder bug.
> 
> Cc: stable@vger.kernel.org
> Fixes: eafedbc7c050 ("rust_binder: add Rust Binder driver")
> Reported-by: Jann Horn <jannh@google.com>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Acked-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  drivers/android/binder/thread.rs | 17 ++++++-----------
>  1 file changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/android/binder/thread.rs b/drivers/android/binder/thread.rs
> index 1f1709a6a77abc1c865cc9387e7ba7493448c71d..a81910f4cedf9bf485bf1cf954b95aee6c122cfd 100644
> --- a/drivers/android/binder/thread.rs
> +++ b/drivers/android/binder/thread.rs
> @@ -1016,12 +1016,9 @@ pub(crate) fn copy_transaction_data(
>  
>          // Copy offsets if there are any.
>          if offsets_size > 0 {
> -            {
> -                let mut reader =
> -                    UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
> -                        .reader();
> -                alloc.copy_into(&mut reader, aligned_data_size, offsets_size)?;
> -            }
> +            let mut offsets_reader =
> +                UserSlice::new(UserPtr::from_addr(trd_data_ptr.offsets as _), offsets_size)
> +                    .reader();
>  
>              let offsets_start = aligned_data_size;
>              let offsets_end = aligned_data_size + offsets_size;
> @@ -1042,11 +1039,9 @@ pub(crate) fn copy_transaction_data(
>                  .step_by(size_of::<u64>())
>                  .enumerate()
>              {
> -                let offset: usize = view
> -                    .alloc
> -                    .read::<u64>(index_offset)?
> -                    .try_into()
> -                    .map_err(|_| EINVAL)?;
> +                let offset = offsets_reader.read::<u64>()?;
> +                view.alloc.write(index_offset, &offset)?;
> +                let offset: usize = offset.try_into().map_err(|_| EINVAL)?;
>  
>                  if offset < end_of_previous_object || !is_aligned(offset, size_of::<u32>()) {
>                      pr_warn!("Got transaction with invalid offset.");
> 
> -- 
> 2.53.0.310.g728cabbaf7-goog
> 

