Return-Path: <stable+bounces-274533-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TvHDI/CVVmpK+QAAu9opvQ
	(envelope-from <stable+bounces-274533-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 894F0758939
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 22:02:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Y3r8ph9a;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274533-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274533-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BE505301B907
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 20:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529794F7981;
	Tue, 14 Jul 2026 20:02:31 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8435D443A9F
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 20:02:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784059346; cv=none; b=EnzQgFeJzD7KiCeDsPkAIUKJ0Boe3VYrHKyynGhDUpTZhvpBNt2I+L9Yut9TWR7J+0bSNPp+m+izv7P/SQVl4dhacrxQcLwzmkQP6HNx1w9TQUk1hjPDLhizlZj73b8b+vsWt8Z7+qz5pFiov1JN3NX2vIeQSv211onra0XWV1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784059346; c=relaxed/simple;
	bh=ejxoZw98mHjrhEQfwN2yE753zism5aOTTPpia90riDk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOHTAsa4UX6gQnStcwkVKKw3K8WV55Vm5+x6Pawp8GT+/2/McvHQnZO4iO+l3LzxtA20Q9Ega8qx10+3rOt+rBuPiXYf6SENx2mA+E2TwHRzbRnu3FWFW12+It9Dcsd+VpBpY9KaLsL70buk6GT9MitXvyB1XECwR5wB/txkrso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3r8ph9a; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E9931F00A3E;
	Tue, 14 Jul 2026 20:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784059338;
	bh=oeenALeyGpAQQKWnpm915KRBhPi6BAiGy8sV/ydUvy4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y3r8ph9agH9NM+sK09NO1wk/NuJEMfBdvexnStSamG0+EKlsiKC5DVGJgctvg8ALF
	 PlrLmdP01IZRPnAIt19GGx+7pcTVrTZwNkGfrH5mknz5MMS8rSoQOORhRGI1M3OOeJ
	 p2KnRmIGIPvvRDTjjXMIGW1gE8Cbpk6QNbKeDNeBXIKVcDZ5DoXxcpk2AWstMYfcjJ
	 D7Uqx4ZHajmHOqr1eVyclnXbqfsfeGsAAKTVeiFFq3FoH/KXppeiyn0PAcYhSh2P8t
	 CR8swcBhi11cME/OKW+StJ2bGH7QK/wKO3eqo/SNA/VU9fEtIpskK8XbLl+Ls2XmWZ
	 VtCuKzPKdxOog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakob Koschel <jakobkoschel@gmail.com>,
	"Paulo Alcantara (SUSE)" <pc@cjr.nz>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/5] cifs: remove check of list iterator against head past the loop body
Date: Tue, 14 Jul 2026 16:02:12 -0400
Message-ID: <20260714200215.3152449-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714200215.3152449-1-sashal@kernel.org>
References: <2026071307-payment-valium-e77f@gregkh>
 <20260714200215.3152449-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274533-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:jakobkoschel@gmail.com,m:pc@cjr.nz,m:stfrench@microsoft.com,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,cjr.nz,microsoft.com,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,cjr.nz:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 894F0758939

From: Jakob Koschel <jakobkoschel@gmail.com>

[ Upstream commit 00c796eecba4898194ea549679797ee28f89a92f ]

When list_for_each_entry() completes the iteration over the whole list
without breaking the loop, the iterator value will be a bogus pointer
computed based on the head element.

While it is safe to use the pointer to determine if it was computed
based on the head element, either with list_entry_is_head() or
&pos->member == head, using the iterator variable after the loop should
be avoided.

In preparation to limit the scope of a list iterator to the list
traversal loop, use a dedicated pointer to point to the found element [1].

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 53b7c271f06b ("smb: client: restrict implied bcc[0] exemption to responses without data area")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2misc.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index db83485d28d932..ab20585db8c159 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -150,16 +150,18 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		struct smb2_transform_hdr *thdr =
 			(struct smb2_transform_hdr *)buf;
 		struct cifs_ses *ses = NULL;
+		struct cifs_ses *iter;
 
 		/* decrypt frame now that it is completely read in */
 		spin_lock(&cifs_tcp_ses_lock);
-		list_for_each_entry(ses, &srvr->smb_ses_list, smb_ses_list) {
-			if (ses->Suid == le64_to_cpu(thdr->SessionId))
+		list_for_each_entry(iter, &srvr->smb_ses_list, smb_ses_list) {
+			if (iter->Suid == le64_to_cpu(thdr->SessionId)) {
+				ses = iter;
 				break;
+			}
 		}
 		spin_unlock(&cifs_tcp_ses_lock);
-		if (list_entry_is_head(ses, &srvr->smb_ses_list,
-				       smb_ses_list)) {
+		if (!ses) {
 			cifs_dbg(VFS, "no decryption - session id not found\n");
 			return 1;
 		}
-- 
2.53.0


