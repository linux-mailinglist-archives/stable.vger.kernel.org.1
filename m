Return-Path: <stable+bounces-41779-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD4F8B66FA
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 02:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F24461C221ED
	for <lists+stable@lfdr.de>; Tue, 30 Apr 2024 00:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7DC10F7;
	Tue, 30 Apr 2024 00:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+N7/5wL"
X-Original-To: stable@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2069.outbound.protection.outlook.com [40.107.223.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC9BA48
	for <stable@vger.kernel.org>; Tue, 30 Apr 2024 00:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437898; cv=fail; b=b9VTjBsVuZ89Lb2fi5BTSsuzO0zqyr6nRw4y1bMyUBM5y+FJwLjrSz5H0TiPLuUOpU8Shc3U6QPCIhWcGTFZ0fq5Y2Mz9v2zFjtoq3UZh6ODpRS2cfVzIKcj31yRAt4WgZcJzxEjnHwpqttmNPJr1VAFx7I51jUcP6xh5f4+ysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437898; c=relaxed/simple;
	bh=BXyLX4ODAtzdcKOGdHKaAz5Z7+bhCSUuVUApCNqjM+E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=jCFGkpFh2RqVRIx9T2HuD7IYX4D7HyraY1jXoxoXpv6hqC2uNgo2qZnfo1k9G7i2E68kUuusFBg433OnYWkZu+VGNKV3ltydz6BXwR+gycawElXsiRYP/gfBBog+BwCu3WbopDyCbZQQS/VYYIi0/DPD1sIJTs1YnkFPPPQhcfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+N7/5wL; arc=fail smtp.client-ip=40.107.223.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NBfTavwmbzyfML/utHc/4e8w58k7CmRpIxLR7QkJgHJoRxUencX3HyQwoNfdk6tx3oKc1bwM2tPC77q8lXc9bfBaggfIkYfSP0RNad8tfdw66AcdKXymOse+4bQR9NDRflDl2PPeDx117UT/0CMONwJsWBH5WXTJId8xC+HMNeGdHPA3KxQTPxODliMuprRBp9irnBGKfsN5L2O+dIlTU9PZqUlKvXVFVXEycmnWbzJ/8S3mXHfv+6BFePcUtOJJEovmrTpxD5Tn5aec9pq4V1LUquUDLWaMlArdDbvcQUyVVwxnwO3cRkXgEzOP92+Ph/fRQcUVvljacYsVP4zshg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eNzuw+SUcriUBSfVe5KM9fxCfOCfciPcWxYxaUwg2j0=;
 b=Kc6xQC+Qcur7wmXzDuki6dOZginy97Me5OG0ipAWWfoEXSLpLskJe104godVhKnr/GTLa/llh+GuIAxQD+0M/d6f7U01bUGSLxIBlP2wqJU+p17csUPaf5Z70gVsh7nC4Q9OgU7SuXQ2q43GPcqEIfP70tXrcb2UnGCTI9mh2LqWX+FkflHVj2fjhXWJ4/E+99po5tv0xH7ZhHdytLbiM/npjNfjyqSgT5k508YALl9H6RTfN2gE6YWdHNGvN/2hF59wXt0xKkzsImbx9/9nN1DkqdvqiqG3q4eS6JFePrsXgLdsMY1hx6KhqQ68qj70jZrTJ3ZoEYDo8fP59dCOww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNzuw+SUcriUBSfVe5KM9fxCfOCfciPcWxYxaUwg2j0=;
 b=o+N7/5wLCQiM6l8ulp11Opzw2qoBodX09/ksksUtCl3n5S/aChmTet58GmzlcxLsdnWcjVbnzGLmAZO56UOOBOj1Kk1VDXqXnQGx1GXg4I1cTi+AANQQGmmDyXpYl/UrgO/hNcB4Wx8MvXsLh0AZI5P29WlvGBMHSiYTYjMRooUOhPnr42G7OYJVtIhApgbgaeI4MYAWXYU81aEAZfOhnenlpp9CDhP5ehQiujvOyQwQrn8LRvWoH8OPLHsw/qHXH1s2QAwDqX4JX30+WcBDhNnGn5GexHHpO1KkelvCIgPQJG8iyH6thFz6gZp26y8Vps8nN3DHzPmtzELX1aoo5Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DM6PR12MB4468.namprd12.prod.outlook.com (2603:10b6:5:2ac::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Tue, 30 Apr
 2024 00:44:54 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::3ec0:1215:f4ed:9535%4]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 00:44:48 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	bpoirier@nvidia.com,
	cratiu@nvidia.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH 6.1.y 1/4] macsec: Enable devices to advertise whether they update sk_buff md_dst during offloads
Date: Mon, 29 Apr 2024 17:44:21 -0700
Message-ID: <20240430004439.299386-1-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR16CA0026.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::39) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DM6PR12MB4468:EE_
X-MS-Office365-Filtering-Correlation-Id: 18c1a9ce-109d-40e0-0318-08dc68aebcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?i2MGyZ6YF9JFturpcT3gd4LB0HPM71wFnMDtgNQUtophb+4SlcozzTzDm80F?=
 =?us-ascii?Q?Tz1HCJr1EFseZgPeJQcLYaVM/PrR4mwYwOXyTb427VZL4QlSRFVXszBuOvBo?=
 =?us-ascii?Q?2qPCAc95DC58QTAM3fM5yg8iWktLeVg7YnP16mmMdFa+IYpD7B1KLbdEsJZJ?=
 =?us-ascii?Q?01Q1rGyR41sE//OZZA8cb5tazu2HtoE9shYBKuvqpo3lQq9R1BE6jvP8K73L?=
 =?us-ascii?Q?FKd6joIm5adM/wFbLuuS0SgN072IUnCj1T3Mc5Tx25nUD7w2iTLpPGGt9HVT?=
 =?us-ascii?Q?bjJXnAbfpon1k9tfhnHnaB8FK1CWwjoKqZ7weAXQW8gvZzitWkJcSUelCWDN?=
 =?us-ascii?Q?wgl8lrFRALCQmS85BwvqGy0HTIp98+22V6ucZGOpvieIV/jFiLyFHqAI0ot+?=
 =?us-ascii?Q?xCiJWoJdz7OuYTYA8xlv3v/O6isjMPBVThMtYUwcQtg7PHHdJzmPuf13cZiG?=
 =?us-ascii?Q?NURb5oIiMiUtB0OY+hx7Cpj4ka/uqr7gdrBB6w0kgRWnxFY8b5zGP6Vt8bzC?=
 =?us-ascii?Q?pJIfew/HgOksEKhYc26mmCJ2rnosuhgNNlehua5VTHbCPA9N+yPgmk62rW1n?=
 =?us-ascii?Q?Bltj3nimSHEwiyZokPvucp8X2RhIYm1nwaY7gRf4Tfuaqedvdsl6BgFc5iK+?=
 =?us-ascii?Q?5FNKpNU+DF8+q8W13dGLb2zA5O1P+vFKTjMQ7RTIqcKqJaoD7gSxWaaUOgsG?=
 =?us-ascii?Q?DuvuiEJM2pqnyW+UkXkxJfo4dMCCyDLOOlfiEJmFoYC8sM9J95gX6rN6glR0?=
 =?us-ascii?Q?f00S8mCuuJEECbdI8tI+qeNJeBjySqHlSwc0mKLUl4jfmSglbcZ7BByLMDz+?=
 =?us-ascii?Q?orUu6lsFC/KoFBf+QlLGC0zcv1p+Oa9LV3ia5o2Jve0PcZrHJp1mCjA91Y4N?=
 =?us-ascii?Q?hNgmdnZpJXhPSIfNeg4AdoPZZWrwUwgu3pN2J15saBlDP7LD0+HDuUpUkzRJ?=
 =?us-ascii?Q?O94dTiOGL72Q4wR0LbMPGkuasbp9L9WtT7eHNZlyLIFyXmUs53iWTPyGW9pD?=
 =?us-ascii?Q?MX5XfWPO3CY5ZZ6USUB6L/JrLyOP7IpfWEAX0g5z7x3r00+n35Fb9sDZ4Ro1?=
 =?us-ascii?Q?FXViT0GhWMGErf0GoS/6uvX7v9XDpvuBI5wMmew0DGvpEyOHwtJTmqt7ub84?=
 =?us-ascii?Q?RgJ/y8OkqKVonFjMH2p4aP2xbqhlvg8Y/UmbwSRADrepR6EjpssBuoDmVdPR?=
 =?us-ascii?Q?LYC24tvovD/kj60L5HvxuyKi1+MLsFIGPlgNCYjnZakao3TBRFSafs05ZiWJ?=
 =?us-ascii?Q?SnhqjQN9W3aRe6QxY3BA08BB3vRG/m0+dF0edMKu+g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juEfk9epdWWYbRHe4tv0I6G0xoO7OLupp7whiuR8OWAqW1jgMhcaGECTcFqi?=
 =?us-ascii?Q?HO9aSJsfkLvzFm3oEu4QcSjEamZi0yA9l9NvTnnP2iiK8gev7w7sZwC4t6nI?=
 =?us-ascii?Q?wNaCNJBSqiL2rrlC53akPGjIymYpnD14GGAV1isI0tN8zLHNjTTQX3ZmB0Dw?=
 =?us-ascii?Q?90Jd2T4BmyN6vJFmJNhyw0uBp5AipTk6flJdhZHYnePpf3C2gR6zC4GTvTWb?=
 =?us-ascii?Q?bUW6cX4E5l1eDR7VDkbw7Ba19Ql0J5wRqZeubOdKK9g2m3lJH1P/A55EaYCW?=
 =?us-ascii?Q?+b5V864Pa3EIRR23ahQglaLkiC0C7brEeLKHHpxC3W4CJ3/CXPRGpML+DQlN?=
 =?us-ascii?Q?AhWH08ixbniFCHBHYBqfLnBn8rVnCc0kPbjDOK6L7UcxEYapTtULWSRPBs8q?=
 =?us-ascii?Q?xPEJ9QKUiLSuA4ZfJCFHLj1ZKaIm9IsdRt+I9I+RVaQEKzEpVGhuPoLRpk2f?=
 =?us-ascii?Q?6hrFEmyAZ5DVzp1pFMgsmV6507taGLnYO+ykZ0ovA/SeRvZPNWqjTZXUmkuZ?=
 =?us-ascii?Q?ZBnA12iZ0VDMqdW/BwUQV59VwhD9YAl3T+5V1AheJdSTe+EFnuF5Jj2rWiKS?=
 =?us-ascii?Q?+kdH9FjLkLo3uOiTjNeQpujwgnbFB4bQxDHFWa/QoUjhT5BBstpR/NkLvKiP?=
 =?us-ascii?Q?4j8cZ6iZSM6EoBEJ4fmP0nZXOuqzicUqcfoCeCRayY5dRhLRFAAAOOoALKMD?=
 =?us-ascii?Q?yCdA3hSU/9pZezSAGnis+ajcOxUh9hRAgxKTXYDqSazDGZM8pI1lpAh3Y7vj?=
 =?us-ascii?Q?rlPO6XRBM54odN/HbI9Zcw4jaVf7JTX3d6Vy+EhUNoC6F+r1FCTu2g/gl8jP?=
 =?us-ascii?Q?KFmSmBqvMnWd51oDicfFPu/2jg/Tcj/eq7ID1xEouXdMuoR/XV406WHS+JBb?=
 =?us-ascii?Q?wqPJhqyIpwkc4KKA+Sh9Yx7jcNhP37MMUhms4WH1cvUS6x5g+f8fkKiZBTKN?=
 =?us-ascii?Q?4bBqnzcgEOsjfiRjEYpKPbe3f3PDIRHjQtNJxZUEUdcDrbBtOdy7/zu1Srau?=
 =?us-ascii?Q?g84HAKenW/kEyy22ilvJnz7ieX+L0lgYIpcvaYw09oQhRj+W+jf1rRThd8Xy?=
 =?us-ascii?Q?FeP6kvQLu4jQBO70K2NFARJfxszaeMRh3HMOIu7d7eGkz7Dg9M2gymbDQtXk?=
 =?us-ascii?Q?hFY5ggiHdyuhsS1A6p6LG4baRJOJn6PC54iYsAINB3xGxUWyy8NHYnkd+ggw?=
 =?us-ascii?Q?g7CtZgrIuLbW7Ih0aqZgfRgxv2FPG8G00455Le1OD8S31eZQxPRV5zMTaXXY?=
 =?us-ascii?Q?bbGSra1671I8+g/4HzlG9qL3srLBODsWLClhkRRW1LR4mGj0AjLpiiOPtBwD?=
 =?us-ascii?Q?w/4J16sgiGBimRKD+1ZW7L2BSnKeaMHLTPxO+JEraEGmMGb+nlNevAQDIc9D?=
 =?us-ascii?Q?DY83ThbhlSoqiWwcWTdncDtrleoplhRzDxFkadkazy4WfN4fCqCOMkyq7EA/?=
 =?us-ascii?Q?g+mZQWi+XX+j4kl8NkTBPxLMnZHo4moczy2mEdUTEwh7ZxW4+25rx0UwIQyl?=
 =?us-ascii?Q?kvF8HbpCUSnCK08O1OlbCd3FaiCJACFmCAy9FODM4byMLKLWzw4OKCIV7i6x?=
 =?us-ascii?Q?D2bmez38lnNERX7rj59nSE6PyEsaK8j62G1j2MRr4iliAig7aN/EA6Z+Il0H?=
 =?us-ascii?Q?sg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18c1a9ce-109d-40e0-0318-08dc68aebcb1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 00:44:48.0098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nSMUPSyBrZJEAHY5qxw1/OqhbGTJjF4srAXw3fH7eTeEdpmvAuOnknWwPKbTuMLXsTiHDLhFN89A7zHnPXMJ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4468

commit 475747a19316b08e856c666a20503e73d7ed67ed upstream.

Omit rx_use_md_dst comment in upstream commit since macsec_ops is not
documented.

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
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/r/20240423181319.115860-2-rrameshbabu@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/net/macsec.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 65c93959c2dc..dd578d193f9a 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -302,6 +302,7 @@ struct macsec_ops {
 	int (*mdo_get_tx_sa_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sc_stats)(struct macsec_context *ctx);
 	int (*mdo_get_rx_sa_stats)(struct macsec_context *ctx);
+	bool rx_uses_md_dst;
 };
 
 void macsec_pn_wrapped(struct macsec_secy *secy, struct macsec_tx_sa *tx_sa);
-- 
2.42.0


