Return-Path: <stable+bounces-240470-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QClbNtMF6mk/rQIAu9opvQ
	(envelope-from <stable+bounces-240470-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:43:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B80451699
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A9A1A300CFE6
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249543E120B;
	Thu, 23 Apr 2026 11:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ieI+PmJq"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365DD2E62A9
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776944590; cv=none; b=k/53yjC8jzp7P7QR/KXOXX6avhGM1sNv653CaT/uNfrqkW/9U8A0FgeOJV+edNUUnho1EtOuYD3HF80vO7bp8oNAuW1GiQjnVj0/eVkJaAv29tJDpqe/Tnw2YNNL266oi0v4QubOcoGwILnJ9VaE8/6wQo/42spNLiCwmpT+LE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776944590; c=relaxed/simple;
	bh=t1CY1cRjo91Z5M3YkhpIYo3++aFpBsaDtyzhwVK2QYE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=EMO7bv3F1vfl+B73C1QT80liIiBgl05qQiKdEkMKpUdybL+yG4m8BYx2WGeNxL0L19GrjxGuW0cMhfXc+FRI0RRWtt7iZIHrCqRX87X5Tx+M8h+vOB69Ec9qzIZcPlyC7J6UoAeCsjoVU1aM9+lk/MP7k649v29j2pqrWSy92+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ieI+PmJq; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1776944579;
	bh=P6BCcr6LahNFj6sgm9z3oJHU5rxlSeOj+UbmdBVzBUE=;
	h=From:To:Cc:Subject:Date;
	b=ieI+PmJq7eupNWa/GiYLSGht9BnTq3UPvaZWjgEIqX7hdkKnyCcP4Y+N1Z+r1BXIL
	 VQ4jR2mkoD3eHlL2oC+Z2x1aweSriwSIkRcEsFnRWfXmLhOsUoMowYqV/BPvFaK6o7
	 ZEPr+zBCN281FTuI0uWmutNANuKaeAWToKI6yumA=
Received: from China-team ([183.241.55.34])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id AB09CC11; Thu, 23 Apr 2026 19:42:48 +0800
X-QQ-mid: xmsmtpt1776944568txlc6cvfn
Message-ID: <tencent_49373CD3B2D5E47DCC496A5823E090C2680A@qq.com>
X-QQ-XMAILINFO: NvOKxKupJG5HqpPurNPOcHp5pqr20vlXC4ey3fEWbK447uzhGIQU1Ow73rPedj
	 19nVluesTkyQcoHQdU/X0gZTkYcZzPHOCxz5igomUQ7t5fOteDDoHpOIxjMiHGWgPhcajeJpc6NA
	 P10+JVSbnTn+shfp+L4OBJ6gW5j3RwqKLBBlez4RZ/cj8a8BFF/aoiHR8D4Vo6j9uBs4hwdc+qye
	 pl57qVlKt6YPTGXiPM6rfaV+rdaQ2NTxaLtl2UVJFWqVPrIVda9F5ryo5M0OK4gezq4hDEJg75j1
	 ASkZHkbb7W4FK/DUGb6PEJa0V7aJRTqkEUHFaacVxfTXBi/RXlzSpSiOZT/3Cxwhq3uu45BWCt6s
	 RRh8FBteWzPkzTHEuHR/FV3cQ2pc8tWWZSTUCwrvZzE91uQiUzoLEPF75aLSfMVoGGtjOmYLhd/q
	 rGd3FPKCheeAyPWh7n3A5SfPqz/gQbrGvqRbnpInu5KqZi8xER2Rxfc2Yi/yQtZPvdUzGBsecuaJ
	 pN8lMR2bVY3OVJkzPB1BJJXUVexJVnQjU6vy+o2Vx9nTgh25jBKyvqhtQhGnJ7DsRio3JXeuIch/
	 SQvsWzv9q2mx3h//O+g0NmcWNYvr8rJvAf6YxZoYJ/mhASGCKWu2SgZSBZk8sJvWqL0baXkYnQmn
	 xfM0P/yS5iFRwGRXnBn4NG1uO1df0VELnMVAeNj0DgmRyFao9jHK1GxIBdM+S54HDaR/Z6UUXgaO
	 mzneQLpwJ6NbrRu5K6ax8vSpB/Iu04tT+9d3lV5CsLvc4tcE543rLkITgYOAjRts4pf/3aerp7Te
	 7/dYmO1MfhrfBeB19JZ8nj9J6G/gfMN8KEukoQZyv03O++G0o71J8wZhJVz5LDxa1IRtJgAgf/7X
	 JnVvsuSOcPmVGXKtFH0Noj+kM984Z4wo5aGHYuCbK7Fsh+WFLiQN0Nh1LQQaR7mHuNMGCWSKMSAq
	 1VPMUs4lLari1EuwBXA8AxNzwkGA78YA05DRa7Fyd+iYqgOsmLrJNcMk1uL1ylC2QbsCA2S5jani
	 cxOxNuJYKdQYLibFO9MgCJfZsITrJU/WylLwAzZroeKnzF91e6MEdjdjl11myok5qcTDvH+w==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.15.y] ksmbd: unset conn->binding on failed binding request
Date: Thu, 23 Apr 2026 19:42:04 +0800
X-OQ-MSGID: <20260423114204.8238-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
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
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-240470-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,microsoft.com,foxmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[foxmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[foxmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qq.com:mid,foxmail.com:dkim,foxmail.com:email]
X-Rspamd-Queue-Id: E9B80451699
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 282343cf8a4a5a3603b1cb0e17a7083e4a593b03 ]

When a multichannel SMB2_SESSION_SETUP request with
SMB2_SESSION_REQ_FLAG_BINDING fails ksmbd sets conn->binding = true
but never clears it on the error path. This leaves the connection in
a binding state where all subsequent ksmbd_session_lookup_all() calls
fall back to the global sessions table. This fix it by clearing
conn->binding = false in the error path.

Cc: stable@vger.kernel.org
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/ksmbd/smb2pdu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 978a103e72bb..700c8070f57a 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -1949,6 +1949,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 			}
 		}
 		smb2_set_err_rsp(work);
+		conn->binding = false;
 	} else {
 		unsigned int iov_len;
 
-- 
2.43.0


