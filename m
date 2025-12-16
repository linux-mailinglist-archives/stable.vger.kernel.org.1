Return-Path: <stable+bounces-201800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82966CC26EC
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 12:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 524AE302282F
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E042F35502E;
	Tue, 16 Dec 2025 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hailo.ai header.i=@hailo.ai header.b="QcA+VMXT"
X-Original-To: stable@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11021072.outbound.protection.outlook.com [52.101.65.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F9F35502C
	for <stable@vger.kernel.org>; Tue, 16 Dec 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765885827; cv=fail; b=fNZNnkID/2/K/8hbOk6ppQkKtmMNdu+s2STSEmUX2D6+Hh/PC7MXn72NEi15qX0/05IhNO0+5B/TDV9vZO5xmxzCEPWyGgPps8OQ2QdhgzfNxPBxlDZH3abIKo3JxhETrz3uVqwfebEh8t1Ug8db6MFN1EygY0dfVl6dZG0PBM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765885827; c=relaxed/simple;
	bh=GCpBmAgGUgCtCOEO5d/9rWLDH3Ag5knnsTQaYDxPNFg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=t4ujTO099mXXY8JmIIbS2YgYsxEvtIX/aG+vuFqGkZQWfKcw9+5g3ELdCsbZ+ns7+DubDrAbbtnvj90J0PTmTNwrac8vAPo97VQMq26FFQNYLgJyIf8M8TidzzxRwSV3iufaFe+xpbNMhPTGRsL8gODVt8oB2Qfy/VasyS+nel4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hailo.ai; spf=pass smtp.mailfrom=hailo.ai; dkim=pass (1024-bit key) header.d=hailo.ai header.i=@hailo.ai header.b=QcA+VMXT; arc=fail smtp.client-ip=52.101.65.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hailo.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hailo.ai
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VvZwuftzzgLU2/ZkyMeJ44aVK1b+Iy5WoGkrBHOP6re8ZPC8AmIha5A91uIA9plLxdLKWJwu5pHrR/LlUMBTdpYlZ5+iH2JEn8xILZBwp2QkVzCQunTHR8V++mRDStNMUq8kvoVDYm7MUzXK+AkvVcSNVh8JiHEYBvlntBBP3t5MLFJnINIKE5GokzL0tfRvOcNBb3teuWdpwEsr6xn1swOOqn3ibzX9iNOLBBEQZrg26XNKlu+pBTNlvonFQW+0MTAF6huPmF4MHSmVyT4kwH9rEwd0/LRKLqWsUbrdAbHcXvDh0/Xvh/SdBUhiVYFt2nOS2QaVW0TKcWeQdbPF+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSwvpBc2dnnGxBco1bRMVhX7eT5grxwhqUd+m5vzIQc=;
 b=JQvTLKOueoqntU5gGZ+FxlWsqNfeCmzzHL9xOcoAF10tR35P1crTTTXHXCyVBmPhr2xeNCqlwp0U0dw3rzr91LyizaGdimkjgAggGVKGdFBU0UjuPJQs1UvGE40AAGfng1e/AqrVhMh1/1MQvNcHIxKI2rli1SPkVlu82jOF2M6GDOSxHvKGih7cPYARLj6AFK9+dP0qlmU03uF9udacEXwZSJhHB1FhI8dVHVHrmPWkWK7WhHTsMymoL0jpRJ/0kpDvxVAMuygJLWzZuMU6dgr6NhP+y88R31moloyazEhi0SLF3hzZKXGLLZPohyZFOhBD+HTGcS5b+l5HDJMT9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hailo.ai; dmarc=pass action=none header.from=hailo.ai;
 dkim=pass header.d=hailo.ai; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hailo.ai; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSwvpBc2dnnGxBco1bRMVhX7eT5grxwhqUd+m5vzIQc=;
 b=QcA+VMXT7IhNEp8/TYa/k9Nf+jYb2QFVFS4nDqIe52KarCYRo27TxSGoGHa4P+ol5TGO3uvpr/w/d8/0fLINiAzs0/AcCQwN5W4O6H5cNsiv0N9opgtsGlYKmPDWzkHoHZBZF0kD7LOiS5lSqMk0Nx7Bj+oQq35Yz/eSQ896vPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=hailo.ai;
Received: from DB9P194MB1356.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:29e::14)
 by AM9P194MB1299.EURP194.PROD.OUTLOOK.COM (2603:10a6:20b:3a5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 11:50:23 +0000
Received: from DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 ([fe80::f805:511f:699c:7c1f]) by DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
 ([fe80::f805:511f:699c:7c1f%6]) with mapi id 15.20.9412.011; Tue, 16 Dec 2025
 11:50:22 +0000
From: Amitai Gottlieb <amitaig@hailo.ai>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sudeep.holla@arm.com,
	amitaigottlieb@gmail.com,
	Amitai Gottlieb <amitaig@hailo.ai>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH v2] [STABLE ONLY] firmware: arm_scmi: Fix unused notifier-block in unregister
Date: Tue, 16 Dec 2025 13:50:09 +0200
Message-Id: <20251216115009.30573-1-amitaig@hailo.ai>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TL2P290CA0010.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:2::8)
 To DB9P194MB1356.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:29e::14)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9P194MB1356:EE_|AM9P194MB1299:EE_
X-MS-Office365-Filtering-Correlation-Id: 68206f67-2b4b-4b8b-b4a0-08de3c994b84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|52116014|7053199007|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JQQtJgPeF4Tkn1PUsaJlpkQfwJwzyrqrberIYuWKBsPtB6xfn8Fd//fjDJRx?=
 =?us-ascii?Q?t7LDVwuojieaDNe+7f/hra8fsdBTSTbJT03iZGSjoZ2scIkrjwqzrcKrhkAk?=
 =?us-ascii?Q?EO9luC6oIE3A4loCuZfOdWCgGym4LUuJ9GaqNxcz5cq57ksOUFHbVul1geaG?=
 =?us-ascii?Q?GinLFf33+7QgvdvVzFQ4l2MSOuxFi/OgKgQQVkKOADXoGPF6XaQOMQUu6zCa?=
 =?us-ascii?Q?rxdPueS8h549dovBBo5GaBx+ESZzT1jYVAbSkS+UorhOzkv+5yzHjznSKdGc?=
 =?us-ascii?Q?czAfU860zVHM3wP/FszcIEQOReppI4Fv+hJHiaqeIGvKjqKloDsixXDHUHKk?=
 =?us-ascii?Q?ZKVatyImK7YCKJTIjA0FQ+RMTQHnqKmRaFBNZ4RTkyfCG+FxTKuKNS+y3Efx?=
 =?us-ascii?Q?uXnH3cLtb4gD2/CTnYBCgGUC2B7LBtGDPwWbsuB1U8IAIzyy6bxX2N+/r/Wp?=
 =?us-ascii?Q?eJti2VKSchKajnB+clHJKxSUIuDR4Vl18CmHddrqanRs3QeDgIO9+GS8Fey2?=
 =?us-ascii?Q?Ab34VladoPtlMWrRSvQI2lbN2moH0nK/fLVrIr4l7bOEt1z26Boy+jA/rBUe?=
 =?us-ascii?Q?MLAsoXKlO5XEwxYVV3uFqXgAUWqDuphFWk7Pva20hFELIjujtiE7N7hUj4i8?=
 =?us-ascii?Q?BqUHsWFy+1lGzZ2ktZpptSAMyZMXTQeVQ+BinS3sf1EomLRKhEbkrqrCHE4N?=
 =?us-ascii?Q?5j3baCcoo2TQyTNSHELC7xryaQdqEMmOGec6KXqdqcmGZgobBcuKUGlZ6o5X?=
 =?us-ascii?Q?6onDs+qilIC6FvrURtTX1lOVe8D5St2ATUMnMLNl3BT7HjkFtmD961+KKe2M?=
 =?us-ascii?Q?zzTF93n/SGYH+5nE39ASwH5wirj1kB2ZTFw3Q52CzxAMVqWAzRQqL3Sbpo7X?=
 =?us-ascii?Q?jx3K3Z4ZpZU3zCTNJgmH11tJSLMYX6lA43rt+8fro6stpkygA3s9ucsfclED?=
 =?us-ascii?Q?a8D9o74wnAWeh1vQSeT5a/pb3TJYhjQb5E3nUkXVAB7BIR63euj12VCOKBrK?=
 =?us-ascii?Q?WwixbrfkTYdHb8IJ8yWkqlkeuA71bicbG4vxwGEG1BPnf95XEuT3DmU3AKiR?=
 =?us-ascii?Q?0TW4aM0UyXaHDe41UvwpYD9TDMLrNmtrgWCWOxT39aIfXIE5rPGruVxXHkCN?=
 =?us-ascii?Q?GQK15uekMbsK0TuR3MPB79WocTXe95mRUH7exPtjhRWQwc5OC/j4V6PGaaiI?=
 =?us-ascii?Q?NMNt65pdFDOXohKwoGwvFf58grorF2GWO1wJV2pdbNXwYA7vFHjxiMHL583E?=
 =?us-ascii?Q?u+S0JGM/3jkM5Z1fDu4s8W0lIBfFwvEOtSSf6XvamVJrlk2oVAK2aoBOSnS0?=
 =?us-ascii?Q?QSGzVnmH3u46IkXM2njaPFywtaOByWD0ClG/13hpg2TyCT2ELDllB1hDsLB/?=
 =?us-ascii?Q?Mtcb3z73Jy4Kjtdlz0WFo5YUFj2jjpJnzOLFr+ckfH+xWkBy5dQMfvm+GXwR?=
 =?us-ascii?Q?IFx8XL/OLs3QACuDX6m1zOR6CLpAhg9ALbE6lXJaYTuE0GLykkI4UYi5ZRFN?=
 =?us-ascii?Q?BTA9AdAOeQM38F/erFwLxkdAjP5qAIXKx6SZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9P194MB1356.EURP194.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(52116014)(7053199007)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zb8CDFDS52k6nqHa1oj7cYfMoVWaokW3tBk0KRzt5mUcmYCiPkCeG+2mgyqF?=
 =?us-ascii?Q?KDgnBlPyC19dRztjC+QdvFJbIQ93VMGU4tv5sP4hYiF2Lcq8qSXtNBWdQwNi?=
 =?us-ascii?Q?AcwNj6MRw4glCMy5LOL7M71Jogs9iSeef/NLgYnmHzrfD2mbs9Ktt+/Y/SsM?=
 =?us-ascii?Q?PORlngg24+7nnzEXkBywrQXu4+8jgJdbvqO87iZ9HC7gsx1Jf2fgUm4/1tx/?=
 =?us-ascii?Q?0XVJbi2zSYjU/LCJcQvHnwMy15fscmLKy76nxBuX+YRdGH8ZiSiVCLDRQqEI?=
 =?us-ascii?Q?2wgSmScFFWObNE1FkH97Ar+4CSJvBtY4f2gir0Zgk0kdTHqYpXPWAiFNE988?=
 =?us-ascii?Q?4UQT84tS8o9/TTVG3LuGpGIfb7m59u2zlv42j2ejXgujihr1GaSMMnItzEqy?=
 =?us-ascii?Q?hzDTh0DgnIWZ3Ah3kPHT3oqz5t22eIKGzAdqrw3f8l3NvrWgb2dhvxvQCcwl?=
 =?us-ascii?Q?SHMP27D8dJPON1t4uHYtx2qy/LHknaz2QgCKoUeE90CL/gQcvFKYYGBBtIRt?=
 =?us-ascii?Q?UECdZcXohoKxWy2nSWO+/g5OEr3CdNL/stHRDN8loD8KHyx6VojF1iqBTVel?=
 =?us-ascii?Q?9y/+Q2uMRQ9RocwpqYUmFnwBSXbv75nLAlMiUH1U9x7x6Kqw+EJG/8XkBx61?=
 =?us-ascii?Q?zSfSOuaenqm9qHDJub0GGZMoHGsk1FK8s7dfDFdbaBUbhX6zo3qlDAtcmEyQ?=
 =?us-ascii?Q?1j4DBKBNQqfMoh+W4Oqju8J3ccbeT4+lZ1QrU27SLUA3MtggiHCIrJvlBguF?=
 =?us-ascii?Q?2BYzNZ0/ATwVXLLdUD6FrSplZlGbvdWB5lIqGiaFqPwD+kXWP4RZ2lyLHZ4I?=
 =?us-ascii?Q?De7I6sp46BYp0/Iap8eESQ5cQwR7dPBOBPIuo7ly96W73BkICzNIccB55kP+?=
 =?us-ascii?Q?XlMcKvv3GlF19zYPKS5u8Bz+Tc/x6N93nQJaaNh8glx7hkG5hkwaIyiZrRtg?=
 =?us-ascii?Q?cD49v74TEbwZEKP+XmN9tIuh8tPwzDYcBZzv6p+MTEzU3oXyesVZguOsGP4U?=
 =?us-ascii?Q?Nxij5e3cCn6Efo+caf5vejgTqxSBUDw1pk0FocdqtUoSyG/8jhar4oXf6XyI?=
 =?us-ascii?Q?hUXv09Vt3VcZqE1rYeDU3WQfDxo405FYHwevP2MIJynVCf6b3EJ3CIZ6akgm?=
 =?us-ascii?Q?WdzdsyION7zqtH5LsCQCpqA5/ZJWhSqznfNph6jBuQESNqM8V0HAck5br3Lf?=
 =?us-ascii?Q?BBeZEqMMNBysk8azkOsXMD+MOvNDajzOlQZrtAB+/L/HUOBYo8Lbzg0RFolV?=
 =?us-ascii?Q?R3szOp1EQ40ANjKlMrkUa4x4z4fScW/H8EJ/l9NSBT3YkETCywDqC9/aqhUo?=
 =?us-ascii?Q?UmR30LJJH1PaBA4GMi42r1pQFTfUMUx4n4G3KNbKUtGMCsjEBUnnUm3G+asG?=
 =?us-ascii?Q?RMM8jfdDjnCMsO+O0r/9Bn/prTMv8cLNalHdwSii2zmqzfZxsqGglEMVd3TM?=
 =?us-ascii?Q?3zSVLtTqqlDWTP596LEOtPpr3kirL7tKYDApJNENcR+M/pLWFGNRS8W4LV6Z?=
 =?us-ascii?Q?9h65/vN5MGMINUE8diwTSjZRd8mC9NSEYBhYcT8fiktuK0L0lrSdTyQed8gz?=
 =?us-ascii?Q?ppAGfiUPJWIs0DG2glVzA522/onwwRqrPyPF4m5P?=
X-OriginatorOrg: hailo.ai
X-MS-Exchange-CrossTenant-Network-Message-Id: 68206f67-2b4b-4b8b-b4a0-08de3c994b84
X-MS-Exchange-CrossTenant-AuthSource: DB9P194MB1356.EURP194.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 11:50:22.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6ae4a5f7-5467-4189-8f6a-f2928ed536de
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UQjWXIqrDkyw9ySpJEP7FDU7ICk6+Hdl1h+iBX+39rkhAv8e5GhNx1NVNJw+ytxyTVwIa0yj9bRyv+Y6y9umlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P194MB1299

In scmi_devm_notifier_unregister(), the notifier-block argument was ignored
and never passed to devres_release(). As a result, the function always
returned -ENOENT and failed to unregister the notifier.

Drivers that depend on this helper for teardown could therefore hit
unexpected failures, including kernel panics.

Commit 264a2c520628 ("firmware: arm_scmi: Simplify scmi_devm_notifier_unregister")
removed the faulty code path during refactoring and hence this fix is not
required upstream.

Cc: <stable@vger.kernel.org> # 5.15.x, 6.1.x, and 6.6.x
Fixes: 5ad3d1cf7d34 ("firmware: arm_scmi: Introduce new devres notification ops")
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Cristian Marussi <cristian.marussi@arm.com>
Signed-off-by: Amitai Gottlieb <amitaig@hailo.ai>
---

v2:
    * changed the wording of commit-message after suggestions made
      by Sudeep Holla <sudeep.holla@arm.com>

 drivers/firmware/arm_scmi/notify.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/arm_scmi/notify.c b/drivers/firmware/arm_scmi/notify.c
index 0efd20cd9d69..4782b115e6ec 100644
--- a/drivers/firmware/arm_scmi/notify.c
+++ b/drivers/firmware/arm_scmi/notify.c
@@ -1539,6 +1539,7 @@ static int scmi_devm_notifier_unregister(struct scmi_device *sdev,
 	dres.handle = sdev->handle;
 	dres.proto_id = proto_id;
 	dres.evt_id = evt_id;
+	dres.nb = nb;
 	if (src_id) {
 		dres.__src_id = *src_id;
 		dres.src_id = &dres.__src_id;
-- 
2.34.1


