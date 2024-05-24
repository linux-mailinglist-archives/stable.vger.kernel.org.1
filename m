Return-Path: <stable+bounces-46063-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDBA8CE5A3
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 15:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C50CCB20550
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 13:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B8486640;
	Fri, 24 May 2024 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UjQ0O5nt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uyqqdi/B"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13610328B6
	for <stable@vger.kernel.org>; Fri, 24 May 2024 13:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716555820; cv=fail; b=PRplNM+qHDbUrjgsyjorgH2D9fwe0s3MQ2/MSB5SZv1CLcg0uw/ZNurwdcbsnIK39ofoHl+LL5JuGnXAOMq9gzeyeXe8bBvvmKq5DZ0t1rrpW2yf3HqijO+C1O4wx6HB4z0tR4iDJgSyubVLwiONsb2YDwX/+flWKQOpQXlXAyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716555820; c=relaxed/simple;
	bh=kx9sXWTdrz4/5XaSmLZPO6FV+Qyrym5XajJ7gUdgVH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dk/z2c6EZ3xqxR3/5zYqeLJek9vFjkAP+XWKQs0nDmgXrLdJxbH+B7myW22391940RaLblc5pmGk/02CztrD+z2N+bqwM5n3Jcipw7WlIdAYzuj1oafwdBbkgcJ3iwJYYmYuzXSDQov2z+ZvnvUjHWVzPFAIiG58UdVv0kykGDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UjQ0O5nt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uyqqdi/B; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44O8xGwL007114;
	Fri, 24 May 2024 13:03:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=lvwmoo3KuTMyeUXPCmOMBxNWEBOjicKW5gEJ9zjH9tk=;
 b=UjQ0O5ntlIHzlRDv9ePRgSeOZfb8M7Uk7mqZalCFMrDKu81i3xcFOQgJfNWN2kgyZVtZ
 9tSE4o1Y9S2gXxrMYMbzd21XAeOHpw4gN8aNaKTNCB/3PZP7g2nDVT9h7Tk8f+aHe3Ol
 llhGTHKLOc6ljPPcdQxdSwFSZY1FPXrmGmAMTatRVVFo0CT7fUIHEgBRvGFnr2fC8Brx
 7re3vVN+uOBLc022H9w98wJcL3AEgIEsXaizVkuSNGcVppE3y/+a+rlOuld9k7NOgVyE
 yNu/f61l/ulJC1gyYV/4Q8pQzL9phQ9ITHfirp+ssRr5XcSsEVCOBQm/Z4W+R9qKqQEy 0A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6jrev98g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 13:03:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44OBh8Ax002706;
	Fri, 24 May 2024 13:03:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsbvbhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 May 2024 13:03:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvtKB1ugeGIg2dEQwWjDmoEe7X3udBrcDPBJTcFeNX/gaDkHvhEJq9c316QkkdRINbLTfuOQ6/Sm1KRjvtH5jpm/mpTZXjLLnQSJZlr7nNnbm4T7EmU2/gz3s1Wt/mgsXGRRFmosVPTYoec1NuOEII+1AqS1WS1WTZqh7lbpn3bWNJ+N3ZGwl7rD2rReNpTL2wR7loT85mgJPz3heN/Fj5ijDe1QKyZFvtn8cBSFcxyS4p3GKz6lnAAL32IvsBXxRX96biBL1qQIqM6iNo4m/VKz9v/SrcoVERmuMTBHG5ZYWQtAcNew6hJ2d7chz2a0OuOen0umQy9IIKYhftG+3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvwmoo3KuTMyeUXPCmOMBxNWEBOjicKW5gEJ9zjH9tk=;
 b=EbrZFg5tkL83c/tfBV4WbLNGYk9svhBCjGGh07NwbhKM2rCZhE/N2Na5e5TuZ/MWIPDXh+SDJGTB0DKsUiP/ZHEgClUkE0rAj4Es4rtNX8xPfO9B7IDuPcfQJ25ZVWkjxSGF4PTITB89MtiEPqd+XD1XyO2j1l2T5su5NGzdpMIgbCFpEqSBq9WAVh+r0sZWGSSBy361JEPf6hVDscbwe9C36CPp1ABRgropbeSRPEScaoWun6lIVI2bsPqSt6pmk6WEJbD1gnIJKEShLSUYfikzurRUkzLJ4k7DZoAux0hVb4E7trR8zw6qZQC0tGhjeO0jIqKlZa/BJTTgyEktdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvwmoo3KuTMyeUXPCmOMBxNWEBOjicKW5gEJ9zjH9tk=;
 b=uyqqdi/B7I++VBHeBPMxNsqWbr0jCdfq0gUgCFKrEN93mS9jS61rBzQbG6FK6/Cre7xOFxN3uY0TOehFRFJ/6+0CUiR8ltFw6rWuDJmY0+tjraLoXb/OwosOzkMsUteWzeSuhyaenM02o6q8qIuYp3Kp4CwgJbyqo0bxCLH9xhw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by DS7PR10MB7279.namprd10.prod.outlook.com (2603:10b6:8:e2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.21; Fri, 24 May
 2024 13:03:19 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7611.016; Fri, 24 May 2024
 13:03:17 +0000
Date: Fri, 24 May 2024 09:03:15 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: akpm@linux-foundation.org, fleischermarius@gmail.com,
        sidhartha.kumar@oracle.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] maple_tree: fix mas_empty_area_rev() null
 pointer dereference" failed to apply to 6.1-stable tree
Message-ID: <w6easm2a7svb4rxc5lfhnfsruceudsqhdjlerblwtczln7uoub@yfma32amjpwn>
References: <2024051347-uncross-jockstrap-5ce0@gregkh>
 <tqyvr6nenpho7fg5p5byipkmlhrv7oqdw6qi3mzbq54nofeohf@4m4fe7xcxoyr>
 <2024052401-scrimmage-camera-8cfa@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024052401-scrimmage-camera-8cfa@gregkh>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0305.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|DS7PR10MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: 6168ce45-0f66-4dd6-4750-08dc7bf1e15b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?2OOPI4/MbhOlU7J7ULcDoXmumMaSmCih99pa6MLs68HzqwAksnGT50QtI19K?=
 =?us-ascii?Q?iIyYHbLM9vPWDVIuiLUJ+yhF7ilrZmsyt7dQGjCqpk+SYPx0P/0f77hAl9hn?=
 =?us-ascii?Q?Zq5b0eKM6xLaEo6+wm943E+uIMs6RkOR3/LrgcxUt8lH4jum0tppDAvc4No5?=
 =?us-ascii?Q?A9k+cwDXVQz5B3ARI2cvAVcqrkV3oRShMqEoLOVWVpiFLx04PCeiTz944+e/?=
 =?us-ascii?Q?OZUtxun3OBOYo+rhassIO1oEazKEsiStGPj3JRn47QID8aoZypFfpK2BMct+?=
 =?us-ascii?Q?MYnlZED9HHFD4/qeoA/ZZjHrrkMxyxtlYaaqZpmjue81NtQ/bHGH/Z0TEJLn?=
 =?us-ascii?Q?eLsvi2yzF1GaDc+QwAkpjkIooLJC2Ck8bGk71o++s6e5WuqE7xLrEIda3cdf?=
 =?us-ascii?Q?2FBntrb8eNM9byD5O+h9bElWFCTIBP/O7QhlioW/0kWAttjQMYBxu4Oqkcph?=
 =?us-ascii?Q?gFs0olctNSv3oRmRzjKjPWtoZ0HT7qIhlLkRqiuqMHqwALQQofCICWXTJ8bE?=
 =?us-ascii?Q?33Sa3JIINCQ/ZOBtf0NKOCprC833Dvth/vB02EZymqDmL3HihNIJaHoOOWH4?=
 =?us-ascii?Q?GXh/fxGiPy2DDrocvHKnq0y6353wmot677b5bud4MFs4trbs3KQp+Xv4Dl73?=
 =?us-ascii?Q?AZ3BG2h+qgUv8h6vjl4MnJx7ySHeDUuHzCVEgjX4Ach1i6x6PdX+FXqrzz1K?=
 =?us-ascii?Q?peb/OOahTGoC/RvnHCSC9P79AQACZB8V3aIfKbefD9YT/Qxls3qWrohLr4FP?=
 =?us-ascii?Q?Lcc3pZqUbpknu+yOjM9y8TOWxdA5Rkz0CYKU2+2pecL9pRaF8kRQEUI/bUzC?=
 =?us-ascii?Q?yLpYII2QcrR4/WNKK/P544UNCCNUiTdy0uIlfF/CeLLlyMk3feM29rlmhPu6?=
 =?us-ascii?Q?5q30JpwD/Bl+5wIBped2n+Sa7KbrtVCz7ctezsqLZYEzv1+i6+hOuP6Pf0ky?=
 =?us-ascii?Q?qBcE4Adyfi3yhj6NRzF8vJ8bfhbF2tN2DIsCuBdPcznAqa4kx05N6jqR15a7?=
 =?us-ascii?Q?DVIwyyjzRfBzxErdfXabZ/sYJhOYKXMTEEUHJla6HXNXPw7RUcb10J7pUmUk?=
 =?us-ascii?Q?aZzoBltaeG2QV+KrBN4kf29zfnFEXKT9DiKAE9i636uQYJhojt/eQkbdyaGj?=
 =?us-ascii?Q?U3DH4TzfYmHMwNZO0V4YRNNWanl5HzYS1MREzSwXIstcjm+7Fizw1rvKBmFL?=
 =?us-ascii?Q?skNEGVJxd9M14zg/eLpgOSBAo+yEJ/RdsbaMTmNha8H+Wqc/Vvozwku5FR4?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XG4T+F2Yll1j6wZf+TRs4hudOwsVBMe0GUmqPlyUSYUd5UNFFY0sKDCZtZpX?=
 =?us-ascii?Q?oI50kyWSjI++XVofEgeDax/yi6/sOXM9C0VAAzXiIMufY3tsL2IxqL+S6h19?=
 =?us-ascii?Q?6NxxXpbrWgoQTK6ugL0Ogpi1+/Z9AlC+159Gt4mo1STAUodZoz2sUlJ3SDH4?=
 =?us-ascii?Q?Y12A9rR+zArCIVy5Xk+1dfy2jee7L7f2vmTXw8C8V9H+OsbVIxODRuQEvphl?=
 =?us-ascii?Q?nLcoZQVAVCsLUWU9UqLw9o58507teMMlfZQdFnD9xXrWhregoHdUm0LDdN1r?=
 =?us-ascii?Q?mGsV8QkIaK70eO+DvReZRuOqGXvoroo3dL7Gzug2JTr63AMoLoLyZqm3Pcde?=
 =?us-ascii?Q?q1WlqJ518wpqpVrWUV49OZ8riLtoZEpKnC6HxKHZQJOLn7R73N6JWyT20VBx?=
 =?us-ascii?Q?xsLVoBaGra2J+fSKxrsg7UtDlg47XJCK45DUI5yzk/0yutXL7tdNl997w0Ac?=
 =?us-ascii?Q?L0mxIr/7V1zwY00eNn07x2A9TCmJyBl91hDwA5rtVwzHGubquHAsTqcu8j4m?=
 =?us-ascii?Q?9kAQ8Ho7p9gXKPJRa0mzi4B8oWmeanp7DKujFJDMjHaRffZtLrbFwXOj9OUz?=
 =?us-ascii?Q?EnJHtiTbh6kmeRMw44XY25XPQJb9GKWacpzIiyARfqKlMEhiRh0Wl4VXP6M8?=
 =?us-ascii?Q?huS8nVPofRCoKkBMmj7lbN5Bd8KAAdqYbyOzQzydYpLC9g9B1GEQI8n2Xu4k?=
 =?us-ascii?Q?FDx7f6GNbSwH6jookBjqSYSbgFXzM6o/uQVVJAa6W/f5olCR6x7CwQSktemH?=
 =?us-ascii?Q?SGyW1h11ScbIvkv89iD2s9r3ljBus2oEYdDFrYmMdfwdoqokrt4XglPkVoPh?=
 =?us-ascii?Q?ha+H71X/hA+d/8lmq33E3jxepJGcSJ1LDbnRp4ClJP4chNQPA1dNxWKFDzv+?=
 =?us-ascii?Q?vNJlHI0huChYidk2nMOeSHGu3Ib8b26OOLxTzZayKNj/InCkSY/gvJ7T2aMS?=
 =?us-ascii?Q?/srJpNaVWfIS+qdFc5izvp3oL9zfO4+QxEra6eIXnwTNnBJlhY7fJbl+9Xg3?=
 =?us-ascii?Q?07RT25POsmnF0EwwUTr3706y9dSGp87oNUta0BAm5PFSUoG3yYe0fd+u88E5?=
 =?us-ascii?Q?ziYz8TYJhGl7RnyBpLFlAqZIUDnyqOs5V1U3zJh0yycD0OMfCsf7CXsWE7qf?=
 =?us-ascii?Q?wfmjnJAXFFnsHUOh2ij107FLZctFm+KrryL8vXURXsb5KN1ctqn41pVss4RI?=
 =?us-ascii?Q?zoot+Msv9h2sZqR/4Yrdclv5boDYgHn9KMx6TBwN0bIyRCPm19RbnW4AvRfn?=
 =?us-ascii?Q?ex2c5iowBoLkMUzqlPZz5sN6xHHb3GLWH4WhuojCbi7TZQZ6ZMhyW6JNMDW0?=
 =?us-ascii?Q?d6ele6sPsSn3mk6DgPHtF/BDMwr45DdPCeQ4xxv45CKwRYUihRBPksqGCCA5?=
 =?us-ascii?Q?QDsL39lvkZC1cj/UAcU3Q4UINJHFOx3Qpmznzt58ro/PcMmjq/afxGr/3+zy?=
 =?us-ascii?Q?YbZYQ+zY3ghc0uizyG40UGZT1XP4mIGnXKtXY2hL0Ny4C4vKrRjBUIU8XloC?=
 =?us-ascii?Q?kvSMdgFspA+/2iBM8E+WzRgn3ws1Gl/KRhQ3B2sS+nQEI4xy4sRG0wHkhy5f?=
 =?us-ascii?Q?eVpKKoy/+V/EwgYHZMdqcifu8+pIMtnKl1F2LRgL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QCKeBdPAJamHf0Itawr5h3klVLbHvGRkm5j22OOYy9hipdiaPEUCOQSYk2ibsxNDC+vt8ggfh3Nci44Ie3JIDDvDGypMe7g3IncWd7otnt5Fa+0UA5/NZGJI0ylvwNWi4O37cMjCr+HlSLRB0EKHSLFtjMPuzXvNks3wpMpFSGUw6GmCAaWbcW5q9/BNQ++LbEdnLYetlJBhZikhgoT6H2CjBUpxMixvPvjuxYCdOQUududtsFRnZFPyMGu2qH8Zlk3ecbc3WXVDk6RESZhIdo8t+VyG7kcMRzK0dWSd37sAjagxVh5JyAvUpV44ieqPC7hYfD3LbnygR+9MFeaUEi6wMwx6ltiXj/OP9Z5mjghaEeO4Q2sOvQKHbXPO8VYjTl51PBo3D9pM2L+S9Xn50tG8TOuReezFJCdea4lLrh/JtuBYOi8zZx90vGaRZQktQc53CsWDQCG7tvaDuP1A2dneQ7GXm6M0BtaMMFGGH4vBWsQIsu1LJxILPXpxI51rofrNJxbY9NYv4H62dlEplm57AmAh7E05xAd63o+VQV1KgQm1l1mFt8dQ4d9ZB8/HS2Ay8i+Tsvh3DHoafCrah5do4KQA9b9RX39oj6kRwG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6168ce45-0f66-4dd6-4750-08dc7bf1e15b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2024 13:03:17.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 42l1a/6gWYE+OA8AY5T6a0YCgfqqNH7fg+NlYLfydlnhpfLyLAr6AanZHBAnD6JrumWPvJoRNkXK2aoJsQHSYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7279
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-24_04,2024-05-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405240090
X-Proofpoint-GUID: Tm-9NpbUgGWG3EzCsY1S7vNCDbLKrORP
X-Proofpoint-ORIG-GUID: Tm-9NpbUgGWG3EzCsY1S7vNCDbLKrORP

* Greg KH <gregkh@linuxfoundation.org> [240524 00:10]:
> On Thu, May 23, 2024 at 03:45:22PM -0400, Liam R. Howlett wrote:
> > * gregkh@linuxfoundation.org <gregkh@linuxfoundation.org> [240513 09:30]:
> > > 
> > > The patch below does not apply to the 6.1-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x 955a923d2809803980ff574270f81510112be9cf
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024051347-uncross-jockstrap-5ce0@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > 955a923d2809 ("maple_tree: fix mas_empty_area_rev() null pointer dereference")
> > > 29ad6bb31348 ("maple_tree: fix allocation in mas_sparse_area()")
> >    ^- This patch is needed, and has a fixes tag.  I'm not entirely sure
> >    why it wasn't included in 6.1 already, but it applies cleanly and
> >    fixes the issue with 955a923d2809.
> 
> "Fixes:" tags does not mean "will always end up in stable".  Please
> read:
>     https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
> for how to do this properly.

Thank you.  The Cc of stable was missing but wasn't required at the
time, so this patch was not taken and wasn't necessary.  It's better to
take it now.

> 
> > > fad8e4291da5 ("maple_tree: make maple state reusable after mas_empty_area_rev()")
> 
> So you want us to take all of these?  Or just the one?

Apologies for not being clear.

The last patch in the list (fad8e4291da5) is reported to be an empty
cherry-pick and stable was Cc'ed on that fix.

Please apply:
29ad6bb31348 ("maple_tree: fix allocation in mas_sparse_area()")
then
955a923d2809 ("maple_tree: fix mas_empty_area_rev() null pointer dereference")

Regards,
Liam

