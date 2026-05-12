Return-Path: <stable+bounces-245675-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPhrJXU8A2oq2AEAu9opvQ
	(envelope-from <stable+bounces-245675-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:43:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9489522C9B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0B7133A9EF8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A33F3AA9E8;
	Tue, 12 May 2026 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PBI0kUT2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0E43AA9D9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594643; cv=none; b=NUrzlvZB4tTbwYiSOoNzlJiLr/pNqy1o465hsjbbMSM+cb0mqEt6eY80jl7ZTvME4jsaJccfzzKEU/EMK83EP5r+Xo/d66XrSdKfLEWMFNUmEEyGizxLrpy6xvAJELQaB36fpmWPZXO9cQepz3ooqfehjcJYotPcw30Rm1W6yHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594643; c=relaxed/simple;
	bh=HJe8f+Sd5vKve+1BUt6k6OB7F9/07FEMn9DtxXgXHFc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=FjjjS71Ot8LTHqKPQrg7Rn8tWFDoamU+7Ea3fbm5g50UYJpAZUeS3Z6gZ5bwHOzidAqNsLtfgxOivOx2dzrn/bO61COrvDUBkFXBdMO8eNTy2c3gSTwTzlm4B5eyQZE+vSsUtRTNWVBU7pFpp9Z9uyF5cT/DliOX014RttcIasA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PBI0kUT2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB11C2BCF5;
	Tue, 12 May 2026 14:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778594643;
	bh=HJe8f+Sd5vKve+1BUt6k6OB7F9/07FEMn9DtxXgXHFc=;
	h=Subject:To:Cc:From:Date:From;
	b=PBI0kUT2KRvJB0pyEGoQ1y3cBgZzJ34lqn48lP427cTmaPg34xxdq2iOeOlR3qqNp
	 pn23FCDyBCxhXD0Nb0IiVdTCObKubTNVyqE4qMPj3gfKG847ay+yPKDJHecd529rMa
	 ylyNQoSGll1yr83vIvqbFxPYCAqraN+gfYYIrF7o=
Subject: FAILED: patch "[PATCH] s390/debug: Reject zero-length input before trimming a" failed to apply to 5.10-stable tree
To: pengpeng@iscas.ac.cn,agordeev@linux.ibm.com,bblock@linux.ibm.com,gor@linux.ibm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:03:56 +0200
Message-ID: <2026051256-navy-magician-f324@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9489522C9B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245675-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,iscas.ac.cn:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c366a7b5ed7564e41345c380285bd3f6cb98971b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051256-navy-magician-f324@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c366a7b5ed7564e41345c380285bd3f6cb98971b Mon Sep 17 00:00:00 2001
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 17 Apr 2026 15:35:30 +0800
Subject: [PATCH] s390/debug: Reject zero-length input before trimming a
 newline

debug_get_user_string() duplicates the userspace buffer with
memdup_user_nul() and then unconditionally looks at buffer[user_len - 1]
to strip a trailing newline.

A zero-length write reaches this helper unchanged, so the newline trim
reads before the start of the allocated buffer.

Reject empty writes before accessing the last input byte.

Fixes: 66a464dbc8e0 ("[PATCH] s390: debug feature changes")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260417073530.96002-1-pengpeng@iscas.ac.cn
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>

diff --git a/arch/s390/kernel/debug.c b/arch/s390/kernel/debug.c
index 31430e9bcfdd..2612f634e826 100644
--- a/arch/s390/kernel/debug.c
+++ b/arch/s390/kernel/debug.c
@@ -1414,6 +1414,9 @@ static inline char *debug_get_user_string(const char __user *user_buf,
 {
 	char *buffer;
 
+	if (!user_len)
+		return ERR_PTR(-EINVAL);
+
 	buffer = memdup_user_nul(user_buf, user_len);
 	if (IS_ERR(buffer))
 		return buffer;


