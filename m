Return-Path: <stable+bounces-190147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5EF9C100BF
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 19:44:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFBD19C8059
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C0431CA4A;
	Mon, 27 Oct 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jW9p/6aY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E931B824;
	Mon, 27 Oct 2025 18:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761590563; cv=none; b=TTwk5wY7KreofWR04bgrwESqg6oeRIzw+C5GcToj8XjsFAZZ/nrOfX3q1/4RECacNDd/8gepfsbsd8SrVd1ChI65G1BiONRXhvWu0HFAFddfcGiFXt3ZBhUOGy7gWxKNhFOodP6t2eoV6OvJ6q3AL3d4lHeMIqvznMjyblJ+7uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761590563; c=relaxed/simple;
	bh=TyQ2tRkzPOtiWWCFbV7tRcrnJdFP6w+Kt3cwiPhgCTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aB+50dYa8NSPjxSIwH07LRjHuctDI4s3hI0MOEHMVd3alRbJumzpAQL/zWh8+SaaaaJ64W2EdV5I1VowtfioTVheFRtbFjFMVlUzlc86ifpe9IwL9k3IHrUkC7Y7EXgR6itu53y0de9FPgrv85E56wRooDLceE9Hu/wFaZbi9mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jW9p/6aY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AA2CC4CEFD;
	Mon, 27 Oct 2025 18:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761590563;
	bh=TyQ2tRkzPOtiWWCFbV7tRcrnJdFP6w+Kt3cwiPhgCTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jW9p/6aYEnQ0fjEbhm4D4FJ5rW5BbokAywom1+x8Fp7r4Sq91pNcN/ADxtwPI+sQu
	 51+RQvyIGLFdoh/prKf8IyJ6nAnk9pFiVNRM93o2Vhu18tIzM3sxDUy7rQyBWbYzQG
	 DLEaj0WY8srIBCOw4msKv+DH7CIHjXfxUfg1qGCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandr Sapozhnikov <alsp705@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 091/224] net/sctp: fix a null dereference in sctp_disposition sctp_sf_do_5_1D_ce()
Date: Mon, 27 Oct 2025 19:33:57 +0100
Message-ID: <20251027183511.427614539@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183508.963233542@linuxfoundation.org>
References: <20251027183508.963233542@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandr Sapozhnikov <alsp705@gmail.com>

[ Upstream commit 2f3119686ef50319490ccaec81a575973da98815 ]

If new_asoc->peer.adaptation_ind=0 and sctp_ulpevent_make_authkey=0
and sctp_ulpevent_make_authkey() returns 0, then the variable
ai_ev remains zero and the zero will be dereferenced
in the sctp_ulpevent_free() function.

Signed-off-by: Alexandr Sapozhnikov <alsp705@gmail.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
Fixes: 30f6ebf65bc4 ("sctp: add SCTP_AUTH_NO_AUTH type for AUTHENTICATION_EVENT")
Link: https://patch.msgid.link/20251002091448.11-1-alsp705@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sctp/sm_statefuns.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/sm_statefuns.c b/net/sctp/sm_statefuns.c
index 6b613569372a0..9c714a6c93076 100644
--- a/net/sctp/sm_statefuns.c
+++ b/net/sctp/sm_statefuns.c
@@ -873,7 +873,8 @@ enum sctp_disposition sctp_sf_do_5_1D_ce(struct net *net,
 	return SCTP_DISPOSITION_CONSUME;
 
 nomem_authev:
-	sctp_ulpevent_free(ai_ev);
+	if (ai_ev)
+		sctp_ulpevent_free(ai_ev);
 nomem_aiev:
 	sctp_ulpevent_free(ev);
 nomem_ev:
-- 
2.51.0




