Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C503775ADA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjHILMP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjHILMO (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:12:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AEB1FCE
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:12:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD19463155
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77F3C433C8;
        Wed,  9 Aug 2023 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691579532;
        bh=cRv3uQS6w3K5DhYQsYcKJo3LiZPnG22vaHOVD/+d5G0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CxDHptNpmNRpkRDwfIAAv66NwV5VKPUqBweYt3fbDW0gJg0Uh2f145UdSu+abdaNv
         a6KACt1tO5HeWooiBysEwxFUzbaUQOLx8qKk5vURnpd6IRxzN8vNEcOPuFw0j1WuKd
         S6IUql6wSkmNO5NKtijIopBgwzVGaPfPV2RDmSeY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 025/323] nfc: constify several pointers to u8, char and sk_buff
Date:   Wed,  9 Aug 2023 12:37:43 +0200
Message-ID: <20230809103659.266682888@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103658.104386911@linuxfoundation.org>
References: <20230809103658.104386911@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

[ Upstream commit 3df40eb3a2ea58bf404a38f15a7a2768e4762cb0 ]

Several functions receive pointers to u8, char or sk_buff but do not
modify the contents so make them const.  This allows doing the same for
local variables and in total makes the code a little bit safer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0d9b41daa590 ("nfc: llcp: fix possible use of uninitialized variable in nfc_llcp_send_connect()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/nfc/nfc.h   |  4 ++--
 net/nfc/core.c          |  4 ++--
 net/nfc/hci/llc_shdlc.c | 10 ++++-----
 net/nfc/llcp.h          |  8 +++----
 net/nfc/llcp_commands.c | 46 ++++++++++++++++++++++-------------------
 net/nfc/llcp_core.c     | 44 +++++++++++++++++++++------------------
 net/nfc/nfc.h           |  2 +-
 7 files changed, 63 insertions(+), 55 deletions(-)

diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
index bbdc73a3239df..8b86560b5cfb1 100644
--- a/include/net/nfc/nfc.h
+++ b/include/net/nfc/nfc.h
@@ -278,7 +278,7 @@ struct sk_buff *nfc_alloc_send_skb(struct nfc_dev *dev, struct sock *sk,
 struct sk_buff *nfc_alloc_recv_skb(unsigned int size, gfp_t gfp);
 
 int nfc_set_remote_general_bytes(struct nfc_dev *dev,
-				 u8 *gt, u8 gt_len);
+				 const u8 *gt, u8 gt_len);
 u8 *nfc_get_local_general_bytes(struct nfc_dev *dev, size_t *gb_len);
 
 int nfc_fw_download_done(struct nfc_dev *dev, const char *firmware_name,
@@ -292,7 +292,7 @@ int nfc_dep_link_is_up(struct nfc_dev *dev, u32 target_idx,
 		       u8 comm_mode, u8 rf_mode);
 
 int nfc_tm_activated(struct nfc_dev *dev, u32 protocol, u8 comm_mode,
-		     u8 *gb, size_t gb_len);
+		     const u8 *gb, size_t gb_len);
 int nfc_tm_deactivated(struct nfc_dev *dev);
 int nfc_tm_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 
diff --git a/net/nfc/core.c b/net/nfc/core.c
index a84f824da051d..dd12ee46ac730 100644
--- a/net/nfc/core.c
+++ b/net/nfc/core.c
@@ -646,7 +646,7 @@ int nfc_disable_se(struct nfc_dev *dev, u32 se_idx)
 	return rc;
 }
 
-int nfc_set_remote_general_bytes(struct nfc_dev *dev, u8 *gb, u8 gb_len)
+int nfc_set_remote_general_bytes(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	pr_debug("dev_name=%s gb_len=%d\n", dev_name(&dev->dev), gb_len);
 
@@ -675,7 +675,7 @@ int nfc_tm_data_received(struct nfc_dev *dev, struct sk_buff *skb)
 EXPORT_SYMBOL(nfc_tm_data_received);
 
 int nfc_tm_activated(struct nfc_dev *dev, u32 protocol, u8 comm_mode,
-		     u8 *gb, size_t gb_len)
+		     const u8 *gb, size_t gb_len)
 {
 	int rc;
 
diff --git a/net/nfc/hci/llc_shdlc.c b/net/nfc/hci/llc_shdlc.c
index fe988936ad923..e6863c71f566d 100644
--- a/net/nfc/hci/llc_shdlc.c
+++ b/net/nfc/hci/llc_shdlc.c
@@ -134,7 +134,7 @@ static bool llc_shdlc_x_lteq_y_lt_z(int x, int y, int z)
 		return ((y >= x) || (y < z)) ? true : false;
 }
 
-static struct sk_buff *llc_shdlc_alloc_skb(struct llc_shdlc *shdlc,
+static struct sk_buff *llc_shdlc_alloc_skb(const struct llc_shdlc *shdlc,
 					   int payload_len)
 {
 	struct sk_buff *skb;
@@ -148,7 +148,7 @@ static struct sk_buff *llc_shdlc_alloc_skb(struct llc_shdlc *shdlc,
 }
 
 /* immediately sends an S frame. */
-static int llc_shdlc_send_s_frame(struct llc_shdlc *shdlc,
+static int llc_shdlc_send_s_frame(const struct llc_shdlc *shdlc,
 				  enum sframe_type sframe_type, int nr)
 {
 	int r;
@@ -170,7 +170,7 @@ static int llc_shdlc_send_s_frame(struct llc_shdlc *shdlc,
 }
 
 /* immediately sends an U frame. skb may contain optional payload */
-static int llc_shdlc_send_u_frame(struct llc_shdlc *shdlc,
+static int llc_shdlc_send_u_frame(const struct llc_shdlc *shdlc,
 				  struct sk_buff *skb,
 				  enum uframe_modifier uframe_modifier)
 {
@@ -372,7 +372,7 @@ static void llc_shdlc_connect_complete(struct llc_shdlc *shdlc, int r)
 	wake_up(shdlc->connect_wq);
 }
 
-static int llc_shdlc_connect_initiate(struct llc_shdlc *shdlc)
+static int llc_shdlc_connect_initiate(const struct llc_shdlc *shdlc)
 {
 	struct sk_buff *skb;
 
@@ -388,7 +388,7 @@ static int llc_shdlc_connect_initiate(struct llc_shdlc *shdlc)
 	return llc_shdlc_send_u_frame(shdlc, skb, U_FRAME_RSET);
 }
 
-static int llc_shdlc_connect_send_ua(struct llc_shdlc *shdlc)
+static int llc_shdlc_connect_send_ua(const struct llc_shdlc *shdlc)
 {
 	struct sk_buff *skb;
 
diff --git a/net/nfc/llcp.h b/net/nfc/llcp.h
index 1f68724d44d3b..a070a57fc1516 100644
--- a/net/nfc/llcp.h
+++ b/net/nfc/llcp.h
@@ -233,15 +233,15 @@ struct sock *nfc_llcp_accept_dequeue(struct sock *sk, struct socket *newsock);
 
 /* TLV API */
 int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
-			  u8 *tlv_array, u16 tlv_array_len);
+			  const u8 *tlv_array, u16 tlv_array_len);
 int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
-				  u8 *tlv_array, u16 tlv_array_len);
+				  const u8 *tlv_array, u16 tlv_array_len);
 
 /* Commands API */
 void nfc_llcp_recv(void *data, struct sk_buff *skb, int err);
-u8 *nfc_llcp_build_tlv(u8 type, u8 *value, u8 value_length, u8 *tlv_length);
+u8 *nfc_llcp_build_tlv(u8 type, const u8 *value, u8 value_length, u8 *tlv_length);
 struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdres_tlv(u8 tid, u8 sap);
-struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
+struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 						  size_t uri_len);
 void nfc_llcp_free_sdp_tlv(struct nfc_llcp_sdp_tlv *sdp);
 void nfc_llcp_free_sdp_tlv_list(struct hlist_head *sdp_head);
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index d1fc019e932e0..6dcad7bcf20bb 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -27,7 +27,7 @@
 #include "nfc.h"
 #include "llcp.h"
 
-static u8 llcp_tlv_length[LLCP_TLV_MAX] = {
+static const u8 llcp_tlv_length[LLCP_TLV_MAX] = {
 	0,
 	1, /* VERSION */
 	2, /* MIUX */
@@ -41,7 +41,7 @@ static u8 llcp_tlv_length[LLCP_TLV_MAX] = {
 
 };
 
-static u8 llcp_tlv8(u8 *tlv, u8 type)
+static u8 llcp_tlv8(const u8 *tlv, u8 type)
 {
 	if (tlv[0] != type || tlv[1] != llcp_tlv_length[tlv[0]])
 		return 0;
@@ -49,7 +49,7 @@ static u8 llcp_tlv8(u8 *tlv, u8 type)
 	return tlv[2];
 }
 
-static u16 llcp_tlv16(u8 *tlv, u8 type)
+static u16 llcp_tlv16(const u8 *tlv, u8 type)
 {
 	if (tlv[0] != type || tlv[1] != llcp_tlv_length[tlv[0]])
 		return 0;
@@ -58,37 +58,37 @@ static u16 llcp_tlv16(u8 *tlv, u8 type)
 }
 
 
-static u8 llcp_tlv_version(u8 *tlv)
+static u8 llcp_tlv_version(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_VERSION);
 }
 
-static u16 llcp_tlv_miux(u8 *tlv)
+static u16 llcp_tlv_miux(const u8 *tlv)
 {
 	return llcp_tlv16(tlv, LLCP_TLV_MIUX) & 0x7ff;
 }
 
-static u16 llcp_tlv_wks(u8 *tlv)
+static u16 llcp_tlv_wks(const u8 *tlv)
 {
 	return llcp_tlv16(tlv, LLCP_TLV_WKS);
 }
 
-static u16 llcp_tlv_lto(u8 *tlv)
+static u16 llcp_tlv_lto(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_LTO);
 }
 
-static u8 llcp_tlv_opt(u8 *tlv)
+static u8 llcp_tlv_opt(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_OPT);
 }
 
-static u8 llcp_tlv_rw(u8 *tlv)
+static u8 llcp_tlv_rw(const u8 *tlv)
 {
 	return llcp_tlv8(tlv, LLCP_TLV_RW) & 0xf;
 }
 
-u8 *nfc_llcp_build_tlv(u8 type, u8 *value, u8 value_length, u8 *tlv_length)
+u8 *nfc_llcp_build_tlv(u8 type, const u8 *value, u8 value_length, u8 *tlv_length)
 {
 	u8 *tlv, length;
 
@@ -142,7 +142,7 @@ struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdres_tlv(u8 tid, u8 sap)
 	return sdres;
 }
 
-struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, char *uri,
+struct nfc_llcp_sdp_tlv *nfc_llcp_build_sdreq_tlv(u8 tid, const char *uri,
 						  size_t uri_len)
 {
 	struct nfc_llcp_sdp_tlv *sdreq;
@@ -202,9 +202,10 @@ void nfc_llcp_free_sdp_tlv_list(struct hlist_head *head)
 }
 
 int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
-			  u8 *tlv_array, u16 tlv_array_len)
+			  const u8 *tlv_array, u16 tlv_array_len)
 {
-	u8 *tlv = tlv_array, type, length, offset = 0;
+	const u8 *tlv = tlv_array;
+	u8 type, length, offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +252,10 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 }
 
 int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
-				  u8 *tlv_array, u16 tlv_array_len)
+				  const u8 *tlv_array, u16 tlv_array_len)
 {
-	u8 *tlv = tlv_array, type, length, offset = 0;
+	const u8 *tlv = tlv_array;
+	u8 type, length, offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -307,7 +309,7 @@ static struct sk_buff *llcp_add_header(struct sk_buff *pdu,
 	return pdu;
 }
 
-static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, u8 *tlv,
+static struct sk_buff *llcp_add_tlv(struct sk_buff *pdu, const u8 *tlv,
 				    u8 tlv_length)
 {
 	/* XXX Add an skb length check */
@@ -401,9 +403,10 @@ int nfc_llcp_send_connect(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local;
 	struct sk_buff *skb;
-	u8 *service_name_tlv = NULL, service_name_tlv_length;
-	u8 *miux_tlv = NULL, miux_tlv_length;
-	u8 *rw_tlv = NULL, rw_tlv_length, rw;
+	const u8 *service_name_tlv = NULL;
+	const u8 *miux_tlv = NULL;
+	const u8 *rw_tlv = NULL;
+	u8 service_name_tlv_length, miux_tlv_length,  rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
@@ -477,8 +480,9 @@ int nfc_llcp_send_cc(struct nfc_llcp_sock *sock)
 {
 	struct nfc_llcp_local *local;
 	struct sk_buff *skb;
-	u8 *miux_tlv = NULL, miux_tlv_length;
-	u8 *rw_tlv = NULL, rw_tlv_length, rw;
+	const u8 *miux_tlv = NULL;
+	const u8 *rw_tlv = NULL;
+	u8 miux_tlv_length, rw_tlv_length, rw;
 	int err;
 	u16 size = 0;
 	__be16 miux;
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 3290f2275b857..bdc1a9d0965af 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -314,7 +314,7 @@ static char *wks[] = {
 	"urn:nfc:sn:snep",
 };
 
-static int nfc_llcp_wks_sap(char *service_name, size_t service_name_len)
+static int nfc_llcp_wks_sap(const char *service_name, size_t service_name_len)
 {
 	int sap, num_wks;
 
@@ -338,7 +338,7 @@ static int nfc_llcp_wks_sap(char *service_name, size_t service_name_len)
 
 static
 struct nfc_llcp_sock *nfc_llcp_sock_from_sn(struct nfc_llcp_local *local,
-					    u8 *sn, size_t sn_len)
+					    const u8 *sn, size_t sn_len)
 {
 	struct sock *sk;
 	struct nfc_llcp_sock *llcp_sock, *tmp_sock;
@@ -535,7 +535,7 @@ static int nfc_llcp_build_gb(struct nfc_llcp_local *local)
 {
 	u8 *gb_cur, version, version_length;
 	u8 lto_length, wks_length, miux_length;
-	u8 *version_tlv = NULL, *lto_tlv = NULL,
+	const u8 *version_tlv = NULL, *lto_tlv = NULL,
 	   *wks_tlv = NULL, *miux_tlv = NULL;
 	__be16 wks = cpu_to_be16(local->local_wks);
 	u8 gb_len = 0;
@@ -625,7 +625,7 @@ u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len)
 	return local->gb;
 }
 
-int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len)
+int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len)
 {
 	struct nfc_llcp_local *local;
 
@@ -652,27 +652,27 @@ int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len)
 				     local->remote_gb_len - 3);
 }
 
-static u8 nfc_llcp_dsap(struct sk_buff *pdu)
+static u8 nfc_llcp_dsap(const struct sk_buff *pdu)
 {
 	return (pdu->data[0] & 0xfc) >> 2;
 }
 
-static u8 nfc_llcp_ptype(struct sk_buff *pdu)
+static u8 nfc_llcp_ptype(const struct sk_buff *pdu)
 {
 	return ((pdu->data[0] & 0x03) << 2) | ((pdu->data[1] & 0xc0) >> 6);
 }
 
-static u8 nfc_llcp_ssap(struct sk_buff *pdu)
+static u8 nfc_llcp_ssap(const struct sk_buff *pdu)
 {
 	return pdu->data[1] & 0x3f;
 }
 
-static u8 nfc_llcp_ns(struct sk_buff *pdu)
+static u8 nfc_llcp_ns(const struct sk_buff *pdu)
 {
 	return pdu->data[2] >> 4;
 }
 
-static u8 nfc_llcp_nr(struct sk_buff *pdu)
+static u8 nfc_llcp_nr(const struct sk_buff *pdu)
 {
 	return pdu->data[2] & 0xf;
 }
@@ -814,7 +814,7 @@ static struct nfc_llcp_sock *nfc_llcp_connecting_sock_get(struct nfc_llcp_local
 }
 
 static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
-						  u8 *sn, size_t sn_len)
+						  const u8 *sn, size_t sn_len)
 {
 	struct nfc_llcp_sock *llcp_sock;
 
@@ -828,9 +828,10 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 	return llcp_sock;
 }
 
-static u8 *nfc_llcp_connect_sn(struct sk_buff *skb, size_t *sn_len)
+static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
-	u8 *tlv = &skb->data[2], type, length;
+	u8 type, length;
+	const u8 *tlv = &skb->data[2];
 	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
 
 	while (offset < tlv_array_len) {
@@ -888,7 +889,7 @@ static void nfc_llcp_recv_ui(struct nfc_llcp_local *local,
 }
 
 static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
-				  struct sk_buff *skb)
+				  const struct sk_buff *skb)
 {
 	struct sock *new_sk, *parent;
 	struct nfc_llcp_sock *sock, *new_sock;
@@ -906,7 +907,7 @@ static void nfc_llcp_recv_connect(struct nfc_llcp_local *local,
 			goto fail;
 		}
 	} else {
-		u8 *sn;
+		const u8 *sn;
 		size_t sn_len;
 
 		sn = nfc_llcp_connect_sn(skb, &sn_len);
@@ -1125,7 +1126,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 }
 
 static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
-			       struct sk_buff *skb)
+			       const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1168,7 +1169,8 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-static void nfc_llcp_recv_cc(struct nfc_llcp_local *local, struct sk_buff *skb)
+static void nfc_llcp_recv_cc(struct nfc_llcp_local *local,
+			     const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1201,7 +1203,8 @@ static void nfc_llcp_recv_cc(struct nfc_llcp_local *local, struct sk_buff *skb)
 	nfc_llcp_sock_put(llcp_sock);
 }
 
-static void nfc_llcp_recv_dm(struct nfc_llcp_local *local, struct sk_buff *skb)
+static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
+			     const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
 	struct sock *sk;
@@ -1239,12 +1242,13 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local, struct sk_buff *skb)
 }
 
 static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
-			      struct sk_buff *skb)
+			      const struct sk_buff *skb)
 {
 	struct nfc_llcp_sock *llcp_sock;
-	u8 dsap, ssap, *tlv, type, length, tid, sap;
+	u8 dsap, ssap, type, length, tid, sap;
+	const u8 *tlv;
 	u16 tlv_len, offset;
-	char *service_name;
+	const char *service_name;
 	size_t service_name_len;
 	struct nfc_llcp_sdp_tlv *sdp;
 	HLIST_HEAD(llc_sdres_list);
diff --git a/net/nfc/nfc.h b/net/nfc/nfc.h
index 6c6f76b370b1e..c792165f523f1 100644
--- a/net/nfc/nfc.h
+++ b/net/nfc/nfc.h
@@ -60,7 +60,7 @@ void nfc_llcp_mac_is_up(struct nfc_dev *dev, u32 target_idx,
 			u8 comm_mode, u8 rf_mode);
 int nfc_llcp_register_device(struct nfc_dev *dev);
 void nfc_llcp_unregister_device(struct nfc_dev *dev);
-int nfc_llcp_set_remote_gb(struct nfc_dev *dev, u8 *gb, u8 gb_len);
+int nfc_llcp_set_remote_gb(struct nfc_dev *dev, const u8 *gb, u8 gb_len);
 u8 *nfc_llcp_general_bytes(struct nfc_dev *dev, size_t *general_bytes_len);
 int nfc_llcp_data_received(struct nfc_dev *dev, struct sk_buff *skb);
 struct nfc_llcp_local *nfc_llcp_find_local(struct nfc_dev *dev);
-- 
2.39.2



