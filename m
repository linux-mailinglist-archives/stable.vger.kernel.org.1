Return-Path: <stable+bounces-142022-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 039EAAADBCC
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 11:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 037C11B68411
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 09:47:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F0D1AF0AE;
	Wed,  7 May 2025 09:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hHO1HT2A"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02BC08248C
	for <stable@vger.kernel.org>; Wed,  7 May 2025 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746611260; cv=fail; b=Z9sbtBU4xVeDUPEFXqZMjZ8/FP54XLQvAuRfSZ9mPU5TYtu58iE4g0QB8bedwQmTN2G1Ci/uNhi1nR5VtaJpzgbQd/Fz1OOO4m9Lr9ewBWfKRFerKoHOk4M+inDLgqU7+TZ19u7TtrWpvbZB3R3PDce1dAoHFOjc4lj3bHQJrlg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746611260; c=relaxed/simple;
	bh=kTlV4uEJgTpb9B7PMdESV76Yqu0XMAmElGgWRehHAqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JivbrBToruw6Kwf9UUxsBd3oMqDMAP+avJSBEnhDoPnpzphv3J1SHZGSINHg9rr1GilLTXga8/Dkw1zKlgFrOpxjObGh6H/MgJw4Zfc/OK0GA1BAHzl6BZslilcAjAvSPcvVNgEFyNNYhZp8mdC2ZSKQ/ijQ3P1SM7oUFaviIbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hHO1HT2A; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iHx3Mz1bfTCcwpWDwUlC1lgpcYAfXwSB9XVOZF3scV06C62rr335MuWJ+JXA0trtCJM+sh3do4a2XUO4fQg+KKZqWQQf56TOstDWRuD8urRTqFdzS0TX5DTIzTOIdcIzp+DeF03IRBd8/oVH4M6fi5C3ZpkFOTs2QTfMq9PxcOWqeeNj/2Hg7SVPS0+LLAB2RsEoOg/M8DWYGljd8XmXnBiqKbBbtLayPa2Pb1rdyJs3sqNTs0rxe5X9uyMTVj3fJOBUmDgVUn0wDisenjNvXMAAgIa5uoCXsJXMjkpHHEBqKGjsPTYrWvDcNb/Xc+eANgbJE10ec/mCPhAERQawOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTRf4hZUmJLFSgFpu1fbkFKuyTEymJYgOMci5a+yQ/w=;
 b=m2bUjogc2HQZPjpZLH++gDAwCKtEUuAMectx/ztgfP/ZbGoW4pyyjB1HDLdt817mjdETm3R8pNi9FyVeIb8BecOcVqFotXjU+UwVNkPSbR7lXY1XtyiYroL2wqZk8QE26vaybTNHheX52E8GhfCVM/zslymYgMp9ioaJJudus7fhPulkLmedWi8f1Q6xajCZ9Jc+Xd3iNQj+7FyH1J/u4otwO3pYuZVXxTyI4N/pE1xMjyg/LE9X8AmaQPv9bnH9hY4vxjFQ/vfifmRkUWdLA9bFopK31E8kkcMP6gaYO0KgW5VFgr6huPTuEaLhvwUnmzyZ1JS8A9bnsjVsaOfoZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTRf4hZUmJLFSgFpu1fbkFKuyTEymJYgOMci5a+yQ/w=;
 b=hHO1HT2A6D9dlk2ajqwfG1fhbvJRmbJgLm8pjobBtDUzzldO5rGwxMKnFIqtGOJzOJgm5G2q7N2wWFtZITTnfXwt1j3FmVqvbkffi1+67Skchx0M7VM7V/OBfzc+bptz2NPp9O3h8TpH2x5sGYrUqRqlYcGYzbzscw4NDqw7BFUikp+6TYNudi4EfR43PRjO206gIg/HDsRVNR0eBb+YZH4xHiNMm0H3ZXdFW7QHkesvLnbkztFU7x38HBgUz7fBDhMeZ9yupcYjs7qnSRA+qSm0wRUHh2i/PlFHnGyZO2FGR+Cxo1GhDE6Dmu8iSaoSOQoWRHBS6MWymsyJAY6uGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com (2603:10b6:a03:453::9)
 by MN0PR12MB6293.namprd12.prod.outlook.com (2603:10b6:208:3c2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Wed, 7 May
 2025 09:47:30 +0000
Received: from SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b]) by SJ1PR12MB6363.namprd12.prod.outlook.com
 ([fe80::bec3:4521:c231:d03b%5]) with mapi id 15.20.8699.026; Wed, 7 May 2025
 09:47:30 +0000
From: Jared Holzman <jholzman@nvidia.com>
To: stable@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	ushankar@purestorage.com,
	gregkh@linuxfoundation.org,
	jholzman@nvidia.com
Subject: [PATCH 6.14.y v2 5/7] ublk: remove __ublk_quiesce_dev()
Date: Wed,  7 May 2025 12:47:00 +0300
Message-ID: <20250507094702.73459-6-jholzman@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250507094702.73459-1-jholzman@nvidia.com>
References: <20250507094702.73459-1-jholzman@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0209.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::8) To SJ1PR12MB6363.namprd12.prod.outlook.com
 (2603:10b6:a03:453::9)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6363:EE_|MN0PR12MB6293:EE_
X-MS-Office365-Filtering-Correlation-Id: 10be804b-af8e-490e-7270-08dd8d4c2ed5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYK44PWz1MFRpu+GIOmRdUgMBwZS3JeptSeo1lpFRgASXei60UkmygXitetz?=
 =?us-ascii?Q?/TMn2FqTna0hAlsnl2u7KW5pmP5yuiHtwXAMZHMbh3yyd1H0Oj/6DCH8JK5d?=
 =?us-ascii?Q?yLtgFvXLkDqU2IS9uRrcmDH7sjsOYnQcppmXyQfxlyTo8zLK4K5YLs+k8eu+?=
 =?us-ascii?Q?5UX5CyD/citGMHB6dvbscnRdPJlugIqXsANFerfp/qdvgeFB6eIOvKedmhCj?=
 =?us-ascii?Q?3+M1AVbvLUJrMaipyRT7ZXckxJmon5i3PlmjVcV+N8ptzBUztcbdW5p7Ne84?=
 =?us-ascii?Q?XEaeCY0t/qvtCkAp8nddP9rcK3rH/vLymT/EHk9huUJJk4NSuQwGo2zDbnSu?=
 =?us-ascii?Q?bwDErGJL8TxMkT46RvnGKfJsII2Ehev35dHJwMc5Dcw7Y9bNzpFgAv6072oT?=
 =?us-ascii?Q?XkFNHFVnwlXwAuUGykvr+0+czHVLKl7c8MbU/WKI9gPZiIMvigIFViEfw2M0?=
 =?us-ascii?Q?/xR+xhH1eCmg2E7E6Mo1q3n4A7ecvO1eqR8FmxEODzuFZKTNNlboDybAGU5E?=
 =?us-ascii?Q?srWBb+pwWnt/wkmuXb1+WG2oTUtdL4u7P6wz50oYMzWPumFaHs6nEXSwU14U?=
 =?us-ascii?Q?OsbmEKlNd6dhy4QoXTtoMJlWnSSgBSDibsWm3wzycW0RnHmxwf+z4vKdzBBw?=
 =?us-ascii?Q?p1oqDBnvEBxo87hn1po6NdmMNO9qZplPcB14X3IpWMkpxVAJPyeHLr1mMuWo?=
 =?us-ascii?Q?Jo3qNpJVJ4KWKzm0XOtJ527IVYS5ho/CV8QhjtDILOvF8P9qDEFabjiWkpem?=
 =?us-ascii?Q?ml3yDckO5K++tk0peY6GqaC65j34rdNwYDZD5JbuQNl5qECC0LPEDjPb+rcX?=
 =?us-ascii?Q?xaphDP9Fl2Q4kuqS20JdNasA5YRxAhnhCvRuAYNzIXh1Ke0on5xB0ua1rttZ?=
 =?us-ascii?Q?9IJbji2k8t9gwDRuKvFD1p7GOQW97IPn1M8/4CyA8JhsBkUouiPQTFF6Oebz?=
 =?us-ascii?Q?WPOvuu+H6348xcP/OR4CQKHB2W+/NnPs8AalAJGf3V+fdEF/2tJymKh3IxqY?=
 =?us-ascii?Q?ot7oKtKOgFaSUjNxewcZjcsSbXdyWV1kcvreq0ZKif8MZxNyXDN8jGRBG2zc?=
 =?us-ascii?Q?duc3P3iQ1Sc5P5J1ESmeOuVu+JG3Pqma7vHnHod6+Y0j1vMS0Vo1vresn109?=
 =?us-ascii?Q?pFg6ieaYyaK4nLdDwjmitOJqelidYe+aw1cZuV5jWt900+o7Ns5XZgGCp2Ns?=
 =?us-ascii?Q?9w8mtBecovKNkFN7qj5x1D908Op6c0opTRwv/V308cvvCTijTF/xFvqV1RLA?=
 =?us-ascii?Q?LwvQwHvlkaVSH0QKomT+OrPsfDvOPXd82BZl6/+w8LzmWdlmn40FH55EbGA6?=
 =?us-ascii?Q?I+8hTPEm90jTsb6OBY8HPZ2IlwvNC3dRqNPZGPBWgaErVPGSlip0XETimDJw?=
 =?us-ascii?Q?HUigmEgJ52HCsuogT8d6HhZuL0k7qhhG3ylDncA0gtFnU6hZaqMNlW4nGLYB?=
 =?us-ascii?Q?kR2EXkAs2t4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6363.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bI5SyDKNOrMlGNBl1CfzzYfxF3K40TYogYYywaCYpZ9d3qpRlgr05bChehn9?=
 =?us-ascii?Q?iNS2O/2QENkyRoV9LWVKGqyOP42YyOIVSLfXTK41eB0jrXHpz4ZTsGiJw4zG?=
 =?us-ascii?Q?jLg5lYcolwb/S5x3CsmVN72FGEd7lI4M2xkjdJKMcZ+DxMHo4S4QvNMLoW1Z?=
 =?us-ascii?Q?RM2OqySWMU0k9x76HIBxgL1cc3hUPxrqw5McTa9flKDFXe1T6z+yA9gPXQwU?=
 =?us-ascii?Q?REoBDUrOLUgaAqH9tlMxyriD8/gh8XWcDuUiUtPE3EmkcdPUgf/tNSwyGbeH?=
 =?us-ascii?Q?n6mmd6QzCOWdkkxOM9qk1oBTfJqgVk8sQzr7wgsuabeZmCXUh3W+HeXJqA1c?=
 =?us-ascii?Q?rez8pmK7BsMFnLiQQM6FTMgTBooG67szBso+kzIqrhRQ6ePJmjMfjZuuQ6Hi?=
 =?us-ascii?Q?LAd4SX+ClKyWOdHT1wOwMl2897jgTBDvVw6HL0Rf4ORefePZ1TsDvXLr0vKB?=
 =?us-ascii?Q?4Zos0f26lfyTb/d2TID84i3axnOAeO9JoqEypSdXQFla/i2zDrXEbT47BUt3?=
 =?us-ascii?Q?Dt5x8QPGrEQh4+RVOeGUMiX+fm67XqnCsKyCNEhKvtanbrFS40nUGOBFs+8X?=
 =?us-ascii?Q?ZQBmH0SZrMOZhJ/sGZ6D4qNS8BSP2p3xTllPpnyYG7wYHRi7usilYfIzwSnM?=
 =?us-ascii?Q?AF9z8YpGsHHynHrSGPGbTio+jG3SJti+5GWqoxdzWEelyQMoNtw8KS3egHg+?=
 =?us-ascii?Q?yf2D2kBB9C/KJhsY0mngWG11WD3D0U5BRIqdJiMB/CxBnf07ehMo2ZcnmqZW?=
 =?us-ascii?Q?SnLFG5SDfjr+izxdD5J70buhGD4djnnMYG4RG58TMlrQu5pUbZXLa/ILhU0L?=
 =?us-ascii?Q?arNbrQpQngNyXR/PxknnBsQbRLRxISMo3wLnh/OeXLuKqhi6D2kKhNux4DBv?=
 =?us-ascii?Q?q9vQxve6fHvg9M3AQQC3/YHnNWqbxi58Tt1cw0meaLC0kof6ypqwcjwWswZX?=
 =?us-ascii?Q?ERJ/4RDermyvoxYIg8WZtEAnNXK2vOjiM+TE+xp+8K4g3KJQhXHutyU6eCZI?=
 =?us-ascii?Q?0vn/fUsoAlJXbOmAgmg8Hw+HHkBMBTxQFVugstBIbmOSNAOv8YkM4vjmUwve?=
 =?us-ascii?Q?ZP4zM5nOp/J6LfkvIsRn0IWkx45zrCGLm8GBmD9mPaqhIAqhwYvFOltlqKib?=
 =?us-ascii?Q?YFbsnf2xdbacgeLtHihP1oOffML6hC1y/OYjKnT0JaON75su3vgbV91sYGKf?=
 =?us-ascii?Q?RHSIUMmkVESbkwG72JD9GroqwY6dKkCyOOXbL8bBuv3dd5X7LE+Z8LI7DpiO?=
 =?us-ascii?Q?fI3f0TtHpsUovANbU8qDzGkKQl5vzyh7dc6UnSxc8VaGZyFNw1/7ANMn6xXE?=
 =?us-ascii?Q?+lUWCa7ELX+FXvkWzHtLussdVi8oDilTqpEBaK+eTt8m6R6wWKMPUGz14gAs?=
 =?us-ascii?Q?iS8kPd1/Wakn7xPG+EzvIrAY85O719h+pdqK5i5yHIDEimKYd6XmpDDIJzl6?=
 =?us-ascii?Q?7J8QQJSsD1JH7yxwm4mlTrqHPhL78U0OUClxJyPlL8g7GxughzV62ttMOR/p?=
 =?us-ascii?Q?Y3Frs0R1Iw2NQXzJ1EX7jr8j7Jp8848e7yTcga7PSCTgrS06LU2IUXUrrVn1?=
 =?us-ascii?Q?hvSY7q9OsREvfhD2NBNYu/D6IWYWl5oonbCP9qhl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10be804b-af8e-490e-7270-08dd8d4c2ed5
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6363.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 09:47:30.0639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b34U6JdunzHaeAJnuu1d/4dPuzEUythwmJo7AV28d6d+3fEZyntxLqyfdnKG4c23wimg49DCN6LrAOMOVBrI2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6293

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 736b005b413a172670711ee17cab3c8ccab83223 ]

Remove __ublk_quiesce_dev() and open code for updating device state as
QUIESCED.

We needn't to drain inflight requests in __ublk_quiesce_dev() any more,
because all inflight requests are aborted in ublk char device release
handler.

Also we needn't to set ->canceling in __ublk_quiesce_dev() any more
because it is done unconditionally now in ublk_ch_release().

Reviewed-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20250416035444.99569-7-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/ublk_drv.c | 19 ++-----------------
 1 file changed, 2 insertions(+), 17 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index 652742db0396..c3f576a9dbf2 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -205,7 +205,6 @@ struct ublk_params_header {
 
 static void ublk_stop_dev_unlocked(struct ublk_device *ub);
 static void ublk_abort_queue(struct ublk_device *ub, struct ublk_queue *ubq);
-static void __ublk_quiesce_dev(struct ublk_device *ub);
 
 static inline unsigned int ublk_req_build_flags(struct request *req);
 static inline struct ublksrv_io_desc *ublk_get_iod(struct ublk_queue *ubq,
@@ -1558,7 +1557,8 @@ static int ublk_ch_release(struct inode *inode, struct file *filp)
 		ublk_stop_dev_unlocked(ub);
 	} else {
 		if (ublk_nosrv_dev_should_queue_io(ub)) {
-			__ublk_quiesce_dev(ub);
+			/* ->canceling is set and all requests are aborted */
+			ub->dev_info.state = UBLK_S_DEV_QUIESCED;
 		} else {
 			ub->dev_info.state = UBLK_S_DEV_FAIL_IO;
 			for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
@@ -1804,21 +1804,6 @@ static void ublk_wait_tagset_rqs_idle(struct ublk_device *ub)
 	}
 }
 
-static void __ublk_quiesce_dev(struct ublk_device *ub)
-{
-	int i;
-
-	pr_devel("%s: quiesce ub: dev_id %d state %s\n",
-			__func__, ub->dev_info.dev_id,
-			ub->dev_info.state == UBLK_S_DEV_LIVE ?
-			"LIVE" : "QUIESCED");
-	/* mark every queue as canceling */
-	for (i = 0; i < ub->dev_info.nr_hw_queues; i++)
-		ublk_get_queue(ub, i)->canceling = true;
-	ublk_wait_tagset_rqs_idle(ub);
-	ub->dev_info.state = UBLK_S_DEV_QUIESCED;
-}
-
 static void ublk_force_abort_dev(struct ublk_device *ub)
 {
 	int i;
-- 
2.43.0


