Return-Path: <stable+bounces-69865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AFC95AD0A
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 07:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4767281CCA
	for <lists+stable@lfdr.de>; Thu, 22 Aug 2024 05:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9945061FE1;
	Thu, 22 Aug 2024 05:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="myGcRbPo"
X-Original-To: stable@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2085.outbound.protection.outlook.com [40.107.21.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F235B23CB;
	Thu, 22 Aug 2024 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724305682; cv=fail; b=R5TooWDhUL/8Ascu3+ym8a8SA/f3lCYD5WJASOtqg1JEpzNu4q1BcGkWtURwl3lrWA23tioX2RiBzBdPAAIy4YfH4nN4isJia6jGs8G1AzsHn63tl5Jf05HW/xGwpwbJ4fLOQmd1HsoFUjwUbpmFfxOHNjfwA9SV95amShSEKwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724305682; c=relaxed/simple;
	bh=scrtRQiMBqJAUrb20l0BhBKJRNP2SaqLNqebZnnB8qo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rBtrVyKocq9Iv5qQdzgqzEVxvkC7de7D3XKtlzWj8ywpAvvB4vcbcg9GvGcHKJXXqfqtMInLWBgnFsrMssSDEhs6Xk6KA77j5HS+RUQW06Y/rm58VjHqNGApIij86yK2NqtewR8zWflW0lMspFQcWB8GM5sNHHnV8TbViv7dDLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=myGcRbPo; arc=fail smtp.client-ip=40.107.21.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W3+G0KXo7TwGTozP3dX2ea6wq4k2pmiwFdUAEV5uCt//k7pxHwIDaGWgtzWe1/iX408s9zmKP4c/+T82DvzXPaBHqJBk8UAtlhINQFutx05v4oMvJAJIrIYozYyJLHcP0Ps8NGO0iAOECYcobfDZYiUDjeXEsmOMo1cteFGz18g5HTNMdgdFAidxhB5If4cbFjzYhlTD9FGDU55Kz1aFZt7dBtM/8owb9QYWn9Z0QBHjkQ1uNqQ3VH1nAfDDjfm93JLhxZPMFQWU14qMoVfIveP6Rn6RjkkwCxYcyPZuzNVjBY0xARo/51Z141/dLHsqSi4E1A9V93sJJ931b5WiKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yP3tBKbA6IUn9ObWANmkgz5vOMlQUC2vB8F9+BJ2fww=;
 b=FvoDUgy61U8cDiCIShW4MMABcH6n7u5eqf35FXJ7KLgVKIetMaMWFynaNm/C3DDVk05kPTtqjV0JkqR/56gR8baIEFxqZGXSJkHGZo5jybNHCJK0JBC7tHvc42sHaFRDXHxZyZFZ8N5WkH2wMSvqpNihg8e1eeIrIxW8lWp/m3UkSDBO5p/lklDmL7uyKN8GjfVuqR5mAKf78bBNMQJ2csBiWZnDCrN38PUtFpaGgXIdlWzl+W9DoCWaCYwjDQqCqYPygwbtxYSjIFjRDkSVzjzaFSEIzdUiVZuN2/oJGcWLSbcdrlJP5WbNSufO2JSYkUPN0pkfT446+v/IQVLOYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yP3tBKbA6IUn9ObWANmkgz5vOMlQUC2vB8F9+BJ2fww=;
 b=myGcRbPobuTstAs/gaT0f+6kJUqMDvoz+jURVbAKvCP5WnZiTv4yCCIDbeyh8ATF/iu+QJWo9f7vG948EPGFFrvpc3StT7Kbth48xnidTzB+WYUa51gz+a+oovW79OKbBYdFHd6h40N+wZFiWIXeagQ9k8An/0H8eqb/c/YGnNI2OTDcLBhI1vrlsMhevE+k/1pN78c68tJxr0YELA4BJ5SAXDl1kycC/chw3lGspL2ezJQMW+34To7qbTtZ9r0MpmjrWqIaaemUf2O1eToT5YgFdB8dRcIcBjuPTXKG5yehv8nDh3pydzzSzb4GqFIdUn67d+Ro5K+PZmntsOa8bA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV2PR10MB6983.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 05:47:56 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%4]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 05:47:56 +0000
Message-ID: <69e773d3-4337-478e-9317-5a713a095188@siemens.com>
Date: Thu, 22 Aug 2024 07:47:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] remoteproc: k3-r5: Fix error handling when power-up
 failed
To: Beleswar Prasad Padhi <b-padhi@ti.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 linux-remoteproc@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Apurva Nandan <a-nandan@ti.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>, Nishanth Menon <nm@ti.com>
References: <9f481156-f220-4adf-b3d9-670871351e26@siemens.com>
 <cf1783e3-e378-482d-8cc2-e03dedca1271@ti.com>
 <3c8844db-0712-4727-a54c-0a156b3f9e9c@siemens.com>
 <716d189d-1f62-4fc0-9bb5-6c78967c5cba@ti.com>
 <eaa07d0d-e2fc-49f2-8ee6-c18b5d7b3b5f@siemens.com>
 <94faa49d-3acc-45c5-aa17-817e3fb31b5b@ti.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <94faa49d-3acc-45c5-aa17-817e3fb31b5b@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0069.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::16) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV2PR10MB6983:EE_
X-MS-Office365-Filtering-Correlation-Id: f2343a9e-209e-452a-7569-08dcc26df8d9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZVlZY1JCTDVuMGU3ei8vUFFQeTgzcDR6VUE3RDZxT3cwZEV4dENJRVFxUFJZ?=
 =?utf-8?B?SnNEZHBuL29IWjJFaGh3dmZFaDUwM01RTkN0dWtJalhoMXRpaXFBYjN0bE80?=
 =?utf-8?B?Nkd0aGFrdmMyZnRtNEEzcjBTYkFGWHY1a3pyb3BNNWFheVhmTTNXNDFET3Jm?=
 =?utf-8?B?NGlRSzFCZ1pyRmZucmJIakhHRTErZ2FvL3pWQXhoZHRjcTkzaWcvd3FYT0sz?=
 =?utf-8?B?WDFKS0x4cDNndmFyWDdHZ3FSVGU1eVVmTkJRdEdMNHlWYzdFK2ZJeHY3TUFC?=
 =?utf-8?B?QXRWVVBadzlPS0tBdFdIKzZrN0FCSFRqckNBR2pUV1Q3aXk5YWFWenFWLzJT?=
 =?utf-8?B?NWl3dlJCQksvcklwSVE5bDRnRUt3YmtXdytLOTVLa3dwamdTVlozNkppRkU0?=
 =?utf-8?B?R1BicEltelNJRzVFNWxsdElYeFBqVXZxTEJDdHpBY0NXUUw1eU5ZVVhFb3M1?=
 =?utf-8?B?cDcyM2xaZmo0MTIrVUdiTDBDckpTekhtOTl3OHZPNFdyNUV4QitxVGdYOUx4?=
 =?utf-8?B?UTljeFBWV3VhQzFTVjZVYzBQS292ZWJHOWRSdTBBeGg1TXZoT0wzSklSQmFP?=
 =?utf-8?B?eFhIeTQxdVY0ZERhNSs4bHFNb3A5SW4zZ1NFU2NSdHB4ZjJEQ2h1TmFpL3Vs?=
 =?utf-8?B?dlNDSWNuUkMvRDErU09NVCtCWkQwSTFxdzNTZFdoS25IVFdkVjdudk1pcjFW?=
 =?utf-8?B?YnJyQm54YXArOXJnVzJhL0g5Mm5MZUxyM3NsVmd1MUVxNnFCOUV4OExCeGJh?=
 =?utf-8?B?VkhRLytvSmlGekJLNDVjTUEydnRqYmJXWm1lYWdORjNrd0FxYjBJWStxSXdy?=
 =?utf-8?B?T3pkUFlpa3FLc2VpR0ltWUJFdlZWclh0VzVpTG10UlB0aUJ6U3FjaGllK2NM?=
 =?utf-8?B?SFBpZGlqN3M0QWVGT3NhdEw1dE1aOHpBdXRQQkIrUVUvODc5RFZ4RzVNVjk2?=
 =?utf-8?B?Q1FCU3kzbnFqaUFBaWVabVIvZGdIV2pWT3lXcFZxKy8xUGFiM1FJVnYxdEh6?=
 =?utf-8?B?dmU4K3RXdU5IM1UwVFpxUGtLUDNKMVNMSkhjd3ZRdE1DSXJrOHNzQ1NMTVo0?=
 =?utf-8?B?NHdvU1pmYnF0Rm03WmgvNmZLQ3UwTkZLTFl0VG9ySU45OEtoNUpJTWFoS2wy?=
 =?utf-8?B?ZG5nOC9XcmZ3Y0pONEpsU3RRYUNlaCtvZksxZnFKMDk5YnlQQUJjNDAxb3d3?=
 =?utf-8?B?RlpEODkzVEQxRzhyWjBTcGpNbGZqYkhTbjNQcTFpOHM3ZjhHQkE4L1FuaHFO?=
 =?utf-8?B?Z29sRldXbWM5a1BlQ0doVVpiR1FBdTU3SWNWRnF4d2NNcGVrU3NkUVk2TmhW?=
 =?utf-8?B?MTNhNG4rMk5mZzlkL0pFQlREQitPeUp5YzZFR0UyQzlRZGtHQTFlZGgvU1I3?=
 =?utf-8?B?aG5jN1ZtZVpCNlpadWhYZTRrM0E0bHJQb3JTUWhtYzg1MTJBM3hsdXAvYTdT?=
 =?utf-8?B?d1p5VmhlelY4bHo2QWZteG1VMnVSNi80RGEvVE0zcWJYbG1XeU5BTXo5dXBU?=
 =?utf-8?B?WmNwMkdwUE1XcXc4dmFXQllDc3lKQkIrd3d2blhxU3BwV091a054TEtFaWh5?=
 =?utf-8?B?TXc3RHFxZDZza2l2eTQ4QWo3RUo1NmtSTEtoL3VjalhVNlRaamFQYm1ESThx?=
 =?utf-8?B?bzkwVDROeG5mWjQ2ek0zL1hGUVhJZHVRRmh2Wk0zblluWklQWUM0a0RUVXlu?=
 =?utf-8?B?OTRNYjdtREhqaisyeXUzbm1yYVF5cmNoNWpOZTl3TEhBTk91eHhlZXVucmlG?=
 =?utf-8?B?YTNSbHdodldycTh3SlprbXFZaDVjb1lGOHhTTTlWR3hlaHRuMkpGQ0ZRdzY3?=
 =?utf-8?Q?EEJYyYLr3aakNjjpYEOwHdd2IDlQFP6v6nqkM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNIWkZtVENjamZ1OTVsMzlMSk1lVC9wWFdmdCtwRENCaDM5ZzAyMThTMVF3?=
 =?utf-8?B?M09iUDhaT1kxMTZtaitCL0luNlBlQmpiSUhkRGFZbWxMb09nbFFQUytJY1Bi?=
 =?utf-8?B?clVjd2UyZGdVNTZ2QTJ3NU13QXBjcDV2NG1aNXNXanVDRzFabXNHVTY3blRh?=
 =?utf-8?B?WngwZnFQbithTXlTUUI1ejIzcGtTN1p2aWdkbTFXWUVac2Jxd1dOa1NhRFhC?=
 =?utf-8?B?WklNVktYS2VoMHY2MVA1WGhWenNTQWtBS0xka2E0UXhmZ2EyYUFmc1pyQnJG?=
 =?utf-8?B?RTRtbSt4UEorZ2w4dmZqcUFuSHA4dUdKeUduOVlLbXEwTm0yZkt0UFRKQnRI?=
 =?utf-8?B?clVpSTRFQVJmdTNDdWJzNHVzRGxVL3BYWkdoS3NQcE1DWG5XbHNkZGRUNDh6?=
 =?utf-8?B?NEhYTTIxb0lyRGdabElSaWpvcVZDZ3RVMlpLN2x0bjluRVF3dW84NVpBMlh1?=
 =?utf-8?B?TS96MzZoWlVwZ0pXd2RnaGF2ZHlGc2Z5MGh1T1hBTXVCbzYxUnhpVnNzYksx?=
 =?utf-8?B?RERCZDRaV0I0VWgzQUZ2NDFyU1lkdkl0SVhpWENMdVlTd2RlRHZBTDFydTRs?=
 =?utf-8?B?c0lrUmNuMmVoY1gxYktqOHZkTWRydWNpcTV1Q1UrUysrZEhlL291dFExMzlR?=
 =?utf-8?B?SnFSNWUzNndYZFRLeE9FckRLQUxzQko0ZFJOREtvNU9haVdSY0NxcjJsYXkz?=
 =?utf-8?B?NWNwdFE2M2NyN2l3T1pzVisyUHRKSzBSQkw3SDhSZW5hNXBoRDRXUUFzQUJT?=
 =?utf-8?B?Z0x1ZkJSZlVISEpVcTdaZ0VXY2pKSnJmbDJoV0JadGZYTmt6b3l2bGNDTGJ6?=
 =?utf-8?B?QzdkNUttZ1V0ZTNPRllTcU43TDdhcnhySTBMRTRuSXhCY0hsZ3lMbFNiNGVY?=
 =?utf-8?B?RDBPSit3ak5XT2lQOVNmUmtETm1LUHN6UVlyUTVmQXlkSHRhSEpuc3V2ay9k?=
 =?utf-8?B?cDdlbzNTMjFuekcwbU1Bc2hzR0NXc1VQZmpVZDVPdVhTUDNFSFhiVFpBK3NS?=
 =?utf-8?B?eDA0RExmdnpMaW1Gd3NKK0FSUGN3VDdsZzNEMGxZQ3hWUlJEekFHK21CTkZS?=
 =?utf-8?B?RGNmRlU2dHh0Wm9MbXpoV2k2eE5Tb09EUGUwajE2N2ZCVFNIWmhkRU1oZUFG?=
 =?utf-8?B?Rnlyak5lbU4rSkRBM0srL1NDZFBFWEZkakh6QzhmaUh6ei95UTBiVEV1cnJo?=
 =?utf-8?B?cGZHNWF1V3pDa2k1VHdrQTJKRHNZZFN1dXV5TnYzV3BIcGhaQmhSUjdPWWN3?=
 =?utf-8?B?NEh1RE50c3dVVEZLWjl4cjBPVXZpZWQ2RkpQRXUrRXdOMWJqaUVpUzRJdUIy?=
 =?utf-8?B?MWhNTDJZaGhjMjZ0VzZHeUs1cEZoUXBQeThhdStNVyttSnN3bE5XdFBFM2ow?=
 =?utf-8?B?R2pnRVpvUXJMWFpwaUIxZlk5QkVjK2k4SUR4WW1oYW9tcXZUSUpNWFFoVHRN?=
 =?utf-8?B?VUx2WGNQRnM0NlRIMEpxYkZnM3d5UE95SEREa0VOeE9pcnZ2amJldDZ5VERi?=
 =?utf-8?B?WlNiYXlwdGhSWGRTZEFxV3d5Mm54UDZKaTB3a2NsRmNjU25jWDdXb2NEcSsr?=
 =?utf-8?B?YlpKMHRNUEtKMW1UR2tadVZuMDRqUjZyTDk1RjhhSjM0ZXJvYlhpVUpuaGJ2?=
 =?utf-8?B?YkVsY1RYK0dGT2lnZWNIaTdrSFlJdmJ6azNISit2ZmlmVldscEEzUGxhVTFa?=
 =?utf-8?B?a2pYR3NyVGNQeUViK1ZzQmx2cGhpVVJWR3A5aENFVDBRWUNXUjZJV0VZRk9J?=
 =?utf-8?B?dEJXU2dISlhZNmUxVGhWNldhL1RsSDVEK29qQVB6d1lyV21TdzZ0U3JGMUlF?=
 =?utf-8?B?SDFyV3FtTGl5NXFsY3daSFNhYk15V21Lb0hpVDlNeVNibzhDcUpxdldabUV1?=
 =?utf-8?B?WmtrUmExZkpCTExlbWJtZzJqYmowK0V2SVF1L1BtSkFoWEtWMFZDL0RObkNj?=
 =?utf-8?B?M0RnS2Q2RVBBNjh1ekdqVGE2TzJWRGpVancwSWt4bnlvUWdENWErdlB4S0NR?=
 =?utf-8?B?LzVXNjVVcGtuOWpFbVhwaE0reDRpYVdSa1I1Q2JmQWFBMkNpbm9JYjl4L0Jm?=
 =?utf-8?B?VDVhU0JJSlVGUDFrWjJHS3YvbU1mWlRKdE1hSmF4TmVKNVVyTDNqcnMxUWs1?=
 =?utf-8?Q?1kwI9Ry7DmU5eZhnbAehBxaIo?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2343a9e-209e-452a-7569-08dcc26df8d9
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 05:47:56.2759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iqWb88nghRRF99YqwmN0J6CyWacJnNp6s+/1C9NJyCx1pbD6r7XOlp4j5zBEyYUrA+GMolIAXlRhm/AdjNEuAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6983

On 22.08.24 07:42, Beleswar Prasad Padhi wrote:
> 
> On 22-08-2024 10:57, Jan Kiszka wrote:
>> On 22.08.24 07:22, Beleswar Prasad Padhi wrote:
>>> On 21-08-2024 23:40, Jan Kiszka wrote:
>>>> On 21.08.24 07:30, Beleswar Prasad Padhi wrote:
>>>>> On 19-08-2024 20:54, Jan Kiszka wrote:
>>>>>> From: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>>
>>>>>> By simply bailing out, the driver was violating its rule and internal
>>>>> Using device lifecycle managed functions to register the rproc
>>>>> (devm_rproc_add()), bailing out with an error code will work.
>>>>>
>>>>>> assumptions that either both or no rproc should be initialized. E.g.,
>>>>>> this could cause the first core to be available but not the second
>>>>>> one,
>>>>>> leading to crashes on its shutdown later on while trying to
>>>>>> dereference
>>>>>> that second instance.
>>>>>>
>>>>>> Fixes: 61f6f68447ab ("remoteproc: k3-r5: Wait for core0 power-up
>>>>>> before powering up core1")
>>>>>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
>>>>>> ---
>>>>>>     drivers/remoteproc/ti_k3_r5_remoteproc.c | 3 ++-
>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>>> b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>>> index 39a47540c590..eb09d2e9b32a 100644
>>>>>> --- a/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>>> +++ b/drivers/remoteproc/ti_k3_r5_remoteproc.c
>>>>>> @@ -1332,7 +1332,7 @@ static int k3_r5_cluster_rproc_init(struct
>>>>>> platform_device *pdev)
>>>>>>                 dev_err(dev,
>>>>>>                     "Timed out waiting for %s core to power up!\n",
>>>>>>                     rproc->name);
>>>>>> -            return ret;
>>>>>> +            goto err_powerup;
>>>>>>             }
>>>>>>         }
>>>>>>     @@ -1348,6 +1348,7 @@ static int k3_r5_cluster_rproc_init(struct
>>>>>> platform_device *pdev)
>>>>>>             }
>>>>>>         }
>>>>>>     +err_powerup:
>>>>>>         rproc_del(rproc);
>>>>> Please use devm_rproc_add() to avoid having to do rproc_del() manually
>>>>> here.
>>>> This is just be the tip of the iceberg. The whole code needs to be
>>>> reworked accordingly so that we can drop these goto, not just this one.
>>>
>>> You are correct. Unfortunately, the organic growth of this driver has
>>> resulted in a need to refactor. I plan on doing this and post the
>>> refactoring soon. This should be part of the overall refactoring as
>>> suggested by Mathieu[2]. But for the immediate problem, your fix does
>>> patch things up.. hence:
>>>
>>> Acked-by: Beleswar Padhi <b-padhi@ti.com>
>>>
>>> [2]: https://lore.kernel.org/all/Zr4w8Vj0mVo5sBsJ@p14s/
>>>
>>>> Just look at k3_r5_reserved_mem_init. Your change in [1] was also too
>>>> early in this regard, breaking current error handling additionally.
>>>
>>>
>>> Curious, Could you point out how does the change in [1] breaks current
>>> error handling?
>>>
>> Same story: You leave the inner loop of k3_r5_cluster_rproc_init() via
>> return without that loop having been converted to support this.
> 
> 
> The rproc has been allocated via devm_rproc_alloc[3] before the

This is insufficient. Study the code again what it currently does to
role back. I'm not saying that this is the only way to do it, but you
need to change the code FIRST before introducing direct returns. And
once you can do that, you should obviously replace the existing gotos as
well.

Jan

> return[4] at k3_r5_cluster_rproc_init. Thus, it is capable of freeing
> the rproc just based on error codes. It was tested.
> [3]:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/remoteproc/ti_k3_r5_remoteproc.c#n1238
> [4]:
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/drivers/remoteproc/ti_k3_r5_remoteproc.c#n1259
> 
>>
>> Jan
>>

-- 
Siemens AG, Technology
Linux Expert Center


