Return-Path: <stable+bounces-216818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNtXIVBllGkFDgIAu9opvQ
	(envelope-from <stable+bounces-216818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:55:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9D714C298
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:55:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 658D9302A044
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 12:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C77A8355057;
	Tue, 17 Feb 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GiIEgLNq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3E355053
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 12:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771332940; cv=none; b=Enkpjq57gAw/msWVWiCE9wp1Tlkg5o/jKNX6+lc5kLm6GGGPSgyIw++v7y+mjbgestk41kiz+8CCCzCV6FmJZ9x5Jh7FHaogqX+EQLam95QeGRchrPZ886VX+YWxgd92GpaQhC2VWrIhAJWhNoYKWHdEzpWfxEN19Bww8x81gpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771332940; c=relaxed/simple;
	bh=lgaXrU0Qc5+cPN7zuTIJCw2qmcmzq1Ykcda2tUjzz88=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ueoFeECMe/ridLgnwcrTbBu2MJGJ0C8+mYqSKykK4saBoLMzRNWwWHClGsVF7JUtzdTitEk8BUrbeTBqEkWLV6TCWnsA7SBsP1mgCKjMDuVnl9DE3NaHb8HIvwh/9che7GDtQu8Y+4rRtLnFkIO4SC5NIbY0DX8tq3VH+Do9CCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GiIEgLNq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C714BC4CEF7;
	Tue, 17 Feb 2026 12:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771332940;
	bh=lgaXrU0Qc5+cPN7zuTIJCw2qmcmzq1Ykcda2tUjzz88=;
	h=Subject:To:Cc:From:Date:From;
	b=GiIEgLNqSs3bEIDteqa9+xFvFWIbKJSnwEN2acQ58Il0Go5/Wx0a9dQv01km+jieG
	 24xytRRh9W+4dU3gE2MsYdukfd2B5QxzmamjHyrlUx3Un8Ayv2Ph7YGdRkcUVLNA6C
	 7uY8qey5wjv3tIyGXHwmwSHdfL3mMGwxACjCi1J4=
Subject: WTF: patch "[PATCH] fbcon: Remove struct fbcon_display.inverse" was seriously submitted to be applied to the 6.19-stable tree?
To: tzimmermann@suse.de,deller@gmx.de,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 17 Feb 2026 13:55:37 +0100
Message-ID: <2026021737-quarry-wieldable-6c75@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216818-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[suse.de,gmx.de,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gmx.de:email]
X-Rspamd-Queue-Id: DC9D714C298
X-Rspamd-Action: no action

The patch below was submitted to be applied to the 6.19-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 30baedeeeab524172abc0b58cb101e8df86b5be8 Mon Sep 17 00:00:00 2001
From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 9 Feb 2026 17:15:43 +0100
Subject: [PATCH] fbcon: Remove struct fbcon_display.inverse

The field inverse in struct fbcon_display is unused. Remove it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: <stable@vger.kernel.org> # v6.0+
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 1cd10a7faab0..fca14e9b729b 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -30,7 +30,6 @@ struct fbcon_display {
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
     u_short scrollmode;             /* Scroll Method, use fb_scrollmode() */
 #endif
-    u_short inverse;                /* != 0 text black on white as default */
     short yscroll;                  /* Hardware scrolling */
     int vrows;                      /* number of virtual rows */
     int cursor_shape;


