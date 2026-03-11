Return-Path: <stable+bounces-224750-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBEhIDnGsWkFFQAAu9opvQ
	(envelope-from <stable+bounces-224750-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:44:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ECDDD26990C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 20:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D86AF3007656
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 19:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DF3347FD3;
	Wed, 11 Mar 2026 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b="yWVk93zo";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=juniper.net header.i=@juniper.net header.b="TJ7qnU0b"
X-Original-To: stable@vger.kernel.org
Received: from mx0b-00273201.pphosted.com (mx0a-00273201.pphosted.com [208.84.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7BC330315;
	Wed, 11 Mar 2026 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=208.84.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773258292; cv=fail; b=IOvN4oLxk1L0fADeipYdcp4PnTuXtDv2IUBmT7ap/KnQ7t7FTgBgfBH8uBnAWBYYHb0g66797RvIAWFrknN6MK9KPjJi91Yox2pCb8isZb6OGRGiEzwUDnBGLtTimkPeHPVpSMYf8oGEHgXG8ivhf7nNLlHp6S+yEnCa4+tID4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773258292; c=relaxed/simple;
	bh=4Ja5W4tvimuEyiKRAPFaLHMmeEkouAISq74kS2LeWP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sebqoKDRbVdbmZBeCp6g419cXo2fP6/Rki2J0QatlqcieCeuTdSTq9ub89BAQOhzJYdrsAqKN0qyMIwnFxKoNV5YF2VeQrL1qgzUey1UKtnyrjHGbVz9601DyxMKQqM8o1tAxu8Nck2bFR0IYuaSS0gSNeemaCOe0gm8UGDba7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net; spf=pass smtp.mailfrom=juniper.net; dkim=pass (2048-bit key) header.d=juniper.net header.i=@juniper.net header.b=yWVk93zo; dkim=fail (0-bit key) header.d=juniper.net header.i=@juniper.net header.b=TJ7qnU0b reason="key not found in DNS"; arc=fail smtp.client-ip=208.84.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=juniper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=juniper.net
Received: from pps.filterd (m0108157.ppops.net [127.0.0.1])
	by mx0a-00273201.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62BI6NLT3707567;
	Wed, 11 Mar 2026 12:03:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=PPS1017; bh=umiVYqFFy5gK+oCOyu/n0I8g
	c8XHIBBhAX9IfSE7khY=; b=yWVk93zohv38W4MOCdgfRyAOAHFcbj/KwIYAu/n9
	UsRmfVjo8kAiQTxNueX6bOWf+iinZPhtdq301b463R9iBm9qQRxJ5H4dGidxloZr
	QLektRUGHyi1ctYfKWkKnV4oJ8X0jnd2AHCoDV8QkkiOCiaSinLwRVnRgXnEdSVu
	HMNT4pdoC30HKU87mjU1oj79q3/9CXzOc2YdagnYFzEAUP/A61qrl+dazJSG5Eob
	YOg/M0zJkocylo0BqB5vkYRIpaaWbM8xwouUoMgPneVy5yhKILt601hLHx0zxC/5
	g7vu+TGWUGcolDIpvBz6eNc1ZK1w7yutHWW891gv66OQBQ==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010034.outbound.protection.outlook.com [52.101.85.34])
	by mx0a-00273201.pphosted.com (PPS) with ESMTPS id 4cu55f2mdj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 11 Mar 2026 12:03:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6y/rwRBN81gK9mWW0p5OZR1+/MBPYJbEgkOhIInMa++18tZH2UkNAAjVbUIBNlO6SW+uUjKcVsfUi3dqiSMWr2wYKjBqUV5v/nmGy9Wb4B5jM0ft1LG+1GI1BN4gadDXVXORShzZK43bqf03YwcGczTlXgyWzY0rmg+5umTvuxD7DdTEnH3tmgZWxaHpyiodE8CXVj3EKjnuFLX1ZFqowJg586h9PElI5qCA7fYfqE04/EBf9xall99pMgTNL00d/KCwrxpnkAXyuJvUM0iiJVlWWU73zMovmTWDS1Qw/DsdwGJGbDanHbZrYix2t9PhXorwbi5/+Z7Sh9f+qCTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=umiVYqFFy5gK+oCOyu/n0I8gc8XHIBBhAX9IfSE7khY=;
 b=ebJx1h/1kCbx68LSkVSJ181XasxHjMpbBEBXOPMl3lKGXjYOyaifABsT+HiH4Hjzv5OuCRLPalW5pChE47oIxK9oDSxnrqJ0mCGFyCsvpPv4e1Mk9eiC+px66S8b979dtO6HchJszZU3gx2tfrN7sYWQj5h6rm/7iYWwXuu0QAar/loJ6sG6jGNE/EQP43JJUQjRGSrJJZH6/KVds2osK3FD/WO8FcEkNsEXYHxYlnJuErtPBU3P9OZPBCaZJeg/aidhAbXXIgbDwjhWy/hR3dRXas0VGl/ZgHPM2AphpvPIlZIXU4HZrm06mGkbyqleu02VYG1MLQ9Dxf8ornNsyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 66.129.239.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=juniper.net;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=juniper.net; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=juniper.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=umiVYqFFy5gK+oCOyu/n0I8gc8XHIBBhAX9IfSE7khY=;
 b=TJ7qnU0bUEBMNj/GJwipGGcQTckhxkLMQNIgIh750HnZtvnsLqvfwm8Myb+V0MhQ3bg6rIhLz5d3dT0FGZ1xm7QVP0FKACJV7ZkWfn6I6sKGXyaD1Toj5VbZodvFNRmHGRkEnhJ4qfmD7stw1tPLYcweisrJ217oVuAXfBXDYr8=
Received: from BYAPR08CA0051.namprd08.prod.outlook.com (2603:10b6:a03:117::28)
 by CO6PR05MB7635.namprd05.prod.outlook.com (2603:10b6:5:352::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 19:02:59 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:117:cafe::a) by BYAPR08CA0051.outlook.office365.com
 (2603:10b6:a03:117::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Wed,
 11 Mar 2026 19:02:59 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 66.129.239.12)
 smtp.mailfrom=juniper.net; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=juniper.net;
Received-SPF: Fail (protection.outlook.com: domain of juniper.net does not
 designate 66.129.239.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=66.129.239.12; helo=p-exchfe-eqx-03.jnpr.net;
Received: from p-exchfe-eqx-03.jnpr.net (66.129.239.12) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 19:02:59 +0000
Received: from p-exchbe-eqx-04.jnpr.net (10.104.9.87) by
 p-exchfe-eqx-03.jnpr.net (10.104.9.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 11 Mar 2026 12:02:56 -0700
Received: from p-mailhub01.juniper.net (10.104.20.6) by
 p-exchbe-eqx-04.jnpr.net (10.104.9.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 11 Mar 2026 12:02:56 -0700
Received: from buildcontainer.juniper.net (qnc-bas-srv058b.juniper.net [10.46.0.148])
	by p-mailhub01.juniper.net (8.14.4/8.11.3) with ESMTP id 62BJ2rLM013369;
	Wed, 11 Mar 2026 12:02:54 -0700
	(envelope-from makb@juniper.net)
From: Brian Mak <makb@juniper.net>
To: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>,
        Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-kernel@vger.kernel.org>
CC: Brian Mak <makb@juniper.net>, <stable@vger.kernel.org>
Subject: [PATCH v3] mfd: core: Preserve OF node when ACPI handle is present
Date: Wed, 11 Mar 2026 12:02:25 -0700
Message-ID: <20260311190225.22426-1-makb@juniper.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|CO6PR05MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 88b7a64a-ffd2-4d2d-67cf-08de7fa0d01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|7053199007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	cEBIinIDDKvDPXIYAlt41uuikcHTpGIrzTH3E/hKm1p/WjAdzE3z2fQDBFhfvTJ0N/aJOltMXADsjWzrW/YGir94xmSfRtzkhlMZFSV3IyZj9hKhDK8uzfiVFDYl+Zw6A+86sRlM3q5UTz9TDG1+IdZfbInVq9yz/WRFjYaDDSIbY5MaeGW1FgefwvMzx0uiA10+EEGINne6cT1wRJjzzywkFQJiRh3gATM9v4ZxYs1PT2OCrkgqJDz9DQS9o82YKRy1d7Z/ArjvNzjHfqXe50H7O6nTa6yJtZrilhdtgA+qKCIjDkDisP8OxRT+uF1X1lIboOtUmoK3aisCUDqIWJ8XLWkzLPXfv/gHJJt1hkKD1TJmuPlv5r/OdLF4ffKZ3Sl0tG0Dx9m79SZCQOJA7Z/q+JeK4Nm51RijYkgtA1fexJ8b7qwFAceR0dEG6IS0qZNU9yDGEoiI7Ca3z5iVV8Hag1FM4t1IqkKQoxazVlBGIOpewxNmtr3SfKMFiIUqzA6QFrxNLBEmkvyRwj08hpyMHXmU6j/WrYc2dvv2DHvEPHZUr9s0EEsW5JfD5T1ubpYvtzZs48pgZAkynSAWxzSNCiShQ+sFEO83qYweNXdFbfjoFON8qPLYYMBTGOsBRDxSJC312/Qhik6JOQYqh5+eo39vuMqM8Lf3dy3xOu1W4GmeM6JSnolevJPAa8wh04pT/JW6zLK8i+SEbdvA05n36cCanZd88l8SeBYLPGFWnct8igfLeqPvyVppkAOYGQNGlISzDpTtuSMr1pc4aA==
X-Forefront-Antispam-Report:
	CIP:66.129.239.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:p-exchfe-eqx-03.jnpr.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(7053199007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UMsT4ntci0vv7/wv25ang1oDgFlevo+PT0Ta10HB6dnblxVijiib+EqIILvpQnmdKeFVelap8CK6d/DkkoKLw7dq068AckQU0m8KKveqLk2JzQpgzF/DVnfXUZpr1KhV3DN+CSXAptFPRKiCU9Vdk+1nqtLdAX5L1bXME7HDADFcnQGgNjcmDhIPZpJwkn4j6qKN93TiZhubF2UkWE2Aw4bYqlexUYoJBG00Z0lfOnb+sXgzOxi1edTjYSz9f4iRFylgDWmCSwEouAyzRstXWloJ1vRgNtmv8aWtFOGKBoMzJzkEAkNri4A4CfX1z+4hXE6lac73du1ax/kA6kEAJMeogm7YcOY9fqpibf31WxsMOJNXn2QP7VkzP4XlafradNiMLUXEaQdwywJKf63DtYyB8nuz7jLnw2LncCz6LY3c7olqpfdx0o52DouQ3xRX
X-Exchange-RoutingPolicyChecked:
	kf5ClhNDdUZOiHamcxIiVtL6BXvkaqSNXEVkNE1DJwXjKWZSZD1l72Wf5rmGJ+3QSuZEjhvtz4bDSw/mbIRICWJeSYm6RFrLYk8GUYJ+EGbbYd+NMPrLrXwbanvXhqjpivyu3crVhSIIUS1+zpdTTefaeq8OXhaXNJvoUx65iPri6jKP5vRUlJB5LSg9UT6nMXVf2M25hnJ/1fOMnBX8Xd/nZ2ZucfmLlvt5+ypWoJGDQ6sE+GHYi66lfB0AW5SDnKhML+ujK0nmQGM8nyUbjHhxqbaDXDZi0zy25tYrtwnAH3tJTOKdpK+YZPtjSw1uyABmh4xvjByv8whAhrbe6Q==
X-OriginatorOrg: juniper.net
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 19:02:59.6104
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b7a64a-ffd2-4d2d-67cf-08de7fa0d01d
X-MS-Exchange-CrossTenant-Id: bea78b3c-4cdb-4130-854a-1d193232e5f4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bea78b3c-4cdb-4130-854a-1d193232e5f4;Ip=[66.129.239.12];Helo=[p-exchfe-eqx-03.jnpr.net]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR05MB7635
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDE2MSBTYWx0ZWRfX4pFZxeWRT/I1
 7HBXizuLgBwh86hKoYeD/czhm/s/T93w4tzTCtngcc5E8j8d9qNbm9z2NcPpTIG+Pg/+XGkMKHl
 V4T7gfFsxR8rdCiD/cv2ReNY/5Ilcc6O15V1BZtc6gtFnCp76JDpeS7J7cZeOhtxtjc9mnvXjXb
 6smas4VrrSIIiumBH4X/V68HqMpbclJ7B2uZ/i8KVZd3BdvK2+VaIhQjNqK1ZLCNIifL/Q2RANt
 lsOGnWa9TQbOo2njPlqOGkdCExJtOzw2SCo4q0WeEE8ttDM8VpRTwX3tKT4JsfzcZ+AbkFg0NIi
 yC1jr0ODcnXA6wV/9412rL5fTp5yp8RUX/Zvn76qjBg6mdWt3/Mf1DM7VTC+ZQBnvp18+bR5NkZ
 5m4kp+lnTBojA0vaYU7rn+aZoMo4qderV7JE9duWIpxDiMuARyqBmd3P626lXuGz6MaW0b6pOIo
 hh6fzlbp0RxeHZ9z4fA==
X-Proofpoint-ORIG-GUID: g9HN4R8rRaRpqaH7UTIuzvDYtRYlZdFf
X-Authority-Analysis: v=2.4 cv=Fu4IPmrq c=1 sm=1 tr=0 ts=69b1bc67 cx=c_pps
 a=h6NrD5D8j3GnK3ckJnoRDA==:117 a=1Ye5qg0S7hDxASgOkGT/HA==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=Yq5XynenixoA:10 a=s63m1ICgrNkA:10
 a=rhJc5-LppCAA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7vL3O5uBSuztJ3xaqtyr:22
 a=O1S9G-DnkxobS-ZkPuRe:22 a=VwQbUJbxAAAA:8 a=OUXY8nFuAAAA:8
 a=1m0Mplif2iitoPYi-QgA:9 a=cAcMbU7R10T-QSRYIcO_:22
X-Proofpoint-GUID: g9HN4R8rRaRpqaH7UTIuzvDYtRYlZdFf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_spam_notspam policy=outbound_spam
 score=0 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603110161
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[juniper.net,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[juniper.net:s=PPS1017];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_MIXED(0.00)[];
	TAGGED_FROM(0.00)[bounces-224750-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_PERMFAIL(0.00)[juniper.net:s=selector1];
	DKIM_TRACE(0.00)[juniper.net:+,juniper.net:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makb@juniper.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: ECDDD26990C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
does not overwrite the of_node with NULL.

This allows MFD children with both OF nodes and ACPI handles to have OF
nodes again.

Fixes: 51e3b257099d ("mfd: core: Make use of device_set_node()")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Mak <makb@juniper.net>
---

v3: Changed FIXME to NOTE, as this will not be addressed in the near
future.

v2: Use open-coded logic for clarity and add FIXME.

 drivers/mfd/mfd-core.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
index 6be58eb5a746..e862448b93b3 100644
--- a/drivers/mfd/mfd-core.c
+++ b/drivers/mfd/mfd-core.c
@@ -88,7 +88,20 @@ static void mfd_acpi_add_device(const struct mfd_cell *cell,
 		}
 	}
 
-	device_set_node(&pdev->dev, acpi_fwnode_handle(adev ?: parent));
+	/*
+	 * NOTE: The fwnode design doesn't allow proper stacking/sharing. This
+	 * should eventually turn into a device fwnode API call that will allow
+	 * prepending to a list of fwnodes (with ACPI taking precedence).
+	 *
+	 * set_primary_fwnode() is used here, instead of device_set_node(), as
+	 * device_set_node() will overwrite the existing fwnode, which may be an
+	 * OF node that was populated earlier. To support a use case where ACPI
+	 * and OF is used in conjunction, we call set_primary_fwnode() instead.
+	 */
+	if (adev)
+		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(adev));
+	else
+		set_primary_fwnode(&pdev->dev, acpi_fwnode_handle(parent));
 }
 #else
 static inline void mfd_acpi_add_device(const struct mfd_cell *cell,

base-commit: d9d32e5bd5a4e57675f2b70ddf73c3dc5cf44fc2
-- 
2.25.1


