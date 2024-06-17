Return-Path: <stable+bounces-52625-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD35290BFD2
	for <lists+stable@lfdr.de>; Tue, 18 Jun 2024 01:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C242D28141F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 23:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3761991A3;
	Mon, 17 Jun 2024 23:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="BkfbRjeX"
X-Original-To: stable@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2095.outbound.protection.outlook.com [40.107.243.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E20E1990C9
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 23:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718667457; cv=fail; b=ZYOvBY+Kz55s4t0l/VeReCvscSModzxirvmXA6YyfoPgLBKEobkP+OShQv0DprtNghHPlhIN7mdMMQws8Uk6TM1eUDKSH/miIr07eCgwDc0y+cFXiyka+ksWpqzizCRFwPPccm4FbmQkosT575kOR9AiIvqbeeHbVw6/vkbroWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718667457; c=relaxed/simple;
	bh=JDx5BaQk97v/9aqI4I0y0fa1sUOtDin+Q3m3ERefP1s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=uazXgRLV96VJdjmeN0+urT79WTRNP+jETyPvxxbCNNvXE/Vvd99iDZGFrqt4PBkFD//oxwQY4zAVyfH2MeQAbkR8t/0vVumDKxWR90BTWTz6v3LhhvLkksR7tmGGezL1IOmxS3Jtcty/VLfrGvkwtmKdT9g4rh9ypyRgmBhMDdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com; spf=pass smtp.mailfrom=microsoft.com; dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b=BkfbRjeX; arc=fail smtp.client-ip=40.107.243.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microsoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGPnVePvLzlpdGOncRPzICjercs37tqUu7cmtxGN4SiCakVQavhi9lGYtJ957NVfEAKLBYJL9SOOzP4lI3RcIUqZxUGy9BvKpPm0zajhXV+5L8FAxvKChOZFPuWDPBT0sEMhrqUm6Nxev0cxM9aJ75iKwW+M4zLtKyHtIHqkYf0UfnnUbfHquQzf+WGOJo/BhDoy8ADhGNYqfEWmRfpEmUKlrlAKBa0/fUWf+fJSdrxhcNLaOqOJbCOZt5hr1apc+wUBojM5PN/jLO8HJEFUDBYel6U5cwPvLINSKDru/umcoDUfyvw+EjYA8v4XYSkjhs5wQyhBE+XhRMVfxotPRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn7zlJ8dUB6qMm03YfxvX8AQ8ip9OtKwQ1nzbzkqMlk=;
 b=Dr0RpA7lgMQjhQIthv71zTqX6gR8ymd7Q7XIrZoMnVQF5VhSNd5WjnWtMq1yPfvcULyK7iYa51rB1+daf+5DfDWABAtE6mu2ViV7dloVQkYPmrr5t0ulfkxxAW0YaipiCxXKwnv44uVsoVw0kWeIvua4mteFuZjNMwCx0HW/JoXaa9wPrrYaP83k8T6sRThRfFZkA8FKwNfLJIowL/Vg5umf+ZKNyjYx24JEe7RkOdvS07yH7EwLjmET5hotkavirilaWcdXGWPZVb49wxhicWztJt3Q7qRnowZ9MCM8+4yuuVyRSSk/LEbLSNJMylC5AUgFl6lNf9ZbESGr0WzeVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn7zlJ8dUB6qMm03YfxvX8AQ8ip9OtKwQ1nzbzkqMlk=;
 b=BkfbRjeX9NfBmEMaaYdDnBxae31NnUj30LzKDneCHSuutnVaYj7TD8iBakvUyT7MKQxsegfMsZeFu3kUI01G01SVtHEZwPD9XK2PL627uS8hew7OXSJOYc1C3vBZZ9+pYGP2VSG7Huk/or/9r3CqnTuY0WTtnnl5ubxmG04VNjQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from BY1PR21MB3919.namprd21.prod.outlook.com (2603:10b6:a03:524::19)
 by SJ1PR21MB3761.namprd21.prod.outlook.com (2603:10b6:a03:452::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.17; Mon, 17 Jun
 2024 23:37:32 +0000
Received: from BY1PR21MB3919.namprd21.prod.outlook.com
 ([fe80::c90d:c54d:7c3a:69fc]) by BY1PR21MB3919.namprd21.prod.outlook.com
 ([fe80::c90d:c54d:7c3a:69fc%4]) with mapi id 15.20.7677.014; Mon, 17 Jun 2024
 23:37:32 +0000
From: Dexuan Cui <decui@microsoft.com>
To: stable@vger.kernel.org,
	mhklinux@outlook.com
Cc: Vineeth Pillai <viremana@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH 4.19.y] hv_utils: drain the timesync packets on onchannelcallback
Date: Mon, 17 Jun 2024 16:37:11 -0700
Message-Id: <20240617233711.691-1-decui@microsoft.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: CY8PR10CA0034.namprd10.prod.outlook.com
 (2603:10b6:930:4b::11) To BY1PR21MB3919.namprd21.prod.outlook.com
 (2603:10b6:a03:524::19)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PR21MB3919:EE_|SJ1PR21MB3761:EE_
X-MS-Office365-Filtering-Correlation-Id: eb2bf0e4-6fec-4394-617d-08dc8f2675aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|52116011|376011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fOPXXLf9OR6R2hsA4pZy7pTUna+n//FCMfGCWs7T+hpiwz3WTkxPzLpwndD6?=
 =?us-ascii?Q?Ng4kp2xsb04HoYtSLWsv4She3iwqf4FUqdDXzUXtny1f0g1x79iF0QF+mOnE?=
 =?us-ascii?Q?VMgpFq2d/FT/t0qpuZbUx9zhrJgASgLFHvl525BhZcAzkFYaxzRVAXpejsu1?=
 =?us-ascii?Q?5Bp0mqWHKsxSoOIC4s0uOdxoD34VPdmoKHCqfthoRDzqp6uyxA2S/rkUfwfD?=
 =?us-ascii?Q?o3qjJHm7/IFpM5Qf6g9g+mbktXuTErmKqUjE+dNrNDXldIEkzCSH8d3ULxQN?=
 =?us-ascii?Q?A6W2Lhw0pWJage4hIcU4fg+SoLDSaj+QMu8NKxSSAyMX8lE86NQjKKkNshc6?=
 =?us-ascii?Q?wVZ9rBszucy+O6uhHkD5QcVHwXpTJog9XAhj4skMjY1pjWl9tCICY/SLOile?=
 =?us-ascii?Q?Lqxt51a8zOwzFVJU1yytMng2I1a5LvBO/bjOyTJp/KghJxsSOU8rbeW67uHz?=
 =?us-ascii?Q?CBqy6paXwIGb3TnURaAD8mZq37B2pwnumo+222KDlIpmOk4wU7Aq/sLiL62h?=
 =?us-ascii?Q?BBRROgV+2QamMXI0/6lmcr5WuIWd7d3KnyI1zO2bInuXuPRGvSFvkOTDqNHN?=
 =?us-ascii?Q?G2pcO7YA60upla6HLFr2XmksgXXwPYNkg7U2HS9E1/SNOQSDRHNkk11IsySB?=
 =?us-ascii?Q?vAClQ3PAhNl5QKuXQ9kJUoKu/EWRuNZSCxvhBrTpXmaDIuoO0nHRi1xuoJhp?=
 =?us-ascii?Q?B2gr622XFaP8Y7rwWp4nHo6OumAw2L/1l+rYXu2T/VJv2UMvPsPuGFB7Ix/m?=
 =?us-ascii?Q?wST9v9rWulZzyetPGSOLSEskJs4Gsl1ehUWLG0GPz2gB9nTWYieO+5r4LYZO?=
 =?us-ascii?Q?XieooIrcHzJbU3jXFLGT0pTPPLDitPQsSeN4jH6/z9LDUdQLFaenshdC5KaY?=
 =?us-ascii?Q?7UvIUiYML6iV2CYwOurZOR74RNwtzJglpvdPbpVdRK1gXxK9CejVSf4dByao?=
 =?us-ascii?Q?5b52/vD3HK0KMefhb3OWJZI4kGycZzmM0b8xkqM3aSk6KHoq3N6aynKrVzWU?=
 =?us-ascii?Q?bBIgcebc9zujllM6oby8frCcCTH3NcaMMrnccjmTD0ejq4ZbYA7hrGOXlNFK?=
 =?us-ascii?Q?Av2pnVa5Zgwe+YBFMNFsf4OxsHvVxUp/gDSfyPAmg7I2vWijM8mNTYlWwNTh?=
 =?us-ascii?Q?cT5mAV9EUjSIfqRK8isqWanMaZyV3P5rQCRQbqOWs/vOR3aZnSk6IZicfRDF?=
 =?us-ascii?Q?utx8JJoTYVs1lIvi6RHEuGceuVNletFZb52BcZH0usW/MPDMIW52zlkH4nOh?=
 =?us-ascii?Q?eViB+OB4PTgYKVlgEMMz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY1PR21MB3919.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(52116011)(376011)(366013)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kk28+dIcE60MphR6NkTXiCuA+IGUOqu/U4VHIjkrPmgnuEmGZl/i5lUC2ymA?=
 =?us-ascii?Q?3G5QVxfLN35k8ad6+Sj7J8pBuppcvKyCXwKUeIqcS7sdNZFT9phfFyUSYeY6?=
 =?us-ascii?Q?8R6JNPStJpGlcjuUNsc0mrhsXlOn6H+Mftoty5pPUge/PGvsSDGRZFsy2nkD?=
 =?us-ascii?Q?a660XSkLG//3zdkHrCIeFf/rZhynZrR1WZn8mugZSCIxi+wEohAjS6TwooW2?=
 =?us-ascii?Q?0dz5RrRSJUOQnT2EwTG0fKuNmfuDQjJe7cmRT1FQ1WkTFxUcAgJ/5PEAbwMc?=
 =?us-ascii?Q?RubuQXuTlip0Cz0zgpgb2KKxeAh2kVnA3Qgm2eLxXhDO4JwixQtUm1CMHTDl?=
 =?us-ascii?Q?DWZDQsoKchaHHf8HCAwV7TyO39/MW5EkF7Nen66QP9+73KFMtvumylCFVouQ?=
 =?us-ascii?Q?st8fsa4kWgcporIrmCtb7oY9A+7v9X+prh3vSHw6u0ncpbqjsQvM4DO9vKWD?=
 =?us-ascii?Q?ckDTi0+iE4UjHa+OaocoDFVShOlpgVYy6jUixe3KEEbuzwDcR3q8tIXRSZWS?=
 =?us-ascii?Q?fTqNkmvUxA/FzPeYADKSKAWUa8ipiaYWjdQwzxxK6P4ys28IyQZ6Ch3l8Wu3?=
 =?us-ascii?Q?n4o33gnib8OCl5mjuka5QRkQSRJlks3Z+2mVlc/s8pwcSctgDtveDUVtlmH5?=
 =?us-ascii?Q?8wG60GIEqT3Bl/cvK2n+0/HQjA8Qhgp+l3kPlC8c5QcmKmy+uJlHk1ZnUi6a?=
 =?us-ascii?Q?tVCRbNV3ouWDooz78whYg3+40Op9rweJy0ldyFG4iXLgnRhrxnQY+3Pvs4Ut?=
 =?us-ascii?Q?7jYzMJIkmILGzJmQaYEgkBwA2l+Lwo7LUgOAwk8BeAczkftCmcMFXn2vP7Pj?=
 =?us-ascii?Q?QMZmocqWT6BiH60dXpAZsOnTlyLM7oPGhpdQ36+f4cLP8hr9fOATLFWk/MeJ?=
 =?us-ascii?Q?e4wSPaLR/xqZvdHLMVK2J3cUdD8wR9I+7GgegMdxHZ9M0H95Yz1GNMmAEBOB?=
 =?us-ascii?Q?qKoIECr/sZkkryyjipjWMh56A/xaT6AKC9CBFnBh8h3w4ZYGq7qhvr5YJPV4?=
 =?us-ascii?Q?Kq44RmBk04PxgNi3NLOFDJA4lNI0D1wRvdh5DOPRtKjYEReK5+JNyl8lJEbj?=
 =?us-ascii?Q?936xz2eduveXGv4ncwefqp1lWi2ZNPDZe+OQ3K1BX1gg8c+x0/8VCyFt9Sou?=
 =?us-ascii?Q?9FVDEMwYGt+StdQ2H7/E05nesCvPm8FsCaJWddCv9yx4bm+T6GeWJ4NQo9Un?=
 =?us-ascii?Q?eI+0gtlN6kIHIQZdJaVQaA3tUX8dl4Oe2eyAj61yD/YcW8cZGM+3PtySGg87?=
 =?us-ascii?Q?mxWm4TmJglOlYYThLfxNboTWpZYceZQDHFojYyT+pqk8CyrWTGjMUQsxLq/d?=
 =?us-ascii?Q?uBEPiK2JrMSaWxXMR6xpPkFVNfDHbQ+my1+qt8iKHY9vPektEsRcVCqLpaj0?=
 =?us-ascii?Q?9XTPFLvc5rgUw+yJTrVQr9MAY9HDsTc8vx0u7cAWCphIwXnFwP7+779oRwf+?=
 =?us-ascii?Q?u78MFGUAUkeigQrgleE6gjeApqP3Tr3Baivpp5d2LT51A46qZz2f7kFj/ePj?=
 =?us-ascii?Q?Za42++TOBrTQCUcKQsZks7K48lFGlOAYGdEdtuQ4bOVoy1Uhl80lfLTAggiv?=
 =?us-ascii?Q?ddHOqJYR08saKLg/bbFUvkazm4iK+gpKQO2WDZBNWIMFtEN38n7j6Bcy1+TC?=
 =?us-ascii?Q?W7FMZhmB0XIbpZk3H+fCb9C6upJP503qCtRmV9sNEBJI?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb2bf0e4-6fec-4394-617d-08dc8f2675aa
X-MS-Exchange-CrossTenant-AuthSource: BY1PR21MB3919.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 23:37:32.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wb4ntHYVphDLu5e7cQIWZtiBnpIrifpCmVYzdcjqXAEZJ8AI+OwRUSaILGuPHVdZvR7rz8l0LLhS+Zp3fxM7Zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR21MB3761

From: Vineeth Pillai <viremana@linux.microsoft.com>

commit b46b4a8a57c377b72a98c7930a9f6969d2d4784e

There could be instances where a system stall prevents the timesync
packets to be consumed. And this might lead to more than one packet
pending in the ring buffer. Current code empties one packet per callback
and it might be a stale one. So drain all the packets from ring buffer
on each callback.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/20200821152849.99517-1-viremana@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>

The upstream commit uses HV_HYP_PAGE_SIZE, which is not defined in 4.19.y.
Fixed this manually for 4.19.y by using PAGE_SIZE instead.

If there are multiple messages in the host-to-guest ringbuffer of the TimeSync
device, 4.19.y only handles 1 message, and later the host puts new messages
into the ringbuffer without signaling the guest because the ringbuffer is not
empty, causing a "hung" ringbuffer. Backported the mainline fix for this issue.

Signed-off-by: Dexuan Cui <decui@microsoft.com>

---
 drivers/hv/hv_util.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 2003314dcfbe..4a131efe54ef 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -294,10 +294,23 @@ static void timesync_onchannelcallback(void *context)
 	struct ictimesync_ref_data *refdata;
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
-	vmbus_recvpacket(channel, time_txf_buf,
-			 PAGE_SIZE, &recvlen, &requestid);
+	/*
+	 * Drain the ring buffer and use the last packet to update
+	 * host_ts
+	 */
+	while (1) {
+		int ret = vmbus_recvpacket(channel, time_txf_buf,
+					   PAGE_SIZE, &recvlen,
+					   &requestid);
+		if (ret) {
+			pr_warn_once("TimeSync IC pkt recv failed (Err: %d)\n",
+				     ret);
+			break;
+		}
+
+		if (!recvlen)
+			break;
 
-	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
 				sizeof(struct vmbuspipe_hdr)];
 
-- 
2.25.1


