Return-Path: <stable+bounces-268464-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RWKOG5UoPWqayAgAu9opvQ
	(envelope-from <stable+bounces-268464-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:09:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 574FA6C5F4E
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 15:09:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b="h92oO/J4";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-268464-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-268464-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A92C8301B1ED
	for <lists+stable@lfdr.de>; Thu, 25 Jun 2026 13:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9774C283FFB;
	Thu, 25 Jun 2026 13:09:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424082E7374;
	Thu, 25 Jun 2026 13:08:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782392941; cv=none; b=j8/EiZcaufU/3HQweGqwIQDnOLqkiwwS61jANXF7U83K1fIYsTsSRmYPLgDqS37y1fkWyfLKj7Hsb3oD1gYQf4YmVg1XWFmpW2QIS+H5ga+ye3h0cuwqXCTCu7qEr9xMXcFQ0aRKz7GpshD/sO4vYuOyU54z9OESdkJSrxUwkfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782392941; c=relaxed/simple;
	bh=XAd7qgSeaNzXzBijVOIfHTZrux1A/XqU08ujgO53EjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Leh86vCxmi02vjG7Xm8MFSiJMDdzUJ1BbRMG7ekLndoaVwWJul9jD1VOhEqAiSARHrvbRSQ9sHttdJtaSADSVKMvT1OvAt086tpeIKcEOTxZ7Bec+VtQkfoVoGeYLNQjfzpkOM7wnJ2N1TIajeKbOO7Ug3HFlJv8PiBlPUGqTiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h92oO/J4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4130A1F00A3A;
	Thu, 25 Jun 2026 13:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782392938;
	bh=ELpxejnwoEB/d3sknwk5gA3lxfy13osUwFOnW76FEzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h92oO/J4Ju/vJt7POZtUe04ScvelB4X3sOxsdbzdL84mqQnyFdy6y3BlSu00HhvEH
	 rhYXW0g5Vb2GyztBZGix8VsJauXsVc5FjI7QIea6fy99gb3ip/BG31CDz0vIW67XM/
	 JbFF3hZik0hSMAJJ8PHc8ZcyIuYO2ZXQYMLx4lHo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.18 52/60] Input: rmi4 - fix bit count in bitmap_copy()
Date: Thu, 25 Jun 2026 14:03:37 +0100
Message-ID: <20260625125653.323632287@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625125645.554579168@linuxfoundation.org>
References: <20260625125645.554579168@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-268464-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:dmitry.torokhov@gmail.com,m:dmitrytorokhov@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 574FA6C5F4E

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

commit f22dbbcbd1f70ed004a7bf8837e0f0c3cc230b78 upstream.

bitmap_copy() takes number of bits, not bytes (or longs). Correct
the bit count in rmi_driver_set_irq_bits() and
rmi_driver_clear_irq_bits().

Fixes: 2b6a321da9a2 ("Input: synaptics-rmi4 - add support for Synaptics RMI4 devices")
Cc: stable@vger.kernel.org
Assisted-by: Gemini:gemini-3.1-pro
Link: https://patch.msgid.link/20260505045952.1570713-7-dmitry.torokhov@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/rmi4/rmi_driver.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/input/rmi4/rmi_driver.c
+++ b/drivers/input/rmi4/rmi_driver.c
@@ -388,9 +388,8 @@ static int rmi_driver_set_irq_bits(struc
 							__func__);
 		goto error_unlock;
 	}
-	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
-		    data->num_of_irq_regs);
 
+	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 	bitmap_or(data->fn_irq_bits, data->fn_irq_bits, mask, data->irq_count);
 
 error_unlock:
@@ -419,8 +418,8 @@ static int rmi_driver_clear_irq_bits(str
 							__func__);
 		goto error_unlock;
 	}
-	bitmap_copy(data->current_irq_mask, data->new_irq_mask,
-		    data->num_of_irq_regs);
+
+	bitmap_copy(data->current_irq_mask, data->new_irq_mask, data->irq_count);
 
 error_unlock:
 	mutex_unlock(&data->irq_mutex);



