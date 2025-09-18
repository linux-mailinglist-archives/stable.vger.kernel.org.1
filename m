Return-Path: <stable+bounces-170959-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E1B2A6F2
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:48:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61F22A5A6A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1288320381;
	Mon, 18 Aug 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZhID4EVs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B90C21FF5D;
	Mon, 18 Aug 2025 13:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755524354; cv=none; b=QY5D79n/2XGJeTIp+kt/W7pRdrZHmp+WFQKhwkFhtzQoS8dVRGSoJiOj9r12A3o7AzW6E/1uFUfVGmUJB0nLk1LM4XcgfJUxkZVF8L6Branbp12HW4NB8O2VRtbpXBOyTuaKyi5zNVsPKl4zsdlktvXRfgwFDNBt1OaHBwayszI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755524354; c=relaxed/simple;
	bh=wCM+W3PCx6jIoUtwzyQYHTU5UA3w+YzMoNPyk5KcRn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUz9QNjg/lRFz5xaopPCfzLmUv7XmSZOhkJATOpO4B+qcXV4wnv2LORt6HsVlnC0+5PfRhtsL7vZHyLj/r2Gl7D3OL0181blWlJDlAq5ZEz5DmPqxu5/saSt2GFzXcalXf+j9VyEXXY+JHztdkgg9nEIJ4gCBM1v1Z5Aq7Z3zJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZhID4EVs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8B1C4CEF1;
	Mon, 18 Aug 2025 13:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755524354;
	bh=wCM+W3PCx6jIoUtwzyQYHTU5UA3w+YzMoNPyk5KcRn0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhID4EVsuHayqsoBldks2t/uqjjIDz7CruCx+9yfRlkgkRULpZRq/bLMFGV3CzbDm
	 icQmDHqdzYaM4AfCJZhLQJ5QFl5SqEywO1qr6zTIwb5cmEuvdVnZswtUzxca0Mm/Yz
	 DTiruqC8WMoeOhpOEv+8yWL/oUkfMi5AaoikCbLE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 447/515] cifs: reset iface weights when we cannot find a candidate
Date: Mon, 18 Aug 2025 14:47:13 +0200
Message-ID: <20250818124515.632440947@linuxfoundation.org>
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

From: Shyam Prasad N <sprasad@microsoft.com>

commit 9d5eff7821f6d70f7d1b4d8a60680fba4de868a7 upstream.

We now do a weighted selection of server interfaces when allocating
new channels. The weights are decided based on the speed advertised.
The fulfilled weight for an interface is a counter that is used to
track the interface selection. It should be reset back to zero once
all interfaces fulfilling their weight.

In cifs_chan_update_iface, this reset logic was missing. As a result
when the server interface list changes, the client may not be able
to find a new candidate for other channels after all interfaces have
been fulfilled.

Fixes: a6d8fb54a515 ("cifs: distribute channels across interfaces based on speed")
Cc: <stable@vger.kernel.org>
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/sess.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/smb/client/sess.c
+++ b/fs/smb/client/sess.c
@@ -332,6 +332,7 @@ cifs_chan_update_iface(struct cifs_ses *
 	struct cifs_server_iface *old_iface = NULL;
 	struct cifs_server_iface *last_iface = NULL;
 	struct sockaddr_storage ss;
+	int retry = 0;
 
 	spin_lock(&ses->chan_lock);
 	chan_index = cifs_ses_get_chan_index(ses, server);
@@ -360,6 +361,7 @@ cifs_chan_update_iface(struct cifs_ses *
 		return;
 	}
 
+try_again:
 	last_iface = list_last_entry(&ses->iface_list, struct cifs_server_iface,
 				     iface_head);
 	iface_min_speed = last_iface->speed;
@@ -397,6 +399,13 @@ cifs_chan_update_iface(struct cifs_ses *
 	}
 
 	if (list_entry_is_head(iface, &ses->iface_list, iface_head)) {
+		list_for_each_entry(iface, &ses->iface_list, iface_head)
+			iface->weight_fulfilled = 0;
+
+		/* see if it can be satisfied in second attempt */
+		if (!retry++)
+			goto try_again;
+
 		iface = NULL;
 		cifs_dbg(FYI, "unable to find a suitable iface\n");
 	}



