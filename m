Return-Path: <stable+bounces-89541-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE59B9B11
	for <lists+stable@lfdr.de>; Sat,  2 Nov 2024 00:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6102C1C210BB
	for <lists+stable@lfdr.de>; Fri,  1 Nov 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D051D1E260F;
	Fri,  1 Nov 2024 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jIzAwahp"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076781D0E18
	for <stable@vger.kernel.org>; Fri,  1 Nov 2024 23:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730502104; cv=fail; b=eCiP8sWHKHhdU3S88gfrxvYpjrQs4jbs1E/cU91Geh3ax8yKEHMBG0XK6PkSJAYsPnkMrq+wM8XlQZ1BURKhSPmq0KVZc+6KXzDh7XbFefpbl1kZq5iLeOugWGKauauOkhOtNVA/1TPEulfNpgXpwbKPs78smGs0G8c/EZ+AM8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730502104; c=relaxed/simple;
	bh=sukXPGEsV6iZZffz142O4iMmN45DvhPNlR2dL5dF8EM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZqYbL/W+Ir0dm7MMT6RgbJxaOhZOMJV6TQWbVJ5F6PIFbIxmt4m4ny9csYOIQxdpnCsnamQ1CFXMvXV4emHo1A3cAIeSxocGuaEKg6dZpLLUp5+FZUksfbQM3v2Q2E0wmGjUFXsiK6QaThixgAs14G5VAmHpQkZoMfshYlYwf/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jIzAwahp; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730502103; x=1762038103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sukXPGEsV6iZZffz142O4iMmN45DvhPNlR2dL5dF8EM=;
  b=jIzAwahpWQRaQ2Y7YTKVvTzl0Zr/aNkQycGSaKnTYEUwEnB61+HjRL6U
   FbHkaIcqWgXHXXxyf8M4wKZY7gzcvzdtjrJeUnu9KwRKsJnQ5mBGamNxE
   iTafDLvWs/z3OMTfN/kEUn++zmg23OC4lyFgbvZFoe2tIgqOyzVM/BJmv
   +o0NTdsGtG2FHaEsulMbDawamPpt82BDE+tHysHw+hbhBkthxUxPn7/1H
   z9FbQ4gOSHLejAV/vP6k3nnZhWV8SqJu1xo+I7JyeUsbu21+GaasPkigV
   O7DU7AS8ZAsXAwMFtDy6eRIz1QajUlY6ylFh9AnFcEH75Egmsi2XnYQKw
   w==;
X-CSE-ConnectionGUID: u4XknHzeSp2DrGlTJMop6g==
X-CSE-MsgGUID: 3knq1R2LQ968j9CGDQoWZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11243"; a="29696239"
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="29696239"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2024 16:01:42 -0700
X-CSE-ConnectionGUID: 29sGN0fKQsymuyqneHTBwA==
X-CSE-MsgGUID: SfvA0ioxRvKuO9YYjVWiVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,251,1725346800"; 
   d="scan'208";a="83441916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2024 16:01:43 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Nov 2024 16:01:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 1 Nov 2024 16:01:42 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 1 Nov 2024 16:01:41 -0700
Received: from MW4PR11MB5911.namprd11.prod.outlook.com (2603:10b6:303:16b::16)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 23:01:39 +0000
Received: from MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2]) by MW4PR11MB5911.namprd11.prod.outlook.com
 ([fe80::1d00:286c:1800:c2f2%4]) with mapi id 15.20.8114.020; Fri, 1 Nov 2024
 23:01:39 +0000
From: "Singh, Krishneil K" <krishneil.k.singh@intel.com>
To: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "horms@kernel.org"
	<horms@kernel.org>, "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Singh, Tarun K"
	<tarun.k.singh@intel.com>
Subject: RE: [Intel-wired-lan] [PATCH iwl-net v2 1/2] idpf: avoid vport access
 in idpf_get_link_ksettings
Thread-Topic: [Intel-wired-lan] [PATCH iwl-net v2 1/2] idpf: avoid vport
 access in idpf_get_link_ksettings
Thread-Index: AQHbJw06PhawaN5PPka7PUE5UBoNmrKjFZfA
Date: Fri, 1 Nov 2024 23:01:39 +0000
Message-ID: <MW4PR11MB5911CC01EAA08BFD0E38F4A1BA562@MW4PR11MB5911.namprd11.prod.outlook.com>
References: <20241025183843.34678-1-pavan.kumar.linga@intel.com>
 <20241025183843.34678-2-pavan.kumar.linga@intel.com>
In-Reply-To: <20241025183843.34678-2-pavan.kumar.linga@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5911:EE_|CH3PR11MB8592:EE_
x-ms-office365-filtering-correlation-id: 8a40e730-08c5-45f3-17fe-08dcfac924eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?PoFGK4yXp54sFSd1PY3ffdI86kEcnPKkHzC8deDhhIwdMytn5uAjlMJzukui?=
 =?us-ascii?Q?0K0PqPDqN90OHH3UgsfwX1MMoCsfE8ZnQ97Y2nP8DUdeoD9k0kEj9fT93VyW?=
 =?us-ascii?Q?tXPqzzoYkA+QjXNJrDikZECYsXMVCXlFtl0TGfdZIc6iSakvDFVhsoDp1l+N?=
 =?us-ascii?Q?4CNQwzi7jSCozcsvbAw9oAFdZ/0apxx9QtfuA2mZqhMhxqMdsagqdb16rvQe?=
 =?us-ascii?Q?xxGgpoaEReu9oM9COobMLke3Ma8aw9XTAJFc14lXV/E1EtbIUlNYPjISjRJd?=
 =?us-ascii?Q?85Pg3lzmVjIEmZb9P1wQ10ywa8D5mlxnpU6Iv4zy04SbZA8+3IkF92492inZ?=
 =?us-ascii?Q?pEJ/ZHSnZrFYiBbZfnrgei3GUJR+RcP+cPTNouHQWzgEmO+3/yhg9EGsj55G?=
 =?us-ascii?Q?df00cs1HJ2yJwC2qdPeHPZFJCnM85RKprs86jS5jdongBksXgLPERrckhI/w?=
 =?us-ascii?Q?wC+1UInerterR8PS+7LpwtVYRZjipPthA4pyDj4uuBxbeeI/2EbfYap8Hohn?=
 =?us-ascii?Q?Pzaa/VXvX469KJPJDqVlT2a6LcRTI6MTWQad64sY/TVJHf+yuYhaW9u0sb9A?=
 =?us-ascii?Q?8+m+EiojOVZMih8Al/5l92ucnwom9MjnlrVDAh3ykfUfwf9a1vgLS/8WANNj?=
 =?us-ascii?Q?VcUhB9q9PqFLij61mZU/KXI1xdmHTJpvz9VnaUHc70ruAP0Ju172TJZ3uLqf?=
 =?us-ascii?Q?l2oailHG+PAxGco5omI0nfNdYyp8TjbdePvD5Ha8HzrW+p5wwdLHIJ4zY0hl?=
 =?us-ascii?Q?Dy4VmCRkS3jB/x3iKWLRk8e1XFzZameBGrSgYdDDUiRsnrSg8BeyBRuM37Py?=
 =?us-ascii?Q?jDJTVVbcK8lXHy9tKzD1VCncb/b+RaGMQs2feYd/DgA9+AspFZ9+HXKSOSMt?=
 =?us-ascii?Q?hrOV2GRtquyS/0fEjjZSK/heitw6ImzXGpR37t+5jApZ8cAqz+IFrC4cMrFR?=
 =?us-ascii?Q?y3zLGbzvEj1IBX9D/0kFC/O4dyKN8IOECp0534DCWQhwzVSIoEboZl5ZW97/?=
 =?us-ascii?Q?IpahiQnFygdQ1N8qDZfCunuQ3J0nDC+FRJWipL/bN7gtfmIs9VS/N8+SfN6z?=
 =?us-ascii?Q?icySCsXxMLu6nqcC4bax2Gs3MCe6AJoi9uiLnLNTKwj65IIlUyW0yFllHFbR?=
 =?us-ascii?Q?lVtKGu4vDbzfkVjZMZqYm9CgIbDXXLDPtex8L3FNqUUnNL0sS0o4aj+Nt5d8?=
 =?us-ascii?Q?B68dc6Nzf/cPRtjAsCHj2ohSZhKlLgtbNzsuMffwRhzxM5Eml3oZnfF4DR3H?=
 =?us-ascii?Q?HPKgJMR20klIwB2IS1FL/5gAHyHvPKp7+ciB0lxrYi8xcV6+xMBMbhJ+jaoA?=
 =?us-ascii?Q?5q9+XKIPYeK8Lk6utW+0fx66MAqFI7NGlvuAeHX9dvVSOAW7Ce4QqeEyE9J6?=
 =?us-ascii?Q?nGmRoGU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5911.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?TUGzLerr0ZwdQR9Ao9dY8hMGGDbsD/489eagihiypeMjg4NSuwjb3XV59e1h?=
 =?us-ascii?Q?nY9iGbUilJmk72XAPIrf1PYq0txACIki4DzoL+UOS1+umMZSsO03GfhCuJpO?=
 =?us-ascii?Q?4bQSURBGk2ttnrcKUGLscM1axW4eUuMBfzc5Ag/eNWYrE/8iiY7k+K5uwspG?=
 =?us-ascii?Q?SGLU8UTIaBLfQ/qyP3XXuBBDzVZq8S4R6dvjKiznJh8KhVffWIzjpUxVXJOL?=
 =?us-ascii?Q?F9f5vTTPUsusvDXEwnyrrLU8KD2XL69FuUri8AKDTjringq6yAzDihNDs+yC?=
 =?us-ascii?Q?G/zAfHyvEBw+XqRAYH9nzv7qnScQ0jcmF9De9JFafOT6rSQ/2LXeh4DGCW8M?=
 =?us-ascii?Q?1/Vf54drIM716/cHlqKxcqgaWyg1xBV1ooVCiTqJgxM0v/J0nBNFMIPWgJFG?=
 =?us-ascii?Q?ouRcPQwb1c8JE9Jwq7eMtMYZ+WWub5IFwhaJYw3FvKWgOyqeM6SnwV2Amue5?=
 =?us-ascii?Q?XzzoB3uEC2WQ76XxIYT25jzNN1VmH4T65U9U0RWdv8sxRS9f0hW+SAvYOHmf?=
 =?us-ascii?Q?BRcYHIloh0MrBeCgMptSyezYJzQAm4FNgCMfUKlht5nXnGDME/x1JwjjW1iR?=
 =?us-ascii?Q?1gVUBBpsArc/c4Z70u7QG8MHZ+lJADgzAdQn1TI+VEzXLElwqg0wq4C5OuBS?=
 =?us-ascii?Q?PrIVHrzDPnR2Ax8nUTVgorlbYNp+li0DTYZqG5Ub6TPeLR+pv78km6DMAUAZ?=
 =?us-ascii?Q?YWuIO+qq2aYgxabrr4zORbf+WKIk2YrWtvaSX7S0tczaROfi3gsN2kt/AURB?=
 =?us-ascii?Q?3Uv/SswQcRuAhdJuHB6XV5qQBkVbfDcNTkO6boBst5xo1IkZte80Sywv+Pqc?=
 =?us-ascii?Q?LfWv/kbp1IR6cgKBCy03yslZmHbuzDYIYNhdkwI8zZPSlXZ5cVfjHq2/wH8b?=
 =?us-ascii?Q?ZaJTUs0acm4wKmouO5rS9i52xlK3eW5ehkbIEeiORF7HFNDlLMU9sIjmXrxz?=
 =?us-ascii?Q?lpOqgMIGihksarmzLkSwRRq+fDhqfCKAq0/yFAjXdaRizk/5OtLEyihYctcx?=
 =?us-ascii?Q?AgX/nZJy3LSkPUcSh3k3kNqs/1opJ7dfa9xUwGrfhR3Uxh8QxOulR94SCiKe?=
 =?us-ascii?Q?3gGw8+5JCP3U3msN1zIW1tzPP4oKFtlDmfQoeus/OYOBT6ERF2+1F3umaeHa?=
 =?us-ascii?Q?RZ3PZMRZeHQi3WRy8DOZ8d2ZCD568ct/fvHlvL4iQUKRIUxEe5AKmu41CVoY?=
 =?us-ascii?Q?UKYYTx2YsYSTV3QwqfwzcOluGrgjtaRWo2t8RrBtb5smhIgecLqAbB8ew5Ll?=
 =?us-ascii?Q?KHfeu2Fv6e45tR7hseNn0KEaAlQxdQH5pkgkkynd45NJsD8dHBJtFkAhDT6f?=
 =?us-ascii?Q?2p+6Wdrr237l4j+RuqV10Ea6RXTC6IpSyefN6Wen8Ox0zQBpIxsbsGIk8nfH?=
 =?us-ascii?Q?dfEaUfkHSRALYv17ApPQBRP0OVugrN9CF1DJH2ktctmFVytUvSGByF/ad2KC?=
 =?us-ascii?Q?CUNJOY/YSeaAzmdkpcaQB7Ag+lhaAk+4ufPbkVlKZK165lSynDJlpJniz6DL?=
 =?us-ascii?Q?xUzuQ6+zjW9V8YGurlUUXCx47L9mWLOJfF0LafGCh32Rg/PRLuuFTHpDQm/y?=
 =?us-ascii?Q?aqSE9B14zrmsHHuq0UiJjcZD9ANRQBt8H/4fmw8HYu6VrwdSWuWzL3jfizfj?=
 =?us-ascii?Q?Hg=3D=3D?=
arc-seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2Jljb0VXxBpZjbgDPBkHqBagxhcQEObnSO6xAKC+RhpjNU+ga9M61wz4gj6hkYt8YZFW1Zw/jf3Oc9tKz1yieMTl5Qbrw2CQSbvQfDmNo33KpTVTdRRBETB9DjapwErBpo4INwt62m8m/YO9QlfMS4+6ThVymDpO2xH1MxOqBigbEG87qtLTbmm97KtuA7/fmFIMefYP10+356vetGx2nYKw4njGjcjoKUSIt3g1hV01jXQHPbETkRQ120w7ctcFLNX9AgiBnrgoUcmNpsNx2IjyFYEDm7hC+yqJO/gRnoVKwEj6UVlP1l5Cn/k/BdfjscguS7M80Bd5riNjy73TQ==
arc-message-signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kYeJx3I0rUuvPJq4zB5QNZwB6VaCHyubzgFLR/uV6uE=;
 b=x2Zw3olioYvcF0cLSnk6FPf7KA7WuPX2hHtlxnJST+BUMJJcJareFBMmlxQGVXIJ7Bja+59KqIgRUizXk+k0LSigCC7+fSc6mrhiyjQDFHVJB4elyxA6JB37LTaaSmL96g1FizwK0gWo2C4/BrAsHXTJgRe0Z87zOeVboW6k6j/usvB7oGdVGs9EDMpC4hBAchp3B4JSsJGN0JURepj18ZFCp1yhey6f+oUJ9013KALzs9k3k+AbFgITqt1gLckdKj/h4hb971Jj3BAVK3vKuw50NV0RiSTMc8injAQHI0ZEF22TsDaR4ySc0y1vpXIrQQekOMcI1IofWj1i5z3v4g==
arc-authentication-results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
x-ms-exchange-crosstenant-authas: Internal
x-ms-exchange-crosstenant-authsource: MW4PR11MB5911.namprd11.prod.outlook.com
x-ms-exchange-crosstenant-network-message-id: 8a40e730-08c5-45f3-17fe-08dcfac924eb
x-ms-exchange-crosstenant-originalarrivaltime: 01 Nov 2024 23:01:39.4418 (UTC)
x-ms-exchange-crosstenant-fromentityheader: Hosted
x-ms-exchange-crosstenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
x-ms-exchange-crosstenant-mailboxtype: HOSTED
x-ms-exchange-crosstenant-userprincipalname: ZH9W/XczofbXzPNzG85EavNZsewgvaSCpd+tzKy++thUW/wo1zyY9MCHQT0g899AJjnMHDSjDdF2NqSf/+jy79TmSwNANGOK0mmvO66yDLc=
x-ms-exchange-transport-crosstenantheadersstamped: CH3PR11MB8592
x-originatororg: intel.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Pavan Kumar Linga
> Sent: Friday, October 25, 2024 11:39 AM
> To: intel-wired-lan@lists.osuosl.org
> Cc: netdev@vger.kernel.org; horms@kernel.org; Linga, Pavan Kumar
> <pavan.kumar.linga@intel.com>; stable@vger.kernel.org; Singh, Tarun K
> <tarun.k.singh@intel.com>
> Subject: [Intel-wired-lan] [PATCH iwl-net v2 1/2] idpf: avoid vport acces=
s in
> idpf_get_link_ksettings
>
> When the device control plane is removed or the platform
> running device control plane is rebooted, a reset is detected
> on the driver. On driver reset, it releases the resources and
> waits for the reset to complete. If the reset fails, it takes
> the error path and releases the vport lock. At this time if the
> monitoring tools tries to access link settings, it call traces
> for accessing released vport pointer.
>
> To avoid it, move link_speed_mbps to netdev_priv structure
> which removes the dependency on vport pointer and the vport lock
> in idpf_get_link_ksettings. Also use netif_carrier_ok()
> to check the link status and adjust the offsetof to use link_up
> instead of link_speed_mbps.
>
> Fixes: 02cbfba1add5 ("idpf: add ethtool callbacks")
> Cc: stable@vger.kernel.org # 6.7+
> Reviewed-by: Tarun K Singh <tarun.k.singh@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf.h          |  4 ++--
>  drivers/net/ethernet/intel/idpf/idpf_ethtool.c  | 11 +++--------
>  drivers/net/ethernet/intel/idpf/idpf_lib.c      |  4 ++--
>  drivers/net/ethernet/intel/idpf/idpf_virtchnl.c |  2 +-
>  4 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/idpf/idpf.h
> b/drivers/net/ethernet/intel/idpf/idpf.h
> index 2c31ad87587a..66544faab710 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf.h
> +++ b/drivers/net/ethernet/intel/idpf/idpf.h

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

