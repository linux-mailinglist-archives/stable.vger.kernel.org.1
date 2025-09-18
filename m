Return-Path: <stable+bounces-170526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B70AB2A49F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 15:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9710217761A
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 13:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A6032274B;
	Mon, 18 Aug 2025 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0mihjjoA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5806321433;
	Mon, 18 Aug 2025 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755522926; cv=none; b=VnhR3JG7cj7LVvXZPDfW+vneyFBg3YsoYFgDi72JgCEGs6P5nUEBMZc2xpkMk4B+ZTDMkDEDu0Nbo3oZcPSg/FvuOtffirt9GomKVdwB1VwXh2DtFH+AcZ3MoLPuZP0DDSv/84CPA/5jBG7hUjjJ3j0C0fdv7uWWZA8yh0Hmkzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755522926; c=relaxed/simple;
	bh=JTMPMKEzwiTthrH1N4t+pi1ErMv/D7aMjFIkVViFSUE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IbMB2z7YsB9WCqGNNNwhil6vzhgKGqWGr6Vp8PpPvl0nL6AvN23f0O5B4wQTvU/fkBA+6kd9NqGoNmzoyl6liOGu+ofrBBpJSN8NAgVN5W4NRijAiI0op8l1KPCwhSq0yumjfvbraOfXDo5Ff+dv6SWkoZ0bSMLRxrj/5bDOo9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0mihjjoA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 423BBC4CEF1;
	Mon, 18 Aug 2025 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755522926;
	bh=JTMPMKEzwiTthrH1N4t+pi1ErMv/D7aMjFIkVViFSUE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0mihjjoA+yq0pYodwkpM29IvM1vVggmhs4FLCdNGfRsPVJJYBrFoM9OTRzPZbcBAE
	 O/asgwGSF07DP9VTC87X+14uun7LlxCvL6Om2raYaCerlClTp52lr8ilkY7lOdBqtH
	 /yKupkjAzYIGEri6QMh5y15EM5ctWDlv7ySix3hg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	Wang Zhaolong <wangzhaolong@huaweicloud.com>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.15 010/515] smb: client: remove redundant lstrp update in negotiate protocol
Date: Mon, 18 Aug 2025 14:39:56 +0200
Message-ID: <20250818124458.723618013@linuxfoundation.org>
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

From: Wang Zhaolong <wangzhaolong@huaweicloud.com>

commit e19d8dd694d261ac26adb2a26121a37c107c81ad upstream.

Commit 34331d7beed7 ("smb: client: fix first command failure during
re-negotiation") addressed a race condition by updating lstrp before
entering negotiate state. However, this approach may have some unintended
side effects.

The lstrp field is documented as "when we got last response from this
server", and updating it before actually receiving a server response
could potentially affect other mechanisms that rely on this timestamp.
For example, the SMB echo detection logic also uses lstrp as a reference
point. In scenarios with frequent user operations during reconnect states,
the repeated calls to cifs_negotiate_protocol() might continuously
update lstrp, which could interfere with the echo detection timing.

Additionally, commit 266b5d02e14f ("smb: client: fix race condition in
negotiate timeout by using more precise timing") introduced a dedicated
neg_start field specifically for tracking negotiate start time. This
provides a more precise solution for the original race condition while
preserving the intended semantics of lstrp.

Since the race condition is now properly handled by the neg_start
mechanism, the lstrp update in cifs_negotiate_protocol() is no longer
necessary and can be safely removed.

Fixes: 266b5d02e14f ("smb: client: fix race condition in negotiate timeout by using more precise timing")
Cc: stable@vger.kernel.org
Acked-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Signed-off-by: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/connect.c |    1 -
 1 file changed, 1 deletion(-)

--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4198,7 +4198,6 @@ retry:
 		return 0;
 	}
 
-	server->lstrp = jiffies;
 	server->tcpStatus = CifsInNegotiate;
 	server->neg_start = jiffies;
 	spin_unlock(&server->srv_lock);



