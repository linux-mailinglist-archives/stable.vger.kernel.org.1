Return-Path: <stable+bounces-208851-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73537D2675E
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 18:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6940A31352A4
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5093B52ED;
	Thu, 15 Jan 2026 17:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aGApd0//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8425228D;
	Thu, 15 Jan 2026 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768497023; cv=none; b=hR9cKPvSOu2+HtShqaznumL2x410vwl1fFrGbkCXp9lN3IAfCtwQkdlUZbrUmBhFA0GWT3V96JPrfPSnKu4bmHNtdEHdzkSuI9l8w3R6ZLiytzMJ8u250Ny0Ylt3pt/fx19Zo5QT8pSbf5FtLaiE4bbaQg3yiygta5XvoDu+1W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768497023; c=relaxed/simple;
	bh=bvajCXpR/wEPPPIYPJOpsJ4UgRDX8Bp0kHASVgHU/jU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=umsnxcOLFSN4nm24+T3bNb3fR6Mdcp4ChUDVwUPh0yTPa3suVjTKPOQnK581DWorKjAA4Qh1bXqdtxGmxBTMoIA+iw6VF5kntf6upgsJdnQvd5SCx7rBS0Fy15ycu3nD8kxAYbMf0RetOCwLCE2HQaYny4nyBWkmw1pO938L4EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aGApd0//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EADC116D0;
	Thu, 15 Jan 2026 17:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768497023;
	bh=bvajCXpR/wEPPPIYPJOpsJ4UgRDX8Bp0kHASVgHU/jU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aGApd0//B2AEZO/QH6bugzFhUHBngaZqPpB5UmALghd3CdJLqDcX9PR+JjXS3wYI3
	 PTZncVOqCgPuMubDPhlGD+RRCEeFUYYyJibrhC4aTMe+/YEXc3SlH0cMh73U6yVvRO
	 t6q47hGN/ln2oXroH6/YL3m58xp20Qpju6KUHJlA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ziming zhang <ezrakiez@gmail.com>,
	Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.1 10/72] libceph: prevent potential out-of-bounds reads in handle_auth_done()
Date: Thu, 15 Jan 2026 17:48:20 +0100
Message-ID: <20260115164143.864858300@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164143.482647486@linuxfoundation.org>
References: <20260115164143.482647486@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ziming zhang <ezrakiez@gmail.com>

commit 818156caffbf55cb4d368f9c3cac64e458fb49c9 upstream.

Perform an explicit bounds check on payload_len to avoid a possible
out-of-bounds access in the callout.

[ idryomov: changelog ]

Cc: stable@vger.kernel.org
Signed-off-by: ziming zhang <ezrakiez@gmail.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ceph/messenger_v2.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ceph/messenger_v2.c
+++ b/net/ceph/messenger_v2.c
@@ -2187,7 +2187,9 @@ static int process_auth_done(struct ceph
 
 	ceph_decode_64_safe(&p, end, global_id, bad);
 	ceph_decode_32_safe(&p, end, con->v2.con_mode, bad);
+
 	ceph_decode_32_safe(&p, end, payload_len, bad);
+	ceph_decode_need(&p, end, payload_len, bad);
 
 	dout("%s con %p global_id %llu con_mode %d payload_len %d\n",
 	     __func__, con, global_id, con->v2.con_mode, payload_len);



