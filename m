Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CF17B885F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbjJDSP1 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243755AbjJDSPZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:15:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7536EC1
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:15:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD315C433C7;
        Wed,  4 Oct 2023 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443320;
        bh=Nn1fyVJNAkN7BNf8o9e+T21yo3FjcLkouY2vHK1cG0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jbi84klcySezKJfnUHXW2xPBbGW4AWXfxQtdZvvlEvRWVRP+d8dTmIl50NUHC3A5c
         3iuJcoPjKRWjcDigU4vtclyp9TxfsbMtgSuhRHQFFBREoH3P6KKzJfNrYvFT+rzVdO
         Ee47d1GvXPzS2m9qwHUOO5Qy5FOgEZf2ja0PQxuk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 114/259] firmware: arm_scmi: Harden perf domain info access
Date:   Wed,  4 Oct 2023 19:54:47 +0200
Message-ID: <20231004175222.573601044@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cristian Marussi <cristian.marussi@arm.com>

[ Upstream commit 3da82112355bba263597fcbb24d275fc57e69e7e ]

Harden internal accesses to domain info in the SCMI perf protocol.

Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
Link: https://lore.kernel.org/r/20230717161246.1761777-2-cristian.marussi@arm.com
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
Stable-dep-of: c3638b851bc1 ("firmware: arm_scmi: Fixup perf power-cost/microwatt support")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/firmware/arm_scmi/perf.c | 89 +++++++++++++++++++++++---------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/drivers/firmware/arm_scmi/perf.c b/drivers/firmware/arm_scmi/perf.c
index ecf5c4de851b7..43dd242ecc49c 100644
--- a/drivers/firmware/arm_scmi/perf.c
+++ b/drivers/firmware/arm_scmi/perf.c
@@ -139,7 +139,7 @@ struct perf_dom_info {
 
 struct scmi_perf_info {
 	u32 version;
-	int num_domains;
+	u16 num_domains;
 	enum scmi_power_scale power_scale;
 	u64 stats_addr;
 	u32 stats_size;
@@ -356,11 +356,26 @@ static int scmi_perf_mb_limits_set(const struct scmi_protocol_handle *ph,
 	return ret;
 }
 
+static inline struct perf_dom_info *
+scmi_perf_domain_lookup(const struct scmi_protocol_handle *ph, u32 domain)
+{
+	struct scmi_perf_info *pi = ph->get_priv(ph);
+
+	if (domain >= pi->num_domains)
+		return ERR_PTR(-EINVAL);
+
+	return pi->dom_info + domain;
+}
+
 static int scmi_perf_limits_set(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 max_perf, u32 min_perf)
 {
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (PROTOCOL_REV_MAJOR(pi->version) >= 0x3 && !max_perf && !min_perf)
 		return -EINVAL;
@@ -408,8 +423,11 @@ static int scmi_perf_mb_limits_get(const struct scmi_protocol_handle *ph,
 static int scmi_perf_limits_get(const struct scmi_protocol_handle *ph,
 				u32 domain, u32 *max_perf, u32 *min_perf)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LIMIT].get_addr) {
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LIMIT];
@@ -449,8 +467,11 @@ static int scmi_perf_mb_level_set(const struct scmi_protocol_handle *ph,
 static int scmi_perf_level_set(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 level, bool poll)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr) {
 		struct scmi_fc_info *fci = &dom->fc_info[PERF_FC_LEVEL];
@@ -490,8 +511,11 @@ static int scmi_perf_mb_level_get(const struct scmi_protocol_handle *ph,
 static int scmi_perf_level_get(const struct scmi_protocol_handle *ph,
 			       u32 domain, u32 *level, bool poll)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	if (dom->fc_info && dom->fc_info[PERF_FC_LEVEL].get_addr) {
 		*level = ioread32(dom->fc_info[PERF_FC_LEVEL].get_addr);
@@ -574,13 +598,14 @@ static int scmi_dvfs_device_opps_add(const struct scmi_protocol_handle *ph,
 	unsigned long freq;
 	struct scmi_opp *opp;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
 
 	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
-		return domain;
+		return -EINVAL;
 
-	dom = pi->dom_info + domain;
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
 		freq = opp->perf * dom->mult_factor;
@@ -603,14 +628,17 @@ static int
 scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 				 struct device *dev)
 {
+	int domain;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	int domain = scmi_dev_domain_id(dev);
 
+	domain = scmi_dev_domain_id(dev);
 	if (domain < 0)
-		return domain;
+		return -EINVAL;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
-	dom = pi->dom_info + domain;
 	/* uS to nS */
 	return dom->opp[dom->opp_count - 1].trans_latency_us * 1000;
 }
@@ -618,8 +646,11 @@ scmi_dvfs_transition_latency_get(const struct scmi_protocol_handle *ph,
 static int scmi_dvfs_freq_set(const struct scmi_protocol_handle *ph, u32 domain,
 			      unsigned long freq, bool poll)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
+	struct perf_dom_info *dom;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	return scmi_perf_level_set(ph, domain, freq / dom->mult_factor, poll);
 }
@@ -630,11 +661,14 @@ static int scmi_dvfs_freq_get(const struct scmi_protocol_handle *ph, u32 domain,
 	int ret;
 	u32 level;
 	struct scmi_perf_info *pi = ph->get_priv(ph);
-	struct perf_dom_info *dom = pi->dom_info + domain;
 
 	ret = scmi_perf_level_get(ph, domain, &level, poll);
-	if (!ret)
+	if (!ret) {
+		struct perf_dom_info *dom = pi->dom_info + domain;
+
+		/* Note domain is validated implicitly by scmi_perf_level_get */
 		*freq = level * dom->mult_factor;
+	}
 
 	return ret;
 }
@@ -643,15 +677,14 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 				   u32 domain, unsigned long *freq,
 				   unsigned long *power)
 {
-	struct scmi_perf_info *pi = ph->get_priv(ph);
 	struct perf_dom_info *dom;
 	unsigned long opp_freq;
 	int idx, ret = -EINVAL;
 	struct scmi_opp *opp;
 
-	dom = pi->dom_info + domain;
-	if (!dom)
-		return -EIO;
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return PTR_ERR(dom);
 
 	for (opp = dom->opp, idx = 0; idx < dom->opp_count; idx++, opp++) {
 		opp_freq = opp->perf * dom->mult_factor;
@@ -670,10 +703,16 @@ static int scmi_dvfs_est_power_get(const struct scmi_protocol_handle *ph,
 static bool scmi_fast_switch_possible(const struct scmi_protocol_handle *ph,
 				      struct device *dev)
 {
+	int domain;
 	struct perf_dom_info *dom;
-	struct scmi_perf_info *pi = ph->get_priv(ph);
 
-	dom = pi->dom_info + scmi_dev_domain_id(dev);
+	domain = scmi_dev_domain_id(dev);
+	if (domain < 0)
+		return false;
+
+	dom = scmi_perf_domain_lookup(ph, domain);
+	if (IS_ERR(dom))
+		return false;
 
 	return dom->fc_info && dom->fc_info[PERF_FC_LEVEL].set_addr;
 }
-- 
2.40.1



