Return-Path: <stable+bounces-226358-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OA+IJomIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226358-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:59:53 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B08C42AEC30
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87A2B3049C92
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93B63F23AA;
	Tue, 17 Mar 2026 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZG1fjQBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB7A3EAC6F;
	Tue, 17 Mar 2026 16:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766349; cv=none; b=T18AtL2fdwTc8prZwNPZ0vxCFw+OPKhDe6wE+K+CRaE6EfkcQ7rT22cXMDEs+1FBqV3Yf8WQmfbB+geosOa4cOmRfp/56y7XBB05vljKNxFbky42zPo/e3YAbQJMOVTiy1PkDmJ4j4X8EK2kV7q6HdSet1+2GsWMOaLXP8srOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766349; c=relaxed/simple;
	bh=rSlsDtDlBmQ3jhdcnL+znmtrmFtllkR0gYbd4fKlpEw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kfrQzDqkZKvrqwMKcYJH7iDmsmU2DC/h8sXwtDvJZMoGpS5/SRyzbNEzlmre/1Jw2VbmufNBFZx9ZCl+3WHefxg8Ov7zmBSI2VPVkg0+Dkibc7TJtYgIacFk0jB75ayvdDjcCEttv5UjKZOuIGJat/+lNoS3OIJIX/vN9Y7b0V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZG1fjQBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04884C4CEF7;
	Tue, 17 Mar 2026 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766349;
	bh=rSlsDtDlBmQ3jhdcnL+znmtrmFtllkR0gYbd4fKlpEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZG1fjQBIEYYYw0n8wErWEOM38dOjBrnXPPN7+Fz0jGQlWXqXUvtl9ufkBmrhFnP+a
	 eFxUMPz7Tv0twcW5SkNHw+eulFiIloKsMHRpMDeYP8V2Cf7IYIeYyJirwkn2JlBU1y
	 qQ74UMwCFCluc9nv183qnnNnVq+T6w4ZGPNtGEBE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Guenter Roeck <linux@roeck-us.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Corey Minyard <corey@minyard.net>
Subject: [PATCH 6.19 225/378] ipmi:si: Handle waiting messages when BMC failure detected
Date: Tue, 17 Mar 2026 17:33:02 +0100
Message-ID: <20260317163015.287769023@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-226358-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,minyard.net:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Queue-Id: B08C42AEC30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Corey Minyard <corey@minyard.net>

commit 52c9ee202edd21d0599ac3b5a6fe1da2a2f053e5 upstream.

If a BMC failure is detected, the current message is returned with an
error.  However, if there was a waiting message, it would not be
handled.

Add a check for the waiting message after handling the current message.

Suggested-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Rafael J. Wysocki <rafael@kernel.org>
Closes: https://lore.kernel.org/linux-acpi/CAK8fFZ58fidGUCHi5WFX0uoTPzveUUDzT=k=AAm4yWo3bAuCFg@mail.gmail.com/
Fixes: bc3a9d217755 ("ipmi:si: Gracefully handle if the BMC is non-functional")
Cc: stable@vger.kernel.org # 4.18
Signed-off-by: Corey Minyard <corey@minyard.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_si_intf.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -809,6 +809,12 @@ restart:
 			 */
 			return_hosed_msg(smi_info, IPMI_BUS_ERR);
 		}
+		if (smi_info->waiting_msg != NULL) {
+			/* Also handle if there was a message waiting. */
+			smi_info->curr_msg = smi_info->waiting_msg;
+			smi_info->waiting_msg = NULL;
+			return_hosed_msg(smi_info, IPMI_BUS_ERR);
+		}
 		smi_mod_timer(smi_info, jiffies + SI_TIMEOUT_HOSED);
 		goto out;
 	}



