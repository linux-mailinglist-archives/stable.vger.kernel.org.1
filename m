Return-Path: <stable+bounces-240723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wF/CLGpx62nCMwAAu9opvQ
	(envelope-from <stable+bounces-240723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:34:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 453A045F212
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8AD993004F19
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3E23D47B0;
	Fri, 24 Apr 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SR/vxCz6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7E433E347;
	Fri, 24 Apr 2026 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777037670; cv=none; b=Az8WCUxXUWkeUvglinMawVqCLB9NcxydZf4iHGg8oY75lyeVCbBs++VRTUkDHnY7r+u9+KSoDwhy6U63LP4NXdPUJUAoBJI0NlGa0A+mTq0j1NoZ5k1xOqZmU7zzC4yCZ1X+HOH8e6T8vWbXJGEQOPC3mxfeyZq/NPmwPVvuk0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777037670; c=relaxed/simple;
	bh=VUDgkiyqGJQYGGCgncwMYgpQw7rWm1wNoD0lhIxHQgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWaTGCn1a9sBVTKZvWifbAYNvl7bcvQp6TPRMpV6RkZy9XfyEF7oUeLuyS2XKBhlzs8B/1f+ErY5ffXIYr9KpVFyaNp62zhHuERtaBS/tzOFZWqF0Fs9gXJgiLtnVBp+PjkYntIzcry0rOIM5qRZFzAulZlqndOoIqqgfw7D+08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SR/vxCz6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7066C19425;
	Fri, 24 Apr 2026 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777037670;
	bh=VUDgkiyqGJQYGGCgncwMYgpQw7rWm1wNoD0lhIxHQgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SR/vxCz6Xbn7Unak2gilylD5FZQFDatzyz7oQZGF0+AuJNthEQ2kl9ShLqXOw6JdO
	 0cSjVq1LM82XxFV8iiFtmngsKBdZtsjNObIhgCdN4GDe/x2l+3qFrUHy4ZE9IizS7M
	 JxBNBckpebQGzWj1v/rwvwGq1ko1ClVntlt1qN2U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 025/166] wifi: brcmfmac: validate bsscfg indices in IF events
Date: Fri, 24 Apr 2026 15:28:59 +0200
Message-ID: <20260424132538.080341154@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 453A045F212
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240723-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:email]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

[ Upstream commit 304950a467d83678bd0b0f46331882e2ac23b12d ]

brcmf_fweh_handle_if_event() validates the firmware-provided interface
index before it touches drvr->iflist[], but it still uses the raw
bsscfgidx field as an array index without a matching range check.

Reject IF events whose bsscfg index does not fit in drvr->iflist[]
before indexing the interface array.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
Link: https://patch.msgid.link/20260323074551.93530-1-pengpeng@iscas.ac.cn
[add missing wifi prefix]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index dac7eb77799bd..e6be192dc0af2 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -151,6 +151,11 @@ static void brcmf_fweh_handle_if_event(struct brcmf_pub *drvr,
 		bphy_err(drvr, "invalid interface index: %u\n", ifevent->ifidx);
 		return;
 	}
+	if (ifevent->bsscfgidx >= BRCMF_MAX_IFS) {
+		bphy_err(drvr, "invalid bsscfg index: %u\n",
+			 ifevent->bsscfgidx);
+		return;
+	}
 
 	ifp = drvr->iflist[ifevent->bsscfgidx];
 
-- 
2.53.0




