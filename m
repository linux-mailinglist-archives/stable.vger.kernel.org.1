Return-Path: <stable+bounces-248262-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IkyEgFLB2q5wwIAu9opvQ
	(envelope-from <stable+bounces-248262-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:09 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4D65537A2
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A33431F1F2C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB2E3FBB5A;
	Fri, 15 May 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ne1B3wqg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3292C303CB0;
	Fri, 15 May 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778861286; cv=none; b=u2+MhI/3qdISzB7KMuaGDiXuKUcn1PvKrhW0CrKGlhUGz78zdTFi0RFSedb1scdXo0qF4aaA08crIigiTlXOaX1hUdrRYv9CpHTG4PeGK4ew69p7H2YLr+ByXO/o8esEHiZnfT4OcykAQKHnPqN6M2VFAyeAa6QCjn65l99vkO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778861286; c=relaxed/simple;
	bh=bpwjBkl2m5UWhPC9jMwCOGEfbPNxALujq47+a1WVC0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ppx2t+4lIsfasPSZicx86+mrc+bLDxqr3JSHlMiC/g+k5+eKHctKGVNCn6JR7DE6aPcJ5IH8SPyERvUk6SoldPXKcWIYh5IlKQ9vXyR2X2F6FojufVgujd0dppwJIWPqiBfmTk6C6ofSzABGBXXK69DlwUEJWsCVBJDdGJlqYrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ne1B3wqg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAFEC2BCB0;
	Fri, 15 May 2026 16:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778861286;
	bh=bpwjBkl2m5UWhPC9jMwCOGEfbPNxALujq47+a1WVC0I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ne1B3wqg2xBNZRFAm6us86Nr7TdNKs3s9PPncTWOskS+4p6o87d09Y/1y+yaSWHpW
	 n/mQUK1olI7tr+77KuhMsZCU7ZuQW2j71U9r+XCWXBq0jVXrIBPP4DJld4JQRxKZgA
	 h+dYyzMCYu71SSYtmgS8GbIMBHeQ1GyL3Zydc6Ig=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stable@vger.kernel.org,
	Zisen Ye <zisenye@stu.xidian.edu.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.6 270/474] smb/client: fix out-of-bounds read in symlink_data()
Date: Fri, 15 May 2026 17:46:19 +0200
Message-ID: <20260515154720.843991498@linuxfoundation.org>
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
X-Rspamd-Queue-Id: BD4D65537A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	SEM_URIBL(3.50)[xidian.edu.cn:email];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248262-lists,stable=lfdr.de];
	R_DKIM_ALLOW(0.00)[linuxfoundation.org:s=korg];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.655];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_SPF_ALLOW(0.00)[+ip6:2600:3c04:e001:36c::/64:c];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,xidian.edu.cn:email]
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zisen Ye <zisenye@stu.xidian.edu.cn>

commit d62b8d236fab503c6fec1d3e9a38bea71feaca20 upstream.

Since smb2_check_message() returns success without length validation for
the symlink error response, in symlink_data() it is possible for
iov->iov_len to be smaller than sizeof(struct smb2_err_rsp). If the buffer
only contains the base SMB2 header (64 bytes), accessing
err->ErrorContextCount (at offset 66) or err->ByteCount later in
symlink_data() will cause an out-of-bounds read.

Link: https://lore.kernel.org/linux-cifs/297d8d9b-adf7-42fd-a1c2-5b1f230032bc@chenxiaosong.com/
Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
Cc: Stable@vger.kernel.org
Signed-off-by: Zisen Ye <zisenye@stu.xidian.edu.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smb2misc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -239,7 +239,8 @@ smb2_check_message(char *buf, unsigned i
 	if (len != calc_len) {
 		/* create failed on symlink */
 		if (command == SMB2_CREATE_HE &&
-		    shdr->Status == STATUS_STOPPED_ON_SYMLINK)
+		    shdr->Status == STATUS_STOPPED_ON_SYMLINK &&
+		    len > calc_len)
 			return 0;
 		/* Windows 7 server returns 24 bytes more */
 		if (calc_len + 24 == len && command == SMB2_OPLOCK_BREAK_HE)



