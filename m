Return-Path: <stable+bounces-40322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCC18AB674
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 23:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C681C20B2D
	for <lists+stable@lfdr.de>; Fri, 19 Apr 2024 21:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F1413CF8F;
	Fri, 19 Apr 2024 21:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="B79Dvh/z"
X-Original-To: stable@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2040.outbound.protection.outlook.com [40.107.102.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D991311A5;
	Fri, 19 Apr 2024 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562243; cv=fail; b=Z9WT9G80vGEeN/xokGZLeE9uaeSbvnFmpmsq6VtZGjZUWtJa1ZPFpgPUjckjwsZQ6MAvqaeZCo/QsCbeNIrKuCyvS9+Xzuv3C+c87b9kZd1O4l7dK8FIrwxfE8pfEPD92WaScinlyzOGB1HuGIicsrQpr8DyYzeGIlB5KC7/LVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562243; c=relaxed/simple;
	bh=Efdz8G45dJgRkSatbSl4NcrFXQdgKcLgNq966ZXGMyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NbAQQluvUiYtbpqPDzKh1FvMnc2NAduEPA8oNf4Qq5OGtuOKsmyuSMuIqDInTAkUZZbW1OTg1XeJCBCLEyR0Kl93EddzYt4iUH9eJ3iZ8M0A+bF4z8B1QlGgWjcOmH7andbNCGUn1G+sK+8jNypE1nzGW0xc+Jr5ShXh85Z96x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=B79Dvh/z; arc=fail smtp.client-ip=40.107.102.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVsLgnQ0GWNhNB1+udyuR88At2E60LiNKtFl60iidMp/bfiSrjyKVW6WSk/iejeGQxf/NDfsHaihhvZvMh9w1d7fbm3r5B5ycmA62iW1SkuGOyAiofxlw4Ajj7luILyzAx6lrASwmRFpOVA+WAnASFrb2AvL8qXSQthVqfYSufqsHcMldAylkWmXSWYxMTTbQrH1NdmzBPwXIoBRByG016jnKM3Syz9/1yLtBhvf/LkWKSiNXT+2fdK5bevjDNEdwhQ2bXmj2lhYdQDm8Z86DFeqrbKP+wqiSztH8X52fpyANnbNIf7n5ZpAWhBAbS5sk+TVDhFVwSZPcwDt6N+ciA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiX/fqj6suKE8LTmyQVM+wxzuokRp/GIE0XrRv5+qfA=;
 b=BRSG1Szl5mrbeh7IbK8bZpLDUvClSXak7ndfrtUOxR2uJxt3myg3Go1ZlkMEIVUTXICwT3M783GBpbebZNkeBmaCZ2FEyAs6dmzYeP3RkXO7rFBF0IobIUaiF/wsfNMdBzDjGf0z7Y6dZB0iV34HoqYVN4j7jTyJGqm8qWFlbFJEZcbQKHOkL6P49xbbqClC6bk//X7TYxzTiC4dLoIS5GIU0oggqDmeFAzMoPejvTBMPZ54WeLCERC0dpOlNyuP8q0JkuFbhvP6aZ9n3dSA12BSbtuNOUgt1DkJ9mTxqmHZhQyGln4hMNzI9M/X8rK9in6OerGWv6d2XMzik7CJBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiX/fqj6suKE8LTmyQVM+wxzuokRp/GIE0XrRv5+qfA=;
 b=B79Dvh/z2OwfbQlkScBnkccFEnQgtNheG2TIliN5sXmCPXouCE9VL4Zitplc7rNvwb1GbEUwaeODsC2NLm+fycGsutEjB1Q3gIIxltXqbHWiNIduwcmti3ch9NBdtSYNKM3mskjvrLClwrEwSRtM+AsEhO38vbYi2G4KK5r97sry7hnBRRB2gr37Gc5uhXmhey9FxXKlC+5hAFMyG8yuyamZHWXZ0645vsjgLEqlNfcA8ex7kpAnGjvIIabevayB6nqt4T8nzftLqDGYyLrYpX10S4NJdPudu9x7dr6qsuba9QFHqyCi0gFewJGwgZITP3mwC+1YOUfSBedR1eaZgQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by SA1PR12MB5670.namprd12.prod.outlook.com (2603:10b6:806:239::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 21:30:37 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7472.044; Fri, 19 Apr 2024
 21:30:37 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Yossi Kuperman <yossiku@nvidia.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH net v2 1/4] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
Date: Fri, 19 Apr 2024 14:30:16 -0700
Message-ID: <20240419213033.400467-2-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240419213033.400467-1-rrameshbabu@nvidia.com>
References: <20240419213033.400467-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::31) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|SA1PR12MB5670:EE_
X-MS-Office365-Filtering-Correlation-Id: 27a65fe1-3d34-4578-57d4-08dc60b7f455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?emka+DcG7USriFJDjvgfgMPtnICP3/No0p47cqd4kY91GpAMDaNJI9lHn/Gy?=
 =?us-ascii?Q?p5/iQTNd7/jMXDzz9dh1oJbsEC55/c8JxP9mtQ+bPDXp1ZS+SLSFI9kTz351?=
 =?us-ascii?Q?kfGZzoqU0JKg2esKaqV9RmhFzr4EIuEhbIKbnga/u5jS5jC5B2nY4BtUPIIl?=
 =?us-ascii?Q?HLk8w8fw0SENg2h9ADC9w3sPFLsx7fkISDI7k33i2Ud4RprRPMLT5JqsdXrp?=
 =?us-ascii?Q?3bi/NJbRlLSvFjX4vg3d40vWHSgOUsqZlrVkEwByPE+59+Qc52FEylqZGmXh?=
 =?us-ascii?Q?i5IiaajEpfWzfeu0jUOvsqJpF5J/LRTMj3n6OVygGOGmSyPj1XJlBfs83zv3?=
 =?us-ascii?Q?AheMPgpdMpIwIAbNcIpuP5hCf1us5Yqiyuv4xq0KfNjW7dVU2Dh5XbXd1FWs?=
 =?us-ascii?Q?TUb6wNv3s7j8wqpUmvKrcpIypXJx9+l7C0uu8480s3Sz9rH7i0+UInyhHYwU?=
 =?us-ascii?Q?ozaIgXxEbh7HcAfrF4Za4o/buJCPX6qG8zufZe3bk4fnzpJDZU7D1wjlTO4f?=
 =?us-ascii?Q?qT2NUBlxeY2u0ZCQyvv6XYxP/odCBAgBSv+A4kfF5tqhcbY4Kwe6D8d28kND?=
 =?us-ascii?Q?G6qxvIcFxGvc/1MhOyvbwYtxPaKNmIV/VCjz8cDxUqGriysI1kCH4niHVRVb?=
 =?us-ascii?Q?Usf8Pw0DFjXus3MtoOJRl0CYhrantqE0XHdRpmZGgviMIBxQ8OnRwuo1GLb9?=
 =?us-ascii?Q?9NwYGwQVRL3YIANmZTKM7PUyz7ET5Ap37wtX8jPWQPTOlaeDbG6AHlJG8aq1?=
 =?us-ascii?Q?ptuA5peekVCPC4yYijm/jgJkpFN2gWESdNdMKaU0z2QOoalZrF63U2TCQ6aZ?=
 =?us-ascii?Q?XfzZ+RYTxRuCmv5f5toIlbwY17iXNXw2R5578o9YCLBAZlBWnMJ9SRatsKMz?=
 =?us-ascii?Q?SKXc6I2g90UqTACQBk7RPjxcdBotw3ElphcFCZ2sORxeJCRUlngkwIZM0xl3?=
 =?us-ascii?Q?E/Wmnc0BkY398pmF0tOYOQIf7+srTqc7wFnPYbrRmL+v6RtMRHpkRNuxdoIz?=
 =?us-ascii?Q?VywJncB616kJWU8VMLvUIBx3F5T3UTz+INCD+Yn6FYxZVArtP0QzCvlcJdbS?=
 =?us-ascii?Q?PtzEGc0SZPMquxINIuB5KLV0EUwhwzQTiArzwNH6kPI/hnqLg9zOFgzdYi2M?=
 =?us-ascii?Q?psJ8VQh2t34P5UT7Mk4JiYorC+K3hOzR8+DTeG3GNUc6TPn0sSIyfsBstpIl?=
 =?us-ascii?Q?40gfUazKJxt1rxqR9FnLLu4hIrjW7AkZ+s6cH42f5u9+jdwp57h5+GftZ3B9?=
 =?us-ascii?Q?6/8QyhoWanJFDZgKihSH899jxJhqnR5TaB44OZ+NbA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sm40NsLS/I5bFKMYUPOaiWYJHZ8DNifO5/R3dpvWM+FAfZMNCp42EwcHssEU?=
 =?us-ascii?Q?ltcS9nsWQQsCr7ml/9NaB+KmzQBa7BWlDhs0vMfwsH1Yp14RM2Qb4Eo0YpS4?=
 =?us-ascii?Q?PRNGq5N3d1BGZukYmaJCB+qjwRX+V9PeNOykPyxYxIyGN3Gy+kDzhI8Uh4rF?=
 =?us-ascii?Q?1TtgWqlwPk86ll/a39XKK/JrN9Ppui5RbqHgkKxEdqtwW3omJo/HJEYDeg9L?=
 =?us-ascii?Q?/DUoHDQD2qDcBhifYNj6IHALI6g+LtRj6fcU22L9NCXVt891zRX8s2pCT/dd?=
 =?us-ascii?Q?CSWv80nAiFoDnQkTP/yCVv/QUOqHxagCjDP1Nr7ERTgfiVlO5HHV7Of0dIib?=
 =?us-ascii?Q?H19YFHjJCOcaAeMBMI8+JdINm2Dgh/oXZ68e8HwJLd3LyMqXQOdy5Id19wrQ?=
 =?us-ascii?Q?ZuzCxnlxWkzGcxl6p2Xbz7wWf5+IpVItjP1uwoBGPSLXbH30AG/eMvJpUJA3?=
 =?us-ascii?Q?vAG/saNjsezsOimNeECDNHCGwRA+uT46MhA8jqjotftUa1jrUf+s7Z6zuKbP?=
 =?us-ascii?Q?VexGrGeJzzi+rRDM6RFXdZDW0m0nk4txjfCIymkYAqtsAlcw0ihex93Pn8pV?=
 =?us-ascii?Q?AkaS7HuJrHwvC8rT0GlwBRHy4NcyQS2EzG3Wy0MpT5eoxhT22qmlTy5s2YW9?=
 =?us-ascii?Q?pzw6o10YnUj2DcY3VeQxGXRxxnYLenJx1gzdFpIVbxtETvPdONU+kKbOHq6d?=
 =?us-ascii?Q?ypPCD/F4L/gSOI+8UnguZ5zs8hREbc6PCx7coFrul2Zjti/xSImHuEhJt7IC?=
 =?us-ascii?Q?+yM+6VwnGW3ZwzvtCtH6ZA8D1r8TKqaFK0wrnUb9ezyi/nriUWLUPc5C16Hm?=
 =?us-ascii?Q?zpmnQK+MONteEE3SPJAPblCFjM4EtZTodpARiSJCfDlpN5MKQCbGBWoDKn8/?=
 =?us-ascii?Q?k1EU+S2HfKKcBeQAUU4ezwmPlj5+QdyStD49WmLz7MGhvN1+AAIRu5ko5EDx?=
 =?us-ascii?Q?9T0iSlpDnDl2w7b/QprK0MaOcl2SH8n48uMadF7hIeGiB5bLO4AYTFEnoVVR?=
 =?us-ascii?Q?84/a+I/1p7lUXOE47J+TRhPKqu3Q3/OPk+kH24ItsAUlxV5ar2lbjMRIeJIl?=
 =?us-ascii?Q?rywcyLMp1jdG1+UEKq8jDvebRoFKRNovGbilIhTZ340kp0rDsUf6egC20Owp?=
 =?us-ascii?Q?xFsJ7GInoFxmsLBjGwPgiqPoOVegVCgV4Pgi8ncLC+dBhmEZGXbCJkq3gJqS?=
 =?us-ascii?Q?+sMLJTL7QskCIKJ873aTHH9hRzsKR5ugrANigJZevCHAEoakNNJcPt7jc7z6?=
 =?us-ascii?Q?Iu+v7EuTkG0CyFcQGpmYS4L67dMV+PEwk9VDODoxoVIteaZ8z66l1fe377Q/?=
 =?us-ascii?Q?1qQLCYKh5KsmUyxuOTBlgGGnwSuYgaT2nBG0qP6xT/MqnQIK47MAi3QCUOU6?=
 =?us-ascii?Q?TmB2R0IphDkIdyY60W00P2AZsgBPoFXJZ4sypV1oyZ2drpHsAv9tohBCs1ls?=
 =?us-ascii?Q?+x+n3UApn41ODhWZogDypRFL6Dzfu1Ei2Mk2YstakmHcpT83Cx6/XDgCeuyP?=
 =?us-ascii?Q?/44jtAQY3L2Z/Dww+L9HwtC3PcpZQd8S2jgDCrk6Fd4+SSnOWhYEC7t023+S?=
 =?us-ascii?Q?8TrNtUYrbLDbwOezzKOhHvyVj36gE+koDLmsgQ+4ZQ2ZEOJFu3+VdjvoZIJ7?=
 =?us-ascii?Q?cw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27a65fe1-3d34-4578-57d4-08dc60b7f455
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 21:30:37.6190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e9gzVjD64sy59wa2jy6AQFEB+619zxaSAuutBlMXtgm7b2E8wXHdv5148pwSCiJvVktGgKOLNS8ictTbXkwQXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5670

Cannot know whether a Rx skb missing md_dst is intended for MACsec or not
without knowing whether the device is able to update this field during an
offload. Assume that an offload to a MACsec device cannot support updating
md_dst by default. Capable devices can advertise that they do indicate that
an skb is related to a MACsec offloaded packet using the md_dst.

Cc: Sabrina Dubroca <sd@queasysnail.net>
Cc: stable@vger.kernel.org
Fixes: 860ead89b851 ("net/macsec: Add MACsec skb_metadata_dst Rx Data path support")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Benjamin Poirier <bpoirier@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
---
 include/net/macsec.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index dbd22180cc5c..de216cbc6b05 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -321,6 +321,7 @@ struct macsec_context {
  *	for the TX tag
  * @needed_tailroom: number of bytes reserved at the end of the sk_buff for the
  *	TX tag
+ * @rx_uses_md_dst: whether MACsec device offload supports sk_buff md_dst
  */
 struct macsec_ops {
 	/* Device wide */
@@ -352,6 +353,7 @@ struct macsec_ops {
 				 struct sk_buff *skb);
 	unsigned int needed_headroom;
 	unsigned int needed_tailroom;
+	bool rx_uses_md_dst;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.42.0


