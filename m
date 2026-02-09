Return-Path: <stable+bounces-215133-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H7gNSzxiWnGEgAAu9opvQ
	(envelope-from <stable+bounces-215133-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAC91108D6
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE2A3022908
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3A037996F;
	Mon,  9 Feb 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CsNjtacp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E315276028;
	Mon,  9 Feb 2026 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770647784; cv=none; b=WqIQmy0BQPy1IEHtrfRHm4DmaYdqQko6ckcKWZTeL9MUIpG4vd2KcserJw30iIzoyCOD7nfPjjvq4GO3gvwB51rbQowI/391ehQch95Y0mzi7oN4GecShp/lx7imczhQg40N+Urtzn0jt+fNX7bnoXGzhgxniiiGNLcrmsLnrhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770647784; c=relaxed/simple;
	bh=M4777Af/8/6KxnkesjBuVgAM+7nSH2cFMhcxxQfGcT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+fLTrwgcstEvrvQDv8WgSljVvO70tN2aU05NHBsApQ2niPFPjblLTEqky19o67qjN8KknN2ad5waKbIQ/Avd2vTPeF0H1JZQS8JzCE5hbQd7OLnZ7o2i79atQd06kNo7EupopeABsuvZi3LPdZ7dsL3Su3v0n7GldwTgd319kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CsNjtacp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E097C116C6;
	Mon,  9 Feb 2026 14:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770647784;
	bh=M4777Af/8/6KxnkesjBuVgAM+7nSH2cFMhcxxQfGcT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CsNjtacpoRZs8qP1J0pC7kFJ/UmXFtAwbb22ivdG4sUMd5V93xbUNRimdEq5wwoCC
	 XAFQEq00q5OA5OMDDvNXYK06AzMTZg8/7PoFBkssMQ63HtTFvaP/nuJy4HKie9nn3G
	 TZ0lBG4pBm8EJr3U1RfzuuuV60aVnEv4pBNuf/eU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gabor Juhos <j4g8y7@gmail.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.12 006/113] pmdomain: qcom: rpmpd: fix off-by-one error in clamping to the highest state
Date: Mon,  9 Feb 2026 15:22:35 +0100
Message-ID: <20260209142310.437997159@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215133-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,oss.qualcomm.com,linaro.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,qualcomm.com:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email,linaro.org:email]
X-Rspamd-Queue-Id: 6BAC91108D6
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gabor Juhos <j4g8y7@gmail.com>

commit 8aa6f7697f5981d336cac7af6ddd182a03c6da01 upstream.

As it is indicated by the comment, the rpmpd_aggregate_corner() function
tries to clamp the state to the highest corner/level supported by the
given power domain, however the calculation of the highest state contains
an off-by-one error.

The 'max_state' member of the 'rpmpd' structure indicates the highest
corner/level, and as such it does not needs to be decremented.

Change the code to use the 'max_state' value directly to avoid the error.

Fixes: 98c8b3efacae ("soc: qcom: rpmpd: Add sync_state")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pmdomain/qcom/rpmpd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/pmdomain/qcom/rpmpd.c
+++ b/drivers/pmdomain/qcom/rpmpd.c
@@ -1001,7 +1001,7 @@ static int rpmpd_aggregate_corner(struct
 
 	/* Clamp to the highest corner/level if sync_state isn't done yet */
 	if (!pd->state_synced)
-		this_active_corner = this_sleep_corner = pd->max_state - 1;
+		this_active_corner = this_sleep_corner = pd->max_state;
 	else
 		to_active_sleep(pd, pd->corner, &this_active_corner, &this_sleep_corner);
 



