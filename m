Return-Path: <stable+bounces-210794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJyHDGATcWlEcgAAu9opvQ
	(envelope-from <stable+bounces-210794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:56:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A80815AD66
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67DEBAEDCCD
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB50626C3BD;
	Wed, 21 Jan 2026 16:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K6IdxZVo"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE7E3271E0
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769013307; cv=fail; b=tEimKwENSNqiya5fOAcm/1OxkZbpUBLZT3xZTFEP/QnMMLvL3WdEsTzgP89bXD6cvvC53In2atxLJnXbHX+j+i8uyEWqfE7b5808Yo52LT9KJ7icUOUqqqppJzpTHqlBpZ02sZMkgHmHPROsdoOW0AR/+StgKhB1pZfxOb1EqnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769013307; c=relaxed/simple;
	bh=JC/V1FTwN91HuxSWAjfyF3ZKsKE+FpJoO58ni4DOTdI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TJKl82Sb3bZIQPu2YKfzm0jCD55R0obpNOQXPM+jBkxbH+5qQxAfuOQwhcAOK6BW0XyjjoVn4+UEEAIn1pGtqzwYgTbhxr78HwBN39suRuJtFtT9JPXuRLEdOC4g+/i5HmXosa4z6h3ixIIdIm35A8oEK+DcoCpJNoiPRPySydU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K6IdxZVo; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769013306; x=1800549306;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JC/V1FTwN91HuxSWAjfyF3ZKsKE+FpJoO58ni4DOTdI=;
  b=K6IdxZVocTf8/3YWTSueVI48/X+rS/8cJpLIH0qXYsXWsLD1eGDqReAG
   vxUb/HNGMyH7gpG2qJZcjMA69JpQpXMAVpEaQwJoaVQlY1QNAszTKf2Ue
   xT4kprrOZ4cJaic1Lak68a9vFCJs0psPXv5paJl57/nbsfXy2JbfzU4+7
   nLd0ZZjtCxK9gi6be1XV7a2dQ7UCqrw9EEFxgCAQa3OfkI2hSzHZ0g4MS
   Wwhhe07kxBVAmG3exAQlVI1elPdg4F5jiquGr069qfupFTpKJYW8tyyQM
   AKco5n/KfmgPmDs661T0zZtRay3PsDxDH5DCUCqrUwcDEIU1q57YNfNPL
   g==;
X-CSE-ConnectionGUID: NpnLGB1KS72FGFw5l41/DA==
X-CSE-MsgGUID: z2cPI8RDQXGNMx8hXftR+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11678"; a="73870101"
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="73870101"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:35:05 -0800
X-CSE-ConnectionGUID: KkVN0bRGRJOSX+hgc32tHQ==
X-CSE-MsgGUID: /gP4E/ToRHa1jADxfoqZag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,242,1763452800"; 
   d="scan'208";a="244066917"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2026 08:35:04 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:35:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 21 Jan 2026 08:35:03 -0800
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 21 Jan 2026 08:35:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gje1toU9MP8eL6oLmiMI73cwiHVdHNALJwJy89E9EMk5jV2W5MWJ1htHargNxA7ljAkZgZVkM4em9Eirx2JtOtUnTG77C/Ig8QP6249awhu0wa3ggT/tx9CjNtmpjaHugA+iVlzXOguN4JBxnOKpuL4rqkwkJHRfjt/cvwFkKFD4IXV7NQRZ8ktqhbRW6dQYX0Z897qkQN9uycSm5RbLcXAoDNtIj7Fm5E1I/4fJNQpdUsgXKmGmhlCcue4XKrnat48W14VX/mlZ/hUWxwVLTghfva+1l6lmsQ3BBWwo8d+0qKsPCBrn1XKivB9tBkv5p+y8LtFIkxu0tgzXrNTZHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdy4IIy/HQIPGgfjJ77paBymQZg+eruu/TLYG2i0AXs=;
 b=R+cHJZE6WnAH8U2zpt/AZGKePb3+0sezWXjEUx8n8hG/2cR2DbI6AdFuRMywqiI1Z1Y3fZNlllhVzGrDDbhzaErR9VgpGelb1im4Gyfco9AIA+pYn+RsASgYFDG40/McCTxMMuK1MPKqO2K0L0UCeRwrcgfpfJ5a6+C8PHh9dalNwKnZcDtXWy4TkOqSBxoYeLU9/LzQLSzZVMSYeePnfyFcVrSaIvTd6PTkFPyOLML9nQkATYy5a/AXdVGIFOMjlK+ToinLSRaNoA/6FKXuscM4pcUVExna57ImCd9Runxe2iPhAxTGsG9jMRW1SJ1G01r6k6IWx4yJWxj1dyLj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by BN9PR11MB5257.namprd11.prod.outlook.com (2603:10b6:408:132::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Wed, 21 Jan
 2026 16:35:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::61a:aa57:1d81:a9cf%3]) with mapi id 15.20.9542.008; Wed, 21 Jan 2026
 16:35:00 +0000
Message-ID: <1cdd81f2-15c1-4f82-a321-ba79df86266e@intel.com>
Date: Wed, 21 Jan 2026 08:34:20 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10.y 1/2] x86/resctrl: Fix kernel-doc in internal.h
To: Sasha Levin <sashal@kernel.org>
CC: <stable@vger.kernel.org>, "Fabio M. De Francesco"
	<fmdefrancesco@gmail.com>, Borislav Petkov <bp@suse.de>
References: <2026012056-existing-collide-49ad@gregkh>
 <20260121025738.1158111-1-sashal@kernel.org>
 <7a7bfbf5-b7c5-4613-91a4-161f0bfb3130@intel.com> <aXD9Ig3JMFW2uyu8@laps>
From: Reinette Chatre <reinette.chatre@intel.com>
Content-Language: en-US
In-Reply-To: <aXD9Ig3JMFW2uyu8@laps>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW3PR06CA0009.namprd06.prod.outlook.com
 (2603:10b6:303:2a::14) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|BN9PR11MB5257:EE_
X-MS-Office365-Filtering-Correlation-Id: c599ced2-3ec8-48da-cb70-08de590b0566
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXpzdURJdzlsLzdpYUYvdk1zM0UxUzMwZ2QrVGl5cnMwTi94bnQ4ejhvL2I2?=
 =?utf-8?B?UmZ4YWxleUZGNVVHTDdFZEpWUngydDN3NzF4bFFPVCtOSG1pSHNIYWlINjY4?=
 =?utf-8?B?RUVSVkFnMkV1aW90cDBOdTIyLzNvTS95dXJBb3hQemwyWVpWaTE5Q1Y2bTcy?=
 =?utf-8?B?bG0wc21ZbkZ2dlFpeVpmUStmV1l4VytCalZvaGZkamhyZXU4aWViUGdGOGJP?=
 =?utf-8?B?MnNrZ3ViYXNJUWRkdGV0TjkvMnl6bWZCZVVuNXo4L2o1ejE4RnF6aUZXSlhx?=
 =?utf-8?B?YmhvdmpOUFg1dThWNm5pU0Jtd2gvNFFUVWpLTis0NHowR0dIZHE3ZmVMRmJ2?=
 =?utf-8?B?VDQrZ3E1VjRBL1J4aXdKakEvelFyRG5Ka2ptWEkzQkZNY2ZFVFBtb0VGaDFl?=
 =?utf-8?B?cGZ0ZHhwZHdxbDBkSGZNZEQ4R2o1UzBvZElKTkFvSjNIbEFTWjFLVy9wYjlM?=
 =?utf-8?B?RWZZeHNPWGhmTjNpNlBtOGV6N2xvZTlpMWxZbGNvc3JwWkJzOXp6WUdZb0xj?=
 =?utf-8?B?aUlPbVRTMCtBQWJ1WUZaYzJjQVpseWNzT0Y4bEZBY1FQSU4ySHFjRllrM201?=
 =?utf-8?B?TnpPV0F2eFA4Y2Z2dU1RdmdrdWw4WFFNOFFOWVdkS1UyQ2JKVldWWEhhT3J3?=
 =?utf-8?B?VTJlRmNBUmZNc05leGYzWk9hQlpUemNFeTRaNEtuUVA3bnI5WnU4UURMTVJQ?=
 =?utf-8?B?UlRNeHJzdnBSVmZvRUJTUURVQVVHbVRQRVZCbWdEdHc2TUIxamNZSmp4SjBy?=
 =?utf-8?B?dXBmbnkzaFFnRmFkWjNpaXdBNkZLSTA5NUdZa2JlS244b3dUUGpRT3hWelRr?=
 =?utf-8?B?ZHVjVmd0VFczbzRvbk51ajRwbEJsMkJPTGY5TmFlbzZGd3YxV25pNlZ4eVcr?=
 =?utf-8?B?emh6SGtvdldKRlhsYUtrOVdsc0w5QmlXcEQ1NitQNno1VlVwcldqNXNuN05C?=
 =?utf-8?B?UzhlZWZYVTJPTGVUNUJsbXpMZ2U5eEwwNThhYU1QNDB2K2VwQlUrUDZBMUh5?=
 =?utf-8?B?akJtOWZ6Q0hIM2NxeVpHN0dDSG51RVlhdmRaeFZYWG5QTHA3VXA1TlRzWTIr?=
 =?utf-8?B?MjVDdWUyV1lkbkhIN1B3TXdQUEcxQ2FvYW13Y0IzdXN0WFkzRGZjN0hLSHBS?=
 =?utf-8?B?L1R1OFdKK3VnTGM3RklOSjRqNjE0WnM3Z0dFc1BvVWRZOURIbnJMSFpjUXJU?=
 =?utf-8?B?S2hJMi9DMzlMQ3l5bm5BazVSM2VDQnpZaHB5elBQWHdWR3dXOXVuellrcHdO?=
 =?utf-8?B?VTNjQnBWUHVoSlpZL3d2VVJWVXErQUVHSzI0bExXN1BiRTg1YVB3WFpSNkNC?=
 =?utf-8?B?VDRLMXBsaFlZT0NoSzhPeEVtRlN0S2NIQWYrYXNQMDJrVlFoK09jWC9LMmdV?=
 =?utf-8?B?R2hubkR3cTFXQVFna1EyV1B1cnJBekxiQ3Iyc0RQRTZ5NkJoTlRQeHl3dGNP?=
 =?utf-8?B?R2R3RDhNZWZCWmlUYVBXS09CL2JmV2VwTTJUKzUvbFVkNWtYcFM4bDlRcGk4?=
 =?utf-8?B?SGdON0p6RmczVHZ6VnhnOTljNEwrWGpoMjRqYXhxS284aWxFNlBzanlIa0xJ?=
 =?utf-8?B?cHdwcDZHOHE3ZlVsRTRJRFc4TEpPSm81dTFzNDJlRWlVTnFFZXpRamlyaXlV?=
 =?utf-8?B?Q0pmTEd4dkE0aFpzUzdQYXkrc0NuSW5kU1F0eEVkSkpPUXpDZmdxdFpNMWNJ?=
 =?utf-8?B?KzV6ZklOUlk3djJBa2ExS0paNmVBLzVhRUFRVGx1alNTRWJjeFhLYlIxY05E?=
 =?utf-8?B?bjViaE8rc1RvV3F6cTlVYTRyQU52cStEaXQ0Vzc5c2ZLbmVBTWhON3I0bFRi?=
 =?utf-8?B?UUVSY3ZVc0NVcnU1UmhodS9sQVpBeEhhNmZSbHIxc2JVVUlEVmQ5WFFvZEFD?=
 =?utf-8?B?RCszQnFaRmRuc3duMmJpMTVQZ1ErZWtqRW1zN2ZuNjdKN1cyTndvelRURmY2?=
 =?utf-8?B?d1gyQ1R0RzNKRFJNTTQvRUJIRzhTa3l6di9YdmFDc2JZVFBBWWhwNS9EZWJS?=
 =?utf-8?B?RnY0aktOWXJRRUVRRURYZGtRWXFlNXpPYXc4Uk1Mc0FMR0RaYkNZdHBTTFBo?=
 =?utf-8?B?OWozOWwvQitjZXJwVm5MT2Rhb3JBSGRBVGhuZmNWWlhYTjBzajUxaHV0ckFp?=
 =?utf-8?Q?gCpU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VnprMmt0TXJuN2g4Q0dxbS9iZ3NiN21mN3VVKysxTXhvNzA4RzNFWXd6WlhN?=
 =?utf-8?B?T0RYTHdKdElQUVVSTEF2cGhwbHNCL3FCVE1qeHhJUFlGRUEwK28wbVVIcjhS?=
 =?utf-8?B?Zm5EekNtYUJUYkRpeVBWeVpOQU5BdTNNYTVJQ3VPUWxGa3dhdmhqbkhuMGVk?=
 =?utf-8?B?Q3MxaXlpNFhJd3NvSDNHNitaVHdrNFZRMk4vWW8wVFpDU2pyV3BFVDFhcWVi?=
 =?utf-8?B?VXRLWlg1M3Nnc0pUOTV1Q1JOQjd2MU1DKzg0RXVRbVRzUWZrRWFqVlVnSjNs?=
 =?utf-8?B?dWdtQjVsQTRnMUowLy9aWS9LRHA4T3kvYU1vK1ZPWFU3VFFHNjZUUVhSMXZZ?=
 =?utf-8?B?RC9vcnY1M2N2NHc5YjY4bWp5UjRXL0JKTmFPL29IZVhkRlZYTkR1M1R1THJO?=
 =?utf-8?B?amNLOUN1WWhzM3k5eHFOTFJvRXpTNkVSaXhOa2tCZDg5KzF6aWpJN3doQUxm?=
 =?utf-8?B?cGdyaFg0LzJadWI5UnErd1Fkd2hQYzlFTjBFTzJOMVg2TitTUDFVNHZMMTlE?=
 =?utf-8?B?ZXVLSnNwS09hUFRvVWxQbW9sVE5NZ2NkTXkzR1IyNDFDb3dwaEt0aXllMHV0?=
 =?utf-8?B?VXl2TGd5S1cwZzhycjVYTUpXNEt3S0VZR3N6YmxUcnVadmRWYVZLRFRJTzZq?=
 =?utf-8?B?K3NaS2s3d3RpZnMyeWdmQzdsMHNEbGFjRnl1Mi8vVlJJZng5TWxCVmlwNlVy?=
 =?utf-8?B?MUcxZHdqZFpXUnhyeXFRVEZFSlBSYWJsVFlWTWNiZjY4a1RaZzg5OFNQQ2Jw?=
 =?utf-8?B?NTlvdldYYVdiNXNmMU02cGVmTXZqUXE2ZjlSMi93MEFkdmZxMUpVeDNwZk5p?=
 =?utf-8?B?QnNMQzR5Q0x5YzBkOFBmS2lNYnlQRHdwY0g1L3NMTm40aS9ZNC8xMzhaeUg1?=
 =?utf-8?B?ckxtUmVaeGNSWUszUTV0VzJTdnRPeGFQajJ5YXR3OXV1czBTUVZXN2lQRHF1?=
 =?utf-8?B?SFEyN0ZHWkRBa0QvbW03RGJXQlR3dEFFRUkzUzRoSVQ1dFJFMGdRYkxNOVRy?=
 =?utf-8?B?eFNjZ05VYlBIUkY4cWh0ZUZKaFBrSnduT2tjNE1JMFFGTFZWYTR5eE9MRkk1?=
 =?utf-8?B?YjlEYVdhVkFVZHBtcjlyZUt2MFROMThqVVUxWC9iS3UzdnlLaEN6YS9jcEZa?=
 =?utf-8?B?TzB3YmVOYjRvUzNIbFd6UTU0LzJLQlR5YmhabTYzZVBjdlV4dExlang4Yy9H?=
 =?utf-8?B?VHU4dDgwS0xNaGk0T1VZci9ONU5FcGlRZFJoMExiUGlxZHRuTFdoREc4UzBE?=
 =?utf-8?B?SXpNWEdpWmlJYkhMenhrQ2pReTJCN0hkYUtpMFdsMGxsTmRXa3JJRXFXbWNT?=
 =?utf-8?B?Z3pJU29Fbi9DWGl0czNXQkQ2Wk9UNDNWbW5yT01QWkkwQUxBNG1Va2Y4Mm9B?=
 =?utf-8?B?cXZWcnBSL0RheU1BeVdYa2lHUmd4SXZHRDc1Y2FOVDBKYnNtS1NRMUE3NWNx?=
 =?utf-8?B?SDZlZFdRU3FiaUpVMkpidXVtOG1YTTBkWFBDb2NpT1RxQy8xMm9QLzFOWjVZ?=
 =?utf-8?B?QW55OFJQNUZIWVF1WXhQMUdidWxaVzd6clhLOExIengxaDdwWGVrY0paQjZW?=
 =?utf-8?B?amJ5QlA1YUtkYW5hc0ptKytkaUxDM2tjdG0yRWtGcWhmakxDT1NBbUpJeXVG?=
 =?utf-8?B?NjZRRW9xa2Z6UWlnQ3VBbmZ2MytLT2psMFlybjNnMHV4OHZYV2FydFVlV05p?=
 =?utf-8?B?T3VHYUwxdkFrQkZhdXhlQWtnanR0Q2hKNGhzcDA0VDQxMlpqdHBRbnc5aTVI?=
 =?utf-8?B?c3EzMGRodWdMMTh3ZDI0WXFUNExzZHBudlBHMFdhT1A0a2IrOEtXSTVIL3g3?=
 =?utf-8?B?QXJCT0QxeEFZQlpvYzdoK283OXlIeUwxUkJsSFJyd0Zra0RNMXZPUVpvQ3Nh?=
 =?utf-8?B?ZEN6L292RDZqZVg3bWdhckVlVnAzUlM2SzV5TURzZWl1OEVBendoSlQrYnFv?=
 =?utf-8?B?SDFCRUF3ck03SG01QW54TVE2RFNHZklZZlh4TDB3ZVRQaGFVWHRzQ1l2MEtt?=
 =?utf-8?B?L3lzejlnV2NpMjFiYWIxVVdWdW50ajgrVVVydjVTQzBWQ01HTjUvY0FRZldi?=
 =?utf-8?B?aEZPamtEZ2MrN0VkOEI3aUl4VUp0N015aHdWb1Z2MHJodEdDWWMxOWFvSEYy?=
 =?utf-8?B?a2M2MXlVUTZ1Z0xUNHN2VVI3NUIvb3JXbXRoNERYclUwRE5WRVllOUFUSHZI?=
 =?utf-8?B?aXYxM2JwZGpzU01adEV4THVPb2ptYVFyT2VtS2xrdFYvVDBaekN0M3VIaDdM?=
 =?utf-8?B?azdUMGljb3gxbGhzWE5BYVRGOHZYc2xoMUlBaHVQNjBML2Ryek50WUoyeGZh?=
 =?utf-8?B?S0RVbzFhU2EwTUk5cEIvY0IvRk03ZnVSdEQzekxrdVJkOVdSZHhhTjQ0STdl?=
 =?utf-8?Q?4KnqwSjOybACUsLI=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c599ced2-3ec8-48da-cb70-08de590b0566
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 16:35:00.4366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WojiE5zCJSRis/VXTZkHzlLi7d2Cco2/5PlL3oLhGzgSXJI3WiO9DDQU+q4BqJKE7LcLAlPm+I5Phxgh58sFxiOS4PtwDzqHnn5IcWNADKY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5257
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-210794-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,suse.de:email];
	RCVD_TLS_LAST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[intel.com,none];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[reinette.chatre@intel.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: A80815AD66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sasha,

On 1/21/26 8:21 AM, Sasha Levin wrote:
> On Wed, Jan 21, 2026 at 08:07:34AM -0800, Reinette Chatre wrote:
>> Hi Sasha,
>>
>> On 1/20/26 6:57 PM, Sasha Levin wrote:
>>> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
>>>
>>> [ Upstream commit fd2afa70eff057fab57c9e06708b68677b261a0c ]
>>>
>>> Add description of undocumented parameters. Issues detected by
>>> scripts/kernel-doc.
>>>
>>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>>> Signed-off-by: Borislav Petkov <bp@suse.de>
>>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>>> Link: https://lkml.kernel.org/r/20210618223206.29539-1-fmdefrancesco@gmail.com
>>> Stable-dep-of: 6ee98aabdc70 ("x86/resctrl: Add missing resctrl initialization for Hygon")
>>
>> I cannot see how this patch is a dependency for above since it only adjusts kernel-doc
>> in a different file.
> 
> You're obviously correct :)
> 
> The full dependency chain is:
> 
>   6ee98aabdc70 ("x86/resctrl: Add missing resctrl initialization for Hygon")
>   63c8b1231929 ("x86/resctrl: Split struct rdt_resource")
>   fd2afa70eff0 ("x86/resctrl: Fix kernel-doc in internal.h")
> 
> After applying that, I've decided to drop 63c8b1231929 as it's fairly big and
> just rework 6ee98aabdc70.
> 
> I should have dropped fd2afa70eff0 too.
> 

Ah - I see. Thank you very much for handling the backport of the fix.

Reinette


