Return-Path: <stable+bounces-247943-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEaEGO5nB2ol2AIAu9opvQ
	(envelope-from <stable+bounces-247943-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:37:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE02E556597
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:37:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 559F43168569
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F393FF1DD;
	Fri, 15 May 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QTTiU1+T"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4283FF1DA;
	Fri, 15 May 2026 15:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778860472; cv=none; b=pFOkFO8ODgp1oIzsIV3aUCRCoUB87QubHN7nlAC4Iacig/mmuLx4exwS666fS5trTX2PlQXtDdmZMzlKbO/esqu93Z0ozKObje8OySd4LJpcliGrTZDxzOOmRSh5ZzJfpBxTTq8couzaCLlNi9oQjhfWBcMz64ANLhkaqiGJqM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778860472; c=relaxed/simple;
	bh=N34cZGrpqKHG7w/IjlzadoJ/m7uJ6VRK1OcXRHx0R78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZ6knhfzkMUCb5rfeh/qOvYCCrVLPUdcem5FXtVhvQvdna2y61xhzAqHOX1QXhpWUQb+SEbDWLsJIG1lw5gDVzUXAtb/uZlOClQN34nPYS8aWnlgtyDhxfQ0ytk2ZBwgIBxbZOaYZ2VTv3vQPF5fdjGk8HEdu19zGjXyAdSU/8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QTTiU1+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93202C2BCB0;
	Fri, 15 May 2026 15:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778860471;
	bh=N34cZGrpqKHG7w/IjlzadoJ/m7uJ6VRK1OcXRHx0R78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTTiU1+TfQwUCXabz6wDsXZSZ/MWbrvObqHQU3JCsb0zGs1L+WFT1jWENPxiD5Fqg
	 MIu2lPyYqWRIOFHAwxcqyOcbE+dJ/tHcNyvIMA7fuJUuSGp8g2SheG7/VGcb1TYnun
	 sdUY7HtasN5pJ8mN5DsKH49IXhG0JQfDtF6Qzebs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 100/144] batman-adv: bla: put backbone reference on failed claim hash insert
Date: Fri, 15 May 2026 17:48:46 +0200
Message-ID: <20260515154655.820659571@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154653.469907118@linuxfoundation.org>
References: <20260515154653.469907118@linuxfoundation.org>
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
X-Rspamd-Queue-Id: CE02E556597
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-247943-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,narfation.org:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sven Eckelmann <sven@narfation.org>

commit ba9d20ee9076dac32c371116bacbe72480eb356c upstream.

When batadv_bla_add_claim() fails to insert a new claim into the hash, it
leaked a reference to the backbone_gw for which the claim was intended.
Call batadv_backbone_gw_put() on the error path to release the reference
and avoid leaking the backbone_gw object.

Cc: stable@kernel.org
Fixes: 3db0decf1185 ("batman-adv: Fix non-atomic bla_claim::backbone_gw access")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/batman-adv/bridge_loop_avoidance.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/batman-adv/bridge_loop_avoidance.c
+++ b/net/batman-adv/bridge_loop_avoidance.c
@@ -723,6 +723,7 @@ static void batadv_bla_add_claim(struct
 
 		if (unlikely(hash_added != 0)) {
 			/* only local changes happened. */
+			batadv_backbone_gw_put(backbone_gw);
 			kfree(claim);
 			return;
 		}



