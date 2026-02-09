Return-Path: <stable+bounces-215320-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFhPHD/3iWl7FAAAu9opvQ
	(envelope-from <stable+bounces-215320-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:03:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFB3111710
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 16:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 136F7317A2CE
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A794928725B;
	Mon,  9 Feb 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Uz7gJk5L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C25E27FB05;
	Mon,  9 Feb 2026 14:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648411; cv=none; b=KDyIDXpqGrUz7jLvJQvAOJhDNj6ZYxJxaViIb97UAPfeFWawCOKwNKx+rwrJlDlJBZuQtvtj5zBZ9md+ejB/r0Xn16XfdLX0ToXRqCgmBdaTr4vI9JkSF6uSDj6HD8neLedzmRV31KwOri2dmoIMN6gJdCa7Tn+tsBuhWMIhYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648411; c=relaxed/simple;
	bh=HVD4MqOtMS54ssgubUJ4AJW5O58MR28I15SORJ2kk3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=miU946B8zghP07WpMogR+Y0jyeLXsaNZfuHXiIG4t276qGUZ9PmMJo6gu6Dh7nqwSlxExBk7+AL8IQKfxQ/cNm57qE1KdZZWyztC7RRizE4Y75wyKNDno+CEBDxEUAc7xkKBv65d8fCPA2vup8Dk6eQXXH2+BpMgfGeJucsqfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Uz7gJk5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0905C116C6;
	Mon,  9 Feb 2026 14:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648411;
	bh=HVD4MqOtMS54ssgubUJ4AJW5O58MR28I15SORJ2kk3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uz7gJk5LlnSSqoPZFNd8nde2j3EgVEaMJyCmdISweyPAqncccZa3f9fIqUzOs43wY
	 4vt5HPkx3uZlQ1dgWJVg3GMNXJ3KMpRaRvQy3byTW06CH7kBCkxreSM9I+KAFTRLuC
	 GLQtQoCUg2/gWYJ9ZCIduyvXY5lqVAgmYAlkWifs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	ZhangGuoDong <zhangguodong@kylinos.cn>,
	ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 30/86] smb/server: fix refcount leak in parse_durable_handle_context()
Date: Mon,  9 Feb 2026 15:23:53 +0100
Message-ID: <20260209142305.868536600@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142304.770150175@linuxfoundation.org>
References: <20260209142304.770150175@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215320-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: BEFB3111710
X-Rspamd-Action: no action

6.6-stable review patch.  If anyone has any objections, please let me know.

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
index 5cbe84938a729..da4d914c87ad2 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2805,6 +2805,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 					    SMB2_CLIENT_GUID_SIZE)) {
 					if (!(req->hdr.Flags & SMB2_FLAGS_REPLAY_OPERATION)) {
 						err = -ENOEXEC;
+						ksmbd_put_durable_fd(dh_info->fp);
 						goto out;
 					}
 
-- 
2.51.0




