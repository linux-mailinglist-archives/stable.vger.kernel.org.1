Return-Path: <stable+bounces-234920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMe3F9el1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:00:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA783C22AE
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06906321D251
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7683D8905;
	Wed,  8 Apr 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="msQahyTf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4933624B9;
	Wed,  8 Apr 2026 18:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674105; cv=none; b=bGFfSyCDXFhRZw7KcNlskGvRIvyTWcbwqa2YVswHawtFy8lHpSNPTzSTMfatqg07EO11HneFP3a+OABxzc8yXvx82T49FbPUxOZdg9kXRDU/so/LrnZrsCivegqql+kfgYv88TaKpMfXTY4/l8wSID8Rc7VU+kgoshyXpyKwhZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674105; c=relaxed/simple;
	bh=dE6icxJbF6d5v/qMHYUsRZGrNOpgRC+ctj7DRVYb8oU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTWX9lEBwMm5U90XluAL/ysXLdXj9AiE9ZHoOd+F9kKmeaNN98Z1P5Og2tyZnNDXy2sFQz+9nYSckUSXnIZ4g/LlVn81GgGQvhuGi0Ov+Oa53KAV5C0Sfsfvja/qdoyrh2M5y4w26sf+Y2dPaHHtKB8h9P4tAD7aXRGE4lMIpDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=msQahyTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67D0C19421;
	Wed,  8 Apr 2026 18:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775674105;
	bh=dE6icxJbF6d5v/qMHYUsRZGrNOpgRC+ctj7DRVYb8oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=msQahyTf+w67dzrfRtA860OSqaJG2mw2/RLWrk5PcjU/W93S9yhDjI7+ajPg41L9Y
	 6yJUQBxJaise1HAxuQXylULbahvIYP7sne5683r/RhBLeEg8TejBdhOKCkftqqKa0H
	 inhQsR2oep5R0dVYFgclfPtZTsUX+kQEKqSBB8Jo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Conor Dooley <conor.dooley@microchip.com>,
	stable <stable@kernel.org>,
	Xu Yang <xu.yang_2@nxp.com>
Subject: [PATCH 6.12 179/242] dt-bindings: connector: add pd-disable dependency
Date: Wed,  8 Apr 2026 20:03:39 +0200
Message-ID: <20260408175933.784804036@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-234920-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,microchip.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EBA783C22AE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xu Yang <xu.yang_2@nxp.com>

commit 269c26464dcf8b54b0dd9c333721c30ee44ae297 upstream.

When Power Delivery is not supported, the source is unable to obtain the
current capability from the Source PDO. As a result, typec-power-opmode
needs to be added to advertise such capability.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Cc: stable <stable@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
Link: https://patch.msgid.link/20260330063518.719345-1-xu.yang_2@nxp.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/devicetree/bindings/connector/usb-connector.yaml |    1 +
 1 file changed, 1 insertion(+)

--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -254,6 +254,7 @@ properties:
     additionalProperties: false
 
 dependencies:
+  pd-disable: [typec-power-opmode]
   sink-vdos-v1: [ sink-vdos ]
   sink-vdos: [ sink-vdos-v1 ]
 



