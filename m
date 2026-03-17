Return-Path: <stable+bounces-226015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBrzCWtXuWnYAgIAu9opvQ
	(envelope-from <stable+bounces-226015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:30:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF2D2AAE3D
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 14:30:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1ED1D3074164
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C513CB2F3;
	Tue, 17 Mar 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="jKIKmcos";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b="WslWQWbi"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F282375F6B;
	Tue, 17 Mar 2026 13:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.152.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773753966; cv=fail; b=s/IZJbSINaaa6sUnl+/tXWjpL20ssjLxfG31zKOL8xT1kfkdfI5pBlpOp0+GSupldjrCt2ndB5977o+sOVgMFkzPIdqXcWuhQwUhbj6o/f4mDnWGnQDMr4c1tKZH6OtqbbcSZF+UjNk0hLg+gJnfy7WBEGJjE/uZxg1xTzSG2YM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773753966; c=relaxed/simple;
	bh=F2pMiwSrKE5uDRuO0jajp1lZZIl1fOYMTsppMpqT0Ag=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnmiyCbmeAZcwrwlCvERU5qinZR+JAR9LfxZinoQmUcb8AetWJhZGtlx3m7/wTlUSTmWMOFWhbjmslLryXntpLEbIv8/62K5RlymLrqrMxKaQEuvxfp6+tyXhD2mWahRs9pPf/G5GoRX5H+kE7HjMPzpFfv/UlrnJoHEnOA5Nj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=jKIKmcos; dkim=fail (1024-bit key) header.d=cirrus4.onmicrosoft.com header.i=@cirrus4.onmicrosoft.com header.b=WslWQWbi reason="signature verification failed"; arc=fail smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H5YApC885596;
	Tue, 17 Mar 2026 08:26:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	PODMain02222019; bh=alBJYNdxGOKvy3NqzYpZjM/wq4xgItsAqCtUgsVfVKc=; b=
	jKIKmcos+p4F89SSYXQ2IWVGWX0UGYvMUvURCp83deX/2g6rV4pTzIfP5yK15llZ
	D34dxu9RgQpXb5H7VELdIrWvUrrVHr2ul6XyrlpYY/t0LZsajk4YlMMHFEkvEi/A
	1Et9Ux6GjbD0nWvMQ9Xghj4I1NUshoE3bwgdiA4OguQECBdU6Bo8NiYSUEbW35mt
	XlzUzBqv0wDDJNnOLojmtGLqszdteAz340QXmfK+T6M8Id88b1UVQJ7Ja9e0MbTw
	omVyVWh3pRw3bbBQT7BNoRKe6QjVSadqHZvNC/uf5+nqaRYqfHWEjbHucKYZtg0m
	TXraS1b7emqEaf98k74yGQ==
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11023075.outbound.protection.outlook.com [40.93.196.75])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 4cw43f3jsd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 08:26:00 -0500 (CDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZkpw8ifWXiUQZ2BTjD4AzwbeUwOxAyssNllQ216iJ88LcdkxNPHH/HJLyMQ6Eyfo1DyTnqec4iagIYP4GsTQtsCiLPEs3Vkf3hKsfW6oqXwqtvHcbJFKVe7o0kD9ANjnyuClMpGTGQ/ix2AQPJRFFyAEbThPJQ4IcgcBS/OqayioMpTFT38wS62X/QSbDlhApeQ+S6k/uP01WzV6yYhnZLfi4cULwau6WONDuqDegoHdwPqXiHFE8u6ruyEUmRbbSLBNrtgFdIqzW1wLRXO1tjIg7auBR9okAK9jhJ4H0wrjo5Aj2psPaO5GSqI6cZK4Z9tqQ1oNxUk5p0xjtL5PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OpDDFAUSGm/G/7NI1VlvtLRSeRsLovus5heDvRjmjTU=;
 b=KeWHKb1QWSvhW4soHVaNVMnufnvsQqeVvYIF74VnXRQmHGBvysyOzNasqS5HNKH8z6M/SW9Th/jveHDYn/6V42weoWthH3KevhtronCM5H1pN/6WMVrlCI2mrIkdD3pQKEmh7tuApyHk8xaflngVSqaSZgbZVs7qfGHMiPt620ip/5d4M1OdvVorXze/VH7z6q5TkZKAIOupGfrJGfK2kUdANzbGgIfZxMLGsJmn+fbwRpELztVEGQYXDx82jwJo6qQiolZ34EKNqoTG5m8610p/5M5fO1jxQ26HJdw99Uk0PKzIaGYfAXQKiZzNeSw1fivdxdoCSENYULyWt9I9hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 84.19.233.75) smtp.rcpttodomain=cirrus.com
 smtp.mailfrom=opensource.cirrus.com; dmarc=fail (p=reject sp=reject pct=100)
 action=oreject header.from=opensource.cirrus.com; dkim=none (message not
 signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cirrus4.onmicrosoft.com; s=selector2-cirrus4-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OpDDFAUSGm/G/7NI1VlvtLRSeRsLovus5heDvRjmjTU=;
 b=WslWQWbixhUmboN7Ni+LY8xyqfz6Wb0keymm7UlYjCW/Y+O+bUkR2JHgLW13KtlLj7pe2hkX0nRP9yp1KwUmbte1NvbAX5Msi5S0YJiQgq0XYJ71BHGBOF9Fkz2LHnkHNq0l/u9Al15Wadvmdlaz5KHq6RjQNPVtsHIJZoVyRe0=
Received: from BYAPR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:c0::18)
 by DS7PR19MB4487.namprd19.prod.outlook.com (2603:10b6:5:2d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Tue, 17 Mar
 2026 13:25:55 +0000
Received: from CO1PEPF00012E60.namprd05.prod.outlook.com
 (2603:10b6:a03:c0:cafe::c9) by BYAPR05CA0005.outlook.office365.com
 (2603:10b6:a03:c0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Tue,
 17 Mar 2026 13:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is 84.19.233.75)
 smtp.mailfrom=opensource.cirrus.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=opensource.cirrus.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 opensource.cirrus.com discourages use of 84.19.233.75 as permitted sender)
Received: from edirelay1.ad.cirrus.com (84.19.233.75) by
 CO1PEPF00012E60.mail.protection.outlook.com (10.167.249.69) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.17
 via Frontend Transport; Tue, 17 Mar 2026 13:25:53 +0000
Received: from ediswmail9.ad.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by edirelay1.ad.cirrus.com (Postfix) with ESMTPS id 822BA40654A;
	Tue, 17 Mar 2026 13:25:52 +0000 (UTC)
Received: from opensource.cirrus.com (ediswmail9.ad.cirrus.com [198.61.86.93])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTPSA id 697FB820247;
	Tue, 17 Mar 2026 13:25:52 +0000 (UTC)
Date: Tue, 17 Mar 2026 13:25:51 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, david.rhodes@cirrus.com,
        rf@opensource.cirrus.com, linux-sound@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] ASoC: cs42l43-jack: Remove manual pm_runtime get/put
 from tip_sense_work
Message-ID: <ablWX1PE/pL8ww2V@opensource.cirrus.com>
References: <20260316124924.31047-1-peter.ujfalusi@linux.intel.com>
 <abgTWxI1Q9M1o+ka@opensource.cirrus.com>
 <d5353ee4-1a3f-43a6-93ed-5127d666ad0b@linux.intel.com>
 <abgyboHV1jaWDUul@opensource.cirrus.com>
 <f461ba8a-4208-4dfa-aa70-e2c85ec2050a@linux.intel.com>
 <abk+o6ZpLRt86K+M@opensource.cirrus.com>
 <f6a22c54-1b91-4013-a774-b56d921cdb67@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6a22c54-1b91-4013-a774-b56d921cdb67@linux.intel.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E60:EE_|DS7PR19MB4487:EE_
X-MS-Office365-Filtering-Correlation-Id: 16a78690-5f5d-46f9-3a1c-08de8428b74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|61400799027|82310400026|376014|22082099003|18002099003|16102099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	60gzrBtHaZovBmriAJSxHnoIXGjuSTAG/mQ9xflqHoRD9olsrvOgTBs1FkJyF7gBcjiRXESmseDFBGSoaSttC6jkLOy/1ijheAGnUEN8k1sxn6sJ6nKyluUbY1ZhKzPv9c7I0UVekzxk/7yXUrOSkpDQChtlYkUT6ztfeaFsG30G8FmEyGjSYMuJ8XmdU2+cO+6teM5hB7GY6zYDmi2mchsznCXUYGehfYaTrSIX2PuK2buzSXhy9kqqwA1jD4LrLcGaqGzp3CryfuyIO6lmTef3KcNe9P2gffxCjm1m9tysAg9d/KqKJRQUlqfQ4UYDXW5rMt4c94toZTO2Aek34iLgPmsf1TxtwUQAl3m/oxLEF2ynk/nMxXY4LNqSlPBp8wJzFFFl3qXEx1McULg5aKLWcJJuX6ldBda1wbZq0lKuLUElbWex7TVz9GTRSJy05osRbf7T3RvE7gdYk5Q17fApVB3CEl/z/ALcAuI/CM3Dcq9sUd9w5PHjArpdWaHe+iRe/CyHVl/sOUA+W3+gbnt/FtSKPH8Uf9I7dHNrvvCbiISr6GV4fgFd5hkH+OGs6PLDj6cqeTnESBjcpWwvY9IejISP7iD1uJxcsy0EsYkDWTwig3JCZp9KLmDTA42NmNr4jNPGr/PLHeIJ8eruaTOAFoCVSqRVpN4xbQtQNAy92DIu9o5hkn6+5b4cYXxHnv78zg5Nmo9ByWsR/sXwRZs5jHFy4G2XbhP0TSp4bNWToe37UI8U/io3uzZZvT7PtTxKNXdDSJmiHS6pa8PNLQ==
X-Forefront-Antispam-Report:
	CIP:84.19.233.75;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:edirelay1.ad.cirrus.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(61400799027)(82310400026)(376014)(22082099003)(18002099003)(16102099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WkIRv+fD3ClUjd73HhFo/EmJhiB51fQCxxu1DwizXibf5vZp6QA6sopc/IBU0vsILwq5vEi3RPvFzlAn03KOW8cresL0yEGhjT4ZYCY8pyP2I1uiwW3xpaBHDVf8Kw9DuFd6luWGjpAdBz2QK8AvXuOn6OXUwD/H9fiwdJCXP8QEoqohnWboD1de2NB8KrRt/sVYgCZdcTB0G1Mh2qXbEGdWOG5xste4mqjtOGKrO2zqnP7mscYPxV1Jh7RD4GEPnzWcAbjfmtVmx214r2ztoAVqWy0Jr8YsG8LJsvTkk7g9i4pAnLQWEKct78CJdwX130XXbBUMAFEX1d9XDvxVRmtfifrgQcfW1tWhkL86vPX9ixot842wYAuv48gyCfhgu0HtNL12qq9g+Z6g0oJCk4jdoCN5cg75VzbK6WUY7IW8zQ746C4lgyS+eIJsBTgR
X-Exchange-RoutingPolicyChecked:
	V+xO3n+6OGqXUNuIZYQej5KMl4xVOz4Z4k9k5RdYEBeWwIBRGTCGSWf2kRKG8iz5h7BeAPXDd6pc6E/jXbmpnCEU88n1rcrhq8TmRX32dO3aKVTHEvVUIiQF/OuJ46vfFjSlkJ/9qrOsuVxYVLSP93Hmqrue2J7MtcczJfjFL9uHndgSfvP5dWCLQk08tBLsa2C3Y8+m1o5Q1WHdE3fsARqCE9RoLF8VQxSpJXeHOMYLNeKLLGEEoTQA5ZRkWOYRvhJj9XBdC6xhmismQDAZoOpTtmzjrFe58Ex1BXx9wqpLPUXS2suah9LtLszZ3Lziciv6JXWBFzZaJgwyt2YEXg==
X-OriginatorOrg: opensource.cirrus.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 13:25:53.8676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16a78690-5f5d-46f9-3a1c-08de8428b74c
X-MS-Exchange-CrossTenant-Id: bec09025-e5bc-40d1-a355-8e955c307de8
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bec09025-e5bc-40d1-a355-8e955c307de8;Ip=[84.19.233.75];Helo=[edirelay1.ad.cirrus.com]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-CO1PEPF00012E60.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR19MB4487
X-Authority-Analysis: v=2.4 cv=YqQChoYX c=1 sm=1 tr=0 ts=69b95668 cx=c_pps
 a=ZwnHHYtbhvZyeoWvue1Gvw==:117 a=h1hSm8JtM9GN1ddwPAif2w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=8nJEP1OIZ-IA:10 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10 a=RWc_ulEos4gA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=iX4cTi3TZMoOKdANLEfx:22 a=KfkQE9S9VqCBgivYGm0O:22
 a=e6BqVSoARSoZsxPfWcEA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExOSBTYWx0ZWRfX5hlcL2anXrDa
 1PiYBAY37GPaWy+1PNFEZut3yDs5Z6magnwKlPOHSiickBnyqnvNRJ/fdKsPyJkVcGCxo9NjwXg
 bP/rpmBe9iC4Jmyk2e9UvvyC+8qX98CQXnQPWJTZfqM4kVeeULBXGo3/47kHBcGGzjIuxsKmdiK
 69ttw3RowWX5MkoZhCT/icZk0PLzbvCkUX2diikU9Wws67ADpqpcOuG2a1Xxs9B/AYrp5j9HJjR
 hzeVcaVXGvK0l5BHXXF6iDsnnkN2BhJojoBYzd/uAUp31I4CJCbOO/hkxJ+koPv6zUenXabBd5q
 tFySmQPm2oIqBEnJZeNergbLOY49Dp1L/PM4M0briAUb/fIP5x8xt1C3p3x7L9t0mHS0+sM8BgN
 m4nY2KB/PcEoFbe0WBeKqTbdq7oh8QX/62Dhfa4nxEGLQIkNX0SJZWhlZEw+AjhrEWpUW2LAGpB
 48u8Hpy+K4BpjeCyOZw==
X-Proofpoint-ORIG-GUID: tFRVnO21DRaONXqRhnVPFv96HY1wGY5y
X-Proofpoint-GUID: tFRVnO21DRaONXqRhnVPFv96HY1wGY5y
X-Proofpoint-Spam-Reason: safe
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cirrus.com:s=PODMain02222019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,cirrus.com,opensource.cirrus.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[cirrus.com,reject];
	R_DKIM_REJECT(0.00)[cirrus4.onmicrosoft.com:s=selector2-cirrus4-onmicrosoft-com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cirrus.com:dkim];
	TAGGED_FROM(0.00)[bounces-226015-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_MIXED(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cirrus.com:+,cirrus4.onmicrosoft.com:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ckeepax@opensource.cirrus.com,stable@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: AEF2D2AAE3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 02:07:29PM +0200, Péter Ujfalusi wrote:
> On 17/03/2026 13:44, Charles Keepax wrote:
> > On Tue, Mar 17, 2026 at 08:21:12AM +0200, Péter Ujfalusi wrote:
> >> On 16/03/2026 18:40, Charles Keepax wrote:
> >>> On Mon, Mar 16, 2026 at 04:37:28PM +0200, Péter Ujfalusi wrote:
> >>>> On 16/03/2026 16:27, Charles Keepax wrote:
> > There is probably a discussion to be had here, its far from clear
> > to me this is the wrong place to do this. Generally the codec
> > controls when the codec wants to mark itself as runtime active.
> > For example on our phone devices where far more of the chip
> > powered down in runtime suspend having a jack in would always
> > keep the device powered up so the button detect could run,
> > as the lowest power states disabled that.
> 
> I see, what about this:
> if the inserted accessory is CS42L43_JACK_HEADSET (SND_JACK_HEADSET)
> then do one more pm_runtime_get() to allow the button presses to be handled?
> This would allow the laptop to hit lower power state if a headphone is
> connected, headphones do not have buttons as they don't have mic ring.
> 
> The jack_plugged would be renamed as jack_is_headset or something and
> drop the rpm on jack removal for headset ( and on module remove).

Yeah it might be possible to not hold the reference for
headphones as we don't need the button detect. We will need to
have a little think about the re-running of the jack detection. I
am not super keen on it running a full jack detect each time we
exit a clock stop. But we might be able to cache that and ignore
the new IRQs after the clock stop.

Thanks,
Charles

