Return-Path: <stable+bounces-110905-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EAFA1DD59
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 21:27:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86637165E1E
	for <lists+stable@lfdr.de>; Mon, 27 Jan 2025 20:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041501946B8;
	Mon, 27 Jan 2025 20:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TzYdokjA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC8719340D
	for <stable@vger.kernel.org>; Mon, 27 Jan 2025 20:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738009611; cv=fail; b=cDbALi+1VOwP+Uv5zhQ4GytK+3uYixKPPoz2gf7HPUg0R9yJLtdekMIV1PY7on6fkP+xi/t9OmQgB2owqDs/kl4dR9K7XL0G8mdbPzCynruTBsuP/buNabHNYTaQ2ytIXd3xWzDHNfcs2j/BiGzVCWQV99gG+4gSMLsnRLSMufM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738009611; c=relaxed/simple;
	bh=bjZcqO+EJ7LJKS2KumU2DItNq71mVC11bXqfQMIrbN0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=crr9p1NvvVmUywWYY7Q06mm5ZS39HyIUhdXslbEWmL0IkiRCuy2OdI7nI3P1ibTmLH8yG4GABkze/Pjm2glPiMt4GwiZ9/mLaSB6x+onjf3mfKPlyzp6ULlL1dpn05tDI6GiWS61gvMPvvqPbtUaBJLjetuS/+V8ref4GMYOalI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TzYdokjA; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738009610; x=1769545610;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=bjZcqO+EJ7LJKS2KumU2DItNq71mVC11bXqfQMIrbN0=;
  b=TzYdokjAfflI+gUV3PJgsmprRnXu+CljTOx8ww+HiFRVkY9jH5t6ky9t
   nc8cA1MQFQY/HPBi187NgxhSMSDoIHNGRVGe8IfR9zQoL7dUefCwczJEF
   g3YZbz7J/I1weA1yOKcbU73ELPGenDHgnOh/03y9HKuv1BRAPBMTzMLMC
   GOwtwySEuS92Ao5jTsp8F4Y9a3FLiLdhTMOyFFSw2yo/4U2CcCy/ZcHH4
   j2Q3K/3f3q9xiR7x8CFCZo1IqqvVaM9cxsJQJDNmzTNtr3kgUyqbVpQin
   FypQRy0yu8fIyKxo21OweWC9CcqeTpDOwu/3ObqMdLtq+OqANGxwsYS4J
   g==;
X-CSE-ConnectionGUID: BTpcso2yRbeLYbG9aaZ7tA==
X-CSE-MsgGUID: gs0AmZeKQkmFBlHiSE/rsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11328"; a="42242312"
X-IronPort-AV: E=Sophos;i="6.13,239,1732608000"; 
   d="scan'208";a="42242312"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 12:26:49 -0800
X-CSE-ConnectionGUID: efp59PTGQGyUmqTIwmtxiA==
X-CSE-MsgGUID: uT4025THTk6yLeRWjWvpnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="113501183"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2025 12:26:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 27 Jan 2025 12:26:49 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 27 Jan 2025 12:26:48 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 27 Jan 2025 12:26:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZuJPunyUyQd87yltSzaOhStECTGOib8qA1kkH6isxR98Fa+b7tY3dUeu6/mWyUAv32umdUR0GabipS/GvB0NI2pQsJwlyhUnljGazne/9pRjHwjhnCggBvCKKzj46rGGilyqVx5ekGnASfyjNioZx/CUYh7jEhG+H1TgrAsrOTeEJCW3ghOrQSX1qin0DsgD2T35ILeudE4AJCGtoJi8yRUXYPxCRqaQ5xMo2Aqm/9YtyQCwA0D1GRdj7Uo/G+QHXlfeKgDwShlzGWZlTk5ulZU/WaRt1Rf3qDuxeRMf1GiTewyWlrNFiJrAQe1BY9ZJiO/frQepmiuBkm5CbcZUqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VMPEjFJzoKMAsna61gCi1LfJy+qMGK6glEp8yRcbMYk=;
 b=OTk1Iv2TZ/4FpIKz0eSTERz85zsPT/Ajq6TXBHuepE3RQPr+kgavhRBIFVkZWyPYlKxW1OIzKuv2BPw9X7dxMes5rGZ+bxDuqqLwbkGVcOtEGNSrsiJFNe9gSaEuLSbsRu3wvmZuh8wmPImxclXpMWVhMhYL5IxpmHeKFQ4BM38Tu2/TL7LcsvJnxXfRP728Z8s313mRER5RGa99YvF9bNvStGS++8bxVZLTQgy1mKaNpVp3OjDa0NBH30zJ52j1eWiEdI2uy48tX6nEIY+7QS5SBMXDpk4lpzMOcwLmi6m3TuQZttnO564vsdeo3tP6nTk9R5ON1jomqlbpg0cb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by SA1PR11MB7110.namprd11.prod.outlook.com (2603:10b6:806:2b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Mon, 27 Jan
 2025 20:26:42 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::7141:316f:77a0:9c44%6]) with mapi id 15.20.8377.021; Mon, 27 Jan 2025
 20:26:41 +0000
Date: Mon, 27 Jan 2025 14:26:38 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: John Harrison <john.c.harrison@intel.com>
CC: =?utf-8?B?Sm9zw6k=?= Roberto de Souza <jose.souza@intel.com>,
	<intel-xe@lists.freedesktop.org>, Julia Filipchuk
	<julia.filipchuk@intel.com>, <stable@vger.kernel.org>, Rodrigo Vivi
	<rodrigo.vivi@intel.com>, Thomas Hellstrom <thomas.hellstrom@intel.com>
Subject: Re: [PATCH v2 1/2] drm/xe: Fix and re-enable xe_print_blob_ascii85()
Message-ID: <dfqxu2qvk2ykn7spd5bi3nou5g7mjn6diqj2iti57y4fbi55av@nnw4clpris73>
References: <20250123202307.95103-1-jose.souza@intel.com>
 <20250123202307.95103-2-jose.souza@intel.com>
 <eaba2ac8-2396-4779-9147-7066995899b7@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eaba2ac8-2396-4779-9147-7066995899b7@intel.com>
X-ClientProxiedBy: MW4PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:303:83::16) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|SA1PR11MB7110:EE_
X-MS-Office365-Filtering-Correlation-Id: eb1a35cb-9657-41bd-b578-08dd3f10e8dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?F0b0uKIyLel3Ee5dd8PMe/F7qWSdFA0RLL8ket8TeM2BxesEmnS0HNwuwQ?=
 =?iso-8859-1?Q?ecIRYw5nDAJx59H4AruCv1X3IMh40a9mKEI1ZeGZLvXLFUFYOk+ArFykW3?=
 =?iso-8859-1?Q?TpstfUiWUA4llEDKyEXS///JGbg65CbVdbn1UH6suApaH6LbZkQkfJMCv+?=
 =?iso-8859-1?Q?eeVvtGtOuGxGqvNlD+5s52cf1A2QTZLJoGmmQFDBmyGVOI+XHJv0sqd0wt?=
 =?iso-8859-1?Q?ZYZCvbmyUCyZBmfBh0TwpVYqPeZY8Rw5DseldyCdzekPz4tv9i836Hxybl?=
 =?iso-8859-1?Q?T2IQ2besyprSMnDBArPZbG8Wn2Yf6kbdLAFDc473HeAR9JTZh2J5tAfIIM?=
 =?iso-8859-1?Q?ZJ3d4lPZSOaMu7vV9IvbMeL1fK8LvhbQ6WwccbIt5hOeY7LL3A7rXgipnn?=
 =?iso-8859-1?Q?wUIKTp9o488Vh8eZkC/M1RUL1z9MRJh4PUhfQiM+Vg+20rbKyML1XQ3rhz?=
 =?iso-8859-1?Q?VggW37Vv7AhQz1g5D9pFru0qgrkmcWgn/Kcy8mQW8Q4PwE7x719U5GD4E8?=
 =?iso-8859-1?Q?1scRFG06DCcSAjZxAlZAs4bbvyko8372mqsn2ycM9PEIauKmos8hq9/Jib?=
 =?iso-8859-1?Q?QHGV647XY+nFPMhx69IGvJKrlD6kalrfQh5U6sFn1pTGUJtVNLdTZeNhuy?=
 =?iso-8859-1?Q?CWIoKH9KqkvrOUmSGxLPrx01565mHxq4MRWTUekVe22Iy4P4/zA+Lcu/Ug?=
 =?iso-8859-1?Q?NN4fWlenj3wzHnh4hW+nTp1dO9xdbwz0eRwFuqSatIrJ74zU8griM+8ge+?=
 =?iso-8859-1?Q?J8fowdW5DKp6Cq7No4whmKawKusIoObJ7yiMNYHRpeAvP53y9gQkmHhNxY?=
 =?iso-8859-1?Q?pIkaDN52relXvgynIXyTPEKukTji0iBhoT6Wrl70G5ox4cbzVyMzdp0wwm?=
 =?iso-8859-1?Q?nqG9l3vC3i22A2zgut+oRdu+bHEzA9KSEPXnw77ggQ5p3ReeRCATruhVbH?=
 =?iso-8859-1?Q?T+ACBzWLd/PhGvxQW8si/BMCo3VgzSbDmy5YC7v+PRdNjEwe/mOjvAhUnD?=
 =?iso-8859-1?Q?n+ONgQONC1x/gHvvaYbFnCqEoPsUnAA8zw6KKhBTAeJb9RdFG/y9GTO6Xr?=
 =?iso-8859-1?Q?bFxM6VYs0QVsFau63ZR+ypcTiWm90k53mCw7bbG0L2f5AWnYhuPTxhprvi?=
 =?iso-8859-1?Q?oSF2MhXHLpNuioxN7dB6Bo5Q+GhpsqnwhR5JP/TJzSJf5M6GV0ll23aGGD?=
 =?iso-8859-1?Q?zQdAXlofLhejdqnQ5FUXIfC69th+hyLLPp6TDxeDJU0kJIgkYEf6ch2xqF?=
 =?iso-8859-1?Q?lpf4p+dhpG2JrlzwEF/l4NgNyZhCWyQmPtPwWE4ViFnTajOnoxRNUQ67jJ?=
 =?iso-8859-1?Q?60BnWF8lEU6piB/8iir/w79JRWv/AUlj3Ill8SEzEnsBOkHe+OpPNF0Eep?=
 =?iso-8859-1?Q?zALua1xq9i0sdTT8lCtlg/dJyhOyPjG7ENaGIz4SQP52FeJJx2zzyCftIX?=
 =?iso-8859-1?Q?sPs9dLcD6QR22NmU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+eZ4PbDGKpnwMRzb7ikkj7u+9ZGzKFMz11zxhM4fVbhQlsZ6EUu6LCTefr?=
 =?iso-8859-1?Q?xRcf8x5WNhMLfQBGiC30ZTwHv6070BMqIDet0FU+PkfviQZDyQhAB4uOs+?=
 =?iso-8859-1?Q?FPgkBn8+l8U2yZXf5Cb9sFA4X0AKc+J2Iy3iuqIt//UMmc6fs1TlghIsS0?=
 =?iso-8859-1?Q?SIozCYOS9MN0bXCeWSfeS7JUl/jSn01FR6oVC1OuAGco4weBV3TqXI2IG0?=
 =?iso-8859-1?Q?5h8P966/6XWXTDs1Wfc2IQpo03vO/kppfUNqmQIs6Y+T9wxvd92lgYFYx2?=
 =?iso-8859-1?Q?JxLhd9OgoHpFWC7H7fHJr165tsmRqxoSRcwyNOTrxC7xq4HxrSQsp7JGBa?=
 =?iso-8859-1?Q?7j4Q4hIB8zPq/7029u+eP1vnSOV34d0XEhpHQc6azRG1CfXluMVImkggQp?=
 =?iso-8859-1?Q?ZQEhQAME1qFFsdX2JkMapupaybsdOWuI3bux8zDClJ2zwCA6RESriUAKLf?=
 =?iso-8859-1?Q?FoF9E0cLwzT6XMdmBmUWGWYxZt/zlCw3bViIii0CHH2zZDG/gyhk1tH7AX?=
 =?iso-8859-1?Q?lNGhRviWCpsMEJWEofiYtY+Sh92J+jOOnWoFx5tBoBDidSZP3/CXVXkc/7?=
 =?iso-8859-1?Q?cRh50t2PGTXte+ncUQIyL1yhpJS1iLhA3wtmtjy+PUF6J9MSEIWAFPOI7K?=
 =?iso-8859-1?Q?imLi9IaJcyfin/u/5ByzXgUqTuUcu1fEmgnHOjShNb6i6wZ3bd0VNPa6op?=
 =?iso-8859-1?Q?2EP0fOVDWKk7HwKbUySGrY+ci9rqy+mbZJVJqsz7zHrmDykGi2/vz9mSm5?=
 =?iso-8859-1?Q?Th2yuzgG0sdvrkqcv/gEJS95VVx9aLpwT0LMQ4aJ+7HLIxVcPr/hm/XRy4?=
 =?iso-8859-1?Q?n6tQHbQBEF08Oy+2565Vl67prQbcJ0f2F6okPiAJG76IE1qLFroOBddAnt?=
 =?iso-8859-1?Q?rLu7syUmIguY6QpRdArbvkaxZCQGxc+Fxpryzj7atet9bJu1TUeIhhIILz?=
 =?iso-8859-1?Q?8VeRDQ58qlNlo8SZNuEtfrrkprHMw3djgxlg5UMvJajTmTthna8tSRhcPY?=
 =?iso-8859-1?Q?oGLyC1ejaqAjwdzzDGhzCv8p0/GkXWGvSiaJNcmzmQehcr9hjNAehHgQE9?=
 =?iso-8859-1?Q?Z5yfATTFzGx6feV7o68Se6sJ0YbqmePnzD4W+5he2wRqfqIfBYD3O5vcta?=
 =?iso-8859-1?Q?YfUnjaaLkL7fFj23xrGdqBS8YKMnPARrvSx3JE5QE+pPhBtkjtBraYPmXk?=
 =?iso-8859-1?Q?zA6H0SkBYlLQZob8VpNI5SFXQNBB9nA9zrThs22MYVSNpvzTQCW7aoJsN1?=
 =?iso-8859-1?Q?APket42/iqNDCjxz7wgqIojqyX7Y1lElRxmOgK/KkMeX+f8r4og1iNhmjw?=
 =?iso-8859-1?Q?h7MhfG/Bo4azC+Y2aD49eEzo/lQA9CzLNPomkiTNc+rH/ggMFLeqfPAnUp?=
 =?iso-8859-1?Q?uwIyBQ4PWS7cALY87IJYcSsSjkdYlR42m9sbG2ZwlVr6aUbSlRtXx+4414?=
 =?iso-8859-1?Q?twXXm7Cf3AElATVdZe5ZlaUhwNw12ONTa7wHHRYzrmY9mabpXp7ixFwqz5?=
 =?iso-8859-1?Q?zfBIi2Ru0V2aw5zVbxGp3E9xTXHrvyYqGwkWz+o0OBL6y0AezWmekhnrnw?=
 =?iso-8859-1?Q?2w0lM20YJPmzOZP894tRedV2rJJ40AUeFcnX7TZG1PpHefRpZlNfdMI2y8?=
 =?iso-8859-1?Q?NCkan2Obu+LfPc1FroLgRM7TCwUHYxKZ10nQAg/LnpEUrD3lTquCy0lA?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1a35cb-9657-41bd-b578-08dd3f10e8dd
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2025 20:26:41.7630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/oREJr+KuQLqvNaxKP69hBJTj5QKTV5lDDAtXZLUHAvPl0uZNtyYQhZ35bsl7W/10fqqiG/cp3PZr0opvzrecdCmmzLMqjVFy7YhGJu9F0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7110
X-OriginatorOrg: intel.com

On Thu, Jan 23, 2025 at 01:14:45PM -0800, John Harrison wrote:
>On 1/23/2025 12:22, José Roberto de Souza wrote:
>>From: Lucas De Marchi <lucas.demarchi@intel.com>
>>
>>Commit 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa
>>debug tool") partially reverted some changes to workaround breakage
>>caused to mesa tools. However, in doing so it also broke fetching the
>>GuC log via debugfs since xe_print_blob_ascii85() simply bails out.
>>
>>The fix is to avoid the extra newlines: the devcoredump interface is
>>line-oriented and adding random newlines in the middle breaks it. If a
>>tool is able to parse it by looking at the data and checking for chars
>>that are out of the ascii85 space, it can still do so. A format change
>>that breaks the line-oriented output on devcoredump however needs better
>>coordination with existing tools.
>>
>>v2:
>>- added suffix description comment
>>
>>Reviewed-by: José Roberto de Souza <jose.souza@intel.com>
>>Cc: John Harrison <John.C.Harrison@Intel.com>
>>Cc: Julia Filipchuk <julia.filipchuk@intel.com>
>>Cc: José Roberto de Souza <jose.souza@intel.com>
>>Cc: stable@vger.kernel.org
>>Fixes: 70fb86a85dc9 ("drm/xe: Revert some changes that break a mesa debug tool")
>>Fixes: ec1455ce7e35 ("drm/xe/devcoredump: Add ASCII85 dump helper function")
>>Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
>>---
>>  drivers/gpu/drm/xe/xe_devcoredump.c | 33 +++++++++++------------------
>>  drivers/gpu/drm/xe/xe_devcoredump.h |  2 +-
>>  drivers/gpu/drm/xe/xe_guc_ct.c      |  3 ++-
>>  drivers/gpu/drm/xe/xe_guc_log.c     |  4 +++-
>>  4 files changed, 18 insertions(+), 24 deletions(-)
>>
>>diff --git a/drivers/gpu/drm/xe/xe_devcoredump.c b/drivers/gpu/drm/xe/xe_devcoredump.c
>>index 81dc7795c0651..6f73b1ba0f2aa 100644
>>--- a/drivers/gpu/drm/xe/xe_devcoredump.c
>>+++ b/drivers/gpu/drm/xe/xe_devcoredump.c
>>@@ -395,42 +395,33 @@ int xe_devcoredump_init(struct xe_device *xe)
>>  /**
>>   * xe_print_blob_ascii85 - print a BLOB to some useful location in ASCII85
>>   *
>>- * The output is split to multiple lines because some print targets, e.g. dmesg
>>- * cannot handle arbitrarily long lines. Note also that printing to dmesg in
>>- * piece-meal fashion is not possible, each separate call to drm_puts() has a
>>- * line-feed automatically added! Therefore, the entire output line must be
>>- * constructed in a local buffer first, then printed in one atomic output call.
>>+ * The output is split to multiple print calls because some print targets, e.g.
>>+ * dmesg cannot handle arbitrarily long lines. These targets may add newline
>>+ * between calls.
>As per earlier comments, this change implies that dmesg output is now 
>supported as long as a newline is added between calls. That is very 
>definitely not the case.

no, this is saying that a \n may be added by the printer itself, i.e.
the printer handling dmesg output, not that the caller has to add \n
between calls to xe_print_blob_ascii85() to support dmesg.

>
>>   *
>>   * There is also a scheduler yield call to prevent the 'task has been stuck for
>>   * 120s' kernel hang check feature from firing when printing to a slow target
>>   * such as dmesg over a serial port.
>>   *
>>- * TODO: Add compression prior to the ASCII85 encoding to shrink huge buffers down.
>>- *
>>   * @p: the printer object to output to
>>   * @prefix: optional prefix to add to output string
>>+ * @suffix: optional suffix to add at the end. 0 disables it and is
>>+ *          not added to the output, which is useful when using multiple calls
>>+ *          to dump data to @p
>>   * @blob: the Binary Large OBject to dump out
>>   * @offset: offset in bytes to skip from the front of the BLOB, must be a multiple of sizeof(u32)
>>   * @size: the size in bytes of the BLOB, must be a multiple of sizeof(u32)
>>   */
>>-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>>+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>>  			   const void *blob, size_t offset, size_t size)
>>  {
>>  	const u32 *blob32 = (const u32 *)blob;
>>  	char buff[ASCII85_BUFSZ], *line_buff;
>>  	size_t line_pos = 0;
>>-	/*
>>-	 * Splitting blobs across multiple lines is not compatible with the mesa
>>-	 * debug decoder tool. Note that even dropping the explicit '\n' below
>>-	 * doesn't help because the GuC log is so big some underlying implementation
>>-	 * still splits the lines at 512K characters. So just bail completely for
>>-	 * the moment.
>>-	 */
>>-	return;
>>-
>>  #define DMESG_MAX_LINE_LEN	800
>>-#define MIN_SPACE		(ASCII85_BUFSZ + 2)		/* 85 + "\n\0" */
>>+	/* Always leave space for the suffix char and the \0 */
>>+#define MIN_SPACE		(ASCII85_BUFSZ + 2)	/* 85 + "<suffix>\0" */
>>  	if (size & 3)
>>  		drm_printf(p, "Size not word aligned: %zu", size);
>>@@ -462,7 +453,6 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>>  		line_pos += strlen(line_buff + line_pos);
>>  		if ((line_pos + MIN_SPACE) >= DMESG_MAX_LINE_LEN) {
>>-			line_buff[line_pos++] = '\n';
>Again, as already commented, do not completely remove this line. It is 
>an absolute requirement for dmesg output. And dmesg output is an 
>important debug facility.
>
>It should be temporarily commented out with a comment saying "this is 
>required for dumping to dmesg but currently breaks a mesa debug tool 
>so is disabled by default". That way it is clear what a developer 
>needs to do to re-enable dmesg output locally.

We don't keep code commented out. Or dead code. When it's fixed it will
likely not be about uncommenting it.  Commenting it only delays the
proper fix to land and makes the problem to exist for more time than it
should. If you are giving instructions for people to uncomment code in this
function to make it work, what's the incentive to fix it?

I think there was enough time for a fix to land, but it never happened.
I also complained about people just trying to improve the workaround
rather than fixing the underlying issue.

I added a debugfs file to "cat the guc log to dmesg" and added
trace_printk(... "\n") calls to xe_print_blob_ascii85(). With the
exception of the different prefixes, there was no diff between the output
produced in /dev/kmsg and in the trace ring buffer. It may be because of
my limited test with a 300k output buffer, but I have no reason to
believe this \n would make any difference.

If my testing was incomplete, we can fix the dmesg output or migrate to
something else rather than rewording a comment or commenting code out.

Lucas De Marchi

>
>>  			line_buff[line_pos++] = 0;
>>  			drm_puts(p, line_buff);
>>@@ -474,10 +464,11 @@ void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>>  		}
>>  	}
>>+	if (suffix)
>>+		line_buff[line_pos++] = suffix;
>>+
>>  	if (line_pos) {
>>-		line_buff[line_pos++] = '\n';
>>  		line_buff[line_pos++] = 0;
>>-
>>  		drm_puts(p, line_buff);
>>  	}
>>diff --git a/drivers/gpu/drm/xe/xe_devcoredump.h b/drivers/gpu/drm/xe/xe_devcoredump.h
>>index 6a17e6d601022..5391a80a4d1ba 100644
>>--- a/drivers/gpu/drm/xe/xe_devcoredump.h
>>+++ b/drivers/gpu/drm/xe/xe_devcoredump.h
>>@@ -29,7 +29,7 @@ static inline int xe_devcoredump_init(struct xe_device *xe)
>>  }
>>  #endif
>>-void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix,
>>+void xe_print_blob_ascii85(struct drm_printer *p, const char *prefix, char suffix,
>>  			   const void *blob, size_t offset, size_t size);
>>  #endif
>>diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
>>index 8b65c5e959cc2..50c8076b51585 100644
>>--- a/drivers/gpu/drm/xe/xe_guc_ct.c
>>+++ b/drivers/gpu/drm/xe/xe_guc_ct.c
>>@@ -1724,7 +1724,8 @@ void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot,
>>  			   snapshot->g2h_outstanding);
>>  		if (snapshot->ctb)
>>-			xe_print_blob_ascii85(p, "CTB data", snapshot->ctb, 0, snapshot->ctb_size);
>>+			xe_print_blob_ascii85(p, "CTB data", '\n',
>>+					      snapshot->ctb, 0, snapshot->ctb_size);
>>  	} else {
>>  		drm_puts(p, "CT disabled\n");
>>  	}
>>diff --git a/drivers/gpu/drm/xe/xe_guc_log.c b/drivers/gpu/drm/xe/xe_guc_log.c
>>index 80151ff6a71f8..44482ea919924 100644
>>--- a/drivers/gpu/drm/xe/xe_guc_log.c
>>+++ b/drivers/gpu/drm/xe/xe_guc_log.c
>>@@ -207,8 +207,10 @@ void xe_guc_log_snapshot_print(struct xe_guc_log_snapshot *snapshot, struct drm_
>>  	remain = snapshot->size;
>>  	for (i = 0; i < snapshot->num_chunks; i++) {
>>  		size_t size = min(GUC_LOG_CHUNK_SIZE, remain);
>>+		const char *prefix = i ? NULL : "Log data";
>>+		char suffix = i == snapshot->num_chunks - 1 ? '\n' : 0;
>>-		xe_print_blob_ascii85(p, i ? NULL : "Log data", snapshot->copy[i], 0, size);
>>+		xe_print_blob_ascii85(p, prefix, suffix, snapshot->copy[i], 0, size);
>I thought you were saying that these need to follow the mesa 
>requirement of "[name].length" + "[name].data"?
>
>John.
>
>
>>  		remain -= size;
>>  	}
>>  }
>

