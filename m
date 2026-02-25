Return-Path: <stable+bounces-219051-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCWfD5FanmlSUwQAu9opvQ
	(envelope-from <stable+bounces-219051-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:12:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F44A190B4C
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A3520309EF5A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E380283FC9;
	Wed, 25 Feb 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WgjNYxt+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0259A22127B;
	Wed, 25 Feb 2026 01:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983973; cv=none; b=ImT/0UpHTHf2GukvWsNWOvglGUrHhNhzjLboz3aO7lvZVoQDsSjtoG5wrXfWnppFrIcLFZHUkCyB3VY7lkdi3YiyVPKkQoA8gMgn/C8k5ZIj+ZpMUUkwGvAOd84O9oh6ydv3o/DIf3mUgP9gTLjr2kst6Rtk8E3sO7nKTRKkGqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983973; c=relaxed/simple;
	bh=uc9QBt9kCwTyix40xhToKYbVjuvRUzghYOeWJVvTKkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ber8kQOjIRhmIlNk/uygVOwmQk+nNeI0EXpbzdLMN+JFuw0EyzaiLZQ4ZPlVAst5vF06CLeyQ0hPOlJNPwDHb4QYmX/n20VHDyEe7fTsQ552NbEZwEpFPFoCZWc8dJi7KRUoYm2XSdzuXJ3qovSpgRcUsXdjDgqrvYewtrADAX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WgjNYxt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1AC116D0;
	Wed, 25 Feb 2026 01:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983972;
	bh=uc9QBt9kCwTyix40xhToKYbVjuvRUzghYOeWJVvTKkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WgjNYxt+AAId7kdyVT5sDYGixPMOiKM+G4jWt6Dhc4Vi8UtJux8mKZlI4WAjRzETa
	 5W7TRXESEdxwmRJurBDinl7Yi1EcMgg6RuXRKdjSpX6Hi1vAvTL7VtTj2pgIO11C2V
	 gMcGUK9PANJ4SmAE8ZxxQvYhU1FPeCeqtboYKgq0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 227/641] accel/amdxdna: Fix incorrect error code returned for failed chain command
Date: Tue, 24 Feb 2026 17:19:13 -0800
Message-ID: <20260225012354.407796391@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-219051-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:email]
X-Rspamd-Queue-Id: 7F44A190B4C
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lizhi Hou <lizhi.hou@amd.com>

[ Upstream commit 750817a7c41de083ca5d73052e97bb7b67d7c394 ]

The driver currently returns an incorrect error code when a chain command
fails. In this case, ERT_CMD_STATE_ERROR is expected to be reported for
failed chain commands.

Fixes: aac243092b70 ("accel/amdxdna: Add command execution")
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Reviewed-by: Maciej Falkowski <maciej.falkowski@linux.intel.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Link: https://patch.msgid.link/20260203184037.2751889-1-lizhi.hou@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/amdxdna/aie2_ctx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index c3cb24d96cee3..4610f491f0881 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -294,7 +294,7 @@ aie2_sched_cmdlist_resp_handler(void *handle, void __iomem *data, size_t size)
 		ret = -EINVAL;
 		goto out;
 	}
-	amdxdna_cmd_set_state(cmd_abo, fail_cmd_status);
+	amdxdna_cmd_set_state(cmd_abo, ERT_CMD_STATE_ERROR);
 
 	if (amdxdna_cmd_get_op(cmd_abo) == ERT_CMD_CHAIN) {
 		struct amdxdna_cmd_chain *cc = amdxdna_cmd_get_payload(cmd_abo, NULL);
-- 
2.51.0




