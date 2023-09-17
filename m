Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A780C7A3933
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbjIQTqM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240012AbjIQTps (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:45:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA2B126
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:45:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50844C433C8;
        Sun, 17 Sep 2023 19:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979942;
        bh=edyz35JqxqQsRjpUoItkk+uy6lM1gghZYJxQiijhpY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uRY1hXs1FRZnQ85SUPuasl01GnHMc+rdQCSLx+pjZkHTWpA3JOjhY+TjHG3+Uf6ky
         fczcIpRn/00fi6tLJ/Ms2JbAH5bWoYuGiGobRMp+VN6pJajNp+cB5MH88W0wFainmq
         qfe/5Gf9PnehJdodNIIWvHVyYcAjZz56uffddS4g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.5 034/285] [SMB3] send channel sequence number in SMB3 requests after reconnects
Date:   Sun, 17 Sep 2023 21:10:34 +0200
Message-ID: <20230917191052.846967948@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Steve French <stfrench@microsoft.com>

commit 09ee7a3bf866c0fa5ee1914d2c65958559eb5b4c upstream.

The ChannelSequence field in the SMB3 header is supposed to be
increased after reconnect to allow the server to distinguish
requests from before and after the reconnect.  We had always
been setting it to zero.  There are cases where incrementing
ChannelSequence on requests after network reconnects can reduce
the chance of data corruptions.

See MS-SMB2 3.2.4.1 and 3.2.7.1

Signed-off-by: Steve French <stfrench@microsoft.com>
Cc: stable@vger.kernel.org # 5.16+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/cifsglob.h |    1 +
 fs/smb/client/connect.c  |    1 +
 fs/smb/client/smb2ops.c  |   11 ++++++++++-
 fs/smb/client/smb2pdu.c  |   11 +++++++++++
 fs/smb/common/smb2pdu.h  |   22 ++++++++++++++++++++++
 5 files changed, 45 insertions(+), 1 deletion(-)

--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -729,6 +729,7 @@ struct TCP_Server_Info {
 	 */
 #define CIFS_SERVER_IS_CHAN(server)	(!!(server)->primary_server)
 	struct TCP_Server_Info *primary_server;
+	__u16 channel_sequence_num;  /* incremented on primary channel on each chan reconnect */
 
 #ifdef CONFIG_CIFS_SWN_UPCALL
 	bool use_swn_dstaddr;
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1686,6 +1686,7 @@ cifs_get_tcp_session(struct smb3_fs_cont
 		ctx->target_rfc1001_name, RFC1001_NAME_LEN_WITH_NULL);
 	tcp_ses->session_estab = false;
 	tcp_ses->sequence_number = 0;
+	tcp_ses->channel_sequence_num = 0; /* only tracked for primary channel */
 	tcp_ses->reconnect_instance = 1;
 	tcp_ses->lstrp = jiffies;
 	tcp_ses->compress_algorithm = cpu_to_le16(ctx->compression);
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -172,8 +172,17 @@ smb2_set_credits(struct TCP_Server_Info
 
 	spin_lock(&server->req_lock);
 	server->credits = val;
-	if (val == 1)
+	if (val == 1) {
 		server->reconnect_instance++;
+		/*
+		 * ChannelSequence updated for all channels in primary channel so that consistent
+		 * across SMB3 requests sent on any channel. See MS-SMB2 3.2.4.1 and 3.2.7.1
+		 */
+		if (CIFS_SERVER_IS_CHAN(server))
+			server->primary_server->channel_sequence_num++;
+		else
+			server->channel_sequence_num++;
+	}
 	scredits = server->credits;
 	in_flight = server->in_flight;
 	spin_unlock(&server->req_lock);
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -88,9 +88,20 @@ smb2_hdr_assemble(struct smb2_hdr *shdr,
 		  const struct cifs_tcon *tcon,
 		  struct TCP_Server_Info *server)
 {
+	struct smb3_hdr_req *smb3_hdr;
 	shdr->ProtocolId = SMB2_PROTO_NUMBER;
 	shdr->StructureSize = cpu_to_le16(64);
 	shdr->Command = smb2_cmd;
+	if (server->dialect >= SMB30_PROT_ID) {
+		/* After reconnect SMB3 must set ChannelSequence on subsequent reqs */
+		smb3_hdr = (struct smb3_hdr_req *)shdr;
+		/* if primary channel is not set yet, use default channel for chan sequence num */
+		if (CIFS_SERVER_IS_CHAN(server))
+			smb3_hdr->ChannelSequence =
+				cpu_to_le16(server->primary_server->channel_sequence_num);
+		else
+			smb3_hdr->ChannelSequence = cpu_to_le16(server->channel_sequence_num);
+	}
 	if (server) {
 		spin_lock(&server->req_lock);
 		/* Request up to 10 credits but don't go over the limit. */
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -153,6 +153,28 @@ struct smb2_hdr {
 	__u8   Signature[16];
 } __packed;
 
+struct smb3_hdr_req {
+	__le32 ProtocolId;	/* 0xFE 'S' 'M' 'B' */
+	__le16 StructureSize;	/* 64 */
+	__le16 CreditCharge;	/* MBZ */
+	__le16 ChannelSequence; /* See MS-SMB2 3.2.4.1 and 3.2.7.1 */
+	__le16 Reserved;
+	__le16 Command;
+	__le16 CreditRequest;	/* CreditResponse */
+	__le32 Flags;
+	__le32 NextCommand;
+	__le64 MessageId;
+	union {
+		struct {
+			__le32 ProcessId;
+			__le32  TreeId;
+		} __packed SyncId;
+		__le64  AsyncId;
+	} __packed Id;
+	__le64  SessionId;
+	__u8   Signature[16];
+} __packed;
+
 struct smb2_pdu {
 	struct smb2_hdr hdr;
 	__le16 StructureSize2; /* size of wct area (varies, request specific) */


