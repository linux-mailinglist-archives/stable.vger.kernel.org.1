Return-Path: <stable+bounces-110285-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69921A1A5A6
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 15:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D5993A142F
	for <lists+stable@lfdr.de>; Thu, 23 Jan 2025 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F9120F96B;
	Thu, 23 Jan 2025 14:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="ReEqu/Hv"
X-Original-To: stable@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F52013212A
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 14:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=173.37.142.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737642039; cv=fail; b=Iis3kG1VT+UKhNYyAHPMzkElormsHiqxXG6kpvCz4e9GC6xw/Zj08daQFnIMHirhgV+AEhvvPkOGIXdWJI0lOlcFWPe2N5xwC9NDXh0ZqIznR242KUeWIxcjzmyAdEQlzpj6t4Jt7xMorVLCU6RNwUkksFqGiQQ6vLMYPkx15bk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737642039; c=relaxed/simple;
	bh=oGPAt5yOIsZfCdaLDGkRiaI/ViRk5qhCxWPxKQuzZSc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kx4t/wUDbtWacT+a0+nkjeXalLG4brhINZFMSD+xogDUgy2p5a8fWIPgL3snHWeoUuOI1Lkt9qGviI9rCajQfysqr8ehdzlUN29TQFQlcgG+SPbSLWyaBlWC11oIRnpt6bF1BNvd/MxswMGlGC63gHekpxeN3cTt4koOfCeAla4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=ReEqu/Hv; arc=fail smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=422; q=dns/txt; s=iport;
  t=1737642037; x=1738851637;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S7mVfY+a5f29XdZIwmJrStwC3UnDQRYoUSaEJAYWrXo=;
  b=ReEqu/Hvbx1H+UpPRSqDuxgrk95wO2Lin8BiaMJ27wPwLPprFJvr7e6G
   Vbr+DIxkGFoTHVCdltVA87XspG1PWznYV4Jo4WNW/Pt4j9/trr4D+0W10
   HQu82mJUZ3NHXGVSr11He/2w+6N7LsVlMAVyFUa2RVExWMHONwn8D4Mnk
   8=;
X-CSE-ConnectionGUID: pg5x7fF6Q5y+zlu3/p1rtA==
X-CSE-MsgGUID: 60zxgOFpScmJsXNXroHjIQ==
X-IPAS-Result: =?us-ascii?q?A0AUAACRTpJnj4v/Ja1aHQEBAQEJARIBBQUBQCWBGggBC?=
 =?us-ascii?q?wGBcVKCBxKIaQOETl+IdoV6jFUchVCFXYF+DwEBAQ0CRAQBAYUHAopzAiY0C?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFAQEBAgEHBRQBAQEBAQE5BQ47h?=
 =?us-ascii?q?giGWwEBAQMSKD8QAgEIGB4FCxAhJQIEDieCX4JlAwGqdQGBQAKKK3iBNIEB4?=
 =?us-ascii?q?CAYgTABiE0BimInG4FJRIQ/PoRDhiIiBIIvgXSDQKAJUnscA1ksAUsKNQw5c?=
 =?us-ascii?q?EgDgTcPgRcFNXuCDYEyOgINAoJAcB+ETII9hEWDO4EWgWeDdIIUgWgDAxYRg?=
 =?us-ascii?q?yd5H4ECHUADeD0UIxQbBqFdgS4UgiuWdLAACoQboiaDXqZiLodbCY9xeakDA?=
 =?us-ascii?q?gQCBAUCDwEBBoFnOoFbcBWDI1EZD446H8Q2gTQCBwsBAQMJkV8BAQ?=
IronPort-PHdr: A9a23:FXf1tBJL4WZASFIhXNmcuVQyDhhOgF28FgcR7pxijKpBbeH5uZ/jJ
 0fYo/5qiQyBUYba7qdcgvHN++D7WGMG6Iqcqn1KbpFWVhEEhMlX1wwtCcKIEwv6edbhbjcxG
 4JJU1oNwg==
IronPort-Data: A9a23:AJ1XlKJzZOEaNAh2FE+R0ZUlxSXFcZb7ZxGr2PjKsXjdYENSgTMCy
 mYZDz/XO/mCNGD1L412bdi+90wOscLRy9dgGVAd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCea/kr1WlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVrW0
 T/Oi5eHYgL9gmQvajl8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN12AxwmYoM2pN8qECJc8
 eFDbyhUdAyq0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBV7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2N0Wojx5nYj/7DLoyleGpi33gehVTqUmeouw85G27IAlZjOG9boCPIYXRLSlTthjAt
 HLJ2ErhORofFsev7wqf9VKup9aayEsXX6pJSeXnraQ16LGJ/UQIFBQcUVaTv/a0kAi9VshZJ
 khS/TAhxZXe72SxRdX7Ghn9q3mes1tEAZxbEvYx70eGza+8Dxul6nYsVjEceIMompEPGC1px
 FuUxJTxXCZzmejAIZ6CzYu8oTS3MCkTCGYNYy4YUAcIi+UPRqlt1Hojqf49S8aIYs3JJN3m/
 9ydQMEDa1QvYSwjivvTEbPv2mPESn31ougdvVi/soWNtVMRWWJdT9b0gWU3FN4ZRGpjcnGPv
 WIfh++V5/0UAJeGmUSlGbpWQ+33vKrebm2A3zaD+qXNERzwqxZPmqgNsVlDyLtBa5hslcLBO
 RWK4F0NtPe/wlPwPPEoOupd9PjGPYC7SIy6DaqLBja/SpNwbwSAtDp/flKd2nulkU4n18kC1
 WSzL66R4YIhIf0/llKeHr5FuZdyn3xW7T2IH/jTkU/4uYdykVbJEt/pxnPSNbhhtMtpYWz9r
 75iCid940sEC7WlOXGMoeb+7zkidBAGOHw/kOQOHsarKQt9E2ZnAPjUqY7NsaQ890iJvo8kJ
 k2AZ3I=
IronPort-HdrOrdr: A9a23:f96Icq51gNI0Bj3erAPXwbSCI+orL9Y04lQ7vn2ZFiYlEfBwxv
 rPoB1E737JYW4qKQ8dcLC7VJVpQRvnhPhICRF4B8btYOCUghrYEGgE1/qi/9SAIVywygcz79
 YbT0ETMqyVMbE+t7eE3ODaKadh/DDkytHUuQ629R4EJm8aCdAE0+46MHfmLqQcfng+OXNNLu
 vm2iMxnUvZRZ14VLXdOpAtZZmxm/T70LjdTVotARkh5AOSjTWuxoLbPnGjtCs2Yndk+5tn1X
 LKvTDYy8yY3s1TzCWy60bjq7Bt3PfxwNpKA8KBzuIPLC/3twqubIN9H5WfoTEcuoiUmRQXue
 iJhy1lE9V46nvXcG3wiwDqwRPc3DEn7GKn4UOEgEHkvdfySFsBeo98bMNiA1/kAngbzZdBOZ
 FwrjukXl1sfEv9dRHGlp/1vtdR5xGJSDQZ4LQuZjdkIPsjgfdq3P4iFQVuYdQ99OaQ0vF6LA
 GoZ/usucp+YBeUaWvUsXJox8HpVnMvHg2eSkxHocCN1SNK9UoJhXfw6fZv1kvozqhNAKVs9q
 DBKOBlhbtORsgZYeZ0A/oAW9K+DijITQjXOGyfLFz7HOVfUki956Lf8fEw/qWnaZYIxJw9lN
 DIV05Zr3c7fwbrBdeV1JNG/xjRSCG2XCjryMtZ+59l04eMCYbDIGmGUhQjgsGgq/IQDonSXO
 uyIotfB7v5IW7nCe9yrkTDsllpWA8jueEuy6EGsgi107f2w6XRx5jmTMo=
X-Talos-CUID: =?us-ascii?q?9a23=3AFQfXYWp0h3q3sBk/YsMej3rmUdgqL22CwlmOGhK?=
 =?us-ascii?q?pSnRtVebSUQaK5Ioxxg=3D=3D?=
X-Talos-MUID: 9a23:O0c6NwuqZRlAU7Rqns2n2mlwJMhPzbyVA0UviqUgi9ODFS5RAmLI
X-IronPort-Anti-Spam-Filtered: true
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Jan 2025 14:20:36 +0000
Received: from alln-opgw-2.cisco.com (alln-opgw-2.cisco.com [173.37.147.250])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPS id 1C3841800022D
	for <stable@vger.kernel.org>; Thu, 23 Jan 2025 14:20:36 +0000 (GMT)
X-CSE-ConnectionGUID: uJ4yW+q8TkC8YR1TE2U+7w==
X-CSE-MsgGUID: yhKHPOjnThiiMfseDwg8hg==
Authentication-Results: alln-opgw-2.cisco.com; dkim=pass (signature verified) header.i=@cisco.com
X-IronPort-AV: E=Sophos;i="6.13,228,1732579200"; 
   d="scan'208";a="17471907"
Received: from mail-bn7nam10lp2049.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.49])
  by alln-opgw-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 23 Jan 2025 14:20:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bu2FOgCALnsRPaA5fUHBXbE4ysaWMFPSbvWi9dL0JtEJrCJUw99c5e1SdeVMg8tEGPQwmlZ0GN0CTREeFYwcBVxuhSTJI93XeMGyu/SxF0KTNVG/33wf9CfpWR2z6DT5/3Bd9BXftaClYUxLnpBBCzkdthOCz46gpMjgwPX2ogl6E4HtlG3y/I7uWtaXa1diSe75rXHHdmnHpWcLzn3VTmR4+duKk9ffKcPUo97HaNDv3sKjC2ba1zEM9aXIKMy2UdcTdCgH10+36blApV5GeWip4000XhSKqr1JRl4sQ4sglb+hdgJbUwareXPigfUym6q7Hm2LI6+LV7QLVKuJ9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S7mVfY+a5f29XdZIwmJrStwC3UnDQRYoUSaEJAYWrXo=;
 b=yUsZ5KuK04846ttJ0MDyN6mP98gNBNRuAtCKcAusOG2ALKaHlBXoIpqEgMUZuPtJ5Naxp0a+mMR5rmDKGX+I4s/wA1RGXDBn3WiHi8dyfItY+JUWMLyiLSvLOk7/lz6qXssOVXequcoosemUGylmAJSd7eQ4S7ARugUNhwHnkMGe8UQ1TT3495yp2ZZgVNs4s2qs/9jmC0WgXhGZcdAJUf5ElJ1U/2k0PxgI2vF5ftFo4BkcC2q7tlpWC4ondE0ueq0AkbDjtuMoXqAYb03iaUEnspJIfdS0+oXH/W7PPnIZtglRbvbOq7npgLr+4L7Zl+/AAQuZ4W/GCnikQWl/Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
Received: from CH3PR11MB8775.namprd11.prod.outlook.com (2603:10b6:610:1c7::5)
 by SN7PR11MB7539.namprd11.prod.outlook.com (2603:10b6:806:343::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.17; Thu, 23 Jan
 2025 14:20:33 +0000
Received: from CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da]) by CH3PR11MB8775.namprd11.prod.outlook.com
 ([fe80::d17a:fdd6:dfc9:19da%7]) with mapi id 15.20.8377.009; Thu, 23 Jan 2025
 14:20:32 +0000
From: "Daniel Walker (danielwa)" <danielwa@cisco.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "Shubham Pushpkar -X (spushpka - E INFOCHIPS PRIVATE LIMITED at Cisco)"
	<spushpka@cisco.com>, "xe-linux-external(mailer list)"
	<xe-linux-external@cisco.com>, Zhihao Cheng <chengzhihao1@huawei.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, David Sterba
	<dsterba@suse.com>
Subject: Re: [Internal Review] [Patch] btrfs: fix use-after-free of block
 device file in __btrfs_free_extra_devids()
Thread-Topic: [Internal Review] [Patch] btrfs: fix use-after-free of block
 device file in __btrfs_free_extra_devids()
Thread-Index: AQHbbZfygv7iEYM2yEuhxEnfkgU18Q==
Date: Thu, 23 Jan 2025 14:20:32 +0000
Message-ID: <Z5JQMGk34hnSI/94@goliath>
References: <20250123114141.1955806-1-spushpka@cisco.com>
 <Z5I/YsJbzLaTBZ/9@goliath> <2025012346-submarine-dismount-f9b3@gregkh>
In-Reply-To: <2025012346-submarine-dismount-f9b3@gregkh>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-Auto-Response-Suppress: DR, OOF, AutoReply
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR11MB8775:EE_|SN7PR11MB7539:EE_
x-ms-office365-filtering-correlation-id: e294aaf4-1e6d-4ee5-06ef-08dd3bb918c3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?44XdTMsaFdEa5YSHGwMYv2/HX+BoZ3njMFKuPs65kGsQw0R53uyAGhHcDuVu?=
 =?us-ascii?Q?4ZPpxCIome7etMzmPc5EBN58KlYWKwkuhBEj4MY5IWGlw3whj6MtmM9KnOxi?=
 =?us-ascii?Q?eBMG5XrbxYocnYQNDT+E2/oEHnwltYGOib//Wzau9nnFduQsxIuIlnLbs02f?=
 =?us-ascii?Q?t24s8vtw5gLGW13ewn2ryCa6k7QWXvlfK7pjCek2A/vqxM66pWdR3i10AFju?=
 =?us-ascii?Q?gHt5Z1M61fnMTmcF3HKuIznpQ2ZQhbns0ja3AuVDLec0lG0BzLu6FLA2NszF?=
 =?us-ascii?Q?Scghz9UDsOAYq8x2tgWOjPzVTzK7FKnWD7ATENSqQ0/PCdEs7iFcVGCE/v4u?=
 =?us-ascii?Q?3xqGAoZHBmmrNzCcq04OYxEuoqJgYn0F/xZd0UsN4cgfaIXxsV7A54eim5lF?=
 =?us-ascii?Q?3hbnXxBGbXJB6hKsLagGQ+SBmfSv3vonyZTdkZ4MnYbVnATs3eEZJcac24L6?=
 =?us-ascii?Q?hSEot2rZb/Sa19uvOcWSgREzaA+dHi+7bKWc2agh8ZFycm2n7ewpD/nepUNp?=
 =?us-ascii?Q?U99TnBEi/1gq0FaNOZElDvk5zTCmvd+4bzkkYUHMh1oJUMIkd3uD68BpVdzJ?=
 =?us-ascii?Q?G+hrle9vzvC9JaavyWE/vl0ZPKW59VeD35jL5/9Lr9SX1slkmBJtcRiU5CqY?=
 =?us-ascii?Q?dkbyIasC+nKpJ2wjBZgav0uJdQ8AfDWlDceRlMNTBcLa5gS17RV/o0C1y+41?=
 =?us-ascii?Q?1YXGCHnzsvd8yO/kipqc22/arl0rjz4ZEfepBainhO21eXA8WKUsPEa5tVck?=
 =?us-ascii?Q?zL32b9mqHfbi4034m1KsNjNG6Sj5fXcD5G0Zp03y8ZCVkW10stpPUvJkE5Ho?=
 =?us-ascii?Q?7JLCrHtRy0W8RIiL2J2yNwlL0ODI7AvJASDlv66Rej8P6U52HJQSl/v73X0B?=
 =?us-ascii?Q?QgNztxKfB1NcPNHQmtTxoE240HgH9dPE62LaYtAMfmrkCda+FnkZ3WJEXt4e?=
 =?us-ascii?Q?EGhKsqPBEPy3W5dyugumKDgdW+jj661iqIq7u9r5bFIvteaXs9HYeB4Om/ue?=
 =?us-ascii?Q?rpNehrkaHtNXCoLWNLC9tKiSeguufo0ZezylV4ISmtO7ohbjStzUJoI4SatF?=
 =?us-ascii?Q?28kEgs1zsapIKJeM2ewsnmWOw/jeqvV44UKUWpBbmdmu7mj1FMO9JeyinxWx?=
 =?us-ascii?Q?m9Dx+Fue85FXG/53hwn/awcydD+XRs0lVEAoweThALdklfZSZSPaASeKiV/l?=
 =?us-ascii?Q?/n4eIp3nNLIxEZM2Bt9/2/FB28wSDuRlCnMlJ7Jx3lWmG6xkmjcjaA06WeTY?=
 =?us-ascii?Q?OABPz+gyJ8L+Hg2YS14QoMBrmd98Mo0GjeV8DwiTenaj4efDpIrE9Vn8XJ6X?=
 =?us-ascii?Q?LaVqBioTTRAuh9/GFMpA3rvhljF0lcIT7jZ7zb3G2qjDBSyiTZkFiJkFH+Jj?=
 =?us-ascii?Q?fPF1FZvYfGWYoUTGdUuLXf2omhJng+Jmgqfd+S642+LK8UU3jEdyNZyC7Um2?=
 =?us-ascii?Q?mnctk4vvm/e9YMT8/M8nkS0O6tsMBMle?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR11MB8775.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qy1UopU4XsL6s2uDtpG3VAZV4z8EmOi8xP/Ztu+829pMY7rErC45joz9pVJz?=
 =?us-ascii?Q?8cPW8Z/4tIc1K0HUAyDFMBKjoPTKM5Z+Dm45nTs3p7RyVH5vmlPZFiw1xdv3?=
 =?us-ascii?Q?rCGFejTd/KQe+bi3YdP0GmnCXtgJu4DPYTny77RlWexJ9YH9wF9eXdgvKYWw?=
 =?us-ascii?Q?5oRcigtw8fArwD54GfSr1MJgm9hcV/EuCop7qcRrSfqs1YOBoRcnaCDO7tKc?=
 =?us-ascii?Q?tfOQORf/zsXHyU6CBk66gDm6F22NGicW7IMsMl2Udd0iK0afBRw4RD1ayRYE?=
 =?us-ascii?Q?Vv5duUxVBVCy8dIHM+8WtICBb5Ro27DoYwIQQdVPn3MrXlB83ligw0PqohR4?=
 =?us-ascii?Q?JgddtsgVtqNgCQnJyaV2FvRHM6TT+VZr5B6NiFgNrRMisl8L3icJSj0xWgrc?=
 =?us-ascii?Q?6hb94jLIp62QcQObhMGMNVy1d4QWKWmgXUXfoBX613atpMuVCxO1GCCgdTj4?=
 =?us-ascii?Q?AWngxhAT+8/3/7mN7WJkDgDkCpyrtbG3AxBwKysJwXpgMvWF6TYsKcrrBRPV?=
 =?us-ascii?Q?b7bV0GMq+asbQrl7lR+iec953x8s2NjjkcVx4U+DxAw8Dwln4QCz0wuu7JeC?=
 =?us-ascii?Q?XWNpkoaO/RYShTuqgO6jFKW87pXaSiizvx4kbRQXmLyvmsodXx3mlvPFPck6?=
 =?us-ascii?Q?uK4p+lFdXH6uADMwkgDcoYRCupMU5GS17Yu3+bWoH7TCxkWyO4Quzjw432kq?=
 =?us-ascii?Q?do+0bYlLtBl6xIxBObdQtCiKBqH1RhWpOIcQs4Ax913fhcfVrW1Vzr0jSvA8?=
 =?us-ascii?Q?J9tRoj7rX8hhwXoN1SNa72tF8vGh7KPEcra/6ychQyiU4vRBRNnfjapzGYBn?=
 =?us-ascii?Q?ZrdBGmWfrK9m4i5xXsab7AEdDUwxoo0VANANJwgjMl+r3tngomYsU2JnZH9R?=
 =?us-ascii?Q?zZT3JCm6Z4lXBB2PYOgHzg6zUAfGJsxETw5CwS+7MGez1HbkF3oqq50vwxl1?=
 =?us-ascii?Q?LoVVtG5sOhcz0XQzZmJ3LD2O09E0cBxupuZqOwWIB/uKTli0f0GjPL30UZfI?=
 =?us-ascii?Q?M1FoYm2hSYMlmfC6BqZt1+oZDMdX6iBR6/+iikhZhqCJCp+dcprQxziAc+aK?=
 =?us-ascii?Q?e5oMaWzF/5Qp2sudOtPAcrjoA7823n0vc3X9S4iCrjIfp8yf77UlPo/v6T1b?=
 =?us-ascii?Q?QzL0dqqRve2q0oWobgMfV5C3ANlrnoH2uyEHKBiLmZ0aG6DkDHQukYI68FgV?=
 =?us-ascii?Q?wHJ0Z0KNbiX2PEG2wkREkZbza5eMat0E53/xYPcKUbdMnx8lHgfvmKuR0EyL?=
 =?us-ascii?Q?s9fwkC0mCnAvpiZ/JiSaSyCW3lcqsfWAWnd0QC+1o46OH0Ht5rTEgV3zvTTO?=
 =?us-ascii?Q?yFodoc29xyLHoxiCAbs9uC44C1iUDYUd1YuHCW/v7cTrZd7ncdP1wA4iG1my?=
 =?us-ascii?Q?zWue5aGldrxBFTyUUe+aeIfw3C2Pa7w83LX+jy9NA3wuoMlhXVF9UMZYNOpX?=
 =?us-ascii?Q?g/hFoNUFZmLcdxHlPdWRBF5cKIH4tFfex6564KAGLtoWxJv6834g5GNRMaUQ?=
 =?us-ascii?Q?paF1WsmvzUIn1PXTwZ883ZwSd3CoK9VZ7M2Lzoo9Fo6zVk4ehPsMJ7W9CtcC?=
 =?us-ascii?Q?vlkzXf31F6w10L5z7XkuX8fNT+qJ4SwCmdrAADjT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A9D9CFBFFEA5834B902463A56C6A6159@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cisco.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8775.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e294aaf4-1e6d-4ee5-06ef-08dd3bb918c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2025 14:20:32.6480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DURDm0FnL4ErddVWSxpdx0Q93fIQS8bOWE7vD/yhCdFo+IoFvs/akL50QA/Wjcanb+lFOYEOf8MMuDvRltovjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7539
X-Outbound-SMTP-Client: 173.37.147.250, alln-opgw-2.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

On Thu, Jan 23, 2025 at 02:56:08PM +0100, Greg KH wrote:
> On Thu, Jan 23, 2025 at 01:08:52PM +0000, Daniel Walker (danielwa) wrote:
> >=20
> > Looks fine for release to me.
>=20
> Released to where?  This is already in the 6.12 release, what other
> stable tree should it be added to?
>=20
> confused,

Don't worry, it was suppose to be internal to Ciscp but looks like the CC's=
 were not correct.

Daniel=

