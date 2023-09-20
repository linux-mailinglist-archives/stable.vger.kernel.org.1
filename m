Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFD87A7ABE
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjITLpo (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbjITLpd (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:45:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1883FCA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:45:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63639C433C9;
        Wed, 20 Sep 2023 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210327;
        bh=JXt5TanKDk/9W+dcl59xrG+qtrrF/D2eIIo+KZZN/qQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gkqt8umf9S/AXGGDXCpQxIlXd932/qKNJE20mgi099rqbEZrn7gg7H828tnp51QbU
         yeY3Q1jLNePW7wX0XF6he1u7CpJmbGkDVtpFOML+9toe0LipYIhPQY/CKe/GTCaVYx
         Qu8+VqSoAegzXOjWWEbB4bn2PPoWniuEyqN6rR+Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wen Gong <quic_wgong@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 037/211] wifi: ath12k: avoid array overflow of hw mode for preferred_hw_mode
Date:   Wed, 20 Sep 2023 13:28:01 +0200
Message-ID: <20230920112846.944468503@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 1e9b1363e2de1552ee4e3d74ac8bb43a194f1cb4 ]

Currently ath12k define WMI_HOST_HW_MODE_DBS_OR_SBS=5 as max hw mode
for enum wmi_host_hw_mode_config_type, it is also same for the array
ath12k_hw_mode_pri_map.

When tested with new version firmware/board data which support new
hw mode eMLSR mode with hw mode value 8, it leads overflow usage for
array ath12k_hw_mode_pri_map in function ath12k_wmi_hw_mode_caps(),
and then lead preferred_hw_mode changed to 8, and finally function
ath12k_pull_mac_phy_cap_svc_ready_ext() select the capability of hw
mode 8, but the capability of eMLSR mode report from firmware does
not support 2.4 GHz band for WCN7850, so finally 2.4 GHz band is
disabled.

Skip the hw mode which exceeds WMI_HOST_HW_MODE_MAX in function
ath12k_wmi_hw_mode_caps() helps to avoid array overflow, then the 2.4
GHz band will not be disabled.

This is to keep compatibility with newer version firmware/board data
files, this change is still needed after ath12k add eMLSR hw mode 8 in
array ath12k_hw_mode_pri_map and enum wmi_host_hw_mode_config_type,
because more hw mode maybe added in next firmware/board data version
e.g hw mode 9, then it will also lead new array overflow without this
change.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20230714072405.28705-1-quic_wgong@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/ath/ath12k/wmi.c b/drivers/net/wireless/ath/ath12k/wmi.c
index 4928e4e916603..4f378f06e946e 100644
--- a/drivers/net/wireless/ath/ath12k/wmi.c
+++ b/drivers/net/wireless/ath/ath12k/wmi.c
@@ -3704,6 +3704,10 @@ static int ath12k_wmi_hw_mode_caps(struct ath12k_base *soc,
 	for (i = 0 ; i < svc_rdy_ext->n_hw_mode_caps; i++) {
 		hw_mode_caps = &svc_rdy_ext->hw_mode_caps[i];
 		mode = le32_to_cpu(hw_mode_caps->hw_mode_id);
+
+		if (mode >= WMI_HOST_HW_MODE_MAX)
+			continue;
+
 		pref = soc->wmi_ab.preferred_hw_mode;
 
 		if (ath12k_hw_mode_pri_map[mode] < ath12k_hw_mode_pri_map[pref]) {
-- 
2.40.1



