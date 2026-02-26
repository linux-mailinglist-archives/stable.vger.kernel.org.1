Return-Path: <stable+bounces-219791-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Hi4ApQqoGlrfwQAu9opvQ
	(envelope-from <stable+bounces-219791-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:12:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1806B1A4E25
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 12:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6A391300AD8A
	for <lists+stable@lfdr.de>; Thu, 26 Feb 2026 11:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121CD3396E5;
	Thu, 26 Feb 2026 11:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b="TP0QA4jg"
X-Original-To: stable@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013050.outbound.protection.outlook.com [40.93.201.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CEB3370FE;
	Thu, 26 Feb 2026 11:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772104312; cv=fail; b=d3qHlwgiGjOCLrV3M0epv8Bwz93Ki/dgeij5ifyCfe+x6XNBaQaXkerWBLO0z4E1Fm/xlufwrnf6aXYDaEWUDj1WbqBUCQQYtZm0hJVnhnB3uH/+OyvQ282pEitsNWS/5Lpti9X5c279mL/WO3tKpGrXTa9LyZyl97kx4vbQc8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772104312; c=relaxed/simple;
	bh=8fYIy443oN4XJ6SNmXS1Rq72lNZtH8WfL+jsoXLtU/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jqllb3fSr1ZeFjV4nEqV977pNIH4s5o6SRz10mQSAJMdWVmMSrUcONCi35LexqlmUSbEX66HfAYDNQMJOoaqp/2OTtxwqrq0J37ZW0U7DOrCqbZLy/oDXCRfl8pAKC9+UQjOPzRSlBPARkc2IVKrum8seKH1zrjDtUvJI/XbFUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com; spf=pass smtp.mailfrom=gehealthcare.com; dkim=pass (2048-bit key) header.d=gehealthcare.com header.i=@gehealthcare.com header.b=TP0QA4jg; arc=fail smtp.client-ip=40.93.201.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gehealthcare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gehealthcare.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC9IuP0KRQR9be4yRlESvBExOumsJ43eYdAMMx2++h7iFcxtNxbgXRM3AiB2aIbJhe6rnMV5dZe5fWO9ys2FvW5HGeJsQBR6VkoyRBQSCEECyvTggpo1X3/MJhO54ViQsiphgePaB5aSJ0XTnC+xDFjkQsHmBXQHqtQ0oZFcQB3uc83h67dz+eUZqX0VdfmwNPi4gEGlc32RFPXS2gwC3IXXJgv4cn0ChbquEaMNsC0kqu3UzquNyy/xvuqEj+PdbMmtjd6JmGkwqHHLCHWXQXbzaY7VTqnmBx4CRNZKrG1XhNA8dZx8CmsnigZzsT2mLc89K4CbG/VInrtmVIY7Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ka7OgTHLSg5cQrQlTEmEn50QJYXRVG/PEkuBEQOKjE0=;
 b=BwpFegex2P7TGe2FYsnEzbQudX2RNoPU0VaFNjq7yXTXTsfyZCXtO/hc5rOc+XXA8xb6Jdbxk/rxJoGrpOEUfC4aXCRLIKnDSL9T15pupOWzO7e4inMB+kFOczcyY1ZUtoQhht2Jq5woa7PUjv0w8IH1fVohG6X2fijR/YWmLWNNa1lI7+yj4dbPpKPi1jaj/3fdP47z7pfSeK6aAXaYLBufkZfewWDMn7D69jRPWfWXfgviEgGxNraUwklOtuIatndR6uyT4MrX5iGLUZkRmWuzLByQsJtuW/oCW4GHPnjIpEcnPobGcicC9+wKx8pdNyq90C/zmQj2GwH5crzHYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 165.85.157.49) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=gehealthcare.com; dmarc=fail (p=quarantine sp=quarantine
 pct=100) action=quarantine header.from=gehealthcare.com; dkim=none (message
 not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gehealthcare.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ka7OgTHLSg5cQrQlTEmEn50QJYXRVG/PEkuBEQOKjE0=;
 b=TP0QA4jgDmZ/6Dm9ZGUSIoevoqdmBvCzRD1ZKyQnsi72ZNt+8diMWg6CvVveJlh+GsCV+nNp6EUs6Nwd+bqEuWJNtrhldnBjQ6NxrM5W60BWraD0i0TOfcbrj7ZQpm8fbFxlg/4uct7uU9cL76aq537/bo9UB91I5L4TMnih+xSoBQwVhrfzuHZ6PVBxU4SXt5eWxBiAtfuobyNSPweBIBt/tl98gCabaR70ThBBJ/Rdw+Rzj1PVXtz/Cp/XAyJU1OA32Z+TzSU799KQpLjXfvho/FvAyaZiXm3jbkJRGfMCy4UufZxwZYO7ActGVVT8HNp5rRN5CaVYc9ycg38E2Q==
Received: from BN0PR04CA0164.namprd04.prod.outlook.com (2603:10b6:408:eb::19)
 by DS7PR22MB3670.namprd22.prod.outlook.com (2603:10b6:8:79::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 11:11:48 +0000
Received: from BN2PEPF000044A8.namprd04.prod.outlook.com
 (2603:10b6:408:eb:cafe::2a) by BN0PR04CA0164.outlook.office365.com
 (2603:10b6:408:eb::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 11:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 165.85.157.49)
 smtp.mailfrom=gehealthcare.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=gehealthcare.com;
Received-SPF: Fail (protection.outlook.com: domain of gehealthcare.com does
 not designate 165.85.157.49 as permitted sender)
 receiver=protection.outlook.com; client-ip=165.85.157.49;
 helo=mkerelay1.compute.ge-healthcare.net;
Received: from mkerelay1.compute.ge-healthcare.net (165.85.157.49) by
 BN2PEPF000044A8.mail.protection.outlook.com (10.167.243.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 11:11:47 +0000
Received: from zeus (zoo13.fihel.lab.ge-healthcare.net [10.168.174.111])
	by builder1.fihel.lab.ge-healthcare.net (Postfix) with SMTP id 4ECFAE8F2D;
	Thu, 26 Feb 2026 13:11:45 +0200 (EET)
Date: Thu, 26 Feb 2026 13:11:44 +0200
From: Ian Ray <ian.ray@gehealthcare.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>,
	=?utf-8?Q?Cl=C3=A9ment?= Perrochaud <clement.perrochaud@nxp.com>,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] nfc: nxp-nci: allow GPIOs to sleep
Message-ID: <aaAqcFSxarIKYlEp@zeus>
References: <20260223070533.106625-1-ian.ray@gehealthcare.com>
 <d60bc526-fb21-46c6-916e-b063c959259e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d60bc526-fb21-46c6-916e-b063c959259e@redhat.com>
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A8:EE_|DS7PR22MB3670:EE_
X-MS-Office365-Filtering-Correlation-Id: 87661400-d346-4f27-85ff-08de7527d565
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	IqglH7Dz6C/8Aeax5mFzyHx4mYI/TSDC+M4k59/4oKD6Yy3qpJ8nE4GaKgYE1cYgiJNKd5RMAWdxsJLzCTGhdO/YVjlNpgO7NsN4kBTq1SRKkSLVclbL1W73MNNeUZ7c+gvSy6FuDiccEA6UiTOqYij4RC9Rr0NGGJ9lJKGRVP31RQPvKD658S+zpW3f3fJmSuxNqx53ghIIO1sof6SfdHUCa8ouRUKUhU8td1ZNdgcpU8Qt4ZryGlmTF9tt1tAh7SJsoSza5TvdxY/ZA7ufmOTViO7aCBffXyrZaty7mSLJTxtVSXaBMEoLf+Z4VtqX7aBUB3+WIJrAOM/EjDT12+9YIU0dnyFtJ/x9Lhj9INLTsi6nzHka5ZIH2DARxJcGCnSTr2OwlqnN22CTxMAVNyWzjELFXeMsL/LqFo0nGwZDEeZR+7qtauyP4q1FoNGrWh/mm5rTif5XKZP90zmCxwKI/LfjJLfghLqYPaRhWf1GXQwL60YUWHAUsF3uf8fIjrAKhgmtN7MxLwTm7BW1U0HHVADEEiPxh/G4y1c+yvkqSKgB2y9XYFjgxvJKGpj0uljvJrchQoyxXHxYWGqes1hLjciDO0974Wq0B524BLQMBZmw/+xMFIBhr4rXLrWb4wcDMT35U+ZnER/iuOAJKeXW37R5U3zD6NWWRKimowdR2mFLLce5vGi6Ujgb0ETir8yWr5I6wK1WGKyYKPkvuuuzu6dyE8genXmceGJNkJpSfh3B+RiIiRDdDrDPD08RSWjC2VQqOcdko7eBWfpN4gvpURWzLPmEaWLPF+Pbk9bK5zcac3de1kM9vZFHZPpq8sxQwZMkykE1vrXdzu4gCQ==
X-Forefront-Antispam-Report:
	CIP:165.85.157.49;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mkerelay1.compute.ge-healthcare.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MKCBrSpfzFbk6xnlnolcH42bEopf1VJjU+bjKFr4L2o+5bbbsAEuD8QR68/HoTT+DPKK3xozz8O49CYc6ejXo5WpispEEpSOjffiNJrJAae8ZXYno3K2C62dF4bWmgCc4jgxdt5D/73X0tGgXOgakPGmQP8Yj8h5rGiJUfswD7F8w4hERl1STXiuU4cCcuvzUlxssfSr/DNjdYNuqgxiBcgHULhdFkzz9ujHgG18F2EmUJp8Ipar0WYrC9fqkw4xuECybVa61XaHOfgN4d9bEdhKYklOV/vD9eSTDl2edV/D96XT9WOJeUb2WxySsk/azCK/AIwXWpelAE76jPgjdp235uQHx405PkJdYsJJqboubMGtpL4HXRCviA2N/YEGmg/69dxwcNJ3cKUyA+OZRL9gNBkj+kzptkInuJk4D51ap+dDzVUA5ITCrhRM+p3Q
X-OriginatorOrg: gehealthcare.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 11:11:47.4448
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87661400-d346-4f27-85ff-08de7527d565
X-MS-Exchange-CrossTenant-Id: 9a309606-d6ec-4188-a28a-298812b4bbbf
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=9a309606-d6ec-4188-a28a-298812b4bbbf;Ip=[165.85.157.49];Helo=[mkerelay1.compute.ge-healthcare.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-BN2PEPF000044A8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR22MB3670
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gehealthcare.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gehealthcare.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219791-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gehealthcare.com:email,gehealthcare.com:dkim];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ian.ray@gehealthcare.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gehealthcare.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1806B1A4E25
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 01:31:16PM +0100, Paolo Abeni wrote:
> On 2/23/26 8:05 AM, Ian Ray wrote:
> > Allow the firmware and enable GPIOs to sleep.
> >
> > This fixes a `WARN_ON' and allows the driver to operate GPIOs which are
> > connected to I2C GPIO expanders.
> >
> > -- >8 --
> > kernel: WARNING: CPU: 3 PID: 2636 at drivers/gpio/gpiolib.c:3880 gpiod_set_value+0x88/0x98
> > -- >8 --
> >
> > Fixes: 6be88670fc59 ("NFC: nxp-nci_i2c: Add I2C support to NXP NCI driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Ian Ray <ian.ray@gehealthcare.com>
> 
> When resubmitting with the correct fixes tag, please additionally
> include the target tree in the subj prefix (in this case 'net').

Is that prefix correct?  At least recent changes use the "nfc" prefix
that I used in the subject.

$ git log --oneline drivers/nfc/ | head
57be33f85e36 nfc: nxp-nci: remove interrupt trigger type
f40ddcc0c0ca Revert "nfc/nci: Add the inconsistency check between the input data length and count"
885bebac9909 nfc: pn533: Fix error code in pn533_acr122_poweron_rdr()
7cf3ac8a9c0a NFC: mei_phy: fix kernel-doc warnings
661bfb4699f8 nfc: s3fwrn5: Use SHA-1 library instead of crypto_shash
c6f68f69416d nfc: pn533: Delete an unnecessary check
5d69351820ea NFC: trf7970a: Create device-tree parameter for RX gain reduction
41cb08555c41 treewide, timers: Rename from_timer() to timer_container_of()

> 
> Thanks,
> 
> Paolo
> 

Thanks,
Ian

