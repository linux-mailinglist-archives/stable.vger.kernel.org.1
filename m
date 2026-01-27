Return-Path: <stable+bounces-211763-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gHIsE/a4eGlzsQEAu9opvQ
	(envelope-from <stable+bounces-211763-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:09:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB29894AD2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1530730054FF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 13:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840373559F8;
	Tue, 27 Jan 2026 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fi+TNp8A"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EF93559E4
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769519343; cv=none; b=MqD5nwT0vDPI5oTxLLU3Tf0wMeFvvDWsiO7+v8svoaTlKjRnENFojJi6DcEcmpzhekgxVJIJzZSSACWMHEC9sX/m/Y/5BuhhATZY3Gg4gUzF3eMu5smZbBUPiSHTM/iLlp93rT6n7tQ809Sn92o8K8CNovGOkyCNJkKxxeJnQBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769519343; c=relaxed/simple;
	bh=8PxbLKnCI2bBI+JHih4NugbPdCWZepJh1fAYuLJVxdk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sKrcC+nEtsay1gYgcAw2w3s13K2BtGVncgv/awWeirLboy8O0SspXgRkj6c5pAIlGfKzlI2Nyy9MQbpgn1vbJ6InkTshjvueq4kTuM1KBuf53UcvIX4bbulUZ6p/dO13ZlFMUhWpBScFw8ZtlUwmQQYPLBpy3VnBILxFosaCTfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fi+TNp8A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B46EC16AAE;
	Tue, 27 Jan 2026 13:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769519342;
	bh=8PxbLKnCI2bBI+JHih4NugbPdCWZepJh1fAYuLJVxdk=;
	h=Subject:To:Cc:From:Date:From;
	b=Fi+TNp8AXyPr+WXLRnmok+11jFO6kMcXVpKHJ0475Kwfi0Ro0eF+wGSVM9I8TVwZl
	 O5+XnXyY5zbLjuE8CgSu1m0ipKdBQY86I2QLxUHqmA9teIIuY5MlKskukk+t1AK8kG
	 1v7m6yaXfVoSVqUgcbuCeaZB2AeLMOVDouJGysBg=
Subject: FAILED: patch "[PATCH] of: platform: Use default match table for /firmware" failed to apply to 5.10-stable tree
To: robh@kernel.org,sudeep.holla@arm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 27 Jan 2026 14:08:51 +0100
Message-ID: <2026012751-crescent-atlas-e3e1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211763-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,arm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: CB29894AD2
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 48e6a9c4a20870e09f85ff1a3628275d6bce31c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026012751-crescent-atlas-e3e1@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 48e6a9c4a20870e09f85ff1a3628275d6bce31c0 Mon Sep 17 00:00:00 2001
From: "Rob Herring (Arm)" <robh@kernel.org>
Date: Tue, 13 Jan 2026 19:51:58 -0600
Subject: [PATCH] of: platform: Use default match table for /firmware

Calling of_platform_populate() without a match table will only populate
the immediate child nodes under /firmware. This is usually fine, but in
the case of something like a "simple-mfd" node such as
"raspberrypi,bcm2835-firmware", those child nodes will not be populated.
And subsequent calls won't work either because the /firmware node is
marked as processed already.

Switch the call to of_platform_default_populate() to solve this problem.
It should be a nop for existing cases.

Fixes: 3aa0582fdb82 ("of: platform: populate /firmware/ node from of_platform_default_populate_init()")
Cc: stable@vger.kernel.org
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Link: https://patch.msgid.link/20260114015158.692170-2-robh@kernel.org
Signed-off-by: Rob Herring (Arm) <robh@kernel.org>

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index f77cb19973a5..a6dca3a005aa 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -569,7 +569,7 @@ static int __init of_platform_default_populate_init(void)
 
 		node = of_find_node_by_path("/firmware");
 		if (node) {
-			of_platform_populate(node, NULL, NULL, NULL);
+			of_platform_default_populate(node, NULL, NULL);
 			of_node_put(node);
 		}
 


