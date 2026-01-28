Return-Path: <stable+bounces-212633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCUAHlU8emlB4wEAu9opvQ
	(envelope-from <stable+bounces-212633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:41:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8681A6021
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 17:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45C0C324F715
	for <lists+stable@lfdr.de>; Wed, 28 Jan 2026 16:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB4C3033E4;
	Wed, 28 Jan 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FILYkJmL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9016781AA8;
	Wed, 28 Jan 2026 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769616176; cv=none; b=nhoBTl3xqI7HmktW+X0UWu7m75P2dN4sQRGkocPMF8KYNj3M6Rp4NigzZ2yV9aB5piJjX5O22rllkXX+Qc+H/squGDbt+iba7u37Qt2dZuAx+FH+pxOHegagD9Bo5YehglLT57kbLVvGECX5ifTtXy0URhlGeWaCI/sZPwuflno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769616176; c=relaxed/simple;
	bh=rbk3u27ZKBp+kxW+tznkCzlTdSN2qR5XSTXCUHyJUYw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Osj0tbs9ZwX5QoQ9FQoiEeeD8QKbPUvuCL+SpA8zfGsNEYZjCuzxe2FwpCJpBWOHS7ioJgWmiWLQrzE4yqTWb5JYkhEejik74ysQWuzP+eJXSmGyzZ/u9gJOK/RZ34ewcyRg8YS0yVzPQ+AQivdlJxVOvhhnLyYlVdj0uhm3fVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FILYkJmL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91FDC4CEF1;
	Wed, 28 Jan 2026 16:02:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769616176;
	bh=rbk3u27ZKBp+kxW+tznkCzlTdSN2qR5XSTXCUHyJUYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FILYkJmLzAOLoPaPHP8boI36Nrp8jO5JDyd2VGFmv9GiPGdJniGUg5aRPuegBJg18
	 LEDCw25BC4WjK9A4lkVzKPjlEQ4J0ReGvxgREpB37LeFVd0mmo15+X0qFqacwY0YqQ
	 K9CqIKUFRPazMBVE0Ix3sZBUHZ8lYqXCIQYEvRU4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hamza Mahfooz <someguy@effective-light.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 205/227] net: sfp: add potron quirk to the H-COM SPP425H-GAB4 SFP+ Stick
Date: Wed, 28 Jan 2026 16:24:10 +0100
Message-ID: <20260128145351.815898446@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260128145344.331957407@linuxfoundation.org>
References: <20260128145344.331957407@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-212633-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,effective-light.com:email]
X-Rspamd-Queue-Id: C8681A6021
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <someguy@effective-light.com>

commit a92a6c50e35b75a8021265507f3c2a9084df0b94 upstream.

This is another one of those XGSPON ONU sticks that's using the
X-ONU-SFPP internally, thus it also requires the potron quirk to avoid tx
faults. So, add an entry for it in sfp_quirks[].

Cc: stable@vger.kernel.org
Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>
Link: https://patch.msgid.link/20260113232957.609642-1-someguy@effective-light.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/sfp.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -519,6 +519,8 @@ static const struct sfp_quirk sfp_quirks
 
 	SFP_QUIRK_F("HALNy", "HL-GSFP", sfp_fixup_halny_gsfp),
 
+	SFP_QUIRK_F("H-COM", "SPP425H-GAB4", sfp_fixup_potron),
+
 	// HG MXPD-483II-F 2.5G supports 2500Base-X, but incorrectly reports
 	// 2600MBd in their EERPOM
 	SFP_QUIRK_S("HG GENUINE", "MXPD-483II", sfp_quirk_2500basex),



