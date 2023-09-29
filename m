Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A7B7B2AD0
	for <lists+stable@lfdr.de>; Fri, 29 Sep 2023 05:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbjI2DvV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 28 Sep 2023 23:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjI2DvK (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 28 Sep 2023 23:51:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2106.outbound.protection.outlook.com [40.107.93.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78989CF9
        for <stable@vger.kernel.org>; Thu, 28 Sep 2023 20:50:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KxaAxSzcp5V/fQ+AqU66i6A0tB9cq7CLP+0KwMlv560WMWltj7ENoitNLQO2cZ/yDOjJ6cQgP2vBxAmnjyOPhtqvgyKsdKJ43BD8HLRyoxbWmmx+DK+bt9dXN6ILl7OatAtIA+adHTH1WQwI3tLKGXs8Cq+glMeZRL/xfzcM8LAhmb3joUOEsEtW7vspemHm5MLSoZKiFdhFD6CeZZqeO8ZvocMIa7P0a3JxQKgtBmdgRxy35jwB8pJUUni/FVmPOGMxvr7Xh0Ajyj9v3KvA4XtD0Qhe+CPKE3+fNf2g9iCLhArWXlxohB6rhjeD6tCYtyrg8wsXqNPLoaTLNfsQVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rU8/bMAgq8i81Ggafv3/0NK9aRGGpx0egcyhB2D1sQw=;
 b=E5FQwqSf9BIDVJZWTtFbt9L6XNSfp93jBPSbrOQz56zmIcBHSZoWY+f6yRNcLD86hNYEAlTtj4s7+gtC5TwW59QKWTm3FFHeemeQ/OKTljAPT4WbE77QeYB/oOiFGIUO26Nov28KrGq0TFAyEPodcohijoP4+tIl7iO0zESnVpDrnbDSKyQ9MssuzGUgObYn19eXNv2zS8AxIcIJyrm2jJiM+YysuwfwzuPjGBq/JfqLO+iKFFHDay9CCMAHlOJ8T0AfwG+8Ax3sS4sZT43mPRsTiyOXPwT1ULrPgzxZX5zSsr8g91zMxsK4GD29fjjKuByTQmNaPp45K97vbqq/Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rU8/bMAgq8i81Ggafv3/0NK9aRGGpx0egcyhB2D1sQw=;
 b=hyuzvjeO6rYn0q7A1YTM/QwbVskn8/1q2ShuaR/L+rqRXIpZcfFiUgAsK6meS7vSjUXLEdt2VtTep36h9vrnRt0tblsinnwIHWa3v10HMjTPAp7EIa0hBdUHvdX63oY9s7QGV6d1tLnhogoyTACAtIdFTZX2XL9Y0YJCdMebE94=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SA1PR01MB8131.prod.exchangelabs.com (2603:10b6:806:325::8) by
 DS0PR01MB8036.prod.exchangelabs.com (2603:10b6:8:14c::19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Fri, 29 Sep 2023 03:50:53 +0000
Received: from SA1PR01MB8131.prod.exchangelabs.com
 ([fe80::ad0:68f6:fb88:bf5a]) by SA1PR01MB8131.prod.exchangelabs.com
 ([fe80::ad0:68f6:fb88:bf5a%7]) with mapi id 15.20.6792.026; Fri, 29 Sep 2023
 03:50:53 +0000
From:   Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
To:     tamnguyenchi@os.amperecomputing.com
Cc:     stable@vger.kernel.org
Subject: [PATCH v1] i2c: designware: Disable TX_EMPTY irq while waiting for block length byte
Date:   Fri, 29 Sep 2023 10:49:39 +0700
Message-Id: <20230929034939.5724-1-tamnguyenchi@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0141.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::21) To SA1PR01MB8131.prod.exchangelabs.com
 (2603:10b6:806:325::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR01MB8131:EE_|DS0PR01MB8036:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d06e7e1-a905-4eb5-3514-08dbc09f3bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8M7Hnas3zMHVIcWhSxAz6vJfwKN0UwPkedC7xZ3X4pF0B4FWDKUf0gLOQp/sR9ee6jpQyeAKuGdc/zIla7tlsY7uU9YeYn0jrfzffV1oU5KrLgBDyeQbyp6T3Ks3GdfsR0Kz1RJoEANJtURXOJOUHPxmu0ZBMd6x5Javu7Rp0IVS3FEIH11Sm1Qyg1F2zV6yd+49/KZ5mBXGbqb5gOqmZ+3PTEZkXextmsPdHNt3jJY4BtOuPvLeT9Ii39oQ4/MCd/ysGH1/6M2lGmC1i92ss/IBIOzrsK8naKIUngztrpULzfRZDmPaGBgq9mcZfXSQNW8UCbMKsEr9ySctSG/L854M2ExXQlLq8r3TIz5+vPARK6V8EgKaUs/GL8m6mcJg1j/HasgBVhQgHn3SKXBjrcZYI46lK6mFmy/Nf1FLMWqjKtema6zTlCSFFmAWZ7OFcSrytF3ETzAlwloDZBImFwzjFKZUPD59QRusbO8dlEzHW28UFWA0H/11CHJX50t7/V5uf7ynlP6sn9AV+f9QixEKcjP67NkQdAFP9TCKGCQpjiuhG3EZ8Hnu+iK0lGWf657jJkkAxo0cDemMT9cy7ExxcXLh3tylrVZOiynppx3oKCwCNk0zFdtAIyX355c
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR01MB8131.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39850400004)(376002)(136003)(346002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(2616005)(34206002)(6486002)(66556008)(52116002)(6666004)(6506007)(1076003)(37006003)(66476007)(66946007)(6512007)(316002)(8936002)(86362001)(41300700001)(83380400001)(26005)(8676002)(4326008)(478600001)(5660300002)(2906002)(38100700002)(38350700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kerb4j5Kdb99R1GE/uPiDRxw9Xtdc+tFT9TlYZLzRsEL8B5LI3mJdAHlPbUy?=
 =?us-ascii?Q?L96k2KNoKB2ZY6euGpxm9eWiRj5Fq3/JzYy9+8nYNpGDV8cDsrWCykzXrLJX?=
 =?us-ascii?Q?8BxEIk04LVZbGWzjChhxNqiN+FgIQFBazcLwxcVc6TYRtZDdAiA1MtwGEaIW?=
 =?us-ascii?Q?GuJu5tnKBWHzxVBxyivv/L+3h/yMGeBT4c/0nYk+Dnib1LnqN6VXB1GPY7v0?=
 =?us-ascii?Q?H82cQTzpepp9gfvbsrJVORKyQw0EtBwb3tPVm1MJhgkLX39169FCG78Ruj/b?=
 =?us-ascii?Q?0tH90w6OPtuHifelMGfsUSnOkJmfW/9/r61jnoQaGUXoLepzQy9C9Kf7dsz/?=
 =?us-ascii?Q?tt1W30psL6zAnf4uJt8Jw/O6YJdXszO2pf6nMOpN5aVTHG+MSGGyG8TgHxeu?=
 =?us-ascii?Q?REtFmN3BzSGrb+4dIcVRc03u7mxwYR5/hME75t47QItC86Ww7NApnRls18ox?=
 =?us-ascii?Q?ej8uKSLjCWsgy+9STF6+p/5a6r7jurhiZdGx5gC5Ik/LsBw5R9CNoB4/wbBq?=
 =?us-ascii?Q?mvWI9D1THOWStmdDIfWJgs/QkAL6BJv/Ve5dYJlLRylxVUsbiUqCtULWNKpP?=
 =?us-ascii?Q?xIjLvRP5ScrM8dibAezqsMbiXYAcQdT9SXFKSoCee9uSplWeo5S/y/EJ1FLf?=
 =?us-ascii?Q?6TaTZr0Sz0hZt2cHYBtEt0M93ljYH3H90622qie0UN/sulM6SW/X6PMPmUtr?=
 =?us-ascii?Q?CbUxfFk74UOKsXQt82EyXxqRbKLddlQg+K0uAyXlg/xtTxXU33Wq2bMKqN2F?=
 =?us-ascii?Q?lKybTKEiYPflA85GaM2oFu9yG2GBew2JoKzVK2CpVfYNdgqPreUt9dqCZB+o?=
 =?us-ascii?Q?2/JawtBImQVvhwSp54qMbQgCH5wVIwv7lTyqALRbwtyYIZTZloA/RhYzsgm8?=
 =?us-ascii?Q?wm2U9pPklxVazIy8X8g+OkNpuD4rCOTtsxnqq6ARhEfo4B31rlFd5zk9cM4c?=
 =?us-ascii?Q?yqZMAEBtTCFwML3cR1VK+VQZOMVxPjFxBJ/fBuu2LCkaTeGW2WpYBnDEuuLv?=
 =?us-ascii?Q?U9696lGfBHFniVHl30D+MvbK/c7eNlCspkIANeqqawdblrfKH9YEHfGFs9uA?=
 =?us-ascii?Q?V79BUqmtlO4DykwnpnfxlgOVb/t6iomXSwlI7ndqDVGEqR+4x7k6oaNqW0W0?=
 =?us-ascii?Q?/TjYjhSpFV3Pj6lfCS2obMpLK4M0mxqtdGorDCk4hIEEjJMPb9K5JuueOCCD?=
 =?us-ascii?Q?KQJUhE0cswiDWkR7QJPiB4eGpwZNlJt1QJBgQxUsri1uixhaRw3uYcz5DQFl?=
 =?us-ascii?Q?x132nNdYizTlm19WDTc9C1hHoKN47dp8RgZ3lCcWHMPLjlsVzjGycPOxhz7i?=
 =?us-ascii?Q?jrebUfR69QPqfJORx/9VqsJcxn0ajBe/NR8CSF+hhtb+8EhzHUnqsfdmBEVa?=
 =?us-ascii?Q?JcONNCrM+xvJxwQX8Tx7fjLyZmQrmIK6SFgbqptTqkUPFU+HlfTHo6uEl+kV?=
 =?us-ascii?Q?4v+8JOwQH3vuqhKLtkaEZi9v6HpjoTcN7nrHVbCAC6FDXifiyRXWgbDeAFhz?=
 =?us-ascii?Q?2el/QnDr+FcF34/BX8sAlipJiYgsV8uJ+4WCdYS1FyNdIS6/l5tMNML9MvW8?=
 =?us-ascii?Q?l5k8J7h0Eez++FW1ohB0QjWRV+rtxsLmKW9ZKBu2RYJhHG/JfUMPBSwpleXs?=
 =?us-ascii?Q?jZ/y/VwD8HUKgbr6N0TGq7Iea2A9qCX9OnOQ6l5pOWBj?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d06e7e1-a905-4eb5-3514-08dbc09f3bf8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR01MB8131.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 03:50:34.4388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYDSdCYCLc0sHHEfcruZSdPK8SZHzs5WfD0ZkEBSaHWQUoP32jP71OgzfgABciGi5c6Ui1xIbOjzInj6tVrXZ2Yl+MEVrHYTIj6kOWzGcG/1tD6hr7/dcmV5KIhaXujS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR01MB8036
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

During SMBus block data read process, we have seen high interrupt rate
because of TX_EMPTY irq status while waiting for block length byte (the
first data byte after the address phase). The interrupt handler does not
do anything because the internal state is kept as STATUS_WRITE_IN_PROGRESS.
Hence, we should disable TX_EMPTY irq until I2C DW receives first data
byte from I2C device, then re-enable it.

It takes 0.789 ms for host to receive data length from slave.
Without the patch, i2c_dw_isr is called 99 times by TX_EMPTY interrupt.
And it is none after applying the patch.

Cc: stable@vger.kernel.org
Signed-off-by: Chuong Tran <chuong@os.amperecomputing.com>
Signed-off-by: Tam Nguyen <tamnguyenchi@os.amperecomputing.com>
---
 drivers/i2c/busses/i2c-designware-master.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/i2c/busses/i2c-designware-master.c b/drivers/i2c/busses/i2c-designware-master.c
index 55ea91a63382..2152b1f9b27c 100644
--- a/drivers/i2c/busses/i2c-designware-master.c
+++ b/drivers/i2c/busses/i2c-designware-master.c
@@ -462,6 +462,13 @@ i2c_dw_xfer_msg(struct dw_i2c_dev *dev)
 		if (buf_len > 0 || flags & I2C_M_RECV_LEN) {
 			/* more bytes to be written */
 			dev->status |= STATUS_WRITE_IN_PROGRESS;
+			/*
+			 * In I2C_FUNC_SMBUS_BLOCK_DATA case, there is no data
+			 * to send before receiving data length from slave.
+			 * Disable TX_EMPTY while waiting for data length byte
+			 */
+			if (flags & I2C_M_RECV_LEN)
+				intr_mask &= ~DW_IC_INTR_TX_EMPTY;
 			break;
 		} else
 			dev->status &= ~STATUS_WRITE_IN_PROGRESS;
@@ -485,6 +492,7 @@ i2c_dw_recv_len(struct dw_i2c_dev *dev, u8 len)
 {
 	struct i2c_msg *msgs = dev->msgs;
 	u32 flags = msgs[dev->msg_read_idx].flags;
+	u32 intr_mask;
 
 	/*
 	 * Adjust the buffer length and mask the flag
@@ -495,6 +503,11 @@ i2c_dw_recv_len(struct dw_i2c_dev *dev, u8 len)
 	msgs[dev->msg_read_idx].len = len;
 	msgs[dev->msg_read_idx].flags &= ~I2C_M_RECV_LEN;
 
+	/* Re-enable TX_EMPTY interrupt. */
+	regmap_read(dev->map, DW_IC_INTR_MASK, &intr_mask);
+	intr_mask |= DW_IC_INTR_TX_EMPTY;
+	regmap_write(dev->map, DW_IC_INTR_MASK, intr_mask);
+
 	return len;
 }
 
-- 
2.25.1

