Return-Path: <stable+bounces-228171-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PtoFqRQwWnLSAQAu9opvQ
	(envelope-from <stable+bounces-228171-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:39:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CD72F4F1C
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:39:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AB2A30ADB87
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50E13B6C04;
	Mon, 23 Mar 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CjiriA8d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658973B6BF2;
	Mon, 23 Mar 2026 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274342; cv=none; b=XN94udNk+NIYIel2z1s88t0fHNjvuZmgumVMpLz2KWM1d74tuK6bbD9HERAmADEmgvL3kDlSsJdwJIrPPYik24c4ETjdwyw1RIsLl1Sv5YTEI5d1JDyllPIvrK6NPlu31qEwf35X01NcFsHLyhuGgRiHFkl7h6AD/BNwxd+PUVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274342; c=relaxed/simple;
	bh=dAAVbOHhjB6wAOqEoavsXji5bsG5YP1CubOMKqRw0uM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gspdBNXP8TNsHaZ6yZZGiVoZLnhBxYHURAXioyNUO5fhGktlnXYaalfpGYia9Fx8f0auNm6t6w4DkmPOugiGMJLzGjbE7ehzoXGaepC6FhhnpZtkHssGGzq3smJNefTeIwci8aocnjomY8IMoRoEHbeWIj8M4shEQGZmISfhQ14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CjiriA8d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981AAC2BCB8;
	Mon, 23 Mar 2026 13:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274342;
	bh=dAAVbOHhjB6wAOqEoavsXji5bsG5YP1CubOMKqRw0uM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjiriA8df+mqAXCMYzSL5eyggm6lwklYowbWfWVv1G2B0JtW+DOza9i2i2f+Dbgp1
	 ti1s0euApTl40g1r7KXrNKwuIpUKukUADyjOPiliu3bDYGGvkStageb5/ocfoas0ss
	 E5AVE8I/v4VJDkuri+/v65NpG3gGZvslIvRX4gZw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH 6.19 187/220] i2c: fsi: Fix a potential leak in fsi_i2c_probe()
Date: Mon, 23 Mar 2026 14:46:04 +0100
Message-ID: <20260323134510.494286660@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228171-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,wanadoo.fr,kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D9CD72F4F1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

commit be627abcc0d5dbd5882873bd85fbc18aa3d189ed upstream.

In the commit in Fixes:, when the code has been updated to use an explicit
for loop, instead of for_each_available_child_of_node(), the assumption
that a reference to a device_node structure would be released at each
iteration has been broken.

Now, an explicit of_node_put() is needed to release the reference.

Fixes: 095561f476ab ("i2c: fsi: Create busses for all ports")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: <stable@vger.kernel.org> # v5.3+
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://lore.kernel.org/r/fd805c39f8de51edf303856103d782138a1633c8.1772382022.git.christophe.jaillet@wanadoo.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-fsi.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/i2c/busses/i2c-fsi.c
+++ b/drivers/i2c/busses/i2c-fsi.c
@@ -728,6 +728,7 @@ static int fsi_i2c_probe(struct device *
 		rc = i2c_add_adapter(&port->adapter);
 		if (rc < 0) {
 			dev_err(dev, "Failed to register adapter: %d\n", rc);
+			of_node_put(np);
 			kfree(port);
 			continue;
 		}



