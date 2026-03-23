Return-Path: <stable+bounces-229227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP6DFgZvwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAD72F8D9A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 404FA32A4DCC
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE28257828;
	Mon, 23 Mar 2026 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PSzEASe9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD8D253958;
	Mon, 23 Mar 2026 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774278459; cv=none; b=TN6mNGTAizm0SKXFlAiWeptNPFMp5uFyS1lBsUWkqvEwvDFl4tTPC3zhKa179dfpSNTpdiy8N+fVvWBKLfAb+dSF8VZMtP8jliXoHZD8nQaay7yrBYukRV9k2vV3sd9rw5ox/k6YOLkzGm4SNVNwzMriZwl2K9pY2kNg+aaECkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774278459; c=relaxed/simple;
	bh=QkwupSL4pOWLIsVzW44P5l9N7T5SlMKhsNrX9WsONm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t0eFNIiC75OvizNf4gHX+IAy3kynh6zHjJnMICdWrGHGfQbcG+eRpVQXeefvsKovqFXZlJefTkGi3NUk1xxfOOCxXNbO/0eMu/b4JtmWF1ZvxNLDLy+R/VfwV0N5ON+kRxX0WDSzOuhdFN8OidRFD8pfDIVtxNwRwzMZGrhuGBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PSzEASe9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20BBC2BC9E;
	Mon, 23 Mar 2026 15:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774278459;
	bh=QkwupSL4pOWLIsVzW44P5l9N7T5SlMKhsNrX9WsONm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PSzEASe9de3vtLx2SsqZF3IPi02WAVja8B+OJE3txFjGaMvzW+PHmGjF5tU7ir7N0
	 pipUmmMUT7DfwZJijiXnqBJCCZRwWVK55ENAyatqMJ3LE3oYVlRyiQFx4kRZN9YmZh
	 tKNzEX9HWvOdIWV4MXM/pcHCl0+xvRINCkyNTG5Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH 6.6 313/567] ixgbevf: fix link setup issue
Date: Mon, 23 Mar 2026 14:43:53 +0100
Message-ID: <20260323134541.570731393@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
References: <20260323134533.749096647@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229227-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 9BAD72F8D9A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

commit feae40a6a178bb525a15f19288016e5778102a99 upstream.

It may happen that VF spawned for E610 adapter has problem with setting
link up. This happens when ixgbevf supporting mailbox API 1.6 cooperates
with PF driver which doesn't support this version of API, and hence
doesn't support new approach for getting PF link data.

In that case VF asks PF to provide link data but as PF doesn't support
it, returns -EOPNOTSUPP what leads to early bail from link configuration
sequence.

Avoid such situation by using legacy VFLINKS approach whenever negotiated
API version is less than 1.6.

To reproduce the issue just create VF and set its link up - adapter must
be any from the E610 family, ixgbevf must support API 1.6 or higher while
ixgbevf must not.

Fixes: 53f0eb62b4d2 ("ixgbevf: fix getting link speed data for E610 devices")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: stable@vger.kernel.org
Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbevf/vf.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbevf/vf.c
+++ b/drivers/net/ethernet/intel/ixgbevf/vf.c
@@ -852,7 +852,8 @@ static s32 ixgbevf_check_mac_link_vf(str
 	if (!mac->get_link_status)
 		goto out;
 
-	if (hw->mac.type == ixgbe_mac_e610_vf) {
+	if (hw->mac.type == ixgbe_mac_e610_vf &&
+	    hw->api_version >= ixgbe_mbox_api_16) {
 		ret_val = ixgbevf_get_pf_link_state(hw, speed, link_up);
 		if (ret_val)
 			goto out;



