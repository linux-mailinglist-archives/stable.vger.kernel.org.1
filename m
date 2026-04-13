Return-Path: <stable+bounces-236869-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEy5OT0d3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236869-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B64D3EF9F7
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7B3FC304F325
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C78277CA5;
	Mon, 13 Apr 2026 16:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IyPK9jAe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01201A275;
	Mon, 13 Apr 2026 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776098002; cv=none; b=Dk2SUPGjvuj2tDT6nWv6NU0bs2HiG4TrrdLoHEpM6SZ5aI0Ygx0T2aiKSBSLI1DPm55HEuNjfMAK2dqXsvGDwQDejADuZevnjQFSenwRUhh7hKyXi3LwhErpY+oeiP6fgudFqr4KPas118V3sTmFT22DG95CqzP4BUNa2YcwEkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776098002; c=relaxed/simple;
	bh=sQ3urzEf4szXSgupCeM8qX46TZx3JVtNxJOhOhDJyZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jl3lB+uRNYJyCFpZ5rOk9OpIK0ftVhsUKd6P3YXBPOrQB9O7xhzL101anAcK+ZQzFRoHN3c7Z8sGc46DGhqwG87pwKY1zog0uuLyb5Y+4HXRqFUeaOVDqpG3j00V7T5oX609g6RGN2zgP7+hFJ9fcC9N0FUvOcFslzfqReMnWNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IyPK9jAe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8564FC2BCAF;
	Mon, 13 Apr 2026 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776098001;
	bh=sQ3urzEf4szXSgupCeM8qX46TZx3JVtNxJOhOhDJyZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyPK9jAe2La3JZeR6hSBEm8zieBnGda2oJUcugwRAswx3k8gPNZe12RX6TpHoBWbX
	 OMAYqNDD1F4YmRzwYsgzHjRuxAOj5xzhH+sk1qjy8IPc+W+UOzhXkw005WMVjQ6XQg
	 WC2rNv2FEz6sXS2pxjtbzsTR4v1BG9oefqfcih5U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 355/570] drm/i915/gmbus: fix spurious timeout on 512-byte burst reads
Date: Mon, 13 Apr 2026 17:58:06 +0200
Message-ID: <20260413155843.783709594@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236869-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,intel.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 7B64D3EF9F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>

[ Upstream commit 08441f10f4dc09fdeb64529953ac308abc79dd38 ]

When reading exactly 512 bytes with burst read enabled, the
extra_byte_added path breaks out of the inner do-while without
decrementing len. The outer while(len) then re-enters and gmbus_wait()
times out since all data has been delivered. Decrement len before the
break so the outer loop terminates correctly.

Fixes: d5dc0f43f268 ("drm/i915/gmbus: Enable burst read")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patch.msgid.link/20260316231920.135438-2-samasth.norway.ananda@oracle.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 4ab0f09ee73fc853d00466682635f67c531f909c)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_gmbus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_gmbus.c b/drivers/gpu/drm/i915/display/intel_gmbus.c
index ceb1bf8a8c3c2..01b046578cd15 100644
--- a/drivers/gpu/drm/i915/display/intel_gmbus.c
+++ b/drivers/gpu/drm/i915/display/intel_gmbus.c
@@ -432,8 +432,10 @@ gmbus_xfer_read_chunk(struct drm_i915_private *dev_priv,
 
 		val = intel_de_read_fw(dev_priv, GMBUS3);
 		do {
-			if (extra_byte_added && len == 1)
+			if (extra_byte_added && len == 1) {
+				len--;
 				break;
+			}
 
 			*buf++ = val & 0xff;
 			val >>= 8;
-- 
2.53.0




