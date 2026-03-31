Return-Path: <stable+bounces-232443-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMuWNa8DzGljNQYAu9opvQ
	(envelope-from <stable+bounces-232443-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:26:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F2C36EB09
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7C357313515E
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 17:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968B303A07;
	Tue, 31 Mar 2026 17:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GrVC/AYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AA43033D8;
	Tue, 31 Mar 2026 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774976761; cv=none; b=cqSIlnAw6kMoNiS/V3YTLV14+DJZq/vUyvItSTmJz9opFgb4vAMUK9DWgzAF7ciyQrWCAJ7ge/MGkhUuiUP2yQR0xlIxCNDkoRSWvDpp+bng3OXA5/FvNh5wtcylxlNpK9dML6FDMp8e5YfH46Ll7YoLgvjsaKNYNReDcBOCrQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774976761; c=relaxed/simple;
	bh=9DhMglYBUe1g1XcAGgDOG1wnR7MaRwv/xXvJtPg8//o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZPNYnmcOoowNjFYwF1JuRQVUqh1V4xbPYi0DWbUAyhA6+YWxE+XMvlzlGIod0uXwAkujEfAvJceVpjMAqqCf5DhHknwbgMQM4451kkU40/U8JamXB1EEVq6p4VVi/4lPKU7CE21ISYrY84j26KV2d5pkPO5fCo0C39UrpYknmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GrVC/AYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ECBCC19423;
	Tue, 31 Mar 2026 17:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774976760;
	bh=9DhMglYBUe1g1XcAGgDOG1wnR7MaRwv/xXvJtPg8//o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GrVC/AYb52owZ8D1jgaqz7cqis7LtiExEepirVeUI+l/dD7d1HRZM1J9xRIkbGm+0
	 s4y4dOBIbHqM4lVy0S7r4OT6tqFF6XULjku//QQ4Zmh5V+qlbdbnx2Z/5Zl6kGnbuv
	 UZvere2VHLuXS703S6avg1yehYJtvthdfZqeWilg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	stable <stable@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 6.18 218/309] scsi: ses: Handle positive SCSI error from ses_recv_diag()
Date: Tue, 31 Mar 2026 18:22:01 +0200
Message-ID: <20260331161801.473758101@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161753.468533260@linuxfoundation.org>
References: <20260331161753.468533260@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-232443-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,suse.de:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,oracle.com:email,hansenpartnership.com:email]
X-Rspamd-Queue-Id: F2F2C36EB09
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit 7a9f448d44127217fabc4065c5ba070d4e0b5d37 upstream.

ses_recv_diag() can return a positive value, which also means that an
error happened, so do not only test for negative values.

Cc: James E.J. Bottomley <James.Bottomley@HansenPartnership.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: stable <stable@kernel.org>
Assisted-by: gkh_clanker_2000
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Link: https://patch.msgid.link/2026022301-bony-overstock-a07f@gregkh
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/ses.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/scsi/ses.c
+++ b/drivers/scsi/ses.c
@@ -216,7 +216,7 @@ static unsigned char *ses_get_page2_desc
 	unsigned char *type_ptr = ses_dev->page1_types;
 	unsigned char *desc_ptr = ses_dev->page2 + 8;
 
-	if (ses_recv_diag(sdev, 2, ses_dev->page2, ses_dev->page2_len) < 0)
+	if (ses_recv_diag(sdev, 2, ses_dev->page2, ses_dev->page2_len))
 		return NULL;
 
 	for (i = 0; i < ses_dev->page1_num_types; i++, type_ptr += 4) {



