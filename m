Return-Path: <stable+bounces-225150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEV+H00hs2m5SQAAu9opvQ
	(envelope-from <stable+bounces-225150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:25:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F9279077
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A232D30297A9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49E53750A3;
	Thu, 12 Mar 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mH2+9bKa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 890973242AC;
	Thu, 12 Mar 2026 20:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773347145; cv=none; b=ZdNq8ZZBLfI9XR+N++wvBIcfrvE6ko93EQlIN+xtPfzKInMBAwl0MO3SEMsa8Rw0NHsaeK7QM1/t++KhKBeew0CUO0gxbGaoBQxCYMjfsfm8YG/SvTFyiDTqFjU5UkK5FVcab4RRPvb66sBtC7/HlBtdvkFiy6wBiSvsWelZktc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773347145; c=relaxed/simple;
	bh=Has+Yhq5J+WNfYYKJ2lHZFWJGJzcQGeizkGH60mnYzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PvyhAwO/6aJOBMmwf+jlVnGZm5Rbnk9dUts8jupfEkmGvU9EJjTLPrO/zywcjrcO1NtKCHZArzdX/aW1qo5fYQKysnj1ATu3OPYmsVhNDOADJBR01k0qQPtkOc5vbbGUjKDMK47g9uWDBUUJ1T2DYbSYS74lgPy72iNQ2/Y/10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mH2+9bKa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA37C4CEF7;
	Thu, 12 Mar 2026 20:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773347145;
	bh=Has+Yhq5J+WNfYYKJ2lHZFWJGJzcQGeizkGH60mnYzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mH2+9bKai0uMT8PJEXZnCbjYgDg94SmavTvIuZHPyqJkgDzBvdvP3lJm4h2e3c/xj
	 y6xt4Qe+v34xVzC6pf1eh3ctPqFEFw3WeWtdxErS5WapUvTHH03r9hsjfukssz6/JE
	 gsnLg3qRpmRuzT+xRcb0NzqaeO8r7fvJyqYPq/qI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 216/265] smb/client: fix buffer size for smb311_posix_qinfo in SMB311_posix_query_info()
Date: Thu, 12 Mar 2026 21:10:03 +0100
Message-ID: <20260312201026.123819558@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225150-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: D27F9279077
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: ZhangGuoDong <zhangguodong@kylinos.cn>

[ Upstream commit 9621b996e4db1dbc2b3dc5d5910b7d6179397320 ]

SMB311_posix_query_info() is currently unused, but it may still be used in
some stable versions, so these changes are submitted as a separate patch.

Use `sizeof(struct smb311_posix_qinfo)` instead of sizeof its pointer,
so the allocated buffer matches the actual struct size.

Fixes: b1bc1874b885 ("smb311: Add support for SMB311 query info (non-compounded)")
Reported-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: ZhangGuoDong <zhangguodong@kylinos.cn>
Reviewed-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 121463b9273bc..b6821815248e7 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3933,7 +3933,7 @@ int
 SMB311_posix_query_info(const unsigned int xid, struct cifs_tcon *tcon,
 		u64 persistent_fid, u64 volatile_fid, struct smb311_posix_qinfo *data, u32 *plen)
 {
-	size_t output_len = sizeof(struct smb311_posix_qinfo *) +
+	size_t output_len = sizeof(struct smb311_posix_qinfo) +
 			(sizeof(struct smb_sid) * 2) + (PATH_MAX * 2);
 	*plen = 0;
 
-- 
2.51.0




