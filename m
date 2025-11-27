Return-Path: <stable+bounces-197064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AE199C8CB20
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 03:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A07C34E2B27
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 02:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C8529B20A;
	Thu, 27 Nov 2025 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="KktY9A9X";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="F8R6VBs0"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12C226F299;
	Thu, 27 Nov 2025 02:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764212204; cv=fail; b=Zpvv4PwRya63l/AzEWJSq9l+KlrPP7GBJpm2Xzu1sWKp7qVeplDovP/HkHJFuQd0YQx1gZLaGtQkdw5NacGZuoexdgLcETrwrbycnxeDaslV92YRjwvp9tEtgekvK0Kk88AsUL5QBSqH4OVaE2wNEhVOG6BYyRKtTnitScr4PNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764212204; c=relaxed/simple;
	bh=JueSpHIOTlg8Yi6bYMX/l4BMmfnb/Sb1LGYa5nIN34g=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=S6wYPlMN6WJbj9gn6V7uq6WLMZtxYHyAeW/ruqjBYog85n7A2KBca1KbyPKZT6V6Fzzr7wu0x6/zuQKI6JU/VTUvdB2YK2fk3MUDJ25VIkiHNHfTtcfCsOQGVS/J5Odi4XKnXGHbgWNh1rfWd+JomxRh7E6yBbwzcr8dvZP6KZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=KktY9A9X; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=F8R6VBs0; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127842.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AR11odZ1765048;
	Wed, 26 Nov 2025 18:56:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=WfXOY2EMlpU2h
	4tKy8yn5BP3ki3PuQRI1YoX0U+rNIk=; b=KktY9A9X0UEBIPm8R055GXsTNcMyO
	sCXGh0FShoUDSaQHTtx7vEQ9PPvpaaLh6+Rxhp8FNbCWNLkZPbQKQsXM7R2LoXZf
	h/oMZED7YBQbmLqhfz9V5I9Pek3Lc24KvwNKTJJeO//Hj0goK+hDP5YENEfLFXaH
	RdBA9kiBqMn2diC6ug+qr5gIDR9HZYvWNLoxV7C2DXBu6RhPNJHJ6Dum/YJY0XoH
	lBSN11a1cccFAipxvRYzvVBKplu2tAwM8RjwVjvcQ4AsPzABpMXuu1DhU/YKSBvD
	he4Sd7AxHOcyooVChYWNplFWj7ln6BBVuKEMcl246kg5qHM3fVQgQq6VQ==
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11022091.outbound.protection.outlook.com [40.107.209.91])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 4ap206he41-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 26 Nov 2025 18:56:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BBszFZu8MlAzCx8HWNxjuFDY9xtJsjNjcuyC8YtYS8kwDiWMrwTXis0RJyM/8/jnQtNASY0aObi47uPFEk/lz8hI7s6iBngTuLWpeZ16eb7+sIXbFe8e2mrbDawI0yyxYeszqrzvCG8rizroaUJWkwzQG2ifzdX3ENLk8xguQa3/dLY0LnIfayxCNMUO9AC1EGvdsX6A08ActaIL4QGjuRj8FtLrhNGeFqbB3++EFA0JnPKSqcBQuTvT5INCk1gAozSCM8ZCR+wzbYB/DKLKTrbvAGcgW311ZCLKTvU+8z6EqLVG4TCi+bAsOhyxo9FY+zcJsKH62eTpLISnDMYFiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WfXOY2EMlpU2h4tKy8yn5BP3ki3PuQRI1YoX0U+rNIk=;
 b=aBHVzPqOCe38Yh6H/TY9vM0shX83KFhyKVugbRpTEvPO3TahLaaZQal1dfe9ozZjEQy92pJ/+9ec9t4sMZG0sRaLe+wYgvNzC8alifo8YcXmo90jivZmsVnksAGYoSF5YjXsEV3MlXsf5ELkvuMWtM/hZK87A5pUH8epIo4KbisiP3FWt/d5lS2jUv8D1iROikFzKC22whg+NnZzBHVOoLLPBembF1NnBr4cO5u9FkvZfVsCuNXHvQHdBgCKbMZWowYeOZ/+qNEoudttZOD8BUCpXB9w5XB6+enk+oqhyhAU7Hjzr/syDR+k0FnDeUSwMFiYaO7ngS3cw6yAarSHuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfXOY2EMlpU2h4tKy8yn5BP3ki3PuQRI1YoX0U+rNIk=;
 b=F8R6VBs0SwDMLpSa5+bUDPK23EQqKV+tRrp9qQFThfZUudCJ9y1xrbuOHlJRty18JSPzaUTHWRAJEn5z32cSyHG7R6zIKWxRY9dB3tRq9ZSV4TBf1ot5XAioPmJjNSPPlGAA4i16gRGbyRN2twTBWh5Kfn3QSZ/L6f0ul/hO7vPJL0zxbI920eE9zA8+m813J8kqNJE15jMZdmLVZGCUHfC6msxrW0Sc1YibPnAiG4J8EO2MqvFJpsuka1QJdNKxyN1Cpj2wVpX4qx1EJEIKJDQjzBaaJXmAgh7VYobi/u2t+HgRpkVWq1PUmvqPx5qO/wN4/YoxkTglGomO5HuaXQ==
Received: from DS0PR02MB11138.namprd02.prod.outlook.com (2603:10b6:8:2f7::17)
 by CY5PR02MB9039.namprd02.prod.outlook.com (2603:10b6:930:31::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 02:56:17 +0000
Received: from DS0PR02MB11138.namprd02.prod.outlook.com
 ([fe80::b514:ca81:3eec:5b97]) by DS0PR02MB11138.namprd02.prod.outlook.com
 ([fe80::b514:ca81:3eec:5b97%6]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 02:56:17 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
Cc: Jon Kohler <jon@nutanix.com>, stable@vger.kernel.org
Subject: [PATCH net v4] virtio-net: avoid unnecessary checksum calculation on guest RX
Date: Wed, 26 Nov 2025 20:38:36 -0700
Message-ID: <20251127033837.3002462-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8P220CA0015.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:345::23) To DS0PR02MB11138.namprd02.prod.outlook.com
 (2603:10b6:8:2f7::17)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR02MB11138:EE_|CY5PR02MB9039:EE_
X-MS-Office365-Filtering-Correlation-Id: e2c3dbd5-df94-412d-dffb-08de2d608908
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2ry03klK13p5AkAAjirvSD6kAll4+BtI9dzgnjj6qFMTJ/xB/Ji6cf9VIj6m?=
 =?us-ascii?Q?daF0HGmTfeXglS5Esb8JarKWek5A4BPZP3U93a/ytzRSUb6JxcYeJmXSg04T?=
 =?us-ascii?Q?1ETDfC89U2yfBbokklOwaUq4yMN/JIqi5xpK0NNsdBcSBfIuhEt2Ltwsq9h3?=
 =?us-ascii?Q?lYD5M4w5IBTZKnbOnxzdSRv96NMHEoca/yIi4MHK7P2QmqFHfzRhi05vWN1S?=
 =?us-ascii?Q?cK7pOUXh6aUE0Hjr6XFBOOKbaqOqtCYeBQqgjGUFuGhnD5cnPidhq58+u/e6?=
 =?us-ascii?Q?7C2vLVlQ+qDcZPALY9NJFCRkdQHlZ6mzUbuWkE9fgNPaG25t841okTeBbsA3?=
 =?us-ascii?Q?F6civ8ZAISsMIO5BRL5xrRBHWGx8Dgshke4Jseh6ZuXd+9NuvezAoD7mhKhk?=
 =?us-ascii?Q?D3Tc/6WqCabDfAfl41IASxC6QA+hrzW2cmDJrrl1gcEaOHfQjBpNOxP9PiXt?=
 =?us-ascii?Q?WcRtw+i55dXq0o7gGdN23dpJnyoa67csdNyB5QGwER4luASpsVkHWqeSf769?=
 =?us-ascii?Q?OuX5svEvnVSLFMkba4WGE7GXdOsb2zfGN3vylesRqhf0z2tCH75CZOy1BrD+?=
 =?us-ascii?Q?SYlBAdicBAnFlabwKonsciqVrNbqSJwm8moh6xptfzH6i/2TbTFTRAF9zh21?=
 =?us-ascii?Q?r6kbrI6/vnOtpSLKtb826T2jyjHbC8I4uc+pTqd10Ryl3KVTUNVlLmWhl4Lz?=
 =?us-ascii?Q?mrxV5vKqiVRSsFQq3vLVr4LWGfsJ+b2R6Z4AV9vef7LQ6ASznOif/8FjofmZ?=
 =?us-ascii?Q?93HkJKQx28JzOUODW6C5E9kqVJlIx8aJMk6iYRutR9FigTVv01QpJat1fuFQ?=
 =?us-ascii?Q?97EPM9s9ZhthAQzbgX6HyG7nKXY+7drqAIX7Z1wy5PNp4ElmxedLVVWXMFrL?=
 =?us-ascii?Q?CWTXBhknqkzkdOkTyXvSuntwHc6ynsDBofYgdU0ZFMO1KqLYwlX66UDuXf3I?=
 =?us-ascii?Q?qMGei+/x1+f9r3WSRzv1NhQ6kWEhggOMjjE2knnvhCQCC2zzh4fZmVZ6mn7m?=
 =?us-ascii?Q?7tj6hoolrynSTWRWN+nFFQ8/O390k2VVlJG6R8w7dAQqS3V3VKL0tZPpM8hy?=
 =?us-ascii?Q?6tBPt4U+RTEw5g8ANM0d4RjR7kzRv83I0ySv0qt/ET9AJIHbenPDHZTXecaV?=
 =?us-ascii?Q?A+hul6Tebud25A9z0WpXEo+N9+v4Q3odwzyFjbvYJw/E8V+kt3YzG2UhLZxP?=
 =?us-ascii?Q?TIuMaavW/TBGly7K3Ir0sNALxpGzkPfBYjeNEDVvdVrSYOwjZEvUQfRTp/ln?=
 =?us-ascii?Q?9O6aLT2Y/r0lli5hCFDfSD1eFU/FPYr9SNjWike5xC76Lnu3k8dQ3jDz+p/Z?=
 =?us-ascii?Q?FFhotF54Eiyq0jSSoOCLxsYOolNm6JS+K6hZ/611EZgaScOFrAs7lBrn8UGp?=
 =?us-ascii?Q?HEXAohsuD+SW+kr/1cDSu1sgMcMsNdb/7wixUV3yoc9UHrZBZuT9WiJEQMhg?=
 =?us-ascii?Q?RNv7FoWhdDxNyKGdiUzbaRoOZmxErK3g0QkykC6JIOLOzmJkZJD9Pv8LI0Eq?=
 =?us-ascii?Q?MjTKM5gVUTiPNncuBLkDNR5pfOA0ikr+tjZ9/zg8YFfy2WYnYqkCE6/8Uw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR02MB11138.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(7416014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xGOilSA4FnnNZN64s0oJPz1IoSDOdoTOztNhMQzM4euyIFwe6JcnGulx6NAh?=
 =?us-ascii?Q?4zHGzOaWBph2xDR4MHklBlw9DDoOueG+TpMQqco2a/Beh5yy8CRVIDoTzyDr?=
 =?us-ascii?Q?Z1I5qT4jK7OVt3Ga2wcydosQLQ9VuNcvnBGxpM2k8W5ZRHD1y8Gq+W/UaHeV?=
 =?us-ascii?Q?5LLlOBM7JHGeanBNOyip4us6ozKYIHCxAjxeMLyreQ0/FVZ41lAC5W2RxHI+?=
 =?us-ascii?Q?AteXPq7PMNEt1IXGdsYjvL/5MssVzNPSEXBOp1B7xSiOfLmybPW07ixk0jA8?=
 =?us-ascii?Q?YvJ0qI3wyB9PYwEVjMpe8l0Ke6TOcgbhvPhWETlmmP42rZpLe2RF9UVhNTq9?=
 =?us-ascii?Q?2TOWetZhKvO8I5mpaoGkXs1apB8iahCqxGHtxRMJJHQ71/RsE+cN1TP5pcpg?=
 =?us-ascii?Q?QTcFrtTUIxg1/lKUgLEq5jstq3aQ+IJNvqSVlAsBwSXQz4OAJvUNx9AaJ9+r?=
 =?us-ascii?Q?EVfz02le5YmM9DsmG1Y13SJb8DvEf6Sq+yREIuibyX0WKGNtwRU3wFMC0pKW?=
 =?us-ascii?Q?2xegpp4U33D1EdyrJtsUiDMC+sgZ0T9I04fqzH4hNAG02JvOYy4elbjz2hSV?=
 =?us-ascii?Q?IsstNHyseGo6DKXDyfLAZwK53VRhiLRmZjK/HOkNwZy+v7V/ZvxiDKUpIPWk?=
 =?us-ascii?Q?XeWrBrSsw2CfbyJy7UEDMAajX6IunIgHWOY48q4+uHb/8XbzRFvQqVn1IEfo?=
 =?us-ascii?Q?Y5f4azpB9R3F2uZ4WdidLur5u2BVQmEV619p0ZudrCBJSIWiesaht/Pn2EAt?=
 =?us-ascii?Q?ziHjPYFd3EKN3Cpl7Zkn83nGFh4A7zmi2vgGl3/DtgvuSs3NSsXMcbaG8Y1Z?=
 =?us-ascii?Q?bU3x+De2jvE8gNGq6QmiCYnJG6skPQSGf8K+W//IQdPOfzdYCdapAbJgFHwr?=
 =?us-ascii?Q?P+PndzpkmP1EA8urbEVQdyFuftRIvxj1alYlOZ1wl7AdqIxhBLIlV+0zDKek?=
 =?us-ascii?Q?kXsRVXVG0MPr0pPh7MwCTWHRDCFoHnd+iDFK7SgaWrFGnNHQ20egYkLtcEFe?=
 =?us-ascii?Q?mAjCuRkLVa1dCKk8hOjEYT6H4/Ur+7QutlgV29i1UlPmcL+nriB9v1J3ltnb?=
 =?us-ascii?Q?JsUkmu2jiL810BbXRXNASrql8l3kfdhITqsofHTwP0mTPUP2pp3/IPO//Ukh?=
 =?us-ascii?Q?MKtxAQjxa46sU+YMPocOJdAOr99AX555w+0MTUeopZYrxLGm2wCbJDE45U0a?=
 =?us-ascii?Q?lNxOW6amysppXknimJ2imVKChSyvHpcGO3Y4YPrD0b0vahcH690BDFqaVJIl?=
 =?us-ascii?Q?RBY5HepeHNf8JwOdXOdDUnfY70Izq0mBYrvfx5jyqL1WCMgtorcuZ4OP53rA?=
 =?us-ascii?Q?TDn1N+WsyLTdOlvOEuSSxVC4aMP5bQLq/QwUS+6SzsZ/njchWbuHxTt6ETxX?=
 =?us-ascii?Q?ICkOppXJAK1rwwQLe7WN2i84bBVohAhdfZ956Bai872T45+86GDyZWjnqZp8?=
 =?us-ascii?Q?qDfLoLu9zECmonAeIbM+EmlwYxx0Y4bB4kgurlYvYUNHiwqAk8hmIy+rWolI?=
 =?us-ascii?Q?pPh/fVOnu6FmBD0JJBBxsq4Gh7Ihz0hpNwb4C7CtGGUJf8qCC/rRzT3NATec?=
 =?us-ascii?Q?U2oFl77JJuItcF69Be4APD7+rRMoakkcXBQErQZgYTagav2STnf4MutTFwRi?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c3dbd5-df94-412d-dffb-08de2d608908
X-MS-Exchange-CrossTenant-AuthSource: DS0PR02MB11138.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 02:56:17.3134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3+IQ4SKvDMly3o27patqYkI8uAKHD/oI8DdmlQqSNoBi63tqSS56+44KdSPlj2DaYv1lOsuHWUAI3XvpL/VdQcXk4u79PrqHYJ4ebb92Ek=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR02MB9039
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI3MDAyMiBTYWx0ZWRfXxGwEgDo3LOKn
 PjZbbfPnHQtHgrNemFDmRs5qetRW9+mAhAOgUchyizDlfJNrlb5m0oSeHDxYjkX+3cZakKEXcx3
 fsDwvXjVs0y3fwRgSKlJ4erh81BU3YG330Xnh1fsRpKtyMxgpF4345DL5VKZB2wxkOMJiZSd3JO
 XkcD/2kEv98527+/TcfC1up5+a2peex2a7paQS4mjrZQ4HfWtee3qZBxxNCTGzzwmdVQ9FHZf37
 7BDgs4O/zqTLLMfQkI/RVsFxpVS8kAiswpPysshIBMq1cx87DLzoxaVN1lMKEnAipETkycPaPSh
 DTeS+sQdB5tGyM8e4CRQ3FuL4Ytu6TbDcrDegfgd4IvnXup1UKJcT4vR+5gmco3cFkblRQqjFfL
 h6JxQ4IaWhWPnwKtMdyO+B5kPTZF5g==
X-Proofpoint-GUID: DmEw1nXum7gGFV-9aU-a0BvrnFPSeIbr
X-Proofpoint-ORIG-GUID: DmEw1nXum7gGFV-9aU-a0BvrnFPSeIbr
X-Authority-Analysis: v=2.4 cv=OaSVzxTY c=1 sm=1 tr=0 ts=6927bdd3 cx=c_pps
 a=MYP/rumDVsRFgfoFHJYHXQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=20KFwNOVAAAA:8
 a=mpNxyM1ivdqcNymvxlcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-26_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Commit a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP
GSO tunneling.") inadvertently altered checksum offload behavior
for guests not using UDP GSO tunneling.

Before, tun_put_user called tun_vnet_hdr_from_skb, which passed
has_data_valid = true to virtio_net_hdr_from_skb.

After, tun_put_user began calling tun_vnet_hdr_tnl_from_skb instead,
which passes has_data_valid = false into both call sites.

This caused virtio hdr flags to not include VIRTIO_NET_HDR_F_DATA_VALID
for SKBs where skb->ip_summed == CHECKSUM_UNNECESSARY. As a result,
guests are forced to recalculate checksums unnecessarily.

Restore the previous behavior by ensuring has_data_valid = true is
passed in the !tnl_gso_type case, but only from tun side, as
virtio_net_hdr_tnl_from_skb() is used also by the virtio_net driver,
which in turn must not use VIRTIO_NET_HDR_F_DATA_VALID on tx.

Cc: Paolo Abeni <pabeni@redhat.com>
Cc: stable@vger.kernel.org
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Fixes: a2fb4bc4e2a6 ("net: implement virtio helpers to handle UDP GSO tunneling.")
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v3: https://patchwork.kernel.org/project/netdevbpf/patch/20251125222754.1737443-1-jon@nutanix.com/
v2: https://patchwork.kernel.org/project/netdevbpf/patch/20251125211418.1707482-1-jon@nutanix.com/
v3-v4: Collect acked-by (MST, Jason) and cc stable (Jason)
v2-v3: Add net tag (whoops, sorry!)
v1-v2: Add arg to avoid conflict from driver (Paolo) and send to net
       instead of net-next.

 drivers/net/tun_vnet.h     | 2 +-
 drivers/net/virtio_net.c   | 3 ++-
 include/linux/virtio_net.h | 7 ++++---
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
index 81662328b2c7..a5f93b6c4482 100644
--- a/drivers/net/tun_vnet.h
+++ b/drivers/net/tun_vnet.h
@@ -244,7 +244,7 @@ tun_vnet_hdr_tnl_from_skb(unsigned int flags,
 
 	if (virtio_net_hdr_tnl_from_skb(skb, tnl_hdr, has_tnl_offload,
 					tun_vnet_is_little_endian(flags),
-					vlan_hlen)) {
+					vlan_hlen, true)) {
 		struct virtio_net_hdr_v1 *hdr = &tnl_hdr->hash_hdr.hdr;
 		struct skb_shared_info *sinfo = skb_shinfo(skb);
 
diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index b0947e15895f..1bb3aeca66c6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3344,7 +3344,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
 		hdr = &skb_vnet_common_hdr(skb)->tnl_hdr;
 
 	if (virtio_net_hdr_tnl_from_skb(skb, hdr, vi->tx_tnl,
-					virtio_is_little_endian(vi->vdev), 0))
+					virtio_is_little_endian(vi->vdev), 0,
+					false))
 		return -EPROTO;
 
 	if (vi->mergeable_rx_bufs)
diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
index b673c31569f3..75dabb763c65 100644
--- a/include/linux/virtio_net.h
+++ b/include/linux/virtio_net.h
@@ -384,7 +384,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 			    struct virtio_net_hdr_v1_hash_tunnel *vhdr,
 			    bool tnl_hdr_negotiated,
 			    bool little_endian,
-			    int vlan_hlen)
+			    int vlan_hlen,
+			    bool has_data_valid)
 {
 	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
 	unsigned int inner_nh, outer_th;
@@ -394,8 +395,8 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
 	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
 						    SKB_GSO_UDP_TUNNEL_CSUM);
 	if (!tnl_gso_type)
-		return virtio_net_hdr_from_skb(skb, hdr, little_endian, false,
-					       vlan_hlen);
+		return virtio_net_hdr_from_skb(skb, hdr, little_endian,
+					       has_data_valid, vlan_hlen);
 
 	/* Tunnel support not negotiated but skb ask for it. */
 	if (!tnl_hdr_negotiated)
-- 
2.43.0


