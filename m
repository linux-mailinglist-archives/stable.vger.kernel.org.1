Return-Path: <stable+bounces-237192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLN8KN8h3Wn9aAkAu9opvQ
	(envelope-from <stable+bounces-237192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:03:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9439C3F09A1
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 380853030AA0
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492A8314A6B;
	Mon, 13 Apr 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RvfGUVAU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A692223DCE;
	Mon, 13 Apr 2026 16:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098823; cv=none; b=H6m6/mi1opArjm7xPdz8kxeNIMhRdppcbzUY0utUr/EQAUnh7WLxpU5T/Om8VkNEXPNRSLxfYyQLTW5h9Pr+Gua097e3kpVfKMnFGpC7ui5/6tK4ZM4vjX+dFgvhk9hSg7Gd7etX2suMZX4pp/I73CFHlHj868x73M4nrSdyxzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098823; c=relaxed/simple;
	bh=U66awp2D1lRIrjHcrG5xgXWqb+abkrF9bY3BmpX0kqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X5dLnjwUAenqo3UU8g4UjaQ2kGkGSQr9jdec55OLuUIqQh01r5QJSbh9mCXhlj3YQhfhZVlOacnrHoqGaUFC+zyTAtcdn7iaKlIyj/bKOv+GchBNYG8Wjn0sThXi7SqbTuPF8lJqR4k82J6KvJ9dPC8fj4qbu01aAZAEIlESLS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RvfGUVAU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7ACC2BCAF;
	Mon, 13 Apr 2026 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098822;
	bh=U66awp2D1lRIrjHcrG5xgXWqb+abkrF9bY3BmpX0kqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvfGUVAUioKV6azTgjNaSvyvYO69sG2Bhmn6BhVJxfKFJFCubrHEB+zida81qj3Jk
	 jIVXd0qnWGh08l0gE/sfctf6MDuV1ay7QubGuc1kpxVEClfvREn3Z61+yWxBkTceMq
	 N5zHZda8gUBtiwp52d/p+BkWW0b4RKCQzWUl+1/U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Gui-Dong Han <hanguidong02@gmail.com>
Subject: [PATCH 5.10 101/491] usb: class: cdc-wdm: fix reordering issue in read code path
Date: Mon, 13 Apr 2026 17:55:46 +0200
Message-ID: <20260413155822.826495590@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237192-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,suse.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,suse.com:email]
X-Rspamd-Queue-Id: 9439C3F09A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oliver Neukum <oneukum@suse.com>

commit 8df672bfe3ec2268c2636584202755898e547173 upstream.

Quoting the bug report:

Due to compiler optimization or CPU out-of-order execution, the
desc->length update can be reordered before the memmove. If this
happens, wdm_read() can see the new length and call copy_to_user() on
uninitialized memory. This also violates LKMM data race rules [1].

Fix it by using WRITE_ONCE and memory barriers.

Fixes: afba937e540c9 ("USB: CDC WDM driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Oliver Neukum <oneukum@suse.com>
Closes: https://lore.kernel.org/linux-usb/CALbr=LbrUZn_cfp7CfR-7Z5wDTHF96qeuM=3fO2m-q4cDrnC4A@mail.gmail.com/
Reported-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Gui-Dong Han <hanguidong02@gmail.com>
Link: https://patch.msgid.link/20260304130116.1721682-1-oneukum@suse.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/class/cdc-wdm.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/usb/class/cdc-wdm.c
+++ b/drivers/usb/class/cdc-wdm.c
@@ -212,7 +212,8 @@ static void wdm_in_callback(struct urb *
 		/* we may already be in overflow */
 		if (!test_bit(WDM_OVERFLOW, &desc->flags)) {
 			memmove(desc->ubuf + desc->length, desc->inbuf, length);
-			desc->length += length;
+			smp_wmb(); /* against wdm_read() */
+			WRITE_ONCE(desc->length, desc->length + length);
 		}
 	}
 skip_error:
@@ -519,6 +520,7 @@ static ssize_t wdm_read
 		return -ERESTARTSYS;
 
 	cntr = READ_ONCE(desc->length);
+	smp_rmb(); /* against wdm_in_callback() */
 	if (cntr == 0) {
 		desc->read = 0;
 retry:



