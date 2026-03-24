Return-Path: <stable+bounces-230154-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MG5FDYeIwmkAegQAu9opvQ
	(envelope-from <stable+bounces-230154-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:50:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 78995308A30
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 13:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91B14302D8B3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 12:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 190263F7ABC;
	Tue, 24 Mar 2026 12:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OyH/YAaz";
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="OyH/YAaz"
X-Original-To: stable@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11022109.outbound.protection.outlook.com [52.101.66.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409A93D47B3;
	Tue, 24 Mar 2026 12:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.109
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774356095; cv=fail; b=skQXyswE4usEaG/fBnSD/+z4jScBBdFt+OEUD81ASLVgUib+aiRWE94U5htsp8aYYGmwtxio1lOco9fR3GS/oTGdDA78xu86CdJOjpaBdYCANvZIcant2YaoE48yzccIB+sfyP1VOzH51G13sqOYwAA9AJzPuFTwD/1tb7Z/dcg=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774356095; c=relaxed/simple;
	bh=L6i3uLvmSadccOMIJKdH/iFQSPR7TGJITPGoC7rFl0o=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=SpBsH/cf5lZLA+xqdV4qcP9BgiiA7S6bkQEz7vm8EpY/8hdsg5tdainJW5Z8GmmBo1+NPqauWHPGla0wwww4tlN2/ihM7kgWW/s1M6WRm8L9CXQyF2lXJ6GkjNPwhiQVWhwVMHSkNAM3RnAsTkcnVh7URMp4otx0d6ozcGfAe3c=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OyH/YAaz; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=OyH/YAaz; arc=fail smtp.client-ip=52.101.66.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=XII1Glfn0kcTiQnFI3cM1bdlWP8SCtBCf4r9preCXGDpj/TLoVaYfQd2gXeGUWbsa9ifo9vsVGBaYq6e5dhwq2zc+KsaBpHJGpD8cPsB/db1fRy81cX6se7YpB3z9S+PGg08CdBQX5F64HaSVRI9jCAxZjGlNJaEK8bHAgai2LX1g8aTGJGlIznmodsgagAn+eBBfq5sHNKiB7uPWmpui5/qUgpV6pOU/pjNIm2WXhGPF0iRLUMMBVbCFRydpg3QljZR/s//R79E7HfcfG/6cshL+E2C/6IpEd90uSQUwA8r3APZR1bVqWcdkr/CsLvj332HM36AVWK7nVkOfB/rqg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=o9d97V6Cv7eXEmotkIitZilUvyyu9PbE2ZVH0QJ26le2xhKhnoQFlC3DWyWUanOJH8L+JJYmpcwiJqKdJ/7hJS4bIMzC4uw1zn+KIRTua0XxriXd/reIjw4n76kFhJQeiYHAXDpdH7m8TXJwZAsrhLSMk8IxNM8Lk4XfVYEpOC3pd4oEUeHpvE+x3QDtR/bx1/aEd6Pq7XVWcm/bDtv6B+sah+yUVey1helVQIbcWe8X9QdbbQbwHPOPd494a66azrMwnzvC9iKigqasrT8XqFHKrII5SGtAfP4Xy4KQkOsHZxrWgR8F3VCq0AmwbAokoXDA4HCe84OI0r+t/2AJlA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=fail (sender ip is
 52.17.62.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=solid-run.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=solid-run.com;
 dkim=pass (signature was verified) header.d=solidrn.onmicrosoft.com; arc=pass
 (0 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=solid-run.com]
 dkim=[1,1,header.d=solid-run.com] dmarc=[1,1,header.from=solid-run.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=OyH/YAazc7HQBwOEA2+JbhUiWaW/CMFFeMyirMW7RN/1KbcpfnbGc8t7Wz16cgKYpq364eexwuJ6MGzpEpKGjfp96k81qMX0zMMGkVH8J0w8FSkLSdGe/onFkF/GOtHbj4E2W59LGweWjkdRywKVnBr+lhxnUcg9vRk5+LpZZsg=
Received: from CWLP123CA0225.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::22)
 by DU4PR04MB12325.eurprd04.prod.outlook.com (2603:10a6:10:630::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:41:21 +0000
Received: from AMS1EPF00000094.eurprd05.prod.outlook.com
 (2603:10a6:400:19f:cafe::90) by CWLP123CA0225.outlook.office365.com
 (2603:10a6:400:19f::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:41:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 52.17.62.50)
 smtp.mailfrom=solid-run.com; dkim=pass (signature was verified)
 header.d=solidrn.onmicrosoft.com;dmarc=fail action=none
 header.from=solid-run.com;
Received-SPF: Fail (protection.outlook.com: domain of solid-run.com does not
 designate 52.17.62.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=52.17.62.50; helo=eu-dlp.cloud-sec-av.com;
Received: from eu-dlp.cloud-sec-av.com (52.17.62.50) by
 AMS1EPF00000094.mail.protection.outlook.com (10.167.242.91) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19
 via Frontend Transport; Tue, 24 Mar 2026 12:41:30 +0000
Received: from emails-7479722-12-mt-prod-cp-eu-2.checkpointcloudsec.com (ip-10-20-5-76.eu-west-1.compute.internal [10.20.5.76])
	by mta-outgoing-dlp-467-mt-prod-cp-eu-2.checkpointcloudsec.com (Postfix) with ESMTPS id 043658078C;
	Tue, 24 Mar 2026 12:41:30 +0000 (UTC)
X-Mailbox-Line: From b'josua@solid-run.com' Tue Mar 24 12:41:22 2026
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gi+bo5aBYgYCXOszmTry9BLnl9MkRDYO3SJjl8eKajlPfL9e8ljS1ShG5fM8MUJBghaeUyxvw7xh95Bzlg8tzqeUL7qNKD1aHKkQlX7FoQYYCE0K3G22GlsT9tXEZI7spcg5aDT3z1xUUQ9s33GxxPFbZyV51+rxuFlIVJW73dVrFZ9lIFynUAXrL/Hy/SLRmwp5PU8dOhxGb8xN7Mci6Z/piaFlChVDN7ntvpFraU7gegFDa4EUwDbM8Nt28BKjlChlDaMIoGdiIXTuiZGHauxFLw6pynw+l1eLnXmbui9X0qrJHSF7L/BDauxFr2I/i9VA6mMul843biS350uKew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=n6ApbtNxDRdr1rN/JUVawSy/woP4cYKAtpPkSQfd9AZe1CYcU5W0jm0XEi2IoQzBbUy7ssaUVZn8a92z+9PungQ3s5aiJVmW1SOVt9BhOWFwIJuzCri0iLu/ebw4EHeCZlSvs7A+4kpqW7A3Hjq3L4cW18qETL94b1V1Fgjx523jrJQkm+8FHPq87U4pPHc4N1SwuF8sIEnQUf/1ZtHwrQvfkf1C8cfnEMxk6hhLbowhoAJE+IUPU13VYn1LtUFjYZZXwdJfEzSM04rex6Gtdl9xgxyXHq5kj8QcUodSGQZaaV+/pqNZzOh/wC9xOT8om2luXLqoxdGzeo6+gDycYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EE4FuJlbndKGLJzqACuKMNqYcAqnVVJp+qLWA/BM9j0=;
 b=OyH/YAazc7HQBwOEA2+JbhUiWaW/CMFFeMyirMW7RN/1KbcpfnbGc8t7Wz16cgKYpq364eexwuJ6MGzpEpKGjfp96k81qMX0zMMGkVH8J0w8FSkLSdGe/onFkF/GOtHbj4E2W59LGweWjkdRywKVnBr+lhxnUcg9vRk5+LpZZsg=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22)
 by DB9PR04MB9722.eurprd04.prod.outlook.com (2603:10a6:10:4c7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 12:41:13 +0000
Received: from PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1]) by PAXPR04MB8749.eurprd04.prod.outlook.com
 ([fe80::d782:fbb2:be9a:43f1%3]) with mapi id 15.20.9723.030; Tue, 24 Mar 2026
 12:40:57 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 24 Mar 2026 13:40:55 +0100
Subject: [PATCH v6 01/10] arm64: dts: lx2160a-cex7/lx2162a-sr-som: fix
 usd-cd & gpio pinmux
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-lx2160-sd-cd-v6-1-8bf207711848@solid-run.com>
References: <20260324-lx2160-sd-cd-v6-0-8bf207711848@solid-run.com>
In-Reply-To: <20260324-lx2160-sd-cd-v6-0-8bf207711848@solid-run.com>
To: Frank Li <Frank.Li@nxp.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Carlos Song <carlos.song@nxp.com>
Cc: Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, Frank Li <frank.li@nxp.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-ClientProxiedBy: FR4P281CA0400.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::20) To PAXPR04MB8749.eurprd04.prod.outlook.com
 (2603:10a6:102:21f::22)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAXPR04MB8749:EE_|DB9PR04MB9722:EE_|AMS1EPF00000094:EE_|DU4PR04MB12325:EE_
X-MS-Office365-Filtering-Correlation-Id: 26190287-0053-4562-cf94-08de89a2ac6a
X-CLOUD-SEC-AV-Info: solidrun,office365_emails,sent,inline
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|366016|7416014|1800799024|376014|52116014|38350700014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 Mfe6Z/+c75xpK1Z3ML6nkUYQTONTyJouwW1H3XOk4RZNPWDMg/s4jUY6Waeq0fklrIkZczRRw3vkit3GVC7/Z3VbRBF/4I6/3QlU9Cdh1oNByPMTQilJ+FVJb56jd6CIPlxrbGQHOz4FbQQm/LA+Vszgaos8ab9yjZcYXvuHV+t2L+Myq8GJ5OQanWXJSNgSSgRsV9f5uiwzttaSW3Is7A/WWMaRb2Mg0JKAGws9QvmIHwp+2n0rvyXPGcC2Cb4N6TnK9UepDLQ9fpWYwzh67n/OnQehRySjAX0llQdT6T1UsIy+kb7GrX/xiFL2EGWhM/VdEZflDGsqikjRewE9siD/RN07nvRsvloG/WmqBzv0leG0rAogrAIFc0PwwobB2SHU0+oxdMJuA9XVnNgKdYekZrSNDRfOppNy3E5d2kj6R8TsQlp+fnflH/xB2T0FlqHu+v+D7mzdC90HU++cuIPmt3KjQefUgleoJdNsSK0F4E0c6F79o3pw+1UwqSYTURCDMVjdtkS8OvHLxFN2hAkbXnKrIHiKnRxGM8st4Kc2161Fban9qgYrbUzapAYl/1jqU48aGIOypubjG4YZG97CGqziOVEc/3S1PO3tGA0mW811wG42Kpg1rDvJAJepSSKXAUYx4E8tx3fRIbRw3jXvAw2YOZSMTSBEEnIH+8YmfTbCzvszH4Awu8OawO3nY1FuvPJcLFA6TThD65tyUcHg9btG0+7k+vJao7j+0EA8Gcqm5iogxtHUbAXLBXvMXY8lNGCJQ2FC/OYJKDqKJnqfpO0PUqtDX+wALjV8QWs=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8749.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(52116014)(38350700014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1102;
X-Exchange-RoutingPolicyChecked:
 MrDSFGZPvaD+5QwxgMTBAuQrUwQaxuwkwvvQ23J9czexpcQA0qccsl4X4EBxXJNEAAjTCbD1METRsGevDDj/GVVAIoo5If6S9JxdI6F2CXTCofxrvCkAlGL5804ZOJBWeaTq1oXDmCGbWOA3k6Q9l6Shm58zf4amSJK/QtgZc4FNQM7B3JpxF1yFqaq2u4f27OIIm9E56Thwewwg/eguMFnj1fHuY/FLg6xk8/uqIMpLEybmyFrsUYbI9x7UPcKifdkustKN8TkwEmqtJ+HDxw/j+YeJOijvjo3NC34RlIg8GI4Cr80OULPKl/Lip7Kr8C/8cHQqUp0jcjFDelUmUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9722
X-CLOUD-SEC-AV-INT-Relay: sent<mta-outgoing-dlp-mt-prod-cp-eu-2.checkpointcloudsec.com>
X-CLOUD-SEC-AV-UUID: 8673f46671f441bab8de1e1a1ef5a3ec:solidrun,office365_emails,sent,inline:167ef90dd5433cf33d467578846ac289
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	94c76690-00ff-4ab4-fa05-08de89a298ea
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|1800799024|36860700016|82310400026|14060799003|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	xQgJFzlbmi0g3+V9Kc7ib5m+HKxOywHgaN6rO+dfxHGqYkwQC4BOv+16S2NQN1OGRIGJOdpBQlLfiBRevYPPDShnVki7VP2qVeV77zDSqOmIajKinKFs1daA/IoBw2wDDQL3gntqt7MOec8yJvvKGK2nqn6PBb4sgbpHg3lBA0NP0I0htivYSebfS+isk/tT1gBuwnSqd22j1mhWrG3RCvcBkDn4pc1/B+7VShC/bqKmVwi+GERfT4THBuXcLQu8ZLZkk9HinS343VKDYYIwOUApJtZulYw4UwfRIPDdfWjf15gRVCXW+HJBHaW6lIpIImtOaruF2mXjMe1/d27GhRifY0MIhUj0mbR4g9G5SFOuiyVb87NU03DX6ENiC8SzYJrnBmElBeD7CcYlj6nmB3crynhWXu1RIER6izBCACwooTnVn1qMAVohdOHKNQ4MfUvcC2lkHYfWuQFr9XO8xC2eHwTKELKln2ysh3+rForaBouXYvM8fNDDbERbDcGg+X52qAtFQKBLqtWCP8vTxQ0b7DoZsfnu1gEYInfmlO2yuooj6h8xYC/5wp9uVmEqBhXTRHild2qkYKAT6zab2XmU5VxUY6NL3Iye+2Wg5B7bqpZAGkSspDGcbRCtDyYH0CuTZbToYaPsY1HsxYoaUPqSV7zB1HMkXkBKoGU81W0eV8GFnpmjtOXVeDD8kymKrX3R/Gl1UvWWVc+TZzQzR9q4CgETFUELDuez8MN3KxAWbTLeGK+TJdjWMlbg+Skm0D4UAHsfA4N6m+6O3X0vNg==
X-Forefront-Antispam-Report:
	CIP:52.17.62.50;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:eu-dlp.cloud-sec-av.com;PTR:eu-dlp.cloud-sec-av.com;CAT:NONE;SFS:(13230040)(35042699022)(1800799024)(36860700016)(82310400026)(14060799003)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Wp18yJq5EVYVOyT5qFO6RrwH9SK4n8CTAE8xUZeFRuFm9R+a0HEmBRdCZm8XBIC3d1bnayMMH6Sy4Uaxy5ru8wwPGRbU9oXSnv0UkQtxznznfM/tjB9xKe+a6D8iRwt0RbsgMlazK5jWRM+J0l88X18Es0y9n+NFd80jXGDHh7iwAJvBF8eSjPHEH7+FWFkr0imnky937Xo9NL7mfB8WXvPbTx0ay6FsT8HsrhMaYgguKQ7e2prfnbI5IkR+Wp69hsqF4ORNk6TpGoM4LACWFIoZPPQfZ2iMdyH1VCLRmluVLNyXlBcZzNcXsBQtNlZGSBB7feF5g9y+w59Kr5UaaO4eIHEjDooIpaY7zMmrgIJXGAB+u0V8f3itv3Cr2xCpeNU38NZ50sMt3vRnTeFTRVVFBEuof34QmZxBt1AhCZoQgXXMCEP9XJPD9YWsULOx
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:41:30.2790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26190287-0053-4562-cf94-08de89a2ac6a
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a4a8aaf3-fd27-4e27-add2-604707ce5b82;Ip=[52.17.62.50];Helo=[eu-dlp.cloud-sec-av.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000094.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB12325
X-Spamd-Result: default: False [1.94 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=3];
	R_DKIM_ALLOW(-0.20)[solidrn.onmicrosoft.com:s=selector1-solidrn-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[solid-run.com : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230154-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0.0.0.0:email,0.0.0.15:email,6f:email,solidrn.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,0.0.0.51:email,solid-run.com:email,solid-run.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josua@solid-run.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[solidrn.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 78995308A30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to
support bus recovery") introduced pinmux nodes for lx2160 i2c
interfaces, allowing runtime change between i2c and gpio functions
implementing bus recovery.

However, the dynamic configuration area (overwrite MUX) used by the
pinctrl-single driver initially reads as zero and does not reflect the
actual hardware state set by the Reset Configuration Word (RCW) at
power-on.

Because multiple groups of pins are configured from a single 32-bit
register, the first write from the pinctrl driver unintentionally clears
all other bits to zero.

For example, on the LX2162A Clearfog, RCWSR12 is initialized to
0x08000006. When any i2c pinmux is applied, it clears all other fields.
This inadvertently disables SD card-detect (IIC2_PMUX) and some GPIOs
(SDHC1_DIR_PMUX):

LX2162-CF RCWSR12: 0b0000100000000000 0000000000000110
IIC2_PMUX              |||   |||   || |   |||   |||XXX : I2C/GPIO/CD-WP
SDHC1_DIR_PMUX         XXX   |||   || |   |||   |||    : SDHC/GPIO/SPI

Reverting the commit in question was considered but bus recovery is an
important feature.

Instead add pinmux nodes for those pins that were unintentionally
reconfigured on SolidRun LX2160A Clearfog-CX and LX2162A Clearfog
boards.

Fixes: 8a1365c7bbc1 ("arm64: dts: lx2160a: add pinmux and i2c gpio to support bus recovery")
Cc: stable@vger.kernel.org
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 .../arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi |  7 +++++++
 .../dts/freescale/fsl-lx2160a-clearfog-itx.dtsi    |  2 ++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi     | 24 ++++++++++++++++++++++
 .../boot/dts/freescale/fsl-lx2162a-clearfog.dts    |  2 ++
 .../boot/dts/freescale/fsl-lx2162a-sr-som.dtsi     |  7 +++++++
 5 files changed, 42 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
index eec2cd6c6d32a..7f6e39e27ce5c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-cex7.dtsi
@@ -162,6 +162,8 @@ rtc@51 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -177,6 +179,11 @@ flash@0 {
 	};
 };
 
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};
+
 &usb0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
index af6258b2fe826..580ee9b3026e3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-clearfog-itx.dtsi
@@ -89,6 +89,8 @@ &emdio2 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 853b01452813a..af74e77efabc5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1721,6 +1721,10 @@ i2c1_scl_gpio: i2c1-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 0x1 0x7>;
 			};
 
+			esdhc0_cd_wp_pins: iic2-sdhc-pins {
+				pinctrl-single,bits = <0x0 0x6 0x7>;
+			};
+
 			i2c2_scl: i2c2-scl-pins {
 				pinctrl-single,bits = <0x0 0 (0x7 << 3)>;
 			};
@@ -1753,6 +1757,26 @@ i2c5_scl_gpio: i2c5-scl-gpio-pins {
 				pinctrl-single,bits = <0x0 (0x1 << 12) (0x7 << 12)>;
 			};
 
+			fspi_data74_pins: xspi1-data74-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 15)>;
+			};
+
+			fspi_data30_pins: xspi1-data30-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 18)>;
+			};
+
+			fspi_dqs_sck_cs10_pins: xspi1-base-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 21)>;
+			};
+
+			esdhc0_cmd_data30_clk_vsel_pins: sdhc1-base-sdhc-vsel-pins {
+				pinctrl-single,bits = <0x0 0x0 (0x7 << 24)>;
+			};
+
+			gpio0_14_12_pins: sdhc1-dir-gpio-pins {
+				pinctrl-single,bits = <0x0 (0x1 << 27) (0x7 << 27)>;
+			};
+
 			i2c6_scl: i2c6-scl-pins {
 				pinctrl-single,bits = <0x4 0x2 0x7>;
 			};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
index eafef8718a0fe..8920326a06735 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-clearfog.dts
@@ -223,6 +223,8 @@ ethernet_phy8: ethernet-phy@15 {
 };
 
 &esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&esdhc0_cd_wp_pins>, <&esdhc0_cmd_data30_clk_vsel_pins>;
 	sd-uhs-sdr104;
 	sd-uhs-sdr50;
 	sd-uhs-sdr25;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
index e914291e63a1a..e1344942eaaee 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-sr-som.dtsi
@@ -30,6 +30,8 @@ &esdhc1 {
 };
 
 &fspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&fspi_data74_pins>, <&fspi_data30_pins>, <&fspi_dqs_sck_cs10_pins>;
 	status = "okay";
 
 	flash@0 {
@@ -80,3 +82,8 @@ rtc@6f {
 		reg = <0x6f>;
 	};
 };
+
+&pinmux_i2crv {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gpio0_14_12_pins>;
+};

-- 
2.51.0


