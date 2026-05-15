Return-Path: <stable+bounces-247832-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yI0WIJU8B2ottwIAu9opvQ
	(envelope-from <stable+bounces-247832-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:32:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A375522C1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 17:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B6690302BB96
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10E5495527;
	Fri, 15 May 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SIRYQ2ME"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9D844D018
	for <stable@vger.kernel.org>; Fri, 15 May 2026 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859110; cv=none; b=iv+G55bBzm6C2XOAszjst5oxK9gZCQqbvlqnsDBy3tVtCEuBeSmehaBauHEq7SMDsdXr2eXGx7NfxiT7/MF8dE37uP0ajWFsELVcA5gPkXBZxTsC0mn5j4T2AZ7lcCl+Alm1YIPxd8TszkvrTWDeO0MzVbDxiqIIccY0S5J2uY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859110; c=relaxed/simple;
	bh=7DxZDOE300QfT6uZq0Zr5RrP2VtaLS639LIyu7Qc630=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EZzHUL299lo3DEyjUXW6dX7N2NzowtM4Upg5icaWD1wpMpddcA1ljh00eAwrha5b1Ic1zvvqmaWqFI1WFUKtflFZ0B6nh7nXZbfgLjiarPX4gz5zXtuWxJYuUHtUnx4qyXigEnFdsAHd3ESPS0KySmWN9xuEbCs0w2+JceBHKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SIRYQ2ME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CECC2BCB0;
	Fri, 15 May 2026 15:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778859110;
	bh=7DxZDOE300QfT6uZq0Zr5RrP2VtaLS639LIyu7Qc630=;
	h=Subject:To:Cc:From:Date:From;
	b=SIRYQ2MEL5+fyqFsf4qxw5iQ4UnHLM1oZw6FZJWSC5Y8bgo/AwgR6TuuLp8kxnniE
	 SYHZgZb99QrcXl36FZBsVktr9J/mu42p51NSliQLHSqTwy2J6W346zspnjOvA/1/bQ
	 7LpAOLBgfRG6vYqDG56icXCLWU8pconeZP91lxH0=
Subject: FAILED: patch "[PATCH] ipmi:ssif: NULL thread on error" failed to apply to 6.1-stable tree
To: corey@minyard.net,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 17:31:41 +0200
Message-ID: <2026051541-deflate-babbling-1b5b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 11A375522C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247832-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,minyard.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x a8aebe93a4938c0ca1941eeaae821738f869be3d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051541-deflate-babbling-1b5b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a8aebe93a4938c0ca1941eeaae821738f869be3d Mon Sep 17 00:00:00 2001
From: Corey Minyard <corey@minyard.net>
Date: Tue, 21 Apr 2026 06:50:22 -0500
Subject: [PATCH] ipmi:ssif: NULL thread on error

Cleanup code was checking the thread for NULL, but it was possibly
a PTR_ERR() in one spot.

Spotted with static analysis.

Link: https://sourceforge.net/p/openipmi/mailman/message/59324676/
Fixes: 75c486cb1bca ("ipmi:ssif: Clean up kthread on errors")
Cc: <stable@vger.kernel.org> # 91eb7ec72612: ipmi:ssif: Remove unnecessary indention
Cc: stable@vger.kernel.org
Signed-off-by: Corey Minyard <corey@minyard.net>

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index f3798f4e6a63..f419b46bf002 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1905,6 +1905,7 @@ static int ssif_probe(struct i2c_client *client)
 					"kssif%4.4x", thread_num);
 	if (IS_ERR(ssif_info->thread)) {
 		rv = PTR_ERR(ssif_info->thread);
+		ssif_info->thread = NULL;
 		dev_notice(&ssif_info->client->dev,
 			   "Could not start kernel thread: error %d\n",
 			   rv);


