Return-Path: <stable+bounces-219919-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAdXJ1A0oWmFrAQAu9opvQ
	(envelope-from <stable+bounces-219919-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:06:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 185FB1B3068
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 07:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E728C306C46B
	for <lists+stable@lfdr.de>; Fri, 27 Feb 2026 06:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0553E8C4D;
	Fri, 27 Feb 2026 06:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MCnW9BY0"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E57AD4B;
	Fri, 27 Feb 2026 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772172364; cv=fail; b=IQjLHVuB5phz4Vl2lsfCz+AKxQj7tiXIugNEWwbULTMKvupKt5L412KAO3U8vAAmxqYEicoGl1rEQCNe7iSX3k6LaxjpB+9YdUZN3p2XLWQUIOGbfbJ/vpGBepKt4Tmq1NxZkR42tUWVBygZMoPB9Tf0TFwVCIeO3A2jNwVViYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772172364; c=relaxed/simple;
	bh=rwi+YOs8BB6yDSf9jBxH9I0BkcyGn08GPCyMAWLHmxk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dBPAg10GZHFkBcRJ6uQJkFmgItNkFZmyvLL8ySAUUaGhRwbfFB57fJZtE5fF4K/IgzTypvHf0hMTMOWO0hftajRWfpckITl59HdnsFwfpVZ6dGZFbMfFcpaL8npb68q3UTKfrI9xlDqIFjQB5d0IjXi8dfuQNYU+toYDwSupn4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MCnW9BY0; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772172363; x=1803708363;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rwi+YOs8BB6yDSf9jBxH9I0BkcyGn08GPCyMAWLHmxk=;
  b=MCnW9BY0cXID+krFG35qIXgaZkLb03XKsUcz6m2jy7sR79CUgMU9rj9C
   +m7tUuqW/flXnlHdu/SEhiDz2VdsYV7IsG4AYJgvbOj30TCaf8MI7fPhL
   qGG/5aU779HW5nvCw8z6MAMc892vYGyNB2xhtRAnNiqwZsAXPw6iBZTlY
   fkBTPIwRJ+rINxpulY94AzaPa7JW2kYOKLRxUCzB0UdQGBq7iVQ7LNJ9h
   +P0ZvfNFDzx8QKrwSZnWZRfTD9exjQdka8T/XF5Egrt0h0ToXy8rIWQwJ
   Oh+CVFBpPCEfJ8tBmo0eOT5V/gkzdbvDuhWc55Yq1GozmaJid2NOUWlnz
   A==;
X-CSE-ConnectionGUID: ogln+PLiQHONqXqbOwQT1A==
X-CSE-MsgGUID: 9sqF3rotSNOEMfpFxjTEuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="60826030"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="60826030"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 22:06:03 -0800
X-CSE-ConnectionGUID: +BSPRR+hTKC+rFcP2cDcuw==
X-CSE-MsgGUID: zpb98CjwRA6SDaCnL1cDng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216706226"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 22:06:02 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 22:06:01 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 26 Feb 2026 22:06:01 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.2) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 26 Feb 2026 22:06:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gt7qtD3OElSqWsKSRMyLRdQ0UKWfD4cRfINk+fITLyq6q9W9TPPeWHv924YxBsiG7vX5mwmzt0hM1zKgMwfVOgw10jmMQce7fkBJduPL0hZgf67vtXCKYO7CNx4aytwXNy06B68n9MTmH1dXSW6WYJ6M4cQ4IoVO3zj+ZjBrQqosyI+KNfO0wmZ5dVHXbr0j1BcPmr2IzG0EYJb69nADVb9TNsk1pXPG8Ho4PecjkRlyfeEDWKqPeyswyOvJJlv51tmtNYGLPhbBa7rwjODg9EcxLbNhgE3pwOMv2T1Ne+heTRpHKc1F4WSBm++FeTi9v2s9dXSmcXi5jnL1zVrPew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwi+YOs8BB6yDSf9jBxH9I0BkcyGn08GPCyMAWLHmxk=;
 b=K4QfKUKaukBCghNFJXHl1m+80DrJrll9XbBxrM1wUPK6s5bGClrBNUOeDcEvVwoYJ4Pp35aLofroC/VBhHHuCzymNnTAYI1ELFgtrLk+E/sgFLQ+NXduuf5A4h4a9KNPq7XNKWGGA+hfyJ7dniPQK5nPXp0rDCsuEOjq31bioEL4UHDgqkhEihzuoF2IQYEkv1dlIXsMM/qTO8NYHbSnq2tzh+ITXdASDkhtJ0eMpqxOY78+ojjHNs/7sPQU0frl5J37uW5Zi3gVCmMzrk6QfWg7zslO0KsMOd0EQLTf9RR8Qd3E0V6D5tTPeW/bb+Fxg9JIVREsfPgfkMFLVsD6cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA1PR11MB6241.namprd11.prod.outlook.com (2603:10b6:208:3e9::5)
 by BL3PR11MB6433.namprd11.prod.outlook.com (2603:10b6:208:3b9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Fri, 27 Feb
 2026 06:05:59 +0000
Received: from IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919]) by IA1PR11MB6241.namprd11.prod.outlook.com
 ([fe80::7ac8:884c:5d56:9919%4]) with mapi id 15.20.9632.017; Fri, 27 Feb 2026
 06:05:58 +0000
From: "Rinitha, SX" <sx.rinitha@intel.com>
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Loktionov, Aleksandr"
	<aleksandr.loktionov@intel.com>, Jakub Staniszewski
	<jakub.staniszewski@linux.intel.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: reintroduce retry
 mechanism for indirect AQ
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: reintroduce retry
 mechanism for indirect AQ
Thread-Index: AQHchMRIc3k/TrwpA0qpa98jskoXy7WWST0A
Date: Fri, 27 Feb 2026 06:05:58 +0000
Message-ID: <IA1PR11MB62418AACCD42A9E3FAE30FFB8B73A@IA1PR11MB6241.namprd11.prod.outlook.com>
References: <20260113193817.582-1-dawid.osuchowski@linux.intel.com>
 <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
In-Reply-To: <20260113193817.582-2-dawid.osuchowski@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR11MB6241:EE_|BL3PR11MB6433:EE_
x-ms-office365-filtering-correlation-id: 24edc5e3-8ed9-4f72-b46b-08de75c646b5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003|38070700021;
x-microsoft-antispam-message-info: +C3oNjPcpCx50fBAGrr44zbB4I0qsuvkLdypLtXxKW6RJHB0K4r1bqhKgHmKhsoF246HuW8vsWnulvB3voI4uBZmk3aYztpBm3yz85bKTSKVSqIGW3jFkMDFEkI/YX8Et5XldguWbvZNaUj0wxRzKsZSjvVHMB6LNtx4Fz2fnWSVllm+Hg6P0NCLKtsUnTEib2PI5XBbiKIDn3weguqMAzYB1BrASjmm8s42haAZYF6UJX1p/TtL2u/kYPgJgy2CqT6ibFuiLpo1S5k1sW8f/lVAgdEUTbd2wCW5r4m2kbE4BCZFcN0IVCRwbyI3Co2wv/oou0BTY/2axXio3X5q64VSO2v78N4F/9b7AgiPuBeJhxkxBtxIRys68SsoyAFqCdJ6Zb6XFs0XDcNGEZDgD96ffTGStXIRT+rer/q/skBGWDaMeKrvSEblh4ZHOveHNweczBghW16STQLcj+cJ2kRRBxfNAglgDgIkUdTU8xjji0n940Vgdtr+SGc7iqiZ1Y9lDZvUS0kXC/1Y6j5DpDMd8z4OX8izJH4hwDB++c4XJsqCUtXUr+5CKkgHks8PZaCFLQShiFl3lWOjy41hOdxMUwVqXJV0l9NwpZKanMZQywUVjtkhk+qH7ZvinDsU81I2uxwRl7Ek+DfGaZEaYbVP/Qa+cr/D6XWKa+ONoTAn/oV0ZPpYm//qnjAlvoUo5FL2E3gipKnmYALEVijv2Ax8zozrP+r+ASsnwbUiXayzdFv5AQ8xuGGt2Ql+rUM88ta5EdLiTzGBkkzxs6Owy9/yBv+KbQXOBO0grp+Tfe8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB6241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?PZ7pXCCa9/lqAP6mRSmj5RIIhplNzP31SxCnTN5/UYB7fTtCQN5wquN7wOZw?=
 =?us-ascii?Q?2kViNdCJ5aFQ+dkuxH2UQKo1Je6LsYQdprok6JRb38+mX0MQdx99DutQBK34?=
 =?us-ascii?Q?JhFkrsgQCOukATZFpBsdxsW6yh9wJoPNmhhKoB8mD8gIM+VvqtyCTMHJtZ1p?=
 =?us-ascii?Q?yVw5jiN/sCEm6AT9lGD3bmIImz0uUjKB/+POsDppKRcVCqsMVf4bXBEZE6Pt?=
 =?us-ascii?Q?o+88Kri7FRJBl5aqrIbrDRSytSpyNAo11nhvyVy6fgXHHq5LpuNWWIR/8GT9?=
 =?us-ascii?Q?tKaQoUU80l8bJDiMo1cZYApLgalwK9yz0NRf1vyO7ybrRBSY7MBNjb/cj3Gl?=
 =?us-ascii?Q?SOVkFXyIkllfHAdd/2AqGrngPjkUJ8e43Wz0LMulgM6v44S0B/WVX6V38LRY?=
 =?us-ascii?Q?KbjzpQOa3y8cbAVB4mu4rYxP5t3aL21NLWjBVNtFX5ccVkj3UCl6xTIFwhKg?=
 =?us-ascii?Q?nSr3YUZW1QM/8M+AR6jkBsvlpmHw+7Weg8Ts1rlvHtXaPGmg3keQE9wCWN/g?=
 =?us-ascii?Q?BBYDAtAI9VhRjLAmF6iO9I+nF/HlCKiHYepU+wKO+j1SF4ODSFWMUJaRLVBv?=
 =?us-ascii?Q?1MohS0a41kcM7rHRpo3beWzoQ9IIZaNIzfvr/Udupci3uRgDeg50DWU1BxLY?=
 =?us-ascii?Q?VykoeedvvA+bTpet47MXYBfPW3Zj0f6perxTJxvU4VmcKtA03AhbPw1q8WO5?=
 =?us-ascii?Q?xzWCPhr703Pmf3da+YMGMnInc+362N7f26x4ElQ0oIikprZEvEtie8GUfImW?=
 =?us-ascii?Q?YI7AHBttI+BG8iSQbl13Gtt8kytmzKTIWEkfWd7Ar+IECqQLZ6GwAsNLSjgS?=
 =?us-ascii?Q?fcqa1OXcJ2/MuBqRDjyCqtM+bS5qaCJRK9mL7HhrT1agRYNXGaX3FWMOor+n?=
 =?us-ascii?Q?pZsudxjCbDESdGY7z0kQEwV80O+h9IceSqW2lUJ3wS9wm8RfwhfbzUFn6Czo?=
 =?us-ascii?Q?/0wBjA5N/MMDThVywqRZ3MFPu/Q6Yl9EbnEYxmxQWCVd5JyxRJ+JoUKDjojY?=
 =?us-ascii?Q?kuk6YNY+yZW/duge/5QNCCQLLJmQRPj8gT8zsF12qiSxON25vGwt6wg1V5H8?=
 =?us-ascii?Q?gkGMMW/bwh+XuFIqkuWG3z+b6KZ0/p7GtjfFJsOsn86QVusBSH2F8eJSRcEi?=
 =?us-ascii?Q?No3eubp9VEY+WuRW+h6cA0kCBkh2YheYaI3GuUjNIFWE7JqnE01qRR1gc2hh?=
 =?us-ascii?Q?AVSccUhIJ2wIpCTxmvYTDNPFow7Ig6lwalWngCOEKQWz4ECTaUCnT83924lI?=
 =?us-ascii?Q?WMGUGFkQc3Om678MHc0eZHuw04PXECx236bBP/3WVZQtNUYv/ilTmg3QJNXn?=
 =?us-ascii?Q?PmOp3zNtokgIDGx8oIqvfl/9lgxPVXw0UG5GBHM+fHeTXltyWfAMsFyhkU84?=
 =?us-ascii?Q?6VFfcAYO9GHpGZs0+wTB+cD5Bk6sqaNZktyVu8Tyigb5N9mRqeyZSL+ru1Nc?=
 =?us-ascii?Q?d5tiw2JUcxkb5hyxemQApFezRkDqFliUE2pzTF2V/x9pX0+xFFmEoWQbEu5f?=
 =?us-ascii?Q?xYdYP4WzM0wSd5F0TjjIdXyLC/1m/1qjfmDV28kbDjoLnIontGdjdknvsllD?=
 =?us-ascii?Q?GYVCkRqxQaMIF9aF+0s7TrP2hFs74uwBS25YZGcuXgPNW5HcVcGYYbLwpi0Y?=
 =?us-ascii?Q?MceSe+VTUN64YBqLWCDdmrOSbDHBDxxRAUxge3xNO7kKUiJxTaYvgCQiknjQ?=
 =?us-ascii?Q?dWTbxxu4aK4S+r7nMvOJZudZA6KmcmdSK2nTX3cHed2PfHwPFUE7l46cgTmE?=
 =?us-ascii?Q?Um7EEY3q1TCHb5qG2wZ2KZAYmUAYTOvIU7APp8NWxYNGirf549r/+Gnnc79Y?=
x-ms-exchange-antispam-messagedata-1: LfTnLlxwsZu3MQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB6241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24edc5e3-8ed9-4f72-b46b-08de75c646b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2026 06:05:58.3413
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJtJvrzyGlPtHUjB6+lFyXHOZAkvfCWdXCo9+aG66RCI0NfE2RKO4KNXmfBJEHA0mUOIBzY/afdsm8N5blMVoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6433
X-OriginatorOrg: intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-219919-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sx.rinitha@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 185FB1B3068
X-Rspamd-Action: no action

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of D=
awid Osuchowski
> Sent: 14 January 2026 01:08
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; stable@vger.kernel.org; Loktionov, Aleksandr =
<aleksandr.loktionov@intel.com>; Jakub Staniszewski <jakub.staniszewski@lin=
ux.intel.com>; Kitszel, Przemyslaw <przemyslaw.kitszel@intel.com>; Dawid Os=
uchowski <dawid.osuchowski@linux.intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net 1/2] ice: reintroduce retry mec=
hanism for indirect AQ
>
> From: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
>
> Add retry mechanism for indirect Admin Queue (AQ) commands. To do so we n=
eed to keep the command buffer.
>
> This technically reverts commit 43a630e37e25
> ("ice: remove unused buffer copy code in ice_sq_send_cmd_retry()"), but c=
ombines it with a fix in the logic by using a kmemdup() call, making it mor=
e robust and less likely to break in the future due to programmer error.
>
> Cc: Michal Schmidt <mschmidt@redhat.com>
> Cc: stable@vger.kernel.org
> Fixes: 3056df93f7a8 ("ice: Re-send some AQ commands, as result of EBUSY A=
Q error")
> Signed-off-by: Jakub Staniszewski <jakub.staniszewski@linux.intel.com>
> Co-developed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> Ccing Michal, given they are the author of the "reverted" commit.
>
> drivers/net/ethernet/intel/ice/ice_common.c | 12 +++++++++---
> 1 file changed, 9 insertions(+), 3 deletions(-)
>

Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)

