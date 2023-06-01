Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D9F71938D
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 08:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231191AbjFAGuR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 02:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFAGuP (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 02:50:15 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20631.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC69E2
        for <stable@vger.kernel.org>; Wed, 31 May 2023 23:50:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVIpbIjf6hxHSf+SwNCR4wMsLLTD3Eh26wTHjHQyhEE9rmdlclWtf/xQMKnI4DNtiMCjHwuXlD32IfKNUcVMEaSCQbiwv+XJHUPCCPF57QtH/x70rBZ8Gb2ArI/Bx6J4JIKw2BVLz9jQpHlEkvL2D7wDUum8JwjfVynwaR5i81uZ3tjuSozqLex9Qlq/kp7wiAx9niUmpP/K4d+GDIbGV58hk/oAHoeAW15G8N7Q9i8TcA3ADkwcGsSMreUe5F9EQ1tUlQG+inl+zsTbQi7aj1RGrrxnh/WbdrFlYpuY4tiyK48sFgPDLhBlRWoCLF07bHUi21bFVt6L+Al6CIgEJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4A+1iOFbc2vfZyIBylteXMe7vBiB4+xGALOKkvMuLog=;
 b=T0beQjKwnmN3c7tKTFlAx859rORIsvPxHsEihK6Ove87nzbfUDsSl9+uqVgamjSBpRYWowZamMJ7yPGnl5GHTNbOmt/40Udc4duQgADYxTspE6tbgDug3UEWStNuTkeKzPj0AQ/4GmgLefeTVAzaRR9Prk29k8y7vp0niTZETup003DVvK7at/Ui5qx/Y4HpkFJt6izUms+GYMRdK9solru48b8rnxm0qbPP5BeDX0XahZTPH5nWfJdIp7nCni4zzou+ErMitTdys9CwhqprL/0X5MTMcpupg6rZCKt1lgWJr0aTnFWhUFiJJqvijida+P9gKts/GXEbbaIis6sASA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4A+1iOFbc2vfZyIBylteXMe7vBiB4+xGALOKkvMuLog=;
 b=lqF9Erko6KL0p8FFUNfWZCAIeb97LNRZKycceFBrurojvQ9VP+4s7WiKeTxdgb5ISsv5ODnK4Bcpq5Q54rKCz5xUpsFyoClrBBEumZt+B3JSL98ZIeqbFCz8G/3WZv29jagn0x+C9kNG16H3wlU3KrjJBIlvTbwUCBbmE8Dh0KwQY3qdsyQ4ENuMY2mlFBlfrEI/IHJiHwYsrlUPR/47U+2u+GYeaA9h+EbSvg9VyXKk7+VZukZZAUYV7KsuoOfwCMNZDQc/kEZgZwFwU8xq4ie9fbiLo6nJj7PXVQOW3SeWKMbHOCxZU44EqFJsODVr+NpnpW8TTIWqxgkC9f5D+Q==
Received: from BN9PR03CA0180.namprd03.prod.outlook.com (2603:10b6:408:f4::35)
 by IA1PR12MB8285.namprd12.prod.outlook.com (2603:10b6:208:3f6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 06:49:07 +0000
Received: from BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::f0) by BN9PR03CA0180.outlook.office365.com
 (2603:10b6:408:f4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 06:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN8NAM11FT029.mail.protection.outlook.com (10.13.177.68) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 06:49:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Wed, 31 May 2023
 23:48:43 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Wed, 31 May 2023 23:48:40 -0700
From:   Ido Schimmel <idosch@nvidia.com>
To:     <stable@vger.kernel.org>
CC:     <daniel.lezcano@linaro.org>, <vadimp@nvidia.com>,
        <sashal@kernel.org>, <petrm@nvidia.com>, <davem@davemloft.net>,
        <joe@atomic.ac>, <gregkh@linuxfoundation.org>,
        Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH stable 6.1] Revert "thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function"
Date:   Thu, 1 Jun 2023 09:48:03 +0300
Message-ID: <20230601064803.1063014-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT029:EE_|IA1PR12MB8285:EE_
X-MS-Office365-Filtering-Correlation-Id: b73396e9-9ce7-4871-484b-08db626c4c39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vSEYdHqYWcAr4VhoJKNMKwDq0gkhCMOsUE7dr3gWF/ndT7kVq/X9Qy1pfqz5IP07ZATKpdNd9yu7TofKYHRHbzy+0xipX22p2f4lwVWGEdv3jcGk71gEVQ4/U/Mq093TNdIuVMwfwGYMGrHQDlgUnw/dflmBI5lv27hhlC/cyjGdz8pYN4lTFBC+ZC7FH7aEsaWfA/etCjbj8lT608TGvmR10q1ahjrmCZbC223gEPFuHYVUyRXBCtcqOyXmjehOpZtlx62rBW60GzMGWvRH7w1LYweH+qNrxNyyLHbH9kaGK/WKk+PZy+SX4Gn+U/CZS9Egc5nH0mwjgUGN7rO+u3nlI/O4bcYEYFyfEYcDhlMlpwUgfdDcN+VDvzojzg5LXNjuNAP/rkU1y7NvT/LRo2AspiPQWBG2CbdRba4f1z67j/YT852SbKzwr6wmpnagwxNiCd6rnjnXsnoQXIO3T3WhnoQa1RalsW8KayTlv+GgoK2a9iBcraqDZk9D52vRvZ4GhEcVGLG606CVOuJ4s7+axNevY5GZBh8S4pBEjy1OBBisASmhCuu6VeP7ucV3H09h7Y3zdWNih9im0MbT/n2zxtLiPLgPVNGyzwAOaLmB7yUFa/BteTHatXlHPmtWMCxzQtDwySiz9au7qbzzgnonwNZeR7Az8bCzzWY1ZQETcRq3gIL0xtQAGvDhG3GlRiqB9yjdkYeEsBxse2B/vf2CEvrgR/MiB8pfcR1U0oBidmC9EbYZgs1jO2tRcSpfmsVwviejbMD/4RKI1WNk8g==
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199021)(36840700001)(40470700004)(46966006)(40460700003)(336012)(8676002)(426003)(83380400001)(47076005)(2616005)(186003)(16526019)(6666004)(36860700001)(2906002)(6916009)(4326008)(70206006)(316002)(30864003)(70586007)(54906003)(478600001)(26005)(1076003)(5660300002)(107886003)(41300700001)(8936002)(7636003)(356005)(82740400003)(36756003)(82310400005)(86362001)(40480700001)(41533002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 06:49:07.5838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b73396e9-9ce7-4871-484b-08db626c4c39
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8285
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This reverts commit a71f388045edbf6788a61f43e2cdc94b392a4ea3.

Commit a71f388045ed ("thermal/drivers/mellanox: Use generic
thermal_zone_get_trip() function") was backported as a dependency of the
fix in upstream commit 6d206b1ea9f4 ("mlxsw: core_thermal: Fix fan speed
in maximum cooling state"). However, it is dependent on changes in the
thermal core that were merged in v6.3. Without them, the mlxsw driver is
unable to register its thermal zone:

mlxsw_spectrum 0000:03:00.0: Failed to register thermal zone
mlxsw_spectrum 0000:03:00.0: cannot register bus device
mlxsw_spectrum: probe of 0000:03:00.0 failed with error -22

Fix this by reverting this commit and instead fix the small conflict
with the above mentioned fix. Tested using the test case mentioned in
the change log of the fix:

 # cat /sys/class/thermal/thermal_zone2/cdev0/type
 mlxsw_fan
 # echo 10 > /sys/class/thermal/thermal_zone2/cdev0/cur_state
 # cat /sys/class/hwmon/hwmon1/name
 mlxsw
 # cat /sys/class/hwmon/hwmon1/pwm1
 255

After setting the fan to its maximum cooling state (10), it operates at
100% duty cycle instead of being stuck at 0 RPM.

Fixes: a71f388045ed ("thermal/drivers/mellanox: Use generic thermal_zone_get_trip() function")
Reported-by: Joe Botha <joe@atomic.ac>
Tested-by: Joe Botha <joe@atomic.ac>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
I read the stable rules, but it is not clear to me which "upstream
commit ID" to specify in this case given I am reverting a commit that
was mistakenly backported to stable.
---
 .../ethernet/mellanox/mlxsw/core_thermal.c    | 209 ++++++++++++++----
 1 file changed, 161 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 09ed6e5fa6c3..ef5e61708df3 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -36,39 +36,33 @@ enum mlxsw_thermal_trips {
 	MLXSW_THERMAL_TEMP_TRIP_HOT,
 };
 
-struct mlxsw_cooling_states {
+struct mlxsw_thermal_trip {
+	int	type;
+	int	temp;
+	int	hyst;
 	int	min_state;
 	int	max_state;
 };
 
-static const struct thermal_trip default_thermal_trips[] = {
+static const struct mlxsw_thermal_trip default_thermal_trips[] = {
 	{	/* In range - 0-40% PWM */
 		.type		= THERMAL_TRIP_ACTIVE,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_NORM,
-		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
-	},
-	{
-		/* In range - 40-100% PWM */
-		.type		= THERMAL_TRIP_ACTIVE,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HIGH,
-		.hysteresis	= MLXSW_THERMAL_HYSTERESIS_TEMP,
-	},
-	{	/* Warning */
-		.type		= THERMAL_TRIP_HOT,
-		.temperature	= MLXSW_THERMAL_ASIC_TEMP_HOT,
-	},
-};
-
-static const struct mlxsw_cooling_states default_cooling_states[] = {
-	{
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_NORM,
+		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
 		.min_state	= 0,
 		.max_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
 	},
 	{
+		/* In range - 40-100% PWM */
+		.type		= THERMAL_TRIP_ACTIVE,
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_HIGH,
+		.hyst		= MLXSW_THERMAL_HYSTERESIS_TEMP,
 		.min_state	= (4 * MLXSW_THERMAL_MAX_STATE) / 10,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
-	{
+	{	/* Warning */
+		.type		= THERMAL_TRIP_HOT,
+		.temp		= MLXSW_THERMAL_ASIC_TEMP_HOT,
 		.min_state	= MLXSW_THERMAL_MAX_STATE,
 		.max_state	= MLXSW_THERMAL_MAX_STATE,
 	},
@@ -84,8 +78,7 @@ struct mlxsw_thermal;
 struct mlxsw_thermal_module {
 	struct mlxsw_thermal *parent;
 	struct thermal_zone_device *tzdev;
-	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	int module; /* Module or gearbox number */
 	u8 slot_index;
 };
@@ -105,8 +98,7 @@ struct mlxsw_thermal {
 	struct thermal_zone_device *tzdev;
 	int polling_delay;
 	struct thermal_cooling_device *cdevs[MLXSW_MFCR_PWMS_MAX];
-	struct thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
-	struct mlxsw_cooling_states cooling_states[MLXSW_THERMAL_NUM_TRIPS];
+	struct mlxsw_thermal_trip trips[MLXSW_THERMAL_NUM_TRIPS];
 	struct mlxsw_thermal_area line_cards[];
 };
 
@@ -143,9 +135,9 @@ static int mlxsw_get_cooling_device_idx(struct mlxsw_thermal *thermal,
 static void
 mlxsw_thermal_module_trips_reset(struct mlxsw_thermal_module *tz)
 {
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = 0;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = 0;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = 0;
 }
 
 static int
@@ -187,12 +179,12 @@ mlxsw_thermal_module_trips_update(struct device *dev, struct mlxsw_core *core,
 	 * by subtracting double hysteresis value.
 	 */
 	if (crit_temp >= MLXSW_THERMAL_MODULE_TEMP_SHIFT)
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp -
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp -
 					MLXSW_THERMAL_MODULE_TEMP_SHIFT;
 	else
-		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temperature = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temperature = crit_temp;
-	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temperature = emerg_temp;
+		tz->trips[MLXSW_THERMAL_TEMP_TRIP_NORM].temp = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HIGH].temp = crit_temp;
+	tz->trips[MLXSW_THERMAL_TEMP_TRIP_HOT].temp = emerg_temp;
 
 	return 0;
 }
@@ -209,11 +201,11 @@ static int mlxsw_thermal_bind(struct thermal_zone_device *tzdev,
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &thermal->cooling_states[i];
+		const struct mlxsw_thermal_trip *trip = &thermal->trips[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
+						       trip->max_state,
+						       trip->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0) {
 			dev_err(dev, "Failed to bind cooling device to trip %d\n", i);
@@ -267,6 +259,61 @@ static int mlxsw_thermal_get_temp(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
+static int mlxsw_thermal_get_trip_type(struct thermal_zone_device *tzdev,
+				       int trip,
+				       enum thermal_trip_type *p_type)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_type = thermal->trips[trip].type;
+	return 0;
+}
+
+static int mlxsw_thermal_get_trip_temp(struct thermal_zone_device *tzdev,
+				       int trip, int *p_temp)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_temp = thermal->trips[trip].temp;
+	return 0;
+}
+
+static int mlxsw_thermal_set_trip_temp(struct thermal_zone_device *tzdev,
+				       int trip, int temp)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	thermal->trips[trip].temp = temp;
+	return 0;
+}
+
+static int mlxsw_thermal_get_trip_hyst(struct thermal_zone_device *tzdev,
+				       int trip, int *p_hyst)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	*p_hyst = thermal->trips[trip].hyst;
+	return 0;
+}
+
+static int mlxsw_thermal_set_trip_hyst(struct thermal_zone_device *tzdev,
+				       int trip, int hyst)
+{
+	struct mlxsw_thermal *thermal = tzdev->devdata;
+
+	thermal->trips[trip].hyst = hyst;
+	return 0;
+}
+
 static struct thermal_zone_params mlxsw_thermal_params = {
 	.no_hwmon = true,
 };
@@ -275,6 +322,11 @@ static struct thermal_zone_device_ops mlxsw_thermal_ops = {
 	.bind = mlxsw_thermal_bind,
 	.unbind = mlxsw_thermal_unbind,
 	.get_temp = mlxsw_thermal_get_temp,
+	.get_trip_type	= mlxsw_thermal_get_trip_type,
+	.get_trip_temp	= mlxsw_thermal_get_trip_temp,
+	.set_trip_temp	= mlxsw_thermal_set_trip_temp,
+	.get_trip_hyst	= mlxsw_thermal_get_trip_hyst,
+	.set_trip_hyst	= mlxsw_thermal_set_trip_hyst,
 };
 
 static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
@@ -289,11 +341,11 @@ static int mlxsw_thermal_module_bind(struct thermal_zone_device *tzdev,
 		return 0;
 
 	for (i = 0; i < MLXSW_THERMAL_NUM_TRIPS; i++) {
-		const struct mlxsw_cooling_states *state = &tz->cooling_states[i];
+		const struct mlxsw_thermal_trip *trip = &tz->trips[i];
 
 		err = thermal_zone_bind_cooling_device(tzdev, i, cdev,
-						       state->max_state,
-						       state->min_state,
+						       trip->max_state,
+						       trip->min_state,
 						       THERMAL_WEIGHT_DEFAULT);
 		if (err < 0)
 			goto err_thermal_zone_bind_cooling_device;
@@ -381,10 +433,74 @@ static int mlxsw_thermal_module_temp_get(struct thermal_zone_device *tzdev,
 	return 0;
 }
 
+static int
+mlxsw_thermal_module_trip_type_get(struct thermal_zone_device *tzdev, int trip,
+				   enum thermal_trip_type *p_type)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_type = tz->trips[trip].type;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_temp_get(struct thermal_zone_device *tzdev,
+				   int trip, int *p_temp)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	*p_temp = tz->trips[trip].temp;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_temp_set(struct thermal_zone_device *tzdev,
+				   int trip, int temp)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	if (trip < 0 || trip >= MLXSW_THERMAL_NUM_TRIPS)
+		return -EINVAL;
+
+	tz->trips[trip].temp = temp;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_hyst_get(struct thermal_zone_device *tzdev, int trip,
+				   int *p_hyst)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	*p_hyst = tz->trips[trip].hyst;
+	return 0;
+}
+
+static int
+mlxsw_thermal_module_trip_hyst_set(struct thermal_zone_device *tzdev, int trip,
+				   int hyst)
+{
+	struct mlxsw_thermal_module *tz = tzdev->devdata;
+
+	tz->trips[trip].hyst = hyst;
+	return 0;
+}
+
 static struct thermal_zone_device_ops mlxsw_thermal_module_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_module_temp_get,
+	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
+	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
+	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
+	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
+	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_gearbox_temp_get(struct thermal_zone_device *tzdev,
@@ -414,6 +530,11 @@ static struct thermal_zone_device_ops mlxsw_thermal_gearbox_ops = {
 	.bind		= mlxsw_thermal_module_bind,
 	.unbind		= mlxsw_thermal_module_unbind,
 	.get_temp	= mlxsw_thermal_gearbox_temp_get,
+	.get_trip_type	= mlxsw_thermal_module_trip_type_get,
+	.get_trip_temp	= mlxsw_thermal_module_trip_temp_get,
+	.set_trip_temp	= mlxsw_thermal_module_trip_temp_set,
+	.get_trip_hyst	= mlxsw_thermal_module_trip_hyst_get,
+	.set_trip_hyst	= mlxsw_thermal_module_trip_hyst_set,
 };
 
 static int mlxsw_thermal_get_max_state(struct thermal_cooling_device *cdev,
@@ -495,8 +616,7 @@ mlxsw_thermal_module_tz_init(struct mlxsw_thermal_module *module_tz)
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-module%d",
 			 module_tz->module + 1);
-	module_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-							module_tz->trips,
+	module_tz->tzdev = thermal_zone_device_register(tz_name,
 							MLXSW_THERMAL_NUM_TRIPS,
 							MLXSW_THERMAL_TRIP_MASK,
 							module_tz,
@@ -540,8 +660,6 @@ mlxsw_thermal_module_init(struct device *dev, struct mlxsw_core *core,
 	module_tz->parent = thermal;
 	memcpy(module_tz->trips, default_thermal_trips,
 	       sizeof(thermal->trips));
-	memcpy(module_tz->cooling_states, default_cooling_states,
-	       sizeof(thermal->cooling_states));
 	/* Initialize all trip point. */
 	mlxsw_thermal_module_trips_reset(module_tz);
 	/* Read module temperature and thresholds. */
@@ -637,8 +755,7 @@ mlxsw_thermal_gearbox_tz_init(struct mlxsw_thermal_module *gearbox_tz)
 	else
 		snprintf(tz_name, sizeof(tz_name), "mlxsw-gearbox%d",
 			 gearbox_tz->module + 1);
-	gearbox_tz->tzdev = thermal_zone_device_register_with_trips(tz_name,
-						gearbox_tz->trips,
+	gearbox_tz->tzdev = thermal_zone_device_register(tz_name,
 						MLXSW_THERMAL_NUM_TRIPS,
 						MLXSW_THERMAL_TRIP_MASK,
 						gearbox_tz,
@@ -695,8 +812,6 @@ mlxsw_thermal_gearboxes_init(struct device *dev, struct mlxsw_core *core,
 		gearbox_tz = &area->tz_gearbox_arr[i];
 		memcpy(gearbox_tz->trips, default_thermal_trips,
 		       sizeof(thermal->trips));
-		memcpy(gearbox_tz->cooling_states, default_cooling_states,
-		       sizeof(thermal->cooling_states));
 		gearbox_tz->module = i;
 		gearbox_tz->parent = thermal;
 		gearbox_tz->slot_index = area->slot_index;
@@ -812,7 +927,6 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 	thermal->core = core;
 	thermal->bus_info = bus_info;
 	memcpy(thermal->trips, default_thermal_trips, sizeof(thermal->trips));
-	memcpy(thermal->cooling_states, default_cooling_states, sizeof(thermal->cooling_states));
 	thermal->line_cards[0].slot_index = 0;
 
 	err = mlxsw_reg_query(thermal->core, MLXSW_REG(mfcr), mfcr_pl);
@@ -862,8 +976,7 @@ int mlxsw_thermal_init(struct mlxsw_core *core,
 				 MLXSW_THERMAL_SLOW_POLL_INT :
 				 MLXSW_THERMAL_POLL_INT;
 
-	thermal->tzdev = thermal_zone_device_register_with_trips("mlxsw",
-						      thermal->trips,
+	thermal->tzdev = thermal_zone_device_register("mlxsw",
 						      MLXSW_THERMAL_NUM_TRIPS,
 						      MLXSW_THERMAL_TRIP_MASK,
 						      thermal,
-- 
2.40.1

