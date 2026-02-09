Return-Path: <stable+bounces-215144-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCI9Iw3ziWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215144-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:45:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21EC2110E02
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0ED5308A016
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46306378D85;
	Mon,  9 Feb 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vmGkko/J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ABD63783A1;
	Mon,  9 Feb 2026 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647823; cv=none; b=iLutJzM1wbjAu76Cw07R5oDR32UCa5CByZpsHzxBOkzXj4k1KosCMEBMcriOpFMIHSmNC8UvhHRbohArOnk4dGhK6DVy3ZXjUUr/v/yBj3mYk7WdHJ/0X0BKi/ROQDEs7z9ev4fJLmJm0s7ZRq58qzcvwCISutuXbdAXRnl970c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647823; c=relaxed/simple;
	bh=dhqhghOfJ/VeCqOLred0VLd2cYN2JwNjZzUPCnpWd2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ccv+SAgjJ7GIiGuO0oE4990Y4o1cLDgcn3nMg25gPctrwzmYwCn4ZIBX0JDhq1bQoCKIzGe3G/XcYQdQSUD+n6BYsATrZesbYr38jMxvpxTdj5q/oSUFpuYSxKorUaykDv7jvXL7Vbd8dCTpx77EBoLQdtGXtmE6Xdd0lpUeoNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vmGkko/J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89A77C116C6;
	Mon,  9 Feb 2026 14:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647822;
	bh=dhqhghOfJ/VeCqOLred0VLd2cYN2JwNjZzUPCnpWd2k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vmGkko/JPw0fasC9XNHaWqJZXsXGC3ni4cG/25RtHkKNSIR3M2wbV6RfHwl+4Sm9v
	 DlY3giVpZnbv+77AMFumvOmg+hVqSqV5sgdFsswVDX12V7EuBWnh2sFzXZGJprIlMi
	 Z8aQMlZcq4jNMMPzWzQy8gn6xTBxw1oBINQudbyE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 039/113] smb/server: fix refcount leak in parse_durable_handle_context()
Date: Mon,  9 Feb 2026 15:23:08 +0100
Message-ID: <20260209142311.613320285@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142310.204833231@linuxfoundation.org>
References: <20260209142310.204833231@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215144-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 21EC2110E02
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 3296c3012a9d9a27e81e34910384e55a6ff3cff0 ]

When the command is a replay operation and -ENOEXEC is returned,
the refcount of ksmbd_file must be released.

Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5641faa1f8952..ac8248479cba2 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2812,6 +2812,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 					    SMB2_CLIENT_GUID_SIZE)) {
 					if (!(req->hdr.Flags & SMB2_FLAGS_REPLAY_OPERATION)) {
 						err = -ENOEXEC;
+						ksmbd_put_durable_fd(dh_info->fp);
 						goto out;
 					}
 
-- 
2.51.0




