Return-Path: <stable+bounces-141831-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EB6AAC8F3
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 16:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D66E7AFAA8
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 14:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4255628315D;
	Tue,  6 May 2025 14:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EdmtYqVy"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDB0283152
	for <stable@vger.kernel.org>; Tue,  6 May 2025 14:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746543480; cv=fail; b=N7Swdea3WCdEsV+NT5GyP0MXawhmwvzLfT8U04YZXmn5BaN5mmeWF5zsscFaATtCfRIp+NryEMkB0kfZsO/QtD56cinIVZekD1/m8SDJaTF+yuKyeHFYnH1xxj4jAnElTIA06gv5xoBoS8vPv2zAWkawTxnas4S5+bgUZJx9VlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746543480; c=relaxed/simple;
	bh=59K8KFSds0gc/4OdFfURo+Hoy0nKToQ6wTd28k/cTvo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S4ct6+G5ggQi6XuEOIs178Ur7rUDQplrmt07AsUqjlgEide6lFKRq+5LX1yJ6SzBRaakmXkVUNKn5M03AFznKR5EX0sa94+7+W+M9iPTMUhTnyfuPcYrO13QKlT9RG501TqEl+vQb98O6mc9e5L4ihypna2AVtSI4xtOMmkivS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EdmtYqVy; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746543477; x=1778079477;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=59K8KFSds0gc/4OdFfURo+Hoy0nKToQ6wTd28k/cTvo=;
  b=EdmtYqVyhD5cXPPRqtlPldAV5L8Ygwkx14midRuplACmg+l+CH3P4YK6
   nKoXyZ36Zxjley61fuS3SUkWZs/pYHGKGJwoG7QHOsRyIAaIPKgoXpWm/
   P3tFMhxh5LoEoSELXpThzuC7AMxKtqxec4QlBscY8IyAQQC6uHVgM5xIu
   UqEqqfxjh0V0KN1U5sfM5IU8hzPO0HRXI0Xix1YAiPVO533rHmRHvAaaw
   tPOio+ByTEsGK7f/svdcz+CSrPzQQwB3/wx8f/L7mgODenRUmVDi8zK2c
   p1xQkG5qHTeO4aByKqbek/jUkcWeFDuiCKqZ1EY6GN3JYPqq5MGjJSFjK
   A==;
X-CSE-ConnectionGUID: NdjPWBNnSMmxau7P1NDa6A==
X-CSE-MsgGUID: 9qb+qplOQBOa8dY1Lbxl+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="65629055"
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="65629055"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 07:57:57 -0700
X-CSE-ConnectionGUID: Vbj/9cc6QUKJBvueZ8b4wg==
X-CSE-MsgGUID: npMLexyvSXK+JJJXkiEUnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,266,1739865600"; 
   d="scan'208";a="158916128"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 07:57:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 07:57:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 6 May 2025 07:57:56 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 6 May 2025 07:57:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d+tYimWb9E7kOTqSX6MusVRT/pWl7DZZ307KXoJgbMgy31sMTRxjTM3wEkQr7gYknCb2f48CpG8JMhCBFI80wDV5p7/PgC+UAGvDtY2vNezzv8bgoq5oY+WwomI5yFMaDQlCXAz+HEpvUqjGyLh2g0WoF641nXzAv1MVWohxKMyRvB59zVc3JoGymRXdhgpIxeZva5U87j+27QrZI+WMLCGXVsPDWVAS6xvyKney79OIyTmzHBnJco+aWBjky7zybAVzuybAY4A+Nl1HmXZ24dtXc15n/RW6lnMZRJ/rF95r1eqWhNV52cISLYAapGGOWzaJP+WwURQjkZCvn+ACug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgAfiRqM+eXSdZNvCqW+r+NUYJqo4Lk5DkezmUA+PxI=;
 b=BAkjGDQt7d/lx9qHQsKtzZO6FB433IneCBWvV5U3y8Nxapm1BYOiWMQWm6PmumIOqkSanIVuvBIib0/Xx86W5PoaGBvflslT/AvIEMv+5+df5QHdL4/T0Gexuzn8lvU4UY/2aljHu8auvwCsX9/dOBv+RWUE1nLFnxvIp9yb0bAYehLVxEBcWQfvH09W5EZihVfXUUkwyOy7exbl4I2nACTRL+JgtB80GXFvCUuBvxLUfXZwyaGhw0VGcGi6iCp7N3fj9AFclFB3U8En/vKi2v1eB08szzoAkm5tXxyLbS2xVx7X5uUTs9HEDaFJROeXUulmngwPkKumAq9K/Mbznw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CH0PR11MB5219.namprd11.prod.outlook.com (2603:10b6:610:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 14:57:47 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::9e94:e21f:e11a:332%4]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 14:57:47 +0000
Date: Tue, 6 May 2025 07:59:12 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	<intel-xe@lists.freedesktop.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v6 02/20] drm/xe: Strict migration policy for atomic SVM
 faults
Message-ID: <aBojwPBS6nD5dC7I@lstrano-desk.jf.intel.com>
References: <20250430121912.337601-1-himal.prasad.ghimiray@intel.com>
 <20250430121912.337601-3-himal.prasad.ghimiray@intel.com>
 <0e60fc015731a15c9cc9b3eac2959c693a52f2d3.camel@linux.intel.com>
 <aBkdKgkLcvRt6grB@lstrano-desk.jf.intel.com>
 <7ae64c5a718088122d3f686eddb019264a6c5662.camel@linux.intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ae64c5a718088122d3f686eddb019264a6c5662.camel@linux.intel.com>
X-ClientProxiedBy: MW4P221CA0025.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::30) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CH0PR11MB5219:EE_
X-MS-Office365-Filtering-Correlation-Id: 4010f672-9157-4df1-96dd-08dd8cae5d6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?ZareRdW3NzgeO0gR1ZJzN7ZWuzWkrHoMauhi9doh/APeiOQyrOui6RdnHQ?=
 =?iso-8859-1?Q?fmbxyXqiP5WY2k13tAwI7WPEc1447OsBteNnER8hFk64ahUY7XH/kXGRtR?=
 =?iso-8859-1?Q?7B950ClVtS7XoVxvIzWpJznuq1J5EdAk7YGZgkCLiMTAoiKp8rHEX3oHCf?=
 =?iso-8859-1?Q?yiUb0E87CCXZSypGFx/RC5eD5d7GNG5pst7eZABrQGQ4sVe4AzkiP9PJt0?=
 =?iso-8859-1?Q?H4heyplVYMrsJBVX/DUa7kg42VEMNcVNB5eInO5PUPyPLVsjW3ng2EZ08P?=
 =?iso-8859-1?Q?lg0jbXVujYuhm5VYQ5YTY345KkctPcjl12JPIWtZnFJJLkDqOKHF1sp1bK?=
 =?iso-8859-1?Q?6E/LlvNMmZ8gHCqe8ZZzoLYxGDjlLMLXigf+68MmB5xSXsAcWSSpZ72Qk9?=
 =?iso-8859-1?Q?GlXIMP1t0Rx/czjOOuKesbiF8rsq1CsJIxgmeyKyFRWgnCpmiCQzKnPomZ?=
 =?iso-8859-1?Q?rylPulw67FcGS4KUl8XRLcBHt7cG4+mWIHtuqoCAjfiVXAZhlB2enJF0AD?=
 =?iso-8859-1?Q?Het9xiBmzbyfVCrOQajSd1j26LONQAMzJ4O4UYRNjN/KLTsPPw6zPRyrt7?=
 =?iso-8859-1?Q?jHQWWEFeVfN0A+R71CiBacJk4l9OmpIrxxjclWmowZ+YtRJg4dwWVxkmqa?=
 =?iso-8859-1?Q?/b9lO8CArnzaDt2kocwPrtxfUe/YbQKJhYuqEDaNF8RCxQz53zxW4ZgWws?=
 =?iso-8859-1?Q?d9uyeHcFALPYChWKsXqmUP+GKtiwCIrPiTo/kCnkXnhdPjldojaksMfKO4?=
 =?iso-8859-1?Q?K2pM3N9PhXV0DyGW1UYRyY7dzhvJbqEOfNwWX1Uxuw51TP7X1teq+pAbae?=
 =?iso-8859-1?Q?IJCHtKlBR62qV61l+OlbZynmiLwSW6IfQ/28wsW89rOfGGW/3u4Bp7/pHR?=
 =?iso-8859-1?Q?4OOdaXUmq1hp7D8zuOg+aqPrZLXki0ZOrPGV+7JXkNq+XnwaKezup/LYHK?=
 =?iso-8859-1?Q?anqrL9TbtwQSVgYpOTHDhlI8XZ/X0NRLcIY/fZDvjIPuzwKUaLw3iqj41E?=
 =?iso-8859-1?Q?C6s3EkOgJ98VMSNzs1hyz/sr7xwC7QyE97A+MQSHux+nJVkigasHnSk8GB?=
 =?iso-8859-1?Q?kvxCzU29PaUmeTZExRdK5cKU85+hekzoj5EpLyrW0wXnvBZXttse3hwzEo?=
 =?iso-8859-1?Q?fVzN4o5PXOaac76sO0CCQRYc0YgaplAHY+6mgedTTMpXIzarGftceHRfkh?=
 =?iso-8859-1?Q?kFqfmzDkgLLj12lxw1+C7wnXbZ5c7byFHnr7dQnzbdeiP7JzotAZXLG/9f?=
 =?iso-8859-1?Q?Nm8HShES84Z33sslGYkP7/5NYAT6LA/xcC3yPC5t6mZ0xXfOFPN0mXE+7g?=
 =?iso-8859-1?Q?MCB7/JFtZY7C9UrEsD6hSFl2lrh/wICPVt8Hsrlwvdt+407jYbYLSJO3Yq?=
 =?iso-8859-1?Q?kXfishEjVECAnhEZUTPOh7nqB68rsuLJXYWHAd5kTp+ECNYeS5yZ/JOuue?=
 =?iso-8859-1?Q?dXY3SG5HvdoPJN6T0xtdbHOw9bZpvwJ8zNNHRsmtqR4Q/BrPOpUnRBWuJl?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6522.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QnFg624w2fhFS6GtxSCXzW+eFtEaW7OV/7wmsyZvBA7+R+eaX+jdRwpXAy?=
 =?iso-8859-1?Q?jDpSB7p+p/jRnIiG9VS6gEXNf9W+gvGjW8zGglcU8TKHsSt7btHbHcqmZY?=
 =?iso-8859-1?Q?dch6Zh5ql2CLkmofaCX3NjyiIOzzAVDltifF4gBJhYfT89/0ApeMf4c7zs?=
 =?iso-8859-1?Q?9boWH8Yf+rF7XOPl5jbSpMXwmhWhaho42IfZClL22nIw+6VUfsSMmPQDH4?=
 =?iso-8859-1?Q?EZZbeLOGxembP6b0gseMPmRt14vFDWKwC6j0wkYwLlCX1KMOfPNjzMpOpb?=
 =?iso-8859-1?Q?t7OkJOdAsar6zjj8TjTDRSL65VbRmMoPzUqay7vB53UHlIXfdFrZY29p9b?=
 =?iso-8859-1?Q?rmLxYLafLmyNKRx4eiqbbqww3SG94/2tk+dX8ubja/VG9S0ospkILPhOwE?=
 =?iso-8859-1?Q?bZq4PVs6e8KJ9U/9SWlelcdUcEXpccYQ6iRCOHTSe9Okyadfx4CjBNj3aD?=
 =?iso-8859-1?Q?N72sBBeBdFSTPU6gr2CxSx2ErC7HWj/MCrQUB2UvSkCoa+iI/C+3kU6fvr?=
 =?iso-8859-1?Q?rHcWrHxEu5CxVwNJM91iB2MVFVQmQisrepztEufODMHqTjp1g0r1kyFKgE?=
 =?iso-8859-1?Q?QWSU4M+Jpj0214LbxYd21I51PEhXeHIrOitNgyLgKAmEL4kIvATXc2AT0t?=
 =?iso-8859-1?Q?IlpWWX+vSzDSH2hLdXmkvVUFqJ3ixNThsO8k4lwKStcNV3laWp0IbBqqPK?=
 =?iso-8859-1?Q?sjNIprR4FJQafta3MDDmrWukS+aldMU6eNLXualDOIEzmYVvRfJB3gxkff?=
 =?iso-8859-1?Q?SUjn6aMmZz54Z4lc5SQH15xWqe5JKsXkN3LRE+CxlAU5rI7usWsfwVqHxv?=
 =?iso-8859-1?Q?jN+DSEmOiOWoeWyHH9Qnf6xbtOzjACiaZsJeIiXNWO/OWo3mspz+V4vUV0?=
 =?iso-8859-1?Q?50alHy8CnnwewaZOu7PU4jlecp04o4tSrRSuCigxek7tg4TKnX416RT34V?=
 =?iso-8859-1?Q?jxFjpf3lRFyAviznj1DfzBPcJV1Ohi+S/9xOnd6fxL1ZXrEj0CS3f2iiO5?=
 =?iso-8859-1?Q?FPOrnH1yVrbEBvEVfw28ms91PPW2meeppj9Vb3xUaD71xuqoCT6o480qNz?=
 =?iso-8859-1?Q?BkJMfMr7Uyhb/e0GrN6FuvRXWcET1h0UXXTBvDlMCMy3iiMjz4NqjPRM/A?=
 =?iso-8859-1?Q?qSa0C8MV0TGsY6LKOy8aHVPbW0JUXJm6m6+rDGiXmSpviMOTd9Pm4msScN?=
 =?iso-8859-1?Q?NAoAJmJ7Wjxwh3A/oTnSayEBa1yfniFezSnr5NLRqZR9im3ApQ2iKFyJUV?=
 =?iso-8859-1?Q?SvBRhQTtFwl5BNIYZGElZSC80HGbjfvQrwykkftO4KVZDdkBpa8x1bevU4?=
 =?iso-8859-1?Q?wedfQecOVcQV7uLgJx3bY2IyonY5wqRcXSSyMuRbvy0sl5bUmF5r99VWFQ?=
 =?iso-8859-1?Q?djg1koPdOTer9EDd4hpQ5tXx1dPWQ1/DagUkaHFATXJ0wkQ6Cjqafhh0tA?=
 =?iso-8859-1?Q?YqqfjVZftc+rOrVKkavB8j2sNECbc9NbXEwZr+Owyn0CnZfZn666Yw4toi?=
 =?iso-8859-1?Q?RuCqywdHVxFg+6KDGXdoVU5CmTYvM1bY6dp4iDmQ+O4AQiwnU8r8P9cgyh?=
 =?iso-8859-1?Q?lmAztrZwX+rmjPylv8XgqJ+y7Qcmjt7xK5ksUHH2gKj6Oe+8zboKFskThk?=
 =?iso-8859-1?Q?2gJLDA5Bsse0GK9/ShFmw86wHCnkclS2FqovhkjnVo5CyazoEC9DPE7A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4010f672-9157-4df1-96dd-08dd8cae5d6c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:57:47.7764
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MKzAirqJrC2O0LEqSkhPJ1SqkPilxEdagtgf7nEM1B8N7Lg8ozXjduZrLgpFTOrCkYu+lk7v5mOuq0mXRYB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5219
X-OriginatorOrg: intel.com

On Tue, May 06, 2025 at 12:13:34PM +0200, Thomas Hellström wrote:
> On Mon, 2025-05-05 at 13:18 -0700, Matthew Brost wrote:
> > On Mon, May 05, 2025 at 05:20:00PM +0200, Thomas Hellström wrote:
> > > Hi, Himal,
> > > 
> > > On Wed, 2025-04-30 at 17:48 +0530, Himal Prasad Ghimiray wrote:
> > > > From: Matthew Brost <matthew.brost@intel.com>
> > > > 
> > > > Mixing GPU and CPU atomics does not work unless a strict
> > > > migration
> > > > policy of GPU atomics must be device memory. Enforce a policy of
> > > > must
> > > > be
> > > > in VRAM with a retry loop of 3 attempts, if retry loop fails
> > > > abort
> > > > fault.
> > > > 
> > > > Removing always_migrate_to_vram modparam as we now have real
> > > > migration
> > > > policy.
> > > > 
> > > > v2:
> > > >  - Only retry migration on atomics
> > > >  - Drop alway migrate modparam
> > > > v3:
> > > >  - Only set vram_only on DGFX (Himal)
> > > >  - Bail on get_pages failure if vram_only and retry count
> > > > exceeded
> > > > (Himal)
> > > >  - s/vram_only/devmem_only
> > > >  - Update xe_svm_range_is_valid to accept devmem_only argument
> > > > v4:
> > > >  - Fix logic bug get_pages failure
> > > > v5:
> > > >  - Fix commit message (Himal)
> > > >  - Mention removing always_migrate_to_vram in commit message
> > > > (Lucas)
> > > >  - Fix xe_svm_range_is_valid to check for devmem pages
> > > >  - Bail on devmem_only && !migrate_devmem (Thomas)
> > > > v6:
> > > >  - Add READ_ONCE barriers for opportunistic checks (Thomas)
> > > > 
> > > > Fixes: 2f118c949160 ("drm/xe: Add SVM VRAM migration")
> > > > Cc: stable@vger.kernel.org
> > > > Signed-off-by: Himal Prasad Ghimiray
> > > > <himal.prasad.ghimiray@intel.com>
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > Acked-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > > ---
> > > >  drivers/gpu/drm/xe/xe_module.c |   3 -
> > > >  drivers/gpu/drm/xe/xe_module.h |   1 -
> > > >  drivers/gpu/drm/xe/xe_svm.c    | 103 ++++++++++++++++++++++++---
> > > > ----
> > > > --
> > > >  drivers/gpu/drm/xe/xe_svm.h    |   5 --
> > > >  include/drm/drm_gpusvm.h       |  40 ++++++++-----
> > > >  5 files changed, 103 insertions(+), 49 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_module.c
> > > > b/drivers/gpu/drm/xe/xe_module.c
> > > > index 64bf46646544..e4742e27e2cd 100644
> > > > --- a/drivers/gpu/drm/xe/xe_module.c
> > > > +++ b/drivers/gpu/drm/xe/xe_module.c
> > > > @@ -30,9 +30,6 @@ struct xe_modparam xe_modparam = {
> > > >  module_param_named(svm_notifier_size,
> > > > xe_modparam.svm_notifier_size,
> > > > uint, 0600);
> > > >  MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier
> > > > size(in
> > > > MiB), must be power of 2");
> > > >  
> > > > -module_param_named(always_migrate_to_vram,
> > > > xe_modparam.always_migrate_to_vram, bool, 0444);
> > > > -MODULE_PARM_DESC(always_migrate_to_vram, "Always migrate to VRAM
> > > > on
> > > > GPU fault");
> > > > -
> > > >  module_param_named_unsafe(force_execlist,
> > > > xe_modparam.force_execlist, bool, 0444);
> > > >  MODULE_PARM_DESC(force_execlist, "Force Execlist submission");
> > > >  
> > > > diff --git a/drivers/gpu/drm/xe/xe_module.h
> > > > b/drivers/gpu/drm/xe/xe_module.h
> > > > index 84339e509c80..5a3bfea8b7b4 100644
> > > > --- a/drivers/gpu/drm/xe/xe_module.h
> > > > +++ b/drivers/gpu/drm/xe/xe_module.h
> > > > @@ -12,7 +12,6 @@
> > > >  struct xe_modparam {
> > > >  	bool force_execlist;
> > > >  	bool probe_display;
> > > > -	bool always_migrate_to_vram;
> > > >  	u32 force_vram_bar_size;
> > > >  	int guc_log_level;
> > > >  	char *guc_firmware_path;
> > > > diff --git a/drivers/gpu/drm/xe/xe_svm.c
> > > > b/drivers/gpu/drm/xe/xe_svm.c
> > > > index 890f6b2f40e9..dcc84e65ca96 100644
> > > > --- a/drivers/gpu/drm/xe/xe_svm.c
> > > > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > > > @@ -16,8 +16,12 @@
> > > >  
> > > >  static bool xe_svm_range_in_vram(struct xe_svm_range *range)
> > > >  {
> > > > -	/* Not reliable without notifier lock */
> > > > -	return range->base.flags.has_devmem_pages;
> > > > +	/* Not reliable without notifier lock, opportunistic
> > > > only */
> > > > +	struct drm_gpusvm_range_flags flags = {
> > > > +		.__flags = READ_ONCE(range->base.flags.__flags),
> > > > +	};
> > > > +
> > > > +	return flags.has_devmem_pages;
> > > >  }
> > > >  
> > > >  static bool xe_svm_range_has_vram_binding(struct xe_svm_range
> > > > *range)
> > > > @@ -650,9 +654,13 @@ void xe_svm_fini(struct xe_vm *vm)
> > > >  }
> > > >  
> > > >  static bool xe_svm_range_is_valid(struct xe_svm_range *range,
> > > > -				  struct xe_tile *tile)
> > > > +				  struct xe_tile *tile,
> > > > +				  bool devmem_only)
> > > >  {
> > > > -	return (range->tile_present & ~range->tile_invalidated)
> > > > &
> > > > BIT(tile->id);
> > > > +	/* Not reliable without notifier lock, opportunistic
> > > > only */
> > > > +	return ((READ_ONCE(range->tile_present) &
> > > > +		 ~READ_ONCE(range->tile_invalidated)) &
> > > > BIT(tile-
> > > > > id)) &&
> > > > +		(!devmem_only || xe_svm_range_in_vram(range));
> > > >  }
> > > 
> > > Hmm, TBH I had something more elaborate in mind:
> > > 
> > > https://lore.kernel.org/intel-xe/b5569de8cc036e23b976f21a51c4eb5ca104d4bb.camel@linux.intel.com/
> > > 
> > > (Separate function for lockless access and a lockdep assert for
> > > locked
> > > access + similar documentation as the functions I mentioned there +
> > > a
> > > "Pairs with" comment.
> > > 
> > 
> > But if the locked functions are unused wouldn't the compiler
> > complain?
> 
> Oh, I was under the impression we had multiple ose of those. My bad.
> 
> But still IMO we should move that comment about opportunistic from
> within the function to the header to clarify the usage of the function
> interface, and close to the READ_ONCE we should add a comment about a
> pairing WRITE_ONCE.
> 

Ah, ok. I missed the WRITE_ONCE side of this + comment.

> It actually looks like (for a future patch unless done in this one) the
> atomic bitops is a good fit for this.

Maybe? I'll probably stick with WRITE_ONCE pairing for now.

Matt

> 
> /Thomas
> 
> 
> 
> > 
> > Matt
> > 
> > > Thanks,
> > > Thomas
> > > 
> > > 
> > > 
> > > >  
> > > >  #if IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR)
> > > > @@ -726,6 +734,36 @@ static int xe_svm_alloc_vram(struct xe_vm
> > > > *vm,
> > > > struct xe_tile *tile,
> > > >  }
> > > >  #endif
> > > >  
> > > > +static bool supports_4K_migration(struct xe_device *xe)
> > > > +{
> > > > +	if (xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
> > > > +		return false;
> > > > +
> > > > +	return true;
> > > > +}
> > > > +
> > > > +static bool xe_svm_range_needs_migrate_to_vram(struct
> > > > xe_svm_range
> > > > *range,
> > > > +					       struct xe_vma
> > > > *vma)
> > > > +{
> > > > +	struct xe_vm *vm = range_to_vm(&range->base);
> > > > +	u64 range_size = xe_svm_range_size(range);
> > > > +
> > > > +	if (!range->base.flags.migrate_devmem)
> > > > +		return false;
> > > > +
> > > > +	/* Not reliable without notifier lock, opportunistic
> > > > only */
> > > > +	if (xe_svm_range_in_vram(range)) {
> > > > +		drm_dbg(&vm->xe->drm, "Range is already in
> > > > VRAM\n");
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	if (range_size <= SZ_64K && !supports_4K_migration(vm-
> > > > >xe))
> > > > {
> > > > +		drm_dbg(&vm->xe->drm, "Platform doesn't support
> > > > SZ_4K range migration\n");
> > > > +		return false;
> > > > +	}
> > > > +
> > > > +	return true;
> > > > +}
> > > >  
> > > >  /**
> > > >   * xe_svm_handle_pagefault() - SVM handle page fault
> > > > @@ -750,12 +788,15 @@ int xe_svm_handle_pagefault(struct xe_vm
> > > > *vm,
> > > > struct xe_vma *vma,
> > > >  			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
> > > >  		.check_pages_threshold = IS_DGFX(vm->xe) &&
> > > >  			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR)
> > > > ?
> > > > SZ_64K : 0,
> > > > +		.devmem_only = atomic && IS_DGFX(vm->xe) &&
> > > > +			IS_ENABLED(CONFIG_DRM_XE_DEVMEM_MIRROR),
> > > >  	};
> > > >  	struct xe_svm_range *range;
> > > >  	struct drm_gpusvm_range *r;
> > > >  	struct drm_exec exec;
> > > >  	struct dma_fence *fence;
> > > >  	struct xe_tile *tile = gt_to_tile(gt);
> > > > +	int migrate_try_count = ctx.devmem_only ? 3 : 1;
> > > >  	ktime_t end = 0;
> > > >  	int err;
> > > >  
> > > > @@ -776,24 +817,30 @@ int xe_svm_handle_pagefault(struct xe_vm
> > > > *vm,
> > > > struct xe_vma *vma,
> > > >  	if (IS_ERR(r))
> > > >  		return PTR_ERR(r);
> > > >  
> > > > +	if (ctx.devmem_only && !r->flags.migrate_devmem)
> > > > +		return -EACCES;
> > > > +
> > > >  	range = to_xe_range(r);
> > > > -	if (xe_svm_range_is_valid(range, tile))
> > > > +	if (xe_svm_range_is_valid(range, tile, ctx.devmem_only))
> > > >  		return 0;
> > > >  
> > > >  	range_debug(range, "PAGE FAULT");
> > > >  
> > > > -	/* XXX: Add migration policy, for now migrate range once
> > > > */
> > > > -	if (!range->skip_migrate && range-
> > > > >base.flags.migrate_devmem
> > > > &&
> > > > -	    xe_svm_range_size(range) >= SZ_64K) {
> > > > -		range->skip_migrate = true;
> > > > -
> > > > +	if (--migrate_try_count >= 0 &&
> > > > +	    xe_svm_range_needs_migrate_to_vram(range, vma)) {
> > > >  		err = xe_svm_alloc_vram(vm, tile, range, &ctx);
> > > >  		if (err) {
> > > > -			drm_dbg(&vm->xe->drm,
> > > > -				"VRAM allocation failed, falling
> > > > back to "
> > > > -				"retrying fault, asid=%u,
> > > > errno=%pe\n",
> > > > -				vm->usm.asid, ERR_PTR(err));
> > > > -			goto retry;
> > > > +			if (migrate_try_count ||
> > > > !ctx.devmem_only) {
> > > > +				drm_dbg(&vm->xe->drm,
> > > > +					"VRAM allocation failed,
> > > > falling back to retrying fault, asid=%u, errno=%pe\n",
> > > > +					vm->usm.asid,
> > > > ERR_PTR(err));
> > > > +				goto retry;
> > > > +			} else {
> > > > +				drm_err(&vm->xe->drm,
> > > > +					"VRAM allocation failed,
> > > > retry count exceeded, asid=%u, errno=%pe\n",
> > > > +					vm->usm.asid,
> > > > ERR_PTR(err));
> > > > +				return err;
> > > > +			}
> > > >  		}
> > > >  	}
> > > >  
> > > > @@ -801,15 +848,22 @@ int xe_svm_handle_pagefault(struct xe_vm
> > > > *vm,
> > > > struct xe_vma *vma,
> > > >  	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, r,
> > > > &ctx);
> > > >  	/* Corner where CPU mappings have changed */
> > > >  	if (err == -EOPNOTSUPP || err == -EFAULT || err == -
> > > > EPERM) {
> > > > -		if (err == -EOPNOTSUPP) {
> > > > -			range_debug(range, "PAGE FAULT - EVICT
> > > > PAGES");
> > > > -			drm_gpusvm_range_evict(&vm->svm.gpusvm,
> > > > &range->base);
> > > > +		if (migrate_try_count > 0 || !ctx.devmem_only) {
> > > > +			if (err == -EOPNOTSUPP) {
> > > > +				range_debug(range, "PAGE FAULT -
> > > > EVICT PAGES");
> > > > +				drm_gpusvm_range_evict(&vm-
> > > > > svm.gpusvm,
> > > > +						       &range-
> > > > > base);
> > > > +			}
> > > > +			drm_dbg(&vm->xe->drm,
> > > > +				"Get pages failed, falling back
> > > > to
> > > > retrying, asid=%u, gpusvm=%p, errno=%pe\n",
> > > > +				vm->usm.asid, &vm->svm.gpusvm,
> > > > ERR_PTR(err));
> > > > +			range_debug(range, "PAGE FAULT - RETRY
> > > > PAGES");
> > > > +			goto retry;
> > > > +		} else {
> > > > +			drm_err(&vm->xe->drm,
> > > > +				"Get pages failed, retry count
> > > > exceeded, asid=%u, gpusvm=%p, errno=%pe\n",
> > > > +				vm->usm.asid, &vm->svm.gpusvm,
> > > > ERR_PTR(err));
> > > >  		}
> > > > -		drm_dbg(&vm->xe->drm,
> > > > -			"Get pages failed, falling back to
> > > > retrying,
> > > > asid=%u, gpusvm=%p, errno=%pe\n",
> > > > -			vm->usm.asid, &vm->svm.gpusvm,
> > > > ERR_PTR(err));
> > > > -		range_debug(range, "PAGE FAULT - RETRY PAGES");
> > > > -		goto retry;
> > > >  	}
> > > >  	if (err) {
> > > >  		range_debug(range, "PAGE FAULT - FAIL PAGE
> > > > COLLECT");
> > > > @@ -843,9 +897,6 @@ int xe_svm_handle_pagefault(struct xe_vm *vm,
> > > > struct xe_vma *vma,
> > > >  	}
> > > >  	drm_exec_fini(&exec);
> > > >  
> > > > -	if (xe_modparam.always_migrate_to_vram)
> > > > -		range->skip_migrate = false;
> > > > -
> > > >  	dma_fence_wait(fence, false);
> > > >  	dma_fence_put(fence);
> > > >  
> > > > diff --git a/drivers/gpu/drm/xe/xe_svm.h
> > > > b/drivers/gpu/drm/xe/xe_svm.h
> > > > index 3d441eb1f7ea..0e1f376a7471 100644
> > > > --- a/drivers/gpu/drm/xe/xe_svm.h
> > > > +++ b/drivers/gpu/drm/xe/xe_svm.h
> > > > @@ -39,11 +39,6 @@ struct xe_svm_range {
> > > >  	 * range. Protected by GPU SVM notifier lock.
> > > >  	 */
> > > >  	u8 tile_invalidated;
> > > > -	/**
> > > > -	 * @skip_migrate: Skip migration to VRAM, protected by
> > > > GPU
> > > > fault handler
> > > > -	 * locking.
> > > > -	 */
> > > > -	u8 skip_migrate	:1;
> > > >  };
> > > >  
> > > >  /**
> > > > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> > > > index 9fd25fc880a4..653d48dbe1c1 100644
> > > > --- a/include/drm/drm_gpusvm.h
> > > > +++ b/include/drm/drm_gpusvm.h
> > > > @@ -185,6 +185,31 @@ struct drm_gpusvm_notifier {
> > > >  	} flags;
> > > >  };
> > > >  
> > > > +/**
> > > > + * struct drm_gpusvm_range_flags - Structure representing a GPU
> > > > SVM
> > > > range flags
> > > > + *
> > > > + * @migrate_devmem: Flag indicating whether the range can be
> > > > migrated to device memory
> > > > + * @unmapped: Flag indicating if the range has been unmapped
> > > > + * @partial_unmap: Flag indicating if the range has been
> > > > partially
> > > > unmapped
> > > > + * @has_devmem_pages: Flag indicating if the range has devmem
> > > > pages
> > > > + * @has_dma_mapping: Flag indicating if the range has a DMA
> > > > mapping
> > > > + * @__flags: Flags for range in u16 form (used for READ_ONCE)
> > > > + */
> > > > +struct drm_gpusvm_range_flags {
> > > > +	union {
> > > > +		struct {
> > > > +			/* All flags below must be set upon
> > > > creation
> > > > */
> > > > +			u16 migrate_devmem : 1;
> > > > +			/* All flags below must be set / cleared
> > > > under notifier lock */
> > > > +			u16 unmapped : 1;
> > > > +			u16 partial_unmap : 1;
> > > > +			u16 has_devmem_pages : 1;
> > > > +			u16 has_dma_mapping : 1;
> > > > +		};
> > > > +		u16 __flags;
> > > > +	};
> > > > +};
> > > > +
> > > >  /**
> > > >   * struct drm_gpusvm_range - Structure representing a GPU SVM
> > > > range
> > > >   *
> > > > @@ -198,11 +223,6 @@ struct drm_gpusvm_notifier {
> > > >   * @dpagemap: The struct drm_pagemap of the device pages we're
> > > > dma-
> > > > mapping.
> > > >   *            Note this is assuming only one drm_pagemap per
> > > > range
> > > > is allowed.
> > > >   * @flags: Flags for range
> > > > - * @flags.migrate_devmem: Flag indicating whether the range can
> > > > be
> > > > migrated to device memory
> > > > - * @flags.unmapped: Flag indicating if the range has been
> > > > unmapped
> > > > - * @flags.partial_unmap: Flag indicating if the range has been
> > > > partially unmapped
> > > > - * @flags.has_devmem_pages: Flag indicating if the range has
> > > > devmem
> > > > pages
> > > > - * @flags.has_dma_mapping: Flag indicating if the range has a
> > > > DMA
> > > > mapping
> > > >   *
> > > >   * This structure represents a GPU SVM range used for tracking
> > > > memory ranges
> > > >   * mapped in a DRM device.
> > > > @@ -216,15 +236,7 @@ struct drm_gpusvm_range {
> > > >  	unsigned long notifier_seq;
> > > >  	struct drm_pagemap_device_addr *dma_addr;
> > > >  	struct drm_pagemap *dpagemap;
> > > > -	struct {
> > > > -		/* All flags below must be set upon creation */
> > > > -		u16 migrate_devmem : 1;
> > > > -		/* All flags below must be set / cleared under
> > > > notifier lock */
> > > > -		u16 unmapped : 1;
> > > > -		u16 partial_unmap : 1;
> > > > -		u16 has_devmem_pages : 1;
> > > > -		u16 has_dma_mapping : 1;
> > > > -	} flags;
> > > > +	struct drm_gpusvm_range_flags flags;
> > > >  };
> > > >  
> > > >  /**
> > > 
> 

