Return-Path: <stable+bounces-119271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 772AEA42535
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 16:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5397B444304
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEBC18A95E;
	Mon, 24 Feb 2025 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RQB/e69O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8652A8D0;
	Mon, 24 Feb 2025 14:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408898; cv=none; b=tQzr5Zwh4HBcNJMwjbj/11HEtzCxXQ1yKcfeTY45UZcOGMeZFYlCGNCQG+c2lhuEkOcMURK8ftoiJM+yOTusEaOsgASPrP8XZdT95cSlKOAzVlwfSDEToV0h0HQSRtewcKO9ovKYcgJ5ZEYaC9Uqzwjmha/RaWrMjIcaE2heNlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408898; c=relaxed/simple;
	bh=/AH2iGRJhziTIYimU7NF2RJ0sqhK3xaGqrUQhBsHi/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XJK882PORoZJjwlQwNHRL+gwagUwjK+S6hcSqjfHeXbxxtIE8kVHB5CW1/d3JrmRvR91i1T5mGEJhqigIdF6ugqr+yK8MLR/BSd7D4BN3BPjw8mU0784jrdbqUeI4lR2dJvPs9ryRsZcztLcw2q6sQllEEvwcGZnEG9+9KuVmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RQB/e69O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6AAC4CED6;
	Mon, 24 Feb 2025 14:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740408896;
	bh=/AH2iGRJhziTIYimU7NF2RJ0sqhK3xaGqrUQhBsHi/A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RQB/e69OfjEhUKppZ24I3pbaPkszdV9YMM+nq+MR9wE0jfYtcSXeNa7CDVQS8WFDl
	 iDaiBjdJ3nqkcs7HLysVbwggpgTUGJ4rNgjU8rZzKtfj6rzN0EWkZ/IkjYmSNHmHne
	 jk6/v/kaEyj39wIP84DTuLq234bOtQBy09ucBoDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.13 038/138] net: pse-pd: Use power limit at driver side instead of current limit
Date: Mon, 24 Feb 2025 15:34:28 +0100
Message-ID: <20250224142605.964401615@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224142604.442289573@linuxfoundation.org>
References: <20250224142604.442289573@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.13-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kory Maincent <kory.maincent@bootlin.com>

[ Upstream commit e0a5e2bba38aa61a900934b45d6e846e0a6d7524 ]

The regulator framework uses current limits, but the PSE standard and
known PSE controllers rely on power limits. Instead of converting
current to power within each driver, perform the conversion in the PSE
core. This avoids redundancy in driver implementation and aligns better
with the standard, simplifying driver development.

Remove at the same time the _pse_ethtool_get_status() function which is
not needed anymore.

Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: f6093c5ec74d ("net: pse-pd: pd692x0: Fix power limit retrieval")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/pse-pd/pd692x0.c  | 45 ++++-------------
 drivers/net/pse-pd/pse_core.c | 91 ++++++++++++++++-------------------
 include/linux/pse-pd/pse.h    | 16 +++---
 3 files changed, 57 insertions(+), 95 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 0af7db80b2f88..9f00538f7e450 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -999,13 +999,12 @@ static int pd692x0_pi_get_voltage(struct pse_controller_dev *pcdev, int id)
 	return (buf.sub[0] << 8 | buf.sub[1]) * 100000;
 }
 
-static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
-					int id)
+static int pd692x0_pi_get_pw_limit(struct pse_controller_dev *pcdev,
+				   int id)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_msg msg, buf = {0};
-	int mW, uV, uA, ret;
-	s64 tmp_64;
+	int ret;
 
 	msg = pd692x0_msg_template_list[PD692X0_MSG_GET_PORT_PARAM];
 	msg.sub[2] = id;
@@ -1013,48 +1012,24 @@ static int pd692x0_pi_get_current_limit(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 
-	ret = pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
-	if (ret < 0)
-		return ret;
-	mW = ret;
-
-	ret = pd692x0_pi_get_voltage(pcdev, id);
-	if (ret < 0)
-		return ret;
-	uV = ret;
-
-	tmp_64 = mW;
-	tmp_64 *= 1000000000ull;
-	/* uA = mW * 1000000000 / uV */
-	uA = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
-	return uA;
+	return pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
 }
 
-static int pd692x0_pi_set_current_limit(struct pse_controller_dev *pcdev,
-					int id, int max_uA)
+static int pd692x0_pi_set_pw_limit(struct pse_controller_dev *pcdev,
+				   int id, int max_mW)
 {
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct device *dev = &priv->client->dev;
 	struct pd692x0_msg msg, buf = {0};
-	int uV, ret, mW;
-	s64 tmp_64;
+	int ret;
 
 	ret = pd692x0_fw_unavailable(priv);
 	if (ret)
 		return ret;
 
-	ret = pd692x0_pi_get_voltage(pcdev, id);
-	if (ret < 0)
-		return ret;
-	uV = ret;
-
 	msg = pd692x0_msg_template_list[PD692X0_MSG_SET_PORT_PARAM];
 	msg.sub[2] = id;
-	tmp_64 = uV;
-	tmp_64 *= max_uA;
-	/* mW = uV * uA / 1000000000 */
-	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
-	ret = pd692x0_pi_set_pw_from_table(dev, &msg, mW);
+	ret = pd692x0_pi_set_pw_from_table(dev, &msg, max_mW);
 	if (ret)
 		return ret;
 
@@ -1068,8 +1043,8 @@ static const struct pse_controller_ops pd692x0_ops = {
 	.pi_disable = pd692x0_pi_disable,
 	.pi_is_enabled = pd692x0_pi_is_enabled,
 	.pi_get_voltage = pd692x0_pi_get_voltage,
-	.pi_get_current_limit = pd692x0_pi_get_current_limit,
-	.pi_set_current_limit = pd692x0_pi_set_current_limit,
+	.pi_get_pw_limit = pd692x0_pi_get_pw_limit,
+	.pi_set_pw_limit = pd692x0_pi_set_pw_limit,
 };
 
 #define PD692X0_FW_LINE_MAX_SZ 0xff
diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 9fee4dd53515a..4c5abef9e94ee 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -291,33 +291,25 @@ static int pse_pi_get_voltage(struct regulator_dev *rdev)
 	return ret;
 }
 
-static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
-				   int id,
-				   struct netlink_ext_ack *extack,
-				   struct pse_control_status *status);
-
 static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	struct netlink_ext_ack extack = {};
-	struct pse_control_status st = {};
-	int id, uV, ret;
+	int id, uV, mW, ret;
 	s64 tmp_64;
 
 	ops = pcdev->ops;
 	id = rdev_get_id(rdev);
+	if (!ops->pi_get_pw_limit || !ops->pi_get_voltage)
+		return -EOPNOTSUPP;
+
 	mutex_lock(&pcdev->lock);
-	if (ops->pi_get_current_limit) {
-		ret = ops->pi_get_current_limit(pcdev, id);
+	ret = ops->pi_get_pw_limit(pcdev, id);
+	if (ret < 0)
 		goto out;
-	}
+	mW = ret;
 
-	/* If pi_get_current_limit() callback not populated get voltage
-	 * from pi_get_voltage() and power limit from ethtool_get_status()
-	 *  to calculate current limit.
-	 */
-	ret = _pse_pi_get_voltage(rdev);
+	ret = pse_pi_get_voltage(rdev);
 	if (!ret) {
 		dev_err(pcdev->dev, "Voltage null\n");
 		ret = -ERANGE;
@@ -327,16 +319,7 @@ static int pse_pi_get_current_limit(struct regulator_dev *rdev)
 		goto out;
 	uV = ret;
 
-	ret = _pse_ethtool_get_status(pcdev, id, &extack, &st);
-	if (ret)
-		goto out;
-
-	if (!st.c33_avail_pw_limit) {
-		ret = -ENODATA;
-		goto out;
-	}
-
-	tmp_64 = st.c33_avail_pw_limit;
+	tmp_64 = mW;
 	tmp_64 *= 1000000000ull;
 	/* uA = mW * 1000000000 / uV */
 	ret = DIV_ROUND_CLOSEST_ULL(tmp_64, uV);
@@ -351,10 +334,11 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	const struct pse_controller_ops *ops;
-	int id, ret;
+	int id, mW, ret;
+	s64 tmp_64;
 
 	ops = pcdev->ops;
-	if (!ops->pi_set_current_limit)
+	if (!ops->pi_set_pw_limit || !ops->pi_get_voltage)
 		return -EOPNOTSUPP;
 
 	if (max_uA > MAX_PI_CURRENT)
@@ -362,7 +346,21 @@ static int pse_pi_set_current_limit(struct regulator_dev *rdev, int min_uA,
 
 	id = rdev_get_id(rdev);
 	mutex_lock(&pcdev->lock);
-	ret = ops->pi_set_current_limit(pcdev, id, max_uA);
+	ret = pse_pi_get_voltage(rdev);
+	if (!ret) {
+		dev_err(pcdev->dev, "Voltage null\n");
+		ret = -ERANGE;
+		goto out;
+	}
+	if (ret < 0)
+		goto out;
+
+	tmp_64 = ret;
+	tmp_64 *= max_uA;
+	/* mW = uA * uV / 1000000000 */
+	mW = DIV_ROUND_CLOSEST_ULL(tmp_64, 1000000000);
+	ret = ops->pi_set_pw_limit(pcdev, id, mW);
+out:
 	mutex_unlock(&pcdev->lock);
 
 	return ret;
@@ -406,7 +404,7 @@ devm_pse_pi_regulator_register(struct pse_controller_dev *pcdev,
 
 	rinit_data->constraints.valid_ops_mask = REGULATOR_CHANGE_STATUS;
 
-	if (pcdev->ops->pi_set_current_limit)
+	if (pcdev->ops->pi_set_pw_limit)
 		rinit_data->constraints.valid_ops_mask |=
 			REGULATOR_CHANGE_CURRENT;
 
@@ -737,23 +735,6 @@ struct pse_control *of_pse_control_get(struct device_node *node)
 }
 EXPORT_SYMBOL_GPL(of_pse_control_get);
 
-static int _pse_ethtool_get_status(struct pse_controller_dev *pcdev,
-				   int id,
-				   struct netlink_ext_ack *extack,
-				   struct pse_control_status *status)
-{
-	const struct pse_controller_ops *ops;
-
-	ops = pcdev->ops;
-	if (!ops->ethtool_get_status) {
-		NL_SET_ERR_MSG(extack,
-			       "PSE driver does not support status report");
-		return -EOPNOTSUPP;
-	}
-
-	return ops->ethtool_get_status(pcdev, id, extack, status);
-}
-
 /**
  * pse_ethtool_get_status - get status of PSE control
  * @psec: PSE control pointer
@@ -766,11 +747,21 @@ int pse_ethtool_get_status(struct pse_control *psec,
 			   struct netlink_ext_ack *extack,
 			   struct pse_control_status *status)
 {
+	const struct pse_controller_ops *ops;
+	struct pse_controller_dev *pcdev;
 	int err;
 
-	mutex_lock(&psec->pcdev->lock);
-	err = _pse_ethtool_get_status(psec->pcdev, psec->id, extack, status);
-	mutex_unlock(&psec->pcdev->lock);
+	pcdev = psec->pcdev;
+	ops = pcdev->ops;
+	if (!ops->ethtool_get_status) {
+		NL_SET_ERR_MSG(extack,
+			       "PSE driver does not support status report");
+		return -EOPNOTSUPP;
+	}
+
+	mutex_lock(&pcdev->lock);
+	err = ops->ethtool_get_status(pcdev, psec->id, extack, status);
+	mutex_unlock(&pcdev->lock);
 
 	return err;
 }
diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
index 591a53e082e65..df1592022d938 100644
--- a/include/linux/pse-pd/pse.h
+++ b/include/linux/pse-pd/pse.h
@@ -75,12 +75,8 @@ struct pse_control_status {
  * @pi_disable: Configure the PSE PI as disabled.
  * @pi_get_voltage: Return voltage similarly to get_voltage regulator
  *		    callback.
- * @pi_get_current_limit: Get the configured current limit similarly to
- *			  get_current_limit regulator callback.
- * @pi_set_current_limit: Configure the current limit similarly to
- *			  set_current_limit regulator callback.
- *			  Should not return an error in case of MAX_PI_CURRENT
- *			  current value set.
+ * @pi_get_pw_limit: Get the configured power limit of the PSE PI.
+ * @pi_set_pw_limit: Configure the power limit of the PSE PI.
  */
 struct pse_controller_ops {
 	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
@@ -91,10 +87,10 @@ struct pse_controller_ops {
 	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_disable)(struct pse_controller_dev *pcdev, int id);
 	int (*pi_get_voltage)(struct pse_controller_dev *pcdev, int id);
-	int (*pi_get_current_limit)(struct pse_controller_dev *pcdev,
-				    int id);
-	int (*pi_set_current_limit)(struct pse_controller_dev *pcdev,
-				    int id, int max_uA);
+	int (*pi_get_pw_limit)(struct pse_controller_dev *pcdev,
+			       int id);
+	int (*pi_set_pw_limit)(struct pse_controller_dev *pcdev,
+			       int id, int max_mW);
 };
 
 struct module;
-- 
2.39.5




