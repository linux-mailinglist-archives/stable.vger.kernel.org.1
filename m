Return-Path: <stable+bounces-37594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0C289C643
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 16:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F9D6B2AE3E
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A0A7CF39;
	Mon,  8 Apr 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RHEF5MZI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483A7EEF2;
	Mon,  8 Apr 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712584691; cv=none; b=aj5uUJVitQ26MBAgTrAMTs6St0GgzZDR+FKeeIDd//Ljbsyb3he56Egt+j/DkrQWufEr9OZJtTWFu/3XyORcHsBP34IFPVkzTyPvp9CC1RuYmeavnpNw8q1nMPbxtnUqFB7yg4Pg0XBY0aqNIXqU8pbiQH48Q9tcfuq7Bc1ocis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712584691; c=relaxed/simple;
	bh=DgA7W/1lVFYHRJ9nl65Tno/j/a92M+YKFp3lQhCEA3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iHu3VjewVDBP5B1n80UB5EghCjYOJ6QNdJGf7KcXmBUFhve3cGacB6D38F2L5nOtfqqLmcfVgUujTfjkpACjAvuK7Eur+WiW+r8BuxtQmONHOZom2kFI+atsF56v+7uHrl2h0U9684dKs7Kyq/GLqAIJOonnbarZWOONEIbPDXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RHEF5MZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03BFC43390;
	Mon,  8 Apr 2024 13:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712584691;
	bh=DgA7W/1lVFYHRJ9nl65Tno/j/a92M+YKFp3lQhCEA3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RHEF5MZIu/RLyC9/cH6sXCxyi8Bei2IzNlPRJOb71hZkHqcon2ynn0W0JX+PNweq6
	 idIt4gIgvX7khtf5XpFP0GSWzsJ9unfy96GhirN06WEPYtZJQoNltWu7IpRCkGqYVN
	 E35Km+irPXMOmBp5hz1kvC5kz2crIB3zDprk24nU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 5.15 525/690] NFSD: copy the whole verifier in nfsd_copy_write_verifier
Date: Mon,  8 Apr 2024 14:56:31 +0200
Message-ID: <20240408125418.662552251@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125359.506372836@linuxfoundation.org>
References: <20240408125359.506372836@linuxfoundation.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 90d2175572470ba7f55da8447c72ddd4942923c4 ]

Currently, we're only memcpy'ing the first __be32. Ensure we copy into
both words.

Fixes: 91d2e9b56cf5 ("NFSD: Clean up the nfsd_net::nfssvc_boot field")
Reported-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfssvc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 325d3d3f12110..a0ecec54d3d7d 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -363,7 +363,7 @@ void nfsd_copy_write_verifier(__be32 verf[2], struct nfsd_net *nn)
 
 	do {
 		read_seqbegin_or_lock(&nn->writeverf_lock, &seq);
-		memcpy(verf, nn->writeverf, sizeof(*verf));
+		memcpy(verf, nn->writeverf, sizeof(nn->writeverf));
 	} while (need_seqretry(&nn->writeverf_lock, seq));
 	done_seqretry(&nn->writeverf_lock, seq);
 }
-- 
2.43.0




