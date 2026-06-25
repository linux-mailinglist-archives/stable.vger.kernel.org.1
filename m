Return-Path: <stable+bounces-268542-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4rOwLjkuPWpOyggAu9opvQ
	(envelope-from <stable+bounces-268542-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:33:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD7C6C629D
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:33:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=Nvidia.com header.s=selector2 header.b=mfAvgJgs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268542-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-268542-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=nvidia.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DBF8E301BA76
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:32:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B2432E12E;
	Thu, 25 Jun 2026 13:32:29 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013060.outbound.protection.outlook.com [40.93.196.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311873264E0;
	Thu, 25 Jun 2026 13:32:28 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782394349; cv=fail; b=PbKB2AuqQ8/ZMhOEKdnO1zACp5JXdtkqevcZSjLmdz5yL2iFY5MkxKytu1C+NfCAJWUHJmgbOE0yGpgWaRXVRfUfkvTUA4fuPaRDA7r1LLpUJRQnhcv0LOAhzZFbYjCoWabUBr8scrkjRYyytHT+ZvX9jj/SwyX5SnlX5U6eqT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782394349; c=relaxed/simple;
	bh=Km11Hldy6PaQddIex2ZswaypRdqJ8KYAxgql0mZXZWc=;
	h=References:From:To:CC:Subject:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PZAfK4JuO1y94FJV93ieAiD+zJiJ7PWRIWo2SiepslZBQATD39ayTlYRV1kOGD5BxEF+TQmLSryGK7Yrn8WudGgZFTYem9jzekRBCGj4BAybK/tAaBBZxal0Nk5CxldTZLwpZTlRIpaDvYq1HF91huuDIQinv8wuaFg+KbaYwao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mfAvgJgs; arc=fail smtp.client-ip=40.93.196.60
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTzqG01mQaiJPV9b4RpuSBDW/ivRZmouH0BizpOGCri0FTf8ca0SSc1VUsAYFxQICCYrsgXAmDqtSoltSGwcrQlHl53iPwa1aWSjH9IOHSEC1oywbvy8gZsRejixMSyD7nb3wXx+GwT+MeriyKGonUzztixl7gPjzPBu4wnWfKsSOmAhO/KJ4+6f5H9HaapqmbsVx8O66r1dM11Ko+4BrvjqS+gkV8UvwYIb/TA8VDXqPfdurlklfuLpLxJcTGrQvqmBlZpstTtlS5Q71qrelCv+3XrY6tK86xZY0ar0UvP5vu2OaDyPbxIq26pHDnj7PIEA+Wi17b2Q/x9QB/ky5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Km11Hldy6PaQddIex2ZswaypRdqJ8KYAxgql0mZXZWc=;
 b=P0IXJ557C1MyL6j9iejETRd+aiR2Mj2oUr+8e/pcjkSk06s8WQh+8TGU+cyvSXn3uAld+eklEiHTzvX5Xrp7L77aXqpJ3rnRZa7mf7d+33VJbO78TXGaosAZX7XmnZOXEJjl9o85K0EAAOt2QxDRo2EYgJR0gO3SLHBMjwZch4tFkISoiRb78Bo/yIQ0vPnS+QnJnLBz1DpoMwJ+irMbuTWiQoLpkOCQOPcUdNS26s/lk671LHMgMNm0s0TEMSJWvvEBoU/MaHXwlgWUItxa7CjXfcXufFT7dqpfvS8uy5sWhzVNsVt21vd9uNmd64aKDpfmF5PO5MUlDZI3nLxnBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxtesting.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Km11Hldy6PaQddIex2ZswaypRdqJ8KYAxgql0mZXZWc=;
 b=mfAvgJgsA1hwsJ+tE3BTPImvnA22lhKFoRCqNfDppoiYViRciQ4sOz2+qqtxSG6lWERBzQSQoZ7IT/yrYQUHisnMfuTxNAK4BPXc+S3xNaEK9+Y7fokmJkv7ws8i2HBHXE8WyhlSov6zox7LJb3x8Sygtf/ls0lfygDtjpXuyjUGsMN+B4u/Y3B5FhFuic2Ue2yhZlAsEwaDP3tHG4FuN5OGLG13zNm7cQYbAXENIbqXCuykL4etW1nrI+S8ewWcg29kQXY83fzSFxbnuWAJ2jsF7J0U5h8C39Jr9thodRbv6TzrPLULYb895GaqAj4AESJ3HOAP2qf5jk5kGZz3gg==
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Thu, 25 Jun
 2026 13:32:19 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:109:cafe::61) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Thu,
 25 Jun 2026 13:32:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 13:32:18 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:31:56 -0700
Received: from fedora (10.126.231.37) by rnnvmail201.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 25 Jun
 2026 06:31:51 -0700
References: <20260625114831.17386-1-evg28bur@yandex.ru>
User-agent: mu4e 1.8.14; emacs 30.2
From: Petr Machata <petrm@nvidia.com>
To: Evgenii Burenchev <evg28bur@yandex.ru>
CC: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<idosch@nvidia.com>, <petrm@nvidia.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] mlxsw: spectrum_acl_erp: Fix const qualifier of
 delta_clear()
Date: Thu, 25 Jun 2026 15:27:15 +0200
In-Reply-To: <20260625114831.17386-1-evg28bur@yandex.ru>
Message-ID: <87h5mq3fwg.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1f2101-60de-4618-d4ec-08ded2be2e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|7416014|376014|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	czMgYaJ3HxB+IcTi15YwxcFvEY+ZfLIiwWd+v120YJsX1WXxZZeM1gA2PjgcIXMqiKVZUuRSXiHh/raEnG1AD8TneuaVy0nK9QJMeWhcuoPduU+N9EH5waGAed2Rk/el92W52tZVuGSFai8bgxfCuoXOmpQsv35LNmm6Q6tKYnfhx5hcFKZZjYAJLbTL/S3/Tq1KyagejPPMxj7SoM15G+pWwWYL01UZP6+fwZiDNppbGc8QIRGSIHKrVisRUpPJghWLneuGAZoy8uGuDdeab5vEEKvK5ULlB5FPp4J43QBdWalJP5VuvDf1I5gULM2MwlqvSQ7PfnNQSp/bz+pFRsd/yvBX5uSxsF/UXjxuofsO35FhE6/Hl5yKiOtUBrtMdBCm5C/duZr86eU+kriFsMboSl6ZXcKNSMnf0xOmt9V0bQULSZqNLR6eqvT048jiWx3weh0bWx6Q/Gf5BRRatFPLlcYcqrJttaHvxDkCYJoO2iXI1gWQd49nrc7lO39LNOxcF51GO7QZe7aM6PCiJP+jw9Ub+obX0R2LDaz3hf4u0Atw6Atdd6zY+Y7MfhKVzHmORyC9sDYxz62JMNeh8MPVA4XJUYgPqh1iEHf6BfZiQJXI5SafF+fIxgCv6VqWw/D8yPrlYKeSwsJMQaPzN7z+dJJ2d/CN1ExfiOKUjo8DLIuBlCjpf07v0csjUIWyrjTOewI9sdtfgi/ikOQKwQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(7416014)(376014)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xpwBnuuVUu+k02WOY477yIWRChbD31S2CvQs/DdTYhUaZLr+geX6wNm50XvayZFuRYsunF/Q6AMlcYLPNzUvo0cIWlSiKvrdWtnbsic+S/XbZKO9xjyH6YhF8gDVPTtudL3Wkqx+kMHe0aDKBGcKfc+BLaIwhALRzOurggVQqFeFQstcp/UjAx6KyM476p/5mzya8/85JWxEc7Xp1O3KjgrJGATHSXFr8Vdf0KjesyEIc3XoB18bEJPQrANy1Y4iuiJxKb2B12IW0u3HZt9SCCC2IO+K7vK8ZcRDWyuk/GIAPaCCM8fl1Ki/vPCtJEQ56feenXxJ/zALfDwLKFvOjuCbAKVLoZsYC6URI4WyYakgGE+fZBGqX+APPzKBZV6z9/CHIG+FiJhTVgsPwDmZLHwvqjSUv2hVUYaCdpLSqm4IJxn5VqjcxaP9YOHTRpUz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 13:32:18.9436
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1f2101-60de-4618-d4ec-08ded2be2e0d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485
X-Rspamd-Action: no action
X-Spamd-Result: default: False [3.34 / 15.00];
	URIBL_BLACK(7.50)[linuxtesting.org:url];
	WHITELIST_DMARC(-7.00)[nvidia.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268542-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[yandex.ru];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:evg28bur@yandex.ru,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:idosch@nvidia.com,m:petrm@nvidia.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:jiri@resnulli.us,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[petrm@nvidia.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	R_DKIM_ALLOW(0.00)[Nvidia.com:s=selector2];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nvidia.com:email,nvidia.com:mid,nvidia.com:from_mime,Nvidia.com:dkim,linuxtesting.org:url,vger.kernel.org:from_smtp];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[petrm@nvidia.com,stable@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[nvidia.com,reject];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2DD7C6C629D


Evgenii Burenchev <evg28bur@yandex.ru> writes:

> mlxsw_sp_acl_erp_delta_clear() takes 'const char *enc_key' but modifies
> the memory it points to. This is a logical error in the function
> declaration.
>
> The only caller passes a non-const buffer (aentry->ht_key.enc_key), so
> the const qualifier is misleading and unnecessary.
>
> Remove const from the enc_key parameter to match the actual usage.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c22291f7cf45 ("mlxsw: spectrum: acl: Implement delta for ERP")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Dunno how much of a net material this is, there's no bug to be fixed,
it's a source code cleanliness improvement. But the patch is correct.

Reviewed-by: Petr Machata <petrm@nvidia.com>

