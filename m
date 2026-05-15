Return-Path: <stable+bounces-248288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGUTEk5LB2q5wwIAu9opvQ
	(envelope-from <stable+bounces-248288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:35:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C64553874
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4B36B3216A44
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B74305686;
	Fri, 15 May 2026 16:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e0Y7U2Yi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5DD3FD958;
	Fri, 15 May 2026 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861351; cv=none; b=jCnWYIn+wn7w1ibFj6LrZeFqbdUZBZxSu9OBXDSbAnS1TyTp6qArcN34p0Igzd4gs1RSM97PgYB4SQrDpYbmyDmOgay+thzr6Mi3JKNLCQtAMSzVdhBAYlw7aRfvB0RvcQ/VjJ93aNU1HUo1yPyS+zr8sQLmKvP4aF8ehslg3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861351; c=relaxed/simple;
	bh=VcnHTkZ6ASNIB2vWq4JG1YaXwsoagnVNSJ2hgjAfJp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTIqSQ5xwIvv6TvdxzxsG4UBSo75Fy6qr/lN+QChTL6pB/8jyJKIgcyzl10xMCJVV7pWavr+kYKctEgy96AwvjUefUrGRY9b+mmTo/nzFb7M4CX6LYpAgG7v2PIdm59GdoPrfNV8LEuTYW9JFT0yKvMCz3kSsoja/HktredLdNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e0Y7U2Yi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85BE7C2BCB0;
	Fri, 15 May 2026 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861350;
	bh=VcnHTkZ6ASNIB2vWq4JG1YaXwsoagnVNSJ2hgjAfJp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e0Y7U2Yibo+g6L3FdcYMRrvApYJSssnSJmuwBzGwAHq6kB4raI2ePG4x0gt4RILu4
	 JS6ZBgmcgvnND3vXeXr6KE9XurY1xoTPaaM0y0wURTzoIcOPxEyc9mxlJ7DbKq9UD6
	 /DEh0clT5fH1hVhNqO9lBu8DsznO7CYD/6cABxuo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tony Asleson <tasleson@redhat.com>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Bryn M. Reeves" <bmr@redhat.com>
Subject: [PATCH 6.6 253/474] dm: fix a buffer overflow in ioctl processing
Date: Fri, 15 May 2026 17:46:02 +0200
Message-ID: <20260515154720.471953008@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154715.053014143@linuxfoundation.org>
References: <20260515154715.053014143@linuxfoundation.org>
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
X-Rspamd-Queue-Id: E0C64553874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248288-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1341,6 +1341,10 @@ static void retrieve_status(struct dm_ta
 		used = param->data_start + (outptr - outbuf);
 
 		outptr = align_ptr(outptr);
+		if (!outptr || outptr > outbuf + len) {
+			param->flags |= DM_BUFFER_FULL_FLAG;
+			break;
+		}
 		spec->next = outptr - outbuf;
 	}
 



