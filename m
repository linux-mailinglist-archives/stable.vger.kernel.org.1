Return-Path: <stable+bounces-81390-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60090993413
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0ECCD1F2119B
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892991DC73B;
	Mon,  7 Oct 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xFS9tAIg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CEA1DC734
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319890; cv=none; b=rmK8GgOPw78Y7SKUlF+9c27WP+7zH8hfMyaH2Y8HJxyConB+lCldIYns0VnT/OuWbK5f/jwLMaTd9QJED8YNriJWo4TEkjT5aOHpIhC+QeMpK/IkJjaq+5mLm7xY9Lt9khhZvBSkEAghiBLv2d8e85v1/xg4Y4nnNIvTS+xd0lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319890; c=relaxed/simple;
	bh=QiMJlJUxWvfAdI+RqpkePRejpv/xDmd2MZtL6yEGYUY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZBh0OZfxQIf4AtoPOkPSBbUB2zDTa+aWYszQwPMxjCdobj7MWKPOYRHfT5sr40IFnib/YUbKwI6OgfOjmrdpO+dfRozXyyrJZj5yPM5J+4F+tg8HtE9PyaHpvtBoD7I/IcSIBM/AbFdrcFGUkUX3eu3XtxgJjQZXs5ZCAUxhAfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xFS9tAIg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC08C4CED3;
	Mon,  7 Oct 2024 16:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319889;
	bh=QiMJlJUxWvfAdI+RqpkePRejpv/xDmd2MZtL6yEGYUY=;
	h=Subject:To:Cc:From:Date:From;
	b=xFS9tAIgp4vCWBvgL62/7dAe88BuTdFHgimBXD9QDmv7A/pPs7nkOZ+QFYQUcC1Uq
	 1HooENzw8L2n5oIAPFfTOZ8WpAtZTFLIuWFNXPNHIAgtA/ya8D1t+2/iwA9iMiQB3U
	 AyEkhvJdidRRv0WLQPd2b2rylW2YOjCwrb76YXIg=
Subject: FAILED: patch "[PATCH] clk: qcom: clk-rpmh: Fix overflow in BCM vote" failed to apply to 5.4-stable tree
To: quic_mdtipton@quicinc.com,andersson@kernel.org,quic_imrashai@quicinc.com,quic_tdas@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:51:19 +0200
Message-ID: <2024100719-exploring-umbrella-b6ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a4e5af27e6f6a8b0d14bc0d7eb04f4a6c7291586
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100719-exploring-umbrella-b6ca@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

a4e5af27e6f6 ("clk: qcom: clk-rpmh: Fix overflow in BCM vote")
2cf7a4cbcb4e ("clk: qcom: rpmh: Simplify clk_rpmh_bcm_send_cmd()")
dad4e7fda4bd ("clk: qcom: clk-rpmh: Wait for completion when enabling clocks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a4e5af27e6f6a8b0d14bc0d7eb04f4a6c7291586 Mon Sep 17 00:00:00 2001
From: Mike Tipton <quic_mdtipton@quicinc.com>
Date: Fri, 9 Aug 2024 10:51:29 +0530
Subject: [PATCH] clk: qcom: clk-rpmh: Fix overflow in BCM vote

Valid frequencies may result in BCM votes that exceed the max HW value.
Set vote ceiling to BCM_TCS_CMD_VOTE_MASK to ensure the votes aren't
truncated, which can result in lower frequencies than desired.

Fixes: 04053f4d23a4 ("clk: qcom: clk-rpmh: Add IPA clock support")
Cc: stable@vger.kernel.org
Signed-off-by: Mike Tipton <quic_mdtipton@quicinc.com>
Reviewed-by: Taniya Das <quic_tdas@quicinc.com>
Signed-off-by: Imran Shaik <quic_imrashai@quicinc.com>
Link: https://lore.kernel.org/r/20240809-clk-rpmh-bcm-vote-fix-v2-1-240c584b7ef9@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/clk-rpmh.c b/drivers/clk/qcom/clk-rpmh.c
index bb82abeed88f..4acde937114a 100644
--- a/drivers/clk/qcom/clk-rpmh.c
+++ b/drivers/clk/qcom/clk-rpmh.c
@@ -263,6 +263,8 @@ static int clk_rpmh_bcm_send_cmd(struct clk_rpmh *c, bool enable)
 		cmd_state = 0;
 	}
 
+	cmd_state = min(cmd_state, BCM_TCS_CMD_VOTE_MASK);
+
 	if (c->last_sent_aggr_state != cmd_state) {
 		cmd.addr = c->res_addr;
 		cmd.data = BCM_TCS_CMD(1, enable, 0, cmd_state);


