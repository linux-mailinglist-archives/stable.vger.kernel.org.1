Return-Path: <stable+bounces-170878-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34142B2A6A5
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:46:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9573B5803C0
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D49F322DAD;
	Mon, 18 Aug 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zUGqYtxv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46EDA2206AF;
	Mon, 18 Aug 2025 13:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524092; cv=none; b=mhbrq9fAHqiq/O84P0+vLBVQNPH1+aWPa1DPFkc8os/BvC70KRWysIK3nUcfuJDuiFqNAV5FYjywLC81rEhJyx6n3AK3Arn4e/1A5OLBoayZ53Ax19zaolYyagP1kfMtJ5LiFG5cuFl1q+TILh13MZYm+fAX7g+Luz4X0twkA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524092; c=relaxed/simple;
	bh=XGj9quBjVw+uok/kcuJrIehuBxpYrEuz5s1hDZkH7HY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=th3tz59ftOL+y6mkHLq5uBo/OuZ3FZaGi4ojz6QrJoTf6W3e8WDePwQSImachh1p8Ou20iEei+5Fzp0dHpDzEbId1b0EL2oQ4Wf9VkmeElD7UJZTQsy3fqXQbQ+fLzoP/zRXut5LEAzeRUBIFJw3+IikLcjRvvOat87vlwH22W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zUGqYtxv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA59C4CEEB;
	Mon, 18 Aug 2025 13:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524092;
	bh=XGj9quBjVw+uok/kcuJrIehuBxpYrEuz5s1hDZkH7HY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zUGqYtxv2ikimw+cvG8eREJ8o1Uq3fDOm81V88tqg3sLhPWcgn8t4zUOYhfEIbP28
	 q7BLcOI3d7+OjSotDZ9CQ9xjxz9AhGqMUgBWzWDly2rmPUFZolbrohWxGnW/tF4f8H
	 U1JYo3c+Xal2SiGIvzMSLVf14JbZaQ/5Gy4zt1kk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	Pierguido Lambri <plambri@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15 333/515] smb: client: fix session setup against servers that require SPN
Date: Mon, 18 Aug 2025 14:45:19 +0200
Message-ID: <20250818124511.248546758@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124458.334548733@linuxfoundation.org>
References: <20250818124458.334548733@linuxfoundation.org>
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

6.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit 33cfdd726381828b9907a61c038a9f48b6690a31 ]

Some servers might enforce the SPN to be set in the target info
blob (AV pairs) when sending NTLMSSP_AUTH message.  In Windows Server,
this could be enforced with SmbServerNameHardeningLevel set to 2.

Fix this by always appending SPN (cifs/<hostname>) to the existing
list of target infos when setting up NTLMv2 response blob.

Cc: linux-cifs@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>
Reported-by: Pierguido Lambri <plambri@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsencrypt.c | 79 ++++++++++++++++++++++++++++---------
 1 file changed, 61 insertions(+), 18 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 6be850d2a346..3cc686246908 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -532,17 +532,67 @@ CalcNTLMv2_response(const struct cifs_ses *ses, char *ntlmv2_hash, struct shash_
 	return rc;
 }
 
+/*
+ * Set up NTLMv2 response blob with SPN (cifs/<hostname>) appended to the
+ * existing list of AV pairs.
+ */
+static int set_auth_key_response(struct cifs_ses *ses)
+{
+	size_t baselen = CIFS_SESS_KEY_SIZE + sizeof(struct ntlmv2_resp);
+	size_t len, spnlen, tilen = 0, num_avs = 2 /* SPN + EOL */;
+	struct TCP_Server_Info *server = ses->server;
+	char *spn __free(kfree) = NULL;
+	struct ntlmssp2_name *av;
+	char *rsp = NULL;
+	int rc;
+
+	spnlen = strlen(server->hostname);
+	len = sizeof("cifs/") + spnlen;
+	spn = kmalloc(len, GFP_KERNEL);
+	if (!spn) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	spnlen = scnprintf(spn, len, "cifs/%.*s",
+			   (int)spnlen, server->hostname);
+
+	av_for_each_entry(ses, av)
+		tilen += sizeof(*av) + AV_LEN(av);
+
+	len = baselen + tilen + spnlen * sizeof(__le16) + num_avs * sizeof(*av);
+	rsp = kmalloc(len, GFP_KERNEL);
+	if (!rsp) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	memcpy(rsp + baselen, ses->auth_key.response, tilen);
+	av = (void *)(rsp + baselen + tilen);
+	av->type = cpu_to_le16(NTLMSSP_AV_TARGET_NAME);
+	av->length = cpu_to_le16(spnlen * sizeof(__le16));
+	cifs_strtoUTF16((__le16 *)av->data, spn, spnlen, ses->local_nls);
+	av = (void *)((__u8 *)av + sizeof(*av) + AV_LEN(av));
+	av->type = cpu_to_le16(NTLMSSP_AV_EOL);
+	av->length = 0;
+
+	rc = 0;
+	ses->auth_key.len = len;
+out:
+	ses->auth_key.response = rsp;
+	return rc;
+}
+
 int
 setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 {
 	struct shash_desc *hmacmd5 = NULL;
-	int rc;
-	int baselen;
-	unsigned int tilen;
+	unsigned char *tiblob = NULL; /* target info blob */
 	struct ntlmv2_resp *ntlmv2;
 	char ntlmv2_hash[16];
-	unsigned char *tiblob = NULL; /* target info blob */
 	__le64 rsp_timestamp;
+	__u64 cc;
+	int rc;
 
 	if (nls_cp == NULL) {
 		cifs_dbg(VFS, "%s called with nls_cp==NULL\n", __func__);
@@ -588,32 +638,25 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 	 * (as Windows 7 does)
 	 */
 	rsp_timestamp = find_timestamp(ses);
+	get_random_bytes(&cc, sizeof(cc));
 
-	baselen = CIFS_SESS_KEY_SIZE + sizeof(struct ntlmv2_resp);
-	tilen = ses->auth_key.len;
-	tiblob = ses->auth_key.response;
+	cifs_server_lock(ses->server);
 
-	ses->auth_key.response = kmalloc(baselen + tilen, GFP_KERNEL);
-	if (!ses->auth_key.response) {
-		rc = -ENOMEM;
+	tiblob = ses->auth_key.response;
+	rc = set_auth_key_response(ses);
+	if (rc) {
 		ses->auth_key.len = 0;
-		goto setup_ntlmv2_rsp_ret;
+		goto unlock;
 	}
-	ses->auth_key.len += baselen;
 
 	ntlmv2 = (struct ntlmv2_resp *)
 			(ses->auth_key.response + CIFS_SESS_KEY_SIZE);
 	ntlmv2->blob_signature = cpu_to_le32(0x00000101);
 	ntlmv2->reserved = 0;
 	ntlmv2->time = rsp_timestamp;
-
-	get_random_bytes(&ntlmv2->client_chal, sizeof(ntlmv2->client_chal));
+	ntlmv2->client_chal = cc;
 	ntlmv2->reserved2 = 0;
 
-	memcpy(ses->auth_key.response + baselen, tiblob, tilen);
-
-	cifs_server_lock(ses->server);
-
 	rc = cifs_alloc_hash("hmac(md5)", &hmacmd5);
 	if (rc) {
 		cifs_dbg(VFS, "Could not allocate HMAC-MD5, rc=%d\n", rc);
-- 
2.39.5




