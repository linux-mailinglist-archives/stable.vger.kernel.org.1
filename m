Return-Path: <stable+bounces-258962-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EK2aL/guG2qU/wgAu9opvQ
	(envelope-from <stable+bounces-258962-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:39:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 689DD61231D
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 20:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7758730A57FB
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23766351C2F;
	Sat, 30 May 2026 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eg6SfkgW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ACB331200;
	Sat, 30 May 2026 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780166129; cv=none; b=qpB3n5qFWuqAxPxO6R//AZs3AvJgIH7gubx4GchXe9wgTlKxYx0lf/GcEjVRbcfBgQ59+H0XeiyOYO31zXYK7Us+AF2jg6K07gbM2qkuktcEpfdvGLTW/FuVZ/6HlcG6vaXmJQPHpzxe7AqAHsJqbyfcq3kaY6shIC3hNCyIrqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780166129; c=relaxed/simple;
	bh=BEsfLBpZUBSBwvqs5sH2U+d0jBXiYfmsq/v4LBPq9WY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jEH+sx1maAmMy5OrdLTfZ+GcXXP93/4jrO8iRlOGsSTmZv7MlqqrRqCdE8R2CEx+2yVIbnyYdg8+0AxcwiLOByqSV7LjPN8q/+nkfukmvCxGrKRUnMxtKn8aE9nTO9UCcFyg0heAZ17u+Xb5+E7zIMJzVZzLLaFqgptl8GyuJj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eg6SfkgW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B551F00893;
	Sat, 30 May 2026 18:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780166128;
	bh=jyzdE1LnZREy0q+FJprC21+gKMcci/VPE2zn9Ui5krY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eg6SfkgWGT4YzZMacQrbqGkmTxTHsnk4zpFxyy202FLMecKGJYCyUHWyPlmLbZrXf
	 gJZ0/TfNwPLE4e63gKp8jlSfWAnbEsGtciXCl5p10dIpvkHvI+JddLvsIOXqOiRD9k
	 2jWaRYstPRXij3gaKqi0kqRNBG/xR0SLkfeqkgSQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Asleson <tasleson@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Bryn M. Reeves" <bmr@redhat.com>
Subject: [PATCH 5.10 248/589] dm: fix a buffer overflow in ioctl processing
Date: Sat, 30 May 2026 18:02:09 +0200
Message-ID: <20260530160231.510500646@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160224.570625122@linuxfoundation.org>
References: <20260530160224.570625122@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258962-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 689DD61231D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit 2fa49cc884f6496a915c35621ba4da35649bf159 upstream.

Tony Asleson (using Claude) found a buffer overflow in dm-ioctl in the
function retrieve_status:

1. The code in retrieve_status checks that the output string fits into
   the output buffer and writes the output string there
2. Then, the code aligns the "outptr" variable to the next 8-byte
   boundary:
	outptr = align_ptr(outptr);
3. The alignment doesn't check overflow, so outptr could point past the
   buffer end
4. The "for" loop is iterated again, it executes:
	remaining = len - (outptr - outbuf);
5. If "outptr" points past "outbuf + len", the arithmetics wraps around
   and the variable "remaining" contains unusually high number
6. With "remaining" being high, the code writes more data past the end of
   the buffer

Luckily, this bug has no security implications because:
1. Only root can issue device mapper ioctls
2. The commonly used libraries that communicate with device mapper
   (libdevmapper and devicemapper-rs) use buffer size that is aligned to
   8 bytes - thus, "outptr = align_ptr(outptr)" can't overshoot the input
   buffer and the bug can't happen accidentally

Reported-by: Tony Asleson <tasleson@redhat.com>
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Reviewed-by: Bryn M. Reeves <bmr@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-ioctl.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -1214,6 +1214,10 @@ static void retrieve_status(struct dm_ta
 		used = param->data_start + (outptr - outbuf);
 
 		outptr = align_ptr(outptr);
+		if (!outptr || outptr > outbuf + len) {
+			param->flags |= DM_BUFFER_FULL_FLAG;
+			break;
+		}
 		spec->next = outptr - outbuf;
 	}
 



