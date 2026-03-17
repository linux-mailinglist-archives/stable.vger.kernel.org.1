Return-Path: <stable+bounces-225888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHBDOaFEuWmK+QEAu9opvQ
	(envelope-from <stable+bounces-225888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:10:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 883AE2A990C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 13:10:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D3F0307B22B
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 12:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87883AE1B2;
	Tue, 17 Mar 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OAQy7PUm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C03AE1A4
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 12:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773749121; cv=none; b=brKy9CjKAFAV20AZtkIFqWPCrAb/j2/e9dFRbkgrGPllpFSCDzvZS9v66E7oEWFedhzXAmv20bPlK0HpnDGxdfnzCcKzExCc9TdAzK3yN+pCAycAMYm4JNaDplQT0B609Oxoxe0VbC1DlSAPR4V4R0lZ2ngwK9uWPDgtY5QwnZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773749121; c=relaxed/simple;
	bh=42PRfGcLdgyEVaQjGLiO1CUQbfh5jTrPQRQIkiHq3lI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T/INDuW2rEepcwnrNLji4F9IxBYIEFgoeBUdD4oewmpp4YYUBK9xcOcNyhtXBZpI1SsAMcWdQBNOcEmXicqW3mK43WKe+e6i2IghHcJEQDMy/8W+vp9pf2kO1Tk2icjEBc/4lo5uXbGJZOGDKMOYXKDgH5hqgXDUBbBuuno9oDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OAQy7PUm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51BCC4CEF7;
	Tue, 17 Mar 2026 12:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773749121;
	bh=42PRfGcLdgyEVaQjGLiO1CUQbfh5jTrPQRQIkiHq3lI=;
	h=Subject:To:Cc:From:Date:From;
	b=OAQy7PUmuxsLZcE3QHu7O+in8xR5572jichnPy1f4REIKMmQGxV5GmC6YbQXdMd6p
	 jx3uRvfbFdV+Aq9DHOp5d815HBykZwIF3L+j2JuF9PSGImu9xu0zpfxCo+a2A4jlyq
	 /MccWAR9adaipVV97drwGXA70S1h6LoUptpK4rW4=
Subject: FAILED: patch "[PATCH] s390/xor: Fix xor_xc_2() inline assembly constraints" failed to apply to 6.1-stable tree
To: hca@linux.ibm.com,gor@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Mar 2026 13:05:00 +0100
Message-ID: <2026031700-prowler-dreamless-96ea@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
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
	TAGGED_FROM(0.00)[bounces-225888-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email]
X-Rspamd-Queue-Id: 883AE2A990C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x f775276edc0c505dc0f782773796c189f31a1123
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031700-prowler-dreamless-96ea@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f775276edc0c505dc0f782773796c189f31a1123 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <hca@linux.ibm.com>
Date: Mon, 2 Mar 2026 14:34:58 +0100
Subject: [PATCH] s390/xor: Fix xor_xc_2() inline assembly constraints

The inline assembly constraints for xor_xc_2() are incorrect. "bytes",
"p1", and "p2" are input operands, while all three of them are modified
within the inline assembly. Given that the function consists only of this
inline assembly it seems unlikely that this may cause any problems, however
fix this in any case.

Fixes: 2cfc5f9ce7f5 ("s390/xor: optimized xor routing using the XC instruction")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260302133500.1560531-2-hca@linux.ibm.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>

diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index a4d8b51beb95..81c0235c0466 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -28,8 +28,8 @@ static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
 		"	j	3f\n"
 		"2:	xc	0(1,%1),0(%2)\n"
 		"3:"
-		: : "d" (bytes), "a" (p1), "a" (p2)
-		: "0", "cc", "memory");
+		: "+d" (bytes), "+a" (p1), "+a" (p2)
+		: : "0", "cc", "memory");
 }
 
 static void xor_xc_3(unsigned long bytes, unsigned long * __restrict p1,


