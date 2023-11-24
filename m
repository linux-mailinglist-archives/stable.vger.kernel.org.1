Return-Path: <stable+bounces-2198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CAB7F832D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267241C24F8D
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5A364BA;
	Fri, 24 Nov 2023 19:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yQlCVRTo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E352D787;
	Fri, 24 Nov 2023 19:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39F3C433C9;
	Fri, 24 Nov 2023 19:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700853292;
	bh=91c0oXAoj2NUvjARdBRCCyzWQud72ABhm8hU/BxVvBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yQlCVRTo3ZDb2nns/Usym8/Z0FUADEJ7RL4NhTrcX8n5ZiS8INe+fvCuyQ4FX7PDZ
	 u/IB3H4T2YHprIwtgZBgS7W4Eu95Ljo54jBJJWpVIlsGB8A1Zs5S9m5KBW6LbHfpyG
	 1DoBNogwoO/tFH7a4mPDhTAYMc9Ewm1iaKU0MM6c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jie Wang <wangjie125@huawei.com>,
	Guangbin Huang <huangguangbin2@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 106/297] net: hns3: add byte order conversion for PF to VF mailbox message
Date: Fri, 24 Nov 2023 17:52:28 +0000
Message-ID: <20231124172003.982646011@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172000.087816911@linuxfoundation.org>
References: <20231124172000.087816911@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jie Wang <wangjie125@huawei.com>

[ Upstream commit 767975e582c50b39d633f6e1c4bb99cc1f156efb ]

Currently, hns3 mailbox processing between PF and VF missed to convert
message byte order and use data type u16 instead of __le16 for mailbox
data process. These processes may cause problems between different
architectures.

So this patch uses __le16/__le32 data type to define mailbox data
structures. To be compatible with old hns3 driver, these structures use
one-byte alignment. Then byte order conversions are added to mailbox
messages from PF to VF.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: ac92c0a9a060 ("net: hns3: add barrier in vf mailbox reply process")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/hisilicon/hns3/hclge_mbx.h   | 36 +++++++--
 .../hisilicon/hns3/hns3pf/hclge_mbx.c         | 60 +++++++-------
 .../hisilicon/hns3/hns3pf/hclge_trace.h       |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |  4 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.h      |  2 +-
 .../hisilicon/hns3/hns3vf/hclgevf_mbx.c       | 80 +++++++++++--------
 .../hisilicon/hns3/hns3vf/hclgevf_trace.h     |  2 +-
 7 files changed, 109 insertions(+), 77 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
index c4603a70ed60b..277d6d657c429 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hclge_mbx.h
@@ -131,13 +131,13 @@ struct hclge_vf_to_pf_msg {
 };
 
 struct hclge_pf_to_vf_msg {
-	u16 code;
+	__le16 code;
 	union {
 		/* used for mbx response */
 		struct {
-			u16 vf_mbx_msg_code;
-			u16 vf_mbx_msg_subcode;
-			u16 resp_status;
+			__le16 vf_mbx_msg_code;
+			__le16 vf_mbx_msg_subcode;
+			__le16 resp_status;
 			u8 resp_data[HCLGE_MBX_MAX_RESP_DATA_SIZE];
 		};
 		/* used for general mbx */
@@ -154,7 +154,7 @@ struct hclge_mbx_vf_to_pf_cmd {
 	u8 rsv1[1];
 	u8 msg_len;
 	u8 rsv2;
-	u16 match_id;
+	__le16 match_id;
 	struct hclge_vf_to_pf_msg msg;
 };
 
@@ -165,7 +165,7 @@ struct hclge_mbx_pf_to_vf_cmd {
 	u8 rsv[3];
 	u8 msg_len;
 	u8 rsv1;
-	u16 match_id;
+	__le16 match_id;
 	struct hclge_pf_to_vf_msg msg;
 };
 
@@ -175,6 +175,28 @@ struct hclge_vf_rst_cmd {
 	u8 rsv[22];
 };
 
+#pragma pack(1)
+struct hclge_mbx_link_status {
+	__le16 link_status;
+	__le32 speed;
+	__le16 duplex;
+	u8 flag;
+};
+
+struct hclge_mbx_link_mode {
+	__le16 idx;
+	__le64 link_mode;
+};
+
+struct hclge_mbx_port_base_vlan {
+	__le16 state;
+	__le16 vlan_proto;
+	__le16 qos;
+	__le16 vlan_tag;
+};
+
+#pragma pack()
+
 /* used by VF to store the received Async responses from PF */
 struct hclgevf_mbx_arq_ring {
 #define HCLGE_MBX_MAX_ARQ_MSG_SIZE	8
@@ -183,7 +205,7 @@ struct hclgevf_mbx_arq_ring {
 	u32 head;
 	u32 tail;
 	atomic_t count;
-	u16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
+	__le16 msg_q[HCLGE_MBX_MAX_ARQ_MSG_NUM][HCLGE_MBX_MAX_ARQ_MSG_SIZE];
 };
 
 #define hclge_mbx_ring_ptr_move_crq(crq) \
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index dac4ac425481c..5182051e5414d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -56,17 +56,19 @@ static int hclge_gen_resp_to_vf(struct hclge_vport *vport,
 	resp_pf_to_vf->msg_len = vf_to_pf_req->msg_len;
 	resp_pf_to_vf->match_id = vf_to_pf_req->match_id;
 
-	resp_pf_to_vf->msg.code = HCLGE_MBX_PF_VF_RESP;
-	resp_pf_to_vf->msg.vf_mbx_msg_code = vf_to_pf_req->msg.code;
-	resp_pf_to_vf->msg.vf_mbx_msg_subcode = vf_to_pf_req->msg.subcode;
+	resp_pf_to_vf->msg.code = cpu_to_le16(HCLGE_MBX_PF_VF_RESP);
+	resp_pf_to_vf->msg.vf_mbx_msg_code =
+				cpu_to_le16(vf_to_pf_req->msg.code);
+	resp_pf_to_vf->msg.vf_mbx_msg_subcode =
+				cpu_to_le16(vf_to_pf_req->msg.subcode);
 	resp = hclge_errno_to_resp(resp_msg->status);
 	if (resp < SHRT_MAX) {
-		resp_pf_to_vf->msg.resp_status = resp;
+		resp_pf_to_vf->msg.resp_status = cpu_to_le16(resp);
 	} else {
 		dev_warn(&hdev->pdev->dev,
 			 "failed to send response to VF, response status %u is out-of-bound\n",
 			 resp);
-		resp_pf_to_vf->msg.resp_status = EIO;
+		resp_pf_to_vf->msg.resp_status = cpu_to_le16(EIO);
 	}
 
 	if (resp_msg->len > 0)
@@ -106,7 +108,7 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 
 	resp_pf_to_vf->dest_vfid = dest_vfid;
 	resp_pf_to_vf->msg_len = msg_len;
-	resp_pf_to_vf->msg.code = mbx_opcode;
+	resp_pf_to_vf->msg.code = cpu_to_le16(mbx_opcode);
 
 	memcpy(resp_pf_to_vf->msg.msg_data, msg, msg_len);
 
@@ -124,8 +126,8 @@ static int hclge_send_mbx_msg(struct hclge_vport *vport, u8 *msg, u16 msg_len,
 int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
 {
 	struct hclge_dev *hdev = vport->back;
+	__le16 msg_data;
 	u16 reset_type;
-	u8 msg_data[2];
 	u8 dest_vfid;
 
 	BUILD_BUG_ON(HNAE3_MAX_RESET > U16_MAX);
@@ -139,10 +141,10 @@ int hclge_inform_reset_assert_to_vf(struct hclge_vport *vport)
 	else
 		reset_type = HNAE3_VF_FUNC_RESET;
 
-	memcpy(&msg_data[0], &reset_type, sizeof(u16));
+	msg_data = cpu_to_le16(reset_type);
 
 	/* send this requested info to VF */
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	return hclge_send_mbx_msg(vport, (u8 *)&msg_data, sizeof(msg_data),
 				  HCLGE_MBX_ASSERTING_RESET, dest_vfid);
 }
 
@@ -338,16 +340,14 @@ int hclge_push_vf_port_base_vlan_info(struct hclge_vport *vport, u8 vfid,
 				      u16 state,
 				      struct hclge_vlan_info *vlan_info)
 {
-#define MSG_DATA_SIZE	8
+	struct hclge_mbx_port_base_vlan base_vlan;
 
-	u8 msg_data[MSG_DATA_SIZE];
+	base_vlan.state = cpu_to_le16(state);
+	base_vlan.vlan_proto = cpu_to_le16(vlan_info->vlan_proto);
+	base_vlan.qos = cpu_to_le16(vlan_info->qos);
+	base_vlan.vlan_tag = cpu_to_le16(vlan_info->vlan_tag);
 
-	memcpy(&msg_data[0], &state, sizeof(u16));
-	memcpy(&msg_data[2], &vlan_info->vlan_proto, sizeof(u16));
-	memcpy(&msg_data[4], &vlan_info->qos, sizeof(u16));
-	memcpy(&msg_data[6], &vlan_info->vlan_tag, sizeof(u16));
-
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	return hclge_send_mbx_msg(vport, (u8 *)&base_vlan, sizeof(base_vlan),
 				  HCLGE_MBX_PUSH_VLAN_INFO, vfid);
 }
 
@@ -487,10 +487,9 @@ int hclge_push_vf_link_status(struct hclge_vport *vport)
 #define HCLGE_VF_LINK_STATE_UP		1U
 #define HCLGE_VF_LINK_STATE_DOWN	0U
 
+	struct hclge_mbx_link_status link_info;
 	struct hclge_dev *hdev = vport->back;
 	u16 link_status;
-	u8 msg_data[9];
-	u16 duplex;
 
 	/* mac.link can only be 0 or 1 */
 	switch (vport->vf_info.link_state) {
@@ -506,14 +505,13 @@ int hclge_push_vf_link_status(struct hclge_vport *vport)
 		break;
 	}
 
-	duplex = hdev->hw.mac.duplex;
-	memcpy(&msg_data[0], &link_status, sizeof(u16));
-	memcpy(&msg_data[2], &hdev->hw.mac.speed, sizeof(u32));
-	memcpy(&msg_data[6], &duplex, sizeof(u16));
-	msg_data[8] = HCLGE_MBX_PUSH_LINK_STATUS_EN;
+	link_info.link_status = cpu_to_le16(link_status);
+	link_info.speed = cpu_to_le32(hdev->hw.mac.speed);
+	link_info.duplex = cpu_to_le16(hdev->hw.mac.duplex);
+	link_info.flag = HCLGE_MBX_PUSH_LINK_STATUS_EN;
 
 	/* send this requested info to VF */
-	return hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	return hclge_send_mbx_msg(vport, (u8 *)&link_info, sizeof(link_info),
 				  HCLGE_MBX_LINK_STAT_CHANGE, vport->vport_id);
 }
 
@@ -521,22 +519,22 @@ static void hclge_get_link_mode(struct hclge_vport *vport,
 				struct hclge_mbx_vf_to_pf_cmd *mbx_req)
 {
 #define HCLGE_SUPPORTED   1
+	struct hclge_mbx_link_mode link_mode;
 	struct hclge_dev *hdev = vport->back;
 	unsigned long advertising;
 	unsigned long supported;
 	unsigned long send_data;
-	u8 msg_data[10] = {};
 	u8 dest_vfid;
 
 	advertising = hdev->hw.mac.advertising[0];
 	supported = hdev->hw.mac.supported[0];
 	dest_vfid = mbx_req->mbx_src_vfid;
-	msg_data[0] = mbx_req->msg.data[0];
-
-	send_data = msg_data[0] == HCLGE_SUPPORTED ? supported : advertising;
+	send_data = mbx_req->msg.data[0] == HCLGE_SUPPORTED ? supported :
+							      advertising;
+	link_mode.idx = cpu_to_le16((u16)mbx_req->msg.data[0]);
+	link_mode.link_mode = cpu_to_le64(send_data);
 
-	memcpy(&msg_data[2], &send_data, sizeof(unsigned long));
-	hclge_send_mbx_msg(vport, msg_data, sizeof(msg_data),
+	hclge_send_mbx_msg(vport, (u8 *)&link_mode, sizeof(link_mode),
 			   HCLGE_MBX_LINK_STAT_MODE, dest_vfid);
 }
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
index 5b0b71bd61200..8510b88d49820 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_trace.h
@@ -62,7 +62,7 @@ TRACE_EVENT(hclge_pf_mbx_send,
 
 	TP_fast_assign(
 		__entry->vfid = req->dest_vfid;
-		__entry->code = req->msg.code;
+		__entry->code = le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
 		__assign_str(devname, &hdev->vport[0].nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 8adc682f624f9..69913af880a40 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -3816,7 +3816,7 @@ static void hclgevf_get_regs(struct hnae3_handle *handle, u32 *version,
 }
 
 void hclgevf_update_port_base_vlan_info(struct hclgevf_dev *hdev, u16 state,
-					u8 *port_base_vlan_info, u8 data_size)
+				struct hclge_mbx_port_base_vlan *port_base_vlan)
 {
 	struct hnae3_handle *nic = &hdev->nic;
 	struct hclge_vf_to_pf_msg send_msg;
@@ -3841,7 +3841,7 @@ void hclgevf_update_port_base_vlan_info(struct hclgevf_dev *hdev, u16 state,
 	/* send msg to PF and wait update port based vlan info */
 	hclgevf_build_send_msg(&send_msg, HCLGE_MBX_SET_VLAN,
 			       HCLGE_MBX_PORT_BASE_VLAN_CFG);
-	memcpy(send_msg.data, port_base_vlan_info, data_size);
+	memcpy(send_msg.data, port_base_vlan, sizeof(*port_base_vlan));
 	ret = hclgevf_send_mbx_msg(hdev, &send_msg, false, NULL, 0);
 	if (!ret) {
 		if (state == HNAE3_PORT_BASE_VLAN_DISABLE)
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
index f6f736c0091c0..e16068264fa77 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.h
@@ -355,5 +355,5 @@ void hclgevf_update_speed_duplex(struct hclgevf_dev *hdev, u32 speed,
 void hclgevf_reset_task_schedule(struct hclgevf_dev *hdev);
 void hclgevf_mbx_task_schedule(struct hclgevf_dev *hdev);
 void hclgevf_update_port_base_vlan_info(struct hclgevf_dev *hdev, u16 state,
-					u8 *port_base_vlan_info, u8 data_size);
+			struct hclge_mbx_port_base_vlan *port_base_vlan);
 #endif
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index c5ac6ecf36e10..df6e9b8b26e0f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -121,7 +121,7 @@ int hclgevf_send_mbx_msg(struct hclgevf_dev *hdev,
 	if (need_resp) {
 		mutex_lock(&hdev->mbx_resp.mbx_mutex);
 		hclgevf_reset_mbx_resp_status(hdev);
-		req->match_id = hdev->mbx_resp.match_id;
+		req->match_id = cpu_to_le16(hdev->mbx_resp.match_id);
 		status = hclgevf_cmd_send(&hdev->hw, &desc, 1);
 		if (status) {
 			dev_err(&hdev->pdev->dev,
@@ -159,27 +159,29 @@ static bool hclgevf_cmd_crq_empty(struct hclgevf_hw *hw)
 static void hclgevf_handle_mbx_response(struct hclgevf_dev *hdev,
 					struct hclge_mbx_pf_to_vf_cmd *req)
 {
+	u16 vf_mbx_msg_subcode = le16_to_cpu(req->msg.vf_mbx_msg_subcode);
+	u16 vf_mbx_msg_code = le16_to_cpu(req->msg.vf_mbx_msg_code);
 	struct hclgevf_mbx_resp_status *resp = &hdev->mbx_resp;
+	u16 resp_status = le16_to_cpu(req->msg.resp_status);
+	u16 match_id = le16_to_cpu(req->match_id);
 
 	if (resp->received_resp)
 		dev_warn(&hdev->pdev->dev,
-			 "VF mbx resp flag not clear(%u)\n",
-			 req->msg.vf_mbx_msg_code);
-
-	resp->origin_mbx_msg =
-			(req->msg.vf_mbx_msg_code << 16);
-	resp->origin_mbx_msg |= req->msg.vf_mbx_msg_subcode;
-	resp->resp_status =
-		hclgevf_resp_to_errno(req->msg.resp_status);
+			"VF mbx resp flag not clear(%u)\n",
+			 vf_mbx_msg_code);
+
+	resp->origin_mbx_msg = (vf_mbx_msg_code << 16);
+	resp->origin_mbx_msg |= vf_mbx_msg_subcode;
+	resp->resp_status = hclgevf_resp_to_errno(resp_status);
 	memcpy(resp->additional_info, req->msg.resp_data,
 	       HCLGE_MBX_MAX_RESP_DATA_SIZE * sizeof(u8));
-	if (req->match_id) {
+	if (match_id) {
 		/* If match_id is not zero, it means PF support match_id.
 		 * if the match_id is right, VF get the right response, or
 		 * ignore the response. and driver will clear hdev->mbx_resp
 		 * when send next message which need response.
 		 */
-		if (req->match_id == resp->match_id)
+		if (match_id == resp->match_id)
 			resp->received_resp = true;
 	} else {
 		resp->received_resp = true;
@@ -196,7 +198,7 @@ static void hclgevf_handle_mbx_msg(struct hclgevf_dev *hdev,
 	    HCLGE_MBX_MAX_ARQ_MSG_NUM) {
 		dev_warn(&hdev->pdev->dev,
 			 "Async Q full, dropping msg(%u)\n",
-			 req->msg.code);
+			 le16_to_cpu(req->msg.code));
 		return;
 	}
 
@@ -215,6 +217,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 	struct hclgevf_cmq_ring *crq;
 	struct hclgevf_desc *desc;
 	u16 flag;
+	u16 code;
 
 	crq = &hdev->hw.cmq.crq;
 
@@ -228,10 +231,11 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		req = (struct hclge_mbx_pf_to_vf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
+		code = le16_to_cpu(req->msg.code);
 		if (unlikely(!hnae3_get_bit(flag, HCLGEVF_CMDQ_RX_OUTVLD_B))) {
 			dev_warn(&hdev->pdev->dev,
 				 "dropped invalid mailbox message, code = %u\n",
-				 req->msg.code);
+				 code);
 
 			/* dropping/not processing this invalid message */
 			crq->desc[crq->next_to_use].flag = 0;
@@ -247,7 +251,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		 * timeout and simultaneously queue the async messages for later
 		 * prcessing in context of mailbox task i.e. the slow path.
 		 */
-		switch (req->msg.code) {
+		switch (code) {
 		case HCLGE_MBX_PF_VF_RESP:
 			hclgevf_handle_mbx_response(hdev, req);
 			break;
@@ -261,7 +265,7 @@ void hclgevf_mbx_handler(struct hclgevf_dev *hdev)
 		default:
 			dev_err(&hdev->pdev->dev,
 				"VF received unsupported(%u) mbx msg from PF\n",
-				req->msg.code);
+				code);
 			break;
 		}
 		crq->desc[crq->next_to_use].flag = 0;
@@ -283,14 +287,18 @@ static void hclgevf_parse_promisc_info(struct hclgevf_dev *hdev,
 
 void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 {
+	struct hclge_mbx_port_base_vlan *vlan_info;
+	struct hclge_mbx_link_status *link_info;
+	struct hclge_mbx_link_mode *link_mode;
 	enum hnae3_reset_type reset_type;
 	u16 link_status, state;
-	u16 *msg_q, *vlan_info;
+	__le16 *msg_q;
+	u16 opcode;
 	u8 duplex;
 	u32 speed;
 	u32 tail;
 	u8 flag;
-	u8 idx;
+	u16 idx;
 
 	tail = hdev->arq.tail;
 
@@ -303,13 +311,14 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 		}
 
 		msg_q = hdev->arq.msg_q[hdev->arq.head];
-
-		switch (msg_q[0]) {
+		opcode = le16_to_cpu(msg_q[0]);
+		switch (opcode) {
 		case HCLGE_MBX_LINK_STAT_CHANGE:
-			link_status = msg_q[1];
-			memcpy(&speed, &msg_q[2], sizeof(speed));
-			duplex = (u8)msg_q[4];
-			flag = (u8)msg_q[5];
+			link_info = (struct hclge_mbx_link_status *)(msg_q + 1);
+			link_status = le16_to_cpu(link_info->link_status);
+			speed = le32_to_cpu(link_info->speed);
+			duplex = (u8)le16_to_cpu(link_info->duplex);
+			flag = link_info->flag;
 
 			/* update upper layer with new link link status */
 			hclgevf_update_speed_duplex(hdev, speed, duplex);
@@ -321,13 +330,14 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 
 			break;
 		case HCLGE_MBX_LINK_STAT_MODE:
-			idx = (u8)msg_q[1];
+			link_mode = (struct hclge_mbx_link_mode *)(msg_q + 1);
+			idx = le16_to_cpu(link_mode->idx);
 			if (idx)
-				memcpy(&hdev->hw.mac.supported, &msg_q[2],
-				       sizeof(unsigned long));
+				hdev->hw.mac.supported =
+					le64_to_cpu(link_mode->link_mode);
 			else
-				memcpy(&hdev->hw.mac.advertising, &msg_q[2],
-				       sizeof(unsigned long));
+				hdev->hw.mac.advertising =
+					le64_to_cpu(link_mode->link_mode);
 			break;
 		case HCLGE_MBX_ASSERTING_RESET:
 			/* PF has asserted reset hence VF should go in pending
@@ -335,25 +345,27 @@ void hclgevf_mbx_async_handler(struct hclgevf_dev *hdev)
 			 * has been completely reset. After this stack should
 			 * eventually be re-initialized.
 			 */
-			reset_type = (enum hnae3_reset_type)msg_q[1];
+			reset_type =
+				(enum hnae3_reset_type)le16_to_cpu(msg_q[1]);
 			set_bit(reset_type, &hdev->reset_pending);
 			set_bit(HCLGEVF_RESET_PENDING, &hdev->reset_state);
 			hclgevf_reset_task_schedule(hdev);
 
 			break;
 		case HCLGE_MBX_PUSH_VLAN_INFO:
-			state = msg_q[1];
-			vlan_info = &msg_q[1];
+			vlan_info =
+				(struct hclge_mbx_port_base_vlan *)(msg_q + 1);
+			state = le16_to_cpu(vlan_info->state);
 			hclgevf_update_port_base_vlan_info(hdev, state,
-							   (u8 *)vlan_info, 8);
+							   vlan_info);
 			break;
 		case HCLGE_MBX_PUSH_PROMISC_INFO:
-			hclgevf_parse_promisc_info(hdev, msg_q[1]);
+			hclgevf_parse_promisc_info(hdev, le16_to_cpu(msg_q[1]));
 			break;
 		default:
 			dev_err(&hdev->pdev->dev,
 				"fetched unsupported(%u) message from arq\n",
-				msg_q[0]);
+				opcode);
 			break;
 		}
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
index e4bfb6191fef5..5d4895bb57a17 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_trace.h
@@ -29,7 +29,7 @@ TRACE_EVENT(hclge_vf_mbx_get,
 
 	TP_fast_assign(
 		__entry->vfid = req->dest_vfid;
-		__entry->code = req->msg.code;
+		__entry->code = le16_to_cpu(req->msg.code);
 		__assign_str(pciname, pci_name(hdev->pdev));
 		__assign_str(devname, &hdev->nic.kinfo.netdev->name);
 		memcpy(__entry->mbx_data, req,
-- 
2.42.0




