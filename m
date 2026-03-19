Return-Path: <stable+bounces-227379-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGmOG9tevGlxxQIAu9opvQ
	(envelope-from <stable+bounces-227379-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:38:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB0F2D2474
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FC4B30A0358
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 20:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01BE53FA5D1;
	Thu, 19 Mar 2026 20:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="Kv0AMHMc"
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF92B3F7E93;
	Thu, 19 Mar 2026 20:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773952154; cv=fail; b=pBTKwpWomkYEPSnHVgejRnWu7B8ZuvtqhvrumOmPLamagrKJXOcnUb/6W/l5PzuDB8FrduLFd39JEUVlPO3zfL5VA4lfLaOfHz3iEWeKm/oR0OTIgFDsTfUYYYVX/UeGiXAHnMEo+nMCofftlDkv6CkQeO16yfyFBweZfYuLtDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773952154; c=relaxed/simple;
	bh=w1dTKHBwfReWboU5aCDFDlt8yG8MENUOO/T+4UWt4BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GYB7ASeef6xpWUSOR3o0LLe3QpA5Bo5ke4An5ch032p9kOAtvJqrjAbaduItA6CwfbPZHPIdaZQRe7R3ypSFB3yKdq9yWPwg2FIrDv9KR//PV97Mprn/dWO3LRE8Pnrm3K0yDLk4VVTEq62dTcUwDXyigrkUdtnzs6xW6NN0Jtw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=Kv0AMHMc; arc=fail smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62J8fGFO2827906;
	Thu, 19 Mar 2026 13:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	PPS06212021; bh=k50iDQyJNcadc31oyThqcbP6o/jZBxAl/02L7+71PeU=; b=
	Kv0AMHMcWyY28I8ghcjGQ0PfHrFHQmm7YyZmEcGefOLTh7NED6Ay7xxdssTCQyOr
	Wxjn0RGexggW57Jy5faZ+WUO/G9eEaRcPs/OqBrIkn05zldnp5h7mZiLyNZkvtU2
	UDWRek+zbaa9xEU2ubjIhnXmSawwYHPSqSMwHme54Ffj9DAevUOR6oRZBOD5udMH
	4XOcRaODWEAFo/FOgI0z1VDAsnqK3DfJN0jThnd8FjeHyGrz/WTFp44fvv+VS0S6
	BcLE/uNgzhOFX0sx/yABXsQETR2LjaAPvv90bu4j1WVuML5KPjDHcVZnbl2l11VE
	XwVIfHPonMHwa962JVY9Ag==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010005.outbound.protection.outlook.com [52.101.56.5])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4cw76dxu55-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 13:28:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKb8n0XKz8wSqiM1dlaeLt4tNgUzYDHe70lMMY58PCtxdJTc/4qdxPUWneDBu+jHnt69+2R8Sx+5RVDqJn4945r53EeSvqNG3rCAhRhJVowjOniYJ4sbGcqseLD1yExl4ZjuFWG7tlrOhTSJ0hKh9YyV+cEde47qiA6+sSK+XLrlPKfjoPuoJtOc6oy4Y4k5fwnDVXK/0735r0vprzw2dHeupCZymAlyNl+zf/9xx4XB6Gd6JF9Kq9h6xihvmnxTe8SnO9TBqZVLYRnJlLroUbvCTl2iN7apNhmTt4YE0ThMDNwHi7tCJSV1fiGIbTdCjxoOebRG18PjO29aNWzmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k50iDQyJNcadc31oyThqcbP6o/jZBxAl/02L7+71PeU=;
 b=GHHxetmHjtwGBV9WhJFH3tNjJCiOBYqS4vaQDxEFOnuYCvypHyV4wGlQnW4dVXLgWXk6Dbt6DAlblVNJNyEcVY51i3HXACxlZ1sI297qS8tAi9wyHTY+0LdGDVX6OLFMvED+BA+r/aedGHVgfm6Hxjyabrf47oZnC2RtWxEjMRLhrmzMAjYkPeRPsqy+oX8GQu8U1ooRNzsSSYO5vOhf5U7bWUEW/SM/imprUxYpELp+bwvHjgZTrftZk8wdMSlzxPhiwz4n9qh3dcaEQYGxQ/T4/5zJpgG4imy7Lm+GQwoei2l3Ltp3zEQl09LOec/Kr5D/PI5cg2KmoMufWHJFvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com (2603:10b6:a03:4cc::8)
 by PH7PR11MB7550.namprd11.prod.outlook.com (2603:10b6:510:27d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Thu, 19 Mar
 2026 20:28:12 +0000
Received: from SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced]) by SJ2PR11MB7546.namprd11.prod.outlook.com
 ([fe80::ca9b:dcf:8881:bced%5]) with mapi id 15.20.9745.007; Thu, 19 Mar 2026
 20:28:12 +0000
From: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
To: schnelle@linux.ibm.com
Cc: alifm@linux.ibm.com, bblock@linux.ibm.com, bhelgaas@google.com,
        dtatulea@nvidia.com, helgaas@kernel.org,
        intel-xe@lists.freedesktop.org, ionut.nechita@windriver.com,
        ionut_n2001@yahoo.com, julianr@linux.ibm.com, kbusch@kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux@roeck-us.net, lkml@mageta.org, lukas@wunner.de, mani@kernel.org,
        matthew.brost@intel.com, michal.wajdeczko@intel.com,
        piotr.piorkowski@intel.com, sebott@linux.ibm.com,
        stable@vger.kernel.org, sunlightlinux@gmail.com
Subject: Re: [PATCH v10 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA deadlock
Date: Thu, 19 Mar 2026 22:27:55 +0200
Message-ID: <20260319202755.16081-1-ionut.nechita@windriver.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f17b03652a84be73c1d3a2cfea8a016dab99f8e0.camel@linux.ibm.com>
References: <f17b03652a84be73c1d3a2cfea8a016dab99f8e0.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0006.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::18) To SJ2PR11MB7546.namprd11.prod.outlook.com
 (2603:10b6:a03:4cc::8)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7546:EE_|PH7PR11MB7550:EE_
X-MS-Office365-Filtering-Correlation-Id: 32104cbe-d4dd-4264-66bf-08de85f60a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|10070799003|1800799024|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	N10eU0WzfqQLgqlGJi0S/Qc7SbaarTd5x1nTDcfYfdN0Ag+3BdlDIR/jx3nC4fuG/lR/lCG/YsKrKKtmZAksAnjc6WxbTWPQ5Jeth6W+lLxWUGdqQlKmswGvM+w6LrkDFs/2lGZPyXFYYYblzLnto5/DakKORWDoSvCXe6f7h97pqLHulnhbAKbNbDw4EviiGV3dIOlFfrCQ6ISYHLfbaumpXCUl9aQqpeYWqkHnSGAaJeqLQgAIgDCeIxi+1DXmxQgFPXqblx0mm0qttT0aNGbXe6W1TNaNwABsWHNVX8bkjy5QJJLI5vdE9EcyCFnj2HvEhPmy63KVagoGfgA66lKxy94UEpfazBOTg1TjUeGT3tWmUx8RI3mJsQ88sa+4Dwo0jC8et6KGVshjwTVeOA+Lywt/AYEzN4l/5UkjFpwhJXJU/92SkXQdu+/j2cRutO428gdpdYTdrX1YyRJuohc4nOuuEtf7nkWUcC52b91XzQkcjfEJywPEPYpojOgnZbzIXclRhdbuAPltHSSFySlo85DDtETdUVJm1TMnlZkN3JkTUZcGMOCOtx9qHx1YhVNDo6JELIEHvL5bamisXH178wKof9JPDHGpjW9q9eze2yH6X0xgdSj2M8JOdWQKh6djrizlHycNwgMSDcS/pOUhbH0+xvZf+svNX64k0ZT1iCMMuMzF4XD3fuWghbLJ20xurZwNk+iv13nUwoYS5d/Mh3knl5vy+XUBNX+V15cR7ixlMXmyXq9lYN+oCv0Y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7546.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(10070799003)(1800799024)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MFJKZEZNbTRnRXBaNWt1ZzJnemg1cHYvZTdoMGUwSk9nRGhGTG15WHNuZnM1?=
 =?utf-8?B?S0VwcU5lSWZOV0JUYm1oMWtvNUpxQTZQaXFGZE5mM0FvMmxjd0dueEl4WEhS?=
 =?utf-8?B?Q1ord2ZYelFSMFRDeWhmdzNLUmx5S0hFYklYaUdVajVTeGhoRHMrUFVMZWZE?=
 =?utf-8?B?ZkJXZmhSZlA0RSt5ekU3bkN3YkhObnBuaXpIT1RRWkYvQUtnbmNJeUdSZ0Nn?=
 =?utf-8?B?eW5VcDR0eU4wcHN5a2VubzE4TnpLa1AzdlFBQ3N4aTVXY3RQdnZnTWpxZER2?=
 =?utf-8?B?b2ZEanhUaTc2N0tmZjdXOTBhNnIxVGo0bFcrcTNsM0huZklHZVo2ck9uQUFu?=
 =?utf-8?B?RnUycndrTnlUVG5ZT3hiNXJpaHdqQWJzU25DdUt1L29SYVYvUzR2T29CeEwx?=
 =?utf-8?B?cW1SazBVaUwrZ0Fsby9tT3NZS2Q1aUdncUd4ZFJjdE1sZ2p0a1p0TDdyMG8w?=
 =?utf-8?B?ZXN1U3RnTkxIaTh1YVoreEcvczNjdEx1WDhVZTd4MUN1dlNDRTJiRzhoZWJW?=
 =?utf-8?B?eDl4ZWdqbGFHVUhacGFURGhmb3daUHR4VEM5bndMWUpTRVVVYUErUHJJSHh1?=
 =?utf-8?B?cDZOUS9jeWZ4aVZ3eThxdTBrNnUxWkQrTTdXWUVWYzcvN3hvR2E4VmFaUU96?=
 =?utf-8?B?MVpkSUtTMXYzSG1WeEpQMlJka0N1MEFsOU5NUDFwSmhzb3FGNTBWTnZ5OExo?=
 =?utf-8?B?NXpaclVicHdIay9oNm9mVXpudldHcnBwV3hDTXhQV1h6YlkyVkFjK2FScExP?=
 =?utf-8?B?VGlTL0prL0h2cVdRVGkydE1PUmo4dWtWSlNTT2hCMS93RXI3MnRSVGZNVmQ3?=
 =?utf-8?B?eHloUENPVmptR0dGS0JJclZHT0IrZTFGc29TTlRrcmJXY0s3Q2R4d2k4R2FT?=
 =?utf-8?B?UEdGZWVhNE5VaUF0a2lkbVhKaTQzd1pKZkVmaXFaaVEyR0ZpQVNpcWM5aVVu?=
 =?utf-8?B?OHIxVEFQaEQrVGZaaFFEWTNPeG5DQnlBV24rRGs2QUR5VWt2SGxZS1NabUQ2?=
 =?utf-8?B?ak9mN1EzTHQ2OXpnME1qVUdNU0JSQ3l3cHFXcWxraVErUEVSTUNkSTRiMFBM?=
 =?utf-8?B?TXNRODlCVk02d0M2UTZGYm1BV0NIcUF3cndUbDJrVUFHanJxYTV3Q0FYYTl5?=
 =?utf-8?B?V2RhWEZmeXR6UHlNNzRrOVVaYlpiYkV5bUlIaGpib2g5QWh2U0JmUEJpRXkx?=
 =?utf-8?B?TU1NSHFKWHFoRHRyQ1EvZHl0MHBWZWJ6NXJ5SWFNc1h1bmFBL3VuV29zcmRt?=
 =?utf-8?B?cUV1SzdPWi9JOFhCbjhlWWJrL2pyYTRITXBrREFQS0Z6V05zUy9ZM28yc0tG?=
 =?utf-8?B?T2FKd0ZNc1lEckpMRkRROHNrWVR5eWpCR2o5T0tQa1BVQnJlQ2IxM1VFZWd1?=
 =?utf-8?B?czZ2emlFUDlaRG9HNGx1ZDR2dHo5L1pTeEhsRkhZeFV3dzVFaEJ0d3RoOHpz?=
 =?utf-8?B?RTN5N05vN3Nseml4dWhrLzZQTGZzbW9VTm1FWHdFeVB0dDg5azdKOWVNVlpW?=
 =?utf-8?B?VExXTkJVTmdob3ZHRlRBMEpQYnY4Z1lXdUZnckRHTlFmUEtHK2RCMUhLbS9u?=
 =?utf-8?B?U21QcHdMNzlQLzhLZS9IQVg3bjlPbTN0TEFyZG55dmJQK2xKd1FHZU5VbUt2?=
 =?utf-8?B?YzZoL1JmQktWMFVzbCt1aTBIc0FUTFZweXI5T1hGR3ZnUWdqUlM0SFRPT3BI?=
 =?utf-8?B?cDJNeG9vRHBBdzliLyt1L0FjME16TkQ1ajkyL3p2R1dPVXlpTWxMaGs5M1Nk?=
 =?utf-8?B?OFp4WkZxNGZpaHlXbkdsTldaZG1PaDArSkRTRE1FcHBaZjcrc3V2THhVOG1Z?=
 =?utf-8?B?cktyREhUb0JucXhiOXFSK3JIaWpLei8rK0ZrSUFDdFRJa1RnNDZZemNpeFN6?=
 =?utf-8?B?U3dONkdOSGN4cWlVamxwanByVDI5TVdzUXdWUVJnVWk0bTZtemtISWJRb1VC?=
 =?utf-8?B?dE5NcHBFay9wOXNSeXVTQTk3RUQ0eldJL1VBK1F1RlI1VVNSUGMzRDhHSVVE?=
 =?utf-8?B?b3RQZ2RBZEJRdXhOTytsYjdtelo3cUcrYnJRUVM5RklrYXpMUXRrRDFYRGt1?=
 =?utf-8?B?ZmtMNE92MUk1YnFxWjBlTE9TYU9GMWRWbnlmaWk3UFpjSzM5VWFROVBGdnNm?=
 =?utf-8?B?Sjl6YXVUODFoMTE2S3RCRVp0MjNiUWo3YXpONzR5K0duRkRXYkhVN3ROL0ZB?=
 =?utf-8?B?KytjUE1OWnMzdEMrRGN2NWVrclN3WDNGa25mN056dHIxcnNDbWMwNGVEeG90?=
 =?utf-8?B?QmZaMlp1MXRhR3VFZ240WGpMTytTSGFQVC9xZEtRTEJ5ckNLVEFxaDVISTNm?=
 =?utf-8?B?eW1MOGRvZnZGZS9qZnNLTjV2ZHJRcWxTcWphcW1TUkExVThOU1ZieUhIYWww?=
 =?utf-8?Q?Hf0aiQ2c8m5bwBoYK+oZNT2oLeQ2GENHgeipW83oug3F2?=
X-MS-Exchange-AntiSpam-MessageData-1: 0b9CI/Z6Jw0ITw8Xd+SH6OOKPZ624hh0dts=
X-Exchange-RoutingPolicyChecked:
	E75LKogvDs7A6v3q1tsXFppPq/iDhn4Lie6xyGzwhrpH44hoprMD2a55wt3PozBVvAM2msl2dP2wbuKJUfYXFk7dypUvZIXLsnmy7dx15za7ci6tlHH15Q87qDVma9xE2gaqS5qpUZwwZslF8G9ygFxmdDwc5lOO+nRwNNoYfuReHldABuG/O+6qqBc4BK1cD62NsDSNM9XxZc75A/DGbNdlAdYPEKCvBbKhIQCsiauCoUHxeHQGnk+43+BC9ygurn092jIz3fvwduoCkHSAr4rGrVsAG2VHBtxUKf/g3sPEbXEpy4IJfyV3ZkcIPkfiblqpK4TmeLwPbPdcT4Y7wQ==
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32104cbe-d4dd-4264-66bf-08de85f60a96
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7546.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2026 20:28:12.1273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8WlbrCSy6h+Y3Mntrz58zBGzyTnFIZiy2aA7glmoaqi7xlclKBamUvRkmwcxunmac1ZzuWC3aG0qRKefucnAt5Ug0/xC0JAAQuglUml80I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7550
X-Authority-Analysis: v=2.4 cv=S9nUAYsP c=1 sm=1 tr=0 ts=69bc5c5f cx=c_pps
 a=sh1HRyDNv5RGx04/W1QObA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=bi6dqmuHe4P4UrxVR6um:22 a=iKiJcTA2PjBS6x5JeXcw:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=MbE5xMDNE4MnVr9pmM8A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDE2NCBTYWx0ZWRfX+FFGad8pRTHA
 tjQ7hs4Ass/s3R/Opx1n+RMW5TH4pOGLtPLKtIO5Ikq68mnurOptWFVGBbotXiLhEaVl/LJh0ih
 2HU0Tfj0E6H2VJ6E/7ZpAWZhypcEj9uBouU3SfRR9r84n52KNI5BW1VCFyQ9c4AmKtjPBzf655N
 yOwQgnmRzWlxqdUtwyCXWZ2KTnnuE6TS+mXQA4sm4TVPevQdRoeJGM1p6IUu/hOsaUZQUopziqK
 Z6wMEO18PCQTTpJOLxsk7UvMSkkaPv6w5B0GdlGbliuvBRdSXwAYJn1kwZh9Wqi6nTB5Pt+6U6j
 ZIgW6ZJsXxZYwS/QDJSkdlDzUGJqDDrgBIs0JLOV6qrm23rLCA57v3t2CSpZ8IqOGJNtIhnY5P4
 8EV1bttzJ4c7LXMCVvyE6F7z3IJ1IGI90zCIqzzvDSM4otCUfrXb+Lu6fj/HI8vheUuXp94Me10
 12c+cCR+TcoqTLPJStg==
X-Proofpoint-ORIG-GUID: nJQQTpFTijHsSZ9KZY-cNBu-9GX9d91d
X-Proofpoint-GUID: nJQQTpFTijHsSZ9KZY-cNBu-9GX9d91d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_03,2026-03-19_05,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 bulkscore=0 impostorscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190164
X-Spamd-Result: default: False [0.84 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[windriver.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[windriver.com:s=PPS06212021];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linux.ibm.com,google.com,nvidia.com,kernel.org,lists.freedesktop.org,windriver.com,yahoo.com,vger.kernel.org,roeck-us.net,mageta.org,wunner.de,intel.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-227379-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ionut.nechita@windriver.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[windriver.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.997];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: BEB0F2D2474
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 19 Mar 2026 13:31:39 +0100, Niklas Schnelle wrote:
> For your awareness, I saw that this series has some findings on
> Google's new Sashiko AI reviewing tool[0]. At a quick glance the
> findings seem like at least reasonable concerns to me. I'm still
> looking at this independently also of course.

Hi Niklas,

Thanks for pointing this out. I went through each of the Sashiko
findings carefully(+ AI). Here is my analysis:


1) Incomplete Deadlock Fix (Hierarchical Topology)
   — remove_store on a bridge still has the AB-BA between
     pci_rescan_remove_lock and device_lock(child)

   This is correct, but it is a pre-existing issue, not introduced
   by this series. The v10 cover letter explicitly acknowledges this:

     "Note: the concurrent unbind_store + hotplug-event case (where
      the hotplug handler takes pci_rescan_remove_lock before
      device_lock) remains a known limitation."

   and points to Benjamin Block's separate series that addresses the
   broader hierarchical locking problem:
     https://lore.kernel.org/linux-pci/354b9e4a54ced67f3c89df198041df19434fe4c8.1773235561.git.bblock@linux.ibm.com/

   Patch 2/2 fixes the specific deadlock reported by Guenter Roeck
   (remove_store vs unbind_store on the same device). It does not
   claim to solve all lock ordering issues in the PCI subsystem.
   Trying to do so in a stable-targeted fix would be too invasive.


2) Driver Teardown Ordering Violation
   — unbinding the bridge driver before its children causes PCIe
     errors because pci_disable_device() clears Memory/IO Enable

   This is a partially false positive. Sashiko assumes that
   pci_disable_device() on a bridge disables forwarding of
   transactions to child devices. It does not — pci_disable_device()
   clears the bus master bit and decrements the enable count, but
   does not touch the Memory Space Enable or I/O Space Enable bits
   that control transaction forwarding on bridges. Child devices
   can still access their MMIO regions through the bridge.

   What does happen is that pcie_portdrv_remove() tears down port
   services (AER, hotplug, PME, DPC) before the children are
   unbound. This means error reporting is degraded during child
   teardown, but it does not cause Unsupported Requests, Completer
   Aborts, or system crashes as Sashiko claims.

   Also worth noting: this scenario (remove_store on a bridge)
   is not the path that was deadlocking. The reported deadlocks
   were on the PF device itself, not on its parent bridge.


3) TOCTOU Race Condition / Lock Window Vulnerability
   — a driver can rebind between device_release_driver() and
     pci_stop_and_remove_bus_device_locked()

   This is theoretically valid but practically impossible. The
   window is a few instructions wide. For this race to trigger:

   a) device_remove_file_self() has already removed the "remove"
      sysfs attribute, signaling the device is being torn down
   b) a bind_store or udev probe would need to fire in exactly
      that window
   c) the newly bound driver's probe() would need to call
      pci_enable_sriov() and block on pci_rescan_remove_lock

   This is the same pattern used elsewhere in the kernel (e.g.,
   the existing remove_store already had no synchronization between
   device_remove_file_self() and pci_stop_and_remove_bus_device_locked()
   — the patch just adds one more call in between).

   If this is a real concern, it would need to be addressed as a
   separate improvement, not as a blocker for this fix.


4) Use-After-Free in remove_store
   — device_remove_file_self() breaks active sysfs protection,
     allowing concurrent device_del() to free dev

   This is a false positive. kernfs_remove_self() does three things:

   a) breaks active protection (decrements active ref)
   b) calls __kernfs_remove(kn) to unlink the node
   c) calls kernfs_unbreak_active_protection(kn) to restore the
      active ref

   After step (c), the active reference is restored. The sysfs
   write handler (kernfs_fop_write_iter) still holds this active
   reference for the duration of the store callback. A concurrent
   device_del() calling kernfs_remove() on the parent directory
   will call kernfs_drain() on all remaining children, which blocks
   until active references drop to zero. Since remove_store still
   holds the active ref (restored in step c), device_del() will
   block until remove_store returns.

   Additionally, pci_rescan_remove_lock serializes any concurrent
   PCI device removal (hotplug events also take this lock), so
   the scenario described by Sashiko cannot actually occur.

   This is the same lifetime model that the existing remove_store
   (without this patch) has always relied on.


In summary: finding 1 is a known pre-existing limitation documented
in the cover letter, findings 2 and 4 are false positives, and
finding 3 is a theoretical race that is not practically exploitable
and is not new to this patch.

I don't think a v11 is needed based on these findings. But I'm
happy to discuss further if you see something I missed in my
analysis.

Thanks,
Ionut

