Return-Path: <stable+bounces-255739-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JJWBmakGGrClggAu9opvQ
	(envelope-from <stable+bounces-255739-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B675F8909
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 22:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3B4AB30780CE
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 20:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D3B2D9787;
	Thu, 28 May 2026 20:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ojnePqfn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6572E7377;
	Thu, 28 May 2026 20:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779999748; cv=none; b=tEIN72Yde6zZwQSDAJljXFDQ5K6tlvjsnReGpAk5jyqrkWR5NtYrL9EKT1xUMwfOYcnLWIg8EZqHxcN7uJ5aQpEnndMMHc1Y2Rc4eLu+GD2pwYnWe8aQwOf+CgHHiHkD7/QC7mxnUOgClqZEX31wy+xGBpV0t/pIaP67WY8x+6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779999748; c=relaxed/simple;
	bh=RSkQFM8659yI2cf9q2sKc0lqJRh1LinjXelmLr5zN/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KipTvINlmi04eaoC0C5ExqLth2GnTxedR5jnL2vDgei5BDoUqVIW78kbTDV+GGRZ8meeDDYfwC43IG6s+Ov2pd1jo08s8CIUgRNC20BJjnDT05vSiYQcPrkos+qSmDNzAyH/RvAoacvkmg445P0UvWwnE/bYQ6vWjUd3+u+KcDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ojnePqfn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193C81F00A3A;
	Thu, 28 May 2026 20:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779999747;
	bh=LRzVQjfyVPr3wtTsdAeKzAIu05l7D027Qkc3QIAqHpQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ojnePqfntjWHERZStvHRBYjor5cMaIF3HfTvQlKKokQFz4Qx897TH5Hqq9DPGh/nK
	 3NL44o2Cl6GGnFS4xvti45MZaIfLcO6Lt3hnFS82nzLUix9VNb5aF3yCUbdD/rE/fh
	 Cze0NZPxF6/aPSqdiLH+0yh2+Ezleu6GMdF9rOrc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <error27@gmail.com>,
	Even Xu <even.xu@intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Jiri Kosina <jkosina@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 177/377] HID: intel-thc-hid: Intel-quickspi: Fix some error codes
Date: Thu, 28 May 2026 21:46:55 +0200
Message-ID: <20260528194643.544740942@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528194638.371537336@linuxfoundation.org>
References: <20260528194638.371537336@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,intel.com,squebb.ca,suse.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-255739-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,squebb.ca:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,intel.com:email]
X-Rspamd-Queue-Id: A1B675F8909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <error27@gmail.com>

[ Upstream commit ae4ac077332ea3341a0f4c0973556c6b7ac5b7a1 ]

If we have a partial read that is supposed to be treated as failure but
in this code we forgot to set the error code.  Return -EINVAL.

Fixes: 9d8d51735a3a ("HID: intel-thc-hid: intel-quickspi: Add HIDSPI protocol implementation")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Even Xu <even.xu@intel.com>
Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: Jiri Kosina <jkosina@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
index 16f780bc879b1..cb19057f1191b 100644
--- a/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
+++ b/drivers/hid/intel-thc-hid/intel-quickspi/quickspi-protocol.c
@@ -94,7 +94,7 @@ static int quickspi_get_device_descriptor(struct quickspi_device *qsdev)
 		dev_err_once(qsdev->dev, "Read DEVICE_DESCRIPTOR failed, ret = %d\n", ret);
 		dev_err_once(qsdev->dev, "DEVICE_DESCRIPTOR expected len = %u, actual read = %u\n",
 			     input_len, read_len);
-		return ret;
+		return ret ?: -EINVAL;
 	}
 
 	input_rep_type = ((struct input_report_body_header *)read_buf)->input_report_type;
@@ -318,7 +318,7 @@ int reset_tic(struct quickspi_device *qsdev)
 		dev_err_once(qsdev->dev, "Read RESET_RESPONSE body failed, ret = %d\n", ret);
 		dev_err_once(qsdev->dev, "RESET_RESPONSE body expected len = %u, actual = %u\n",
 			     read_len, actual_read_len);
-		return ret;
+		return ret ?: -EINVAL;
 	}
 
 	input_rep_type = FIELD_GET(HIDSPI_IN_REP_BDY_HDR_REP_TYPE, reset_response);
-- 
2.53.0




