Return-Path: <stable+bounces-1796-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 403C37F8164
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B9F1C21621
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567E4364A5;
	Fri, 24 Nov 2023 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IW+3y+3/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0F33CC2;
	Fri, 24 Nov 2023 18:58:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70250C433C7;
	Fri, 24 Nov 2023 18:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852295;
	bh=EKPJ3W6lYczW5E/KjjHP1ydbBc58PprX3G8LgykpWrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IW+3y+3/o4GnW+A9+y86UF+Haox/3OFl3s9a/o9t1ZrByBVvtB5VHRenI9rTFL56X
	 69R/XSdeICO5NkTTchUNIIH55mGIXB9JtZVTKUujiOsLk87uoYlosMldTJdjc+23I6
	 522KZbOT56NsnWA6EIW+MuupYd8cPBoQTCCh9fvs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.1 274/372] cifs: force interface update before a fresh session setup
Date: Fri, 24 Nov 2023 17:51:01 +0000
Message-ID: <20231124172019.593377539@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shyam Prasad N <sprasad@microsoft.com>

commit d9a6d78096056a3cb5c5f07a730ab92f2f9ac4e6 upstream.

During a session reconnect, it is possible that the
server moved to another physical server (happens in case
of Azure files). So at this time, force a query of server
interfaces again (in case of multichannel session), such
that the secondary channels connect to the right
IP addresses (possibly updated now).

Cc: stable@vger.kernel.org
Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4205,8 +4205,12 @@ cifs_setup_session(const unsigned int xi
 	is_binding = !CIFS_ALL_CHANS_NEED_RECONNECT(ses);
 	spin_unlock(&ses->chan_lock);
 
-	if (!is_binding)
+	if (!is_binding) {
 		ses->ses_status = SES_IN_SETUP;
+
+		/* force iface_list refresh */
+		ses->iface_last_update = 0;
+	}
 	spin_unlock(&ses->ses_lock);
 
 	/* update ses ip_addr only for primary chan */



