Return-Path: <stable+bounces-223519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MHwpMnKermm2GwIAu9opvQ
	(envelope-from <stable+bounces-223519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:18:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AAE8236E24
	for <lists+stable@lfdr.de>; Mon, 09 Mar 2026 11:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA8B8305187A
	for <lists+stable@lfdr.de>; Mon,  9 Mar 2026 10:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FC338F225;
	Mon,  9 Mar 2026 10:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="dR6g7Qig"
X-Original-To: stable@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2143E38BF9B;
	Mon,  9 Mar 2026 10:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773051460; cv=none; b=h7BrwpTxH2kOYme6sW5V/b/uFynmRnPXuVRcUpmWm6eBGqIb2J+aJWIcQnhuNt25E8EpGI9gk9ZFnsfvoM/kTVeQs/qADn5LJSkvt4eUHCkOFK7wotj9RNgf989RbTDbaAj/YCv9xn7eU0uhzjDpqDpNII7Bddgz7BWLvDM43l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773051460; c=relaxed/simple;
	bh=jdPu0HqyJ5sMUjFMOqS4w7rUOTFtY9n2nGCfQuXEmUo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mGBg1++OB5A1bGhGvN/FGd8aG//Rl9vEndMjZk7P/G1CvIvFCXO+Ls3OXF0Z1b/sbqiA4CUHQgg7QsT3itMwM60MDwtUlViciUdZrvijK4s3RHDDMKsQNJrovd9yGdac080u4QNF1SRGYN9NGwDDpNpB9MQq3Asvb7Q7OsBOdQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=dR6g7Qig; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=DrEYVGuudogEhHZtJ/Az32hXqOkfqaHHWKEnaGG5YC4=; b=dR6g7QigspSkR0JZHr+cRxhAv2
	JnUroU/SbdsUSSlDEDMSN4hkkspIYdv40DXZ42KFFD0z+Z1YCKhpvwWCrbuwX6WxB9G47JwiM1FAD
	/SDZNxjNoNmrWd9wXn953Lzz5X0darVK27BK6+mhAsBDRMK0TNn9MYKmKyDPh2iIpzodRqgUUm+r0
	SLFgqUHeF1nTlH1qgLRt2TDRg14u9gEt4sNJL+VV7wLKB0rFweoXJFMtNlrTo2ibGogZgdbRunZLD
	v05DnBm9tYK/Btiaaq1eAAxFv8NRr6jVvEnCwK+Z3GnfXYuhSmoYb/0TIYScVuuBcwrrj9MiI+e0K
	fCQrknVg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1vzXg3-0029Du-Lg; Mon, 09 Mar 2026 10:17:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Mar 2026 03:16:13 -0700
Subject: [PATCH stable] ipmi: Fix use-after-free and list corruption on
 sender error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260309-ipmi_stable-v1-1-be09c9686671@debian.org>
X-B4-Tracking: v=1; b=H4sIAO2drmkC/yXMUQqDQAxF0a2E9+3AqCh2tlKKGI2a0lqZqBTEv
 Zfq7+VydphEFUOgHVE2Nf1MCJQmhHZspkGcdgiEzGelz/3N6fzW2paGX+K4k5S5L6oiL5EQ5ii
 9fk/tjuvB4+q28lPa5U/hOH4M26szdwAAAA==
X-Change-ID: 20260309-ipmi_stable-bde1bbf58536
To: stable@kernel.org, Sasha Levin <sashal@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Corey Minyard <corey@minyard.net>, 
 openipmi-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 Vlad Poenaru <thevlad@meta.com>, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>, stable@vger.kernel.org
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2667; i=leitao@debian.org;
 h=from:subject:message-id; bh=RRSZISaBjsFC609Wiw9cIM591rHRlNy72ILWPcDiQoQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBprp44Bzhtgo2F8yIrnQCic9okRq6bX0+OSsxOw
 b2av9GdvsqJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaa6eOAAKCRA1o5Of/Hh3
 bZVeD/9fJV+zm8uE086rCRcqVndYw7inNb24WYntELsUbAI7lcWSN7xnOFypBP08qOz+91AlrSN
 3v5xukGmJUoW8npTpWbFw5DhGA8l/quddwL0h29gvx+ydjL3vOHmKWFfni/YsnVrrOuVAnoWv2e
 q8pVGbf+VM75p4pocf27WK6ycbhJ8RMzn5qDFoyuaif8nmpCs/rUim/+gIzbJ9KpiBRk2BiWcsO
 sfTXAq0DNjfS8G1QREvSMhxdG0CCqIFQN72KrlmNMSyHqV4yqQ0K55X7P5Oc0kZvzZD4wG7gmae
 a5KL8VR2w70yyy/hWjSYcHz7fxIHFcV2AGh1FiwqG8oUIQbfHSR4mMXEqCSTG65LSyaGS6H50/e
 qAiZtutwwnG+fh7oBuMgXGXyvgA74hQwgKgO3dBXOFhl/1+ws9NwQ5SkthLok52PvOrQFdiJSUK
 QpBgCg+WR2kk47ce8dLYwJm6h8wFkBHW+tsQ5ReZhfA6oX58jaI7NIriQmSGDg3jfNeGiJAQ8+Q
 ZQa/sXG79a1rJNRj/Bd/qVhijzkFn7ofWZeURuZlrvGs/Vp6wJVLKFRV88GSzQ0AffBrlmoYmVb
 66I8d952HZCxQL8PKSce08Akh2GKV2vhnEFHBwfaRc6YV3y5NSvXTPUiNvXrJ7SvJpL7cFrF4jy
 WtzLpk8kBr2tLig==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Rspamd-Queue-Id: 3AAE8236E24
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223519-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	DKIM_TRACE(0.00)[debian.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.947];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Corey Minyard <corey@minyard.net>

[ Upstream commit f9323a44994c2ccd5e0d582bac6f2b2a662e5603 ]

The analysis from Breno:

When the SMI sender returns an error, smi_work() delivers an error
response but then jumps back to restart without cleaning up properly:

1. intf->curr_msg is not cleared, so no new message is pulled
2. newmsg still points to the message, causing sender() to be called
   again with the same message
3. If sender() fails again, deliver_err_response() is called with
   the same recv_msg that was already queued for delivery

This causes list_add corruption ("list_add double add") because the
recv_msg is added to the user_msgs list twice. Subsequently, the
corrupted list leads to use-after-free when the memory is freed and
reused, and eventually a NULL pointer dereference when accessing
recv_msg->done.

The buggy sequence:

  sender() fails
    -> deliver_err_response(recv_msg)  // recv_msg queued for delivery
    -> goto restart                    // curr_msg not cleared!
  sender() fails again (same message!)
    -> deliver_err_response(recv_msg)  // tries to queue same recv_msg
    -> LIST CORRUPTION

Fix this by freeing the message and setting it to NULL on a send error.
Also, always free the newmsg on a send error, otherwise it will leak.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/lkml/20260127-ipmi-v1-0-ba5cc90f516f@debian.org/
Fixes: 9cf93a8fa9513 ("ipmi: Allow an SMI sender to return an error")
Cc: stable@vger.kernel.org # 4.18
Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/char/ipmi/ipmi_msghandler.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_msghandler.c b/drivers/char/ipmi/ipmi_msghandler.c
index 0a886399f9daf..5ed8e95589fb7 100644
--- a/drivers/char/ipmi/ipmi_msghandler.c
+++ b/drivers/char/ipmi/ipmi_msghandler.c
@@ -4848,8 +4848,15 @@ static void smi_work(struct work_struct *t)
 			if (newmsg->recv_msg)
 				deliver_err_response(intf,
 						     newmsg->recv_msg, cc);
-			else
-				ipmi_free_smi_msg(newmsg);
+			if (!run_to_completion)
+				spin_lock_irqsave(&intf->xmit_msgs_lock,
+						  flags);
+			intf->curr_msg = NULL;
+			if (!run_to_completion)
+				spin_unlock_irqrestore(&intf->xmit_msgs_lock,
+						       flags);
+			ipmi_free_smi_msg(newmsg);
+			newmsg = NULL;
 			goto restart;
 		}
 	}

---
base-commit: 6258e292d7463f96d0f06dff2a39093a54c9d16f
change-id: 20260309-ipmi_stable-bde1bbf58536

Best regards,
--  
Breno Leitao <leitao@debian.org>


