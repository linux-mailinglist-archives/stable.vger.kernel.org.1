Return-Path: <stable+bounces-7220-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7F817178
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 14:58:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F489281997
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 13:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77313129EE3;
	Mon, 18 Dec 2023 13:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1lfVvpGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFED129EF7;
	Mon, 18 Dec 2023 13:58:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2C1C433C7;
	Mon, 18 Dec 2023 13:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702907887;
	bh=/EVAQ2JPK+93EOHD6jfji7T4gSxiyekL0A8vEePour4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1lfVvpGabRHG950zcPOT3A6GY8HPGPq8A0tfpNFbnkuW40dskB45mpddbwvj1JlU2
	 cAtpxYnW2r1B5C5kz/aaC6rzScIW6I/xk382EeqzfX+0uCA6CUpXotkGq9Z9Jf5sCH
	 uimWWiRt1IM81hegxSZvQz3nBFhiY2sKYIkoHgGY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florent Revest <revest@chromium.org>,
	Jiri Pirko <jiri@nvidia.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 082/106] team: Fix use-after-free when an option instance allocation fails
Date: Mon, 18 Dec 2023 14:51:36 +0100
Message-ID: <20231218135058.562380681@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218135055.005497074@linuxfoundation.org>
References: <20231218135055.005497074@linuxfoundation.org>
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

From: Florent Revest <revest@chromium.org>

commit c12296bbecc488623b7d1932080e394d08f3226b upstream.

In __team_options_register, team_options are allocated and appended to
the team's option_list.
If one option instance allocation fails, the "inst_rollback" cleanup
path frees the previously allocated options but doesn't remove them from
the team's option_list.
This leaves dangling pointers that can be dereferenced later by other
parts of the team driver that iterate over options.

This patch fixes the cleanup path to remove the dangling pointers from
the list.

As far as I can tell, this uaf doesn't have much security implications
since it would be fairly hard to exploit (an attacker would need to make
the allocation of that specific small object fail) but it's still nice
to fix.

Cc: stable@vger.kernel.org
Fixes: 80f7c6683fe0 ("team: add support for per-port options")
Signed-off-by: Florent Revest <revest@chromium.org>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20231206123719.1963153-1-revest@chromium.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -285,8 +285,10 @@ static int __team_options_register(struc
 	return 0;
 
 inst_rollback:
-	for (i--; i >= 0; i--)
+	for (i--; i >= 0; i--) {
 		__team_option_inst_del_option(team, dst_opts[i]);
+		list_del(&dst_opts[i]->list);
+	}
 
 	i = option_count;
 alloc_rollback:



